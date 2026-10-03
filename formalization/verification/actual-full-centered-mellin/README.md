# Actual full centered arithmetic and Mellin verification

This record covers the [native companion](../../BuildingBlocks/ActualFullCenteredMellin.lean) to the [complete exact-log bound](../../../building-blocks/prime-distribution/complete-prime-error-exact-log-vk-bound.md). It verifies actual arithmetic identities and convergence, not the new analytic upper bound or RH.

The module uses Mathlib's actual von Mangoldt function, ordered Dirichlet convolution, real floors and square-root cofactors. Its full numerator includes the explicit density baseline. Its allocation retains every same-prime proper power. `W_eq_fullNumerator_sub_allocation` identifies their difference with `ActualCriticalMellin.W` at every real cutoff.

`hasMellin_N`, `hasMellin_fullNumerator` and `integral_fullNumerator_Ioi_one` have domain Re(s)>1. The corresponding allocation statements have domain Re(s)>1/2. These are actual convergence domains, not assumed analytic estimates. Support and real-valuedness are proved; the Icc identities preserve all positive integer cofactors and zero-weight birth endpoints.

The toolchain is Lean 4.24.0, compiler commit `797c613eb9b6d4ec95db23e3e00af9ac6657f24b`, with Mathlib `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`. Run from the repository root:

```sh
lake build
lake env lean formalization/verification/ActualFullCenteredMellinAudit.lean
```

The producer's targeted check and the root's independent public audit passed. All 24 public theorem rows are exactly `[propext, Classical.choice, Quot.sound]`; there are no custom axioms or placeholders in this companion. The full repository build passed after its umbrella import was added. See [axioms.txt](axioms.txt) and [acceptance.json](acceptance.json) for the source-bound evidence.

The zero-free theorem, uniform zero density, zero-avoiding contour, exact-log saddle expansion and complete upper bound remain independently reviewed written analysis. The same-prime asymptotic and the missing eventual sign remain outside this module. No new RH criterion, unconditional kernel-checked analytic inequality, effective onset, novelty or RH proof is claimed.
