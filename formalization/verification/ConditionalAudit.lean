import BuildingBlocks
import Lean.Util.CollectAxioms

/-!
# Conditionality audit

Run from the repository root:

    lake env lean formalization/verification/ConditionalAudit.lean

The metaprogram below looks at every theorem, definition, opaque constant and axiom whose
defining module is `BuildingBlocks` or `BuildingBlocks.*` and reports, for each one whose
conclusion is the Riemann hypothesis or a predicate the repository proves equivalent to it,
the hypotheses it takes. It prints a summary and writes the full table to
`formalization/verification/conditional-audit.md` (written by this program through `IO`).

## What counts as "concludes RH"

* **Registry.** The registry starts from Mathlib's `RiemannHypothesis`. Every closed
  statement `A ↔ B` proved in the repository (alone or as a conjunct of a conjunction, with no
  binders in front) is harvested; whenever one side is already registered the other side is
  added, until nothing changes. Predicates that unfold to the same proposition (for example
  `BuildingBlocks.Target`, which is `RiemannHypothesis` by definition) become aliases of one
  entry. For a registered `Nonempty X` the type `X` is registered as a carrier, so a
  definition that constructs an `X` is selected as well.
* **Unfolding.** Before comparison a proposition is normalised along its spine: reducible
  weak head normal form, then delta-unfolding of `RiemannHypothesis`, `Not` and of every
  definition declared in a `BuildingBlocks` module, repeated under each `∀`/`→` binder and
  inside each conjunct of a conjunction. Hypothesis positions are not rewritten.
* **Selection.** A declaration is selected when, after introducing some prefix of its binders
  (and choosing a conjunct if the conclusion is a conjunction), the remaining proposition is
  definitionally equal to a registry entry. The binders introduced up to that point are its
  hypotheses. The contradiction form `(h : ¬ T) … : False` with `T` registered is selected
  too, with `h` removed from the hypothesis list.
* **Families.** If a registered predicate is an application `P a` of a repository definition
  (for example `HighFrequencyZeroFree (3769 / 500)`), declarations concluding `P b` for other
  arguments are listed separately. They are not counted as concluding RH.

## Binder classes

* `Prop`: the binder type is a proposition (explicit, implicit or instance).
* `structure`: the binder type is not a proposition but is (or is a function into) a
  structure or inductive type that carries a proof: some constructor field is a proposition,
  or is itself (a function into) such a type, recursively. A theorem with no `Prop` binder
  but a `structure` binder is still conditional. Mathlib types such as `Finset` land here
  too; no judgement is made.
* `data`: everything else (numbers, functions, sets).

The key number is the count of selected declarations with neither `Prop` nor `structure`
binders.

## One-step discharge check

After selection the program asks two further questions, syntactically and one step deep.
(a) Is any repository structure that a selected declaration takes as a binder constructed
somewhere by a declaration with no `Prop` and no structure binder? (b) Is any closed `Prop`
hypothesis of a selected declaration verbatim the statement of a repository theorem? A "yes"
to either would mean RH follows by one application even though no single theorem says so.

## Limits

Matching is by definitional unfolding, not by logical equivalence. A statement that implies
RH but is written in a shape no registered predicate has (permuted hypotheses, an existential,
a quantified family) is not selected. The section "other declarations mentioning a registered
constant" lists every declaration that names `RiemannHypothesis` or a registered predicate and
was not otherwise classified, so the reader can check those by eye.
-/

open Lean Meta

namespace ConditionalAudit

