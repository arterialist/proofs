import BuildingBlocks.SuccessorFeedbackRootTranslation

/-! The mass-one derivative of the smooth power weight and its cancellation
against the complete causal root kernel, across the parameter value z = 1. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

noncomputable def smoothPowerCharge (z : ℂ) (t : ℝ) : ℂ :=
  z * ((t + 1 : ℝ) : ℂ) ^ (-z - 1)

theorem smoothPowerCharge_measurable (z : ℂ) : Measurable (smoothPowerCharge z) := by
  unfold smoothPowerCharge
  fun_prop

theorem smoothPowerCharge_norm (z : ℂ) {t : ℝ} (ht : 0 ≤ t) :
    ‖smoothPowerCharge z t‖ = ‖z‖ * (t + 1) ^ (-z.re - 1) := by
  rw [smoothPowerCharge, norm_mul, Complex.norm_cpow_eq_rpow_re_of_pos (by linarith)]
  simp

theorem smoothPowerCharge_integrable {z : ℂ} (hz : 0 < z.re) :
    IntegrableOn (smoothPowerCharge z) (Ioi (0 : ℝ)) := by
  apply ((integrableOn_add_rpow_Ioi_of_lt (by linarith : -z.re - 1 < -1)
    (by norm_num : -(1 : ℝ) < 0)).const_mul ‖z‖).mono'
    (smoothPowerCharge_measurable z).aestronglyMeasurable
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  exact (smoothPowerCharge_norm z ht.le).le

theorem smoothPowerCharge_integral {z : ℂ} (hz : 0 < z.re) :
    (∫ t in Ioi (0 : ℝ), smoothPowerCharge z t) = 1 := by
  have hz0 : z ≠ 0 := by intro h; simp [h] at hz
  have hd : ∀ t ∈ Ici (0 : ℝ), HasDerivAt (fun t : ℝ => -((t + 1 : ℝ) : ℂ) ^ (-z))
      (smoothPowerCharge z t) t := by
    intro t ht
    have h' := (hasDerivAt_ofReal_cpow_const
      (show t + 1 ≠ 0 by linarith [ht.out]) (neg_ne_zero.mpr hz0)).scomp
      t ((hasDerivAt_id t).add_const 1)
    convert h'.neg using 1 <;> simp [smoothPowerCharge, mul_assoc]
  have ht : Tendsto (fun t : ℝ => -((t + 1 : ℝ) : ℂ) ^ (-z)) atTop (𝓝 0) := by
    have hr : Tendsto (fun t : ℝ => (t + 1) ^ (-z.re)) atTop (𝓝 0) :=
      (tendsto_rpow_neg_atTop hz).comp (tendsto_atTop_add_const_right atTop 1 tendsto_id)
    apply squeeze_zero_norm' (a := fun t : ℝ => (t + 1) ^ (-z.re)) _ hr
    filter_upwards [eventually_ge_atTop (0 : ℝ)] with t ht
    rw [norm_neg, Complex.norm_cpow_eq_rpow_re_of_pos (by linarith), Complex.neg_re]
  have hi := integral_Ioi_of_hasDerivAt_of_tendsto' hd (smoothPowerCharge_integrable hz) ht
  simpa using hi

theorem causalRoot_abs_le_one (y : ℝ) : |causalRoot y| ≤ 1 := by
  by_cases hy : 1 < y
  · rw [causalRoot, if_pos hy, abs_of_nonneg (by positivity)]
    apply (div_le_one (sqrt_pos.mpr (by linarith))).mpr
    have h := sqrt_le_sqrt hy.le
    simpa using h
  · simp [causalRoot, hy]

noncomputable def smoothRootDerivative (z : ℂ) (y : ℝ) : ℂ :=
  (causalRoot y : ℂ) - ∫ t in Ioi (0 : ℝ), smoothPowerCharge z t * (causalRoot (y - t) : ℂ)

noncomputable def smoothRootDifference (z : ℂ) (t y : ℝ) : ℂ :=
  smoothPowerCharge z t * ((causalRoot y - causalRoot (y - t) : ℝ) : ℂ)

theorem smoothRootDifference_measurable (z : ℂ) :
    Measurable (fun p : ℝ × ℝ => smoothRootDifference z p.1 p.2) := by
  unfold smoothRootDifference
  exact ((smoothPowerCharge_measurable z).comp measurable_fst).mul
    (Complex.measurable_ofReal.comp ((causalRoot_measurable.comp measurable_snd).sub
      (causalRoot_measurable.comp (measurable_snd.sub measurable_fst))))

