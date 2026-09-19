# Contradiction from a canonical evaluation package

**Taxonomy:** building block. The Lean declarations cover only the scalar, algebraic, numerical, or conditional interface stated below; they do not construct the advertised analytic operator or prove an unconditional RH consequence.
**Classification:** conditional scalar certificate

**Lean module:** [`ChirpedCanonicalWavepacketAdmissibility.lean`](../../formalization/BuildingBlocks/ChirpedCanonicalWavepacketAdmissibility.lean)

The module defines a positive parameter record, proves positivity of a chosen coupling and margin, and introduces `CanonicalEvaluationSystem`. That system stores the decisive arithmetic lower bound, spectral upper bound, and exact equality for arbitrary real functions. Lean converts it to the earlier linear bridge and derives a contradiction.

The high-frequency and RH theorems require a witness producing `CanonicalEvaluationSystem` for every candidate zero, plus a low-frequency certificate. The module does not construct this witness from a canonical wavepacket or verify the actual Weil explicit formula estimates. Its checked result is the incompatibility of the packaged assumptions.