/-- The module of `n`, if it is `BuildingBlocks` or `BuildingBlocks.*`. -/
def bbModule? (env : Environment) (n : Name) : Option Name :=
  match env.getModuleIdxFor? n with
  | some idx =>
    let m := env.header.moduleNames[idx.toNat]!
    if m.getRoot == `BuildingBlocks then some m else none
  | none => none

def shouldUnfold (c : Name) : MetaM Bool := do
  if c == ``RiemannHypothesis || c == ``Not then return true
  let env ← getEnv
  match env.find? c with
  | some (.defnInfo _) => return (bbModule? env c).isSome
  | _ => return false

/-- Reducible whnf, then delta-unfold repository definitions, `RiemannHypothesis` and `Not`
at the head, repeatedly. -/
partial def headUnfold (e : Expr) (fuel : Nat := 64) : MetaM Expr := do
  let e ← whnfR e
  if fuel == 0 then return e
  match e.getAppFn with
  | .const c _ =>
    if ← shouldUnfold c then
      let r ← (try unfoldDefinition? e catch _ => pure none)
      match r with
      | some e' => headUnfold e' (fuel - 1)
      | none => return e
    else return e
  | _ => return e

/-- Normalise along the spine: head, then under each binder, then inside conjunctions. -/
partial def spineNorm (e : Expr) : MetaM Expr := do
  let e ← headUnfold e
  if e.isForall then
    forallBoundedTelescope e (some 1) fun xs b => do
      mkForallFVars xs (← spineNorm b)
  else if e.isAppOfArity ``And 2 then
    return mkApp2 (mkConst ``And) (← spineNorm e.appFn!.appArg!) (← spineNorm e.appArg!)
  else
    return e

structure Stats where
  defeqTimeouts : Nat := 0

/-- Definitional equality of two spine-normalised propositions. Cheap shape filter, then
reducible `isDefEq`, then default-transparency `isDefEq` under a heartbeat cap. -/
def sameProp (stats : IO.Ref Stats) (R T : Expr) : MetaM Bool := do
  let shapeOk :=
    (R.isForall && T.isForall) ||
    (match R.getAppFn, T.getAppFn with
      | .const a _, .const b _ => a == b && R.getAppNumArgs == T.getAppNumArgs
      | _, _ => false)
  if !shapeOk then return false
  if ← (try withReducible (isDefEq R T) catch _ => pure false) then return true
  tryCatchRuntimeEx
    (withCurrHeartbeats <|
      withTheReader Core.Context (fun c => { c with maxHeartbeats := 400000 * 1000 }) <|
        (try isDefEq R T catch _ => pure false))
    (fun _ => do
      stats.modify fun s => { s with defeqTimeouts := s.defeqTimeouts + 1 }
      pure false)

/-- Collapse every run of whitespace to one space. -/
def flat (s : String) : String :=
  let (out, _) := s.foldl (init := ("", false)) fun (acc, sp) c =>
    if c == ' ' || c == '\n' || c == '\t' then (acc, true)
    else ((if sp && !acc.isEmpty then acc.push ' ' else acc).push c, false)
  out

def ppFlat (e : Expr) : MetaM String := do
  return flat ((← ppExpr e).pretty 100000)

def showName (n : Name) : String :=
  toString ((privateToUserName? n).getD n)

structure Target where
  display : String
  aliases : Array String := #[]
  norm : Expr
  source : String
  carrier : Bool := false
  deriving Inhabited

inductive BKind where
  | prop | struct | data
  deriving BEq, Inhabited

structure BinderRow where
  text : String
  kind : BKind
  deriving Inhabited

structure Hit where
  decl : Name
  module : Name
  kind : String
  matched : Array String
  written : String
  form : String
  binders : Array BinderRow
  /-- head constants of the structure binders (after their own binders) -/
  structHeads : Array Name := #[]
  /-- the `Prop` hypotheses that mention no earlier binder -/
  closedProps : Array Expr := #[]
  deriving Inhabited

def Hit.numProp (h : Hit) : Nat := (h.binders.filter (·.kind == .prop)).size
def Hit.numStruct (h : Hit) : Nat := (h.binders.filter (·.kind == .struct)).size
def Hit.weight (h : Hit) : Nat := h.numProp + h.numStruct

mutual

/-- Does the inductive type `c` carry a proof: is some constructor field a proposition, or
(recursively) a value of, or a function into, an inductive type that carries a proof? -/
partial def carriesProof (cache : IO.Ref (Std.HashMap Name Bool)) (c : Name) : MetaM Bool := do
  if let some b := (← cache.get)[c]? then return b
  -- guard against recursive types: while `c` is being examined it counts as "no"
  cache.modify (·.insert c false)
  let env ← getEnv
  let b ← match env.find? c with
    | some (.inductInfo iv) =>
      iv.ctors.anyM fun ctor => do
        match env.find? ctor with
        | some (.ctorInfo cv) =>
          (try
            forallTelescope cv.type fun xs _ => do
              (xs.extract iv.numParams xs.size).anyM fun x => do
                let t ← inferType x
                if ← isProp t then return true
                typeCarriesProof cache t
          catch _ => pure false)
        | _ => pure false
    | _ => pure false
  cache.modify (·.insert c b)
  return b

/-- Does the non-proposition type `t` end, after its binders, in a proof-carrying inductive? -/
partial def typeCarriesProof (cache : IO.Ref (Std.HashMap Name Bool)) (t : Expr) : MetaM Bool := do
  try
    forallTelescopeReducing t fun _ body => do
      let body ← whnfD body
      match body.getAppFn with
      | .const c _ => carriesProof cache c
      | _ => pure false
  catch _ => pure false

end

def classify (cache : IO.Ref (Std.HashMap Name Bool)) (t : Expr) : MetaM BKind := do
  if ← (try isProp t catch _ => pure false) then return .prop
  return if ← typeCarriesProof cache t then .struct else .data

def binderRow (cache : IO.Ref (Std.HashMap Name Bool)) (x : Expr) : MetaM BinderRow := do
  let d ← x.fvarId!.getDecl
  let ty ← ppFlat d.type
  let nm := toString d.userName.eraseMacroScopes
  let text := match d.binderInfo with
    | .default => s!"({nm} : {ty})"
    | .implicit => "{" ++ s!"{nm} : {ty}" ++ "}"
    | .strictImplicit => "⦃" ++ s!"{nm} : {ty}" ++ "⦄"
    | .instImplicit => s!"[{nm} : {ty}]"
  return { text, kind := ← classify cache d.type }

structure Decl where
  name : Name
  module : Name
  kind : String
  type : Expr
  deriving Inhabited

def collectDecls (env : Environment) : Array Decl :=
  let all := env.constants.fold (init := (#[] : Array Decl)) fun acc n ci =>
    match bbModule? env n with
    | none => acc
    | some m =>
      match ci with
      | .thmInfo _ => acc.push ⟨n, m, "theorem", ci.type⟩
      | .axiomInfo _ => acc.push ⟨n, m, "axiom", ci.type⟩
      | .opaqueInfo _ => acc.push ⟨n, m, "opaque", ci.type⟩
      | .defnInfo _ => acc.push ⟨n, m, "def", ci.type⟩
      | _ => acc
  all.qsort fun a b =>
    let ka := toString a.module ++ "|" ++ toString a.name
    let kb := toString b.module ++ "|" ++ toString b.name
    ka < kb

partial def splitAndUnfold (e : Expr) : MetaM (Array Expr) := do
  let e ← headUnfold e
  if e.isAppOfArity ``And 2 then
    return (← splitAndUnfold e.appFn!.appArg!) ++ (← splitAndUnfold e.appArg!)
  else
    return #[e]

/-- The repository constant that names a registered predicate, if any: the head constant,
or the head constant of `X` in `Nonempty X`, or of either side of an equation. -/
def keyConsts (env : Environment) (e : Expr) : Array Name := Id.run do
  let isBB (c : Name) : Bool := (bbModule? env c).isSome
  let headOf (e : Expr) : Array Name :=
    match e.getAppFn with
    | .const c _ => if isBB c then #[c] else #[]
    | _ => #[]
  if e.isAppOfArity ``Nonempty 1 then return headOf e.appArg!
  if e.isAppOfArity ``Eq 3 then return headOf e.appFn!.appArg! ++ headOf e.appArg!
  return headOf e

structure Ctx where
  stats : IO.Ref Stats
  cache : IO.Ref (Std.HashMap Name Bool)
  targets : Array Target
  family : NameSet
  hits : IO.Ref (Array Hit)
  familyHits : IO.Ref (Array Hit)
  iffHits : IO.Ref (Array Hit)

def matchTargets (ctx : Ctx) (R : Expr) : MetaM (Array String) := do
  let N ← spineNorm R
  let mut out := #[]
  for T in ctx.targets do
    if ← sameProp ctx.stats N T.norm then out := out.push T.display
  return out

def mkHit (ctx : Ctx) (d : Decl) (matched : Array String) (written : Expr) (form : String)
    (bs : Array Expr) : MetaM Hit := do
  let w ← ppFlat written
  let w := if w.length > 160 then (w.take 160).toString ++ " …" else w
  let rows ← bs.mapM (binderRow ctx.cache)
  let mut structHeads : Array Name := #[]
  let mut closedProps : Array Expr := #[]
  for b in bs, r in rows do
    let t ← instantiateMVars (← inferType b)
    if r.kind == .struct then
      let h ← (try
        forallTelescopeReducing t fun _ body => do
          return (← whnfR body).getAppFn.constName?
        catch _ => pure none)
      if let some c := h then structHeads := structHeads.push c
    if r.kind == .prop && !t.hasFVar then closedProps := closedProps.push t
  return { decl := d.name, module := d.module, kind := d.kind, matched, written := w, form,
           binders := rows, structHeads, closedProps }

partial def visit (ctx : Ctx) (d : Decl) (R : Expr) (bs : Array Expr) : MetaM Unit := do
  -- (1) the remaining proposition is a registered predicate
  let m ← matchTargets ctx R
  if !m.isEmpty then
    ctx.hits.modify (·.push (← mkHit ctx d m R "direct" bs))
    return
  -- (2) it is another instance of a registered predicate family
  let r ← whnfR R
  let fam := (keyConsts (← getEnv) r).filter ctx.family.contains
  if !fam.isEmpty && !r.isAppOfArity ``Eq 3 then
    ctx.familyHits.modify (·.push (← mkHit ctx d (fam.map toString) R "family" bs))
    return
  -- (3) descend
  let R' ← headUnfold R
  if R'.isForall then
    forallBoundedTelescope R' (some 1) fun xs b => visit ctx d b (bs ++ xs)
  else if R'.isAppOfArity ``And 2 then
    visit ctx d R'.appFn!.appArg! bs
    visit ctx d R'.appArg! bs
  else if R'.isAppOfArity ``Iff 2 then
    let a ← matchTargets ctx R'.appFn!.appArg!
    let b ← matchTargets ctx R'.appArg!
    if !(a ++ b).isEmpty then
      ctx.iffHits.modify (·.push (← mkHit ctx d (a ++ b) R' "iff" bs))
  else if R'.isConstOf ``False then
    -- contradiction form: some hypothesis is the negation of a registered predicate
    for b in bs do
      let t ← inferType b
      if !(← isProp t) then continue
      let t ← headUnfold t
      if t.isArrow && t.bindingBody!.isConstOf ``False then
        let m ← matchTargets ctx t.bindingDomain!
        if !m.isEmpty then
          ctx.hits.modify (·.push
            (← mkHit ctx d m (mkApp (mkConst ``Not) t.bindingDomain!)
              "contradiction (hypothesis ¬T, conclusion False)" (bs.filter (· != b))))
          return
  else
    return

def mergeHits (hs : Array Hit) : Array Hit := Id.run do
  let mut out : Array Hit := #[]
  for h in hs do
    match out.findIdx? (·.decl == h.decl) with
    | some i =>
      let o := out[i]!
      let matched := h.matched.foldl (fun acc s => if acc.contains s then acc else acc.push s) o.matched
      let best := if h.weight < o.weight then h else o
      out := out.set! i { best with matched }
    | none => out := out.push h
  return out

def mdEscape (s : String) : String :=
  (s.replace "|" "\\|").replace "`" "'"

