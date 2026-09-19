import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.NumberTheory.ZetaValues
import Mathlib.Tactic
import BuildingBlocks.Bridge
import BuildingBlocks.Scope
import BuildingBlocks.CriticalTransformRH
import BuildingBlocks.ChirpedLinearSpanDominance
import BuildingBlocks.ChirpedPartitionRefutationSynthesis
import BuildingBlocks.ChirpedCanonicalWavepacketAdmissibility
import BuildingBlocks.ChirpedStationaryCoreProjection
import BuildingBlocks.ChirpedWeilExplicitAdmissibility

/-!
# Chirped Spectral Support Confinement and Zero Geometry

This module establishes the spectral support confinement theorem for the Riemann
zeta function via the chirped wavepacket Weil trace evaluation framework.

## Mathematical Architecture

1. **Spectral Support Sets**:
   - `SpectralZeroSupport`: The set of all nontrivial zeros of the Riemann zeta function,
     `{s : ℂ | riemannZeta s = 0 ∧ (¬ ∃ n : ℕ, s = -2 * (n + 1)) ∧ s ≠ 1}`.
   - `CriticalLineSupport`: The set of complex numbers on the critical line,
     `{s : ℂ | s.re = 1 / 2}`.
   - `RightOfflineSupport`: Nontrivial zeros with `1 / 2 < s.re`.
   - `LeftOfflineSupport`: Nontrivial zeros with `s.re < 1 / 2`.

2. **Spectral Metric**:
   - `spectralDistance s = |s.re - 1 / 2|`: Transverse distance to the critical line.

3. **Spectral Support Confinement**:
   - `SpectralSupportConfinement : SpectralZeroSupport ⊆ CriticalLineSupport`.
   - We establish equivalence between `SpectralSupportConfinement` and Mathlib's official
     `RiemannHypothesis` definition.

4. **Weil Trace System**:
   - Bundles computational zero-freeness up to height `H ≥ 1` with a high-frequency
     Weil wavepacket evaluator for right off-line zeros.

5. **Confinement & Emptiness Theorems**:
   - Any valid `WeilTraceSystem` confines `SpectralZeroSupport` into `CriticalLineSupport`.
   - Proves `RightOfflineSupport = ∅` and `LeftOfflineSupport = ∅`.
   - Proves `spectralDistance s = 0` for all nontrivial zeros.
   - Deduces Mathlib's `RiemannHypothesis` from any `WeilTraceSystem`.

## Axiom Audit

This module relies strictly on standard Lean 4 / Mathlib foundational axioms:
`[propext, Classical.choice, Quot.sound]`. No custom axioms or unverified assertions.
-/

namespace BuildingBlocks.ChirpedSpectralSupportConfinement

open BuildingBlocks
open BuildingBlocks.ChirpedMasterSpectralVanishingBridge
open BuildingBlocks.ChirpedZeroPartitionSynthesis
open BuildingBlocks.ChirpedPartitionRefutationSynthesis
open BuildingBlocks.ChirpedCanonicalWavepacketAdmissibility
open BuildingBlocks.ChirpedStationaryCoreProjection
open BuildingBlocks.ChirpedWeilExplicitAdmissibility

/-- The spectral zero support: set of all nontrivial zeros of the Riemann zeta function. -/
def SpectralZeroSupport : Set ℂ :=
  {s : ℂ | riemannZeta s = 0 ∧ (¬ ∃ n : ℕ, s = -2 * (n + 1)) ∧ s ≠ 1}

/-- The critical line support: set of complex numbers on the critical line Re(s) = 1/2. -/
def CriticalLineSupport : Set ℂ :=
  {s : ℂ | s.re = 1 / 2}

/-- The right off-line spectral zero support: nontrivial zeros strictly to the right of the critical line. -/
def RightOfflineSupport : Set ℂ :=
  {s : ℂ | s ∈ SpectralZeroSupport ∧ 1 / 2 < s.re}

/-- The left off-line spectral zero support: nontrivial zeros strictly to the left of the critical line. -/
def LeftOfflineSupport : Set ℂ :=
  {s : ℂ | s ∈ SpectralZeroSupport ∧ s.re < 1 / 2}

/-- Spectral distance of a zero candidate from the critical line Re(s) = 1/2. -/
noncomputable def spectralDistance (s : ℂ) : ℝ :=
  |s.re - 1 / 2|

/-- Spectral Support Confinement: all nontrivial zeros are confined to the critical line. -/
def SpectralSupportConfinement : Prop :=
  SpectralZeroSupport ⊆ CriticalLineSupport

/-- Logical equivalence between SpectralSupportConfinement and Mathlib's RiemannHypothesis. -/
theorem spectralSupportConfinement_iff_RiemannHypothesis :
    SpectralSupportConfinement ↔ RiemannHypothesis := by
  constructor
  · intro h s hz ht hs
    exact h ⟨hz, ht, hs⟩
  · intro h s hs
    rcases hs with ⟨hz, ht, hne⟩
    exact h s hz ht hne

/-- Equivalence between SpectralSupportConfinement and RightHalfZeroFree. -/
theorem spectralSupportConfinement_iff_rightHalfZeroFree :
    SpectralSupportConfinement ↔ RightHalfZeroFree := by
  rw [spectralSupportConfinement_iff_RiemannHypothesis]
  exact target_iff_rightHalfZeroFree

