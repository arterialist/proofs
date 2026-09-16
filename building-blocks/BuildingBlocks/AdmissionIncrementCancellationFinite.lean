import Mathlib.Tactic
import Mathlib.Analysis.InnerProductSpace.Basic

/-!
# Finite cancellation algebra for an admission increment

The common remainder at two adjacent levels is kept as one vector.  Only its
newly admitted part is subtracted.  Polarization then pairs the common
remainder with the local model face instead of charging it twice by norm.
-/

namespace BuildingBlocks.AdmissionIncrementCancellationFinite

noncomputable section

/-- The exact fixed-profile admission identity. -/
theorem model_admission
    {E : Type*} [SeminormedAddCommGroup E] [InnerProductSpace ℝ E]
    (F U : E) :
    ‖F - U‖ ^ 2 - ‖F‖ ^ 2 = ‖U‖ ^ 2 - 2 * inner ℝ F U := by
  rw [norm_sub_sq_real]
  ring

/-- Exact increment error when both the model and its row remainder acquire
a local admitted face.  This is the algebra behind direct row differencing. -/
theorem increment_error_identity
    {E : Type*} [SeminormedAddCommGroup E] [InnerProductSpace ℝ E]
    (F U R V : E) :
    ((‖(F - U) + (R - V)‖ ^ 2 - ‖F + R‖ ^ 2) -
        (‖F - U‖ ^ 2 - ‖F‖ ^ 2)) =
      -2 * inner ℝ U R - 2 * inner ℝ (F - U) V -
        2 * inner ℝ R V + ‖V‖ ^ 2 := by
  rw [norm_add_sq_real, norm_add_sq_real]
  simp only [inner_sub_left, inner_sub_right, norm_sub_sq_real]
  ring

/-- Norm bound for the direct increment error.  In particular, the old row
remainder is multiplied by the local model face `U`; there is no bare
`2 * ‖R‖` level-error term. -/
theorem increment_error_le
    {E : Type*} [SeminormedAddCommGroup E] [InnerProductSpace ℝ E]
    (F U R V : E) :
    |((‖(F - U) + (R - V)‖ ^ 2 - ‖F + R‖ ^ 2) -
        (‖F - U‖ ^ 2 - ‖F‖ ^ 2))| ≤
      2 * ‖U‖ * ‖R‖ + 2 * ‖F - U‖ * ‖V‖ +
        2 * ‖R‖ * ‖V‖ + ‖V‖ ^ 2 := by
  rw [increment_error_identity]
  calc
    |-2 * inner ℝ U R - 2 * inner ℝ (F - U) V -
        2 * inner ℝ R V + ‖V‖ ^ 2| ≤
        |-2 * inner ℝ U R| + |-2 * inner ℝ (F - U) V| +
          |-2 * inner ℝ R V| + |‖V‖ ^ 2| := by
            rw [show -2 * inner ℝ U R - 2 * inner ℝ (F - U) V -
                2 * inner ℝ R V + ‖V‖ ^ 2 =
                ((-2 * inner ℝ U R) + (-2 * inner ℝ (F - U) V) +
                  (-2 * inner ℝ R V)) + ‖V‖ ^ 2 by ring]
            exact le_trans (abs_add_le _ _)
              (add_le_add_right (abs_add_three _ _ _) _)
    _ = 2 * |inner ℝ U R| + 2 * |inner ℝ (F - U) V| +
          2 * |inner ℝ R V| + ‖V‖ ^ 2 := by
            rw [abs_mul, abs_mul, abs_mul]
            norm_num [abs_of_nonneg (sq_nonneg ‖V‖)]
    _ ≤ 2 * (‖U‖ * ‖R‖) + 2 * (‖F - U‖ * ‖V‖) +
          2 * (‖R‖ * ‖V‖) + ‖V‖ ^ 2 := by
            gcongr
            · exact abs_real_inner_le_norm _ _
            · exact abs_real_inner_le_norm _ _
            · exact abs_real_inner_le_norm _ _
    _ = 2 * ‖U‖ * ‖R‖ + 2 * ‖F - U‖ * ‖V‖ +
          2 * ‖R‖ * ‖V‖ + ‖V‖ ^ 2 := by ring

/-- The bilinear first-correction coefficient also localizes to the new
faces, with every mixed orientation retained. -/
theorem bilinear_admission
    {E : Type*} [SeminormedAddCommGroup E] [InnerProductSpace ℝ E]
    (F J U W : E) :
    inner ℝ (F - U) (J - W) - inner ℝ F J =
      -inner ℝ U J - inner ℝ F W + inner ℝ U W := by
  rw [inner_sub_left, inner_sub_right, inner_sub_right]
  ring

/-- Abstract Boolean-face pairing: a packet whose new state is obtained by
subtracting the prime-dilated old faces has the stated exact increment. -/
theorem face_pairing
    {ι E : Type*} [Fintype ι] [AddCommGroup E]
    (oldFace newFace : ι → E)
    (hpair : ∀ i, newFace i = -oldFace i) :
    (∑ i, newFace i) = -(∑ i, oldFace i) := by
  simp_rw [hpair]
  simp

end
end BuildingBlocks.AdmissionIncrementCancellationFinite

#print axioms BuildingBlocks.AdmissionIncrementCancellationFinite.model_admission
#print axioms BuildingBlocks.AdmissionIncrementCancellationFinite.increment_error_identity
#print axioms BuildingBlocks.AdmissionIncrementCancellationFinite.increment_error_le
#print axioms BuildingBlocks.AdmissionIncrementCancellationFinite.bilinear_admission
#print axioms BuildingBlocks.AdmissionIncrementCancellationFinite.face_pairing
