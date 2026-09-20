import Mathlib

/-!
# Exponent ledger for the fourfold high-block completion

Only scale and exponent identities are formalized.  The analytic transforms,
canonical coefficient provenance, and resonance count are written inputs.
-/

namespace BuildingBlocks
namespace ActualMobiusDoubleQFourfoldResonanceBound

noncomputable section

def p (lambda : ℝ) : ℝ := 1 - 2 * lambda / 5
def q (lambda : ℝ) : ℝ := lambda / 5

theorem physical_scale (lambda : ℝ) :
    p lambda + 2 * q lambda = 1 := by
  simp [p, q]
  ring

/-- The resonance windows have exponents `(3q-f)` and `(q-p)`. -/
theorem window_product_exponent (lambda f : ℝ) :
    (3 * q lambda - f) + (q lambda - p lambda) =
      4 * q lambda - p lambda - f := by
  ring

/-- Adding the two `Q` variables gives the full resonance-count exponent. -/
theorem resonance_count_exponent (lambda f : ℝ) :
    2 * q lambda + (4 * q lambda - p lambda - f) =
      6 * q lambda - p lambda - f := by
  ring

/-- The average-center lower-count construction has the same exponent as
the fixed-center upper count.  Its factors are: determinant tuples
`(Q/P)Q^3`, the two `Q` variables, center-incidence length `Q^5/F`, and
division by the `Q^5` available integer centers. -/
theorem average_center_lower_count_exponent (lambda f : ℝ) :
    ((q lambda - p lambda) + 3 * q lambda) + 2 * q lambda +
        (5 * q lambda - f) - 5 * q lambda =
      6 * q lambda - p lambda - f := by
  ring

/-- Multiplying the Fourier-integral size `P^2 F/Q^2` by the
resonance count gives `P Q^4`. -/
theorem leading_block_exponent (lambda f : ℝ) :
    (2 * p lambda + f - 2 * q lambda) +
        (6 * q lambda - p lambda - f) =
      p lambda + 4 * q lambda := by
  ring

/-- Relative to the Gram target `P^3 Q^3`, the leading ratio is `Q/P^2`. -/
theorem leading_ratio_exponent (lambda : ℝ) :
    (p lambda + 4 * q lambda) -
        (3 * p lambda + 3 * q lambda) =
      q lambda - 2 * p lambda := by
  ring

theorem resonance_excess_eq (lambda : ℝ) :
    q lambda - 2 * p lambda = lambda - 2 := by
  simp [p, q]
  ring

theorem resonance_excess_pos {lambda : ℝ} (hlow : 2 < lambda) :
    0 < q lambda - 2 * p lambda := by
  rw [resonance_excess_eq]
  linarith

theorem resonance_excess_below_one_fourteenth {lambda : ℝ}
    (hhigh : lambda < 29 / 14) :
    q lambda - 2 * p lambda < 1 / 14 := by
  rw [resonance_excess_eq]
  linarith

/-- The cutoff/stationary replacement error has normalized exponent
`p+3q-2f`.  At the barrier `f=2q` this is `p-q`. -/
theorem replacement_error_at_barrier (lambda : ℝ) :
    p lambda + 3 * q lambda - 2 * (2 * q lambda) =
      p lambda - q lambda := by
  ring

theorem p_lt_q {lambda : ℝ} (hlow : 5 / 3 < lambda) :
    p lambda < q lambda := by
  simp [p, q]
  linarith

theorem replacement_error_saves {lambda f : ℝ}
    (hlow : 2 < lambda) (hbarrier : 2 * q lambda ≤ f) :
    p lambda + 3 * q lambda - 2 * f < 0 := by
  have hpq : p lambda < q lambda := p_lt_q (by linarith)
  linarith

/-- The reversed-transform error `Q^{-1}` saves exponent `q`. -/
theorem reverse_error_saves {lambda : ℝ} (hlow : 0 < lambda) :
    0 < q lambda := by
  simp [q]
  linarith

/-- The product diagonal contributes normalized size `P^{-1}`. -/
theorem product_diagonal_saving {lambda : ℝ} (hhigh : lambda < 5 / 2) :
    0 < p lambda := by
  simp [p]
  linarith

end
end ActualMobiusDoubleQFourfoldResonanceBound
end BuildingBlocks
