import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.RiemannZetaDisplacementReflectionAntisymmetry
import BuildingBlocks.RiemannZetaDisplacementCauchyRiemannSlope
import BuildingBlocks.RiemannZetaZeroSlopeDeficit

/-!
# Zeta-Factor Vanishing and a Reused Scalar Bound

The first theorem observes that the defined zeta displacement component is zero when
`riemannZeta s = 0`, because that component contains the zeta factor.  The second theorem merely
re-exports the scalar deficit bound from `RiemannZetaZeroSlopeDeficit`.  No logarithmic derivative,
asymptotic growth statement, or slope contradiction is proved here.
-/

namespace BuildingBlocks.RiemannZetaLogarithmicVanishing

open Complex Real
open BuildingBlocks.RiemannZetaDisplacementReflectionAntisymmetry
open BuildingBlocks.RiemannZetaDisplacementCauchyRiemannSlope
open BuildingBlocks.RiemannZetaZeroSlopeDeficit

noncomputable section

/-! ### Section 1: Completed Zeta Root Components -/

/-- An algebraic real-imaginary combination of `completedRiemannZeta`; unused below. -/
def completedZetaVariationSum (s : ℂ) : ℝ :=
  (2 * s.re - 1) * (completedRiemannZeta s).re - s.im * (completedRiemannZeta s).im

/-- At any zero, the displacementFunctionalZeta vanishes. -/
theorem displacementFunctionalZeta_zero {s : ℂ} (hz : riemannZeta s = 0) :
    BuildingBlocks.RiemannZetaPoleDominanceTheorem.displacementFunctionalZeta s = 0 := by
  unfold BuildingBlocks.RiemannZetaPoleDominanceTheorem.displacementFunctionalZeta
  rw [hz, mul_zero]
  simp

/-! ### Section 2: Re-exported Scalar Bound -/

/-- Direct wrapper around `structuralSlopeDeficit_bound`. -/
theorem slopeGapEquation (t : ℝ) (ht : 2 ≤ t) :
    structuralSlopeDeficit t ≤ 1 / t^4 :=
  structuralSlopeDeficit_bound ht

/-! ### Section 3: Axioms Verification -/

#print axioms displacementFunctionalZeta_zero
#print axioms slopeGapEquation

end

end BuildingBlocks.RiemannZetaLogarithmicVanishing
