# Catalog entry 358: finite complex norm-square positivity

This page documents `formalization/BuildingBlocks/AutocorrelationFourierPositivity.lean`.

The module proves pointwise complex-exponential conjugation identities and the scalar identity

```lean
F * star F = (Complex.normSq F : ℝ)
```

with its real-part nonnegativity. `critical_zero_energy_nonneg` is the same fact for an arbitrary input `u_hat : ℂ`; it has no hypothesis that `u_hat` is a Fourier transform or is evaluated at a zeta zero. `critical_spectral_sum_nonneg` sums this norm-square inequality over an arbitrary finite index set.

The other advertised bridge is also scalar:

- `offline_pair_negativity_form` bounds `4*M + 2*M/r - 2*b*r` using `1 ≤ r` and `0 ≤ M`.
- `spectral_decomposition_with_offline_pair` proves an expression is at most itself by `le_rfl`.

No autocorrelation integral, Fourier-transform theorem, Wiener–Khinchin theorem, Weil explicit formula, zero set, or spectral operator appears in the declarations. The compatibility names describe an intended interpretation, while the checked content is finite complex and real algebra. Worldwide priority is not asserted.

- **Lean:** 4.24.0
- **Mathlib revision:** `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`
- **Sorries:** 0
- **Reported axioms:** `[propext, Classical.choice, Quot.sound]`
