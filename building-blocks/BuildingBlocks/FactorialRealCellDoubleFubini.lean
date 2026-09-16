import BuildingBlocks.FactorialRealCellMixedFubini
import BuildingBlocks.FactorialRealCellCrossKernel

open Real Set MeasureTheory Filter
namespace BuildingBlocks.FactorialRealCellPhase

/-- Absolute integrability of the actual signed double spatial row on its full space-clock domain. -/
theorem actual_double_product_integrable (N : ℕ) (hN : 0 < N) :
    Integrable (fun p : (ℝ × ℝ) × ℝ => actualDiscrepancy N p.1.1 * actualDiscrepancy N p.1.2 *
      inverseTestPhase p.1.1 p.2 * inverseTestPhase p.1.2 p.2 * FactorialBinaryEnergy.weight p.2)
      (((volume.restrict (Ioc 1 (N : ℝ))).prod (volume.restrict (Ioc 1 (N : ℝ)))).prod (volume.restrict (Ioi 0))) := by
  let H := inverseCoefficientBudget N
  let D := actualFloorBudget N + 1
  let A := D * D * H * H
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hH : 0 ≤ H := by unfold H inverseCoefficientBudget; exact Finset.sum_nonneg (fun _ _ => abs_nonneg _)
  have hD : 0 ≤ D := by unfold D actualFloorBudget; positivity
  have hm : Measurable (fun p : (ℝ × ℝ) × ℝ => actualDiscrepancy N p.1.1 * actualDiscrepancy N p.1.2 *
      inverseTestPhase p.1.1 p.2 * inverseTestPhase p.1.2 p.2 * FactorialBinaryEnergy.weight p.2) := by
    have hw : Measurable FactorialBinaryEnergy.weight := by unfold FactorialBinaryEnergy.weight; fun_prop
    have h1 : Measurable (fun p : (ℝ × ℝ) × ℝ => p.1.1) := measurable_fst.comp measurable_fst
    have h2 : Measurable (fun p : (ℝ × ℝ) × ℝ => p.1.2) := measurable_snd.comp measurable_fst
    exact (((((actualDiscrepancy_measurable N).comp h1).mul
      ((actualDiscrepancy_measurable N).comp h2)).mul
      (inverseTestPhase_joint_measurable.comp (h1.prodMk measurable_snd))).mul
      (inverseTestPhase_joint_measurable.comp (h2.prodMk measurable_snd))).mul (hw.comp measurable_snd)
  have hi := ((FactorialKernelDictionary.kernelRow_integrable 1 1).const_mul A).comp_snd
    ((volume.restrict (Ioc 1 (N : ℝ))).prod (volume.restrict (Ioc 1 (N : ℝ))))
  apply hi.mono' hm.aestronglyMeasurable
  rw [Measure.prod_restrict, Measure.prod_restrict]
  filter_upwards [ae_restrict_mem ((measurableSet_Ioc.prod measurableSet_Ioc).prod measurableSet_Ioi)] with p hp
  have hx : 1 ≤ p.1.1 := hp.1.1.1.le
  have hy : 1 ≤ p.1.2 := hp.1.2.1.le
  have ht : 0 < p.2 := hp.2
  have hu : 0 ≤ 1 - exp (-p.2) := sub_nonneg.mpr (exp_le_one_iff.mpr (by linarith))
  have hd := actualDiscrepancy_norm_le N hx
  have he := actualDiscrepancy_norm_le N hy
  change ‖actualDiscrepancy N p.1.1‖ ≤ D at hd
  change ‖actualDiscrepancy N p.1.2‖ ≤ D at he
  have hf : ⌊p.1.1⌋₊ ≤ N := by simpa only [Nat.floor_natCast] using Nat.floor_mono hp.1.1.2
  have hg : ⌊p.1.2⌋₊ ≤ N := by simpa only [Nat.floor_natCast] using Nat.floor_mono hp.1.2.2
  have hphase : ‖inverseTestPhase p.1.1 p.2‖ ≤ H * (1 - exp (-p.2)) :=
    (inverseTestPhase_norm_le_unit ht hx).trans
      (mul_le_mul_of_nonneg_right (inverseCoefficientBudget_mono hf) hu)
  have hphase2 : ‖inverseTestPhase p.1.2 p.2‖ ≤ H * (1 - exp (-p.2)) :=
    (inverseTestPhase_norm_le_unit ht hy).trans
      (mul_le_mul_of_nonneg_right (inverseCoefficientBudget_mono hg) hu)
  have hw := FactorialBinaryEnergy.weight_pos p.2 ht
  have hk : FactorialKernelDictionary.kernelRow 1 1 p.2 =
      (1 - exp (-p.2)) ^ 2 * FactorialBinaryEnergy.weight p.2 := by
    unfold FactorialKernelDictionary.kernelRow FactorialEntropyIntegral.numerator
    simp [pow_two]
  calc
    _ = ‖actualDiscrepancy N p.1.1‖ * ‖actualDiscrepancy N p.1.2‖ *
        ‖inverseTestPhase p.1.1 p.2‖ * ‖inverseTestPhase p.1.2 p.2‖ *
        FactorialBinaryEnergy.weight p.2 := by simp only [norm_mul, Real.norm_eq_abs, abs_of_pos hw]
    _ ≤ D * D * (H * (1 - exp (-p.2))) * (H * (1 - exp (-p.2))) * FactorialBinaryEnergy.weight p.2 := by
      gcongr
    _ = A * FactorialKernelDictionary.kernelRow 1 1 p.2 := by rw [hk]; dsimp [A]; ring

/-- The complete double spatial row admits the full positive-clock Fubini exchange. -/
theorem actual_double_integral_swap (N : ℕ) (hN : 0 < N) :
    (∫ p : ℝ × ℝ, (∫ t in Ioi 0, actualDiscrepancy N p.1 * actualDiscrepancy N p.2 *
      inverseTestPhase p.1 t * inverseTestPhase p.2 t * FactorialBinaryEnergy.weight t)
      ∂((volume.restrict (Ioc 1 (N : ℝ))).prod (volume.restrict (Ioc 1 (N : ℝ))))) =
    ∫ t in Ioi 0, ∫ p : ℝ × ℝ, actualDiscrepancy N p.1 * actualDiscrepancy N p.2 *
      inverseTestPhase p.1 t * inverseTestPhase p.2 t * FactorialBinaryEnergy.weight t
      ∂((volume.restrict (Ioc 1 (N : ℝ))).prod (volume.restrict (Ioc 1 (N : ℝ)))) := by
  exact integral_integral_swap (f := fun (p : ℝ × ℝ) (t : ℝ) =>
    actualDiscrepancy N p.1 * actualDiscrepancy N p.2 * inverseTestPhase p.1 t *
      inverseTestPhase p.2 t * FactorialBinaryEnergy.weight t) (actual_double_product_integrable N hN)

#print axioms actual_double_integral_swap
#print axioms actual_double_product_integrable
end BuildingBlocks.FactorialRealCellPhase
