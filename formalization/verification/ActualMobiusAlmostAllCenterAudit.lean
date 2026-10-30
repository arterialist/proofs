import BuildingBlocks.ActualMobiusAlmostAllCenter
import Lean.Util.CollectAxioms

#check BuildingBlocks.ActualMobiusAlmostAllCenter.smallNThreshold
#print axioms BuildingBlocks.ActualMobiusAlmostAllCenter.smallNThreshold
#check BuildingBlocks.ActualMobiusAlmostAllCenter.threshold_balance
#print axioms BuildingBlocks.ActualMobiusAlmostAllCenter.threshold_balance
#check BuildingBlocks.ActualMobiusAlmostAllCenter.lower_shortInterval_margin
#print axioms BuildingBlocks.ActualMobiusAlmostAllCenter.lower_shortInterval_margin
#check BuildingBlocks.ActualMobiusAlmostAllCenter.upper_shortInterval_margin
#print axioms BuildingBlocks.ActualMobiusAlmostAllCenter.upper_shortInterval_margin
#check BuildingBlocks.ActualMobiusAlmostAllCenter.threshold_at_epsilon_zero
#print axioms BuildingBlocks.ActualMobiusAlmostAllCenter.threshold_at_epsilon_zero
#check BuildingBlocks.ActualMobiusAlmostAllCenter.critical_threshold
#print axioms BuildingBlocks.ActualMobiusAlmostAllCenter.critical_threshold

open Lean in
run_cmd do
  let env ← getEnv
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! ==
        `BuildingBlocks.ActualMobiusAlmostAllCenter
  let mut axs : NameSet := {}
  for (name, _) in selected do
    let a ← Lean.collectAxioms name
    for x in a do
      axs := axs.insert x
  let axList := axs.toList
  let allowed := #[`propext, `Classical.choice, `Quot.sound]
  if selected.isEmpty then throwError "No module constants selected"
  unless axList.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {axList}"
  logInfo m!"Module constants audited, including generated declarations: {selected.length}"
  logInfo m!"Full transitive axiom union: {axList}"
  logInfo "ACTUAL MOBIUS ALMOST-ALL-CENTER AXIOM AUDIT PASSED"
