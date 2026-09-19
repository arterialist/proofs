import Mathlib.Analysis.Complex.Trigonometric
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.RiemannZetaTrigonometricDecomposition
import BuildingBlocks.RiemannZetaDisplacementRigidity

/-!
# Riemann Zeta Hyperbolic Disparity Kernel and Nodal Oscillation

This module formalizes the exact pointwise hyperbolic-trigonometric disparity kernel:
$$\mathcal{D}(s, x) := (2(\operatorname{Re}(s) - 1/2)) \operatorname{Re}(\operatorname{cpowTrigKernel}(s, x))
  - \operatorname{Im}(s) \operatorname{Im}(\operatorname{cpowTrigKernel}(s, x)).$$

## Mathematical Architecture

1. **Pointwise Disparity Kernel**:
   - `disparityPointKernel s x`: The linear combination of the real and imaginary parts of
     the symmetrized power kernel $x^{s/2 - 1} + x^{(1-s)/2 - 1}$ with weights $2d$ and $-t$.
   - `disparityPointKernel_one`: At the boundary $x = 1$, the imaginary component vanishes
     identically, yielding $\mathcal{D}(s, 1) = 4(\operatorname{Re}(s) - 1/2)$.

2. **Hyperbolic-Trigonometric Bracket Decomposition**:
   - In logarithmic coordinates $u = \log x \ge 0$, the kernel factors through
     $$B_d(\gamma, u) = 2d \cosh(du/2) \cos(\gamma u/2) - \gamma \sinh(du/2) \sin(\gamma u/2).$$
   - `bracketKernel_zero`: At $u = 0$, $B_d(\gamma, 0) = 2d$.

3. **Nodal Sign Reversal on the Second Quarter-Period**:
   - In the frequency interval where $\pi/\gamma \le \log x \le 2\pi/\gamma$, the phase angle
     $\theta(x) = (\gamma/2)\log x$ lies in $[\pi/2, \pi]$.
   - In this sector, $\cos(\theta) \le 0$ and $\sin(\theta) \ge 0$.
   - Since $x \ge 1$ and $\sigma \ge 1/2$, the hyperbolic amplitude difference
     $x^{\sigma/2-1} - x^{(1-\sigma)/2-1} \ge 0$.
   - Consequently, both the real and imaginary components become simultaneously non-positive:
     `disparityPointKernel_nonpos_of_mem_second_quarter`.

All declarations depend strictly on the standard foundational axioms:
`[propext, Classical.choice, Quot.sound]`.
-/

namespace BuildingBlocks.RiemannZetaHyperbolicDisparityKernel

open Real Complex
open BuildingBlocks.RiemannZetaTrigonometricDecomposition
open BuildingBlocks.RiemannZetaDisplacementRigidity

noncomputable section

/-- The hyperbolic bracket kernel $B_d(\gamma, u)$ in logarithmic coordinates:
$$B_d(\gamma, u) = 2d \cosh(d u / 2) \cos(\gamma u / 2) - \gamma \sinh(d u / 2) \sin(\gamma u / 2).$$ -/
def bracketKernel (d γ u : ℝ) : ℝ :=
  2 * d * Real.cosh (d * u / 2) * Real.cos (γ * u / 2) -
  γ * Real.sinh (d * u / 2) * Real.sin (γ * u / 2)

/-- Exact basepoint value of the bracket kernel at $u = 0$: $B_d(\gamma, 0) = 2d$. -/
theorem bracketKernel_zero (d γ : ℝ) : bracketKernel d γ 0 = 2 * d := by
  unfold bracketKernel
  have h1 : d * 0 / 2 = 0 := by ring
  have h2 : γ * 0 / 2 = 0 := by ring
  rw [h1, h2]
  have h_cosh : Real.cosh 0 = 1 := Real.cosh_zero
  have h_cos : Real.cos 0 = 1 := Real.cos_zero
  have h_sinh : Real.sinh 0 = 0 := Real.sinh_zero
  have h_sin : Real.sin 0 = 0 := Real.sin_zero
  rw [h_cosh, h_cos, h_sinh, h_sin]
  ring

