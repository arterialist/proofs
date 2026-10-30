/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import Mathlib.Analysis.Complex.Basic
import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.Target
import BuildingBlocks.ActualCriticalMellin
import BuildingBlocks.ActualFullCenteredMellin
import BuildingBlocks.ActualCriticalGrowthCriterion
import BuildingBlocks.SelbergDistinctPrimes
import BuildingBlocks.CriticalTransformPoles
import BuildingBlocks.CriticalTransformRH
import BuildingBlocks.RiemannZetaGrandEquivalence

/-!
# Module 322: Prime-Allocation Positivity and Centered Fluctuation Growth Bridge

This module establishes the unconditional non-negativity of the diagonal same-prime
allocation $\operatorname{allocation}(x) \ge 0$, the unconditional pointwise dominance

$$\operatorname{Re}(\mathcal{W}(x)) \le \operatorname{Re}(\operatorname{fullNumerator}(x)),$$

and reduces the Riemann Hypothesis to an eventual one-sided growth bound on the
centered fluctuation sum alone:

$$\left(\forallᶠ x \text{ in } \operatorname{atTop}, \operatorname{Re}(\operatorname{fullNumerator}(x)) \le C x^{3/2}\right) \implies \text{RiemannHypothesis}$$

for any real constant $C$.

### Key Structural Identities:
1. `T_re_nonneg`: The same-prime quadratic Riesz weight $T(u) = \sum_{n \le u} (u - n) \Lambda_{\text{same}}(n)$ satisfies $\operatorname{Re}(T(u)) \ge 0$ for all $u \in \mathbb{R}$.
2. `allocation_re_nonneg`: The aggregated proper-power allocation satisfies $\operatorname{Re}(\operatorname{allocation}(x)) \ge 0$ for all $x \in \mathbb{R}$.
3. `W_re_le_fullNumerator_re`: From $\mathcal{W}(x) = \operatorname{fullNumerator}(x) - \operatorname{allocation}(x)$, the real part satisfies $\operatorname{Re}(\mathcal{W}(x)) \le \operatorname{Re}(\operatorname{fullNumerator}(x))$ pointwise.
4. `RiemannHypothesis_of_eventually_fullNumerator_growth`: Any one-sided bound $\operatorname{Re}(\operatorname{fullNumerator}(x)) \le C x^{3/2}$ on centered prime fluctuations at infinity forces `RiemannHypothesis` unconditionally.
5. `grand_rh_bundle_of_eventually_fullNumerator_growth`: Simultaneously derives all 10 grand RH representations from fluctuation growth.

All theorems are machine-checked with 0 `sorry`, 0 `sorryAx`, and depend strictly on
the standard Lean 4 foundational axioms `[propext, Classical.choice, Quot.sound]`.
-/

namespace BuildingBlocks.RiemannZetaPrimeAllocationGrowth

open Filter
open scoped BigOperators Topology
open BuildingBlocks
open BuildingBlocks.ActualCenteredMellin
open BuildingBlocks.ActualFullCenteredMellin
open BuildingBlocks.ActualCriticalGrowthCriterion
open BuildingBlocks.RiemannZetaGrandEquivalence
open BuildingBlocks.RightOfflineContradiction
open BuildingBlocks.RiemannZetaDisplacementIntegralRefutation

/-! ### Positivity of the Same-Prime Allocation -/

/-- The same-prime Riesz-smoothed kernel T has non-negative real part for all x. -/
theorem T_re_nonneg (x : ℝ) : 0 ≤ (ActualCenteredMellin.T x).re := by
  by_cases hx : x ≤ 1
  · rw [T_zero hx]
    simp
  · have h1 : 1 < x := lt_of_not_ge hx
    have hx0 : 0 ≤ x := by linarith
    have hT := T_eq_real_cutoff hx0
    rw [hT]
    simp only [Complex.ofReal_re]
    apply Finset.sum_nonneg
    intro n hn
    simp only [Finset.mem_Icc] at hn
    have hnx : (n : ℝ) ≤ x := by
      have hcast : (n : ℝ) ≤ (⌊x⌋₊ : ℝ) := by exact_mod_cast hn.2
      exact hcast.trans (Nat.floor_le hx0)
    have hdiff : 0 ≤ x - (n : ℝ) := sub_nonneg.mpr hnx
    exact mul_nonneg hdiff (samePrimePairWeight_nonneg n)

