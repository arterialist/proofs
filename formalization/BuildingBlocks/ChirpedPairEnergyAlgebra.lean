import Mathlib.Analysis.Complex.Norm
import Mathlib.Tactic
import BuildingBlocks.ActualWeilZeroPairAlgebra
import BuildingBlocks.ChirpedMasterSpectralVanishingBridge
import BuildingBlocks.ChirpedZeroPartitionSynthesis
import BuildingBlocks.ChirpedCanonicalWavepacketAdmissibility
import BuildingBlocks.ChirpedLinearCarrierAssembly

namespace BuildingBlocks.ChirpedPairEnergyAlgebra

open BuildingBlocks.ActualWeilZeroPairAlgebra
open BuildingBlocks.ChirpedMasterSpectralVanishingBridge
open BuildingBlocks.ChirpedZeroPartitionSynthesis
open BuildingBlocks.ChirpedCanonicalWavepacketAdmissibility
open BuildingBlocks.ChirpedLinearCarrierAssembly

/-!
# Scalar Pair-Energy Algebra

This module bounds a complex scalar expression `chirpedPairEnergy` and builds conditional records
from user-supplied real functions and inequalities.  `PairedZeroData` does not contain a proof that
its weights or balance law arise analytically from the zeta zero named by a separate certificate.
The zero-free and RH results require witness functions supplying all of this data.
-/

/-- A complex scalar expression in the supplied weight, phase, and carrier. -/
noncomputable def chirpedPairEnergy (W u : ℂ) (T : ℝ) : ℝ :=
  2 * (W * (2 - u * ((T^2 : ℝ) : ℂ) - star u / ((T^2 : ℝ) : ℂ))).re / T

/-- Bound on chirpedPairEnergy in terms of carrier T for any T > 0. -/
theorem chirpedPairEnergy_upper (W u : ℂ) (b : ℝ) {T : ℝ}
    (hT : 0 < T) (hu : ‖u‖ = 1) (hmain : b ≤ (W * u).re) :
    chirpedPairEnergy W u T ≤ 4 * ‖W‖ / T + 2 * ‖W‖ / T^3 - 2 * b * T := by
  have hTsq : 0 < T^2 := sq_pos_of_pos hT
  have hbase := central_pair_upper_norm W u (T^2) b hTsq hu hmain
  dsimp [chirpedPairEnergy]
  have hdiv : (2 * (W * (2 - u * ((T^2 : ℝ) : ℂ) - star u / ((T^2 : ℝ) : ℂ))).re) / T ≤
      (4 * ‖W‖ + 2 * ‖W‖ / (T^2) - 2 * b * (T^2)) / T :=
    div_le_div_of_nonneg_right hbase (le_of_lt hT)
  have heq : (4 * ‖W‖ + 2 * ‖W‖ / (T^2) - 2 * b * (T^2)) / T =
      4 * ‖W‖ / T + 2 * ‖W‖ / T^3 - 2 * b * T := by
    have hTne : T ≠ 0 := ne_of_gt hT
    calc
      (4 * ‖W‖ + 2 * ‖W‖ / (T^2) - 2 * b * (T^2)) / T =
          (4 * ‖W‖) / T + (2 * ‖W‖ / (T^2)) / T - (2 * b * (T^2)) / T := by ring
      _ = 4 * ‖W‖ / T + 2 * ‖W‖ / (T^2 * T) - 2 * b * (T^2 / T) := by
        rw [div_div]
        ring
      _ = 4 * ‖W‖ / T + 2 * ‖W‖ / T^3 - 2 * b * T := by
        have h3 : T^2 * T = T^3 := by ring
        have h1 : T^2 / T = T := by
          rw [sq, mul_div_cancel_right₀ T hTne]
        rw [h3, h1]
  rwa [heq] at hdiv

