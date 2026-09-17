import Mathlib.Analysis.Complex.Norm
import Mathlib.Tactic

namespace BuildingBlocks.ActualAnnulusGramAlgebra

/-- The exact two-bump Hermitian prime cross is controlled by its absolute value.
This is the finite-dimensional step in the written annular Weil theorem. -/
theorem signed_gram_lower (d : ℝ) (p a b : ℂ) :
    (d - ‖p‖) * (Complex.normSq a + Complex.normSq b) ≤
      d * (Complex.normSq a + Complex.normSq b) -
        2 * (b * star a * p).re := by
  have hre : (b * star a * p).re ≤ ‖p‖ * ‖a‖ * ‖b‖ := by
    calc
      _ ≤ ‖b * star a * p‖ := Complex.re_le_norm _
      _ = ‖p‖ * ‖a‖ * ‖b‖ := by simp [mul_comm, mul_assoc]
  have hamgm : 2 * ‖a‖ * ‖b‖ ≤ ‖a‖ ^ 2 + ‖b‖ ^ 2 :=
    two_mul_le_add_sq _ _
  have hp : 0 ≤ ‖p‖ := norm_nonneg _
  rw [Complex.normSq_eq_norm_sq, Complex.normSq_eq_norm_sq]
  nlinarith [mul_nonneg hp (sub_nonneg.mpr hamgm)]

theorem signed_gram_pos {d : ℝ} {p a b : ℂ}
    (hmargin : ‖p‖ < d) (hnonzero : a ≠ 0 ∨ b ≠ 0) :
    0 < d * (Complex.normSq a + Complex.normSq b) -
      2 * (b * star a * p).re := by
  have hsum : 0 < Complex.normSq a + Complex.normSq b := by
    rw [Complex.normSq_eq_norm_sq, Complex.normSq_eq_norm_sq]
    rcases hnonzero with ha | hb
    · have hna : 0 < ‖a‖ := norm_pos_iff.mpr ha
      nlinarith [sq_nonneg ‖b‖]
    · have hnb : 0 < ‖b‖ := norm_pos_iff.mpr hb
      nlinarith [sq_nonneg ‖a‖]
  have hprod : 0 < (d - ‖p‖) *
      (Complex.normSq a + Complex.normSq b) :=
    mul_pos (sub_pos.mpr hmargin) hsum
  exact lt_of_lt_of_le hprod (signed_gram_lower d p a b)

end BuildingBlocks.ActualAnnulusGramAlgebra

#print axioms BuildingBlocks.ActualAnnulusGramAlgebra.signed_gram_lower
#print axioms BuildingBlocks.ActualAnnulusGramAlgebra.signed_gram_pos
