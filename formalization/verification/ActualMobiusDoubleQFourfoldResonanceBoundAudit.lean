import BuildingBlocks.ActualMobiusDoubleQFourfoldResonanceBound

open BuildingBlocks.ActualMobiusDoubleQFourfoldResonanceBound

#check physical_scale
#check window_product_exponent
#check resonance_count_exponent
#check leading_block_exponent
#check leading_ratio_exponent
#check resonance_excess_eq
#check resonance_excess_pos
#check resonance_excess_below_one_fourteenth
#check replacement_error_at_barrier
#check p_lt_q
#check replacement_error_saves
#check reverse_error_saves
#check product_diagonal_saving

#print axioms physical_scale
#print axioms window_product_exponent
#print axioms resonance_count_exponent
#print axioms leading_block_exponent
#print axioms leading_ratio_exponent
#print axioms resonance_excess_eq
#print axioms resonance_excess_pos
#print axioms resonance_excess_below_one_fourteenth
#print axioms replacement_error_at_barrier
#print axioms p_lt_q
#print axioms replacement_error_saves
#print axioms reverse_error_saves
#print axioms product_diagonal_saving

open Lean in
run_cmd do
  let env ← getEnv
  let target := `BuildingBlocks.ActualMobiusDoubleQFourfoldResonanceBound
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == target
  if selected.isEmpty then
    throwError "No declarations found for the fourfold resonance module"
  let audit : Lean.CollectAxioms.M Unit := do
    for (name, _) in selected do Lean.CollectAxioms.collect name
  let (_, state) := (audit.run env).run {}
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless state.axioms.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {state.axioms}"
  logInfo m!"FOURFOLD RESONANCE DECLARATION COUNT {selected.length}"
  logInfo m!"FOURFOLD RESONANCE TRANSITIVE AXIOMS {state.axioms}"
  logInfo "FOURFOLD RESONANCE AXIOM AUDIT PASSED"
