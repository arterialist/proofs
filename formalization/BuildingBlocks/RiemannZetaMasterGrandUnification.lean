import BuildingBlocks.RiemannZetaAutonomousGrandPartition
import BuildingBlocks.RiemannZetaHighFrequencySynthesis
import BuildingBlocks.RiemannZetaUnconditionalLowFrequency
import BuildingBlocks.ChirpedUniversalFredholmExclusion
import BuildingBlocks.ChirpedUniversalZeroRefutation
import BuildingBlocks.ChirpedGrandSynthesis
import BuildingBlocks.ChirpedSpectralSupportConfinement
import BuildingBlocks.ChirpedWeilExplicitAdmissibility
import BuildingBlocks.ChirpedOperatorTraceCoercivity
import BuildingBlocks.ChirpedFredholmDeterminant
import BuildingBlocks.ChirpedCarlemanResolventBound
import BuildingBlocks.ChirpedCanonicalWavepacketAdmissibility
import BuildingBlocks.ChirpedLinearSpanDominance
import BuildingBlocks.CriticalTransformRH
import BuildingBlocks.Scope
import BuildingBlocks.Target
import Mathlib.NumberTheory.ZetaValues

/-!
# Module 300: Equivalent RH conditions and conditional consequence packages

This module collects logical equivalences to Mathlib's `RiemannHypothesis` and constructors that
package its consequences. A constructor whose input is an operator, trace, wavepacket, or spectral
system remains conditional on an inhabitant of that system; this module does not construct those
inputs from zeta-function data.

1. **Equivalent formulations**:
   Establishes that Mathlib's formal `RiemannHypothesis`, the repository's `Target`,
   the analytic right-half zero-freeness `RightHalfZeroFree`, the unit-height
   autonomous grand partition `HighFrequencyZeroFree 1`, the open upper-quadrant
   non-vanishing condition, the emptiness of the right off-line zero support
   `RightOfflineSupport = ∅`, the bilateral emptiness
   `LeftOfflineSupport = ∅ ∧ RightOfflineSupport = ∅`, and spectral support
   confinement `SpectralSupportConfinement` are all mutually logically equivalent.

2. **Consequence package (`RHConsequences`)**:
   A record containing an RH hypothesis and consequences derived from it.

3. **Autonomous Operator and Trace System Ingestion**:
   Direct constructors producing `RHConsequences` from each of the 6
   autonomous operator systems of Module 299:
   - `AutonomousWeilTraceSystem`
   - `AutonomousOperatorTraceSystem`
   - `AutonomousFredholmDeterminantSystem`
   - `AutonomousCarlemanResolventSystem`
   - `AutonomousLinearBridgeSystem`
   - `AutonomousCanonicalEvaluationSystem`

4. **Universal and High-Frequency Spectral System Ingestion**:
   Constructors producing `RHConsequences` from:
   - `HighFrequencyFredholmSystem`
   - `HighFrequencyRefutationSystem`
   - `HighFrequencyGrandSynthesisSystem`
   - `UniversalFredholmDeterminantSystem`
   - `UniversalRefutationSystem`
   - `GrandSynthesisSystem`

5. **Zero trichotomy under RH**:
   Under Mathlib's conventions (where the pole at $s = 1$ is assigned value 0),
   assuming `h_rh : RiemannHypothesis`, every zero $s \in \mathbb{C}$ of `riemannZeta` satisfies:
   `s = 1 ∨ (∃ n : ℕ, s = -2 * (n + 1)) ∨ s.re = 1 / 2`.
   Every non-trivial zero is strictly confined to the critical line $\operatorname{Re}(s) = 1/2$,
   with vanishing spectral distance $|s.re - 1/2| = 0$.

All declarations depend strictly on standard Lean 4 foundational axioms:
`[propext, Classical.choice, Quot.sound]`. No custom axioms or unverified assertions.
-/

namespace BuildingBlocks.RiemannZetaMasterGrandUnification

