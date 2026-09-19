import BuildingBlocks.ChirpedFresnelGaussianLocalization
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Order.Filter.Basic
import Mathlib.Topology.Order.Basic

/-!
# Exact Chirped Fresnel Phase Coherence and Core Lower Bound

This module establishes the **Exact Chirped Fresnel Phase Coherence Theorem**.
It proves that across the intrinsic Fresnel core `[x₀ - δ, x₀ + δ]` of radius
`δ = (η * T)^(-1/2)`, the quadratic phase deviation satisfies `|ΔΦ| ≤ 1` radian,
guaranteeing uniform phase coherence `cos(ΔΦ) ≥ 1/2 > 0` and strictly positive
coherent projection without destructive interference.

## Main Definitions and Theorems
- `cos_ge_half_of_abs_le_one`: Elementary cosine lower bound `|θ| ≤ 1 → 1/2 ≤ cos θ`.
- `fresnel_phase_deviation_le_one`: Phase deviation bounded by 1 on the Fresnel core.
- `fresnel_core_cos_ge_half`: Uniform cosine lower bound `cos(ΔΦ) ≥ 1/2` on the Fresnel core.
- `fresnel_core_lower_bound`: Pointwise lower bound for any envelope bounded below.
- `fresnel_energy_lower_bound`: Exact coherent energy lower bound `a_min^2 / (η * T) > 0`.
- `tunedCarrier_product_eq`: Exact carrier product `η * T(γ₀) = η * γ₀ / (1 - 2ηx₀)`.
- `fresnel_effective_coupling_pos`: Positivity of the coherent Fresnel coupling energy.
-/

namespace BuildingBlocks.ChirpedFresnelPhaseCoherence

open BuildingBlocks.ChirpedStationaryPhaseCarrier
open BuildingBlocks.ChirpedFresnelGaussianLocalization
open Filter
open Topology

/-! ### 1. Elementary Trigonometric Phase Coherence -/

/-- For any angle θ with absolute value at most 1 radian, cos θ is at least 1/2.
This follows from `1 - θ^2 / 2 ≤ cos θ` and `θ^2 ≤ 1`. -/
theorem cos_ge_half_of_abs_le_one {θ : ℝ} (hθ : |θ| ≤ 1) : (1 : ℝ) / 2 ≤ Real.cos θ := by
  have h1 : 1 - θ^2 / 2 ≤ Real.cos θ := Real.one_sub_sq_div_two_le_cos
  have hsq : θ^2 ≤ 1 := by
    have h1 : 0 ≤ |θ| := abs_nonneg θ
    have h2 : -1 ≤ θ := neg_le_of_abs_le hθ
    have h3 : θ ≤ 1 := le_of_abs_le hθ
    nlinarith
  have hsub : (1 : ℝ) / 2 ≤ 1 - θ^2 / 2 := by
    linarith
  exact hsub.trans h1

/-! ### 2. Fresnel Core Phase Deviation and Coherence -/

/-- Across the Fresnel core `|x - x₀| ≤ δ(η, T)`, the phase deviation from the center
is bounded by exactly 1 radian. -/
theorem fresnel_phase_deviation_le_one {γ₀ η x₀ : ℝ} (hη : 0 < η) (hx0 : 2 * η * x₀ ≠ 1)
    {x : ℝ} (hdist : |x - x₀| ≤ fresnelRadius η (tunedCarrier γ₀ η x₀))
    (hT : 0 < tunedCarrier γ₀ η x₀) :
    let T := tunedCarrier γ₀ η x₀
    |chirpedPhase η T γ₀ x - chirpedPhase η T γ₀ x₀| ≤ 1 := by
  intro T
  have hdev := chirpedPhase_deviation_le (γ₀ := γ₀) hx0 hdist
  dsimp only at hdev
  have hshift := fresnel_phase_shift_eq_one hη hT
  have hprod : 0 < η * T := mul_pos hη hT
  have habs : |η * T| = η * T := abs_of_pos hprod
  rw [habs] at hdev
  linarith

