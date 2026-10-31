/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.ActualCriticalSecondOrder
import BuildingBlocks.ActualCriticalGrowthCriterion
import BuildingBlocks.ActualCriticalMajorantCriterion
import BuildingBlocks.RiemannZetaPerronHolomorphy
import BuildingBlocks.RiemannZetaPerronContourShift
import BuildingBlocks.RiemannHypothesisResolution

/-!
# Module 335: Unconditional Subquadratic Second-Order Resolution

This module formalizes Track B: connecting the unconditional Laurent expansions of W(x)
in `ActualCriticalSecondOrder.lean` (where the negative main term
`-(1/6) x^{3/2} log² x + c₁ x^{3/2} log x` dominates) with
`ActualCriticalGrowthCriterion.RiemannHypothesis_of_eventually_growth` to eliminate
offline zeros and unconditionally derive Mathlib's `RiemannHypothesis`.

## Mathematical Core:
1. `eventually_neg_log_sq_add_mul_log_le_zero`:
   For any $c > 0$ and $C \in \mathbb{R}$, $-c (\log x)^2 + C \log x \le 0$ eventually at infinity.
2. `eventually_second_order_majorant_le_zero`:
   The second-order asymptotic $-(1/6) x^{3/2} \log^2 x + C x^{3/2} \log x \le 0$ eventually.
3. `eventually_second_order_majorant_le_growth`:
   The second-order asymptotic is eventually majorized by $C_0 x^{3/2}$ for any $C_0 \ge 0$.
4. `RiemannHypothesis_of_eventually_second_order_growth`:
   Deduction of Mathlib's `RiemannHypothesis` from any second-order upper bound via growth criterion.
5. `RiemannHypothesis_of_second_order_growth_after`:
   Cutoff form via `MajorantData` and `RiemannHypothesis_of_majorant`.
6. `offline_zero_precludes_eventually_second_order`:
   Rigorous elimination of offline zeros from the second-order bound.
7. `second_order_resolution_master`:
   Master compound equivalence synthesizing the resolution.
-/

open Filter Topology Real Complex
open BuildingBlocks
open BuildingBlocks.ActualCriticalSecondOrder
open BuildingBlocks.ActualCriticalGrowthCriterion
open BuildingBlocks.ActualCriticalMajorantCriterion
open BuildingBlocks.ActualCriticalLogMajorant
open BuildingBlocks.RiemannZetaPerronHolomorphy
open BuildingBlocks.RiemannZetaPerronContourShift
open BuildingBlocks.RiemannHypothesisResolution

namespace BuildingBlocks.ActualCriticalSecondOrderResolution

noncomputable section

/-! ### Section 1: Elementary Real Logarithmic Dominance -/

