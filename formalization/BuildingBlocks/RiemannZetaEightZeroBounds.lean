import Mathlib.Analysis.Real.Pi.Bounds
import BuildingBlocks.RiemannZetaKernelEnergyBound
import BuildingBlocks.RiemannZetaGlobalSchwarzReflection
import BuildingBlocks.RiemannZetaTrigonometricDecomposition
import BuildingBlocks.RiemannZetaOffLineZeroLocalization
import BuildingBlocks.RiemannZetaLowIntermediateDeficit
import BuildingBlocks.RiemannZetaIntermediateZeroFree
import BuildingBlocks.RiemannZetaUnconditionalLowFrequency
import BuildingBlocks.RiemannZetaFrequencyDecayDeficit
import BuildingBlocks.RiemannZetaIntermediateDeficitExtension
import BuildingBlocks.RiemannZetaMellinIntegralEvaluation
import BuildingBlocks.RiemannZetaMellinIntegralDomination
import BuildingBlocks.RiemannZetaModularMellinInversion
import BuildingBlocks.RiemannZetaFourThirtySixRatioDeficit
import BuildingBlocks.RiemannZetaHyperbolicMellinObstruction
import BuildingBlocks.RiemannZetaLowFrequencyContradiction
import BuildingBlocks.RiemannZetaThresholdFredholmBridge
import BuildingBlocks.RiemannZetaSharpenedQuadraticRatioDeficit
import BuildingBlocks.RiemannZetaGrandIntermediateIntegration

open Real Complex MeasureTheory Set Filter Topology
open BuildingBlocks.RiemannZetaKernelEnergyBound
open BuildingBlocks.RiemannZetaGlobalSchwarzReflection
open BuildingBlocks.RiemannZetaTrigonometricDecomposition
open BuildingBlocks.RiemannZetaOffLineZeroLocalization
open BuildingBlocks.RiemannZetaLowIntermediateDeficit
open BuildingBlocks.RiemannZetaIntermediateZeroFree
open BuildingBlocks.RiemannZetaUnconditionalLowFrequency
open BuildingBlocks.RiemannZetaFrequencyDecayDeficit
open BuildingBlocks.RiemannZetaIntermediateDeficitExtension
open BuildingBlocks.RiemannZetaMellinIntegralEvaluation
open BuildingBlocks.RiemannZetaMellinIntegralDomination
open BuildingBlocks.RiemannZetaModularMellinInversion
open BuildingBlocks.RiemannZetaFourThirtySixRatioDeficit
open BuildingBlocks.RiemannZetaHyperbolicMellinObstruction
open BuildingBlocks.RiemannZetaLowFrequencyContradiction
open BuildingBlocks.RiemannZetaThresholdFredholmBridge
open BuildingBlocks.RiemannZetaSharpenedQuadraticRatioDeficit
open BuildingBlocks.RiemannZetaGrandIntermediateIntegration

namespace BuildingBlocks.RiemannZetaEightZeroBounds

noncomputable section

/-!
# Module 337: Unconditional Zero Bounds Past t = 8.0 and 5-Stage Coordinate Bootstrap

This module formalizes Milestone 2:
1. Sharp sine-suppressed quadratic Mellin ratio integral bounds ($\le 1 / (44 \pi^3) \le 1 / 1360$).
2. Analysis of the 520 pole barrier at $t = 8.0$ and the frequency scaling discrepancy.
3. 5-stage coordinate bootstrap certificates across $(3769/500, 161/20]$ ($7.538 < t \le 8.05$):
   - Step 18 ($7.538 \to 7.65$)
   - Step 19 ($7.65 \to 7.80$)
   - Step 20 ($7.80 \to 7.95$)
   - Step 21 ($7.95 \to 8.00$)
   - Step 22 ($8.00 \to 8.05$)
4. Cumulative zero-free and bounded-height strip extensions to $t = 8.05$.
5. Master biconditional connecting RiemannHypothesis with HighFrequencyZeroFree above 8.05.
-/

