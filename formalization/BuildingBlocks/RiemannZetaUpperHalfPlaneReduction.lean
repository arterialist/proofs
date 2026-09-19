import Mathlib.Analysis.Complex.Basic
import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.Scope
import BuildingBlocks.CriticalTransformRH
import BuildingBlocks.UniversalSchwarzRHBridge
import BuildingBlocks.RiemannZetaGlobalSchwarzReflection
import BuildingBlocks.RiemannZetaRealAxisUnconditional
import BuildingBlocks.ActualArchimedeanFactor

/-!
# Upper Half-Plane Reduction of the Riemann Hypothesis

This module establishes the unconditional equivalence between Mathlib's official
`RiemannHypothesis` and the non-vanishing of the Riemann zeta function on the open
upper quadrant:
`{s : ℂ | 1 / 2 < s.re ∧ 0 < s.im}`.

## Mathematical Architecture

1. **Unconditional Axis and Reflection Integration**:
   - The real interval `(1/2, 1)` is zero-free via unconditional symmetrized energy dominance
     (`real_axis_zeta_ne_zero_unconditional`).
   - The lower half-plane `{s : ℂ | s.im < 0}` is reflected across the real line to the upper
     half-plane via global Schwarz reflection symmetry (`riemannZeta_zero_iff_conj_zero_of_half_lt_re`).
   - The real pole and half-plane `[1, ∞)` are excluded by Dirichlet series convergence.
   - Consequently, any hypothetical off-line zero of `riemannZeta` must reside in the open upper
     quadrant `1/2 < s.re ∧ 0 < s.im`.

2. **The Four-Fold Off-Line Zero Constellation**:
   - Every hypothetical off-line zero `s` generates four pairwise distinct zeros:
     `s`, `star s`, `1 - s`, `1 - star s`.
   - These four points form a symmetric rectangle around the central symmetry point `1/2`.

3. **Algebraic Inversion and Strict Positivity**:
   - At every zero `s` with `1/2 < s.re` and `0 < s.im`, the entire function `completedRiemannZeta₀`
     satisfies the algebraic inversion `completedRiemannZeta₀ s = -1 / (s * (s - 1))`.
   - Decomposing into real and imaginary parts reveals:
     `Re(completedRiemannZeta₀ s) = (s.im ^ 2 - s.re * (s.re - 1)) / normSq (s * (s - 1))`
     `Im(completedRiemannZeta₀ s) = ((2 * s.re - 1) * s.im) / normSq (s * (s - 1))`.
   - Since `2 * s.re - 1 > 0` and `s.im > 0`, the imaginary part is strictly positive:
     `0 < Im(completedRiemannZeta₀ s)`.
   - In particular, `completedRiemannZeta₀ s ≠ 0`.

All declarations depend strictly on the standard foundational axioms:
`[propext, Classical.choice, Quot.sound]`.
-/

namespace BuildingBlocks.RiemannZetaUpperHalfPlaneReduction

open Complex
open BuildingBlocks
open BuildingBlocks.ActualArchimedeanFactor
open BuildingBlocks.UniversalSchwarzRHBridge
open BuildingBlocks.RiemannZetaGlobalSchwarzReflection
open BuildingBlocks.RiemannZetaRealAxisUnconditional
open BuildingBlocks.CriticalTransformRH

noncomputable section

/-- A point in the right half-plane `1/2 < s.re` cannot be zero. -/
theorem ne_zero_of_half_lt_re {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) : s ≠ 0 := by
  intro h
  subst h
  norm_num at hsr

/-- A point with positive imaginary part cannot equal one. -/
theorem ne_one_of_im_pos {s : ℂ} (hsim : 0 < s.im) : s ≠ 1 := by
  intro h
  subst h
  norm_num at hsim