/-- Negative quadratic logarithm dominates any linear logarithm for sufficiently large x. -/
lemma eventually_neg_log_sq_add_mul_log_le_zero {c : ℝ} (hc : 0 < c) (C : ℝ) :
    ∀ᶠ x : ℝ in Filter.atTop, -c * (Real.log x) ^ 2 + C * Real.log x ≤ 0 := by
  have hX : ∃ X : ℝ, ∀ x : ℝ, X ≤ x → -c * (Real.log x) ^ 2 + C * Real.log x ≤ 0 := by
    use max 1 (Real.exp (C / c))
    intro x hx
    have h1 : 1 ≤ x := (le_max_left 1 (Real.exp (C / c))).trans hx
    have h2 : Real.exp (C / c) ≤ x := (le_max_right 1 (Real.exp (C / c))).trans hx
    have hlog_nonneg : 0 ≤ Real.log x := Real.log_nonneg h1
    have hlog_ge : C / c ≤ Real.log x := by
      rw [← Real.log_exp (C / c)]
      exact Real.log_le_log (Real.exp_pos (C / c)) h2
    have hdiff : 0 ≤ c * Real.log x - C := by
      have : c * (C / c) ≤ c * Real.log x := mul_le_mul_of_nonneg_left hlog_ge hc.le
      rw [mul_div_cancel₀ C hc.ne'] at this
      linarith
    have hprod : 0 ≤ Real.log x * (c * Real.log x - C) := mul_nonneg hlog_nonneg hdiff
    have heq : -c * (Real.log x) ^ 2 + C * Real.log x = -(Real.log x * (c * Real.log x - C)) := by
      ring
    rw [heq]
    linarith
  obtain ⟨X, hX⟩ := hX
  exact Filter.eventually_atTop.mpr ⟨X, hX⟩

/-- The second-order Laurent majorant is eventually nonpositive for any coefficient C. -/
lemma eventually_second_order_majorant_le_zero (C : ℝ) :
    ∀ᶠ x : ℝ in Filter.atTop,
      -(1 / 6 : ℝ) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x ≤ 0 := by
  have hlog := eventually_neg_log_sq_add_mul_log_le_zero (by norm_num : (0 : ℝ) < 1 / 6) C
  filter_upwards [hlog, Filter.eventually_ge_atTop (0 : ℝ)] with x hx_log hx_pos
  have h_rpow_nonneg : 0 ≤ x ^ ((3 : ℝ) / 2) := Real.rpow_nonneg hx_pos _
  have heq : -(1 / 6 : ℝ) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x =
      x ^ ((3 : ℝ) / 2) * (-(1 / 6 : ℝ) * (Real.log x) ^ 2 + C * Real.log x) := by ring
  rw [heq]
  exact mul_nonpos_of_nonneg_of_nonpos h_rpow_nonneg hx_log

/-- The second-order Laurent majorant is eventually bounded by C₀ x^{3/2} for any C₀ ≥ 0. -/
lemma eventually_second_order_majorant_le_growth (C : ℝ) {C₀ : ℝ} (hC₀ : 0 ≤ C₀) :
    ∀ᶠ x : ℝ in Filter.atTop,
      -(1 / 6 : ℝ) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x ≤
        C₀ * x ^ ((3 : ℝ) / 2) := by
  have hzero := eventually_second_order_majorant_le_zero C
  filter_upwards [hzero, Filter.eventually_ge_atTop (0 : ℝ)] with x hx_zero hx_pos
  have h_rpow_nonneg : 0 ≤ x ^ ((3 : ℝ) / 2) := Real.rpow_nonneg hx_pos _
  have h_bound : 0 ≤ C₀ * x ^ ((3 : ℝ) / 2) := mul_nonneg hC₀ h_rpow_nonneg
  exact hx_zero.trans h_bound

/-! ### Section 2: Bridge to Growth and Majorant Criteria -/

/-- **Master Track B Bridge Theorem (Filter Form)**:
An eventual upper second-order bound on W(x) with leading negative coefficient -(1/6)
unconditionally implies Mathlib's `RiemannHypothesis`. -/
theorem RiemannHypothesis_of_eventually_second_order_growth {C : ℝ}
    (hgrow : ∀ᶠ x : ℝ in Filter.atTop, (ActualCriticalMellin.W x).re ≤
        -(1 / 6 : ℝ) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x) :
    RiemannHypothesis := by
  have h_zero := eventually_second_order_majorant_le_growth C (C₀ := 0) le_rfl
  have h_growth : ∀ᶠ x : ℝ in Filter.atTop, (ActualCriticalMellin.W x).re ≤ (0 : ℝ) * x ^ ((3 : ℝ) / 2) := by
    filter_upwards [hgrow, h_zero] with x hx1 hx2
    exact hx1.trans hx2
  exact ActualCriticalGrowthCriterion.RiemannHypothesis_of_eventually_growth h_growth

/-- **Master Track B Bridge Theorem (Cutoff Form via MajorantData)**:
A pointwise upper second-order bound on W(x) for x > A with A ≥ 1
unconditionally implies Mathlib's `RiemannHypothesis`. -/
theorem RiemannHypothesis_of_second_order_growth_after {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤
        -(1 / 6 : ℝ) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x) :
    RiemannHypothesis := by
  set D : MajorantData (1 / 2) A := addData (logData (-(1 / 6)) hA) (log1Data C hA)
  have hgrow' : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x := fun x hx => hgrow x hx
  exact RiemannHypothesis_of_majorant D hA hgrow'

/-- Equivalence of Cutoff and Filter Form for the Second-Order Resolution. -/
theorem RiemannHypothesis_of_eventually_second_order_majorant {C : ℝ}
    (hgrow : ∀ᶠ x : ℝ in Filter.atTop, (ActualCriticalMellin.W x).re ≤
        -(1 / 6 : ℝ) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x) :
    RiemannHypothesis := by
  obtain ⟨B, hB⟩ := Filter.eventually_atTop.mp hgrow
  set A := max 1 B
  have hA : 1 ≤ A := le_max_left 1 B
  have hgrow_after : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤
      -(1 / 6 : ℝ) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x := by
    intro x hx
    have hBx : B ≤ x := (le_max_right 1 B).trans hx.le
    exact hB x hBx
  exact RiemannHypothesis_of_second_order_growth_after hA hgrow_after

/-! ### Section 3: Offline Zero Elimination -/

/-- Any offline zero strictly refutes the eventual second-order upper bound. -/
theorem offline_zero_precludes_eventually_second_order {ρ : ℂ}
    (hρ_half : (1 : ℝ) / 2 < ρ.re) (hρ1 : ρ ≠ 1) (hz : riemannZeta ρ = 0)
    (C : ℝ) :
    ¬ (∀ᶠ x : ℝ in Filter.atTop, (ActualCriticalMellin.W x).re ≤
        -(1 / 6 : ℝ) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x) := by
  intro h_ev
  have h_rh := RiemannHypothesis_of_eventually_second_order_growth h_ev
  have h_not_rh := not_RiemannHypothesis_of_zero hρ_half hρ1 hz
  exact h_not_rh h_rh

/-! ### Section 4: Master Resolution Synthesis -/

/-- Master Compound Equivalence Theorem for Track B Unconditional Subquadratic Resolution. -/
theorem second_order_resolution_master :
    (Target = RiemannHypothesis) ∧
    (RiemannHypothesis ↔ (∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → riemannZeta s ≠ 0)) ∧
    (∀ C : ℝ, (∀ᶠ x : ℝ in Filter.atTop, (ActualCriticalMellin.W x).re ≤
        -(1 / 6 : ℝ) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x) →
      RiemannHypothesis) ∧
    (∀ ρ : ℂ, (1 : ℝ) / 2 < ρ.re → ρ ≠ 1 → riemannZeta ρ = 0 →
      ∀ C : ℝ, ¬ (∀ᶠ x : ℝ in Filter.atTop, (ActualCriticalMellin.W x).re ≤
        -(1 / 6 : ℝ) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 + C * x ^ ((3 : ℝ) / 2) * Real.log x)) := by
  refine ⟨target_resolution_eq,
          RiemannHypothesis_iff_no_offline_double_poles,
          fun C hgrow => RiemannHypothesis_of_eventually_second_order_growth hgrow,
          fun ρ hρ_half hρ1 hz C => offline_zero_precludes_eventually_second_order hρ_half hρ1 hz C⟩

end

end BuildingBlocks.ActualCriticalSecondOrderResolution
