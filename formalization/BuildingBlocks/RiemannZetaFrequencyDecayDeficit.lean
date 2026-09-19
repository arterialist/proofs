/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist
-/
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Add
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.MeasureTheory.Integral.IntegralEqImproper
import BuildingBlocks.RiemannZetaKernelEnergyBound
import BuildingBlocks.RiemannZetaMellinIntegralEvaluation
import BuildingBlocks.RiemannZetaIntermediateDeficitExtension
import BuildingBlocks.RiemannZetaMellinIntegralDomination
import BuildingBlocks.RiemannZetaOffLineZeroLocalization
import BuildingBlocks.RiemannZetaTrigonometricDecomposition
import BuildingBlocks.RiemannZetaMellinEnergyIntegral
import BuildingBlocks.RiemannZetaGlobalSchwarzReflection
import BuildingBlocks.RiemannZetaIntermediateZeroFree
import BuildingBlocks.RiemannZetaHyperbolicMellinObstruction
import BuildingBlocks.RiemannZetaUnconditionalLowFrequency
import BuildingBlocks.RiemannZetaLowIntermediateDeficit

/-!
# Riemann Zeta Frequency Decay Deficit and Frontier Extension to $t = 5.47$

This module establishes the **Frequency Decay Deficit Theorem**, which leverages
oscillatory cancellation in the imaginary Mellin integrand to scale down the upper
bound on the halved symmetrized ratio integral by $1/\gamma_0$:
$$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{171 \gamma_0} \quad \text{for all } \operatorname{Im}(s) \ge \gamma_0 > 0.$$

By coupling this dynamic frequency decay with coordinate norm-squared bounds, we execute
a 4-step bootstrap chain extending the unconditional zero-free ceiling of the Riemann zeta
function on $\operatorname{Re}(s) > 1/2$:
1. **Step 1** ($4.6 \to 5.1$): $\frac{1}{171 \times 4.6} \le \frac{1}{786} < \frac{1}{703} \le \frac{1}{|s(s-1)|^2}$
2. **Step 2** ($5.1 \to 5.35$): $\frac{1}{171 \times 5.1} \le \frac{1}{872} < \frac{1}{848} \le \frac{1}{|s(s-1)|^2}$
3. **Step 3** ($5.35 \to 5.45$): $\frac{1}{171 \times 5.35} \le \frac{1}{914} < \frac{1}{912} \le \frac{1}{|s(s-1)|^2}$
4. **Step 4** ($5.45 \to 5.47$): $\frac{1}{171 \times 5.45} \le \frac{1}{931} < \frac{1}{926} \le \frac{1}{|s(s-1)|^2}$

This unconditionally eliminates any possibility of non-trivial zeros off the critical line
throughout the entire region $\operatorname{Re}(s) > 1/2, 0 < \operatorname{Im}(s) \le 5.47$.

## Axiom Status
All declarations depend strictly on standard foundational Lean 4 axioms:
- `propext`
- `Classical.choice`
- `Quot.sound`
No ad hoc axioms or unproven hypotheses are introduced.
-/

open Real Complex Set Filter Topology MeasureTheory
open BuildingBlocks.RiemannZetaKernelPositivity
open BuildingBlocks.RiemannZetaKernelEnergyBound
open BuildingBlocks.RiemannZetaMellinIntegralEvaluation
open BuildingBlocks.RiemannZetaIntermediateDeficitExtension
open BuildingBlocks.RiemannZetaMellinIntegralDomination
open BuildingBlocks.RiemannZetaOffLineZeroLocalization
open BuildingBlocks.RiemannZetaTrigonometricDecomposition
open BuildingBlocks.RiemannZetaMellinEnergyIntegral
open BuildingBlocks.RiemannZetaGlobalSchwarzReflection
open BuildingBlocks.RiemannZetaIntermediateZeroFree
open BuildingBlocks.RiemannZetaHyperbolicMellinObstruction
open BuildingBlocks.RiemannZetaUnconditionalLowFrequency
open BuildingBlocks.RiemannZetaLowIntermediateDeficit

namespace BuildingBlocks.RiemannZetaFrequencyDecayDeficit

noncomputable section

/-! ### Section 1: Linear-Exponential Integrals and Closed Forms -/

/-- Primitive function with derivative `-(x - 1) e^{-π x}`. -/
def antiF_lin (x : ℝ) : ℝ :=
  ((1 / Real.pi) * (x - 1) + (1 / Real.pi^2)) * Real.exp (-Real.pi * x)

/-- Primitive function with derivative `(x - 1) e^{-π x}`. -/
def antiG_lin (x : ℝ) : ℝ := - antiF_lin x