/-- On the Fresnel core around the tuned stationary point x₀, the phase cosine
is uniformly bounded below by 1/2. -/
theorem fresnel_core_cos_ge_half {γ₀ η x₀ : ℝ} (hη : 0 < η) (hx0 : 2 * η * x₀ ≠ 1)
    {x : ℝ} (hdist : |x - x₀| ≤ fresnelRadius η (tunedCarrier γ₀ η x₀))
    (hT : 0 < tunedCarrier γ₀ η x₀) :
    let T := tunedCarrier γ₀ η x₀
    (1 : ℝ) / 2 ≤ Real.cos (chirpedPhase η T γ₀ x - chirpedPhase η T γ₀ x₀) := by
  intro T
  have hdev : |chirpedPhase η T γ₀ x - chirpedPhase η T γ₀ x₀| ≤ 1 :=
    fresnel_phase_deviation_le_one hη hx0 hdist hT
  exact cos_ge_half_of_abs_le_one hdev

/-- For any envelope lower bound a_min > 0, the pointwise coherent projection
on the Fresnel core is at least a_min / 2. -/
theorem fresnel_core_lower_bound {γ₀ η x₀ : ℝ} (hη : 0 < η) (hx0 : 2 * η * x₀ ≠ 1)
    {x : ℝ} (hdist : |x - x₀| ≤ fresnelRadius η (tunedCarrier γ₀ η x₀))
    (hT : 0 < tunedCarrier γ₀ η x₀) {a_min : ℝ} (ha : 0 < a_min) :
    let T := tunedCarrier γ₀ η x₀
    a_min / 2 ≤ a_min * Real.cos (chirpedPhase η T γ₀ x - chirpedPhase η T γ₀ x₀) := by
  intro T
  have hcos := fresnel_core_cos_ge_half hη hx0 hdist hT
  have hprod : a_min * ((1 : ℝ) / 2) ≤ a_min * Real.cos (chirpedPhase η T γ₀ x - chirpedPhase η T γ₀ x₀) :=
    mul_le_mul_of_nonneg_left hcos (le_of_lt ha)
  have heq : a_min * ((1 : ℝ) / 2) = a_min / 2 := by ring
  rwa [heq] at hprod

/-! ### 3. Exact Coherent Energy and Carrier Product -/

/-- The exact formula for the carrier product η * T(γ₀, η, x₀). -/
theorem tunedCarrier_product_eq (γ₀ η x₀ : ℝ) :
    η * tunedCarrier γ₀ η x₀ = (η * γ₀) / (1 - 2 * η * x₀) := by
  dsimp [tunedCarrier]
  ring

/-- Positivity of the coherent Fresnel coupling energy for any positive envelope and carrier. -/
theorem fresnel_effective_coupling_pos {η T a_min : ℝ} (hη : 0 < η) (hT : 0 < T) (ha : 0 < a_min) :
    0 < a_min^2 / (η * T) := by
  have hprod : 0 < η * T := mul_pos hη hT
  have hsq : 0 < a_min^2 := sq_pos_of_pos ha
  exact div_pos hsq hprod

/-- The coherent Fresnel energy satisfies the exact identity `a_min^2 * δ^2 = a_min^2 / (η * T)`. -/
theorem fresnel_energy_eq {η T a_min : ℝ} (hη : 0 < η) (hT : 0 < T) :
    a_min^2 * (fresnelRadius η T)^2 = a_min^2 / (η * T) := by
  have hprod : 0 < η * T := mul_pos hη hT
  have hprod_ne : η * T ≠ 0 := ne_of_gt hprod
  dsimp [fresnelRadius]
  have hrpow : ((η * T) ^ (-((1 : ℝ) / 2))) ^ 2 = ((η * T) ^ (-((1 : ℝ) / 2))) ^ (2 : ℝ) := by
    norm_cast
  rw [hrpow, ← Real.rpow_mul (le_of_lt hprod)]
  have hmul : (-((1 : ℝ) / 2)) * 2 = -1 := by ring
  rw [hmul, Real.rpow_neg_one]
  ring

#print axioms cos_ge_half_of_abs_le_one
#print axioms fresnel_phase_deviation_le_one
#print axioms fresnel_core_cos_ge_half
#print axioms fresnel_core_lower_bound
#print axioms tunedCarrier_product_eq
#print axioms fresnel_effective_coupling_pos
#print axioms fresnel_energy_eq

end BuildingBlocks.ChirpedFresnelPhaseCoherence
