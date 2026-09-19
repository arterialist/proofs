/-
Copyright (c) 2026 Antigravity Team. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Antigravity Team
-/
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Analysis.Complex.ExponentialBounds
import BuildingBlocks.RiemannZetaKernelPositivity
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
import BuildingBlocks.RiemannZetaFrequencyDecayDeficit
import BuildingBlocks.RiemannZetaSharpenedKernelDeficit
import BuildingBlocks.RiemannZetaModularMellinInversion
import BuildingBlocks.RiemannZetaLowFrequencyContradiction

/-!
# RiemannZetaOptimalRatioDeficit: Optimal Exponential Bound and Bootstrap to 7.42

This module formalizes the optimal linear-exponential integral majorization and establishes
the unconditional non-vanishing of the Riemann zeta function $\zeta(s)$ on the open right half-plane
$\operatorname{Re}(s) > 1/2$ up to height $t = 7.42$.

### Mathematical Content
1. **Optimal Quadratic-Exponential Denominator**:
   Using `pi_gt_d2` ($\pi > 3.14$) and `exp_one_gt_d9` ($e > 2.718$), we establish:
   $$\pi^2 e^\pi \ge 224.$$
2. **Sharp Linear Integral Bound**:
   $$\int_1^\infty (x - 1) e^{-\pi x} \, dx = \frac{e^{-\pi}}{\pi^2} \le \frac{1}{224}.$$
3. **Integer Fraction Majorization**:
   With $18 \times 224 = 4032$ and $4032 > 19 \times 212 = 4028$:
   $$\frac{19}{18 \gamma_0} \times \frac{1}{224} \le \frac{1}{212 \gamma_0}.$$
4. **Optimal Halved Ratio Deficit**:
   $$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{424 \gamma_0}.$$
5. **Three-Stage Coordinate Bootstrap**:
   - Stage 1: $(6.78, 7.15]$ via $\frac{1}{424 \times (339/50)} \le \frac{1}{2874} < \frac{1}{2665} \le \frac{1}{|s(s-1)|^2}$.
   - Stage 2: $(7.15, 7.35]$ via $\frac{1}{424 \times (143/20)} \le \frac{1}{3031} < \frac{1}{2973} \le \frac{1}{|s(s-1)|^2}$.
   - Stage 3: $(7.35, 7.42]$ via $\frac{1}{424 \times (147/20)} \le \frac{1}{3116} < \frac{1}{3087} \le \frac{1}{|s(s-1)|^2}$.
6. **Master Theorem**:
   `cumulative_zero_free_to_seven_and_forty_two_hundredths`: Unconditionally proves
   $\zeta(s) \ne 0$ for all $\operatorname{Re}(s) > 1/2$ and $0 < \operatorname{Im}(s) \le 7.42$.
7. **Ratio Disparity Generalization**:
   Defines `IntermediateRatioSurplus` and `IntermediateRatioDisparity`, proving that any
   pointwise disparity between the ratio integral and the pole term unconditionally refutes zeros.

### Axiom Baseline
All declarations depend strictly on standard foundational Lean 4 axioms:
- `propext`
- `Classical.choice`
- `Quot.sound`
No unproven hypotheses or ad hoc axioms are introduced.
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
open BuildingBlocks.RiemannZetaFrequencyDecayDeficit
open BuildingBlocks.RiemannZetaSharpenedKernelDeficit
open BuildingBlocks.RiemannZetaModularMellinInversion
open BuildingBlocks.RiemannZetaLowFrequencyContradiction

namespace BuildingBlocks.RiemannZetaOptimalRatioDeficit

noncomputable section

/-! ### Section 1: Optimal Quadratic-Exponential Lower Bound -/