open BuildingBlocks
open BuildingBlocks.ChirpedSpectralSupportConfinement
open BuildingBlocks.ChirpedZeroPartitionSynthesis
open BuildingBlocks.ChirpedPartitionRefutationSynthesis
open BuildingBlocks.ChirpedCanonicalWavepacketAdmissibility
open BuildingBlocks.ChirpedWeilExplicitAdmissibility
open BuildingBlocks.ChirpedOperatorTraceCoercivity
open BuildingBlocks.ChirpedFredholmDeterminant
open BuildingBlocks.ChirpedCarlemanResolventBound
open BuildingBlocks.ChirpedUniversalFredholmExclusion
open BuildingBlocks.ChirpedUniversalZeroRefutation
open BuildingBlocks.ChirpedGrandSynthesis
open BuildingBlocks.RiemannZetaUnconditionalLowFrequency
open BuildingBlocks.RiemannZetaHighFrequencySynthesis
open BuildingBlocks.RiemannZetaAutonomousGrandPartition

/-! ### Part I: Logical equivalences -/

/-- Target is definitionally equal to Mathlib's RiemannHypothesis. -/
theorem target_eq_RH : Target = RiemannHypothesis := rfl

/-- Equivalence between RightHalfZeroFree and RightOfflineSupport = ∅. -/
theorem rightHalfZeroFree_iff_rightOfflineSupport_empty :
    RightHalfZeroFree ↔ RightOfflineSupport = ∅ := by
  constructor
  · intro h
    ext s
    simp only [Set.mem_empty_iff_false, iff_false]
    intro hs
    have hsr : 1 / 2 < s.re := hs.2
    have hz : riemannZeta s = 0 := hs.1.1
    have hs1 : s ≠ 1 := hs.1.2.2
    exact h s hsr hs1 hz
  · intro h s hsr hs1 hz
    have h_not_triv : ¬ ∃ n : ℕ, s = -2 * (n + 1) := by
      rintro ⟨n, rfl⟩
      norm_num at hsr
      have : (0 : ℝ) ≤ n := Nat.cast_nonneg n
      linarith
    have h_mem : s ∈ RightOfflineSupport := ⟨⟨hz, h_not_triv, hs1⟩, hsr⟩
    rw [h] at h_mem
    exact h_mem.elim

/-- Equivalence between RiemannHypothesis and bilateral off-line support emptiness. -/
theorem RiemannHypothesis_iff_offline_supports_empty :
    RiemannHypothesis ↔ LeftOfflineSupport = ∅ ∧ RightOfflineSupport = ∅ := by
  constructor
  · intro h_rh
    have h_conf : SpectralSupportConfinement :=
      spectralSupportConfinement_iff_RiemannHypothesis.mpr h_rh
    constructor
    · ext s
      simp only [Set.mem_empty_iff_false, iff_false]
      intro hs
      have h_crit : s ∈ CriticalLineSupport := h_conf hs.1
      have h_re : s.re = 1 / 2 := h_crit
      have h_lt : s.re < 1 / 2 := hs.2
      linarith
    · ext s
      simp only [Set.mem_empty_iff_false, iff_false]
      intro hs
      have h_crit : s ∈ CriticalLineSupport := h_conf hs.1
      have h_re : s.re = 1 / 2 := h_crit
      have h_gt : 1 / 2 < s.re := hs.2
      linarith
  · intro ⟨_, h_right⟩
    have h_rh_right : RightHalfZeroFree :=
      rightHalfZeroFree_iff_rightOfflineSupport_empty.mpr h_right
    exact target_iff_rightHalfZeroFree.mpr h_rh_right

/-- Zero trichotomy under an explicit Riemann Hypothesis assumption.
Under the Riemann Hypothesis, every zero is either the pole artifact at s = 1,
a trivial negative-even integer zero, or lies on the critical line Re(s) = 1/2. -/
theorem riemann_zeta_zero_trichotomy (h_rh : RiemannHypothesis) (s : ℂ)
    (hz : riemannZeta s = 0) :
    s = 1 ∨ (∃ n : ℕ, s = -2 * (n + 1)) ∨ s.re = 1 / 2 := by
  by_cases hs1 : s = 1
  · exact Or.inl hs1
  · by_cases ht : ∃ n : ℕ, s = -2 * (n + 1)
    · exact Or.inr (Or.inl ht)
    · have h_crit := h_rh s hz ht hs1
      exact Or.inr (Or.inr h_crit)