theorem smoothRootDerivative_eq_difference {z : ℂ} (hz : 0 < z.re) (y : ℝ) :
    smoothRootDerivative z y = ∫ t in Ioi (0 : ℝ), smoothRootDifference z t y := by
  have hq := smoothPowerCharge_integrable hz
  have hk : IntegrableOn (fun t : ℝ => smoothPowerCharge z t * (causalRoot (y - t) : ℂ))
      (Ioi (0 : ℝ)) := by
    have hm : Measurable (fun t : ℝ => (causalRoot (y - t) : ℂ)) :=
      Complex.measurable_ofReal.comp (causalRoot_measurable.comp (measurable_const.sub measurable_id))
    exact (hq.bdd_mul' hm.aestronglyMeasurable
      (Eventually.of_forall (fun t => by
        simpa only [Complex.norm_real, Real.norm_eq_abs] using causalRoot_abs_le_one (y - t)))).congr
      (Eventually.of_forall (fun t => mul_comm _ _))
  simp only [smoothRootDifference, Complex.ofReal_sub, mul_sub]
  rw [integral_sub (hq.mul_const _) hk, integral_mul_const, smoothPowerCharge_integral hz, one_mul]
  rfl

theorem smoothRootDifference_integral_norm {t : ℝ} (ht : 0 ≤ t) (z : ℂ) :
    (∫ y : ℝ, ‖smoothRootDifference z t y‖) =
      ‖smoothPowerCharge z t‖ * (4 * (sqrt (t + 1) - 1)) := by
  simp only [smoothRootDifference, norm_mul, Complex.norm_real, Real.norm_eq_abs]
  rw [integral_const_mul, causalRoot_translation_norm ht]

theorem smoothRootDifference_integrable {z : ℂ} (hz : 1 / 2 < z.re) :
    Integrable (fun p : ℝ × ℝ => smoothRootDifference z p.1 p.2)
      ((volume.restrict (Ioi (0 : ℝ))).prod volume) := by
  apply (integrable_prod_iff (smoothRootDifference_measurable z).aestronglyMeasurable).mpr
  constructor
  · filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
    exact (causalRoot_translation_integrable ht.le).ofReal.const_mul _
  · have hi := (integrableOn_add_rpow_Ioi_of_lt
      (by linarith : -z.re - 1 / 2 < -1) (by norm_num : -(1 : ℝ) < 0)).const_mul (4 * ‖z‖)
    apply hi.mono' (smoothRootDifference_measurable z).stronglyMeasurable.norm.integral_prod_right'.aestronglyMeasurable
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
    rw [Real.norm_eq_abs, abs_of_nonneg (integral_nonneg (fun _ => norm_nonneg _)),
      smoothRootDifference_integral_norm ht.le, smoothPowerCharge_norm z ht.le]
    calc
      _ ≤ (‖z‖ * (t + 1) ^ (-z.re - 1)) * (4 * sqrt (t + 1)) := by
        apply mul_le_mul_of_nonneg_left (by linarith)
          (mul_nonneg (norm_nonneg z) (rpow_nonneg (by have := ht; change 0 < t at this; linarith : 0 ≤ t + 1) _))
      _ = _ := by
        rw [sqrt_eq_rpow]
        calc
          _ = (4 * ‖z‖) * ((t + 1) ^ (-z.re - 1) * (t + 1) ^ (1 / 2 : ℝ)) := by ring
          _ = _ := by rw [← rpow_add (by have := ht; change 0 < t at this; linarith : 0 < t + 1)]; congr 2; ring

theorem smoothRootDerivative_integrable {z : ℂ} (hz : 1 / 2 < z.re) :
    Integrable (smoothRootDerivative z) := by
  have hi := (smoothRootDifference_integrable hz).integral_prod_right
  exact hi.congr (Eventually.of_forall (fun y => (smoothRootDerivative_eq_difference (by linarith) y).symm))

/-- The full cancellation has zero total mass, although neither root term
has a separately convergent whole-line integral. -/
theorem smoothRootDerivative_integral {z : ℂ} (hz : 1 / 2 < z.re) :
    (∫ y : ℝ, smoothRootDerivative z y) = 0 := by
  simp_rw [smoothRootDerivative_eq_difference (show 0 < z.re by linarith)]
  have hi : Integrable (fun p : ℝ × ℝ => smoothRootDifference z p.2 p.1)
      (volume.prod (volume.restrict (Ioi (0 : ℝ)))) := (smoothRootDifference_integrable hz).swap
  rw [integral_integral_swap hi]
  have he : (∫ t in Ioi (0 : ℝ), ∫ y : ℝ, smoothRootDifference z t y) =
      ∫ t in Ioi (0 : ℝ), (0 : ℂ) := by
    apply integral_congr_ae
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
    simp only [smoothRootDifference]
    rw [integral_const_mul, integral_complex_ofReal,
      causalRoot_translation_integral ht.le, Complex.ofReal_zero, mul_zero]
  rw [he, integral_zero]

theorem actual_smoothRootDerivative_pairing_integrable {z : ℂ} (hz : 1 / 2 < z.re) :
    Integrable (fun y : ℝ => (physicalError y : ℂ) * smoothRootDerivative z y) := by
  apply (smoothRootDerivative_integrable hz).bdd_mul'
    (Complex.measurable_ofReal.comp measurable_physicalError).aestronglyMeasurable
    (c := 4 * log 2 + 1)
  filter_upwards with y
  simpa only [Function.comp_apply, Complex.norm_real, Real.norm_eq_abs] using
    physicalError_abs_le_global y

end BuildingBlocks.SuccessorFeedback
