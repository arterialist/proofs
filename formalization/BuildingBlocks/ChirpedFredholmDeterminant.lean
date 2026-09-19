import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Order.Filter.Basic
import Mathlib.Topology.Order.Basic
import Mathlib.Tactic
import BuildingBlocks.Bridge
import BuildingBlocks.Scope
import BuildingBlocks.CriticalTransformRH
import BuildingBlocks.CriticalChirpedGramFinite
import BuildingBlocks.ChirpedSpectralArithmeticExclusion
import BuildingBlocks.ChirpedSpectralRHBridge
import BuildingBlocks.ChirpedGrandSynthesis
import BuildingBlocks.ChirpedGramDefiniteness
import BuildingBlocks.ChirpedCoerciveSpectralExclusion
import BuildingBlocks.ChirpedQuantitativeExclusionThreshold
import BuildingBlocks.ChirpedZeroPartitionSynthesis
import BuildingBlocks.ChirpedPartitionRefutationSynthesis
import BuildingBlocks.ChirpedWeilExplicitAdmissibility
import BuildingBlocks.ChirpedSpectralSupportConfinement
import BuildingBlocks.ChirpedOperatorTraceCoercivity
import BuildingBlocks.ChirpedSpectralMeasureAnnihilation

/-!
# Scalar trace discrepancy packaged with Fredholm terminology

This module defines a scalar trace discrepancy and packages hypotheses under names borrowed from
Fredholm determinant theory. It does not define a Hilbert-space operator, prove trace-class or
Hilbert-Schmidt properties, or construct an analytic Fredholm determinant.

`LogFredholmDeterminant` is definitionally `T_arith T c - T_spec T c`.
`RegularizedFredholmDeterminant` is definitionally `exp (-LogFredholmDeterminant ...)`. Thus the
ordinary real logarithm of the latter, where simplified, has the opposite sign from
`LogFredholmDeterminant`; the names do not establish a determinant/log-determinant relation.

Under the supplied trace-balance predicate, arithmetic and spectral traces balance:
  `Tr_arith(T, c) = Tr_spec(T, c) ↔ log Δ(T, c) = 0 ↔ Δ(T, c) = 1`.

The hypotheses `ArithmeticCoercivity` and `SpectralTraceZeroBound` imply the scalar bound:
  `log Δ(T, c) ≥ 𝒢_Fredholm(T) * ‖c‖² > 0`
for all carrier frequencies `T ≥ T_thresh`.

Under trace balance `log Δ(T, c) = 0`, this yields `0 > 0`, an immediate contradiction.
The later zero-exclusion and RH results are conditional on a supplied
`FredholmDeterminantSystem`; this file does not construct such a system from zeta-function data.

## Axiom Status
All declarations depend strictly on standard foundational axioms:
`[propext, Classical.choice, Quot.sound]`.
-/

namespace BuildingBlocks.ChirpedFredholmDeterminant

open Filter
open scoped Topology BigOperators
open BuildingBlocks.CriticalChirpedGramFinite
open BuildingBlocks.ChirpedSpectralArithmeticExclusion
open BuildingBlocks.ChirpedSpectralRHBridge
open BuildingBlocks.ChirpedGrandSynthesis
open BuildingBlocks.ChirpedGramDefiniteness
open BuildingBlocks.ChirpedCoerciveSpectralExclusion
open BuildingBlocks.ChirpedQuantitativeExclusionThreshold
open BuildingBlocks.ChirpedZeroPartitionSynthesis
open BuildingBlocks.ChirpedPartitionRefutationSynthesis
open BuildingBlocks.ChirpedWeilExplicitAdmissibility
open BuildingBlocks.ChirpedSpectralSupportConfinement
open BuildingBlocks.ChirpedOperatorTraceCoercivity
open BuildingBlocks.ChirpedSpectralMeasureAnnihilation

set_option linter.unusedSectionVars false

variable {ι : Type*} [Fintype ι] [Nonempty ι]

noncomputable section

/-- Scalar discrepancy between two real-valued trace functions. Despite its historical name,
this definition is not shown here to be a logarithm of a Fredholm determinant. -/
def LogFredholmDeterminant
    (T_arith T_spec : ℝ → (ι → ℂ) → ℝ) (T : ℝ) (c : ι → ℂ) : ℝ :=
  T_arith T c - T_spec T c

