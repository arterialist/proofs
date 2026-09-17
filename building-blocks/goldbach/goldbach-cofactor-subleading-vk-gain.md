# A subleading Vinogradov--Korobov gain for the signed Goldbach cofactor

Keep all prime powers in \(\Lambda\), and for integers \(s\ge4\) set
\[
E(x)=\psi(x)-x,\qquad
Q_s=\sum_{m=2}^{s-2}\Lambda(m)\frac{E(s-m)}{s-m}.
\]
Write
\[
F(x)=\frac{(\log x)^{3/5}}{(\log\log x)^{1/5}},\quad
c_2=2^{2/5}\left(\frac{5^6 A_0^3}{2^2 3^4}\right)^{1/5},
\quad A_0=\frac1{48.0718},\quad
D(x)=F(x)\frac{\log\log\log x}{\log\log x}.
\]
The formula for \(D(x)\) is used only when its iterated logarithms are
positive. Numerically \(c_2=0.2804999388\ldots\).

**Theorem.** For every fixed \(0<\theta<c_2/15\),
\[
\boxed{\displaystyle
 |Q_s|\ll_\theta s\exp\{-c_2F(s)-\theta D(s)\}.}
\tag{1}
\]
Thus the [previous pointwise bound](goldbach-cofactor-short-interval-vk-gain.md)
with exponent \(c_2-\varepsilon\) admits the exact leading coefficient
\(c_2\) and a positive, diverging subleading saving. This does not
increase the coefficient of \(F(s)\).

## The linear term