/-- Derivative of `antiF_lin` is `-(x - 1) e^{-π x}`. -/
theorem hasDerivAt_antiF_lin (x : ℝ) :
    HasDerivAt antiF_lin (- (x - 1) * Real.exp (-Real.pi * x)) x := by
  have hd_lin : HasDerivAt (fun y : ℝ => y - 1) 1 x := (hasDerivAt_id x).sub_const 1
  have hd_poly : HasDerivAt (fun y : ℝ => (1 / Real.pi) * (y - 1) + (1 / Real.pi^2))
      ((1 / Real.pi) * 1) x := by
    apply HasDerivAt.add_const
    exact hd_lin.const_mul (1 / Real.pi)
  have hd_exp : HasDerivAt (fun y : ℝ => Real.exp (-Real.pi * y))
      (-Real.pi * Real.exp (-Real.pi * x)) x := by
    have hlin : HasDerivAt (fun y : ℝ => -Real.pi * y) (-Real.pi) x := by
      simpa using (hasDerivAt_id x).const_mul (-Real.pi)
    have hexp := hlin.exp
    simpa [mul_comm] using hexp
  have h_prod := hd_poly.mul hd_exp
  unfold antiF_lin
  apply h_prod.congr_deriv
  have h_alg : ((1 / Real.pi) * 1) +
      ((1 / Real.pi) * (x - 1) + 1 / Real.pi^2) * (-Real.pi) = - (x - 1) := by
    field_simp
    ring
  calc ((1 / Real.pi) * 1) * Real.exp (-Real.pi * x) +
      ((1 / Real.pi) * (x - 1) + 1 / Real.pi^2) * (-Real.pi * Real.exp (-Real.pi * x))
    _ = (((1 / Real.pi) * 1) +
        ((1 / Real.pi) * (x - 1) + 1 / Real.pi^2) * (-Real.pi)) * Real.exp (-Real.pi * x) := by ring
    _ = - (x - 1) * Real.exp (-Real.pi * x) := by rw [h_alg]

/-- Derivative of `antiG_lin` is `(x - 1) e^{-π x}`. -/
theorem hasDerivAt_antiG_lin (x : ℝ) :
    HasDerivAt antiG_lin ((x - 1) * Real.exp (-Real.pi * x)) x := by
  unfold antiG_lin
  have h := (hasDerivAt_antiF_lin x).neg
  have h_eq : - (- (x - 1) * Real.exp (-Real.pi * x)) = (x - 1) * Real.exp (-Real.pi * x) := by ring
  exact h_eq ▸ h

/-- Asymptotic vanishing of `antiF_lin` as $x \to \infty$. -/
theorem tendsto_antiF_lin_atTop : Tendsto antiF_lin atTop (𝓝 0) := by
  have ht_u : Tendsto (fun x : ℝ => x - 1) atTop atTop :=
    tendsto_atTop_add_const_right atTop (-1) tendsto_id
  have h0 := tendsto_pow_mul_exp_neg_pi 0
  have h1 := tendsto_pow_mul_exp_neg_pi 1
  have h_comb : Tendsto (fun u : ℝ =>
      ((1 / Real.pi) * (u^1 * Real.exp (-Real.pi * u)) +
       (1 / Real.pi^2) * (u^0 * Real.exp (-Real.pi * u))) * Real.exp (-Real.pi)) atTop (𝓝 0) := by
    have l1 := (tendsto_const_nhds (x := 1 / Real.pi)).mul h1
    have l0 := (tendsto_const_nhds (x := 1 / Real.pi^2)).mul h0
    rw [mul_zero] at l1 l0
    have l_sum := l1.add l0
    have l_all := l_sum.mul (tendsto_const_nhds (x := Real.exp (-Real.pi)))
    have h_zero : (0 + 0 : ℝ) * Real.exp (-Real.pi) = 0 := by ring
    rw [h_zero] at l_all
    exact l_all
  have h_comp := h_comb.comp ht_u
  have h_eq : antiF_lin = (fun x : ℝ =>
      ((1 / Real.pi) * ((x - 1)^1 * Real.exp (-Real.pi * (x - 1))) +
       (1 / Real.pi^2) * ((x - 1)^0 * Real.exp (-Real.pi * (x - 1)))) * Real.exp (-Real.pi)) := by
    ext x
    unfold antiF_lin
    have h_exp_split : Real.exp (-Real.pi * x) = Real.exp (-Real.pi * (x - 1)) * Real.exp (-Real.pi) := by
      have : -Real.pi * x = -Real.pi * (x - 1) + -Real.pi := by ring
      rw [this, Real.exp_add]
    rw [h_exp_split]
    ring
  rw [h_eq]
  exact h_comp

/-- Asymptotic vanishing of `antiG_lin` as $x \to \infty$. -/
theorem tendsto_antiG_lin_atTop : Tendsto antiG_lin atTop (𝓝 0) := by
  unfold antiG_lin
  have h := tendsto_antiF_lin_atTop.neg
  rw [neg_zero] at h
  exact h

/-- Boundary evaluation: $\operatorname{antiG}_{\text{lin}}(1) = -e^{-\pi}/\pi^2$. -/
theorem antiG_lin_one : antiG_lin 1 = - Real.exp (-Real.pi) / Real.pi^2 := by
  unfold antiG_lin antiF_lin
  ring_nf

