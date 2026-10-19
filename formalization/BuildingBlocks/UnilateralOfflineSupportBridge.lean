import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.Bridge
import BuildingBlocks.Scope
import BuildingBlocks.Target

/-!
# Unilateral Off-Line Support Reflection Duality and Spectral Confinement Bridge

This module establishes the exact unilateral reflection duality between the left and right
off-line zero supports of the Riemann zeta function, and connects them to Mathlib's formal
`RiemannHypothesis`, spectral support confinement, and frequency-domain zero-freeness.

## Mathematical Context

The Riemann Hypothesis states that all non-trivial zeros of $\zeta(s)$ lie on the critical line
$\operatorname{Re}(s) = 1/2$. In previous formalizations, the absence of off-line zeros was
frequently stated as a bilateral conjunction (`LeftOfflineSupport = ∅ ∧ RightOfflineSupport = ∅`).

Using the Riemann functional equation reflection theorem `reflect_nontrivial_zero`, this module
proves that non-trivial zeros reflect across the critical line $s \mapsto 1 - s$:
1. $s \in \text{RightOfflineSupport} \implies (1 - s) \in \text{LeftOfflineSupport}$
2. $s \in \text{LeftOfflineSupport} \implies (1 - s) \in \text{RightOfflineSupport}$

Consequently, emptiness of the left off-line support is strictly logically equivalent to emptiness
of the right off-line support:
$$\text{RightOfflineSupport} = \emptyset \iff \text{LeftOfflineSupport} = \emptyset$$

This unifies unilateral zero exclusion with `Target`, `RightHalfZeroFree`, `SpectralSupportConfinement`,
and transverse distance vanishing $\forall s \in \text{SpectralZeroSupport}, |s.\text{re} - 1/2| = 0$.

## Axiom Dependencies

This module depends strictly on standard Lean 4 foundational axioms:
`[propext, Classical.choice, Quot.sound]`, with zero custom axioms and zero `sorry`.
-/

namespace BuildingBlocks

noncomputable section

/-- The spectral zero support: set of all non-trivial zeros of the Riemann zeta function. -/
def SpectralZeroSupport : Set ℂ :=
  {s : ℂ | riemannZeta s = 0 ∧ (¬ ∃ n : ℕ, s = -2 * (n + 1)) ∧ s ≠ 1}

/-- The critical line support: set of complex numbers on the critical line Re(s) = 1/2. -/
def CriticalLineSupport : Set ℂ :=
  {s : ℂ | s.re = 1 / 2}

/-- The right off-line support: non-trivial zeros strictly to the right of the critical line. -/
def RightOfflineSupport : Set ℂ :=
  {s : ℂ | s ∈ SpectralZeroSupport ∧ 1 / 2 < s.re}

/-- The left off-line support: non-trivial zeros strictly to the left of the critical line. -/
def LeftOfflineSupport : Set ℂ :=
  {s : ℂ | s ∈ SpectralZeroSupport ∧ s.re < 1 / 2}

/-- Transverse spectral distance of a zero candidate from the critical line Re(s) = 1/2. -/
def spectralDistance (s : ℂ) : ℝ :=
  |s.re - 1 / 2|

/-- Spectral support confinement: all non-trivial zeros lie on the critical line. -/
def SpectralSupportConfinement : Prop :=
  SpectralZeroSupport ⊆ CriticalLineSupport

/-- High-frequency zero-free condition at ordinate cutoff H: no zeros with Re(s) > 1/2 and |Im(s)| > H. -/
def HighFrequencyZeroFree (H : ℝ) : Prop :=
  ∀ (s : ℂ), riemannZeta s = 0 → s ≠ 1 → H < |s.im| → 1 / 2 < s.re → False

/-- Low-frequency zero-free condition up to ordinate height H: any zero with |Im(s)| ≤ H has Re(s) ≤ 1/2. -/
def LowFrequencyZeroFree (H : ℝ) : Prop :=
  ∀ (s : ℂ), riemannZeta s = 0 → s ≠ 1 → |s.im| ≤ H → s.re ≤ 1 / 2

