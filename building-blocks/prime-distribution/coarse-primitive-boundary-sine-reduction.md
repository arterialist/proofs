# Boundary sine modes of the coarse prime primitive

**Status:** unconditional written reduction, 21 September 2026. The exact
identities retain every von Mangoldt prime power and both dyadic endpoints.
The tail estimate uses Theorem 1.1 of
[Maynard, Pandey, and Radziwill](https://arxiv.org/abs/2608.14777). The
terminal mass and the first \(X^{1/4}\) sine modes remain open at the required
scale. This note therefore does not prove `CoarsePrimitiveBound` or the
Riemann hypothesis.

Let \(X=2^m\ge16\),
\[
 E(x)=\psi(\lfloor x\rfloor)-x,\qquad f(u)=E(X+u)\quad(0\le u\le X),
\]
and define
\[
 P(u)=\int_0^u f(v)\,dv,\qquad M=P(X),\qquad
 Q(u)=P(u)-\frac{u}{X}M.
 \tag{1}
\]
Then \(Q(0)=Q(X)=0\).

## Exact sine coefficients

For \(j\ge1\), put
\[
 q_j=\frac2X\int_0^XQ(u)\sin\frac{\pi ju}{X}\,du
 \tag{2}
\]
and
\[
 T_j(X)=\sum_{X<n\le2X}\Lambda(n)
       \sin\frac{\pi j(n-X)}X
       -\frac{X(1-(-1)^j)}{\pi j}.
 \tag{3}
\]
The second term in (3) is the integral of the same sine against uniform
density on \([X,2X]\). It is zero for even \(j\) and \(2X/(\pi j)\) for odd
\(j\).

Integration by parts in (2) gives
\[
 q_j=\frac{2}{\pi j}\int_0^X f(u)
      \cos\frac{\pi ju}{X}\,du.
 \tag{4}
\]
The derivative \(-M/X\) in \(Q'\) contributes zero. Writing
\[
 E(X+u)=E(X)-u+\sum_{X<n\le X+u}\Lambda(n)
\]
and interchanging the finite sum and integral gives
\[
 \int_0^X f(u)\cos\frac{\pi ju}{X}\,du
 =-\frac{X}{\pi j}T_j(X).
 \tag{5}
\]
Here \(n=X\) is excluded. The term \(n=2X\) is included but its sine
coefficient is zero. Combining (4) and (5),
\[
 \boxed{q_j=-\frac{2X}{\pi^2j^2}T_j(X).}
 \tag{6}
\]
Parseval for the Dirichlet sine basis now gives the exact identity
\[
 \boxed{
 \int_0^X|Q(u)|^2\,du
 =\frac{2X^3}{\pi^4}
   \sum_{j\ge1}\frac{|T_j(X)|^2}{j^4}.}
 \tag{7}
\]

## Unconditional tail estimate

Let \(e(t)=e^{2\pi it}\), \(\alpha_j=j/(2X)\), and
\[
 U_j(X)=\sum_{X<n\le2X}\Lambda(n)e(\alpha_j(n-X)).
 \tag{8}
\]
Then \(\operatorname{Im}U_j=S_j\), where \(S_j\) is the prime sum in (3).
For the prefix convention
\[
 \mathcal S_N(\alpha)=\sum_{1\le n<N}\Lambda(n)e(n\alpha),
\]
the endpoint identity is
\[
 U_j(X)=e(-j/2)
 \left\{\mathcal S_{2X+1}(\alpha_j)
              -\mathcal S_{X+1}(\alpha_j)\right\}.
 \tag{9}
\]

Apply Maynard, Pandey, and Radziwill, Theorem 1.1, to each prefix with
\[
 a=0,\qquad q=1,\qquad \epsilon=\frac{j}{2X}.
\]
For \(1\le j\le\sqrt X\), its approximation condition holds for both prefix
lengths, and its parameter \(\max(1,Nj/(2X))\) is comparable to \(j\).
Consequently,
\[
 |T_j(X)|\ll X^{o(1)}
 \left(\frac{X}{\sqrt j}+X^{19/24}\right)+\frac{X}{j}
 \qquad(1\le j\le\sqrt X).
 \tag{10}
\]
For every integer \(1\le K\le X^{1/4}\), summing (10) yields
\[
 \sum_{K<j\le\sqrt X}\frac{|T_j(X)|^2}{j^4}
 \ll X^{2+o(1)}K^{-4}.
 \tag{11}
\]

It remains to control \(j>\sqrt X\). Set \(a_r=\Lambda(X+r)\) for
\(1\le r\le X\), extend it by zero on \(\mathbb Z/(2X)\mathbb Z\), and write
\[
 V_j=\sum_{r=1}^Xa_re(jr/(2X)).
\]
Discrete Parseval and the elementary estimate
\(\sum_{X<n\le2X}\Lambda(n)^2\ll X\log X\) give
\[
 \sum_{j=0}^{2X-1}|V_j|^2\ll X^2\log X.
 \tag{12}
\]
The sums \(V_j\) are periodic modulo \(2X\). Using (12) on the first period
and then grouping all later periods proves
\[
 \sum_{j>\sqrt X}\frac{|T_j(X)|^2}{j^4}\ll\log X.
 \tag{13}
\]
This is absorbed by the right side of (11). Hence
\[
 \boxed{
 \sum_{j>K}\frac{|T_j(X)|^2}{j^4}
 \ll X^{2+o(1)}K^{-4}}
 \qquad(1\le K\le X^{1/4}).
 \tag{14}
\]
Combining (7) and (14), the modes above \(K\) contribute
\[
 \frac{2X^3}{\pi^4}
 \sum_{j>K}\frac{|T_j(X)|^2}{j^4}
 \ll X^{5+o(1)}K^{-4}.
 \tag{15}
\]
At \(K=\lceil X^{1/4}\rceil\), this is
\(O_\varepsilon(X^{4+\varepsilon})\). The \(X^{o(1)}\) loss in (14) and
(15) comes from the cited theorem and has not been removed.

## Connection to the coarse primitive

The two-sided primitive energy is
\[
 \mathcal E_X=\int_0^X\left(P(u)^2+(M-P(u))^2\right)\,du.
 \tag{16}
\]
Substituting \(P(u)=Q(u)+(u/X)M\) gives
\[
 \mathcal E_X
 =2\lVert Q\rVert_2^2
 +2M\int_0^X(2u/X-1)Q(u)\,du
 +\frac{2X}{3}M^2.
 \tag{17}
\]
Since \(\lVert2u/X-1\rVert_2^2=X/3\), Cauchy-Schwarz and
\(2ab\le a^2+b^2\) imply
\[
 \boxed{\mathcal E_X\le3\lVert Q\rVert_2^2+XM^2.}
 \tag{18}
\]
Thus it is enough to prove
\[
 M^2\ll_\varepsilon X^{3+\varepsilon},
 \qquad
 \sum_{j\le X^{1/4}}
       \frac{|T_j(X)|^2}{j^4}
 \ll_\varepsilon X^{1+\varepsilon}.
 \tag{19}
\]
Equations (7), (14), and (18) then give
\(\mathcal E_X\ll_\varepsilon X^{4+\varepsilon}\), the analytic premise
used by `CoarsePrimitiveBound`.

The centered zero mode from the periodic decomposition is already contained
in \(Q\). If
\[
 Z=\frac1X\int_0^X P(u)\,du-\frac M2,
\]
then
\[
 Z=\frac1X\int_0^XQ(u)\,du,
 \qquad X|Z|^2\le\lVert Q\rVert_2^2.
 \tag{20}
\]
No separate estimate for \(Z\) is needed in (19). Compared with the periodic
Fourier reduction, the boundary sine basis replaces the cutoff
\(X^{1/3}\) by \(X^{1/4}\) and absorbs the centered zero mode. The terminal
bound and the low sine sum in (19) are still open.
