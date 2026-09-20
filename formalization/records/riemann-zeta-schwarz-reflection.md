# Catalog entry 359: Mellin and Gamma conjugation with an abstract zeta-reflection record

This page documents `formalization/BuildingBlocks/RiemannZetaSchwarzReflection.lean`.

The module proves:

- `mellin_integrand_conj`, a pointwise identity for a real-valued kernel;
- `mellin_conj_of_real`, conjugation equivariance of its Mellin integral;
- `Gammaℝ_star`, conjugation equivariance of the real Deligne Gamma factor.

It then defines `ZetaSchwarzReflection`, a structure whose field `star_eq` asserts the desired zeta conjugation identity. The theorem

```lean
theorem zero_iff_star_zero (sr : ZetaSchwarzReflection) (s : ℂ) :
    riemannZeta s = 0 ↔ riemannZeta (star s) = 0
```

is conditional on the supplied record `sr`; this file does not construct that record. The later `RiemannZetaGlobalSchwarzReflection.lean` proves concrete global completed-zeta reflection and right-half-plane zeta reflection.

Pinned Mathlib already provides `Complex.Gamma_conj`; the Mellin composition here is project code. A bounded search of the pinned tree did not find the later project theorem identifiers, but that does not establish worldwide priority.

- **Lean:** 4.24.0
- **Mathlib revision:** `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`
- **Sorries:** 0
- **Reported axioms:** `[propext, Classical.choice, Quot.sound]`
