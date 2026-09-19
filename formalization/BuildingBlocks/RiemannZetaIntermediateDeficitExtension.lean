import Mathlib
import BuildingBlocks.RiemannZetaThresholdSynthesis
import BuildingBlocks.RiemannZetaIntermediateZeroFree
import BuildingBlocks.RiemannZetaLowIntermediateDeficit
import BuildingBlocks.RiemannZetaMellinIntegralEvaluation
import BuildingBlocks.RiemannZetaMellinIntegralDomination
import BuildingBlocks.RiemannZetaKernelEnergyBound
import BuildingBlocks.RiemannZetaTrigonometricDecomposition
import BuildingBlocks.RiemannZetaPhaseContradiction
import BuildingBlocks.RiemannZetaModularMellinInversion
import BuildingBlocks.RiemannZetaOffLineZeroLocalization
import BuildingBlocks.RiemannZetaUnconditionalLowFrequency

/-!
# RiemannZetaIntermediateDeficitExtension

This module formalizes **Module 306**: extending the machine-verified, unconditional
discharge of the intermediate frequency band from $t = 1.9$ up to $t = 23/5 = 4.6$
for the Riemann zeta function.

## Core Advancements

1. **Sharp Archimedean Exponential Bounding**:
   - `exp_neg_pi_le_one_nineteenth`: Proves $\exp(-\pi) \le 1/19$ using only foundational
     estimates $\exp(1) \ge 27/10$ and $\pi \ge 3$, yielding $(\exp 1)^3 \ge 19.683 > 19$.

2. **Refined Closed-Form Area Evaluation**:
   - `integral_sub_one_sq_mul_exp_neg_pi_le_two_div_513`: Proves
     $$\int_1^\infty (x - 1)^2 e^{-\pi x} \, dx = \frac{2 e^{-\pi}}{\pi^3} \le \frac{2}{513}.$$
   - `half_symmetrizedRatioIntegral_le_one_div_513`: Bounds the halved symmetrized ratio integral
     strictly by $1/513 \approx 0.001949$.

3. **Coordinate Geometry of the Inverse Pole up to $t = 4.6$**:
   - `normSq_coords_le_five_hundred_six`: For $x \in [1/2, 1]$ and $y \le 22$ (covering $t^2 \le (23/5)^2 = 21.16$),
     the norm-square $|s(s-1)|^2$ is majorized by $y^2 + y \le 506$.
   - `one_div_five_hundred_six_le_inv_normSq`: Establishes $\frac{1}{506} \le \frac{1}{|s(s-1)|^2}$.

4. **Unconditional Deficit Gap and Zero-Freeness up to $t = 4.6$**:
   - `intermediate_deficit_one_to_twenty_three_fifths`: Proves `IntermediateRatioDeficit 1 (23 / 5)`.
     The arithmetic gap $\frac{1}{506} - \frac{1}{513} = \frac{7}{259578} > 0$ strictly excludes
     all zeros.
   - `cumulative_zero_free_to_twenty_three_fifths`: Unconditionally proves $\zeta(s) \ne 0$
     for all $\operatorname{Re}(s) > 1/2$ and $0 < \operatorname{Im}(s) \le 23/5 = 4.6$.

## Axiom Status
All declarations in this module depend strictly on standard foundational Lean 4 axioms:
- `propext`
- `Classical.choice`
- `Quot.sound`
No ad hoc axioms or unproven hypotheses are introduced.
-/

open Real Complex MeasureTheory Set Filter Topology
open BuildingBlocks.RiemannZetaThresholdSynthesis
open BuildingBlocks.RiemannZetaIntermediateZeroFree
open BuildingBlocks.RiemannZetaLowIntermediateDeficit
open BuildingBlocks.RiemannZetaMellinIntegralEvaluation
open BuildingBlocks.RiemannZetaMellinIntegralDomination
open BuildingBlocks.RiemannZetaKernelEnergyBound
open BuildingBlocks.RiemannZetaTrigonometricDecomposition
open BuildingBlocks.RiemannZetaPhaseContradiction
open BuildingBlocks.RiemannZetaModularMellinInversion
open BuildingBlocks.RiemannZetaOffLineZeroLocalization
open BuildingBlocks.RiemannZetaUnconditionalLowFrequency

namespace BuildingBlocks.RiemannZetaIntermediateDeficitExtension

/-! ### Subsection 1: Sharp Archimedean Exponential Bounds -/