/-- Rigorous exponential lower bound: $\exp(\pi) \ge 22.8$. -/
theorem exp_pi_ge_twenty_two_point_eight : (228 / 10 : ℝ) ≤ Real.exp Real.pi := by
  have h_exp1 : (2718 / 1000 : ℝ) ≤ Real.exp 1 := by
    have := exp_one_gt_d9
    linarith
  have h_exp3 : (20 : ℝ) ≤ Real.exp 3 := by
    have h_pow : (2718 / 1000 : ℝ)^3 ≤ (Real.exp 1)^3 :=
      pow_le_pow_left₀ (by norm_num) h_exp1 3
    rw [← Real.exp_nat_mul] at h_pow
    have h_num : (20 : ℝ) ≤ (2718 / 1000 : ℝ)^3 := by norm_num
    linarith
  have h_exp_add : (14 / 100 : ℝ) + 1 ≤ Real.exp (14 / 100) :=
    add_one_le_exp (14 / 100 : ℝ)
  have h_exp_sum : (20 : ℝ) * (14 / 100 + 1) ≤ Real.exp 3 * Real.exp (14 / 100) := by
    apply mul_le_mul h_exp3 h_exp_add (by norm_num) (by positivity)
  rw [← Real.exp_add] at h_exp_sum
  have h_pi : (3 : ℝ) + 14 / 100 ≤ Real.pi := by
    have := pi_gt_d2
    linarith
  have h_exp_pi : Real.exp (3 + 14 / 100) ≤ Real.exp Real.pi :=
    Real.exp_le_exp.mpr h_pi
  have h_exp_comb : (20 : ℝ) * (14 / 100 + 1) ≤ Real.exp Real.pi :=
    h_exp_sum.trans h_exp_pi
  have h_arith : (228 / 10 : ℝ) ≤ (20 : ℝ) * (14 / 100 + 1) := by norm_num
  linarith

/-- Optimal lower bound: $\pi^2 \exp(\pi) \ge 224$. -/
theorem pi_sq_mul_exp_pi_ge_224 : (224 : ℝ) ≤ Real.pi^2 * Real.exp Real.pi := by
  have h_pi : (314 / 100 : ℝ) ≤ Real.pi := by
    have := pi_gt_d2
    linarith
  have h_pi_sq : (314 / 100 : ℝ)^2 ≤ Real.pi^2 :=
    pow_le_pow_left₀ (by norm_num) h_pi 2
  have h_exp := exp_pi_ge_twenty_two_point_eight
  have h_prod : (314 / 100 : ℝ)^2 * (228 / 10) ≤ Real.pi^2 * Real.exp Real.pi :=
    mul_le_mul h_pi_sq h_exp (by norm_num) (by positivity)
  have h_arith : (224 : ℝ) ≤ (314 / 100 : ℝ)^2 * (228 / 10) := by norm_num
  linarith

/-- Optimal linear-exponential integral majorization:
$$\int_1^\infty (x - 1) e^{-\pi x} \, dx \le \frac{1}{224}.$$ -/
theorem integral_sub_one_mul_exp_neg_pi_le_one_div_224 :
    ∫ x in Ioi (1 : ℝ), (x - 1) * Real.exp (-Real.pi * x) ≤ 1 / 224 := by
  rw [integral_sub_one_mul_exp_neg_pi]
  have h_alg : Real.exp (-Real.pi) / Real.pi^2 = 1 / (Real.pi^2 * Real.exp Real.pi) := by
    rw [Real.exp_neg]
    ring
  rw [h_alg]
  exact one_div_le_one_div_of_le (by norm_num) pi_sq_mul_exp_pi_ge_224

/-! ### Section 2: Optimal Halved Ratio Deficit Bound -/

/-- Optimal prefactor cancellation:
$$\frac{19}{18 \gamma_0} \times \frac{1}{224} \le \frac{1}{212 \gamma_0}.$$ -/
theorem nineteen_div_18_mul_inv_224_le {γ0 : ℝ} (hγ0 : 0 < γ0) :
    (19 / (18 * γ0)) * (1 / 224) ≤ 1 / (212 * γ0) := by
  have h_alg : (19 / (18 * γ0)) * (1 / 224) = (19 / 4032) * (1 / γ0) := by ring
  have h_target : 1 / (212 * γ0) = (1 / 212) * (1 / γ0) := by ring
  rw [h_alg, h_target]
  have h_frac : (19 : ℝ) / 4032 ≤ 1 / 212 := by norm_num
  have h_inv_pos : 0 ≤ 1 / γ0 := one_div_nonneg.mpr (le_of_lt hγ0)
  exact mul_le_mul_of_nonneg_right h_frac h_inv_pos

