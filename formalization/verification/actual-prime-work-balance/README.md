# Actual prime work balance: verification scope

3 October 2026. The [native module](../../BuildingBlocks/ActualPrimeWorkBalance.lean) proves the complete continuous predictable-work identity, exact ordinary-prime/proper-power splitting and the absorbed ordinary-prime energy inequality. The field is e(t)=psi(floor(t))-t+c, with c held fixed throughout each history and all actual Mangoldt births retained.

For EVERY real c and sigma and EVERY real Y>=1, the exact identity is H+sigma E=(c-1)²/2+A+J/2. H is the inclusive real terminal Y^(-2sigma)e(Y)²/2; E is the full integral [(psi(floor(t))-t+c)/t]²t^(1-2sigma) from one through Y; A is the sum of ALL Lambda(n)n^(-2sigma)[psi(n-1)-n+c] through floor(Y), minus the full density integral e(t)t^(-2sigma); J is the complete Lambda-square diagonal. The requested sigma>=1/2 specialization has its own literal target.

U is defined independently by filtering that integer atom sum through Nat.Prime, with the SAME full density integral and full psi inner history. It is not defined by A minus a remainder. Actual Lambda support, degree-one separation, unique complete finite prime-power row enumeration and positive-base normalization internally prove A-U=the existing complete proper-power force. No composite with two distinct prime factors contributes an unsupported Mangoldt row.

For EVERY real fixed c, EVERY sigma>=1/2, EVERY real Y>=1 and EVERY eta>0, the literal final consumer proves H+(sigma-eta)E<=(c-1)²/2+U+(3000+144/eta)log²(2Y)+J/2. Choosing eta=1/4 leaves a coefficient at least1/4. A nonpositive sigma-eta is still an admitted inequality but supplies no positive energy upper by itself. The canonical c=1+gamma head is gamma²/2 by substitution. No independent upper on U is supplied.

Zero and unit heads, actual psi-square telescoping, the exact jump2Lambda(n)psi(n-1)+Lambda(n)², positive-interval power derivatives, finite real-endpoint Abel summation, FTC, all separate integrabilities and normalized energy conversion are proved internally. The generic Abel helper has local regularity hypotheses; actual final calls discharge them. At a terminal integer storage is inclusive while the atom is predictable, with a POSITIVE half-diagonal. Fractional cutoffs retain the full last interval. There is no caller jump/support/enumerator/evaluator/integrability/energy/norm/tail/zero-free or RH premise in the final actual targets.

The source has two namespaces: ActualContinuousWorkBalance (23 audited declarations) and ActualOrdinaryPrimeWorkConsumer (16). The [audit](../ActualPrimeWorkBalanceAudit.lean) prints all 39 in source order and displays eight final targets. The prime Lambda=log(p) and positive-base power dictionary is composed internally, so a final literal target uses exactly the log-prime force displayed in (5). Every row uses exactly `propext`, `Classical.choice`, `Quot.sound`. The [raw output](axioms.txt) and [acceptance record](acceptance.json) bind the source, pinned configuration and successful verification. The fresh full repository build passed with 8057 jobs. Nine cosmetic lint warnings in the original unchanged balance block are retained in its saved producer evidence; they do not introduce any proof premise or axiom. Public mathematical statements and proof bodies match the independently frozen private assembly after namespace/comment changes and moving inspections.

This closes native coverage of the existing finite balance and [absorbed inequality (5)](../../../building-blocks/prime-distribution/proper-prime-power-forcing-energy-bound.md). It does not strengthen the arithmetic bound or supply the missing signed ordinary-prime estimate. The fixed-strict-sigma infinite-tail refinement and bounded complex phase extension remain written. A stronger complete prime-error/coarse/W premise and RH remain unproved. These are disclosed independent GPT-6.1 Sol/xhigh checks, not a human referee report or a priority claim.

Reproduce from the repository root with the pinned Lean4.24.0 / Mathlib setup:

```sh
lake build
lake env lean formalization/verification/ActualPrimeWorkBalanceAudit.lean
```
