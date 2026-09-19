/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import Mathlib.Analysis.Complex.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Pow.Complex
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.Scope
import BuildingBlocks.RiemannZetaGlobalSchwarzReflection
import BuildingBlocks.RiemannZetaKernelPositivity
import BuildingBlocks.RiemannZetaKernelEnergyBound
import BuildingBlocks.RiemannZetaUpperHalfPlaneReduction
import BuildingBlocks.RiemannZetaOffLineZeroLocalization

/-!
# Module 288: Riemann Zeta Trigonometric Decomposition and Mellin Kernel Positivity

This module formalizes the trigonometric decomposition of the symmetrized complex power kernel
$$x^{s/2 - 1} + x^{(1-s)/2 - 1}$$
and the corresponding imaginary Mellin integrand of the completed Riemann zeta function $\Lambda_0(s)$.

## Mathematical Architecture

1. **Trigonometric Exponent Real and Imaginary Parts**:
   - `cpow_ofReal_re_eq_rpow`: For $x > 0$ and $z \in \mathbb{C}$,
     $$\operatorname{Re}(x^z) = x^{\operatorname{Re}(z)} \cos(\operatorname{Im}(z) \log x).$$
   - `cpow_ofReal_im_eq_rpow`: For $x > 0$ and $z \in \mathbb{C}$,
     $$\operatorname{Im}(x^z) = x^{\operatorname{Re}(z)} \sin(\operatorname{Im}(z) \log x).$$

2. **Symmetrized Trigonometric Kernel**:
   - `cpowTrigKernel`: The symmetrized sum $x^{s/2 - 1} + x^{(1-s)/2 - 1}$.
   - `cpowTrigKernel_re`: The real part equals
     $$(x^{\beta/2 - 1} + x^{(1-\beta)/2 - 1}) \cos\left(\frac{\gamma}{2} \log x\right).$$
   - `cpowTrigKernel_im`: The imaginary part equals
     $$(x^{\beta/2 - 1} - x^{(1-\beta)/2 - 1}) \sin\left(\frac{\gamma}{2} \log x\right) = \operatorname{powerDiff}(\beta, x) \sin\left(\frac{\gamma}{2} \log x\right).$$

3. **Critical Line Vanishing of the Imaginary Kernel**:
   - `cpowTrigKernel_im_critical_line`: When $\operatorname{Re}(s) = 1/2$, the imaginary part
     vanishes identically for all $x > 0$.
   - `mellinTrigIntegrandIm_critical_line`: The imaginary Mellin integrand vanishes identically
     along the critical line $\operatorname{Re}(s) = 1/2$.

4. **Off-Line Kernel Positivity on the Fundamental Half-Period**:
   - `halfPeriodHorizon`: The first nodal transition point $x_{\text{crit}} = \exp(2\pi / \gamma)$.
   - `halfPeriodHorizon_gt_one`: $x_{\text{crit}} > 1$ for all $\gamma > 0$.
   - `mellinTrigIntegrandIm_pos_of_mem_first_half_period`: For any $s$ in the upper critical strip
     ($\beta > 1/2, \gamma > 0$) and any $x \in (1, \exp(2\pi / \gamma))$, the imaginary Mellin
     integrand is strictly positive.

5. **Infinitesimal Ratio Majorization and Exponential Decay**:
   - `sin_div_gamma_le`: Universal bound $\frac{\sin((\gamma/2)\log x)}{\gamma} \le \frac{1}{2}\log x$.
   - `powerDiff_nonneg`: $\operatorname{powerDiff}(\beta, x) \ge 0$ for $\beta \ge 1/2$ and $x \ge 1$.
   - `mellinTrigIntegrandIm_div_im_le`: Pointwise bound by $\frac{1}{2} \log x \cdot f_{\text{modif}}(x)$.
   - `mellinTrigIntegrandIm_div_im_le_two_exp`: Pointwise bound by $2 \log x \cdot e^{-\pi x}$.
-/

open Real Complex
open BuildingBlocks.RiemannZetaGlobalSchwarzReflection
open BuildingBlocks.RiemannZetaKernelPositivity
open BuildingBlocks.RiemannZetaKernelEnergyBound
open BuildingBlocks.RiemannZetaUpperHalfPlaneReduction
open BuildingBlocks.RiemannZetaOffLineZeroLocalization

