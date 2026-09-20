import Mathlib

/-!
# Exponent ledger for joint outer/alias spacing

Only the scale algebra is formalized here. The analytic stationary transform,
spacing estimates, and double large sieve are external written inputs.
-/

namespace BuildingBlocks
namespace ActualMobiusDoubleQDualSpacingSaving

noncomputable section

def p (lambda : ℝ) : ℝ := 1 - 2 * lambda / 5
def q (lambda : ℝ) : ℝ := lambda / 5
def middleEndpoint (lambda : ℝ) : ℝ :=
  (2 * p lambda + 5 * q lambda) / 3

theorem physical_scale (lambda : ℝ) :
    p lambda + 2 * q lambda = 1 := by
  simp [p, q]
  ring

theorem middle_endpoint_eq (lambda : ℝ) :
    middleEndpoint lambda = (2 + q lambda) / 3 := by
  simp [middleEndpoint, p, q]
  ring

/-- The `G^2 U^2/F` spacing term contributes Gram ratio F/Q^2. -/
theorem long_interval_ratio_exponent (lambda f : ℝ) :
    f - 2 * q lambda = f - 2 * q lambda := rfl

/-- The `G^2 U` spacing term contributes Gram ratio
F^(3/2)/(P Q^(5/2)). -/
theorem unit_interval_ratio_exponent (lambda f : ℝ) :
    3 * f / 2 - p lambda - 5 * q lambda / 2 =
      3 * f / 2 - p lambda - 5 * q lambda / 2 := rfl

theorem unit_interval_balances_at_endpoint (lambda : ℝ) :
    3 * middleEndpoint lambda / 2 - p lambda - 5 * q lambda / 2 = 0 := by
  simp [middleEndpoint]
  ring

theorem endpoint_below_two_q {lambda : ℝ} (hlambda : 2 < lambda) :
    middleEndpoint lambda < 2 * q lambda := by
  simp [middleEndpoint, p, q]
  linarith

theorem endpoint_above_three_halves_q {lambda : ℝ}
    (hlambda : lambda < 20 / 7) :
    3 * q lambda / 2 < middleEndpoint lambda := by
  simp [middleEndpoint, p, q]
  linarith

theorem public_range_extension {lambda : ℝ}
    (hlow : 2 < lambda) (hhigh : lambda < 29 / 14) :
    3 * q lambda / 2 < middleEndpoint lambda ∧
      middleEndpoint lambda < 2 * q lambda := by
  constructor
  · apply endpoint_above_three_halves_q
    linarith
  · exact endpoint_below_two_q hlow

theorem first_term_endpoint_saving (lambda : ℝ) :
    2 * q lambda - middleEndpoint lambda = (lambda - 2) / 3 := by
  simp [middleEndpoint, p, q]
  ring

theorem unit_interval_margin_saving (lambda kappa : ℝ) :
    p lambda + 5 * q lambda / 2 -
        3 * (middleEndpoint lambda - kappa) / 2 =
      3 * kappa / 2 := by
  rw [show p lambda + 5 * q lambda / 2 =
    3 * middleEndpoint lambda / 2 by
      simp [middleEndpoint]
      ring]
  ring

theorem long_interval_margin_saving (lambda kappa : ℝ) :
    2 * q lambda - (middleEndpoint lambda - kappa) =
      (lambda - 2) / 3 + kappa := by
  calc
    2 * q lambda - (middleEndpoint lambda - kappa) =
        (2 * q lambda - middleEndpoint lambda) + kappa := by ring
    _ = (lambda - 2) / 3 + kappa := by
      rw [first_term_endpoint_saving]

theorem stationary_window_nonempty {lambda kappa : ℝ}
    (hmargin : kappa < middleEndpoint lambda - q lambda) :
    q lambda < middleEndpoint lambda - kappa := by
  linarith

theorem stationary_overlaps_full_rank {lambda rho : ℝ}
    (hoverlap : rho < q lambda / 2) :
    q lambda < 3 * q lambda / 2 - rho := by
  linarith

/-- A total stationary-expansion error of size P^3 saves Q^3 relative
to the double-Cauchy Gram target P^3 Q^3. -/
theorem stationary_remainder_gram_saving (lambda : ℝ) :
    (3 * p lambda + 3 * q lambda) - 3 * p lambda = 3 * q lambda := by
  ring

/-- The diagonal size P^2 Q^3 saves P relative to P^3 Q^3. -/
theorem diagonal_gram_saving (lambda : ℝ) :
    (3 * p lambda + 3 * q lambda) -
        (2 * p lambda + 3 * q lambda) = p lambda := by
  ring

theorem p_pos {lambda : ℝ} (hlambda : lambda < 5 / 2) :
    0 < p lambda := by
  simp [p]
  linarith

end
end ActualMobiusDoubleQDualSpacingSaving
end BuildingBlocks