/-- Integrability of the linear-exponential integrand $(x - 1) e^{-\pi x}$ on $(1, \infty)$. -/
theorem integrableOn_sub_one_mul_exp_neg_pi :
    IntegrableOn (fun x : ℝ => (x - 1) * Real.exp (-Real.pi * x)) (Ioi 1) := by
  apply (integrableOn_Ioi_deriv_of_nonneg' (a := 1) (g := antiG_lin)
    (fun x _ => hasDerivAt_antiG_lin x)
    (fun x hx => mul_nonneg (by linarith [show 1 ≤ x from le_of_lt hx]) (Real.exp_pos _).le)
    tendsto_antiG_lin_atTop)

/-- Closed-form evaluation: $\int_1^\infty (x - 1) e^{-\pi x} \, dx = e^{-\pi}/\pi^2$. -/
theorem integral_sub_one_mul_exp_neg_pi :
    ∫ x in Ioi (1 : ℝ), (x - 1) * Real.exp (-Real.pi * x) =
      Real.exp (-Real.pi) / Real.pi^2 := by
  have h := integral_Ioi_of_hasDerivAt_of_nonneg' (a := 1) (g := antiG_lin)
    (fun x _ => hasDerivAt_antiG_lin x)
    (fun x hx => mul_nonneg (by linarith [show 1 ≤ x from le_of_lt hx]) (Real.exp_pos _).le)
    tendsto_antiG_lin_atTop
  rw [antiG_lin_one] at h
  rw [h]
  ring

/-- Strict numerical majorization: $\int_1^\infty (x - 1) e^{-\pi x} \, dx \le \frac{1}{171}$. -/
theorem integral_sub_one_mul_exp_neg_pi_le_one_div_171 :
    ∫ x in Ioi (1 : ℝ), (x - 1) * Real.exp (-Real.pi * x) ≤ 1 / 171 := by
  rw [integral_sub_one_mul_exp_neg_pi]
  have h_exp : Real.exp (-Real.pi) ≤ 1 / 19 := exp_neg_pi_le_one_nineteenth
  have h_pi : 3 ≤ Real.pi := by linarith [Real.pi_gt_three]
  have h_pi_sq : 9 ≤ Real.pi^2 := by nlinarith
  have h_exp_nonneg : 0 ≤ Real.exp (-Real.pi) := (Real.exp_pos _).le
  have h_div1 : Real.exp (-Real.pi) / Real.pi^2 ≤ (1 / 19) / Real.pi^2 :=
    div_le_div_of_nonneg_right h_exp (by positivity)
  have h_div2 : (1 / 19 : ℝ) / Real.pi^2 ≤ (1 / 19 : ℝ) / 9 :=
    div_le_div_of_nonneg_left (by norm_num) (by norm_num) h_pi_sq
  have h_calc : (1 / 19 : ℝ) / 9 = 1 / 171 := by norm_num
  linarith

/-! ### Section 2: Pointwise Oscillatory Majorization and Frequency Decay -/

/-- Pointwise oscillation bound: $\frac{\sin((\gamma/2)\log x)}{\gamma} \le \frac{1}{\gamma_0}$ for $\gamma \ge \gamma_0 > 0$. -/
theorem sin_div_gamma_le_inv_gamma0 {γ γ0 : ℝ} (hγ0 : 0 < γ0) (hγ : γ0 ≤ γ) (x : ℝ) :
    Real.sin ((γ / 2) * Real.log x) / γ ≤ 1 / γ0 := by
  have hγ_pos : 0 < γ := hγ0.trans_le hγ
  have hsin : Real.sin ((γ / 2) * Real.log x) ≤ 1 := Real.sin_le_one _
  have h1 : Real.sin ((γ / 2) * Real.log x) / γ ≤ 1 / γ :=
    div_le_div_of_nonneg_right hsin (le_of_lt hγ_pos)
  have h2 : 1 / γ ≤ 1 / γ0 := one_div_le_one_div_of_le hγ0 hγ
  exact h1.trans h2

