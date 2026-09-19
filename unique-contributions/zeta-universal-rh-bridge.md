# RH from a supplied universal evaluator, reflection, and real-axis nonvanishing

**Classification:** conditional logical assembly

**Lean module:** [`ZetaUniversalRHBridge.lean`](../formalization/BuildingBlocks/ZetaUniversalRHBridge.lean)

This module performs trichotomy on the imaginary part of a putative right-half-plane zero. Its four theorems combine three supplied components:

- a `UniversalZeroRefutationSystem` or `UniversalFredholmSystem`;
- a `ZetaSchwarzReflection` package;
- a `RealAxisNonvanishingSystem` package.

The real branch uses the last package, the negative-imaginary branch uses reflection, and the positive-imaginary branch calls the supplied universal evaluator. The resulting statements have the form

```lean
UniversalZeroRefutationSystem ->
ZetaSchwarzReflection ->
RealAxisNonvanishingSystem ->
RiemannHypothesis
```

and the analogous form with `UniversalFredholmSystem`.

The bridge is machine-checked, but it does not construct the decisive universal system. Carrier tuning only makes an assumed power-versus-logarithm contradiction occur at a chosen scale. It does not prove that a zeta zero supplies the arithmetic and spectral inequalities stored in the evaluator. The Fredholm branch also uses the scalar object described in [the universal scalar balance page](chirped-universal-fredholm-exclusion.md), not a constructed operator determinant.

This bookkeeping theorem identifies the exact interface an analytic proof would need to implement. It does not establish unconditional zero-freeness or RH.
