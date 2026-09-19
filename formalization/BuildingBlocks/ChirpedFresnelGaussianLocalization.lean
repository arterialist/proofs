import BuildingBlocks.ChirpedStationaryPhaseCarrier
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics
import Mathlib.Order.Filter.Basic
import Mathlib.Topology.Order.Basic

/-!
# Chirped Fresnel-Gaussian Localization and Stationary Phase Core

This module formalizes the exact algebraic structure of the chirped wavepacket
phase around its stationary point, proving that the phase deviation is an
EXACT quadratic polynomial with zero higher-order remainder, and establishing
the Fresnel core localization properties under carrier tuning.

## Mathematical Results
1. `chirpedPhase_sub_eq_quadratic`: Exact Taylor expansion of `chirpedPhase` around
   an arbitrary point `x₀` with exact remainder `η * T * (x - x₀)^2`.
2. `chirpedPhase_tuned_quadratic`: At the tuned carrier `T = tunedCarrier γ₀ η x₀`,
   the linear term vanishes identically, leaving a pure Gaussian phase
   `chirpedPhase x - chirpedPhase x₀ = η * T * (x - x₀)^2`.
3. `chirpedPhase_at_tuned_center`: Exact evaluation of the central phase
   `chirpedPhase x₀ = - η * T * x₀^2`.
4. `chirpedPhase_deviation_le`: Exact uniform bound on phase deviation within radius `δ`.
5. `fresnel_radius_sq_eq`: At the Fresnel radius `δ = (η * T)^(-1/2)`, the phase
   deviation equals exactly 1.
6. `fresnel_radius_pos`: Positivity of the Fresnel core radius for `η > 0` and `T > 0`.
7. `tendsto_fresnel_radius_zero`: Shrinkage of the Fresnel core to 0 as `T → ∞`.
8. `eventually_fresnel_core_in_support`: For any interior support point `0 < x₀ < w`,
   the Fresnel core `[x₀ - δ, x₀ + δ]` is eventually strictly contained in `(0, w)`.
-/

namespace BuildingBlocks.ChirpedFresnelGaussianLocalization

open BuildingBlocks.ChirpedStationaryPhaseCarrier
open Filter
open scoped Topology

/-! ### 1. Exact Algebraic Quadratic Expansion -/

/-- Exact algebraic identity expressing the chirped phase around any base point x₀
as the linear derivative term plus the exact quadratic remainder. -/
theorem chirpedPhase_sub_eq_quadratic (η T s x x₀ : ℝ) :
    chirpedPhase η T s x - chirpedPhase η T s x₀ =
      (x - x₀) * chirpedPhaseDeriv η T s x₀ + η * T * (x - x₀)^2 := by
  dsimp [chirpedPhase, chirpedPhaseDeriv]
  ring

/-- At the tuned carrier frequency T = tunedCarrier γ₀ η x₀, the linear derivative term
vanishes identically at x₀, so the phase difference is a pure quadratic Gaussian with zero remainder. -/
theorem chirpedPhase_tuned_quadratic {γ₀ η x₀ : ℝ} (hηx : 2 * η * x₀ ≠ 1) (x : ℝ) :
    let T := tunedCarrier γ₀ η x₀
    chirpedPhase η T γ₀ x - chirpedPhase η T γ₀ x₀ = η * T * (x - x₀)^2 := by
  intro T
  have hlin : chirpedPhaseDeriv η T γ₀ x₀ = 0 := tunedCarrier_stationary hηx
  have hquad := chirpedPhase_sub_eq_quadratic η T γ₀ x x₀
  rw [hlin] at hquad
  linear_combination hquad

/-- Exact central phase value at the tuned carrier: chirpedPhase x₀ = - η * T * x₀^2. -/
theorem chirpedPhase_at_tuned_center {γ₀ η x₀ : ℝ} (hηx : 2 * η * x₀ ≠ 1) :
    let T := tunedCarrier γ₀ η x₀
    chirpedPhase η T γ₀ x₀ = - η * T * x₀^2 := by
  intro T
  have hstat : chirpedPhaseDeriv η T γ₀ x₀ = 0 := tunedCarrier_stationary hηx
  dsimp [chirpedPhaseDeriv] at hstat
  dsimp [chirpedPhase]
  calc
    x₀ * (γ₀ - T) + x₀^2 * (η * T) = x₀ * (γ₀ - T + η * T * x₀) := by ring
    _ = x₀ * (- η * T * x₀) := by
      have heq : γ₀ - T + η * T * x₀ = - η * T * x₀ := by linear_combination hstat
      rw [heq]
    _ = - η * T * x₀^2 := by ring

/-! ### 2. Fresnel Core Radius and Phase Dispersion -/

/-- The Fresnel radius δ(η, T) = (η * T)^(-1/2) where quadratic phase shift equals 1. -/
noncomputable def fresnelRadius (η T : ℝ) : ℝ :=
  (η * T) ^ (-((1 : ℝ) / 2))

/-- Positivity of the Fresnel radius when η > 0 and T > 0. -/
theorem fresnelRadius_pos {η T : ℝ} (hη : 0 < η) (hT : 0 < T) :
    0 < fresnelRadius η T := by
  have hprod : 0 < η * T := mul_pos hη hT
  dsimp [fresnelRadius]
  exact Real.rpow_pos_of_pos hprod (-((1 : ℝ) / 2))

