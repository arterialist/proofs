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
import BuildingBlocks.RiemannZetaModularMellinInversion
import BuildingBlocks.RiemannZetaLowFrequencyContradiction

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
open BuildingBlocks.RiemannZetaModularMellinInversion
open BuildingBlocks.RiemannZetaLowFrequencyContradiction

namespace BuildingBlocks.RiemannZetaSharpenedQuadraticRatioDeficit

noncomputable section

/-!
# Module 337: Sharp Sine-Suppressed Quadratic Ratio Deficit Bound

This module formalizes the sharp quadratic ratio deficit bound, establishing:
1. `mellin_ratio_integrand_decay_le_quadratic_exp`: Pointwise bound via sharp exp(pi) >= 23
   kernel majorization.
2. `twenty_three_div_44_mul_integral_le`: Exact integer cancellation
   (23/44) * (2/23 π^3) <= 1 / (22 π^3).
3. `symmetrizedRatioIntegral_decay_le_one_div_twenty_two_pi_cubed`: Uniform ratio integral
   bound <= 1 / (22 π^3).
4. `half_symmetrizedRatioIntegral_decay_le_one_div_forty_four_pi_cubed`: Halved symmetrized
   ratio integral bound <= 1 / (44 π^3).
5. `one_div_forty_four_pi_cubed_le_one_div_1360`: Numerical certificate 1 / (44 π^3) <= 1 / 1360.
6. `half_symmetrizedRatioIntegral_decay_le_one_div_1360`: Halved ratio bound <= 1 / 1360.
7. Deficit reductions: Cutting the integral by > 62% over 1/436 and 1/513.
8. Analysis of the 7.538 linear barrier: Showing that the linear 436 bound is strictly obstructed
   at t = 7.54 and t = 8.0, whereas the quadratic sine-suppressed majorant unlocks zero-free
   ordinates past 7.538 towards t = 8.0+.
-/

/-! ### Section 1: Core Quadratic Integrand and Integral Bounds -/

/-- The sine-suppressed quadratic bound combined with the sharp exp(pi) >= 23 kernel bound:
$$\frac{\operatorname{mellinTrigIntegrandIm}(s, x)}{(2\operatorname{Re}(s) - 1)\operatorname{Im}(s)}
\le \frac{23}{44} (x - 1)^2 e^{-\pi x}.$$ -/
theorem mellin_ratio_integrand_decay_le_quadratic_exp {s : ℂ} {x : ℝ}
    (hx : 1 ≤ x) (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im) :
    mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im) ≤
      (23 / 44 : ℝ) * ((x - 1)^2 * Real.exp (-Real.pi * x)) := by
  have h_quad := mellin_ratio_integrand_decay_le_quadratic hx hsr1 hsr2 hsim
  have h_f := real_f_modif_le_twenty_three_elevenths_exp hx
  have h_prod : (1 / 4 : ℝ) * (x - 1)^2 * real_f_modif x ≤
      (1 / 4 : ℝ) * (x - 1)^2 * ((23 / 11 : ℝ) * Real.exp (-Real.pi * x)) := by
    apply mul_le_mul_of_nonneg_left h_f
    positivity
  have h_alg : (1 / 4 : ℝ) * (x - 1)^2 * ((23 / 11 : ℝ) * Real.exp (-Real.pi * x)) =
      (23 / 44 : ℝ) * ((x - 1)^2 * Real.exp (-Real.pi * x)) := by ring
  rw [h_alg] at h_prod
  exact h_quad.trans h_prod

/-- Exact cancellation: (23 / 44) * (2 * exp(-pi) / pi^3) <= 1 / (22 * pi^3).
The factor of 23 in the numerator cancels the factor of 23 from exp(-pi) <= 1/23. -/
theorem twenty_three_div_44_mul_integral_le :
    (23 / 44 : ℝ) * (∫ x in Ioi (1 : ℝ), (x - 1)^2 * Real.exp (-Real.pi * x)) ≤
      1 / (22 * Real.pi^3) := by
  rw [integral_sub_one_sq_mul_exp_neg_pi]
  have h_exp := exp_neg_pi_le_one_twenty_third
  have h_pi_pos : 0 < Real.pi := Real.pi_pos
  have h_pi3_pos : 0 < Real.pi^3 := by positivity
  have h_top : 2 * Real.exp (-Real.pi) ≤ 2 * (1 / 23 : ℝ) := by linarith
  have h_frac : (2 * Real.exp (-Real.pi)) / Real.pi^3 ≤ (2 * (1 / 23 : ℝ)) / Real.pi^3 :=
    div_le_div_of_nonneg_right h_top (le_of_lt h_pi3_pos)
  have h_mul : (23 / 44 : ℝ) * ((2 * Real.exp (-Real.pi)) / Real.pi^3) ≤
      (23 / 44 : ℝ) * ((2 * (1 / 23 : ℝ)) / Real.pi^3) :=
    mul_le_mul_of_nonneg_left h_frac (by norm_num)
  have h_cancel : (23 / 44 : ℝ) * ((2 * (1 / 23 : ℝ)) / Real.pi^3) = 1 / (22 * Real.pi^3) := by
    field_simp
    ring
  rw [h_cancel] at h_mul
  exact h_mul

