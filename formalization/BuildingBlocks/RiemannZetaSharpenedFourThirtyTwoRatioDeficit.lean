/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist
-/
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Analysis.Complex.ExponentialBounds
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

/-!
# Module 335: Sharpened 432-Ratio Deficit and Cumulative Zero-Freeness to 7.515

This module shatters the theoretical $424$-barrier ($t^* \approx 7.468202$) of the ratio deficit
method by establishing a sharpened quadratic-exponential lower bound:
$$\pi^2 \exp(\pi) \ge 228.$$
This sharpens the decay prefactor of the ratio integral from $1 / (424 \gamma_0)$ to $1 / (432 \gamma_0)$,
extending the theoretical root $t^3 + t < 432$ all the way to $t^* \approx 7.515433$.

## Mathematical Architecture

1. **Optimal Linear-Exponential Integral Sharpening**:
   Using `pi_gt_d4` ($3.1415 < \pi$) and `exp_one_gt_d9` ($2.718281828 < e$), partitioned into
   $8$ dyadic segments with `add_one_le_exp`:
   $$\pi^2 \exp(\pi) \ge 228 \implies \int_1^\infty (x - 1) e^{-\pi x} \, dx \le \frac{1}{228}.$$

2. **Sharpened Halved Ratio Deficit Bound**:
   Since $18 \times 228 = 4104 = 19 \times 216$:
   $$\frac{19}{18 \gamma_0} \times \frac{1}{228} = \frac{1}{216 \gamma_0} \implies \frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{432 \gamma_0}.$$

3. **Four-Stage Coordinate Bootstrap Across $(7.4682015, 7.515]$**:
   - **Step 1 ($7.4682015 \to 7.50$)**:
     $\gamma_0 = 14936403/2000000$, $\gamma_1 = 15/2$.
     $C_{10} = 51525 / 16 = 3220.3125 < 432 \gamma_0 = 3226.263048$.
   - **Step 2 ($7.50 \to 7.51$)**:
     $\gamma_0 = 15/2$, $\gamma_1 = 751/100$.
     $C_{11} = 3238 \le 432 \gamma_0 = 3240$.
   - **Step 3 ($7.51 \to 7.514$)**:
     $\gamma_0 = 751/100$, $\gamma_1 = 3757/500$.
     $C_{12} = 162211 / 50 = 3244.22 < 432 \gamma_0 = 3244.32$.
   - **Step 4 ($7.514 \to 7.515$)**:
     $\gamma_0 = 3757/500$, $\gamma_1 = 1503/200$.
     $C_{13} = 3246 < 432 \gamma_0 = 3246.048$.

4. **Cumulative Zero-Freeness to 7.515**:
   Glues cumulative zero-freeness up to $7.4682015$ with the four bootstrap stages:
   $$\forall s \in \mathbb{C},\; \operatorname{Re}(s) > 1/2 \land 0 < \operatorname{Im}(s) \le 1503/200 \implies \zeta(s) \ne 0.$$

5. **Pushed Master High-Frequency Reduction**:
   $$\text{RiemannHypothesis} \iff \text{HighFrequencyZeroFree}(1503/200).$$

## Axiom Status
This module depends strictly and exclusively on standard Lean 4 foundational axioms:
`[propext, Classical.choice, Quot.sound]`, with 0 `sorry`, 0 `sorryAx`, and 0 custom axioms.
-/

open Real Complex MeasureTheory Set Filter Topology
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

namespace BuildingBlocks.RiemannZetaSharpenedFourThirtyTwoRatioDeficit

noncomputable section

/-! ### Section 1: Sharpened Quadratic-Exponential Lower Bound (228) -/

