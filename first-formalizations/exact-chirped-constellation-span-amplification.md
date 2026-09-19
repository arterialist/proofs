# First Formalization 353: Exact Chirped Constellation Span Amplification and Power Dominance in Lean 4

## 1. Overview and Significance

This note documents the first machine-checked formalization of the **Exact Chirped Constellation Span Amplification and Power Dominance Construction** in Lean 4.

- **Module:** [`formalization/BuildingBlocks/ChirpedConstellationSpanAmplification.lean`](../formalization/BuildingBlocks/ChirpedConstellationSpanAmplification.lean)
- **Lean Version:** Lean 4.24.0 (Mathlib commit 2026-09-11)
- **Axioms:** Strictly `[propext, Classical.choice, Quot.sound]`. Zero custom axioms, zero `sorry`.
- **Preceding Work:** [Unique Contribution 344](../unique-contributions/exact-chirped-constellation-span-amplification.md), [First Formalization 352](exact-chirped-fresnel-phase-coherence.md).

---

## 2. Formal Definitions and Machine-Checked Declarations

### 2.1 Span Dilation Parameter and Exponent Identity
```lean
noncomputable def spanDilation (d μ : ℝ) : ℝ := (1 + μ) / (2 * d)

theorem spanDilation_pos {d μ : ℝ} (hd : 0 < d) (hμ : 0 < μ) : 0 < spanDilation d μ := by
  dsimp [spanDilation]
  have htop : 0 < 1 + μ := by linarith
  have hbot : 0 < 2 * d := by linarith
  exact div_pos htop hbot

theorem amplified_exponent_eq {d μ : ℝ} (hd : d ≠ 0) :
    2 * (spanDilation d μ) * d - 1 = μ := by
  dsimp [spanDilation]
  have hd2 : 2 * d ≠ 0 := mul_ne_zero two_ne_zero hd
  calc
    2 * ((1 + μ) / (2 * d)) * d - 1 = ((1 + μ) / (2 * d)) * (2 * d) - 1 := by ring
    _ = (1 + μ) - 1 := by rw [div_mul_cancel₀ (1 + μ) hd2]
    _ = μ := by ring
```

### 2.2 Amplified Coupling Coefficient and Growth Factor
```lean
noncomputable def amplifiedOfflineCoeff (a_min η : ℝ) : ℝ := a_min^2 / η

theorem amplifiedOfflineCoeff_pos {a_min η : ℝ} (ha : 0 < a_min) (hη : 0 < η) :
    0 < amplifiedOfflineCoeff a_min η := by
  dsimp [amplifiedOfflineCoeff]
  exact div_pos (sq_pos_of_pos ha) hη

theorem amplified_growth_factor_eq {d μ T : ℝ} (hd : d ≠ 0) (hT : 0 < T) :
    T ^ (2 * (spanDilation d μ) * d) / T = T ^ μ := by
  have heq : 2 * (spanDilation d μ) * d = μ + 1 := by
    have h1 := amplified_exponent_eq (μ := μ) hd
    linarith
  rw [heq]
  have hrpow : T ^ (μ + 1) = T ^ μ * T ^ (1 : ℝ) := Real.rpow_add hT μ 1
  rw [hrpow, Real.rpow_one]
  exact mul_div_cancel_right₀ (T ^ μ) (ne_of_gt hT)
```

### 2.3 Exact Energy Product Identity
```lean
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
```

### 2.4 Asymptotic Deficit, Divergence, and Exclusion
```lean
theorem amplified_spectral_deficit_eventual {b μ C_crit M a : ℝ}
    (hb : 0 < b) (hμ : 0 < μ) :
    ∀ᶠ (T : ℝ) in atTop, C_crit * Real.log T + 6 * M - 2 * b * T^μ < a * Real.log T := by
  have hdom := power_dominance_over_log hμ hb (A := C_crit - a) (C := 6 * M)
  filter_upwards [hdom, eventually_gt_atTop (1 : ℝ)] with T hT hT1
  have hpos : 0 < b * T^μ := mul_pos hb (Real.rpow_pos_of_pos (by linarith) μ)
  linarith

theorem tendsto_amplified_energy_atTop {b μ : ℝ} (hb : 0 < b) (hμ : 0 < μ) :
    Tendsto (fun T : ℝ => b * T ^ μ) atTop atTop := by
  have hpow : Tendsto (fun T : ℝ => T ^ μ) atTop atTop := tendsto_rpow_atTop hμ
  exact Tendsto.const_mul_atTop hb hpow

theorem amplified_spectral_exclusion {b μ C_crit M a : ℝ}
    (hb : 0 < b) (hμ : 0 < μ) :
    ∀ᶠ (T : ℝ) in atTop,
      ¬ (a * Real.log T ≤ C_crit * Real.log T + 6 * M - 2 * b * T^μ) := by
  have hdef := amplified_spectral_deficit_eventual (C_crit := C_crit) (a := a) (M := M) hb hμ
  filter_upwards [hdef] with T hT hle
  linarith
```

### 2.5 Constructive Parameter Bundle
```lean
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
```

---

## 3. Axiomatic Verification

Verified via `#print axioms`:
```
info: 'BuildingBlocks.ChirpedConstellationSpanAmplification.spanDilation_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedConstellationSpanAmplification.amplified_exponent_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedConstellationSpanAmplification.amplifiedOfflineCoeff_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedConstellationSpanAmplification.amplified_growth_factor_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedConstellationSpanAmplification.amplified_energy_product_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedConstellationSpanAmplification.amplified_spectral_deficit_eventual' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedConstellationSpanAmplification.tendsto_amplified_energy_atTop' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedConstellationSpanAmplification.amplified_spectral_exclusion' depends on axioms: [propext, Classical.choice, Quot.sound]
info: 'BuildingBlocks.ChirpedConstellationSpanAmplification.makeAmplifiedParameters' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All 9 theorems depend exclusively on the standard core axioms of Lean 4.
