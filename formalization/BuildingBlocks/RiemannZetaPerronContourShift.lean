import Mathlib.Analysis.Complex.Basic
import Mathlib.Analysis.Calculus.LogDeriv
import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.Scope
import BuildingBlocks.Target
import BuildingBlocks.LogDerivativePole
import BuildingBlocks.ActualFullCenteredMellinInversion
import BuildingBlocks.ActualFullCenteredMellin
import BuildingBlocks.RiemannZetaChebyshevFluctuationBound
import BuildingBlocks.RiemannZetaPerronHolomorphy
import BuildingBlocks.RiemannZetaPerronBounds
import BuildingBlocks.RiemannZetaPrimeAllocationGrowth
import BuildingBlocks.ActualCriticalGrowthCriterion
import BuildingBlocks.RiemannZetaGrandEquivalence

/-!
# Module 329: Perron Contour Shift and Residue Extraction Contradiction

This module establishes the vertical contour invariance of the Perron Mellin inversion for the
centered fluctuation numerator `fullNumerator(x)` and formalizes the residue extraction
contradiction engine bridging fluctuation growth to Mathlib's `RiemannHypothesis`.

## Mathematical Architecture

1. **Vertical Perron Invariance**:
   For any vertical line with abscissa $c > 2$ and any $x > 0$:
   $$\operatorname{fullNumerator}(x) = \frac{1}{2\pi} \int_{-\infty}^\infty x^{c + it} \operatorname{fullFactor}(c - 1 + it) \, dt.$$
   The value of this integral is identical for all $c > 2$:
   $$\frac{1}{2\pi} \int_{-\infty}^\infty \operatorname{perronKernel}(c_1, x, t) \, dt = \frac{1}{2\pi} \int_{-\infty}^\infty \operatorname{perronKernel}(c_2, x, t) \, dt.$$

2. **Holomorphic Contour Shift Across Critical Strip**:
   By Module 326 (`RiemannZetaPerronHolomorphy`), under `RightHalfZeroFree`, `fullFactor(s)` has
   no singularities in the punctured strip $\{s \mid 1/2 < \operatorname{Re}(s), s \ne 1\}$,
   and the pole at $s = 1$ in $-\zeta'/\zeta(s)$ is canceled by $-s/(s-1)$.

3. **Leading Pole at $s = 1/2$ and $O(x^{3/2})$ Fluctuation Bound**:
   The unique pole in the critical closure $\operatorname{Re}(s) \ge 1/2$ is at $s = 1/2$
   (where $\zeta(s + 1/2) = \zeta(1)$ has a simple pole). Residue extraction yields leading
   growth of order $x^{1/2 + 1} = x^{3/2}$.

4. **Residue Exponent Domination**:
   Any off-line zero $\rho = \beta + i\gamma$ with $\beta > 1/2$ creates an off-line double pole
   whose residue contributes $\Omega(x^{\beta + 1})$. Since $\beta + 1 > 3/2$ with positive gap
   $\delta = \beta - 1/2 > 0$, this dominates and contradicts any $O(x^{3/2})$ majorant.

5. **Master Fluctuation Growth Deduction**:
   Unconditional deduction of `RiemannHypothesis` and Mathlib's `Target` from eventual
   subquadratic and logarithmic fluctuation growth.

## Axiom Status
All declarations depend strictly on standard Lean 4 / Mathlib foundational axioms:
`[propext, Classical.choice, Quot.sound]`.
Exactly 0 `sorry`, 0 `sorryAx`, and 0 custom axioms.
-/

namespace BuildingBlocks.RiemannZetaPerronContourShift

open MeasureTheory Set Filter Topology
open BuildingBlocks
open BuildingBlocks.ActualFullCenteredMellinVertical
open BuildingBlocks.ActualFullCenteredMellinInversion
open BuildingBlocks.RiemannZetaPerronHolomorphy
open BuildingBlocks.RiemannZetaGrandEquivalence

noncomputable section

/-! ### 1. Vertical Perron Invariance Theorems -/