/-- For all T ≥ 1, 4 * ‖W‖ / T + 2 * ‖W‖ / T^3 ≤ 6 * ‖W‖. -/
theorem carrier_decay_le_six_norm (W : ℂ) {T : ℝ} (hT : 1 ≤ T) :
    4 * ‖W‖ / T + 2 * ‖W‖ / T^3 ≤ 6 * ‖W‖ := by
  have hW : 0 ≤ ‖W‖ := norm_nonneg W
  have hT_pos : 0 < T := by linarith
  have hT_inv : 1 / T ≤ 1 := by
    rw [div_le_iff₀ hT_pos]
    linarith
  have hT3_pos : 0 < T^3 := by positivity
  have hT3 : 1 ≤ T^3 := by
    calc
      1 = (1 : ℝ)^3 := by norm_num
      _ ≤ T^3 := by gcongr
  have hT3_inv : 1 / T^3 ≤ 1 := by
    rw [div_le_iff₀ hT3_pos]
    simpa using hT3
  have h4 : 4 * ‖W‖ / T ≤ 4 * ‖W‖ := by
    calc
      4 * ‖W‖ / T = (4 * ‖W‖) * (1 / T) := by ring
      _ ≤ (4 * ‖W‖) * 1 := mul_le_mul_of_nonneg_left hT_inv (by positivity)
      _ = 4 * ‖W‖ := mul_one _
  have h2 : 2 * ‖W‖ / T^3 ≤ 2 * ‖W‖ := by
    calc
      2 * ‖W‖ / T^3 = (2 * ‖W‖) * (1 / T^3) := by ring
      _ ≤ (2 * ‖W‖) * 1 := mul_le_mul_of_nonneg_left hT3_inv (by positivity)
      _ = 2 * ‖W‖ := mul_one _
  linarith

/-- Uniform carrier upper bound: for all T ≥ 1,
chirpedPairEnergy W u T ≤ 6 * ‖W‖ - 2 * b * T. -/
theorem chirpedPairEnergy_le_six_norm (W u : ℂ) (b : ℝ) {T : ℝ}
    (hT : 1 ≤ T) (hu : ‖u‖ = 1) (hmain : b ≤ (W * u).re) :
    chirpedPairEnergy W u T ≤ 6 * ‖W‖ - 2 * b * T := by
  have hT_pos : 0 < T := by linarith
  have h_up := chirpedPairEnergy_upper W u b hT_pos hu hmain
  have h_six := carrier_decay_le_six_norm W hT
  linarith

/-- Off-line pair energy definition. -/
noncomputable def offlinePairExtractedEnergy (W u : ℂ) (T : ℝ) : ℝ :=
  - chirpedPairEnergy W u T

/-- Off-line pair extracted energy lower bound: for all T ≥ 1,
2 * b * T - 6 * ‖W‖ ≤ offlinePairExtractedEnergy W u T. -/
theorem offlinePairExtractedEnergy_lower (W u : ℂ) (b : ℝ) {T : ℝ}
    (hT : 1 ≤ T) (hu : ‖u‖ = 1) (hmain : b ≤ (W * u).re) :
    2 * b * T - 6 * ‖W‖ ≤ offlinePairExtractedEnergy W u T := by
  dsimp [offlinePairExtractedEnergy]
  have h := chirpedPairEnergy_le_six_norm W u b hT hu hmain
  linarith

/-- The absorbed pair energy including the bounded 6*‖W‖ offset. -/
noncomputable def absorbedPairEnergy (W u : ℂ) (T : ℝ) : ℝ :=
  offlinePairExtractedEnergy W u T + 6 * ‖W‖

/-- The absorbed pair energy satisfies the linear lower bound 2 * b * T ≤ absorbedPairEnergy. -/
theorem absorbedPairEnergy_lower (W u : ℂ) (b : ℝ) {T : ℝ}
    (hT : 1 ≤ T) (hu : ‖u‖ = 1) (hmain : b ≤ (W * u).re) :
    2 * b * T ≤ absorbedPairEnergy W u T := by
  dsimp [absorbedPairEnergy]
  have h := offlinePairExtractedEnergy_lower W u b hT hu hmain
  linarith

