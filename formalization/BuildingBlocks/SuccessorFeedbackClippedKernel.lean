import BuildingBlocks.SuccessorFeedbackFloorKernel

/-! A bounded Lipschitz square-root kernel separating the moving endpoint
from the differentiable convolution in the literal floor Abel remainder. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

noncomputable def clippedRoot (x : ℝ) : ℝ :=
  (max 1 x) ^ (-(1 / 2 : ℝ)) - 1

theorem clippedRoot_eq_zero {x : ℝ} (hx : x ≤ 1) : clippedRoot x = 0 := by
  simp [clippedRoot, max_eq_left hx]

theorem clippedRoot_eq {x : ℝ} (hx : 1 ≤ x) :
    clippedRoot x = x ^ (-(1 / 2 : ℝ)) - 1 := by
  rw [clippedRoot, max_eq_right hx]

theorem clippedRoot_abs_le_one (x : ℝ) : |clippedRoot x| ≤ 1 := by
  have hm : 1 ≤ max (1 : ℝ) x := le_max_left _ _
  have hp := Real.rpow_nonneg (by linarith : 0 ≤ max (1 : ℝ) x) (-(1 / 2 : ℝ))
  have hq := Real.rpow_le_one_of_one_le_of_nonpos hm (by norm_num : -(1 / 2 : ℝ) ≤ 0)
  rw [clippedRoot, abs_le]
  constructor <;> linarith

