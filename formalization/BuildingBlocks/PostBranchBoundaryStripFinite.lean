import Mathlib.Tactic

/-!
# Boundary-strip algebra for the post-branch scalar kernel

The analytic facts `0 < q < 1` and positivity of the displayed base
coefficients are kept as explicit hypotheses in the sign theorems.
-/

namespace BuildingBlocks.PostBranchBoundaryStripFinite

noncomputable section

/-- The old-endpoint forward coefficient simplifies to a positive affine
function of the integer distance from the boundary. -/
theorem old_forward_coefficient (q s : ℝ) :
    (1 - q) * (1 + (1 - q) * s - q) =
      (1 - q) ^ 2 * (s + 1) := by
  ring

/-- The new-endpoint forward coefficient has the stated base and slope. -/
theorem new_forward_coefficient (q qp p s : ℝ) :
    (1 - qp) + (1 - q) * p * (s - qp * (s + 1)) =
      (1 - qp - p * qp * (1 - q)) +
        p * (1 - q) * (1 - qp) * s := by
  ring

/-- Interior cancellation of two neighboring affine boundary coefficients.
The slanted boundary relation is supplied as `a = s + h*e`. -/
theorem affine_interior_collapse
    (A C s h e a : ℝ) (he : e ≠ 0) (he1 : e + 1 ≠ 0)
    (ha : a = s + h * e) :
    (A + C * s) / e - (A + C * (s - h)) / (e + 1) =
      (A + C * a) / (e * (e + 1)) := by
  rw [ha]
  field_simp [he, he1]
  ring

/-- On the boundary strip the predecessor lies outside the wedge, leaving
one affine coefficient divided by the current divisor. -/
theorem affine_boundary_strip (A C s e : ℝ) :
    (A + C * s) / e - 0 = (A + C * s) / e := by
  ring

/-- Literal value on the slanted boundary `s=0`. -/
theorem affine_at_boundary (A C e : ℝ) :
    (A + C * 0) / e = A / e := by ring

/-- Literal value one lattice step beyond the boundary. -/
theorem affine_one_beyond (A C e : ℝ) :
    (A + C * 1) / e = (A + C) / e := by ring

/-- Positivity of the boundary-strip coefficient under explicit elementary
hypotheses. -/
theorem affine_boundary_strip_pos
    (A C s e : ℝ) (hA : 0 < A) (hC : 0 ≤ C)
    (hs : 0 ≤ s) (he : 0 < e) :
    0 < (A + C * s) / e := by
  exact div_pos (add_pos_of_pos_of_nonneg hA (mul_nonneg hC hs)) he

/-- Positivity of the separable interior coefficient. -/
theorem affine_interior_pos
    (A C a e : ℝ) (hA : 0 < A) (hC : 0 ≤ C)
    (ha : 0 ≤ a) (he : 0 < e) :
    0 < (A + C * a) / (e * (e + 1)) := by
  have hden : 0 < e * (e + 1) := mul_pos he (by linarith)
  exact div_pos (add_pos_of_pos_of_nonneg hA (mul_nonneg hC ha)) hden

/-- In the cone where only the subtracted new-endpoint wedge is active, the
oriented scalar residual is strictly negative. -/
theorem oriented_single_wedge_neg (newPart : ℝ) (hnew : 0 < newPart) :
    0 - newPart < 0 := by linarith

end
end BuildingBlocks.PostBranchBoundaryStripFinite

#print axioms BuildingBlocks.PostBranchBoundaryStripFinite.old_forward_coefficient
#print axioms BuildingBlocks.PostBranchBoundaryStripFinite.new_forward_coefficient
#print axioms BuildingBlocks.PostBranchBoundaryStripFinite.affine_interior_collapse
#print axioms BuildingBlocks.PostBranchBoundaryStripFinite.affine_boundary_strip
#print axioms BuildingBlocks.PostBranchBoundaryStripFinite.affine_at_boundary
#print axioms BuildingBlocks.PostBranchBoundaryStripFinite.affine_one_beyond
#print axioms BuildingBlocks.PostBranchBoundaryStripFinite.affine_boundary_strip_pos
#print axioms BuildingBlocks.PostBranchBoundaryStripFinite.affine_interior_pos
#print axioms BuildingBlocks.PostBranchBoundaryStripFinite.oriented_single_wedge_neg
