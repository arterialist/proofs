import BuildingBlocks.ActualMobiusLowShiftGramSaving

open BuildingBlocks.ActualMobiusLowShiftGramSaving

#check physical_scale
#check p_cubed_lt_pq
#check parameterized_endpoint_bound_exponent
#check parameterized_gram_saving
#check parameterized_range_gap
#check parameterized_range_extends_p_cubed
#check parameterized_original_sum_saving
#check absolute_endpoint_bound_exponent
#check gram_saving_identity
#check gram_saving_positive
#check original_sum_saving_identity
#check original_sum_saving_positive
#check endpoint_error_saving_gap
#check p_pos
#check endpoint_error_saving_stronger
#check canonical_kappa_pos
#check canonical_kappa_lt
#check canonical_range_gap
#check canonical_original_sum_saving
#check parameterized_endpoint_error_stronger

#print axioms physical_scale
#print axioms p_cubed_lt_pq
#print axioms parameterized_endpoint_bound_exponent
#print axioms parameterized_gram_saving
#print axioms parameterized_range_gap
#print axioms parameterized_range_extends_p_cubed
#print axioms parameterized_original_sum_saving
#print axioms absolute_endpoint_bound_exponent
#print axioms gram_saving_identity
#print axioms gram_saving_positive
#print axioms original_sum_saving_identity
#print axioms original_sum_saving_positive
#print axioms endpoint_error_saving_gap
#print axioms p_pos
#print axioms endpoint_error_saving_stronger
#print axioms canonical_kappa_pos
#print axioms canonical_kappa_lt
#print axioms canonical_range_gap
#print axioms canonical_original_sum_saving
#print axioms parameterized_endpoint_error_stronger
open Lean in
run_cmd do
  let env ← getEnv
  let target := `BuildingBlocks.ActualMobiusLowShiftGramSaving
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == target
  if selected.isEmpty then
    throwError "No declarations found for the low-shift Gram-saving module"
  let audit : Lean.CollectAxioms.M Unit := do
    for (name, _) in selected do Lean.CollectAxioms.collect name
  let (_, state) := (audit.run env).run {}
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless state.axioms.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {state.axioms}"
  logInfo m!"LOW-SHIFT GRAM-SAVING DECLARATION COUNT {selected.length}"
  logInfo m!"LOW-SHIFT GRAM-SAVING TRANSITIVE AXIOMS {state.axioms}"
  logInfo "LOW-SHIFT GRAM-SAVING AXIOM AUDIT PASSED"
