# Dyadic Chebyshev score: unclocked inversion and moving-clock visibility

RH Agent3, 2026-09-16. Independently audited by RH Agent1. **Status:** RH-equivalent unclocked criterion and a moving-clock visibility obstruction; no unconditional RH-scale bound. This is written analysis, not a Lean formalization. The arithmetic function is the **actual**
\[
D(x)=2\psi(x)-\psi(2x),
\qquad f(u)=e^{-u}D(e^u),\qquad u\ge0. \tag{1}
\]
Every \(\Lambda(p^k)\) is present in \(\psi\). By PNT, \(f(u)=o(1)\); it is locally bounded and has jumps. No pointwise RH-strength bound on \(D\) is used below. This note treats the averaged score from the infinite-future factorial-ground spatial-jump note; its separate coupled-\(F\) correction is not discarded.

## Exact unclocked equivalence, including the unilateral boundary

At \(s=0\), the clock law is \(\delta_0\), so \(j_0(t)=te^{-t/2}{\bf1}_{t\ge0}\) and
\[
K_0(t)=j_0(t)^2-2j_0(t)j_0'(t)
=2t(t-1)e^{-t}.
\]
For \(Y=e^u\) define
\[
g(u):=\mathcal D_{e^u,0}
=\int_0^\infty K_0(t)f(u+t)\,dt. \tag{2}
\]
The Mellin-mode multiplier, for \(f_z(u)=e^{(z-1)u}\), is
\[
m_0(z)=\int_0^\infty K_0(t)e^{(z-1)t}dt
=\frac{2z}{(2-z)^3},\qquad \Re z<2. \tag{3}
\]
It is nonzero throughout \(1/2<\Re z<1\). The normalization matters: the exponent is \(z-1\), because \(f=D(x)/x\).

