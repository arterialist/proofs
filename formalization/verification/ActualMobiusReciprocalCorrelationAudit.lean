import BuildingBlocks.ActualMobiusReciprocalCorrelation
import Lean.Util.CollectAxioms

open Lean

#check BuildingBlocks.ActualMobiusReciprocalCorrelation.finiteBilinearKernelExpansion
#print axioms BuildingBlocks.ActualMobiusReciprocalCorrelation.finiteBilinearKernelExpansion
#check BuildingBlocks.ActualMobiusReciprocalCorrelation.finiteMeanSquareExpansion
#print axioms BuildingBlocks.ActualMobiusReciprocalCorrelation.finiteMeanSquareExpansion
#check BuildingBlocks.ActualMobiusReciprocalCorrelation.finiteMeanSquareDiagonal
#print axioms BuildingBlocks.ActualMobiusReciprocalCorrelation.finiteMeanSquareDiagonal
#check BuildingBlocks.ActualMobiusReciprocalCorrelation.primitiveReciprocalGap
#print axioms BuildingBlocks.ActualMobiusReciprocalCorrelation.primitiveReciprocalGap
#check BuildingBlocks.ActualMobiusReciprocalCorrelation.reciprocalCoherenceScale
#print axioms BuildingBlocks.ActualMobiusReciprocalCorrelation.reciprocalCoherenceScale
#check BuildingBlocks.ActualMobiusReciprocalCorrelation.additiveReciprocityExact
#print axioms BuildingBlocks.ActualMobiusReciprocalCorrelation.additiveReciprocityExact
#check BuildingBlocks.ActualMobiusReciprocalCorrelation.hermitianReciprocityExact
#print axioms BuildingBlocks.ActualMobiusReciprocalCorrelation.hermitianReciprocityExact
#check BuildingBlocks.ActualMobiusReciprocalCorrelation.endpointCorrelationThreshold
#print axioms BuildingBlocks.ActualMobiusReciprocalCorrelation.endpointCorrelationThreshold
#check BuildingBlocks.ActualMobiusReciprocalCorrelation.endpointCorrelationMargin
#print axioms BuildingBlocks.ActualMobiusReciprocalCorrelation.endpointCorrelationMargin
#check BuildingBlocks.ActualMobiusReciprocalCorrelation.endpointDiagonalThreshold
#print axioms BuildingBlocks.ActualMobiusReciprocalCorrelation.endpointDiagonalThreshold
#check BuildingBlocks.ActualMobiusReciprocalCorrelation.zeroBranchRho_lower_margin
#print axioms BuildingBlocks.ActualMobiusReciprocalCorrelation.zeroBranchRho_lower_margin
#check BuildingBlocks.ActualMobiusReciprocalCorrelation.zeroBranchRho_upper_margin
#print axioms BuildingBlocks.ActualMobiusReciprocalCorrelation.zeroBranchRho_upper_margin
#check BuildingBlocks.ActualMobiusReciprocalCorrelation.zeroBranch_supports_final_margin
#print axioms BuildingBlocks.ActualMobiusReciprocalCorrelation.zeroBranch_supports_final_margin
#check BuildingBlocks.ActualMobiusReciprocalCorrelation.coprime_product_difference
#print axioms BuildingBlocks.ActualMobiusReciprocalCorrelation.coprime_product_difference
#check BuildingBlocks.ActualMobiusReciprocalCorrelation.exact_resonance_reduced_product_dvd_center
#print axioms BuildingBlocks.ActualMobiusReciprocalCorrelation.exact_resonance_reduced_product_dvd_center

open Lean in
run_cmd do
  let env ← getEnv
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! ==
        `BuildingBlocks.ActualMobiusReciprocalCorrelation
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
  logInfo "ACTUAL MOBIUS RECIPROCAL CORRELATION AXIOM AUDIT PASSED"
