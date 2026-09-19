import BuildingBlocks.ActualMobiusCriticalWindowSaving
import Lean.Util.CollectAxioms

open Lean

#check BuildingBlocks.ActualMobiusCriticalWindowSaving.finiteLogSplit
#print axioms BuildingBlocks.ActualMobiusCriticalWindowSaving.finiteLogSplit
#check BuildingBlocks.ActualMobiusCriticalWindowSaving.completeUnloggedFiber_zero
#print axioms BuildingBlocks.ActualMobiusCriticalWindowSaving.completeUnloggedFiber_zero
#check BuildingBlocks.ActualMobiusCriticalWindowSaving.critical_outer_and_window
#print axioms BuildingBlocks.ActualMobiusCriticalWindowSaving.critical_outer_and_window
#check BuildingBlocks.ActualMobiusCriticalWindowSaving.critical_relative_window
#print axioms BuildingBlocks.ActualMobiusCriticalWindowSaving.critical_relative_window
#check BuildingBlocks.ActualMobiusCriticalWindowSaving.normalizedMassExponent_eq
#print axioms BuildingBlocks.ActualMobiusCriticalWindowSaving.normalizedMassExponent_eq
#check BuildingBlocks.ActualMobiusCriticalWindowSaving.critical_normalized_mass
#print axioms BuildingBlocks.ActualMobiusCriticalWindowSaving.critical_normalized_mass
#check BuildingBlocks.ActualMobiusCriticalWindowSaving.critical_maximal_source_range
#print axioms BuildingBlocks.ActualMobiusCriticalWindowSaving.critical_maximal_source_range
#check BuildingBlocks.ActualMobiusCriticalWindowSaving.absorb_one_log_exponent
#print axioms BuildingBlocks.ActualMobiusCriticalWindowSaving.absorb_one_log_exponent

open Lean in
run_cmd do
  let env ← getEnv
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! ==
        `BuildingBlocks.ActualMobiusCriticalWindowSaving
  let audit : Lean.CollectAxioms.M Unit := do
    for (name, _) in selected do
      Lean.CollectAxioms.collect name
  let (_, state) := (audit.run env).run {}
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  if selected.isEmpty then throwError "No module constants selected"
  unless state.axioms.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {state.axioms}"
  logInfo m!"Module constants audited, including generated declarations: {selected.length}"
  logInfo m!"Full transitive axiom union: {state.axioms}"
  logInfo "ACTUAL MOBIUS CRITICAL WINDOW AXIOM AUDIT PASSED"
