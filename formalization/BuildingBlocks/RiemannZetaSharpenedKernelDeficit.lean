import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.Calculus.Deriv.Basic
import BuildingBlocks.RiemannZetaFrequencyDecayDeficit

/-!
# Module 308: Riemann Zeta Sharpened Kernel Deficit and Frontier Extension to $t = 6.78$

This module establishes the **Sharpened Modifying Kernel Deficit Theorem**, which improves
the pointwise bound on the modifying kernel $f(x)$ from $4 e^{-\pi x}$ to $\frac{19}{9} e^{-\pi x}$
for all $x \ge 1$ by leveraging $1 - e^{-\pi t} \ge 18/19$.

Crucially, the fractional constant $\frac{19}{18}$ combines with the improper integral bound
$\int_1^\infty (x - 1) e^{-\pi x} \, dx \le \frac{1}{171}$ through an exact integer cancellation:
$$\frac{19}{18 \gamma_0} \times \frac{1}{171} = \frac{19}{3078 \gamma_0} = \frac{1}{162 \gamma_0}.$$
Halving this bound establishes the sharpened decay deficit:
$$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{324 \gamma_0} \quad \text{for all } \operatorname{Im}(s) \ge \gamma_0 > 0.$$

By coupling this sharpened decay rate with coordinate norm-squared bounds, we execute
a 4-step bootstrap chain extending the unconditional zero-free ceiling of the Riemann zeta
function on $\operatorname{Re}(s) > 1/2$:
1. **Step 1** ($5.47 \to 6.1$): $\frac{1}{324 \times 5.47} \le \frac{1}{1772} < \frac{1}{1422} \le \frac{1}{|s(s-1)|^2}$
2. **Step 2** ($6.1 \to 6.5$): $\frac{1}{324 \times 6.1} \le \frac{1}{1976} < \frac{1}{1828} \le \frac{1}{|s(s-1)|^2}$
3. **Step 3** ($6.5 \to 6.7$): $\frac{1}{324 \times 6.5} \le \frac{1}{2106} < \frac{1}{2061} \le \frac{1}{|s(s-1)|^2}$
4. **Step 4** ($6.7 \to 6.78$): $\frac{1}{324 \times 6.7} \le \frac{1}{2170} < \frac{1}{2160} \le \frac{1}{|s(s-1)|^2}$

This unconditionally eliminates any possibility of non-trivial zeros off the critical line
throughout the entire region $\operatorname{Re}(s) > 1/2, 0 < \operatorname{Im}(s) \le 6.78$.

## Axiom Status
All declarations depend strictly on standard foundational Lean 4 axioms:
- `propext`
- `Classical.choice`
- `Quot.sound`
No custom axioms or unverified hypotheses are introduced.
-/

open Real Complex Set Filter Topology MeasureTheory
open HurwitzZeta
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

namespace BuildingBlocks.RiemannZetaSharpenedKernelDeficit

noncomputable section

/-! ### Part I: Sharpened Modifying Kernel Bound -/

/-- Sharp geometric denominator lower bound:
$$1 - e^{-\pi t} \ge \frac{18}{19} \quad \text{for } t \ge 1.$$ -/
theorem one_sub_exp_ge_eighteen_nineteenths_of_one_le {t : ℝ} (ht : 1 ≤ t) :
    (18 : ℝ) / 19 ≤ 1 - Real.exp (-Real.pi * t) := by
  have h1 := exp_neg_pi_mul_le_of_one_le ht
  have h2 := exp_neg_pi_le_one_nineteenth
  linarith

