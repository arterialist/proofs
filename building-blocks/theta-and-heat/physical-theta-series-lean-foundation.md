# Literal physical theta series: convergence and positive half-line

The actual normalization in [the theta jump-form chapter](theta-weil-jump-form.md) is
\[
\Phi(u)=\sum_{n\ge1}
(4\pi^2n^4e^{9u/2}-6\pi n^2e^{5u/2})e^{-\pi n^2e^{2u}}.
\]
[PhysicalThetaSeries.lean](../../formalization/BuildingBlocks/PhysicalThetaSeries.lean) now defines this literal real-variable series. Its initial natural-number index includes zero, whose term is proved zero; `phi_eq_positive_index` gives the exact reindexing to the displayed positive indices. No replacement of \(u\) by \(|u|\) is made.

For every fixed real \(u\), put \(c=\pi e^{2u}>0\). The formal majorant is
\[
|\Phi_n(u)|\le
(4\pi^2e^{9u/2}+6\pi e^{5u/2})n^4e^{-cn}.
\]
It follows from \(n^2\ge n\), \(n^4\ge n^2\), the triangle inequality, and monotonicity of the exponential. Mathlib's polynomial–exponential summability theorem then proves absolute summability of the actual terms on the entire real line, without a zero-free or PNT input.

For \(u\ge0\) and \(n\ge1\), the exact factorization is
\[
\Phi_n(u)=2\pi n^2e^{5u/2}
(2\pi n^2e^{2u}-3)e^{-\pi n^2e^{2u}}>0.
\]
Here \(n^2\ge1\), \(e^{2u}\ge1\), and \(\pi>3\). Every positive-index term is strictly positive. Absolute summability and the first term prove \(\Phi(u)>0\) for \(u\ge0\).

The batch proves pointwise convergence and positivity on the stated half-line. It does not yet prove theta parity, continuity or derivative regularity, the Fourier–xi identity, full-line positivity, exponential moment integrability, the actual killed operator or its ground equation. In particular, it does not silently redefine a positive even surrogate as the actual kernel. These are foundational definitions and alternate elementary convergence proofs supporting the remaining actual weak-ground identification; they give no arithmetic covariance estimate or RH proof.

Agent2 supplied the literal series and nine convergence/positivity declarations. RH Proof independently checked its normalization and proof hypotheses, and added continuity of each summand and measurability of the full actual series via finite partial sums. These eleven printed declarations compile with only `propext`, `Classical.choice`, and `Quot.sound`. Measurability does not assert continuity of the infinite sum.

The [local-interchange sequel](physical-theta-local-derivative-interchange.md) now additionally proves continuity of this literal series on the full real line, after justified differentiation of the actual Gaussian seed sum. Parity, moment integrability and the actual killed ground remain unfinished.