namespace BuildingBlocks.RiemannZetaTrigonometricDecomposition

/-! ### Subsection 1: Trigonometric Power Evaluations -/

/-- For any positive real $x > 0$ and complex exponent $z$, the real part of $x^z$
equals $x^{\operatorname{Re}(z)} \cos(\operatorname{Im}(z) \log x)$. -/
lemma cpow_ofReal_re_eq_rpow {x : ℝ} (hx : 0 < x) (z : ℂ) :
    ((x : ℂ) ^ z).re = x ^ z.re * Real.cos (z.im * Real.log x) := by
  have hne : (x : ℂ) ≠ 0 := ofReal_ne_zero.mpr (ne_of_gt hx)
  have hpos_le : 0 ≤ x := le_of_lt hx
  rw [cpow_def, if_neg hne]
  rw [← ofReal_log hpos_le]
  have hmul_re : ((x.log : ℂ) * z).re = z.re * x.log := by simp [mul_comm]
  have hmul_im : ((x.log : ℂ) * z).im = z.im * x.log := by simp [mul_comm]
  rw [exp_re, hmul_re, hmul_im]
  rw [rpow_def_of_pos hx]
  rw [mul_comm (Real.log x) z.re]

/-- For any positive real $x > 0$ and complex exponent $z$, the imaginary part of $x^z$
equals $x^{\operatorname{Re}(z)} \sin(\operatorname{Im}(z) \log x)$. -/
lemma cpow_ofReal_im_eq_rpow {x : ℝ} (hx : 0 < x) (z : ℂ) :
    ((x : ℂ) ^ z).im = x ^ z.re * Real.sin (z.im * Real.log x) := by
  have hne : (x : ℂ) ≠ 0 := ofReal_ne_zero.mpr (ne_of_gt hx)
  have hpos_le : 0 ≤ x := le_of_lt hx
  rw [cpow_def, if_neg hne]
  rw [← ofReal_log hpos_le]
  have hmul_re : ((x.log : ℂ) * z).re = z.re * x.log := by simp [mul_comm]
  have hmul_im : ((x.log : ℂ) * z).im = z.im * x.log := by simp [mul_comm]
  rw [exp_im, hmul_re, hmul_im]
  rw [rpow_def_of_pos hx]
  rw [mul_comm (Real.log x) z.re]

/-! ### Subsection 2: Symmetrized Trigonometric Kernel Definition -/

/-- The symmetrized complex power kernel $x^{s/2 - 1} + x^{(1-s)/2 - 1}$. -/
noncomputable def cpowTrigKernel (s : ℂ) (x : ℝ) : ℂ :=
  (x : ℂ) ^ (s / 2 - 1) + (x : ℂ) ^ ((1 - s) / 2 - 1)

/-- The imaginary Mellin integrand formed by coupling the imaginary part of
the symmetrized kernel with the modifying theta kernel `real_f_modif`. -/
noncomputable def mellinTrigIntegrandIm (s : ℂ) (x : ℝ) : ℝ :=
  (cpowTrigKernel s x).im * real_f_modif x

/-- The real Mellin integrand formed by coupling the real part of
the symmetrized kernel with the modifying theta kernel `real_f_modif`. -/
noncomputable def mellinTrigIntegrandRe (s : ℂ) (x : ℝ) : ℝ :=
  (cpowTrigKernel s x).re * real_f_modif x

/-- Real part of the symmetrized kernel in coordinates $(\beta, \gamma)$. -/
theorem cpowTrigKernel_re {s : ℂ} {x : ℝ} (hx : 0 < x) :
    (cpowTrigKernel s x).re =
      (x ^ (s.re / 2 - 1) + x ^ ((1 - s.re) / 2 - 1)) * Real.cos ((s.im / 2) * Real.log x) := by
  unfold cpowTrigKernel
  rw [add_re, cpow_ofReal_re_eq_rpow hx, cpow_ofReal_re_eq_rpow hx]
  simp only [sub_re, div_ofNat_re, one_re, sub_im, div_ofNat_im, one_im, sub_zero, zero_sub]
  have hcos_neg : Real.cos ((-s.im / 2) * Real.log x) = Real.cos ((s.im / 2) * Real.log x) := by
    have : (-s.im / 2) * Real.log x = -((s.im / 2) * Real.log x) := by ring
    rw [this, Real.cos_neg]
  rw [hcos_neg]
  ring