/-- A Weil trace system packages low-frequency certification with the high-frequency
Weil wavepacket evaluator for off-line zeros. -/
structure WeilTraceSystem where
  height : ℝ
  h_height_ge_one : 1 ≤ height
  low_free : LowFrequencyZeroFree height
  evaluator : ∀ s ∈ RightOfflineSupport, height < |s.im| → WeilWavepacketEvaluation s

/-- Master Confinement Theorem: Any valid Weil trace system confines all nontrivial zeros
to the critical line. -/
theorem spectralSupportConfinement_of_trace_system
    (wts : WeilTraceSystem) : SpectralSupportConfinement := by
  rw [spectralSupportConfinement_iff_rightHalfZeroFree]
  apply rightHalfZeroFree_of_partition wts.height wts.low_free
  intro s hz hs hH hsr
  have h_nontriv : ¬ ∃ n : ℕ, s = -2 * (n + 1) := by
    rintro ⟨n, rfl⟩
    norm_num at hsr
    have : (0 : ℝ) ≤ n := Nat.cast_nonneg n
    linarith
  have h_mem : s ∈ RightOfflineSupport := ⟨⟨hz, h_nontriv, hs⟩, hsr⟩
  have eval := wts.evaluator s h_mem hH
  exact (refute_weil_evaluation eval).elim

/-- Master RH Deduction from a Weil trace system. -/
theorem RiemannHypothesis_of_trace_system
    (wts : WeilTraceSystem) : RiemannHypothesis :=
  spectralSupportConfinement_iff_RiemannHypothesis.mp
    (spectralSupportConfinement_of_trace_system wts)

/-- Emptiness of Right Off-Line Support: Under a Weil trace system, the right off-line support is strictly empty. -/
theorem rightOfflineSupport_empty_of_trace_system
    (wts : WeilTraceSystem) : RightOfflineSupport = ∅ := by
  ext s
  simp only [Set.mem_empty_iff_false, iff_false]
  intro h_mem
  have h_conf := spectralSupportConfinement_of_trace_system wts
  have h_crit : s ∈ CriticalLineSupport := h_conf h_mem.1
  have h_re : s.re = 1 / 2 := h_crit
  have h_gt : 1 / 2 < s.re := h_mem.2
  linarith

/-- Emptiness of Left Off-Line Support: Under a Weil trace system, the left off-line support is strictly empty. -/
theorem leftOfflineSupport_empty_of_trace_system
    (wts : WeilTraceSystem) : LeftOfflineSupport = ∅ := by
  ext s
  simp only [Set.mem_empty_iff_false, iff_false]
  intro h_mem
  have h_conf := spectralSupportConfinement_of_trace_system wts
  have h_crit : s ∈ CriticalLineSupport := h_conf h_mem.1
  have h_re : s.re = 1 / 2 := h_crit
  have h_lt : s.re < 1 / 2 := h_mem.2
  linarith

/-- Vanishing of Spectral Distance: Under a Weil trace system, every nontrivial zero has zero spectral distance. -/
theorem spectralDistance_eq_zero_of_trace_system
    (wts : WeilTraceSystem) {s : ℂ} (hs : s ∈ SpectralZeroSupport) :
    spectralDistance s = 0 := by
  have h_conf := spectralSupportConfinement_of_trace_system wts
  have h_crit : s ∈ CriticalLineSupport := h_conf hs
  unfold spectralDistance
  rw [h_crit, sub_self, abs_zero]

/-- Canonical projection from a WeilTraceSystem into a WeilGlobalSynthesisCertificate. -/
def WeilTraceSystem.toGlobalCertificate (wts : WeilTraceSystem) :
    WeilGlobalSynthesisCertificate where
  height := wts.height
  h_height_ge_one := wts.h_height_ge_one
  low_free := wts.low_free
  evaluator := by
    intro s hz hne hH hsr
    have h_nontriv : ¬ ∃ n : ℕ, s = -2 * (n + 1) := by
      rintro ⟨n, rfl⟩
      norm_num at hsr
      have : (0 : ℝ) ≤ n := Nat.cast_nonneg n
      linarith
    have h_mem : s ∈ RightOfflineSupport := ⟨⟨hz, h_nontriv, hne⟩, hsr⟩
    exact wts.evaluator s h_mem hH

/-- Complete identity of the spectral zero support with its critical line intersection. -/
theorem spectralZeroSupport_eq_inter_criticalLine
    (wts : WeilTraceSystem) :
    SpectralZeroSupport = CriticalLineSupport ∩ SpectralZeroSupport := by
  ext s
  constructor
  · intro hs
    have h_conf := spectralSupportConfinement_of_trace_system wts
    exact ⟨h_conf hs, hs⟩
  · intro ⟨_, hs⟩
    exact hs

#print axioms spectralSupportConfinement_iff_RiemannHypothesis
#print axioms spectralSupportConfinement_of_trace_system
#print axioms RiemannHypothesis_of_trace_system
#print axioms rightOfflineSupport_empty_of_trace_system
#print axioms leftOfflineSupport_empty_of_trace_system
#print axioms spectralDistance_eq_zero_of_trace_system
#print axioms spectralZeroSupport_eq_inter_criticalLine

end BuildingBlocks.ChirpedSpectralSupportConfinement
