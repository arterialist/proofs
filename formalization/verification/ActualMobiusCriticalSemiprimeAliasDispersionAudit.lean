import BuildingBlocks.ActualMobiusCriticalSemiprimeAliasDispersion
import Lean.Util.CollectAxioms

open BuildingBlocks.ActualMobiusCriticalSemiprimeAliasDispersion

#check critical_scale_ledger
#check full_alias_ledger
#check packet_normalization_ledger
#check targetB_diagonal_ledger
#check targetC_diagonal_ledger
#check cao_zhai_short_orientation_excess
#check cao_zhai_long_orientation_excess
#check cao_zhai_excesses_positive
#check residual_sampling_gain
#check residual_sampling_gain_positive
#check sampling_vs_fixedQ
#check compositeQ_majorant_gain
#check offDiagonal_schur_deficit
#check collapsed_allUnit_rs_saturation
#check collapsed_allUnit_rs_other_margins
#check allUnit_long_free_rs_exact_contact
#check allUnit_short_free_rs_losses

#print axioms critical_scale_ledger
#print axioms full_alias_ledger
#print axioms packet_normalization_ledger
#print axioms targetB_diagonal_ledger
#print axioms targetC_diagonal_ledger
#print axioms cao_zhai_short_orientation_excess
#print axioms cao_zhai_long_orientation_excess
#print axioms cao_zhai_excesses_positive
#print axioms residual_sampling_gain
#print axioms residual_sampling_gain_positive
#print axioms sampling_vs_fixedQ
#print axioms compositeQ_majorant_gain
#print axioms offDiagonal_schur_deficit
#print axioms collapsed_allUnit_rs_saturation
#print axioms collapsed_allUnit_rs_other_margins
#print axioms allUnit_long_free_rs_exact_contact
#print axioms allUnit_short_free_rs_losses

open Lean in
run_cmd do
  let env ← getEnv
  let target := `BuildingBlocks.ActualMobiusCriticalSemiprimeAliasDispersion
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == target
  if selected.isEmpty then
    throwError "No declarations found for the critical semiprime alias module"
  let audit : Lean.CollectAxioms.M Unit := do
    for (name, _) in selected do Lean.CollectAxioms.collect name
  let (_, state) := (audit.run env).run {}
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless state.axioms.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {state.axioms}"
  logInfo m!"CRITICAL SEMIPRIME ALIAS DECLARATION COUNT {selected.length}"
  logInfo m!"CRITICAL SEMIPRIME ALIAS TRANSITIVE AXIOMS {state.axioms}"
  logInfo "CRITICAL SEMIPRIME ALIAS AXIOM AUDIT PASSED"
