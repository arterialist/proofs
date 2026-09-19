import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Add
import BuildingBlocks.RiemannZetaKernelPositivity
import BuildingBlocks.RiemannZetaDisplacementFourierEnvelope
import BuildingBlocks.RiemannZetaThetaEnvelopeMonotonicity
import BuildingBlocks.RiemannZetaTransverseCauchyRiemannMatching

/-!
# Scalar Mismatch and Origin Identities

This module proves positivity of an explicit rational expression, elementary mismatch lemmas for
two arbitrary real numbers `D_theta` and `R`, and algebraic evaluations of displayed origin
expressions.  It does not connect `D_theta` to the completed zeta function or a theta integral,
and none of its theorems concludes `riemannZeta s != 0`.  The declarations named as higher jets
do not assume or prove that the arbitrary inputs are derivatives of one common envelope.
-/

namespace BuildingBlocks.RiemannZetaDisplacementZeroExclusion

open Real
open BuildingBlocks.RiemannZetaKernelPositivity
open BuildingBlocks.RiemannZetaDisplacementFourierEnvelope
open BuildingBlocks.RiemannZetaThetaEnvelopeMonotonicity
open BuildingBlocks.RiemannZetaTransverseCauchyRiemannMatching

noncomputable section

/-! ### Section 1: Residual Positivity -/

/-- Scalar residual formula with an arbitrary denominator parameter. -/
def displacementResidualVal (d denom : ℝ) : ℝ :=
  2 * d * (1 / 4 - d ^ 2) / denom

/-- The displacement residual is strictly positive for all $d \in (0, 1/2)$ and positive denominator. -/
theorem displacementResidualVal_pos {d denom : ℝ}
    (hd_pos : 0 < d) (hd_lt : d < 1 / 2) (hdenom : 0 < denom) :
    0 < displacementResidualVal d denom := by
  unfold displacementResidualVal
  have h_2d : 0 < 2 * d := mul_pos two_pos hd_pos
  have h_sq : d ^ 2 < (1 / 2 : ℝ) ^ 2 := sq_lt_sq.mpr (by
    rw [abs_of_pos hd_pos, abs_of_pos (by norm_num)]
    exact hd_lt)
  have h_half_sq : (1 / 2 : ℝ) ^ 2 = 1 / 4 := by ring
  rw [h_half_sq] at h_sq
  have h_diff : 0 < 1 / 4 - d ^ 2 := by linarith
  have h_num : 0 < 2 * d * (1 / 4 - d ^ 2) := mul_pos h_2d h_diff
  exact div_pos h_num hdenom

/-! ### Section 2: Zero Exclusion Criteria -/

/-- Elementary rearrangement of `D_theta - R = 0`. -/
theorem zero_balance_eq {D_theta R : ℝ} (h_balance : D_theta - R = 0) :
    D_theta = R := by
  linarith

/-- A nonpositive real number differs from a strictly positive one. -/
theorem zero_exclusion_of_nonpos {D_theta R : ℝ}
    (h_nonpos : D_theta ≤ 0) (h_pos : 0 < R) :
    D_theta ≠ R := by
  linarith

/-- Strict inequality implies inequality. -/
theorem zero_exclusion_of_deficit {D_theta R : ℝ}
    (h_deficit : D_theta < R) :
    D_theta ≠ R := by
  linarith

/-- Reverse strict inequality implies inequality. -/
theorem zero_exclusion_of_excess {D_theta R : ℝ}
    (h_excess : R < D_theta) :
    D_theta ≠ R := by
  linarith

/-- If two real numbers differ, their difference is nonzero. -/
theorem offline_zero_free_of_mismatch {D_theta R : ℝ}
    (h_mismatch : D_theta ≠ R) :
    D_theta - R ≠ 0 := by
  intro h_eq
  have : D_theta = R := by linarith
  exact h_mismatch this

/-! ### Section 3: Algebraic Origin Expressions -/

/-- The auxiliary jet coefficient:
$$H(d, u) := \frac{d^2}{2} K(u) - 2 K''(u).$$ -/
def jetH (d : ℝ) (K K'' : ℝ → ℝ) (u : ℝ) : ℝ :=
  (d ^ 2 / 2) * K u - 2 * K'' u

/-- Algebraic simplification of the expression associated with a proposed second derivative:
$$W_d''(0) = d \left(\frac{d^2}{4} K(0) - K''(0)\right).$$ -/
theorem envelopeW_deriv2_zero (d : ℝ) (K K'' : ℝ → ℝ) (H'0 : ℝ) :
    H'0 * sinh (d * 0 / 2) + jetH d K K'' 0 * (d / 2 * cosh (d * 0 / 2)) =
      d * ((d ^ 2 / 4) * K 0 - K'' 0) := by
  unfold jetH
  have h0 : d * 0 / 2 = 0 := by ring
  rw [h0, sinh_zero, cosh_zero]
  ring

/-- Algebraic simplification of the expression associated with a proposed third derivative:
$$W_d'''(0) = d \left(\frac{d^2}{2} K'(0) - 2 K'''(0)\right).$$ -/
theorem envelopeW_deriv3_zero (d : ℝ) (K' K''' : ℝ → ℝ) (H''0 H0 : ℝ) :
    H''0 * sinh (d * 0 / 2) +
    d * ((d ^ 2 / 2) * K' 0 - 2 * K''' 0) * cosh (d * 0 / 2) +
    (d ^ 2 / 4) * H0 * sinh (d * 0 / 2) =
      d * ((d ^ 2 / 2) * K' 0 - 2 * K''' 0) := by
  have h0 : d * 0 / 2 = 0 := by ring
  rw [h0, sinh_zero, cosh_zero]
  ring

/-! ### Section 4: Axiom Verification -/

#print axioms displacementResidualVal_pos
#print axioms zero_balance_eq
#print axioms zero_exclusion_of_nonpos
#print axioms zero_exclusion_of_deficit
#print axioms zero_exclusion_of_excess
#print axioms offline_zero_free_of_mismatch
#print axioms envelopeW_deriv2_zero
#print axioms envelopeW_deriv3_zero

end

end BuildingBlocks.RiemannZetaDisplacementZeroExclusion