/-- Exponential of the negative scalar discrepancy. No operator-theoretic determinant property is
proved for this definition. -/
def RegularizedFredholmDeterminant
    (T_arith T_spec : ℝ → (ι → ℂ) → ℝ) (T : ℝ) (c : ι → ℂ) : ℝ :=
  Real.exp (-(LogFredholmDeterminant T_arith T_spec T c))

/-- Equality of the two supplied trace functions at every carrier and test vector. -/
def FredholmSpectralBalance
    (T_arith T_spec : ℝ → (ι → ℂ) → ℝ) : Prop :=
  ∀ (T : ℝ) (c : ι → ℂ), LogFredholmDeterminant T_arith T_spec T c = 0

/-- Logical equivalence between Fredholm spectral balance and Weil trace equivalence. -/
theorem fredholmSpectralBalance_iff_weilTraceEquivalence
    (T_arith T_spec : ℝ → (ι → ℂ) → ℝ) :
    FredholmSpectralBalance T_arith T_spec ↔ WeilTraceEquivalence T_arith T_spec := by
  constructor
  · intro hbal T c
    have h := hbal T c
    unfold LogFredholmDeterminant at h
    linarith
  · intro hequiv T c
    have h := hequiv T c
    unfold LogFredholmDeterminant
    linarith

/-- Lower bound on the scalar trace discrepancy from the two supplied trace inequalities. -/
theorem log_fredholm_lower_bound
    {T_arith T_spec : ℝ → (ι → ℂ) → ℝ} {c₀ C_arith C_crit C_nonres b d T : ℝ}
    (h_arith : ArithmeticCoercivity T_arith c₀ C_arith)
    (h_spec : SpectralTraceZeroBound T_spec C_crit C_nonres b d)
    (c : ι → ℂ) :
    traceCoerciveGap c₀ C_arith C_crit C_nonres b d T * energy c ≤
      LogFredholmDeterminant T_arith T_spec T c := by
  have ha := h_arith T c
  have hs := h_spec T c
  unfold LogFredholmDeterminant traceCoerciveGap
  linarith

/-- Refutation of Fredholm trace balance for non-zero vectors when the carrier exceeds the threshold. -/
theorem refute_fredholm_balance
    {T_arith T_spec : ℝ → (ι → ℂ) → ℝ} {c₀ C_arith C_crit C_nonres b d : ℝ}
    (hd : 0 < d) (hb : 0 < b)
    (h_arith : ArithmeticCoercivity T_arith c₀ C_arith)
    (h_spec : SpectralTraceZeroBound T_spec C_crit C_nonres b d)
    (h_bal : FredholmSpectralBalance T_arith T_spec)
    (c : ι → ℂ) (hc : c ≠ 0) : False := by
  have hequiv := (fredholmSpectralBalance_iff_weilTraceEquivalence T_arith T_spec).mp h_bal
  exact refute_operator_trace hd hb h_arith h_spec hequiv c hc

/-- A hypothesis package containing two real-valued functions, coercivity bounds, a test vector,
and their pointwise equality. It contains no Fredholm operator or determinant construction. -/
structure FredholmDeterminantEvaluation (s : ℂ) where
  c₀ : ℝ
  hc₀_pos : 0 < c₀
  C_arith : ℝ
  C_crit : ℝ
  C_nonres : ℝ
  b : ℝ
  hb_pos : 0 < b
  T_arith : ℝ → (ι → ℂ) → ℝ
  T_spec : ℝ → (ι → ℂ) → ℝ
  h_arith : ArithmeticCoercivity T_arith c₀ C_arith
  h_spec : SpectralTraceZeroBound T_spec C_crit C_nonres b (s.re - 1 / 2)
  h_bal : FredholmSpectralBalance T_arith T_spec
  test_vector : ι → ℂ
  h_test_ne_zero : test_vector ≠ 0

/-- Projection from FredholmDeterminantEvaluation into OperatorTraceEvaluation. -/
def FredholmDeterminantEvaluation.toOperatorTraceEvaluation
    {s : ℂ} (fde : FredholmDeterminantEvaluation (ι := ι) s) :
    OperatorTraceEvaluation (ι := ι) s where
  c₀ := fde.c₀
  hc₀_pos := fde.hc₀_pos
  C_arith := fde.C_arith
  C_crit := fde.C_crit
  C_nonres := fde.C_nonres
  b := fde.b
  hb_pos := fde.hb_pos
  T_arith := fde.T_arith
  T_spec := fde.T_spec
  h_arith := fde.h_arith
  h_spec := fde.h_spec
  h_equiv := (fredholmSpectralBalance_iff_weilTraceEquivalence fde.T_arith fde.T_spec).mp fde.h_bal
  test_vector := fde.test_vector
  h_test_ne_zero := fde.h_test_ne_zero

