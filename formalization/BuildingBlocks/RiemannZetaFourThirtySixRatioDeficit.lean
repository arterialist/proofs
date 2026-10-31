/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist
-/
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.NumberTheory.LSeries.Nonvanishing
import BuildingBlocks.RiemannZetaKernelEnergyBound
import BuildingBlocks.RiemannZetaKernelPositivity
import BuildingBlocks.RiemannZetaGlobalSchwarzReflection
import BuildingBlocks.RiemannZetaFrontierPushedBounds
import BuildingBlocks.RiemannZetaAsymptoticPushedBounds
import BuildingBlocks.RiemannZetaExtendedPushedBounds
import BuildingBlocks.RiemannZetaExtendedRatioDeficit
import BuildingBlocks.RiemannZetaOptimalRatioDeficit
import BuildingBlocks.RiemannZetaIntermediateZeroFree
import BuildingBlocks.RiemannZetaThresholdFredholmBridge
import BuildingBlocks.RiemannZetaUnconditionalLowFrequency
import BuildingBlocks.RiemannZetaMellinIntegralDomination
import BuildingBlocks.RiemannZetaRealPartDisparity
import BuildingBlocks.RiemannZetaGrandIntermediateIntegration
import BuildingBlocks.RiemannZetaRatioSurplus
import BuildingBlocks.RiemannZetaLowIntermediateDeficit
import BuildingBlocks.RiemannZetaFrequencyDecayDeficit
import BuildingBlocks.RiemannZetaSharpenedKernelDeficit
import BuildingBlocks.RiemannZetaSharpenedFourThirtyTwoRatioDeficit

/-!
# Module 336: 436-Ratio Deficit and Cumulative Zero-Freeness to 7.538

This module breaks through the $432$-barrier ($t^* \approx 7.515433$) of the ratio deficit
method by establishing a sharpened lower bound on the exponential of $\pi$:
$$\exp(\pi) \ge 23 \implies \exp(-\pi) \le \frac{1}{23}.$$
This sharpens the geometric modifying kernel bound on $[1, \infty)$ from $\frac{19}{9} e^{-\pi x}$
to $\frac{23}{11} e^{-\pi x}$, yielding an enhanced decay prefactor of $\frac{23}{22 \gamma_0}$
for the Mellin ratio integrand.

Combined with the linear-exponential integral bound $\int_1^\infty (x - 1) e^{-\pi x} \, dx \le \frac{1}{228}$,
and the integer inequality $23 \times 218 = 5014 \le 5016 = 22 \times 228$:
$$\frac{23}{22 \gamma_0} \times \frac{1}{228} \le \frac{1}{218 \gamma_0} \implies
\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{436 \gamma_0}.$$
This advances the theoretical zero-free root $t^3 + t < 436$ all the way to $t^* \approx 7.538828$.

## Mathematical Architecture

1. **Sharpened Exponential Bounds**:
   - `exp_pi_ge_23`: $\exp(\pi) \ge 23$ deduced from $\exp(3) \ge 20.08553$ and 8 dyadic steps for $\pi - 3 \ge 0.1415$.
   - `exp_neg_pi_le_one_twenty_third`: $\exp(-\pi) \le 1/23$.
   - `one_sub_exp_ge_twenty_two_twenty_thirds_of_one_le`: $1 - \exp(-\pi t) \ge 22/23$ for $t \ge 1$.
   - `real_f_modif_le_twenty_three_elevenths_exp`: $f(x) \le \frac{23}{11} e^{-\pi x}$ for $x \ge 1$.

2. **Enhanced 436-Decay Majorization**:
   - `mellin_ratio_integrand_decay_le_twenty_three_twenty_seconds`: Integrand decay $\le \frac{23}{22 \gamma_0} (x - 1) e^{-\pi x}$.
   - `twenty_three_div_22_mul_inv_228_le`: Prefactor majorization $\frac{23}{22 \gamma_0} \times \frac{1}{228} \le \frac{1}{218 \gamma_0}$.
   - `symmetrizedRatioIntegral_decay_le_one_div_218_gamma0`: $\operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{218 \gamma_0}$.
   - `half_symmetrizedRatioIntegral_decay_le_one_div_436_gamma0`: $\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{436 \gamma_0}$.

3. **Four-Stage Coordinate Bootstrap Across $(7.515, 7.538]$**:
   - **Step 14 ($7.515 \to 7.525$)**:
     $\gamma_0 = 1503/200$, $\gamma_1 = 301/40$.
     $C_{14} = 8353502801 / 2560000 = 3263.08703125 < 436 \gamma_0 = 3276.54$.
   - **Step 15 ($7.525 \to 7.532$)**:
     $\gamma_0 = 301/40$, $\gamma_1 = 1883/250$.
     $C_{15} = 12793516047221 / 3906250000 \approx 3275.14 < 436 \gamma_0 = 3280.9$.
   - **Step 16 ($7.532 \to 7.536$)**:
     $\gamma_0 = 1883/250$, $\gamma_1 = 942/125$.
     $C_{16} = 801279930996 / 244140625 \approx 3282.04 < 436 \gamma_0 = 3283.952$.
   - **Step 17 ($7.536 \to 7.538$)**:
     $\gamma_0 = 942/125$, $\gamma_1 = 3769/500$.
     $C_{17} = 205343621390321 / 62500000000 \approx 3285.50 < 436 \gamma_0 = 3285.696$.

