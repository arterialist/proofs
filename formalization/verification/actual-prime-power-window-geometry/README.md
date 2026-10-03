# Proper prime-power windows: verification scope

3 October 2026. The [native module](../../BuildingBlocks/ActualPrimePowerWindowGeometry.lean) proves finite geometry for actual proper prime-power rows. Every admitted row has n>=4, its causal window [n-sqrt(n),n] lies inside [1,Y] for every real cutoff admitting n, and its actual prime base/exponent are unique. At a fixed exponent, distinct positive integer bases have strictly separated closed windows; the actual-prime specialization is explicit. Different exponents can overlap: the actual rows eight=2³ and nine=3² both contain seven. No source-norm or analytic estimate premise appears in these targets.

The [public audit](../ActualPrimePowerWindowGeometryAudit.lean) covers all 25 source theorems in order. Exactly 22 rows use `propext`, `Classical.choice`, `Quot.sound`; three pure-natural identities use only `propext`, `Quot.sound`. The [raw output](axioms.txt) and [hash-bound acceptance](acceptance.json) record their exact profiles. No extra choice dependency was inserted into the smaller rows. The current full repository build passed with 8057 jobs, and the public audit passed. Public mathematical bodies/statements match the frozen private producer after the namespace replacement and relocation of inspection commands.

The [full proper-power forcing inequality](../../../building-blocks/prime-distribution/proper-prime-power-forcing-energy-bound.md), with constants 24/3000 and 144/eta, is now kernel checked by the separate [forcing companion](../actual-proper-prime-power-forcing/README.md). It covers complete finite energy allocation, all degrees, logarithmic tails, signed and absolute-row bounds, and Young absorption. The actual staircase trace and interval Cauchy have their own [causal-trace companion](../actual-prime-error-causal-trace/README.md). The complete work balance, literal prime/proper split and energy substitution are now kernel checked in the [work companion](../actual-prime-work-balance/README.md); this geometry leaf still covers only its25 finite geometry rows. Bounded complex phase multipliers are a written consequence of the absolute-row bound.

Reproduce from the repository root with the pinned Lean 4.24.0 / Mathlib setup:

```sh
lake build
lake env lean formalization/verification/ActualPrimePowerWindowGeometryAudit.lean
```

Separate agent contexts reconstructed the full written inequality and its literal parameter/consumer scope; the coordinator also reconstructed it. These are disclosed checks, not a human referee report. The ordinary-prime bracket keeps the full psi history and continuous density and still has no independent critical upper. No stronger complete signed RH bound, novelty, new RH criterion premise or RH result is claimed.
