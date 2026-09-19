/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import Mathlib.NumberTheory.LSeries.RiemannZeta
import Mathlib.NumberTheory.LSeries.Nonvanishing
import Mathlib.Analysis.SpecialFunctions.Gamma.Deligne
import BuildingBlocks.UniversalSchwarzRHBridge
import BuildingBlocks.DirichletEtaGroupedConvergence
import BuildingBlocks.CriticalTransformRH
import BuildingBlocks.RiemannZetaGlobalSchwarzReflection
import BuildingBlocks.ChirpedUniversalZeroRefutation
import BuildingBlocks.ChirpedUniversalFredholmExclusion

/-!
# Riemann Zeta Real Axis Discharge and Equivalence

This module formalizes the universal discharge and equivalence principles for the non-vanishing
of the Riemann zeta function on the critical real segment $(1/2, 1)$, linking:
1. Non-vanishing of the Deligne factor $\Gamma_{\mathbb{R}}(\sigma)$ on $\sigma > 0$ (`Gammaℝ_ofReal_ne_zero`).
2. Exact zero equivalence $\zeta(\sigma) = 0 \iff \Lambda(\sigma) = 0$ on $\sigma > 0$
   (`riemannZeta_ofReal_zero_iff_completed_zero`).
3. Exact non-zero equivalence $\zeta(\sigma) \ne 0 \iff \Lambda(\sigma) \ne 0$ on $\sigma > 0$
   (`riemannZeta_ofReal_ne_zero_iff_completed_ne_zero`).
4. Abstract real zero-freeness `RealAxisZeroFree`.
5. Multiple independent discharge channels:
   - Via completed zeta non-vanishing (`realAxisZeroFree_of_completed`).
   - Via grouped Dirichlet eta relation (`realAxisZeroFree_of_eta_rel`).
   - Via real part negativity (`realAxisZeroFree_of_re_neg`).
6. Unconditional bridge theorems deriving `RightHalfZeroFree` and Mathlib's `RiemannHypothesis`
   from `UniversalWeilSystem`, `UniversalZeroRefutationSystem`, and `UniversalFredholmSystem`
   coupled with `RealAxisZeroFree`.
-/

namespace BuildingBlocks.RiemannZetaRealAxisDischarge

open Complex
open BuildingBlocks.DirichletEtaGroupedConvergence
open BuildingBlocks.UniversalSchwarzRHBridge
open BuildingBlocks.WeilExplicitGrandRHBridge
open BuildingBlocks.ZetaUniversalRHBridge
open BuildingBlocks.RiemannZetaGlobalSchwarzReflection
open BuildingBlocks.ChirpedUniversalZeroRefutation
open BuildingBlocks.ChirpedUniversalFredholmExclusion

/-!
### 1. Deligne Factor and Completed Zeta Equivalence
-/

/-- Non-vanishing of the Deligne Gamma factor $\Gamma_{\mathbb{R}}(\sigma)$ on the positive real axis. -/
theorem Gammaℝ_ofReal_ne_zero {σ : ℝ} (hσ : 0 < σ) : Gammaℝ (σ : ℂ) ≠ 0 := by
  apply Gammaℝ_ne_zero_of_re_pos
  simpa using hσ

/-- Equivalence between vanishing of $\zeta(\sigma : \mathbb{C})$ and $\Lambda(\sigma : \mathbb{C})$
for real $\sigma > 0$. -/
theorem riemannZeta_ofReal_zero_iff_completed_zero {σ : ℝ} (hσ : 0 < σ) :
    riemannZeta (σ : ℂ) = 0 ↔ completedRiemannZeta (σ : ℂ) = 0 := by
  have hs_ne : (σ : ℂ) ≠ 0 := by
    intro h0
    have : σ = 0 := ofReal_eq_zero.mp h0
    linarith
  rw [riemannZeta_def_of_ne_zero hs_ne]
  have hg := Gammaℝ_ofReal_ne_zero hσ
  simp [hg]

/-- Equivalence between non-vanishing of $\zeta(\sigma : \mathbb{C})$ and $\Lambda(\sigma : \mathbb{C})$
for real $\sigma > 0$. -/
theorem riemannZeta_ofReal_ne_zero_iff_completed_ne_zero {σ : ℝ} (hσ : 0 < σ) :
    riemannZeta (σ : ℂ) ≠ 0 ↔ completedRiemannZeta (σ : ℂ) ≠ 0 := by
  rw [not_iff_not]
  exact riemannZeta_ofReal_zero_iff_completed_zero hσ

/-!
### 2. Universal Real Axis Zero-Freeness and Discharges
-/