4. **Cumulative Zero-Freeness to 7.538 ($3769/500$)**:
   $$\forall s \in \mathbb{C},\; \operatorname{Re}(s) > 1/2 \land 0 < \operatorname{Im}(s) \le 3769/500 \implies \zeta(s) \ne 0.$$

5. **Bilateral Zero-Freeness and High-Frequency Reduction**:
   $$\text{RiemannHypothesis} \iff \text{HighFrequencyZeroFree}(3769/500).$$

## Axiom Status
This module depends strictly and exclusively on standard Lean 4 foundational axioms:
`[propext, Classical.choice, Quot.sound]`, with 0 `sorry`, 0 `sorryAx`, and 0 custom axioms.
-/

open Real Complex MeasureTheory Set Filter Topology
open HurwitzZeta
open BuildingBlocks.RiemannZetaKernelPositivity
open BuildingBlocks.RiemannZetaKernelEnergyBound
open BuildingBlocks.RiemannZetaGlobalSchwarzReflection
open BuildingBlocks.RiemannZetaMellinIntegralEvaluation
open BuildingBlocks.RiemannZetaIntermediateDeficitExtension
open BuildingBlocks.RiemannZetaTrigonometricDecomposition
open BuildingBlocks.RiemannZetaModularMellinInversion
open BuildingBlocks.RiemannZetaUpperHalfPlaneReduction
open BuildingBlocks.RiemannZetaOffLineZeroLocalization
open BuildingBlocks.RiemannZetaOptimalRatioDeficit
open BuildingBlocks.RiemannZetaRealPartDisparity
open BuildingBlocks.RiemannZetaLowIntermediateDeficit
open BuildingBlocks.RiemannZetaIntermediateZeroFree
open BuildingBlocks.RiemannZetaUnconditionalLowFrequency
open BuildingBlocks.RiemannZetaMellinIntegralDomination
open BuildingBlocks.RiemannZetaRatioSurplus
open BuildingBlocks.RiemannZetaExtendedRatioDeficit
open BuildingBlocks.RiemannZetaExtendedPushedBounds
open BuildingBlocks.RiemannZetaFrontierPushedBounds
open BuildingBlocks.RiemannZetaAsymptoticPushedBounds
open BuildingBlocks.RiemannZetaGrandIntermediateIntegration
open BuildingBlocks.RiemannZetaThresholdFredholmBridge
open BuildingBlocks.RiemannZetaFrequencyDecayDeficit
open BuildingBlocks.RiemannZetaSharpenedKernelDeficit
open BuildingBlocks.RiemannZetaSharpenedFourThirtyTwoRatioDeficit

namespace BuildingBlocks.RiemannZetaFourThirtySixRatioDeficit

noncomputable section

/-! ### Section 1: Sharpened Exponential Bounds and 436-Decay -/

/-- Sharp lower bound $\exp(\pi) \ge 23$. -/
theorem exp_pi_ge_23 : (23 : ℝ) ≤ Real.exp Real.pi := by
  have h_pi : (31415 / 10000 : ℝ) ≤ Real.pi := by
    have := pi_gt_d4
    linarith
  have h_exp1 : (2718281828 / 1000000000 : ℝ) ≤ Real.exp 1 := by
    have := exp_one_gt_d9
    linarith
  have h_exp3 : (2008553 / 100000 : ℝ) ≤ Real.exp 3 := by
    have h_pow : (2718281828 / 1000000000 : ℝ)^3 ≤ (Real.exp 1)^3 :=
      pow_le_pow_left₀ (by norm_num) h_exp1 3
    rw [← Real.exp_nat_mul] at h_pow
    have h3 : ((3 : ℕ) : ℝ) * 1 = 3 := by norm_num
    rw [h3] at h_pow
    have h_num : (2008553 / 100000 : ℝ) ≤ (2718281828 / 1000000000 : ℝ)^3 := by norm_num
    linarith
  have h_del : (1415 / 80000 : ℝ) + 1 ≤ Real.exp (1415 / 80000) :=
    add_one_le_exp (1415 / 80000 : ℝ)
  have h_del8 : ((1415 / 80000 : ℝ) + 1)^8 ≤ (Real.exp (1415 / 80000))^8 :=
    pow_le_pow_left₀ (by norm_num) h_del 8
  rw [← Real.exp_nat_mul] at h_del8
  have h8 : ((8 : ℕ) : ℝ) * (1415 / 80000 : ℝ) = 1415 / 10000 := by norm_num
  have h_exp_rem : ((1415 / 80000 : ℝ) + 1)^8 ≤ Real.exp (1415 / 10000) := by rwa [h8] at h_del8
  have h_exp_sum : (2008553 / 100000 : ℝ) * ((1415 / 80000 : ℝ) + 1)^8 ≤
      Real.exp 3 * Real.exp (1415 / 10000) :=
    mul_le_mul h_exp3 h_exp_rem (by positivity) (by positivity)
  rw [← Real.exp_add] at h_exp_sum
  have h_pi_sum : (3 : ℝ) + 1415 / 10000 ≤ Real.pi := by linarith
  have h_exp_pi : Real.exp (3 + 1415 / 10000) ≤ Real.exp Real.pi :=
    Real.exp_le_exp.mpr h_pi_sum
  have h_exp_comb : (2008553 / 100000 : ℝ) * ((1415 / 80000 : ℝ) + 1)^8 ≤ Real.exp Real.pi :=
    h_exp_sum.trans h_exp_pi
  have h_arith : (23 : ℝ) ≤ (2008553 / 100000 : ℝ) * ((1415 / 80000 : ℝ) + 1)^8 := by
    norm_num
  linarith

