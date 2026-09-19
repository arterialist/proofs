import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds
import Mathlib.Analysis.Complex.Norm
import Mathlib.Tactic
import BuildingBlocks.ChirpedStationaryPhaseCarrier
import BuildingBlocks.ChirpedFresnelGaussianLocalization
import BuildingBlocks.ChirpedFresnelPhaseCoherence
import BuildingBlocks.ChirpedMasterSpectralVanishingBridge
import BuildingBlocks.ChirpedZeroPartitionSynthesis
import BuildingBlocks.ChirpedCanonicalWavepacketAdmissibility
import BuildingBlocks.ChirpedLinearCarrierAssembly
import BuildingBlocks.ChirpedPairEnergyAlgebra

/-!
# Algebraic Stationary-Core Weight Model

This module defines scalar formulas for a core radius, amplitude, and weight and proves identities
between them.  It does not define or estimate a stationary-phase integral.  The constructors for
`PairedZeroData` require the spectral, tail, diagonal, cross, and balance bounds as arguments.
Accordingly, the zero-free and RH theorems remain conditional on a witness supplying those data.
-/

namespace BuildingBlocks.ChirpedStationaryCoreProjection

open BuildingBlocks.ChirpedStationaryPhaseCarrier
open BuildingBlocks.ChirpedFresnelGaussianLocalization
open BuildingBlocks.ChirpedFresnelPhaseCoherence
open BuildingBlocks.ChirpedMasterSpectralVanishingBridge
open BuildingBlocks.ChirpedZeroPartitionSynthesis
open BuildingBlocks.ChirpedCanonicalWavepacketAdmissibility
open BuildingBlocks.ChirpedLinearCarrierAssembly
open BuildingBlocks.ChirpedPairEnergyAlgebra

/-! ### 1. Fresnel Core Geometric Dimensions -/

/-- Canonical Fresnel radius δ = 2 / √T for chirp parameter η = 1/4. -/
noncomputable def canonicalFresnelRadius (T : ℝ) : ℝ := 2 / Real.sqrt T

/-- Canonical Fresnel core length L = 2δ = 4 / √T. -/
noncomputable def canonicalCoreLength (T : ℝ) : ℝ := 4 / Real.sqrt T

/-- Defined scalar core amplitude `L * (a_min / 2) = 2 * a_min / sqrt T`. -/
noncomputable def coherentCoreAmplitude (a_min T : ℝ) : ℝ := 2 * a_min / Real.sqrt T

/-- Defined scalar weight `4 * a_min^2 / T`. -/
noncomputable def coherentSpectralWeight (a_min T : ℝ) : ℝ := 4 * a_min^2 / T

/-- Carrier-normalized coherent weight W_norm = W_core * T = 4 * a_min^2. -/
noncomputable def normalizedCoherentWeight (a_min : ℝ) : ℝ := 4 * a_min^2

/-- Relation between core length and canonical Fresnel radius. -/
theorem canonicalCoreLength_eq_two_mul (T : ℝ) :
    canonicalCoreLength T = 2 * canonicalFresnelRadius T := by
  dsimp [canonicalCoreLength, canonicalFresnelRadius]
  ring

/-- Coherent core amplitude identity: core length multiplied by half envelope equals coherent core amplitude. -/
theorem coherentCoreAmplitude_eq (a_min T : ℝ) :
    canonicalCoreLength T * (a_min / 2) = coherentCoreAmplitude a_min T := by
  dsimp [canonicalCoreLength, coherentCoreAmplitude]
  ring

/-- Coherent spectral weight identity: the square of coherent core amplitude equals coherent spectral weight. -/
theorem coherentSpectralWeight_eq (a_min : ℝ) {T : ℝ} (hT : 0 < T) :
    (coherentCoreAmplitude a_min T)^2 = coherentSpectralWeight a_min T := by
  dsimp [coherentCoreAmplitude, coherentSpectralWeight]
  have hsqrt : (Real.sqrt T)^2 = T := Real.sq_sqrt (le_of_lt hT)
  calc
    (2 * a_min / Real.sqrt T)^2 = (2 * a_min)^2 / (Real.sqrt T)^2 := by
      rw [div_pow]
    _ = 4 * a_min^2 / T := by
      rw [hsqrt]
      ring

/-- Carrier normalization identity: coherent spectral weight multiplied by T equals normalized coherent weight. -/
theorem normalizedCoherentWeight_eq (a_min : ℝ) {T : ℝ} (hT : T ≠ 0) :
    (coherentSpectralWeight a_min T) * T = normalizedCoherentWeight a_min := by
  dsimp [coherentSpectralWeight, normalizedCoherentWeight]
  rw [div_mul_cancel₀ _ hT]