/-- High-frequency right off-line support above ordinate height H. -/
def RightOfflineSupportAbove (H : ℝ) : Set ℂ :=
  {s ∈ RightOfflineSupport | H < |s.im|}

/-- Points with Re(s) > 1/2 cannot be trivial zeros of the Riemann zeta function. -/
theorem not_trivial_zero_of_half_lt_re {s : ℂ} (hsr : (1 : ℝ) / 2 < s.re) :
    ¬ ∃ n : ℕ, s = -2 * (n + 1) := by
  rintro ⟨n, rfl⟩
  norm_num at hsr
  have : (0 : ℝ) ≤ n := Nat.cast_nonneg n
  linarith

/-- A right off-line non-trivial zero reflects to a left off-line non-trivial zero. -/
theorem right_offline_to_left_offline {s : ℂ} (hs : s ∈ RightOfflineSupport) :
    (1 - s) ∈ LeftOfflineSupport := by
  have hz := hs.1.1
  have ht := hs.1.2.1
  have hs1 := hs.1.2.2
  have hsr := hs.2
  have h_re_lt : (1 - s).re < 1 / 2 := by
    simp only [Complex.sub_re, Complex.one_re]
    linarith
  have h_zeta_zero : riemannZeta (1 - s) = 0 :=
    reflect_nontrivial_zero hz ht hs1
  have h_ne_one : 1 - s ≠ 1 := by
    intro h
    have : s = 0 := by linear_combination -h
    subst s
    exact zeta_zero_ne_origin hz rfl
  have h_not_triv : ¬ ∃ n : ℕ, 1 - s = -2 * (n + 1) := by
    rintro ⟨n, hn⟩
    have hs_eq : s = 1 + 2 * (n + 1 : ℂ) := by
      linear_combination -hn
    have hs_re : 1 < s.re := by
      rw [hs_eq]
      norm_num
      have : (0 : ℝ) ≤ n := Nat.cast_nonneg n
      linarith
    have hz_ne := riemannZeta_ne_zero_of_one_lt_re hs_re
    exact hz_ne hz
  exact ⟨⟨h_zeta_zero, h_not_triv, h_ne_one⟩, h_re_lt⟩

/-- A left off-line non-trivial zero reflects to a right off-line non-trivial zero. -/
theorem left_offline_to_right_offline {s : ℂ} (hs : s ∈ LeftOfflineSupport) :
    (1 - s) ∈ RightOfflineSupport := by
  have hz := hs.1.1
  have ht := hs.1.2.1
  have hs1 := hs.1.2.2
  have hsl := hs.2
  have h_re_gt : 1 / 2 < (1 - s).re := by
    simp only [Complex.sub_re, Complex.one_re]
    linarith
  have h_zeta_zero : riemannZeta (1 - s) = 0 :=
    reflect_nontrivial_zero hz ht hs1
  have h_ne_one : 1 - s ≠ 1 := by
    intro h
    have : s = 0 := by linear_combination -h
    subst s
    exact zeta_zero_ne_origin hz rfl
  have h_not_triv : ¬ ∃ n : ℕ, 1 - s = -2 * (n + 1) := by
    rintro ⟨n, hn⟩
    have hn_re : (1 - s).re = -2 * ((n : ℝ) + 1) := by
      have h1 : (1 - s).re = (-2 * (n + 1 : ℂ)).re := congrArg Complex.re hn
      rw [h1]
      norm_num
    have : (0 : ℝ) ≤ n := Nat.cast_nonneg n
    linarith
  exact ⟨⟨h_zeta_zero, h_not_triv, h_ne_one⟩, h_re_gt⟩

