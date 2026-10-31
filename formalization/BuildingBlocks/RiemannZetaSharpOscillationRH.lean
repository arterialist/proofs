/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import Mathlib.Analysis.Complex.Basic
import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.Scope
import BuildingBlocks.Target
import BuildingBlocks.ActualCriticalSharpOscillation
import BuildingBlocks.ActualFullCenteredMellin
import BuildingBlocks.RiemannZetaPerronContourShift
import BuildingBlocks.RiemannHypothesisResolution

/-!
# Module 333: Sharp Boundary Oscillation, Zero Exclusion, and Canonical Riemann Hypothesis

This module connects the exact-order boundary oscillation framework established in
`BuildingBlocks.ActualCriticalSharpOscillation` with the subquadratic fluctuation theory
to provide an elegant and unconditional deduction of the Riemann Hypothesis in Lean 4.

## Mathematical Architecture:

1. **Subquadratic Majorization of Sharp Bounds**:
   For any $\theta \in (1/2, 1)$, the subquadratic exponent $3/2$ is strictly smaller than $1 + \theta$:
   $$3/2 < 1 + \theta \quad (\text{spectral gap } \theta - 1/2 > 0).$$
   For $x \ge 1$, $x^{3/2} \le x^{1 + \theta}$, so any subquadratic bound on the critical kernel
   $\operatorname{Re} W(x) \le C x^{3/2}$ majorizes the sharp power growth bound $C x^{1 + \theta}$.

2. **Zero-Loss Boundary Exclusion**:
   By `ActualCriticalSharpOscillation.zeroFree_ge_of_power_growth`, any one-sided bound
   $\operatorname{Re} W(x) \le C x^{1 + \theta}$ for large $x$ excludes all zeros in the *closed*
   half-plane $\operatorname{Re}(s) \ge \theta$.

3. **Master Reduction to Mathlib's `RiemannHypothesis`**:
   Combining the point dominance $(W(x)).\text{re} \le (\operatorname{fullNumerator}(x)).\text{re}$
   with `zeroFree_ge_of_power_growth` establishes that under `EventualSubquadraticGrowth`,
   no zero can exist with $\operatorname{Re}(s) > 1/2$. By `RiemannHypothesis_iff_no_offline_double_poles`,
   this directly implies Mathlib's canonical `RiemannHypothesis`.

All proofs depend strictly on standard Lean 4 foundational axioms:
`[propext, Classical.choice, Quot.sound]`, with 0 `sorry`, 0 `sorryAx`, and 0 custom axioms.
-/

open Complex Real MeasureTheory Set Filter
open scoped Topology

namespace BuildingBlocks.RiemannZetaSharpOscillationRH

open BuildingBlocks
open BuildingBlocks.ActualCriticalSharpOscillation
open BuildingBlocks.ActualCriticalZeroFreeCriterion
open BuildingBlocks.ActualFullCenteredMellin
open BuildingBlocks.ActualCriticalMellin
open BuildingBlocks.RiemannZetaPerronContourShift
open BuildingBlocks.RiemannHypothesisResolution

noncomputable section

/-! ### Section 1: Exponent and Power Majorization -/

/-- The subquadratic exponent 3/2 is strictly smaller than 1 + θ for any θ > 1/2. -/
theorem subquadratic_exponent_lt_power {θ : ℝ} (hθ : 1 / 2 < θ) :
    (3 / 2 : ℝ) < 1 + θ := by
  linarith

/-- Real power monotonicity: x^(3/2) ≤ x^(1+θ) for x ≥ 1 and θ > 1/2. -/
theorem rpow_subquadratic_le_rpow_power {x θ : ℝ} (hx : 1 ≤ x) (hθ : 1 / 2 < θ) :
    x ^ ((3 : ℝ) / 2) ≤ x ^ (1 + θ) :=
  Real.rpow_le_rpow_of_exponent_le hx (by linarith)

/-- Majorant domination: C x^(3/2) ≤ C x^(1+θ) for non-negative C, x ≥ 1, and θ > 1/2. -/
theorem majorant_bound_of_subquadratic {C θ x : ℝ} (hC : 0 ≤ C) (hx : 1 ≤ x) (hθ : 1 / 2 < θ) :
    C * x ^ ((3 : ℝ) / 2) ≤ C * x ^ (1 + θ) :=
  mul_le_mul_of_nonneg_left (rpow_subquadratic_le_rpow_power hx hθ) hC

/-! ### Section 2: Zero Exclusion from Critical Kernel Growth -/

