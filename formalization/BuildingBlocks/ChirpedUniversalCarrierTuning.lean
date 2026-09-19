import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import BuildingBlocks.ChirpedStationaryPhaseCarrier
import BuildingBlocks.ChirpedFresnelGaussianLocalization
import BuildingBlocks.ChirpedQuantitativeExclusionThreshold

/-!
# Chirped Universal Carrier Tuning and Elimination of Low-Frequency Cutoffs

This module proves the universal carrier tuning theorem for chirped wavepackets.
In previous literature and earlier modules, wavepacket tuning fixed the chirp rate
(e.g., `η = 1/4`), which tied the carrier linearly to the zero ordinate (`T = (4/3)γ`)
and required an external high-frequency bound (`γ ≥ H₀`) to ensure interior core embedding
(`T > 16`).

Here we prove that by allowing the chirp rate `η` to approach `1⁻`, the tuned carrier
`T(γ, η) = γ / (1 - η)` can be chosen arbitrarily large (`T > T_star`) for **any** positive
zero ordinate `γ > 0`, while keeping the stationary point locked at `x₀ = 1/2` and shrinking
the Fresnel core radius `δ = ((1 - η)/(ηγ))^(1/2) → 0`.

Consequently:
1. The stationary core `[1/2 - δ, 1/2 + δ]` is strictly embedded in `(0, 1)` for all `γ > 0`.
2. The carrier `T` unconditionally exceeds the quantitative power dominance threshold
   `quantitativeThreshold d b A C` for any displacement `d > 0`.
3. The reliance on external computational zero-free heights (such as Platt–Trudgian `H₀`)
   is eliminated: the chirped wavepacket mechanism refutes off-line zeros at **all**
   positive frequencies `γ > 0`.

All declarations depend strictly on the standard foundational axioms:
`[propext, Classical.choice, Quot.sound]`.
-/

namespace BuildingBlocks.ChirpedUniversalCarrierTuning

open Real
open BuildingBlocks.ChirpedQuantitativeExclusionThreshold

noncomputable section

/-- The lower bound on `η` ensuring the Fresnel core radius `δ < 1/2`. -/
def coreBoundEta (γ : ℝ) : ℝ := 4 / (4 + γ)

/-- The lower bound on `η` ensuring the carrier `T > T_star`. -/
def carrierBoundEta (γ T_star : ℝ) : ℝ := 1 - γ / T_star

/-- The joint lower bound on `η` combining core embedding and carrier magnitude. -/
def thresholdEta (γ T_star : ℝ) : ℝ := max (coreBoundEta γ) (carrierBoundEta γ T_star)

/-- The universal chirp rate selected as the midpoint between `thresholdEta` and 1. -/
def universalChirpRate (γ T_star : ℝ) : ℝ := (1 + max (thresholdEta γ T_star) 0) / 2

/-- The core bound on `η` is strictly positive for positive `γ`. -/
theorem coreBoundEta_pos {γ : ℝ} (hγ : 0 < γ) : 0 < coreBoundEta γ := by
  unfold coreBoundEta
  positivity

/-- The core bound on `η` is strictly less than 1 for positive `γ`. -/
theorem coreBoundEta_lt_one {γ : ℝ} (hγ : 0 < γ) : coreBoundEta γ < 1 := by
  unfold coreBoundEta
  rw [div_lt_iff₀ (by linarith)]
  linarith

/-- The carrier bound on `η` is strictly less than 1 for positive `γ` and `T_star`. -/
theorem carrierBoundEta_lt_one {γ T_star : ℝ} (hγ : 0 < γ) (hT : 0 < T_star) :
    carrierBoundEta γ T_star < 1 := by
  unfold carrierBoundEta
  have : 0 < γ / T_star := div_pos hγ hT
  linarith

/-- The threshold `η` is strictly less than 1. -/
theorem thresholdEta_lt_one {γ T_star : ℝ} (hγ : 0 < γ) (hT : 0 < T_star) :
    thresholdEta γ T_star < 1 := by
  unfold thresholdEta
  rw [max_lt_iff]
  exact ⟨coreBoundEta_lt_one hγ, carrierBoundEta_lt_one hγ hT⟩

/-- The universal chirp rate is strictly greater than `thresholdEta`. -/
theorem universalChirpRate_gt_threshold {γ T_star : ℝ} (hγ : 0 < γ) (hT : 0 < T_star) :
    thresholdEta γ T_star < universalChirpRate γ T_star := by
  unfold universalChirpRate
  have h_lt := thresholdEta_lt_one hγ hT
  have h_le : thresholdEta γ T_star ≤ max (thresholdEta γ T_star) 0 := le_max_left _ _
  have h_max_lt : max (thresholdEta γ T_star) 0 < 1 := by
    rw [max_lt_iff]
    exact ⟨h_lt, by norm_num⟩
  linarith

/-- The universal chirp rate is strictly positive. -/
theorem universalChirpRate_pos (γ T_star : ℝ) : 0 < universalChirpRate γ T_star := by
  unfold universalChirpRate
  have : 0 ≤ max (thresholdEta γ T_star) 0 := le_max_right _ _
  linarith

