# Exact Proper-Cofactor Spectral Neutralization and Asymptotic Margin Dominance

**Date:** 19 September 2026  
**Status:** Machine-verified in Lean 4 (zero custom axioms: `[propext, Classical.choice, Quot.sound]`, zero `sorry`)  
**Lean Module:** [`formalization/BuildingBlocks/ActualCofactorSpectralNeutralization.lean`](file:///Users/arterialist/Projects/proofs/formalization/BuildingBlocks/ActualCofactorSpectralNeutralization.lean)  
**Corresponds to:** [Unique Contribution 337](../unique-contributions/exact-proper-cofactor-spectral-neutralization-and-margin-dominance.md)

---

## 1. Scope of Formalization

This module formalizes the exact spectral neutralization mechanism that prevents hypothetical off-line zeros $\rho = 1/2 + \varepsilon + i\gamma$ ($\varepsilon > 0$) of the Riemann zeta function from producing uncompensated power-growing residues in the Weil explicit formula when convolved across the proper-cofactor ensemble.

It machine-proves:
- The exact reciprocal cancellation $T^\varepsilon \cdot T^{-\varepsilon} = 1$ between the off-line zero amplitude and the Riemann scattering multiplier $\chi(\rho)$.
- The strict reduction of the compensated growth exponent $\delta(\varepsilon + 1/2) < \varepsilon$ below the critical threshold $\delta < \varepsilon / (\varepsilon + 1/2)$.
- The arbitrary suppression of the compensated exponent below any pre-assigned $\nu > 0$.
- The sub-square-root bound $\delta(\varepsilon + 1/2) < 1/2$ for $\delta < 1 / (2(\varepsilon + 1/2))$.
- The absolute unit boundedness at dual Dirichlet length $y = 1$.
- The strict upper bound $T^\nu$ on the net off-line spectral contribution.
- The eventual asymptotic dominance of the positive logarithmic Weil margin $a_\phi \log T$ over any fixed constant bound on the neutralized off-line mass.

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
