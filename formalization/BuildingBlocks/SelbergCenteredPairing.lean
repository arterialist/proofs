import BuildingBlocks.HyperbolaProduct
import BuildingBlocks.PrimePrimitiveFormula
import Mathlib.Analysis.Complex.ExponentialBounds

open scoped BigOperators

namespace BuildingBlocks

open CoarsePrimitive HyperbolaProduct

/-- The finite centered convolution primitive. All ordered positive factor pairs
with product at most `x` are included, including zero-weight endpoint pairs. -/
noncomputable def selbergCenteredArea (x : ℕ) : ℝ :=
  (∑ a ∈ Finset.Icc 1 x, ∑ b ∈ Finset.Icc 1 (x / a),
    ((x : ℝ) - (a * b : ℕ)) * ArithmeticFunction.vonMangoldt a *
      ArithmeticFunction.vonMangoldt b) -
  (x : ℝ) ^ 2 * (∑ n ∈ Finset.Icc 1 x,
    ArithmeticFunction.vonMangoldt n / (n : ℝ)) +
  (∑ n ∈ Finset.Icc 1 x, (n : ℝ) * ArithmeticFunction.vonMangoldt n) +
  (x : ℝ) ^ 2 / 2 * Real.log x + (x : ℝ) ^ 2 / 4 - 1 / 4

private lemma mangoldt_two : ArithmeticFunction.vonMangoldt 2 = Real.log 2 :=
  ArithmeticFunction.vonMangoldt_apply_prime (by decide)

private lemma mangoldt_three : ArithmeticFunction.vonMangoldt 3 = Real.log 3 :=
  ArithmeticFunction.vonMangoldt_apply_prime (by decide)

private lemma mangoldt_four : ArithmeticFunction.vonMangoldt 4 = Real.log 2 := by
  change ArithmeticFunction.vonMangoldt (2 ^ 2) = _
  rw [ArithmeticFunction.vonMangoldt_apply_pow (by norm_num), mangoldt_two]

private lemma log_four : Real.log 4 = 2 * Real.log 2 := by
  convert Real.log_pow (2 : ℝ) 2 using 1
  norm_num

theorem selbergCenteredArea_two : selbergCenteredArea 2 = 2 * Real.log 2 + 3 / 4 := by
  norm_num [selbergCenteredArea, Finset.sum_Icc_succ_top, mangoldt_two]
  ring

theorem selbergCenteredArea_three :
    selbergCenteredArea 3 = -(5 / 2 : ℝ) * Real.log 2 +
      (9 / 2 : ℝ) * Real.log 3 + 2 := by
  norm_num [selbergCenteredArea, Finset.sum_Icc_succ_top, mangoldt_two, mangoldt_three]
  ring

theorem selbergCenteredArea_four :
    selbergCenteredArea 4 = 10 * Real.log 2 - (7 / 3 : ℝ) * Real.log 3 + 15 / 4 := by
  norm_num [selbergCenteredArea, Finset.sum_Icc_succ_top, mangoldt_two, mangoldt_three,
    mangoldt_four, log_four]
  ring

theorem primePrimitiveArea_two : primePrimitiveArea 2 = -(3 / 2 : ℝ) := by
  rw [primePrimitiveArea_eq_weighted_sum]
  norm_num [Finset.sum_Icc_succ_top, mangoldt_two]

theorem primePrimitiveArea_three : primePrimitiveArea 3 = Real.log 2 - 4 := by
  rw [primePrimitiveArea_eq_weighted_sum]
  norm_num [Finset.sum_Icc_succ_top, mangoldt_two, mangoldt_three]

theorem primePrimitiveArea_four :
    primePrimitiveArea 4 = 2 * Real.log 2 + Real.log 3 - 15 / 2 := by
  rw [primePrimitiveArea_eq_weighted_sum]
  norm_num [Finset.sum_Icc_succ_top, mangoldt_two, mangoldt_three, mangoldt_four]

private theorem log_three_lt_eleven_tenths : Real.log 3 < 11 / 10 := by
  rw [Real.log_lt_iff_lt_exp (by norm_num : (0 : ℝ) < 3)]
  refine lt_of_lt_of_le ?_ (Real.sum_le_exp_of_nonneg
    (by norm_num : (0 : ℝ) ≤ 11 / 10) 8)
  simp_rw [Finset.sum_range_succ, Nat.factorial_succ]
  norm_num

/-- The proposed nonnegative pairing fails for the actual prime-error primitive
and the actual centered finite convolution primitive at `X = 2`, `t = 1`. -/
theorem selbergCenteredPairing_two_lt :
    (primePrimitiveArea 3 - primePrimitiveArea 2) *
        (selbergCenteredArea 3 - selbergCenteredArea 2) +
      (primePrimitiveArea 4 - primePrimitiveArea 3) *
        (selbergCenteredArea 4 - selbergCenteredArea 3) < -(13 / 6 : ℝ) := by
  rw [primePrimitiveArea_two, primePrimitiveArea_three, primePrimitiveArea_four,
    selbergCenteredArea_two, selbergCenteredArea_three, selbergCenteredArea_four]
  have ha0 : (69 / 100 : ℝ) < Real.log 2 := by linarith [Real.log_two_gt_d9]
  have ha1 : Real.log 2 < (7 / 10 : ℝ) := by linarith [Real.log_two_lt_d9]
  have hb0 : (1 : ℝ) < Real.log 3 := by
    rw [Real.lt_log_iff_exp_lt (by norm_num : (0 : ℝ) < 3)]
    linarith [Real.exp_one_lt_d9]
  have hb1 := log_three_lt_eleven_tenths
  have hn1 : (2 : ℝ) <
      -(9 / 2 : ℝ) * Real.log 2 + (9 / 2 : ℝ) * Real.log 3 + 5 / 4 := by linarith
  have hn2 : (2 : ℝ) <
      (25 / 2 : ℝ) * Real.log 2 - (41 / 6 : ℝ) * Real.log 3 + 7 / 4 := by linarith
  have hprod1 := mul_pos
    (show 0 < (5 / 2 : ℝ) - Real.log 2 - 9 / 5 by linarith)
    (show 0 < -(9 / 2 : ℝ) * Real.log 2 + (9 / 2 : ℝ) * Real.log 3 + 5 / 4
      by linarith)
  have hprod2 := mul_pos
    (show 0 < (7 / 2 : ℝ) - Real.log 2 - Real.log 3 - 17 / 10 by linarith)
    (show 0 < (25 / 2 : ℝ) * Real.log 2 - (41 / 6 : ℝ) * Real.log 3 + 7 / 4
      by linarith)
  nlinarith

end BuildingBlocks
