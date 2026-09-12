import BuildingBlocks.SuccessorFeedbackAbelLaplace
import Mathlib.Analysis.Calculus.ParametricIntegral

/-! The literal floor-defined Abel kernel. The upper endpoint is `y-1`,
so the real square-root factor is bounded on the complete integration cell. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

noncomputable def floorAbelIntegrand (z : ℂ) (y t : ℝ) : ℂ :=
  floorWeight z t * ((y - t) ^ (-(1 / 2 : ℝ)) : ℝ)

noncomputable def floorAbelKernel (z : ℂ) (y : ℝ) : ℂ :=
  ∫ t in Icc (0 : ℝ) (y - 1), floorAbelIntegrand z y t

theorem floorWeight_norm_le_one {z : ℂ} (hz : 0 ≤ z.re) (t : ℝ) :
    ‖floorWeight z t‖ ≤ 1 := by
  have hn : (1 : ℝ) ≤ ⌊t⌋₊ + 1 := by have := Nat.cast_nonneg (α := ℝ) ⌊t⌋₊; linarith
  have he : ((⌊t⌋₊ + 1 : ℕ) : ℂ) = ((⌊t⌋₊ + 1 : ℝ) : ℂ) := by push_cast; rfl
  rw [floorWeight, he, Complex.norm_cpow_eq_rpow_re_of_pos (by positivity)]
  simpa only [Complex.neg_re] using Real.rpow_le_one_of_one_le_of_nonpos hn (neg_nonpos.mpr hz)

theorem floorAbelIntegrand_measurable (z : ℂ) (y : ℝ) :
    Measurable (floorAbelIntegrand z y) :=
  (measurable_floorWeight z).mul (by fun_prop)

theorem floorAbelIntegrand_norm_le_one {z : ℂ} (hz : 0 ≤ z.re) {y t : ℝ}
    (ht : t ∈ Icc (0 : ℝ) (y - 1)) : ‖floorAbelIntegrand z y t‖ ≤ 1 := by
  have hd : 1 ≤ y - t := by linarith [ht.2]
  rw [floorAbelIntegrand, norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (Real.rpow_nonneg (by linarith : 0 ≤ y - t) _)]
  exact mul_le_one₀ (floorWeight_norm_le_one hz t) (by positivity)
    (Real.rpow_le_one_of_one_le_of_nonpos hd (by norm_num))

theorem floorAbelIntegrand_integrable {z : ℂ} (hz : 0 ≤ z.re) (y : ℝ) :
    IntegrableOn (floorAbelIntegrand z y) (Icc 0 (y - 1)) := by
  apply (integrableOn_const (by simp : volume (Icc (0 : ℝ) (y - 1)) ≠ ⊤)
    (C := (1 : ℝ))).mono' (floorAbelIntegrand_measurable z y).aestronglyMeasurable
  filter_upwards [ae_restrict_mem measurableSet_Icc] with t ht
  exact floorAbelIntegrand_norm_le_one hz ht

theorem floorAbelKernel_initial (z : ℂ) : floorAbelKernel z 1 = 0 := by
  simp [floorAbelKernel]

noncomputable def floorAbelParameterDerivative (z : ℂ) (y t : ℝ) : ℂ :=
  -(log (⌊t⌋₊ + 1 : ℝ) : ℂ) * floorAbelIntegrand z y t

theorem floorAbelIntegrand_hasDerivAt (z : ℂ) (y t : ℝ) :
    HasDerivAt (fun w => floorAbelIntegrand w y t)
      (floorAbelParameterDerivative z y t) z := by
  have hn : (0 : ℝ) < ⌊t⌋₊ + 1 := by positivity
  have h := ((hasDerivAt_id z).neg.const_cpow
    (c := ((⌊t⌋₊ + 1 : ℕ) : ℂ))
    (Or.inl (by exact_mod_cast (Nat.succ_ne_zero ⌊t⌋₊)))).mul_const
      (((y - t) ^ (-(1 / 2 : ℝ)) : ℝ) : ℂ)
  convert h using 1
  simp only [floorAbelParameterDerivative, floorAbelIntegrand, floorWeight, Pi.neg_apply, id_eq]
  rw [show ((⌊t⌋₊ + 1 : ℕ) : ℂ) = ((⌊t⌋₊ + 1 : ℝ) : ℂ) by push_cast; rfl,
    ← Complex.ofReal_log hn.le]
  ring

theorem floorAbelParameterDerivative_measurable (z : ℂ) (y : ℝ) :
    Measurable (floorAbelParameterDerivative z y) := by
  exact (by fun_prop : Measurable (fun t : ℝ => -(log (⌊t⌋₊ + 1 : ℝ) : ℂ))).mul
    (floorAbelIntegrand_measurable z y)

theorem floorAbelParameterDerivative_bound {z : ℂ} (hz : 0 ≤ z.re) {y t : ℝ}
    (ht : t ∈ Icc (0 : ℝ) (y - 1)) :
    ‖floorAbelParameterDerivative z y t‖ ≤ log y := by
  have hn : (1 : ℝ) ≤ ⌊t⌋₊ + 1 := by have := Nat.cast_nonneg (α := ℝ) ⌊t⌋₊; linarith
  have hny : (⌊t⌋₊ : ℝ) + 1 ≤ y := by linarith [Nat.floor_le ht.1, ht.2]
  rw [floorAbelParameterDerivative, norm_mul, norm_neg, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (log_nonneg hn)]
  exact (mul_le_of_le_one_right (log_nonneg hn)
    (floorAbelIntegrand_norm_le_one hz ht)).trans
    (log_le_log (by positivity) hny)