/-- The complete proper-power allocation sum has non-negative real part for all x. -/
theorem allocation_re_nonneg (x : ℝ) : 0 ≤ (ActualFullCenteredMellin.allocation x).re := by
  by_cases hx : x ≤ 1
  · rw [allocation_zero hx]
    simp
  · rw [allocation_eq_real_sum]
    simp only [Complex.ofReal_re]
    apply Finset.sum_nonneg
    intro d hd
    exact mul_nonneg (Real.sqrt_nonneg _) (T_re_nonneg (x / d))

/-! ### Pointwise Domination of the Critical Kernel -/

/-- Pointwise inequality: The real part of the critical transform kernel W is bounded
above by the centered fluctuation numerator fullNumerator for all real x. -/
theorem W_re_le_fullNumerator_re (x : ℝ) :
    (ActualCriticalMellin.W x).re ≤ (ActualFullCenteredMellin.fullNumerator x).re := by
  rw [ActualFullCenteredMellin.W_eq_fullNumerator_sub_allocation]
  simp only [Complex.sub_re]
  have ha := allocation_re_nonneg x
  linarith

/-! ### Reduction of the Riemann Hypothesis to Centered Fluctuation Growth -/

/-- Cutoff form: A one-sided bound `fullNumerator(x).re ≤ C x^{3/2}` for all `x > A`
with threshold `A ≥ 1` implies the Riemann Hypothesis unconditionally. -/
theorem RiemannHypothesis_of_fullNumerator_growth_after {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualFullCenteredMellin.fullNumerator x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    RiemannHypothesis := by
  have hW : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2) := by
    intro x hx
    exact (W_re_le_fullNumerator_re x).trans (hgrow x hx)
  exact ActualCriticalGrowthCriterion.RiemannHypothesis_of_growth_after hA hW

