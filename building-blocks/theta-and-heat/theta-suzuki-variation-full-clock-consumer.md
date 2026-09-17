# Suzuki's first coefficient variation as a full theta-clock test

Suzuki's coefficient identity \(c'_0(n)=2\Lambda(n)\) produces a concrete family of tests for the actual killed-theta ground clock. The complete prime-power derivative, obtained by removing the finite cutoff, belongs to the **operator domain** of that clock. This is a domain and source-identification result. It does not bound the affine conditional-edge residual, sign the Weil form, or prove RH.

Fix \(R>0\), the actual even bounded killed ground \(\psi\), and the full exterior clock \(K\) on \(L^2(\gamma)\), with \(d\gamma=\rho\psi\,d\nu\), \(d\nu=b\Phi\,du\), \(b=2\cosh(u/2)\), and \(\rho=(e^{|u|}+1)^{-1}\). The original complete internal jump rate is \(q_O(u,dv)\), including the continuous \(r(|u-v|)\) kernel and both \(\pm\log n\) prime-power displacements. Let \(P_\infty=\|\psi\|_\infty\). The [cross-profile domain proof](theta-cross-profile-weak-score-tests.md#1-the-continuous-profile-is-in-the-full-operator-domain) gives
\[
 B_1:=\sup_{u\in O}\int_O\min(1,|u-v|)q_O(u,dv)<\infty.
\tag{1}
\]

## Exponentially growing smooth odd potentials are operator tests

We first record a useful actual-clock domain lemma. Suppose \(F\) is real, odd, \(C^1\) on each of the two exterior halves, and for some fixed \(B,m\ge0\) and \(C<\infty\),
\[
 |F(u)|+|F'(u)|\le C W(u),\qquad
 W(u)=(1+|u|)^m e^{B|u|}.
\tag{2}
\]
Then \(F\in D(K)\), and its full action is the absolutely convergent rate integral
\[
 \boxed{\quad
 KF(u)=\frac1{\rho(u)}\int_O\psi(v)[F(u)-F(v)]q_O(u,dv)
 \quad\text{for almost every }u\in O.\quad}
\tag{3}
\]
The equality uses oddness: the rank-one-subtracted clock acts on the centered sector, and the odd \(F\) has zero \(\gamma\)-mean.

Here are the estimates behind the domain assertion. The mean-value theorem on each half and (2) give
\[
 |F(u)-F(v)|\le C'(W(u)+W(v))\min(1,|u-v|).
\tag{4}
\]
For endpoints on opposite halves, their distance is at least \(2R\); the same bound follows from \(|F(u)|+|F(v)|\), with a constant depending on \(R\). Thus no continuity across the deleted core is assumed.
Write \(\Theta(v)=\Phi(v)W(v)\). It decays faster than every ordinary exponential at both ends. Splitting the integers into \(e^j\le n<e^{j+1}\), using \(\Lambda(n)\le\log n\) and at most \(e^{j+1}\) integers in a shell, proves
\[
 \sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
 [\Theta(u+\log n)+\Theta(u-\log n)]
 \le C_\Theta b(u)(1+|u|).
\tag{5}
\]
Indeed a shell contributes at most \(C(j+1)e^{j/2}\) times the supremum of \(\Theta\) on its translated unit interval. For \(u>0\), the potentially large shells have \(j=u+O(1)\), giving \(e^{u/2}(1+u)\); the remaining translated theta suprema form a uniformly summable sequence. Reflection treats \(u<0\). This elementary estimate uses no PNT.

The continuous part of the weighted rate is bounded by \(\sup_v\Phi(v)W(v)\int r(t)\min(1,t)dt/b(u)\). The prime part is bounded by (5) divided by \(b(u)\). Equations (1), (4), and (5) therefore yield
\[
 |KF(u)|\le\frac{C'P_\infty}{\rho(u)}
 \{B_1W(u)+C_\Theta(1+|u|)+C_0\}.
\tag{6}
\]
The right side lies in \(L^2(\gamma)\), since \(\psi\le P_\infty\), \(\rho^{-1}\) grows only exponentially, and \(\nu\) has two-sided theta tails. The same weighted-rate calculation with \(W^2\) in place of \(W\) proves finite full edge energy. For bounded form tests, symmetry and absolute convergence identify the edge form with the \(L^2(\gamma)\) pairing against (3). Truncating a general form test and passing by dominated edge convergence extends that identity to the full form domain. The closed-form representation theorem proves \(F\in D(K)\). No derivative of \(\psi\) or replacement of the prime measure by a density is used.

This also upgrades two actual affine sources. With \(y=\sigma_O\), \(q=\tau_O\), \(\sigma=\Phi'/\Phi\), and \(\tau=\tanh(u/2)\), put \(S_y=y/\rho\) and \(S_q=q/\rho\). Both are odd and smooth on each exterior half. The theta derivative estimates give \(|S_y|+|S_y'|\le C_R e^{B|u|}\) for some fixed \(B\), while \(S_q\) and its derivative have the same type of bound directly. Hence
\[
 \boxed{\qquad S_y,S_q\in D(K).\qquad}
\tag{6a}
\]
The existing [prime-profile full-form theorem](theta-prime-profile-full-form-domain.md) needed only their membership in \(V_K\). Equation (6a) alone does not upgrade the prime profile \(w_p\), the crossing source \(S_f\), or the affine optimizer \(v_U\) to \(D(K)\). A separate [singular-rate and graph-sum proof](theta-score-crossing-second-clock-domain.md) now establishes \(S_f\in D(K)\).

## The complete Suzuki derivative and graph-norm cutoff limit

Choose \(\varphi\in C_c^\infty((R,\infty))\), supported inside \([A,D]\) with \(R<A<D\). On \(u>0\) define
\[
 H_N(u)=2\sum_{2\le n\le N}
       \frac{\Lambda(n)}{\sqrt n}\varphi(u-\log n),
 \qquad
 H(u)=2\sum_{n\ge2}
       \frac{\Lambda(n)}{\sqrt n}\varphi(u-\log n),
\tag{7}
\]
and extend both functions oddly to \(u<0\). Every sum is locally finite: a nonzero term at \(u\) requires \(e^{u-D}\le n\le e^{u-A}\). In particular these functions vanish near \([-R,R]\). Counting that interval with \(\Lambda(n)\le\log n\) gives, uniformly in \(N\),
\[
 |H_N(u)|+|H_N'(u)|+|H(u)|+|H'(u)|
 \le C_\varphi(1+|u|)e^{|u|/2}.
\tag{8}
\]
The lemma therefore puts every \(H_N\) and the **complete** \(H\) in \(D(K)\). Moreover
\[
 \boxed{\qquad H_N\longrightarrow H\quad\text{in the graph norm of }K.\qquad}
\tag{9}
\]
For the \(L^2(\gamma)\) part, (8) is a theta-integrable dominating function and \(H_N\to H\) pointwise. For the action part, (4)--(6) supply a common \(L^2(\gamma)\) bound on \(KH_N\); the rate integrands converge pointwise and are dominated by the weighted rate in (4)--(5). Dominated convergence first gives \(KH_N(u)\to KH(u)\) almost everywhere, then convergence in \(L^2(\gamma)\). Thus (9) keeps both prime orientations and every prime power through the operator limit.

To connect this literally to [Suzuki's coefficient variation](../weil-and-spectral/suzuki-coefficient-prime-history-variation.md), let \(c_\omega(n)\) be its finite divisor-sum coefficient and form the odd finite path
\[
 H_{N,\omega}(u)=\operatorname{sgn}(u)
 \sum_{1\le n\le N}c_\omega(n)n^{-1/2}
       \varphi(|u|-\log n).
\tag{10}
\]
For each fixed \(N\), this is a smooth compact exterior potential in \(D(K)\). The formalized actual coefficient identity \(c'_0(n)=2\Lambda(n)\) gives
\[
 \left.\partial_\omega H_{N,\omega}\right|_{\omega=0}=H_N,
\qquad
 \left.\partial_\omega H_{N,\omega}\right|_{\omega=0}
 \longrightarrow H\quad\text{in }D(K).
\tag{11}
\]
Here \(D(K)\) convergence means graph norm as in (9). This is a derivative of finite paths followed by a proved limit; no interchange of an infinite coefficient path with differentiation is asserted.

## A literal full-Weil first-variation row

The same tests also consume Suzuki's **completed** Weil form, without identifying that form with the arithmetic coefficient alone. Let \(Q_W\) be the full polarized physical form, with archimedean part \(\mathscr K=A-S\), complete prime translation sum \(S\), and both pole moments \(M_\pm(g)=\int e^{\pm u/2}g(u)du\). Define
\[
 g_{N,\omega}=\Phi\psi H_{N,\omega},\quad
 g_0=\Phi\psi\,\operatorname{sgn}(u)\varphi(|u|),\quad
 g_N=\Phi\psi H_N,\quad g=\Phi\psi H.
\tag{12}
\]
Every fixed finite path lies in the full Weil form domain. For real \(\omega\) near zero, ordinary differentiation of its quadratic form gives
\[
 \boxed{\quad
 \left.\frac{d}{d\omega}Q_W[g_{N,\omega}]\right|_{0}
 =2Q_W(g_0,g_N)
 \longrightarrow 2Q_W(g_0,g).
 \quad}
\tag{13}
\]
The row on the right retains its literal completion:
\[
 Q_W(g_0,g_N)=\mathscr K(g_0,g_N)
   +M_+(g_0)M_-(g_N)+M_-(g_0)M_+(g_N).
\tag{14}
\]
Here \(\mathscr K\) is a form pairing, not an assertion that \(Ag_0\) exists as an unweighted \(L^2\) vector.

For the limit in (13), graph convergence in (9) implies convergence in the full ground energy. The proved equivalence of the \(\gamma\) and original ground-potential form domains then gives \(\psi H_N\to\psi H\) in original \(L^2(\nu)\) and form norm. The archimedean and complete-prime pairings consequently converge. Each pole moment is a bounded functional of \(\psi H_N\in L^2(\nu)\): Cauchy--Schwarz uses \(\int e^{\pm u}\Phi(u)/b(u)\,du<\infty\). Thus no gamma or pole contribution is lost in passing to the complete-prime derivative. Equation (13) is a full-form mixed row; it gives no sign for that row.

The vectors \(H_N\) or \(H\) may be used as \(u_i\in D(K)\) in the [multirank affine Gram formula](theta-affine-action-rank-domain-obstruction.md#several-action-ranks-an-exact-finite-lower-gap-certificate). Their action columns \((K-M)u_i\) retain the full continuous conductance, the actual ground weights, every internal prime power, and the score constraint through the constrained inverse. The finite successor operators \(R_n\) in Suzuki's Euler transfer are truncated divisor shifts; they are **not** identified with the physical translations in (7). Nor does the positive coefficient family sign the mixed Gram entries. The completed ratio's gamma and pole variation remains part of the full Weil form and cannot be discarded because its arithmetic first variation is \(2\Lambda\). Consequently this construction gives legitimate full-clock tests and possible lower-gap certificates, but no upper bound on \(n[v_U]\) or RH conclusion.

The coefficient identity in (11) is compiled in [SuzukiCoefficientVariation.lean](../../formalization/BuildingBlocks/SuzukiCoefficientVariation.lean). The exponential-growth domain lemma, graph-norm limit, and actual multirank insertion here are written mathematics, not Lean-formalized.
