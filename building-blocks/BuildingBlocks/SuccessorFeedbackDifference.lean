import BuildingBlocks.SuccessorFeedbackSource
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals

/-! The exact prime-power and density terms in an ordinary successor difference
of the physical prime error. -/

open MeasureTheory Real Set Filter

namespace BuildingBlocks.SuccessorFeedback

noncomputable def physicalDifference (j : ℕ) (x : ℝ) : ℝ :=
  physicalError (x + j + 1) - physicalError (x + j)

theorem physicalError_succ {y : ℝ} (hy : 0 < y) :
    physicalError (y + 1) - physicalError y =
      ArithmeticFunction.vonMangoldt (⌊y⌋₊ + 1) / (y + 1) -
        CoarsePrimitive.psi ⌊y⌋₊ / (y * (y + 1)) := by
  have hs : CoarsePrimitive.psi (⌊y⌋₊ + 1) = CoarsePrimitive.psi ⌊y⌋₊ +
      ArithmeticFunction.vonMangoldt (⌊y⌋₊ + 1) := by
    exact Finset.sum_range_succ _ _
  unfold physicalError
  rw [Nat.floor_add_one hy.le, hs]
  field_simp
  ring

/-- The continuous negative density term remains alongside the new prime power. -/
theorem physicalDifference_eq {x : ℝ} (hx : 0 < x) (j : ℕ) :
    physicalDifference j x =
      ArithmeticFunction.vonMangoldt (⌊x⌋₊ + j + 1) / (x + j + 1) -
        CoarsePrimitive.psi (⌊x⌋₊ + j) / ((x + j) * (x + j + 1)) := by
  unfold physicalDifference
  rw [physicalError_succ (by positivity), Nat.floor_add_natCast hx.le]

theorem physicalError_succ_abs_le {y : ℝ} (hy : 0 < y) :
    |physicalError (y + 1) - physicalError y| ≤
      (log (y + 1) + 4 * log 2) / (y + 1) := by
  rw [physicalError_succ hy]
  have hp : 0 ≤ CoarsePrimitive.psi ⌊y⌋₊ :=
    Finset.sum_nonneg (fun _ _ => ArithmeticFunction.vonMangoldt_nonneg)
  have hd : 0 ≤ CoarsePrimitive.psi ⌊y⌋₊ / (y * (y + 1)) :=
    div_nonneg hp (by positivity)
  have hv : 0 ≤ ArithmeticFunction.vonMangoldt (⌊y⌋₊ + 1) / (y + 1) :=
    div_nonneg ArithmeticFunction.vonMangoldt_nonneg (by positivity)
  have hb : CoarsePrimitive.psi ⌊y⌋₊ / (y * (y + 1)) ≤
      (4 * log 2) / (y + 1) := by
    apply (div_le_div_iff₀ (by positivity : 0 < y * (y + 1)) (by positivity)).2
    have hc := (CoarsePrimitive.psi_le_linear ⌊y⌋₊).trans
      (mul_le_mul_of_nonneg_left (Nat.floor_le hy.le) (by positivity : 0 ≤ 4 * log (2 : ℝ)))
    nlinarith [mul_le_mul_of_nonneg_right hc (by positivity : 0 ≤ y + 1)]
  have hl : ArithmeticFunction.vonMangoldt (⌊y⌋₊ + 1) ≤ log (y + 1) :=
    ArithmeticFunction.vonMangoldt_le_log.trans
      (log_le_log (by positivity) (by exact_mod_cast add_le_add_right (Nat.floor_le hy.le) 1))
  have hh := div_le_div_of_nonneg_right hl (by positivity : 0 ≤ y + 1)
  calc
    _ ≤ ArithmeticFunction.vonMangoldt (⌊y⌋₊ + 1) / (y + 1) +
        CoarsePrimitive.psi ⌊y⌋₊ / (y * (y + 1)) := by
      exact (abs_sub _ _).trans_eq (by rw [abs_of_nonneg hv, abs_of_nonneg hd])
    _ ≤ log (y + 1) / (y + 1) + (4 * log 2) / (y + 1) := add_le_add hh hb
    _ = _ := by ring

theorem physicalDifference_abs_le {x : ℝ} (hx : 0 < x) (j : ℕ) :
    |physicalDifference j x| ≤
      (log (x + j + 1) + 4 * log 2) / (x + j + 1) :=
  physicalError_succ_abs_le (by positivity)

theorem measurable_physicalDifference (j : ℕ) : Measurable (physicalDifference j) :=
  (measurable_physicalError.comp ((measurable_id.add_const (j : ℝ)).add_const 1)).sub
    (measurable_physicalError.comp (measurable_id.add_const (j : ℝ)))

