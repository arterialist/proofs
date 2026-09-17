# Physical correlations, Mellin order and complete arithmetic cutoff

The module [PhysicalScatteringCorrelation.lean](../../formalization/BuildingBlocks/PhysicalScatteringCorrelation.lean) uses the literal cross correlation
\[
R(f,g)(x)=\int_{\mathbb R}g(v+x)\overline{f(v)}\,dv.
\]
It proves translation with the exact argument x+a-b, integrability of each continuous correlation kernel when f has compact support, and the full joint finite-translate identity
\[
R\!\left(\sum_i c_i f(\cdot-a_i),\sum_j e_j g(\cdot-b_j)\right)(x)
 =\sum_j\sum_i e_j\bar c_i R(f,g)(x+a_i-b_j).
\]
Each kernel's integrability is supplied before the integral is split into the joint finite sum. It also proves the exact reflection identity
\[
\overline{R(g,f)(x)}=R(f,g)(-x).
\]

For continuous compactly supported f and g, the weighted correlation is integrable for every complex z. The proof writes it as a convolution of two integrable functions,
\[
e^{zx}R(f,g)(x)=(F_z*G_z)(x),\quad
F_z(v)=\overline{f(-v)}e^{zv},\quad G_z(v)=g(v)e^{zv}.
\]
The convolution integral theorem and the exact reflected conjugation then give
\[
M_z(R(f,g))=M_z(g)\overline{M_{-\bar z}(f)}=W_z(g,f).
\]
The order g,f is part of the proved identity. Combining it with the complete physical history theorem gives
\[
M_z\bigl(R(H_{s,M}f,H_{s,M}g)\bigr)
 =\left(\prod_{p\in s}V_{p,M}(z)V_{p,M}(-z)\right)W_z(g,f).
\]
Here H is the literal finite composition from `FullComplexHistoryMellin`, retaining the forward term and every backward history term. The identity is valid for arbitrary complex z, every natural depth M, and finite sets of integers p at least 2. No zero-location premise enters these transform identities. On the imaginary axis, the autocorrelation weight is the ordinary squared modulus. This observation alone does not control weights away from that axis or sign the arithmetic readout.

The actual arithmetic cutoff is defined by
\[
A_N(f,g)=\sum_{2\le n\le N}\frac{\Lambda(n)}{\sqrt n}
 \left[R(f,g)(\log n)+\overline{R(g,f)(\log n)}\right].
\]
The module proves its exact joint finite-translate expansion in both orientations, and proves Lambda(p^m)=log p for every prime p and exponent m at least 1. The cutoff contains all prime powers. The history indices and observing indices are separate; translating functions does not replace the von Mangoldt weights by the history multipliers. The finite cutoff is retained explicitly. Infinite arithmetic convergence, compact support bounds for the expanded correlation, zeta-zero multiplicities and decay, gamma and pole terms, and the complete explicit-formula identity remain further obligations. No RH conclusion or new arithmetic sign estimate follows.

The signed scattering research branch supplied five declarations for correlations, the arithmetic cutoff and prime-power weights. Root independently reviewed them and supplied five further declarations for reflected conjugation, the weighted convolution, weighted integrability, the complex Mellin transform and its finite-history consumer. The methods are classical translation and convolution identities; no novelty claim is made.

All ten printed declarations compile with only `propext`, `Classical.choice` and `Quot.sound`, with no warnings in this module. The combined `BuildingBlocks` library also builds successfully.

[Complete arithmetic correlation support](complete-arithmetic-correlation-support.md) compiles automatic absolute convergence and a stable cutoff for the full prime-power correlation row from literal compact supports. It includes the full joint finite-translate row and common-cutoff consumers for actual physical histories. The complete explicit formula and signed arithmetic estimate remain unfinished.