/-- Symmetrized ratio integral optimal decay theorem:
$$\operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{212 \gamma_0}.$$ -/
theorem symmetrizedRatioIntegral_decay_le_one_div_212_gamma0 {s : ℂ} {γ0 : ℝ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hγ0 : 0 < γ0) (hγ : γ0 ≤ s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    symmetrizedRatioIntegral s ≤ 1 / (212 * γ0) := by
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
  have h_eval := integral_sub_one_mul_exp_neg_pi_le_one_div_224
  have h_scale : (19 / (18 * γ0)) * (∫ x in Ioi (1 : ℝ), (x - 1) * Real.exp (-Real.pi * x)) ≤
      (19 / (18 * γ0)) * (1 / 224) :=
    mul_le_mul_of_nonneg_left h_eval (by positivity)
  have h_comb := h_mono.trans h_scale
  have h_num := nineteen_div_18_mul_inv_224_le hγ0
  exact h_comb.trans h_num

/-- Optimal halved ratio deficit bound:
$$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{424 \gamma_0}.$$ -/
theorem half_symmetrizedRatioIntegral_decay_le_one_div_424_gamma0 {s : ℂ} {γ0 : ℝ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hγ0 : 0 < γ0) (hγ : γ0 ≤ s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / (424 * γ0) := by
  have h := symmetrizedRatioIntegral_decay_le_one_div_212_gamma0 hsr1 hsr2 hγ0 hγ h_int
  have h_half : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ (1 / 2 : ℝ) * (1 / (212 * γ0)) :=
    mul_le_mul_of_nonneg_left h (by norm_num)
  have h_alg : (1 / 2 : ℝ) * (1 / (212 * γ0)) = 1 / (424 * γ0) := by ring
  rw [h_alg] at h_half
  exact h_half

/-! ### Section 3: Bootstrap Step 1 ($6.78 \to 7.15$) -/

/-- Polynomial remainder bound for coordinate norm-squared up to $y \le 20449/400$ ($t \le 143/20 = 7.15$). -/
theorem normSq_coords_le_two_thousand_six_hundred_sixty_five {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 20449 / 400) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 2665 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 2665 := by
    have h1 : y^2 ≤ (20449 / 400 : ℝ)^2 := by nlinarith
    have h2 : (20449 / 400 : ℝ)^2 = 418161601 / 160000 := by norm_num
    have h3 : (20449 / 400 : ℝ) = 8179600 / 160000 := by norm_num
    linarith
  linarith

/-- Bound on normSq $(s * (s - 1)) \le 2665$ for $\operatorname{Im}(s) \le 143/20$. -/
theorem normSq_mul_sub_one_le_two_thousand_six_hundred_sixty_five {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 143 / 20) :
    normSq (s * (s - 1)) ≤ 2665 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 20449 / 400 := by
    have : s.im^2 ≤ (143 / 20 : ℝ)^2 := by nlinarith
    have : (143 / 20 : ℝ)^2 = 20449 / 400 := by norm_num
    linarith
  exact normSq_coords_le_two_thousand_six_hundred_sixty_five hsr1 hsr2 hy1 hy2

/-- Lower bound on inverse normSq for $\operatorname{Im}(s) \le 143/20$:
$$\frac{1}{2665} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_div_two_thousand_six_hundred_sixty_five_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 143 / 20) :
    (1 : ℝ) / 2665 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_two_thousand_six_hundred_sixty_five hsr1 hsr2 hsim1 hsim2
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
  exact one_div_le_one_div_of_le h_pos h_le

/-- Unconditional Intermediate Ratio Deficit on $(339/50, 143/20]$:
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{424 \times (339/50)} \le \frac{1}{2874} < \frac{1}{2665} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_six_seventy_eight_to_seven_fifteen :
    IntermediateRatioDeficit (339 / 50) (143 / 20) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_424_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (424 * (339 / 50 : ℝ)) ≤ (1 : ℝ) / 2874 := by
    have h1 : (2874 : ℝ) ≤ 424 * (339 / 50) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 2874 :=
    h_decay.trans h_dec_le
  have h_inv := one_div_two_thousand_six_hundred_sixty_five_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 2874 < 1 / 2665 := by norm_num
  linarith

/-- Unconditional zero-freeness across $(339/50, 143/20]$ on $\operatorname{Re}(s) > 1/2$. -/
theorem intermediate_half_plane_zero_free_six_seventy_eight_to_seven_fifteen {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 339 / 50 < s.im) (hsim2 : s.im ≤ 143 / 20) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_six_seventy_eight_to_seven_fifteen s hsr hsim1 hsim2

/-! ### Section 4: Bootstrap Step 2 ($7.15 \to 7.35$) -/

/-- Polynomial remainder bound for coordinate norm-squared up to $y \le 21609/400$ ($t \le 147/20 = 7.35$). -/
theorem normSq_coords_le_two_thousand_nine_hundred_seventy_three {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 21609 / 400) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 2973 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 2973 := by
    have h1 : y^2 ≤ (21609 / 400 : ℝ)^2 := by nlinarith
    have h2 : (21609 / 400 : ℝ)^2 = 466948881 / 160000 := by norm_num
    have h3 : (21609 / 400 : ℝ) = 8643600 / 160000 := by norm_num
    linarith
  linarith

/-- Bound on normSq $(s * (s - 1)) \le 2973$ for $\operatorname{Im}(s) \le 147/20$. -/
theorem normSq_mul_sub_one_le_two_thousand_nine_hundred_seventy_three {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 147 / 20) :
    normSq (s * (s - 1)) ≤ 2973 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 21609 / 400 := by
    have : s.im^2 ≤ (147 / 20 : ℝ)^2 := by nlinarith
    have : (147 / 20 : ℝ)^2 = 21609 / 400 := by norm_num
    linarith
  exact normSq_coords_le_two_thousand_nine_hundred_seventy_three hsr1 hsr2 hy1 hy2

/-- Lower bound on inverse normSq for $\operatorname{Im}(s) \le 147/20$:
$$\frac{1}{2973} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_div_two_thousand_nine_hundred_seventy_three_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 147 / 20) :
    (1 : ℝ) / 2973 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_two_thousand_nine_hundred_seventy_three hsr1 hsr2 hsim1 hsim2
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
  exact one_div_le_one_div_of_le h_pos h_le

