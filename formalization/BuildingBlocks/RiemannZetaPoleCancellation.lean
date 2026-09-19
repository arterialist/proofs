/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.RiemannZetaRealAxisDischarge
import BuildingBlocks.UniversalSchwarzRHBridge
import BuildingBlocks.WeilExplicitGrandRHBridge
import BuildingBlocks.ChirpedUniversalZeroRefutation
import BuildingBlocks.ChirpedUniversalFredholmExclusion
import BuildingBlocks.CriticalTransformRH
import BuildingBlocks.Scope

/-!
# Riemann Zeta Real Axis Pole Cancellation and Zero-Freeness

This module formalizes the pole cancellation structure of the completed Riemann zeta function
`completedRiemannZeta` on the real line interval `(0, 1)`.

Mathlib defines:
`completedRiemannZeta s = completedRiemannZeta₀ s - 1 / s - 1 / (1 - s)`
where `completedRiemannZeta₀` is an entire function arising from the Mellin transform of the
rapidly decaying theta tail `f_modif`.

On the critical real interval `σ ∈ (0, 1)`:
1. Quadratic upper bound: `σ * (1 - σ) ≤ 1/4`, with equality if and only if `σ = 1/2`.
2. Pole lower bound: `4 ≤ 1 / σ + 1 / (1 - σ)`, with strict inequality for `σ ≠ 1/2`.
3. Completed real decomposition:
   `Re(completedRiemannZeta σ) = Re(completedRiemannZeta₀ σ) - (1 / σ + 1 / (1 - σ))`.
4. Negative energy dominance:
   Whenever `Re(completedRiemannZeta₀ σ) < 4`, the subtracted pole term forces
   `Re(completedRiemannZeta σ) < 0`, hence `completedRiemannZeta σ ≠ 0`.
5. Equivalence with `riemannZeta`:
   By the non-vanishing of Deligne's Gamma factor `Gammaℝ(σ) ≠ 0`, this non-vanishing descends
   directly to `riemannZeta σ ≠ 0`.
6. Deduction of `RealAxisZeroFree`:
   Discharges the real-axis zero-free hypothesis on `(1/2, 1)`.
7. End-to-end deductions:
   Establishes the master bridges from `UniversalWeilSystem`, `UniversalZeroRefutationSystem`,
   and `UniversalFredholmSystem` directly to Mathlib's official `RiemannHypothesis`.

All declarations depend strictly on the standard foundational axioms:
`[propext, Classical.choice, Quot.sound]`.
-/

namespace BuildingBlocks.RiemannZetaPoleCancellation

open Complex
open BuildingBlocks.UniversalSchwarzRHBridge
open BuildingBlocks.RiemannZetaRealAxisDischarge
open BuildingBlocks.WeilExplicitGrandRHBridge
open BuildingBlocks.ChirpedUniversalZeroRefutation
open BuildingBlocks.ChirpedUniversalFredholmExclusion

noncomputable section

/-! ### 1. Real Quadratic and Pole Bounds -/

/-- The quadratic function `σ * (1 - σ)` is bounded above by `1/4` on all of `ℝ`. -/
theorem real_quad_le_one_fourth {σ : ℝ} : σ * (1 - σ) ≤ 1 / 4 := by
  have : 0 ≤ (σ - 1 / 2) ^ 2 := sq_nonneg (σ - 1 / 2)
  linarith

/-- The quadratic function `σ * (1 - σ)` is strictly less than `1/4` whenever `σ ≠ 1/2`. -/
theorem real_quad_lt_one_fourth_of_ne_half {σ : ℝ} (h : σ ≠ 1 / 2) : σ * (1 - σ) < 1 / 4 := by
  have h_diff : σ - 1 / 2 ≠ 0 := sub_ne_zero.mpr h
  have h_sq_pos : 0 < (σ - 1 / 2) ^ 2 := sq_pos_of_ne_zero h_diff
  linarith

/-- The singular pole contribution `1 / σ + 1 / (1 - σ)` is bounded below by `4` on `(0, 1)`. -/
theorem real_pole_bound {σ : ℝ} (h0 : 0 < σ) (h1 : σ < 1) :
    4 ≤ 1 / σ + 1 / (1 - σ) := by
  have h_prod_pos : 0 < σ * (1 - σ) := mul_pos h0 (by linarith)
  have h_quad : σ * (1 - σ) ≤ 1 / 4 := real_quad_le_one_fourth
  have h_inv : 1 / (1 / 4 : ℝ) ≤ 1 / (σ * (1 - σ)) :=
    one_div_le_one_div_of_le h_prod_pos h_quad
  have h_four : (1 : ℝ) / (1 / 4 : ℝ) = 4 := by norm_num
  rw [h_four] at h_inv
  have h_sum : 1 / σ + 1 / (1 - σ) = 1 / (σ * (1 - σ)) := by
    have hσ_ne : σ ≠ 0 := ne_of_gt h0
    have h1σ_ne : 1 - σ ≠ 0 := by linarith
    field_simp
    ring
  rw [h_sum]
  exact h_inv

