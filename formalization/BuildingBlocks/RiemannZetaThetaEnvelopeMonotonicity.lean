import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Add
import BuildingBlocks.RiemannZetaKernelPositivity
import BuildingBlocks.RiemannZetaDisplacementFourierEnvelope

/-!
# Gaussian-Mode and Abstract Envelope Derivatives

This module proves that each explicitly defined Gaussian mode has negative derivative on `u >= 0` and differentiates an
abstract expression `envelopeW` under derivative hypotheses for arbitrary functions `K`, `K'`,
and `K''`.  It does not identify their sums with the theta kernel, justify termwise
differentiation, define a Fourier integral, or derive quartic Fourier decay.  The origin theorem
only evaluates the displayed derivative expression at `u = 0`.
-/

namespace BuildingBlocks.RiemannZetaThetaEnvelopeMonotonicity

open Real
open BuildingBlocks.RiemannZetaKernelPositivity
open BuildingBlocks.RiemannZetaDisplacementFourierEnvelope

noncomputable section

/-! ### Section 1: Gaussian Mode Definitions and Derivatives -/

/-- The $n$-th Gaussian mode in logarithmic coordinates:
$$g_n(u) := e^{u/4} \exp\left(-\pi (n+1)^2 e^u\right).$$ -/
def gaussianMode (n : ℕ) (u : ℝ) : ℝ :=
  exp (u / 4) * exp (- Real.pi * ((n + 1 : ℝ) ^ 2) * exp u)

/-- Every Gaussian mode is strictly positive everywhere on $\mathbb{R}$. -/
theorem gaussianMode_pos (n : ℕ) (u : ℝ) :
    0 < gaussianMode n u := by
  unfold gaussianMode
  exact mul_pos (exp_pos _) (exp_pos _)