/-- At the Fresnel radius, the quadratic phase shift is exactly 1. -/
theorem fresnel_phase_shift_eq_one {η T : ℝ} (hη : 0 < η) (hT : 0 < T) :
    η * T * (fresnelRadius η T)^2 = 1 := by
  have hprod : 0 < η * T := mul_pos hη hT
  have hprod_ne : η * T ≠ 0 := ne_of_gt hprod
  dsimp [fresnelRadius]
  have hrpow : ((η * T) ^ (-((1 : ℝ) / 2))) ^ 2 = ((η * T) ^ (-((1 : ℝ) / 2))) ^ (2 : ℝ) := by
    norm_cast
  rw [hrpow, ← Real.rpow_mul (le_of_lt hprod)]
  have hmul : (-((1 : ℝ) / 2)) * 2 = -1 := by ring
  rw [hmul, Real.rpow_neg_one]
  exact mul_inv_cancel₀ hprod_ne

/-- Uniform quadratic phase bound on an interval of radius δ around x₀. -/
theorem chirpedPhase_deviation_le {γ₀ η x₀ : ℝ} (hηx : 2 * η * x₀ ≠ 1)
    {x δ : ℝ} (hdist : |x - x₀| ≤ δ) :
    let T := tunedCarrier γ₀ η x₀
    |chirpedPhase η T γ₀ x - chirpedPhase η T γ₀ x₀| ≤ |η * T| * δ^2 := by
  intro T
  have hdiff : chirpedPhase η T γ₀ x - chirpedPhase η T γ₀ x₀ = η * T * (x - x₀)^2 :=
    chirpedPhase_tuned_quadratic (γ₀ := γ₀) hηx x
  rw [hdiff, abs_mul]
  have hsq : |(x - x₀)^2| = (x - x₀)^2 := abs_sq (x - x₀)
  rw [hsq]
  have hsq_le : (x - x₀)^2 ≤ δ^2 := by
    have h1 : 0 ≤ |x - x₀| := abs_nonneg (x - x₀)
    have h2 : 0 ≤ δ := h1.trans hdist
    have h3 : -δ ≤ x - x₀ := by
      have := neg_le_of_abs_le hdist
      linarith
    have h4 : x - x₀ ≤ δ := le_of_abs_le hdist
    nlinarith
  exact mul_le_mul_of_nonneg_left hsq_le (abs_nonneg (η * T))

/-! ### 3. High-Frequency Asymptotics and Support Localization -/

/-- The Fresnel radius tends to 0 as the carrier T → ∞. -/
theorem tendsto_fresnelRadius_atTop {η : ℝ} (hη : 0 < η) :
    Tendsto (fun T => fresnelRadius η T) atTop (𝓝 0) := by
  dsimp [fresnelRadius]
  have hlim : Tendsto (fun T => η * T) atTop atTop :=
    Tendsto.const_mul_atTop hη tendsto_id
  have hpos : (0 : ℝ) < (1 : ℝ) / 2 := by norm_num
  have hpow : Tendsto (fun u : ℝ => u ^ (-((1 : ℝ) / 2))) atTop (𝓝 0) :=
    tendsto_rpow_neg_atTop hpos
  exact hpow.comp hlim

/-- For any interior point x₀ ∈ (0, w), the Fresnel core [x₀ - δ, x₀ + δ] is eventually
strictly contained in the packet window (0, w) as T → ∞. -/
theorem eventually_fresnel_core_in_support {η x₀ w : ℝ} (hη : 0 < η)
    (hx0 : 0 < x₀) (hxw : x₀ < w) :
    ∀ᶠ T in atTop, 0 < x₀ - fresnelRadius η T ∧ x₀ + fresnelRadius η T < w := by
  have htend := tendsto_fresnelRadius_atTop hη
  have hx0_pos : 0 < x₀ := hx0
  have hxw_pos : 0 < w - x₀ := sub_pos.mpr hxw
  have hmin : 0 < min x₀ (w - x₀) := lt_min hx0_pos hxw_pos
  have hevt := (tendsto_order.mp htend).2 (min x₀ (w - x₀)) hmin
  filter_upwards [hevt] with T hT
  have hpos : fresnelRadius η T < min x₀ (w - x₀) := hT
  have h1 : fresnelRadius η T < x₀ := hpos.trans_le (min_le_left x₀ (w - x₀))
  have h2 : fresnelRadius η T < w - x₀ := hpos.trans_le (min_le_right x₀ (w - x₀))
  constructor
  · linarith
  · linarith

#print axioms chirpedPhase_sub_eq_quadratic
#print axioms chirpedPhase_tuned_quadratic
#print axioms chirpedPhase_at_tuned_center
#print axioms fresnelRadius_pos
#print axioms fresnel_phase_shift_eq_one
#print axioms chirpedPhase_deviation_le
#print axioms tendsto_fresnelRadius_atTop
#print axioms eventually_fresnel_core_in_support

end BuildingBlocks.ChirpedFresnelGaussianLocalization