/-- Pointwise product ratio decay bound:
$$\frac{\operatorname{powerDiff}(\beta, x) \sin((\gamma/2)\log x)}{(2\beta - 1)\gamma} \le \frac{1}{2\gamma_0} (x - 1).$$ -/
theorem product_ratio_decay_bound {β γ γ0 x : ℝ} (hx : 1 ≤ x) (hβ1 : 1 / 2 < β) (hβ2 : β ≤ 1)
    (hγ0 : 0 < γ0) (hγ : γ0 ≤ γ) :
    (powerDiff β x * Real.sin ((γ / 2) * Real.log x)) / ((2 * β - 1) * γ) ≤
      (1 / (2 * γ0)) * (x - 1) := by
  have hγ_pos : 0 < γ := hγ0.trans_le hγ
  have h_denom_pos : 0 < (2 * β - 1) * γ := by
    have : 0 < 2 * β - 1 := by linarith
    exact mul_pos this hγ_pos
  have h_target_nonneg : 0 ≤ (1 / (2 * γ0)) * (x - 1) := by
    have h1 : 0 ≤ 1 / (2 * γ0) := by positivity
    have h2 : 0 ≤ x - 1 := by linarith
    exact mul_nonneg h1 h2
  rcases le_or_gt (Real.sin ((γ / 2) * Real.log x)) 0 with h_sin_nonpos | h_sin_pos
  · have h_pd_nonneg : 0 ≤ powerDiff β x := powerDiff_nonneg (by linarith) hx
    have h_num_nonpos : powerDiff β x * Real.sin ((γ / 2) * Real.log x) ≤ 0 :=
      mul_nonpos_of_nonneg_of_nonpos h_pd_nonneg h_sin_nonpos
    have h_ratio_nonpos : (powerDiff β x * Real.sin ((γ / 2) * Real.log x)) / ((2 * β - 1) * γ) ≤ 0 :=
      div_nonpos_of_nonpos_of_nonneg h_num_nonpos (le_of_lt h_denom_pos)
    exact h_ratio_nonpos.trans h_target_nonneg
  · have h_sin_div : Real.sin ((γ / 2) * Real.log x) / γ ≤ 1 / γ0 :=
      sin_div_gamma_le_inv_gamma0 hγ0 hγ x
    have h_alg : (powerDiff β x * Real.sin ((γ / 2) * Real.log x)) / ((2 * β - 1) * γ) =
        (powerDiff β x / (2 * β - 1)) * (Real.sin ((γ / 2) * Real.log x) / γ) :=
      mul_div_mul_comm (powerDiff β x) (Real.sin ((γ / 2) * Real.log x)) (2 * β - 1) γ
    rw [h_alg]
    have h_pd := powerDiff_div_le_half_log hx hβ1 hβ2
    have h_log_le : (1 / 2) * Real.log x ≤ (1 / 2) * (x - 1) := by
      have : Real.log x ≤ x - 1 := log_le_sub_one hx
      linarith
    have h_pd_le : powerDiff β x / (2 * β - 1) ≤ (1 / 2) * (x - 1) :=
      h_pd.trans h_log_le
    have h_pd_nonneg : 0 ≤ powerDiff β x / (2 * β - 1) := by
      have h1 : 0 ≤ powerDiff β x := powerDiff_nonneg (by linarith) hx
      have h2 : 0 < 2 * β - 1 := by linarith
      exact div_nonneg h1 (le_of_lt h2)
    have h_sin_div_nonneg : 0 ≤ Real.sin ((γ / 2) * Real.log x) / γ :=
      div_nonneg (le_of_lt h_sin_pos) (le_of_lt hγ_pos)
    have h_mul := mul_le_mul h_pd_le h_sin_div h_sin_div_nonneg (by linarith)
    have h_target : ((1 / 2) * (x - 1)) * (1 / γ0) = (1 / (2 * γ0)) * (x - 1) := by ring
    rw [h_target] at h_mul
    exact h_mul

/-- Full pointwise Mellin ratio decay majorization:
$$\frac{\operatorname{mellinTrigIntegrandIm}(s, x)}{(2\operatorname{Re}(s) - 1)\operatorname{Im}(s)} \le \frac{2}{\gamma_0} (x - 1) e^{-\pi x}.$$ -/
theorem mellin_ratio_integrand_decay_le {s : ℂ} {γ0 x : ℝ} (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1)
    (hγ0 : 0 < γ0) (hγ : γ0 ≤ s.im) (hx : 1 ≤ x) :
    mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im) ≤
      (2 / γ0) * ((x - 1) * Real.exp (-Real.pi * x)) := by
  have hx_pos : 0 < x := by linarith
  have h_kernel_im : (cpowTrigKernel s x).im = powerDiff s.re x * Real.sin ((s.im / 2) * Real.log x) :=
    cpowTrigKernel_im_eq_powerDiff_mul_sin hx_pos
  have h_bound := product_ratio_decay_bound hx hsr1 hsr2 hγ0 hγ
  have h_f := real_f_modif_le_four_exp hx
  have h_f_nonneg : 0 ≤ real_f_modif x := real_f_modif_nonneg x
  have h_denom_pos : 0 < (2 * s.re - 1) * s.im := by
    have h1 : 0 < 2 * s.re - 1 := by linarith
    have h2 : 0 < s.im := hγ0.trans_le hγ
    exact mul_pos h1 h2
  unfold mellinTrigIntegrandIm
  rw [h_kernel_im]
  have h_assoc : powerDiff s.re x * Real.sin ((s.im / 2) * Real.log x) * real_f_modif x / ((2 * s.re - 1) * s.im) =
      ((powerDiff s.re x * Real.sin ((s.im / 2) * Real.log x)) / ((2 * s.re - 1) * s.im)) * real_f_modif x := by
    ring
  rw [h_assoc]
  rcases le_or_gt ((powerDiff s.re x * Real.sin ((s.im / 2) * Real.log x)) / ((2 * s.re - 1) * s.im)) 0 with h_neg | h_pos
  · have h_left_nonpos : ((powerDiff s.re x * Real.sin ((s.im / 2) * Real.log x)) / ((2 * s.re - 1) * s.im)) * real_f_modif x ≤ 0 :=
      mul_nonpos_of_nonpos_of_nonneg h_neg h_f_nonneg
    have h_right_nonneg : 0 ≤ (2 / γ0) * ((x - 1) * Real.exp (-Real.pi * x)) := by
      have h1 : 0 ≤ 2 / γ0 := by positivity
      have h2 : 0 ≤ x - 1 := by linarith
      have h3 : 0 ≤ Real.exp (-Real.pi * x) := (Real.exp_pos _).le
      exact mul_nonneg h1 (mul_nonneg h2 h3)
    exact h_left_nonpos.trans h_right_nonneg
  · have h_target_nonneg : 0 ≤ (1 / (2 * γ0)) * (x - 1) := by
      have h1 : 0 ≤ 1 / (2 * γ0) := by positivity
      have h2 : 0 ≤ x - 1 := by linarith
      exact mul_nonneg h1 h2
    have h_mul := mul_le_mul h_bound h_f h_f_nonneg h_target_nonneg
    have h_ring : (1 / (2 * γ0)) * (x - 1) * (4 * Real.exp (-Real.pi * x)) =
        (2 / γ0) * ((x - 1) * Real.exp (-Real.pi * x)) := by ring
    rw [h_ring] at h_mul
    exact h_mul

