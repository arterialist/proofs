# A third-order Vinogradov--Korobov bound for the signed Goldbach cofactor

Every occurrence of \(\Lambda\) below includes all prime powers. For integers
\(s\ge4\), let
\[
 E(y)=\psi(y)-y,\qquad
 Q_s=\sum_{m=2}^{s-2}\Lambda(m)\frac{E(s-m)}{s-m}.
\]
For sufficiently large \(s\), write
\[
 F(s)=\frac{(\log s)^{3/5}}{(\log\log s)^{1/5}},\qquad
 R_s=\log\log s,\qquad M_s=\log R_s,
\]
and set
\[
 A_0=\frac1{48.0718},\qquad
 d=\left(\frac{5^6A_0^3}{2^2 3^4}\right)^{1/5},\qquad
 c_2=2^{2/5}d,
 \qquad \kappa_0=\frac{c_2}{3}\log\frac5{c_2}.
\]
Numerically, \(c_2=0.280499938864373\ldots\) and
\(\kappa_0=0.269337881789115\ldots\).

**Theorem.** For every fixed \(0<\kappa<\kappa_0\),
\[
 \boxed{\displaystyle
 |Q_s|\ll_\kappa s\exp\!\left{
 -c_2F(s)-\frac{c_2}{15}\frac{F(s)M_s}{R_s}
 -\kappa\frac{F(s)}{R_s}\right\}}.
 \tag{1}
\]
This reaches the \(c_2/15\) subleading coefficient excluded by the
[previous bound](goldbach-cofactor-subleading-vk-gain.md) and adds a positive
third-order saving. It does not increase the coefficient \(c_2\) of \(F(s)\).

## The linear zero sum

