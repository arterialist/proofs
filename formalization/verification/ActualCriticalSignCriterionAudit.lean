import BuildingBlocks.ActualCriticalSignCriterion
import Lean.Util.CollectAxioms

open BuildingBlocks.ActualCriticalSignCriterion

#check RiemannHypothesis_of_nonpos_after
#print axioms RiemannHypothesis_of_nonpos_after

#check RiemannHypothesis_of_eventually_nonpos
#print axioms RiemannHypothesis_of_eventually_nonpos

open Lean in
run_cmd do
  let env ← getEnv
  let target := `BuildingBlocks.ActualCriticalSignCriterion
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! == target
  if selected.isEmpty then
    throwError "No declarations found for ActualCriticalSignCriterion"
  let mut axs : NameSet := {}
  for (name, _) in selected do
    let a ← Lean.collectAxioms name
    for x in a do
      axs := axs.insert x
  let axList := axs.toList
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  unless axList.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {axList}"
  logInfo m!"ACTUAL CRITICAL SIGN CRITERION DECLARATION COUNT {selected.length}"
  logInfo m!"ACTUAL CRITICAL SIGN CRITERION TRANSITIVE AXIOMS {axList}"
  for (name, _) in selected do
    logInfo m!"AUDITED {name}"
  logInfo "ACTUAL CRITICAL SIGN CRITERION AXIOM AUDIT PASSED: standard foundational axioms only [propext, Classical.choice, Quot.sound], zero custom axioms, zero sorry"
