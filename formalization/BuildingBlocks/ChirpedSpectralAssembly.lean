import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic
import BuildingBlocks.ChirpedCarrierDilutionDensityBalance
import BuildingBlocks.ChirpedDyadicTailSummability
import BuildingBlocks.ChirpedArchimedeanDigammaBound
import BuildingBlocks.ChirpedConstellationSpanAmplification
import BuildingBlocks.ChirpedWeilSpectralDecomposition

open Filter
open scoped Topology

namespace BuildingBlocks.ChirpedSpectralAssembly

open BuildingBlocks.ChirpedCarrierDilutionDensityBalance
open BuildingBlocks.ChirpedDyadicTailSummability
open BuildingBlocks.ChirpedArchimedeanDigammaBound
open BuildingBlocks.ChirpedConstellationSpanAmplification
open BuildingBlocks.ChirpedWeilSpectralDecomposition

/-- The total assembled critical-line coefficient:
C_crit,assembled := criticalResonantCoeff C_N C_core w + dyadicTailCoeff C_dens Δ0. -/
noncomputable def assembledCriticalCoeff
    (C_N C_core w C_dens Δ0 : ℝ) : ℝ :=
  criticalResonantCoeff C_N C_core w + dyadicTailCoeff C_dens Δ0

/-- The assembled critical coefficient is strictly positive. -/
theorem assembledCriticalCoeff_pos
    {C_N C_core w C_dens Δ0 : ℝ}
    (hCN : 0 < C_N) (hcore : 0 < C_core) (hw : 0 < w)
    (hCdens : 0 < C_dens) (hΔ : 0 < Δ0) :
    0 < assembledCriticalCoeff C_N C_core w C_dens Δ0 := by
  unfold assembledCriticalCoeff
  have hres := criticalResonantCoeff_pos hCN hcore hw
  have htail := dyadicTailCoeff_pos hCdens hΔ
  positivity

/-- The total critical bound is the sum of the resonant and non-resonant tail bounds:
Q_crit ≤ (criticalResonantCoeff + dyadicTailCoeff) * log T. -/
theorem assembled_critical_bound_le
    {Q_crit : ℝ → ℝ} {C_N C_core w C_dens Δ0 T : ℝ}
    (hres : ∀ T, 1 ≤ T → ∃ Q_res, ∃ Q_tail,
      Q_crit T ≤ Q_res + Q_tail ∧
      Q_res ≤ (criticalResonantCoeff C_N C_core w) * Real.log T ∧
      Q_tail ≤ (dyadicTailCoeff C_dens Δ0) * Real.log T)
    (hT : 1 ≤ T) :
    Q_crit T ≤ (assembledCriticalCoeff C_N C_core w C_dens Δ0) * Real.log T := by
  obtain ⟨Q_res, Q_tail, hsum, hres_bnd, htail_bnd⟩ := hres T hT
  unfold assembledCriticalCoeff
  rw [add_mul]
  linarith

/-- The effective continuous bound scale M_cont := C_cont / 6. -/
noncomputable def assembledContinuousScale (eta w C_Gamma : ℝ) : ℝ :=
  (chirpedArchimedeanCoeff eta w C_Gamma) / 6

/-- The assembled continuous scale is strictly positive. -/
theorem assembledContinuousScale_pos
    {eta w C_Gamma : ℝ}
    (heta : 0 ≤ eta) (hw : 0 < w) (hGamma : 0 ≤ C_Gamma) :
    0 < assembledContinuousScale eta w C_Gamma := by
  unfold assembledContinuousScale
  have hcoeff := chirpedArchimedeanCoeff_pos heta (le_of_lt hw) hGamma
  positivity