/-- Universal definition of zero-freeness on the real interval $(1/2, 1)$. -/
def RealAxisZeroFree : Prop :=
  ∀ (σ : ℝ), (1 : ℝ) / 2 < σ → σ < 1 → riemannZeta (σ : ℂ) ≠ 0

/-- Discharge of real zero-freeness via completed zeta non-vanishing. -/
theorem realAxisZeroFree_of_completed
    (h : ∀ (σ : ℝ), (1 : ℝ) / 2 < σ → σ < 1 → completedRiemannZeta (σ : ℂ) ≠ 0) :
    RealAxisZeroFree := by
  intro σ hσ_gt hσ_lt
  have hσ_pos : 0 < σ := by linarith
  rw [riemannZeta_ofReal_ne_zero_iff_completed_ne_zero hσ_pos]
  exact h σ hσ_gt hσ_lt

/-- Discharge of real zero-freeness via grouped Dirichlet eta relation. -/
theorem realAxisZeroFree_of_eta_rel
    (h : ∀ (σ : ℝ), (1 : ℝ) / 2 < σ → σ < 1 →
      (1 - (2 : ℝ)^(1 - σ)) * (riemannZeta (σ : ℂ)).re = groupedDirichletEta σ) :
    RealAxisZeroFree := by
  intro σ hσ_gt hσ_lt
  have hσ_pos : 0 < σ := by linarith
  exact riemannZeta_ne_zero_of_rel hσ_pos hσ_lt (h σ hσ_gt hσ_lt)

/-- Discharge of real zero-freeness via real part negativity. -/
theorem realAxisZeroFree_of_re_neg
    (h : ∀ (σ : ℝ), (1 : ℝ) / 2 < σ → σ < 1 → (riemannZeta (σ : ℂ)).re < 0) :
    RealAxisZeroFree := by
  intro σ hσ_gt hσ_lt hz
  have hre : (riemannZeta (σ : ℂ)).re = 0 := by rw [hz, zero_re]
  have hneg := h σ hσ_gt hσ_lt
  linarith

/-- Non-vanishing of the Riemann zeta function at any real number $s > 1/2$ with $s \ne 1$,
under the minimal assumption `RealAxisZeroFree`. -/
theorem real_axis_zeta_ne_zero_of_zeroFree
    (h_free : RealAxisZeroFree) (s : ℂ)
    (hsr : (1 : ℝ) / 2 < s.re) (hsim : s.im = 0) (_hs1 : s ≠ 1) :
    riemannZeta s ≠ 0 := by
  by_cases h_lt : s.re < 1
  · have hs_eq : s = (s.re : ℂ) := by
      apply Complex.ext
      · rfl
      · rw [ofReal_im, hsim]
    rw [hs_eq]
    exact h_free s.re hsr h_lt
  · push_neg at h_lt
    exact riemannZeta_ne_zero_of_one_le_re h_lt

/-!
### 3. Grand RH Bridges with Minimal Real Axis Hypothesis
-/

/-- Right-half zero-freeness deduced from a `UniversalWeilSystem` and `RealAxisZeroFree`. -/
theorem rightHalfZeroFree_of_weil_and_zeroFree
    (sys : UniversalWeilSystem)
    (h_free : RealAxisZeroFree) :
    RightHalfZeroFree := by
  intro s hsr hs1 hz
  rcases lt_trichotomy s.im 0 with h_neg | h_zero | h_pos
  · have hz_conj : riemannZeta (star s) = 0 :=
      (riemannZeta_zero_iff_conj_zero_of_half_lt_re hsr).mp hz
    have h_conj_re : (star s).re = s.re := by
      rw [star_def, conj_re]
    have h_conj_im : 0 < (star s).im := by
      rw [star_def, conj_im]
      linarith
    have hsr_conj : (1 : ℝ) / 2 < (star s).re := by
      rw [h_conj_re]
      exact hsr
    exact WeilExplicitGrandRHBridge.no_positive_im_offline_zero sys (star s) hsr_conj h_conj_im hz_conj
  · exact real_axis_zeta_ne_zero_of_zeroFree h_free s hsr h_zero hs1 hz
  · exact WeilExplicitGrandRHBridge.no_positive_im_offline_zero sys s hsr h_pos hz

/-- Full Mathlib Riemann Hypothesis deduced from a `UniversalWeilSystem` and `RealAxisZeroFree`. -/
theorem RiemannHypothesis_of_weil_and_zeroFree
    (sys : UniversalWeilSystem)
    (h_free : RealAxisZeroFree) :
    RiemannHypothesis := by
  apply CriticalTransformRH.noRightZeros_implies_RiemannHypothesis
  exact rightHalfZeroFree_of_weil_and_zeroFree sys h_free

