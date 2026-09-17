# A smooth obstruction to Gaussian coercivity of the full-F score

2026-09-16. **Status:** a counterexample for a smooth pseudo-source. It does not use the actual von Mangoldt weights and proves nothing about RH.

Fix \(\kappa,a>0\), put \(u=\log x\), and, for \(x>1\), define

\[
 F(x)=\kappa+\frac{a}{1+\log x},\qquad
 e(u)=\frac{a}{(1+u)^2},\qquad
 E(x)=x e(\log x)=\frac{ax}{(1+\log x)^2}.
\tag{1}
\]

These are smooth and satisfy exactly \(F_x=-E/x^2\), \(F>0\),
\(F(x)\to\kappa\), and \(E(x)=o(x)\). They are a **pseudo-source**:
\(dE\) is not the actual prime-power measure \(d\psi-dx\).

Let \(L=\log 2\), \(H(t)=t^2e^{-t}\), \(K=H-H'=2t(t-1)e^{-t}\), and
\(T_Qh(u)=\int_0^\infty Q(t)h(u+t)\,dt\). Set \(r=e/F\), with
\(F\) evaluated at \(e^u\), and define the exact full-F profile and
dyadic score by

\[
 G(u)=\int_{e^u}^\infty
 \frac{H(\log(x/e^u))}{xF(x)}\,dE(x),
 \qquad J_F(u)=G(u)-G(u+L).
\tag{2}
\]

Stieltjes integration by parts, or direct differentiation of (1), gives
\(G=T_Kr-T_Hr^2\). Since \(r=-\partial_u\log(F/\kappa)\) and \(K(0)=0\),

\[
 \boxed{G=T_{K'}\log(F/\kappa)-T_Hr^2.}
\tag{3}
\]

Here \(\int K'=0\), \(\int tK'=-\int K=-2\), and \(\int H=2\); all
integrals are over \([0,\infty)\). Writing \(\ell=\log(F/\kappa)\),
Taylor expansion under the exponentially decaying kernel gives

\[
 (T_{K'}\ell)'(u)=-2\ell''(u)+O(u^{-4})
 =-\frac{4a}{\kappa u^3}+O(u^{-4}).
\]

Also \(r(u)^2=a^2\kappa^{-2}u^{-4}+O(u^{-5})\), so
\((T_Hr^2)'(u)=O(u^{-5})\). Integrating both derivatives over
\([u,u+L]\) proves

\[
 \boxed{J_F(u)=\frac{4aL}{\kappa u^3}+O(u^{-4})>0
 \quad\text{for all sufficiently large }u.}
\tag{4}
\]

For any fixed Gaussian variance ratio \(c>0\), let \(g_U\) be the
normal density of mean \(U\) and variance \(cU\), restricted and
renormalized to \(u\ge1\). Write
\(A_Uh=\int_1^\infty g_U(u)h(u)\,du\) and
\(V_U=A_U[e^2]\). Gaussian concentration on \(u=U+O(\sqrt U)\), with
an exponentially small left tail, yields

\[
 A_UJ_F=\left(\frac{4aL}{\kappa}+o(1)\right)U^{-3}>0,
 \qquad
 V_U=(a^2+o(1))U^{-4},
 \qquad
 \frac{A_UJ_F}{V_U}\sim\frac{4L}{\kappa a}U.
\tag{5}
\]

Consequently, for any \(c_0,\eta>0\), an inequality of the form
\(A_UJ_F\le-c_0V_U+O(e^{-\eta U})\) fails on this source. The ground
equation, positivity, limiting constant, and PNT-like decay alone do
not make the Gaussian-averaged score coercive. The conditional negative
bias for the actual prime source needs additional information about
its oscillatory zeta-zero frequencies; (1) contains none of it. No RH
statement follows from this counterexample.

The obstruction persists even if a pseudo-source has a square-root-sized
error. Set \(e(u)=a e^{-u/2}\) and \(F(e^u)=\kappa+2a e^{-u/2}\), so that
\(E(x)=a\sqrt{x}\). Then the linear kernel moment
\(\int_0^\infty K(t)e^{-t/2}dt=8/27\) gives
\[
J_F(u)=\frac{8a}{27\kappa}(1-2^{-1/2})e^{-u/2}
       +O(e^{-u})>0.
\]
For the Gaussian with \(c=1/10\), its average has order
\(e^{-(1/2-c/8)U}\), while \(V_U\) has order
\(e^{-(1-c/2)U}\). Even a square-root envelope cannot supply the
negative sign without the actual prime source's oscillatory spectrum.