/-- Symmetrized ratio integral decay theorem:
$$\operatorname{symmetrizedRatioIntegral}(s) \le \frac{2}{171 \gamma_0}.$$ -/
theorem symmetrizedRatioIntegral_decay_le {s : ℂ} {γ0 : ℝ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hγ0 : 0 < γ0) (hγ : γ0 ≤ s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    symmetrizedRatioIntegral s ≤ (2 / γ0) * (1 / 171) := by
  unfold symmetrizedRatioIntegral
  have h_int_maj : IntegrableOn (fun x : ℝ => (2 / γ0) * ((x - 1) * Real.exp (-Real.pi * x))) (Ioi 1) :=
    integrableOn_sub_one_mul_exp_neg_pi.const_mul (2 / γ0)
  have h_mono : ∫ x in Ioi (1 : ℝ), mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im) ≤
      ∫ x in Ioi (1 : ℝ), (2 / γ0) * ((x - 1) * Real.exp (-Real.pi * x)) := by
    refine setIntegral_mono_on h_int h_int_maj measurableSet_Ioi fun x hx => ?_
    exact mellin_ratio_integrand_decay_le hsr1 hsr2 hγ0 hγ (le_of_lt (mem_Ioi.mp hx))
  have h_pull : (∫ x in Ioi (1 : ℝ), (2 / γ0) * ((x - 1) * Real.exp (-Real.pi * x))) =
      (2 / γ0) * (∫ x in Ioi (1 : ℝ), (x - 1) * Real.exp (-Real.pi * x)) :=
    integral_const_mul (2 / γ0) (fun x => (x - 1) * Real.exp (-Real.pi * x))
  rw [h_pull] at h_mono
  have h_eval := integral_sub_one_mul_exp_neg_pi_le_one_div_171
  have h_scale : (2 / γ0) * (∫ x in Ioi (1 : ℝ), (x - 1) * Real.exp (-Real.pi * x)) ≤
      (2 / γ0) * (1 / 171) :=
    mul_le_mul_of_nonneg_left h_eval (by positivity)
  exact (h_mono.trans h_scale)

/-- Halved symmetrized ratio integral frequency decay bound:
$$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{171 \gamma_0}.$$ -/
theorem half_symmetrizedRatioIntegral_decay_le {s : ℂ} {γ0 : ℝ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hγ0 : 0 < γ0) (hγ : γ0 ≤ s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / (171 * γ0) := by
  have h := symmetrizedRatioIntegral_decay_le hsr1 hsr2 hγ0 hγ h_int
  have h_half : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ (1 / 2 : ℝ) * ((2 / γ0) * (1 / 171)) :=
    mul_le_mul_of_nonneg_left h (by norm_num)
  have h_alg : (1 / 2 : ℝ) * ((2 / γ0) * (1 / 171)) = 1 / (171 * γ0) := by
    field_simp
  rwa [h_alg] at h_half

/-! ### Section 3: Step 1 Bootstrap ($4.6 \to 5.1$) -/

/-- Coordinate product bound for $y \le 2601/100$: $(x^2 + y)((x - 1)^2 + y) \le 703$. -/
lemma normSq_coords_le_seven_hundred_three {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 2601 / 100) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 703 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 703 := by
    have h1 : y^2 ≤ (2601 / 100 : ℝ)^2 := by nlinarith
    have h2 : (2601 / 100 : ℝ)^2 = 6765201 / 10000 := by norm_num
    have h3 : (2601 / 100 : ℝ) = 260100 / 10000 := by norm_num
    linarith
  linarith

/-- Bound on normSq $(s * (s - 1)) \le 703$ for $\operatorname{Im}(s) \le 51/10 = 5.1$. -/
theorem normSq_mul_sub_one_le_seven_hundred_three {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 51 / 10) :
    normSq (s * (s - 1)) ≤ 703 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 2601 / 100 := by
    have : s.im^2 ≤ (51 / 10 : ℝ)^2 := by nlinarith
    have : (51 / 10 : ℝ)^2 = 2601 / 100 := by norm_num
    linarith
  exact normSq_coords_le_seven_hundred_three hsr1 hsr2 hy1 hy2

/-- Lower bound on the inverse norm-squared for $\operatorname{Im}(s) \le 51/10$:
$$\frac{1}{703} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_div_seven_hundred_three_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 51 / 10) :
    (1 : ℝ) / 703 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_seven_hundred_three hsr1 hsr2 hsim1 hsim2
  have h_pos : 0 < normSq (s * (s - 1)) := by
    have hne : s * (s - 1) ≠ 0 := by
      intro h0
      cases mul_eq_zero.mp h0 with
      | inl hs =>
        have : s.im = 0 := congr_arg Complex.im hs
        linarith
      | inr hs1 =>
        have : (s - 1).im = 0 := congr_arg Complex.im hs1
        simp only [sub_im, one_im, sub_zero] at this
        linarith
    exact normSq_pos.mpr hne
  have h703 : 0 < (703 : ℝ) := by norm_num
  exact one_div_le_one_div_of_le h_pos h_le

