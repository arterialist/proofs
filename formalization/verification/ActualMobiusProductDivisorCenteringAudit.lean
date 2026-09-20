import BuildingBlocks.ActualMobiusProductDivisorCentering

open BuildingBlocks.ActualMobiusProductDivisorCentering

#check kernelPairing
#check kernelPairing_const_right_eq_zero
#check kernelPairing_const_left_eq_zero
#check kernelPairing_centered

#print axioms kernelPairing_const_right_eq_zero
#print axioms kernelPairing_const_left_eq_zero
#print axioms kernelPairing_centered

open Lean in
run_cmd do
  let env ← getEnv
  let target := `BuildingBlocks.ActualMobiusProductDivisorCentering
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == target
  if selected.isEmpty then
    throwError "No declarations found for the product-divisor centering module"
  let audit : Lean.CollectAxioms.M Unit := do
    for (name, _) in selected do Lean.CollectAxioms.collect name
  let (_, state) := (audit.run env).run {}
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless state.axioms.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {state.axioms}"
  logInfo m!"PRODUCT-DIVISOR CENTERING DECLARATION COUNT {selected.length}"
  logInfo m!"PRODUCT-DIVISOR CENTERING TRANSITIVE AXIOMS {state.axioms}"
  logInfo "PRODUCT-DIVISOR CENTERING AXIOM AUDIT PASSED"
