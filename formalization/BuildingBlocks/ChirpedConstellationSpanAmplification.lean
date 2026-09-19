import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Order.Filter.Basic
import Mathlib.Topology.Order.Basic
import BuildingBlocks.ChirpedSpectralArithmeticExclusion

/-!
# Exact Chirped Constellation Span Amplification and Power Dominance Construction

This module establishes the exact bridge between the micro-local Fresnel coherent coupling
and macroscopic constellation span amplification for chirped wavepacket tests against
hypothetical off-line zeros of the Riemann zeta function.

Given any off-line zero displacement `d = β - 1/2 > 0` and any target power exponent `μ > 0`,
this module provides:
1. The explicit span dilation parameter `λ(d, μ) = (1 + μ) / (2d) > 0`.
2. The exact exponent identity `2 * λ * d - 1 = μ`.
3. The exact growth factor identity `T^(2*λ*d) / T = T^μ` for all `T > 0`.
4. The positive amplified coupling coefficient `b = a_min^2 / η > 0`.
5. The exact algebraic factorization `(a_min^2 / (η * T)) * T^(2*λ*d) = b * T^μ`.
6. The filter-theoretic divergence `b * T^μ → +∞` as `T → +∞`.
7. The eventual spectral deficit theorem `C_crit * log T + 6M - 2b T^μ < a * log T`.
8. The canonical parameter construction bundle `makeAmplifiedParameters`.

All declarations depend strictly on the standard foundational axioms:
`[propext, Classical.choice, Quot.sound]`.
-/

namespace BuildingBlocks.ChirpedConstellationSpanAmplification

open Filter
open Topology
open BuildingBlocks.ChirpedSpectralArithmeticExclusion

/-- Span dilation parameter λ required to produce net power exponent μ from off-line displacement d. -/
noncomputable def spanDilation (d μ : ℝ) : ℝ := (1 + μ) / (2 * d)

/-- The span dilation parameter is strictly positive for any d > 0 and μ > 0. -/
theorem spanDilation_pos {d μ : ℝ} (hd : 0 < d) (hμ : 0 < μ) : 0 < spanDilation d μ := by
  dsimp [spanDilation]
  have htop : 0 < 1 + μ := by linarith
  have hbot : 0 < 2 * d := by linarith
  exact div_pos htop hbot

/-- Exact exponent identity: the two-sided constellation span amplification minus the
carrier normalization 1/T yields precisely the target exponent μ. -/
theorem amplified_exponent_eq {d μ : ℝ} (hd : d ≠ 0) :
    2 * (spanDilation d μ) * d - 1 = μ := by
  dsimp [spanDilation]
  have hd2 : 2 * d ≠ 0 := mul_ne_zero two_ne_zero hd
  calc
    2 * ((1 + μ) / (2 * d)) * d - 1 = ((1 + μ) / (2 * d)) * (2 * d) - 1 := by ring
    _ = (1 + μ) - 1 := by rw [div_mul_cancel₀ (1 + μ) hd2]
    _ = μ := by ring

/-- Amplified off-line coupling coefficient derived from wavepacket envelope a_min and chirp rate η. -/
noncomputable def amplifiedOfflineCoeff (a_min η : ℝ) : ℝ := a_min^2 / η

/-- The amplified coupling coefficient is strictly positive for a_min > 0 and η > 0. -/
theorem amplifiedOfflineCoeff_pos {a_min η : ℝ} (ha : 0 < a_min) (hη : 0 < η) :
    0 < amplifiedOfflineCoeff a_min η := by
  dsimp [amplifiedOfflineCoeff]
  exact div_pos (sq_pos_of_pos ha) hη

/-- Exact growth factor identity: the amplified constellation power divided by the carrier
scaling 1/T exactly collapses to T^μ. -/
theorem amplified_growth_factor_eq {d μ T : ℝ} (hd : d ≠ 0) (hT : 0 < T) :
    T ^ (2 * (spanDilation d μ) * d) / T = T ^ μ := by
  have heq : 2 * (spanDilation d μ) * d = μ + 1 := by
    have h1 := amplified_exponent_eq (μ := μ) hd
    linarith
  rw [heq]
  have hrpow : T ^ (μ + 1) = T ^ μ * T ^ (1 : ℝ) := Real.rpow_add hT μ 1
  rw [hrpow, Real.rpow_one]
  exact mul_div_cancel_right₀ (T ^ μ) (ne_of_gt hT)

