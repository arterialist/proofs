import BuildingBlocks.ActualMobiusDoubleQFullRankGram

open BuildingBlocks.ActualMobiusDoubleQFullRankGram

#check physical_scale
#check double_cauchy_gram_target_exponent
#check outer_count_exponent
#check high_endpoint_exponent
#check parameterized_gram_saving
#check parameterized_conditional_sqrt_scale
#check reciprocal_q_saving
#check middle_term_saving
#check uniform_saving_from_kappa_lt_half
#check determinant_from_difference
#check canonical_kappa_pos
#check canonical_kappa_lt_half
#check canonical_f_exponent
#check canonical_g_exponent
#check canonical_h_exponent
#check canonical_gram_saving
#check canonical_conditional_sqrt_scale

#print axioms physical_scale
#print axioms double_cauchy_gram_target_exponent
#print axioms outer_count_exponent
#print axioms high_endpoint_exponent
#print axioms parameterized_gram_saving
#print axioms parameterized_conditional_sqrt_scale
#print axioms reciprocal_q_saving
#print axioms middle_term_saving
#print axioms uniform_saving_from_kappa_lt_half
#print axioms determinant_from_difference
#print axioms canonical_kappa_pos
#print axioms canonical_kappa_lt_half
#print axioms canonical_f_exponent
#print axioms canonical_g_exponent
#print axioms canonical_h_exponent
#print axioms canonical_gram_saving
#print axioms canonical_conditional_sqrt_scale

open Lean in
run_cmd do
  let env ← getEnv
  let target := `BuildingBlocks.ActualMobiusDoubleQFullRankGram
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == target
  if selected.isEmpty then
    throwError "No declarations found for the double-Q full-rank Gram module"
  let audit : Lean.CollectAxioms.M Unit := do
    for (name, _) in selected do Lean.CollectAxioms.collect name
  let (_, state) := (audit.run env).run {}
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless state.axioms.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {state.axioms}"
  logInfo m!"DOUBLE-Q FULL-RANK GRAM DECLARATION COUNT {selected.length}"
  logInfo m!"DOUBLE-Q FULL-RANK GRAM TRANSITIVE AXIOMS {state.axioms}"
  logInfo "DOUBLE-Q FULL-RANK GRAM AXIOM AUDIT PASSED"
