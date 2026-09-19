# RH-equivalent support predicates and a conditional trace-system bridge

**Classification:** classical reformulation plus conditional bridge

**Lean module:** [`ChirpedSpectralSupportConfinement.lean`](../formalization/BuildingBlocks/ChirpedSpectralSupportConfinement.lean)

The module defines the set of nontrivial zeta zeros, the critical line, and the right and left off-line subsets. The equivalence

$$
\text{SpectralSupportConfinement}\iff\text{RiemannHypothesis}
$$

is a direct restatement of RH in set language. The analogous equivalence with `RightHalfZeroFree` uses the functional-equation bridge imported from the surrounding development.

The substantive-looking consequences all take a `WeilTraceSystem`. That structure contains a low-frequency zero-free certificate and an evaluator assigning a contradictory `WeilWavepacketEvaluation` to every relevant high-frequency off-line candidate. Given those fields, support emptiness, zero spectral distance, and RH follow logically.

The file does not construct a spectral operator or its support, and it does not build a `WeilTraceSystem`. Its "spectral support" is the set of zeta zeros by definition. The accurate result is therefore an RH-equivalent set reformulation and a conditional reduction from a supplied evaluator.