/-- Unconditional Intermediate Ratio Deficit on $(23/5, 51/10]$:
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{171 \times (23/5)} \le \frac{1}{786} < \frac{1}{703} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_twenty_three_fifths_to_fifty_one_tenths :
    IntermediateRatioDeficit (23 / 5) (51 / 10) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (171 * (23 / 5 : ℝ)) ≤ (1 : ℝ) / 786 := by
    have h1 : (786 : ℝ) ≤ 171 * (23 / 5) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 786 :=
    h_decay.trans h_dec_le
  have h_inv := one_div_seven_hundred_three_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 786 < 1 / 703 := by norm_num
  linarith

/-- Unconditional zero-freeness on the strip segment $(1/2, 1] \times (23/5, 51/10]$. -/
theorem intermediate_strip_zero_free_twenty_three_fifths_to_fifty_one_tenths {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 23 / 5 < s.im) (hsim2 : s.im ≤ 51 / 10) :
    riemannZeta s ≠ 0 :=
  intermediate_strip_zero_free_of_deficit (by norm_num)
    intermediate_deficit_twenty_three_fifths_to_fifty_one_tenths
    s hsr1 hsr2 hsim1 hsim2

/-- Unconditional zero-freeness on the half-plane $\operatorname{Re}(s) > 1/2$ for frequencies $23/5 < \operatorname{Im}(s) \le 51/10$. -/
theorem intermediate_half_plane_zero_free_twenty_three_fifths_to_fifty_one_tenths {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 23 / 5 < s.im) (hsim2 : s.im ≤ 51 / 10) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_twenty_three_fifths_to_fifty_one_tenths
    s hsr hsim1 hsim2

/-- Unconditional cumulative zero-freeness on the half-plane $\operatorname{Re}(s) > 1/2$
for all frequencies $0 < \operatorname{Im}(s) \le 51/10 = 5.1$, unifying the entire region $[0, 5.1]$. -/
theorem cumulative_zero_free_to_fifty_one_tenths {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim_pos : 0 < s.im) (hsim_le : s.im ≤ 51 / 10) :
    riemannZeta s ≠ 0 := by
  by_cases h1 : s.im ≤ 23 / 5
  · exact cumulative_zero_free_to_twenty_three_fifths hsr hsim_pos h1
  · have h1_lt : 23 / 5 < s.im := not_le.mp h1
    exact intermediate_half_plane_zero_free_twenty_three_fifths_to_fifty_one_tenths hsr h1_lt hsim_le

/-! ### Section 4: Step 2 Bootstrap ($5.1 \to 5.35$) -/

/-- Coordinate product bound for $y \le 11449/400$: $(x^2 + y)((x - 1)^2 + y) \le 848$. -/
lemma normSq_coords_le_eight_hundred_forty_eight {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 11449 / 400) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 848 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 848 := by
    have h1 : y^2 ≤ (11449 / 400 : ℝ)^2 := by nlinarith
    have h2 : (11449 / 400 : ℝ)^2 = 131079601 / 160000 := by norm_num
    have h3 : (11449 / 400 : ℝ) = 4579600 / 160000 := by norm_num
    linarith
  linarith

/-- Bound on normSq $(s * (s - 1)) \le 848$ for $\operatorname{Im}(s) \le 107/20 = 5.35$. -/
theorem normSq_mul_sub_one_le_eight_hundred_forty_eight {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 107 / 20) :
    normSq (s * (s - 1)) ≤ 848 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 11449 / 400 := by
    have : s.im^2 ≤ (107 / 20 : ℝ)^2 := by nlinarith
    have : (107 / 20 : ℝ)^2 = 11449 / 400 := by norm_num
    linarith
  exact normSq_coords_le_eight_hundred_forty_eight hsr1 hsr2 hy1 hy2