/-- An integrable power majorant, with no hypothesis on prime distribution
beyond the already proved Chebyshev estimate. -/
theorem physicalDifference_power_bound {x : ℝ} (hx : 1 ≤ x) (j : ℕ) :
    |physicalDifference j x / sqrt x| ≤
      (4 + log (j + 2 : ℝ) + 4 * log 2) * x ^ (-(5 / 4 : ℝ)) := by
  have hx0 : 0 < x := lt_of_lt_of_le (by norm_num) hx
  have hj : 0 ≤ (j : ℝ) := Nat.cast_nonneg _
  have hlog : log (x + j + 1) ≤ log x + log (j + 2 : ℝ) := by
    rw [← log_mul (ne_of_gt hx0) (by positivity)]
    apply log_le_log (by positivity)
    nlinarith
  have hb := physicalDifference_abs_le hx0 j
  have hjl : 0 ≤ log (j + 2 : ℝ) := log_nonneg (by linarith)
  have hxl : 0 ≤ log x := log_nonneg hx
  have hr : 1 ≤ x ^ (1 / 4 : ℝ) := one_le_rpow hx (by norm_num)
  have hl := log_le_rpow_div hx0.le (by norm_num : 0 < (1 / 4 : ℝ))
  have hn : log (x + j + 1) + 4 * log 2 ≤
      (4 + log (j + 2 : ℝ) + 4 * log 2) * x ^ (1 / 4 : ℝ) := by
    have hm := mul_le_mul_of_nonneg_left hr
      (show 0 ≤ log (j + 2 : ℝ) + 4 * log 2 by positivity)
    nlinarith
  have hd : |physicalDifference j x| ≤
      ((4 + log (j + 2 : ℝ) + 4 * log 2) * x ^ (1 / 4 : ℝ)) / x := by
    exact hb.trans ((div_le_div_of_nonneg_right hn (by positivity)).trans
      (div_le_div_of_nonneg_left (by positivity) hx0 (by linarith)))
  rw [abs_div, abs_of_pos (sqrt_pos.mpr hx0)]
  apply (div_le_div_of_nonneg_right hd (sqrt_nonneg x)).trans_eq
  have he : x * sqrt x = x ^ (3 / 2 : ℝ) := by
    rw [sqrt_eq_rpow]
    nth_rw 1 [← rpow_one x]
    rw [← rpow_add hx0]
    norm_num
  rw [div_div, he, mul_div_assoc, ← rpow_sub hx0]
  norm_num

theorem physicalDifference_integrable (j : ℕ) :
    IntegrableOn (fun x => physicalDifference j x / sqrt x) (Ioi (1 : ℝ)) := by
  have hi := (integrableOn_Ioi_rpow_of_lt (by norm_num : -(5 / 4 : ℝ) < -1)
    (by norm_num : (0 : ℝ) < 1)).const_mul (4 + log (j + 2 : ℝ) + 4 * log 2)
  apply hi.mono' ((measurable_physicalDifference j).div (by fun_prop)).aestronglyMeasurable
  filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with x hx
  rw [Real.norm_eq_abs]
  exact physicalDifference_power_bound hx.le j

/-- The unmodified ordinary successor increment on the causal half-line. -/
noncomputable def innovation (j : ℕ) (v : ℝ) : ℝ :=
  SuccessorCharge.successor^[j + 1] source v -
    SuccessorCharge.successor^[j] source v

theorem innovation_eq {v : ℝ} (hv : 0 ≤ v) (j : ℕ) :
    innovation j v = exp (v / 2) * physicalDifference j (exp v) := by
  rw [innovation, source_iterate _ hv, source_iterate _ hv]
  simp only [physicalDifference, physicalError, Nat.cast_add, Nat.cast_one, add_assoc, mul_sub]

private theorem exp_mul_difference (j : ℕ) (v : ℝ) :
    exp v * (physicalDifference j (exp v) / sqrt (exp v)) =
      exp (v / 2) * physicalDifference j (exp v) := by
  have he : exp v = exp (v / 2) ^ 2 := by rw [pow_two, ← exp_add, add_halves]
  have hs : sqrt (exp v) = exp (v / 2) := by rw [he, sqrt_sq (exp_pos _).le]
  rw [hs, he]
  field_simp

/-- The difference itself lies in L¹ although its two source terms need not. -/
theorem innovation_integrable (j : ℕ) :
    IntegrableOn (innovation j) (Ioi (0 : ℝ)) := by
  have h := integrableOn_image_iff_integrableOn_abs_deriv_smul (s := Ioi (0 : ℝ))
    measurableSet_Ioi (fun v _ => (hasDerivAt_exp v).hasDerivWithinAt)
    exp_injective.injOn (fun x => physicalDifference j x / sqrt x)
  rw [MixedEnergy.exp_image_Ioi, exp_zero] at h
  apply (h.mp (physicalDifference_integrable j)).congr
  filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with v hv
  rw [smul_eq_mul, abs_of_pos (exp_pos v), exp_mul_difference, innovation_eq hv.le]

theorem innovation_integral (j : ℕ) :
    (∫ v in Ioi (0 : ℝ), innovation j v) =
      ∫ x in Ioi (1 : ℝ), physicalDifference j x / sqrt x := by
  have h := integral_image_eq_integral_abs_deriv_smul (s := Ioi (0 : ℝ))
    measurableSet_Ioi (fun v _ => (hasDerivAt_exp v).hasDerivWithinAt)
    exp_injective.injOn (fun x => physicalDifference j x / sqrt x)
  rw [MixedEnergy.exp_image_Ioi, exp_zero] at h
  rw [h]
  apply integral_congr_ae
  filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with v hv
  rw [smul_eq_mul, abs_of_pos (exp_pos v), exp_mul_difference, innovation_eq hv.le]

end BuildingBlocks.SuccessorFeedback
