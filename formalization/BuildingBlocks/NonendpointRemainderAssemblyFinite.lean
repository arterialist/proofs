import Mathlib.Tactic
import Mathlib.Analysis.InnerProductSpace.Basic

/-!
# Finite Hilbert-space assembly of a non-endpoint expansion

This is the exact algebra needed after the prime-density correction and all
row errors have been placed in one remainder vector.
-/

namespace BuildingBlocks.NonendpointRemainderAssemblyFinite

noncomputable section

/-- Exact square expansion retaining the second correction square and both
remainder cross terms. -/
theorem corrected_profile_square
    {E : Type*} [SeminormedAddCommGroup E] [InnerProductSpace ℝ E]
    (F J R : E) (ell : ℝ) :
    ‖-F + ell • J + R‖ ^ 2 =
      ‖F‖ ^ 2 - 2 * ell * inner ℝ F J + ell ^ 2 * ‖J‖ ^ 2 +
        2 * inner ℝ (-F + ell • J) R + ‖R‖ ^ 2 := by
  rw [show -F + ell • J + R = (-F + ell • J) + R by rfl]
  rw [norm_add_sq_real]
  have hbase : ‖-F + ell • J‖ ^ 2 =
      ‖F‖ ^ 2 - 2 * ell * inner ℝ F J + ell ^ 2 * ‖J‖ ^ 2 := by
    rw [show -F + ell • J = -(F - ell • J) by module]
    rw [norm_neg, norm_sub_sq_real, inner_smul_right, norm_smul, Real.norm_eq_abs]
    have habs : |ell| ^ 2 = ell ^ 2 := sq_abs ell
    rw [mul_pow, habs]
    ring
  rw [hbase]

/-- Cauchy propagation of a row-norm error into the squared energy. -/
theorem corrected_profile_square_error_le
    {E : Type*} [SeminormedAddCommGroup E] [InnerProductSpace ℝ E]
    (F J R : E) (ell : ℝ) :
    |‖-F + ell • J + R‖ ^ 2 -
        (‖F‖ ^ 2 - 2 * ell * inner ℝ F J)| ≤
      ell ^ 2 * ‖J‖ ^ 2 +
        2 * (‖F‖ + |ell| * ‖J‖) * ‖R‖ + ‖R‖ ^ 2 := by
  rw [corrected_profile_square]
  have hcross :
      |inner ℝ (-F + ell • J) R| ≤
        (‖F‖ + |ell| * ‖J‖) * ‖R‖ := by
    calc
      |inner ℝ (-F + ell • J) R| ≤ ‖-F + ell • J‖ * ‖R‖ :=
        abs_real_inner_le_norm _ _
      _ ≤ (‖F‖ + |ell| * ‖J‖) * ‖R‖ := by
        apply mul_le_mul_of_nonneg_right _ (norm_nonneg _)
        calc
          ‖-F + ell • J‖ ≤ ‖-F‖ + ‖ell • J‖ := norm_add_le _ _
          _ = ‖F‖ + |ell| * ‖J‖ := by
            rw [norm_neg, norm_smul, Real.norm_eq_abs]
  have hnonneg1 : 0 ≤ ell ^ 2 * ‖J‖ ^ 2 := mul_nonneg (sq_nonneg _) (sq_nonneg _)
  have hnonneg2 : 0 ≤ ‖R‖ ^ 2 := sq_nonneg _
  calc
    |‖F‖ ^ 2 - 2 * ell * inner ℝ F J + ell ^ 2 * ‖J‖ ^ 2 +
          2 * inner ℝ (-F + ell • J) R + ‖R‖ ^ 2 -
        (‖F‖ ^ 2 - 2 * ell * inner ℝ F J)| =
        |ell ^ 2 * ‖J‖ ^ 2 + 2 * inner ℝ (-F + ell • J) R + ‖R‖ ^ 2| := by
      congr 1
      ring
    _ ≤ |ell ^ 2 * ‖J‖ ^ 2| +
          |2 * inner ℝ (-F + ell • J) R| + |‖R‖ ^ 2| := by
      exact abs_add_three _ _ _
    _ = ell ^ 2 * ‖J‖ ^ 2 +
          2 * |inner ℝ (-F + ell • J) R| + ‖R‖ ^ 2 := by
      rw [abs_of_nonneg hnonneg1, abs_mul, abs_of_nonneg hnonneg2]
      norm_num
    _ ≤ ell ^ 2 * ‖J‖ ^ 2 +
          2 * ((‖F‖ + |ell| * ‖J‖) * ‖R‖) + ‖R‖ ^ 2 := by
      gcongr
    _ = ell ^ 2 * ‖J‖ ^ 2 +
          2 * (‖F‖ + |ell| * ‖J‖) * ‖R‖ + ‖R‖ ^ 2 := by ring

end
end BuildingBlocks.NonendpointRemainderAssemblyFinite

#print axioms BuildingBlocks.NonendpointRemainderAssemblyFinite.corrected_profile_square
#print axioms BuildingBlocks.NonendpointRemainderAssemblyFinite.corrected_profile_square_error_le