/-- Sharpened even kernel bound on $[1, \infty)$:
$$\operatorname{evenKernel}(0, t) - 1 \le \frac{19}{9} e^{-\pi t}.$$ -/
theorem evenKernel_sub_one_le_nineteen_ninths_exp {t : ℝ} (ht : 1 ≤ t) :
    evenKernel 0 t - 1 ≤ (19 / 9 : ℝ) * Real.exp (-Real.pi * t) := by
  have ht_pos : 0 < t := zero_lt_one.trans_le ht
  have h_geom := evenKernel_sub_one_le_geom ht_pos
  have h_denom : (18 : ℝ) / 19 ≤ 1 - Real.exp (-Real.pi * t) :=
    one_sub_exp_ge_eighteen_nineteenths_of_one_le ht
  have h_denom_pos : 0 < 1 - Real.exp (-Real.pi * t) := by
    have : 0 < (18 : ℝ) / 19 := by norm_num
    linarith
  have h_div : 2 * Real.exp (-Real.pi * t) / (1 - Real.exp (-Real.pi * t)) ≤
      2 * Real.exp (-Real.pi * t) / (18 / 19) := by
    apply div_le_div_of_nonneg_left
    · exact mul_nonneg two_pos.le (Real.exp_pos _).le
    · norm_num
    · exact h_denom
  have h_alg : 2 * Real.exp (-Real.pi * t) / (18 / 19) = (19 / 9 : ℝ) * Real.exp (-Real.pi * t) := by
    ring
  rw [h_alg] at h_div
  exact h_geom.trans h_div

/-- Sharpened modifying kernel bound on $[1, \infty)$:
$$f(x) \le \frac{19}{9} e^{-\pi x}.$$ -/
theorem real_f_modif_le_nineteen_ninths_exp {x : ℝ} (hx : 1 ≤ x) :
    real_f_modif x ≤ (19 / 9 : ℝ) * Real.exp (-Real.pi * x) := by
  rcases eq_or_lt_of_le hx with rfl | h_gt
  · rw [real_f_modif_one]
    exact mul_nonneg (by norm_num) (Real.exp_pos _).le
  · unfold real_f_modif
    have h1 : x ∈ Set.Ioi (1 : ℝ) := h_gt
    have h2 : x ∉ Set.Ioo (0 : ℝ) 1 := fun h => not_le_of_gt h_gt (Set.mem_Ioo.mp h).2.le
    rw [Set.indicator_of_mem h1, Set.indicator_of_notMem h2, add_zero]
    exact evenKernel_sub_one_le_nineteen_ninths_exp hx

/-! ### Part II: Sharpened Decay Deficit -/

/-- Refined pointwise Mellin ratio decay majorization:
$$\frac{\operatorname{mellinTrigIntegrandIm}(s, x)}{(2\operatorname{Re}(s) - 1)\operatorname{Im}(s)} \le \frac{19}{18 \gamma_0} (x - 1) e^{-\pi x}.$$ -/
theorem mellin_ratio_integrand_decay_le_nineteen_eighteenths {s : ℂ} {γ0 x : ℝ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1)
    (hγ0 : 0 < γ0) (hγ : γ0 ≤ s.im) (hx : 1 ≤ x) :
    mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im) ≤
      (19 / (18 * γ0)) * ((x - 1) * Real.exp (-Real.pi * x)) := by
  have hx_pos : 0 < x := by linarith
  have h_kernel_im : (cpowTrigKernel s x).im = powerDiff s.re x * Real.sin ((s.im / 2) * Real.log x) :=
    cpowTrigKernel_im_eq_powerDiff_mul_sin hx_pos
  have h_bound := product_ratio_decay_bound hx hsr1 hsr2 hγ0 hγ
  have h_f := real_f_modif_le_nineteen_ninths_exp hx
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
  have h_alg : ((1 / (2 * γ0)) * (x - 1)) * ((19 / 9 : ℝ) * Real.exp (-Real.pi * x)) =
      (19 / (18 * γ0)) * ((x - 1) * Real.exp (-Real.pi * x)) := by ring
  rw [h_alg] at h_prod
  exact h_prod