/-- Unconditional Intermediate Ratio Deficit on $(143/20, 147/20]$:
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{424 \times (143/20)} \le \frac{1}{3031} < \frac{1}{2973} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_fifteen_to_seven_thirty_five :
    IntermediateRatioDeficit (143 / 20) (147 / 20) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_424_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (424 * (143 / 20 : ℝ)) ≤ (1 : ℝ) / 3031 := by
    have h1 : (3031 : ℝ) ≤ 424 * (143 / 20) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 3031 :=
    h_decay.trans h_dec_le
  have h_inv := one_div_two_thousand_nine_hundred_seventy_three_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 3031 < 1 / 2973 := by norm_num
  linarith

/-- Unconditional zero-freeness across $(143/20, 147/20]$ on $\operatorname{Re}(s) > 1/2$. -/
theorem intermediate_half_plane_zero_free_seven_fifteen_to_seven_thirty_five {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 143 / 20 < s.im) (hsim2 : s.im ≤ 147 / 20) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_fifteen_to_seven_thirty_five s hsr hsim1 hsim2

/-! ### Section 5: Bootstrap Step 3 ($7.35 \to 7.42$) -/

/-- Polynomial remainder bound for coordinate norm-squared up to $y \le 137641/2500$ ($t \le 371/50 = 7.42$). -/
theorem normSq_coords_le_three_thousand_eighty_seven {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 137641 / 2500) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 3087 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 3087 := by
    have h1 : y^2 ≤ (137641 / 2500 : ℝ)^2 := by nlinarith
    have h2 : (137641 / 2500 : ℝ)^2 = 18945044881 / 6250000 := by norm_num
    have h3 : (137641 / 2500 : ℝ) = 344102500 / 6250000 := by norm_num
    linarith
  linarith