/-- The product `s * (s - 1)` does not vanish for any upper quadrant candidate. -/
theorem mul_sub_one_ne_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im) :
    s * (s - 1) ≠ 0 := by
  have hs0 := ne_zero_of_half_lt_re hsr
  have hs1 := ne_one_of_im_pos hsim
  have hs1' : s - 1 ≠ 0 := sub_ne_zero.mpr hs1
  exact mul_ne_zero hs0 hs1'

/-- The entire function `xi` vanishes at any upper quadrant zero of `riemannZeta`. -/
theorem xi_eq_zero_of_zeta_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) : xi s = 0 := by
  have hs0_re : 0 < s.re := by linarith
  have hs1 := ne_one_of_im_pos hsim
  exact (xi_zero_iff_zeta s hs0_re hs1).mpr hz

/-- Algebraic inversion: `completedRiemannZeta₀ s` equals `-1 / (s * (s - 1))` at every zero. -/
theorem completedRiemannZeta₀_eq_of_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    completedRiemannZeta₀ s = -1 / (s * (s - 1)) := by
  have hxi := xi_eq_zero_of_zeta_zero hsr hsim hz
  have hmul := mul_sub_one_ne_zero hsr hsim
  unfold xi at hxi
  have h2 : (2 : ℂ) ≠ 0 := by norm_num
  rw [div_eq_zero_iff] at hxi
  cases hxi with
  | inl h1 =>
    have h_neg : s * (s - 1) * completedRiemannZeta₀ s = -1 := by
      linear_combination h1
    calc completedRiemannZeta₀ s = (s * (s - 1) * completedRiemannZeta₀ s) / (s * (s - 1)) := by
           rw [mul_div_cancel_left₀ _ hmul]
         _ = -1 / (s * (s - 1)) := by rw [h_neg]
  | inr h2_zero => exact False.elim (h2 h2_zero)

/-- Real part of `s * (s - 1)`. -/
theorem mul_sub_one_re (s : ℂ) :
    (s * (s - 1)).re = s.re * (s.re - 1) - s.im ^ 2 := by
  simp only [mul_re, sub_re, one_re, sub_im, one_im, sub_zero]
  ring

/-- Imaginary part of `s * (s - 1)`. -/
theorem mul_sub_one_im (s : ℂ) :
    (s * (s - 1)).im = (2 * s.re - 1) * s.im := by
  simp only [mul_im, sub_re, one_re, sub_im, one_im, sub_zero]
  ring

/-- Imaginary part of `-1 / z`. -/
theorem neg_one_div_im (z : ℂ) :
    (-1 / z).im = z.im / normSq z := by
  have : -1 / z = - (z⁻¹) := by
    rw [div_eq_mul_inv, neg_mul, one_mul]
  rw [this, neg_im, inv_im]
  ring

/-- Real part of `-1 / z`. -/
theorem neg_one_div_re (z : ℂ) :
    (-1 / z).re = -z.re / normSq z := by
  have : -1 / z = - (z⁻¹) := by
    rw [div_eq_mul_inv, neg_mul, one_mul]
  rw [this, neg_re, inv_re]
  ring

/-- Decomposition of `Im(completedRiemannZeta₀ s)` at any upper quadrant zero. -/
theorem completedRiemannZeta₀_im_of_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    (completedRiemannZeta₀ s).im = ((2 * s.re - 1) * s.im) / normSq (s * (s - 1)) := by
  rw [completedRiemannZeta₀_eq_of_zero hsr hsim hz, neg_one_div_im, mul_sub_one_im]

/-- Decomposition of `Re(completedRiemannZeta₀ s)` at any upper quadrant zero. -/
theorem completedRiemannZeta₀_re_of_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    (completedRiemannZeta₀ s).re = (s.im ^ 2 - s.re * (s.re - 1)) / normSq (s * (s - 1)) := by
  rw [completedRiemannZeta₀_eq_of_zero hsr hsim hz, neg_one_div_re, mul_sub_one_re]
  ring