/-- Sharp upper bound $\exp(-\pi) \le 1/23$. -/
theorem exp_neg_pi_le_one_twenty_third : Real.exp (-Real.pi) ≤ 1 / 23 := by
  have h_pos : 0 < Real.exp Real.pi := Real.exp_pos _
  have h_inv : (Real.exp Real.pi)⁻¹ ≤ (23 : ℝ)⁻¹ :=
    (inv_le_inv₀ h_pos (by norm_num)).mpr exp_pi_ge_23
  rw [← Real.exp_neg, ← one_div] at h_inv
  exact h_inv

/-- Sharp geometric denominator lower bound: $1 - e^{-\pi t} \ge 22/23$ for $t \ge 1$. -/
theorem one_sub_exp_ge_twenty_two_twenty_thirds_of_one_le {t : ℝ} (ht : 1 ≤ t) :
    (22 : ℝ) / 23 ≤ 1 - Real.exp (-Real.pi * t) := by
  have h1 := exp_neg_pi_mul_le_of_one_le ht
  have h2 := exp_neg_pi_le_one_twenty_third
  linarith

/-- Sharpened even kernel bound on $[1, \infty)$:
$$\operatorname{evenKernel}(0, t) - 1 \le \frac{23}{11} e^{-\pi t}.$$ -/
theorem evenKernel_sub_one_le_twenty_three_elevenths_exp {t : ℝ} (ht : 1 ≤ t) :
    evenKernel 0 t - 1 ≤ (23 / 11 : ℝ) * Real.exp (-Real.pi * t) := by
  have ht_pos : 0 < t := zero_lt_one.trans_le ht
  have h_geom := evenKernel_sub_one_le_geom ht_pos
  have h_denom : (22 : ℝ) / 23 ≤ 1 - Real.exp (-Real.pi * t) :=
    one_sub_exp_ge_twenty_two_twenty_thirds_of_one_le ht
  have h_denom_pos : 0 < 1 - Real.exp (-Real.pi * t) := by
    have : 0 < (22 : ℝ) / 23 := by norm_num
    linarith
  have h_div : 2 * Real.exp (-Real.pi * t) / (1 - Real.exp (-Real.pi * t)) ≤
      2 * Real.exp (-Real.pi * t) / (22 / 23) := by
    apply div_le_div_of_nonneg_left
    · exact mul_nonneg two_pos.le (Real.exp_pos _).le
    · norm_num
    · exact h_denom
  have h_alg : 2 * Real.exp (-Real.pi * t) / (22 / 23) = (23 / 11 : ℝ) * Real.exp (-Real.pi * t) := by
    ring
  rw [h_alg] at h_div
  exact h_geom.trans h_div

/-- Sharpened modifying kernel bound on $[1, \infty)$:
$$f(x) \le \frac{23}{11} e^{-\pi x}.$$ -/
theorem real_f_modif_le_twenty_three_elevenths_exp {x : ℝ} (hx : 1 ≤ x) :
    real_f_modif x ≤ (23 / 11 : ℝ) * Real.exp (-Real.pi * x) := by
  rcases eq_or_lt_of_le hx with rfl | h_gt
  · rw [real_f_modif_one]
    exact mul_nonneg (by norm_num) (Real.exp_pos _).le
  · unfold real_f_modif
    have h1 : x ∈ Set.Ioi (1 : ℝ) := h_gt
    have h2 : x ∉ Set.Ioo (0 : ℝ) 1 := fun h => not_le_of_gt h_gt (Set.mem_Ioo.mp h).2.le
    rw [Set.indicator_of_mem h1, Set.indicator_of_notMem h2, add_zero]
    exact evenKernel_sub_one_le_twenty_three_elevenths_exp hx

/-- Refined pointwise Mellin ratio decay majorization:
$$\frac{\operatorname{mellinTrigIntegrandIm}(s, x)}{(2\operatorname{Re}(s) - 1)\operatorname{Im}(s)} \le \frac{23}{22 \gamma_0} (x - 1) e^{-\pi x}.$$ -/
theorem mellin_ratio_integrand_decay_le_twenty_three_twenty_seconds {s : ℂ} {γ0 x : ℝ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1)
    (hγ0 : 0 < γ0) (hγ : γ0 ≤ s.im) (hx : 1 ≤ x) :
    mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im) ≤
      (23 / (22 * γ0)) * ((x - 1) * Real.exp (-Real.pi * x)) := by
  have hx_pos : 0 < x := by linarith
  have h_kernel_im : (cpowTrigKernel s x).im = powerDiff s.re x * Real.sin ((s.im / 2) * Real.log x) :=
    cpowTrigKernel_im_eq_powerDiff_mul_sin hx_pos
  have h_bound := product_ratio_decay_bound hx hsr1 hsr2 hγ0 hγ
  have h_f := real_f_modif_le_twenty_three_elevenths_exp hx
  unfold mellinTrigIntegrandIm
  rw [h_kernel_im]
  have h_split : (powerDiff s.re x * Real.sin ((s.im / 2) * Real.log x) * real_f_modif x) /
      ((2 * s.re - 1) * s.im) =
      ((powerDiff s.re x * Real.sin ((s.im / 2) * Real.log x)) / ((2 * s.re - 1) * s.im)) *
      real_f_modif x := by ring
  rw [h_split]
  have h_f_nonneg : 0 ≤ real_f_modif x := real_f_modif_nonneg x
  have h_target_nonneg : 0 ≤ (1 / (2 * γ0)) * (x - 1) := by
    have h1 : 0 ≤ 1 / (2 * γ0) := by positivity
    have h2 : 0 ≤ x - 1 := by linarith
    exact mul_nonneg h1 h2
  have h_prod := mul_le_mul h_bound h_f h_f_nonneg h_target_nonneg
  have h_alg : ((1 / (2 * γ0)) * (x - 1)) * ((23 / 11 : ℝ) * Real.exp (-Real.pi * x)) =
      (23 / (22 * γ0)) * ((x - 1) * Real.exp (-Real.pi * x)) := by ring
  rw [h_alg] at h_prod
  exact h_prod

