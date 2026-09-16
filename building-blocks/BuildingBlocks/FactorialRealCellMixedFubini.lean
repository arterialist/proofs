import BuildingBlocks.FactorialRealCellDiscrepancyBounds
import BuildingBlocks.FactorialRealCellEnergySplit
import Mathlib.MeasureTheory.Integral.Prod

open Real Set MeasureTheory Filter
namespace BuildingBlocks.FactorialRealCellPhase

/-- Absolute integrability of the actual signed mixed row on its full space-clock domain. -/
theorem actual_mixed_product_integrable (N : ℕ) (hN : 0 < N) :
    Integrable (fun p : ℝ × ℝ => actualBaseline N p.2 * actualDiscrepancy N p.1 *
      (-inverseTestPhase p.1 p.2) * FactorialBinaryEnergy.weight p.2)
      ((volume.restrict (Ioc 1 (N : ℝ))).prod (volume.restrict (Ioi 0))) := by
  let H := inverseCoefficientBudget N
  let B := 1 + H * ((N : ℝ) - 1)
  let D := actualFloorBudget N + 1
  let A := B * D * H
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hH : 0 ≤ H := by unfold H inverseCoefficientBudget; exact Finset.sum_nonneg (fun _ _ => abs_nonneg _)
  have hB : 0 ≤ B := by dsimp [B]; nlinarith
  have hD : 0 ≤ D := by unfold D actualFloorBudget; positivity
  have hm : Measurable (fun p : ℝ × ℝ => actualBaseline N p.2 * actualDiscrepancy N p.1 *
      (-inverseTestPhase p.1 p.2) * FactorialBinaryEnergy.weight p.2) := by
    have hw : Measurable FactorialBinaryEnergy.weight := by unfold FactorialBinaryEnergy.weight; fun_prop
    exact ((((actualBaseline_measurable N).comp measurable_snd).mul
      ((actualDiscrepancy_measurable N).comp measurable_fst)).mul
      inverseTestPhase_joint_measurable.neg).mul (hw.comp measurable_snd)
  have hi := ((FactorialKernelDictionary.kernelRow_integrable 1 1).const_mul A).comp_snd
    (volume.restrict (Ioc 1 (N : ℝ)))
  apply hi.mono' hm.aestronglyMeasurable
  rw [Measure.prod_restrict]
  filter_upwards [ae_restrict_mem (measurableSet_Ioc.prod measurableSet_Ioi)] with p hp
  have hx : 1 ≤ p.1 := hp.1.1.le
  have ht : 0 < p.2 := hp.2
  have hu : 0 ≤ 1 - exp (-p.2) := sub_nonneg.mpr (exp_le_one_iff.mpr (by linarith))
  have hc := actualBaseline_norm_le_unit N ht hN
  change ‖actualBaseline N p.2‖ ≤ B * (1 - exp (-p.2)) at hc
  have hd := actualDiscrepancy_norm_le N hx
  change ‖actualDiscrepancy N p.1‖ ≤ D at hd
  have hf : ⌊p.1⌋₊ ≤ N := by simpa only [Nat.floor_natCast] using Nat.floor_mono hp.1.2
  have hphase : ‖inverseTestPhase p.1 p.2‖ ≤ H * (1 - exp (-p.2)) :=
    (inverseTestPhase_norm_le_unit ht hx).trans
      (mul_le_mul_of_nonneg_right (inverseCoefficientBudget_mono hf) hu)
  have hw := FactorialBinaryEnergy.weight_pos p.2 ht
  have hk : FactorialKernelDictionary.kernelRow 1 1 p.2 =
      (1 - exp (-p.2)) ^ 2 * FactorialBinaryEnergy.weight p.2 := by
    unfold FactorialKernelDictionary.kernelRow FactorialEntropyIntegral.numerator
    simp [pow_two]
  calc
    _ = ‖actualBaseline N p.2‖ * ‖actualDiscrepancy N p.1‖ * ‖inverseTestPhase p.1 p.2‖ *
        FactorialBinaryEnergy.weight p.2 := by simp only [norm_mul, norm_neg, Real.norm_eq_abs, abs_of_pos hw]
    _ ≤ (B * (1 - exp (-p.2))) * D * (H * (1 - exp (-p.2))) * FactorialBinaryEnergy.weight p.2 := by
      gcongr
    _ = A * FactorialKernelDictionary.kernelRow 1 1 p.2 := by rw [hk]; dsimp [A]; ring

/-- Spatial and positive-clock integration commute for the actual mixed row. -/
theorem actual_mixed_integral_swap (N : ℕ) (hN : 0 < N) :
    (∫ x in (1 : ℝ)..N, ∫ t in Ioi 0, actualBaseline N t * actualDiscrepancy N x *
      (-inverseTestPhase x t) * FactorialBinaryEnergy.weight t) =
      ∫ t in Ioi 0, ∫ x in (1 : ℝ)..N, actualBaseline N t * actualDiscrepancy N x *
        (-inverseTestPhase x t) * FactorialBinaryEnergy.weight t := by
  have hi := actual_mixed_product_integrable N hN
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  rw [← Set.uIoc_of_le hNr] at hi
  exact intervalIntegral_integral_swap hi

noncomputable def actualMixedKernel (N : ℕ) (x : ℝ) : ℝ :=
  ∫ t in Ioi 0, actualBaseline N t * (-inverseTestPhase x t) * FactorialBinaryEnergy.weight t

/-- The full signed mixed clock energy equals its spatial kernel pairing. -/
theorem actual_mixed_spatial_pairing (N : ℕ) (hN : 0 < N) :
    (∫ t in Ioi 0, actualBaseline N t * actualWork N t * FactorialBinaryEnergy.weight t) =
      ∫ x in (1 : ℝ)..N, actualDiscrepancy N x * actualMixedKernel N x := by
  have hl : ∀ x : ℝ, (∫ t in Ioi 0, actualBaseline N t * actualDiscrepancy N x *
      (-inverseTestPhase x t) * FactorialBinaryEnergy.weight t) = actualDiscrepancy N x * actualMixedKernel N x := by
    intro x
    unfold actualMixedKernel
    rw [← integral_const_mul]
    apply integral_congr_ae
    exact Eventually.of_forall (fun t => by ring)
  have hr : ∀ t : ℝ, (∫ x in (1 : ℝ)..N, actualBaseline N t * actualDiscrepancy N x *
      (-inverseTestPhase x t) * FactorialBinaryEnergy.weight t) =
      actualBaseline N t * actualWork N t * FactorialBinaryEnergy.weight t := by
    intro t
    calc
      _ = (actualBaseline N t * FactorialBinaryEnergy.weight t) *
          (∫ x in (1 : ℝ)..N, actualDiscrepancy N x * (-inverseTestPhase x t)) := by
        rw [← intervalIntegral.integral_const_mul]
        apply intervalIntegral.integral_congr
        intro x hx
        dsimp only
        ring
      _ = _ := by unfold actualWork; ring
  have hs := actual_mixed_integral_swap N hN
  simp_rw [hl, hr] at hs
  exact hs.symm

#print axioms actual_mixed_spatial_pairing
#print axioms actual_mixed_integral_swap
#print axioms actual_mixed_product_integrable
end BuildingBlocks.FactorialRealCellPhase
