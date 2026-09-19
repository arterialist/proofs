/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import Mathlib.Analysis.Complex.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.Scope
import BuildingBlocks.RiemannZetaGlobalSchwarzReflection
import BuildingBlocks.RiemannZetaKernelPositivity
import BuildingBlocks.RiemannZetaKernelEnergyBound
import BuildingBlocks.RiemannZetaUpperHalfPlaneReduction

/-!
# Module 287: Off-Line Zero Localization and Completed Zeta Decay

This module establishes geometric and analytic constraints on any putative
counterexample to the Riemann Hypothesis in the upper critical strip:
$$\{s \in \mathbb{C} \mid 1/2 < \operatorname{Re}(s) \le 1 \wedge 0 < \operatorname{Im}(s)\}$$

## Key Theorems

1. **Denominator Coordinate Expansion and Positivity**:
   - `normSq_mul_sub_one_eq_coords`: $|s(s-1)|^2 = (s.re^2 + s.im^2)((s.re - 1)^2 + s.im^2)$.
   - `normSq_mul_sub_one_ge_im_four`: $|s(s-1)|^2 \ge s.im^4$.
   - `normSq_mul_sub_one_ge_sq_sq`: $(s.im^2)^2 \le |s(s-1)|^2$.

2. **First Quadrant Localization**:
   - `re_numerator_pos`: $s.im^2 - s.re(s.re - 1) > 0$ for $s.re \in (0, 1]$ and $s.im > 0$.
   - `completedRiemannZeta₀_re_pos_of_zero`: $\operatorname{Re}(\Lambda_0(s)) > 0$ at any strip zero.
   - `completedRiemannZeta₀_mem_first_quadrant_of_zero`: both $\operatorname{Re}(\Lambda_0(s)) > 0$
     and $\operatorname{Im}(\Lambda_0(s)) > 0$, confining $\Lambda_0(s)$ strictly to the first quadrant.

3. **Magnitude Decay and Norm Bounds**:
   - `normSq_completedRiemannZeta₀_eq_of_zero`: $\|\Lambda_0(s)\|^2 = 1 / |s(s-1)|^2$.
   - `normSq_completedRiemannZeta₀_le_of_zero`: $\|\Lambda_0(s)\|^2 \le 1 / s.im^4$.
   - `norm_completedRiemannZeta₀_le_of_zero`: $\|\Lambda_0(s)\| \le 1 / s.im^2$.
   - `re_le_inv_sq_of_zero`: $\operatorname{Re}(\Lambda_0(s)) \le 1 / s.im^2$.
   - `im_le_inv_sq_of_zero`: $\operatorname{Im}(\Lambda_0(s)) \le 1 / s.im^2$.

4. **Algebraic Ratio and Fourth-Power Decay**:
   - `imRatio`: the ratio $\operatorname{Im}(\Lambda_0(s)) / s.im$.
   - `imRatio_eq_of_zero`: algebraic coordinate formulation at a zero.
   - `imRatio_pos_of_zero`: strict positivity $0 < \operatorname{imRatio}(s)$.
   - `imRatio_le_four_power_of_zero`: $\operatorname{imRatio}(s) \le (2 s.re - 1) / s.im^4$.

5. **Imaginary Mellin Envelope and Exponential Majorization**:
   - `powerDiff`: the hyperbolic amplitude $x^{\beta/2 - 1} - x^{(1-\beta)/2 - 1}$.
   - `powerDiff_pos`: strict positivity for $\beta > 1/2$ and $x > 1$.
   - `powerDiff_le_one`: uniform majorization by $1$ for $\beta \le 1$ and $x \ge 1$.
   - `powerDiff_mul_real_f_modif_le_four_exp`: uniform decay bounded by $4 \exp(-\pi x)$.
-/

open Real Complex
open BuildingBlocks.RiemannZetaGlobalSchwarzReflection
open BuildingBlocks.RiemannZetaKernelPositivity
open BuildingBlocks.RiemannZetaKernelEnergyBound
open BuildingBlocks.RiemannZetaUpperHalfPlaneReduction

noncomputable section

namespace BuildingBlocks.RiemannZetaOffLineZeroLocalization

/-! ### Denominator Expansions and Quadratic Coordinates -/

