# Contribution 356: quadratic phase bands and a pointwise kernel bound

**Module:** [`formalization/BuildingBlocks/ChirpedPhaseBandLocalization.lean`](../formalization/BuildingBlocks/ChirpedPhaseBandLocalization.lean)
**Classification:** elementary phase calculus under explicit hypotheses
**Priority status:** not assessed by an exhaustive literature search

## What Lean proves

The module defines a quadratic real phase and its first two derivatives. It calculates the stationary point, characterizes when it lies in a chosen interval, and proves lower bounds for the absolute phase derivative in low and high frequency regimes.

`ibp_integrand_pointwise_bound` is a pointwise real inequality. It assumes bounds on the amplitude, its derivative, the chirp parameter, and the phase derivative. Under those hypotheses it bounds a modeled kernel by `ibpKernelBound`.

## Boundary of the result

No oscillatory integral is defined or evaluated. The pointwise theorem is not an integration-by-parts identity, a spectral localization theorem, or a bound on an actual zeta wavepacket. The certificate builder records numeric band parameters and elementary consequences.

Representative declarations are `stationaryPoint_deriv_zero`, `canonical_resonant_band_iff`, and `ibp_integrand_pointwise_bound`.

No custom axioms or `sorry` placeholders are used.
