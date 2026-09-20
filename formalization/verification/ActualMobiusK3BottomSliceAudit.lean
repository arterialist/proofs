import BuildingBlocks.ActualMobiusK3BottomSlice
import Lean.Util.CollectAxioms

open BuildingBlocks.ActualMobiusK3BottomSlice

#check endpoint_identity
#check aspect_identities
#check rs_bord_overlap_margin
#check small_above_cutoff
#check small_below_three_cutoffs
#check forced_atom_identity
#check uniform_buffer_ledger
#check pruning_margin
#check type_i_one_identity
#check type_i_one_negative
#check pruning_delta_condition
#check decomposition_length
#check transition_reaches_previous_cutoff
#check equality_geometry
#check equality_short_factor_admissible
#check equality_contact_geometry
#check type_i_endpoint_margin
#check outer_signed_second_k3_range
#check second_k3_self_similar_contact
#check second_k3_greedy_gap

#print axioms endpoint_identity
#print axioms rs_bord_overlap_margin
#print axioms uniform_buffer_ledger
#print axioms pruning_margin
#print axioms type_i_one_negative
#print axioms pruning_delta_condition
#print axioms decomposition_length
#print axioms transition_reaches_previous_cutoff
#print axioms equality_geometry
#print axioms equality_short_factor_admissible
#print axioms equality_contact_geometry
#print axioms type_i_endpoint_margin
#print axioms outer_signed_second_k3_range
#print axioms second_k3_self_similar_contact
#print axioms second_k3_greedy_gap

open Lean in
run_cmd do
  let env ← getEnv
  let target := `BuildingBlocks.ActualMobiusK3BottomSlice
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == target
  if selected.isEmpty then
    throwError "No declarations found for the K=3 prefix module"
  let audit : Lean.CollectAxioms.M Unit := do
    for (name, _) in selected do
      Lean.CollectAxioms.collect name
  let (_, state) := (audit.run env).run {}
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless state.axioms.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {state.axioms}"
  logInfo m!"K3 PREFIX DECLARATION COUNT {selected.length}"
  logInfo m!"K3 PREFIX TRANSITIVE AXIOMS {state.axioms}"
  logInfo "K3 PREFIX AXIOM AUDIT PASSED"