/-- Lower bound on the inverse norm-squared for $\operatorname{Im}(s) \le 107/20$:
$$\frac{1}{848} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_div_eight_hundred_forty_eight_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 107 / 20) :
    (1 : ℝ) / 848 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_eight_hundred_forty_eight hsr1 hsr2 hsim1 hsim2
  have h_pos : 0 < normSq (s * (s - 1)) := by
    have hne : s * (s - 1) ≠ 0 := by
      intro h0
      cases mul_eq_zero.mp h0 with
      | inl hs =>
        have : s.im = 0 := congr_arg Complex.im hs
        linarith
      | inr hs1 =>
        have : (s - 1).im = 0 := congr_arg Complex.im hs1
        simp only [sub_im, one_im, sub_zero] at this
        linarith
    exact normSq_pos.mpr hne
  have h848 : 0 < (848 : ℝ) := by norm_num
  exact one_div_le_one_div_of_le h_pos h_le

/-- Unconditional Intermediate Ratio Deficit on $(51/10, 107/20]$:
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{171 \times (51/10)} \le \frac{1}{872} < \frac{1}{848} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_fifty_one_tenths_to_one_hundred_seven_twentieths :
    IntermediateRatioDeficit (51 / 10) (107 / 20) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (171 * (51 / 10 : ℝ)) ≤ (1 : ℝ) / 872 := by
    have h1 : (872 : ℝ) ≤ 171 * (51 / 10) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 872 :=
    h_decay.trans h_dec_le
  have h_inv := one_div_eight_hundred_forty_eight_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 872 < 1 / 848 := by norm_num
  linarith

/-- Unconditional cumulative zero-freeness on the half-plane $\operatorname{Re}(s) > 1/2$
for all frequencies $0 < \operatorname{Im}(s) \le 107/20 = 5.35$, unifying the entire region $[0, 5.35]$. -/
theorem cumulative_zero_free_to_one_hundred_seven_twentieths {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim_pos : 0 < s.im) (hsim_le : s.im ≤ 107 / 20) :
    riemannZeta s ≠ 0 := by
  by_cases h1 : s.im ≤ 51 / 10
  · exact cumulative_zero_free_to_fifty_one_tenths hsr hsim_pos h1
  · have h1_lt : 51 / 10 < s.im := not_le.mp h1
    exact intermediate_half_plane_zero_free_of_deficit (by norm_num)
      intermediate_deficit_fifty_one_tenths_to_one_hundred_seven_twentieths
      s hsr h1_lt hsim_le

/-! ### Section 5: Step 3 Bootstrap ($5.35 \to 5.45$) -/

/-- Coordinate product bound for $y \le 11881/400$: $(x^2 + y)((x - 1)^2 + y) \le 912$. -/
lemma normSq_coords_le_nine_hundred_twelve {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 11881 / 400) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 912 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 912 := by
    have h1 : y^2 ≤ (11881 / 400 : ℝ)^2 := by nlinarith
    have h2 : (11881 / 400 : ℝ)^2 = 141158161 / 160000 := by norm_num
    have h3 : (11881 / 400 : ℝ) = 4752400 / 160000 := by norm_num
    linarith
  linarith

/-- Bound on normSq $(s * (s - 1)) \le 912$ for $\operatorname{Im}(s) \le 109/20 = 5.45$. -/
theorem normSq_mul_sub_one_le_nine_hundred_twelve {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 109 / 20) :
    normSq (s * (s - 1)) ≤ 912 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 11881 / 400 := by
    have : s.im^2 ≤ (109 / 20 : ℝ)^2 := by nlinarith
    have : (109 / 20 : ℝ)^2 = 11881 / 400 := by norm_num
    linarith
  exact normSq_coords_le_nine_hundred_twelve hsr1 hsr2 hy1 hy2

/-- Lower bound on the inverse norm-squared for $\operatorname{Im}(s) \le 109/20$:
$$\frac{1}{912} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_div_nine_hundred_twelve_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 109 / 20) :
    (1 : ℝ) / 912 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_nine_hundred_twelve hsr1 hsr2 hsim1 hsim2
  have h_pos : 0 < normSq (s * (s - 1)) := by
    have hne : s * (s - 1) ≠ 0 := by
      intro h0
      cases mul_eq_zero.mp h0 with
      | inl hs =>
        have : s.im = 0 := congr_arg Complex.im hs
        linarith
      | inr hs1 =>
        have : (s - 1).im = 0 := congr_arg Complex.im hs1
        simp only [sub_im, one_im, sub_zero] at this
        linarith
    exact normSq_pos.mpr hne
  have h912 : 0 < (912 : ℝ) := by norm_num
  exact one_div_le_one_div_of_le h_pos h_le

/-- Unconditional Intermediate Ratio Deficit on $(107/20, 109/20]$:
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{171 \times (107/20)} \le \frac{1}{914} < \frac{1}{912} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_one_hundred_seven_twentieths_to_one_hundred_nine_twentieths :
    IntermediateRatioDeficit (107 / 20) (109 / 20) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (171 * (107 / 20 : ℝ)) ≤ (1 : ℝ) / 914 := by
    have h1 : (914 : ℝ) ≤ 171 * (107 / 20) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 914 :=
    h_decay.trans h_dec_le
  have h_inv := one_div_nine_hundred_twelve_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 914 < 1 / 912 := by norm_num
  linarith

