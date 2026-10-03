# Actual prime-error causal trace: verification scope

3 October 2026. The [native module](../../BuildingBlocks/ActualPrimeErrorCausalTrace.lean) proves the literal local trace of the actual von Mangoldt staircase. For every natural n>=4, every real c and every real sigma>=1/2, it bounds |[psi(n-1)-n+c]/n| by n^(sigma-3/4) times the square root of its actual causal weighted energy on [n-sqrt(n),n], plus n^(-1/2)(1+logn). Every earlier actual prime power remains in psi. No caller continuity, integrability, atom/trace estimate, evaluator, energy upper, PNT, zero-free input or RH premise appears in the two final targets.

The source internally proves actual increments and center cancellation before division, pays the closed right endpoint by its exact -Lambda(n) difference, and proves square/weighted integrability from the bounded actual floor staircase. Its interval Cauchy proof and real-power identities give the exact coefficients. The generic Cauchy helper has integrability hypotheses; both actual targets discharge them internally. The interval contains positive times, including the first proper-power window [2,4].

The [public audit](../ActualPrimeErrorCausalTraceAudit.lean) covers all16 source theorems in order. Every row uses exactly `propext`, `Classical.choice`, `Quot.sound`. The [raw output](axioms.txt) and [hash-bound acceptance](acceptance.json) record their profiles and the pinned configuration. The current full repository build passed with8056 jobs. Public definitions, statements and proof bodies match the frozen private producer after only namespace/comment changes and moving the inspection commands.

The [proper-power forcing theorem](../../../building-blocks/prime-distribution/proper-prime-power-forcing-energy-bound.md) uses this local trace and the separately checked [finite geometry](../actual-prime-power-window-geometry/README.md). Allocation over all actual prime rows/degrees, the full24/3000 bound, finite logarithmic tails and Young absorption are kernel checked in the separate [forcing companion](../actual-proper-prime-power-forcing/README.md). The complete work balance and energy substitution remain written. This leaf proves no ordinary-prime signed upper, stronger complete RH estimate, new criterion premise or RH. No priority claim is made.

Reproduce from the repository root with the pinned Lean4.24.0 / Mathlib setup:

```sh
lake build
lake env lean formalization/verification/ActualPrimeErrorCausalTraceAudit.lean
```

Separate GPT-6.1 Sol/xhigh contexts checked the whole actual target, proof and saved evidence; the coordinator reconstructed the argument and checked the public build/audit. These are disclosed independent agent checks, not a human referee report.