The [exact finite split](../../formalization/BuildingBlocks/GoldbachCofactorLinearSplitFinite.lean)
is \(Q_s=L_s+V_s\), where
\[
 L_s=\sum_{y=2}^{s-2}\frac{E(y)}y,\qquad
 V_s=\sum_{m=2}^{s-2}(\Lambda(m)-1)\frac{E(s-m)}{s-m}.
 \tag{2}
\]
The [endpoint-corrected explicit formula](goldbach-linearized-pointwise-vk-gain.md),
from [Soundararajan's unconditional Lemma 1](https://arxiv.org/pdf/math/0612106),
gives, with \(x=s-1\),
\[
 L_s=-\sum_\rho\frac{x^\rho}{\rho^2}+O(\log x).
 \tag{3}
\]
Zeros are counted with multiplicity. This series converges absolutely for
each \(x\); in particular (3) requires no height truncation.

Put \(\ell=\log x\), \(R=\log\ell\), \(M=\log R\), and
\(F=\ell^{3/5}R^{-1/5}\). By [Bellotti's Theorem 1.3](https://arxiv.org/html/2306.10680),
every sufficiently high zero \(\rho=\beta+i\gamma\) satisfies
\[
 \beta\le1-A_0u(|\gamma|),\qquad
 u(t)=(\log t)^{-2/3}(\log\log t)^{-1/3}.
 \tag{4}
\]
We use the uniform [Ingham density bound](https://arxiv.org/html/2507.15184)
\(N(\sigma,t)\ll t^{3(1-\sigma)/(2-\sigma)}(\log t)^5\) for
\(1/2\le\sigma\le1\), and \(N(t)\ll t\log t\).

Define \(g(z)=A_0(5/3)^{1/3}z^{-2/3}\). On any fixed compact interval
\(0<a\le z\le b\), put \(t=e^{zF}\). The exact logarithms in (4) give,
uniformly in \(z\),
\[
 A_0u(2t)\ell
 =g(z)F\left[1+\frac{M-5\log z}{9R}
            +O_{a,b}\!\left(\frac{M^2}{R^2}\right)\right].
 \tag{5}
\]
Indeed \(\log\log(2t)=(3R-M)/5+\log z+O_{a,b}(1/F)\),
while \(\log(2t)=zF+O(1)\). The term \(-5\log z\), hidden in the
previous proof's \(O(1/R)\), supplies the new coefficient.

Choose fixed \(a>0\) so small that \(g(a)>c_2+1\), and fixed
\(b>c_2+1\). The finitely many zeros below the threshold of (4)
contribute \(O(x^{1-\delta})\) for some \(\delta>0\). The other zeros
with \(|\gamma|\le e^{aF}\) contribute
\(\ll x\exp[-(g(a)+o(1))F]\) by monotonicity of \(u\) and
\(\sum_\rho|\rho|^{-2}<\infty\). Those with \(|\gamma|\ge e^{bF}\)
contribute \(\ll xF e^{-bF}\) by \(N(t)\ll t\log t\).

On a dyadic block \(t\le|\gamma|<2t\) between these cutoffs, call a
zero *near* if \(\beta>1-2A_0u(2t)\). Ingham's bound gives
\[
 \log\bigl(1+\#\{\text{near zeros on the block}\}\bigr)
 \ll u(2t)\log t+\log\log t
 \ll_{a,b}F^{1/3}R^{-1/3}+R=o(F/R).
 \tag{6}
\]
By (4), (5), and the denominator \(|\rho|^{-2}\), the near contribution
is at most
\[
 x\exp\{-A_0u(2t)\ell-2\log t+o(F/R)\}.
 \tag{7}
\]
The other zeros have \(\beta\le1-2A_0u(2t)\); counting them by
\(O(t\log t)\) gives a leading rate
\(z+2g(z)\), whose global minimum is
\(2^{3/5}d>c_2\). They therefore have a fixed \(F\)-scale gap.

For (7), \(f_0(z)=2z+g(z)\) has a unique strict minimum at
\(z_0=c_2/5\), with \(g(z_0)=3c_2/5\). Define the exact block rate
\(f_x(z)=2z+A_0u(2e^{zF})\ell/F\). Its perturbation from \(f_0\)
moves the minimizer by \(O(M/R)\); evaluating at that shifted point,
rather than at \(z_0\), changes the value by only \(O(M^2/R^2)\).
Hence (5) yields
\[
 \begin{aligned}
 \min_{a\le z\le b}f_x(z)
 &=c_2+\frac{g(z_0)}9\frac{M-5\log z_0}{R}
                         +O\!\left(\frac{M^2}{R^2}\right)\\
 &=c_2+\frac{c_2}{15}\frac MR
              +\frac{\kappa_0}{R}
                         +O\!\left(\frac{M^2}{R^2}\right).
 \end{aligned}
 \tag{8}
\]
There are \(O(F)\) dyadic blocks; their logarithmic cost is
\(O(\log F)=o(F/R)\). Equations (3)--(8) thus give
\[
 |L_s|\ll x\exp\!\left[-c_2F-\frac{c_2}{15}\frac{FM}{R}
                    -\kappa_0\frac FR
                    +O\!\left(\frac{FM^2}{R^2}\right)\right].
 \tag{9}
\]
The \(O(\log x)\) from (3) is absorbed. Replacing \(x=s-1\) by \(s\)
changes each displayed exponent term by \(o(1)\).

## Transfer to the actual cofactor

The [short-interval theorem](goldbach-cofactor-short-interval-vk-gain.md)
for the **same exact centered weight** \(\Lambda(m)-1\) gives, for every
fixed \(\varepsilon>0\),
\[
 |V_s|\ll_\varepsilon s\exp[-(c_V-\varepsilon)F(s)],
 \qquad c_V=d+g(d)=0.281822649859995\ldots>c_2.
 \tag{10}
\]
Choose \(\varepsilon<(c_V-c_2)/2\). The fixed gap in (10) absorbs
both smaller scales in (1). Since \(M^2/R\to0\), the error in (9)
is absorbed by \((\kappa_0-\kappa)F/R\). Equations (2), (9), and
(10) prove (1).

This is a written analytic proof. The finite split in (2) is Lean
compiled; the zero sum, density estimate, optimization, and
short-interval bound are not Lean formalized. The result is
quantitatively weaker than RH: the classical RH estimate
\(E(y)\ll\sqrt y(\log y)^2\) and \(\Lambda(m)\le\log s\) would give
\(|Q_s|\ll\sqrt s(\log s)^3\) directly. No literature-priority
claim is made.