/-- Symmetrized ratio integral refined decay theorem:
$$\operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{162 \gamma_0}.$$ -/
theorem symmetrizedRatioIntegral_decay_le_one_div_162_gamma0 {s : ℂ} {γ0 : ℝ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hγ0 : 0 < γ0) (hγ : γ0 ≤ s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    symmetrizedRatioIntegral s ≤ 1 / (162 * γ0) := by
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
  have h_eval := integral_sub_one_mul_exp_neg_pi_le_one_div_171
  have h_scale : (19 / (18 * γ0)) * (∫ x in Ioi (1 : ℝ), (x - 1) * Real.exp (-Real.pi * x)) ≤
      (19 / (18 * γ0)) * (1 / 171) :=
    mul_le_mul_of_nonneg_left h_eval (by positivity)
  have h_alg : (19 / (18 * γ0)) * (1 / 171) = 1 / (162 * γ0) := by
    calc (19 / (18 * γ0)) * (1 / 171)
      _ = (19 * 1) / ((18 * γ0) * 171) := by ring
      _ = 19 / (3078 * γ0) := by ring
      _ = (19 * 1) / (19 * (162 * γ0)) := by ring
      _ = 1 / (162 * γ0) := by
        rw [mul_div_mul_left (1 : ℝ) (162 * γ0) (by norm_num : (19 : ℝ) ≠ 0)]
  rw [h_alg] at h_scale
  exact (h_mono.trans h_scale)

/-- Halved symmetrized ratio integral refined decay bound:
$$\frac{1}{2} \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{324 \gamma_0}.$$ -/
theorem half_symmetrizedRatioIntegral_decay_le_one_div_324_gamma0 {s : ℂ} {γ0 : ℝ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1) (hγ0 : 0 < γ0) (hγ : γ0 ≤ s.im)
    (h_int : IntegrableOn (fun x => mellinTrigIntegrandIm s x / ((2 * s.re - 1) * s.im)) (Ioi 1)) :
    (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / (324 * γ0) := by
  have h := symmetrizedRatioIntegral_decay_le_one_div_162_gamma0 hsr1 hsr2 hγ0 hγ h_int
  have h_half : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ (1 / 2 : ℝ) * (1 / (162 * γ0)) :=
    mul_le_mul_of_nonneg_left h (by norm_num)
  have h_alg : (1 / 2 : ℝ) * (1 / (162 * γ0)) = 1 / (324 * γ0) := by ring
  rw [h_alg] at h_half
  exact h_half

/-! ### Part III: Bootstrap Step 1 ($5.47 \to 6.1$) -/

/-- Polynomial remainder bound for coordinate norm-squared up to $y \le 3721/100$ ($t \le 6.1$). -/
theorem normSq_coords_le_one_thousand_four_hundred_twenty_two {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 3721 / 100) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 1422 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 1422 := by
    have h1 : y^2 ≤ (3721 / 100 : ℝ)^2 := by nlinarith
    have h2 : (3721 / 100 : ℝ)^2 = 13845841 / 10000 := by norm_num
    have h3 : (3721 / 100 : ℝ) = 372100 / 10000 := by norm_num
    linarith
  linarith

/-- Bound on normSq $(s * (s - 1)) \le 1422$ for $\operatorname{Im}(s) \le 61/10 = 6.1$. -/
theorem normSq_mul_sub_one_le_one_thousand_four_hundred_twenty_two {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 61 / 10) :
    normSq (s * (s - 1)) ≤ 1422 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 3721 / 100 := by
    have : s.im^2 ≤ (61 / 10 : ℝ)^2 := by nlinarith
    have : (61 / 10 : ℝ)^2 = 3721 / 100 := by norm_num
    linarith
  exact normSq_coords_le_one_thousand_four_hundred_twenty_two hsr1 hsr2 hy1 hy2

/-- Lower bound on the inverse norm-squared for $\operatorname{Im}(s) \le 61/10$:
$$\frac{1}{1422} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_div_one_thousand_four_hundred_twenty_two_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 61 / 10) :
    (1 : ℝ) / 1422 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_one_thousand_four_hundred_twenty_two hsr1 hsr2 hsim1 hsim2
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

/-- Unconditional Intermediate Ratio Deficit on $(547/100, 61/10]$:
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{324 \times (547/100)} \le \frac{1}{1772} < \frac{1}{1422} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_five_forty_seven_to_six_and_one_tenth :
    IntermediateRatioDeficit (547 / 100) (61 / 10) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_324_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (324 * (547 / 100 : ℝ)) ≤ (1 : ℝ) / 1772 := by
    have h1 : (1772 : ℝ) ≤ 324 * (547 / 100) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 1772 :=
    h_decay.trans h_dec_le
  have h_inv := one_div_one_thousand_four_hundred_twenty_two_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 1772 < 1 / 1422 := by norm_num
  linarith

/-- Unconditional zero-freeness on the strip segment $(1/2, 1] \times (547/100, 61/10]$. -/
theorem intermediate_strip_zero_free_five_forty_seven_to_six_and_one_tenth {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 547 / 100 < s.im) (hsim2 : s.im ≤ 61 / 10) :
    riemannZeta s ≠ 0 :=
  intermediate_strip_zero_free_of_deficit (by norm_num)
    intermediate_deficit_five_forty_seven_to_six_and_one_tenth
    s hsr1 hsr2 hsim1 hsim2

/-- Unconditional zero-freeness on the half-plane $\operatorname{Re}(s) > 1/2$ for frequencies $547/100 < \operatorname{Im}(s) \le 61/10$. -/
theorem intermediate_half_plane_zero_free_five_forty_seven_to_six_and_one_tenth {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 547 / 100 < s.im) (hsim2 : s.im ≤ 61 / 10) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_five_forty_seven_to_six_and_one_tenth
    s hsr hsim1 hsim2

/-! ### Part IV: Bootstrap Step 2 ($6.1 \to 6.5$) -/

/-- Polynomial remainder bound for coordinate norm-squared up to $y \le 169/4$ ($t \le 6.5$). -/
theorem normSq_coords_le_one_thousand_eight_hundred_twenty_eight {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 169 / 4) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 1828 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 1828 := by
    have h1 : y^2 ≤ (169 / 4 : ℝ)^2 := by nlinarith
    have h2 : (169 / 4 : ℝ)^2 = 28561 / 16 := by norm_num
    have h3 : (169 / 4 : ℝ) = 676 / 16 := by norm_num
    linarith
  linarith

/-- Bound on normSq $(s * (s - 1)) \le 1828$ for $\operatorname{Im}(s) \le 13/2 = 6.5$. -/
theorem normSq_mul_sub_one_le_one_thousand_eight_hundred_twenty_eight {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 13 / 2) :
    normSq (s * (s - 1)) ≤ 1828 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 169 / 4 := by
    have : s.im^2 ≤ (13 / 2 : ℝ)^2 := by nlinarith
    have : (13 / 2 : ℝ)^2 = 169 / 4 := by norm_num
    linarith
  exact normSq_coords_le_one_thousand_eight_hundred_twenty_eight hsr1 hsr2 hy1 hy2

/-- Lower bound on the inverse norm-squared for $\operatorname{Im}(s) \le 13/2$:
$$\frac{1}{1828} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_div_one_thousand_eight_hundred_twenty_eight_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 13 / 2) :
    (1 : ℝ) / 1828 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_one_thousand_eight_hundred_twenty_eight hsr1 hsr2 hsim1 hsim2
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

