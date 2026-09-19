# Contribution 359: conditional combination of three spectral bands

**Module:** [`formalization/BuildingBlocks/ChirpedTriPartitionSpectralBound.lean`](../formalization/BuildingBlocks/ChirpedTriPartitionSpectralBound.lean)
**Classification:** set partition algebra and a conditional bound
**Priority status:** not assessed by an exhaustive literature search

## What Lean proves

The module defines low, resonant, and high frequency predicates and proves their elementary coverage and disjointness properties. It also proves phase-gradient separation statements.

`tri_partition_spectral_upper_bound` combines four supplied facts: a decomposition of a scalar spectral quantity, a critical-band bound, a nonresonant bound, and a pair contribution bound. `tri_partition_coercive_refutation` adds a supplied arithmetic lower bound, equality of the arithmetic and spectral quantities, and a power-domination inequality.

## Boundary of the result

The module does not form the spectral sums or prove any component analytic estimate. `TriPartitionCertificate` stores constants; it is not a certificate that a zeta spectral decomposition satisfies the hypotheses. The RH theorem accepts a hypothesis that directly refutes every candidate right-half-plane zero.

No custom axioms or `sorry` placeholders are used.
