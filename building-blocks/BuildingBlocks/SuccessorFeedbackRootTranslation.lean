import BuildingBlocks.SuccessorFeedbackFloorBoundary
import Mathlib.Analysis.SpecialFunctions.Sqrt

/-! Exact L¹ translation cost of the causal inverse-square-root kernel.
The kernel itself is not integrable; its translated difference is. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

noncomputable def causalRoot (x : ℝ) : ℝ := if 1 < x then 1 / sqrt x else 0

theorem causalRoot_measurable : Measurable causalRoot := by
  change Measurable ((Ioi (1 : ℝ)).indicator (fun x : ℝ => 1 / sqrt x))
  exact (measurable_const.div continuous_sqrt.measurable).indicator measurableSet_Ioi

theorem one_div_sqrt_eq_rpow {x : ℝ} (hx : 0 ≤ x) :
    1 / sqrt x = x ^ (-(1 / 2 : ℝ)) := by
  rw [rpow_neg hx, sqrt_eq_rpow, one_div]

private theorem sqrt_difference_tendsto {t : ℝ} (ht : 0 ≤ t) :
    Tendsto (fun x : ℝ => sqrt x - sqrt (x - t)) atTop (𝓝 0) := by
  have hh : Tendsto (fun x : ℝ => t * x ^ (-(1 / 2 : ℝ))) atTop (𝓝 0) := by
    simpa using (tendsto_rpow_neg_atTop (by norm_num : (0 : ℝ) < 1 / 2)).const_mul t
  apply squeeze_zero_norm' (a := fun x : ℝ => t * x ^ (-(1 / 2 : ℝ))) _ hh
  filter_upwards [eventually_ge_atTop (t + 1)] with x hx
  have hx0 : 0 < x := by linarith
  have hxt : 0 ≤ x - t := by linarith
  have hle : sqrt (x - t) ≤ sqrt x := sqrt_le_sqrt (by linarith)
  rw [Real.norm_eq_abs, abs_of_nonneg (sub_nonneg.mpr hle),
    ← one_div_sqrt_eq_rpow hx0.le, ← div_eq_mul_one_div,
    le_div_iff₀ (sqrt_pos.mpr hx0)]
  have h1 := sq_sqrt hx0.le
  have h2 := sq_sqrt hxt
  have h3 := mul_nonneg (sub_nonneg.mpr hle) (sqrt_nonneg (x - t))
  nlinarith

private theorem rootTailPrimitive_hasDerivAt {t : ℝ} (ht : 0 ≤ t)
    {x : ℝ} (hx : t + 1 ≤ x) :
    HasDerivAt (fun y : ℝ => 2 * (sqrt (y - t) - sqrt y))
      (1 / sqrt (x - t) - 1 / sqrt x) x := by
  have hx0 : 0 < x := by linarith
  have hxt : 0 < x - t := by linarith
  have h := (((hasDerivAt_id x).sub_const t).sqrt hxt.ne').sub (hasDerivAt_sqrt hx0.ne')
  convert h.const_mul 2 using 1
  simp only [id_eq, mul_one]
  field_simp
  <;> ring

private theorem rootTail_nonneg {t : ℝ} (ht : 0 ≤ t) {x : ℝ} (hx : t + 1 < x) :
    0 ≤ 1 / sqrt (x - t) - 1 / sqrt x := by
  apply sub_nonneg.mpr
  exact one_div_le_one_div_of_le (sqrt_pos.mpr (by linarith)) (sqrt_le_sqrt (by linarith))

private theorem rootTailPrimitive_tendsto {t : ℝ} (ht : 0 ≤ t) :
    Tendsto (fun x : ℝ => 2 * (sqrt (x - t) - sqrt x)) atTop (𝓝 0) := by
  have h := (sqrt_difference_tendsto ht).neg.const_mul 2
  simpa only [neg_sub, neg_zero, mul_zero] using h

theorem causalRoot_tail_integrable {t : ℝ} (ht : 0 ≤ t) :
    IntegrableOn (fun x : ℝ => 1 / sqrt (x - t) - 1 / sqrt x) (Ioi (t + 1)) :=
  integrableOn_Ioi_deriv_of_nonneg'
    (fun x hx => rootTailPrimitive_hasDerivAt ht hx)
    (fun x hx => rootTail_nonneg ht hx) (rootTailPrimitive_tendsto ht)

theorem causalRoot_tail_integral {t : ℝ} (ht : 0 ≤ t) :
    (∫ x in Ioi (t + 1), (1 / sqrt (x - t) - 1 / sqrt x)) =
      2 * (sqrt (t + 1) - 1) := by
  have h := integral_Ioi_of_hasDerivAt_of_nonneg'
    (fun x hx => rootTailPrimitive_hasDerivAt ht hx)
    (fun x hx => rootTail_nonneg ht hx) (rootTailPrimitive_tendsto ht)
  simp only [add_sub_cancel_left, sqrt_one, zero_sub] at h
  rw [h]
  ring

