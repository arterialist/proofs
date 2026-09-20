import Mathlib.Tactic

/-!
# Exponent ledger for the critical dual row

This module checks the exponent arithmetic behind the determinant-line
count, the row-entry comparison, and the Schur loss. The analytic second
derivative and stationary-phase estimates remain in the companion note.
-/

namespace BuildingBlocks.ActualMobiusCriticalDualKRow

theorem scale_exponents (lambda : ℝ) :
    let p := 1 - 2 * lambda / 5
    let q := lambda / 5
    p + 2 * q = 1 ∧ 5 * q = lambda := by
  dsimp
  constructor <;> ring

theorem scale_order (lambda : ℝ)
    (hlow : 2 < lambda) (hhigh : lambda < 29 / 14) :
    let p := 1 - 2 * lambda / 5
    let q := lambda / 5
    0 < p ∧ p < q := by
  dsimp
  constructor <;> nlinarith

/-- The gcd exponent cancels from the main increasing determinant sum. -/
theorem determinant_increasing_exponent
    (p q gamma : ℝ) :
    (q + gamma - p) + (q + gamma) / 2
        + 3 * (p + q - gamma) / 2 = p / 2 + 3 * q := by
  ring

/-- The gcd exponent also cancels from the decreasing determinant sum. -/
theorem determinant_decreasing_exponent
    (p q gamma : ℝ) :
    (q + gamma - p) + (3 * q - gamma) / 2
        + (p + q - gamma) / 2 = 3 * q - p / 2 := by
  ring

theorem row_improves_rs (p q : ℝ) (hpq : p < q) :
    3 * q + p / 2 < 7 * q / 2 := by
  linarith

theorem schur_row_exponent (p q : ℝ) :
    p + (3 * q + p / 2) = 3 * q + 3 * p / 2 := by
  ring

/-- After the `Q^2` coefficient norm, Schur loses `P^(1/2)`. -/
theorem schur_energy_loss (p q : ℝ) :
    (3 * q + 3 * p / 2 + 2 * q) - (p + 5 * q) = p / 2 := by
  ring

/-- At a typical determinant, `P` stationary modes of size `Q/sqrt(P)`
have absolute-sum exponent `q + p/2`. -/
theorem stationary_absolute_exponent (p q : ℝ) :
    p + (q - p / 2) = q + p / 2 := by
  ring

end BuildingBlocks.ActualMobiusCriticalDualKRow
