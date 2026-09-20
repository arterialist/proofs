# Catalog entry 360: conditional real-axis zeta nonvanishing from eta data

This page documents `formalization/BuildingBlocks/RiemannZetaRealNonvanishing.lean`.

The module proves scalar positivity of paired real powers and negativity of the multiplier `1 - 2^(1-σ)`. It does not construct the alternating Dirichlet eta series or prove its relation to `riemannZeta`.

Instead, `DirichletEtaIdentity σ` stores as fields a positive real `eta_val`, the relation

```lean
(1 - 2^(1 - σ)) * (riemannZeta (σ : ℂ)).re = eta_val
```

and the assertion that the zeta value has zero imaginary part. `riemannZeta_re_neg_of_eta` and `riemannZeta_ne_zero_of_eta` require a value of this structure. `RealAxisNonvanishingSystem` requires such an identity for every `σ ∈ (1/2,1)`, and the final theorem has the exact premise:

```lean
theorem real_axis_zeta_ne_zero
    (sys : RealAxisNonvanishingSystem) (s : ℂ)
    (hsr : 1 / 2 < s.re) (hsim : s.im = 0) (hs1 : s ≠ 1) :
    riemannZeta s ≠ 0
```

Thus this module is a conditional packaging of the eta argument. It does not by itself prove real-axis nonvanishing on `(1/2,1)`.

- **Lean:** 4.24.0
- **Mathlib revision:** `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`
- **Sorries:** 0
- **Reported axioms:** `[propext, Classical.choice, Quot.sound]`