/-- Sharpened quadratic-exponential lower bound: $\pi^2 \exp(\pi) \ge 228$. -/
theorem pi_sq_mul_exp_pi_ge_228 : (228 : ℝ) ≤ Real.pi^2 * Real.exp Real.pi := by
  have h_pi : (31415 / 10000 : ℝ) ≤ Real.pi := by
    have := pi_gt_d4
    linarith
  have h_pi_sq : (31415 / 10000 : ℝ)^2 ≤ Real.pi^2 :=
    pow_le_pow_left₀ (by norm_num) h_pi 2
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
  -- Split 1415 / 10000 into 8 pieces of delta = 1415 / 80000
  have h_del : (1415 / 80000 : ℝ) + 1 ≤ Real.exp (1415 / 80000) :=
    add_one_le_exp (1415 / 80000 : ℝ)
  have h_del8 : ((1415 / 80000 : ℝ) + 1)^8 ≤ (Real.exp (1415 / 80000))^8 :=
    pow_le_pow_left₀ (by norm_num) h_del 8
  rw [← Real.exp_nat_mul] at h_del8
  have h_exp_rem : ((1415 / 80000 : ℝ) + 1)^8 ≤ Real.exp (1415 / 10000) := by
    have h8 : ((8 : ℕ) : ℝ) * (1415 / 80000 : ℝ) = 1415 / 10000 := by norm_num
    rwa [h8] at h_del8
  have h_exp_sum : (2008553 / 100000 : ℝ) * ((1415 / 80000 : ℝ) + 1)^8 ≤
      Real.exp 3 * Real.exp (1415 / 10000) :=
    mul_le_mul h_exp3 h_exp_rem (by positivity) (by positivity)
  rw [← Real.exp_add] at h_exp_sum
  have h_pi_sum : (3 : ℝ) + 1415 / 10000 ≤ Real.pi := by linarith
  have h_exp_pi : Real.exp (3 + 1415 / 10000) ≤ Real.exp Real.pi :=
    Real.exp_le_exp.mpr h_pi_sum
  have h_exp_comb : (2008553 / 100000 : ℝ) * ((1415 / 80000 : ℝ) + 1)^8 ≤ Real.exp Real.pi :=
    h_exp_sum.trans h_exp_pi
  have h_prod : (31415 / 10000 : ℝ)^2 * ((2008553 / 100000 : ℝ) * ((1415 / 80000 : ℝ) + 1)^8) ≤
      Real.pi^2 * Real.exp Real.pi :=
    mul_le_mul h_pi_sq h_exp_comb (by positivity) (by positivity)
  have h_arith : (228 : ℝ) ≤ (31415 / 10000 : ℝ)^2 * ((2008553 / 100000 : ℝ) * ((1415 / 80000 : ℝ) + 1)^8) := by
    norm_num
  linarith

/-- Sharpened linear-exponential integral majorization:
$$\int_1^\infty (x - 1) e^{-\pi x} \, dx \le \frac{1}{228}.$$ -/
theorem integral_sub_one_mul_exp_neg_pi_le_one_div_228 :
    ∫ x in Ioi (1 : ℝ), (x - 1) * Real.exp (-Real.pi * x) ≤ 1 / 228 := by
  rw [integral_sub_one_mul_exp_neg_pi]
  have h_alg : Real.exp (-Real.pi) / Real.pi^2 = 1 / (Real.pi^2 * Real.exp Real.pi) := by
    rw [Real.exp_neg]
    ring
  rw [h_alg]
  exact one_div_le_one_div_of_le (by norm_num) pi_sq_mul_exp_pi_ge_228

/-- Exact prefactor cancellation with 228:
$$\frac{19}{18 \gamma_0} \times \frac{1}{228} \le \frac{1}{216 \gamma_0}.$$ -/
theorem nineteen_div_18_mul_inv_228_le {γ0 : ℝ} (_hγ0 : 0 < γ0) :
    (19 / (18 * γ0)) * (1 / 228) ≤ 1 / (216 * γ0) := by
  have h_alg : (19 / (18 * γ0)) * (1 / 228) = (19 / 4104) * (1 / γ0) := by ring
  have h_target : 1 / (216 * γ0) = (1 / 216) * (1 / γ0) := by ring
  rw [h_alg, h_target]
  have h_frac : (19 : ℝ) / 4104 = 1 / 216 := by norm_num
  rw [h_frac]