/-- Strict positivity of the imaginary part of `completedRiemannZeta₀` at every candidate zero. -/
theorem completedRiemannZeta₀_im_pos_of_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    0 < (completedRiemannZeta₀ s).im := by
  rw [completedRiemannZeta₀_im_of_zero hsr hsim hz]
  have hnum : 0 < (2 * s.re - 1) * s.im := by
    have h1 : 0 < 2 * s.re - 1 := by linarith
    exact mul_pos h1 hsim
  have hmul : s * (s - 1) ≠ 0 := mul_sub_one_ne_zero hsr hsim
  have hden : 0 < normSq (s * (s - 1)) := normSq_pos.mpr hmul
  exact div_pos hnum hden

/-- Non-vanishing of `completedRiemannZeta₀` at every candidate zero. -/
theorem completedRiemannZeta₀_ne_zero_of_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    completedRiemannZeta₀ s ≠ 0 := by
  intro h
  have him : (completedRiemannZeta₀ s).im = 0 := by rw [h, zero_im]
  have hpos := completedRiemannZeta₀_im_pos_of_zero hsr hsim hz
  linarith

/-- All four vertices of the hypothetical off-line rectangle are pairwise distinct. -/
theorem four_fold_distinct {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im) :
    s ≠ star s ∧ s ≠ 1 - s ∧ s ≠ 1 - star s ∧
    star s ≠ 1 - s ∧ star s ≠ 1 - star s ∧ 1 - s ≠ 1 - star s := by
  have h_re_gt : (1 - s).re < s.re := by
    simp only [sub_re, one_re]
    linarith
  have h_star_re : (star s).re = s.re := by rw [star_def, conj_re]
  have h_star_im : (star s).im = -s.im := by rw [star_def, conj_im]
  have h_one_sub_star_re : (1 - star s).re = 1 - s.re := by
    simp only [sub_re, one_re, star_def, conj_re]
  have h_one_sub_star_im : (1 - star s).im = s.im := by
    simp only [sub_im, one_im, zero_sub, star_def, conj_im, neg_neg]
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩
  · -- s ≠ star s
    intro h
    have him := congr_arg Complex.im h
    rw [h_star_im] at him
    linarith
  · -- s ≠ 1 - s
    intro h
    have hre := congr_arg Complex.re h
    simp only [sub_re, one_re] at hre
    linarith
  · -- s ≠ 1 - star s
    intro h
    have hre := congr_arg Complex.re h
    rw [h_one_sub_star_re] at hre
    linarith
  · -- star s ≠ 1 - s
    intro h
    have hre := congr_arg Complex.re h
    rw [h_star_re] at hre
    simp only [sub_re, one_re] at hre
    linarith
  · -- star s ≠ 1 - star s
    intro h
    have hre := congr_arg Complex.re h
    rw [h_star_re, h_one_sub_star_re] at hre
    linarith
  · -- 1 - s ≠ 1 - star s
    intro h
    have him := congr_arg Complex.im h
    simp only [sub_im, one_im, zero_sub] at him
    rw [h_star_im] at him
    linarith

