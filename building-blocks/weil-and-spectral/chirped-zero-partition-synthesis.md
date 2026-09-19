# Combining supplied low- and high-frequency zero-free certificates

**Taxonomy:** building block. The Lean declarations cover only the scalar, algebraic, numerical, or conditional interface stated below; they do not construct the advertised analytic operator or prove an unconditional RH consequence.
**Classification:** classical case split plus certificate packaging

**Lean module:** [`ChirpedZeroPartitionSynthesis.lean`](../../formalization/BuildingBlocks/ChirpedZeroPartitionSynthesis.lean)

The main theorem is a direct partition: if `LowFrequencyZeroFree H` and `HighFrequencyZeroFree H` both hold, then the right half-plane is zero-free, hence RH follows through the imported symmetry equivalence.

The file defines the numerical value $3\cdot10^{12}$ and proves elementary positivity facts about it. It does not formalize or import the Platt-Trudgian computation as a theorem. A `ZeroPartitionCertificate` stores the low- and high-frequency results as fields.

This is useful proof plumbing. The RH implication remains conditional on both certificates, especially the unconstructed high-frequency evaluator in the chirped chain.
