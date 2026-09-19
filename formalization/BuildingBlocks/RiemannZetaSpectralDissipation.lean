/-
Copyright (c) 2026 Formalized Riemann Hypothesis Project. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Formalized Riemann Hypothesis Team
-/
import BuildingBlocks.RiemannZetaCharacteristicDeterminant

/-!
# Module 302: Spectral Dissipation and Symmetrized Resolvent Energy Identity for the Riemann Hypothesis

Building directly upon **Module 301** (`RiemannZetaCharacteristicDeterminant`), this module establishes
the theory of **Spectral Dissipation** $\mathcal{D}(s, x)$ along the real spectral axis $\mathbb{R}$
governed by the quadratic spectral parameter $z(s) = s(1 - s)$.

## 1. Mathematical Formulation

For any complex spectral parameter $s = \sigma + i t \in \mathbb{C}$ and any real probe energy $x \in \mathbb{R}$,
the **spectral dissipation** is defined as the imaginary defect of the characteristic resolvent kernel:
$$\mathcal{D}(s, x) := \operatorname{Im}\left( R(z(s), x) \right) = \operatorname{Im}\left(\frac{1}{z(s) - x}\right) = \frac{-\operatorname{Im}(z(s))}{|z(s) - x|^2}.$$

In explicit coordinates:
- The numerator is:
  $$-\operatorname{Im}(z(s)) = -t(1 - 2\sigma) = t(2\sigma - 1).$$
- The denominator is the Euclidean distance squared in the complex spectral plane:
  $$|z(s) - x|^2 = (\operatorname{Re}(z(s)) - x)^2 + \operatorname{Im}(z(s))^2 = (\sigma(1 - \sigma) + t^2 - x)^2 + t^2(1 - 2\sigma)^2.$$

## 2. Fundamental Structural Properties Formalized

1. **Exact Coordinate Formula**:
   $$\mathcal{D}(s, x) = \frac{t(2\sigma - 1)}{|z(s) - x|^2}.$$
2. **Vanishing on the Critical Line**:
   $$\sigma = \frac{1}{2} \implies 2\sigma - 1 = 0 \implies \mathcal{D}(s, x) = 0 \quad (\forall x \in \mathbb{R}).$$
3. **Strict Quadrant Positivity**:
   $$\sigma > \frac{1}{2}, \ t > 0 \implies \mathcal{D}(s, x) > 0 \quad (\forall x \in \mathbb{R} \setminus \{z(s)\}).$$
4. **Strict Quadrant Negativity**:
   $$\sigma > \frac{1}{2}, \ t < 0 \implies \mathcal{D}(s, x) < 0 \quad (\forall x \in \mathbb{R} \setminus \{z(s)\}).$$
5. **Functional Reflection Invariance**:
   $$\mathcal{D}(1 - s, x) = \mathcal{D}(s, x) \quad (\forall s \in \mathbb{C}, x \in \mathbb{R}),$$
   arising identically from the reflection invariance $z(1 - s) = z(s)$.
6. **Complex Conjugation Antisymmetry**:
   $$\mathcal{D}(\bar{s}, x) = -\mathcal{D}(s, x) \quad (\forall s \in \mathbb{C}, x \in \mathbb{R}).$$
7. **Resonance and Peak Dissipation**:
   The dissipation along $\mathbb{R}$ attains its global extremum at the resonant probe frequency:
   $$x^* = \operatorname{resonantFrequency}(s) := \operatorname{Re}(z(s)) = \sigma(1 - \sigma) + t^2.$$
   At this resonant frequency, the denominator reduces to $\operatorname{Im}(z(s))^2$, yielding the peak value:
   $$\mathcal{D}(s, x^*) = \frac{1}{t(2\sigma - 1)}.$$
   For $\sigma > 1/2, t > 0$, the dissipation at every $x \in \mathbb{R}$ is bounded above by this resonant peak:
   $$\mathcal{D}(s, x) \le \mathcal{D}(s, x^*).$$
8. **Conservative Spectral Balance**:
   The condition that all non-trivial zeros $\rho$ of $\zeta(s)$ exhibit vanishing dissipation on $\mathbb{R}$:
   $$\forall x \in \mathbb{R}, \quad \mathcal{D}(\rho, x) = 0.$$
   We prove the definitive Millennium equivalence:
   $$\text{ConservativeSpectralBalance} \iff \text{RiemannHypothesis}.$$