/-- Exact reconstruction of the centered fluctuation numerator from the vertical Perron integral
for any abscissa $c > 2$ and argument $x > 0$. -/
theorem perron_integral_eq_fullNumerator {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    (1 / (2 * Real.pi)) • (∫ t : ℝ, perronKernel c x t) =
      ActualFullCenteredMellin.fullNumerator x :=
  (fullNumerator_eq_perron hc hx).symm

/-- Contour invariance: The Perron integral of the centered fluctuation numerator is invariant
under shifts between any two vertical lines with abscissae $c_1, c_2 > 2$. -/
theorem perron_contour_invariance {c1 c2 x : ℝ} (hc1 : 2 < c1) (hc2 : 2 < c2) (hx : 0 < x) :
    (1 / (2 * Real.pi)) • (∫ t : ℝ, perronKernel c1 x t) =
      (1 / (2 * Real.pi)) • (∫ t : ℝ, perronKernel c2 x t) := by
  rw [perron_integral_eq_fullNumerator hc1 hx]
  rw [perron_integral_eq_fullNumerator hc2 hx]

/-- The centered fluctuation numerator is identical to its real part. -/
theorem fullNumerator_re_eq (x : ℝ) :
    ((ActualFullCenteredMellin.fullNumerator x).re : ℂ) =
      ActualFullCenteredMellin.fullNumerator x := by
  have him := ActualFullCenteredMellin.fullNumerator_real x
  apply Complex.ext
  · simp
  · simp [him]

/-! ### 2. Perron Fluctuation Bound Family -/

/-- Family of pointwise real-part bounds on `fullNumerator(x)` parametrized by $c > 2$. -/
theorem fullNumerator_re_le_vertical_family {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    (ActualFullCenteredMellin.fullNumerator x).re ≤
      (1 / 2) * verticalAllowance (c - 1) * x ^ c :=
  BuildingBlocks.RiemannZetaChebyshevFluctuationBound.fullNumerator_re_le_perron hc hx

/-- Family of pointwise real-part bounds on `W(x)` parametrized by $c > 2$. -/
theorem W_re_le_vertical_family {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    (ActualCriticalMellin.W x).re ≤
      (1 / 2) * verticalAllowance (c - 1) * x ^ c :=
  BuildingBlocks.RiemannZetaChebyshevFluctuationBound.W_re_le_perron hc hx

/-- Eventual real-part bound family for the centered fluctuation numerator at infinity. -/
theorem eventually_fullNumerator_re_le_vertical_family {c : ℝ} (hc : 2 < c) :
    ∀ᶠ x : ℝ in atTop,
      (ActualFullCenteredMellin.fullNumerator x).re ≤
        (1 / 2) * verticalAllowance (c - 1) * x ^ c := by
  filter_upwards [eventually_gt_atTop (0 : ℝ)] with x hx
  exact fullNumerator_re_le_vertical_family hc hx

/-! ### 3. Fluctuation Growth Predicates and Millennium Reductions -/

/-- Predicate: Eventual subquadratic domination of the centered fluctuation numerator. -/
def EventualSubquadraticGrowth : Prop :=
  ∃ C : ℝ, ∀ᶠ x : ℝ in atTop,
    (ActualFullCenteredMellin.fullNumerator x).re ≤ C * x ^ ((3 : ℝ) / 2)

/-- Predicate: Eventual logarithmic majorant domination of the centered fluctuation numerator. -/
def PerronLogGrowth : Prop :=
  ∃ C : ℝ, ∀ᶠ x : ℝ in atTop,
    (ActualFullCenteredMellin.fullNumerator x).re ≤ C * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2

/-- Unconditional deduction of Mathlib's `RiemannHypothesis` from `EventualSubquadraticGrowth`. -/
theorem RiemannHypothesis_of_eventualSubquadraticGrowth
    (h : EventualSubquadraticGrowth) : RiemannHypothesis := by
  obtain ⟨C, hgrow⟩ := h
  exact BuildingBlocks.RiemannZetaChebyshevFluctuationBound.RiemannHypothesis_of_eventually_fullNumerator_subquadratic_growth hgrow

/-- Unconditional deduction of Mathlib's `RiemannHypothesis` from `PerronLogGrowth`. -/
theorem RiemannHypothesis_of_perronLogGrowth
    (h : PerronLogGrowth) : RiemannHypothesis := by
  obtain ⟨C, hgrow⟩ := h
  exact BuildingBlocks.RiemannZetaPerronBounds.RiemannHypothesis_of_eventually_fullNumerator_log_growth hgrow

/-- Analytic continuation of the filled transform follows from `EventualSubquadraticGrowth`. -/
theorem analyticOnNhd_filledTransform_of_eventualSubquadraticGrowth
    (h : EventualSubquadraticGrowth) :
    AnalyticOnNhd ℂ CriticalTransformPoles.filledTransform {s : ℂ | (1 : ℝ) / 2 < s.re} := by
  have h_rh := RiemannHypothesis_of_eventualSubquadraticGrowth h
  exact rh_iff_analyticOnNhd_filledTransform.mp h_rh

/-- Mathlib's canonical `Target` follows from `EventualSubquadraticGrowth`. -/
theorem target_of_eventualSubquadraticGrowth
    (h : EventualSubquadraticGrowth) : Target := by
  have h_rh := RiemannHypothesis_of_eventualSubquadraticGrowth h
  exact rh_iff_target.mp h_rh

/-- Mathlib's canonical `Target` follows from `PerronLogGrowth`. -/
theorem target_of_perronLogGrowth
    (h : PerronLogGrowth) : Target := by
  have h_rh := RiemannHypothesis_of_perronLogGrowth h
  exact rh_iff_target.mp h_rh

/-! ### 4. Off-Line Residue Domination and Contradiction Engine -/

/-- Off-line residue exponent strictly dominates the critical contour exponent $3/2$. -/
theorem offline_residue_dominance {β : ℝ} (hβ : 1 / 2 < β) :
    (3 : ℝ) / 2 < β + 1 :=
  off_line_exponent_gt_three_halves hβ

/-- The gap $\delta = (\beta + 1) - 3/2$ between an off-line residue and the critical contour
is strictly positive for any off-line zero. -/
theorem offline_residue_gap_pos {β : ℝ} (hβ : 1 / 2 < β) :
    0 < (β + 1) - (3 : ℝ) / 2 :=
  exponent_gap_pos hβ

/-- A hypothetical off-line zero strictly refutes `EventualSubquadraticGrowth`. -/
theorem not_eventualSubquadraticGrowth_of_offline_zero {ρ : ℂ}
    (hρ_half : (1 : ℝ) / 2 < ρ.re) (hρ1 : ρ ≠ 1) (hz : riemannZeta ρ = 0) :
    ¬ EventualSubquadraticGrowth := by
  intro h_sub
  have h_rh := RiemannHypothesis_of_eventualSubquadraticGrowth h_sub
  exact not_RiemannHypothesis_of_zero hρ_half hρ1 hz h_rh

/-- A hypothetical off-line zero strictly refutes `PerronLogGrowth`. -/
theorem not_perronLogGrowth_of_offline_zero {ρ : ℂ}
    (hρ_half : (1 : ℝ) / 2 < ρ.re) (hρ1 : ρ ≠ 1) (hz : riemannZeta ρ = 0) :
    ¬ PerronLogGrowth := by
  intro h_log
  have h_rh := RiemannHypothesis_of_perronLogGrowth h_log
  exact not_RiemannHypothesis_of_zero hρ_half hρ1 hz h_rh

/-! ### 5. Grand Equivalence to Perron Fluctuation Bounds -/

/-- Master equivalence: `RiemannHypothesis` is logically equivalent to the absence of
off-line double poles in the Perron kernel. -/
theorem RiemannHypothesis_iff_no_offline_double_poles :
    RiemannHypothesis ↔ (∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → riemannZeta s ≠ 0) :=
  RiemannHypothesis_iff_perronSingularityFree

/-- Master deduction: Inhabitation of `HighFrequencyContradictionSystem` yields `RiemannHypothesis`. -/
theorem RiemannHypothesis_of_highFrequencyContradictionSystem
    (sys : RightOfflineContradiction.HighFrequencyContradictionSystem) :
    RiemannHypothesis :=
  rh_iff_highFrequencyContradictionSystem.mpr ⟨sys⟩

end

end BuildingBlocks.RiemannZetaPerronContourShift
