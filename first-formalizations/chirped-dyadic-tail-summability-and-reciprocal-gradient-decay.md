# Catalog entry 356: finite dyadic scalar-tail bounds

This page documents `formalization/BuildingBlocks/ChirpedDyadicTailSummability.lean`.

The module proves finite geometric-sum estimates, defines scalar dyadic radii and weights, verifies the algebraic identity

$$(C_{\rm dens} 2^{k+1}Δ_0)(2^kΔ_0)^{-2}
= \frac{2C_{\rm dens}}{Δ_0}(1/2)^k,$$

and bounds the corresponding finite sum by `dyadicTailCoeff C_dens Δ0 * Real.log T`. `makeDyadicTailSumCertificate` packages these scalar facts.

The file does not define zeta zeros, a zero-counting function, a Riemann–von Mangoldt estimate, or a sum indexed by zeros. Its `C_dens` is a free positive real parameter, so the theorem is bookkeeping for a later application rather than a verified zero-density theorem or reciprocal-gradient decay theorem.

Pinned Mathlib already supplies general geometric-sum results, including `geom_sum_of_lt_one`, `geom_sum_lt`, and `geom_sum_Ico_le_of_lt_one` in `Mathlib/Algebra/Order/Field/GeomSum.lean`. This module specializes related algebra to the project's dyadic coefficient. A bounded source search therefore establishes overlap with Mathlib, not firstness.

- **Lean:** 4.24.0
- **Mathlib revision:** `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`
- **Sorries:** 0
- **Reported axioms:** `[propext, Classical.choice, Quot.sound]`