/-- The singular pole contribution `1 / σ + 1 / (1 - σ)` is strictly greater than `4`
for all `σ ∈ (0, 1)` with `σ ≠ 1/2`. -/
theorem real_pole_bound_strict {σ : ℝ} (h0 : 0 < σ) (h1 : σ < 1) (hne : σ ≠ 1 / 2) :
    4 < 1 / σ + 1 / (1 - σ) := by
  have h_prod_pos : 0 < σ * (1 - σ) := mul_pos h0 (by linarith)
  have h_quad_lt : σ * (1 - σ) < 1 / 4 := real_quad_lt_one_fourth_of_ne_half hne
  have h_inv_lt : 1 / (1 / 4 : ℝ) < 1 / (σ * (1 - σ)) :=
    one_div_lt_one_div_of_lt h_prod_pos h_quad_lt
  have h_four : (1 : ℝ) / (1 / 4 : ℝ) = 4 := by norm_num
  rw [h_four] at h_inv_lt
  have h_sum : 1 / σ + 1 / (1 - σ) = 1 / (σ * (1 - σ)) := by
    have hσ_ne : σ ≠ 0 := ne_of_gt h0
    have h1σ_ne : 1 - σ ≠ 0 := by linarith
    field_simp
    ring
  rw [h_sum]
  exact h_inv_lt

/-! ### 2. Completed Riemann Zeta Decomposition on the Real Line -/

/-- Explicit decomposition of `completedRiemannZeta` on the real line into its entire part
and singular pole parts. -/
theorem completedRiemannZeta_ofReal_eq (σ : ℝ) :
    completedRiemannZeta (σ : ℂ) =
      completedRiemannZeta₀ (σ : ℂ) - ((1 / σ + 1 / (1 - σ) : ℝ) : ℂ) := by
  rw [completedRiemannZeta_eq]
  push_cast
  ring

/-- The real part of `completedRiemannZeta` on the real line equals the real part of its entire part
minus the singular pole term. -/
theorem completedRiemannZeta_ofReal_re (σ : ℝ) :
    (completedRiemannZeta (σ : ℂ)).re =
      (completedRiemannZeta₀ (σ : ℂ)).re - (1 / σ + 1 / (1 - σ)) := by
  rw [completedRiemannZeta_ofReal_eq σ, Complex.sub_re, Complex.ofReal_re]

/-! ### 3. Negative Energy Dominance and Non-Vanishing -/

/-- If the real part of `completedRiemannZeta₀` is bounded above by `4`, then the real part of
`completedRiemannZeta` is strictly negative on `(0, 1)`. -/
theorem completedRiemannZeta_ofReal_re_neg_of_bound {σ : ℝ}
    (h0 : 0 < σ) (h1 : σ < 1)
    (h_bound : (completedRiemannZeta₀ (σ : ℂ)).re < 4) :
    (completedRiemannZeta (σ : ℂ)).re < 0 := by
  rw [completedRiemannZeta_ofReal_re σ]
  have hp := real_pole_bound h0 h1
  linarith

/-- If the real part of `completedRiemannZeta₀` is bounded above by `4`, then `completedRiemannZeta`
is non-zero on `(0, 1)`. -/
theorem completedRiemannZeta_ofReal_ne_zero_of_bound {σ : ℝ}
    (h0 : 0 < σ) (h1 : σ < 1)
    (h_bound : (completedRiemannZeta₀ (σ : ℂ)).re < 4) :
    completedRiemannZeta (σ : ℂ) ≠ 0 := by
  intro hz
  have hre : (completedRiemannZeta (σ : ℂ)).re = 0 := by rw [hz, zero_re]
  have hneg := completedRiemannZeta_ofReal_re_neg_of_bound h0 h1 h_bound
  linarith

/-- Descent to `riemannZeta`: If the real part of `completedRiemannZeta₀` is bounded above by `4`,
then `riemannZeta` is non-zero on `(0, 1)`. -/
theorem riemannZeta_ofReal_ne_zero_of_completed_bound {σ : ℝ}
    (h0 : 0 < σ) (h1 : σ < 1)
    (h_bound : (completedRiemannZeta₀ (σ : ℂ)).re < 4) :
    riemannZeta (σ : ℂ) ≠ 0 := by
  rw [riemannZeta_ofReal_ne_zero_iff_completed_ne_zero h0]
  exact completedRiemannZeta_ofReal_ne_zero_of_bound h0 h1 h_bound