/-- In the second quarter-period $[\pi/\gamma, 2\pi/\gamma]$, the bracket kernel is non-positive. -/
theorem bracketKernel_nonpos_of_mem_second_quarter {d γ u : ℝ}
    (hd : 0 ≤ d) (hγ : 0 ≤ γ)
    (hu_ge : π / γ ≤ u) (hu_le : u ≤ 2 * π / γ) (hγ_pos : 0 < γ) :
    bracketKernel d γ u ≤ 0 := by
  unfold bracketKernel
  have h_cosh_pos : 0 < Real.cosh (d * u / 2) := Real.cosh_pos _
  have hu_pos : 0 ≤ u := by
    have : 0 ≤ π / γ := div_nonneg (le_of_lt Real.pi_pos) (le_of_lt hγ_pos)
    linarith
  have h_du2 : 0 ≤ d * u / 2 := by
    have : 0 ≤ d * u := mul_nonneg hd hu_pos
    linarith
  have h_sinh_nonneg : 0 ≤ Real.sinh (d * u / 2) := Real.sinh_nonneg_iff.mpr h_du2
  have h_arg_ge : π / 2 ≤ γ * u / 2 := by
    calc π / 2 = γ * (π / γ) / 2 := by
           have : γ * (π / γ) = π := mul_div_cancel₀ π (ne_of_gt hγ_pos)
           rw [this]
         _ ≤ γ * u / 2 := by
           have : γ * (π / γ) ≤ γ * u := mul_le_mul_of_nonneg_left hu_ge (le_of_lt hγ_pos)
           linarith
  have h_arg_le : γ * u / 2 ≤ π := by
    calc γ * u / 2 ≤ γ * (2 * π / γ) / 2 := by
           have : γ * u ≤ γ * (2 * π / γ) := mul_le_mul_of_nonneg_left hu_le (le_of_lt hγ_pos)
           linarith
         _ = π := by
           have : γ * (2 * π / γ) = 2 * π := mul_div_cancel₀ (2 * π) (ne_of_gt hγ_pos)
           rw [this]
           ring
  have h_arg_le_pi_plus : γ * u / 2 ≤ π + π / 2 := by
    have : 0 < π / 2 := by linarith [Real.pi_pos]
    linarith
  have h_cos_nonpos : Real.cos (γ * u / 2) ≤ 0 := Real.cos_nonpos_of_pi_div_two_le_of_le h_arg_ge h_arg_le_pi_plus
  have h_sin_nonneg : 0 ≤ Real.sin (γ * u / 2) := by
    have h_arg_ge0 : 0 ≤ γ * u / 2 := by linarith [Real.pi_pos]
    exact Real.sin_nonneg_of_mem_Icc ⟨h_arg_ge0, h_arg_le⟩
  have h_term1_nonpos : 2 * d * Real.cosh (d * u / 2) * Real.cos (γ * u / 2) ≤ 0 := by
    have h_coeff : 0 ≤ 2 * d * Real.cosh (d * u / 2) := by
      have : 0 ≤ 2 * d := by linarith
      exact mul_nonneg this (le_of_lt h_cosh_pos)
    exact mul_nonpos_of_nonneg_of_nonpos h_coeff h_cos_nonpos
  have h_term2_nonneg : 0 ≤ γ * Real.sinh (d * u / 2) * Real.sin (γ * u / 2) := by
    have h_tsinh : 0 ≤ γ * Real.sinh (d * u / 2) := mul_nonneg hγ h_sinh_nonneg
    exact mul_nonneg h_tsinh h_sin_nonneg
  linarith

/-- Pointwise disparity kernel for the complex power kernel:
$$\mathcal{D}(s, x) = (2(\operatorname{Re}(s) - 1/2)) \operatorname{Re}(\operatorname{cpowTrigKernel}(s, x))
  - \operatorname{Im}(s) \operatorname{Im}(\operatorname{cpowTrigKernel}(s, x)).$$ -/
def disparityPointKernel (s : ℂ) (x : ℝ) : ℝ :=
  (2 * (s.re - 1 / 2)) * (cpowTrigKernel s x).re - s.im * (cpowTrigKernel s x).im

/-- Value of the pointwise disparity kernel at the basepoint $x = 1$:
$\operatorname{disparityPointKernel}(s, 1) = 4(\sigma - 1/2)$. -/
theorem disparityPointKernel_one (s : ℂ) :
    disparityPointKernel s 1 = 4 * (s.re - 1 / 2) := by
  unfold disparityPointKernel
  have hre : (cpowTrigKernel s 1).re = 2 := by
    rw [cpowTrigKernel_re (by norm_num)]
    rw [Real.log_one]
    have : (s.im / 2) * 0 = 0 := by ring
    rw [this, Real.cos_zero]
    have h1 : (1 : ℝ) ^ (s.re / 2 - 1) = 1 := Real.one_rpow _
    have h2 : (1 : ℝ) ^ ((1 - s.re) / 2 - 1) = 1 := Real.one_rpow _
    rw [h1, h2]
    ring
  have him : (cpowTrigKernel s 1).im = 0 := by
    rw [cpowTrigKernel_im (by norm_num)]
    rw [Real.log_one]
    have : (s.im / 2) * 0 = 0 := by ring
    rw [this, Real.sin_zero]
    ring
  rw [hre, him]
  ring