/-- Zero classification for nontrivial zeros under an explicit RH assumption:
every zero distinct from 1 with Re(s) > 0 lies strictly on the critical line. -/
theorem riemann_zeta_nontrivial_zero_on_critical_line (h_rh : RiemannHypothesis) (s : ℂ)
    (hz : riemannZeta s = 0) (hs1 : s ≠ 1) (hs_pos : 0 < s.re) :
    s.re = 1 / 2 := by
  have ht : ¬ ∃ n : ℕ, s = -2 * (n + 1) := by
    rintro ⟨n, rfl⟩
    norm_num at hs_pos
    have : (0 : ℝ) ≤ n := Nat.cast_nonneg n
    linarith
  exact h_rh s hz ht hs1

/-- Vanishing of spectral distance for every nontrivial zero. -/
theorem riemann_zeta_spectralDistance_zero (h_rh : RiemannHypothesis) {s : ℂ}
    (hs : s ∈ SpectralZeroSupport) : spectralDistance s = 0 := by
  have h_conf : SpectralSupportConfinement :=
    spectralSupportConfinement_iff_RiemannHypothesis.mpr h_rh
  have h_crit : s ∈ CriticalLineSupport := h_conf hs
  unfold spectralDistance
  rw [h_crit, sub_self, abs_zero]

/-! ### Part II: RH consequence package -/

/-- A package containing RH together with several consequences and equivalent formulations. -/
structure RHConsequences where
  rh : RiemannHypothesis
  target : Target
  right_free : RightHalfZeroFree
  high_freq_one : HighFrequencyZeroFree 1
  upper_quadrant_free : ∀ s : ℂ, 1 / 2 < s.re → 1 < s.im → riemannZeta s ≠ 0
  confinement : SpectralSupportConfinement
  right_offline_empty : RightOfflineSupport = ∅
  left_offline_empty : LeftOfflineSupport = ∅
  zero_trichotomy : ∀ s : ℂ, riemannZeta s = 0 → s = 1 ∨ (∃ n : ℕ, s = -2 * (n + 1)) ∨ s.re = 1 / 2

/-- Package the listed consequences of Mathlib's `RiemannHypothesis`. -/
def rhConsequences_of_RH (h_rh : RiemannHypothesis) : RHConsequences where
  rh := h_rh
  target := h_rh
  right_free := target_iff_rightHalfZeroFree.mp h_rh
  high_freq_one := RiemannHypothesis_iff_highFrequencyZeroFree_one.mp h_rh
  upper_quadrant_free := rightHalfZeroFree_iff_high_frequency.mp (target_iff_rightHalfZeroFree.mp h_rh)
  confinement := spectralSupportConfinement_iff_RiemannHypothesis.mpr h_rh
  right_offline_empty := (RiemannHypothesis_iff_offline_supports_empty.mp h_rh).2
  left_offline_empty := (RiemannHypothesis_iff_offline_supports_empty.mp h_rh).1
  zero_trichotomy := riemann_zeta_zero_trichotomy h_rh

/-- Constructor from Target. -/
def rhConsequences_of_target (h : Target) : RHConsequences :=
  rhConsequences_of_RH h

/-- Constructor from RightHalfZeroFree. -/
def rhConsequences_of_rightHalfZeroFree (h : RightHalfZeroFree) : RHConsequences :=
  rhConsequences_of_RH (target_iff_rightHalfZeroFree.mpr h)

/-- Constructor from HighFrequencyZeroFree 1. -/
def rhConsequences_of_highFrequencyZeroFree (h : HighFrequencyZeroFree 1) :
    RHConsequences :=
  rhConsequences_of_RH (RiemannHypothesis_iff_highFrequencyZeroFree_one.mpr h)

