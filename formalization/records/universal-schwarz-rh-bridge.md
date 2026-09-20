# Schwarz reflection and conditional RH bridges

## Summary
This module proves reflection and real-valuedness facts, then uses them in RH implications. It removes an explicit `ZetaSchwarzReflection` argument from earlier bridge theorems, but it does not remove their RH-strength system arguments:
1. Proves exact real-valuedness of the Riemann zeta function on the positive real axis:
   $$\operatorname{Im}(\zeta(\sigma)) = 0 \quad \text{for all } \sigma > 0.$$
2. Proves exact real-valuedness of the completed Riemann zeta function on the real line:
   $$\operatorname{Im}(\Lambda(\sigma)) = 0 \quad \text{for all } \sigma \in \mathbb{R}.$$
3. Proves equivalence between vanishing and vanishing real part on the positive real axis:
   $$\zeta(\sigma) = 0 \iff \operatorname{Re}(\zeta(\sigma)) = 0 \quad \text{for all } \sigma > 0.$$
4. Deduces `RightHalfZeroFree` and Mathlib's formal `RiemannHypothesis` from:
   - `UniversalWeilSystem` + `RealAxisNonvanishingSystem` (`RiemannHypothesis_of_weil_and_real`).
   - `UniversalZeroRefutationSystem` + `RealAxisNonvanishingSystem` (`RiemannHypothesis_of_refutation_and_real`).
   - `UniversalFredholmSystem` + `RealAxisNonvanishingSystem` (`RiemannHypothesis_of_fredholm_and_real`).
   These are conditional implications. The module does not construct a `UniversalWeilSystem`, `UniversalZeroRefutationSystem`, `UniversalFredholmSystem`, or `RealAxisNonvanishingSystem` value.

## Background and Mathematical Significance
In previous bridge modules (`ZetaUniversalRHBridge.lean` and `WeilExplicitGrandRHBridge.lean`), the deduction of the Riemann Hypothesis required three premises:
1. Refutation of zeros in the upper half-plane $\operatorname{Im}(s) > 0$.
2. An external reflection structure `sr : ZetaSchwarzReflection` asserting $\zeta(s) = 0 \iff \zeta(\bar{s}) = 0$.
3. Non-vanishing on the real axis $(1/2, 1)$ (`RealAxisNonvanishingSystem`).

With the machine-verified theorem `riemannZeta_zero_iff_conj_zero_of_half_lt_re` from Module 276, the reflection symmetry across the real axis is proved unconditionally from first principles in Mathlib.
Module 277 couples this global reflection theorem with three supplied system records. `UniversalZeroRefutationSystem` and `UniversalFredholmSystem` are scalar evaluation records in their defining modules; this bridge does not construct a Fredholm operator or determinant:
- Any hypothetical zero in the lower half-plane $\operatorname{Im}(s) < 0$ with $\operatorname{Re}(s) > 1/2$ is reflected to an off-line zero candidate with $\operatorname{Im}(\bar{s}) > 0$ and $\operatorname{Re}(\bar{s}) > 1/2$.
- The corresponding supplied system field rules out the reflected upper-half-plane zero.
- Any zero on the real axis is ruled out by the real non-vanishing system.
- Consequently, the open right half-plane $\operatorname{Re}(s) > 1/2$ is zero-free, which by `CriticalTransformRH.noRightZeros_implies_RiemannHypothesis` immediately implies Mathlib's official `RiemannHypothesis`.

## Machine Verification
- **Module:** `formalization/BuildingBlocks/UniversalSchwarzRHBridge.lean`
- **Lean Version:** 4.24.0 (Mathlib v4.24.0)
- **Sorries:** 0
- **Axioms:** `[propext, Classical.choice, Quot.sound]` (100% foundational)
