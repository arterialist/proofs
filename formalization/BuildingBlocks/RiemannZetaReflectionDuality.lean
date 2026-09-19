import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.RiemannZetaPoleCancellation
import BuildingBlocks.UniversalSchwarzRHBridge
import BuildingBlocks.RiemannZetaRealAxisDischarge
import BuildingBlocks.WeilExplicitGrandRHBridge
import BuildingBlocks.ChirpedUniversalZeroRefutation
import BuildingBlocks.ChirpedUniversalFredholmExclusion

/-!
# Riemann Zeta Real Reflection Duality and Left-Right Critical Equivalence

This module establishes the full real-axis reflection duality for both the completed
Riemann zeta function $\Lambda(s)$ and the uncompleted Riemann zeta function $\zeta(s)$
under the involution $\sigma \mapsto 1 - \sigma$, halving the verification domain
of real-axis zero-freeness from the full critical interval $(0, 1)$ to $(0, 1/2)$:

1. Vanishing of the imaginary part of $\Lambda_0$ on the entire real line:
   `completedRiemannZeta₀_ofReal_im_zero`, `completedRiemannZeta₀_ofReal_eq_re`.
2. Real functional equation for $\Lambda_0$ and $\Lambda$:
   `completedRiemannZeta₀_ofReal_one_sub`, `completedRiemannZeta_ofReal_one_sub`.
3. Invariant real part reflection:
   `completedRiemannZeta₀_ofReal_re_one_sub`, `completedRiemannZeta_ofReal_re_one_sub`.
4. Pointwise zero equivalence under reflection:
   `completedRiemannZeta_ofReal_zero_iff_one_sub`, `completedRiemannZeta_ofReal_ne_zero_iff_one_sub`.
5. Pointwise negative energy equivalence:
   `completedRiemannZeta_ofReal_re_neg_iff_one_sub`.
6. Uncompleted zeta zero equivalence on $(0, 1)$:
   `riemannZeta_ofReal_zero_iff_one_sub`, `riemannZeta_ofReal_ne_zero_iff_one_sub`.
7. Bi-directional interval equivalence:
   `left_half_zeta_zero_free_iff_right_half_zeta_zero_free`,
   `realAxisZeroFree_iff_left_half_zeta_zero_free`.
8. Master bridges deriving Mathlib's `RiemannHypothesis` from left-half non-vanishing:
   `RiemannHypothesis_of_weil_and_left_half_zero_free`,
   `RiemannHypothesis_of_refutation_and_left_half_zero_free`,
   `RiemannHypothesis_of_fredholm_and_left_half_zero_free`.

All declarations compile with Lean 4.24.0 and depend strictly on the three standard
foundational axioms: `[propext, Classical.choice, Quot.sound]`.
-/

namespace BuildingBlocks.RiemannZetaReflectionDuality

open Complex
open BuildingBlocks.UniversalSchwarzRHBridge
open BuildingBlocks.RiemannZetaRealAxisDischarge
open BuildingBlocks.RiemannZetaPoleCancellation
open BuildingBlocks.WeilExplicitGrandRHBridge
open BuildingBlocks.ChirpedUniversalZeroRefutation
open BuildingBlocks.ChirpedUniversalFredholmExclusion

noncomputable section

/-! ### 1. Real Properties of Modified Completed Zeta Function -/

/-- The modified completed Riemann zeta function $\Lambda_0(\sigma : \mathbb{C})$ has
vanishing imaginary part on the entire real line $\mathbb{R}$. -/
theorem completedRiemannZeta₀_ofReal_im_zero (σ : ℝ) :
    (completedRiemannZeta₀ (σ : ℂ)).im = 0 := by
  have h_eq : completedRiemannZeta₀ (σ : ℂ) =
      completedRiemannZeta (σ : ℂ) + (((1 / σ + 1 / (1 - σ) : ℝ)) : ℂ) := by
    have h := completedRiemannZeta_ofReal_eq σ
    linear_combination -h
  rw [h_eq]
  have h_zeta_im := completedRiemannZeta_ofReal_im_zero σ
  simp only [add_im, ofReal_im, add_zero]
  exact h_zeta_im