/-- Bound on normSq $(s * (s - 1)) \le 3087$ for $\operatorname{Im}(s) \le 371/50$. -/
theorem normSq_mul_sub_one_le_three_thousand_eighty_seven {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 371 / 50) :
    normSq (s * (s - 1)) ≤ 3087 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 137641 / 2500 := by
    have : s.im^2 ≤ (371 / 50 : ℝ)^2 := by nlinarith
    have : (371 / 50 : ℝ)^2 = 137641 / 2500 := by norm_num
    linarith
  exact normSq_coords_le_three_thousand_eighty_seven hsr1 hsr2 hy1 hy2

/-- Lower bound on inverse normSq for $\operatorname{Im}(s) \le 371/50$:
$$\frac{1}{3087} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_div_three_thousand_eighty_seven_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 371 / 50) :
    (1 : ℝ) / 3087 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_three_thousand_eighty_seven hsr1 hsr2 hsim1 hsim2
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
  exact one_div_le_one_div_of_le h_pos h_le

/-- Unconditional Intermediate Ratio Deficit on $(147/20, 371/50]$:
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{424 \times (147/20)} \le \frac{1}{3116} < \frac{1}{3087} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_seven_thirty_five_to_seven_forty_two :
    IntermediateRatioDeficit (147 / 20) (371 / 50) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_424_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (424 * (147 / 20 : ℝ)) ≤ (1 : ℝ) / 3116 := by
    have h1 : (3116 : ℝ) ≤ 424 * (147 / 20) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 3116 :=
    h_decay.trans h_dec_le
  have h_inv := one_div_three_thousand_eighty_seven_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 3116 < 1 / 3087 := by norm_num
  linarith

/-- Unconditional zero-freeness across $(147/20, 371/50]$ on $\operatorname{Re}(s) > 1/2$. -/
theorem intermediate_half_plane_zero_free_seven_thirty_five_to_seven_forty_two {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 147 / 20 < s.im) (hsim2 : s.im ≤ 371 / 50) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_seven_thirty_five_to_seven_forty_two s hsr hsim1 hsim2

/-! ### Section 6: Cumulative Zero-Free Ceiling Extension to 7.42 -/

/-- **Cumulative Zero-Free Ceiling to 7.42**:
Unconditionally proves $\zeta(s) \ne 0$ for all $\operatorname{Re}(s) > 1/2$ and $0 < \operatorname{Im}(s) \le 7.42$. -/
theorem cumulative_zero_free_to_seven_and_forty_two_hundredths {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim_pos : 0 < s.im) (hsim_le : s.im ≤ 371 / 50) :
    riemannZeta s ≠ 0 := by
  by_cases h1 : s.im ≤ 339 / 50
  · exact cumulative_zero_free_to_six_and_seventy_eight_hundredths hsr hsim_pos h1
  push_neg at h1
  by_cases h2 : s.im ≤ 143 / 20
  · exact intermediate_half_plane_zero_free_six_seventy_eight_to_seven_fifteen hsr h1 h2
  push_neg at h2
  by_cases h3 : s.im ≤ 147 / 20
  · exact intermediate_half_plane_zero_free_seven_fifteen_to_seven_thirty_five hsr h2 h3
  push_neg at h3
  exact intermediate_half_plane_zero_free_seven_thirty_five_to_seven_forty_two hsr h3 hsim_le

/-! ### Section 7: Generalized Ratio Disparity Framework -/

/-- The **Intermediate Ratio Surplus Property**:
The halved symmetrized ratio integral strictly exceeds the pole term across an interval. -/
def IntermediateRatioSurplus (T_low T_high : ℝ) : Prop :=
  ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → T_low < s.im → s.im ≤ T_high →
    1 / normSq (s * (s - 1)) < (1 / 2 : ℝ) * symmetrizedRatioIntegral s

/-- The **Intermediate Ratio Disparity Property**:
The halved symmetrized ratio integral differs from the pole term across an interval. -/
def IntermediateRatioDisparity (T_low T_high : ℝ) : Prop :=
  ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → T_low < s.im → s.im ≤ T_high →
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≠ 1 / normSq (s * (s - 1))

