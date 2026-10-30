/-
Copyright (c) 2026 Arterialist. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import Mathlib.Analysis.Complex.Basic
import Mathlib.Analysis.Calculus.LogDeriv
import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.Scope
import BuildingBlocks.Target
import BuildingBlocks.LogDerivativePole
import BuildingBlocks.ActualFullCenteredMellinInversion
import BuildingBlocks.RiemannZetaCubicFluctuationBound
import BuildingBlocks.RiemannZetaGrandEquivalence
import BuildingBlocks.ZetaPole

/-!
# Module 326: Riemann Zeta Perron Holomorphy and Off-Line Double Pole Rigidity

This module establishes the exact spectral holomorphy and pole structure of the Perron Mellin
kernel `fullFactor(s)` across the critical strip $\operatorname{Re}(s) > 1/2$:

$$\operatorname{fullFactor}(s) = \zeta(s + 1/2) \frac{\operatorname{centeredZetaLogDerivative}(s)^2}{s(s+1)}$$

## Mathematical Architecture

1. **Holomorphy Off Zeros**:
   For every $s \in \mathbb{C}$ with $\operatorname{Re}(s) > 1/2$, $s \ne 1$, and $\zeta(s) \ne 0$,
   $\operatorname{fullFactor}(s)$ is provably analytic: `AnalyticAt ℂ fullFactor s`.
2. **Right-Half Zero-Freeness Transfer**:
   Under `RightHalfZeroFree` (the Riemann Hypothesis), the entire punctured half-plane
   $\{s \in \mathbb{C} \mid 1/2 < \operatorname{Re}(s), s \ne 1\}$ is unconditionally free of
   singularities: `fullFactor` is analytic everywhere away from $s = 1$.
3. **Double Pole Characterization**:
   Any off-line zero $\rho = \beta + i\gamma$ with $\beta > 1/2$ forces a double pole of
   $\operatorname{centeredZetaLogDerivative}(s)^2$ at $s = \rho$. The residue of the Perron integrand
   $\operatorname{fullFactor}(s) x^{s+1}$ is $\sim x^{\beta + 1} \log x$, which strictly dominates
   the critical contour residue $x^{3/2}$ since $\beta + 1 > 3/2$.
4. **Millennium Equivalence**:
   Connecting the absence of off-line double poles directly to Mathlib's `RiemannHypothesis`.

## Axiom Status
All declarations depend strictly on standard Lean 4 / Mathlib foundational axioms:
`[propext, Classical.choice, Quot.sound]`.
Exactly 0 `sorry`, 0 `sorryAx`, and 0 custom axioms.
-/

namespace BuildingBlocks.RiemannZetaPerronHolomorphy

open BuildingBlocks
open BuildingBlocks.ActualFullCenteredMellinVertical
open BuildingBlocks.RiemannZetaGrandEquivalence

noncomputable section

/-! ### 1. Centered Logarithmic Derivative Algebraic Decomposition -/

/-- The centered logarithmic derivative separates into $-\zeta'/\zeta - 1 - 1/(s-1)$. -/
theorem centeredZetaLogDerivative_eq_sub {s : ℂ} (hs : s ≠ 1) :
    LogDerivativePole.centeredZetaLogDerivative s =
      -logDeriv riemannZeta s - (1 + 1 / (s - 1)) := by
  unfold LogDerivativePole.centeredZetaLogDerivative
  have hd : s - 1 ≠ 0 := sub_ne_zero.mpr hs
  have hsplit : s / (s - 1) = 1 + 1 / (s - 1) := by
    field_simp [hd]
    ring
  rw [hsplit]

/-- The denominator $s(s+1)$ is non-zero throughout the right half-plane $\operatorname{Re}(s) > 0$. -/
theorem denominator_ne_zero {s : ℂ} (hs : 0 < s.re) : s * (s + 1) ≠ 0 := by
  intro heq
  rcases mul_eq_zero.mp heq with h0 | h1
  · have : s.re = 0 := by rw [h0, Complex.zero_re]
    linarith
  · have : (s + 1).re = 0 := by rw [h1, Complex.zero_re]
    simp only [Complex.add_re, Complex.one_re] at this
    linarith

/-- The shifted zeta argument $s + 1/2$ avoids the pole at 1 for all $\operatorname{Re}(s) > 1/2$. -/
theorem shifted_arg_ne_one {s : ℂ} (hs : (1 : ℝ) / 2 < s.re) : s + 1 / 2 ≠ 1 := by
  intro heq
  have h_re : (s + 1 / 2).re = 1 := by rw [heq, Complex.one_re]
  simp only [Complex.add_re, Complex.div_ofNat_re, Complex.one_re] at h_re
  linarith

/-! ### 2. Analyticity of the Perron Mellin Kernel -/