/-- Constructor from open upper quadrant zero-freeness. -/
def rhConsequences_of_upper_quadrant
    (h : ∀ s : ℂ, 1 / 2 < s.re → 1 < s.im → riemannZeta s ≠ 0) : RHConsequences :=
  rhConsequences_of_RH (RiemannHypothesis_iff_high_frequency.mpr h)

/-- Constructor from SpectralSupportConfinement. -/
def rhConsequences_of_confinement (h : SpectralSupportConfinement) : RHConsequences :=
  rhConsequences_of_RH (spectralSupportConfinement_iff_RiemannHypothesis.mp h)

/-- Constructor from RightOfflineSupport = ∅. -/
def rhConsequences_of_right_offline_empty (h : RightOfflineSupport = ∅) :
    RHConsequences :=
  rhConsequences_of_rightHalfZeroFree
    (rightHalfZeroFree_iff_rightOfflineSupport_empty.mpr h)

/-- Constructor from bilateral off-line support emptiness. -/
def rhConsequences_of_offline_empty
    (h : LeftOfflineSupport = ∅ ∧ RightOfflineSupport = ∅) : RHConsequences :=
  rhConsequences_of_RH (RiemannHypothesis_iff_offline_supports_empty.mpr h)

/-! ### Part III: Collected equivalences -/

/-- A conjunction of the RH equivalences established by the imported modules and above. -/
theorem rh_equivalent_conditions :
    (RiemannHypothesis ↔ Target) ∧
    (Target ↔ RightHalfZeroFree) ∧
    (RightHalfZeroFree ↔ HighFrequencyZeroFree 1) ∧
    (RightHalfZeroFree ↔ (∀ s : ℂ, 1 / 2 < s.re → 1 < s.im → riemannZeta s ≠ 0)) ∧
    (RightHalfZeroFree ↔ RightOfflineSupport = ∅) ∧
    (RiemannHypothesis ↔ LeftOfflineSupport = ∅ ∧ RightOfflineSupport = ∅) ∧
    (RiemannHypothesis ↔ SpectralSupportConfinement) := by
  refine ⟨Iff.rfl, target_iff_rightHalfZeroFree,
    rightHalfZeroFree_iff_highFrequencyZeroFree_one,
    rightHalfZeroFree_iff_high_frequency,
    rightHalfZeroFree_iff_rightOfflineSupport_empty,
    RiemannHypothesis_iff_offline_supports_empty,
    spectralSupportConfinement_iff_RiemannHypothesis.symm⟩

/-- Logical equivalence between an inhabited consequence package and `RiemannHypothesis`. -/
theorem nonempty_rhConsequences_iff_RiemannHypothesis :
    Nonempty RHConsequences ↔ RiemannHypothesis := by
  constructor
  · rintro ⟨mgu⟩
    exact mgu.rh
  · intro h_rh
    exact ⟨rhConsequences_of_RH h_rh⟩

/-! ### Part IV: Ingestion of Autonomous High-Frequency Operator Systems -/

/-- Consequences conditional on an `AutonomousWeilTraceSystem`. -/
def rhConsequences_of_autonomous_weil
    (sys : AutonomousWeilTraceSystem) : RHConsequences :=
  rhConsequences_of_RH (RiemannHypothesis_of_autonomous_weil_system sys)

/-- Consequences conditional on an `AutonomousOperatorTraceSystem`. -/
def rhConsequences_of_autonomous_operator {ι : Type*} [Fintype ι] [Nonempty ι]
    (sys : AutonomousOperatorTraceSystem ι) : RHConsequences :=
  rhConsequences_of_RH (RiemannHypothesis_of_autonomous_operator_system sys)

/-- Consequences conditional on an `AutonomousFredholmDeterminantSystem`. -/
def rhConsequences_of_autonomous_fredholm {ι : Type*} [Fintype ι] [Nonempty ι]
    (sys : AutonomousFredholmDeterminantSystem ι) : RHConsequences :=
  rhConsequences_of_RH (RiemannHypothesis_of_autonomous_fredholm_system sys)

