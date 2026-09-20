import BuildingBlocks.ActualMobiusCriticalDualKRow
import Lean.Util.CollectAxioms

open BuildingBlocks.ActualMobiusCriticalDualKRow

#check scale_exponents
#check scale_order
#check determinant_increasing_exponent
#check determinant_decreasing_exponent
#check row_improves_rs
#check schur_row_exponent
#check schur_energy_loss
#check stationary_absolute_exponent

#print axioms scale_exponents
#print axioms scale_order
#print axioms determinant_increasing_exponent
#print axioms determinant_decreasing_exponent
#print axioms row_improves_rs
#print axioms schur_row_exponent
#print axioms schur_energy_loss
#print axioms stationary_absolute_exponent

open Lean in
run_cmd do
  let env ← getEnv
  let target := `BuildingBlocks.ActualMobiusCriticalDualKRow
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == target
  if selected.isEmpty then
    throwError "No declarations found for the critical dual-row module"
  let audit : Lean.CollectAxioms.M Unit := do
    for (name, _) in selected do Lean.CollectAxioms.collect name
  let (_, state) := (audit.run env).run {}
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless state.axioms.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {state.axioms}"
  logInfo m!"CRITICAL DUAL-ROW DECLARATION COUNT {selected.length}"
  logInfo m!"CRITICAL DUAL-ROW TRANSITIVE AXIOMS {state.axioms}"
  logInfo "CRITICAL DUAL-ROW AXIOM AUDIT PASSED"
