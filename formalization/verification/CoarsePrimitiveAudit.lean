import BuildingBlocks.CoarsePrimitive
import Lean.Util.CollectAxioms

#check BuildingBlocks.CoarsePrimitive.psi
#print axioms BuildingBlocks.CoarsePrimitive.psi
#check BuildingBlocks.CoarsePrimitive.psi_mono
#print axioms BuildingBlocks.CoarsePrimitive.psi_mono
#check BuildingBlocks.CoarsePrimitive.primeErrorReal
#print axioms BuildingBlocks.CoarsePrimitive.primeErrorReal
#check BuildingBlocks.CoarsePrimitive.coarsePrefix
#print axioms BuildingBlocks.CoarsePrimitive.coarsePrefix
#check BuildingBlocks.CoarsePrimitive.coarseSuffix
#print axioms BuildingBlocks.CoarsePrimitive.coarseSuffix
#check BuildingBlocks.CoarsePrimitive.coarsePrimitiveSquare
#print axioms BuildingBlocks.CoarsePrimitive.coarsePrimitiveSquare
#check BuildingBlocks.CoarsePrimitive.primeErrorReal_intervalIntegrable
#print axioms BuildingBlocks.CoarsePrimitive.primeErrorReal_intervalIntegrable
#check BuildingBlocks.CoarsePrimitive.coarsePrefix_add_suffix
#print axioms BuildingBlocks.CoarsePrimitive.coarsePrefix_add_suffix
#check BuildingBlocks.CoarsePrimitive.coarsePrefix_continuous
#print axioms BuildingBlocks.CoarsePrimitive.coarsePrefix_continuous
#check BuildingBlocks.CoarsePrimitive.coarseSuffix_continuous
#print axioms BuildingBlocks.CoarsePrimitive.coarseSuffix_continuous
#check BuildingBlocks.CoarsePrimitive.coarsePrimitiveSquare_nonneg
#print axioms BuildingBlocks.CoarsePrimitive.coarsePrimitiveSquare_nonneg
#check BuildingBlocks.CoarsePrimitive.coarse_terminal_mass_sq_le
#print axioms BuildingBlocks.CoarsePrimitive.coarse_terminal_mass_sq_le
#check BuildingBlocks.CoarsePrimitive.primeErrorReal_measurable
#print axioms BuildingBlocks.CoarsePrimitive.primeErrorReal_measurable
#check BuildingBlocks.CoarsePrimitive.primeErrorReal_continuousWithinAt_right
#print axioms BuildingBlocks.CoarsePrimitive.primeErrorReal_continuousWithinAt_right
#check BuildingBlocks.CoarsePrimitive.coarsePrefix_hasDerivWithinAt_right
#print axioms BuildingBlocks.CoarsePrimitive.coarsePrefix_hasDerivWithinAt_right
#check BuildingBlocks.CoarsePrimitive.interval_abs_integral_sq_le
#print axioms BuildingBlocks.CoarsePrimitive.interval_abs_integral_sq_le
#check BuildingBlocks.CoarsePrimitive.coarsePrefix_abs_integral_sq_le
#print axioms BuildingBlocks.CoarsePrimitive.coarsePrefix_abs_integral_sq_le
#check BuildingBlocks.CoarsePrimitive.coarsePrime_summation_by_parts
#print axioms BuildingBlocks.CoarsePrimitive.coarsePrime_summation_by_parts
#check BuildingBlocks.CoarsePrimitive.coarsePrime_mellin_block
#print axioms BuildingBlocks.CoarsePrimitive.coarsePrime_mellin_block
#check BuildingBlocks.CoarsePrimitive.coarse_terminal_mass_le_sqrt
#print axioms BuildingBlocks.CoarsePrimitive.coarse_terminal_mass_le_sqrt
#check BuildingBlocks.CoarsePrimitive.coarsePrefix_abs_integral_le_sqrt
#print axioms BuildingBlocks.CoarsePrimitive.coarsePrefix_abs_integral_le_sqrt
#check BuildingBlocks.CoarsePrimitive.coarsePrime_test_bound
#print axioms BuildingBlocks.CoarsePrimitive.coarsePrime_test_bound

open Lean in
run_cmd do
  let env ← getEnv
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == `BuildingBlocks.CoarsePrimitive
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
  logInfo "COARSE PRIMITIVE AXIOM AUDIT PASSED"
