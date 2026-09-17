# Finite paired scattering and the uniform half-strip bound

[PairedScatteringDefect.lean](../../formalization/BuildingBlocks/PairedScatteringDefect.lean)
formalizes the literal finite local history polynomial with actual
parameters r=1/sqrt(p), L=log p and phase exp(zL). It proves the paired
identity including endpoint M, evaluates the literal exponential defect
moment, and bounds that moment by 2. Complex exponential norms and cosh
monotonicity give the paired multiplier bound 3 throughout |Re z|<=1/2,
for every integer p>=2 and every finite history depth. All parameter
hypotheses in the square-root/log specialization are proved. No rational
denominator nonvanishing or critical-line zero premise is assumed.

The module was implemented by the paired-defect mathematics worker and
independently reviewed and compiled by RH Proof. Its axiom checks use
only propext, Classical.choice and Quot.sound. The [uniform paired
transport repair](../analytic-methods/paired-multiplier-uniform-strip-repair.md) uses this
finite algebra in written complete-zero estimates. Those zero counts,
zero-free regions, archimedean comparisons and support costs remain
analytic formalization obligations. No novelty or RH claim is made.

The [actual block sign change](../prime-history/actual-paired-history-block-sign-change.md)
explains why the positive single-place defect does not sign the complete
block correction. A sign or upper bound for the full original arithmetic
readout remains unproved.