private theorem rootPower_hasDerivAt {x : ℝ} (hx : 0 < x) :
    HasDerivAt (fun u : ℝ => u ^ (-(1 / 2 : ℝ)))
      (-(1 / 2 : ℝ) * x ^ (-(3 / 2 : ℝ))) x := by
  convert (hasDerivAt_id x).rpow_const
    (p := -(1 / 2 : ℝ)) (Or.inl hx.ne') using 1 <;> norm_num

private theorem rootPower_lipschitz :
    LipschitzOnWith 1 (fun x : ℝ => x ^ (-(1 / 2 : ℝ))) (Ici 1) := by
  apply (convex_Ici (1 : ℝ)).lipschitzOnWith_of_nnnorm_hasDerivWithin_le
    (fun x hx => (rootPower_hasDerivAt (by linarith [show 1 ≤ x from hx])).hasDerivWithinAt)
  intro x hx
  rw [← NNReal.coe_le_coe]
  simp only [coe_nnnorm, NNReal.coe_one, norm_mul, Real.norm_eq_abs,
    abs_of_nonneg (Real.rpow_nonneg (by linarith [show 1 ≤ x from hx]) _)]
  have hp := Real.rpow_le_one_of_one_le_of_nonpos (show 1 ≤ x from hx)
    (by norm_num : -(3 / 2 : ℝ) ≤ 0)
  norm_num
  linarith

theorem clippedRoot_lipschitz : LipschitzWith 1 clippedRoot := by
  apply LipschitzWith.of_dist_le_mul
  intro x y
  rw [clippedRoot, clippedRoot, dist_sub_right]
  exact (rootPower_lipschitz.dist_le_mul _ (show max 1 x ∈ Ici (1 : ℝ) from le_max_left 1 x)
    _ (show max 1 y ∈ Ici (1 : ℝ) from le_max_left 1 y)).trans
    (by simpa using (LipschitzWith.id.const_max (1 : ℝ)).dist_le_mul x y)

noncomputable def clippedRootDerivative (x : ℝ) : ℝ :=
  if 1 < x then -(1 / 2 : ℝ) * x ^ (-(3 / 2 : ℝ)) else 0

theorem clippedRoot_hasDerivAt {x : ℝ} (hx : x ≠ 1) :
    HasDerivAt clippedRoot (clippedRootDerivative x) x := by
  rcases lt_or_gt_of_ne hx with hlt | hgt
  · rw [clippedRootDerivative, if_neg (not_lt_of_ge hlt.le)]
    apply (hasDerivAt_const x (0 : ℝ)).congr_of_eventuallyEq
    filter_upwards [eventually_lt_nhds hlt] with u hu
    exact clippedRoot_eq_zero hu.le
  · rw [clippedRootDerivative, if_pos hgt]
    apply ((rootPower_hasDerivAt (by linarith : 0 < x)).sub_const 1).congr_of_eventuallyEq
    filter_upwards [eventually_gt_nhds hgt] with u hu
    exact clippedRoot_eq hu.le

theorem clippedRootDerivative_measurable : Measurable clippedRootDerivative := by
  unfold clippedRootDerivative
  exact Measurable.ite measurableSet_Ioi (by fun_prop) measurable_const

theorem clippedRootDerivative_abs_le (x : ℝ) : |clippedRootDerivative x| ≤ 1 / 2 := by
  by_cases hx : 1 < x
  · rw [clippedRootDerivative, if_pos hx, abs_mul,
      abs_of_nonneg (Real.rpow_nonneg (by linarith : 0 ≤ x) _)]
    have hp := Real.rpow_le_one_of_one_le_of_nonpos hx.le
      (by norm_num : -(3 / 2 : ℝ) ≤ 0)
    norm_num
    linarith
  · simp [clippedRootDerivative, hx]

noncomputable def clippedConvolution (f : ℝ → ℂ) (y : ℝ) : ℂ :=
  ∫ t in Ioi (0 : ℝ), f t * (clippedRoot (y - t) : ℂ)

theorem clippedConvolution_integrable {f : ℝ → ℂ} (hf : IntegrableOn f (Ioi 0)) (y : ℝ) :
    IntegrableOn (fun t : ℝ => f t * (clippedRoot (y - t) : ℂ)) (Ioi 0) := by
  apply hf.norm.mono'
  · exact hf.aestronglyMeasurable.mul
      (Complex.continuous_ofReal.comp (clippedRoot_lipschitz.continuous.comp
        (continuous_const.sub continuous_id))).aestronglyMeasurable
  · filter_upwards with t
    rw [norm_mul, Complex.norm_real, Real.norm_eq_abs]
    exact mul_le_of_le_one_right (norm_nonneg _) (clippedRoot_abs_le_one _)

theorem clippedConvolution_hasDerivAt {f : ℝ → ℂ} (hf : IntegrableOn f (Ioi 0)) (y : ℝ) :
    HasDerivAt (clippedConvolution f)
      (∫ t in Ioi (0 : ℝ), f t * (clippedRootDerivative (y - t) : ℂ)) y := by
  have h := hasDerivAt_integral_of_dominated_loc_of_lip
    (F := fun x t : ℝ => f t * (clippedRoot (x - t) : ℂ))
    (F' := fun t : ℝ => f t * (clippedRootDerivative (y - t) : ℂ))
    (μ := volume.restrict (Ioi (0 : ℝ))) (bound := fun t : ℝ => ‖f t‖)
    (show (0 : ℝ) < 1 by norm_num)
    (Eventually.of_forall (fun x => (clippedConvolution_integrable hf x).aestronglyMeasurable))
    (clippedConvolution_integrable hf y)
    (hf.aestronglyMeasurable.mul
      (Complex.measurable_ofReal.comp (clippedRootDerivative_measurable.comp
        (by fun_prop))).aestronglyMeasurable)
    ?_ hf.norm ?_
  · exact h.2
  · filter_upwards with t
    rw [lipschitzOnWith_iff_dist_le_mul]
    intro x hx w hw
    rw [dist_eq_norm, ← mul_sub, norm_mul, ← Complex.ofReal_sub,
      Complex.norm_real, Real.norm_eq_abs, Real.coe_nnabs, abs_of_nonneg (norm_nonneg _),
      Real.dist_eq]
    have hc := clippedRoot_lipschitz.dist_le_mul (x - t) (w - t)
    simp only [NNReal.coe_one, one_mul, Real.dist_eq, sub_sub_sub_cancel_right] at hc
    exact mul_le_mul_of_nonneg_left hc (norm_nonneg _)
  · have hne : ∀ᵐ t : ℝ, t ≠ y - 1 := by rw [ae_iff]; simp
    filter_upwards [ae_restrict_of_ae hne] with t ht
    have hn : y - t ≠ 1 := by intro he; apply ht; linarith
    have hd := ((clippedRoot_hasDerivAt hn).comp y ((hasDerivAt_id y).sub_const t)).ofReal_comp
    simpa only [mul_one] using hd.const_mul (f t)

/-- The actual floor error satisfies the integrability prerequisite; no
arithmetic continuation is used in this differentiation step. -/
theorem floorError_clippedConvolution_hasDerivAt {z : ℂ} (hz : 0 < z.re) (y : ℝ) :
    HasDerivAt (clippedConvolution (floorWeightError z))
      (∫ t in Ioi (0 : ℝ), floorWeightError z t *
        (clippedRootDerivative (y - t) : ℂ)) y :=
  clippedConvolution_hasDerivAt (floorWeightError_integrable hz) y

theorem clippedConvolution_eq_finite (f : ℝ → ℂ) (y : ℝ) :
    clippedConvolution f y = ∫ t in Ioc (0 : ℝ) (y - 1),
      f t * (((y - t) ^ (-(1 / 2 : ℝ)) - 1 : ℝ) : ℂ) := by
  have he : (fun t : ℝ => f t * (clippedRoot (y - t) : ℂ)) =
      (Iic (y - 1)).indicator (fun t : ℝ =>
        f t * (((y - t) ^ (-(1 / 2 : ℝ)) - 1 : ℝ) : ℂ)) := by
    funext t
    by_cases ht : t ≤ y - 1
    · rw [indicator_of_mem (show t ∈ Iic (y - 1) from ht), clippedRoot_eq (by linarith)]
    · rw [indicator_of_notMem (show t ∉ Iic (y - 1) from ht),
        clippedRoot_eq_zero (by linarith), Complex.ofReal_zero, mul_zero]
  unfold clippedConvolution
  rw [he, setIntegral_indicator measurableSet_Iic]
  congr 1

theorem clippedConvolution_derivative_eq_finite (f : ℝ → ℂ) (y : ℝ) :
    (∫ t in Ioi (0 : ℝ), f t * (clippedRootDerivative (y - t) : ℂ)) =
      -(1 / 2 : ℂ) * ∫ t in Ioo (0 : ℝ) (y - 1),
        f t * ((y - t) ^ (-(3 / 2 : ℝ)) : ℝ) := by
  have he : (fun t : ℝ => f t * (clippedRootDerivative (y - t) : ℂ)) =
      (Iio (y - 1)).indicator (fun t : ℝ =>
        -(1 / 2 : ℂ) * (f t * ((y - t) ^ (-(3 / 2 : ℝ)) : ℝ))) := by
    funext t
    by_cases ht : t < y - 1
    · rw [indicator_of_mem (show t ∈ Iio (y - 1) from ht), clippedRootDerivative, if_pos (by linarith)]
      push_cast
      ring
    · rw [indicator_of_notMem (show t ∉ Iio (y - 1) from ht), clippedRootDerivative, if_neg (by linarith),
        Complex.ofReal_zero, mul_zero]
  rw [he, setIntegral_indicator measurableSet_Iio]
  have hs : Ioi (0 : ℝ) ∩ Iio (y - 1) = Ioo 0 (y - 1) := by
    ext t
    simp
  rw [hs, integral_const_mul]

end BuildingBlocks.SuccessorFeedback
