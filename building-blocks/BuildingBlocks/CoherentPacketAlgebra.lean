import Mathlib.Tactic

namespace PaidThetaCompensation

/-!
Finite Hermitian algebra used for the coherent endpoint-packet calculation.
The analytic consumer supplies continuous and prime column norms and their
mixed pairing.
-/

/-- Exact square of a coherent complex column sum. -/
theorem complex_normSq_add (z w : ℂ) :
    Complex.normSq (z + w) = Complex.normSq z + Complex.normSq w +
      2 * (z * star w).re := by
  simp [Complex.normSq_apply]
  ring

/-- If the mixed pairing is bounded by `b`, the coherent total differs from
its prime diagonal by at most the continuous diagonal plus `2b`. -/
theorem coherent_total_deviation
    {continuous prime mixed total b : ℝ}
    (hc : 0 ≤ continuous)
    (hm : |mixed| ≤ b)
    (htotal : total = continuous + prime + 2 * mixed) :
    |total - prime| ≤ continuous + 2 * b := by
  rw [htotal]
  have hm' : |2 * mixed| ≤ 2 * b := by
    rw [abs_mul]
    norm_num
    linarith
  calc
    |continuous + prime + 2 * mixed - prime| = |continuous + 2 * mixed| := by ring_nf
    _ ≤ |continuous| + |2 * mixed| := abs_add_le _ _
    _ ≤ continuous + 2 * b := by simpa [abs_of_nonneg hc] using add_le_add_right hm' continuous

/-- Cauchy-type scalar data imply a concrete coherent deviation bound. -/
theorem coherent_deviation_of_cross_square
    {continuous prime mixed total : ℝ}
    (hc : 0 ≤ continuous) (hp : 0 ≤ prime)
    (hm : mixed^2 ≤ continuous * prime)
    (htotal : total = continuous + prime + 2 * mixed) :
    |total - prime| ≤ continuous + 2 * Real.sqrt (continuous * prime) := by
  apply coherent_total_deviation hc _ htotal
  rw [abs_le]
  constructor
  · have hs : 0 ≤ Real.sqrt (continuous * prime) := Real.sqrt_nonneg _
    nlinarith [Real.sq_sqrt (mul_nonneg hc hp)]
  · have hs : 0 ≤ Real.sqrt (continuous * prime) := Real.sqrt_nonneg _
    nlinarith [Real.sq_sqrt (mul_nonneg hc hp)]

/-- Exact quadratic perturbation identity for a finite nullspace correction. -/
theorem quadratic_correction_identity
    (raw correction : ℂ) :
    Complex.normSq (raw - correction) =
      Complex.normSq raw + Complex.normSq correction -
        2 * (raw * star correction).re := by
  simp [Complex.normSq_apply]
  ring

/-- A uniformly bounded coherent port is negligible compared with a supply
that grows linearly in the logarithmic scale. -/
theorem bounded_port_over_linear_supply
    {port supply P c L : ℝ}
    (hport0 : 0 ≤ port) (hport : port ≤ P)
    (hc : 0 < c) (hL : 0 < L)
    (hsupply : c * L ≤ supply) :
    port / supply ≤ P / (c * L) := by
  have hspos : 0 < supply := lt_of_lt_of_le (mul_pos hc hL) hsupply
  have hden : 0 < c * L := mul_pos hc hL
  calc
    port / supply ≤ P / supply := div_le_div_of_nonneg_right hport hspos.le
    _ ≤ P / (c * L) := by
      have hP : 0 ≤ P := le_trans hport0 hport
      exact div_le_div_of_nonneg_left hP hden hsupply

end PaidThetaCompensation

#print axioms PaidThetaCompensation.complex_normSq_add
#print axioms PaidThetaCompensation.coherent_total_deviation
#print axioms PaidThetaCompensation.coherent_deviation_of_cross_square
#print axioms PaidThetaCompensation.quadratic_correction_identity
#print axioms PaidThetaCompensation.bounded_port_over_linear_supply