/-- Consequences conditional on an `AutonomousCarlemanResolventSystem`. -/
def rhConsequences_of_autonomous_carleman {ι : Type*} [Fintype ι] [Nonempty ι]
    (sys : AutonomousCarlemanResolventSystem ι) : RHConsequences :=
  rhConsequences_of_RH (RiemannHypothesis_of_autonomous_carleman_system sys)

/-- Consequences conditional on an `AutonomousLinearBridgeSystem`. -/
def rhConsequences_of_autonomous_linear_bridge
    (sys : AutonomousLinearBridgeSystem) : RHConsequences :=
  rhConsequences_of_RH (RiemannHypothesis_of_autonomous_linear_bridge sys)

/-- Consequences conditional on an `AutonomousCanonicalEvaluationSystem`. -/
def rhConsequences_of_autonomous_canonical
    (sys : AutonomousCanonicalEvaluationSystem) : RHConsequences :=
  rhConsequences_of_RH (RiemannHypothesis_of_autonomous_canonical sys)

/-! ### Part V: Ingestion of High-Frequency and Universal Spectral Systems -/

/-- Consequences conditional on a `HighFrequencyFredholmSystem`. -/
def rhConsequences_of_high_frequency_fredholm
    (sys : HighFrequencyFredholmSystem) : RHConsequences :=
  rhConsequences_of_RH (RiemannHypothesis_of_high_frequency_fredholm sys)

/-- Consequences conditional on a `HighFrequencyZeroRefutationSystem`. -/
def rhConsequences_of_high_frequency_refutation
    (sys : HighFrequencyZeroRefutationSystem) : RHConsequences :=
  rhConsequences_of_RH (RiemannHypothesis_of_high_frequency_refutation sys)

/-- Consequences conditional on a `HighFrequencyGrandSynthesisSystem`. -/
def rhConsequences_of_high_frequency_grand_synthesis
    (sys : HighFrequencyGrandSynthesisSystem) : RHConsequences :=
  rhConsequences_of_RH (RiemannHypothesis_of_high_frequency_grand_synthesis sys)

/-- Consequences conditional on a `UniversalFredholmSystem`. -/
def rhConsequences_of_universal_fredholm
    (sys : UniversalFredholmSystem) : RHConsequences :=
  rhConsequences_of_RH (RiemannHypothesis_of_universal_fredholm sys)

/-- Consequences conditional on a `UniversalZeroRefutationSystem`. -/
def rhConsequences_of_universal_refutation
    (sys : UniversalZeroRefutationSystem) : RHConsequences :=
  rhConsequences_of_RH (RiemannHypothesis_of_universal_refutation sys)

/-- Consequences conditional on a `GrandSynthesisSystem`. -/
def rhConsequences_of_grand_synthesis
    (sys : GrandSynthesisSystem) : RHConsequences :=
  rhConsequences_of_RH (RiemannZetaUnconditionalLowFrequency.RiemannHypothesis_of_grand_synthesis sys)

/-! ### Part VI: Projections from `RHConsequences` -/

/-- Mathlib's official `RiemannHypothesis` is the first field of `RHConsequences`. -/
theorem RiemannHypothesis_of_master (mgu : RHConsequences) : RiemannHypothesis :=
  mgu.rh

/-- Analytic right-half zero-freeness is a field of `RHConsequences`. -/
theorem RightHalfZeroFree_of_master (mgu : RHConsequences) : RightHalfZeroFree :=
  mgu.right_free

/-- Right off-line zero support emptiness is a field of `RHConsequences`. -/
theorem rightOfflineSupport_empty_of_master (mgu : RHConsequences) :
    RightOfflineSupport = ∅ :=
  mgu.right_offline_empty

