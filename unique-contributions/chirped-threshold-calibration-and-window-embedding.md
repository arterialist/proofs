# Contribution 353: numeric chirp calibration and interval containment

**Module:** [`formalization/BuildingBlocks/ChirpedThresholdCalibration.lean`](../formalization/BuildingBlocks/ChirpedThresholdCalibration.lean)
**Classification:** elementary parameter algebra
**Priority status:** not assessed by an exhaustive literature search

## What Lean proves

The module sets `w = 1`, `x0 = 1 / 2`, `eta = 1 / 4`, and `T(gamma) = 4 * gamma / 3`. It verifies the resulting tuning factor, algebraic derivative cancellation for positive `gamma`, and the curvature value `-1 / 2`.

It also proves that `2 / sqrt T < 1 / 2` when `T > 16`, and that any positive radius below `1 / 2` gives `0 < x0 - delta` and `x0 + delta < w`. Other declarations compare the defined constant `plattTrudgianHeight` with `T(gamma)` and apply logarithm monotonicity.

## Boundary of the result

These are exact identities and interval inequalities. The module does not define a wavepacket integral, prove a stationary-phase estimate, or establish boundary leakage for an analytic test function. The number `plattTrudgianHeight` is a real constant used by the module; this file does not import or verify the underlying zero computation.

Representative declarations are `canonical_stationary_cancellation`, `canonical_radius_lt_half`, `canonical_window_embedding`, and `carrier_gt_plattTrudgianHeight`.

No custom axioms or `sorry` placeholders are used.
