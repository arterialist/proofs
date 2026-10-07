/-
Copyright (c) 2020 Microsoft Corporation. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Original author: Leonardo de Moura

Adapted from Lean 4.34.1 Lean/Util/CollectAxioms.lean:
https://github.com/leanprover/lean4/blob/v4.34.1/src/Lean/Util/CollectAxioms.lean
This collector bypasses exportedAxiomsExt and adds fail-closed body/scope checks.
It examines loaded ConstantInfo; it does not replay the kernel or compare source.
-/
module

public import Lean.Elab.Command
public import Lean.Util.FoldConsts

public section

namespace UncachedBodyAudit
open Lean

structure State where
  visited : NameSet := {}
  visitOrder : Array Name := #[]
  axioms : NameSet := {}
  axiomPaths : Array String := #[]
  bodies : Array (Name × String) := #[]

structure Context where
  env : Environment
  maxConstants : Nat := 100000

abbrev M := ReaderT Context <| StateT State <| Except String

def pathText (c : Name) (parents : List Name) : String :=
  String.intercalate " -> " ((c :: parents).reverse.map toString)

/-- Require a full private-data import view. A restricted view is never a pass. -/
def checkImportData (env : Environment) : Except String Unit := do
  if env.header.isModule then
    throw "RESTRICTED_MODULE_VIEW: require a non-module/private import environment"
  if env.header.moduleData.size != env.header.modules.size then
    throw "INCOMPLETE_MODULE_DATA: module/data counts differ"
  for imp in env.header.modules do
    unless imp.hasData && imp.importAll do
      throw s!"INCOMPLETE_IMPORT_DATA: {imp.module}; hasData={imp.hasData}; importAll={imp.importAll}"

/-- Visit exact kernel names, including private names and every dependency namespace. -/
partial def collectConstant (c : Name) (parents : List Name := []) : M Unit := do
  let ctx ← read
  let state ← get
  if state.visited.contains c then return
  if state.visitOrder.size >= ctx.maxConstants then
    throw s!"RESOURCE_LIMIT: reached {ctx.maxConstants} constants at {pathText c parents}"
  let some info := ctx.env.checked.get.find? c |
    throw s!"UNRESOLVED_CONSTANT_OR_BODY: {pathText c parents}"
  if info.isUnsafe then
    throw s!"UNSAFE_DECLARATION: {pathText c parents}"
  modify fun state => { state with
    visited := state.visited.insert c
    visitOrder := state.visitOrder.push c }
  let walkExpr (expr : Expr) : M Unit := do
    if expr.hasMVar || expr.hasFVar || expr.hasLooseBVars then
      throw s!"NONCLOSED_EXPRESSION: {pathText c parents}"
    for dependency in expr.getUsedConstants do
      collectConstant dependency (c :: parents)
  -- Axiom types are traversed as well, even for an allowed axiom name.
  walkExpr info.type
  match info with
  | .axiomInfo _ =>
      modify fun state => { state with
        axioms := state.axioms.insert c
        axiomPaths := state.axiomPaths.push (pathText c parents) }
  | .defnInfo value =>
      if value.safety != .safe then
        throw s!"UNSAFE_OR_PARTIAL_DEFINITION: {pathText c parents}"
      modify fun state => { state with bodies := state.bodies.push (c, "definition") }
      walkExpr value.value
  | .thmInfo value =>
      modify fun state => { state with bodies := state.bodies.push (c, "theorem") }
      walkExpr value.value
  | .opaqueInfo value =>
      modify fun state => { state with bodies := state.bodies.push (c, "opaque") }
      walkExpr value.value
  | .inductInfo value =>
      for member in value.all do collectConstant member (c :: parents)
      for ctor in value.ctors do collectConstant ctor (c :: parents)
  | .ctorInfo value => collectConstant value.induct (c :: parents)
  | .recInfo value =>
      for member in value.all do collectConstant member (c :: parents)
      for rule in value.rules do
        collectConstant rule.ctor (c :: parents)
        walkExpr rule.rhs
  | .quotInfo _ =>
      -- Quotient primitives have a kernel-defined kind rather than a stored body.
      -- Their types were still traversed above; this does not check kernel rules.
      pure ()