def bindersCell (h : Hit) (k : BKind) : String :=
  let rows := h.binders.filter (·.kind == k)
  if rows.isEmpty then "none" else "<br>".intercalate (rows.map (fun r => mdEscape r.text)).toList

def tableRows (hs : Array Hit) : Array String := Id.run do
  let mut lines := #[
    "| # | declaration | kind | module | conclusion as written | matched | form | Prop hypotheses | structure binders | data binders |",
    "|---|---|---|---|---|---|---|---|---|---|"]
  let mut i := 0
  for h in hs do
    i := i + 1
    lines := lines.push
      (s!"| {i} | {mdEscape (showName h.decl)} | {h.kind} | {h.module} | {mdEscape h.written} | " ++
       s!"{mdEscape ("; ".intercalate h.matched.toList)} | {h.form} | {bindersCell h .prop} | " ++
       s!"{bindersCell h .struct} | {bindersCell h .data} |")
  return lines

def outPath : System.FilePath := "formalization/verification/conditional-audit.md"

def run : MetaM Unit := do
  let env ← getEnv
  let stats ← IO.mkRef ({} : Stats)
  let cache ← IO.mkRef ({} : Std.HashMap Name Bool)
  let decls := collectDecls env
  let bbModules := env.header.moduleNames.filter (·.getRoot == `BuildingBlocks)
  -- source files outside the import closure
  let mut notImported : Array String := #[]
  let srcDir : System.FilePath := "formalization/BuildingBlocks"
  unless ← srcDir.isDir do
    throwError "run this from the repository root (cannot see {srcDir})"
  for entry in ← srcDir.readDir do
    if entry.path.extension == some "lean" then
      let stem := entry.path.fileStem.getD ""
      let modName := Name.mkStr `BuildingBlocks stem
      unless bbModules.contains modName do notImported := notImported.push stem
  notImported := notImported.qsort (· < ·)
  -- these files are not compiled here; a plain text search is all that can be said about them
  let mut notImportedMentions : Array String := #[]
  for stem in notImported do
    let text ← IO.FS.readFile (srcDir / (stem ++ ".lean"))
    let count (pat : String) : Nat := (text.splitOn pat).length - 1
    let rh := count "RiemannHypothesis"
    let ax := count "\naxiom "
    let so := count "sorry"
    let nd := count "native_decide"
    if rh + ax + so + nd > 0 then
      notImportedMentions := notImportedMentions.push
        s!"{stem}: {rh} occurrences of the text RiemannHypothesis, {ax} axiom declarations, {so} of sorry, {nd} of native_decide"
  -- registry: closed equivalences
  let rh := mkConst ``RiemannHypothesis
  let mut targets : Array Target :=
    #[{ display := "RiemannHypothesis", norm := ← spineNorm rh, source := "Mathlib (seed)" }]
  let mut pairs : Array (Expr × Expr × Name) := #[]
  for d in decls do
    if d.kind != "theorem" && d.kind != "def" && d.kind != "axiom" then continue
    if d.type.isForall then continue
    let conj ← (try withoutModifyingState (splitAndUnfold d.type) catch _ => pure #[])
    for c in conj do
      if c.isAppOfArity ``Iff 2 then
        pairs := pairs.push (c.appFn!.appArg!, c.appArg!, d.name)
  -- name seeds (kept in addition to the harvested equivalences)
  let seedNames : Array Name := #[`BuildingBlocks.Target, `BuildingBlocks.RightHalfZeroFree]
  let mut seeds : Array (Expr × String) := #[]
  for n in seedNames do
    if let some ci := env.find? n then
      if ci.type.isProp && ci.levelParams.isEmpty then seeds := seeds.push (mkConst n, "name seed")
  let mut changed := true
  let mut first := true
  while changed do
    changed := false
    let mut cands : Array (Expr × String) := #[]
    if first then cands := seeds; first := false
    for (a, b, n) in pairs do
      let na ← spineNorm a
      let nb ← spineNorm b
      let ina ← targets.anyM fun T => sameProp stats na T.norm
      let inb ← targets.anyM fun T => sameProp stats nb T.norm
      if ina && !inb then cands := cands.push (b, s!"{showName n}")
      if inb && !ina then cands := cands.push (a, s!"{showName n}")
      -- aliases of entries already present
      if ina && inb then cands := cands.push (a, s!"{showName n}") |>.push (b, s!"{showName n}")
    for (e, src) in cands do
      let ne ← spineNorm e
      let disp ← ppFlat e
      match ← targets.findIdxM? (fun T => sameProp stats ne T.norm) with
      | some i =>
        let T := targets[i]!
        if T.display != disp && !T.aliases.contains disp then
          targets := targets.set! i { T with aliases := T.aliases.push disp }
      | none =>
        targets := targets.push { display := disp, norm := ne, source := src }
        changed := true
        if e.isAppOfArity ``Nonempty 1 then
          let X := e.appArg!
          targets := targets.push
            { display := s!"{← ppFlat X} (carrier of {disp})", norm := ← whnfR X,
              source := src, carrier := true }
  -- every closed `Prop`-valued repository definition that unfolds to a registered predicate
  -- is recorded as an alias (it would be matched by unfolding in any case)
  for d in decls do
    if d.kind == "def" && d.type.isProp then
      if let some ci := env.find? d.name then
        if ci.levelParams.isEmpty then
          let e := mkConst d.name
          let ne ← spineNorm e
          let disp ← ppFlat e
          if let some i ← targets.findIdxM? (fun T => do if T.carrier then pure false else sameProp stats ne T.norm) then
            let T := targets[i]!
            if T.display != disp && !T.aliases.contains disp then
              targets := targets.set! i { T with aliases := T.aliases.push disp }
  -- family constants
  let mut family : NameSet := {}
  let mut origExprs : Array Expr := #[rh]
  for (a, b, _) in pairs do
    let na ← spineNorm a
    let nb ← spineNorm b
    if ← targets.anyM fun T => sameProp stats na T.norm then origExprs := origExprs.push a
    if ← targets.anyM fun T => sameProp stats nb T.norm then origExprs := origExprs.push b
  for (e, _) in seeds do origExprs := origExprs.push e
  for e in origExprs do
    for c in keyConsts env e do family := family.insert c
  let mentionSet := family.insert ``RiemannHypothesis
  -- main pass
  let ctx : Ctx := { stats, cache, targets, family,
                     hits := ← IO.mkRef #[], familyHits := ← IO.mkRef #[], iffHits := ← IO.mkRef #[] }
  let mut errors : Array String := #[]
  let mut mentions : Array Decl := #[]
  for d in decls do
    if d.type.getUsedConstants.any mentionSet.contains then mentions := mentions.push d
    try
      withoutModifyingState (visit ctx d d.type #[])
    catch e =>
      errors := errors.push s!"{showName d.name}: {← e.toMessageData.toString}"
  let hits := mergeHits (← ctx.hits.get)
  let famHits := (mergeHits (← ctx.familyHits.get)).filter fun h => !hits.any (·.decl == h.decl)
  let iffHits := (mergeHits (← ctx.iffHits.get)).filter fun h => !hits.any (·.decl == h.decl)
  let classified : NameSet :=
    (hits ++ famHits ++ iffHits).foldl (fun s h => s.insert h.decl) {}
  let otherMentions := mentions.filter fun d => !classified.contains d.name
  let zero := hits.filter (·.weight == 0)
  let structOnly := hits.filter fun h => h.numProp == 0 && h.numStruct > 0
  let withProp := hits.filter (·.numProp > 0)
  let closedIff := iffHits.filter (·.binders.isEmpty)
  let openIff := iffHits.filter (!·.binders.isEmpty)
  let nThm := (decls.filter (·.kind == "theorem")).size
  let nDef := (decls.filter (·.kind == "def")).size
  let nOpaque := (decls.filter (·.kind == "opaque")).size
  let axioms := decls.filter (·.kind == "axiom")
  let nThmUser := (decls.filter fun d =>
    d.kind == "theorem" && !((privateToUserName? d.name).getD d.name).isInternalDetail).size
  -- One-step discharge check (syntactic). (a) Is a structure taken as a binder by a selected
  -- declaration constructed anywhere with no `Prop` and no structure binder? (b) Is a closed
  -- `Prop` hypothesis of a selected declaration the statement of some repository theorem?
  let hypStructs : NameSet := hits.foldl (init := {}) fun s h =>
    h.structHeads.foldl (fun s c => if (bbModule? env c).isSome then s.insert c else s) s
  let mut typeIndex : Std.HashMap Expr Name := {}
  let mut inhabitants : Array String := #[]
  let mut conditionalConstructions : Nat := 0
  for d in decls do
    if d.kind == "theorem" || d.kind == "axiom" then
      unless typeIndex.contains d.type do typeIndex := typeIndex.insert d.type d.name
    let r ← (try
      withoutModifyingState <| forallTelescopeReducing d.type fun xs body => do
        match (← whnfR body).getAppFn.constName? with
        | some c =>
          if hypStructs.contains c then
            let kinds ← xs.mapM fun x => do classify cache (← inferType x)
            return some (c, kinds.all (· == .data))
          else return none
        | none => return none
      catch _ => pure none)
    if let some (c, free) := r then
      if free then
        inhabitants := inhabitants.push s!"{showName d.name} ({d.kind}, {d.module}) constructs {c}"
      else conditionalConstructions := conditionalConstructions + 1
  let mut discharged : Array String := #[]
  let mut fullyDischarged : Array String := #[]
  for h in hits do
    let mut k := 0
    for t in h.closedProps do
      if let some n := typeIndex[t]? then
        k := k + 1
        discharged := discharged.push
          s!"{showName h.decl}: hypothesis {← ppFlat t} is the statement of {showName n}"
    -- every `Prop` hypothesis is closed and matched, and there is no structure binder
    if h.weight > 0 && k == h.weight then
      fullyDischarged := fullyDischarged.push s!"{showName h.decl} ({h.kind}, {h.module})"
  -- axiom dependencies of every enumerated declaration
  let standard : Array Name := #[``propext, ``Classical.choice, ``Quot.sound]
  let mut nonStd : Array (Decl × Array Name) := #[]
  for d in decls do
    let ax := (← collectAxioms d.name).filter fun a => !standard.contains a && a != d.name
    if !ax.isEmpty then nonStd := nonStd.push (d, ax.qsort (toString · < toString ·))
  let nonStdSelected := nonStd.filter fun (d, _) => hits.any (·.decl == d.name)
  -- axioms of the zero-hypothesis hits
  let mut zeroLines : Array String := #[]
  for h in zero do
    let ax ← collectAxioms h.decl
    zeroLines := zeroLines.push
      s!"- {showName h.decl} ({h.kind}, {h.module}); concludes: {h.written}; matched: {"; ".intercalate h.matched.toList}; form: {h.form}; data binders: {bindersCell h .data}; axioms: {ax.qsort (toString · < toString ·)}"
  let summary : Array String := #[
    s!"BuildingBlocks modules in the import closure of `BuildingBlocks`: {bbModules.size}",
    s!"source files under formalization/BuildingBlocks not in that closure (not audited): {notImported.size}",
    s!"declarations enumerated: {decls.size} = {nThm} theorems ({nThmUser} with user-facing names) + {nDef} definitions + {nOpaque} opaque + {axioms.size} axioms",
    s!"axioms declared in BuildingBlocks modules: {axioms.size}{if axioms.isEmpty then "" else " (" ++ ", ".intercalate (axioms.map fun d => toString d.name).toList ++ ")"}",
    s!"declarations depending on an axiom other than propext, Classical.choice, Quot.sound: {nonStd.size} (of the selected ones: {nonStdSelected.size})",
    s!"registered RH-equivalent predicates (distinct up to unfolding, carriers included): {targets.size}",
    s!"SELECTED (conclusion is RH or a registered equivalent): {hits.size}",
    s!"  of which with zero Prop hypotheses and zero structure binders: {zero.size}",
    s!"  of which with zero Prop hypotheses but at least one structure binder: {structOnly.size}",
    s!"  of which with at least one Prop hypothesis: {withProp.size}",
    s!"  by kind: {(hits.filter (·.kind == "theorem")).size} theorems, {(hits.filter (·.kind == "def")).size} definitions, {(hits.filter (·.kind == "axiom")).size} axioms, {(hits.filter (·.kind == "opaque")).size} opaque",
    s!"  by form: {(hits.filter (·.form == "direct")).size} direct, {(hits.filter (·.form != "direct")).size} contradiction form",
    s!"one-step discharge check: {hypStructs.size} repository structures occur as binders of selected declarations; declarations constructing one of them with no Prop and no structure binder: {inhabitants.size} (constructions that take such binders: {conditionalConstructions})",
    s!"one-step discharge check: closed Prop hypotheses of selected declarations that are verbatim the statement of a repository theorem: {discharged.size}",
    s!"one-step discharge check: selected declarations ALL of whose hypotheses are discharged this way: {fullyDischarged.size}",
    s!"equivalence statements with a registered side: {closedIff.size} closed, {openIff.size} with binders in front",
    s!"declarations concluding another instance of a registered predicate family: {famHits.size}",
    s!"other declarations mentioning RiemannHypothesis or a registered predicate constant: {otherMentions.size}",
    s!"definitional-equality checks that hit the heartbeat cap (treated as no match): {(← stats.get).defeqTimeouts}",
    s!"declarations whose traversal raised an error: {errors.size}"]
  -- stdout
  IO.println "=== Conditionality audit ==="
  for l in summary do IO.println l
  IO.println ""
  IO.println s!"Selected declarations with zero Prop hypotheses and zero structure binders ({zero.size}):"
  if zero.isEmpty then IO.println "  (none)"
  for l in zeroLines do IO.println l
  IO.println ""
  IO.println s!"Selected declarations with zero Prop hypotheses but a structure binder ({structOnly.size}):"
  if structOnly.isEmpty then IO.println "  (none)"
  for h in structOnly do
    IO.println s!"- {showName h.decl} ({h.kind}, {h.module}): {bindersCell h .struct}"
  IO.println ""
  IO.println s!"Unconditional constructions of a hypothesis structure ({inhabitants.size}):"
  if inhabitants.isEmpty then IO.println "  (none)"
  for l in inhabitants do IO.println s!"- {l}"
  IO.println s!"Hypotheses of selected declarations proved verbatim elsewhere ({discharged.size}):"
  if discharged.isEmpty then IO.println "  (none)"
  for l in discharged do IO.println s!"- {l}"
  IO.println s!"Selected declarations all of whose hypotheses are proved verbatim elsewhere ({fullyDischarged.size}):"
  if fullyDischarged.isEmpty then IO.println "  (none)"
  for l in fullyDischarged do IO.println s!"- {l}"
  IO.println ""
  IO.println "Registered predicates:"
  for T in targets do
    let al := if T.aliases.isEmpty then "" else s!"  [aliases: {"; ".intercalate T.aliases.toList}]"
    IO.println s!"- {T.display}{al}  (from {T.source})"
  IO.println ""
  IO.println s!"Selected declarations with hypotheses ({hits.size - zero.size}):"
  for h in hits do
    if h.weight == 0 then continue
    IO.println s!"- {showName h.decl} [{h.module}] concludes {h.written}"
    for b in h.binders do
      match b.kind with
      | .prop => IO.println s!"    Prop: {b.text}"
      | .struct => IO.println s!"    structure: {b.text}"
      | .data => pure ()
  IO.println ""
  IO.println s!"Text search of the {notImported.size} source files outside the import closure:"
  if notImportedMentions.isEmpty then IO.println "  (no occurrence of RiemannHypothesis, axiom, sorry, native_decide)"
  for l in notImportedMentions do IO.println s!"- {l}"
  if !errors.isEmpty then
    IO.println ""
    IO.println "Errors:"
    for e in errors do IO.println s!"- {e}"
  -- markdown
  let mut md : Array String := #[
    "# Conditionality audit of `BuildingBlocks`",
    "",
    "Generated by `lake env lean formalization/verification/ConditionalAudit.lean` (the metaprogram writes this file). Do not edit by hand. The method, the binder classes and the limits of the matching are described in the header of that file.",
    "",
    "## Summary",
    ""]
  for l in summary do md := md.push s!"- {mdEscape l}"
  md := md ++ #["", "## Selected declarations with zero Prop hypotheses and zero structure binders", ""]
  if zero.isEmpty then md := md.push "None."
  for l in zeroLines do md := md.push (mdEscape l)
  md := md ++ #["", "## Selected declarations with zero Prop hypotheses but a structure binder", "",
    "Each takes a value of a structure that carries proofs. The structure is the hypothesis.", ""]
  if structOnly.isEmpty then md := md.push "None."
  for h in structOnly do
    md := md.push s!"- {mdEscape (showName h.decl)} ({h.kind}, {h.module}): {bindersCell h .struct}"
  md := md ++ #["", "## One-step discharge check", "",
    "Syntactic and one step deep. It does not show that the hypotheses are unprovable; it shows that the repository does not already contain their proofs in the same words.", "",
    s!"Repository structures that occur as binders of selected declarations: {", ".intercalate (hypStructs.toList.map toString)}", "",
    "Declarations constructing one of these structures with no Prop and no structure binder:", ""]
  if inhabitants.isEmpty then md := md.push "None."
  for l in inhabitants do md := md.push s!"- {mdEscape l}"
  md := md ++ #["", "Closed Prop hypotheses of selected declarations that are verbatim the statement of a repository theorem:", ""]
  if discharged.isEmpty then md := md.push "None."
  for l in discharged do md := md.push s!"- {mdEscape l}"
  md := md ++ #["", "Selected declarations all of whose hypotheses are discharged this way:", ""]
  if fullyDischarged.isEmpty then md := md.push "None."
  for l in fullyDischarged do md := md.push s!"- {mdEscape l}"
  md := md ++ #["", "## Registered RH-equivalent predicates", "",
    "| # | predicate | aliases (same proposition after unfolding) | registered from |", "|---|---|---|---|"]
  let mut i := 0
  for T in targets do
    i := i + 1
    md := md.push s!"| {i} | {mdEscape T.display} | {mdEscape ("<br>".intercalate T.aliases.toList)} | {mdEscape T.source} |"
  md := md ++ #["", "## Selected declarations: conclusion is RH or a registered equivalent", ""]
  md := md ++ tableRows hits
  md := md ++ #["", "## Equivalence statements with a registered side", "",
    "These are `A ↔ B` statements, not proofs of either side. Closed ones feed the registry."]
  md := md ++ #[""] ++ tableRows iffHits
  md := md ++ #["", "## Declarations concluding another instance of a registered predicate family", "",
    "Not counted as concluding RH: the arguments differ from the registered instance."]
  md := md ++ #[""] ++ tableRows famHits
  md := md ++ #["", "## Other declarations mentioning RiemannHypothesis or a registered predicate constant", "",
    "The constant occurs in a hypothesis, under a quantifier, or in a shape the matcher does not classify.", ""]
  for d in otherMentions do
    md := md.push s!"- {mdEscape (showName d.name)} ({d.kind}, {d.module})"
  md := md ++ #["", "## Declarations depending on an axiom other than propext, Classical.choice, Quot.sound", ""]
  if nonStd.isEmpty then md := md.push "None."
  for (d, ax) in nonStd do
    md := md.push s!"- {mdEscape (showName d.name)} ({d.kind}, {d.module}): {mdEscape (", ".intercalate (ax.map toString).toList)}"
  md := md ++ #["", "## Source files outside the import closure (not audited)", ""]
  md := md.push (if notImported.isEmpty then "None." else ", ".intercalate notImported.toList)
  md := md ++ #["", "These files are not imported by `BuildingBlocks.lean` and were not compiled, so their declarations are not in the tables above. Text search of their sources:", ""]
  if notImportedMentions.isEmpty then
    md := md.push "No occurrence of RiemannHypothesis, axiom, sorry or native_decide in any of them."
  for l in notImportedMentions do md := md.push s!"- {l}"
  if !errors.isEmpty then
    md := md ++ #["", "## Errors", ""]
    for e in errors do md := md.push s!"- {mdEscape e}"
  IO.FS.writeFile outPath ("\n".intercalate md.toList ++ "\n")
  IO.println ""
  IO.println s!"Full table written to {outPath}"

end ConditionalAudit

set_option maxHeartbeats 0 in
set_option maxRecDepth 100000 in
#eval ConditionalAudit.run