/-- The derivative of the $n$-th Gaussian mode:
$$g_n'(u) = \left(\frac{1}{4} - \pi (n+1)^2 e^u\right) g_n(u).$$ -/
theorem hasDerivAt_gaussianMode (n : ℕ) (u : ℝ) :
    HasDerivAt (gaussianMode n)
      ((1 / 4 - Real.pi * ((n + 1 : ℝ) ^ 2) * exp u) * gaussianMode n u) u := by
  have h_lin : HasDerivAt (fun x : ℝ ↦ x / 4) (1 / 4) u := by
    have h : (fun x : ℝ ↦ x / 4) = (fun x ↦ x * (1 / 4)) := by ext; ring
    rw [h]
    simpa using (hasDerivAt_id' u).mul_const (1 / 4)
  have h_e1 : HasDerivAt (fun x ↦ exp (x / 4)) ((1 / 4) * exp (u / 4)) u := by
    have := (hasDerivAt_exp (u / 4)).comp u h_lin
    simpa [mul_comm] using this
  have h_arg : HasDerivAt (fun x ↦ - Real.pi * ((n + 1 : ℝ) ^ 2) * exp x)
      (- Real.pi * ((n + 1 : ℝ) ^ 2) * exp u) u := by
    have h : (fun x ↦ - Real.pi * ((n + 1 : ℝ) ^ 2) * exp x) =
        (fun x ↦ (- Real.pi * ((n + 1 : ℝ) ^ 2)) * exp x) := by ext; ring
    rw [h]
    exact (hasDerivAt_exp u).const_mul (- Real.pi * ((n + 1 : ℝ) ^ 2))
  have h_e2 : HasDerivAt (fun x ↦ exp (- Real.pi * ((n + 1 : ℝ) ^ 2) * exp x))
      ((- Real.pi * ((n + 1 : ℝ) ^ 2) * exp u) * exp (- Real.pi * ((n + 1 : ℝ) ^ 2) * exp u)) u := by
    have := (hasDerivAt_exp (- Real.pi * ((n + 1 : ℝ) ^ 2) * exp u)).comp u h_arg
    simpa [mul_comm] using this
  have h_prod := h_e1.mul h_e2
  unfold gaussianMode
  have h_alg : (1 / 4) * exp (u / 4) * exp (-Real.pi * (↑n + 1) ^ 2 * exp u) +
      exp (u / 4) * ((-Real.pi * (↑n + 1) ^ 2 * exp u) * exp (-Real.pi * (↑n + 1) ^ 2 * exp u)) =
      (1 / 4 - Real.pi * ((n + 1 : ℝ) ^ 2) * exp u) * (exp (u / 4) * exp (- Real.pi * ((n + 1 : ℝ) ^ 2) * exp u)) := by
    ring
  rw [h_alg] at h_prod
  exact h_prod

/-- The logarithmic multiplier $\frac{1}{4} - \pi (n+1)^2 e^u$ is strictly negative for all $u \ge 0$. -/
theorem gaussianMode_factor_neg (n : ℕ) {u : ℝ} (hu : 0 ≤ u) :
    1 / 4 - Real.pi * ((n + 1 : ℝ) ^ 2) * exp u < 0 := by
  have h_exp : 1 ≤ exp u := Real.one_le_exp hu
  have h_n1 : 1 ≤ (n + 1 : ℝ) := by
    have : (0 : ℝ) ≤ n := Nat.cast_nonneg n
    linarith
  have h_sq : 1 ≤ (n + 1 : ℝ) ^ 2 := by
    nlinarith
  have h_pi_pos : 0 < Real.pi := Real.pi_pos
  have hA : Real.pi ≤ Real.pi * ((n + 1 : ℝ) ^ 2) :=
    le_mul_of_one_le_right (le_of_lt h_pi_pos) h_sq
  have h_posA : 0 ≤ Real.pi * ((n + 1 : ℝ) ^ 2) := by positivity
  have hB : Real.pi * ((n + 1 : ℝ) ^ 2) ≤ Real.pi * ((n + 1 : ℝ) ^ 2) * exp u :=
    le_mul_of_one_le_right h_posA h_exp
  have hC : Real.pi ≤ Real.pi * ((n + 1 : ℝ) ^ 2) * exp u := hA.trans hB
  have hD : 3 < Real.pi * ((n + 1 : ℝ) ^ 2) * exp u := lt_of_lt_of_le Real.pi_gt_three hC
  linarith

/-- Every Gaussian mode has strictly negative derivative for all $u \ge 0$. -/
theorem gaussianMode_deriv_neg (n : ℕ) {u : ℝ} (hu : 0 ≤ u) :
    (1 / 4 - Real.pi * ((n + 1 : ℝ) ^ 2) * exp u) * gaussianMode n u < 0 := by
  have h_fac := gaussianMode_factor_neg n hu
  have h_pos := gaussianMode_pos n u
  exact mul_neg_of_neg_of_pos h_fac h_pos

/-! ### Section 2: Abstract Envelope Derivative and Origin Value -/

/-- General algebraic definition of the displacement envelope for arbitrary profile $K$ and derivative $K'$:
$$W_d(u) = d K(u) \cosh\left(\frac{du}{2}\right) - 2 K'(u) \sinh\left(\frac{du}{2}\right).$$ -/
def envelopeW (d : ℝ) (K K' : ℝ → ℝ) (u : ℝ) : ℝ :=
  d * K u * cosh (d * u / 2) - 2 * K' u * sinh (d * u / 2)

/-- Derivative identity for the abstract envelope:
If $K$ has derivative $K'$ and $K'$ has derivative $K''$ at $u$, the derivative of $W_d$ evaluates to:
$$W_d'(u) = \left(\frac{d^2}{2} K(u) - 2 K''(u)\right) \sinh\left(\frac{du}{2}\right).$$
In particular, the cross-terms $d K'(u) \cosh(du/2)$ cancel identically. -/
theorem hasDerivAt_envelopeW (d : ℝ) {K K' K'' : ℝ → ℝ} {u : ℝ}
    (hK : HasDerivAt K (K' u) u) (hK' : HasDerivAt K' (K'' u) u) :
    HasDerivAt (envelopeW d K K')
      (((d ^ 2 / 2) * K u - 2 * K'' u) * sinh (d * u / 2)) u := by
  have h_lin : HasDerivAt (fun x : ℝ ↦ d * x / 2) (d / 2) u := by
    have h : (fun x : ℝ ↦ d * x / 2) = (fun x ↦ x * (d / 2)) := by ext; ring
    rw [h]
    simpa using (hasDerivAt_id' u).mul_const (d / 2)
  have h_cosh : HasDerivAt (fun x ↦ cosh (d * x / 2)) ((d / 2) * sinh (d * u / 2)) u := by
    have := (hasDerivAt_cosh (d * u / 2)).comp u h_lin
    simpa [mul_comm] using this
  have h_sinh : HasDerivAt (fun x ↦ sinh (d * x / 2)) ((d / 2) * cosh (d * u / 2)) u := by
    have := (hasDerivAt_sinh (d * u / 2)).comp u h_lin
    simpa [mul_comm] using this
  have h_term1 := (hK.const_mul d).mul h_cosh
  have h_term2 := (hK'.const_mul 2).mul h_sinh
  have h_diff := h_term1.sub h_term2
  unfold envelopeW
  have h_alg : (d * K' u * cosh (d * u / 2) + d * K u * (d / 2 * sinh (d * u / 2))) -
      (2 * K'' u * sinh (d * u / 2) + 2 * K' u * (d / 2 * cosh (d * u / 2))) =
      ((d ^ 2 / 2) * K u - 2 * K'' u) * sinh (d * u / 2) := by
    ring
  rw [h_alg] at h_diff
  exact h_diff

/-- The displayed derivative expression vanishes at `u = 0` because `sinh 0 = 0`. -/
theorem envelopeW_deriv_zero (d : ℝ) (K K'' : ℝ → ℝ) :
    (((d ^ 2 / 2) * K 0 - 2 * K'' 0) * sinh (d * 0 / 2)) = 0 := by
  have h0 : d * 0 / 2 = 0 := by ring
  rw [h0, sinh_zero]
  ring

/-! ### Section 3: Axiom Verification -/

#print axioms gaussianMode_pos
#print axioms hasDerivAt_gaussianMode
#print axioms gaussianMode_factor_neg
#print axioms gaussianMode_deriv_neg
#print axioms hasDerivAt_envelopeW
#print axioms envelopeW_deriv_zero

end

end BuildingBlocks.RiemannZetaThetaEnvelopeMonotonicity