/-- Sharpened symmetrized ratio integral decay theorem:
$$\operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{216 \gamma_0}.$$ -/
theorem symmetrizedRatioIntegral_decay_le_one_div_216_gamma0 {s : ℂ} {γ0 : ℝ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hγ0 : 0 < γ0) (hγ : γ0 ≤ s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    symmetrizedRatioIntegral s ≤ 1 / (216 * γ0) := by
  unfold symmetrizedRatioIntegral
  have h_int_maj : IntegrableOn (fun x : ℝ => (19 / (18 * γ0)) * ((x - 1) * Real.exp (-Real.pi * x))) (Ioi 1) :=
    integrableOn_sub_one_mul_exp_neg_pi.const_mul (19 / (18 * γ0))
  have h_mono : ∫ x in Ioi (1 : ℝ), mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im) ≤
      ∫ x in Ioi (1 : ℝ), (19 / (18 * γ0)) * ((x - 1) * Real.exp (-Real.pi * x)) := by
    refine setIntegral_mono_on h_int h_int_maj measurableSet_Ioi fun x hx => ?_
    exact mellin_ratio_integrand_decay_le_nineteen_eighteenths hsr1 hsr2 hγ0 hγ (le_of_lt (mem_Ioi.mp hx))
  have h_pull : (∫ x in Ioi (1 : ℝ), (19 / (18 * γ0)) * ((x - 1) * Real.exp (-Real.pi * x))) =
      (19 / (18 * γ0)) * (∫ x in Ioi (1 : ℝ), (x - 1) * Real.exp (-Real.pi * x)) :=
    integral_const_mul (19 / (18 * γ0)) (fun x => (x - 1) * Real.exp (-Real.pi * x))
  rw [h_pull] at h_mono
  have h_eval := integral_sub_one_mul_exp_neg_pi_le_one_div_228
  have h_scale : (19 / (18 * γ0)) * (∫ x in Ioi (1 : ℝ), (x - 1) * Real.exp (-Real.pi * x)) ≤
      (19 / (18 * γ0)) * (1 / 228) :=
    mul_le_mul_of_nonneg_left h_eval (by positivity)
  have h_comb := h_mono.trans h_scale
  have h_num := nineteen_div_18_mul_inv_228_le hγ0
  exact h_comb.trans h_num

