# Combining supplied low- and high-frequency zero-free certificates

**Classification:** classical case split plus certificate packaging

**Lean module:** [`ChirpedZeroPartitionSynthesis.lean`](../formalization/BuildingBlocks/ChirpedZeroPartitionSynthesis.lean)

The main theorem is a direct partition: if `LowFrequencyZeroFree H` and `HighFrequencyZeroFree H` both hold, then the right half-plane is zero-free, hence RH follows through the imported symmetry equivalence.

The file defines the numerical value $3\cdot10^{12}$ and proves elementary positivity facts about it. It does not formalize or import the Platt-Trudgian computation as a theorem. A `ZeroPartitionCertificate` stores the low- and high-frequency results as fields.

This is useful proof plumbing. The RH implication remains conditional on both certificates, especially the unconstructed high-frequency evaluator in the chirped chain.