/-- Strict positivity of normalized coherent weight. -/
theorem normalizedCoherentWeight_pos {a_min : ℝ} (ha : 0 < a_min) :
    0 < normalizedCoherentWeight a_min := by
  dsimp [normalizedCoherentWeight]
  have hsq : 0 < a_min^2 := sq_pos_of_pos ha
  linarith

/-- The normalized coherent weight 4 * a_min^2 strictly exceeds the canonical carrier coupling 2 * a_min^2. -/
theorem normalizedCoherentWeight_gt_coupling (cfg : ChirpedWavepacketConfiguration) :
    canonicalCarrierCoupling cfg < normalizedCoherentWeight cfg.a_min := by
  dsimp [canonicalCarrierCoupling, normalizedCoherentWeight]
  have ha : 0 < cfg.a_min := cfg.ha_min
  have hsq : 0 < cfg.a_min^2 := sq_pos_of_pos ha
  linarith

/-- Weak inequality: canonical carrier coupling is bounded by normalized coherent weight. -/
theorem canonicalCarrierCoupling_le_normalized (cfg : ChirpedWavepacketConfiguration) :
    canonicalCarrierCoupling cfg ≤ normalizedCoherentWeight cfg.a_min :=
  le_of_lt (normalizedCoherentWeight_gt_coupling cfg)

/-! ### 2. Complex Weight Construction and Real Part Projection -/

/-- Construction of the canonical coherent weight as a complex number. -/
noncomputable def canonicalComplexWeight (cfg : ChirpedWavepacketConfiguration) : ℂ :=
  ((normalizedCoherentWeight cfg.a_min : ℝ) : ℂ)

/-- The canonical complex weight has norm equal to normalizedCoherentWeight. -/
theorem canonicalComplexWeight_norm (cfg : ChirpedWavepacketConfiguration) :
    ‖canonicalComplexWeight cfg‖ = normalizedCoherentWeight cfg.a_min := by
  dsimp [canonicalComplexWeight]
  have hpos := normalizedCoherentWeight_pos cfg.ha_min
  rw [Complex.norm_real, Real.norm_eq_abs, abs_of_pos hpos]

/-- Under the unit phase u = 1, (W * u).re equals normalizedCoherentWeight cfg.a_min. -/
theorem canonicalComplexWeight_re_mul_one (cfg : ChirpedWavepacketConfiguration) :
    (canonicalComplexWeight cfg * 1).re = normalizedCoherentWeight cfg.a_min := by
  dsimp [canonicalComplexWeight]
  simp

/-- Main projection lower bound: canonical carrier coupling is bounded by (W * 1).re. -/
theorem canonicalComplexWeight_main_bound (cfg : ChirpedWavepacketConfiguration) :
    canonicalCarrierCoupling cfg ≤ (canonicalComplexWeight cfg * 1).re := by
  rw [canonicalComplexWeight_re_mul_one]
  exact canonicalCarrierCoupling_le_normalized cfg

/-- The unit phase 1 has norm 1. -/
theorem norm_one_eq_one : ‖(1 : ℂ)‖ = 1 := by simp

/-! ### 3. Canonical Paired Zero Data and Refutation -/

/-- Construct `PairedZeroData` from supplied functions and bounds, using `W` and `u = 1`. -/
noncomputable def makeCanonicalPairedZeroData
    (cfg : ChirpedWavepacketConfiguration)
    (Q_crit Q_tail Q_diag Q_cross : ℝ → ℝ)
    (h_crit : ∀ T ≥ 1, Q_crit T ≤ cfg.C_crit * Real.log T)
    (h_tail : ∀ T ≥ 1, Q_tail T ≤ totalNonresonantTailEnvelope cfg.C_tail_tot T)
    (h_diag : ∀ T ≥ 1, canonicalNetMargin * Real.log T ≤ Q_diag T)
    (h_cross : ∀ T ≥ 1, Q_cross T ≤ cfg.C_tot)
    (h_weil : ∀ T : ℝ, Q_diag T - Q_cross T =
      Q_crit T + Q_tail T - offlinePairExtractedEnergy (canonicalComplexWeight cfg) 1 T) :
    PairedZeroData where
  cfg := cfg
  W := canonicalComplexWeight cfg
  u := 1
  hu := norm_one_eq_one
  hmain := canonicalComplexWeight_main_bound cfg
  Q_crit := Q_crit
  Q_tail := Q_tail
  Q_diag := Q_diag
  Q_cross := Q_cross
  h_crit := h_crit
  h_tail := h_tail
  h_diag := h_diag
  h_cross := h_cross
  h_weil := h_weil