/-- The modified completed Riemann zeta function $\Lambda_0(\sigma : \mathbb{C})$ is equal
to its real part on the real line. -/
theorem completedRiemannZeta₀_ofReal_eq_re (σ : ℝ) :
    completedRiemannZeta₀ (σ : ℂ) = (completedRiemannZeta₀ (σ : ℂ)).re := by
  apply Complex.ext
  · simp
  · rw [completedRiemannZeta₀_ofReal_im_zero σ, ofReal_im]

/-! ### 2. Real Reflection Functional Equations -/

/-- Functional equation for $\Lambda_0$ on the real line: $\Lambda_0(1 - \sigma) = \Lambda_0(\sigma)$. -/
theorem completedRiemannZeta₀_ofReal_one_sub (σ : ℝ) :
    completedRiemannZeta₀ ((1 - σ : ℝ) : ℂ) = completedRiemannZeta₀ (σ : ℂ) := by
  have h_cast : ((1 - σ : ℝ) : ℂ) = 1 - (σ : ℂ) := by push_cast; rfl
  rw [h_cast]
  exact completedRiemannZeta₀_one_sub (σ : ℂ)

/-- Real part symmetry of $\Lambda_0$ under reflection:
$\operatorname{Re}(\Lambda_0(1 - \sigma)) = \operatorname{Re}(\Lambda_0(\sigma))$. -/
theorem completedRiemannZeta₀_ofReal_re_one_sub (σ : ℝ) :
    (completedRiemannZeta₀ ((1 - σ : ℝ) : ℂ)).re = (completedRiemannZeta₀ (σ : ℂ)).re := by
  rw [completedRiemannZeta₀_ofReal_one_sub σ]

/-- Functional equation for $\Lambda$ on the real line: $\Lambda(1 - \sigma) = \Lambda(\sigma)$. -/
theorem completedRiemannZeta_ofReal_one_sub (σ : ℝ) :
    completedRiemannZeta ((1 - σ : ℝ) : ℂ) = completedRiemannZeta (σ : ℂ) := by
  have h_cast : ((1 - σ : ℝ) : ℂ) = 1 - (σ : ℂ) := by push_cast; rfl
  rw [h_cast]
  exact completedRiemannZeta_one_sub (σ : ℂ)

/-- Real part symmetry of $\Lambda$ under reflection:
$\operatorname{Re}(\Lambda(1 - \sigma)) = \operatorname{Re}(\Lambda(\sigma))$. -/
theorem completedRiemannZeta_ofReal_re_one_sub (σ : ℝ) :
    (completedRiemannZeta ((1 - σ : ℝ) : ℂ)).re = (completedRiemannZeta (σ : ℂ)).re := by
  rw [completedRiemannZeta_ofReal_one_sub σ]

/-- Zero equivalence of $\Lambda$ under real reflection:
$\Lambda(\sigma) = 0 \iff \Lambda(1 - \sigma) = 0$. -/
theorem completedRiemannZeta_ofReal_zero_iff_one_sub (σ : ℝ) :
    completedRiemannZeta (σ : ℂ) = 0 ↔ completedRiemannZeta ((1 - σ : ℝ) : ℂ) = 0 := by
  rw [completedRiemannZeta_ofReal_one_sub σ]

/-- Non-vanishing equivalence of $\Lambda$ under real reflection:
$\Lambda(\sigma) \ne 0 \iff \Lambda(1 - \sigma) \ne 0$. -/
theorem completedRiemannZeta_ofReal_ne_zero_iff_one_sub (σ : ℝ) :
    completedRiemannZeta (σ : ℂ) ≠ 0 ↔ completedRiemannZeta ((1 - σ : ℝ) : ℂ) ≠ 0 := by
  rw [completedRiemannZeta_ofReal_one_sub σ]

/-- Real part negativity equivalence of $\Lambda$ under real reflection:
$\operatorname{Re}(\Lambda(\sigma)) < 0 \iff \operatorname{Re}(\Lambda(1 - \sigma)) < 0$. -/
theorem completedRiemannZeta_ofReal_re_neg_iff_one_sub (σ : ℝ) :
    (completedRiemannZeta (σ : ℂ)).re < 0 ↔ (completedRiemannZeta ((1 - σ : ℝ) : ℂ)).re < 0 := by
  rw [completedRiemannZeta_ofReal_re_one_sub σ]

/-! ### 3. Uncompleted Riemann Zeta Real Reflection Equivalence -/