/-- Sharpened halved ratio deficit bound:
$$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{432 \gamma_0}.$$ -/
theorem half_symmetrizedRatioIntegral_decay_le_one_div_432_gamma0 {s : ℂ} {γ0 : ℝ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hγ0 : 0 < γ0) (hγ : γ0 ≤ s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / (432 * γ0) := by
  have h := symmetrizedRatioIntegral_decay_le_one_div_216_gamma0 hsr1 hsr2 hγ0 hγ h_int
  have h_half : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ (1 / 2 : ℝ) * (1 / (216 * γ0)) :=
    mul_le_mul_of_nonneg_left h (by norm_num)
  have h_alg : (1 / 2 : ℝ) * (1 / (216 * γ0)) = 1 / (432 * γ0) := by ring
  rw [h_alg] at h_half
  exact h_half

/-! ### Section 2: Bootstrap Step 1 ($7.4682015 \to 7.50$) -/

/-- Coordinate polynomial bound for $y \le 225/4$ ($t \le 15/2 = 7.50$). -/
theorem normSq_coords_le_fifty_one_thousand_five_hundred_twenty_five_div_sixteen {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 225 / 4) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ (51525 : ℝ) / 16 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ (51525 : ℝ) / 16 := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (225 / 4 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (225 / 4 : ℝ)^2 = 50625 / 16 := by norm_num
    rw [h2] at h1
    linarith
  linarith

/-- Bound on $\operatorname{normSq}(s(s-1)) \le 51525 / 16$ for $\operatorname{Im}(s) \le 15/2 = 7.50$. -/
theorem normSq_mul_sub_one_le_fifty_one_thousand_five_hundred_twenty_five_div_sixteen {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 15 / 2) :
    normSq (s * (s - 1)) ≤ (51525 : ℝ) / 16 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 225 / 4 := by
    have : s.im^2 ≤ (15 / 2 : ℝ)^2 := by nlinarith
    have : (15 / 2 : ℝ)^2 = 225 / 4 := by norm_num
    linarith
  exact normSq_coords_le_fifty_one_thousand_five_hundred_twenty_five_div_sixteen
    hsr1 hsr2 hy1 hy2

/-- Lower bound on $1 / |s(s-1)|^2 \ge 16 / 51525$ for $\operatorname{Im}(s) \le 15/2$. -/
theorem sixteen_div_fifty_one_thousand_five_hundred_twenty_five_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 15 / 2) :
    (16 : ℝ) / 51525 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_fifty_one_thousand_five_hundred_twenty_five_div_sixteen
    hsr1 hsr2 hsim1 hsim2
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
  have h_div : 1 / ((51525 : ℝ) / 16) = (16 : ℝ) / 51525 := by norm_num
  rw [← h_div]
  exact one_div_le_one_div_of_le h_pos h_le

/-- Unconditional Intermediate Ratio Deficit on $(14936403/2000000, 15/2]$:
$$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{432 \times (14936403/2000000)} < \frac{16}{51525} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_forty_six_eight_two_zero_one_five_to_seven_point_five :
    IntermediateRatioDeficit (14936403 / 2000000) (15 / 2) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_432_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (432 * (14936403 / 2000000 : ℝ)) < (16 : ℝ) / 51525 := by
    have h_denom : (51525 / 16 : ℝ) < 432 * (14936403 / 2000000) := by norm_num
    have h_pos : 0 < (51525 / 16 : ℝ) := by norm_num
    have h_inv := one_div_lt_one_div_of_lt h_pos h_denom
    have h_alg : 1 / (51525 / 16 : ℝ) = (16 : ℝ) / 51525 := by norm_num
    rwa [h_alg] at h_inv
  have h_ratio_lt : (1 / 2 : ℝ) * symmetrizedRatioIntegral s < (16 : ℝ) / 51525 :=
    h_decay.trans_lt h_dec_le
  have h_inv := sixteen_div_fifty_one_thousand_five_hundred_twenty_five_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  exact h_ratio_lt.trans_le h_inv

/-- Half-plane zero-free extension across $(14936403/2000000, 15/2]$. -/
theorem intermediate_half_plane_zero_free_seven_forty_six_eight_two_zero_one_five_to_seven_point_five {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 14936403 / 2000000 < s.im) (hsim2 : s.im ≤ 15 / 2) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_forty_six_eight_two_zero_one_five_to_seven_point_five s hsr hsim1 hsim2

/-! ### Section 3: Bootstrap Step 2 ($7.50 \to 7.51$) -/

/-- Coordinate polynomial bound for $y \le 564001 / 10000$ ($t \le 751/100 = 7.51$). -/
theorem normSq_coords_le_three_thousand_two_hundred_thirty_eight {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 564001 / 10000) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ (3238 : ℝ) := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ (3238 : ℝ) := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (564001 / 10000 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (564001 / 10000 : ℝ)^2 = 318097128001 / 100000000 := by norm_num
    have h3 : (564001 / 10000 : ℝ) = 5640010000 / 100000000 := by norm_num
    rw [h2] at h1
    rw [h3] at hy2
    linarith
  linarith

/-- Bound on $\operatorname{normSq}(s(s-1)) \le 3238$ for $\operatorname{Im}(s) \le 751/100 = 7.51$. -/
theorem normSq_mul_sub_one_le_three_thousand_two_hundred_thirty_eight {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 751 / 100) :
    normSq (s * (s - 1)) ≤ (3238 : ℝ) := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 564001 / 10000 := by
    have : s.im^2 ≤ (751 / 100 : ℝ)^2 := by nlinarith
    have : (751 / 100 : ℝ)^2 = 564001 / 10000 := by norm_num
    linarith
  exact normSq_coords_le_three_thousand_two_hundred_thirty_eight
    hsr1 hsr2 hy1 hy2

/-- Lower bound on $1 / |s(s-1)|^2 \ge 1 / 3238$ for $\operatorname{Im}(s) \le 751/100$. -/
theorem one_div_three_thousand_two_hundred_thirty_eight_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 751 / 100) :
    (1 : ℝ) / 3238 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_three_thousand_two_hundred_thirty_eight
    hsr1 hsr2 hsim1 hsim2
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
  exact one_div_le_one_div_of_le h_pos h_le

/-- Unconditional Intermediate Ratio Deficit on $(15/2, 751/100]$:
$$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{432 \times (15/2)} = \frac{1}{3240} < \frac{1}{3238} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_point_five_to_seven_point_five_one :
    IntermediateRatioDeficit (15 / 2) (751 / 100) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_432_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (432 * (15 / 2 : ℝ)) < (1 : ℝ) / 3238 := by
    have h1 : (3238 : ℝ) < 432 * (15 / 2) := by norm_num
    exact one_div_lt_one_div_of_lt (by norm_num) h1
  have h_ratio_lt : (1 / 2 : ℝ) * symmetrizedRatioIntegral s < (1 : ℝ) / 3238 :=
    h_decay.trans_lt h_dec_le
  have h_inv := one_div_three_thousand_two_hundred_thirty_eight_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  exact h_ratio_lt.trans_le h_inv

/-- Half-plane zero-free extension across $(15/2, 751/100]$. -/
theorem intermediate_half_plane_zero_free_seven_point_five_to_seven_point_five_one {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 15 / 2 < s.im) (hsim2 : s.im ≤ 751 / 100) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_point_five_to_seven_point_five_one s hsr hsim1 hsim2

/-! ### Section 4: Bootstrap Step 3 ($7.51 \to 7.514$) -/

/-- Coordinate polynomial bound for $y \le 14115049 / 250000$ ($t \le 3757/500 = 7.514$). -/
theorem normSq_coords_le_one_hundred_sixty_two_thousand_two_hundred_eleven_div_fifty {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 14115049 / 250000) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ (162211 : ℝ) / 50 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ (162211 : ℝ) / 50 := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (14115049 / 250000 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (14115049 / 250000 : ℝ)^2 = 199234608272401 / 62500000000 := by norm_num
    rw [h2] at h1
    linarith
  linarith

/-- Bound on $\operatorname{normSq}(s(s-1)) \le 162211 / 50$ for $\operatorname{Im}(s) \le 3757/500 = 7.514$. -/
theorem normSq_mul_sub_one_le_one_hundred_sixty_two_thousand_two_hundred_eleven_div_fifty {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 3757 / 500) :
    normSq (s * (s - 1)) ≤ (162211 : ℝ) / 50 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 14115049 / 250000 := by
    have : s.im^2 ≤ (3757 / 500 : ℝ)^2 := by nlinarith
    have : (3757 / 500 : ℝ)^2 = 14115049 / 250000 := by norm_num
    linarith
  exact normSq_coords_le_one_hundred_sixty_two_thousand_two_hundred_eleven_div_fifty
    hsr1 hsr2 hy1 hy2

/-- Lower bound on $1 / |s(s-1)|^2 \ge 50 / 162211$ for $\operatorname{Im}(s) \le 3757/500$. -/
theorem fifty_div_one_hundred_sixty_two_thousand_two_hundred_eleven_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 3757 / 500) :
    (50 : ℝ) / 162211 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_one_hundred_sixty_two_thousand_two_hundred_eleven_div_fifty
    hsr1 hsr2 hsim1 hsim2
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
  have h_div : 1 / ((162211 : ℝ) / 50) = (50 : ℝ) / 162211 := by norm_num
  rw [← h_div]
  exact one_div_le_one_div_of_le h_pos h_le

/-- Unconditional Intermediate Ratio Deficit on $(751/100, 3757/500]$:
$$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{432 \times (751/100)} < \frac{50}{162211} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_point_five_one_to_seven_point_five_one_four :
    IntermediateRatioDeficit (751 / 100) (3757 / 500) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_432_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (432 * (751 / 100 : ℝ)) < (50 : ℝ) / 162211 := by
    have h_denom : (162211 / 50 : ℝ) < 432 * (751 / 100) := by norm_num
    have h_pos : 0 < (162211 / 50 : ℝ) := by norm_num
    have h_inv := one_div_lt_one_div_of_lt h_pos h_denom
    have h_alg : 1 / (162211 / 50 : ℝ) = (50 : ℝ) / 162211 := by norm_num
    rwa [h_alg] at h_inv
  have h_ratio_lt : (1 / 2 : ℝ) * symmetrizedRatioIntegral s < (50 : ℝ) / 162211 :=
    h_decay.trans_lt h_dec_le
  have h_inv := fifty_div_one_hundred_sixty_two_thousand_two_hundred_eleven_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  exact h_ratio_lt.trans_le h_inv

/-- Half-plane zero-free extension across $(751/100, 3757/500]$. -/
theorem intermediate_half_plane_zero_free_seven_point_five_one_to_seven_point_five_one_four {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 751 / 100 < s.im) (hsim2 : s.im ≤ 3757 / 500) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_point_five_one_to_seven_point_five_one_four s hsr hsim1 hsim2

/-! ### Section 5: Bootstrap Step 4 ($7.514 \to 7.515$) -/

/-- Coordinate polynomial bound for $y \le 2259009 / 40000$ ($t \le 1503/200 = 7.515$). -/
theorem normSq_coords_le_three_thousand_two_hundred_forty_six {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 2259009 / 40000) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ (3246 : ℝ) := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ (3246 : ℝ) := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (2259009 / 40000 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (2259009 / 40000 : ℝ)^2 = 5103121662081 / 1600000000 := by norm_num
    rw [h2] at h1
    linarith
  linarith

/-- Bound on $\operatorname{normSq}(s(s-1)) \le 3246$ for $\operatorname{Im}(s) \le 1503/200 = 7.515$. -/
theorem normSq_mul_sub_one_le_three_thousand_two_hundred_forty_six {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 1503 / 200) :
    normSq (s * (s - 1)) ≤ (3246 : ℝ) := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 2259009 / 40000 := by
    have : s.im^2 ≤ (1503 / 200 : ℝ)^2 := by nlinarith
    have : (1503 / 200 : ℝ)^2 = 2259009 / 40000 := by norm_num
    linarith
  exact normSq_coords_le_three_thousand_two_hundred_forty_six
    hsr1 hsr2 hy1 hy2

/-- Lower bound on $1 / |s(s-1)|^2 \ge 1 / 3246$ for $\operatorname{Im}(s) \le 1503/200$. -/
theorem one_div_three_thousand_two_hundred_forty_six_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 1503 / 200) :
    (1 : ℝ) / 3246 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_three_thousand_two_hundred_forty_six
    hsr1 hsr2 hsim1 hsim2
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
  exact one_div_le_one_div_of_le h_pos h_le

/-- Unconditional Intermediate Ratio Deficit on $(3757/500, 1503/200]$:
$$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{432 \times (3757/500)} < \frac{1}{3246} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_point_five_one_four_to_seven_point_five_one_five :
    IntermediateRatioDeficit (3757 / 500) (1503 / 200) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_432_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (432 * (3757 / 500 : ℝ)) < (1 : ℝ) / 3246 := by
    have h1 : (3246 : ℝ) < 432 * (3757 / 500) := by norm_num
    exact one_div_lt_one_div_of_lt (by norm_num) h1
  have h_ratio_lt : (1 / 2 : ℝ) * symmetrizedRatioIntegral s < (1 : ℝ) / 3246 :=
    h_decay.trans_lt h_dec_le
  have h_inv := one_div_three_thousand_two_hundred_forty_six_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  exact h_ratio_lt.trans_le h_inv

/-- Half-plane zero-free extension across $(3757/500, 1503/200]$. -/
theorem intermediate_half_plane_zero_free_seven_point_five_one_four_to_seven_point_five_one_five {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 3757 / 500 < s.im) (hsim2 : s.im ≤ 1503 / 200) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_point_five_one_four_to_seven_point_five_one_five s hsr hsim1 hsim2

/-! ### Section 6: Cumulative Zero-Freeness to 7.515 and Master Equivalence -/

/-- Cumulative zero-free theorem up to $t = 1503 / 200 = 7.515$:
$$\forall s \in \mathbb{C},\; \operatorname{Re}(s) > 1/2 \land 0 < \operatorname{Im}(s) \le 1503/200 \implies \zeta(s) \ne 0.$$ -/
theorem cumulative_zero_free_to_seven_five_one_five {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 0 < s.im) (hsim2 : s.im ≤ 1503 / 200) :
    riemannZeta s ≠ 0 := by
  rcases le_or_gt s.im (14936403 / 2000000) with h_prev | h_above1
  · exact cumulative_zero_free_to_seven_four_six_eight_two_zero_one_five hsr hsim1 h_prev
  · rcases le_or_gt s.im (15 / 2) with h_mid1 | h_above2
    · exact intermediate_half_plane_zero_free_seven_forty_six_eight_two_zero_one_five_to_seven_point_five
        hsr h_above1 h_mid1
    · rcases le_or_gt s.im (751 / 100) with h_mid2 | h_above3
      · exact intermediate_half_plane_zero_free_seven_point_five_to_seven_point_five_one
          hsr h_above2 h_mid2
      · rcases le_or_gt s.im (3757 / 500) with h_mid3 | h_above4
        · exact intermediate_half_plane_zero_free_seven_point_five_one_to_seven_point_five_one_four
            hsr h_above3 h_mid3
        · exact intermediate_half_plane_zero_free_seven_point_five_one_four_to_seven_point_five_one_five
            hsr h_above4 hsim2

/-- CumulativeZeroFree proposition instantiated at $H = 1503 / 200 = 7.515$. -/
theorem cumulative_zero_free_base_seven_five_one_five :
    CumulativeZeroFree (1503 / 200) :=
  fun _ hsr hsim1 hsim2 =>
    cumulative_zero_free_to_seven_five_one_five hsr hsim1 hsim2

/-- Mathlib's canonical `LowFrequencyZeroFree` unconditionally certified up to $H = 1503/200 = 7.515$. -/
theorem lowFrequencyZeroFree_seven_five_one_five :
    LowFrequencyZeroFree (1503 / 200) :=
  lowFrequencyZeroFree_of_cumulativeZeroFree
    (by norm_num) cumulative_zero_free_base_seven_five_one_five

/-- Zero-freeness on the bilateral bounded-height critical strip up to height $7.515$. -/
theorem bounded_height_zero_free_seven_five_one_five :
    ∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → |s.im| ≤ 1503 / 200 → riemannZeta s ≠ 0 := by
  intro s hsr hs1 h_bound hz
  have h_le := lowFrequencyZeroFree_seven_five_one_five s hz hs1 h_bound
  linarith

/-- Master Biconditional: Riemann Hypothesis is equivalent to High-Frequency Zero-Freeness
above $H = 1503 / 200 = 7.515$. -/
theorem rh_iff_high_frequency_seven_five_one_five :
    RiemannHypothesis ↔ HighFrequencyZeroFree (1503 / 200) := by
  constructor
  · intro rh
    exact highFrequencyZeroFree_of_RH rh (1503 / 200)
  · intro h_high
    exact RiemannHypothesis_of_cumulative_and_high (1503 / 200) (by norm_num)
      cumulative_zero_free_base_seven_five_one_five h_high

/-- Unconditional RH deduction from high-frequency refutation above $7.515$. -/
theorem rh_of_high_frequency_seven_five_one_five :
    HighFrequencyZeroFree (1503 / 200) → RiemannHypothesis :=
  rh_iff_high_frequency_seven_five_one_five.mpr

/-- High-frequency zero-freeness above $7.515$ from Riemann Hypothesis. -/
theorem high_frequency_of_rh_seven_five_one_five :
    RiemannHypothesis → HighFrequencyZeroFree (1503 / 200) :=
  rh_iff_high_frequency_seven_five_one_five.mp

/-- Master Tripartite Gluing Theorem extending cumulative zero-freeness from $7.515$:
Combines cumulative deficit to $7.515$ with crossover real disparity and surplus. -/
theorem cumulative_zero_free_tripartite_from_seven_five_one_five
    {T_2 T_3 : ℝ} (hT_2 : 1503 / 200 ≤ T_2)
    (h_real : IntermediateRealDisparity (1503 / 200) T_2)
    (h_surp : IntermediateRatioSurplus T_2 T_3) :
    ∀ s : ℂ, 1 / 2 < s.re → 0 < s.im → s.im ≤ T_3 → riemannZeta s ≠ 0 := by
  intro s hsr hsim_pos hsim_le
  rcases le_or_gt s.im (1503 / 200) with h_def | h_above
  · exact cumulative_zero_free_to_seven_five_one_five hsr hsim_pos h_def
  · rcases le_or_gt s.im T_2 with h_mid | h_surp_zone
    · exact intermediate_half_plane_zero_free_of_real_disparity
        (by norm_num) h_real s hsr h_above h_mid
    · exact intermediate_half_plane_zero_free_of_surplus
        (by linarith) h_surp s hsr h_surp_zone hsim_le

/-! ### Section 7: In-File Declarative Axiom Audits -/

#print axioms pi_sq_mul_exp_pi_ge_228
#print axioms integral_sub_one_mul_exp_neg_pi_le_one_div_228
#print axioms nineteen_div_18_mul_inv_228_le
#print axioms symmetrizedRatioIntegral_decay_le_one_div_216_gamma0
#print axioms half_symmetrizedRatioIntegral_decay_le_one_div_432_gamma0
#print axioms normSq_coords_le_fifty_one_thousand_five_hundred_twenty_five_div_sixteen
#print axioms normSq_mul_sub_one_le_fifty_one_thousand_five_hundred_twenty_five_div_sixteen
#print axioms sixteen_div_fifty_one_thousand_five_hundred_twenty_five_le_inv_normSq
#print axioms intermediate_deficit_seven_forty_six_eight_two_zero_one_five_to_seven_point_five
#print axioms intermediate_half_plane_zero_free_seven_forty_six_eight_two_zero_one_five_to_seven_point_five
#print axioms normSq_coords_le_three_thousand_two_hundred_thirty_eight
#print axioms normSq_mul_sub_one_le_three_thousand_two_hundred_thirty_eight
#print axioms one_div_three_thousand_two_hundred_thirty_eight_le_inv_normSq
#print axioms intermediate_deficit_seven_point_five_to_seven_point_five_one
#print axioms intermediate_half_plane_zero_free_seven_point_five_to_seven_point_five_one
#print axioms normSq_coords_le_one_hundred_sixty_two_thousand_two_hundred_eleven_div_fifty
#print axioms normSq_mul_sub_one_le_one_hundred_sixty_two_thousand_two_hundred_eleven_div_fifty
#print axioms fifty_div_one_hundred_sixty_two_thousand_two_hundred_eleven_le_inv_normSq
#print axioms intermediate_deficit_seven_point_five_one_to_seven_point_five_one_four
#print axioms intermediate_half_plane_zero_free_seven_point_five_one_to_seven_point_five_one_four
#print axioms normSq_coords_le_three_thousand_two_hundred_forty_six
#print axioms normSq_mul_sub_one_le_three_thousand_two_hundred_forty_six
#print axioms one_div_three_thousand_two_hundred_forty_six_le_inv_normSq
#print axioms intermediate_deficit_seven_point_five_one_four_to_seven_point_five_one_five
#print axioms intermediate_half_plane_zero_free_seven_point_five_one_four_to_seven_point_five_one_five
#print axioms cumulative_zero_free_to_seven_five_one_five
#print axioms cumulative_zero_free_base_seven_five_one_five
#print axioms lowFrequencyZeroFree_seven_five_one_five
#print axioms bounded_height_zero_free_seven_five_one_five
#print axioms rh_iff_high_frequency_seven_five_one_five
#print axioms rh_of_high_frequency_seven_five_one_five
#print axioms high_frequency_of_rh_seven_five_one_five
#print axioms cumulative_zero_free_tripartite_from_seven_five_one_five

end

end BuildingBlocks.RiemannZetaSharpenedFourThirtyTwoRatioDeficit