/-- Unconditional Intermediate Ratio Deficit on $(61/10, 13/2]$:
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{324 \times (61/10)} \le \frac{1}{1976} < \frac{1}{1828} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_six_and_one_tenth_to_six_and_one_half :
    IntermediateRatioDeficit (61 / 10) (13 / 2) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_324_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (324 * (61 / 10 : ℝ)) ≤ (1 : ℝ) / 1976 := by
    have h1 : (1976 : ℝ) ≤ 324 * (61 / 10) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 1976 :=
    h_decay.trans h_dec_le
  have h_inv := one_div_one_thousand_eight_hundred_twenty_eight_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 1976 < 1 / 1828 := by norm_num
  linarith

/-- Unconditional zero-freeness on the strip segment $(1/2, 1] \times (61/10, 13/2]$. -/
theorem intermediate_strip_zero_free_six_and_one_tenth_to_six_and_one_half {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 61 / 10 < s.im) (hsim2 : s.im ≤ 13 / 2) :
    riemannZeta s ≠ 0 :=
  intermediate_strip_zero_free_of_deficit (by norm_num)
    intermediate_deficit_six_and_one_tenth_to_six_and_one_half
    s hsr1 hsr2 hsim1 hsim2

/-- Unconditional zero-freeness on the half-plane $\operatorname{Re}(s) > 1/2$ for frequencies $61/10 < \operatorname{Im}(s) \le 13/2$. -/
theorem intermediate_half_plane_zero_free_six_and_one_tenth_to_six_and_one_half {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 61 / 10 < s.im) (hsim2 : s.im ≤ 13 / 2) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_six_and_one_tenth_to_six_and_one_half
    s hsr hsim1 hsim2