/-- Imaginary part of the symmetrized kernel in coordinates $(\beta, \gamma)$. -/
theorem cpowTrigKernel_im {s : ℂ} {x : ℝ} (hx : 0 < x) :
    (cpowTrigKernel s x).im =
      (x ^ (s.re / 2 - 1) - x ^ ((1 - s.re) / 2 - 1)) * Real.sin ((s.im / 2) * Real.log x) := by
  unfold cpowTrigKernel
  rw [add_im, cpow_ofReal_im_eq_rpow hx, cpow_ofReal_im_eq_rpow hx]
  simp only [sub_re, div_ofNat_re, one_re, sub_im, div_ofNat_im, one_im, sub_zero, zero_sub]
  have hsin_neg : Real.sin ((-s.im / 2) * Real.log x) = -Real.sin ((s.im / 2) * Real.log x) := by
    have : (-s.im / 2) * Real.log x = -((s.im / 2) * Real.log x) := by ring
    rw [this, Real.sin_neg]
  rw [hsin_neg]
  ring

/-! ### Subsection 3: Critical Line Vanishing -/

/-- On the critical line $\operatorname{Re}(s) = 1/2$, the imaginary part of the
symmetrized kernel vanishes identically for every $x > 0$. -/
theorem cpowTrigKernel_im_critical_line {s : ℂ} (hs : s.re = 1 / 2) {x : ℝ} (hx : 0 < x) :
    (cpowTrigKernel s x).im = 0 := by
  rw [cpowTrigKernel_im hx]
  have heq : s.re / 2 - 1 = (1 - s.re) / 2 - 1 := by
    rw [hs]
    ring
  rw [heq, sub_self, zero_mul]

/-- On the critical line $\operatorname{Re}(s) = 1/2$, the imaginary Mellin integrand
vanishes identically for every $x > 0$. -/
theorem mellinTrigIntegrandIm_critical_line {s : ℂ} (hs : s.re = 1 / 2) {x : ℝ} (hx : 0 < x) :
    mellinTrigIntegrandIm s x = 0 := by
  unfold mellinTrigIntegrandIm
  rw [cpowTrigKernel_im_critical_line hs hx, zero_mul]

/-! ### Subsection 4: Factorization via Hyperbolic Power Difference -/

/-- The imaginary kernel factors into the hyperbolic power difference `powerDiff`
and the oscillatory sine component $\sin((\gamma / 2) \log x)$. -/
theorem cpowTrigKernel_im_eq_powerDiff_mul_sin {s : ℂ} {x : ℝ} (hx : 0 < x) :
    (cpowTrigKernel s x).im = powerDiff s.re x * Real.sin ((s.im / 2) * Real.log x) := by
  rw [cpowTrigKernel_im hx]
  rfl

/-- For $\beta \ge 1/2$ and $x \ge 1$, the hyperbolic power difference $\operatorname{powerDiff}(\beta, x)$
is non-negative. -/
theorem powerDiff_nonneg {β x : ℝ} (hβ : (1 : ℝ) / 2 ≤ β) (hx : 1 ≤ x) :
    0 ≤ powerDiff β x := by
  rcases eq_or_lt_of_le hβ with heq | hlt
  · unfold powerDiff
    rw [← heq]
    have : ((1 : ℝ) / 2) / 2 - 1 = (1 - (1 : ℝ) / 2) / 2 - 1 := by ring
    rw [this, sub_self]
  · rcases eq_or_lt_of_le hx with heq_x | hlt_x
    · unfold powerDiff
      rw [← heq_x, Real.one_rpow, Real.one_rpow, sub_self]
    · exact le_of_lt (powerDiff_pos hlt hlt_x)

/-! ### Subsection 5: First Half-Period Positivity -/

/-- Auxiliary inequality: for any non-negative $u \ge 0$, $\sin u \le u$. -/
lemma sin_le_self {x : ℝ} (hx : 0 ≤ x) : Real.sin x ≤ x := by
  have h := Real.abs_sin_le_abs (x := x)
  rw [_root_.abs_of_nonneg hx] at h
  exact (le_abs_self (Real.sin x)).trans h

