import Mathlib.Tactic

/-!
# Finite harmonic endpoint algebra

This is the finite linear algebra behind the valuation-Hodge endpoint audit.
The analytic identification of the coefficient mass with a friable Stieltjes
tail is kept as an explicit input.
-/

namespace BuildingBlocks.HarmonicEndpointCrossFinite

open scoped BigOperators

variable {ι : Type*} [Fintype ι]

/-- Sum of the vertex coefficients. -/
def coefficientMass (x : ι → ℝ) : ℝ := ∑ i, x i

/-- Row-vector convention for the Gram pairing `xᵀ G y`. -/
def gramPair (G : Matrix ι ι ℝ) (x y : ι → ℝ) : ℝ :=
  dotProduct (Matrix.vecMul x G) y

/-- If the normalized harmonic row has constant Gram image `D⁻¹`, its
pairing with every vector is exactly coefficient mass divided by capacity. -/
theorem harmonic_pair_eq_mass_div
    (G : Matrix ι ι ℝ) (h b : ι → ℝ) (D : ℝ)
    (hRiesz : Matrix.vecMul h G = fun _ => D⁻¹) :
    gramPair G h b = coefficientMass b / D := by
  rw [gramPair, hRiesz]
  simp only [dotProduct, coefficientMass]
  rw [← Finset.mul_sum]
  simp [div_eq_mul_inv, mul_comm]

/-- Rank-one harmonic projection determined by coefficient mass. -/
def harmonicProjection (h x : ι → ℝ) : ι → ℝ :=
  coefficientMass x • h

/-- A moving linear cut can create a harmonic component even when the
unsliced vector has coefficient mass zero. -/
theorem projection_cut_commutator
    (h a : ι → ℝ) (cut : (ι → ℝ) →ₗ[ℝ] (ι → ℝ))
    (ha : coefficientMass a = 0) :
    harmonicProjection h (cut a) - cut (harmonicProjection h a) =
      coefficientMass (cut a) • h := by
  simp [harmonicProjection, ha]

/-- The two-point Möbius endpoint already has opposite signs on its two
literal lower faces. -/
theorem two_face_opposite_signs {q : ℝ} (hq0 : 0 < q) (hq1 : q < 1) :
    0 < q * (1 - q) ∧ -q < 0 := by
  constructor
  · exact mul_pos hq0 (sub_pos.mpr hq1)
  · linarith

end BuildingBlocks.HarmonicEndpointCrossFinite

#print axioms BuildingBlocks.HarmonicEndpointCrossFinite.harmonic_pair_eq_mass_div
#print axioms BuildingBlocks.HarmonicEndpointCrossFinite.projection_cut_commutator
#print axioms BuildingBlocks.HarmonicEndpointCrossFinite.two_face_opposite_signs
