import BuildingBlocks.ActualCriticalGrowthCriterion
import BuildingBlocks.ActualCriticalLowerExcursion
import BuildingBlocks.ActualCriticalMajorantCriterion
import BuildingBlocks.ActualCriticalLogMajorant
import BuildingBlocks.ActualCriticalLowerMajorant
import BuildingBlocks.ActualCriticalSharpConstant
import Lean.Util.CollectAxioms

/-!
Axiom audit for the one-sided growth criteria and the unconditional lower-excursion
theorem. The `#check` lines print the full statements, so the conditional hypotheses
(`hgrow`, `hlow`) of the criteria are visible next to the unconditional excursion result.
-/

open BuildingBlocks.ActualCriticalGrowthCriterion
open BuildingBlocks.ActualCriticalLowerExcursion
open BuildingBlocks.ActualCriticalMajorantCriterion
open BuildingBlocks.ActualCriticalLogMajorant
open BuildingBlocks.ActualCriticalLowerMajorant
open BuildingBlocks.ActualCriticalSharpConstant

#check RiemannHypothesis_of_growth_after
#print axioms RiemannHypothesis_of_growth_after
#check RiemannHypothesis_of_eventually_growth
#print axioms RiemannHypothesis_of_eventually_growth
#check RiemannHypothesis_of_lower_growth_after
#print axioms RiemannHypothesis_of_lower_growth_after
#check RiemannHypothesis_of_eventually_abs_growth
#print axioms RiemannHypothesis_of_eventually_abs_growth

#check riemannZeta_half_ne_zero
#print axioms riemannZeta_half_ne_zero
#check not_eventually_lower_growth
#print axioms not_eventually_lower_growth
#check exists_lower_excursion
#print axioms exists_lower_excursion
#check frequently_lower_excursion
#print axioms frequently_lower_excursion

#check RiemannHypothesis_of_majorant
#print axioms RiemannHypothesis_of_majorant
#check RiemannHypothesis_of_log_growth_after
#print axioms RiemannHypothesis_of_log_growth_after
#check RiemannHypothesis_of_eventually_log_growth
#print axioms RiemannHypothesis_of_eventually_log_growth

#check RiemannHypothesis_of_lower_majorant
#print axioms RiemannHypothesis_of_lower_majorant
#check not_eventually_lower_majorant
#print axioms not_eventually_lower_majorant

#check not_eventually_lower_log_growth_of_HDoublePole
#print axioms not_eventually_lower_log_growth_of_HDoublePole

open Lean in
run_cmd do
  let env ← getEnv
  let targets : List Name := [`BuildingBlocks.ActualCriticalGrowthCriterion,
    `BuildingBlocks.ActualCriticalLowerExcursion, `BuildingBlocks.ActualCriticalMajorantCriterion,
    `BuildingBlocks.ActualCriticalLogMajorant, `BuildingBlocks.ActualCriticalLowerMajorant,
    `BuildingBlocks.ActualCriticalSharpConstant]
  let selected := env.constants.toList.filter fun (name, _) =>
    match env.getModuleIdxFor? name with
    | none => false
    | some idx => targets.contains env.header.moduleNames[idx.toNat]!
  if selected.isEmpty then
    throwError "No declarations found for the growth/excursion modules"
  let mut axs : NameSet := {}
  for (name, _) in selected do
    let a ← Lean.collectAxioms name
    for x in a do
      axs := axs.insert x
  let allowed : List Name := [`propext, `Classical.choice, `Quot.sound]
  let axList := axs.toList
  unless axList.all (fun name => allowed.contains name) do
    throwError m!"Unexpected axiom dependency: {axList}"
  logInfo m!"GROWTH/EXCURSION DECLARATION COUNT {selected.length}"
  logInfo m!"GROWTH/EXCURSION TRANSITIVE AXIOMS {axList}"
  logInfo "GROWTH/EXCURSION AXIOM AUDIT PASSED: standard foundational axioms only, zero custom axioms, zero sorry"
