# First Formalization 351: Exact Chirped Fresnel-Gaussian Localization and Stationary Phase Core in Lean 4

## 1. Overview and Significance

This treatise documents the first machine-checked formalization of the **Exact Chirped Fresnel-Gaussian Localization and Stationary Phase Core Theorem** in interactive theorem proving.

- **Module:** [`formalization/BuildingBlocks/ChirpedFresnelGaussianLocalization.lean`](../formalization/BuildingBlocks/ChirpedFresnelGaussianLocalization.lean)
- **Lean Version:** Lean 4.24.0 (Mathlib commit 2026-09-11)
- **Axioms:** Strictly `[propext, Classical.choice, Quot.sound]`. Zero custom axioms, zero `sorry`.
- **Preceding Work:** [Unique Contribution 342](../unique-contributions/exact-chirped-fresnel-gaussian-localization.md), [First Formalization 350](exact-chirped-stationary-phase-carrier-tuning.md).

---

## 2. Formal Definitions and Machine-Checked Declarations

### 2.1 Fresnel Radius Definition
```lean
noncomputable def fresnelRadius (η T : ℝ) : ℝ :=
  (η * T) ^ (-((1 : ℝ) / 2))
```

### 2.2 Exact Quadratic Taylor Expansion
```lean
theorem chirpedPhase_sub_eq_quadratic (η T s x x₀ : ℝ) :
    chirpedPhase η T s x - chirpedPhase η T s x₀ =
      (x - x₀) * chirpedPhaseDeriv η T s x₀ + η * T * (x - x₀)^2 := by
  dsimp [chirpedPhase, chirpedPhaseDeriv]
  ring
```

### 2.3 Stationary Quadratic Phase Collapse
```lean
theorem chirpedPhase_tuned_quadratic {γ₀ η x₀ : ℝ} (hηx : 2 * η * x₀ ≠ 1) (x : ℝ) :
    let T := tunedCarrier γ₀ η x₀
    chirpedPhase η T γ₀ x - chirpedPhase η T γ₀ x₀ = η * T * (x - x₀)^2 := by
  intro T
  have hlin : chirpedPhaseDeriv η T γ₀ x₀ = 0 := tunedCarrier_stationary hηx
  have hquad := chirpedPhase_sub_eq_quadratic η T γ₀ x x₀
  rw [hlin] at hquad
  linear_combination hquad
```

### 2.4 Central Phase Value Evaluation
```lean
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
```

### 2.5 Unit Phase Shift at Fresnel Radius
```lean
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
```

### 2.6 Uniform Quadratic Phase Deviation Bound
```lean
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
```

### 2.7 High-Frequency Shrinkage and Window Containment
```lean
theorem tendsto_fresnelRadius_atTop {η : ℝ} (hη : 0 < η) :
    Tendsto (fun T => fresnelRadius η T) atTop (𝓝 0) := by
  dsimp [fresnelRadius]
  have hlim : Tendsto (fun T => η * T) atTop atTop :=
    Tendsto.const_mul_atTop hη tendsto_id
  have hpos : (0 : ℝ) < (1 : ℝ) / 2 := by norm_num
  have hpow : Tendsto (fun u : ℝ => u ^ (-((1 : ℝ) / 2))) atTop (𝓝 0) :=
    tendsto_rpow_neg_atTop hpos
  exact hpow.comp hlim

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
```

---

## 3. Axiomatic Verification

Verified via `#print axioms`:
```
info: 'BuildingBlocks.ChirpedFresnelGaussianLocalization.chirpedPhase_sub_eq_quadratic' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedFresnelGaussianLocalization.chirpedPhase_tuned_quadratic' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedFresnelGaussianLocalization.chirpedPhase_at_tuned_center' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedFresnelGaussianLocalization.fresnelRadius_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedFresnelGaussianLocalization.fresnel_phase_shift_eq_one' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedFresnelGaussianLocalization.chirpedPhase_deviation_le' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedFresnelGaussianLocalization.tendsto_fresnelRadius_atTop' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedFresnelGaussianLocalization.eventually_fresnel_core_in_support' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All 8 machine-checked theorems depend solely on the three standard foundational axioms of Lean 4.