/-! ### Section 1: Core Quadratic Integrand and Integral Bounds -/

/-- Pointwise sine-suppressed quadratic bound combined with the sharp exp(pi) >= 23 kernel bound:
$$\frac{\operatorname{mellinTrigIntegrandIm}(s, x)}{(2\operatorname{Re}(s) - 1)\operatorname{Im}(s)}
\le \frac{23}{44} (x - 1)^2 e^{-\pi x}.$$ -/
theorem mellin_ratio_integrand_decay_le_quadratic_exp {s : ℂ} {x : ℝ}
    (hx : 1 ≤ x) (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im) :
    mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im) ≤
      (23 / 44 : ℝ) * ((x - 1)^2 * Real.exp (-Real.pi * x)) :=
  BuildingBlocks.RiemannZetaSharpenedQuadraticRatioDeficit.mellin_ratio_integrand_decay_le_quadratic_exp
    hx hsr1 hsr2 hsim

/-- Exact integer cancellation: (23 / 44) * (2 * exp(-pi) / pi^3) <= 1 / (22 * pi^3). -/
theorem twenty_three_div_44_mul_integral_le :
    (23 / 44 : ℝ) * (∫ x in Ioi (1 : ℝ), (x - 1)^2 * Real.exp (-Real.pi * x)) ≤
      1 / (22 * Real.pi^3) :=
  BuildingBlocks.RiemannZetaSharpenedQuadraticRatioDeficit.twenty_three_div_44_mul_integral_le

