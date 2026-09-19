import BuildingBlocks.ActualMobiusConvolution
import Lean.Util.CollectAxioms

#check BuildingBlocks.ActualMobiusConvolution.balancedMobiusCoefficient
#print axioms BuildingBlocks.ActualMobiusConvolution.balancedMobiusCoefficient
#check BuildingBlocks.ActualMobiusConvolution.tail_difference
#print axioms BuildingBlocks.ActualMobiusConvolution.tail_difference
#check BuildingBlocks.ActualMobiusConvolution.balancedMobiusCoefficient_isMultiplicative
#print axioms BuildingBlocks.ActualMobiusConvolution.balancedMobiusCoefficient_isMultiplicative
#check BuildingBlocks.ActualMobiusConvolution.balancedMobiusCoefficient_prime_pow
#print axioms BuildingBlocks.ActualMobiusConvolution.balancedMobiusCoefficient_prime_pow
#check BuildingBlocks.ActualMobiusConvolution.balancedMobiusCoefficient_apply_prime
#print axioms BuildingBlocks.ActualMobiusConvolution.balancedMobiusCoefficient_apply_prime
#check BuildingBlocks.ActualMobiusConvolution.balancedMobiusCoefficient_apply_prime_sq
#print axioms BuildingBlocks.ActualMobiusConvolution.balancedMobiusCoefficient_apply_prime_sq
#check BuildingBlocks.ActualMobiusConvolution.balancedMobiusCoefficient_apply_prime_pow_eq_zero
#print axioms BuildingBlocks.ActualMobiusConvolution.balancedMobiusCoefficient_apply_prime_pow_eq_zero
#check BuildingBlocks.ActualMobiusConvolution.balancedMobiusCoefficient_mul_zeta_sq
#print axioms BuildingBlocks.ActualMobiusConvolution.balancedMobiusCoefficient_mul_zeta_sq
#check BuildingBlocks.ActualMobiusConvolution.mul_moebius_mul_zeta
#print axioms BuildingBlocks.ActualMobiusConvolution.mul_moebius_mul_zeta
#check BuildingBlocks.ActualMobiusConvolution.balancedMobiusCoefficient_mul_zeta
#print axioms BuildingBlocks.ActualMobiusConvolution.balancedMobiusCoefficient_mul_zeta
#check BuildingBlocks.ActualMobiusConvolution.moebius_mul_of_coprime
#print axioms BuildingBlocks.ActualMobiusConvolution.moebius_mul_of_coprime
#check BuildingBlocks.ActualMobiusConvolution.coprimeFactorFiber_sum
#print axioms BuildingBlocks.ActualMobiusConvolution.coprimeFactorFiber_sum
#check BuildingBlocks.ActualMobiusConvolution.squarefreeCoreCoefficient
#print axioms BuildingBlocks.ActualMobiusConvolution.squarefreeCoreCoefficient
#check BuildingBlocks.ActualMobiusConvolution.squarefreeCoreCoefficient_apply
#print axioms BuildingBlocks.ActualMobiusConvolution.squarefreeCoreCoefficient_apply
#check BuildingBlocks.ActualMobiusConvolution.squarefreeCoreCoefficient_isMultiplicative
#print axioms BuildingBlocks.ActualMobiusConvolution.squarefreeCoreCoefficient_isMultiplicative
#check BuildingBlocks.ActualMobiusConvolution.typeICorrection
#print axioms BuildingBlocks.ActualMobiusConvolution.typeICorrection
#check BuildingBlocks.ActualMobiusConvolution.squarefreeCoreCoefficient_eq_zeta_mul_typeICorrection
#print axioms BuildingBlocks.ActualMobiusConvolution.squarefreeCoreCoefficient_eq_zeta_mul_typeICorrection
#check BuildingBlocks.ActualMobiusConvolution.typeICorrection_isMultiplicative
#print axioms BuildingBlocks.ActualMobiusConvolution.typeICorrection_isMultiplicative
#check BuildingBlocks.ActualMobiusConvolution.typeICorrection_apply_prime
#print axioms BuildingBlocks.ActualMobiusConvolution.typeICorrection_apply_prime
#check BuildingBlocks.ActualMobiusConvolution.typeICorrection_apply_prime_sq
#print axioms BuildingBlocks.ActualMobiusConvolution.typeICorrection_apply_prime_sq
#check BuildingBlocks.ActualMobiusConvolution.typeICorrection_apply_prime_pow_eq_zero
#print axioms BuildingBlocks.ActualMobiusConvolution.typeICorrection_apply_prime_pow_eq_zero

open Lean in
run_cmd do
  let env ← getEnv
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! ==
        `BuildingBlocks.ActualMobiusConvolution
  let audit : Lean.CollectAxioms.M Unit := do
    for (name, _) in selected do
      Lean.CollectAxioms.collect name
  let (_, state) := (audit.run env).run {}
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  if selected.isEmpty then throwError "No module constants selected"
  unless state.axioms.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {state.axioms}"
  logInfo m!"Module constants audited, including generated declarations: {selected.length}"
  logInfo m!"Full transitive axiom union: {state.axioms}"
  logInfo "ACTUAL MOBIUS CONVOLUTION AXIOM AUDIT PASSED"
