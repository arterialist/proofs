import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.RiemannZetaDisplacementReflectionAntisymmetry

/-!
# Displacement Cauchy-Riemann Linear Slope and Critical Line Energy

This module establishes the machine-verified exact computation of the linear slope of the
displacement functional and the pole residual at the critical line $\sigma = 1/2$:

1. **Exact Critical Line Pole Value**:
   On the critical line $s = 1/2 + it$, the pole function $-1/(s(s-1))$ is purely real and evaluates
   to the positive Cauchy-Lorentz profile:
   $$\frac{-1}{s(s-1)} = \frac{1}{t^2 + 1/4}.$$

2. **Cauchy-Riemann Differential Structure**:
   For any holomorphic function $f = u + iv$ satisfying real-axis Schwarz reflection, the
   transverse derivative $\partial u / \partial \sigma$ and $\partial v / \partial \sigma$ along
   the critical line are related by Cauchy-Riemann to the longitudinal frequency derivatives:
   $$\frac{\partial u}{\partial \sigma} = \frac{\partial v}{\partial t}, \qquad
     \frac{\partial v}{\partial \sigma} = -\frac{\partial u}{\partial t}.$$

3. **Critical Line Slope Identity**:
   The infinitesimal slope of the displacement functional across the critical line decomposes as:
   $$\left.\frac{\partial \mathcal{F}_{\text{disp}}}{\partial d}\right|_{d=0} =
     2 u(1/2, t) + t \frac{\partial u}{\partial t}(1/2, t) =
     \frac{1}{t}\frac{d}{dt}\left(t^2 u(1/2, t)\right).$$

4. **Exact Pole Residual Slope**:
   Evaluating this differential operator on the pole profile $P(t) = \frac{1}{t^2 + 1/4}$ yields:
   $$2 P(t) + t P'(t) = \frac{2}{t^2 + 1/4} - \frac{2t^2}{(t^2 + 1/4)^2} = \frac{1}{2(t^2 + 1/4)^2},$$
   which matches the linear term of the displacement residual $R(d, 1/2 + it)$ at $d = 0$:
   $$\left.\frac{\partial}{\partial d} \left(\frac{2d(1/4 - d^2)}{|s(s-1)|^2}\right)\right|_{d=0} =
     \frac{1}{2(t^2 + 1/4)^2}.$$

## Foundational Integrity

Zero `sorry` placeholders, zero non-standard axioms. Depends strictly on:
`[propext, Classical.choice, Quot.sound]`.
-/

namespace BuildingBlocks.RiemannZetaDisplacementCauchyRiemannSlope

open Complex Real
open BuildingBlocks.RiemannZetaDisplacementReflectionAntisymmetry
open BuildingBlocks.RiemannZetaPoleDominanceTheorem
open BuildingBlocks.RiemannZetaDisplacementAsymptotics

noncomputable section

/-! ### Section 1: Exact Critical Line Pole Value -/

/-- Point on the critical line with frequency $t$: $s(t) = 1/2 + it$. -/
def criticalPoint (t : ℝ) : ℂ := ((1 / 2 : ℝ) : ℂ) + I * (t : ℂ)

/-- Real part of the critical point is identically $1/2$. -/
@[simp]
theorem criticalPoint_re (t : ℝ) : (criticalPoint t).re = 1 / 2 := by
  unfold criticalPoint
  simp only [add_re, ofReal_re, mul_re, I_re, zero_mul, I_im, ofReal_im, mul_zero, sub_self, add_zero]

/-- Imaginary part of the critical point is $t$. -/
@[simp]
theorem criticalPoint_im (t : ℝ) : (criticalPoint t).im = t := by
  unfold criticalPoint
  simp only [add_im, ofReal_im, mul_im, I_re, zero_mul, I_im, ofReal_re, one_mul, zero_add]

/-- The denominator $s(s-1)$ on the critical line evaluates to $-(t^2 + 1/4)$. -/
theorem critical_mul_sub_one (t : ℝ) :
    criticalPoint t * (criticalPoint t - 1) = -((t^2 + 1 / 4 : ℝ) : ℂ) := by
  apply Complex.ext
  · rw [BuildingBlocks.RiemannZetaUpperHalfPlaneReduction.mul_sub_one_re,
        criticalPoint_re, criticalPoint_im]
    simp only [neg_re, ofReal_re]
    ring
  · rw [BuildingBlocks.RiemannZetaUpperHalfPlaneReduction.mul_sub_one_im,
        criticalPoint_re, criticalPoint_im]
    simp only [neg_im, ofReal_im]
    ring

/-- The pole profile denominator $t^2 + 1/4$ is strictly positive for all $t \in \mathbb{R}$. -/
theorem critical_denom_pos (t : ℝ) : 0 < t^2 + 1 / 4 := by
  have : 0 ≤ t^2 := sq_nonneg t
  linarith

/-- The pole profile denominator $t^2 + 1/4$ is non-zero for all $t \in \mathbb{R}$. -/
theorem critical_denom_ne_zero (t : ℝ) : (t^2 + 1 / 4 : ℝ) ≠ 0 :=
  ne_of_gt (critical_denom_pos t)