/-- The normalized sine factor $\sin((\gamma / 2) \log x) / \gamma$ is bounded by
$\frac{1}{2} \log x$ for all $\gamma > 0$ and $x \ge 1$. -/
theorem sin_div_gamma_le {γ x : ℝ} (hγ : 0 < γ) (hx : 1 ≤ x) :
    Real.sin ((γ / 2) * Real.log x) / γ ≤ (1 / 2) * Real.log x := by
  have hlog_nonneg : 0 ≤ Real.log x := Real.log_nonneg hx
  have hphase_nonneg : 0 ≤ (γ / 2) * Real.log x := by
    have : 0 ≤ γ / 2 := by linarith
    exact mul_nonneg this hlog_nonneg
  have hsin_le := sin_le_self hphase_nonneg
  have hdiv : Real.sin ((γ / 2) * Real.log x) / γ ≤ ((γ / 2) * Real.log x) / γ :=
    div_le_div_of_nonneg_right hsin_le (le_of_lt hγ)
  have heq : ((γ / 2) * Real.log x) / γ = (1 / 2) * Real.log x := by
    field_simp
  linarith

/-- When the oscillatory phase lies strictly in $(0, \pi)$, the imaginary Mellin
integrand is strictly positive for any off-line zero coordinate $\beta > 1/2$ and $x > 1$. -/
theorem mellinTrigIntegrandIm_pos_of_phase_in_zero_pi {s : ℂ} {x : ℝ}
    (hsr : 1 / 2 < s.re) (hx1 : 1 < x)
    (hphase_pos : 0 < (s.im / 2) * Real.log x)
    (hphase_lt_pi : (s.im / 2) * Real.log x < Real.pi) :
    0 < mellinTrigIntegrandIm s x := by
  unfold mellinTrigIntegrandIm
  have hx_pos : 0 < x := by linarith
  rw [cpowTrigKernel_im_eq_powerDiff_mul_sin hx_pos]
  have h_pd : 0 < powerDiff s.re x := powerDiff_pos hsr hx1
  have h_sin : 0 < Real.sin ((s.im / 2) * Real.log x) := Real.sin_pos_of_mem_Ioo ⟨hphase_pos, hphase_lt_pi⟩
  have h_f : 0 < real_f_modif x := real_f_modif_pos_of_gt_one hx1
  have h_prod : 0 < powerDiff s.re x * Real.sin ((s.im / 2) * Real.log x) := mul_pos h_pd h_sin
  exact mul_pos h_prod h_f

/-- The first half-period horizon $x_{\text{crit}} = \exp(2\pi / \gamma)$, marking the
first positive half-cycle of the imaginary kernel. -/
noncomputable def halfPeriodHorizon (γ : ℝ) : ℝ :=
  Real.exp (2 * Real.pi / γ)

/-- The first half-period horizon strictly exceeds 1 for any positive frequency $\gamma > 0$. -/
theorem halfPeriodHorizon_gt_one {γ : ℝ} (hγ : 0 < γ) :
    1 < halfPeriodHorizon γ := by
  unfold halfPeriodHorizon
  rw [← Real.exp_zero]
  have : 0 < 2 * Real.pi / γ := by
    have : 0 < 2 * Real.pi := by positivity
    exact div_pos this hγ
  exact Real.exp_lt_exp.mpr this

/-- Fundamental Positivity: On the interval $(1, \exp(2\pi / \gamma))$, the imaginary
Mellin integrand $\operatorname{mellinTrigIntegrandIm}(s, x)$ is strictly positive
for any off-line zero candidate with $\operatorname{Re}(s) > 1/2$ and $\operatorname{Im}(s) > 0$. -/
theorem mellinTrigIntegrandIm_pos_of_mem_first_half_period {s : ℂ} {x : ℝ}
    (hsr : 1 / 2 < s.re) (hsim : 0 < s.im)
    (hx1 : 1 < x) (hx2 : x < halfPeriodHorizon s.im) :
    0 < mellinTrigIntegrandIm s x := by
  unfold halfPeriodHorizon at hx2
  have hlog_pos : 0 < Real.log x := Real.log_pos hx1
  have hphase_pos : 0 < (s.im / 2) * Real.log x := by
    have : 0 < s.im / 2 := by linarith
    exact mul_pos this hlog_pos
  have hx_pos : 0 < x := by linarith
  have hlog_lt : Real.log x < 2 * Real.pi / s.im := by
    rw [← Real.log_exp (2 * Real.pi / s.im)]
    exact Real.log_lt_log hx_pos hx2
  have hphase_lt_pi : (s.im / 2) * Real.log x < Real.pi := by
    have h1 : (s.im / 2) * Real.log x < (s.im / 2) * (2 * Real.pi / s.im) := by
      exact mul_lt_mul_of_pos_left hlog_lt (by linarith)
    have h2 : (s.im / 2) * (2 * Real.pi / s.im) = Real.pi := by
      have : s.im ≠ 0 := by linarith
      field_simp
    linarith
  exact mellinTrigIntegrandIm_pos_of_phase_in_zero_pi hsr hx1 hphase_pos hphase_lt_pi

