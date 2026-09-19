import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic

open Filter
open scoped Topology

namespace BuildingBlocks.ChirpedCarrierDilutionDensityBalance

/-- The bandwidth of the resonant spectral window [T(1 - 2ηw), T]. -/
def resonantBandwidth (T eta w : ℝ) : ℝ :=
  2 * eta * w * T

/-- Resonant bandwidth is positive for positive carrier, chirp rate, and window width. -/
theorem resonantBandwidth_pos {T eta w : ℝ}
    (hT : 0 < T) (heta : 0 < eta) (hw : 0 < w) :
    0 < resonantBandwidth T eta w := by
  unfold resonantBandwidth
  positivity

/-- Algebraic identity: carrier minus lower edge equals the resonant bandwidth. -/
theorem resonantBandwidth_eq (T eta w : ℝ) :
    T - T * (1 - 2 * eta * w) = resonantBandwidth T eta w := by
  unfold resonantBandwidth
  ring

/-- The unamplified critical-line single zero energy bound: C_core / (η * T). -/
noncomputable def criticalSingleEnergyBound (C_core eta T : ℝ) : ℝ :=
  C_core / (eta * T)

/-- The critical-line single zero bound is positive for positive constants. -/
theorem criticalSingleEnergyBound_pos {C_core eta T : ℝ}
    (hC : 0 < C_core) (heta : 0 < eta) (hT : 0 < T) :
    0 < criticalSingleEnergyBound C_core eta T := by
  unfold criticalSingleEnergyBound
  positivity

/-- The resonant zero-count upper bound: C_N * bandwidth * log T. -/
noncomputable def resonantZeroCountBound (C_N T eta w : ℝ) : ℝ :=
  C_N * (resonantBandwidth T eta w) * Real.log T

/-- Total logarithmic coefficient for critical-line resonant zeros: 2 * C_N * C_core * w. -/
def criticalResonantCoeff (C_N C_core w : ℝ) : ℝ :=
  2 * C_N * C_core * w

/-- The critical resonant coefficient is strictly positive. -/
theorem criticalResonantCoeff_pos {C_N C_core w : ℝ}
    (hN : 0 < C_N) (hC : 0 < C_core) (hw : 0 < w) :
    0 < criticalResonantCoeff C_N C_core w := by
  unfold criticalResonantCoeff
  positivity

/-- The Carrier Dilution-Density Balance Theorem:
The product of the resonant zero count (which grows linearly with carrier frequency T)
and the chirped wavepacket stationary phase energy dispersion (which decays as 1/T)
cancels the carrier frequency T and chirp rate η identically, leaving a logarithmic
bound bounded by (2 * C_N * C_core * w) * log T. -/
theorem carrier_dilution_density_product_eq (C_N C_core eta w T : ℝ)
    (heta : eta ≠ 0) (hT : T ≠ 0) :
    (C_N * (resonantBandwidth T eta w) * Real.log T) *
      (criticalSingleEnergyBound C_core eta T) =
      (criticalResonantCoeff C_N C_core w) * Real.log T := by
  unfold resonantBandwidth criticalSingleEnergyBound criticalResonantCoeff
  calc
    (C_N * (2 * eta * w * T) * Real.log T) * (C_core / (eta * T))
      = (2 * C_N * C_core * w * Real.log T) * ((eta * T) / (eta * T)) := by ring
    _ = (2 * C_N * C_core * w * Real.log T) * 1 := by
      rw [div_self]
      exact mul_ne_zero heta hT
    _ = (2 * C_N * C_core * w) * Real.log T := by ring

/-- Critical-line logarithmic upper bound from density and dispersion bounds. -/
theorem critical_resonant_bound_of_bounds {C_N C_core eta w T N_zeros E_single : ℝ}
    (heta : 0 < eta) (hT : 0 < T)
    (hN_le : N_zeros ≤ C_N * (resonantBandwidth T eta w) * Real.log T)
    (hE_le : E_single ≤ criticalSingleEnergyBound C_core eta T)
    (hN_nonneg : 0 ≤ N_zeros) (hE_nonneg : 0 ≤ E_single) :
    N_zeros * E_single ≤ (criticalResonantCoeff C_N C_core w) * Real.log T := by
  have h_top_nonneg : 0 ≤ C_N * (resonantBandwidth T eta w) * Real.log T :=
    le_trans hN_nonneg hN_le
  have h_prod : N_zeros * E_single ≤
      (C_N * (resonantBandwidth T eta w) * Real.log T) *
        (criticalSingleEnergyBound C_core eta T) :=
    mul_le_mul hN_le hE_le hE_nonneg h_top_nonneg
  have heq := carrier_dilution_density_product_eq C_N C_core eta w T
    (ne_of_gt heta) (ne_of_gt hT)
  linarith