## 3. System Architecture

The module encapsulates these structures into `ZetaSpectralDissipationSystem` and provides
canonical constructors from:
- `RiemannHypothesis`
- `MasterGrandUnification`
- `ZetaCharacteristicDeterminantSystem`
- All 6 autonomous operator systems from Modules 294–299.
-/

open Complex
open BuildingBlocks.ChirpedSpectralSupportConfinement
open BuildingBlocks.RiemannZetaRealAxisDischarge
open BuildingBlocks.RiemannZetaRealAxisUnconditional
open BuildingBlocks.RiemannZetaMasterGrandUnification
open BuildingBlocks.RiemannZetaCharacteristicDeterminant
open BuildingBlocks.RiemannZetaAutonomousGrandPartition

namespace BuildingBlocks.RiemannZetaSpectralDissipation

/-- Symmetrized spectral dissipation: the imaginary part of the resolvent kernel on the real line. -/
noncomputable def spectralDissipation (s : ℂ) (x : ℝ) : ℝ :=
  (charResolvent (spectralParam s) (x : ℂ)).im

/-- Formula for the spectral dissipation in terms of s coordinates and real parameter x. -/
theorem spectralDissipation_eq (s : ℂ) (x : ℝ) :
    spectralDissipation s x = - (spectralParam s).im / normSq (spectralParam s - (x : ℂ)) := by
  dsimp [spectralDissipation]
  exact charResolvent_real_axis_im (spectralParam s) x

/-- The spectral dissipation can be written with the coordinate numerator s.im * (2 * s.re - 1). -/
theorem spectralDissipation_eq_coords (s : ℂ) (x : ℝ) :
    spectralDissipation s x = (s.im * (2 * s.re - 1)) / normSq (spectralParam s - (x : ℂ)) := by
  rw [spectralDissipation_eq, spectralParam_im]
  have : - (s.im * (1 - 2 * s.re)) = s.im * (2 * s.re - 1) := by ring
  rw [this]

/-- The denominator of spectral dissipation decomposed into real and imaginary coordinate squares. -/
theorem spectralDissipation_denom_eq (s : ℂ) (x : ℝ) :
    normSq (spectralParam s - (x : ℂ)) =
      ((spectralParam s).re - x)^2 + ((spectralParam s).im)^2 := by
  rw [normSq_apply]
  simp only [sub_re, ofReal_re, sub_im, ofReal_im, sub_zero]
  ring

/-- Resonant frequency of the spectral parameter. -/
noncomputable def resonantFrequency (s : ℂ) : ℝ := (spectralParam s).re

/-- Resonant frequency in terms of s coordinates. -/
theorem resonantFrequency_eq (s : ℂ) :
    resonantFrequency s = s.re * (1 - s.re) + s.im^2 := by
  dsimp [resonantFrequency]
  exact spectralParam_re s

/-- At resonance x = resonantFrequency s, the denominator is the square of the imaginary part. -/
theorem spectralDissipation_denom_at_resonance (s : ℂ) :
    normSq (spectralParam s - (resonantFrequency s : ℂ)) = ((spectralParam s).im)^2 := by
  rw [spectralDissipation_denom_eq]
  dsimp [resonantFrequency]
  ring

/-- Peak spectral dissipation at resonance: equals -1 / (spectralParam s).im. -/
theorem spectralDissipation_at_resonance {s : ℂ} (h_im_ne : (spectralParam s).im ≠ 0) :
    spectralDissipation s (resonantFrequency s) = - 1 / (spectralParam s).im := by
  rw [spectralDissipation_eq, spectralDissipation_denom_at_resonance]
  have h_sq : ((spectralParam s).im)^2 = (spectralParam s).im * (spectralParam s).im := sq ((spectralParam s).im)
  rw [h_sq]
  have h_cancel : - (spectralParam s).im / ((spectralParam s).im * (spectralParam s).im) =
    - 1 / (spectralParam s).im := by
    field_simp [h_im_ne]
  exact h_cancel