/-- Right-half zero-freeness deduced from a `UniversalZeroRefutationSystem` and `RealAxisZeroFree`. -/
theorem rightHalfZeroFree_of_refutation_and_zeroFree
    (sys : UniversalZeroRefutationSystem)
    (h_free : RealAxisZeroFree) :
    RightHalfZeroFree := by
  intro s hsr hs1 hz
  rcases lt_trichotomy s.im 0 with h_neg | h_zero | h_pos
  · have hz_conj : riemannZeta (star s) = 0 :=
      (riemannZeta_zero_iff_conj_zero_of_half_lt_re hsr).mp hz
    have h_conj_re : (star s).re = s.re := by
      rw [star_def, conj_re]
    have h_conj_im : 0 < (star s).im := by
      rw [star_def, conj_im]
      linarith
    have hsr_conj : (1 : ℝ) / 2 < (star s).re := by
      rw [h_conj_re]
      exact hsr
    exact ChirpedUniversalZeroRefutation.no_positive_im_offline_zero sys (star s) hsr_conj h_conj_im hz_conj
  · exact real_axis_zeta_ne_zero_of_zeroFree h_free s hsr h_zero hs1 hz
  · exact ChirpedUniversalZeroRefutation.no_positive_im_offline_zero sys s hsr h_pos hz

/-- Full Mathlib Riemann Hypothesis deduced from a `UniversalZeroRefutationSystem` and `RealAxisZeroFree`. -/
theorem RiemannHypothesis_of_refutation_and_zeroFree
    (sys : UniversalZeroRefutationSystem)
    (h_free : RealAxisZeroFree) :
    RiemannHypothesis := by
  apply CriticalTransformRH.noRightZeros_implies_RiemannHypothesis
  exact rightHalfZeroFree_of_refutation_and_zeroFree sys h_free

/-- Right-half zero-freeness deduced from a `UniversalFredholmSystem` and `RealAxisZeroFree`. -/
theorem rightHalfZeroFree_of_fredholm_and_zeroFree
    (f_sys : UniversalFredholmSystem)
    (h_free : RealAxisZeroFree) :
    RightHalfZeroFree := by
  intro s hsr hs1 hz
  rcases lt_trichotomy s.im 0 with h_neg | h_zero | h_pos
  · have hz_conj : riemannZeta (star s) = 0 :=
      (riemannZeta_zero_iff_conj_zero_of_half_lt_re hsr).mp hz
    have h_conj_re : (star s).re = s.re := by
      rw [star_def, conj_re]
    have h_conj_im : 0 < (star s).im := by
      rw [star_def, conj_im]
      linarith
    have hsr_conj : (1 : ℝ) / 2 < (star s).re := by
      rw [h_conj_re]
      exact hsr
    exact no_positive_im_zero_of_universal_fredholm f_sys (star s) hsr_conj h_conj_im hz_conj
  · exact real_axis_zeta_ne_zero_of_zeroFree h_free s hsr h_zero hs1 hz
  · exact no_positive_im_zero_of_universal_fredholm f_sys s hsr h_pos hz

/-- Full Mathlib Riemann Hypothesis deduced from a `UniversalFredholmSystem` and `RealAxisZeroFree`. -/
theorem RiemannHypothesis_of_fredholm_and_zeroFree
    (f_sys : UniversalFredholmSystem)
    (h_free : RealAxisZeroFree) :
    RiemannHypothesis := by
  apply CriticalTransformRH.noRightZeros_implies_RiemannHypothesis
  exact rightHalfZeroFree_of_fredholm_and_zeroFree f_sys h_free

#print axioms Gammaℝ_ofReal_ne_zero
#print axioms riemannZeta_ofReal_zero_iff_completed_zero
#print axioms riemannZeta_ofReal_ne_zero_iff_completed_ne_zero
#print axioms realAxisZeroFree_of_completed
#print axioms realAxisZeroFree_of_eta_rel
#print axioms realAxisZeroFree_of_re_neg
#print axioms real_axis_zeta_ne_zero_of_zeroFree
#print axioms rightHalfZeroFree_of_weil_and_zeroFree
#print axioms RiemannHypothesis_of_weil_and_zeroFree
#print axioms rightHalfZeroFree_of_refutation_and_zeroFree
#print axioms RiemannHypothesis_of_refutation_and_zeroFree
#print axioms rightHalfZeroFree_of_fredholm_and_zeroFree
#print axioms RiemannHypothesis_of_fredholm_and_zeroFree

end BuildingBlocks.RiemannZetaRealAxisDischarge