/-- Integer prefactor cancellation with 228:
$$\frac{23}{22 \gamma_0} \times \frac{1}{228} \le \frac{1}{218 \gamma_0}.$$ -/
theorem twenty_three_div_22_mul_inv_228_le {γ0 : ℝ} (hγ0 : 0 < γ0) :
    (23 / (22 * γ0)) * (1 / 228) ≤ 1 / (218 * γ0) := by
  have h_alg : (23 / (22 * γ0)) * (1 / 228) = (23 / 5016) * (1 / γ0) := by ring
  have h_target : 1 / (218 * γ0) = (1 / 218) * (1 / γ0) := by ring
  rw [h_alg, h_target]
  have h_frac : (23 : ℝ) / 5016 ≤ 1 / 218 := by norm_num
  exact mul_le_mul_of_nonneg_right h_frac (by positivity)

/-- Sharpened symmetrized ratio integral 218-decay theorem:
$$\operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{218 \gamma_0}.$$ -/
theorem symmetrizedRatioIntegral_decay_le_one_div_218_gamma0 {s : ℂ} {γ0 : ℝ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hγ0 : 0 < γ0) (hγ : γ0 ≤ s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    symmetrizedRatioIntegral s ≤ 1 / (218 * γ0) := by
  unfold symmetrizedRatioIntegral
  have h_int_maj : IntegrableOn (fun x : ℝ => (23 / (22 * γ0)) * ((x - 1) * Real.exp (-Real.pi * x))) (Ioi 1) :=
    integrableOn_sub_one_mul_exp_neg_pi.const_mul (23 / (22 * γ0))
  have h_mono : ∫ x in Ioi (1 : ℝ), mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im) ≤
      ∫ x in Ioi (1 : ℝ), (23 / (22 * γ0)) * ((x - 1) * Real.exp (-Real.pi * x)) := by
    refine setIntegral_mono_on h_int h_int_maj measurableSet_Ioi fun x hx => ?_
    exact mellin_ratio_integrand_decay_le_twenty_three_twenty_seconds hsr1 hsr2 hγ0 hγ (le_of_lt (mem_Ioi.mp hx))
  have h_pull : (∫ x in Ioi (1 : ℝ), (23 / (22 * γ0)) * ((x - 1) * Real.exp (-Real.pi * x))) =
      (23 / (22 * γ0)) * (∫ x in Ioi (1 : ℝ), (x - 1) * Real.exp (-Real.pi * x)) :=
    integral_const_mul (23 / (22 * γ0)) (fun x => (x - 1) * Real.exp (-Real.pi * x))
  rw [h_pull] at h_mono
  have h_eval := integral_sub_one_mul_exp_neg_pi_le_one_div_228
  have h_scale : (23 / (22 * γ0)) * (∫ x in Ioi (1 : ℝ), (x - 1) * Real.exp (-Real.pi * x)) ≤
      (23 / (22 * γ0)) * (1 / 228) :=
    mul_le_mul_of_nonneg_left h_eval (by positivity)
  have h_comb := h_mono.trans h_scale
  have h_num := twenty_three_div_22_mul_inv_228_le hγ0
  exact h_comb.trans h_num