/-! ### Subsection 6: Infinitesimal Ratio Bounds and Uniform Exponential Majorization -/

/-- Pointwise bound on the imaginary ratio integrand:
$$\frac{\operatorname{mellinTrigIntegrandIm}(s, x)}{\gamma} \le \frac{1}{2} \log x \cdot f_{\text{modif}}(x).$$ -/
theorem mellinTrigIntegrandIm_div_im_le {s : ℂ} {x : ℝ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im) (hx : 1 ≤ x) :
    mellinTrigIntegrandIm s x / s.im ≤ (1 / 2) * Real.log x * real_f_modif x := by
  unfold mellinTrigIntegrandIm
  have hx_pos : 0 < x := by linarith
  rw [cpowTrigKernel_im_eq_powerDiff_mul_sin hx_pos]
  have h_f_nonneg : 0 ≤ real_f_modif x := real_f_modif_nonneg x
  have h_pd_le : powerDiff s.re x ≤ 1 := powerDiff_le_one hsr2 hx
  have h_pd_nonneg : 0 ≤ powerDiff s.re x := powerDiff_nonneg hsr1 hx
  have h_sin_div : Real.sin ((s.im / 2) * Real.log x) / s.im ≤ (1 / 2) * Real.log x :=
    sin_div_gamma_le hsim hx
  have h_alg : (powerDiff s.re x * Real.sin ((s.im / 2) * Real.log x) * real_f_modif x) / s.im =
      powerDiff s.re x * (Real.sin ((s.im / 2) * Real.log x) / s.im) * real_f_modif x := by
    ring
  rw [h_alg]
  have h_mul1 : powerDiff s.re x * (Real.sin ((s.im / 2) * Real.log x) / s.im) ≤
      1 * ((1 / 2) * Real.log x) := by
    have h_log_nonneg : 0 ≤ (1 / 2) * Real.log x := by
      have : 0 ≤ Real.log x := Real.log_nonneg hx
      linarith
    nlinarith
  nlinarith

/-- Pointwise exponential majorization of the imaginary ratio integrand:
$$\frac{\operatorname{mellinTrigIntegrandIm}(s, x)}{\gamma} \le 2 \log x \cdot e^{-\pi x}.$$ -/
theorem mellinTrigIntegrandIm_div_im_le_two_exp {s : ℂ} {x : ℝ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im) (hx : 1 ≤ x) :
    mellinTrigIntegrandIm s x / s.im ≤ 2 * Real.log x * Real.exp (-π * x) := by
  have h1 : mellinTrigIntegrandIm s x / s.im ≤ (1 / 2) * Real.log x * real_f_modif x :=
    mellinTrigIntegrandIm_div_im_le hsr1 hsr2 hsim hx
  have h2 : real_f_modif x ≤ 4 * Real.exp (-π * x) :=
    real_f_modif_le_four_exp hx
  have hlog_nonneg : 0 ≤ Real.log x := Real.log_nonneg hx
  have : (1 / 2) * Real.log x * real_f_modif x ≤ (1 / 2) * Real.log x * (4 * Real.exp (-π * x)) := by
    nlinarith
  have : (1 / 2) * Real.log x * (4 * Real.exp (-π * x)) = 2 * Real.log x * Real.exp (-π * x) := by
    ring
  linarith

end BuildingBlocks.RiemannZetaTrigonometricDecomposition

open BuildingBlocks.RiemannZetaTrigonometricDecomposition

#print axioms cpowTrigKernel_re
#print axioms cpowTrigKernel_im
#print axioms cpowTrigKernel_im_critical_line
#print axioms mellinTrigIntegrandIm_pos_of_mem_first_half_period
#print axioms mellinTrigIntegrandIm_div_im_le_two_exp