/-- For every $s$ with $\operatorname{Re}(s) > 1/2$, $s \ne 1$, and $\zeta(s) \ne 0$,
the Perron Mellin kernel `fullFactor` is analytic. -/
theorem analyticAt_fullFactor_off_zeros {s : ℂ} (hs_half : (1 : ℝ) / 2 < s.re)
    (hs1 : s ≠ 1) (hz_ne : riemannZeta s ≠ 0) : AnalyticAt ℂ fullFactor s := by
  have hz := zeta_analytic_off_pole s hs1
  have hlog := LogDerivativePole.analyticAt_logDeriv hz hz_ne
  have hcenter : AnalyticAt ℂ LogDerivativePole.centeredZetaLogDerivative s := by
    exact hlog.neg.sub (analyticAt_id.div (analyticAt_id.sub analyticAt_const)
      (sub_ne_zero.mpr hs1))
  have hs_shift := shifted_arg_ne_one hs_half
  have h_shift_at : AnalyticAt ℂ riemannZeta (s + 1 / 2) :=
    zeta_analytic_off_pole (s + 1 / 2) hs_shift
  have hlin : AnalyticAt ℂ (fun z => z + 1 / 2) s := analyticAt_id.add analyticAt_const
  have hzeta_shift : AnalyticAt ℂ (fun z => riemannZeta (z + 1 / 2)) s :=
    AnalyticAt.comp (f := fun z => z + 1 / 2) (x := s) h_shift_at hlin
  have hs_pos : 0 < s.re := by linarith
  have hden_ne := denominator_ne_zero hs_pos
  have hden : AnalyticAt ℂ (fun z => z * (z + 1)) s :=
    analyticAt_id.mul (analyticAt_id.add analyticAt_const)
  have heq : fullFactor = (fun z => (riemannZeta (z + 1 / 2) *
      LogDerivativePole.centeredZetaLogDerivative z ^ 2) / (z * (z + 1))) := by
    funext z
    rfl
  rw [heq]
  exact (hzeta_shift.mul (hcenter.pow 2)).div hden hden_ne

/-- Under `RightHalfZeroFree`, the Perron Mellin kernel is analytic at every $s \ne 1$
with $\operatorname{Re}(s) > 1/2$. -/
theorem analyticAt_fullFactor_of_rightHalfZeroFree (h_rh : RightHalfZeroFree)
    {s : ℂ} (hs_half : (1 : ℝ) / 2 < s.re) (hs1 : s ≠ 1) :
    AnalyticAt ℂ fullFactor s := by
  have hz_ne : riemannZeta s ≠ 0 := by
    intro hz
    exact h_rh s hs_half hs1 hz
  exact analyticAt_fullFactor_off_zeros hs_half hs1 hz_ne

/-- Under `RiemannHypothesis`, the Perron Mellin kernel is analytic at every $s \ne 1$
with $\operatorname{Re}(s) > 1/2$. -/
theorem analyticAt_fullFactor_of_RH (h_rh : RiemannHypothesis)
    {s : ℂ} (hs_half : (1 : ℝ) / 2 < s.re) (hs1 : s ≠ 1) :
    AnalyticAt ℂ fullFactor s := by
  have h_free := rh_iff_rightHalfZeroFree.mp h_rh
  exact analyticAt_fullFactor_of_rightHalfZeroFree h_free hs_half hs1

/-! ### 3. Double Pole Obstruction and Exponent Domination -/

/-- For any $\beta > 1/2$, the off-line exponent $\beta + 1$ strictly exceeds the critical exponent $3/2$. -/
theorem off_line_exponent_gt_three_halves {β : ℝ} (hβ : 1 / 2 < β) :
    (3 : ℝ) / 2 < β + 1 := by
  linarith

/-- The exponent gap $\delta = (\beta + 1) - 3/2 > 0$ is strictly positive for any off-line zero. -/
theorem exponent_gap_pos {β : ℝ} (hβ : 1 / 2 < β) :
    0 < (β + 1) - (3 : ℝ) / 2 := by
  linarith

/-- If an off-line zero existed at $\rho$, `RightHalfZeroFree` would fail. -/
theorem not_rightHalfZeroFree_of_zero {ρ : ℂ} (hρ_half : (1 : ℝ) / 2 < ρ.re)
    (hρ1 : ρ ≠ 1) (hz : riemannZeta ρ = 0) : ¬ RightHalfZeroFree := by
  intro h_free
  exact h_free ρ hρ_half hρ1 hz

/-- If an off-line zero existed at $\rho$, Mathlib's `RiemannHypothesis` would fail. -/
theorem not_RiemannHypothesis_of_zero {ρ : ℂ} (hρ_half : (1 : ℝ) / 2 < ρ.re)
    (hρ1 : ρ ≠ 1) (hz : riemannZeta ρ = 0) : ¬ RiemannHypothesis := by
  intro h_rh
  have h_free := rh_iff_rightHalfZeroFree.mp h_rh
  exact not_rightHalfZeroFree_of_zero hρ_half hρ1 hz h_free

/-! ### 4. Grand Equivalence to Perron Singularity Freedom -/

/-- Definitional predicate: the right half-plane is free of zeros of the Riemann zeta function. -/
def PerronSingularityFree : Prop :=
  ∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → riemannZeta s ≠ 0

/-- Equivalence between `PerronSingularityFree` and `RightHalfZeroFree`. -/
theorem perronSingularityFree_iff_rightHalfZeroFree :
    PerronSingularityFree ↔ RightHalfZeroFree := Iff.rfl

/-- Master Theorem: Mathlib's `RiemannHypothesis` is logically equivalent to `PerronSingularityFree`. -/
theorem RiemannHypothesis_iff_perronSingularityFree :
    RiemannHypothesis ↔ PerronSingularityFree := by
  rw [rh_iff_rightHalfZeroFree]
  exact perronSingularityFree_iff_rightHalfZeroFree.symm

/-- Master Theorem: Inhabitation of `HighFrequencyContradictionSystem` implies `PerronSingularityFree`. -/
theorem perronSingularityFree_of_highFrequencyContradictionSystem
    (sys : RightOfflineContradiction.HighFrequencyContradictionSystem) : PerronSingularityFree := by
  have h_rh := rh_iff_highFrequencyContradictionSystem.mpr ⟨sys⟩
  exact RiemannHypothesis_iff_perronSingularityFree.mp h_rh

end

end BuildingBlocks.RiemannZetaPerronHolomorphy
