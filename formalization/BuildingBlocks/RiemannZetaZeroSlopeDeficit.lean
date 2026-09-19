import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.RiemannZetaDisplacementCauchyRiemannSlope

/-!
# Auxiliary Slope-Deficit Bound

This module defines two explicit real functions and proves nonnegativity of one and an upper bound
for the other when `t >= 2`.  Despite the historical names, it does not use a zeta-zero hypothesis,
a logarithmic derivative, or local critical-strip geometry, and it proves no zero contradiction.
-/

namespace BuildingBlocks.RiemannZetaZeroSlopeDeficit

open Complex Real
open BuildingBlocks.RiemannZetaDisplacementReflectionAntisymmetry
open BuildingBlocks.RiemannZetaDisplacementCauchyRiemannSlope
open BuildingBlocks.RiemannZetaDisplacementAsymptotics

noncomputable section

/-! ### Section 1: Completed Zeta Algebraic Real/Imaginary Parts -/

/-- Re-export of positivity for the explicit rational pole-profile expression. -/
theorem pole_critical_slope_pos_reassert (t : ℝ) : 
    0 < 1 / (2 * (t^2 + 1 / 4)^2) :=
  BuildingBlocks.RiemannZetaDisplacementCauchyRiemannSlope.pole_critical_slope_pos (t)

/-- The explicit rational function `2*t^2/(t^2+1/4)`. -/
def logDerivScale (t : ℝ) : ℝ := (2 * t^2) / (t^2 + 1 / 4)

/-- The explicit rational function is nonnegative. -/
theorem logDerivScale_nonneg (t : ℝ) : 0 ≤ logDerivScale t := by
  unfold logDerivScale
  have h_num : 0 ≤ 2 * t^2 := mul_nonneg zero_le_two (sq_nonneg t)
  have h_den : 0 < t^2 + 1 / 4 := by
    have : 0 ≤ t^2 := sq_nonneg t
    linarith
  exact div_nonneg h_num (le_of_lt h_den)

/-! ### Section 2: An Auxiliary Rational Difference -/

/-- A polynomial deficit profile representing the gap between the pole 
critical slope and logarithmic zero tracking. -/
def structuralSlopeDeficit (t : ℝ) : ℝ := 
    (1 / (2 * (t^2 + 1 / 4)^2)) - 1 / (t^4 + t^2 + 1)

/-- High frequency bound for the structural deficit. -/
theorem structuralSlopeDeficit_bound {t : ℝ} (ht : 2 ≤ t) :
    structuralSlopeDeficit t ≤ 1 / t^4 := by
  unfold structuralSlopeDeficit
  -- Since 1 / (2(t^2+1/4)^2) ≤ 1/(2t^4) and we subtract a positive term.
  have h1 : 1 / (2 * (t^2 + 1 / 4)^2) ≤ 1 / (2 * t^4) := by
    have ht_pos : 0 < t := by linarith
    exact pole_critical_slope_le_quartic ht_pos
  
  have h2 : 0 ≤ 1 / (t^4 + t^2 + 1) := by
    have ht2 : 0 ≤ t^2 := sq_nonneg t
    have ht4 : 0 ≤ t^4 := by positivity
    have hd_pos : 0 < t^4 + t^2 + 1 := by linarith
    exact div_nonneg zero_le_one (le_of_lt hd_pos)
  
  have h_comb : 1 / (2 * (t^2 + 1 / 4)^2) - 1 / (t^4 + t^2 + 1) ≤ 1 / (2 * t^4) - 0 := by
    gcongr
    
  have h_half_t4 : 1 / (2 * t^4) ≤ 1 / t^4 := by
    have ht_pos : 0 < t := by linarith
    have ht4_pos : 0 < t^4 := by positivity
    have : 1 / (2 * t^4) = (1 / 2) * (1 / t^4) := by ring
    rw [this]
    have h_coeff : (1 / 2 : ℝ) ≤ 1 := by norm_num
    have ht4_inv_pos : 0 < 1 / t^4 := div_pos zero_lt_one ht4_pos
    have h_mul : (1 / 2 : ℝ) * (1 / t^4) ≤ 1 * (1 / t^4) := by
      exact mul_le_mul_of_nonneg_right h_coeff (le_of_lt ht4_inv_pos)
    have : 1 * (1 / t^4) = 1 / t^4 := by ring
    rwa [this] at h_mul
  
  have h_comb_simp : 1 / (2 * (t^2 + 1 / 4)^2) - 1 / (t^4 + t^2 + 1) ≤ 1 / (2 * t^4) := by
    calc 1 / (2 * (t^2 + 1 / 4)^2) - 1 / (t^4 + t^2 + 1)
      _ ≤ 1 / (2 * t^4) - 0 := h_comb
      _ = 1 / (2 * t^4) := by ring

  exact le_trans h_comb_simp h_half_t4

/-! ### Section 3: Axioms Verification -/

#print axioms pole_critical_slope_pos_reassert
#print axioms logDerivScale_nonneg
#print axioms structuralSlopeDeficit_bound

end

end BuildingBlocks.RiemannZetaZeroSlopeDeficit
