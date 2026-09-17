import BuildingBlocks.SuccessorFeedbackSmoothCancellation

/-! The causal primitive of the root kernel and its differentiable convolution.
The age-one corner is retained and excluded only on its null translated slice. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

noncomputable def causalRootPrimitive (x : ℝ) : ℝ := 2 * (sqrt (max 1 x) - 1)

theorem causalRootPrimitive_eq_zero {x : ℝ} (hx : x ≤ 1) : causalRootPrimitive x = 0 := by
  simp [causalRootPrimitive, max_eq_left hx]

theorem causalRootPrimitive_eq {x : ℝ} (hx : 1 ≤ x) :
    causalRootPrimitive x = 2 * (sqrt x - 1) := by rw [causalRootPrimitive, max_eq_right hx]

private theorem rootPrimitive_smooth_derivative {x : ℝ} (hx : 0 < x) :
    HasDerivAt (fun y : ℝ => 2 * (sqrt y - 1)) (1 / sqrt x) x := by
  convert ((hasDerivAt_sqrt hx.ne').sub_const 1).const_mul 2 using 1
  field_simp

private theorem rootPrimitive_smooth_lipschitz :
    LipschitzOnWith 1 (fun x : ℝ => 2 * (sqrt x - 1)) (Ici 1) := by
  apply (convex_Ici (1 : ℝ)).lipschitzOnWith_of_nnnorm_hasDerivWithin_le
    (fun x hx => (rootPrimitive_smooth_derivative (by linarith [show 1 ≤ x from hx])).hasDerivWithinAt)
  intro x hx
  rw [← NNReal.coe_le_coe]
  simp only [coe_nnnorm, NNReal.coe_one, Real.norm_eq_abs,
    abs_of_nonneg (one_div_nonneg.mpr (sqrt_nonneg x))]
  apply (div_le_one (sqrt_pos.mpr (by linarith [show 1 ≤ x from hx]))).mpr
  simpa using sqrt_le_sqrt (show 1 ≤ x from hx)

theorem causalRootPrimitive_lipschitz : LipschitzWith 1 causalRootPrimitive := by
  apply LipschitzWith.of_dist_le_mul
  intro x y
  exact (rootPrimitive_smooth_lipschitz.dist_le_mul _
    (show max 1 x ∈ Ici (1 : ℝ) from le_max_left 1 x) _
    (show max 1 y ∈ Ici (1 : ℝ) from le_max_left 1 y)).trans
    (by simpa using (LipschitzWith.id.const_max (1 : ℝ)).dist_le_mul x y)

theorem causalRootPrimitive_hasDerivAt {x : ℝ} (hx : x ≠ 1) :
    HasDerivAt causalRootPrimitive (causalRoot x) x := by
  rcases lt_or_gt_of_ne hx with hlt | hgt
  · rw [causalRoot, if_neg (not_lt_of_ge hlt.le)]
    apply (hasDerivAt_const x (0 : ℝ)).congr_of_eventuallyEq
    filter_upwards [eventually_lt_nhds hlt] with y hy
    exact causalRootPrimitive_eq_zero hy.le
  · rw [causalRoot, if_pos hgt]
    apply (rootPrimitive_smooth_derivative (by linarith : 0 < x)).congr_of_eventuallyEq
    filter_upwards [eventually_gt_nhds hgt] with y hy
    exact causalRootPrimitive_eq hy.le

theorem causalRootPrimitive_monotone : Monotone causalRootPrimitive := by
  intro x y hxy
  unfold causalRootPrimitive
  gcongr

theorem causalRootPrimitive_nonneg (y : ℝ) : 0 ≤ causalRootPrimitive y := by
  have h := sqrt_le_sqrt (le_max_left (1 : ℝ) y)
  simp only [sqrt_one] at h
  unfold causalRootPrimitive
  linarith

noncomputable def rootPrimitiveConvolution (f : ℝ → ℂ) (y : ℝ) : ℂ :=
  ∫ t in Ioi (0 : ℝ), f t * (causalRootPrimitive (y - t) : ℂ)

theorem rootPrimitiveConvolution_integrable {f : ℝ → ℂ}
    (hf : IntegrableOn f (Ioi (0 : ℝ))) (y : ℝ) :
    IntegrableOn (fun t : ℝ => f t * (causalRootPrimitive (y - t) : ℂ)) (Ioi (0 : ℝ)) := by
  apply (hf.norm.mul_const (causalRootPrimitive y)).mono'
  · exact hf.aestronglyMeasurable.mul
      (Complex.continuous_ofReal.comp (causalRootPrimitive_lipschitz.continuous.comp
        (continuous_const.sub continuous_id))).aestronglyMeasurable
  · filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
    rw [norm_mul, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg (causalRootPrimitive_nonneg _)]
    exact mul_le_mul_of_nonneg_left
      (causalRootPrimitive_monotone (by have := ht; change 0 < t at this; linarith)) (norm_nonneg _)

theorem rootPrimitiveConvolution_hasDerivAt {f : ℝ → ℂ}
    (hf : IntegrableOn f (Ioi (0 : ℝ))) (y : ℝ) :
    HasDerivAt (rootPrimitiveConvolution f)
      (∫ t in Ioi (0 : ℝ), f t * (causalRoot (y - t) : ℂ)) y := by
  have h := hasDerivAt_integral_of_dominated_loc_of_lip
    (F := fun x t : ℝ => f t * (causalRootPrimitive (x - t) : ℂ))
    (F' := fun t : ℝ => f t * (causalRoot (y - t) : ℂ))
    (μ := volume.restrict (Ioi (0 : ℝ))) (bound := fun t : ℝ => ‖f t‖)
    (show (0 : ℝ) < 1 by norm_num)
    (Eventually.of_forall (fun x => (rootPrimitiveConvolution_integrable hf x).aestronglyMeasurable))
    (rootPrimitiveConvolution_integrable hf y)
    (hf.aestronglyMeasurable.mul
      (Complex.measurable_ofReal.comp (causalRoot_measurable.comp (by fun_prop))).aestronglyMeasurable)
    ?_ hf.norm ?_
  · exact h.2
  · filter_upwards with t
    rw [lipschitzOnWith_iff_dist_le_mul]
    intro x _ x' _
    rw [dist_eq_norm, ← mul_sub, norm_mul, ← Complex.ofReal_sub,
      Complex.norm_real, Real.norm_eq_abs, Real.coe_nnabs, abs_of_nonneg (norm_nonneg _),
      Real.dist_eq]
    have hd := causalRootPrimitive_lipschitz.dist_le_mul (x - t) (x' - t)
    simp only [NNReal.coe_one, one_mul, Real.dist_eq, sub_sub_sub_cancel_right] at hd
    exact mul_le_mul_of_nonneg_left hd (norm_nonneg _)
  · have hne : ∀ᵐ t : ℝ, t ≠ y - 1 := by rw [ae_iff]; simp
    filter_upwards [ae_restrict_of_ae hne] with t ht
    have hd := ((causalRootPrimitive_hasDerivAt (show y - t ≠ 1 by intro h; apply ht; linarith)).comp
      y ((hasDerivAt_id y).sub_const t)).ofReal_comp
    simpa only [mul_one] using hd.const_mul (f t)

end BuildingBlocks.SuccessorFeedback