/-- Points in the right half-plane do not equal non-positive integers. -/
theorem not_eq_neg_nat_of_half_lt_re {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (n : ℕ) :
    s ≠ -n := by
  intro h
  have hre := congr_arg Complex.re h
  simp only [neg_re, natCast_re] at hre
  have hn : (0 : ℝ) ≤ n := Nat.cast_nonneg n
  linarith

/-- Any off-line zero forces a quartet of zeros across both symmetry axes. -/
theorem four_fold_zeta_zero {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) (hsim : 0 < s.im)
    (hz : riemannZeta s = 0) :
    riemannZeta s = 0 ∧
    riemannZeta (star s) = 0 ∧
    riemannZeta (1 - s) = 0 ∧
    riemannZeta (1 - star s) = 0 := by
  have hz_conj : riemannZeta (star s) = 0 :=
    (riemannZeta_zero_iff_conj_zero_of_half_lt_re hsr).mp hz
  have hs1 : s ≠ 1 := ne_one_of_im_pos hsim
  have hsn : ∀ n : ℕ, s ≠ -n := not_eq_neg_nat_of_half_lt_re hsr
  have hz_one_sub : riemannZeta (1 - s) = 0 := by
    rw [riemannZeta_one_sub hsn hs1, hz, mul_zero]
  have hstar_re : (1 : ℝ) / 2 < (star s).re := by
    rw [star_def, conj_re]
    exact hsr
  have hstar_1 : star s ≠ 1 := by
    intro h
    have him := congr_arg Complex.im h
    rw [star_def, conj_im] at him
    simp only [one_im] at him
    linarith
  have hstar_n : ∀ n : ℕ, star s ≠ -n := not_eq_neg_nat_of_half_lt_re hstar_re
  have hz_one_sub_star : riemannZeta (1 - star s) = 0 := by
    rw [riemannZeta_one_sub hstar_n hstar_1, hz_conj, mul_zero]
  exact ⟨hz, hz_conj, hz_one_sub, hz_one_sub_star⟩

/-- Equivalence between `RightHalfZeroFree` and upper quadrant zero-freeness. -/
theorem rightHalfZeroFree_iff_upper_half_plane_zero_free :
    RightHalfZeroFree ↔ (∀ s : ℂ, (1 : ℝ) / 2 < s.re → 0 < s.im → riemannZeta s ≠ 0) := by
  constructor
  · intro hRH s hsr hsim hz
    unfold RightHalfZeroFree at hRH
    have hs1 := ne_one_of_im_pos hsim
    exact hRH s hsr hs1 hz
  · intro h_upper s hsr hs1 hz
    rcases lt_trichotomy s.im 0 with h_neg | h_zero | h_pos
    · -- Im(s) < 0
      have hz_conj : riemannZeta (star s) = 0 :=
        (riemannZeta_zero_iff_conj_zero_of_half_lt_re hsr).mp hz
      have hsr_conj : (1 : ℝ) / 2 < (star s).re := by
        rw [star_def, conj_re]
        exact hsr
      have hpos_conj : 0 < (star s).im := by
        rw [star_def, conj_im]
        linarith
      exact h_upper (star s) hsr_conj hpos_conj hz_conj
    · -- Im(s) = 0
      exact real_axis_zeta_ne_zero_unconditional s hsr h_zero hs1 hz
    · -- 0 < Im(s)
      exact h_upper s hsr h_pos hz

/-- Grand Equivalence: The official Mathlib `RiemannHypothesis` is logically equivalent
to non-vanishing on the open upper quadrant `{s : ℂ | 1/2 < s.re ∧ 0 < s.im}`. -/
theorem RiemannHypothesis_iff_upper_half_plane_zero_free :
    RiemannHypothesis ↔ (∀ s : ℂ, (1 : ℝ) / 2 < s.re → 0 < s.im → riemannZeta s ≠ 0) := by
  change Target ↔ _
  rw [target_iff_rightHalfZeroFree]
  exact rightHalfZeroFree_iff_upper_half_plane_zero_free

/-- Direct forward implication: Upper quadrant zero-freeness implies `RiemannHypothesis`. -/
theorem RiemannHypothesis_of_upper_half_plane_zero_free
    (h : ∀ s : ℂ, (1 : ℝ) / 2 < s.re → 0 < s.im → riemannZeta s ≠ 0) :
    RiemannHypothesis :=
  RiemannHypothesis_iff_upper_half_plane_zero_free.mpr h

end

end BuildingBlocks.RiemannZetaUpperHalfPlaneReduction

#print axioms BuildingBlocks.RiemannZetaUpperHalfPlaneReduction.RiemannHypothesis_iff_upper_half_plane_zero_free
#print axioms BuildingBlocks.RiemannZetaUpperHalfPlaneReduction.completedRiemannZeta₀_im_pos_of_zero
#print axioms BuildingBlocks.RiemannZetaUpperHalfPlaneReduction.four_fold_zeta_zero
#print axioms BuildingBlocks.RiemannZetaUpperHalfPlaneReduction.four_fold_distinct