private theorem causalRoot_head_integrable {t : ℝ} (ht : 0 ≤ t) :
    IntegrableOn (fun x : ℝ => 1 / sqrt x) (Ioc 1 (t + 1)) := by
  apply (intervalIntegrable_iff_integrableOn_Ioc_of_le (by linarith : (1 : ℝ) ≤ t + 1)).mp
  apply ContinuousOn.intervalIntegrable
  apply continuousOn_const.div continuous_sqrt.continuousOn
  intro x hx
  rw [uIcc_of_le (by linarith : (1 : ℝ) ≤ t + 1)] at hx
  exact (sqrt_pos.mpr (by linarith [hx.1])).ne'

private theorem causalRoot_head_integral {t : ℝ} (ht : 0 ≤ t) :
    (∫ x in Ioc (1 : ℝ) (t + 1), 1 / sqrt x) = 2 * (sqrt (t + 1) - 1) := by
  have he : (∫ x in Ioc (1 : ℝ) (t + 1), 1 / sqrt x) =
      ∫ x in Ioc (1 : ℝ) (t + 1), x ^ (-(1 / 2 : ℝ)) := by
    apply setIntegral_congr_fun measurableSet_Ioc
    intro x hx
    exact one_div_sqrt_eq_rpow (by linarith [hx.1])
  rw [he, ← intervalIntegral.integral_of_le (by linarith : (1 : ℝ) ≤ t + 1),
    integral_rpow (Or.inl (by norm_num))]
  norm_num
  rw [sqrt_eq_rpow]
  ring

private theorem causalRoot_translation_eq {t : ℝ} (ht : 0 ≤ t) :
    (fun x : ℝ => causalRoot x - causalRoot (x - t)) =
      (fun x : ℝ => (Ioc (1 : ℝ) (t + 1)).indicator (fun x => 1 / sqrt x) x -
        (Ioi (t + 1)).indicator (fun x => 1 / sqrt (x - t) - 1 / sqrt x) x) := by
  funext x
  by_cases hx : 1 < x
  · by_cases hxt : t + 1 < x
    · have ha : 1 < x - t := by linarith
      simp [causalRoot, hx, ha, hxt, show ¬x ≤ t + 1 from not_le.mpr hxt]
    · have ha : ¬1 < x - t := by linarith
      simp [causalRoot, hx, ha, hxt, le_of_not_gt hxt]
  · have ha : ¬1 < x - t := by linarith
    have hb : ¬t + 1 < x := by linarith
    simp [causalRoot, hx, ha, hb]

theorem causalRoot_translation_integrable {t : ℝ} (ht : 0 ≤ t) :
    Integrable (fun x : ℝ => causalRoot x - causalRoot (x - t)) := by
  rw [causalRoot_translation_eq ht]
  exact ((causalRoot_head_integrable ht).integrable_indicator measurableSet_Ioc).sub
    ((causalRoot_tail_integrable ht).integrable_indicator measurableSet_Ioi)

/-- The positive boundary strip and opposite-sign tail have equal masses. -/
theorem causalRoot_translation_integral {t : ℝ} (ht : 0 ≤ t) :
    (∫ x : ℝ, causalRoot x - causalRoot (x - t)) = 0 := by
  rw [causalRoot_translation_eq ht, integral_sub
    ((causalRoot_head_integrable ht).integrable_indicator measurableSet_Ioc)
    ((causalRoot_tail_integrable ht).integrable_indicator measurableSet_Ioi),
    integral_indicator measurableSet_Ioc, integral_indicator measurableSet_Ioi,
    causalRoot_head_integral ht, causalRoot_tail_integral ht, sub_self]

/-- Exact translation cost of the original causal root kernel. -/
theorem causalRoot_translation_norm {t : ℝ} (ht : 0 ≤ t) :
    (∫ x : ℝ, |causalRoot x - causalRoot (x - t)|) = 4 * (sqrt (t + 1) - 1) := by
  have he : (fun x : ℝ => |causalRoot x - causalRoot (x - t)|) =
      (fun x : ℝ => (Ioc (1 : ℝ) (t + 1)).indicator (fun x => 1 / sqrt x) x +
        (Ioi (t + 1)).indicator (fun x => 1 / sqrt (x - t) - 1 / sqrt x) x) := by
    funext x
    rw [congrFun (causalRoot_translation_eq ht) x]
    by_cases hx : x ≤ t + 1
    · rw [indicator_of_notMem (show x ∉ Ioi (t + 1) from not_lt.mpr hx), sub_zero, add_zero]
      exact abs_of_nonneg (indicator_nonneg (fun _ _ => by positivity) x)
    · rw [indicator_of_notMem (show x ∉ Ioc (1 : ℝ) (t + 1) from fun h => hx h.2),
        indicator_of_mem (show x ∈ Ioi (t + 1) from lt_of_not_ge hx), zero_sub, zero_add, abs_neg]
      exact abs_of_nonneg (rootTail_nonneg ht (lt_of_not_ge hx))
  rw [he, integral_add
    ((causalRoot_head_integrable ht).integrable_indicator measurableSet_Ioc)
    ((causalRoot_tail_integrable ht).integrable_indicator measurableSet_Ioi),
    integral_indicator measurableSet_Ioc, integral_indicator measurableSet_Ioi,
    causalRoot_head_integral ht, causalRoot_tail_integral ht]
  ring

end BuildingBlocks.SuccessorFeedback