/-- Peak spectral dissipation expressed in coordinates: equals 1 / (s.im * (2 * s.re - 1)). -/
theorem spectralDissipation_at_resonance_coords {s : ℂ}
    (ht : s.im ≠ 0) (hs : s.re ≠ 1 / 2) :
    spectralDissipation s (resonantFrequency s) = 1 / (s.im * (2 * s.re - 1)) := by
  have h_im_param : (spectralParam s).im ≠ 0 := by
    rw [spectralParam_im]
    have h1 : 1 - 2 * s.re ≠ 0 := by intro h; apply hs; linarith
    exact mul_ne_zero ht h1
  rw [spectralDissipation_at_resonance h_im_param, spectralParam_im]
  have h_neg : s.im * (1 - 2 * s.re) = - (s.im * (2 * s.re - 1)) := by ring
  rw [h_neg]
  exact neg_div_neg_eq 1 (s.im * (2 * s.re - 1))

/-- Resonant lower bound for the denominator: for all x ∈ ℝ, the denominator is at least ((spectralParam s).im)^2. -/
theorem spectralDissipation_denom_ge_resonance (s : ℂ) (x : ℝ) :
    ((spectralParam s).im)^2 ≤ normSq (spectralParam s - (x : ℂ)) := by
  rw [spectralDissipation_denom_eq]
  have : 0 ≤ ((spectralParam s).re - x)^2 := sq_nonneg _
  linarith

/-- In the right upper quadrant, the spectral dissipation at any probe point x ∈ ℝ
    is bounded above by its resonant peak value. -/
theorem spectralDissipation_le_resonant_peak {s : ℂ}
    (hsigma : 1 / 2 < s.re) (ht : 0 < s.im) (x : ℝ) :
    spectralDissipation s x ≤ spectralDissipation s (resonantFrequency s) := by
  rw [spectralDissipation_eq_coords, spectralDissipation_eq_coords]
  have h_num_nonneg : 0 ≤ s.im * (2 * s.re - 1) := by
    have h1 : 0 < 2 * s.re - 1 := by linarith [hsigma]
    exact le_of_lt (mul_pos ht h1)
  have h_im_ne : (spectralParam s).im ≠ 0 := by
    rw [spectralParam_im]
    have h1 : 1 - 2 * s.re ≠ 0 := by intro h; linarith [hsigma]
    exact mul_ne_zero (ne_of_gt ht) h1
  have h_denom_res_pos : 0 < normSq (spectralParam s - (resonantFrequency s : ℂ)) := by
    rw [spectralDissipation_denom_at_resonance]
    exact sq_pos_of_ne_zero h_im_ne
  have h_denom_le : normSq (spectralParam s - (resonantFrequency s : ℂ)) ≤
      normSq (spectralParam s - (x : ℂ)) := by
    rw [spectralDissipation_denom_at_resonance]
    exact spectralDissipation_denom_ge_resonance s x
  exact div_le_div_of_nonneg_left h_num_nonneg h_denom_res_pos h_denom_le

/-- On the critical line, the spectral dissipation vanishes identically for all x ∈ ℝ. -/
theorem spectralDissipation_critical_line {s : ℂ} (hs : s.re = 1 / 2) (x : ℝ) :
    spectralDissipation s x = 0 := by
  rw [spectralDissipation_eq_coords]
  have : 2 * s.re - 1 = 0 := by linarith [hs]
  rw [this, mul_zero, zero_div]

/-- In the right upper quadrant, the spectral dissipation is strictly positive everywhere on ℝ
    for any point with spectral parameter distinct from x. -/
theorem spectralDissipation_pos_of_right_upper {s : ℂ}
    (hsigma : 1 / 2 < s.re) (ht : 0 < s.im) (x : ℝ)
    (hwx : spectralParam s ≠ (x : ℂ)) :
    0 < spectralDissipation s x := by
  rw [spectralDissipation_eq_coords]
  have h_num_pos : 0 < s.im * (2 * s.re - 1) := by
    have h1 : 0 < 2 * s.re - 1 := by linarith [hsigma]
    exact mul_pos ht h1
  have h_diff_ne : spectralParam s - (x : ℂ) ≠ 0 := sub_ne_zero.mpr hwx
  have h_denom_pos : 0 < normSq (spectralParam s - (x : ℂ)) := normSq_pos.mpr h_diff_ne
  exact div_pos h_num_pos h_denom_pos