/-- Pointwise zero equivalence of $\zeta$ under real reflection on the unit interval $(0, 1)$:
$\zeta(\sigma) = 0 \iff \zeta(1 - \sigma) = 0$. -/
theorem riemannZeta_ofReal_zero_iff_one_sub {σ : ℝ} (hσ0 : 0 < σ) (hσ1 : σ < 1) :
    riemannZeta (σ : ℂ) = 0 ↔ riemannZeta ((1 - σ : ℝ) : ℂ) = 0 := by
  have h_sub0 : 0 < 1 - σ := by linarith
  rw [riemannZeta_ofReal_zero_iff_completed_zero hσ0]
  rw [riemannZeta_ofReal_zero_iff_completed_zero h_sub0]
  exact completedRiemannZeta_ofReal_zero_iff_one_sub σ

/-- Pointwise non-vanishing equivalence of $\zeta$ under real reflection on $(0, 1)$:
$\zeta(\sigma) \ne 0 \iff \zeta(1 - \sigma) \ne 0$. -/
theorem riemannZeta_ofReal_ne_zero_iff_one_sub {σ : ℝ} (hσ0 : 0 < σ) (hσ1 : σ < 1) :
    riemannZeta (σ : ℂ) ≠ 0 ↔ riemannZeta ((1 - σ : ℝ) : ℂ) ≠ 0 := by
  have h := riemannZeta_ofReal_zero_iff_one_sub hσ0 hσ1
  exact not_congr h

/-! ### 4. Left-Right Interval Duality and Discharge of Real Axis Zero-Freeness -/

/-- Zero-freeness of $\Lambda$ on the left half-interval $(0, 1/2)$ implies
zero-freeness on the right half-interval $(1/2, 1)$ (`RealAxisZeroFree`). -/
theorem realAxisZeroFree_of_left_half_zero_free
    (h_left : ∀ σ : ℝ, 0 < σ → σ < 1 / 2 → completedRiemannZeta (σ : ℂ) ≠ 0) :
    RealAxisZeroFree := by
  apply realAxisZeroFree_of_completed
  intro σ hσ_half hσ1
  have h_sub0 : 0 < 1 - σ := by linarith
  have h_sub_half : 1 - σ < 1 / 2 := by linarith
  have h_nz := h_left (1 - σ) h_sub0 h_sub_half
  have h_eq := completedRiemannZeta_ofReal_one_sub σ
  rwa [h_eq] at h_nz

/-- Zero-freeness of $\zeta$ on the left half-interval $(0, 1/2)$ implies
zero-freeness on the right half-interval $(1/2, 1)$ (`RealAxisZeroFree`). -/
theorem realAxisZeroFree_of_left_half_zeta_zero_free
    (h_left : ∀ σ : ℝ, 0 < σ → σ < 1 / 2 → riemannZeta (σ : ℂ) ≠ 0) :
    RealAxisZeroFree := by
  apply realAxisZeroFree_of_left_half_zero_free
  intro σ hσ0 hσ_half
  have h_zeta := h_left σ hσ0 hσ_half
  rwa [← riemannZeta_ofReal_ne_zero_iff_completed_ne_zero hσ0]

/-- Bi-directional equivalence between zero-freeness of $\zeta$ on the left half-interval $(0, 1/2)$
and the right half-interval $(1/2, 1)$. -/
theorem left_half_zeta_zero_free_iff_right_half_zeta_zero_free :
    (∀ σ : ℝ, 0 < σ → σ < 1 / 2 → riemannZeta (σ : ℂ) ≠ 0) ↔
    (∀ σ : ℝ, 1 / 2 < σ → σ < 1 → riemannZeta (σ : ℂ) ≠ 0) := by
  constructor
  · intro h_left σ hσ_half hσ1
    have hσ0 : 0 < σ := by linarith
    have h_sub0 : 0 < 1 - σ := by linarith
    have h_sub_half : 1 - σ < 1 / 2 := by linarith
    have h_nz := h_left (1 - σ) h_sub0 h_sub_half
    rw [riemannZeta_ofReal_ne_zero_iff_one_sub hσ0 hσ1]
    exact h_nz
  · intro h_right σ hσ0 hσ_half
    have hσ1 : σ < 1 := by linarith
    have h_sub_half : 1 / 2 < 1 - σ := by linarith
    have h_sub1 : 1 - σ < 1 := by linarith
    have h_nz := h_right (1 - σ) h_sub_half h_sub1
    have h_sub0 : 0 < 1 - σ := by linarith
    have h_iff := riemannZeta_ofReal_ne_zero_iff_one_sub h_sub0 h_sub1
    have h_res := h_iff.mp h_nz
    have h_cancel : (1 - (1 - σ) : ℝ) = σ := sub_sub_cancel 1 σ
    rwa [h_cancel] at h_res

