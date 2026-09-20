import Mathlib

/-!
# Exponent ledger for the actual low-shift Möbius Gram saving

This module checks only the scale and exponent algebra in
actual-mobius-low-shift-gram-saving.md. It does not formalize the K = 3
history expansion, determinant representation count, Cauchy reduction,
analytic endpoint theorem, or an implication for RH.
-/

namespace BuildingBlocks
namespace ActualMobiusLowShiftGramSaving

noncomputable section

def p (lambda : ℝ) : ℝ := 1 - 2 * lambda / 5
def q (lambda : ℝ) : ℝ := lambda / 5

/-- The physical scale relation P Q^2 = T. -/
theorem physical_scale (lambda : ℝ) :
    p lambda + 2 * q lambda = 1 := by
  simp [p, q]
  ring

/-- The low-shift endpoint P^3 lies below P Q exactly when lambda > 2. -/
theorem p_cubed_lt_pq {lambda : ℝ} (hlow : 2 < lambda) :
    3 * p lambda < p lambda + q lambda := by
  simp [p, q]
  linarith

/-- At the upper shift H = P Q T^(-kappa), the absolute bound
H P^2 Q^3 has exponent equal to the Gram target minus kappa. -/
theorem parameterized_endpoint_bound_exponent (lambda kappa : ℝ) :
    (p lambda + q lambda - kappa) +
        2 * p lambda + 3 * q lambda =
      3 * p lambda + 4 * q lambda - kappa := by
  ring

theorem parameterized_gram_saving (lambda kappa : ℝ) :
    (3 * p lambda + 4 * q lambda) -
        (3 * p lambda + 4 * q lambda - kappa) =
      kappa := by
  ring

/-- The parameterized upper range extends strictly past P^3 whenever
kappa < lambda - 2. -/
theorem parameterized_range_gap (lambda kappa : ℝ) :
    (p lambda + q lambda - kappa) - 3 * p lambda =
      lambda - 2 - kappa := by
  simp [p, q]
  ring

theorem parameterized_range_extends_p_cubed {lambda kappa : ℝ}
    (hkappa : kappa < lambda - 2) :
    3 * p lambda < p lambda + q lambda - kappa := by
  have h := parameterized_range_gap lambda kappa
  linarith

theorem parameterized_original_sum_saving (lambda kappa : ℝ) :
    ((3 * p lambda + 4 * q lambda) -
        (3 * p lambda + 4 * q lambda - kappa)) / 2 =
      kappa / 2 := by
  ring

/-- At H = P^3, the absolute bound H P^2 Q^3 has exponent 5p + 3q. -/
theorem absolute_endpoint_bound_exponent (lambda : ℝ) :
    3 * p lambda + 2 * p lambda + 3 * q lambda =
      5 * p lambda + 3 * q lambda := by
  ring

/-- Relative to the Gram target P^3 Q^4, the low-shift endpoint
absolute bound saves exponent lambda - 2. -/
theorem gram_saving_identity (lambda : ℝ) :
    (3 * p lambda + 4 * q lambda) -
        (5 * p lambda + 3 * q lambda) =
      lambda - 2 := by
  simp [p, q]
  ring

theorem gram_saving_positive {lambda : ℝ} (hlow : 2 < lambda) :
    5 * p lambda + 3 * q lambda <
      3 * p lambda + 4 * q lambda := by
  have h := gram_saving_identity lambda
  linarith

/-- The outer Cauchy step takes a square root, leaving half of the
Gram exponent saving in the original one-Poisson sum. -/
theorem original_sum_saving_identity (lambda : ℝ) :
    ((3 * p lambda + 4 * q lambda) -
        (5 * p lambda + 3 * q lambda)) / 2 =
      (lambda - 2) / 2 := by
  rw [gram_saving_identity]

theorem original_sum_saving_positive {lambda : ℝ} (hlow : 2 < lambda) :
    0 < (lambda - 2) / 2 := by
  linarith

/-- The endpoint-error saving q/2 exceeds the low-shift original-sum
saving by exactly p. -/
theorem endpoint_error_saving_gap (lambda : ℝ) :
    q lambda / 2 - (lambda - 2) / 2 = p lambda := by
  simp [p, q]
  ring

theorem p_pos {lambda : ℝ} (hhigh : lambda < 29 / 14) :
    0 < p lambda := by
  simp [p]
  norm_num at hhigh ⊢
  linarith

theorem endpoint_error_saving_stronger {lambda : ℝ}
    (hhigh : lambda < 29 / 14) :
    (lambda - 2) / 2 < q lambda / 2 := by
  have hgap := endpoint_error_saving_gap lambda
  have hp := p_pos hhigh
  linarith

/-- The canonical choice kappa = (lambda - 2)/2 is positive. -/
theorem canonical_kappa_pos {lambda : ℝ} (hlow : 2 < lambda) :
    0 < (lambda - 2) / 2 := by
  linarith

theorem canonical_kappa_lt {lambda : ℝ} (hlow : 2 < lambda) :
    (lambda - 2) / 2 < lambda - 2 := by
  linarith

/-- The canonical upper range extends past P^3 by exponent
(lambda - 2)/2. -/
theorem canonical_range_gap (lambda : ℝ) :
    (p lambda + q lambda - (lambda - 2) / 2) -
        3 * p lambda =
      (lambda - 2) / 2 := by
  simp [p, q]
  ring

theorem canonical_original_sum_saving (lambda : ℝ) :
    ((lambda - 2) / 2) / 2 = (lambda - 2) / 4 := by
  ring

theorem parameterized_endpoint_error_stronger {lambda kappa : ℝ}
    (hkappa : kappa < lambda - 2)
    (hhigh : lambda < 29 / 14) :
    kappa / 2 < q lambda / 2 := by
  have hfixed := endpoint_error_saving_stronger hhigh
  linarith

end
end ActualMobiusLowShiftGramSaving
end BuildingBlocks
