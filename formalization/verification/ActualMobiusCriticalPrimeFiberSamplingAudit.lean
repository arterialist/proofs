import BuildingBlocks.ActualMobiusCriticalPrimeFiberSampling
import Lean.Util.CollectAxioms

open BuildingBlocks.ActualMobiusCriticalPrimeFiberSampling

#check critical_relations
#check prime_sample_bound_exponent
#check prime_sample_gain
#check admissible_rho_positive
#check qCauchy_exhausts_gain

#print axioms critical_relations
#print axioms prime_sample_bound_exponent
#print axioms prime_sample_gain
#print axioms admissible_rho_positive
#print axioms qCauchy_exhausts_gain

open Lean in
run_cmd do
  let env ← getEnv
  let target := `BuildingBlocks.ActualMobiusCriticalPrimeFiberSampling
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == target
  if selected.isEmpty then
    throwError "No declarations found for the critical prime-fiber sampling module"
  let audit : Lean.CollectAxioms.M Unit := do
    for (name, _) in selected do Lean.CollectAxioms.collect name
  let (_, state) := (audit.run env).run {}
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless state.axioms.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {state.axioms}"
  logInfo m!"CRITICAL PRIME-FIBER SAMPLING DECLARATION COUNT {selected.length}"
  logInfo m!"CRITICAL PRIME-FIBER SAMPLING TRANSITIVE AXIOMS {state.axioms}"
  logInfo "CRITICAL PRIME-FIBER SAMPLING AXIOM AUDIT PASSED"
