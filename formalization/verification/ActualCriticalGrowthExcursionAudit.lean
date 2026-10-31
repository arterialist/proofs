import BuildingBlocks.ActualCriticalGrowthCriterion
import BuildingBlocks.ActualCriticalLowerExcursion
import BuildingBlocks.ActualCriticalMajorantCriterion
import BuildingBlocks.ActualCriticalLogMajorant
import BuildingBlocks.ActualCriticalLowerMajorant
import BuildingBlocks.ActualCriticalSharpConstant
import BuildingBlocks.PrimePowerLogSeries
import BuildingBlocks.ActualCriticalHDoublePole
import BuildingBlocks.ActualCriticalUpperSharpConstant
import BuildingBlocks.CriticalTransformContinuationZeroFree
import BuildingBlocks.ActualCriticalZeroFreeCriterion
import BuildingBlocks.ActualCriticalSharpOscillation
import BuildingBlocks.ActualCriticalSecondOrder
import BuildingBlocks.SamePrimeContinuation
import BuildingBlocks.ActualCriticalLineAmplitude
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
open BuildingBlocks.ActualCriticalHDoublePole
open BuildingBlocks.ActualCriticalUpperSharpConstant
open BuildingBlocks.CriticalTransformContinuationZeroFree
open BuildingBlocks.ActualCriticalZeroFreeCriterion
open BuildingBlocks.ActualCriticalSharpOscillation
open BuildingBlocks.ActualCriticalSecondOrder
open BuildingBlocks.SamePrimeContinuation
open BuildingBlocks.ActualCriticalLineAmplitude

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

#check hDoublePole
#print axioms hDoublePole
#check BuildingBlocks.ActualCriticalHDoublePole.not_eventually_lower_log_growth
#print axioms BuildingBlocks.ActualCriticalHDoublePole.not_eventually_lower_log_growth
#check exists_sharp_lower_excursion
#print axioms exists_sharp_lower_excursion

#check not_eventually_upper_log_growth
#print axioms not_eventually_upper_log_growth
#check two_sided_sharp_constant
#print axioms two_sided_sharp_constant

open Lean in
run_cmd do
  let env ← getEnv
  let targets : List Name := [`BuildingBlocks.ActualCriticalGrowthCriterion,
    `BuildingBlocks.ActualCriticalLowerExcursion, `BuildingBlocks.ActualCriticalMajorantCriterion,
    `BuildingBlocks.ActualCriticalLogMajorant, `BuildingBlocks.ActualCriticalLowerMajorant,
    `BuildingBlocks.ActualCriticalSharpConstant, `BuildingBlocks.PrimePowerLogSeries,
    `BuildingBlocks.ActualCriticalHDoublePole, `BuildingBlocks.ActualCriticalUpperSharpConstant]
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

/-! ### Level `θ`: zero-free half-planes and oscillation -/

#check zeroFree_of_holomorphic_continuation
#print axioms zeroFree_of_holomorphic_continuation
#check zeroFree_of_majorant
#print axioms zeroFree_of_majorant
#check zeroFree_of_lower_majorant
#print axioms zeroFree_of_lower_majorant
#check zeroFree_of_power_growth
#print axioms zeroFree_of_power_growth
#check zeroFree_of_power_lower_growth
#print axioms zeroFree_of_power_lower_growth
#check zeroFree_le_of_power_growth
#print axioms zeroFree_le_of_power_growth
#check oscillation_of_zero
#print axioms oscillation_of_zero
#check log_oscillation_of_not_RH
#print axioms log_oscillation_of_not_RH
#check power_oscillation_of_not_RH
#print axioms power_oscillation_of_not_RH

/-! ### The boundary line: sharp oscillation at the exact exponent -/

#check no_zero_on_boundary
#print axioms no_zero_on_boundary
#check zeroFree_boundary_of_power_growth
#print axioms zeroFree_boundary_of_power_growth
#check zeroFree_boundary_of_power_lower_growth
#print axioms zeroFree_boundary_of_power_lower_growth
#check zeroFree_ge_of_power_growth
#print axioms zeroFree_ge_of_power_growth
#check zeroFree_ge_of_power_lower_growth
#print axioms zeroFree_ge_of_power_lower_growth
#check sharp_oscillation_of_zero
#print axioms sharp_oscillation_of_zero
#check exact_power_oscillation_of_not_RH
#print axioms exact_power_oscillation_of_not_RH

/-! ### The second-order constant `c₁ = 8/9 - γ/3` -/

#check hasDerivAt_mA
#print axioms hasDerivAt_mA
#check tendsto_H_second
#print axioms tendsto_H_second
#check not_eventually_upper_second_order
#print axioms not_eventually_upper_second_order
#check not_eventually_lower_second_order
#print axioms not_eventually_lower_second_order
#check second_order_two_sided
#print axioms second_order_two_sided
#check c₁_bounds
#print axioms c₁_bounds

/-! ### Continuation of the same-prime series and zeros on the line -/

#check Hext_eq_H
#print axioms Hext_eq_H
#check Hext_analyticAt_line
#print axioms Hext_analyticAt_line
#check Fext_pole
#print axioms Fext_pole
#check norm_coeff_le_of_upper
#print axioms norm_coeff_le_of_upper
#check norm_coeff_le_of_lower
#print axioms norm_coeff_le_of_lower
#check line_amplitude
#print axioms line_amplitude
#check multiplicity_bound_of_upper
#print axioms multiplicity_bound_of_upper