/-- Unilateral reflection duality: emptiness of right off-line support is equivalent to
emptiness of left off-line support. -/
theorem rightOfflineSupport_empty_iff_leftOfflineSupport_empty :
    RightOfflineSupport = ∅ ↔ LeftOfflineSupport = ∅ := by
  constructor
  · intro hr
    ext s
    simp only [Set.mem_empty_iff_false, iff_false]
    intro hs
    have hr_mem := left_offline_to_right_offline hs
    rw [hr] at hr_mem
    exact hr_mem.elim
  · intro hl
    ext s
    simp only [Set.mem_empty_iff_false, iff_false]
    intro hs
    have hl_mem := right_offline_to_left_offline hs
    rw [hl] at hl_mem
    exact hl_mem.elim

/-- Equivalence between RightHalfZeroFree and emptiness of RightOfflineSupport. -/
theorem rightHalfZeroFree_iff_rightOfflineSupport_empty :
    RightHalfZeroFree ↔ RightOfflineSupport = ∅ := by
  constructor
  · intro h
    ext s
    simp only [Set.mem_empty_iff_false, iff_false]
    intro ⟨⟨hz, _, hs1⟩, hsr⟩
    exact h s hsr hs1 hz
  · intro h s hsr hs1 hz
    have ht := not_trivial_zero_of_half_lt_re hsr
    have h_mem : s ∈ RightOfflineSupport := ⟨⟨hz, ht, hs1⟩, hsr⟩
    rw [h] at h_mem
    exact h_mem.elim

/-- Equivalence between RiemannHypothesis and emptiness of RightOfflineSupport. -/
theorem RiemannHypothesis_iff_rightOfflineSupport_empty :
    RiemannHypothesis ↔ RightOfflineSupport = ∅ := by
  change Target ↔ RightOfflineSupport = ∅
  rw [target_iff_rightHalfZeroFree]
  exact rightHalfZeroFree_iff_rightOfflineSupport_empty

/-- Equivalence between RiemannHypothesis and emptiness of LeftOfflineSupport. -/
theorem RiemannHypothesis_iff_leftOfflineSupport_empty :
    RiemannHypothesis ↔ LeftOfflineSupport = ∅ := by
  rw [RiemannHypothesis_iff_rightOfflineSupport_empty]
  exact rightOfflineSupport_empty_iff_leftOfflineSupport_empty

/-- Bilateral off-line support emptiness collapses to unilateral right off-line support emptiness. -/
theorem offline_supports_empty_iff_rightOfflineSupport_empty :
    LeftOfflineSupport = ∅ ∧ RightOfflineSupport = ∅ ↔ RightOfflineSupport = ∅ := by
  constructor
  · exact fun h => h.2
  · intro h
    exact ⟨rightOfflineSupport_empty_iff_leftOfflineSupport_empty.mp h, h⟩

/-- Bilateral off-line support emptiness collapses to unilateral left off-line support emptiness. -/
theorem offline_supports_empty_iff_leftOfflineSupport_empty :
    LeftOfflineSupport = ∅ ∧ RightOfflineSupport = ∅ ↔ LeftOfflineSupport = ∅ := by
  constructor
  · exact fun h => h.1
  · intro h
    exact ⟨h, rightOfflineSupport_empty_iff_leftOfflineSupport_empty.mpr h⟩

/-- Spectral support confinement is equivalent to Mathlib's RiemannHypothesis. -/
theorem spectralSupportConfinement_iff_RiemannHypothesis :
    SpectralSupportConfinement ↔ RiemannHypothesis := by
  constructor
  · intro h s hz ht hs
    exact h ⟨hz, ht, hs⟩
  · intro h s hs
    rcases hs with ⟨hz, ht, hne⟩
    exact h s hz ht hne

