import BuildingBlocks.SuccessorFeedbackFloorHolomorphic
import Mathlib.MeasureTheory.Integral.DominatedConvergence

/-! Both age endpoints of the literal floor-kernel error. Integrability of the
floor discrepancy is enough for the infinite endpoint; no age-rate premise is used. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

noncomputable def floorBoundaryIntegrand (z : ℂ) (y : ℝ) : ℝ → ℂ :=
  (Iic (y - 1)).indicator (fun t => floorWeightError z t *
    ((y - t) ^ (-(1 / 2 : ℝ)) : ℝ))

theorem floorBoundaryIntegrand_measurable (z : ℂ) (y : ℝ) :
    Measurable (floorBoundaryIntegrand z y) := by
  exact ((measurable_floorWeightError z).mul (by fun_prop)).indicator measurableSet_Iic

theorem floorBoundaryIntegrand_bound (z : ℂ) (y t : ℝ) :
    ‖floorBoundaryIntegrand z y t‖ ≤ ‖floorWeightError z t‖ := by
  by_cases ht : t ≤ y - 1
  · rw [floorBoundaryIntegrand, indicator_of_mem (show t ∈ Iic (y - 1) from ht),
      norm_mul, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg (rpow_nonneg (by linarith : 0 ≤ y - t) _)]
    exact mul_le_of_le_one_right (norm_nonneg _)
      (rpow_le_one_of_one_le_of_nonpos (by linarith) (by norm_num))
  · simp [floorBoundaryIntegrand, ht]

theorem floorBoundaryIntegrand_tendsto (z : ℂ) (t : ℝ) :
    Tendsto (fun y => floorBoundaryIntegrand z y t) atTop (𝓝 0) := by
  have hr : Tendsto (fun y : ℝ => (y - t) ^ (-(1 / 2 : ℝ))) atTop (𝓝 0) :=
    (tendsto_rpow_neg_atTop (by norm_num : (0 : ℝ) < 1 / 2)).comp
      (by simpa [sub_eq_add_neg] using tendsto_atTop_add_const_right atTop (-t) tendsto_id)
  have hc := (Complex.continuous_ofReal.tendsto 0).comp hr
  have h := hc.const_mul (floorWeightError z t)
  simp only [Complex.ofReal_zero, mul_zero] at h
  apply h.congr'
  filter_upwards [eventually_ge_atTop (t + 1)] with y hy
  change floorWeightError z t * ((y - t) ^ (-(1 / 2 : ℝ)) : ℝ) = _
  rw [floorBoundaryIntegrand, indicator_of_mem (show t ∈ Iic (y - 1) from by change t ≤ y - 1; linarith)]

theorem floorAbelError_eq_boundaryIntegral {z : ℂ} (hz : 0 ≤ z.re) (y : ℝ) :
    floorAbelKernel z y - smoothAbelKernel z y =
      ∫ t in Ioi (0 : ℝ), floorBoundaryIntegrand z y t := by
  rw [floorAbelKernel_sub_smooth hz, floorBoundaryIntegrand,
    setIntegral_indicator measurableSet_Iic,
    show Ioi (0 : ℝ) ∩ Iic (y - 1) = Ioc 0 (y - 1) by ext t; simp,
    integral_Icc_eq_integral_Ioc]

/-- The exact discretization error vanishes at infinite age. -/
theorem floorAbelError_tendsto_zero {z : ℂ} (hz : 0 < z.re) :
    Tendsto (fun y : ℝ => floorAbelKernel z y - smoothAbelKernel z y) atTop (𝓝 0) := by
  have h := tendsto_integral_filter_of_dominated_convergence
    (μ := volume.restrict (Ioi (0 : ℝ)))
    (F := floorBoundaryIntegrand z) (f := fun _ : ℝ => (0 : ℂ))
    (fun t => ‖floorWeightError z t‖)
    (Eventually.of_forall (fun y => (floorBoundaryIntegrand_measurable z y).aestronglyMeasurable))
    (Eventually.of_forall (fun y => Eventually.of_forall (floorBoundaryIntegrand_bound z y)))
    (floorWeightError_integrable hz).norm
    (Eventually.of_forall (floorBoundaryIntegrand_tendsto z))
  simpa only [integral_zero, ← floorAbelError_eq_boundaryIntegral hz.le] using h

theorem floorAbelError_initial (z : ℂ) :
    floorAbelKernel z 1 - smoothAbelKernel z 1 = 0 := by
  simp [floorAbelKernel, smoothAbelKernel]

/-- The arithmetic source is bounded, so its product with this boundary
also vanishes. This does not assume that the source itself has a limit. -/
theorem physicalError_floorAbelError_tendsto_zero {z : ℂ} (hz : 0 < z.re) :
    Tendsto (fun y : ℝ => (physicalError y : ℂ) *
      (floorAbelKernel z y - smoothAbelKernel z y)) atTop (𝓝 0) := by
  apply squeeze_zero_norm
    (a := fun y : ℝ => (4 * log 2 + 1) * ‖floorAbelKernel z y - smoothAbelKernel z y‖)
  · intro y
    rw [norm_mul, Complex.norm_real, Real.norm_eq_abs]
    exact mul_le_mul_of_nonneg_right (physicalError_abs_le_global y) (norm_nonneg _)
  · simpa only [norm_zero, mul_zero] using (floorAbelError_tendsto_zero hz).norm.const_mul
      (4 * log 2 + 1)

end BuildingBlocks.SuccessorFeedback