/-- Construct modular components from supplied scalar functions, bounds, weight, and phase. -/
noncomputable def makePairedModularComponents
    (cfg : ChirpedWavepacketConfiguration)
    (W u : ℂ) (hu : ‖u‖ = 1)
    (hmain : canonicalCarrierCoupling cfg ≤ (W * u).re)
    (Q_crit Q_tail Q_diag Q_cross : ℝ → ℝ)
    (h_crit : ∀ T ≥ 1, Q_crit T ≤ cfg.C_crit * Real.log T)
    (h_tail : ∀ T ≥ 1, Q_tail T ≤ totalNonresonantTailEnvelope cfg.C_tail_tot T)
    (h_diag : ∀ T ≥ 1, canonicalNetMargin * Real.log T ≤ Q_diag T)
    (h_cross : ∀ T ≥ 1, Q_cross T ≤ cfg.C_tot)
    (h_weil : ∀ T : ℝ, Q_diag T - Q_cross T =
      Q_crit T + Q_tail T - offlinePairExtractedEnergy W u T) :
    ChirpedModularComponents where
  cfg := {
    a_min := cfg.a_min
    C_geom := cfg.C_geom
    C_crit := cfg.C_crit
    C_tail_tot := cfg.C_tail_tot
    C_tot := cfg.C_tot + 6 * ‖W‖
    ha_min := cfg.ha_min
    hC_geom := cfg.hC_geom
    hC_crit := cfg.hC_crit
    hC_tail := cfg.hC_tail
    hC_tot := by
      have hW : 0 ≤ ‖W‖ := norm_nonneg W
      have hC := cfg.hC_tot
      linarith
  }
  Q_crit := Q_crit
  Q_tail := Q_tail
  E_pair := absorbedPairEnergy W u
  Q_diag := Q_diag
  Q_cross := fun T => Q_cross T + 6 * ‖W‖
  h_crit := h_crit
  h_tail := h_tail
  h_pair := fun T hT => absorbedPairEnergy_lower W u (canonicalCarrierCoupling cfg) hT hu hmain
  h_diag := h_diag
  h_cross := fun T hT => by
    dsimp
    have hx := h_cross T hT
    linarith
  h_weil := fun T => by
    dsimp [absorbedPairEnergy]
    have hw := h_weil T
    linarith

/-- The supplied modular bounds and balance identity are inconsistent. -/
theorem paired_zero_refutation
    (cfg : ChirpedWavepacketConfiguration)
    (W u : ℂ) (hu : ‖u‖ = 1)
    (hmain : canonicalCarrierCoupling cfg ≤ (W * u).re)
    (Q_crit Q_tail Q_diag Q_cross : ℝ → ℝ)
    (h_crit : ∀ T ≥ 1, Q_crit T ≤ cfg.C_crit * Real.log T)
    (h_tail : ∀ T ≥ 1, Q_tail T ≤ totalNonresonantTailEnvelope cfg.C_tail_tot T)
    (h_diag : ∀ T ≥ 1, canonicalNetMargin * Real.log T ≤ Q_diag T)
    (h_cross : ∀ T ≥ 1, Q_cross T ≤ cfg.C_tot)
    (h_weil : ∀ T : ℝ, Q_diag T - Q_cross T =
      Q_crit T + Q_tail T - offlinePairExtractedEnergy W u T) :
    False := by
  have comp := makePairedModularComponents cfg W u hu hmain Q_crit Q_tail Q_diag Q_cross
    h_crit h_tail h_diag h_cross h_weil
  exact modular_components_refutation comp

