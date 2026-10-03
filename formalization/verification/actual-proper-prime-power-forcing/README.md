# Actual proper-prime-power forcing: verification scope

3 October 2026. The [native module](../../BuildingBlocks/ActualProperPrimePowerForcing.lean) proves the full actual proper-power forcing inequality and its absolute-row and Young forms. For EVERY real fixed center c, EVERY real sigma>=1/2 and EVERY real Y>=1, the sum of the absolute values of all proper-power force rows is at most 24log(2Y)sqrt(E)+3000log²(2Y). For EVERY real eta>0 it is at most eta E+(3000+144/eta)log²(2Y). The signed force obeys both bounds. E is the literal full integral of [(psi(floor(t))-t+c)/t]²t^(1-2sigma) from one through Y; the force samples [psi(p^k-1)-p^k+c]/p^k before every actual birth. All earlier actual prime powers remain in psi.

The final literal targets assume only those domain conditions. Actual row completeness, base/degree ceilings, real-cutoff equivalence, square and weighted integrability, nonnegative full energy, fixed-degree interval allocation, finite Cauchy, the 24log(2Y) coefficient, complete finite remainder, signed triangle inequality and Young absorption are proved internally. No row evaluator, supplied tail/remainder bound, integrability premise, energy upper, PNT, zero-free estimate or RH premise appears. Empty cutoffs before four, Y=1, fractional cutoffs, the first window [2,4] and the inclusive/prebirth distinction are covered by native proofs.

The module contains three namespaces: ActualProperPowerEnergyAllocation (37 audited declarations), ActualLogarithmicTailBounds (18), and ActualProperPrimePowerForcing (32). The [public audit](../ActualProperPrimePowerForcingAudit.lean) covers all 87 in source order and displays the eight final targets. Exactly 85 rows use `propext`, `Classical.choice`, `Quot.sound`; `base_le_power` uses `propext`, `Quot.sound` and `exponent_le_power` uses only `propext`. No artificial dependency was imposed. The [raw output](axioms.txt) and [hash-bound acceptance](acceptance.json) record the profiles and pinned configuration. The current full repository build passed with 8057 jobs. Public statements and proof bodies match the independently frozen private assembly after namespace/comment changes and moving inspection commands.

The finite proof uses the existing actual factorial/Chebyshev and harmonic Mangoldt masses. A deliberately conservative full-cutoff mass majorant gives the same 24log(2Y) coefficient and a square-grade remainder35log²(2Y). Complete higher-degree geometric sums and the finite 6/26 logarithmic-tail bounds give648<=2592log²(2Y), hence2627log²(2Y)<=3000log²(2Y). The finite tails use explicit antiderivatives and retain the terminal inequalities. No infinite-series or improper-integral evaluation premise is supplied by the caller.

This closes kernel coverage of the [existing written inequality](../../../building-blocks/prime-distribution/proper-prime-power-forcing-energy-bound.md); it does not strengthen its constants or prove a new arithmetic upper. The exact predictable-work balance, literal prime/proper split and energy substitution are now kernel checked in the [work companion](../actual-prime-work-balance/README.md). The older fixed-strict-sigma cutoff-independent refinement and the bounded complex phase extension remain written. The ordinary-prime bracket retains full psi history and continuous density. Its independent signed upper, a stronger complete prime-error/coarse/W premise and RH remain unproved. This is supporting formalization, not RH-frontier progress or a priority claim.

Reproduce from the repository root using the pinned Lean4.24.0 / Mathlib setup:

```sh
lake build
lake env lean formalization/verification/ActualProperPrimePowerForcingAudit.lean
```

Separate GPT-6.1 Sol/xhigh contexts reconstructed the proof and checked the frozen complete scope and evidence; the coordinator independently reconstructed the argument and checked the public build/audit. These are disclosed independent agent checks, not a human referee report.