def collectRoots (env : Environment) (roots : Array Name)
    (maxConstants : Nat := 100000) : Except String State := do
  checkImportData env
  if roots.isEmpty then throw "EMPTY_ROOT_SCOPE"
  let action : M Unit := do
    for root in roots do collectConstant root
  let (_, state) ← (action.run {env, maxConstants}).run {}
  return state

def allowedAxioms : Array Name := #[`propext, `Classical.choice, `Quot.sound]

def checkAllowlist (state : State) : Except String Unit := do
  let found := state.axioms.toArray.qsort Name.lt
  let forbidden := found.filter fun ax => !allowedAxioms.contains ax
  unless forbidden.isEmpty do
    throw s!"FORBIDDEN_AXIOM_OR_ERASED_BODY: {forbidden}; dependency paths: {state.axiomPaths}"

def declaringModule? (env : Environment) (name : Name) : Option Name := do
  let idx ← env.getModuleIdxFor? name
  return (← env.header.modules[idx.toNat]?).module

/-- Bind declaring modules and expected root count; names need not share their namespace. -/
def rootsForModules (env : Environment) (expectedModules : Array Name)
    (expectedRootCount : Nat) (rootModulePrefix : Name := `BuildingBlocks) :
    Except String (Array Name) := do
  checkImportData env
  if rootModulePrefix.isAnonymous then throw "EMPTY_MODULE_PREFIX"
  let actualModules := env.header.moduleNames.filter rootModulePrefix.isPrefixOf
  unless actualModules.size == expectedModules.size &&
      actualModules.all expectedModules.contains && expectedModules.all actualModules.contains do
    throw s!"MODULE_SCOPE_MISMATCH: expected {expectedModules}, got {actualModules}"
  let roots := env.checked.get.constants.toList.filterMap fun (name, _) => do
    let mod ← declaringModule? env name
    if expectedModules.contains mod then some name else none
  let roots := roots.toArray.qsort Name.lt
  if roots.isEmpty then throw "EMPTY_ROOT_SCOPE"
  unless roots.size == expectedRootCount do
    throw s!"ROOT_COUNT_MISMATCH: expected {expectedRootCount}, got {roots.size}; roots={roots}"
  return roots

def verifyModules (expectedModules : Array Name) (expectedRootCount : Nat)
    (rootModulePrefix : Name := `BuildingBlocks) : Elab.Command.CommandElabM Unit := do
  let env ← getEnv
  let roots ← match rootsForModules env expectedModules expectedRootCount rootModulePrefix with
    | .ok roots => pure roots
    | .error message => throwError "{message}"
  let state ← match collectRoots env roots with
    | .ok state => pure state
    | .error message => throwError "{message}"
  logInfo m!"UNCACHED_BODY_AXIOM_UNION {state.axioms.toArray.qsort Name.lt}"
  logInfo m!"UNCACHED_ROOT_PREFIX {rootModulePrefix}"
  logInfo m!"UNCACHED_ROOT_MODULES {expectedModules}; ROOT_COUNT {roots.size}; VISITED {state.visitOrder.size}; BODIES {state.bodies.size}"
  for (name, kind) in state.bodies do
    if let some mod := declaringModule? env name then
      if expectedModules.contains mod then
        logInfo m!"BODY_VISITED {mod} {name} {kind}"
      else
        logInfo m!"DEPENDENCY_BODY_VISITED {mod} {name} {kind}"
  match checkAllowlist state with
  | .ok _ => logInfo "UNCACHED_BODY_ALLOWLIST_PASS"
  | .error message => throwError "{message}"

end UncachedBodyAudit
