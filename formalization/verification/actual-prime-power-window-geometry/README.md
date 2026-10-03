# Proper prime-power windows: verification scope

3 October 2026. The [native module](../../BuildingBlocks/ActualPrimePowerWindowGeometry.lean) proves finite geometry for actual proper prime-power rows. Every admitted row has n>=4, its causal window [n-sqrt(n),n] lies inside [1,Y] for every real cutoff admitting n, and its actual prime base/exponent are unique. At a fixed exponent, distinct positive integer bases have strictly separated closed windows; the actual-prime specialization is explicit. Different exponents can overlap: the actual rows eight=2³ and nine=3² both contain seven. No source-norm or analytic estimate premise appears in these targets.

The [public audit](../ActualPrimePowerWindowGeometryAudit.lean) covers all 25 source theorems in order. Exactly 22 rows use `propext`, `Classical.choice`, `Quot.sound`; three pure-natural identities use only `propext`, `Quot.sound`. The [raw output](axioms.txt) and [hash-bound acceptance](acceptance.json) record their exact profiles. No extra choice dependency was inserted into the smaller rows. The current full repository build passed with 8054 jobs, and the public audit passed. Public mathematical bodies/statements match the frozen private producer after the namespace replacement and relocation of inspection commands.

The [full proper-power forcing inequality](../../../building-blocks/prime-distribution/proper-prime-power-forcing-energy-bound.md), with constants 24/3000 and 144/eta, remains an independently checked **written proof**. It also bounds the sum of the absolute values of all rows, so bounded phase multipliers are admissible. The actual staircase trace, interval Cauchy, interval-energy summation, exponent allocation, logarithmic tail integrals and complete energy substitution are not kernel checked by this geometry leaf. The existing actual first/second Mangoldt mass bounds used in that proof have their own native sources.

Reproduce from the repository root with the pinned Lean 4.24.0 / Mathlib setup:

```sh
lake build
lake env lean formalization/verification/ActualPrimePowerWindowGeometryAudit.lean
```

Separate agent contexts reconstructed the full written inequality and its literal parameter/consumer scope; the coordinator also reconstructed it. These are disclosed checks, not a human referee report. The ordinary-prime bracket keeps the full psi history and continuous density and still has no independent critical upper. No stronger complete signed RH bound, novelty, new RH criterion premise or RH result is claimed.
