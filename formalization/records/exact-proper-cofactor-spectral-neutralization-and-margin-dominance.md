# Reciprocal real-power identity and logarithmic eventual dominance

**Date:** 19 September 2026  
**Status:** Machine-verified in Lean 4 (zero custom axioms: `[propext, Classical.choice, Quot.sound]`, zero `sorry`)  
**Lean Module:** [`formalization/BuildingBlocks/ActualCofactorSpectralNeutralization.lean`](file:///Users/arterialist/Projects/proofs/formalization/BuildingBlocks/ActualCofactorSpectralNeutralization.lean)  
**Corresponds to:** [Unique Contribution 337](../../formalization/records/exact-proper-cofactor-spectral-neutralization-and-margin-dominance.md)

---

## 1. Scope of Formalization

This module defines `offlineAmplitude ε T` to be $T^\varepsilon$ and `scatteringModulus ε T` to be $T^{-\varepsilon}$. These are abstract real-power definitions. The module does not prove that they equal an actual zeta-zero amplitude or Riemann scattering multiplier, and it contains no cofactor sum or Weil explicit formula.

It machine-proves:
- The reciprocal real-power identity $T^\varepsilon T^{-\varepsilon}=1$ for $T>0$.
- The strict reduction of the compensated growth exponent $\delta(\varepsilon + 1/2) < \varepsilon$ below the critical threshold $\delta < \varepsilon / (\varepsilon + 1/2)$.
- The arbitrary suppression of the compensated exponent below any pre-assigned $\nu > 0$.
- The sub-square-root bound $\delta(\varepsilon + 1/2) < 1/2$ for $\delta < 1 / (2(\varepsilon + 1/2))$.
- The same identity after multiplication by $1$.
- An inequality between real powers when the exponent inequality is supplied.
- The elementary eventual inequality $C<a\log T$ for $a>0$.

Terms such as "spectral contribution" and "Weil margin" are motivation only. No declaration in this file connects the defined powers to those analytic objects.

---

## 2. Verified Lean Declarations

```lean
namespace BuildingBlocks.ActualCofactorSpectralNeutralization

noncomputable def offlineAmplitude (ε : ℝ) (T : ℝ) : ℝ := T ^ ε

noncomputable def scatteringModulus (ε : ℝ) (T : ℝ) : ℝ := T ^ (-ε)

theorem amplitude_scattering_exact_neutralization (ε : ℝ) (T : ℝ) (hT : 0 < T) :
    offlineAmplitude ε T * scatteringModulus ε T = 1

noncomputable def compensatedExponent (ε δ : ℝ) : ℝ := δ * (ε + 1/2)

theorem compensated_exponent_strictly_less (ε δ : ℝ) (_hε : 0 < ε)
    (hδ : δ < ε / (ε + 1/2)) :
    compensatedExponent ε δ < ε

theorem compensated_exponent_arbitrarily_small (ε : ℝ) (hε : 0 < ε) (ν : ℝ) (hν : 0 < ν) :
    ∃ δ > 0, compensatedExponent ε δ < ν

theorem compensated_exponent_sub_half (ε δ : ℝ) (_hε : 0 < ε)
    (hδ : δ < 1 / (2 * (ε + 1/2))) :
    compensatedExponent ε δ < 1/2

theorem neutralized_spectral_magnitude_at_one (ε : ℝ) (T : ℝ) (hT : 0 < T) :
    offlineAmplitude ε T * scatteringModulus ε T * 1 = 1

theorem net_spectral_offline_suppression (ε δ ν : ℝ) (T : ℝ) (hT : 1 < T)
    (hcomp : compensatedExponent ε δ < ν) :
    offlineAmplitude ε T * scatteringModulus ε T * (T ^ compensatedExponent ε δ) < T ^ ν

theorem eventual_dominance_weil_margin (C a : ℝ) (ha : 0 < a) :
    ∀ᶠ T in Filter.atTop, C < a * Real.log T

end BuildingBlocks.ActualCofactorSpectralNeutralization
```

---

## 3. Dependency and Axiom Audit

- Built cleanly with `lake build BuildingBlocks.ActualCofactorSpectralNeutralization` (3087 jobs passed).
- Axiom report:
  - `amplitude_scattering_exact_neutralization`: `[propext, Classical.choice, Quot.sound]`
  - `compensated_exponent_strictly_less`: `[propext, Classical.choice, Quot.sound]`
  - `compensated_exponent_arbitrarily_small`: `[propext, Classical.choice, Quot.sound]`
  - `compensated_exponent_sub_half`: `[propext, Classical.choice, Quot.sound]`
  - `neutralized_spectral_magnitude_at_one`: `[propext, Classical.choice, Quot.sound]`
  - `net_spectral_offline_suppression`: `[propext, Classical.choice, Quot.sound]`
  - `eventual_dominance_weil_margin`: `[propext, Classical.choice, Quot.sound]`
- Zero custom axioms, zero `sorry`.
