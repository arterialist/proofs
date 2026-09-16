# Reflection test for the five even radius-two core hats

Use the sixteen cell indices of the
[geometry ledger](radius-two-first-edge-cell-geometry.md). Reflection
\((u,v)\mapsto(-u,-v)\) changes the orientation and maps their indices
in eight pairs:

\[
 (0,7),\ (1,6),\ (2,5),\ (3,4),\
 (8,11),\ (9,10),\ (12,15),\ (13,14).                 \tag{1}
\]

The unit start-cell endpoints only affect null sets. The radius-two
ground \(\psi_2\), \(\Phi\), \(b\), \(\rho\), the complete departure rate
\(\ell\), and the canonical vertex cutoff \(E_4\) are even. Thus the
full \(\mathsf P_1\) density in the
[reversal audit](radius-two-edge-reversal-rank.md), including the
proper-power \(q=4\) term and every power inside \(\ell\), is
reflection-invariant. Paired cells have equal masses.

Let \(F_j=\mathcal S_2h_j\) for the five published even hats
\(h_0,\ldots,h_4\). The continuous crossing kernel depends on
\(|u-v|\); the complete prime crossing sum contains both orientations.
Reflection of the core integration variable therefore gives
\(B_2h_j(-u)=B_2h_j(u)\). Its common affine subtraction is a scalar,
and \(\rho\) is even, so \(F_j(-u)=F_j(u)\). Under reflection,

\[
 F_j(-v)-F_j(-u)=F_j(v)-F_j(u).                          \tag{2}
\]

Consequently the eight pairs in (1) have *equal* action masses and
observed action coordinates \(T_{i,j}=T_{i',j}\); no sign is inserted by
reflection. In raw rows \(r_i(F_j)=\sqrt{2m_i}\,T_{i,j}\), these are the
eight reflection equalities. Combining them with the six reversal
relations gives the exact action pattern

\[
\begin{array}{c|rrrrrrrrrrrrrrrr}
i&0&1&2&3&4&5&6&7&8&9&10&11&12&13&14&15\\ \hline
r_i(F_j)&A&B&C&-A-B-C&-A-B-C&C&B&A&D&-D&-D&D&E&-E&-E&E .
\end{array}                                                   \tag{3}
\]

Here \(A,B,C,D,E\) depend on the hat \(j\) and the actual ground.
Thus the sixteen-row action matrix has complex row rank at most five;
(3) does not assert its five columns are independent. Zero-mass cells
retain the raw identity, while normalized equality is interpreted as
zero on both reflected cells. The theorem
evenReconstructed_evenReduced in
[RadiusTwoEdgeReversalFinite.lean](BuildingBlocks/RadiusTwoEdgeReversalFinite.lean)
compiles the conditional five-row reconstruction. The analytic
reflection of the full crossing kernel and measure is a written input
to that finite theorem.

The target columns have a different parity. For either \(j=1,2\),
centering \(Y_j=P_\gamma Z_j\) removes a constant, so their cell
gradients equal those of the explicit \(Z_j\). The factor

\[
 d(u)=\left[
 \frac{e^u w(e^u)}
 {\rho(u)\psi_2(u)b(u)\Phi(u)}\right]^{1/2}              \tag{4}
\]

and the clock factors \(h(e^u)\), \(c_{1,X}(e^u)\),
\(s_X(e^u)\), and \(1_{\Theta_X(e^u)}(\theta)\) are not
forced to be even in \(u\). For a reflected pair \(i,i'\),

\[
 r_i(Y_j)-r_{i'}(Y_j)
 =\int_{D_i}
 \bigl[(Z_j(v)-Z_j(-v))-(Z_j(u)-Z_j(-u))\bigr]\,
 d\mathsf P_1.                                         \tag{5}
\]

Equation (5) is the exact odd-reflection target test. Its sign for an
arbitrary admissible \(h\) is not determined by the published formulas.

There is a concrete conditional witness. Fix \(X\ge1\), take the
admissible bounded compact clock test
\(h(t)=1_{[e^{13/4},\,e^4]}(t)\), and choose any
\(|\theta|<X^{-1/2}\). On cell 9, the \(q=3,+\) right edge has
\(u<4-\log3<3\) and
\(13/4<9/4+\log3<v<4\); these inequalities use
\(\log3>1\). Hence \(h(e^u)=0\) and \(h(e^v)=1\).
The far-domain threshold is at most one on this angular interval, so
\(1_{\Theta_X(e^v)}(\theta)=1\). Its reflected cell 10 is wholly on
the negative half-line, where this \(h(e^u)\) vanishes. Provided the
*actual cutoff cell mass* \(m_9>0\), equation (5) becomes

\[
\begin{aligned}
 r_9(Y_1)-r_{10}(Y_1)
 &=e^{i\theta}\int_{D_9}d(v)c_{1,X}(e^v)\,d\mathsf P_1
 \ne0,\\
 r_9(Y_2)-r_{10}(Y_2)
 &=e^{2i\theta}\int_{D_9}
   d(v)s_X(e^v)c_{1,X}(e^v)\,d\mathsf P_1
 \ne0 .
\end{aligned}                                                   \tag{6}
\]

Both integrands are positive before their constant phase. The
coherent difference also has nonzero odd row: after removing
\(e^{i\theta}\), its integrand has positive real part
\(d(v)c_{1,X}(e^v)\,[1-s_X(e^v)\cos\theta]\), since \(s_X<1\).
Thus **if \(m_9>0\)**, neither chosen target column nor their
difference can be realized by a combination of the five even hats,
for any angle in the central interval.

The published data do not enclose \(m_9\) for the canonical
\(E_4\)-restricted measure. Its geometric interval is nonempty, but
the ground and departure-rate cutoff could erase it. The chosen
\(h\) is one admissible test, not a claim about every clock source.
Accordingly (6) is a conditional finite-hat obstruction, not an
unconditional target sign, a full-core range obstruction, or an RH
statement.

The [moving-cutoff audit](uncut-cell-nine-even-hat-test.md#eventual-canonical-detection-on-the-same-strip)
proves that some unspecified larger canonical \((M,0)\) stage
detects the same chosen clock test. It does not determine \(m_9\) at
\(M=4\).