/-! ### Part V: Bootstrap Step 3 ($6.5 \to 6.7$) -/

/-- Polynomial remainder bound for coordinate norm-squared up to $y \le 4489/100$ ($t \le 6.7$). -/
theorem normSq_coords_le_two_thousand_sixty_one {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 4489 / 100) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 2061 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 2061 := by
    have h1 : y^2 ≤ (4489 / 100 : ℝ)^2 := by nlinarith
    have h2 : (4489 / 100 : ℝ)^2 = 20151121 / 10000 := by norm_num
    have h3 : (4489 / 100 : ℝ) = 448900 / 10000 := by norm_num
    linarith
  linarith

/-- Bound on normSq $(s * (s - 1)) \le 2061$ for $\operatorname{Im}(s) \le 67/10 = 6.7$. -/
theorem normSq_mul_sub_one_le_two_thousand_sixty_one {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 67 / 10) :
    normSq (s * (s - 1)) ≤ 2061 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 4489 / 100 := by
    have : s.im^2 ≤ (67 / 10 : ℝ)^2 := by nlinarith
    have : (67 / 10 : ℝ)^2 = 4489 / 100 := by norm_num
    linarith
  exact normSq_coords_le_two_thousand_sixty_one hsr1 hsr2 hy1 hy2

/-- Lower bound on the inverse norm-squared for $\operatorname{Im}(s) \le 67/10$:
$$\frac{1}{2061} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_div_two_thousand_sixty_one_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 67 / 10) :
    (1 : ℝ) / 2061 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_two_thousand_sixty_one hsr1 hsr2 hsim1 hsim2
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

/-- Unconditional Intermediate Ratio Deficit on $(13/2, 67/10]$:
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{324 \times (13/2)} \le \frac{1}{2106} < \frac{1}{2061} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_six_and_one_half_to_six_and_seven_tenths :
    IntermediateRatioDeficit (13 / 2) (67 / 10) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_324_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (324 * (13 / 2 : ℝ)) ≤ (1 : ℝ) / 2106 := by
    have h1 : (2106 : ℝ) ≤ 324 * (13 / 2) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 2106 :=
    h_decay.trans h_dec_le
  have h_inv := one_div_two_thousand_sixty_one_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 2106 < 1 / 2061 := by norm_num
  linarith

/-- Unconditional zero-freeness on the strip segment $(1/2, 1] \times (13/2, 67/10]$. -/
theorem intermediate_strip_zero_free_six_and_one_half_to_six_and_seven_tenths {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 13 / 2 < s.im) (hsim2 : s.im ≤ 67 / 10) :
    riemannZeta s ≠ 0 :=
  intermediate_strip_zero_free_of_deficit (by norm_num)
    intermediate_deficit_six_and_one_half_to_six_and_seven_tenths
    s hsr1 hsr2 hsim1 hsim2

/-- Unconditional zero-freeness on the half-plane $\operatorname{Re}(s) > 1/2$ for frequencies $13/2 < \operatorname{Im}(s) \le 67/10$. -/
theorem intermediate_half_plane_zero_free_six_and_one_half_to_six_and_seven_tenths {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 13 / 2 < s.im) (hsim2 : s.im ≤ 67 / 10) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_six_and_one_half_to_six_and_seven_tenths
    s hsr hsim1 hsim2

/-! ### Part VI: Bootstrap Step 4 ($6.7 \to 6.78$) -/