/-- Contradiction from the supplied scalar bounds and balance identity. -/
theorem refute_canonical_paired_zero
    (cfg : ChirpedWavepacketConfiguration)
    (Q_crit Q_tail Q_diag Q_cross : ℝ → ℝ)
    (h_crit : ∀ T ≥ 1, Q_crit T ≤ cfg.C_crit * Real.log T)
    (h_tail : ∀ T ≥ 1, Q_tail T ≤ totalNonresonantTailEnvelope cfg.C_tail_tot T)
    (h_diag : ∀ T ≥ 1, canonicalNetMargin * Real.log T ≤ Q_diag T)
    (h_cross : ∀ T ≥ 1, Q_cross T ≤ cfg.C_tot)
    (h_weil : ∀ T : ℝ, Q_diag T - Q_cross T =
      Q_crit T + Q_tail T - offlinePairExtractedEnergy (canonicalComplexWeight cfg) 1 T) :
    False := by
  have comp := (makeCanonicalPairedZeroData cfg Q_crit Q_tail Q_diag Q_cross
    h_crit h_tail h_diag h_cross h_weil).toModularComponents
  exact modular_components_refutation comp

/-- Certificate builder requiring candidate-zero facts and every scalar bound. -/
noncomputable def makeCanonicalPairedCertificate
    {s : ℂ} (hz : riemannZeta s = 0) (hs : s ≠ 1) (hsr : 1 / 2 < s.re)
    (cfg : ChirpedWavepacketConfiguration)
    (Q_crit Q_tail Q_diag Q_cross : ℝ → ℝ)
    (h_crit : ∀ T ≥ 1, Q_crit T ≤ cfg.C_crit * Real.log T)
    (h_tail : ∀ T ≥ 1, Q_tail T ≤ totalNonresonantTailEnvelope cfg.C_tail_tot T)
    (h_diag : ∀ T ≥ 1, canonicalNetMargin * Real.log T ≤ Q_diag T)
    (h_cross : ∀ T ≥ 1, Q_cross T ≤ cfg.C_tot)
    (h_weil : ∀ T : ℝ, Q_diag T - Q_cross T =
      Q_crit T + Q_tail T - offlinePairExtractedEnergy (canonicalComplexWeight cfg) 1 T) :
    PairedZeroCertificate s where
  hz := hz
  hs := hs
  hsr := hsr
  data := makeCanonicalPairedZeroData cfg Q_crit Q_tail Q_diag Q_cross
    h_crit h_tail h_diag h_cross h_weil

/-- Conditional high-frequency zero freeness from a paired-data witness. -/
theorem highFrequencyZeroFree_of_canonical_projector_witness
    (H : ℝ)
    (witness : ∀ s : ℂ, riemannZeta s = 0 → s ≠ 1 → H < |s.im| → 1 / 2 < s.re →
      PairedZeroData) :
    HighFrequencyZeroFree H :=
  highFrequencyZeroFree_of_paired_witness H witness

/-- Conditional deduction of `RiemannHypothesis` from low-height and paired-data witnesses. -/
theorem RiemannHypothesis_of_canonical_projector_witness
    (h_pt : LowFrequencyZeroFree plattTrudgianHeight)
    (witness : ∀ s : ℂ, riemannZeta s = 0 → s ≠ 1 → plattTrudgianHeight < |s.im| → 1 / 2 < s.re →
      PairedZeroData) :
    RiemannHypothesis :=
  RiemannHypothesis_of_paired_witness h_pt witness

#print axioms canonicalCoreLength_eq_two_mul
#print axioms coherentCoreAmplitude_eq
#print axioms coherentSpectralWeight_eq
#print axioms normalizedCoherentWeight_eq
#print axioms normalizedCoherentWeight_pos
#print axioms normalizedCoherentWeight_gt_coupling
#print axioms canonicalCarrierCoupling_le_normalized
#print axioms canonicalComplexWeight_norm
#print axioms canonicalComplexWeight_re_mul_one
#print axioms canonicalComplexWeight_main_bound
#print axioms norm_one_eq_one
#print axioms refute_canonical_paired_zero
#print axioms highFrequencyZeroFree_of_canonical_projector_witness
#print axioms RiemannHypothesis_of_canonical_projector_witness

end BuildingBlocks.ChirpedStationaryCoreProjection