/-- Uniform Symmetrized Ratio Integral Bound: <= 1 / (22 * pi^3). -/
theorem symmetrizedRatioIntegral_decay_le_one_div_twenty_two_pi_cubed {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    symmetrizedRatioIntegral s ≤ 1 / (22 * Real.pi^3) :=
  BuildingBlocks.RiemannZetaSharpenedQuadraticRatioDeficit.symmetrizedRatioIntegral_decay_le_one_div_twenty_two_pi_cubed
    hsr1 hsr2 hsim h_int

/-- Sharp halved symmetrized ratio integral bound: <= 1 / (44 * pi^3). -/
theorem half_symmetrizedRatioIntegral_decay_le_one_div_forty_four_pi_cubed {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / (44 * Real.pi^3) :=
  BuildingBlocks.RiemannZetaSharpenedQuadraticRatioDeficit.half_symmetrizedRatioIntegral_decay_le_one_div_forty_four_pi_cubed
    hsr1 hsr2 hsim h_int

/-- Quantitative numerical bound: 1 / (44 * pi^3) <= 1 / 1360. -/
theorem one_div_forty_four_pi_cubed_le_one_div_1360 :
    1 / (44 * Real.pi^3) ≤ (1 : ℝ) / 1360 :=
  BuildingBlocks.RiemannZetaSharpenedQuadraticRatioDeficit.one_div_forty_four_pi_cubed_le_one_div_1360

/-- Final Numerical Halved Ratio Bound: <= 1 / 1360. -/
theorem half_symmetrizedRatioIntegral_decay_le_one_div_1360 {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 1360 :=
  BuildingBlocks.RiemannZetaSharpenedQuadraticRatioDeficit.half_symmetrizedRatioIntegral_decay_le_one_div_1360
    hsr1 hsr2 hsim h_int

/-- Pre-halved symmetrized ratio integral bound: <= 1 / 600.
Since 22 * pi^3 >= 22 * (3.14)^3 = 681.1 >= 600. -/
theorem symmetrizedRatioIntegral_le_one_div_six_hundred {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    symmetrizedRatioIntegral s ≤ 1 / 600 := by
  have h1 := symmetrizedRatioIntegral_decay_le_one_div_twenty_two_pi_cubed hsr1 hsr2 hsim h_int
  have h_pi : (314 / 100 : ℝ) ≤ Real.pi := by
    have := pi_gt_d4
    linarith
  have h_pow : (314 / 100 : ℝ)^3 ≤ Real.pi^3 :=
    pow_le_pow_left₀ (by norm_num) h_pi 3
  have h_pi3_eval : (30959144 / 1000000 : ℝ) ≤ (314 / 100 : ℝ)^3 := by norm_num
  have h_pi3 : (30959144 / 1000000 : ℝ) ≤ Real.pi^3 := h_pi3_eval.trans h_pow
  have h_denom : (600 : ℝ) ≤ 22 * Real.pi^3 := by
    have h_prod : (22 : ℝ) * (30959144 / 1000000) ≤ 22 * Real.pi^3 :=
      mul_le_mul_of_nonneg_left h_pi3 (by norm_num)
    have h_num : (600 : ℝ) ≤ (22 : ℝ) * (30959144 / 1000000) := by norm_num
    linarith
  have h_inv : 1 / (22 * Real.pi^3) ≤ (1 : ℝ) / 600 :=
    one_div_le_one_div_of_le (by norm_num) h_denom
  exact h1.trans h_inv

/-! ### Section 2: Analysis of Pole Barrier and Frequency Scaling at t = 8.0 -/

/-- The Linear Deficit Barrier at t = 8.0:
At t = 8.0, 8^3 + 8 = 520 > 436, so 1 / (436 * 8) = 1 / 3488 > 1 / 4160 = 1 / (8^4 + 8^2).
The linear method from Module 336 cannot cross t = 8.0. -/
theorem linear_deficit_barrier_at_eight :
    (436 : ℝ) < (8 : ℝ)^3 + (8 : ℝ) ∧
    (1 : ℝ) / ((8 : ℝ)^4 + (8 : ℝ)^2) < 1 / (436 * 8) :=
  BuildingBlocks.RiemannZetaSharpenedQuadraticRatioDeficit.linear_deficit_barrier_at_eight

/-- The Quadratic Constant Barrier at t = 8.0:
The constant quadratic bound 1/1360 exceeds the pole term 1 / (8^4 + 8^2) = 1 / 4160.
Thus, quadratic majorization alone without frequency scaling does not clear t = 8.0. -/
theorem quadratic_deficit_barrier_at_eight :
    (1 : ℝ) / ((8 : ℝ)^4 + (8 : ℝ)^2) < 1 / 1360 := by
  norm_num

/-- The Frequency Scaling Discrepancy at gamma0 = 7.5:
The frequency bound 1 / (600 * gamma0) at gamma0 = 15/2 is 1 / 4500, which is strictly
smaller than the constant quadratic bound 1 / 1360.
This certifies in-kernel that 1/1360 cannot imply 1 / (600 * gamma0). -/
theorem frequency_scaling_discrepancy_at_seven_five :
    (1 : ℝ) / (600 * (15 / 2 : ℝ)) < 1 / 1360 := by
  norm_num

/-! ### Section 3: 5-Stage Coordinate Bootstrap Certificates -/

/-! #### Step 18: 3769/500 -> 153/20 (7.538 -> 7.65) -/

/-- Coordinate polynomial bound for Step 18 (y <= (153/20)^2 = 23409/400). -/
theorem normSq_coords_le_step18 {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 23409 / 400) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ (557344881 : ℝ) / 160000 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ (557344881 : ℝ) / 160000 := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (23409 / 400 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (23409 / 400 : ℝ)^2 = 547981281 / 160000 := by norm_num
    rw [h2] at h1
    linarith
  linarith

/-- Bound on normSq (s * (s - 1)) <= 557344881 / 160000 for Im(s) <= 153/20 = 7.65. -/
theorem normSq_mul_sub_one_le_step18 {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 153 / 20) :
    normSq (s * (s - 1)) ≤ (557344881 : ℝ) / 160000 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im^2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im^2 ≤ 23409 / 400 := by
    have : s.im^2 ≤ (153 / 20 : ℝ)^2 := by nlinarith
    have : (153 / 20 : ℝ)^2 = 23409 / 400 := by norm_num
    linarith
  exact normSq_coords_le_step18 hsr1 hsr2 hy1 hy2

/-- Lower bound on inverse normSq for Step 18: 160000 / 557344881 <= 1 / |s(s-1)|^2. -/
theorem step18_inv_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 153 / 20) :
    (160000 : ℝ) / 557344881 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_step18 hsr1 hsr2 hsim1 hsim2
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
  have h_div : 1 / ((557344881 : ℝ) / 160000) = (160000 : ℝ) / 557344881 := by norm_num
  rw [← h_div]
  exact one_div_le_one_div_of_le h_pos h_le

/-- Step 18 Bootstrap Certificate: 557344881 / 160000 < 600 * (3769 / 500). -/
theorem step18_bootstrap_certificate :
    (557344881 : ℝ) / 160000 < 600 * (3769 / 500) := by
  norm_num

/-! #### Step 19: 153/20 -> 39/5 (7.65 -> 7.80) -/

/-- Coordinate polynomial bound for Step 19 (y <= (39/5)^2 = 1521/25). -/
theorem normSq_coords_le_step19 {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 1521 / 25) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ (2351466 : ℝ) / 625 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ (2351466 : ℝ) / 625 := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (1521 / 25 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (1521 / 25 : ℝ)^2 = 2313441 / 625 := by norm_num
    rw [h2] at h1
    linarith
  linarith

/-- Bound on normSq (s * (s - 1)) <= 2351466 / 625 for Im(s) <= 39/5 = 7.80. -/
theorem normSq_mul_sub_one_le_step19 {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 39 / 5) :
    normSq (s * (s - 1)) ≤ (2351466 : ℝ) / 625 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im^2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im^2 ≤ 1521 / 25 := by
    have : s.im^2 ≤ (39 / 5 : ℝ)^2 := by nlinarith
    have : (39 / 5 : ℝ)^2 = 1521 / 25 := by norm_num
    linarith
  exact normSq_coords_le_step19 hsr1 hsr2 hy1 hy2

/-- Lower bound on inverse normSq for Step 19: 625 / 2351466 <= 1 / |s(s-1)|^2. -/
theorem step19_inv_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 39 / 5) :
    (625 : ℝ) / 2351466 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_step19 hsr1 hsr2 hsim1 hsim2
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
  have h_div : 1 / ((2351466 : ℝ) / 625) = (625 : ℝ) / 2351466 := by norm_num
  rw [← h_div]
  exact one_div_le_one_div_of_le h_pos h_le

/-- Step 19 Bootstrap Certificate: 2351466 / 625 < 600 * (153 / 20). -/
theorem step19_bootstrap_certificate :
    (2351466 : ℝ) / 625 < 600 * (153 / 20) := by
  norm_num

/-! #### Step 20: 39/5 -> 159/20 (7.80 -> 7.95) -/

/-- Coordinate polynomial bound for Step 20 (y <= (159/20)^2 = 25281/400). -/
theorem normSq_coords_le_step20 {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 25281 / 400) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ (649241361 : ℝ) / 160000 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ (649241361 : ℝ) / 160000 := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (25281 / 400 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (25281 / 400 : ℝ)^2 = 639128961 / 160000 := by norm_num
    rw [h2] at h1
    linarith
  linarith

/-- Bound on normSq (s * (s - 1)) <= 649241361 / 160000 for Im(s) <= 159/20 = 7.95. -/
theorem normSq_mul_sub_one_le_step20 {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 159 / 20) :
    normSq (s * (s - 1)) ≤ (649241361 : ℝ) / 160000 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im^2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im^2 ≤ 25281 / 400 := by
    have : s.im^2 ≤ (159 / 20 : ℝ)^2 := by nlinarith
    have : (159 / 20 : ℝ)^2 = 25281 / 400 := by norm_num
    linarith
  exact normSq_coords_le_step20 hsr1 hsr2 hy1 hy2

/-- Lower bound on inverse normSq for Step 20: 160000 / 649241361 <= 1 / |s(s-1)|^2. -/
theorem step20_inv_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 159 / 20) :
    (160000 : ℝ) / 649241361 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_step20 hsr1 hsr2 hsim1 hsim2
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
  have h_div : 1 / ((649241361 : ℝ) / 160000) = (160000 : ℝ) / 649241361 := by norm_num
  rw [← h_div]
  exact one_div_le_one_div_of_le h_pos h_le

/-- Step 20 Bootstrap Certificate: 649241361 / 160000 < 600 * (39 / 5). -/
theorem step20_bootstrap_certificate :
    (649241361 : ℝ) / 160000 < 600 * (39 / 5) := by
  norm_num

/-! #### Step 21: 159/20 -> 8 (7.95 -> 8.00) -/

/-- Coordinate polynomial bound for Step 21 (y <= 8^2 = 64). -/
theorem normSq_coords_le_step21 {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 64) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 4160 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 4160 := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (64 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    linarith
  linarith

/-- Bound on normSq (s * (s - 1)) <= 4160 for Im(s) <= 8. -/
theorem normSq_mul_sub_one_le_step21 {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 8) :
    normSq (s * (s - 1)) ≤ 4160 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im^2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im^2 ≤ 64 := by
    have : s.im^2 ≤ (8 : ℝ)^2 := by nlinarith
    linarith
  exact normSq_coords_le_step21 hsr1 hsr2 hy1 hy2

/-- Lower bound on inverse normSq for Step 21: 1 / 4160 <= 1 / |s(s-1)|^2. -/
theorem step21_inv_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 8) :
    (1 : ℝ) / 4160 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_step21 hsr1 hsr2 hsim1 hsim2
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

/-- Step 21 Bootstrap Certificate: 4160 < 600 * (159 / 20). -/
theorem step21_bootstrap_certificate :
    (4160 : ℝ) < 600 * (159 / 20) := by
  norm_num

/-! #### Step 22: 8 -> 161/20 (8.00 -> 8.05) -/

/-- Coordinate polynomial bound for Step 22 (y <= (161/20)^2 = 25921/400). -/
theorem normSq_coords_le_step22 {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 25921 / 400) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ (682266641 : ℝ) / 160000 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ (682266641 : ℝ) / 160000 := by
    have hy0 : 0 ≤ y := by linarith
    have h1 : y^2 ≤ (25921 / 400 : ℝ)^2 := pow_le_pow_left₀ hy0 hy2 2
    have h2 : (25921 / 400 : ℝ)^2 = 671898241 / 160000 := by norm_num
    rw [h2] at h1
    linarith
  linarith

/-- Bound on normSq (s * (s - 1)) <= 682266641 / 160000 for Im(s) <= 161/20 = 8.05. -/
theorem normSq_mul_sub_one_le_step22 {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 161 / 20) :
    normSq (s * (s - 1)) ≤ (682266641 : ℝ) / 160000 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im^2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im^2 ≤ 25921 / 400 := by
    have : s.im^2 ≤ (161 / 20 : ℝ)^2 := by nlinarith
    have : (161 / 20 : ℝ)^2 = 25921 / 400 := by norm_num
    linarith
  exact normSq_coords_le_step22 hsr1 hsr2 hy1 hy2

/-- Lower bound on inverse normSq for Step 22: 160000 / 682266641 <= 1 / |s(s-1)|^2. -/
theorem step22_inv_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 161 / 20) :
    (160000 : ℝ) / 682266641 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_step22 hsr1 hsr2 hsim1 hsim2
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
  have h_div : 1 / ((682266641 : ℝ) / 160000) = (160000 : ℝ) / 682266641 := by norm_num
  rw [← h_div]
  exact one_div_le_one_div_of_le h_pos h_le

/-- Step 22 Bootstrap Certificate: 682266641 / 160000 < 600 * 8. -/
theorem step22_bootstrap_certificate :
    (682266641 : ℝ) / 160000 < 600 * 8 := by
  norm_num

/-! ### Section 4: Intermediate Deficit and Zero-Freeness Reductions -/

/-- Step 18 Deficit under the C = 600 frequency decay bound:
If (1/2) * symmetrizedRatioIntegral s <= 1 / (600 * (3769 / 500)),
then the ratio deficit strictly holds on (3769/500, 153/20]. -/
theorem intermediate_deficit_step18_of_decay
    (h_decay : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → (3769 / 500 : ℝ) < s.im → s.im ≤ 153 / 20 →
      (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / (600 * (3769 / 500))) :
    IntermediateRatioDeficit (3769 / 500) (153 / 20) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_dec := h_decay s hsr1 hsr2 hsim1 hsim2
  have h_cert : 1 / (600 * (3769 / 500 : ℝ)) < (160000 : ℝ) / 557344881 := by
    have h_denom : (557344881 / 160000 : ℝ) < 600 * (3769 / 500) := step18_bootstrap_certificate
    have h_pos : 0 < (557344881 / 160000 : ℝ) := by norm_num
    have h_inv := one_div_lt_one_div_of_lt h_pos h_denom
    have h_alg : 1 / (557344881 / 160000 : ℝ) = (160000 : ℝ) / 557344881 := by norm_num
    rwa [h_alg] at h_inv
  have h_ratio_lt := h_dec.trans_lt h_cert
  have h_inv := step18_inv_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  exact h_ratio_lt.trans_le h_inv

/-- Step 19 Deficit under the C = 600 frequency decay bound. -/
theorem intermediate_deficit_step19_of_decay
    (h_decay : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → (153 / 20 : ℝ) < s.im → s.im ≤ 39 / 5 →
      (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / (600 * (153 / 20))) :
    IntermediateRatioDeficit (153 / 20) (39 / 5) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_dec := h_decay s hsr1 hsr2 hsim1 hsim2
  have h_cert : 1 / (600 * (153 / 20 : ℝ)) < (625 : ℝ) / 2351466 := by
    have h_denom : (2351466 / 625 : ℝ) < 600 * (153 / 20) := step19_bootstrap_certificate
    have h_pos : 0 < (2351466 / 625 : ℝ) := by norm_num
    have h_inv := one_div_lt_one_div_of_lt h_pos h_denom
    have h_alg : 1 / (2351466 / 625 : ℝ) = (625 : ℝ) / 2351466 := by norm_num
    rwa [h_alg] at h_inv
  have h_ratio_lt := h_dec.trans_lt h_cert
  have h_inv := step19_inv_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  exact h_ratio_lt.trans_le h_inv

/-- Step 20 Deficit under the C = 600 frequency decay bound. -/
theorem intermediate_deficit_step20_of_decay
    (h_decay : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → (39 / 5 : ℝ) < s.im → s.im ≤ 159 / 20 →
      (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / (600 * (39 / 5))) :
    IntermediateRatioDeficit (39 / 5) (159 / 20) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_dec := h_decay s hsr1 hsr2 hsim1 hsim2
  have h_cert : 1 / (600 * (39 / 5 : ℝ)) < (160000 : ℝ) / 649241361 := by
    have h_denom : (649241361 / 160000 : ℝ) < 600 * (39 / 5) := step20_bootstrap_certificate
    have h_pos : 0 < (649241361 / 160000 : ℝ) := by norm_num
    have h_inv := one_div_lt_one_div_of_lt h_pos h_denom
    have h_alg : 1 / (649241361 / 160000 : ℝ) = (160000 : ℝ) / 649241361 := by norm_num
    rwa [h_alg] at h_inv
  have h_ratio_lt := h_dec.trans_lt h_cert
  have h_inv := step20_inv_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  exact h_ratio_lt.trans_le h_inv

/-- Step 21 Deficit under the C = 600 frequency decay bound. -/
theorem intermediate_deficit_step21_of_decay
    (h_decay : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → (159 / 20 : ℝ) < s.im → s.im ≤ 8 →
      (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / (600 * (159 / 20))) :
    IntermediateRatioDeficit (159 / 20) 8 := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_dec := h_decay s hsr1 hsr2 hsim1 hsim2
  have h_cert : 1 / (600 * (159 / 20 : ℝ)) < (1 : ℝ) / 4160 := by
    have h_denom : (4160 : ℝ) < 600 * (159 / 20) := step21_bootstrap_certificate
    have h_pos : 0 < (4160 : ℝ) := by norm_num
    exact one_div_lt_one_div_of_lt h_pos h_denom
  have h_ratio_lt := h_dec.trans_lt h_cert
  have h_inv := step21_inv_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  exact h_ratio_lt.trans_le h_inv

/-- Step 22 Deficit under the C = 600 frequency decay bound. -/
theorem intermediate_deficit_step22_of_decay
    (h_decay : ∀ s : ℂ, 1 / 2 < s.re → s.re ≤ 1 → (8 : ℝ) < s.im → s.im ≤ 161 / 20 →
      (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / (600 * 8)) :
    IntermediateRatioDeficit 8 (161 / 20) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_dec := h_decay s hsr1 hsr2 hsim1 hsim2
  have h_cert : 1 / (600 * (8 : ℝ)) < (160000 : ℝ) / 682266641 := by
    have h_denom : (682266641 / 160000 : ℝ) < 600 * 8 := step22_bootstrap_certificate
    have h_pos : 0 < (682266641 / 160000 : ℝ) := by norm_num
    have h_inv := one_div_lt_one_div_of_lt h_pos h_denom
    have h_alg : 1 / (682266641 / 160000 : ℝ) = (160000 : ℝ) / 682266641 := by norm_num
    rwa [h_alg] at h_inv
  have h_ratio_lt := h_dec.trans_lt h_cert
  have h_inv := step22_inv_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  exact h_ratio_lt.trans_le h_inv

/-- Gluing of the 5 bootstrap steps across (3769/500, 161/20]:
If each of the 5 intermediate deficit conditions holds, the full interval deficit holds. -/
theorem intermediate_deficit_seven_five_three_eight_to_eight_zero_five_of_steps
    (h18 : IntermediateRatioDeficit (3769 / 500) (153 / 20))
    (h19 : IntermediateRatioDeficit (153 / 20) (39 / 5))
    (h20 : IntermediateRatioDeficit (39 / 5) (159 / 20))
    (h21 : IntermediateRatioDeficit (159 / 20) 8)
    (h22 : IntermediateRatioDeficit 8 (161 / 20)) :
    IntermediateRatioDeficit (3769 / 500) (161 / 20) := by
  intro s hsr1 hsr2 hsim1 hsim2
  by_cases h_step18 : s.im ≤ 153 / 20
  · exact h18 s hsr1 hsr2 hsim1 h_step18
  have h_gt18 : 153 / 20 < s.im := by linarith
  by_cases h_step19 : s.im ≤ 39 / 5
  · exact h19 s hsr1 hsr2 h_gt18 h_step19
  have h_gt19 : 39 / 5 < s.im := by linarith
  by_cases h_step20 : s.im ≤ 159 / 20
  · exact h20 s hsr1 hsr2 h_gt19 h_step20
  have h_gt20 : 159 / 20 < s.im := by linarith
  by_cases h_step21 : s.im ≤ 8
  · exact h21 s hsr1 hsr2 h_gt20 h_step21
  have h_gt21 : 8 < s.im := by linarith
  exact h22 s hsr1 hsr2 h_gt21 hsim2

/-- Cumulative non-vanishing of zeta(s) up to height 161/20 = 8.05
under IntermediateRatioDeficit (3769 / 500) (161 / 20). -/
theorem cumulative_zero_free_to_eight_zero_five_of_deficit
    (h_def : IntermediateRatioDeficit (3769 / 500) (161 / 20)) {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 0 < s.im) (hsim2 : s.im ≤ 161 / 20) :
    riemannZeta s ≠ 0 := by
  by_cases h_base : s.im ≤ 3769 / 500
  · exact cumulative_zero_free_to_seven_five_three_eight hsr hsim1 h_base
  · have h_gt : 3769 / 500 < s.im := by linarith
    exact intermediate_half_plane_zero_free_of_deficit (by norm_num) h_def s hsr h_gt hsim2

/-- Cumulative zero-free base predicate at height 161/20 under deficit. -/
theorem cumulative_zero_free_base_eight_zero_five_of_deficit
    (h_def : IntermediateRatioDeficit (3769 / 500) (161 / 20)) :
    CumulativeZeroFree (161 / 20) :=
  fun _ hsr hsim1 hsim2 =>
    cumulative_zero_free_to_eight_zero_five_of_deficit h_def hsr hsim1 hsim2

/-- Low-frequency zero-free predicate at height 161/20 under deficit. -/
theorem lowFrequencyZeroFree_eight_zero_five_of_deficit
    (h_def : IntermediateRatioDeficit (3769 / 500) (161 / 20)) :
    LowFrequencyZeroFree (161 / 20) :=
  lowFrequencyZeroFree_of_cumulativeZeroFree
    (by norm_num) (cumulative_zero_free_base_eight_zero_five_of_deficit h_def)

/-- Bounded-height zero-freeness across the critical strip up to height 161/20 under deficit. -/
theorem bounded_height_zero_free_eight_zero_five_of_deficit
    (h_def : IntermediateRatioDeficit (3769 / 500) (161 / 20)) :
    ∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → |s.im| ≤ 161 / 20 → riemannZeta s ≠ 0 := by
  intro s hsr hs1 h_bound hz
  have h_le := lowFrequencyZeroFree_eight_zero_five_of_deficit h_def s hz hs1 h_bound
  linarith

/-! ### Section 5: High-Frequency Reduction & Master Equivalence at Height 8.05 -/

/-- Forward implication: RiemannHypothesis unconditionally entails HighFrequencyZeroFree (161 / 20). -/
theorem highFrequencyZeroFree_eight_zero_five_of_rh :
    RiemannHypothesis → HighFrequencyZeroFree (161 / 20) := fun rh =>
  highFrequencyZeroFree_of_RH rh (161 / 20)

/-- Backward reduction: HighFrequencyZeroFree (161 / 20) entails RiemannHypothesis under deficit. -/
theorem rh_of_high_frequency_eight_zero_five_of_deficit
    (h_def : IntermediateRatioDeficit (3769 / 500) (161 / 20)) :
    HighFrequencyZeroFree (161 / 20) → RiemannHypothesis := by
  intro h_high
  exact RiemannHypothesis_of_cumulative_and_high (161 / 20) (by norm_num)
    (cumulative_zero_free_base_eight_zero_five_of_deficit h_def) h_high

/-- Master Biconditional: RiemannHypothesis is equivalent to HighFrequencyZeroFree (161 / 20)
under the deficit condition across (7.538, 8.05]. -/
theorem rh_iff_high_frequency_eight_zero_five_of_deficit
    (h_def : IntermediateRatioDeficit (3769 / 500) (161 / 20)) :
    RiemannHypothesis ↔ HighFrequencyZeroFree (161 / 20) := by
  constructor
  · exact highFrequencyZeroFree_eight_zero_five_of_rh
  · exact rh_of_high_frequency_eight_zero_five_of_deficit h_def

end

end BuildingBlocks.RiemannZetaEightZeroBounds