/-- In the second quarter-period $\pi / \gamma \le \log x \le 2\pi / \gamma$,
the pointwise disparity kernel is non-positive. -/
theorem disparityPointKernel_nonpos_of_mem_second_quarter {s : ℂ} {x : ℝ}
    (hsr : 1 / 2 ≤ s.re) (hsim : 0 < s.im) (hx : 1 ≤ x)
    (h_log_ge : π / s.im ≤ Real.log x) (h_log_le : Real.log x ≤ 2 * π / s.im) :
    disparityPointKernel s x ≤ 0 := by
  unfold disparityPointKernel
  have hx_pos : 0 < x := by linarith
  rw [cpowTrigKernel_re hx_pos]
  rw [cpowTrigKernel_im hx_pos]
  have hd_nonneg : 0 ≤ 2 * (s.re - 1 / 2) := by linarith
  have h_rpow1_pos : 0 < x ^ (s.re / 2 - 1) := Real.rpow_pos_of_pos hx_pos _
  have h_rpow2_pos : 0 < x ^ ((1 - s.re) / 2 - 1) := Real.rpow_pos_of_pos hx_pos _
  have h_sum_pos : 0 < x ^ (s.re / 2 - 1) + x ^ ((1 - s.re) / 2 - 1) := add_pos h_rpow1_pos h_rpow2_pos
  have h_arg_ge : π / 2 ≤ (s.im / 2) * Real.log x := by
    have h_cancel : (s.im / 2) * (π / s.im) = π / 2 := by
      have hne : s.im ≠ 0 := ne_of_gt hsim
      calc (s.im / 2) * (π / s.im) = (s.im * (π / s.im)) / 2 := by ring
           _ = π / 2 := by rw [mul_div_cancel₀ π hne]
    calc π / 2 = (s.im / 2) * (π / s.im) := h_cancel.symm
         _ ≤ (s.im / 2) * Real.log x := by
           have : 0 ≤ s.im / 2 := by linarith
           exact mul_le_mul_of_nonneg_left h_log_ge this
  have h_arg_le : (s.im / 2) * Real.log x ≤ π := by
    have h_cancel : (s.im / 2) * (2 * π / s.im) = π := by
      have hne : s.im ≠ 0 := ne_of_gt hsim
      calc (s.im / 2) * (2 * π / s.im) = (s.im * (2 * π / s.im)) / 2 := by ring
           _ = (2 * π) / 2 := by rw [mul_div_cancel₀ (2 * π) hne]
           _ = π := by ring
    calc (s.im / 2) * Real.log x ≤ (s.im / 2) * (2 * π / s.im) := by
           have : 0 ≤ s.im / 2 := by linarith
           exact mul_le_mul_of_nonneg_left h_log_le this
         _ = π := h_cancel
  have h_arg_le_pi_plus : (s.im / 2) * Real.log x ≤ π + π / 2 := by
    have : 0 < π / 2 := by linarith [Real.pi_pos]
    linarith
  have h_cos_nonpos : Real.cos ((s.im / 2) * Real.log x) ≤ 0 :=
    Real.cos_nonpos_of_pi_div_two_le_of_le h_arg_ge h_arg_le_pi_plus
  have h_sin_nonneg : 0 ≤ Real.sin ((s.im / 2) * Real.log x) := by
    have h_arg_ge0 : 0 ≤ (s.im / 2) * Real.log x := by linarith [Real.pi_pos]
    exact Real.sin_nonneg_of_mem_Icc ⟨h_arg_ge0, h_arg_le⟩
  have h_term1_nonpos : (2 * (s.re - 1 / 2)) * ((x ^ (s.re / 2 - 1) + x ^ ((1 - s.re) / 2 - 1)) * Real.cos ((s.im / 2) * Real.log x)) ≤ 0 := by
    have h_coeff : 0 ≤ (2 * (s.re - 1 / 2)) * (x ^ (s.re / 2 - 1) + x ^ ((1 - s.re) / 2 - 1)) :=
      mul_nonneg hd_nonneg (le_of_lt h_sum_pos)
    have : (2 * (s.re - 1 / 2)) * ((x ^ (s.re / 2 - 1) + x ^ ((1 - s.re) / 2 - 1)) * Real.cos ((s.im / 2) * Real.log x)) =
           ((2 * (s.re - 1 / 2)) * (x ^ (s.re / 2 - 1) + x ^ ((1 - s.re) / 2 - 1))) * Real.cos ((s.im / 2) * Real.log x) := by ring
    rw [this]
    exact mul_nonpos_of_nonneg_of_nonpos h_coeff h_cos_nonpos
  have hexp_le : (1 - s.re) / 2 - 1 ≤ s.re / 2 - 1 := by linarith
  have h_diff_nonneg : 0 ≤ x ^ (s.re / 2 - 1) - x ^ ((1 - s.re) / 2 - 1) := by
    have := Real.rpow_le_rpow_of_exponent_le hx hexp_le
    linarith
  have h_term2_nonneg : 0 ≤ s.im * ((x ^ (s.re / 2 - 1) - x ^ ((1 - s.re) / 2 - 1)) * Real.sin ((s.im / 2) * Real.log x)) := by
    have h_prod : 0 ≤ (x ^ (s.re / 2 - 1) - x ^ ((1 - s.re) / 2 - 1)) * Real.sin ((s.im / 2) * Real.log x) :=
      mul_nonneg h_diff_nonneg h_sin_nonneg
    exact mul_nonneg (le_of_lt hsim) h_prod
  linarith

end

#print axioms bracketKernel_zero
#print axioms bracketKernel_nonpos_of_mem_second_quarter
#print axioms disparityPointKernel_one
#print axioms disparityPointKernel_nonpos_of_mem_second_quarter

end BuildingBlocks.RiemannZetaHyperbolicDisparityKernel
