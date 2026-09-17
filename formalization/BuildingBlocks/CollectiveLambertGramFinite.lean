import Mathlib.Tactic

namespace PaidThetaCompensation

/-! Finite real-Hermitian algebra for the first collective Lambert block.
The angular integrals and complete theta covariance entries remain
explicit analytic inputs. -/

/-- Exact cancellation identity for a two-frequency Toeplitz block on the
signed vector with coordinates one and minus s. -/
theorem two_frequency_cancellation_identity
    (k0 k1 s : ℝ) :
    k0 * (1 + s ^ 2) - 2 * k1 * s =
      k0 * (1 - s) ^ 2 + 2 * s * (k0 - k1) := by
  ring

/-- Once the near-equality of the two coefficients and the Toeplitz
difference estimate have been supplied, the signed block has the stated
upper bound. -/
theorem two_frequency_cancellation_upper
    {k0 k1 s eps delta : ℝ}
    (hidentity :
      k0 * (1 + s ^ 2) - 2 * k1 * s =
        k0 * (1 - s) ^ 2 + 2 * s * (k0 - k1))
    (hk0 : 0 ≤ k0)
    (hnear : (1 - s) ^ 2 ≤ eps ^ 2)
    (htail : 2 * s * (k0 - k1) ≤ 2 * delta * k0) :
    k0 * (1 + s ^ 2) - 2 * k1 * s
      ≤ k0 * eps ^ 2 + 2 * delta * k0 := by
  rw [hidentity]
  have hscaled := mul_le_mul_of_nonneg_left hnear hk0
  linarith

/-- Expanding a scaled two-by-two theta Gram minus a central Gram gives the
residual matrix used in the generalized-eigenvalue test. -/
theorem two_by_two_comparison_residual
    (scale A B C k0 k1 x y : ℝ) :
    scale * (A * x ^ 2 + 2 * B * x * y + C * y ^ 2) -
        (k0 * x ^ 2 + 2 * k1 * x * y + k0 * y ^ 2) =
      (scale * A - k0) * x ^ 2 +
        2 * (scale * B - k1) * x * y +
        (scale * C - k0) * y ^ 2 := by
  ring

/-- Positive leading diagonal plus the determinant condition proves
nonnegativity of a real symmetric two-by-two quadratic form. The
zero-diagonal boundary case is intentionally left separate. -/
theorem two_by_two_nonneg_of_det
    {a b c x y : ℝ} (ha : 0 < a) (hdet : b ^ 2 ≤ a * c) :
    0 ≤ a * x ^ 2 + 2 * b * x * y + c * y ^ 2 := by
  have hid :
      a * (a * x ^ 2 + 2 * b * x * y + c * y ^ 2) =
        (a * x + b * y) ^ 2 + (a * c - b ^ 2) * y ^ 2 := by
    ring
  have hrhs :
      0 ≤ (a * x + b * y) ^ 2 + (a * c - b ^ 2) * y ^ 2 := by
    have hres : 0 ≤ a * c - b ^ 2 := by linarith
    positivity
  nlinarith

/-- The exact theta energy on the signed row with coordinates one and
minus s. -/
theorem signed_theta_row_identity
    (A B C s : ℝ) :
    A * 1 ^ 2 + 2 * B * 1 * (-s) + C * (-s) ^ 2 =
      A - 2 * s * B + s ^ 2 * C := by
  ring

end PaidThetaCompensation
