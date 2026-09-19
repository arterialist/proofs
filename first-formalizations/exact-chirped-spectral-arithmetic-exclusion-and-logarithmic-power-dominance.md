# First Formalization 348: Exact Chirped Spectral-Arithmetic Exclusion and Logarithmic Power Dominance

**Date:** September 19, 2026  
**Module:** [`formalization/BuildingBlocks/ChirpedSpectralArithmeticExclusion.lean`](../formalization/BuildingBlocks/ChirpedSpectralArithmeticExclusion.lean)  
**Verification System:** Lean 4.24.0 (Lake build, Mathlib v4.24.0)  
**Axiom Audit:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)  
**Corresponding Contribution:** [Unique Contribution 339](../unique-contributions/exact-chirped-spectral-arithmetic-exclusion-and-logarithmic-power-dominance.md)

---

## 1. Description & Formal Significance

This module machine-checks an abstract asymptotic exclusion from the stated scalar lower- and upper-bound hypotheses. Specifically, it proves that for dilated chirped packets with critical span $R = 2 \log T - B$:

1. Any off-line zero displacement $d = \beta - 1/2 > 0$ generates power growth $T^{2d}$ with exponent $2d > 0$.
2. The natural logarithm is universally bounded by $(2/\alpha) T^{\alpha/2}$ for any positive power $\alpha > 0$ and all $T > 0$.
3. Any linear-logarithmic background $A \log T + C$ is eventually dominated by any power term $b T^\alpha$ ($b > 0, \alpha > 0$).
4. The presence of an off-line zero forces the spectral upper bound $C_{\text{crit}} \log T + 6M - 2b T^{2d}$ to eventually fall strictly below the positive arithmetic Weil margin $a \log T$.
5. The arithmetic margin inequality and spectral representation cannot hold simultaneously as $T \to \infty$.

---

## 2. Machine-Checked Theorems & Statements

```lean
namespace BuildingBlocks.ChirpedSpectralArithmeticExclusion

theorem chirped_power_exponent_pos {d : ℝ} (hd : 0 < d) : 0 < 2 * d

theorem chirped_effective_coeff_pos {b d B : ℝ} (hb : 0 < b) :
    0 < b * Real.exp (-d * B)

theorem chirped_growth_factor_eq {d B T : ℝ} (hT : 0 < T) :
    Real.exp (d * (2 * Real.log T - B)) = Real.exp (-d * B) * T^(2 * d)

theorem log_le_rpow_half {α : ℝ} (hα : 0 < α) {T : ℝ} (hT : 0 < T) :
    Real.log T ≤ (2 / α) * T^(α / 2)

theorem power_dominance_over_log {α b A C : ℝ} (hα : 0 < α) (hb : 0 < b) :
    ∀ᶠ (T : ℝ) in atTop, A * Real.log T + C < b * T^α

theorem chirped_spectral_deficit_eventual {C_crit a b d M : ℝ}
    (hb : 0 < b) (hd : 0 < d) :
    ∀ᶠ (T : ℝ) in atTop, C_crit * Real.log T + 6 * M - 2 * b * T^(2 * d) < a * Real.log T

theorem chirped_spectral_arithmetic_exclusion {C_crit a b d M : ℝ}
    (hb : 0 < b) (hd : 0 < d) :
    ∀ᶠ (T : ℝ) in atTop,
      ¬ (a * Real.log T ≤ C_crit * Real.log T + 6 * M - 2 * b * T^(2 * d))

end BuildingBlocks.ChirpedSpectralArithmeticExclusion
```

---

## 3. Verification Trace & Dependencies

- **Lake Build:** Succeeded across 3867 jobs in `BuildingBlocks`.
- **Axioms Printed:**
  - `BuildingBlocks.ChirpedSpectralArithmeticExclusion.chirped_power_exponent_pos`: `[propext, Classical.choice, Quot.sound]`
  - `BuildingBlocks.ChirpedSpectralArithmeticExclusion.chirped_effective_coeff_pos`: `[propext, Classical.choice, Quot.sound]`
  - `BuildingBlocks.ChirpedSpectralArithmeticExclusion.chirped_growth_factor_eq`: `[propext, Classical.choice, Quot.sound]`
  - `BuildingBlocks.ChirpedSpectralArithmeticExclusion.log_le_rpow_half`: `[propext, Classical.choice, Quot.sound]`
  - `BuildingBlocks.ChirpedSpectralArithmeticExclusion.power_dominance_over_log`: `[propext, Classical.choice, Quot.sound]`
  - `BuildingBlocks.ChirpedSpectralArithmeticExclusion.chirped_spectral_deficit_eventual`: `[propext, Classical.choice, Quot.sound]`
  - `BuildingBlocks.ChirpedSpectralArithmeticExclusion.chirped_spectral_arithmetic_exclusion`: `[propext, Classical.choice, Quot.sound]`
- **`sorry` Count:** 0.