/-- Exact energy product equality: the micro-local Fresnel coherent energy (a_min^2 / (η * T))
multiplied by the constellation span factor T^(2 * λ * d) identically equals b * T^μ. -/
theorem amplified_energy_product_eq {a_min η d μ T : ℝ} (hd : d ≠ 0) (hT : 0 < T) :
    (a_min^2 / (η * T)) * T ^ (2 * (spanDilation d μ) * d) =
    (amplifiedOfflineCoeff a_min η) * T ^ μ := by
  dsimp [amplifiedOfflineCoeff]
  have hgrow := amplified_growth_factor_eq (μ := μ) hd hT
  have hsplit : a_min^2 / (η * T) = (a_min^2 / η) / T := by
    ring
  rw [hsplit]
  calc
    ((a_min^2 / η) / T) * T ^ (2 * (spanDilation d μ) * d) =
      (a_min^2 / η) * (T ^ (2 * (spanDilation d μ) * d) / T) := by ring
    _ = (a_min^2 / η) * T ^ μ := by rw [hgrow]

/-- Asymptotic power dominance: the amplified off-line zero coupling b * T^μ eventually forces
the spectral upper bound strictly below any positive arithmetic logarithmic margin a * log T. -/
theorem amplified_spectral_deficit_eventual {b μ C_crit M a : ℝ}
    (hb : 0 < b) (hμ : 0 < μ) :
    ∀ᶠ (T : ℝ) in atTop, C_crit * Real.log T + 6 * M - 2 * b * T^μ < a * Real.log T := by
  have hdom := power_dominance_over_log hμ hb (A := C_crit - a) (C := 6 * M)
  filter_upwards [hdom, eventually_gt_atTop (1 : ℝ)] with T hT hT1
  have hpos : 0 < b * T^μ := mul_pos hb (Real.rpow_pos_of_pos (by linarith) μ)
  linarith

/-- Divergence of amplified off-line energy to +∞ as T → +∞. -/
theorem tendsto_amplified_energy_atTop {b μ : ℝ} (hb : 0 < b) (hμ : 0 < μ) :
    Tendsto (fun T : ℝ => b * T ^ μ) atTop atTop := by
  have hpow : Tendsto (fun T : ℝ => T ^ μ) atTop atTop := tendsto_rpow_atTop hμ
  exact Tendsto.const_mul_atTop hb hpow

/-- Exclusion theorem: the positive arithmetic lower bound a * log T and the amplified
off-line zero spectral upper bound cannot both hold for large T. -/
theorem amplified_spectral_exclusion {b μ C_crit M a : ℝ}
    (hb : 0 < b) (hμ : 0 < μ) :
    ∀ᶠ (T : ℝ) in atTop,
      ¬ (a * Real.log T ≤ C_crit * Real.log T + 6 * M - 2 * b * T^μ) := by
  have hdef := amplified_spectral_deficit_eventual (C_crit := C_crit) (a := a) (M := M) hb hμ
  filter_upwards [hdef] with T hT hle
  linarith

/-- Structure packing the exact amplified chirped constellation parameters. -/
structure AmplifiedChirpedParameters (d a_min η μ : ℝ) where
  hd : 0 < d
  ha : 0 < a_min
  hη : 0 < η
  hμ : 0 < μ
  dilation : ℝ
  b : ℝ
  hdilation_pos : 0 < dilation
  hb_pos : 0 < b
  hexp : 2 * dilation * d - 1 = μ

/-- Canonical construction of amplified chirped parameters for any off-line zero displacement d > 0. -/
noncomputable def makeAmplifiedParameters {d a_min η μ : ℝ}
    (hd : 0 < d) (ha : 0 < a_min) (hη : 0 < η) (hμ : 0 < μ) :
    AmplifiedChirpedParameters d a_min η μ where
  hd := hd
  ha := ha
  hη := hη
  hμ := hμ
  dilation := spanDilation d μ
  b := amplifiedOfflineCoeff a_min η
  hdilation_pos := spanDilation_pos hd hμ
  hb_pos := amplifiedOfflineCoeff_pos ha hη
  hexp := amplified_exponent_eq (ne_of_gt hd)

end BuildingBlocks.ChirpedConstellationSpanAmplification

#print axioms BuildingBlocks.ChirpedConstellationSpanAmplification.spanDilation_pos
#print axioms BuildingBlocks.ChirpedConstellationSpanAmplification.amplified_exponent_eq
#print axioms BuildingBlocks.ChirpedConstellationSpanAmplification.amplifiedOfflineCoeff_pos
#print axioms BuildingBlocks.ChirpedConstellationSpanAmplification.amplified_growth_factor_eq
#print axioms BuildingBlocks.ChirpedConstellationSpanAmplification.amplified_energy_product_eq
#print axioms BuildingBlocks.ChirpedConstellationSpanAmplification.amplified_spectral_deficit_eventual
#print axioms BuildingBlocks.ChirpedConstellationSpanAmplification.tendsto_amplified_energy_atTop
#print axioms BuildingBlocks.ChirpedConstellationSpanAmplification.amplified_spectral_exclusion
#print axioms BuildingBlocks.ChirpedConstellationSpanAmplification.makeAmplifiedParameters