/-- In the right lower quadrant, the spectral dissipation is strictly negative everywhere on ℝ. -/
theorem spectralDissipation_neg_of_right_lower {s : ℂ}
    (hsigma : 1 / 2 < s.re) (ht : s.im < 0) (x : ℝ)
    (hwx : spectralParam s ≠ (x : ℂ)) :
    spectralDissipation s x < 0 := by
  rw [spectralDissipation_eq_coords]
  have h_num_neg : s.im * (2 * s.re - 1) < 0 := by
    have h1 : 0 < 2 * s.re - 1 := by linarith [hsigma]
    exact mul_neg_of_neg_of_pos ht h1
  have h_diff_ne : spectralParam s - (x : ℂ) ≠ 0 := sub_ne_zero.mpr hwx
  have h_denom_pos : 0 < normSq (spectralParam s - (x : ℂ)) := normSq_pos.mpr h_diff_ne
  exact div_neg_of_neg_of_pos h_num_neg h_denom_pos

/-- Reflection invariance of spectral dissipation under s ↦ 1 - s. -/
theorem spectralDissipation_reflection (s : ℂ) (x : ℝ) :
    spectralDissipation (1 - s) x = spectralDissipation s x := by
  dsimp [spectralDissipation]
  rw [spectralParam_reflection]

/-- Conjugation covariance of the spectral parameter: z(star s) = star (z(s)). -/
theorem spectralParam_star (s : ℂ) :
    spectralParam (star s) = star (spectralParam s) := by
  apply Complex.ext
  · simp only [Complex.star_def, Complex.conj_re]
    rw [spectralParam_re, spectralParam_re]
    simp only [Complex.conj_re, Complex.conj_im]
    ring
  · simp only [Complex.star_def, Complex.conj_im]
    rw [spectralParam_im, spectralParam_im]
    simp only [Complex.conj_re, Complex.conj_im]
    ring

/-- Invariance of the denominator normSq under conjugation. -/
theorem normSq_sub_real_star (w : ℂ) (x : ℝ) :
    normSq (star w - (x : ℂ)) = normSq (w - (x : ℂ)) := by
  rw [normSq_apply, normSq_apply]
  simp only [Complex.sub_re, Complex.sub_im, Complex.ofReal_re, Complex.ofReal_im,
    Complex.star_def, Complex.conj_re, Complex.conj_im]
  ring

/-- Antisymmetry of spectral dissipation under complex conjugation s ↦ star s. -/
theorem spectralDissipation_star (s : ℂ) (x : ℝ) :
    spectralDissipation (star s) x = - spectralDissipation s x := by
  rw [spectralDissipation_eq_coords, spectralDissipation_eq_coords]
  rw [spectralParam_star, normSq_sub_real_star]
  simp only [Complex.star_def, Complex.conj_re, Complex.conj_im]
  ring

/-- Conservative spectral balance condition: all non-trivial zeros produce zero dissipation on ℝ. -/
def ConservativeSpectralBalance : Prop :=
  ∀ s : ℂ, riemannZeta s = 0 → s ≠ 1 → (¬ ∃ n : ℕ, s = -2 * (n + 1)) →
    ∀ x : ℝ, spectralDissipation s x = 0

/-- ConservativeSpectralBalance implies CharacteristicSpectralReality. -/
theorem characteristic_spectral_reality_of_conservative (h_bal : ConservativeSpectralBalance) :
    CharacteristicSpectralReality := by
  intro s hz hne1 hntriv
  have h_diss := h_bal s hz hne1 hntriv 0
  rw [spectralDissipation_eq] at h_diss
  by_cases h_diff : spectralParam s - (0 : ℂ) = 0
  · rw [sub_zero] at h_diff
    have : (spectralParam s).im = 0 := by rw [h_diff]; rfl
    exact this
  · have h_denom_pos : 0 < normSq (spectralParam s - (0 : ℂ)) := normSq_pos.mpr h_diff
    have h_num_zero : - (spectralParam s).im = 0 :=
      (div_eq_zero_iff.mp h_diss).resolve_right (ne_of_gt h_denom_pos)
    exact neg_eq_zero.mp h_num_zero

