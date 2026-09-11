import BuildingBlocks.HyperbolaEndpoint
import Lean.Util.CollectAxioms

#check BuildingBlocks.HyperbolaEndpoint.moebius_square_quotient_sum
#print axioms BuildingBlocks.HyperbolaEndpoint.moebius_square_quotient_sum
#check BuildingBlocks.HyperbolaEndpoint.halfDivisorCount
#print axioms BuildingBlocks.HyperbolaEndpoint.halfDivisorCount
#check BuildingBlocks.HyperbolaEndpoint.twice_halfDivisorCount
#print axioms BuildingBlocks.HyperbolaEndpoint.twice_halfDivisorCount
#check BuildingBlocks.HyperbolaEndpoint.moebius_divisorCard_sum
#print axioms BuildingBlocks.HyperbolaEndpoint.moebius_divisorCard_sum
#check BuildingBlocks.HyperbolaEndpoint.hyperbolaEndpointCorrection
#print axioms BuildingBlocks.HyperbolaEndpoint.hyperbolaEndpointCorrection
#check BuildingBlocks.HyperbolaEndpoint.twice_hyperbolaEndpointCorrection
#print axioms BuildingBlocks.HyperbolaEndpoint.twice_hyperbolaEndpointCorrection
#check BuildingBlocks.HyperbolaEndpoint.hyperbolaEndpointCorrection_zero_or_one
#print axioms BuildingBlocks.HyperbolaEndpoint.hyperbolaEndpointCorrection_zero_or_one
#check BuildingBlocks.HyperbolaEndpoint.halfDivisorCount_eq_sqrt_divisors
#print axioms BuildingBlocks.HyperbolaEndpoint.halfDivisorCount_eq_sqrt_divisors
#check BuildingBlocks.HyperbolaEndpoint.hyperbolaEndpointCorrection_eq_jump_sum
#print axioms BuildingBlocks.HyperbolaEndpoint.hyperbolaEndpointCorrection_eq_jump_sum

open Lean in
run_cmd do
  let env ← getEnv
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == `BuildingBlocks.HyperbolaEndpoint
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
  logInfo "HYPERBOLA ENDPOINT AXIOM AUDIT PASSED"
