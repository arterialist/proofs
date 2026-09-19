import Mathlib.Analysis.Complex.Basic
import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.ActualArchimedeanFactor
import BuildingBlocks.RiemannZetaUpperHalfPlaneReduction
import BuildingBlocks.RiemannZetaDisplacementRigidity
import BuildingBlocks.RiemannZetaDisplacementAsymptotics

/-!
# Module 320: RiemannZetaPoleDominanceTheorem

This module formalizes the exact pole-zeta additive decomposition of the completed Riemann zeta
function $\Lambda_0(s)$ and the displacement functional $\mathcal{F}_{\text{disp}}(s)$. It proves
algebraic identities only; it does not prove an asymptotic pole-dominance estimate.

## Mathematical Architecture

1. **Exact Completed Zeta Pole Decomposition**:
   For any $s \ne 0, 1$:
   $$\Lambda_0(s) - \frac{-1}{s(s-1)} = \frac{2\xi(s)}{s(s-1)}.$$

2. **Archimedean-Zeta Factorization**:
   For any $s$ with $\operatorname{Re}(s) > 0$ and $s \ne 1$:
   $$\frac{2\xi(s)}{s(s-1)} = \Gamma_{\mathbb{R}}(s) \zeta(s).$$

3. **Complete Additive Decomposition**:
   $$\Lambda_0(s) = \frac{-1}{s(s-1)} + \Gamma_{\mathbb{R}}(s) \zeta(s).$$

4. **Linear Splitting of the Displacement Functional**:
   $$\mathcal{F}_{\text{disp}}(s) = \mathcal{F}_{\text{pole}}(s) + \mathcal{F}_{\text{zeta}}(s)$$
   where:
   - $\mathcal{F}_{\text{pole}}(s) := 2(\sigma - 1/2)\operatorname{Re}\left(\frac{-1}{s(s-1)}\right) - t \operatorname{Im}\left(\frac{-1}{s(s-1)}\right)$
   - $\mathcal{F}_{\text{zeta}}(s) := 2(\sigma - 1/2)\operatorname{Re}(\Gamma_{\mathbb{R}}(s)\zeta(s)) - t \operatorname{Im}(\Gamma_{\mathbb{R}}(s)\zeta(s))$.

5. **Pole Residual Identification**:
   $$\mathcal{F}_{\text{pole}}(s) = R(\sigma - 1/2, s) = \frac{2d(1/4 - d^2)}{|s(s-1)|^2}.$$

6. **Master Pole-Zeta Decomposition Theorem**:
   For any $s$ with $1/2 < \sigma < 1$ and $t > 0$:
   $$\mathcal{F}_{\text{disp}}(s) = R(\sigma - 1/2, s) + \mathcal{F}_{\text{zeta}}(s).$$

7. **Zero Specialization & Refutation**:
   - At any zero $\zeta(s) = 0$, $\mathcal{F}_{\text{zeta}}(s) = 0$, so $\mathcal{F}_{\text{disp}}(s) = R(\sigma - 1/2, s) > 0$.
   - Conversely, $\mathcal{F}_{\text{zeta}}(s) \ne 0$ directly implies $\zeta(s) \ne 0$.

8. **Scope of the result**:
   At a candidate zero, $\mathcal{F}_{\text{zeta}}(s) = 0$, so
   $\mathcal{F}_{\text{disp}}(s) = R(d,s) > 0$. No theorem below bounds
   $\Gamma_{\mathbb R}(s)\zeta(s)$ away from zeros or proves a Stirling asymptotic. A bound derived
   from standard vertical-strip estimates would retain a polynomial factor, for example
   $O_\sigma(t^{\sigma/2+3/2}e^{-\pi t/4})$ for the displacement contribution under a suitable
   polynomial zeta bound. The previously stated bare $O(e^{-\pi t/4})$ estimate was too strong.

## Foundational Integrity

This module contains zero `sorry`s, zero non-standard axioms, and depends solely on Lean's
foundational core: `[propext, Classical.choice, Quot.sound]`.
-/

open Real Complex
open BuildingBlocks.ActualArchimedeanFactor
open BuildingBlocks.RiemannZetaUpperHalfPlaneReduction
open BuildingBlocks.RiemannZetaDisplacementRigidity
open BuildingBlocks.RiemannZetaDisplacementAsymptotics

noncomputable section

namespace BuildingBlocks.RiemannZetaPoleDominanceTheorem

/-! ### Section 1: Exact Pole Decomposition of $\Lambda_0(s)$ -/

/-- The exact completed zeta pole decomposition:
$\Lambda_0(s) - \frac{-1}{s(s-1)} = \frac{2\xi(s)}{s(s-1)}$. -/
theorem completedRiemannZeta₀_sub_pole (s : ℂ) (hs0 : s ≠ 0) (hs1 : s ≠ 1) :
    completedRiemannZeta₀ s - (-1 / (s * (s - 1))) = 2 * xi s / (s * (s - 1)) := by
  have hs1_sub : s - 1 ≠ 0 := sub_ne_zero.mpr hs1
  have hs_prod : s * (s - 1) ≠ 0 := mul_ne_zero hs0 hs1_sub
  unfold xi
  field_simp
  ring

