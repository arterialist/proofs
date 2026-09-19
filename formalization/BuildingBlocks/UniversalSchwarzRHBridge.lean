/-
Copyright (c) 2026 Arterialist RH Research Team. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import BuildingBlocks.WeilExplicitGrandRHBridge
import BuildingBlocks.ZetaUniversalRHBridge
import BuildingBlocks.RiemannZetaGlobalSchwarzReflection
import BuildingBlocks.ChirpedUniversalZeroRefutation
import BuildingBlocks.ChirpedUniversalFredholmExclusion
import BuildingBlocks.CriticalTransformRH

/-!
# Module 277: RH bridges with proved Schwarz reflection

This module formalizes the elimination of the external Schwarz reflection hypothesis
`ZetaSchwarzReflection` from the grand Riemann Hypothesis deduction pipeline.

## Mathematical Architecture

Prior bridge formalizations (`ZetaUniversalRHBridge.lean` and `WeilExplicitGrandRHBridge.lean`)
parameterized the global RH deduction by an abstract reflection structure `sr : ZetaSchwarzReflection`.
With the establishment of `RiemannZetaGlobalSchwarzReflection.lean` (Module 276 / First Formalization 363),
the exact conjugation symmetry $\zeta(\bar{s}) = \overline{\zeta(s)}$ on $\operatorname{Re}(s) > 0$ and the
critical half-plane zero reflection equivalence:
$$\zeta(s) = 0 \iff \zeta(\bar{s}) = 0 \quad (\operatorname{Re}(s) > 1/2)$$
are supplied by the imported reflection module.

In this module, we:
1. Establish the exact real-valuedness of $\zeta(\sigma)$ on the positive real axis:
   $\operatorname{Im}(\zeta(\sigma)) = 0$ for all $\sigma > 0$.
2. Prove that $\zeta(\sigma) = 0 \iff \operatorname{Re}(\zeta(\sigma)) = 0$ for $\sigma > 0$.
3. Deduce `RightHalfZeroFree` and the official Mathlib `RiemannHypothesis` from:
   - `UniversalWeilSystem` + `RealAxisNonvanishingSystem` (Weil explicit wavepacket evaluation).
   - `UniversalZeroRefutationSystem` + `RealAxisNonvanishingSystem` (Universal chirped carrier tuning).
   - `UniversalFredholmSystem` + `RealAxisNonvanishingSystem` (Universal Fredholm determinant trace).
   without an external reflection structure. Each deduction still assumes the named evaluation
   system and a `RealAxisNonvanishingSystem`; this file constructs neither.

## Foundational Axiom Status

All declarations depend strictly on Lean 4's foundational axioms:
`[propext, Classical.choice, Quot.sound]`.
-/

namespace BuildingBlocks.UniversalSchwarzRHBridge

open Complex
open BuildingBlocks.RiemannZetaGlobalSchwarzReflection
open BuildingBlocks.RiemannZetaRealNonvanishing
open BuildingBlocks.WeilExplicitGrandRHBridge
open BuildingBlocks.ZetaUniversalRHBridge
open BuildingBlocks.ChirpedUniversalZeroRefutation
open BuildingBlocks.ChirpedUniversalFredholmExclusion

noncomputable section

/-!
### 1. Real-Valuedness on the Positive Real Axis
-/

/-- Any complex number equal to its complex conjugate has vanishing imaginary part. -/
lemma im_eq_zero_of_star_eq_self {z : ℂ} (h : star z = z) : z.im = 0 := by
  have := congr_arg Complex.im h
  simp only [star_def, conj_im] at this
  linarith

/-- The Riemann zeta function has vanishing imaginary part on the positive real axis:
$\operatorname{Im}(\zeta(\sigma)) = 0$ for all $\sigma > 0$. -/
theorem riemannZeta_ofReal_im_zero {σ : ℝ} (hσ : 0 < σ) :
    (riemannZeta (σ : ℂ)).im = 0 := by
  have h_re : 0 < (σ : ℂ).re := by simp only [ofReal_re, hσ]
  have h_conj := riemannZeta_conj_of_re_pos h_re
  have h_star : star (σ : ℂ) = (σ : ℂ) := by simp only [star_def, conj_ofReal]
  rw [h_star] at h_conj
  exact im_eq_zero_of_star_eq_self h_conj.symm