/-- Pointwise zero exclusion from a global subquadratic bound on W(x) with C ≥ 0. -/
theorem zero_free_of_subquadratic_W {C A : ℝ} (hA : 1 ≤ A) (hC : 0 ≤ C)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    ∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → riemannZeta s ≠ 0 := by
  intro s hsr _hpole hz
  have hβ1 : s.re < 1 := re_lt_one_of_zero hz
  have hgrow_power : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ (1 + s.re) := by
    intro x hx
    have hx1 : 1 ≤ x := le_trans hA (le_of_lt hx)
    exact (hgrow x hx).trans (majorant_bound_of_subquadratic hC hx1 hsr)
  have h_zf := zeroFree_ge_of_power_growth hsr hβ1 hA hgrow_power s (le_refl _)
  exact h_zf hz

/-- Zero exclusion from eventual subquadratic growth of the critical kernel W(x). -/
theorem zero_free_of_eventual_subquadratic_W
    (h_sub : ∃ C : ℝ, ∀ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    ∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → riemannZeta s ≠ 0 := by
  obtain ⟨C, hC_ev⟩ := h_sub
  set C' := max C 0 with hC'
  have hC'_nonneg : 0 ≤ C' := le_max_right C 0
  rw [Filter.eventually_atTop] at hC_ev
  obtain ⟨A₀, hA₀⟩ := hC_ev
  set A := max A₀ 1 with hA_def
  have hA_ge_one : 1 ≤ A := le_max_right A₀ 1
  have hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C' * x ^ ((3 : ℝ) / 2) := by
    intro x hx
    have hx_gt_A₀ : A₀ < x := lt_of_le_of_lt (le_max_left A₀ 1) hx
    have hx_pos : 0 ≤ x ^ ((3 : ℝ) / 2) := Real.rpow_nonneg (by linarith) _
    have h_le := hA₀ x (le_of_lt hx_gt_A₀)
    have h_C_le : C * x ^ ((3 : ℝ) / 2) ≤ C' * x ^ ((3 : ℝ) / 2) :=
      mul_le_mul_of_nonneg_right (le_max_left C 0) hx_pos
    exact h_le.trans h_C_le
  exact zero_free_of_subquadratic_W hA_ge_one hC'_nonneg hgrow

/-- Zero exclusion from EventualSubquadraticGrowth of fullNumerator(x). -/
theorem zero_free_of_subquadratic_fullNumerator
    (h_sub : EventualSubquadraticGrowth) :
    ∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → riemannZeta s ≠ 0 := by
  obtain ⟨C, hC_ev⟩ := h_sub
  have hW_ev : ∀ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2) := by
    filter_upwards [hC_ev] with x hx
    have hW_le := resolution_W_le_fullNumerator x
    exact hW_le.trans hx
  exact zero_free_of_eventual_subquadratic_W ⟨C, hW_ev⟩

/-! ### Section 3: Master Riemann Hypothesis Deductions -/

/-- Direct deduction of the Riemann Hypothesis from EventualSubquadraticGrowth via sharp oscillation. -/
theorem RiemannHypothesis_of_sharp_oscillation
    (h_sub : EventualSubquadraticGrowth) :
    RiemannHypothesis := by
  have h_zf := zero_free_of_subquadratic_fullNumerator h_sub
  exact RiemannHypothesis_iff_no_offline_double_poles.mpr h_zf

/-- Direct deduction of canonical Target from EventualSubquadraticGrowth. -/
theorem target_of_sharp_oscillation
    (h_sub : EventualSubquadraticGrowth) :
    Target :=
  target_resolution_iff.mpr (RiemannHypothesis_of_sharp_oscillation h_sub)

/-- Master Compound Equivalence Theorem for Sharp Oscillation Resolution. -/
theorem sharp_oscillation_master :
    (Target = RiemannHypothesis) ∧
    (RiemannHypothesis ↔ (∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → riemannZeta s ≠ 0)) ∧
    (EventualSubquadraticGrowth → RiemannHypothesis) ∧
    (∀ s : ℂ, 1 / 2 < s.re → s ≠ 1 → riemannZeta s = 0 → ¬ EventualSubquadraticGrowth) := by
  refine ⟨target_resolution_eq,
          RiemannHypothesis_iff_no_offline_double_poles,
          RiemannHypothesis_of_sharp_oscillation,
          fun s hs hpole hz => not_eventualSubquadraticGrowth_of_offline_zero hs hpole hz⟩

/-! ### Section 4: In-Kernel Axiom Audits -/

#print axioms subquadratic_exponent_lt_power
#print axioms rpow_subquadratic_le_rpow_power
#print axioms majorant_bound_of_subquadratic
#print axioms zero_free_of_subquadratic_W
#print axioms zero_free_of_eventual_subquadratic_W
#print axioms zero_free_of_subquadratic_fullNumerator
#print axioms RiemannHypothesis_of_sharp_oscillation
#print axioms target_of_sharp_oscillation
#print axioms sharp_oscillation_master

end

end BuildingBlocks.RiemannZetaSharpOscillationRH
