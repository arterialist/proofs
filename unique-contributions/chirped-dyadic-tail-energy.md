# Contribution 361: finite dyadic envelope sums and their decay

**Module:** [`formalization/BuildingBlocks/ChirpedDyadicTailEnergy.lean`](../formalization/BuildingBlocks/ChirpedDyadicTailEnergy.lean)
**Classification:** finite geometric-sum and real-limit lemmas
**Priority status:** not assessed by an exhaustive literature search

## What Lean proves

The module defines modeled shell width, pointwise decay, zero count, and shell energy expressions. It proves an algebraic product identity, bounds the resulting geometric factors, and sums them over a finite range. It then proves decay of an envelope proportional to `log T / T ^ 3` as `T` tends to infinity.

## Boundary of the result

The names `shellPointwiseDecay` and `shellZeroCount` are definitions. The module does not prove an actual zero-density estimate, show that an actual spectral shell is bounded by `shellEnergyBound`, or pass from finite shells to the full zeta-zero spectrum. `DyadicTailEnergyCertificate` records constants and the modeled formula.

A later analytic application must prove that its spectral terms satisfy these envelopes.

No custom axioms or `sorry` placeholders are used.
