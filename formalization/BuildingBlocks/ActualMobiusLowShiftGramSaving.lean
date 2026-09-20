import Mathlib

/-!
# Exponent ledger for the smooth-Gram determinant saving

This module checks only the scale and exponent algebra in
actual-mobius-low-shift-gram-saving.md. It does not formalize the K = 3
history expansion, determinant representation count, weighted Cauchy
reduction, second-derivative estimate, or an implication for RH.
-/

namespace BuildingBlocks
namespace ActualMobiusLowShiftGramSaving

noncomputable section

def p (lambda : ℝ) : ℝ := 1 - 2 * lambda / 5
def q (lambda : ℝ) : ℝ := lambda / 5

theorem physical_scale (lambda : ℝ) :
    p lambda + 2 * q lambda = 1 := by
  simp [p, q]
  ring

theorem q_pos {lambda : ℝ} (hlow : 2 < lambda) :
    0 < q lambda := by
  simp [q]
  linarith

theorem p_cubed_lt_pq {lambda : ℝ} (hlow : 2 < lambda) :
    3 * p lambda < p lambda + q lambda := by
  simp [p, q]
  linarith

/-- In the range H at most P, the absolute bound P^3 Q^3 is below
the Gram target P^3 Q^4 by exponent q. -/
theorem small_range_gram_gap (lambda : ℝ) :
    (3 * p lambda + 4 * q lambda) -
        (3 * p lambda + 3 * q lambda) =
      q lambda := by
  ring

/-- At H = P Q, the middle-range bound
P^2 Q^2 (T H)^(1/2) has exponent 3p + 7q/2. -/
theorem middle_endpoint_bound_exponent (lambda : ℝ) :
    2 * p lambda + 2 * q lambda +
        (1 + p lambda + q lambda) / 2 =
      3 * p lambda + 7 * q lambda / 2 := by
  rw [← physical_scale lambda]
  ring

theorem middle_range_gram_gap (lambda : ℝ) :
    (3 * p lambda + 4 * q lambda) -
        (3 * p lambda + 7 * q lambda / 2) =
      q lambda / 2 := by
  ring

/-- In the high smooth range, the bound
P^(3/2) Q^2 H^(3/2), evaluated at
H = P Q^(4/3) T^(-kappa), is the Gram target minus 3kappa/2. -/
theorem high_endpoint_bound_exponent (lambda kappa : ℝ) :
    3 * p lambda / 2 + 2 * q lambda +
        3 * (p lambda + 4 * q lambda / 3 - kappa) / 2 =
      3 * p lambda + 4 * q lambda - 3 * kappa / 2 := by
  ring

theorem high_range_gram_saving (lambda kappa : ℝ) :
    (3 * p lambda + 4 * q lambda) -
        (3 * p lambda + 4 * q lambda - 3 * kappa / 2) =
      3 * kappa / 2 := by
  ring

theorem high_range_conditional_sqrt_scale (lambda kappa : ℝ) :
    ((3 * p lambda + 4 * q lambda) -
        (3 * p lambda + 4 * q lambda - 3 * kappa / 2)) / 2 =
      3 * kappa / 4 := by
  ring

/-- The high endpoint exceeds P Q by exponent q/3 - kappa. -/
theorem high_endpoint_above_pq_gap (lambda kappa : ℝ) :
    (p lambda + 4 * q lambda / 3 - kappa) -
        (p lambda + q lambda) =
      q lambda / 3 - kappa := by
  ring

theorem high_endpoint_above_pq {lambda kappa : ℝ}
    (hkappa : kappa < q lambda / 3) :
    p lambda + q lambda <
      p lambda + 4 * q lambda / 3 - kappa := by
  have h := high_endpoint_above_pq_gap lambda kappa
  linarith

theorem high_endpoint_above_p_cubed {lambda kappa : ℝ}
    (hlow : 2 < lambda) (hkappa : kappa < q lambda / 3) :
    3 * p lambda <
      p lambda + 4 * q lambda / 3 - kappa := by
  exact lt_trans (p_cubed_lt_pq hlow) (high_endpoint_above_pq hkappa)

/-- Under kappa < q/3, the high-range Gram saving 3kappa/2 is
smaller than the middle-range saving q/2 and therefore controls the
uniform exponent. -/
theorem high_saving_below_middle {lambda kappa : ℝ}
    (hkappa : kappa < q lambda / 3) :
    3 * kappa / 2 < q lambda / 2 := by
  linarith

/-- Algebraic comparison only: the public endpoint-error saving q/2 is
stronger than the conditional square-root scale 3kappa/4. -/
theorem endpoint_error_stronger {lambda kappa : ℝ}
    (hlow : 2 < lambda) (hkappa : kappa < q lambda / 3) :
    3 * kappa / 4 < q lambda / 2 := by
  have hq := q_pos hlow
  linarith

/-- The exact diagonal P^2 Q^3 is below the Gram target by exponent p+q. -/
theorem diagonal_gram_gap (lambda : ℝ) :
    (3 * p lambda + 4 * q lambda) -
        (2 * p lambda + 3 * q lambda) =
      p lambda + q lambda := by
  ring

/-- Canonical choice kappa = q/6. -/
theorem canonical_kappa_pos {lambda : ℝ} (hlow : 2 < lambda) :
    0 < q lambda / 6 := by
  have hq := q_pos hlow
  linarith

theorem canonical_kappa_lt_third {lambda : ℝ} (hlow : 2 < lambda) :
    q lambda / 6 < q lambda / 3 := by
  have hq := q_pos hlow
  linarith

theorem canonical_upper_exponent (lambda : ℝ) :
    p lambda + 4 * q lambda / 3 - q lambda / 6 =
      p lambda + 7 * q lambda / 6 := by
  ring

theorem canonical_gram_saving (lambda : ℝ) :
    3 * (q lambda / 6) / 2 = q lambda / 4 := by
  ring

theorem canonical_conditional_sqrt_scale (lambda : ℝ) :
    3 * (q lambda / 6) / 4 = q lambda / 8 := by
  ring

end
end ActualMobiusLowShiftGramSaving
end BuildingBlocks
