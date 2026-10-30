import BuildingBlocks.ActualMobiusLocalizedDivisorFourier

open BuildingBlocks.ActualMobiusLocalizedDivisorFourier

#check factor_product_scale
#check physical_scale
#check localized_product_exponent
#check natural_modulus_main_exponent
#check natural_modulus_exponent_le
#check box_saving_exponent
#check endpoint_ratio_exponent
#check endpoint_ratio_saves
#check worst_gcd_ratio_exponent
#check worst_gcd_ratio_saves

#print axioms factor_product_scale
#print axioms physical_scale
#print axioms localized_product_exponent
#print axioms natural_modulus_main_exponent
#print axioms natural_modulus_exponent_le
#print axioms box_saving_exponent
#print axioms endpoint_ratio_exponent
#print axioms endpoint_ratio_saves
#print axioms worst_gcd_ratio_exponent
#print axioms worst_gcd_ratio_saves

open Lean in
run_cmd do
  let env ← getEnv
  let target := `BuildingBlocks.ActualMobiusLocalizedDivisorFourier
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == target
  if selected.isEmpty then
    throwError "No declarations found for the localized-divisor Fourier module"
  let mut axs : NameSet := {}
  for (name, _) in selected do
    let a ← Lean.collectAxioms name
    for x in a do
      axs := axs.insert x
  let axList := axs.toList
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless axList.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {axList}"
  logInfo m!"LOCALIZED DIVISOR FOURIER DECLARATION COUNT {selected.length}"
  logInfo m!"LOCALIZED DIVISOR FOURIER TRANSITIVE AXIOMS {axList}"
  logInfo "LOCALIZED DIVISOR FOURIER AXIOM AUDIT PASSED"
