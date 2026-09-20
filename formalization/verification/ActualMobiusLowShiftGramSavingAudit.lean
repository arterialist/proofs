import BuildingBlocks.ActualMobiusLowShiftGramSaving

open BuildingBlocks.ActualMobiusLowShiftGramSaving

#check physical_scale
#check q_pos
#check p_cubed_lt_pq
#check small_range_gram_gap
#check middle_endpoint_bound_exponent
#check middle_range_gram_gap
#check high_endpoint_bound_exponent
#check high_range_gram_saving
#check high_range_square_root_scale_saving
#check high_endpoint_above_pq_gap
#check high_endpoint_above_pq
#check high_endpoint_above_p_cubed
#check high_saving_below_middle
#check endpoint_error_stronger
#check diagonal_gram_gap
#check canonical_kappa_pos
#check canonical_kappa_lt_third
#check canonical_upper_exponent
#check canonical_gram_saving
#check canonical_square_root_scale_saving

#print axioms physical_scale
#print axioms q_pos
#print axioms p_cubed_lt_pq
#print axioms small_range_gram_gap
#print axioms middle_endpoint_bound_exponent
#print axioms middle_range_gram_gap
#print axioms high_endpoint_bound_exponent
#print axioms high_range_gram_saving
#print axioms high_range_square_root_scale_saving
#print axioms high_endpoint_above_pq_gap
#print axioms high_endpoint_above_pq
#print axioms high_endpoint_above_p_cubed
#print axioms high_saving_below_middle
#print axioms endpoint_error_stronger
#print axioms diagonal_gram_gap
#print axioms canonical_kappa_pos
#print axioms canonical_kappa_lt_third
#print axioms canonical_upper_exponent
#print axioms canonical_gram_saving
#print axioms canonical_square_root_scale_saving

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