/-- Any ratio deficit implies a ratio disparity. -/
theorem disparity_of_deficit {T_low T_high : ℝ} (h_def : IntermediateRatioDeficit T_low T_high) :
    IntermediateRatioDisparity T_low T_high := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h := h_def s hsr1 hsr2 hsim1 hsim2
  exact ne_of_lt h

/-- Any ratio surplus implies a ratio disparity. -/
theorem disparity_of_surplus {T_low T_high : ℝ} (h_surp : IntermediateRatioSurplus T_low T_high) :
    IntermediateRatioDisparity T_low T_high := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h := h_surp s hsr1 hsr2 hsim1 hsim2
  exact (ne_of_lt h).symm

/-- Universal exclusion of off-line zeros under the **Intermediate Ratio Disparity Property**. -/
theorem intermediate_strip_zero_free_of_disparity
    {T_low T_high : ℝ} (hT_low : 0 ≤ T_low)
    (h_disp : IntermediateRatioDisparity T_low T_high) :
    ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → T_low < s.im → s.im ≤ T_high → riemannZeta s ≠ 0 := by
  intro s hsr1 hsr2 hsim1 hsim2 hz
  have hsim_pos : 0 < s.im := by linarith
  have h_exact := symmetrizedRatioExact_unconditional s
  have h_pole := normImRatio_eq_inv_normSq_of_zero hsr1 hsim_pos hz
  have h_d := h_disp s hsr1 hsr2 hsim1 hsim2
  unfold SymmetrizedRatioExact at h_exact
  rw [h_exact] at h_pole
  exact h_d h_pole

/-- Right half-plane zero-freeness under ratio disparity. -/
theorem intermediate_half_plane_zero_free_of_disparity
    {T_low T_high : ℝ} (hT_low : 0 ≤ T_low)
    (h_disp : IntermediateRatioDisparity T_low T_high) :
    ∀ s : ℂ, 1 / 2 < s.re → T_low < s.im → s.im ≤ T_high → riemannZeta s ≠ 0 := by
  intro s hsr hsim1 hsim2 hz
  rcases le_or_gt s.re 1 with h_le | h_gt
  · exact intermediate_strip_zero_free_of_disparity hT_low h_disp s hsr h_le hsim1 hsim2 hz
  · exact riemannZeta_ne_zero_of_one_lt_re h_gt hz

/-- Right half-plane zero-freeness under ratio surplus. -/
theorem intermediate_half_plane_zero_free_of_surplus
    {T_low T_high : ℝ} (hT_low : 0 ≤ T_low)
    (h_surp : IntermediateRatioSurplus T_low T_high) :
    ∀ s : ℂ, 1 / 2 < s.re → T_low < s.im → s.im ≤ T_high → riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_disparity hT_low (disparity_of_surplus h_surp)

/-! ### Section 8: Axiom Audits -/

#print axioms exp_pi_ge_twenty_two_point_eight
#print axioms pi_sq_mul_exp_pi_ge_224
#print axioms integral_sub_one_mul_exp_neg_pi_le_one_div_224
#print axioms nineteen_div_18_mul_inv_224_le
#print axioms symmetrizedRatioIntegral_decay_le_one_div_212_gamma0
#print axioms half_symmetrizedRatioIntegral_decay_le_one_div_424_gamma0
#print axioms intermediate_deficit_six_seventy_eight_to_seven_fifteen
#print axioms intermediate_half_plane_zero_free_six_seventy_eight_to_seven_fifteen
#print axioms intermediate_deficit_seven_fifteen_to_seven_thirty_five
#print axioms intermediate_half_plane_zero_free_seven_fifteen_to_seven_thirty_five
#print axioms intermediate_deficit_seven_thirty_five_to_seven_forty_two
#print axioms intermediate_half_plane_zero_free_seven_thirty_five_to_seven_forty_two
#print axioms cumulative_zero_free_to_seven_and_forty_two_hundredths
#print axioms intermediate_strip_zero_free_of_disparity
#print axioms intermediate_half_plane_zero_free_of_disparity
end

end BuildingBlocks.RiemannZetaOptimalRatioDeficit