/-- Sharpened halved ratio deficit 436-decay bound:
$$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{436 \gamma_0}.$$ -/
theorem half_symmetrizedRatioIntegral_decay_le_one_div_436_gamma0 {s : ℂ} {γ0 : ℝ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hγ0 : 0 < γ0) (hγ : γ0 ≤ s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / (436 * γ0) := by
  have h := symmetrizedRatioIntegral_decay_le_one_div_218_gamma0 hsr1 hsr2 hγ0 hγ h_int
  have h_half : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ (1 / 2 : ℝ) * (1 / (218 * γ0)) :=
    mul_le_mul_of_nonneg_left h (by norm_num)
  have h_alg : (1 / 2 : ℝ) * (1 / (218 * γ0)) = 1 / (436 * γ0) := by ring
  rw [h_alg] at h_half
  exact h_half

/-! ### Section 2: Bootstrap Step 14 ($7.515 \to 7.525$) -/

/-- Coordinate polynomial bound for $y \le 90601/1600$ ($t \le 301/40 = 7.525$). -/
theorem normSq_coords_le_eight_billion_div_two_million {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 90601 / 1600) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ (8353502801 : ℝ) / 2560000 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ (8353502801 : ℝ) / 2560000 := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (90601 / 1600 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (90601 / 1600 : ℝ)^2 = 8208541201 / 2560000 := by norm_num
    rw [h2] at h1
    linarith
  linarith

/-- Bound on $\operatorname{normSq}(s(s-1)) \le 8353502801 / 2560000$ for $\operatorname{Im}(s) \le 301/40 = 7.525$. -/
theorem normSq_mul_sub_one_le_step14 {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 301 / 40) :
    normSq (s * (s - 1)) ≤ (8353502801 : ℝ) / 2560000 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 90601 / 1600 := by
    have : s.im^2 ≤ (301 / 40 : ℝ)^2 := by nlinarith
    have : (301 / 40 : ℝ)^2 = 90601 / 1600 := by norm_num
    linarith
  exact normSq_coords_le_eight_billion_div_two_million hsr1 hsr2 hy1 hy2

/-- Lower bound on $1 / |s(s-1)|^2 \ge 2560000 / 8353502801$ for $\operatorname{Im}(s) \le 301/40$. -/
theorem step14_inv_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 301 / 40) :
    (2560000 : ℝ) / 8353502801 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_step14 hsr1 hsr2 hsim1 hsim2
  have h_pos : 0 < normSq (s * (s - 1)) := by
    have hne : s * (s - 1) ≠ 0 := by
      intro h
      cases mul_eq_zero.mp h with
      | inl h0 =>
        have : s.im = 0 := by rw [h0, Complex.zero_im]
        linarith
      | inr h1 =>
        have : s.im = 0 := by
          have h_sub : (s - 1).im = 0 := by rw [h1, Complex.zero_im]
          rw [Complex.sub_im, Complex.one_im, sub_zero] at h_sub
          exact h_sub
        linarith
    exact normSq_pos.mpr hne
  have h_div : 1 / ((8353502801 : ℝ) / 2560000) = (2560000 : ℝ) / 8353502801 := by norm_num
  rw [← h_div]
  exact one_div_le_one_div_of_le h_pos h_le

/-- Unconditional Intermediate Ratio Deficit on $(1503/200, 301/40]$:
$$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) < \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_five_one_five_to_seven_five_two_five :
    IntermediateRatioDeficit (1503 / 200) (301 / 40) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_436_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (436 * (1503 / 200 : ℝ)) < (2560000 : ℝ) / 8353502801 := by
    have h_denom : (8353502801 / 2560000 : ℝ) < 436 * (1503 / 200) := by norm_num
    have h_pos : 0 < (8353502801 / 2560000 : ℝ) := by norm_num
    have h_inv := one_div_lt_one_div_of_lt h_pos h_denom
    have h_alg : 1 / (8353502801 / 2560000 : ℝ) = (2560000 : ℝ) / 8353502801 := by norm_num
    rwa [h_alg] at h_inv
  have h_ratio_lt : (1 / 2 : ℝ) * symmetrizedRatioIntegral s < (2560000 : ℝ) / 8353502801 :=
    h_decay.trans_lt h_dec_le
  have h_inv := step14_inv_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  exact h_ratio_lt.trans_le h_inv

/-- Half-plane zero-free extension across $(1503/200, 301/40]$. -/
theorem intermediate_half_plane_zero_free_seven_five_one_five_to_seven_five_two_five {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 1503 / 200 < s.im) (hsim2 : s.im ≤ 301 / 40) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_five_one_five_to_seven_five_two_five s hsr hsim1 hsim2

/-! ### Section 3: Bootstrap Step 15 ($7.525 \to 7.532$) -/

/-- Coordinate polynomial bound for $y \le 3545689/62500$ ($t \le 1883/250 = 7.532$). -/
theorem normSq_coords_le_step15 {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 3545689 / 62500) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ (12793516047221 : ℝ) / 3906250000 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ (12793516047221 : ℝ) / 3906250000 := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (3545689 / 62500 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (3545689 / 62500 : ℝ)^2 = 12571910484721 / 3906250000 := by norm_num
    rw [h2] at h1
    linarith
  linarith

/-- Bound on $\operatorname{normSq}(s(s-1))$ for $\operatorname{Im}(s) \le 1883/250 = 7.532$. -/
theorem normSq_mul_sub_one_le_step15 {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 1883 / 250) :
    normSq (s * (s - 1)) ≤ (12793516047221 : ℝ) / 3906250000 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 3545689 / 62500 := by
    have : s.im^2 ≤ (1883 / 250 : ℝ)^2 := by nlinarith
    have : (1883 / 250 : ℝ)^2 = 3545689 / 62500 := by norm_num
    linarith
  exact normSq_coords_le_step15 hsr1 hsr2 hy1 hy2

/-- Lower bound on $1 / |s(s-1)|^2$ for $\operatorname{Im}(s) \le 1883/250$. -/
theorem step15_inv_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 1883 / 250) :
    (3906250000 : ℝ) / 12793516047221 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_step15 hsr1 hsr2 hsim1 hsim2
  have h_pos : 0 < normSq (s * (s - 1)) := by
    have hne : s * (s - 1) ≠ 0 := by
      intro h
      cases mul_eq_zero.mp h with
      | inl h0 =>
        have : s.im = 0 := by rw [h0, Complex.zero_im]
        linarith
      | inr h1 =>
        have : s.im = 0 := by
          have h_sub : (s - 1).im = 0 := by rw [h1, Complex.zero_im]
          rw [Complex.sub_im, Complex.one_im, sub_zero] at h_sub
          exact h_sub
        linarith
    exact normSq_pos.mpr hne
  have h_div : 1 / ((12793516047221 : ℝ) / 3906250000) = (3906250000 : ℝ) / 12793516047221 := by norm_num
  rw [← h_div]
  exact one_div_le_one_div_of_le h_pos h_le

