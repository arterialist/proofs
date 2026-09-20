import BuildingBlocks.ActualMobiusCriticalOneQPoissonEndpoint
import Lean.Util.CollectAxioms

open BuildingBlocks.ActualMobiusCriticalOneQPoissonEndpoint

#check scale_identities
#check scale_order
#check x_spacing_exponent
#check y_spacing_exponent
#check spacing_exponents_negative
#check double_large_sieve_exponent
#check stationary_endpoint_exponent
#check endpoint_margin_zero
#check monomial_loss_positive

#print axioms scale_identities
#print axioms scale_order
#print axioms spacing_exponents_negative
#print axioms double_large_sieve_exponent
#print axioms stationary_endpoint_exponent
#print axioms endpoint_margin_zero

open Lean in
run_cmd do
  let env ← getEnv
  let target := `BuildingBlocks.ActualMobiusCriticalOneQPoissonEndpoint
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == target
  if selected.isEmpty then
    throwError "No declarations found for the one-Q Poisson endpoint module"
  let audit : Lean.CollectAxioms.M Unit := do
    for (name, _) in selected do Lean.CollectAxioms.collect name
  let (_, state) := (audit.run env).run {}
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless state.axioms.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {state.axioms}"
  logInfo m!"ONE-Q POISSON ENDPOINT DECLARATION COUNT {selected.length}"
  logInfo m!"ONE-Q POISSON ENDPOINT TRANSITIVE AXIOMS {state.axioms}"
  logInfo "ONE-Q POISSON ENDPOINT AXIOM AUDIT PASSED"