/-- ConservativeSpectralBalance implies RiemannHypothesis. -/
theorem RiemannHypothesis_of_conservative (h_bal : ConservativeSpectralBalance) :
    RiemannHypothesis :=
  RiemannHypothesis_of_csr (characteristic_spectral_reality_of_conservative h_bal)

/-- RiemannHypothesis implies ConservativeSpectralBalance. -/
theorem conservative_of_RiemannHypothesis (h_RH : RiemannHypothesis) :
    ConservativeSpectralBalance := by
  intro s hz hne1 hntriv x
  have hre : s.re = 1 / 2 := h_RH s hz hntriv hne1
  exact spectralDissipation_critical_line hre x

/-- Equivalence between ConservativeSpectralBalance and RiemannHypothesis. -/
theorem conservative_spectral_balance_iff_RiemannHypothesis :
    ConservativeSpectralBalance ↔ RiemannHypothesis :=
  ⟨RiemannHypothesis_of_conservative, conservative_of_RiemannHypothesis⟩

/-- Equivalence between ConservativeSpectralBalance and CharacteristicSpectralReality. -/
theorem conservative_spectral_balance_iff_csr :
    ConservativeSpectralBalance ↔ CharacteristicSpectralReality := by
  rw [conservative_spectral_balance_iff_RiemannHypothesis, characteristic_spectral_reality_iff_RiemannHypothesis]

/-- Package structure for the Spectral Dissipation System. -/
structure ZetaSpectralDissipationSystem where
  /-- Vanishing of spectral dissipation on the critical line. -/
  critical_dissipation_zero : ∀ s : ℂ, s.re = 1 / 2 → ∀ x : ℝ, spectralDissipation s x = 0
  /-- Invariance under functional equation reflection. -/
  dissipation_reflection : ∀ s : ℂ, ∀ x : ℝ, spectralDissipation (1 - s) x = spectralDissipation s x
  /-- Antisymmetry under complex conjugation. -/
  dissipation_star : ∀ s : ℂ, ∀ x : ℝ, spectralDissipation (star s) x = - spectralDissipation s x
  /-- Positivity of dissipation in the right upper quadrant. -/
  right_upper_dissipation_pos : ∀ s : ℂ, 1 / 2 < s.re → 0 < s.im → ∀ x : ℝ,
    spectralParam s ≠ (x : ℂ) → 0 < spectralDissipation s x
  /-- Global conservative spectral balance. -/
  conservative_balance : ConservativeSpectralBalance

/-- Canonical constructor for ZetaSpectralDissipationSystem from RiemannHypothesis. -/
noncomputable def spectralDissipationSystem_of_RH (h_RH : RiemannHypothesis) :
    ZetaSpectralDissipationSystem where
  critical_dissipation_zero := fun _ hs x => spectralDissipation_critical_line hs x
  dissipation_reflection := spectralDissipation_reflection
  dissipation_star := spectralDissipation_star
  right_upper_dissipation_pos := fun _ hsigma ht x hwx =>
    spectralDissipation_pos_of_right_upper hsigma ht x hwx
  conservative_balance := conservative_of_RiemannHypothesis h_RH

/-- Canonical constructor from MasterGrandUnification. -/
noncomputable def spectralDissipationSystem_of_master (m : MasterGrandUnification) :
    ZetaSpectralDissipationSystem :=
  spectralDissipationSystem_of_RH m.rh

/-- Canonical constructor from ZetaCharacteristicDeterminantSystem. -/
noncomputable def spectralDissipationSystem_of_characteristic (sys : ZetaCharacteristicDeterminantSystem) :
    ZetaSpectralDissipationSystem :=
  spectralDissipationSystem_of_RH (RiemannHypothesis_of_characteristicSystem sys)

/-- Canonical constructor from AutonomousWeilTraceSystem. -/
noncomputable def spectralDissipationSystem_of_autonomous_weil (sys : AutonomousWeilTraceSystem) :
    ZetaSpectralDissipationSystem :=
  spectralDissipationSystem_of_master (masterGrandUnification_of_autonomous_weil sys)