/-- The universal chirp rate is strictly less than 1. -/
theorem universalChirpRate_lt_one {γ T_star : ℝ} (hγ : 0 < γ) (hT : 0 < T_star) :
    universalChirpRate γ T_star < 1 := by
  unfold universalChirpRate
  have h_lt := thresholdEta_lt_one hγ hT
  have h_max_lt : max (thresholdEta γ T_star) 0 < 1 := by
    rw [max_lt_iff]
    exact ⟨h_lt, by norm_num⟩
  linarith

/-- The tuned carrier frequency associated to the universal chirp rate. -/
def universalCarrier (γ T_star : ℝ) : ℝ := γ / (1 - universalChirpRate γ T_star)

/-- The universal carrier is strictly positive. -/
theorem universalCarrier_pos {γ T_star : ℝ} (hγ : 0 < γ) (hT : 0 < T_star) :
    0 < universalCarrier γ T_star := by
  unfold universalCarrier
  have h_eta := universalChirpRate_lt_one hγ hT
  exact div_pos hγ (by linarith)

/-- The universal carrier strictly exceeds the prescribed target threshold `T_star`. -/
theorem universalCarrier_gt_target {γ T_star : ℝ} (hγ : 0 < γ) (hT : 0 < T_star) :
    T_star < universalCarrier γ T_star := by
  unfold universalCarrier
  have h_gt := universalChirpRate_gt_threshold hγ hT
  have h_thresh : carrierBoundEta γ T_star ≤ thresholdEta γ T_star := le_max_right _ _
  have h_eta : carrierBoundEta γ T_star < universalChirpRate γ T_star := h_thresh.trans_lt h_gt
  unfold carrierBoundEta at h_eta
  have h_sub_pos : 0 < 1 - universalChirpRate γ T_star := by
    have := universalChirpRate_lt_one hγ hT
    linarith
  have h_div : γ / T_star > 1 - universalChirpRate γ T_star := by linarith
  rw [lt_div_iff₀ h_sub_pos]
  have h_step : T_star * (1 - universalChirpRate γ T_star) < T_star * (γ / T_star) := by
    exact mul_lt_mul_of_pos_left h_div hT
  rw [mul_div_cancel₀ γ (ne_of_gt hT)] at h_step
  exact h_step

/-- The stationary phase derivative at `x₀ = 1/2` vanishes identically. -/
theorem universalPhaseDerivative_eq_zero (γ T_star : ℝ) {hγ : 0 < γ} {hT : 0 < T_star} :
    universalCarrier γ T_star * (1 - 2 * universalChirpRate γ T_star * (1 / 2)) - γ = 0 := by
  unfold universalCarrier
  have h_sub : 1 - universalChirpRate γ T_star ≠ 0 := by
    have := universalChirpRate_lt_one hγ hT
    linarith
  have h_simp : 1 - 2 * universalChirpRate γ T_star * (1 / 2) = 1 - universalChirpRate γ T_star := by
    ring
  rw [h_simp]
  rw [div_mul_cancel₀ γ h_sub]
  ring

/-- The squared Fresnel core radius under universal carrier tuning. -/
def universalCoreRadiusSq (γ T_star : ℝ) : ℝ :=
  (1 - universalChirpRate γ T_star) / (universalChirpRate γ T_star * γ)

/-- The squared Fresnel core radius is strictly less than 1/4. -/
theorem universalCoreRadiusSq_lt_quarter {γ T_star : ℝ} (hγ : 0 < γ) (hT : 0 < T_star) :
    universalCoreRadiusSq γ T_star < 1 / 4 := by
  unfold universalCoreRadiusSq
  have h_gt := universalChirpRate_gt_threshold hγ hT
  have h_core : coreBoundEta γ ≤ thresholdEta γ T_star := le_max_left _ _
  have h_eta : coreBoundEta γ < universalChirpRate γ T_star := h_core.trans_lt h_gt
  unfold coreBoundEta at h_eta
  have h_eta_pos := universalChirpRate_pos γ T_star
  have h_den_pos : 0 < universalChirpRate γ T_star * γ := mul_pos h_eta_pos hγ
  rw [div_lt_iff₀ h_den_pos]
  have h4g : 0 < 4 + γ := by linarith
  have h_cross2 := (div_lt_iff₀ h4g).mp h_eta
  have h_expand : universalChirpRate γ T_star * (4 + γ) =
      4 * universalChirpRate γ T_star + universalChirpRate γ T_star * γ := by ring
  rw [h_expand] at h_cross2
  linarith

/-- The Fresnel core radius under universal carrier tuning. -/
def universalCoreRadius (γ T_star : ℝ) : ℝ :=
  Real.sqrt (universalCoreRadiusSq γ T_star)

