# Full physical history and complex Mellin weights

For continuous compactly supported complex functions, define
\[
M_z(f)=\int_{\mathbb R}f(v)e^{zv}\,dv.
\]
The module [FullComplexHistoryMellin.lean](BuildingBlocks/FullComplexHistoryMellin.lean) proves weighted integrability for every complex z, exact translation, and linearity for finite weighted translates. Its translation identity is
\[
M_z(f(\cdot-d))=e^{zd}M_z(f).
\]
The identity itself uses the total Lebesgue integral convention, while the finite-sum identities supply integrability before exchanging sums and integrals.

For an integer p at least 2 and any natural depth M, the literal physical history is
\[
H_{p,M}f(v)=-p^{-1/2}f(v-\log p)
 +(1-p^{-1})\sum_{0\le m<M}p^{-m/2}f(v+m\log p).
\]
It preserves continuity and compact support. Applying the translation identity to every term proves
\[
M_z(H_{p,M}f)=V_{p,M}(z)M_z(f),\qquad
V_{p,M}(z)=-p^{z-1/2}+(1-p^{-1})\sum_{0\le m<M}p^{-m(z+1/2)}.
\]
No terminal history term is removed. The complex-power dictionary is the previously compiled one in `GrowingPrimeScatteringBounds`.

For the cross weight
\[
W_z(f,g)=M_z(f)\overline{M_{-\bar z}(g)},
\]
real history coefficients give
\[
W_z(H_{p,M}f,H_{p,M}g)
 =V_{p,M}(z)V_{p,M}(-z)W_z(f,g).
\]
This proves the paired multiplier from the actual physical functions, without assuming an operator-to-weight correspondence. Finite lists of histories retain every term of the composition; finite-set exports give the complete product of paired multipliers. The identities require no half-strip or zero-location assumption and work for M equal to zero too.

The last two consumers apply the earlier weighted-sum estimates to these derived physical weights. For an arbitrary index set, they explicitly require absolute summability of the original weights and the closed-half-strip condition on the complex parameters. The finer comparison additionally requires an interior gap on a chosen low subset and a lower bound P greater than 1 for every history index. With
\[
B=e^{-M\delta\log P}\frac{1+\delta\log P}{\delta\log P},
\]
the difference between the full transformed and original sums is bounded by
\[
\bigl(e^{|s|(2B+B^2)}-1\bigr)\sum_{i\in\mathrm{low}}|W_{z_i}(f,g)|
 +(3^{|s|}+1)\sum_{i\notin\mathrm{low}}|W_{z_i}(f,g)|.
\]
Both sums retain their complete index sets. These are conditional analytic comparisons, not a proof that actual zeta-zero weights satisfy the premises. Multiplicities, zero counting and decay, explicit-formula limits, gamma and pole terms, and the original signed arithmetic readout remain further obligations. No RH conclusion follows.

The signed scattering research branch supplied the 17 declarations. Root independently reviewed the physical translation signs, complex conjugation, finite compositions and exact hypotheses of the infinite-sum consumers. These are classical Mellin identities and a formalized connection to the repository's complete-history estimates; no novelty claim is made.

All 17 printed declarations independently compile with only `propext`, `Classical.choice` and `Quot.sound`, with no warnings in this module. The combined `BuildingBlocks` library also builds successfully.