/-- Filter form: Eventual domination `fullNumerator(x).re ≤ C x^{3/2}` at infinity
implies the Riemann Hypothesis unconditionally for any real constant C. -/
theorem RiemannHypothesis_of_eventually_fullNumerator_growth {C : ℝ}
    (hgrow : ∀ᶠ x : ℝ in atTop, (ActualFullCenteredMellin.fullNumerator x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    RiemannHypothesis := by
  have hW : ∀ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2) := by
    filter_upwards [hgrow] with x hx
    exact (W_re_le_fullNumerator_re x).trans hx
  exact ActualCriticalGrowthCriterion.RiemannHypothesis_of_eventually_growth hW

/-- Global analyticity of the filled transform on `{s | 1/2 < s.re}` follows from
eventual one-sided growth of the centered fluctuation numerator. -/
theorem analyticOnNhd_filledTransform_of_eventually_fullNumerator_growth {C : ℝ}
    (hgrow : ∀ᶠ x : ℝ in atTop, (ActualFullCenteredMellin.fullNumerator x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    AnalyticOnNhd ℂ CriticalTransformPoles.filledTransform {s : ℂ | (1 : ℝ) / 2 < s.re} := by
  have hrh := RiemannHypothesis_of_eventually_fullNumerator_growth hgrow
  exact rh_iff_analyticOnNhd_filledTransform.mp hrh

/-- Mathlib's canonical `Target` follows from eventual centered fluctuation growth. -/
theorem target_of_eventually_fullNumerator_growth {C : ℝ}
    (hgrow : ∀ᶠ x : ℝ in atTop, (ActualFullCenteredMellin.fullNumerator x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    Target := by
  have hrh := RiemannHypothesis_of_eventually_fullNumerator_growth hgrow
  exact rh_iff_target.mp hrh

/-- Right half-plane zero-freeness follows from eventual centered fluctuation growth. -/
theorem rightHalfZeroFree_of_eventually_fullNumerator_growth {C : ℝ}
    (hgrow : ∀ᶠ x : ℝ in atTop, (ActualFullCenteredMellin.fullNumerator x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    RightHalfZeroFree := by
  have hrh := RiemannHypothesis_of_eventually_fullNumerator_growth hgrow
  exact rh_iff_rightHalfZeroFree.mp hrh

/-- Emptiness of `RightOfflineSupport` follows from eventual centered fluctuation growth. -/
theorem rightOfflineSupport_empty_of_eventually_fullNumerator_growth {C : ℝ}
    (hgrow : ∀ᶠ x : ℝ in atTop, (ActualFullCenteredMellin.fullNumerator x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    RightOfflineSupport = ∅ := by
  have hrh := RiemannHypothesis_of_eventually_fullNumerator_growth hgrow
  exact rh_iff_rightOfflineSupport_empty.mp hrh

/-- Upper half-plane zero-freeness follows from eventual centered fluctuation growth. -/
theorem upper_half_plane_zero_free_of_eventually_fullNumerator_growth {C : ℝ}
    (hgrow : ∀ᶠ x : ℝ in atTop, (ActualFullCenteredMellin.fullNumerator x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    ∀ s : ℂ, (1 : ℝ) / 2 < s.re → 0 < s.im → riemannZeta s ≠ 0 := by
  have hrh := RiemannHypothesis_of_eventually_fullNumerator_growth hgrow
  exact rh_iff_upper_half_plane_zero_free.mp hrh

/-- High-frequency zero-freeness follows from eventual centered fluctuation growth. -/
theorem high_frequency_zero_free_of_eventually_fullNumerator_growth {C : ℝ}
    (hgrow : ∀ᶠ x : ℝ in atTop, (ActualFullCenteredMellin.fullNumerator x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    ∀ s : ℂ, (1 : ℝ) / 2 < s.re → 1 < s.im → riemannZeta s ≠ 0 := by
  have hrh := RiemannHypothesis_of_eventually_fullNumerator_growth hgrow
  exact rh_iff_high_frequency_zero_free.mp hrh

/-- The holomorphic zeta ODE follows from eventual centered fluctuation growth. -/
theorem holomorphicZetaODE_of_eventually_fullNumerator_growth {C : ℝ}
    (hgrow : ∀ᶠ x : ℝ in atTop, (ActualFullCenteredMellin.fullNumerator x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    HolomorphicZetaODE := by
  have hrh := RiemannHypothesis_of_eventually_fullNumerator_growth hgrow
  exact rh_iff_holomorphicZetaODE.mp hrh

/-! ### Master Grand Equivalence Bundle from Fluctuation Growth -/

/-- Comprehensive master grand theorem: An eventual one-sided bound on the centered
prime fluctuations `fullNumerator(x).re ≤ C x^{3/2}` simultaneously and constructively
establishes all 10 grand representations of the Riemann Hypothesis in a single unified bundle. -/
theorem grand_rh_bundle_of_eventually_fullNumerator_growth {C : ℝ}
    (hgrow : ∀ᶠ x : ℝ in atTop, (ActualFullCenteredMellin.fullNumerator x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    RiemannHypothesis ∧
    Target ∧
    RightHalfZeroFree ∧
    RightOfflineSupport = ∅ ∧
    (∀ s : ℂ, (1 : ℝ) / 2 < s.re → 0 < s.im → riemannZeta s ≠ 0) ∧
    (∀ s : ℂ, (1 : ℝ) / 2 < s.re → 1 < s.im → riemannZeta s ≠ 0) ∧
    HolomorphicZetaODE ∧
    AnalyticOnNhd ℂ CriticalTransformPoles.filledTransform {s : ℂ | (1 : ℝ) / 2 < s.re} ∧
    Nonempty HighFrequencyContradictionSystem ∧
    Nonempty DisplacementIntegralRefutationSystem ∧
    Nonempty DisplacementIntegralMismatchSystem := by
  have hrh := RiemannHypothesis_of_eventually_fullNumerator_growth hgrow
  refine ⟨hrh,
          rh_iff_target.mp hrh,
          rh_iff_rightHalfZeroFree.mp hrh,
          rh_iff_rightOfflineSupport_empty.mp hrh,
          rh_iff_upper_half_plane_zero_free.mp hrh,
          rh_iff_high_frequency_zero_free.mp hrh,
          rh_iff_holomorphicZetaODE.mp hrh,
          rh_iff_analyticOnNhd_filledTransform.mp hrh,
          rh_iff_highFrequencyContradictionSystem.mp hrh,
          rh_iff_displacementIntegralRefutationSystem.mp hrh,
          rh_iff_displacementIntegralMismatchSystem.mp hrh⟩

/-! ### Kernel Axiom Audits -/

#print axioms T_re_nonneg
#print axioms allocation_re_nonneg
#print axioms W_re_le_fullNumerator_re
#print axioms RiemannHypothesis_of_fullNumerator_growth_after
#print axioms RiemannHypothesis_of_eventually_fullNumerator_growth
#print axioms analyticOnNhd_filledTransform_of_eventually_fullNumerator_growth
#print axioms grand_rh_bundle_of_eventually_fullNumerator_growth

end BuildingBlocks.RiemannZetaPrimeAllocationGrowth
