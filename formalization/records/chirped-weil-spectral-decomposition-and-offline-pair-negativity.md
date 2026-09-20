# Catalog entry 354: conditional scalar spectral-envelope assembly

This page documents `formalization/BuildingBlocks/ChirpedWeilSpectralDecomposition.lean`.

`spectral_upper_bound_of_decomposition` combines four supplied eventual inequalities for arbitrary functions `Q_spec Q_crit Q_cont E_pair : ℝ → ℝ`. `pair_energy_product_eq` is a real-power identity using the project definitions `spanDilation` and `amplifiedOfflineCoeff`.

The larger conclusions retain all analytic premises. In particular, `make_chirped_offline_configuration` and `chirped_offline_zero_refutation` require:

- a supplied `WeilSpectralArithmeticIdentity Q_arith Q_spec`;
- an eventual arithmetic lower budget;
- an eventual scalar decomposition bound;
- eventual critical, continuous, and pair-energy bounds.

`ChirpedZeroCouplingSystem` is the proposition that every hypothetical right-half-plane zero supplies all of those data and bounds. Consequently,

```lean
theorem RiemannHypothesis_of_chirped_system
    (hsys : ChirpedZeroCouplingSystem) : RiemannHypothesis
```

is an implication from an RH-strength system premise, not an unconditional proof of RH.

The module does not construct a Weil test function, Fourier transform, spectral operator, zero sum, or explicit-formula identity. Its verified content is scalar algebra and filter-order bookkeeping once the analytic bounds are assumed. The power manipulations overlap pinned Mathlib declarations such as `Real.rpow_mul` and `Real.rpow_neg_one`; no worldwide priority claim is made.

- **Lean:** 4.24.0
- **Mathlib revision:** `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`
- **Sorries:** 0
- **Reported axioms:** `[propext, Classical.choice, Quot.sound]`
