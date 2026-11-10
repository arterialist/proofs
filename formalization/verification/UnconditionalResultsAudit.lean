import BuildingBlocks.UnconditionalResults
import Lean.Util.CollectAxioms

/-!
Axiom audit for `BuildingBlocks.UnconditionalResults`.

Run from the repository root:

    lake env lean formalization/verification/UnconditionalResultsAudit.lean

For every theorem declared in the module `BuildingBlocks.UnconditionalResults` this prints the
section it belongs to, its statement, its `Prop` hypotheses and its axioms. It fails
(`throwError`) if a theorem depends on any axiom other than `propext`, `Classical.choice`,
`Quot.sound`, if a Section 1 theorem is missing from the expected list below (or the list
names a theorem that is not there), or if a section is empty.

Sections are read off the namespace:

* Section 1, `BuildingBlocks.UnconditionalResults.*`: unconditional results.
* Section 2, `BuildingBlocks.UnconditionalResults.AboutAZero.*`: statements about a zero.
* Section 3, `BuildingBlocks.UnconditionalResults.Criteria.*`: criteria whose hypothesis is
  not proved in the repository.

The check on axioms is applied to all three sections. Whether a `Prop` hypothesis is a
"variable range" is not something a program can decide; the hypotheses are printed so that
they can be read.
-/

open Lean Meta

namespace UnconditionalResultsAudit

def allowed : Array Name := #[``propext, ``Classical.choice, ``Quot.sound]

/-- The Section 1 theorems, by name. The audit fails if the module and this list disagree. -/
def expectedSection1 : Array Name := #[
  `BuildingBlocks.UnconditionalResults.riemannZeta_ne_zero_of_im_le_3769_div_500,
  `BuildingBlocks.UnconditionalResults.riemannZeta_one_half_ne_zero,
  `BuildingBlocks.UnconditionalResults.W_im,
  `BuildingBlocks.UnconditionalResults.exists_lower_excursion,
  `BuildingBlocks.UnconditionalResults.frequently_lower_excursion,
  `BuildingBlocks.UnconditionalResults.sharp_constant_two_sided,
  `BuildingBlocks.UnconditionalResults.second_order_two_sided]

def sectionOf (n : Name) : Option Nat :=
  let root := `BuildingBlocks.UnconditionalResults
  if n.getPrefix == root then some 1
  else if n.getPrefix == root ++ `AboutAZero then some 2
  else if n.getPrefix == root ++ `Criteria then some 3
  else none

def flat (s : String) : String :=
  let (out, _) := s.foldl (init := ("", false)) fun (acc, sp) c =>
    if c == ' ' || c == '\n' || c == '\t' then (acc, true)
    else ((if sp && !acc.isEmpty then acc.push ' ' else acc).push c, false)
  out

def run : MetaM Unit := do
  let env ← getEnv
  let some modIdx := env.getModuleIdx? `BuildingBlocks.UnconditionalResults
    | throwError "module BuildingBlocks.UnconditionalResults is not imported"
  let mut thms : Array (Nat × Name × Expr) := #[]
  for (n, ci) in env.constants.fold (init := #[]) (fun acc n ci => acc.push (n, ci)) do
    if env.getModuleIdxFor? n != some modIdx then continue
    let .thmInfo _ := ci | continue
    match sectionOf n with
    | some k => thms := thms.push (k, n, ci.type)
    | none => throwError "theorem {n} is in the module but in none of the three namespaces"
  thms := thms.qsort fun a b => a.1 < b.1 || (a.1 == b.1 && toString a.2.1 < toString b.2.1)
  let mut bad : Array String := #[]
  let titles := #["", "Section 1. Unconditional results",
    "Section 2. Statements about a zero ρ",
    "Section 3. Criteria (the hypothesis is not proved here)"]
  for k in [1, 2, 3] do
    let sec := thms.filter (·.1 == k)
    IO.println s!"=== {titles[k]!} ({sec.size} theorems) ==="
    if sec.isEmpty then bad := bad.push s!"section {k} is empty"
    for (_, n, type) in sec do
      let ax := (← collectAxioms n).qsort (toString · < toString ·)
      let hyps ← forallTelescope type fun xs _ => do
        let mut out : Array String := #[]
        for x in xs do
          let t ← inferType x
          if ← isProp t then out := out.push (flat ((← ppExpr t).pretty 100000))
        return out
      IO.println s!"{n}"
      IO.println s!"  statement: {flat ((← ppExpr type).pretty 100000)}"
      IO.println s!"  Prop hypotheses ({hyps.size}): {if hyps.isEmpty then "none" else "; ".intercalate hyps.toList}"
      IO.println s!"  axioms: {ax}"
      for a in ax do
        unless allowed.contains a do
          bad := bad.push s!"{n} depends on the axiom {a}"
    IO.println ""
  let sec1 := (thms.filter (·.1 == 1)).map (·.2.1)
  for n in expectedSection1 do
    unless sec1.contains n do bad := bad.push s!"expected Section 1 theorem {n} is missing"
  for n in sec1 do
    unless expectedSection1.contains n do
      bad := bad.push s!"Section 1 theorem {n} is not in the expected list of this audit"
  if bad.isEmpty then
    IO.println s!"AUDIT PASSED: {thms.size} theorems, all axioms within {allowed}."
  else
    throwError "AUDIT FAILED:\n{"\n".intercalate bad.toList}"

end UnconditionalResultsAudit

#eval UnconditionalResultsAudit.run
