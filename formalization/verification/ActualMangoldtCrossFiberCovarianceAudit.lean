import BuildingBlocks.ActualMangoldtCrossFiberCovariance

open BuildingBlocks.ActualMangoldtCrossFiberCovariance

#check physical_scale
#check diagonal_saving_exponent
#check coefficient_blind_loss
#check coefficient_blind_loss_in_T
#check coefficient_blind_loss_pos
#check phase_cell_exponent
#check phase_cell_grows
#check phase_cell_below_one_fourteenth
#check aligned_twist_excess

#print axioms physical_scale
#print axioms diagonal_saving_exponent
#print axioms coefficient_blind_loss
#print axioms coefficient_blind_loss_in_T
#print axioms coefficient_blind_loss_pos
#print axioms phase_cell_exponent
#print axioms phase_cell_grows
#print axioms phase_cell_below_one_fourteenth
#print axioms aligned_twist_excess

open Lean in
run_cmd do
  let env ← getEnv
  let target := `BuildingBlocks.ActualMangoldtCrossFiberCovariance
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == target
  if selected.isEmpty then
    throwError "No declarations found for the Mangoldt covariance module"
  let audit : Lean.CollectAxioms.M Unit := do
    for (name, _) in selected do Lean.CollectAxioms.collect name
  let (_, state) := (audit.run env).run {}
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless state.axioms.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {state.axioms}"
  logInfo m!"MANGOLDT COVARIANCE DECLARATION COUNT {selected.length}"
  logInfo m!"MANGOLDT COVARIANCE TRANSITIVE AXIOMS {state.axioms}"
  logInfo "MANGOLDT COVARIANCE AXIOM AUDIT PASSED"