/-- The completed Riemann zeta function $\Lambda(s)$ has vanishing imaginary part on the real axis:
$\operatorname{Im}(\Lambda(\sigma)) = 0$ for all $\sigma \in \mathbb{R}$. -/
theorem completedRiemannZeta_ofReal_im_zero (σ : ℝ) :
    (completedRiemannZeta (σ : ℂ)).im = 0 := by
  have h_conj := completedRiemannZeta_conj (σ : ℂ)
  have h_star : star (σ : ℂ) = (σ : ℂ) := by simp only [star_def, conj_ofReal]
  rw [h_star] at h_conj
  exact im_eq_zero_of_star_eq_self h_conj.symm

/-- On the positive real axis, $\zeta(\sigma : \mathbb{C})$ coincides with its real part. -/
theorem riemannZeta_ofReal_eq_re {σ : ℝ} (hσ : 0 < σ) :
    riemannZeta (σ : ℂ) = ((riemannZeta (σ : ℂ)).re : ℂ) := by
  apply Complex.ext
  · rfl
  · rw [riemannZeta_ofReal_im_zero hσ, ofReal_im]

/-- On the positive real axis, vanishing of $\zeta(\sigma : \mathbb{C})$ is equivalent to
vanishing of its real part. -/
theorem riemannZeta_ofReal_zero_iff_re_zero {σ : ℝ} (hσ : 0 < σ) :
    riemannZeta (σ : ℂ) = 0 ↔ (riemannZeta (σ : ℂ)).re = 0 := by
  constructor
  · intro hz
    rw [hz, zero_re]
  · intro hre
    rw [riemannZeta_ofReal_eq_re hσ, hre, ofReal_zero]

/-!
### 2. Conditional Weil explicit RH bridge
-/

/-- Right-half zero-freeness deduced from a `UniversalWeilSystem` and
`RealAxisNonvanishingSystem`, with no external reflection hypothesis. -/
theorem rightHalfZeroFree_of_weil_and_real
    (sys : UniversalWeilSystem)
    (real_sys : RealAxisNonvanishingSystem) :
    RightHalfZeroFree := by
  intro s hsr hs1 hz
  rcases lt_trichotomy s.im 0 with h_neg | h_zero | h_pos
  · -- Case 1: Im(s) < 0 (Lower half-plane zero)
    have hz_conj : riemannZeta (star s) = 0 :=
      (riemannZeta_zero_iff_conj_zero_of_half_lt_re hsr).mp hz
    have h_conj_re : (star s).re = s.re := by
      rw [Complex.star_def, Complex.conj_re]
    have h_conj_im : 0 < (star s).im := by
      rw [Complex.star_def, Complex.conj_im]
      linarith
    have hsr_conj : (1 : ℝ) / 2 < (star s).re := by
      rw [h_conj_re]
      exact hsr
    exact WeilExplicitGrandRHBridge.no_positive_im_offline_zero sys (star s) hsr_conj h_conj_im hz_conj
  · -- Case 2: Im(s) = 0 (Real zero)
    exact real_axis_zeta_ne_zero real_sys s hsr h_zero hs1 hz
  · -- Case 3: 0 < Im(s) (Upper half-plane zero)
    exact WeilExplicitGrandRHBridge.no_positive_im_offline_zero sys s hsr h_pos hz

/-- Mathlib's `RiemannHypothesis` deduced from a `UniversalWeilSystem` and
`RealAxisNonvanishingSystem`. -/
theorem RiemannHypothesis_of_weil_and_real
    (sys : UniversalWeilSystem)
    (real_sys : RealAxisNonvanishingSystem) :
    RiemannHypothesis := by
  apply CriticalTransformRH.noRightZeros_implies_RiemannHypothesis
  exact rightHalfZeroFree_of_weil_and_real sys real_sys

/-!
### 3. Conditional universal zero-refutation RH bridge
-/