/-- Canonical constructor from AutonomousOperatorTraceSystem. -/
noncomputable def spectralDissipationSystem_of_autonomous_operator {ι : Type*} [Fintype ι] [Nonempty ι]
    (sys : AutonomousOperatorTraceSystem ι) : ZetaSpectralDissipationSystem :=
  spectralDissipationSystem_of_master (masterGrandUnification_of_autonomous_operator sys)

/-- Canonical constructor from AutonomousFredholmDeterminantSystem. -/
noncomputable def spectralDissipationSystem_of_autonomous_fredholm {ι : Type*} [Fintype ι] [Nonempty ι]
    (sys : AutonomousFredholmDeterminantSystem ι) : ZetaSpectralDissipationSystem :=
  spectralDissipationSystem_of_master (masterGrandUnification_of_autonomous_fredholm sys)

/-- Canonical constructor from AutonomousCarlemanResolventSystem. -/
noncomputable def spectralDissipationSystem_of_autonomous_carleman {ι : Type*} [Fintype ι] [Nonempty ι]
    (sys : AutonomousCarlemanResolventSystem ι) : ZetaSpectralDissipationSystem :=
  spectralDissipationSystem_of_master (masterGrandUnification_of_autonomous_carleman sys)

/-- Canonical constructor from AutonomousLinearBridgeSystem. -/
noncomputable def spectralDissipationSystem_of_autonomous_linear_bridge (sys : AutonomousLinearBridgeSystem) :
    ZetaSpectralDissipationSystem :=
  spectralDissipationSystem_of_master (masterGrandUnification_of_autonomous_linear_bridge sys)

/-- Canonical constructor from AutonomousCanonicalEvaluationSystem. -/
noncomputable def spectralDissipationSystem_of_autonomous_canonical (sys : AutonomousCanonicalEvaluationSystem) :
    ZetaSpectralDissipationSystem :=
  spectralDissipationSystem_of_master (masterGrandUnification_of_autonomous_canonical sys)

/-- Deduction of RiemannHypothesis from ZetaSpectralDissipationSystem. -/
theorem RiemannHypothesis_of_spectralDissipationSystem (sys : ZetaSpectralDissipationSystem) :
    RiemannHypothesis :=
  RiemannHypothesis_of_conservative sys.conservative_balance

/-- Deduction of RightHalfZeroFree from ZetaSpectralDissipationSystem. -/
theorem rightHalfZeroFree_of_spectralDissipationSystem (sys : ZetaSpectralDissipationSystem) :
    RightHalfZeroFree :=
  rightHalfZeroFree_of_csr (characteristic_spectral_reality_of_conservative sys.conservative_balance)

/-- Equivalence between Nonempty ZetaSpectralDissipationSystem and RiemannHypothesis. -/
theorem spectralDissipationSystem_nonempty_iff_RiemannHypothesis :
    Nonempty ZetaSpectralDissipationSystem ↔ RiemannHypothesis := by
  constructor
  · rintro ⟨sys⟩
    exact RiemannHypothesis_of_spectralDissipationSystem sys
  · intro h_RH
    exact ⟨spectralDissipationSystem_of_RH h_RH⟩

/-- Equivalence between Nonempty ZetaSpectralDissipationSystem and Nonempty MasterGrandUnification. -/
theorem spectralDissipationSystem_nonempty_iff_master :
    Nonempty ZetaSpectralDissipationSystem ↔ Nonempty MasterGrandUnification := by
  rw [spectralDissipationSystem_nonempty_iff_RiemannHypothesis, master_grand_unification_iff_RiemannHypothesis]

/-- Equivalence between Nonempty ZetaSpectralDissipationSystem and Nonempty ZetaCharacteristicDeterminantSystem. -/
theorem spectralDissipationSystem_nonempty_iff_characteristic :
    Nonempty ZetaSpectralDissipationSystem ↔ Nonempty ZetaCharacteristicDeterminantSystem := by
  rw [spectralDissipationSystem_nonempty_iff_RiemannHypothesis, characteristicSystem_nonempty_iff_RiemannHypothesis]

#print axioms conservative_spectral_balance_iff_RiemannHypothesis
#print axioms RiemannHypothesis_of_spectralDissipationSystem
#print axioms spectralDissipation_at_resonance_coords
#print axioms spectralDissipation_le_resonant_peak

end BuildingBlocks.RiemannZetaSpectralDissipation
