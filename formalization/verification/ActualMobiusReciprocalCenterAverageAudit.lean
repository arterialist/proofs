import BuildingBlocks.ActualMobiusReciprocalCenterAverage
import Lean.Util.CollectAxioms

open Lean

#check BuildingBlocks.ActualMobiusReciprocalCenterAverage.physicalRowScale
#print axioms BuildingBlocks.ActualMobiusReciprocalCenterAverage.physicalRowScale
#check BuildingBlocks.ActualMobiusReciprocalCenterAverage.reciprocalGap
#print axioms BuildingBlocks.ActualMobiusReciprocalCenterAverage.reciprocalGap
#check BuildingBlocks.ActualMobiusReciprocalCenterAverage.secondExponent_below_endpoint
#print axioms BuildingBlocks.ActualMobiusReciprocalCenterAverage.secondExponent_below_endpoint
#check BuildingBlocks.ActualMobiusReciprocalCenterAverage.firstExponent_below_endpoint
#print axioms BuildingBlocks.ActualMobiusReciprocalCenterAverage.firstExponent_below_endpoint
#check BuildingBlocks.ActualMobiusReciprocalCenterAverage.both_exponents_negative
#print axioms BuildingBlocks.ActualMobiusReciprocalCenterAverage.both_exponents_negative
#check BuildingBlocks.ActualMobiusReciprocalCenterAverage.endpoint_gain
#print axioms BuildingBlocks.ActualMobiusReciprocalCenterAverage.endpoint_gain
#check BuildingBlocks.ActualMobiusReciprocalCenterAverage.critical_centerEndpoint
#print axioms BuildingBlocks.ActualMobiusReciprocalCenterAverage.critical_centerEndpoint
#check BuildingBlocks.ActualMobiusReciprocalCenterAverage.critical_oldEndpoint
#print axioms BuildingBlocks.ActualMobiusReciprocalCenterAverage.critical_oldEndpoint
#check BuildingBlocks.ActualMobiusReciprocalCenterAverage.critical_endpoint_gain
#print axioms BuildingBlocks.ActualMobiusReciprocalCenterAverage.critical_endpoint_gain
#check BuildingBlocks.ActualMobiusReciprocalCenterAverage.critical_swapped_boundary
#print axioms BuildingBlocks.ActualMobiusReciprocalCenterAverage.critical_swapped_boundary

open Lean in
run_cmd do
  let env ← getEnv
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! ==
        `BuildingBlocks.ActualMobiusReciprocalCenterAverage
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
  logInfo "ACTUAL MOBIUS RECIPROCAL CENTER AVERAGE AXIOM AUDIT PASSED"