/-- Right-half zero-freeness deduced from a `UniversalZeroRefutationSystem` and
`RealAxisNonvanishingSystem`. -/
theorem rightHalfZeroFree_of_refutation_and_real
    (sys : UniversalZeroRefutationSystem)
    (real_sys : RealAxisNonvanishingSystem) :
    RightHalfZeroFree := by
  intro s hsr hs1 hz
  rcases lt_trichotomy s.im 0 with h_neg | h_zero | h_pos
  · -- Case 1: Im(s) < 0
    have hz_conj : riemannZeta (star s) = 0 :=
      (riemannZeta_zero_iff_conj_zero_of_half_lt_re hsr).mp hz
    have h_conj_re : (star s).re = s.re := by
      rw [Complex.star_def, Complex.conj_re]
    have h_conj_im : 0 < (star s).im := by
      rw [Complex.star_def, Complex.conj_im]
      linarith
    have hsr_conj : (1 : ℝ) / 2 < (star s).re := by
      rw [h_conj_re]
      exact hsr
    exact ChirpedUniversalZeroRefutation.no_positive_im_offline_zero sys (star s) hsr_conj h_conj_im hz_conj
  · -- Case 2: Im(s) = 0
    exact real_axis_zeta_ne_zero real_sys s hsr h_zero hs1 hz
  · -- Case 3: 0 < Im(s)
    exact ChirpedUniversalZeroRefutation.no_positive_im_offline_zero sys s hsr h_pos hz

/-- Mathlib's `RiemannHypothesis` deduced from a `UniversalZeroRefutationSystem`
and `RealAxisNonvanishingSystem`. -/
theorem RiemannHypothesis_of_refutation_and_real
    (sys : UniversalZeroRefutationSystem)
    (real_sys : RealAxisNonvanishingSystem) :
    RiemannHypothesis := by
  apply CriticalTransformRH.noRightZeros_implies_RiemannHypothesis
  exact rightHalfZeroFree_of_refutation_and_real sys real_sys

/-!
### 4. Conditional bridge from the scalar Fredholm-named system
-/

/-- Right-half zero-freeness deduced from a `UniversalFredholmSystem` and
`RealAxisNonvanishingSystem`. -/
theorem rightHalfZeroFree_of_fredholm_and_real
    (f_sys : UniversalFredholmSystem)
    (real_sys : RealAxisNonvanishingSystem) :
    RightHalfZeroFree := by
  intro s hsr hs1 hz
  rcases lt_trichotomy s.im 0 with h_neg | h_zero | h_pos
  · -- Case 1: Im(s) < 0
    have hz_conj : riemannZeta (star s) = 0 :=
      (riemannZeta_zero_iff_conj_zero_of_half_lt_re hsr).mp hz
    have h_conj_re : (star s).re = s.re := by
      rw [Complex.star_def, Complex.conj_re]
    have h_conj_im : 0 < (star s).im := by
      rw [Complex.star_def, Complex.conj_im]
      linarith
    have hsr_conj : (1 : ℝ) / 2 < (star s).re := by
      rw [h_conj_re]
      exact hsr
    exact no_positive_im_zero_of_universal_fredholm f_sys (star s) hsr_conj h_conj_im hz_conj
  · -- Case 2: Im(s) = 0
    exact real_axis_zeta_ne_zero real_sys s hsr h_zero hs1 hz
  · -- Case 3: 0 < Im(s)
    exact no_positive_im_zero_of_universal_fredholm f_sys s hsr h_pos hz

/-- Mathlib's `RiemannHypothesis` deduced from a `UniversalFredholmSystem` and
`RealAxisNonvanishingSystem`. -/
theorem RiemannHypothesis_of_fredholm_and_real
    (f_sys : UniversalFredholmSystem)
    (real_sys : RealAxisNonvanishingSystem) :
    RiemannHypothesis := by
  apply CriticalTransformRH.noRightZeros_implies_RiemannHypothesis
  exact rightHalfZeroFree_of_fredholm_and_real f_sys real_sys

#print axioms rightHalfZeroFree_of_weil_and_real
#print axioms RiemannHypothesis_of_weil_and_real
#print axioms rightHalfZeroFree_of_refutation_and_real
#print axioms RiemannHypothesis_of_refutation_and_real
#print axioms rightHalfZeroFree_of_fredholm_and_real
#print axioms RiemannHypothesis_of_fredholm_and_real

end

end BuildingBlocks.UniversalSchwarzRHBridge