/-- Coordinate expansion of normSq s. -/
theorem normSq_eq (s : ℂ) :
    normSq s = s.re ^ 2 + s.im ^ 2 := by
  rw [normSq_apply]
  ring

/-- Coordinate expansion of normSq (s - 1). -/
theorem normSq_sub_one (s : ℂ) :
    normSq (s - 1) = (s.re - 1) ^ 2 + s.im ^ 2 := by
  rw [normSq_apply]
  simp only [sub_re, one_re, sub_im, one_im, sub_zero]
  ring

/-- The algebraic denominator |s|^2 |s-1|^2 in terms of real coordinates. -/
theorem normSq_mul_sub_one_eq_coords (s : ℂ) :
    normSq (s * (s - 1)) = (s.re ^ 2 + s.im ^ 2) * ((s.re - 1) ^ 2 + s.im ^ 2) := by
  rw [normSq_mul s (s - 1), normSq_eq, normSq_sub_one]

/-- The denominator is strictly positive for any upper quadrant candidate. -/
theorem normSq_mul_sub_one_pos {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im) :
    0 < normSq (s * (s - 1)) :=
  normSq_pos.mpr (mul_sub_one_ne_zero hsr hsim)

/-- The algebraic denominator is at least s.im^4. -/
theorem normSq_mul_sub_one_ge_im_four (s : ℂ) :
    s.im ^ 4 ≤ (s.re ^ 2 + s.im ^ 2) * ((s.re - 1) ^ 2 + s.im ^ 2) := by
  have h1 : s.im ^ 2 ≤ s.re ^ 2 + s.im ^ 2 := by
    have : 0 ≤ s.re ^ 2 := sq_nonneg s.re
    linarith
  have h2 : s.im ^ 2 ≤ (s.re - 1) ^ 2 + s.im ^ 2 := by
    have : 0 ≤ (s.re - 1) ^ 2 := sq_nonneg (s.re - 1)
    linarith
  have hpos : 0 ≤ s.im ^ 2 := sq_nonneg s.im
  have h_mul : s.im ^ 2 * s.im ^ 2 ≤ (s.re ^ 2 + s.im ^ 2) * ((s.re - 1) ^ 2 + s.im ^ 2) :=
    mul_le_mul h1 h2 hpos (by linarith)
  have h4 : s.im ^ 4 = s.im ^ 2 * s.im ^ 2 := by ring
  rw [h4]
  exact h_mul

/-- Denominator bound: |s(s-1)|^2 ≥ (s.im^2)^2 for any s with Im(s) = γ. -/
theorem normSq_mul_sub_one_ge_sq_sq (s : ℂ) :
    (s.im ^ 2) ^ 2 ≤ normSq (s * (s - 1)) := by
  rw [normSq_mul_sub_one_eq_coords]
  have h_sq : (s.im ^ 2) ^ 2 = s.im ^ 4 := by ring
  rw [h_sq]
  exact normSq_mul_sub_one_ge_im_four s

/-! ### First Quadrant Localization -/

/-- For β ≤ 1, β * (β - 1) ≤ 0 when 0 ≤ β. -/
theorem mul_sub_one_nonpos {β : ℝ} (h0 : 0 ≤ β) (h1 : β ≤ 1) :
    β * (β - 1) ≤ 0 := by
  have : β - 1 ≤ 0 := by linarith
  nlinarith

/-- The numerator of Re(completedRiemannZeta₀ s) is strictly positive for β ∈ (0, 1] and γ > 0. -/
theorem re_numerator_pos {s : ℂ} (hsr0 : 0 ≤ s.re) (hsr1 : s.re ≤ 1) (hsim : 0 < s.im) :
    0 < s.im ^ 2 - s.re * (s.re - 1) := by
  have h_sq : 0 < s.im ^ 2 := sq_pos_of_pos hsim
  have h_prod : s.re * (s.re - 1) ≤ 0 := mul_sub_one_nonpos hsr0 hsr1
  linarith

/-- Strict positivity of Re(completedRiemannZeta₀ s) at any off-line zero with Re(s) ≤ 1. -/
theorem completedRiemannZeta₀_re_pos_of_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsr1 : s.re ≤ 1)
    (hsim : 0 < s.im) (hz : riemannZeta s = 0) :
    0 < (completedRiemannZeta₀ s).re := by
  rw [completedRiemannZeta₀_re_of_zero hsr hsim hz]
  have hnum : 0 < s.im ^ 2 - s.re * (s.re - 1) :=
    re_numerator_pos (by linarith) hsr1 hsim
  have hdenom : 0 < normSq (s * (s - 1)) :=
    normSq_mul_sub_one_pos hsr hsim
  exact div_pos hnum hdenom