theorem floorAbelKernel_differentiableAt {z : ℂ} (hz : 0 < z.re) (y : ℝ) :
    DifferentiableAt ℂ (fun w => floorAbelKernel w y) z := by
  have h := hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (F := fun w t => floorAbelIntegrand w y t)
    (F' := fun w t => floorAbelParameterDerivative w y t)
    (μ := volume.restrict (Icc (0 : ℝ) (y - 1)))
    (bound := fun _ : ℝ => log y)
    (show 0 < z.re / 2 by linarith)
    (Eventually.of_forall (fun w => (floorAbelIntegrand_measurable w y).aestronglyMeasurable))
    (floorAbelIntegrand_integrable hz.le y)
    (floorAbelParameterDerivative_measurable z y).aestronglyMeasurable
    ?_ (integrableOn_const (by simp : volume (Icc (0 : ℝ) (y - 1)) ≠ ⊤))
    (Eventually.of_forall (fun t w _ => floorAbelIntegrand_hasDerivAt w y t))
  · exact h.2.differentiableAt
  · filter_upwards [ae_restrict_mem measurableSet_Icc] with t ht w hw
    have hdist : ‖z - w‖ < z.re / 2 := by
      simpa only [Metric.mem_ball, dist_eq_norm, norm_sub_rev] using hw
    have hr := Complex.re_le_norm (z - w)
    simp only [Complex.sub_re] at hr
    exact floorAbelParameterDerivative_bound (by linarith) ht

theorem floorAbelKernel_analyticOnNhd (y : ℝ) :
    AnalyticOnNhd ℂ (fun z => floorAbelKernel z y) {z : ℂ | 0 < z.re} := by
  apply DifferentiableOn.analyticOnNhd _ (isOpen_lt continuous_const Complex.continuous_re)
  exact fun z hz => (floorAbelKernel_differentiableAt hz y).differentiableWithinAt

theorem floorAbelKernel_eq_intervalIntegral {y : ℝ} (hy : 1 ≤ y) (z : ℂ) :
    floorAbelKernel z y = ∫ t in (0 : ℝ)..(y - 1),
      floorWeight z t * ((y - t) ^ (-(1 / 2 : ℝ)) : ℝ) := by
  rw [floorAbelKernel, integral_Icc_eq_integral_Ioc,
    intervalIntegral.integral_of_le (by linarith : (0 : ℝ) ≤ y - 1)]
  rfl

noncomputable def smoothAbelIntegrand (z : ℂ) (y t : ℝ) : ℂ :=
  ((t + 1 : ℝ) : ℂ) ^ (-z) * ((y - t) ^ (-(1 / 2 : ℝ)) : ℝ)

noncomputable def smoothAbelKernel (z : ℂ) (y : ℝ) : ℂ :=
  ∫ t in Icc (0 : ℝ) (y - 1), smoothAbelIntegrand z y t

theorem smoothAbelIntegrand_integrable {z : ℂ} (hz : 0 ≤ z.re) (y : ℝ) :
    IntegrableOn (smoothAbelIntegrand z y) (Icc 0 (y - 1)) := by
  apply (integrableOn_const (by simp : volume (Icc (0 : ℝ) (y - 1)) ≠ ⊤)
    (C := (1 : ℝ))).mono' (by unfold smoothAbelIntegrand; fun_prop)
  filter_upwards [ae_restrict_mem measurableSet_Icc] with t ht
  have ht1 : 1 ≤ t + 1 := by linarith [ht.1]
  have hd : 1 ≤ y - t := by linarith [ht.2]
  rw [smoothAbelIntegrand, norm_mul, Complex.norm_cpow_eq_rpow_re_of_pos (by linarith),
    Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (Real.rpow_nonneg (by linarith : 0 ≤ y - t) _)]
  exact mul_le_one₀ (Real.rpow_le_one_of_one_le_of_nonpos ht1 (by simpa)) (by positivity)
    (Real.rpow_le_one_of_one_le_of_nonpos hd (by norm_num))

theorem floorAbelError_integrable {z : ℂ} (hz : 0 ≤ z.re) (y : ℝ) :
    IntegrableOn (fun t : ℝ => floorWeightError z t *
      ((y - t) ^ (-(1 / 2 : ℝ)) : ℝ)) (Icc 0 (y - 1)) := by
  have h := (floorAbelIntegrand_integrable hz y).sub (smoothAbelIntegrand_integrable hz y)
  apply h.congr
  filter_upwards with t
  simp [floorWeightError, floorAbelIntegrand, smoothAbelIntegrand, sub_mul]

/-- Exact comparison with the continuous power kernel, before any asymptotic
estimate or integration against the arithmetic error. -/
theorem floorAbelKernel_sub_smooth {z : ℂ} (hz : 0 ≤ z.re) (y : ℝ) :
    floorAbelKernel z y - smoothAbelKernel z y =
      ∫ t in Icc (0 : ℝ) (y - 1), floorWeightError z t *
        ((y - t) ^ (-(1 / 2 : ℝ)) : ℝ) := by
  rw [floorAbelKernel, smoothAbelKernel,
    ← integral_sub (floorAbelIntegrand_integrable hz y) (smoothAbelIntegrand_integrable hz y)]
  apply integral_congr_ae
  filter_upwards with t
  simp [floorWeightError, floorAbelIntegrand, smoothAbelIntegrand, sub_mul]

end BuildingBlocks.SuccessorFeedback