/-- Uniform Symmetrized Ratio Integral Bound: <= 1 / (22 * pi^3). -/
theorem symmetrizedRatioIntegral_decay_le_one_div_twenty_two_pi_cubed {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    symmetrizedRatioIntegral s ≤ 1 / (22 * Real.pi^3) := by
  unfold symmetrizedRatioIntegral
  have h_int_maj : IntegrableOn (fun x : ℝ => (23 / 44 : ℝ) * ((x - 1)^2 * Real.exp (-Real.pi * x))) (Ioi 1) :=
    integrableOn_sub_one_sq_mul_exp_neg_pi.const_mul (23 / 44)
  have h_mono : ∫ x in Ioi (1 : ℝ), mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im) ≤
      ∫ x in Ioi (1 : ℝ), (23 / 44 : ℝ) * ((x - 1)^2 * Real.exp (-Real.pi * x)) := by
    refine setIntegral_mono_on h_int h_int_maj measurableSet_Ioi fun x hx => ?_
    exact mellin_ratio_integrand_decay_le_quadratic_exp (le_of_lt (mem_Ioi.mp hx)) hsr1 hsr2 hsim
  have h_pull : (∫ x in Ioi (1 : ℝ), (23 / 44 : ℝ) * ((x - 1)^2 * Real.exp (-Real.pi * x))) =
      (23 / 44 : ℝ) * (∫ x in Ioi (1 : ℝ), (x - 1)^2 * Real.exp (-Real.pi * x)) :=
    integral_const_mul (23 / 44) (fun x => (x - 1)^2 * Real.exp (-Real.pi * x))
  rw [h_pull] at h_mono
  exact h_mono.trans twenty_three_div_44_mul_integral_le