/-- First quadrant localization: both Re and Im are strictly positive at any upper-strip off-line zero. -/
theorem completedRiemannZeta₀_mem_first_quadrant_of_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re)
    (hsr1 : s.re ≤ 1) (hsim : 0 < s.im) (hz : riemannZeta s = 0) :
    0 < (completedRiemannZeta₀ s).re ∧ 0 < (completedRiemannZeta₀ s).im :=
  ⟨completedRiemannZeta₀_re_pos_of_zero hsr hsr1 hsim hz,
   completedRiemannZeta₀_im_pos_of_zero hsr hsim hz⟩

/-- The algebraic value of Im(completedRiemannZeta₀ s) in explicit real coordinates. -/
theorem completedRiemannZeta₀_im_eq_coords {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    (completedRiemannZeta₀ s).im =
      ((2 * s.re - 1) * s.im) / ((s.re ^ 2 + s.im ^ 2) * ((s.re - 1) ^ 2 + s.im ^ 2)) := by
  rw [completedRiemannZeta₀_im_of_zero hsr hsim hz, normSq_mul_sub_one_eq_coords]

/-- The algebraic value of Re(completedRiemannZeta₀ s) in explicit real coordinates. -/
theorem completedRiemannZeta₀_re_eq_coords {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    (completedRiemannZeta₀ s).re =
      (s.im ^ 2 - s.re * (s.re - 1)) / ((s.re ^ 2 + s.im ^ 2) * ((s.re - 1) ^ 2 + s.im ^ 2)) := by
  rw [completedRiemannZeta₀_re_of_zero hsr hsim hz, normSq_mul_sub_one_eq_coords]

/-! ### Magnitude Decay and Norm Bounds -/

/-- The normSq of completedRiemannZeta₀ at a zero is the reciprocal of normSq (s * (s - 1)). -/
theorem normSq_completedRiemannZeta₀_eq_of_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    normSq (completedRiemannZeta₀ s) = 1 / normSq (s * (s - 1)) := by
  have heq : completedRiemannZeta₀ s = -1 / (s * (s - 1)) :=
    completedRiemannZeta₀_eq_of_zero hsr hsim hz
  rw [heq, normSq_div, normSq_neg, normSq_one]

/-- Pointwise normSq upper bound: normSq(completedRiemannZeta₀ s) ≤ 1 / γ^4 at any zero. -/
theorem normSq_completedRiemannZeta₀_le_of_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    normSq (completedRiemannZeta₀ s) ≤ 1 / (s.im ^ 2) ^ 2 := by
  rw [normSq_completedRiemannZeta₀_eq_of_zero hsr hsim hz]
  have hpos : 0 < (s.im ^ 2) ^ 2 := by positivity
  have hge : (s.im ^ 2) ^ 2 ≤ normSq (s * (s - 1)) := normSq_mul_sub_one_ge_sq_sq s
  exact div_le_div_of_nonneg_left (by linarith) hpos hge

/-- Pointwise norm upper bound: ‖completedRiemannZeta₀ s‖ ≤ 1 / γ^2 at any zero. -/
theorem norm_completedRiemannZeta₀_le_of_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    ‖completedRiemannZeta₀ s‖ ≤ 1 / s.im ^ 2 := by
  have heq : completedRiemannZeta₀ s = -1 / (s * (s - 1)) :=
    completedRiemannZeta₀_eq_of_zero hsr hsim hz
  rw [heq, norm_div, norm_neg, norm_one, norm_mul]
  have hpos1 : 0 < ‖s‖ := norm_pos_iff.mpr (ne_zero_of_half_lt_re hsr)
  have hpos2 : 0 < ‖s - 1‖ := norm_pos_iff.mpr (sub_ne_zero.mpr (ne_one_of_im_pos hsim))
  have h_im1 : s.im ≤ ‖s‖ := (le_abs_self s.im).trans (Complex.abs_im_le_norm s)
  have h_im2 : s.im ≤ ‖s - 1‖ := by
    have h_sub_im : (s - 1).im = s.im := by simp
    have : |s.im| ≤ ‖s - 1‖ := by
      rw [← h_sub_im]
      exact Complex.abs_im_le_norm (s - 1)
    exact (le_abs_self s.im).trans this
  have h_im_sq : s.im * s.im ≤ ‖s‖ * ‖s - 1‖ :=
    mul_le_mul h_im1 h_im2 (by linarith) (by linarith)
  have h_im_pow : s.im ^ 2 ≤ ‖s‖ * ‖s - 1‖ := by
    have : s.im ^ 2 = s.im * s.im := by ring
    rwa [this]
  have h_denom_pos : 0 < s.im ^ 2 := sq_pos_of_pos hsim
  exact div_le_div_of_nonneg_left (by linarith) h_denom_pos h_im_pow

/-- Real part bound: Re(completedRiemannZeta₀ s) ≤ 1 / γ^2 at any zero. -/
theorem re_le_inv_sq_of_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    (completedRiemannZeta₀ s).re ≤ 1 / s.im ^ 2 := by
  have h1 : (completedRiemannZeta₀ s).re ≤ ‖completedRiemannZeta₀ s‖ :=
    Complex.re_le_norm (completedRiemannZeta₀ s)
  have h2 : ‖completedRiemannZeta₀ s‖ ≤ 1 / s.im ^ 2 :=
    norm_completedRiemannZeta₀_le_of_zero hsr hsim hz
  exact h1.trans h2

/-- Imaginary part bound: Im(completedRiemannZeta₀ s) ≤ 1 / γ^2 at any zero. -/
theorem im_le_inv_sq_of_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    (completedRiemannZeta₀ s).im ≤ 1 / s.im ^ 2 := by
  have h1 : (completedRiemannZeta₀ s).im ≤ ‖completedRiemannZeta₀ s‖ :=
    Complex.im_le_norm (completedRiemannZeta₀ s)
  have h2 : ‖completedRiemannZeta₀ s‖ ≤ 1 / s.im ^ 2 :=
    norm_completedRiemannZeta₀_le_of_zero hsr hsim hz
  exact h1.trans h2

/-! ### Algebraic Ratio and Fourth-Power Decay -/

/-- The algebraic ratio Im(completedRiemannZeta₀ s) / s.im. -/
def imRatio (s : ℂ) : ℝ :=
  (completedRiemannZeta₀ s).im / s.im

/-- The algebraic ratio formula at a zero. -/
theorem imRatio_eq_of_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    imRatio s = (2 * s.re - 1) / ((s.re ^ 2 + s.im ^ 2) * ((s.re - 1) ^ 2 + s.im ^ 2)) := by
  unfold imRatio
  rw [completedRiemannZeta₀_im_eq_coords hsr hsim hz]
  have hne : s.im ≠ 0 := by linarith
  have hdenom_pos : 0 < (s.re ^ 2 + s.im ^ 2) * ((s.re - 1) ^ 2 + s.im ^ 2) := by
    rw [← normSq_mul_sub_one_eq_coords]
    exact normSq_mul_sub_one_pos hsr hsim
  field_simp

/-- Strict positivity of the algebraic ratio at any off-line zero. -/
theorem imRatio_pos_of_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    0 < imRatio s := by
  have him_pos : 0 < (completedRiemannZeta₀ s).im :=
    completedRiemannZeta₀_im_pos_of_zero hsr hsim hz
  exact div_pos him_pos hsim

/-- Asymptotic fourth-power decay bound for the algebraic ratio. -/
theorem imRatio_le_four_power_of_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    imRatio s ≤ (2 * s.re - 1) / s.im ^ 4 := by
  rw [imRatio_eq_of_zero hsr hsim hz]
  have hnum_pos : 0 < 2 * s.re - 1 := by linarith
  have h_denom_ge : s.im ^ 4 ≤ (s.re ^ 2 + s.im ^ 2) * ((s.re - 1) ^ 2 + s.im ^ 2) :=
    normSq_mul_sub_one_ge_im_four s
  have h_im4_pos : 0 < s.im ^ 4 := by positivity
  exact div_le_div_of_nonneg_left (by linarith) h_im4_pos h_denom_ge

/-! ### Imaginary Mellin Envelope and Exponential Majorization -/

/-- The difference of powers x^(β/2 - 1) - x^((1-β)/2 - 1) is strictly positive for β > 1/2 and x > 1. -/
theorem rpow_diff_pos_of_half_lt {β x : ℝ} (hβ : (1 : ℝ) / 2 < β) (hx : 1 < x) :
    0 < x ^ (β / 2 - 1) - x ^ ((1 - β) / 2 - 1) := by
  have h_exp : (1 - β) / 2 - 1 < β / 2 - 1 := by linarith
  have h_lt : x ^ ((1 - β) / 2 - 1) < x ^ (β / 2 - 1) :=
    rpow_lt_rpow_of_exponent_lt hx h_exp
  linarith

/-- The hyperbolic difference function. -/
def powerDiff (β x : ℝ) : ℝ :=
  x ^ (β / 2 - 1) - x ^ ((1 - β) / 2 - 1)

/-- The powerDiff is positive on (1, ∞) for β > 1/2. -/
theorem powerDiff_pos {β x : ℝ} (hβ : (1 : ℝ) / 2 < β) (hx : 1 < x) :
    0 < powerDiff β x :=
  rpow_diff_pos_of_half_lt hβ hx

/-- For β ≤ 1, β/2 - 1 ≤ 0. -/
theorem beta_div_two_sub_one_nonpos {β : ℝ} (hβ : β ≤ 1) :
    β / 2 - 1 ≤ 0 := by
  linarith

/-- For β ≤ 1 and 1 ≤ x, x^(β/2 - 1) ≤ 1. -/
theorem rpow_beta_le_one {β x : ℝ} (hβ : β ≤ 1) (hx : 1 ≤ x) :
    x ^ (β / 2 - 1) ≤ 1 := by
  have hpos : 0 < x := by linarith
  have h_exp : β / 2 - 1 ≤ 0 := beta_div_two_sub_one_nonpos hβ
  simpa using Real.rpow_le_one_of_one_le_of_nonpos hx h_exp

/-- For 0 < x, x^((1-β)/2 - 1) > 0. -/
theorem rpow_one_sub_beta_pos {β x : ℝ} (hx : 0 < x) :
    0 < x ^ ((1 - β) / 2 - 1) :=
  rpow_pos_of_pos hx _

/-- Uniform upper bound: powerDiff β x ≤ 1 for β ≤ 1 and 1 ≤ x. -/
theorem powerDiff_le_one {β x : ℝ} (hβ : β ≤ 1) (hx : 1 ≤ x) :
    powerDiff β x ≤ 1 := by
  unfold powerDiff
  have hpos : 0 < x := by linarith
  have h1 : x ^ (β / 2 - 1) ≤ 1 := rpow_beta_le_one hβ hx
  have h2 : 0 < x ^ ((1 - β) / 2 - 1) := rpow_one_sub_beta_pos hpos
  linarith

/-- The envelope of the imaginary Mellin integrand is bounded by real_f_modif. -/
theorem powerDiff_mul_real_f_modif_le {β x : ℝ} (hβ : β ≤ 1) (hx : 1 ≤ x) :
    powerDiff β x * real_f_modif x ≤ real_f_modif x := by
  have h_f : 0 ≤ real_f_modif x := real_f_modif_nonneg x
  have h_p : powerDiff β x ≤ 1 := powerDiff_le_one hβ hx
  nlinarith

/-- Exponential decay of the imaginary Mellin envelope: bounded by 4 * exp(-π * x). -/
theorem powerDiff_mul_real_f_modif_le_four_exp {β x : ℝ} (hβ : β ≤ 1) (hx : 1 ≤ x) :
    powerDiff β x * real_f_modif x ≤ 4 * Real.exp (-π * x) := by
  have h1 : powerDiff β x * real_f_modif x ≤ real_f_modif x :=
    powerDiff_mul_real_f_modif_le hβ hx
  have h2 : real_f_modif x ≤ 4 * Real.exp (-π * x) :=
    real_f_modif_le_four_exp hx
  linarith

end BuildingBlocks.RiemannZetaOffLineZeroLocalization

open BuildingBlocks.RiemannZetaOffLineZeroLocalization

#print axioms completedRiemannZeta₀_mem_first_quadrant_of_zero
#print axioms norm_completedRiemannZeta₀_le_of_zero
#print axioms imRatio_le_four_power_of_zero
#print axioms powerDiff_mul_real_f_modif_le_four_exp
