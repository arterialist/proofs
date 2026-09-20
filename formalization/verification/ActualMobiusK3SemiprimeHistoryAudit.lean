import BuildingBlocks.ActualMobiusK3SemiprimeHistory
import Lean.Util.CollectAxioms

open BuildingBlocks.ActualMobiusK3SemiprimeHistory

#check divisorCount_apply_prime
#check divisorCount_apply_distinct_prime_mul
#check one_nonunit_short_prime_histories_cancel
#check all_unit_histories_leave_one
#check allUnitCoefficient_eq_single_add_nontrivial
#check allUnitCoefficient_apply_prime
#check nontrivial_free_splits_distinct_prime_mul
#check allUnitCoefficient_apply_distinct_prime_mul
#check moebius_apply_distinct_prime_mul
#check k3_mixed_semiprime_history_provenance

#print axioms divisorCount_apply_distinct_prime_mul
#print axioms one_nonunit_short_prime_histories_cancel
#print axioms all_unit_histories_leave_one
#print axioms allUnitCoefficient_apply_prime
#print axioms nontrivial_free_splits_distinct_prime_mul
#print axioms allUnitCoefficient_apply_distinct_prime_mul
#print axioms k3_mixed_semiprime_history_provenance

open Lean in
run_cmd do
  let env ← getEnv
  let target := `BuildingBlocks.ActualMobiusK3SemiprimeHistory
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == target
  if selected.isEmpty then
    throwError "No declarations found for the K=3 semiprime-history module"
  let audit : Lean.CollectAxioms.M Unit := do
    for (name, _) in selected do
      Lean.CollectAxioms.collect name
  let (_, state) := (audit.run env).run {}
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless state.axioms.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {state.axioms}"
  logInfo m!"K3 SEMIPRIME HISTORY DECLARATION COUNT {selected.length}"
  logInfo m!"K3 SEMIPRIME HISTORY TRANSITIVE AXIOMS {state.axioms}"
  logInfo "K3 SEMIPRIME HISTORY AXIOM AUDIT PASSED"