/-- Sharp lower bound $\exp(\pi) \ge 19$, implying $\exp(-\pi) \le 1/19$.
Deduced from $\exp(1) \ge 27/10$ and $\pi \ge 3$. -/
theorem exp_neg_pi_le_one_nineteenth : Real.exp (-Real.pi) ≤ 1 / 19 := by
  have h_exp1 : (27 / 10 : ℝ) ≤ Real.exp 1 := by linarith [Real.exp_one_gt_d9]
  have h_exp3 : (19 : ℝ) ≤ Real.exp 3 := by
    have h_pow : (27 / 10 : ℝ)^3 ≤ (Real.exp 1)^3 := pow_le_pow_left₀ (by norm_num) h_exp1 3
    rw [← Real.exp_nat_mul] at h_pow
    have h_num : (19 : ℝ) ≤ (27 / 10 : ℝ)^3 := by norm_num
    linarith
  have h_pi_ge_3 : 3 ≤ Real.pi := by linarith [Real.pi_gt_three]
  have h_exp_pi : (19 : ℝ) ≤ Real.exp Real.pi := by
    have : Real.exp 3 ≤ Real.exp Real.pi := Real.exp_le_exp.mpr h_pi_ge_3
    linarith
  have h_pos : 0 < Real.exp Real.pi := Real.exp_pos _
  have h_inv : (Real.exp Real.pi)⁻¹ ≤ (19 : ℝ)⁻¹ := (inv_le_inv₀ h_pos (by norm_num)).mpr h_exp_pi
  rw [← Real.exp_neg, ← one_div] at h_inv
  exact h_inv

/-- Sharp closed-form integral bound on the quadratic-exponential majorant:
$$\int_1^\infty (x - 1)^2 e^{-\pi x} \, dx = \frac{2 e^{-\pi}}{\pi^3} \le \frac{2}{513}.$$ -/
theorem integral_sub_one_sq_mul_exp_neg_pi_le_two_div_513 :
    ∫ x in Ioi (1 : ℝ), (x - 1)^2 * Real.exp (-Real.pi * x) ≤ 2 / 513 := by
  rw [integral_sub_one_sq_mul_exp_neg_pi]
  have h_num : Real.exp (-Real.pi) ≤ 1 / 19 := exp_neg_pi_le_one_nineteenth
  have h_pi : 3 ≤ Real.pi := by linarith [Real.pi_gt_three]
  have h_pi3 : 27 ≤ Real.pi^3 := by
    have h_pow : (3 : ℝ)^3 ≤ Real.pi^3 := pow_le_pow_left₀ (by norm_num) h_pi 3
    have : (3 : ℝ)^3 = 27 := by norm_num
    rwa [this] at h_pow
  have h_top : 2 * Real.exp (-Real.pi) ≤ 2 / 19 := by linarith
  have h1 : (2 * Real.exp (-Real.pi)) / Real.pi^3 ≤ (2 / 19) / Real.pi^3 :=
    div_le_div_of_nonneg_right h_top (by positivity)
  have h2 : (2 / 19) / Real.pi^3 ≤ (2 : ℝ) / 19 / 27 :=
    div_le_div_of_nonneg_left (by norm_num) (by norm_num) h_pi3
  have h3 : (2 : ℝ) / 19 / 27 = 2 / 513 := by norm_num
  linarith

/-! ### Subsection 2: Symmetrized Ratio Integral Refinements -/