/-- Universal equivalence between `RealAxisZeroFree` and zero-freeness of $\zeta$ on $(0, 1/2)$. -/
theorem realAxisZeroFree_iff_left_half_zeta_zero_free :
    RealAxisZeroFree ↔ (∀ σ : ℝ, 0 < σ → σ < 1 / 2 → riemannZeta (σ : ℂ) ≠ 0) := by
  have h := left_half_zeta_zero_free_iff_right_half_zeta_zero_free
  exact ⟨fun h_right ↦ h.mpr (fun σ h1 h2 ↦ h_right σ h1 h2),
         fun h_left ↦ realAxisZeroFree_of_left_half_zeta_zero_free h_left⟩

/-! ### 5. Master Riemann Hypothesis Reductions from Left-Half Zero-Freeness -/

/-- Master deduction of Mathlib's `RiemannHypothesis` from the `UniversalWeilSystem`
under zero-freeness on the left critical half-interval $(0, 1/2)$. -/
theorem RiemannHypothesis_of_weil_and_left_half_zero_free
    (W : UniversalWeilSystem)
    (h_left : ∀ σ : ℝ, 0 < σ → σ < 1 / 2 → riemannZeta (σ : ℂ) ≠ 0) :
    RiemannHypothesis := by
  have hz := realAxisZeroFree_of_left_half_zeta_zero_free h_left
  exact RiemannHypothesis_of_weil_and_zeroFree W hz

/-- Master deduction of Mathlib's `RiemannHypothesis` from the `UniversalZeroRefutationSystem`
under zero-freeness on the left critical half-interval $(0, 1/2)$. -/
theorem RiemannHypothesis_of_refutation_and_left_half_zero_free
    (R : UniversalZeroRefutationSystem)
    (h_left : ∀ σ : ℝ, 0 < σ → σ < 1 / 2 → riemannZeta (σ : ℂ) ≠ 0) :
    RiemannHypothesis := by
  have hz := realAxisZeroFree_of_left_half_zeta_zero_free h_left
  exact RiemannHypothesis_of_refutation_and_zeroFree R hz

/-- Master deduction of Mathlib's `RiemannHypothesis` from the `UniversalFredholmSystem`
under zero-freeness on the left critical half-interval $(0, 1/2)$. -/
theorem RiemannHypothesis_of_fredholm_and_left_half_zero_free
    (F : UniversalFredholmSystem)
    (h_left : ∀ σ : ℝ, 0 < σ → σ < 1 / 2 → riemannZeta (σ : ℂ) ≠ 0) :
    RiemannHypothesis := by
  have hz := realAxisZeroFree_of_left_half_zeta_zero_free h_left
  exact RiemannHypothesis_of_fredholm_and_zeroFree F hz

end

#print axioms completedRiemannZeta₀_ofReal_im_zero
#print axioms completedRiemannZeta₀_ofReal_eq_re
#print axioms completedRiemannZeta₀_ofReal_one_sub
#print axioms completedRiemannZeta_ofReal_one_sub
#print axioms completedRiemannZeta_ofReal_zero_iff_one_sub
#print axioms completedRiemannZeta_ofReal_ne_zero_iff_one_sub
#print axioms riemannZeta_ofReal_zero_iff_one_sub
#print axioms riemannZeta_ofReal_ne_zero_iff_one_sub
#print axioms realAxisZeroFree_of_left_half_zero_free
#print axioms realAxisZeroFree_of_left_half_zeta_zero_free
#print axioms left_half_zeta_zero_free_iff_right_half_zeta_zero_free
#print axioms realAxisZeroFree_iff_left_half_zeta_zero_free
#print axioms RiemannHypothesis_of_weil_and_left_half_zero_free
#print axioms RiemannHypothesis_of_refutation_and_left_half_zero_free
#print axioms RiemannHypothesis_of_fredholm_and_left_half_zero_free

end BuildingBlocks.RiemannZetaReflectionDuality