/-- Unconditional Intermediate Ratio Deficit on $(301/40, 1883/250]$:
$$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) < \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_five_two_five_to_seven_five_three_two :
    IntermediateRatioDeficit (301 / 40) (1883 / 250) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_436_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (436 * (301 / 40 : ℝ)) < (3906250000 : ℝ) / 12793516047221 := by
    have h_denom : (12793516047221 / 3906250000 : ℝ) < 436 * (301 / 40) := by norm_num
    have h_pos : 0 < (12793516047221 / 3906250000 : ℝ) := by norm_num
    have h_inv := one_div_lt_one_div_of_lt h_pos h_denom
    have h_alg : 1 / (12793516047221 / 3906250000 : ℝ) = (3906250000 : ℝ) / 12793516047221 := by norm_num
    rwa [h_alg] at h_inv
  have h_ratio_lt : (1 / 2 : ℝ) * symmetrizedRatioIntegral s < (3906250000 : ℝ) / 12793516047221 :=
    h_decay.trans_lt h_dec_le
  have h_inv := step15_inv_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  exact h_ratio_lt.trans_le h_inv

/-- Half-plane zero-free extension across $(301/40, 1883/250]$. -/
theorem intermediate_half_plane_zero_free_seven_five_two_five_to_seven_five_three_two {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 301 / 40 < s.im) (hsim2 : s.im ≤ 1883 / 250) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_five_two_five_to_seven_five_three_two s hsr hsim1 hsim2

/-! ### Section 4: Bootstrap Step 16 ($7.532 \to 7.536$) -/

/-- Coordinate polynomial bound for $y \le 887364/15625$ ($t \le 942/125 = 7.536$). -/
theorem normSq_coords_le_step16 {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 887364 / 15625) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ (801279930996 : ℝ) / 244140625 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ (801279930996 : ℝ) / 244140625 := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (887364 / 15625 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (887364 / 15625 : ℝ)^2 = 787414868496 / 244140625 := by norm_num
    rw [h2] at h1
    linarith
  linarith

/-- Bound on $\operatorname{normSq}(s(s-1))$ for $\operatorname{Im}(s) \le 942/125 = 7.536$. -/
theorem normSq_mul_sub_one_le_step16 {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 942 / 125) :
    normSq (s * (s - 1)) ≤ (801279930996 : ℝ) / 244140625 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 887364 / 15625 := by
    have : s.im^2 ≤ (942 / 125 : ℝ)^2 := by nlinarith
    have : (942 / 125 : ℝ)^2 = 887364 / 15625 := by norm_num
    linarith
  exact normSq_coords_le_step16 hsr1 hsr2 hy1 hy2

/-- Lower bound on $1 / |s(s-1)|^2$ for $\operatorname{Im}(s) \le 942/125$. -/
theorem step16_inv_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 942 / 125) :
    (244140625 : ℝ) / 801279930996 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_step16 hsr1 hsr2 hsim1 hsim2
  have h_pos : 0 < normSq (s * (s - 1)) := by
    have hne : s * (s - 1) ≠ 0 := by
      intro h
      cases mul_eq_zero.mp h with
      | inl h0 =>
        have : s.im = 0 := by rw [h0, Complex.zero_im]
        linarith
      | inr h1 =>
        have : s.im = 0 := by
          have h_sub : (s - 1).im = 0 := by rw [h1, Complex.zero_im]
          rw [Complex.sub_im, Complex.one_im, sub_zero] at h_sub
          exact h_sub
        linarith
    exact normSq_pos.mpr hne
  have h_div : 1 / ((801279930996 : ℝ) / 244140625) = (244140625 : ℝ) / 801279930996 := by norm_num
  rw [← h_div]
  exact one_div_le_one_div_of_le h_pos h_le

/-- Unconditional Intermediate Ratio Deficit on $(1883/250, 942/125]$:
$$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) < \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_five_three_two_to_seven_five_three_six :
    IntermediateRatioDeficit (1883 / 250) (942 / 125) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_436_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (436 * (1883 / 250 : ℝ)) < (244140625 : ℝ) / 801279930996 := by
    have h_denom : (801279930996 / 244140625 : ℝ) < 436 * (1883 / 250) := by norm_num
    have h_pos : 0 < (801279930996 / 244140625 : ℝ) := by norm_num
    have h_inv := one_div_lt_one_div_of_lt h_pos h_denom
    have h_alg : 1 / (801279930996 / 244140625 : ℝ) = (244140625 : ℝ) / 801279930996 := by norm_num
    rwa [h_alg] at h_inv
  have h_ratio_lt : (1 / 2 : ℝ) * symmetrizedRatioIntegral s < (244140625 : ℝ) / 801279930996 :=
    h_decay.trans_lt h_dec_le
  have h_inv := step16_inv_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  exact h_ratio_lt.trans_le h_inv