/-- Pointwise majorization of the symmetrized ratio integral by $2/513$. -/
theorem symmetrizedRatioIntegral_le_two_div_513 {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    symmetrizedRatioIntegral s ≤ 2 / 513 := by
  have h1 := symmetrizedRatioIntegral_le_majorant hsr1 hsr2 hsim h_int
  exact h1.trans integral_sub_one_sq_mul_exp_neg_pi_le_two_div_513

/-- The halved symmetrized ratio integral is bounded by $1/513$. -/
theorem half_symmetrizedRatioIntegral_le_one_div_513 {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hsim : 0 < s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 513 := by
  have h1 := symmetrizedRatioIntegral_le_two_div_513 hsr1 hsr2 hsim h_int
  linarith

/-! ### Subsection 3: Coordinate Norm-Squared Bounds up to $t = 4.6$ -/

/-- Coordinate product bound for $y \le 22$: $(x^2 + y)((x - 1)^2 + y) \le 506$. -/
lemma normSq_coords_le_five_hundred_six {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 22) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 506 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 506 := by nlinarith
  linarith

/-- Bound on normSq $(s * (s - 1)) \le 506$ for $\operatorname{Im}(s) \le 23/5 = 4.6$. -/
theorem normSq_mul_sub_one_le_five_hundred_six {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 23 / 5) :
    normSq (s * (s - 1)) ≤ 506 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 22 := by
    have : s.im^2 ≤ (23 / 5 : ℝ)^2 := by nlinarith
    have : (23 / 5 : ℝ)^2 = 529 / 25 := by norm_num
    have : (529 / 25 : ℝ) ≤ 22 := by norm_num
    linarith
  exact normSq_coords_le_five_hundred_six hsr1 hsr2 hy1 hy2

/-- Lower bound on the inverse norm-squared:
$$\frac{1}{506} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_div_five_hundred_six_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 23 / 5) :
    (1 : ℝ) / 506 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_five_hundred_six hsr1 hsr2 hsim1 hsim2
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
  have h506 : 0 < (506 : ℝ) := by norm_num
  exact one_div_le_one_div_of_le h_pos h_le

/-! ### Subsection 4: Deficit Property and Zero-Freeness to $t = 4.6$ -/

/-- Unconditional Intermediate Ratio Deficit on $(1, 23/5]$:
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le 1/513 < 1/506 \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_one_to_twenty_three_fifths :
    IntermediateRatioDeficit 1 (23 / 5) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_513 := half_symmetrizedRatioIntegral_le_one_div_513 hsr1 hsr2 (by linarith) h_int
  have h_inv := one_div_five_hundred_six_le_inv_normSq (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 513 < 1 / 506 := by norm_num
  linarith

/-- Unconditional zero-freeness on the strip segment $(1/2, 1] \times (1, 23/5]$. -/
theorem intermediate_strip_zero_free_one_to_twenty_three_fifths {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 < s.im) (hsim2 : s.im ≤ 23 / 5) :
    riemannZeta s ≠ 0 :=
  intermediate_strip_zero_free_of_deficit (by norm_num) intermediate_deficit_one_to_twenty_three_fifths
    s hsr1 hsr2 hsim1 hsim2

/-- Unconditional zero-freeness on the half-plane $\operatorname{Re}(s) > 1/2$ for frequencies $1 < \operatorname{Im}(s) \le 23/5$. -/
theorem intermediate_half_plane_zero_free_one_to_twenty_three_fifths {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 1 < s.im) (hsim2 : s.im ≤ 23 / 5) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num) intermediate_deficit_one_to_twenty_three_fifths
    s hsr hsim1 hsim2

/-- Unconditional cumulative zero-freeness on the half-plane $\operatorname{Re}(s) > 1/2$
for all frequencies $0 < \operatorname{Im}(s) \le 23/5 = 4.6$, unifying the entire region $[0, 4.6]$. -/
theorem cumulative_zero_free_to_twenty_three_fifths {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim_pos : 0 < s.im) (hsim_le : s.im ≤ 23 / 5) :
    riemannZeta s ≠ 0 := by
  by_cases h1 : s.im ≤ 1
  · rcases le_or_gt s.re 1 with h_le | h_gt
    · exact low_freq_free_unconditional hsr h_le hsim_pos h1
    · exact riemannZeta_ne_zero_of_one_lt_re h_gt
  · have h1_lt : 1 < s.im := not_le.mp h1
    exact intermediate_half_plane_zero_free_one_to_twenty_three_fifths hsr h1_lt hsim_le

end BuildingBlocks.RiemannZetaIntermediateDeficitExtension

open BuildingBlocks.RiemannZetaIntermediateDeficitExtension

#print axioms exp_neg_pi_le_one_nineteenth
#print axioms integral_sub_one_sq_mul_exp_neg_pi_le_two_div_513
#print axioms symmetrizedRatioIntegral_le_two_div_513
#print axioms half_symmetrizedRatioIntegral_le_one_div_513
#print axioms normSq_coords_le_five_hundred_six
#print axioms normSq_mul_sub_one_le_five_hundred_six
#print axioms one_div_five_hundred_six_le_inv_normSq
#print axioms intermediate_deficit_one_to_twenty_three_fifths
#print axioms intermediate_strip_zero_free_one_to_twenty_three_fifths
#print axioms intermediate_half_plane_zero_free_one_to_twenty_three_fifths
#print axioms cumulative_zero_free_to_twenty_three_fifths
