import BuildingBlocks.SuccessorFeedbackDirichlet
import Mathlib.Analysis.Calculus.MeanValue

/-! Complex power differences at the original integer clock. These estimates
retain the literal floor in the feedback Abel kernel. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

private theorem negativePower_hasDerivAt (z : ℂ) {x : ℝ} (hx : 0 < x) :
    HasDerivAt (fun y : ℝ => (y : ℂ) ^ (-z))
      ((-z) * (x : ℂ) ^ (-z - 1)) x := by
  by_cases hz : z = 0
  · subst z
    simpa using hasDerivAt_const x (1 : ℂ)
  · exact hasDerivAt_ofReal_cpow_const (ne_of_gt hx) (neg_ne_zero.mpr hz)

/-- The exact one-dimensional derivative bound for complex negative powers. -/
theorem negativePower_difference_bound {z : ℂ} (hz : -1 ≤ z.re)
    {a b : ℝ} (ha : 0 < a) (hab : a ≤ b) :
    ‖(b : ℂ) ^ (-z) - (a : ℂ) ^ (-z)‖ ≤
      ‖z‖ * a ^ (-z.re - 1) * (b - a) := by
  apply norm_image_sub_le_of_norm_deriv_le_segment'
    (f' := fun x => (-z) * (x : ℂ) ^ (-z - 1))
    (fun x hx => (negativePower_hasDerivAt z (ha.trans_le hx.1)).hasDerivWithinAt)
    ?_ b (right_mem_Icc.mpr hab)
  intro x hx
  rw [norm_mul, norm_neg, Complex.norm_cpow_eq_rpow_re_of_pos (ha.trans_le hx.1)]
  simp only [Complex.sub_re, Complex.neg_re, Complex.one_re]
  apply mul_le_mul_of_nonneg_left _ (norm_nonneg z)
  exact rpow_le_rpow_of_nonpos ha hx.1 (by linarith)

noncomputable def floorWeight (z : ℂ) (t : ℝ) : ℂ :=
  ((⌊t⌋₊ + 1 : ℕ) : ℂ) ^ (-z)

noncomputable def floorWeightError (z : ℂ) (t : ℝ) : ℂ :=
  floorWeight z t - ((t + 1 : ℝ) : ℂ) ^ (-z)

theorem floorWeightError_bound {z : ℂ} (hz : -1 ≤ z.re)
    {t : ℝ} (ht : 0 ≤ t) :
    ‖floorWeightError z t‖ ≤ ‖z‖ * (⌊t⌋₊ + 1 : ℝ) ^ (-z.re - 1) := by
  have hfloor := Nat.floor_le ht
  have hlt := Nat.lt_floor_add_one t
  have h := negativePower_difference_bound hz
    (show (0 : ℝ) < (⌊t⌋₊ : ℝ) + 1 by positivity)
    (show (⌊t⌋₊ : ℝ) + 1 ≤ t + 1 by linarith)
  rw [norm_sub_rev] at h
  have he : ‖floorWeightError z t‖ =
      ‖(((⌊t⌋₊ : ℝ) + 1 : ℝ) : ℂ) ^ (-z) - ((t + 1 : ℝ) : ℂ) ^ (-z)‖ := by
    simp [floorWeightError, floorWeight]
  rw [he]
  exact h.trans (mul_le_of_le_one_right (by positivity) (by linarith))

/-- Locally uniform polynomial decay, in terms of `t+1` rather than a replaced
counting variable. The exponent-dependent factor is explicit. -/
theorem floorWeightError_decay {z : ℂ} (hz : -1 ≤ z.re)
    {t : ℝ} (ht : 0 ≤ t) :
    ‖floorWeightError z t‖ ≤
      (‖z‖ * (2 : ℝ) ^ (z.re + 1)) * (t + 1) ^ (-z.re - 1) := by
  have hlt := Nat.lt_floor_add_one t
  have hn : (0 : ℝ) ≤ ⌊t⌋₊ := Nat.cast_nonneg _
  have hb : (t + 1) / 2 ≤ (⌊t⌋₊ : ℝ) + 1 := by linarith
  have hp := rpow_le_rpow_of_nonpos
    (show (0 : ℝ) < (t + 1) / 2 by positivity) hb
    (show -z.re - 1 ≤ 0 by linarith)
  calc
    _ ≤ ‖z‖ * (⌊t⌋₊ + 1 : ℝ) ^ (-z.re - 1) := floorWeightError_bound hz ht
    _ ≤ ‖z‖ * ((t + 1) / 2) ^ (-z.re - 1) :=
      mul_le_mul_of_nonneg_left hp (norm_nonneg z)
    _ = _ := by
      rw [div_rpow (by positivity) (by norm_num), div_eq_mul_inv, ← rpow_neg (by norm_num : (0 : ℝ) ≤ 2)]
      rw [show -(-z.re - 1) = z.re + 1 by ring]
      ring

theorem measurable_floorWeight (z : ℂ) : Measurable (floorWeight z) := by
  have h : Measurable (fun n : ℕ => ((n + 1 : ℕ) : ℂ) ^ (-z)) := measurable_of_countable _
  exact h.comp (by fun_prop : Measurable (fun t : ℝ => ⌊t⌋₊))

theorem measurable_floorWeightError (z : ℂ) : Measurable (floorWeightError z) := by
  exact (measurable_floorWeight z).sub (by fun_prop)

theorem floorWeightError_differentiable {t : ℝ} (ht : 0 ≤ t) :
    Differentiable ℂ (fun z => floorWeightError z t) := by
  apply Differentiable.sub
  · exact differentiable_id.neg.const_cpow (Or.inl (by
      exact_mod_cast (Nat.succ_ne_zero ⌊t⌋₊)))
  · exact differentiable_id.neg.const_cpow (Or.inl (by
      exact_mod_cast (ne_of_gt (show 0 < t + 1 by positivity))))

/-- The exact discretization error is integrable for every positive real part. -/
theorem floorWeightError_integrable {z : ℂ} (hz : 0 < z.re) :
    IntegrableOn (floorWeightError z) (Ioi (0 : ℝ)) := by
  have hi := (integrableOn_add_rpow_Ioi_of_lt
    (by linarith : -z.re - 1 < -1) (by norm_num : -(1 : ℝ) < 0)).const_mul
      (‖z‖ * (2 : ℝ) ^ (z.re + 1))
  apply hi.mono' (measurable_floorWeightError z).aestronglyMeasurable
  filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with t ht
  exact floorWeightError_decay (by linarith) (le_of_lt ht)

/-- A common integrable majorant on each parameter set bounded in norm and
separated from the imaginary axis. -/
theorem floorWeightError_uniform_bound {α M : ℝ} (hα : 0 < α)
    {z : ℂ} (hz : α ≤ z.re) (hM : ‖z‖ ≤ M) {t : ℝ} (ht : 0 ≤ t) :
    ‖floorWeightError z t‖ ≤
      (M * (2 : ℝ) ^ (M + 1)) * (t + 1) ^ (-α - 1) := by
  have hM0 : 0 ≤ M := (norm_nonneg z).trans hM
  have hzr : z.re ≤ M := Complex.re_le_norm z |>.trans hM
  have hc : ‖z‖ * (2 : ℝ) ^ (z.re + 1) ≤ M * (2 : ℝ) ^ (M + 1) := by
    apply mul_le_mul hM
      (rpow_le_rpow_of_exponent_le (by norm_num) (by linarith))
      (by positivity) (by positivity)
  exact (floorWeightError_decay (by linarith) ht).trans
    (mul_le_mul hc
      (rpow_le_rpow_of_exponent_le (by linarith : 1 ≤ t + 1) (by linarith))
      (by positivity) (by have := (norm_nonneg z).trans hM; positivity))

end BuildingBlocks.SuccessorFeedback