The [finite split](../../formalization/BuildingBlocks/GoldbachCofactorLinearSplitFinite.lean)
is \(Q_s=L_s+V_s\), where
\[
L_s=\sum_{y=2}^{s-2}\frac{E(y)}y,
\qquad V_s=\sum_{m=2}^{s-2}(\Lambda(m)-1)\frac{E(s-m)}{s-m}.
\tag{2}
\]
The [endpoint-corrected explicit-formula argument](goldbach-linearized-pointwise-vk-gain.md),
based on [Soundararajan's unconditional Lemma 1](https://arxiv.org/pdf/math/0612106),
gives, with \(x=s-1\),
\[
L_s=-\sum_\rho\frac{x^\rho}{\rho^2}+O(\log x).
\tag{3}
\]
The zeros are counted with multiplicity and the series is absolutely
convergent for each \(x\). We retain the exact logarithms in the
zero-free region when estimating this series.

[Bellotti's Theorem 1.3](https://arxiv.org/html/2306.10680) states with
the **fixed** constant \(A_0\) that sufficiently high zeros satisfy
\[
\beta\le 1-A_0u(|\gamma|),\qquad
u(t)=(\log t)^{-2/3}(\log\log t)^{-1/3}.
\tag{4}
\]
We also use the uniform [Ingham zero-density estimate](https://arxiv.org/html/2507.15184)
\(N(\sigma,t)\ll t^{3(1-\sigma)/(2-\sigma)}(\log t)^5\)
for \(1/2\le\sigma\le1\), and the standard \(N(t)\ll t\log t\).

Put \(\ell=\log x\), \(R=\log\ell\), \(M=\log R\), and
\(F=F(x)=\ell^{3/5}R^{-1/5}\). Define
\(g(z)=A_0(5/3)^{1/3}z^{-2/3}\). On any fixed compact interval
\(0<a\le z\le b\), setting \(t=e^{zF}\) gives, uniformly,
\[
A_0u(2t)\ell
=g(z)F\left(1+\frac{M}{9R}+O_{a,b}\left(\frac1R\right)\right).
\tag{5}
\]
Indeed \(\log\log(2t)=(3/5)R-(1/5)M+\log z+O(1/F)\).
The \(O(1/R)\) in (5) includes the quadratic Taylor remainder,
since \(M^2/R^2=o(1/R)\).

Choose \(a>0\) small enough that \(g(a)>c_2+1\), and \(b>c_2+1\).
The finitely many zeros below the threshold in (4) have a fixed gap
from \(1\). For the remaining ordinates below \(e^{aF}\), monotonicity
of \(u\) and convergence of \(\sum_\rho|\rho|^{-2}\) give a contribution
\(\ll x\exp[-(g(a)+o(1))F]+O(x^{1-\delta})\), for some \(\delta>0\).
Above \(e^{bF}\), absolute convergence and \(N(t)\ll t\log t\) give
\(\ll xF\exp(-bF)\). Both are smaller than (1).

On a dyadic block \(t\le|\gamma|<2t\) between these cutoffs, write
\(t=e^{zF}\), so \(a\le z\le b+o(1)\). Call a zero *near* when
\(\beta>1-2A_0u(2t)\). Ingham's estimate bounds the number of near
zeros on this block by
\[
 \exp\{O(u(2t)\log t+\log\log t)\}
 =\exp\{o(F/R)\}.
\tag{6}
\]
In fact \(u(2t)\log t=O_{a,b}(F^{1/3}R^{-1/3})\) and
\(\log\log t=O(R)\), both \(o(F/R)\). In particular, no fixed
\(\varepsilon F\) loss enters the estimate for \(L_s\).
Here (4) still bounds each near zero by
\(\beta\le1-A_0u(2t)\). Its contribution in (3) is therefore at most
\[
x\exp\{-A_0u(2t)\ell-2\log t+o(F/R)\}.
\tag{7}
\]
The other zeros have \(\beta\le1-2A_0u(2t)\). Their number is
\(O(t\log t)\), so their block costs at most
\[
x\exp\{-2A_0u(2t)\ell-\log t+O(\log\log t)\}.
\tag{8}
\]
By (5), the leading rate in (8) is
\(\min_{z>0}\{z+2g(z)\}=2^{3/5}d>c_2\), where
\(d=(5^6A_0^3/(2^2 3^4))^{1/5}\).

For (7), the rate is, uniformly on the compact interval,
\[
F\left[2z+\left(1+\frac{M}{9R}\right)g(z)
          +O_{a,b}\left(\frac1R\right)\right].
\]
The minimum of \(2z+g(z)\) occurs at \(z_0=c_2/5\), with
\(g(z_0)=3c_2/5\). More precisely, scaling \(g\) by \(1+M/(9R)\)
scales this minimum by \((1+M/(9R))^{3/5}\). Hence
\[
\min_{z>0}\left\{2z+\left(1+\frac{M}{9R}\right)g(z)\right\}
=c_2+\frac{c_2}{15}\frac{M}{R}+O\left(\frac1R\right).
\tag{9}
\]
There are \(O(F)\) dyadic blocks, whose logarithmic cost is
\(O(\log F)=o(F/R)\). Equations (3)--(9) prove the sharper linear estimate
\[
|L_s|\ll x\exp\left[-c_2F(x)-\frac{c_2}{15}D(x)
                         +O\left(\frac{F(x)}{\log\log x}\right)\right].
\tag{10}
\]
The \(O(\log x)\) in (3) is negligible. Replacing \(x=s-1\) by \(s\)
does not affect the displayed error scale. Since \(M\to\infty\),
(10) implies (1) with \(L_s\) in place of \(Q_s\) for every
\(\theta<c_2/15\).

Finally, the [uniform short-interval theorem](goldbach-cofactor-short-interval-vk-gain.md)
gives for every \(\varepsilon>0\)
\[
|V_s|\ll_\varepsilon s\exp[-(d+J(d)-\varepsilon)F(s)],
\qquad d+J(d)=0.2818226498\ldots>c_2.
\]
Fix \(\varepsilon<(d+J(d)-c_2)/2\). Its fixed
\(F(s)\)-saving absorbs the \(o(F(s))\) term \(\theta D(s)\), so (2)
and (10) establish (1). This is a written analytic proof, not a Lean
theorem or a claim of a better leading Vinogradov--Korobov coefficient.
No literature-priority claim is made.