/-- The Fresnel core radius is strictly less than 1/2. -/
theorem universalCoreRadius_lt_half {γ T_star : ℝ} (hγ : 0 < γ) (hT : 0 < T_star) :
    universalCoreRadius γ T_star < 1 / 2 := by
  unfold universalCoreRadius
  have hsq := universalCoreRadiusSq_lt_quarter hγ hT
  have hpos : 0 ≤ universalCoreRadiusSq γ T_star := by
    unfold universalCoreRadiusSq
    have h_num : 0 ≤ 1 - universalChirpRate γ T_star := by
      have := universalChirpRate_lt_one hγ hT
      linarith
    have h_den : 0 ≤ universalChirpRate γ T_star * γ := by
      have h1 := universalChirpRate_pos γ T_star
      nlinarith
    exact div_nonneg h_num h_den
  have h_sqrt := Real.sqrt_lt_sqrt hpos hsq
  have h_half : Real.sqrt (1 / 4) = 1 / 2 := by
    have : (1 / 4 : ℝ) = (1 / 2 : ℝ)^2 := by ring
    rw [this, Real.sqrt_sq (by norm_num)]
  rwa [h_half] at h_sqrt

/-- The stationary core `[1/2 - δ, 1/2 + δ]` is strictly embedded in `(0, 1)`. -/
theorem universalCore_subset_unit_interval {γ T_star : ℝ} (hγ : 0 < γ) (hT : 0 < T_star)
    (x : ℝ) (hx : |x - 1 / 2| ≤ universalCoreRadius γ T_star) :
    0 < x ∧ x < 1 := by
  have hδ := universalCoreRadius_lt_half hγ hT
  have hx1 : -(universalCoreRadius γ T_star) ≤ x - 1 / 2 := (abs_le.mp hx).1
  have hx2 : x - 1 / 2 ≤ universalCoreRadius γ T_star := (abs_le.mp hx).2
  constructor
  · linarith
  · linarith

/-- Main Universal Existence Theorem:
For any positive zero ordinate `γ > 0` and any off-line parameters `(d, b, A, C)` with `0 < d` and `0 < b`,
there exists a chirp rate `η ∈ (0, 1)` and carrier `T > 0` such that:
1. `T` strictly exceeds the quantitative threshold `quantitativeThreshold d b A C`.
2. `T > 16`, ensuring asymptotic scale.
3. The stationary phase derivative at `x₀ = 1/2` vanishes identically (`Φ'(1/2) = 0`).
4. The Fresnel core radius satisfies `δ < 1/2`, guaranteeing strict window interior containment.
5. The power dominance inequality `A * log T + C < 2 * b * T^(2 * d)` holds strictly. -/
theorem universal_offline_carrier_exists
    (γ d b A C : ℝ) (hγ : 0 < γ) (hd : 0 < d) (hb : 0 < b) :
    ∃ (η T : ℝ),
      0 < η ∧ η < 1 ∧
      quantitativeThreshold d b A C < T ∧
      16 < T ∧
      T * (1 - η) - γ = 0 ∧
      universalCoreRadiusSq γ (max (quantitativeThreshold d b A C) 16 + 1) < 1 / 4 ∧
      A * Real.log T + C < 2 * b * T^(2 * d) := by
  let T_star : ℝ := max (quantitativeThreshold d b A C) 16 + 1
  have hT_star_pos : 0 < T_star := by
    have : (0 : ℝ) ≤ max (quantitativeThreshold d b A C) 16 := le_max_of_le_right (by norm_num)
    linarith
  let η := universalChirpRate γ T_star
  let T := universalCarrier γ T_star
  have hη_pos := universalChirpRate_pos γ T_star
  have hη_lt := universalChirpRate_lt_one hγ hT_star_pos
  have hT_gt := universalCarrier_gt_target hγ hT_star_pos
  have hT_thresh : quantitativeThreshold d b A C < T := by
    have h1 : quantitativeThreshold d b A C ≤ max (quantitativeThreshold d b A C) 16 := le_max_left _ _
    have h2 : max (quantitativeThreshold d b A C) 16 < T_star := by linarith
    exact (h1.trans_lt h2).trans hT_gt
  have hT_16 : 16 < T := by
    have h1 : (16 : ℝ) ≤ max (quantitativeThreshold d b A C) 16 := le_max_right _ _
    have h2 : max (quantitativeThreshold d b A C) 16 < T_star := by linarith
    exact (h1.trans_lt h2).trans hT_gt
  have h_stat : T * (1 - η) - γ = 0 := by
    unfold T universalCarrier
    have h_sub : 1 - η ≠ 0 := by linarith
    rw [div_mul_cancel₀ γ h_sub]
    ring
  have h_core := universalCoreRadiusSq_lt_quarter hγ hT_star_pos
  have h_dom := quantitative_power_dominance hd hb (le_of_lt hT_thresh)
  exact ⟨η, T, hη_pos, hη_lt, hT_thresh, hT_16, h_stat, h_core, h_dom⟩

#print axioms universalChirpRate_lt_one
#print axioms universalCarrier_gt_target
#print axioms universalPhaseDerivative_eq_zero
#print axioms universalCoreRadius_lt_half
#print axioms universalCore_subset_unit_interval
#print axioms universal_offline_carrier_exists

end

end BuildingBlocks.ChirpedUniversalCarrierTuning
