import Mathlib.Tactic
import Mathlib.Analysis.InnerProductSpace.Basic

/-!
# Finite endpoint-admission increment algebra

The analytic estimates and geometric weights are external hypotheses.  This
module keeps every cross term and formalizes the constant-mode collapse that
uses the zero total Möbius mass.
-/

namespace BuildingBlocks.EndpointAdmissionIncrementFinite

noncomputable section

/-- Exact endpoint contribution to a full energy admission.  `Z` is the old
nonendpoint row, `D` its admission, `E` the old endpoint, and `W` the newly
admitted endpoint packet. -/
theorem endpoint_increment_expansion
    {H : Type*} [SeminormedAddCommGroup H] [InnerProductSpace ℝ H]
    (Z D E W : H) :
    (‖(Z + D) + (E + W)‖ ^ 2 - ‖Z + E‖ ^ 2) -
        (‖Z + D‖ ^ 2 - ‖Z‖ ^ 2) =
      2 * inner ℝ Z W + 2 * inner ℝ D E + 2 * inner ℝ D W +
        2 * inner ℝ E W + ‖W‖ ^ 2 := by
  simp only [norm_add_sq_real, inner_add_left, inner_add_right]
  ring

/-- Finite constant-mode collapse.  If the old coefficients have total mass
zero and each triangular face has weight `1-r i`, then the negative endpoint
cross is the additive Abel sum `sum a_i r_i`. -/
theorem constant_mode_collapse
    {ι : Type*} [Fintype ι]
    (a r : ι → ℝ)
    (hzero : ∑ i, a i = 0) :
    -(∑ i, a i * (1 - r i)) = ∑ i, a i * r i := by
  calc
    -(∑ i, a i * (1 - r i)) =
        -(∑ i, a i) + ∑ i, a i * r i := by
          simp_rw [mul_sub]
          rw [Finset.sum_sub_distrib]
          ring_nf
    _ = ∑ i, a i * r i := by rw [hzero]; ring

/-- The exact Boolean admission orientation for one new prime. -/
theorem mobius_face_orientation
    {ι A : Type*} [Fintype ι] [AddCommGroup A]
    (oldFace : ι → A) :
    (∑ i, -oldFace i) = -(∑ i, oldFace i) := by
  simp

/-- A five-term absolute estimate retaining the old-endpoint and new-endpoint
cross terms separately. -/
theorem endpoint_increment_error_le
    {H : Type*} [SeminormedAddCommGroup H] [InnerProductSpace ℝ H]
    (Z D E W : H) :
    |(‖(Z + D) + (E + W)‖ ^ 2 - ‖Z + E‖ ^ 2) -
        (‖Z + D‖ ^ 2 - ‖Z‖ ^ 2)| ≤
      2 * ‖Z‖ * ‖W‖ + 2 * ‖D‖ * ‖E‖ + 2 * ‖D‖ * ‖W‖ +
        2 * ‖E‖ * ‖W‖ + ‖W‖ ^ 2 := by
  rw [endpoint_increment_expansion]
  calc
    |2 * inner ℝ Z W + 2 * inner ℝ D E + 2 * inner ℝ D W +
        2 * inner ℝ E W + ‖W‖ ^ 2| ≤
        |2 * inner ℝ Z W| + |2 * inner ℝ D E| + |2 * inner ℝ D W| +
          |2 * inner ℝ E W| + |‖W‖ ^ 2| := by
            rw [show 2 * inner ℝ Z W + 2 * inner ℝ D E +
                2 * inner ℝ D W + 2 * inner ℝ E W + ‖W‖ ^ 2 =
                ((2 * inner ℝ Z W + 2 * inner ℝ D E +
                  2 * inner ℝ D W) + 2 * inner ℝ E W) + ‖W‖ ^ 2 by ring]
            exact le_trans (abs_add_le _ _)
              (add_le_add
                (le_trans (abs_add_le _ _)
                  (add_le_add_right (abs_add_three _ _ _) _))
                (le_refl _))
    _ = 2 * |inner ℝ Z W| + 2 * |inner ℝ D E| +
          2 * |inner ℝ D W| + 2 * |inner ℝ E W| + ‖W‖ ^ 2 := by
            rw [abs_mul, abs_mul, abs_mul, abs_mul]
            norm_num [abs_of_nonneg (sq_nonneg ‖W‖)]
    _ ≤ 2 * (‖Z‖ * ‖W‖) + 2 * (‖D‖ * ‖E‖) +
          2 * (‖D‖ * ‖W‖) + 2 * (‖E‖ * ‖W‖) + ‖W‖ ^ 2 := by
            gcongr <;> exact abs_real_inner_le_norm _ _
    _ = 2 * ‖Z‖ * ‖W‖ + 2 * ‖D‖ * ‖E‖ + 2 * ‖D‖ * ‖W‖ +
          2 * ‖E‖ * ‖W‖ + ‖W‖ ^ 2 := by ring

end
end BuildingBlocks.EndpointAdmissionIncrementFinite

#print axioms BuildingBlocks.EndpointAdmissionIncrementFinite.endpoint_increment_expansion
#print axioms BuildingBlocks.EndpointAdmissionIncrementFinite.constant_mode_collapse
#print axioms BuildingBlocks.EndpointAdmissionIncrementFinite.mobius_face_orientation
#print axioms BuildingBlocks.EndpointAdmissionIncrementFinite.endpoint_increment_error_le