/-- Left off-line zero support emptiness is a field of `RHConsequences`. -/
theorem leftOfflineSupport_empty_of_master (mgu : RHConsequences) :
    LeftOfflineSupport = ∅ :=
  mgu.left_offline_empty

/-- Spectral support confinement is a field of `RHConsequences`. -/
theorem spectralSupportConfinement_of_master (mgu : RHConsequences) :
    SpectralSupportConfinement :=
  mgu.confinement

/-- The RH-conditional zero trichotomy is a field of `RHConsequences`. -/
theorem riemann_zeta_zero_trichotomy_of_master (mgu : RHConsequences) (s : ℂ)
    (hz : riemannZeta s = 0) :
    s = 1 ∨ (∃ n : ℕ, s = -2 * (n + 1)) ∨ s.re = 1 / 2 :=
  mgu.zero_trichotomy s hz

/-! Compatibility names used by the two downstream modules that predate the descriptive API. -/

abbrev MasterGrandUnification := RHConsequences
abbrev masterGrandUnification_of_RH := rhConsequences_of_RH
abbrev masterGrandUnification_of_autonomous_weil := rhConsequences_of_autonomous_weil
abbrev masterGrandUnification_of_autonomous_operator {ι : Type*} [Fintype ι] [Nonempty ι]
    (sys : AutonomousOperatorTraceSystem ι) : RHConsequences :=
  rhConsequences_of_autonomous_operator sys
abbrev masterGrandUnification_of_autonomous_fredholm {ι : Type*} [Fintype ι] [Nonempty ι]
    (sys : AutonomousFredholmDeterminantSystem ι) : RHConsequences :=
  rhConsequences_of_autonomous_fredholm sys
abbrev masterGrandUnification_of_autonomous_carleman {ι : Type*} [Fintype ι] [Nonempty ι]
    (sys : AutonomousCarlemanResolventSystem ι) : RHConsequences :=
  rhConsequences_of_autonomous_carleman sys
abbrev masterGrandUnification_of_autonomous_linear_bridge :=
  rhConsequences_of_autonomous_linear_bridge
abbrev masterGrandUnification_of_autonomous_canonical := rhConsequences_of_autonomous_canonical

/-- Compatibility theorem for the downstream characteristic-system equivalence. -/
theorem master_grand_unification_iff_RiemannHypothesis :
    Nonempty MasterGrandUnification ↔ RiemannHypothesis :=
  nonempty_rhConsequences_iff_RiemannHypothesis

#print axioms target_eq_RH
#print axioms rightHalfZeroFree_iff_rightOfflineSupport_empty
#print axioms RiemannHypothesis_iff_offline_supports_empty
#print axioms riemann_zeta_zero_trichotomy
#print axioms riemann_zeta_nontrivial_zero_on_critical_line
#print axioms riemann_zeta_spectralDistance_zero
#print axioms rhConsequences_of_RH
#print axioms rh_equivalent_conditions
#print axioms nonempty_rhConsequences_iff_RiemannHypothesis
#print axioms rhConsequences_of_autonomous_weil
#print axioms rhConsequences_of_autonomous_operator
#print axioms rhConsequences_of_autonomous_fredholm
#print axioms rhConsequences_of_autonomous_carleman
#print axioms rhConsequences_of_autonomous_linear_bridge
#print axioms rhConsequences_of_autonomous_canonical
#print axioms rhConsequences_of_high_frequency_fredholm
#print axioms rhConsequences_of_high_frequency_refutation
#print axioms rhConsequences_of_high_frequency_grand_synthesis
#print axioms rhConsequences_of_universal_fredholm
#print axioms rhConsequences_of_universal_refutation
#print axioms rhConsequences_of_grand_synthesis
#print axioms RiemannHypothesis_of_master
#print axioms RightHalfZeroFree_of_master
#print axioms rightOfflineSupport_empty_of_master
#print axioms leftOfflineSupport_empty_of_master
#print axioms spectralSupportConfinement_of_master
#print axioms riemann_zeta_zero_trichotomy_of_master

end BuildingBlocks.RiemannZetaMasterGrandUnification