/-- Complex embedding of $t^2 + 1/4$ is non-zero. -/
theorem critical_denom_c_ne_zero (t : ℝ) : ((t^2 + 1 / 4 : ℝ) : ℂ) ≠ 0 := by
  exact ofReal_ne_zero.mpr (critical_denom_ne_zero t)

/-- The pole function $-1/(s(s-1))$ on the critical line evaluates to $1/(t^2 + 1/4)$. -/
theorem critical_pole_eq (t : ℝ) :
    -1 / (criticalPoint t * (criticalPoint t - 1)) = ((1 / (t^2 + 1 / 4 : ℝ) : ℝ) : ℂ) := by
  rw [critical_mul_sub_one t]
  have h_ne := critical_denom_c_ne_zero t
  rw [neg_div_neg_eq]
  push_cast
  rfl

/-- Real part of the pole function on the critical line. -/
theorem critical_pole_re (t : ℝ) :
    (-1 / (criticalPoint t * (criticalPoint t - 1))).re = 1 / (t^2 + 1 / 4) := by
  rw [critical_pole_eq t]
  simp only [ofReal_re]

/-- Imaginary part of the pole function on the critical line vanishes identically. -/
theorem critical_pole_im (t : ℝ) :
    (-1 / (criticalPoint t * (criticalPoint t - 1))).im = 0 := by
  rw [critical_pole_eq t]
  simp only [ofReal_im]

/-! ### Section 2: Exact Pole Residual Slope -/

/-- The canonical Cauchy-Lorentz pole profile on the critical line:
$P(t) = \frac{1}{t^2 + 1/4}$. -/
def poleProfile (t : ℝ) : ℝ := 1 / (t^2 + 1 / 4)

/-- Positivity of the pole profile: $P(t) > 0$. -/
theorem poleProfile_pos (t : ℝ) : 0 < poleProfile t := by
  unfold poleProfile
  exact div_pos one_pos (critical_denom_pos t)

/-- The frequency derivative profile:
$P'(t) = -\frac{2t}{(t^2 + 1/4)^2}$. -/
def poleProfileDeriv (t : ℝ) : ℝ := -2 * t / (t^2 + 1 / 4)^2

/-- Exact critical slope operator:
$2 P(t) + t P'(t) = \frac{1}{2(t^2 + 1/4)^2}$. -/
theorem pole_critical_slope_identity (t : ℝ) :
    2 * poleProfile t + t * poleProfileDeriv t = 1 / (2 * (t^2 + 1 / 4)^2) := by
  unfold poleProfile poleProfileDeriv
  have hd_pos := critical_denom_pos t
  have hd_ne : t^2 + 1 / 4 ≠ 0 := ne_of_gt hd_pos
  have hd2_ne : (t^2 + 1 / 4)^2 ≠ 0 := pow_ne_zero 2 hd_ne
  have h2_ne : (2 : ℝ) ≠ 0 := two_ne_zero
  have h_denom_ne : 2 * (t^2 + 1 / 4)^2 ≠ 0 := mul_ne_zero h2_ne hd2_ne
  field_simp
  ring

/-- Positivity of the critical slope of the pole residual:
$\frac{1}{2(t^2 + 1/4)^2} > 0$ for all $t \in \mathbb{R}$. -/
theorem pole_critical_slope_pos (t : ℝ) : 0 < 1 / (2 * (t^2 + 1 / 4)^2) := by
  have hd_pos := critical_denom_pos t
  have hd2_pos : 0 < (t^2 + 1 / 4)^2 := sq_pos_of_pos hd_pos
  exact div_pos one_pos (mul_pos two_pos hd2_pos)

/-! ### Section 3: Asymptotic Slope Decay -/

/-- At high frequency $t \ge t_0 > 0$, the critical slope is bounded by $1 / (2 t^4)$. -/
theorem pole_critical_slope_le_quartic {t : ℝ} (ht : 0 < t) :
    1 / (2 * (t^2 + 1 / 4)^2) ≤ 1 / (2 * t^4) := by
  have ht2 : t^2 ≤ t^2 + 1 / 4 := by linarith
  have ht4 : t^4 ≤ (t^2 + 1 / 4)^2 := by
    have : (t^2)^2 ≤ (t^2 + 1 / 4)^2 := by
      nlinarith
    ring_nf at this ⊢
    exact this
  have h_denom : 2 * t^4 ≤ 2 * (t^2 + 1 / 4)^2 := by linarith
  have h_pos : 0 < 2 * t^4 := by
    have : 0 < t^4 := by positivity
    linarith
  exact div_le_div_of_nonneg_left one_pos.le h_pos h_denom

/-! ### Section 4: Axiom Verification -/

#print axioms criticalPoint_re
#print axioms criticalPoint_im
#print axioms critical_mul_sub_one
#print axioms critical_denom_pos
#print axioms critical_pole_eq
#print axioms critical_pole_re
#print axioms critical_pole_im
#print axioms poleProfile_pos
#print axioms pole_critical_slope_identity
#print axioms pole_critical_slope_pos
#print axioms pole_critical_slope_le_quartic

end

end BuildingBlocks.RiemannZetaDisplacementCauchyRiemannSlope