/-- The exact Archimedean-zeta representation:
$\frac{2\xi(s)}{s(s-1)} = \Gamma_{\mathbb{R}}(s) \zeta(s)$. -/
theorem two_xi_div_eq_gamma_zeta (s : ℂ) (hs0 : s ≠ 0) (hs1 : s ≠ 1) (hs_re : 0 < s.re) :
    2 * xi s / (s * (s - 1)) = Complex.Gammaℝ s * riemannZeta s := by
  have hs1_sub : s - 1 ≠ 0 := sub_ne_zero.mpr hs1
  have hs_prod : s * (s - 1) ≠ 0 := mul_ne_zero hs0 hs1_sub
  rw [xi_completed_relation s hs0 hs1, completed_zeta_gamma_relation s hs_re]
  field_simp

/-- Complete additive decomposition of $\Lambda_0(s)$:
$$\Lambda_0(s) = \frac{-1}{s(s-1)} + \Gamma_{\mathbb{R}}(s) \zeta(s).$$ -/
theorem completedRiemannZeta₀_eq_pole_add_gamma_zeta (s : ℂ) (hs0 : s ≠ 0) (hs1 : s ≠ 1) (hs_re : 0 < s.re) :
    completedRiemannZeta₀ s = -1 / (s * (s - 1)) + Complex.Gammaℝ s * riemannZeta s := by
  have h1 := completedRiemannZeta₀_sub_pole s hs0 hs1
  have h2 := two_xi_div_eq_gamma_zeta s hs0 hs1 hs_re
  rw [h2] at h1
  linear_combination h1

/-- Zero specialization: at any zero of $\zeta(s)$, $\Lambda_0(s) = \frac{-1}{s(s-1)}$. -/
theorem completedRiemannZeta₀_eq_pole_of_zero {s : ℂ}
    (hs0 : s ≠ 0) (hs1 : s ≠ 1) (hs_re : 0 < s.re) (hz : riemannZeta s = 0) :
    completedRiemannZeta₀ s = -1 / (s * (s - 1)) := by
  rw [completedRiemannZeta₀_eq_pole_add_gamma_zeta s hs0 hs1 hs_re, hz]
  ring

/-- Zero refutation condition: if $\Lambda_0(s) \ne \frac{-1}{s(s-1)}$, then $\zeta(s) \ne 0$. -/
theorem riemannZeta_ne_zero_of_completedRiemannZeta₀_ne_pole {s : ℂ}
    (hs0 : s ≠ 0) (hs1 : s ≠ 1) (hs_re : 0 < s.re)
    (h_ne : completedRiemannZeta₀ s ≠ -1 / (s * (s - 1))) :
    riemannZeta s ≠ 0 := by
  intro hz
  exact h_ne (completedRiemannZeta₀_eq_pole_of_zero hs0 hs1 hs_re hz)

/-! ### Section 2: Decomposition of the Displacement Functional -/

/-- Definition of the Archimedean-zeta displacement functional component:
$$\mathcal{F}_{\text{zeta}}(s) := 2(\sigma - 1/2) \operatorname{Re}(\Gamma_{\mathbb{R}}(s)\zeta(s)) - t \operatorname{Im}(\Gamma_{\mathbb{R}}(s)\zeta(s)).$$ -/
def displacementFunctionalZeta (s : ℂ) : ℝ :=
  2 * (s.re - 1 / 2) * (Complex.Gammaℝ s * riemannZeta s).re -
  s.im * (Complex.Gammaℝ s * riemannZeta s).im

/-- Definition of the pole displacement functional component:
$$\mathcal{F}_{\text{pole}}(s) := 2(\sigma - 1/2) \operatorname{Re}(-1/(s(s-1))) - t \operatorname{Im}(-1/(s(s-1))).$$ -/
def displacementFunctionalPole (s : ℂ) : ℝ :=
  2 * (s.re - 1 / 2) * (-1 / (s * (s - 1))).re -
  s.im * (-1 / (s * (s - 1))).im

/-- Linearity of the displacement functional:
$$\mathcal{F}_{\text{disp}}(s) = \mathcal{F}_{\text{pole}}(s) + \mathcal{F}_{\text{zeta}}(s).$$ -/
theorem displacementFunctional_eq_pole_add_zeta (s : ℂ) (hs0 : s ≠ 0) (hs1 : s ≠ 1) (hs_re : 0 < s.re) :
    displacementFunctional s = displacementFunctionalPole s + displacementFunctionalZeta s := by
  unfold displacementFunctional displacementFunctionalPole displacementFunctionalZeta
  have h_dec := completedRiemannZeta₀_eq_pole_add_gamma_zeta s hs0 hs1 hs_re
  have h_re : (completedRiemannZeta₀ s).re = (-1 / (s * (s - 1))).re + (Complex.Gammaℝ s * riemannZeta s).re := by
    rw [h_dec, add_re]
  have h_im : (completedRiemannZeta₀ s).im = (-1 / (s * (s - 1))).im + (Complex.Gammaℝ s * riemannZeta s).im := by
    rw [h_dec, add_im]
  rw [h_re, h_im]
  ring

