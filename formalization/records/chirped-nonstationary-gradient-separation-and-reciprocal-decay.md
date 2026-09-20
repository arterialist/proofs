# Catalog entry 355: quadratic-phase derivative separation

This page documents `formalization/BuildingBlocks/ChirpedNonstationaryGradientSeparation.lean`.

The module defines the scalar quadratic phase

$$Φ(x)=x(T-γ)-x^2(ηT)$$

and proves its derivative formula and elementary endpoint bounds. Its main result says that if `γ` lies at least `Δ > 0` outside the interval `[T(1 - 2ηw), T]`, then

```lean
Δ ≤ |chirpedPhaseDeriv T eta gamma x|
```

for `x ∈ [0,w]`. The theorem named `reciprocal_square_gradient_le` concludes

```lean
Δ^2 ≤ (chirpedPhaseDeriv T eta gamma x)^2 ∧
0 < (chirpedPhaseDeriv T eta gamma x)^2
```

Despite its compatibility name, it contains no reciprocal and proves no decay estimate. The file has no oscillatory integral, cutoff, integration-by-parts operator, or `O(Δ⁻ᴺ)` theorem. It formalizes the algebraic gradient-separation premise used by such arguments.

This narrow quadratic-phase lemma may be a project-specific formulation, but the bounded audit did not establish worldwide priority.

- **Lean:** 4.24.0
- **Mathlib revision:** `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`
- **Sorries:** 0
- **Reported axioms:** `[propext, Classical.choice, Quot.sound]`