/-- Unconditional cumulative zero-freeness on the half-plane $\operatorname{Re}(s) > 1/2$
for all frequencies $0 < \operatorname{Im}(s) \le 109/20 = 5.45$, unifying the entire region $[0, 5.45]$. -/
theorem cumulative_zero_free_to_one_hundred_nine_twentieths {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim_pos : 0 < s.im) (hsim_le : s.im ≤ 109 / 20) :
    riemannZeta s ≠ 0 := by
  by_cases h1 : s.im ≤ 107 / 20
  · exact cumulative_zero_free_to_one_hundred_seven_twentieths hsr hsim_pos h1
  · have h1_lt : 107 / 20 < s.im := not_le.mp h1
    exact intermediate_half_plane_zero_free_of_deficit (by norm_num)
      intermediate_deficit_one_hundred_seven_twentieths_to_one_hundred_nine_twentieths
      s hsr h1_lt hsim_le

/-! ### Section 6: Step 4 Bootstrap ($5.45 \to 5.47$) -/

/-- Coordinate product bound for $y \le 299209/10000$: $(x^2 + y)((x - 1)^2 + y) \le 926$. -/
lemma normSq_coords_le_nine_hundred_twenty_six {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 299209 / 10000) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 926 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 926 := by
    have h1 : y^2 ≤ (299209 / 10000 : ℝ)^2 := by nlinarith
    have h2 : (299209 / 10000 : ℝ)^2 = 89526025681 / 100000000 := by norm_num
    have h3 : (299209 / 10000 : ℝ) = 2992090000 / 100000000 := by norm_num
    linarith
  linarith

/-- Bound on normSq $(s * (s - 1)) \le 926$ for $\operatorname{Im}(s) \le 547/100 = 5.47$. -/
theorem normSq_mul_sub_one_le_nine_hundred_twenty_six {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 547 / 100) :
    normSq (s * (s - 1)) ≤ 926 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 299209 / 10000 := by
    have : s.im^2 ≤ (547 / 100 : ℝ)^2 := by nlinarith
    have : (547 / 100 : ℝ)^2 = 299209 / 10000 := by norm_num
    linarith
  exact normSq_coords_le_nine_hundred_twenty_six hsr1 hsr2 hy1 hy2

/-- Lower bound on the inverse norm-squared for $\operatorname{Im}(s) \le 547/100$:
$$\frac{1}{926} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_div_nine_hundred_twenty_six_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 547 / 100) :
    (1 : ℝ) / 926 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_nine_hundred_twenty_six hsr1 hsr2 hsim1 hsim2
  have h_pos : 0 < normSq (s * (s - 1)) := by
    have hne : s * (s - 1) ≠ 0 := by
      intro h0
      cases mul_eq_zero.mp h0 with
      | inl hs =>
        have : s.im = 0 := congr_arg Complex.im hs
        linarith
      | inr hs1 =>
        have : (s - 1).im = 0 := congr_arg Complex.im hs1
        simp only [sub_im, one_im, sub_zero] at this
        linarith
    exact normSq_pos.mpr hne
  have h926 : 0 < (926 : ℝ) := by norm_num
  exact one_div_le_one_div_of_le h_pos h_le

/-- Unconditional Intermediate Ratio Deficit on $(109/20, 547/100]$:
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{171 \times (109/20)} \le \frac{1}{931} < \frac{1}{926} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_one_hundred_nine_twentieths_to_five_hundred_forty_seven_hundredths :
    IntermediateRatioDeficit (109 / 20) (547 / 100) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (171 * (109 / 20 : ℝ)) ≤ (1 : ℝ) / 931 := by
    have h1 : (931 : ℝ) ≤ 171 * (109 / 20) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 931 :=
    h_decay.trans h_dec_le
  have h_inv := one_div_nine_hundred_twenty_six_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 931 < 1 / 926 := by norm_num
  linarith

/-- Unconditional cumulative zero-freeness on the half-plane $\operatorname{Re}(s) > 1/2$
for all frequencies $0 < \operatorname{Im}(s) \le 547/100 = 5.47$, unifying the entire region $[0, 5.47]$. -/
theorem cumulative_zero_free_to_five_hundred_forty_seven_hundredths {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim_pos : 0 < s.im) (hsim_le : s.im ≤ 547 / 100) :
    riemannZeta s ≠ 0 := by
  by_cases h1 : s.im ≤ 109 / 20
  · exact cumulative_zero_free_to_one_hundred_nine_twentieths hsr hsim_pos h1
  · have h1_lt : 109 / 20 < s.im := not_le.mp h1
    exact intermediate_half_plane_zero_free_of_deficit (by norm_num)
      intermediate_deficit_one_hundred_nine_twentieths_to_five_hundred_forty_seven_hundredths
      s hsr h1_lt hsim_le

#print axioms cumulative_zero_free_to_five_hundred_forty_seven_hundredths

end

end BuildingBlocks.RiemannZetaFrequencyDecayDeficit