/-- The continuous Archimedean bound expressed in the canonical 6 * M form:
Q_cont ≤ 6 * M_cont. -/
theorem assembled_continuous_bound_le
    {Q_cont : ℝ → ℝ} {eta w C_Gamma T : ℝ}
    (hcont : Q_cont T ≤ chirpedArchimedeanCoeff eta w C_Gamma) :
    Q_cont T ≤ 6 * (assembledContinuousScale eta w C_Gamma) := by
  unfold assembledContinuousScale
  linarith

/-- The master spectral upper bound assembling critical, continuous, and off-line pair components:
Q_spec ≤ C_crit,assembled * log T + 6 * M_cont - 2 * b * T^(2d). -/
theorem assembled_spectral_upper_bound
    {Q_spec Q_crit Q_cont E_pair : ℝ → ℝ}
    {C_N C_core w C_dens Δ0 eta C_Gamma a_min d T : ℝ}
    (hdec : Q_spec T ≤ Q_crit T + Q_cont T - E_pair T)
    (hcrit : Q_crit T ≤ (assembledCriticalCoeff C_N C_core w C_dens Δ0) * Real.log T)
    (hcont : Q_cont T ≤ 6 * (assembledContinuousScale eta w C_Gamma))
    (hpair : 2 * (amplifiedOfflineCoeff a_min eta) * T^(2 * d) ≤ E_pair T) :
    Q_spec T ≤ (assembledCriticalCoeff C_N C_core w C_dens Δ0) * Real.log T +
               6 * (assembledContinuousScale eta w C_Gamma) -
               2 * (amplifiedOfflineCoeff a_min eta) * T^(2 * d) := by
  linarith

/-- Constructive certificate bundling the assembled spectral parameters. -/
structure ChirpedSpectralAssemblyCertificate
    (C_N C_core w C_dens Δ0 eta C_Gamma a_min : ℝ) : Prop where
  CN_pos : 0 < C_N
  core_pos : 0 < C_core
  w_pos : 0 < w
  dens_pos : 0 < C_dens
  Δ0_pos : 0 < Δ0
  eta_pos : 0 < eta
  Gamma_nonneg : 0 ≤ C_Gamma
  a_pos : 0 < a_min
  crit_pos : 0 < assembledCriticalCoeff C_N C_core w C_dens Δ0
  cont_pos : 0 < assembledContinuousScale eta w C_Gamma
  offline_pos : 0 < amplifiedOfflineCoeff a_min eta

/-- Constructor for `ChirpedSpectralAssemblyCertificate`. -/
theorem makeSpectralAssemblyCertificate
    {C_N C_core w C_dens Δ0 eta C_Gamma a_min : ℝ}
    (hCN : 0 < C_N) (hcore : 0 < C_core) (hw : 0 < w)
    (hCdens : 0 < C_dens) (hΔ : 0 < Δ0)
    (heta : 0 < eta) (hGamma : 0 ≤ C_Gamma) (ha : 0 < a_min) :
    ChirpedSpectralAssemblyCertificate C_N C_core w C_dens Δ0 eta C_Gamma a_min :=
  ⟨hCN, hcore, hw, hCdens, hΔ, heta, hGamma, ha,
   assembledCriticalCoeff_pos hCN hcore hw hCdens hΔ,
   assembledContinuousScale_pos (le_of_lt heta) hw hGamma,
   amplifiedOfflineCoeff_pos ha heta⟩

end BuildingBlocks.ChirpedSpectralAssembly

#print axioms BuildingBlocks.ChirpedSpectralAssembly.assembledCriticalCoeff_pos
#print axioms BuildingBlocks.ChirpedSpectralAssembly.assembled_critical_bound_le
#print axioms BuildingBlocks.ChirpedSpectralAssembly.assembledContinuousScale_pos
#print axioms BuildingBlocks.ChirpedSpectralAssembly.assembled_continuous_bound_le
#print axioms BuildingBlocks.ChirpedSpectralAssembly.assembled_spectral_upper_bound
#print axioms BuildingBlocks.ChirpedSpectralAssembly.makeSpectralAssemblyCertificate