/-- Combining resonant and non-resonant tail coefficients into the total
critical-line logarithmic coefficient C_crit,tot = C_crit,res + C_tail. -/
def totalCriticalCoeff (C_N C_core w C_tail : ℝ) : ℝ :=
  criticalResonantCoeff C_N C_core w + C_tail

/-- The total critical coefficient is strictly positive. -/
theorem totalCriticalCoeff_pos {C_N C_core w C_tail : ℝ}
    (hN : 0 < C_N) (hC : 0 < C_core) (hw : 0 < w) (htail : 0 ≤ C_tail) :
    0 < totalCriticalCoeff C_N C_core w C_tail := by
  unfold totalCriticalCoeff
  have hres := criticalResonantCoeff_pos hN hC hw
  linarith

/-- Total critical-line bound from resonant and tail components. -/
theorem total_critical_bound_of_parts {C_N C_core w C_tail T Q_res Q_tail : ℝ}
    (hres : Q_res ≤ (criticalResonantCoeff C_N C_core w) * Real.log T)
    (htail : Q_tail ≤ C_tail * Real.log T) :
    Q_res + Q_tail ≤ (totalCriticalCoeff C_N C_core w C_tail) * Real.log T := by
  unfold totalCriticalCoeff
  linarith

/-- Constructive certificate bundling carrier dilution-density balance parameters. -/
structure CarrierDilutionBalanceCertificate (C_N C_core w eta C_tail : ℝ) : Prop where
  N_pos : 0 < C_N
  core_pos : 0 < C_core
  w_pos : 0 < w
  eta_pos : 0 < eta
  tail_nonneg : 0 ≤ C_tail
  total_coeff_pos : 0 < totalCriticalCoeff C_N C_core w C_tail
  dilution_identity : ∀ T : ℝ, T ≠ 0 →
    (C_N * (resonantBandwidth T eta w) * Real.log T) *
      (criticalSingleEnergyBound C_core eta T) =
      (criticalResonantCoeff C_N C_core w) * Real.log T

/-- Constructor for `CarrierDilutionBalanceCertificate`. -/
theorem makeCarrierDilutionBalanceCertificate {C_N C_core w eta C_tail : ℝ}
    (hN : 0 < C_N) (hC : 0 < C_core) (hw : 0 < w) (heta : 0 < eta)
    (htail : 0 ≤ C_tail) :
    CarrierDilutionBalanceCertificate C_N C_core w eta C_tail :=
  ⟨hN, hC, hw, heta, htail,
   totalCriticalCoeff_pos hN hC hw htail,
   fun T hT => carrier_dilution_density_product_eq C_N C_core eta w T
     (ne_of_gt heta) hT⟩

end BuildingBlocks.ChirpedCarrierDilutionDensityBalance

#print axioms BuildingBlocks.ChirpedCarrierDilutionDensityBalance.resonantBandwidth_pos
#print axioms BuildingBlocks.ChirpedCarrierDilutionDensityBalance.resonantBandwidth_eq
#print axioms BuildingBlocks.ChirpedCarrierDilutionDensityBalance.criticalSingleEnergyBound_pos
#print axioms BuildingBlocks.ChirpedCarrierDilutionDensityBalance.criticalResonantCoeff_pos
#print axioms BuildingBlocks.ChirpedCarrierDilutionDensityBalance.carrier_dilution_density_product_eq
#print axioms BuildingBlocks.ChirpedCarrierDilutionDensityBalance.critical_resonant_bound_of_bounds
#print axioms BuildingBlocks.ChirpedCarrierDilutionDensityBalance.totalCriticalCoeff_pos
#print axioms BuildingBlocks.ChirpedCarrierDilutionDensityBalance.total_critical_bound_of_parts
#print axioms BuildingBlocks.ChirpedCarrierDilutionDensityBalance.makeCarrierDilutionBalanceCertificate
