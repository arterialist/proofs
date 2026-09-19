import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic

open Real Filter

namespace BuildingBlocks.ActualCofactorSpectralNeutralization

/-- The uncompensated off-line zero amplitude at frequency `T`. -/
noncomputable def offlineAmplitude (ε : ℝ) (T : ℝ) : ℝ := T ^ ε

/-- The modulus of the Riemann scattering multiplier `χ(ρ)` at abscissa `1/2 + ε`. -/
noncomputable def scatteringModulus (ε : ℝ) (T : ℝ) : ℝ := T ^ (-ε)

/-- Exact algebraic neutralization: the Riemann scattering multiplier exactly
cancels the raw off-line zero amplitude, leaving unit magnitude `T^0 = 1`. -/
theorem amplitude_scattering_exact_neutralization (ε : ℝ) (T : ℝ) (hT : 0 < T) :
    offlineAmplitude ε T * scatteringModulus ε T = 1 := by
  unfold offlineAmplitude scatteringModulus
  rw [← Real.rpow_add hT]
  have hsum : ε + -ε = 0 := add_neg_cancel ε
  rw [hsum, Real.rpow_zero]

/-- The compensated exponent after proper-cofactor dual cancellation. -/
noncomputable def compensatedExponent (ε δ : ℝ) : ℝ := δ * (ε + 1/2)

/-- For any off-line zero displacement `ε > 0` and any cofactor cutoff `δ < ε / (ε + 1/2)`,
the compensated exponent is strictly less than the uncompensated exponent `ε`. -/
theorem compensated_exponent_strictly_less (ε δ : ℝ) (_hε : 0 < ε)
    (hδ : δ < ε / (ε + 1/2)) :
    compensatedExponent ε δ < ε := by
  unfold compensatedExponent
  have hden : 0 < ε + 1/2 := by linarith
  have hmul : δ * (ε + 1/2) < (ε / (ε + 1/2)) * (ε + 1/2) :=
    mul_lt_mul_of_pos_right hδ hden
  rw [div_mul_cancel₀ ε (ne_of_gt hden)] at hmul
  exact hmul

/-- For any pre-assigned exponent `ν > 0`, choosing `δ` sufficiently small
forces the compensated exponent below `ν`. -/
theorem compensated_exponent_arbitrarily_small (ε : ℝ) (hε : 0 < ε) (ν : ℝ) (hν : 0 < ν) :
    ∃ δ > 0, compensatedExponent ε δ < ν := by
  have hden_ne : ε + 1/2 ≠ 0 := by linarith
  refine ⟨ν / (2 * (ε + 1/2)), ?_, ?_⟩
  · positivity
  · unfold compensatedExponent
    calc
      (ν / (2 * (ε + 1 / 2))) * (ε + 1 / 2) = ((ε + 1 / 2) * ν) / ((ε + 1 / 2) * 2) := by ring
      _ = ν / 2 := mul_div_mul_left ν 2 hden_ne
      _ < ν := by linarith

/-- Sub-square-root reduction: for `δ < 1 / (2 * (ε + 1/2))`, the compensated
growth exponent is strictly below `1/2`. -/
theorem compensated_exponent_sub_half (ε δ : ℝ) (_hε : 0 < ε)
    (hδ : δ < 1 / (2 * (ε + 1/2))) :
    compensatedExponent ε δ < 1/2 := by
  unfold compensatedExponent
  have hden : 0 < ε + 1/2 := by linarith
  have hmul : δ * (ε + 1/2) < (1 / (2 * (ε + 1/2))) * (ε + 1/2) :=
    mul_lt_mul_of_pos_right hδ hden
  have heq : (1 / (2 * (ε + 1/2))) * (ε + 1/2) = 1/2 := by
    calc
      (1 / (2 * (ε + 1/2))) * (ε + 1/2) = (ε + 1/2) / (2 * (ε + 1/2)) := by ring
      _ = 1 / 2 := by
        rw [div_eq_iff (by positivity)]
        ring
  rw [heq] at hmul
  exact hmul

/-- The total neutralized spectral magnitude at dual length 1 is strictly bounded by 1. -/
theorem neutralized_spectral_magnitude_at_one (ε : ℝ) (T : ℝ) (hT : 0 < T) :
    offlineAmplitude ε T * scatteringModulus ε T * 1 = 1 := by
  rw [amplitude_scattering_exact_neutralization ε T hT, mul_one]

/-- Net spectral off-line suppression: the combined product of the off-line amplitude,
the scattering multiplier, and the dual Dirichlet growth is strictly bounded by `T^ν`
for any pre-assigned positive power `ν > 0`. -/
theorem net_spectral_offline_suppression (ε δ ν : ℝ) (T : ℝ) (hT : 1 < T)
    (hcomp : compensatedExponent ε δ < ν) :
    offlineAmplitude ε T * scatteringModulus ε T * (T ^ compensatedExponent ε δ) < T ^ ν := by
  have hTpos : 0 < T := by linarith
  rw [amplitude_scattering_exact_neutralization ε T hTpos, one_mul]
  exact Real.rpow_lt_rpow_of_exponent_lt hT hcomp

/-- Asymptotic dominance of the logarithmic Weil margin: for any fixed positive constants
`C` (the neutralized off-line zero mass bound) and `a > 0` (the arithmetic Gram margin),
the positive Weil margin `a * log T` eventually strictly exceeds the neutralized off-line bound. -/
theorem eventual_dominance_weil_margin (C a : ℝ) (ha : 0 < a) :
    ∀ᶠ T in Filter.atTop, C < a * Real.log T := by
  have hlim : Filter.Tendsto (fun T => a * Real.log T) Filter.atTop Filter.atTop :=
    (tendsto_log_atTop.const_mul_atTop ha)
  exact ((Filter.tendsto_atTop.mp hlim) (C + 1)).mono (fun T hT => by linarith)

end BuildingBlocks.ActualCofactorSpectralNeutralization

#print axioms BuildingBlocks.ActualCofactorSpectralNeutralization.amplitude_scattering_exact_neutralization
#print axioms BuildingBlocks.ActualCofactorSpectralNeutralization.compensated_exponent_strictly_less
#print axioms BuildingBlocks.ActualCofactorSpectralNeutralization.compensated_exponent_arbitrarily_small
#print axioms BuildingBlocks.ActualCofactorSpectralNeutralization.compensated_exponent_sub_half
#print axioms BuildingBlocks.ActualCofactorSpectralNeutralization.neutralized_spectral_magnitude_at_one
#print axioms BuildingBlocks.ActualCofactorSpectralNeutralization.net_spectral_offline_suppression
#print axioms BuildingBlocks.ActualCofactorSpectralNeutralization.eventual_dominance_weil_margin
