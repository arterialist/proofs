import BuildingBlocks.GlobalCOneLongFreeFactor
import Lean.Util.CollectAxioms

open BuildingBlocks.GlobalCOneLongFreeFactor

#check dStar
#check gammaZero
#check cutoffU
#check exponentOne
#check exponentTwo
#check exponentThree
#check exponentOne_eq
#check exponentTwo_eq
#check exponentThree_eq
#check exponent_savings
#check saving_pos
#check q_cutoff_identity
#check old_cutoff_gap
#check old_cutoff_gap_pos
#check strict_extension_of_gap
#check collisionExponent
#check balanced_collision
#check bounded_t_balanced_collision
#check balanced_threshold_gap

#print axioms exponent_savings
#print axioms saving_pos
#print axioms q_cutoff_identity
#print axioms old_cutoff_gap_pos
#print axioms strict_extension_of_gap
#print axioms balanced_collision
#print axioms bounded_t_balanced_collision
#print axioms balanced_threshold_gap

open Lean in
run_cmd do
  let env ← getEnv
  let target := `BuildingBlocks.GlobalCOneLongFreeFactor
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == target
  if selected.isEmpty then
    throwError "No declarations found for the exponent module"
  let mut axs : NameSet := {}
  for (name, _) in selected do
    let a ← Lean.collectAxioms name
    for x in a do
      axs := axs.insert x
  let axList := axs.toList
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless axList.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {axList}"
  logInfo m!"GLOBAL C-ONE DECLARATION COUNT {selected.length}"
  logInfo m!"GLOBAL C-ONE TRANSITIVE AXIOMS {axList}"
  logInfo "GLOBAL C-ONE AXIOM AUDIT PASSED"
