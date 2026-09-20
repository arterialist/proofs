import Mathlib

/-!
# Exponent ledger for the critical localized-divisor Fourier saving

The residue-class estimate is written analysis.  This file checks only the
critical scales and the comparison of its three terms with the endpoint.
-/

namespace BuildingBlocks
namespace ActualMobiusLocalizedDivisorFourier

noncomputable section

def p (lambda : ℝ) : ℝ := 1 - 2 * lambda / 5
def q (lambda : ℝ) : ℝ := lambda / 5
def a (lambda : ℝ) : ℝ := q lambda - p lambda

theorem factor_product_scale (lambda : ℝ) :
    p lambda + a lambda = q lambda := by
  simp [a]

theorem physical_scale (lambda : ℝ) :
    p lambda + 2 * q lambda = 1 := by
  simp [p, q]
  ring

/-- The localized product `x*p*s*r` has scale `Q^3`. -/
theorem localized_product_exponent (lambda : ℝ) :
    q lambda + p lambda + a lambda + q lambda = 3 * q lambda := by
  simp [a]
  ring

/-- At modulus scale `M = Q`, the terms `Q^3/M`, `M`, and the asymmetric
boundary term `Q^2` are all at most `Q^2` in exponent. -/
theorem natural_modulus_main_exponent (lambda : ℝ) :
    3 * q lambda - q lambda = 2 * q lambda := by ring

theorem natural_modulus_exponent_le {lambda : ℝ} (hlambda : 0 ≤ lambda) :
    q lambda ≤ 2 * q lambda := by
  simp [q]
  linarith

/-- The additive Fourier estimate saves one full `Q` against box mass. -/
theorem box_saving_exponent (lambda : ℝ) :
    3 * q lambda - 2 * q lambda = q lambda := by ring

/-- After summing the `P` physical modes, the additive bound `P Q^2` is
`Q^{-1/2}` below the endpoint target `P Q^(5/2)`. -/
theorem endpoint_ratio_exponent (lambda : ℝ) :
    (p lambda + 2 * q lambda) -
        (p lambda + (5 / 2 : ℝ) * q lambda) =
      -(1 / 2 : ℝ) * q lambda := by ring

theorem endpoint_ratio_saves {lambda : ℝ} (hlambda : 0 < lambda) :
    (p lambda + 2 * q lambda) -
        (p lambda + (5 / 2 : ℝ) * q lambda) < 0 := by
  rw [endpoint_ratio_exponent]
  simp [q]
  linarith

/-- If the physical numerator has a gcd as large as `P` with a modulus of
scale `Q`, reducing the fraction changes the per-mode bound to `P Q^2`.
After all `P` modes, its ratio to `P Q^(5/2)` is `P/Q^(1/2)`, with exponent
`-(lambda - 2)/2`. -/
theorem worst_gcd_ratio_exponent (lambda : ℝ) :
    (2 * p lambda + 2 * q lambda) -
        (p lambda + (5 / 2 : ℝ) * q lambda) =
      -(lambda - 2) / 2 := by
  simp [p, q]
  ring

theorem worst_gcd_ratio_saves {lambda : ℝ} (hlow : 2 < lambda) :
    (2 * p lambda + 2 * q lambda) -
        (p lambda + (5 / 2 : ℝ) * q lambda) < 0 := by
  rw [worst_gcd_ratio_exponent]
  linarith

end
end ActualMobiusLocalizedDivisorFourier
end BuildingBlocks
