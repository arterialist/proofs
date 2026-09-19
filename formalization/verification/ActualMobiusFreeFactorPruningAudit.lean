import BuildingBlocks.ActualMobiusFreeFactorPruning
import Lean.Util.CollectAxioms

#check BuildingBlocks.ActualMobiusFreeFactorPruning.freeFactor_grouping
#print axioms BuildingBlocks.ActualMobiusFreeFactorPruning.freeFactor_grouping
#check BuildingBlocks.ActualMobiusFreeFactorPruning.exact_grouping_separation
#print axioms BuildingBlocks.ActualMobiusFreeFactorPruning.exact_grouping_separation
#check BuildingBlocks.ActualMobiusFreeFactorPruning.robertSargosSecond_le
#print axioms BuildingBlocks.ActualMobiusFreeFactorPruning.robertSargosSecond_le
#check BuildingBlocks.ActualMobiusFreeFactorPruning.robertSargosSecond_eq_separation
#print axioms BuildingBlocks.ActualMobiusFreeFactorPruning.robertSargosSecond_eq_separation
#check BuildingBlocks.ActualMobiusFreeFactorPruning.robertSargosSecond_separation_lt_margin
#print axioms BuildingBlocks.ActualMobiusFreeFactorPruning.robertSargosSecond_separation_lt_margin
#check BuildingBlocks.ActualMobiusFreeFactorPruning.robertSargosFirst_le
#print axioms BuildingBlocks.ActualMobiusFreeFactorPruning.robertSargosFirst_le
#check BuildingBlocks.ActualMobiusFreeFactorPruning.robertSargosThird_le
#print axioms BuildingBlocks.ActualMobiusFreeFactorPruning.robertSargosThird_le
#check BuildingBlocks.ActualMobiusFreeFactorPruning.bordellesFirst_le
#print axioms BuildingBlocks.ActualMobiusFreeFactorPruning.bordellesFirst_le
#check BuildingBlocks.ActualMobiusFreeFactorPruning.bordellesSecond_le
#print axioms BuildingBlocks.ActualMobiusFreeFactorPruning.bordellesSecond_le
#check BuildingBlocks.ActualMobiusFreeFactorPruning.bordellesThird_le
#print axioms BuildingBlocks.ActualMobiusFreeFactorPruning.bordellesThird_le
#check BuildingBlocks.ActualMobiusFreeFactorPruning.commonFourth_eq
#print axioms BuildingBlocks.ActualMobiusFreeFactorPruning.commonFourth_eq
#check BuildingBlocks.ActualMobiusFreeFactorPruning.robertSargosSecond_lt_margin
#print axioms BuildingBlocks.ActualMobiusFreeFactorPruning.robertSargosSecond_lt_margin
#check BuildingBlocks.ActualMobiusFreeFactorPruning.bordellesFirst_lt_margin
#print axioms BuildingBlocks.ActualMobiusFreeFactorPruning.bordellesFirst_lt_margin
#check BuildingBlocks.ActualMobiusFreeFactorPruning.bordellesSecond_lt_margin
#print axioms BuildingBlocks.ActualMobiusFreeFactorPruning.bordellesSecond_lt_margin

open Lean in
run_cmd do
  let env ← getEnv
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => env.header.moduleNames[idx.toNat]! ==
        `BuildingBlocks.ActualMobiusFreeFactorPruning
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
  logInfo "ACTUAL MOBIUS FREE-FACTOR PRUNING AXIOM AUDIT PASSED"