/-- Polynomial remainder bound for coordinate norm-squared up to $y \le 114921/2500$ ($t \le 6.78$). -/
theorem normSq_coords_le_two_thousand_one_hundred_sixty {x y : ℝ}
    (hx1 : 1 / 2 ≤ x) (hx2 : x ≤ 1) (hy1 : 1 / 4 ≤ y) (hy2 : y ≤ 114921 / 2500) :
    (x^2 + y) * ((x - 1)^2 + y) ≤ 2160 := by
  have h_id := normSq_polynomial_identity x y
  have h_rem := remainder_nonpos hx1 hx2 hy1
  have h_poly : y^2 + y ≤ 2160 := by
    have h1 : y^2 ≤ (114921 / 2500 : ℝ)^2 := by nlinarith
    have h2 : (114921 / 2500 : ℝ)^2 = 13206836241 / 6250000 := by norm_num
    have h3 : (114921 / 2500 : ℝ) = 287302500 / 6250000 := by norm_num
    linarith
  linarith

/-- Bound on normSq $(s * (s - 1)) \le 2160$ for $\operatorname{Im}(s) \le 339/50 = 6.78$. -/
theorem normSq_mul_sub_one_le_two_thousand_one_hundred_sixty {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 339 / 50) :
    normSq (s * (s - 1)) ≤ 2160 := by
  rw [normSq_mul_sub_one_eq_coords]
  have hy1 : 1 / 4 ≤ s.im ^ 2 := by
    have : (1 / 2 : ℝ)^2 ≤ s.im^2 := by nlinarith
    linarith
  have hy2 : s.im ^ 2 ≤ 114921 / 2500 := by
    have : s.im^2 ≤ (339 / 50 : ℝ)^2 := by nlinarith
    have : (339 / 50 : ℝ)^2 = 114921 / 2500 := by norm_num
    linarith
  exact normSq_coords_le_two_thousand_one_hundred_sixty hsr1 hsr2 hy1 hy2

/-- Lower bound on the inverse norm-squared for $\operatorname{Im}(s) \le 339/50$:
$$\frac{1}{2160} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem one_div_two_thousand_one_hundred_sixty_le_inv_normSq {s : ℂ}
    (hsr1 : 1 / 2 ≤ s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 1 / 2 ≤ s.im) (hsim2 : s.im ≤ 339 / 50) :
    (1 : ℝ) / 2160 ≤ 1 / normSq (s * (s - 1)) := by
  have h_le := normSq_mul_sub_one_le_two_thousand_one_hundred_sixty hsr1 hsr2 hsim1 hsim2
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

/-- Unconditional Intermediate Ratio Deficit on $(67/10, 339/50]$:
$$(1/2) \cdot \operatorname{symmetrizedRatioIntegral}(s) \le \frac{1}{324 \times (67/10)} \le \frac{1}{2170} < \frac{1}{2160} \le \frac{1}{|s(s-1)|^2}.$$ -/
theorem intermediate_deficit_six_and_seven_tenths_to_six_and_seventy_eight_hundredths :
    IntermediateRatioDeficit (67 / 10) (339 / 50) := by
  intro s hsr1 hsr2 hsim1 hsim2
  have h_int := integrableOn_mellin_ratio_integrand_coords s
  have h_decay := half_symmetrizedRatioIntegral_decay_le_one_div_324_gamma0
    hsr1 hsr2 (by norm_num) (le_of_lt hsim1) h_int
  have h_dec_le : 1 / (324 * (67 / 10 : ℝ)) ≤ (1 : ℝ) / 2170 := by
    have h1 : (2170 : ℝ) ≤ 324 * (67 / 10) := by norm_num
    exact one_div_le_one_div_of_le (by norm_num) h1
  have h_ratio_le : (1 / 2 : ℝ) * symmetrizedRatioIntegral s ≤ 1 / 2170 :=
    h_decay.trans h_dec_le
  have h_inv := one_div_two_thousand_one_hundred_sixty_le_inv_normSq
    (le_of_lt hsr1) hsr2 (by linarith) hsim2
  have h_gap : (1 : ℝ) / 2170 < 1 / 2160 := by norm_num
  linarith