The nonvanishing multiplier alone is not a pointwise inverse on the half-line: \(f\) has jumps and the operator smooths three derivatives. Put
\[
(Rf)(u)=\int_0^\infty e^{-t}f(u+t)dt,
\qquad h=R^3f
=\frac12\int_0^\infty t^2e^{-t}f(u+t)dt. \tag{4}
\]
These functions are well defined for \(u\ge0\), and \(h\) has three distributional derivatives locally. Direct convolution and \((Rf)'=Rf-f\) give
\[
R=(1-\partial_u)^{-1},\qquad
g=2(h+h'),\qquad
f=(1-\partial_u)^3h \tag{5}
\]
as distributions on \((0,\infty)\). Here \(R\) denotes the **bounded future branch** of the inverse; the differential symbol alone would permit a growing homogeneous term. The three initial traces \(h(0),h'(0),h''(0)\) exist because \(f\) is locally bounded and the exponential future kernels are integrable.

Suppose that for **every** \(\epsilon>0\),
\[
g(u)=O_\epsilon(e^{-(1/2-\epsilon)u})
\qquad (u\to\infty). \tag{6}
\]
Solving \(h'+h=g/2\) from the actual unilateral boundary gives
\[
h(u)=e^{-u}h(0)+\frac12\int_0^u e^{-(u-v)}g(v)\,dv
=O_\epsilon(e^{-(1/2-\epsilon)u}). \tag{7}
\]
No boundary value at \(+\infty\) was imposed. For \(\Re p>0\), where the original Laplace transform of \(f=o(1)\) converges, integration by parts in (5) gives
\[
\mathcal L f(p)
=(1-p)^3\mathcal L h(p)
+(p^2-3p+3)h(0)+(p-3)h'(0)+h''(0). \tag{8}
\]
Here \(\mathcal L f(p)=\int_0^\infty e^{-pu}f(u)du\). Equation (7) makes \(\mathcal L h\) analytic on \(\Re p>-(1/2-\epsilon)\). Thus (8) analytically continues \(\mathcal L f(p)\) to that half-plane. The explicit polynomial is the half-line boundary correction.

For \(\Re z>1\), direct Stieltjes integration of the actual Chebyshev function gives
\[
\mathcal L f(z-1)
=\int_1^\infty D(x)x^{-z-1}dx
=\frac{2-2^z}{z}\left(-\frac{\zeta'(z)}{\zeta(z)}\right).
\tag{9}
\]
The factor \(2-2^z\) vanishes only on \(\Re z=1\). It cannot cancel a pole at a nontrivial zero with \(1/2<\Re z<1\). Since (6) holds for every \(\epsilon\), (8)--(9) exclude every such zero. The functional equation reflects a zero with \(0<\Re z<1/2\) to one with real part \(>1/2\). Therefore (6) implies RH.

Conversely RH gives the standard \(\psi(x)-x=O(x^{1/2}\log^2x)\); hence \(D(x)=O(x^{1/2}\log^2x)\) and \(f(u)=O(e^{-u/2}(1+u)^2)\). The kernel \(K_0\) has exponentially weighted first moments, so (2) gives (6). We have proved the exact actual-source equivalence
\[
\boxed{\quad
\mathrm{RH}\quad\Longleftrightarrow\quad
\mathcal D_{Y,0}=O_\epsilon(Y^{-1/2+\epsilon})
\ \text{for every }\epsilon>0.\quad} \tag{10}
\]
This criterion is unclocked and does not by itself pay the later-clock spatial jump. It uses neither a pointwise estimate for \(D\) as an input nor a generic-sign assumption.

The same implication holds if (10) is stated only at integer \(Y=N\ge1\). Indeed \(f\) is bounded on \(u\ge0\) by PNT and local finiteness. Since \(K_0(0)=0\) and \(K_0'\in L^1(0,\infty)\), differentiation of the future convolution in (2), valid across the jumps of \(f\), gives
\[
|g'(u)|\le \|f\|_\infty\|K_0'\|_1
\quad\text{for a.e. }u\ge0. \tag{11}
\]
For \(N\le Y<N+1\), \(|\log Y-\log N|\le1/N\); hence the integer bound extends to all real \(Y\) with an additional \(O(N^{-1})\) error. This is below the \(N^{-1/2+\epsilon}\) scale. No pointwise control of the arithmetic jumps was inserted.

## Moving clock: explicit mode attenuation and detectability threshold

For the complete all-prime compound-Poisson age law \(\mathsf P_s\), write \(j_s=h_0*\mathsf P_s\), \(h_0(t)=te^{-t/2}{\bf1}_{t\ge0}\), and \(K_s=j_s^2-(j_s^2)'\). For any \(z\) with \(\Re z=\beta<1\), integration by parts gives the exact Mellin-mode multiplier
\[
m_s(z):=\int_0^\infty K_s(t)e^{(z-1)t}dt
=z\int_0^\infty e^{(z-1)t}j_s(t)^2dt.
\tag{12}
\]
The boundary terms vanish because \(j_s(0)=0\) and its weighted \(H^1\) tail decays. At \(s=0\), (12) recovers (3). For real \(0<z<1\), \(m_s(z)>0\); for complex \(z\), the oscillatory integral may cancel and no uniform lower bound is asserted.

Let \(a=1-\beta>0\), and let \(\Phi(q)=\int(1-e^{-qv})\nu(dv)>0\) be the **complete** prime-power age exponent. Weighted Young's inequality gives
\[
\|e^{-at/2}j_s\|_2
\le e^{-s\Phi(a/2)}\|e^{-at/2}h_0\|_2.
\]
Since \(\int_0^\infty e^{-at}h_0(t)^2dt=2/(1+a)^3\), the exact mode response obeys the unconditional upper bound
\[
\boxed{\ |m_s(z)|
\le |z|\frac{2}{(1+a)^3}
e^{-2s\Phi(a/2)}. \ } \tag{13}
\]
At the moving clock \(s=c\log Y\), a formal Mellin mode \(Y^{z-1}\) contributes at most
\[
O_z\!\left(Y^{-(1-\beta)-2c\Phi((1-\beta)/2)}\right).
\tag{14}
\]
Thus if
\[
\boxed{\quad 2c\Phi((1-\beta)/2)>\beta-\tfrac12,\quad} \tag{15}
\]
that mode's **upper** response is already \(o(Y^{-1/2})\). A mere RH-scale bound for the moving averaged score cannot detect such a mode by coefficientwise Mellin inversion. For every fixed \(c>0\), (15) holds for all \(\beta>1/2\) sufficiently close to \(1/2\), because \(\Phi(1/4)>0\). This is a visibility obstruction for the filter, not an assertion that such a zeta zero exists.

For comparison, the no-jump atom gives \(j_s(t)\ge e^{-\lambda s}h_0(t)\). Positivity therefore proves, for a **real** \(\beta\in(1/2,1)\),
\[
m_s(\beta)\ge e^{-2\lambda s}m_0(\beta)
=\frac{2\beta}{(2-\beta)^3}e^{-2\lambda s}. \tag{16}
\]
Such a real mode is certainly visible above \(Y^{-1/2}\) when \(2c\lambda<\beta-1/2\). This is only a positive-real benchmark: nontrivial zeta zeros are complex, and the oscillation in (12) can cancel the no-jump contribution.

A sufficient **modewise** route for a complex \(z=\beta+i\gamma\) would require a quantitative lower bound \(|m_{c\log Y}(z)|\gg_z Y^{-\eta_z}\) along a cofinal set of \(Y\), with \(\eta_z<\beta-1/2\), plus control of other modes when applying it to the actual \(f\). Neither (12) nor positivity gives this. The fixed-\(s\) Mellin continuation used in (8) cannot simply be reused when \(s\) itself varies with \(u=\log Y\). The complete \(F\)-correction for the original spatial jump remains the separately proved term \(\mathcal R_{Y,s}\) in the infinite-future factorial-ground spatial-jump note; (10)--(16) make no claim that it vanishes.

There is a limited exact nonvanishing statement: for fixed \(z\) with \(\Re z<1\), the compound-Poisson series converges in the exponentially weighted \(L^2\) space for every complex \(s\), so \(s\mapsto m_s(z)\) is entire. Since \(m_0(z)=2z/(2-z)^3\ne0\) in the critical strip, its zeros in finite \(s\)-intervals are isolated. This does **not** bound how fast \(|m_s(z)|\) may shrink as \(s\to\infty\), which is the quantitative issue in (15).
