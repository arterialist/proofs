# First Formalization 352: Exact Chirped Fresnel Phase Coherence and Core Lower Bound in Lean 4

## 1. Overview and Significance

This note documents the first machine-checked formalization of the **Exact Chirped Fresnel Phase Coherence and Core Lower Bound Theorem** in Lean 4.

- **Module:** [`formalization/BuildingBlocks/ChirpedFresnelPhaseCoherence.lean`](../formalization/BuildingBlocks/ChirpedFresnelPhaseCoherence.lean)
- **Lean Version:** Lean 4.24.0 (Mathlib commit 2026-09-11)
- **Axioms:** Strictly `[propext, Classical.choice, Quot.sound]`. Zero custom axioms, zero `sorry`.
- **Preceding Work:** [Unique Contribution 343](../unique-contributions/exact-chirped-fresnel-phase-coherence.md), [First Formalization 351](exact-chirped-fresnel-gaussian-localization.md).

---

## 2. Formal Definitions and Machine-Checked Declarations

### 2.1 Elementary Trigonometric Phase Coherence
```lean
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
```

### 2.2 Fresnel Core Phase Deviation Bound
```lean
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
```

### 2.3 Uniform Core Cosine Lower Bound
```lean
theorem fresnel_core_cos_ge_half {γ₀ η x₀ : ℝ} (hη : 0 < η) (hx0 : 2 * η * x₀ ≠ 1)
    {x : ℝ} (hdist : |x - x₀| ≤ fresnelRadius η (tunedCarrier γ₀ η x₀))
    (hT : 0 < tunedCarrier γ₀ η x₀) :
    let T := tunedCarrier γ₀ η x₀
    (1 : ℝ) / 2 ≤ Real.cos (chirpedPhase η T γ₀ x - chirpedPhase η T γ₀ x₀) := by
  intro T
  have hdev : |chirpedPhase η T γ₀ x - chirpedPhase η T γ₀ x₀| ≤ 1 :=
    fresnel_phase_deviation_le_one hη hx0 hdist hT
  exact cos_ge_half_of_abs_le_one hdev
```

### 2.4 Pointwise Coherent Projection Lower Bound
```lean
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
```

### 2.5 Carrier Product Formula
```lean
theorem tunedCarrier_product_eq (γ₀ η x₀ : ℝ) :
    η * tunedCarrier γ₀ η x₀ = (η * γ₀) / (1 - 2 * η * x₀) := by
  dsimp [tunedCarrier]
  ring
```

### 2.6 Coherent Energy Identity and Positivity
```lean
theorem fresnel_effective_coupling_pos {η T a_min : ℝ} (hη : 0 < η) (hT : 0 < T) (ha : 0 < a_min) :
    0 < a_min^2 / (η * T) := by
  have hprod : 0 < η * T := mul_pos hη hT
  have hsq : 0 < a_min^2 := sq_pos_of_pos ha
  exact div_pos hsq hprod

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
```

---

## 3. Axiomatic Verification

Verified via `#print axioms`:
```
info: 'BuildingBlocks.ChirpedFresnelPhaseCoherence.cos_ge_half_of_abs_le_one' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedFresnelPhaseCoherence.fresnel_phase_deviation_le_one' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedFresnelPhaseCoherence.fresnel_core_cos_ge_half' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedFresnelPhaseCoherence.fresnel_core_lower_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedFresnelPhaseCoherence.tunedCarrier_product_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedFresnelPhaseCoherence.fresnel_effective_coupling_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedFresnelPhaseCoherence.fresnel_energy_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All 7 theorems depend exclusively on the standard core axioms of Lean 4.
