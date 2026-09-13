import BuildingBlocks.SuccessorFeedbackClippedKernel

/-! Age differentiation of the literal floor-kernel error. The moving
endpoint contributes its full value; no distributional endpoint is dropped. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

theorem floorWeightError_continuousAt {t : ℝ} (ht : 0 ≤ t)
    (hnt : ∀ n : ℕ, t ≠ n) (z : ℂ) : ContinuousAt (floorWeightError z) t := by
  have hlo : (⌊t⌋₊ : ℝ) < t := lt_of_le_of_ne (Nat.floor_le ht) (hnt _).symm
  have hup := Nat.lt_floor_add_one t
  have he : (fun u : ℝ => floorWeight z u) =ᶠ[𝓝 t] (fun _ => floorWeight z t) := by
    filter_upwards [eventually_gt_nhds hlo, eventually_lt_nhds hup] with u hu hv
    have hu0 : 0 ≤ u := (Nat.cast_nonneg _).trans hu.le
    have hf : ⌊u⌋₊ = ⌊t⌋₊ := (Nat.floor_eq_iff hu0).mpr ⟨hu.le, hv⟩
    simp [floorWeight, hf]
  have hc : ContinuousAt (floorWeight z) t := continuousAt_const.congr_of_eventuallyEq he
  have hp : ContinuousAt (fun u : ℝ => ((u + 1 : ℝ) : ℂ) ^ (-z)) t :=
    (Complex.continuousAt_ofReal_cpow_const (t + 1) (-z)
      (Or.inr (by linarith : t + 1 ≠ 0))).comp
        (f := fun u : ℝ => u + 1) (x := t) (continuous_id.add continuous_const).continuousAt
  exact hc.sub hp

noncomputable def floorErrorPrimitive (z : ℂ) (y : ℝ) : ℂ :=
  ∫ t in (0 : ℝ)..(y - 1), floorWeightError z t

theorem floorError_intervalIntegrable {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 ≤ y) :
    IntervalIntegrable (floorWeightError z) volume 0 (y - 1) := by
  apply (intervalIntegrable_iff_integrableOn_Ioc_of_le (by linarith : (0 : ℝ) ≤ y - 1)).mpr
  exact (floorWeightError_integrable hz).mono_set Ioc_subset_Ioi_self

theorem floorAbelError_eq_primitive_add_clipped {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 ≤ y) :
    floorAbelKernel z y - smoothAbelKernel z y =
      floorErrorPrimitive z y + clippedConvolution (floorWeightError z) y := by
  have hf : IntegrableOn (floorWeightError z) (Ioc (0 : ℝ) (y - 1)) :=
    (floorWeightError_integrable hz).mono_set Ioc_subset_Ioi_self
  have hk : IntegrableOn (fun t : ℝ => floorWeightError z t *
      ((y - t) ^ (-(1 / 2 : ℝ)) : ℝ)) (Ioc 0 (y - 1)) :=
    (floorAbelError_integrable hz.le y).mono_set Ioc_subset_Icc_self
  rw [floorAbelKernel_sub_smooth hz.le, floorErrorPrimitive,
    intervalIntegral.integral_of_le (by linarith : (0 : ℝ) ≤ y - 1),
    clippedConvolution_eq_finite, integral_Icc_eq_integral_Ioc]
  have he : (fun t : ℝ => floorWeightError z t *
      (((y - t) ^ (-(1 / 2 : ℝ)) - 1 : ℝ) : ℂ)) =
      (fun t : ℝ => floorWeightError z t *
        ((y - t) ^ (-(1 / 2 : ℝ)) : ℝ) - floorWeightError z t) := by
    funext t
    push_cast
    ring
  rw [he, integral_sub hk hf]
  ring

theorem floorErrorPrimitive_hasDerivAt {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 < y)
    (hyn : ∀ n : ℕ, y - 1 ≠ n) :
    HasDerivAt (floorErrorPrimitive z) (floorWeightError z (y - 1)) y := by
  have h := intervalIntegral.integral_hasDerivAt_right (floorError_intervalIntegrable hz hy.le)
    (measurable_floorWeightError z).aestronglyMeasurable.stronglyMeasurableAtFilter
    (floorWeightError_continuousAt (by linarith) hyn z)
  simpa only [floorErrorPrimitive] using h.comp_sub_const y 1

/-- The literal endpoint and complete integral correction, away from the
integer corners of the floor kernel. -/
theorem floorAbelError_hasDerivAt {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 < y)
    (hyn : ∀ n : ℕ, y - 1 ≠ n) :
    HasDerivAt (fun u => floorAbelKernel z u - smoothAbelKernel z u)
      (floorWeightError z (y - 1) - (1 / 2 : ℂ) *
        ∫ t in Ioo (0 : ℝ) (y - 1), floorWeightError z t *
          ((y - t) ^ (-(3 / 2 : ℝ)) : ℝ)) y := by
  have h := (floorErrorPrimitive_hasDerivAt hz hy hyn).add
    (floorError_clippedConvolution_hasDerivAt hz y)
  rw [clippedConvolution_derivative_eq_finite] at h
  have he : floorWeightError z (y - 1) +
      (-(1 / 2 : ℂ) * ∫ t in Ioo (0 : ℝ) (y - 1), floorWeightError z t *
        ((y - t) ^ (-(3 / 2 : ℝ)) : ℝ)) =
      floorWeightError z (y - 1) - (1 / 2 : ℂ) *
        ∫ t in Ioo (0 : ℝ) (y - 1), floorWeightError z t *
          ((y - t) ^ (-(3 / 2 : ℝ)) : ℝ) := by ring
  rw [he] at h
  apply h.congr_of_eventuallyEq
  filter_upwards [eventually_gt_nhds hy] with u hu
  exact floorAbelError_eq_primitive_add_clipped hz hu.le

theorem floorAbelError_hasDerivAt_ae {z : ℂ} (hz : 0 < z.re) :
    ∀ᵐ y : ℝ ∂volume.restrict (Ioi 1),
      HasDerivAt (fun u => floorAbelKernel z u - smoothAbelKernel z u)
        (floorWeightError z (y - 1) - (1 / 2 : ℂ) *
          ∫ t in Ioo (0 : ℝ) (y - 1), floorWeightError z t *
            ((y - t) ^ (-(3 / 2 : ℝ)) : ℝ)) y := by
  have hn : ∀ᵐ y : ℝ, ∀ n : ℕ, y - 1 ≠ n := by
    rw [ae_all_iff]
    intro n
    have hne : ∀ᵐ y : ℝ, y ≠ (n : ℝ) + 1 := by rw [ae_iff]; simp
    filter_upwards [hne] with y hy
    intro he
    apply hy
    linarith
  filter_upwards [ae_restrict_of_ae hn, ae_restrict_mem measurableSet_Ioi] with y hyn hy
  exact floorAbelError_hasDerivAt hz hy hyn

end BuildingBlocks.SuccessorFeedback