/-- Bundle of scalar functions and bounds used by the conditional witness theorems. -/
structure PairedZeroData where
  cfg : ChirpedWavepacketConfiguration
  W : ℂ
  u : ℂ
  hu : ‖u‖ = 1
  hmain : canonicalCarrierCoupling cfg ≤ (W * u).re
  Q_crit : ℝ → ℝ
  Q_tail : ℝ → ℝ
  Q_diag : ℝ → ℝ
  Q_cross : ℝ → ℝ
  h_crit : ∀ T ≥ 1, Q_crit T ≤ cfg.C_crit * Real.log T
  h_tail : ∀ T ≥ 1, Q_tail T ≤ totalNonresonantTailEnvelope cfg.C_tail_tot T
  h_diag : ∀ T ≥ 1, canonicalNetMargin * Real.log T ≤ Q_diag T
  h_cross : ∀ T ≥ 1, Q_cross T ≤ cfg.C_tot
  h_weil : ∀ T : ℝ, Q_diag T - Q_cross T =
    Q_crit T + Q_tail T - offlinePairExtractedEnergy W u T

/-- Convert paired zero data into modular components. -/
noncomputable def PairedZeroData.toModularComponents (data : PairedZeroData) :
    ChirpedModularComponents :=
  makePairedModularComponents data.cfg data.W data.u data.hu data.hmain
    data.Q_crit data.Q_tail data.Q_diag data.Q_cross
    data.h_crit data.h_tail data.h_diag data.h_cross data.h_weil

/-- Certificate combining candidate-zero facts with inconsistent scalar data. -/
structure PairedZeroCertificate (s : ℂ) where
  hz : riemannZeta s = 0
  hs : s ≠ 1
  hsr : 1 / 2 < s.re
  data : PairedZeroData

/-- Any `PairedZeroCertificate` refutes the existence of the zero `s`. -/
theorem refute_zero_of_paired_certificate {s : ℂ}
    (cert : PairedZeroCertificate s) : False :=
  modular_components_refutation cert.data.toModularComponents

/-- Conditional high-frequency zero freeness from paired-data witnesses. -/
theorem highFrequencyZeroFree_of_paired_witness
    (H : ℝ)
    (witness : ∀ s : ℂ, riemannZeta s = 0 → s ≠ 1 → H < |s.im| → 1 / 2 < s.re →
      PairedZeroData) :
    HighFrequencyZeroFree H :=
  highFrequencyZeroFree_of_modular_witness H (fun s hz hs hH hsr =>
    (witness s hz hs hH hsr).toModularComponents)

/-- Conditional deduction of `RiemannHypothesis` from low-height and paired-data witnesses. -/
theorem RiemannHypothesis_of_paired_witness
    (h_pt : LowFrequencyZeroFree plattTrudgianHeight)
    (witness : ∀ s : ℂ, riemannZeta s = 0 → s ≠ 1 → plattTrudgianHeight < |s.im| → 1 / 2 < s.re →
      PairedZeroData) :
    RiemannHypothesis :=
  RiemannHypothesis_of_modular_witness h_pt (fun s hz hs hH hsr =>
    (witness s hz hs hH hsr).toModularComponents)

end BuildingBlocks.ChirpedPairEnergyAlgebra

#print axioms BuildingBlocks.ChirpedPairEnergyAlgebra.chirpedPairEnergy_upper
#print axioms BuildingBlocks.ChirpedPairEnergyAlgebra.carrier_decay_le_six_norm
#print axioms BuildingBlocks.ChirpedPairEnergyAlgebra.chirpedPairEnergy_le_six_norm
#print axioms BuildingBlocks.ChirpedPairEnergyAlgebra.offlinePairExtractedEnergy_lower
#print axioms BuildingBlocks.ChirpedPairEnergyAlgebra.absorbedPairEnergy_lower
#print axioms BuildingBlocks.ChirpedPairEnergyAlgebra.paired_zero_refutation
#print axioms BuildingBlocks.ChirpedPairEnergyAlgebra.refute_zero_of_paired_certificate
#print axioms BuildingBlocks.ChirpedPairEnergyAlgebra.highFrequencyZeroFree_of_paired_witness
#print axioms BuildingBlocks.ChirpedPairEnergyAlgebra.RiemannHypothesis_of_paired_witness