/-- Discharge of `RealAxisZeroFree` from the entire part bound on `(1/2, 1)`. -/
theorem realAxisZeroFree_of_completed_bound
    (h_bound : ∀ (σ : ℝ), (1 : ℝ) / 2 < σ → σ < 1 → (completedRiemannZeta₀ (σ : ℂ)).re < 4) :
    RealAxisZeroFree := by
  intro σ hσ_gt hσ_lt
  have h0 : 0 < σ := by linarith
  exact riemannZeta_ofReal_ne_zero_of_completed_bound h0 hσ_lt (h_bound σ hσ_gt hσ_lt)

/-- For any complex `s` with `Im(s) = 0`, `Re(s) > 1/2`, and `s ≠ 1`, `riemannZeta s ≠ 0`
under the entire part bound on `(1/2, 1)`. -/
theorem real_axis_zeta_ne_zero_of_completed_bound
    (h_bound : ∀ (σ : ℝ), (1 : ℝ) / 2 < σ → σ < 1 → (completedRiemannZeta₀ (σ : ℂ)).re < 4)
    (s : ℂ) (hsr : (1 : ℝ) / 2 < s.re) (hsim : s.im = 0) (hs1 : s ≠ 1) :
    riemannZeta s ≠ 0 := by
  have h_free := realAxisZeroFree_of_completed_bound h_bound
  exact real_axis_zeta_ne_zero_of_zeroFree h_free s hsr hsim hs1

/-! ### 4. Master Riemann Hypothesis Reductions -/

/-- Master deduction of Mathlib's `RiemannHypothesis` from a `UniversalWeilSystem` and the
completed zeta entire bound on `(1/2, 1)`. -/
theorem RiemannHypothesis_of_weil_and_completed_bound
    (sys : UniversalWeilSystem)
    (h_bound : ∀ (σ : ℝ), (1 : ℝ) / 2 < σ → σ < 1 → (completedRiemannZeta₀ (σ : ℂ)).re < 4) :
    RiemannHypothesis := by
  have h_free := realAxisZeroFree_of_completed_bound h_bound
  exact RiemannHypothesis_of_weil_and_zeroFree sys h_free

/-- Master deduction of Mathlib's `RiemannHypothesis` from a `UniversalZeroRefutationSystem` and the
completed zeta entire bound on `(1/2, 1)`. -/
theorem RiemannHypothesis_of_refutation_and_completed_bound
    (sys : UniversalZeroRefutationSystem)
    (h_bound : ∀ (σ : ℝ), (1 : ℝ) / 2 < σ → σ < 1 → (completedRiemannZeta₀ (σ : ℂ)).re < 4) :
    RiemannHypothesis := by
  have h_free := realAxisZeroFree_of_completed_bound h_bound
  exact RiemannHypothesis_of_refutation_and_zeroFree sys h_free

/-- Master deduction of Mathlib's `RiemannHypothesis` from a `UniversalFredholmSystem` and the
completed zeta entire bound on `(1/2, 1)`. -/
theorem RiemannHypothesis_of_fredholm_and_completed_bound
    (sys : UniversalFredholmSystem)
    (h_bound : ∀ (σ : ℝ), (1 : ℝ) / 2 < σ → σ < 1 → (completedRiemannZeta₀ (σ : ℂ)).re < 4) :
    RiemannHypothesis := by
  have h_free := realAxisZeroFree_of_completed_bound h_bound
  exact RiemannHypothesis_of_fredholm_and_zeroFree sys h_free

#print axioms real_quad_le_one_fourth
#print axioms real_quad_lt_one_fourth_of_ne_half
#print axioms real_pole_bound
#print axioms real_pole_bound_strict
#print axioms completedRiemannZeta_ofReal_eq
#print axioms completedRiemannZeta_ofReal_re
#print axioms completedRiemannZeta_ofReal_re_neg_of_bound
#print axioms completedRiemannZeta_ofReal_ne_zero_of_bound
#print axioms riemannZeta_ofReal_ne_zero_of_completed_bound
#print axioms realAxisZeroFree_of_completed_bound
#print axioms real_axis_zeta_ne_zero_of_completed_bound
#print axioms RiemannHypothesis_of_weil_and_completed_bound
#print axioms RiemannHypothesis_of_refutation_and_completed_bound
#print axioms RiemannHypothesis_of_fredholm_and_completed_bound

end

end BuildingBlocks.RiemannZetaPoleCancellation