/-- Unconditional zero-freeness on the strip segment $(1/2, 1] \times (67/10, 339/50]$. -/
theorem intermediate_strip_zero_free_six_and_seven_tenths_to_six_and_seventy_eight_hundredths {s : ℂ}
    (hsr1 : 1 / 2 < s.re) (hsr2 : s.re ≤ 1)
    (hsim1 : 67 / 10 < s.im) (hsim2 : s.im ≤ 339 / 50) :
    riemannZeta s ≠ 0 :=
  intermediate_strip_zero_free_of_deficit (by norm_num)
    intermediate_deficit_six_and_seven_tenths_to_six_and_seventy_eight_hundredths
    s hsr1 hsr2 hsim1 hsim2

/-- Unconditional zero-freeness on the half-plane $\operatorname{Re}(s) > 1/2$ for frequencies $67/10 < \operatorname{Im}(s) \le 339/50$. -/
theorem intermediate_half_plane_zero_free_six_and_seven_tenths_to_six_and_seventy_eight_hundredths {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 67 / 10 < s.im) (hsim2 : s.im ≤ 339 / 50) :
    riemannZeta s ≠ 0 :=
  intermediate_half_plane_zero_free_of_deficit (by norm_num)
    intermediate_deficit_six_and_seven_tenths_to_six_and_seventy_eight_hundredths
    s hsr hsim1 hsim2

/-! ### Part VII: Cumulative Zero-Free Extension to $t = 6.78$ -/

/-- Master Cumulative Zero-Free Theorem up to $t = 6.78$:
Unconditionally proves that `riemannZeta s ≠ 0` for all `Re(s) > 1/2` and `0 < Im(s) ≤ 6.78`. -/
theorem cumulative_zero_free_to_six_and_seventy_eight_hundredths {s : ℂ}
    (hsr : 1 / 2 < s.re) (hsim1 : 0 < s.im) (hsim2 : s.im ≤ 339 / 50) :
    riemannZeta s ≠ 0 := by
  by_cases h1 : s.im ≤ 547 / 100
  · exact cumulative_zero_free_to_five_hundred_forty_seven_hundredths hsr hsim1 h1
  push_neg at h1
  by_cases h2 : s.im ≤ 61 / 10
  · exact intermediate_half_plane_zero_free_five_forty_seven_to_six_and_one_tenth hsr h1 h2
  push_neg at h2
  by_cases h3 : s.im ≤ 13 / 2
  · exact intermediate_half_plane_zero_free_six_and_one_tenth_to_six_and_one_half hsr h2 h3
  push_neg at h3
  by_cases h4 : s.im ≤ 67 / 10
  · exact intermediate_half_plane_zero_free_six_and_one_half_to_six_and_seven_tenths hsr h3 h4
  push_neg at h4
  exact intermediate_half_plane_zero_free_six_and_seven_tenths_to_six_and_seventy_eight_hundredths hsr h4 hsim2

/-! ### Part VIII: Axiom Audits -/

#print axioms one_sub_exp_ge_eighteen_nineteenths_of_one_le
#print axioms evenKernel_sub_one_le_nineteen_ninths_exp
#print axioms real_f_modif_le_nineteen_ninths_exp
#print axioms mellin_ratio_integrand_decay_le_nineteen_eighteenths
#print axioms symmetrizedRatioIntegral_decay_le_one_div_162_gamma0
#print axioms half_symmetrizedRatioIntegral_decay_le_one_div_324_gamma0
#print axioms intermediate_deficit_five_forty_seven_to_six_and_one_tenth
#print axioms intermediate_deficit_six_and_one_tenth_to_six_and_one_half
#print axioms intermediate_deficit_six_and_one_half_to_six_and_seven_tenths
#print axioms intermediate_deficit_six_and_seven_tenths_to_six_and_seventy_eight_hundredths
#print axioms cumulative_zero_free_to_six_and_seventy_eight_hundredths

end

end BuildingBlocks.RiemannZetaSharpenedKernelDeficit