/-- Exact identification of the pole component with the rational displacement residual:
$$\mathcal{F}_{\text{pole}}(s) = R(\sigma - 1/2, s).$$ -/
theorem displacementFunctionalPole_eq_residual (s : ℂ) :
    displacementFunctionalPole s = displacementResidual (s.re - 1 / 2) s := by
  unfold displacementFunctionalPole displacementResidual
  rw [neg_one_div_re, neg_one_div_im, mul_sub_one_re, mul_sub_one_im]
  ring

/-- Pole-zeta decomposition:
For any $s$ with $1/2 < \sigma < 1$:
$$\mathcal{F}_{\text{disp}}(s) = R(\sigma - 1/2, s) + \mathcal{F}_{\text{zeta}}(s).$$ -/
theorem displacementFunctional_master_decomposition {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsr1 : s.re < 1) :
    displacementFunctional s = displacementResidual (s.re - 1 / 2) s + displacementFunctionalZeta s := by
  have hs0 : s ≠ 0 := by
    intro he
    have : s.re = 0 := by rw [he, zero_re]
    linarith
  have hs1 : s ≠ 1 := by
    intro he
    have : s.re = 1 := by rw [he, one_re]
    linarith
  have hs_re : 0 < s.re := by linarith
  rw [displacementFunctional_eq_pole_add_zeta s hs0 hs1 hs_re]
  rw [displacementFunctionalPole_eq_residual s]

/-! ### Section 3: Zero Specialization and Refutation -/

/-- Zero specialization of $\mathcal{F}_{\text{zeta}}$:
If $\zeta(s) = 0$, then $\mathcal{F}_{\text{zeta}}(s) = 0$. -/
theorem displacementFunctionalZeta_of_zero {s : ℂ} (hz : riemannZeta s = 0) :
    displacementFunctionalZeta s = 0 := by
  unfold displacementFunctionalZeta
  rw [hz, mul_zero, zero_re, zero_im]
  ring

/-- Zero refutation from the Master Decomposition:
If $\mathcal{F}_{\text{zeta}}(s) \ne 0$, then $\zeta(s) \ne 0$. -/
theorem riemannZeta_ne_zero_of_zeta_functional_ne_zero {s : ℂ}
    (h_ne : displacementFunctionalZeta s ≠ 0) :
    riemannZeta s ≠ 0 := by
  intro hz
  exact h_ne (displacementFunctionalZeta_of_zero hz)

/-- Strict Positivity of Displacement Functional at Candidate Zeros:
At any zero with $1/2 < \sigma < 1$,
$\mathcal{F}_{\text{disp}}(s) = R(\sigma - 1/2, s) > 0$. -/
theorem displacementFunctional_eq_residual_of_zero {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsr1 : s.re < 1) (hz : riemannZeta s = 0) :
    displacementFunctional s = displacementResidual (s.re - 1 / 2) s := by
  rw [displacementFunctional_master_decomposition hsr hsr1]
  rw [displacementFunctionalZeta_of_zero hz]
  ring

/-- Obstruction to Blanket Nonpositivity:
Any claim that $\mathcal{F}_{\text{disp}}(s) \le 0$ at a putative zero contradicts the strict
positivity of the displacement residual $R(\sigma - 1/2, s) > 0$. -/
theorem nonpositivity_contradiction_at_zero {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsr1 : s.re < 1) (hsim : 0 < s.im) (hz : riemannZeta s = 0)
    (h_le : displacementFunctional s ≤ 0) : False := by
  have h_eq := displacementFunctional_eq_residual_of_zero hsr hsr1 hz
  have hd : 0 < s.re - 1 / 2 := by linarith
  have hd_lt : s.re - 1 / 2 < 1 / 2 := by linarith
  have hmul : s * (s - 1) ≠ 0 := mul_sub_one_ne_zero hsr hsim
  have hs_pos : 0 < normSq (s * (s - 1)) := normSq_pos.mpr hmul
  have hs_ne : normSq (s * (s - 1)) ≠ 0 := ne_of_gt hs_pos
  have h_pos := displacementResidual_pos hd hd_lt hs_ne
  linarith

/-! ### Section 4: Axiom Verification -/

#print axioms completedRiemannZeta₀_sub_pole
#print axioms two_xi_div_eq_gamma_zeta
#print axioms completedRiemannZeta₀_eq_pole_add_gamma_zeta
#print axioms completedRiemannZeta₀_eq_pole_of_zero
#print axioms riemannZeta_ne_zero_of_completedRiemannZeta₀_ne_pole
#print axioms displacementFunctional_eq_pole_add_zeta
#print axioms displacementFunctionalPole_eq_residual
#print axioms displacementFunctional_master_decomposition
#print axioms displacementFunctionalZeta_of_zero
#print axioms riemannZeta_ne_zero_of_zeta_functional_ne_zero
#print axioms displacementFunctional_eq_residual_of_zero
#print axioms nonpositivity_contradiction_at_zero

end BuildingBlocks.RiemannZetaPoleDominanceTheorem
