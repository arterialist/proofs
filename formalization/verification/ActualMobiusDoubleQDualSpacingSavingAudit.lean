import BuildingBlocks.ActualMobiusDoubleQDualSpacingSaving

open BuildingBlocks.ActualMobiusDoubleQDualSpacingSaving

#check physical_scale
#check middle_endpoint_eq
#check long_interval_ratio_exponent
#check unit_interval_ratio_exponent
#check unit_interval_balances_at_endpoint
#check endpoint_below_two_q
#check alias_endpoint_eq
#check quadratic_occupancy_middle_margin
#check quadratic_occupancy_last_margin
#check quadratic_occupancy_middle_gap
#check quadratic_occupancy_last_gap
#check alias_endpoint_margin_saving
#check sharpened_window_nonempty
#check endpoint_above_three_halves_q
#check public_range_extension
#check first_term_endpoint_saving
#check unit_interval_margin_saving
#check long_interval_margin_saving
#check stationary_window_nonempty
#check stationary_overlaps_full_rank
#check stationary_remainder_gram_saving
#check diagonal_gram_saving
#check p_pos

#print axioms physical_scale
#print axioms middle_endpoint_eq
#print axioms long_interval_ratio_exponent
#print axioms unit_interval_ratio_exponent
#print axioms unit_interval_balances_at_endpoint
#print axioms endpoint_below_two_q
#print axioms alias_endpoint_eq
#print axioms quadratic_occupancy_middle_margin
#print axioms quadratic_occupancy_last_margin
#print axioms quadratic_occupancy_middle_gap
#print axioms quadratic_occupancy_last_gap
#print axioms alias_endpoint_margin_saving
#print axioms sharpened_window_nonempty
#print axioms endpoint_above_three_halves_q
#print axioms public_range_extension
#print axioms first_term_endpoint_saving
#print axioms unit_interval_margin_saving
#print axioms long_interval_margin_saving
#print axioms stationary_window_nonempty
#print axioms stationary_overlaps_full_rank
#print axioms stationary_remainder_gram_saving
#print axioms diagonal_gram_saving
#print axioms p_pos

open Lean in
run_cmd do
  let env ← getEnv
  let target := `BuildingBlocks.ActualMobiusDoubleQDualSpacingSaving
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == target
  if selected.isEmpty then
    throwError "No declarations found for the double-Q dual-spacing module"
  let audit : Lean.CollectAxioms.M Unit := do
    for (name, _) in selected do Lean.CollectAxioms.collect name
  let (_, state) := (audit.run env).run {}
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless state.axioms.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {state.axioms}"
  logInfo m!"DOUBLE-Q DUAL-SPACING DECLARATION COUNT {selected.length}"
  logInfo m!"DOUBLE-Q DUAL-SPACING TRANSITIVE AXIOMS {state.axioms}"
  logInfo "DOUBLE-Q DUAL-SPACING AXIOM AUDIT PASSED"