/-- Spectral support confinement is equivalent to vanishing transverse spectral distance. -/
theorem spectralSupportConfinement_iff_spectralDistance_zero :
    SpectralSupportConfinement ↔ ∀ s ∈ SpectralZeroSupport, spectralDistance s = 0 := by
  constructor
  · intro h s hs
    have h_crit : s ∈ CriticalLineSupport := h hs
    unfold spectralDistance CriticalLineSupport at *
    rw [h_crit, sub_self, abs_zero]
  · intro h s hs
    have hd := h s hs
    unfold spectralDistance CriticalLineSupport at *
    rw [abs_eq_zero, sub_eq_zero] at hd
    exact hd

/-- Stratified high-frequency support emptiness equivalence at height H. -/
theorem rightOfflineSupportAbove_empty_iff_highFrequencyZeroFree (H : ℝ) :
    RightOfflineSupportAbove H = ∅ ↔ HighFrequencyZeroFree H := by
  constructor
  · intro h s hz hs1 hH hsr
    have ht := not_trivial_zero_of_half_lt_re hsr
    have h_mem : s ∈ RightOfflineSupportAbove H :=
      ⟨⟨⟨hz, ht, hs1⟩, hsr⟩, hH⟩
    rw [h] at h_mem
    exact h_mem.elim
  · intro h
    ext s
    simp only [Set.mem_empty_iff_false, iff_false]
    intro ⟨⟨⟨hz, _, hs1⟩, hsr⟩, hH⟩
    exact h s hz hs1 hH hsr

/-- Monotonicity of high-frequency zero-freeness in the ordinate threshold. -/
theorem highFrequencyZeroFree_mono {H₁ H₂ : ℝ} (hle : H₁ ≤ H₂)
    (h₁ : HighFrequencyZeroFree H₁) : HighFrequencyZeroFree H₂ := by
  intro s hz hs hH hsr
  exact h₁ s hz hs (hle.trans_lt hH) hsr

/-- Under low-frequency zero-freeness up to height H, global right support emptiness
is equivalent to high-frequency zero-freeness above height H. -/
theorem rightOfflineSupport_empty_iff_highFrequencyZeroFree_of_low {H : ℝ}
    (h_low : LowFrequencyZeroFree H) :
    RightOfflineSupport = ∅ ↔ HighFrequencyZeroFree H := by
  constructor
  · intro h s hz hs hH hsr
    have ht := not_trivial_zero_of_half_lt_re hsr
    have h_mem : s ∈ RightOfflineSupport := ⟨⟨hz, ht, hs⟩, hsr⟩
    rw [h] at h_mem
    exact h_mem.elim
  · intro h_high
    ext s
    simp only [Set.mem_empty_iff_false, iff_false]
    intro ⟨⟨hz, _, hs⟩, hsr⟩
    by_cases hle : |s.im| ≤ H
    · have := h_low s hz hs hle
      linarith
    · exact h_high s hz hs (not_le.mp hle) hsr

/-- Complete master equivalence chain across unilateral and bilateral formulations. -/
theorem unilateral_rh_equivalence_chain :
    (RiemannHypothesis ↔ Target) ∧
    (Target ↔ RightHalfZeroFree) ∧
    (RightHalfZeroFree ↔ RightOfflineSupport = ∅) ∧
    (RightOfflineSupport = ∅ ↔ LeftOfflineSupport = ∅) ∧
    (RightOfflineSupport = ∅ ↔ LeftOfflineSupport = ∅ ∧ RightOfflineSupport = ∅) ∧
    (RiemannHypothesis ↔ SpectralSupportConfinement) ∧
    (SpectralSupportConfinement ↔ ∀ s ∈ SpectralZeroSupport, spectralDistance s = 0) := by
  refine ⟨Iff.rfl, target_iff_rightHalfZeroFree,
    rightHalfZeroFree_iff_rightOfflineSupport_empty,
    rightOfflineSupport_empty_iff_leftOfflineSupport_empty,
    offline_supports_empty_iff_rightOfflineSupport_empty.symm,
    spectralSupportConfinement_iff_RiemannHypothesis.symm,
    spectralSupportConfinement_iff_spectralDistance_zero⟩

end

end BuildingBlocks