/-- Half-plane zero-free extension across $(1883/250, 942/125]$. -/
theorem intermediate_half_plane_zero_free_seven_five_three_two_to_seven_five_three_six {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 1883 / 250 < s.im) (hsim2 : s.im ≤ 942 / 125) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_five_three_two_to_seven_five_three_six s hsr hsim1 hsim2

/-! ### Section 5: Bootstrap Step 17 ($7.536 \to 7.538$) -/

/-- Coordinate polynomial bound for $y \le 14205361/250000$ ($t \le 3769/500 = 7.538$). -/
theorem normSq_coords_le_step17 {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 14205361 / 250000) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ (205343621390321 : ℝ) / 62500000000 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ (205343621390321 : ℝ) / 62500000000 := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (14205361 / 250000 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (14205361 / 250000 : ℝ)^2 = 201792281140321 / 62500000000 := by norm_num
    rw [h2] at h1
    linarith
  linarith

/-- Bound on $\operatorname{normSq}(s(s-1))$ for $\operatorname{Im}(s) \le 3769/500 = 7.538$. -/
theorem normSq_mul_sub_one_le_step17 {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 3769 / 500) :
    normSq (s * (s - 1)) ≤ (205343621390321 : ℝ) / 62500000000 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 14205361 / 250000 := by
    have : s.im^2 ≤ (3769 / 500 : ℝ)^2 := by nlinarith
    have : (3769 / 500 : ℝ)^2 = 14205361 / 250000 := by norm_num
    linarith
  exact normSq_coords_le_step17 hsr1 hsr2 hy1 hy2

/-- Lower bound on $1 / |s(s-1)|^2$ for $\operatorname{Im}(s) \le 3769/500$. -/
theorem step17_inv_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 3769 / 500) :
    (62500000000 : ℝ) / 205343621390321 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_step17 hsr1 hsr2 hsim1 hsim2
  have h_pos : 0 < normSq (s * (s - 1)) := by
    have hne : s * (s - 1) ≠ 0 := by
      intro h
      cases mul_eq_zero.mp h with
      | inl h0 =>
        have : s.im = 0 := by rw [h0, Complex.zero_im]
        linarith
      | inr h1 =>
        have : s.im = 0 := by
          have h_sub : (s - 1).im = 0 := by rw [h1, Complex.zero_im]
          rw [Complex.sub_im, Complex.one_im, sub_zero] at h_sub
          exact h_sub
        linarith
    exact normSq_pos.mpr hne
  have h_div : 1 / ((205343621390321 : ℝ) / 62500000000) = (62500000000 : ℝ) / 205343621390321 := by norm_num
  rw [← h_div]
  exact one_div_le_one_div_of_le h_pos h_le

/-- Unconditional Intermediate Ratio Deficit on $(942/125, 3769/500]$:
$$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) < \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_five_three_six_to_seven_five_three_eight :
    IntermediateRatioDeficit (942 / 125) (3769 / 500) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_436_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (436 * (942 / 125 : ℝ)) < (62500000000 : ℝ) / 205343621390321 := by
    have h_denom : (205343621390321 / 62500000000 : ℝ) < 436 * (942 / 125) := by norm_num
    have h_pos : 0 < (205343621390321 / 62500000000 : ℝ) := by norm_num
    have h_inv := one_div_lt_one_div_of_lt h_pos h_denom
    have h_alg : 1 / (205343621390321 / 62500000000 : ℝ) = (62500000000 : ℝ) / 205343621390321 := by norm_num
    rwa [h_alg] at h_inv
  have h_ratio_lt : (1 / 2 : ℝ) * symmetrizedRatioIntegral s < (62500000000 : ℝ) / 205343621390321 :=
    h_decay.trans_lt h_dec_le
  have h_inv := step17_inv_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  exact h_ratio_lt.trans_le h_inv

/-- Half-plane zero-free extension across $(942/125, 3769/500]$. -/
theorem intermediate_half_plane_zero_free_seven_five_three_six_to_seven_five_three_eight {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 942 / 125 < s.im) (hsim2 : s.im ≤ 3769 / 500) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_five_three_six_to_seven_five_three_eight s hsr hsim1 hsim2

/-! ### Section 6: Cumulative Zero-Freeness to 7.538 -/

/-- Cumulative non-vanishing of $\zeta(s)$ for $\operatorname{Re}(s) > 1/2$ and $0 < \operatorname{Im}(s) \le 3769/500 = 7.538$. -/
theorem cumulative_zero_free_to_seven_five_three_eight {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 0 < s.im) (hsim2 : s.im ≤ 3769 / 500) :
    riemannZeta s ≠ 0 := by
  by_cases hsr2 : s.re ≤ 1
  · by_cases h1 : s.im ≤ 1503 / 200
    · exact cumulative_zero_free_to_seven_five_one_five hsr hsim1 h1
    have h1_gt : 1503 / 200 < s.im := by linarith
    by_cases h2 : s.im ≤ 301 / 40
    · exact intermediate_half_plane_zero_free_seven_five_one_five_to_seven_five_two_five
        hsr h1_gt h2
    have h2_gt : 301 / 40 < s.im := by linarith
    by_cases h3 : s.im ≤ 1883 / 250
    · exact intermediate_half_plane_zero_free_seven_five_two_five_to_seven_five_three_two
        hsr h2_gt h3
    have h3_gt : 1883 / 250 < s.im := by linarith
    by_cases h4 : s.im ≤ 942 / 125
    · exact intermediate_half_plane_zero_free_seven_five_three_two_to_seven_five_three_six
        hsr h3_gt h4
    have h4_gt : 942 / 125 < s.im := by linarith
    exact intermediate_half_plane_zero_free_seven_five_three_six_to_seven_five_three_eight
      hsr h4_gt hsim2
  · have hsr_gt : 1 < s.re := by linarith
    exact riemannZeta_ne_zero_of_one_lt_re hsr_gt

