import Mathlib.Tactic

/-!
# Exponent ledger for the one-Q Poisson endpoint

This checks the scale, spacing, double-large-sieve, and stationary
normalization arithmetic. The analytic estimates remain external inputs.
-/

namespace BuildingBlocks.ActualMobiusCriticalOneQPoissonEndpoint

theorem scale_identities (lambda : ℝ) :
    let p := (5 - 2 * lambda) / 5
    let q := lambda / 5
    let a := 3 * lambda / 5 - 1
    p + 2 * q = 1 ∧ p + a = q ∧ 5 * q = lambda := by
  dsimp
  constructor
  · ring
  constructor <;> ring

theorem scale_order (lambda : ℝ)
    (hlow : 2 < lambda) (hhigh : lambda < 29 / 14) :
    let p := (5 - 2 * lambda) / 5
    let q := lambda / 5
    let a := 3 * lambda / 5 - 1
    0 < p ∧ p < a ∧ a < q := by
  dsimp
  constructor
  · nlinarith
  constructor <;> nlinarith

/-- The first normalized spacing window has physical width `P / Q`. -/
theorem x_spacing_exponent (p q : ℝ) :
    2 * p + q - (p + 2 * q) = p - q := by
  ring

/-- The second normalized spacing window has physical width `1 / P`. -/
theorem y_spacing_exponent (p q : ℝ) :
    2 * q - (p + 2 * q) = -p := by
  ring

theorem spacing_exponents_negative (p q : ℝ)
    (hp : 0 < p) (hpq : p < q) :
    p - q < 0 ∧ -p < 0 := by
  constructor <;> linarith

/-- `T * (P^2 Q) * Q^2 = P^3 Q^5` at exponent level. -/
theorem double_large_sieve_exponent (p q : ℝ)
    (hscale : p + 2 * q = 1) :
    1 + (2 * p + q) + 2 * q = 3 * p + 5 * q := by
  linarith

/-- Square root of the DLS estimate followed by `P^{-1/2}`. -/
theorem stationary_endpoint_exponent (p q : ℝ) :
    (3 * p + 5 * q) / 2 - p / 2 = p + 5 * q / 2 := by
  ring

theorem endpoint_margin_zero (p q : ℝ) :
    (p + 5 * q / 2) - (p + 5 * q / 2) = 0 := by
  ring

theorem monomial_loss_positive (p : ℝ) (hp : 0 < p) :
    0 < p / 4 := by
  linarith

end BuildingBlocks.ActualMobiusCriticalOneQPoissonEndpoint
