import BuildingBlocks.CenteredGoldbachTruncatedHeat
import BuildingBlocks.DirichletFutureObservationFinite
import Mathlib.Analysis.Complex.ExponentialBounds

/-!
# Finite obstruction to coefficientwise positive Goldbach transfer

The complete centered additive coefficient at the even total four is already
negative.  This is compatible with positivity of the full heat square and
rules out coefficientwise or Hankel-positivity replacements.
-/

namespace BuildingBlocks.CenteredGoldbachPositiveTransferObstruction

open scoped BigOperators ArithmeticFunction
open BuildingBlocks.GoldbachHeat
open BuildingBlocks.CenteredGoldbachTruncatedHeat

noncomputable section

private lemma log_three_gt_109_over_100 : (109 / 100 : ℝ) < Real.log 3 := by
  rw [Real.lt_log_iff_exp_lt (by norm_num : (0 : ℝ) < 3)]
  rw [show (109 / 100 : ℝ) = 1 + 9 / 100 by norm_num, Real.exp_add]
  have he1 := Real.exp_one_lt_d9
  have he9 : Real.exp (9 / 100 : ℝ) ≤ 1 / (1 - 9 / 100) :=
    Real.exp_bound_div_one_sub_of_interval (by norm_num) (by norm_num)
  nlinarith [Real.exp_pos (9 / 100 : ℝ)]

/-- The complete interior centered coefficient at total four, with all three
ordered pairs `(1,3)`, `(2,2)`, `(3,1)`. -/
theorem centered_coefficient_four_exact :
    truncatedCoefficient 3 4 =
      (Real.log 2 - 1) ^ 2 - 2 * (Real.log 3 - 1) := by
  have h2 : ArithmeticFunction.vonMangoldt 2 = Real.log 2 :=
    ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two
  have h3 : ArithmeticFunction.vonMangoldt 3 = Real.log 3 :=
    ArithmeticFunction.vonMangoldt_apply_prime (by decide)
  norm_num [truncatedCoefficient, centeredCoefficient, h2, h3,
    Finset.sum_Icc_succ_top]
  ring

/-- The first nontrivial even centered Goldbach coefficient is strictly
negative.  Thus full heat-square positivity is not coefficientwise positivity. -/
theorem centered_coefficient_four_neg : truncatedCoefficient 3 4 < 0 := by
  rw [centered_coefficient_four_exact]
  have h2lo : (69 / 100 : ℝ) < Real.log 2 := by
    linarith [Real.log_two_gt_d9]
  have h2hi : Real.log 2 < (7 / 10 : ℝ) := by
    linarith [Real.log_two_lt_d9]
  have h3lo := log_three_gt_109_over_100
  nlinarith [sq_nonneg (Real.log 2 - 69 / 100),
    sq_nonneg (7 / 10 - Real.log 2)]

/-- No coefficientwise nonnegativity statement can hold for the actual
finite centered additive convolution, even when restricted to even totals. -/
theorem not_all_even_centered_coefficients_nonnegative :
    ¬(∀ Y N : ℕ, Even N → N ≤ Y + 1 → 0 ≤ truncatedCoefficient Y N) := by
  intro h
  have := h 3 4 (by decide) (by omega)
  linarith [centered_coefficient_four_neg]

/-- The negative total-four entry also rules out positive semidefiniteness of
the centered Hankel kernel: its `(2,2)` diagonal entry is negative. -/
theorem centered_hankel_diagonal_not_nonnegative :
    ¬(∀ x : ℝ, 0 ≤ truncatedCoefficient 3 4 * x ^ 2) := by
  intro h
  have h1 := h 1
  norm_num at h1
  linarith [centered_coefficient_four_neg]

/-- Odd/even square algebra used by the exact parity split.  Positivity of the
complete square does not give a sign to either parity component separately. -/
theorem parity_square_decomposition (evenPart oddPart : ℝ) :
    (evenPart + oddPart) ^ 2 =
      (evenPart ^ 2 + oddPart ^ 2) + 2 * evenPart * oddPart ∧
    (evenPart - oddPart) ^ 2 =
      (evenPart ^ 2 + oddPart ^ 2) - 2 * evenPart * oddPart := by
  constructor <;> ring

end
end BuildingBlocks.CenteredGoldbachPositiveTransferObstruction

#print axioms BuildingBlocks.CenteredGoldbachPositiveTransferObstruction.centered_coefficient_four_exact
#print axioms BuildingBlocks.CenteredGoldbachPositiveTransferObstruction.centered_coefficient_four_neg
#print axioms BuildingBlocks.CenteredGoldbachPositiveTransferObstruction.not_all_even_centered_coefficients_nonnegative
#print axioms BuildingBlocks.CenteredGoldbachPositiveTransferObstruction.centered_hankel_diagonal_not_nonnegative
#print axioms BuildingBlocks.CenteredGoldbachPositiveTransferObstruction.parity_square_decomposition