/-- Cumulative zero-free structure at height $3769/500 = 7.538$. -/
theorem cumulative_zero_free_base_seven_five_three_eight :
    CumulativeZeroFree (3769 / 500) :=
  fun _ hsr hsim1 hsim2 =>
    cumulative_zero_free_to_seven_five_three_eight hsr hsim1 hsim2

/-- Mathlib's canonical `LowFrequencyZeroFree` unconditionally certified up to $H = 3769/500 = 7.538$. -/
theorem lowFrequencyZeroFree_seven_five_three_eight :
    LowFrequencyZeroFree (3769 / 500) :=
  lowFrequencyZeroFree_of_cumulativeZeroFree
    (by norm_num) cumulative_zero_free_base_seven_five_three_eight

/-- Zero-freeness on the bilateral bounded-height critical strip up to height $7.538$. -/
theorem bounded_height_zero_free_seven_five_three_eight :
    ∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → |s.im| ≤ 3769 / 500 → riemannZeta s ≠ 0 := by
  intro s hsr hs1 h_bound hz
  have h_le := lowFrequencyZeroFree_seven_five_three_eight s hz hs1 h_bound
  linarith

/-- Master Biconditional: Riemann Hypothesis is equivalent to High-Frequency Zero-Freeness
above $H = 3769 / 500 = 7.538$. -/
theorem rh_iff_high_frequency_seven_five_three_eight :
    RiemannHypothesis ↔ HighFrequencyZeroFree (3769 / 500) := by
  constructor
  · intro rh
    exact highFrequencyZeroFree_of_RH rh (3769 / 500)
  · intro h_high
    exact RiemannHypothesis_of_cumulative_and_high (3769 / 500) (by norm_num)
      cumulative_zero_free_base_seven_five_three_eight h_high

/-- Unconditional RH deduction from high-frequency refutation above $7.538$. -/
theorem rh_of_high_frequency_seven_five_three_eight :
    HighFrequencyZeroFree (3769 / 500) → RiemannHypothesis :=
  rh_iff_high_frequency_seven_five_three_eight.mpr

/-- High-frequency zero-freeness above $7.538$ from Riemann Hypothesis. -/
theorem high_frequency_of_rh_seven_five_three_eight :
    RiemannHypothesis → HighFrequencyZeroFree (3769 / 500) :=
  rh_iff_high_frequency_seven_five_three_eight.mp

/-! ### Section 7: In-File Declarative Axiom Audits -/

#print axioms exp_pi_ge_23
#print axioms exp_neg_pi_le_one_twenty_third
#print axioms one_sub_exp_ge_twenty_two_twenty_thirds_of_one_le
#print axioms evenKernel_sub_one_le_twenty_three_elevenths_exp
#print axioms real_f_modif_le_twenty_three_elevenths_exp
#print axioms mellin_ratio_integrand_decay_le_twenty_three_twenty_seconds
#print axioms twenty_three_div_22_mul_inv_228_le
#print axioms symmetrizedRatioIntegral_decay_le_one_div_218_gamma0
#print axioms half_symmetrizedRatioIntegral_decay_le_one_div_436_gamma0

#print axioms normSq_coords_le_eight_billion_div_two_million
#print axioms normSq_mul_sub_one_le_step14
#print axioms step14_inv_le_inv_normSq
#print axioms intermediate_deficit_seven_five_one_five_to_seven_five_two_five
#print axioms intermediate_half_plane_zero_free_seven_five_one_five_to_seven_five_two_five

#print axioms normSq_coords_le_step15
#print axioms normSq_mul_sub_one_le_step15
#print axioms step15_inv_le_inv_normSq
#print axioms intermediate_deficit_seven_five_two_five_to_seven_five_three_two
#print axioms intermediate_half_plane_zero_free_seven_five_two_five_to_seven_five_three_two

#print axioms normSq_coords_le_step16
#print axioms normSq_mul_sub_one_le_step16
#print axioms step16_inv_le_inv_normSq
#print axioms intermediate_deficit_seven_five_three_two_to_seven_five_three_six
#print axioms intermediate_half_plane_zero_free_seven_five_three_two_to_seven_five_three_six

#print axioms normSq_coords_le_step17
#print axioms normSq_mul_sub_one_le_step17
#print axioms step17_inv_le_inv_normSq
#print axioms intermediate_deficit_seven_five_three_six_to_seven_five_three_eight
#print axioms intermediate_half_plane_zero_free_seven_five_three_six_to_seven_five_three_eight

#print axioms cumulative_zero_free_to_seven_five_three_eight
#print axioms cumulative_zero_free_base_seven_five_three_eight
#print axioms lowFrequencyZeroFree_seven_five_three_eight
#print axioms bounded_height_zero_free_seven_five_three_eight
#print axioms rh_iff_high_frequency_seven_five_three_eight
#print axioms rh_of_high_frequency_seven_five_three_eight
#print axioms high_frequency_of_rh_seven_five_three_eight

end

end BuildingBlocks.RiemannZetaFourThirtySixRatioDeficit