/-- Pointwise contradiction from a supplied scalar evaluation package. -/
theorem refute_fredholm_evaluation
    {s : ℂ} (hs : 1 / 2 < s.re) (eval : FredholmDeterminantEvaluation (ι := ι) s) : False :=
  refute_operator_trace_evaluation hs eval.toOperatorTraceEvaluation

/-- A hypothesis package combining low-frequency zero-freeness with scalar evaluations for
putative high-frequency off-line zeros. -/
structure FredholmDeterminantSystem where
  height : ℝ
  h_height_ge_one : 1 ≤ height
  low_free : LowFrequencyZeroFree height
  evaluator : ∀ s ∈ RightOfflineSupport, height < |s.im| → FredholmDeterminantEvaluation (ι := ι) s

/-- Canonical projection from a FredholmDeterminantSystem into an OperatorTraceCoercivitySystem. -/
def FredholmDeterminantSystem.toOperatorTraceSystem
    (fds : FredholmDeterminantSystem (ι := ι)) :
    OperatorTraceCoercivitySystem (ι := ι) where
  height := fds.height
  h_height_ge_one := fds.h_height_ge_one
  low_free := fds.low_free
  evaluator := fun s hs hH => (fds.evaluator s hs hH).toOperatorTraceEvaluation

/-- Off-line zero exclusion conditional on a `FredholmDeterminantSystem`. -/
theorem no_offline_zero_of_fredholm_system
    (fds : FredholmDeterminantSystem (ι := ι))
    (s : ℂ) (hs : s ∈ RightOfflineSupport) (hH : fds.height < |s.im|) : False :=
  no_offline_zero_of_operator_trace_system fds.toOperatorTraceSystem s hs hH

/-- High-frequency zero-freeness from a Fredholm Determinant System. -/
theorem highFrequencyZeroFree_of_fredholm_system
    (fds : FredholmDeterminantSystem (ι := ι)) :
    HighFrequencyZeroFree fds.height :=
  highFrequencyZeroFree_of_operator_trace_system fds.toOperatorTraceSystem

/-- Right-half zero-freeness from a Fredholm Determinant System. -/
theorem rightHalfZeroFree_of_fredholm_system
    (fds : FredholmDeterminantSystem (ι := ι)) : RightHalfZeroFree :=
  rightHalfZeroFree_of_operator_trace_system fds.toOperatorTraceSystem

/-- Conditional deduction of Mathlib's `RiemannHypothesis` from a
`FredholmDeterminantSystem`. -/
theorem RiemannHypothesis_of_fredholm_system
    (fds : FredholmDeterminantSystem (ι := ι)) : RiemannHypothesis :=
  RiemannHypothesis_of_operator_trace_system fds.toOperatorTraceSystem

/-- Spectral Support Confinement from a Fredholm Determinant System. -/
theorem spectralSupportConfinement_of_fredholm_system
    (fds : FredholmDeterminantSystem (ι := ι)) : SpectralSupportConfinement :=
  spectralSupportConfinement_of_operator_trace_system fds.toOperatorTraceSystem

/-- Canonical projection from a FredholmDeterminantSystem into a WeilTraceSystem. -/
def FredholmDeterminantSystem.toWeilTraceSystem
    (fds : FredholmDeterminantSystem (ι := ι)) : WeilTraceSystem :=
  fds.toOperatorTraceSystem.toWeilTraceSystem

end

end BuildingBlocks.ChirpedFredholmDeterminant

open BuildingBlocks.ChirpedFredholmDeterminant

#print axioms fredholmSpectralBalance_iff_weilTraceEquivalence
#print axioms log_fredholm_lower_bound
#print axioms refute_fredholm_balance
#print axioms refute_fredholm_evaluation
#print axioms no_offline_zero_of_fredholm_system
#print axioms highFrequencyZeroFree_of_fredholm_system
#print axioms rightHalfZeroFree_of_fredholm_system
#print axioms RiemannHypothesis_of_fredholm_system
#print axioms spectralSupportConfinement_of_fredholm_system