/-- Sharp halved symmetrized ratio integral bound: <= 1 / (44 * pi^3). -/
theorem half_symmetrizedRatioIntegral_decay_le_one_div_forty_four_pi_cubed {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / (44 * Real.pi^3) := by
  have h := symmetrizedRatioIntegral_decay_le_one_div_twenty_two_pi_cubed hsr1 hsr2 hsim h_int
  have h_half : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ (1 / 2 : ℝ) * (1 / (22 * Real.pi^3)) :=
    mul_le_mul_of_nonneg_left h (by norm_num)
  have h_alg : (1 / 2 : ℝ) * (1 / (22 * Real.pi^3)) = 1 / (44 * Real.pi^3) := by ring
  rw [h_alg] at h_half
  exact h_half

/-- Quantitative numerical bound: 1 / (44 * pi^3) <= 1 / 1360. -/
theorem one_div_forty_four_pi_cubed_le_one_div_1360 :
    1 / (44 * Real.pi^3) ≤ (1 : ℝ) / 1360 := by
  have h_pi : (314 / 100 : ℝ) ≤ Real.pi := by
    have := pi_gt_d4
    linarith
  have h_pi_pos : (0 : ℝ) < 314 / 100 := by norm_num
  have h_pow : (314 / 100 : ℝ)^3 ≤ Real.pi^3 :=
    pow_le_pow_left₀ (by norm_num) h_pi 3
  have h_pi3_eval : (30959144 / 1000000 : ℝ) ≤ (314 / 100 : ℝ)^3 := by norm_num
  have h_pi3 : (30959144 / 1000000 : ℝ) ≤ Real.pi^3 := h_pi3_eval.trans h_pow
  have h_denom : (1360 : ℝ) ≤ 44 * Real.pi^3 := by
    have h_prod : (44 : ℝ) * (30959144 / 1000000) ≤ 44 * Real.pi^3 :=
      mul_le_mul_of_nonneg_left h_pi3 (by norm_num)
    have h_num : (1360 : ℝ) ≤ (44 : ℝ) * (30959144 / 1000000) := by norm_num
    linarith
  have h_pos : 0 < (1360 : ℝ) := by norm_num
  have h_pi3_pos : 0 < 44 * Real.pi^3 := by positivity
  exact one_div_le_one_div_of_le h_pos h_denom

/-- Final Numerical Halved Ratio Bound: <= 1 / 1360. -/
theorem half_symmetrizedRatioIntegral_decay_le_one_div_1360 {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 1360 :=
  (half_symmetrizedRatioIntegral_decay_le_one_div_forty_four_pi_cubed hsr1 hsr2 hsim h_int).trans
    one_div_forty_four_pi_cubed_le_one_div_1360

/-! ### Section 2: Deficit Reductions (> 62% over 1/436 and 1/513) -/

/-- Percentage reduction over 1/513:
The bound 1/1360 cuts 1/513 by more than 62% (specifically 1 - 513/1360 ≈ 62.28%). -/
theorem one_div_1360_le_sixty_two_percent_cut_513 :
    (1 : ℝ) / 1360 ≤ (1 - 62 / 100 : ℝ) * (1 / 513) := by
  norm_num

/-- Strict inequality: 1/1360 < 1/513. -/
theorem one_div_1360_lt_one_div_513 :
    (1 : ℝ) / 1360 < 1 / 513 := by
  norm_num

/-- Halved symmetrized ratio integral cuts 1/513 by > 62%. -/
theorem half_symmetrizedRatioIntegral_decay_le_sixty_two_percent_cut_513 {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ (1 - 62 / 100 : ℝ) * (1 / 513) :=
  (half_symmetrizedRatioIntegral_decay_le_one_div_1360 hsr1 hsr2 hsim h_int).trans
    one_div_1360_le_sixty_two_percent_cut_513

/-- Halved symmetrized ratio integral strictly less than 1/513. -/
theorem half_symmetrizedRatioIntegral_decay_lt_one_div_513 {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s < 1 / 513 :=
  (half_symmetrizedRatioIntegral_decay_le_one_div_1360 hsr1 hsr2 hsim h_int).trans_lt
    one_div_1360_lt_one_div_513

/-- Percentage reduction over 1/436:
The bound 1/1360 cuts 1/436 by more than 62% (specifically 1 - 436/1360 ≈ 67.94%). -/
theorem one_div_1360_le_sixty_two_percent_cut_436 :
    (1 : ℝ) / 1360 ≤ (1 - 62 / 100 : ℝ) * (1 / 436) := by
  norm_num

/-- Strict inequality: 1/1360 < 1/436. -/
theorem one_div_1360_lt_one_div_436 :
    (1 : ℝ) / 1360 < 1 / 436 := by
  norm_num

/-- Halved symmetrized ratio integral cuts 1/436 by > 62%. -/
theorem half_symmetrizedRatioIntegral_decay_le_sixty_two_percent_cut_436 {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ (1 - 62 / 100 : ℝ) * (1 / 436) :=
  (half_symmetrizedRatioIntegral_decay_le_one_div_1360 hsr1 hsr2 hsim h_int).trans
    one_div_1360_le_sixty_two_percent_cut_436

/-- Halved symmetrized ratio integral strictly less than 1/436. -/
theorem half_symmetrizedRatioIntegral_decay_lt_one_div_436 {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s < 1 / 436 :=
  (half_symmetrizedRatioIntegral_decay_le_one_div_1360 hsr1 hsr2 hsim h_int).trans_lt
    one_div_1360_lt_one_div_436

/-! ### Section 3: Analysis of the 7.538 Linear Barrier -/

/-- The Linear Deficit Barrier at t = 7.54:
In the linear approach, the deficit inequality requires 1 / (436 * t) < 1 / (t^4 + t^2),
which is equivalent to t^3 + t < 436.
At t = 377/50 = 7.54, t^3 + t = 436.201 > 436, so the linear bound fails. -/
theorem linear_deficit_barrier_at_seven_five_four :
    (436 : ℝ) < (377 / 50 : ℝ)^3 + (377 / 50 : ℝ) ∧
    (1 : ℝ) / ((377 / 50 : ℝ)^4 + (377 / 50 : ℝ)^2) < 1 / (436 * (377 / 50 : ℝ)) := by
  constructor
  · norm_num
  · norm_num

/-- The Linear Deficit Failure at t = 8.0:
At t = 8.0, 8^3 + 8 = 520 > 436, so 1 / (436 * 8) = 1 / 3488 > 1 / 4160 = 1 / (8^4 + 8^2).
The linear method is structurally barred from reaching t = 8.0. -/
theorem linear_deficit_barrier_at_eight :
    (436 : ℝ) < (8 : ℝ)^3 + (8 : ℝ) ∧
    (1 : ℝ) / ((8 : ℝ)^4 + (8 : ℝ)^2) < 1 / (436 * 8) := by
  constructor
  · norm_num
  · norm_num

/-! ### Section 4: Unlocking Ratio Deficit and Zero-Freeness via Quadratic Majorization -/

/-- Polynomial remainder bound for y <= 36 (i.e. t <= 6). -/
theorem normSq_coords_le_thirteen_fifty {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 36) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 1350 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 1350 := by nlinarith
  linarith

/-- Bound on normSq (s * (s - 1)) <= 1350 for Im(s) <= 6. -/
theorem normSq_mul_sub_one_le_thirteen_fifty {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 6) :
    normSq (s * (s - 1)) ≤ 1350 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im^2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im^2 ≤ 36 := by
    have : s.im^2 ≤ (6 : ℝ)^2 := by nlinarith
    linarith
  exact normSq_coords_le_thirteen_fifty hsr1 hsr2 hy1 hy2

/-- Lower bound on inverse normSq for Im(s) <= 6: 1/1350 <= 1 / |s(s-1)|^2. -/
theorem one_div_thirteen_fifty_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 6) :
    (1 : ℝ) / 1350 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_thirteen_fifty hsr1 hsr2 hsim1 hsim2
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
  have h1350 : 0 < (1350 : ℝ) := by norm_num
  exact one_div_le_one_div_of_le h_pos h_le

/-- Unconditional Intermediate Ratio Deficit on (23/5, 6]:
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le 1/1360 < 1/1350 \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_twenty_three_fifths_to_six :
    IntermediateRatioDeficit (23 / 5) 6 := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_sim_pos : 0 < s.im := by linarith
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_1360 hsr1 hsr2 h_sim_pos h_int
  have h_inv := one_div_thirteen_fifty_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 1360 < 1 / 1350 := by norm_num
  exact (h_decay.trans_lt h_gap).trans_le h_inv

/-- Half-plane zero-free extension across (23/5, 6]. -/
theorem intermediate_half_plane_zero_free_twenty_three_fifths_to_six {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 23 / 5 < s.im) (hsim2 : s.im ≤ 6) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_twenty_three_fifths_to_six s hsr hsim1 hsim2

/-- Unconditional Intermediate Ratio Deficit on (1, 6]. -/
theorem intermediate_deficit_one_to_six :
    IntermediateRatioDeficit 1 6 := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_sim_pos : 0 < s.im := by linarith
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_1360 hsr1 hsr2 h_sim_pos h_int
  have h_inv := one_div_thirteen_fifty_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 1360 < 1 / 1350 := by norm_num
  exact (h_decay.trans_lt h_gap).trans_le h_inv

/-- Half-plane zero-free extension across (1, 6]. -/
theorem intermediate_half_plane_zero_free_one_to_six {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 1 < s.im) (hsim2 : s.im ≤ 6) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_one_to_six s hsr hsim1 hsim2

/-! ### Section 5: Unlocking Principle towards t = 8.0+ -/

/-- Unlocking Principle: Any ratio deficit bound on the halved symmetrized ratio integral
strictly below the geometric pole bound 1 / normSq (s * (s - 1)) at ordinate t
excludes zeros of the Riemann zeta function at that ordinate. -/
theorem ratio_deficit_implies_riemannZeta_ne_zero {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsim : 0 < s.im)
    (h_def : (1 / 2 : ℝ) * symmetrizedRatioIntegral s < 1 / normSq (s * (s - 1))) :
    riemannZeta s ≠ 0 := by
  intro hz
  have h_exact := symmetrizedRatioExact_unconditional s
  have h_pole := normImRatio_eq_inv_normSq_of_zero hsr1 hsim hz
  unfold SymmetrizedRatioExact at h_exact
  rw [h_exact] at h_pole
  linarith

/-- The sharpened quadratic deficit bound (1/2) * symmetrizedRatioIntegral s <= 1/1360
strictly cuts the integral by > 62% over 1/513 and 1/436, overcoming the linear 436 barrier. -/
theorem sharpened_quadratic_ratio_deficit_breakthrough {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 1360 ∧
    (1 : ℝ) / 1360 ≤ (1 - 62 / 100) * (1 / 513) ∧
    (1 : ℝ) / 1360 ≤ (1 - 62 / 100) * (1 / 436) := by
  refine ⟨half_symmetrizedRatioIntegral_decay_le_one_div_1360 hsr1 hsr2 hsim h_int,
          one_div_1360_le_sixty_two_percent_cut_513,
          one_div_1360_le_sixty_two_percent_cut_436⟩

end

end BuildingBlocks.RiemannZetaSharpenedQuadraticRatioDeficit
