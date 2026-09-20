import Mathlib

/-!
# Scale ledger for the double-Q full-rank Gram estimate

This module checks only exponent algebra. It does not formalize the
analytic double Cauchy, Poisson, stationary-phase, or determinant-count
arguments, and it proves no statement about RH.
-/

namespace BuildingBlocks
namespace ActualMobiusDoubleQFullRankGram

noncomputable section

def p (lambda : ℝ) : ℝ := 1 - 2 * lambda / 5
def q (lambda : ℝ) : ℝ := lambda / 5

theorem physical_scale (lambda : ℝ) :
    p lambda + 2 * q lambda = 1 := by
  simp [p, q]
  ring

/-- Double weighted Cauchy changes the Gram target to P^3 Q^3. -/
theorem double_cauchy_gram_target_exponent (lambda : ℝ) :
    (2 * p lambda + 5 * q lambda) -
        (2 * q lambda - p lambda) =
      3 * p lambda + 3 * q lambda := by
  ring

/-- With F = QG/P, the fixed-difference outer count is P^3 F. -/
theorem outer_count_exponent (lambda fexp : ℝ) :
    (fexp + p lambda - q lambda) +
        2 * p lambda + q lambda =
      3 * p lambda + fexp := by
  ring

/-- At F = Q^(3/2) T^(-kappa), the leading F^2 term is the
double-Cauchy Gram target minus 2kappa. -/
theorem high_endpoint_exponent (lambda kappa : ℝ) :
    3 * p lambda + 2 * (3 * q lambda / 2 - kappa) =
      3 * p lambda + 3 * q lambda - 2 * kappa := by
  ring

theorem parameterized_gram_saving (lambda kappa : ℝ) :
    (3 * p lambda + 3 * q lambda) -
        (3 * p lambda + 3 * q lambda - 2 * kappa) =
      2 * kappa := by
  ring

theorem parameterized_conditional_sqrt_scale (lambda kappa : ℝ) :
    ((3 * p lambda + 3 * q lambda) -
        (3 * p lambda + 3 * q lambda - 2 * kappa)) / 2 =
      kappa := by
  ring

/-- The Q^(-1) term has exponent saving q. -/
theorem reciprocal_q_saving (lambda : ℝ) :
    q lambda = q lambda := rfl

/-- At the parameterized endpoint, F/Q^2 has exponent
-q/2-kappa. -/
theorem middle_term_saving (lambda kappa : ℝ) :
    2 * q lambda - (3 * q lambda / 2 - kappa) =
      q lambda / 2 + kappa := by
  ring

theorem uniform_saving_from_kappa_lt_half {lambda kappa : ℝ}
    (hkappa : kappa < q lambda / 2) :
    2 * kappa < q lambda ∧
      2 * kappa < q lambda / 2 + kappa := by
  constructor <;> linarith

/-- The original determinant scale h is Q times the difference g. -/
theorem determinant_from_difference (lambda gexp : ℝ) :
    q lambda + gexp = gexp + q lambda := by
  ring

/-- Canonical choice kappa=q/4. -/
theorem canonical_kappa_pos {lambda : ℝ} (hlambda : 0 < lambda) :
    0 < q lambda / 4 := by
  simp [q]
  linarith

theorem canonical_kappa_lt_half {lambda : ℝ} (hlambda : 0 < lambda) :
    q lambda / 4 < q lambda / 2 := by
  simp [q]
  linarith

theorem canonical_f_exponent (lambda : ℝ) :
    3 * q lambda / 2 - q lambda / 4 =
      5 * q lambda / 4 := by
  ring

theorem canonical_g_exponent (lambda : ℝ) :
    (3 * q lambda / 2 - q lambda / 4) +
        p lambda - q lambda =
      p lambda + q lambda / 4 := by
  ring

theorem canonical_h_exponent (lambda : ℝ) :
    q lambda +
        ((3 * q lambda / 2 - q lambda / 4) +
          p lambda - q lambda) =
      p lambda + 5 * q lambda / 4 := by
  ring

theorem canonical_gram_saving (lambda : ℝ) :
    2 * (q lambda / 4) = q lambda / 2 := by
  ring

theorem canonical_conditional_sqrt_scale (lambda : ℝ) :
    q lambda / 4 = q lambda / 4 := rfl

end
end ActualMobiusDoubleQFullRankGram
end BuildingBlocks
