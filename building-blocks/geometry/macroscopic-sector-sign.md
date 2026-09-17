# Eventual negativity of the full macroscopic-prime sector

This written proof establishes a collective negative asymptotic for a complete arithmetic sector. It uses an unconditional classical PNT remainder and retains the density and cofactor terms. The complementary sector remains uncontrolled.

Let
$$
E(t)=\psi(t)-t,\qquad
J(u)=\int_1^u E(t)\,dt,\qquad
A(y)=\sum_{d<y}\sqrt d\,J(y/d).
$$
In particular $E(1)=-1$, $J(1)=0$, and $A(1)=0$. The endpoint
normalization is part of these definitions.

Let $W$ be the actual critical-scale readout defined in
[the allocation identity](../prime-distribution/prime-allocation-critical-identity.md). Let $W_>(x)$ denote its full contribution
from product states whose largest prime divisor exceeds $\sqrt x$.
The exact carrier recursion is
$$
W_>(x)=
\sum_{\sqrt x<p<x}\left[
\sqrt p\,W(x/p)+2p\log p\,A(x/p)
\right].
\tag{1}
$$
The sum is over actual primes. Both terms in each summand are retained.
All cofactor prime powers, density terms, and endpoint terms are included
in the functions on the right side.

The conclusion is
$$
\boxed{
W_>(x)=-(1+\gamma)\zeta(3/2)x^2+o(x^2)
\qquad(x\longrightarrow\infty).
}
\tag{2}
$$
Here $\gamma$ is Euler's constant. Consequently the full sector is
strictly negative for all sufficiently large $x$. This says nothing
about the sign of the complementary sector or of their sum $W(x)$.

## Derivation of the full carrier recursion

Write the [exact state readout](../prime-history/counting-birth-full-generator.md) as
$$
\mathcal D_x(n)=D_0(n)-(x/n-1)(S(n)-1)+R(x/n-1),
\quad W(x)=\sum_{n<x}\rho_x(n)\mathcal D_x(n).
$$
If $P^+(n)>\sqrt x$, there is exactly one such prime $p$, its exponent is one, and $n=pm$ with $m<x/p<p$. Put $y=x/p$ and $a=\sqrt p\log p$. All other prime coordinates are those of $m$, so
$$
\rho_x(pm)=\sqrt p\rho_y(m),\qquad
\mathcal D_x(pm)=\mathcal D_y(m)+a[2(S(m)-1)-(y/m-1)].
$$
The integrated prime error also has the exact expression
$$
J(u)=\sum_{b\le u}\Lambda(b)(u-b)-\frac{u^2-1}{2}.
$$
Substituting it into $A(y)$, grouping the first double sum by $m=db$ and retaining the density term, gives
$$
A(y)=\sum_{m<y}\rho_y(m)\left[S(m)-1-\frac{y/m-1}{2}\right].
$$
Indeed the density contribution at $m$ is exactly
$\sqrt m[(y/m)^2-1]/2=\rho_y(m)[1+(y/m-1)/2]$.
Summing the state identity over $m$ and then over the unique largest prime proves (1). Terms at the cutoff have zero weight. This derivation retains both parts of the carrier and every prime power in the cofactor.

## Unconditional bounds sufficient for the proof

We use ordinary PNT together with the classical remainder
$$
|E(t)|\ll \frac{t}{\log^4(2t)},\qquad t\ge1.
\tag{3}
$$
This is much weaker than the unconditional exponential remainder. For
example, Fiori, Kadiri, and Swidinsky prove an explicit bound of the form
$t(\log t)^{3/2}\exp(-c\sqrt{\log t})$, which implies (3) after enlarging
the constant on a bounded interval. Their primary source is
[Sharper bounds for the Chebyshev function](https://arxiv.org/abs/2204.02588).
No RH estimate is used.

Integrating (3) gives
$$
|J(u)|\ll \frac{u^2}{\log^4(2u)},\qquad u\ge1.
\tag{4}
$$
For example, split the defining integral at $\sqrt u$. On the lower
part the bound $E(t)\ll t$ costs $O(u)$; on the upper part the
logarithmic denominator is comparable to $\log^4(2u)$. Enlarging the
constant handles bounded $u$.

Equation (4) also implies
$$
|A(y)|\ll\frac{y^2}{\log^4(2y)}.
\tag{5}
$$
Indeed, in the range $d\le\sqrt y$, the logarithm in (4) is at least
a fixed multiple of $\log(2y)$, and
$$
\sum_{d\le\sqrt y}\sqrt d\,|J(y/d)|
\ll \frac{y^2}{\log^4(2y)}\sum_{d\ge1}d^{-3/2}.
$$
For $d>\sqrt y$, use $|J(y/d)|\ll(y/d)^2$. This contributes
$$
\ll y^2\sum_{d>\sqrt y}d^{-3/2}\ll y^{7/4},
$$
which is absorbed by (5).

We also need only the crude bound
$$
W(y)=O\!\left(y^2\log(2y)\right).
\tag{6}
$$
It follows directly from Chebyshev's bound. In the unscaled centered
tent expression, the positive ordered prime-power pair sum is at most
$$
y\sum_{a\le y}\Lambda(a)\psi(y/a)
\ll y^2\sum_{a\le y}\frac{\Lambda(a)}a
\ll y^2\log(2y).
$$
The same-prime term is a sub-sum of that positive pair sum. The density
cross term and explicit baseline satisfy the same bound. Finally,
summing over critical scales costs only
$$
\sum_{d\le y}\sqrt d\,(y/d)^2\log(2y/d)
\le y^2\log(2y)\sum_{d\ge1}d^{-3/2}.
$$

The functions $J$ and $A$ are continuous. For $A$, there are finitely
many summands on each bounded interval, and a newly appearing summand
at $y=d$ has value $\sqrt d\,J(1)=0$.

## The first carrier term is smaller than $x^2$

By (6),
$$
\begin{aligned}
\left|\sum_{\sqrt x<p<x}\sqrt p\,W(x/p)\right|
&\ll x^2\sum_{p>\sqrt x}p^{-3/2}\log(2x/p)\\
&\ll x^2\log(2x)\sum_{n>\sqrt x}n^{-3/2}\\
&\ll x^{7/4}\log(2x)=o(x^2).
\end{aligned}
\tag{7}
$$
The replacement by integers here is only a positive upper bound; it is
not a replacement of the prime measure in the main term.

## Convergence of the actual prime main term

We prove
$$
\boxed{
\frac1{x^2}\sum_{\sqrt x<p<x}p\log p\,A(x/p)
\longrightarrow\int_1^\infty A(y)\frac{dy}{y^3}.
}
\tag{8}
$$

First fix $Y\ge2$, and then take $x>Y^2$. On the fixed cofactor
range $1\le x/p\le Y$, put $z=p/x$. Ordinary PNT implies weak
convergence
$$
\frac{d\theta(xz)}x\longrightarrow dz
\quad\hbox{on }[1/Y,1].
$$
For example, this follows from the uniform convergence
$\theta(xz)/x\to z$ there, followed by approximation of continuous
test functions. Since $zA(1/z)$ is continuous,
$$
\begin{aligned}
\frac1{x^2}\sum_{x/Y<p<x}p\log p\,A(x/p)
&=\int_{(1/Y,1)}zA(1/z)\frac{d\theta(xz)}x\\
&\longrightarrow\int_{1/Y}^1zA(1/z)\,dz\\
&=\int_1^Y A(y)\frac{dy}{y^3}.
\end{aligned}
\tag{9}
$$
The upper endpoint has zero weight because $A(1)=0$. Including or
excluding the lower endpoint changes the normalized sum by at most
$O_Y(\log x/x)$, so it does not affect this fixed-$Y$ limit.

It remains to control the moving range $Y<x/p<\sqrt x$, uniformly
in $x$. Equation (5) gives
$$
\frac1{x^2}\sum_{\substack{\sqrt x<p<x\\x/p>Y}}
p\log p\,|A(x/p)|
\ll
\sum_{\substack{\sqrt x<p<x\\x/p>Y}}
\frac{\log p}{p\,\log^4(x/p)}.
\tag{10}
$$
Partition it into bands
$$
2^kY<x/p\le2^{k+1}Y,\qquad k\ge0.
$$
In one such band the primes belong to an interval $[T,2T]$, possibly
truncated by the actual lower cutoff $\sqrt x$. Chebyshev's bound gives
$$
\sum_{T\le p\le2T}\frac{\log p}{p}
\le\frac{\theta(2T)}T\ll1.
$$
Therefore the right side of (10) is at most
$$
\ll\sum_{k\ge0}\frac1{[\log Y+k\log2]^4}
\ll\frac1{\log^3Y}.
\tag{11}
$$
The constants do not depend on $x$. The integral tail satisfies the
matching estimate
$$
\int_Y^\infty |A(y)|\frac{dy}{y^3}
\ll\int_Y^\infty\frac{dy}{y\log^4y}
\ll\frac1{\log^3Y}.
\tag{12}
$$

Equations (9)--(12), with $x\to\infty$ first and $Y\to\infty$
second, prove (8). In particular, no dominated-convergence assertion
for a moving prime measure is being assumed without a uniform tail
bound.

## Evaluation of the signed integral and its endpoint constant

Equation (4) gives absolute convergence of
$\int_1^\infty |J(u)|u^{-3}du$. Hence
$$
\begin{aligned}
\int_1^\infty\sum_{d<y}\sqrt d\,|J(y/d)|\frac{dy}{y^3}
&=\sum_{d\ge1}d^{-3/2}
\int_1^\infty |J(u)|\frac{du}{u^3}\\
&<\infty.
\end{aligned}
$$
Signed Fubini is therefore legitimate, and
$$
\int_1^\infty A(y)\frac{dy}{y^3}
=\zeta(3/2)\int_1^\infty J(u)\frac{du}{u^3}.
\tag{13}
$$

Since $J(1)=0$ and $J(u)/u^2\to0$, ordinary integration by parts
gives
$$
\int_1^\infty J(u)\frac{du}{u^3}
=\frac12\int_1^\infty E(u)\frac{du}{u^2}.
\tag{14}
$$
The latter integral is absolutely convergent by (3).

For real $s>1$, the usual von Mangoldt Dirichlet series and Tonelli
give the exact formula
$$
\begin{aligned}
\int_1^\infty E(t)t^{-s-1}\,dt
&=\frac1s\sum_{n\ge1}\frac{\Lambda(n)}{n^s}
-\frac1{s-1}\\
&=\frac1s\left(-\frac{\zeta'}{\zeta}(s)\right)
-\frac1{s-1}.
\end{aligned}
\tag{15}
$$
Absolute integrability from (3) permits $s\downarrow1$ on the left.
On the right, use
$$
-\frac{\zeta'}{\zeta}(s)=\frac1{s-1}-\gamma+O(s-1).
$$
The factor $1/s$ contributes the additional constant $-1$:
$$
\boxed{
\int_1^\infty E(t)\frac{dt}{t^2}=-(1+\gamma).
}
\tag{16}
$$
Thus the endpoint normalization is not lost in taking the finite part.
Equivalently, (15) is
$s^{-1}[-\zeta'/\zeta(s)-s/(s-1)]$, the Mellin expression for
$d\psi-\delta_1-dt$.

Combining (13)--(16),
$$
\boxed{
\int_1^\infty A(y)\frac{dy}{y^3}
=-\frac{1+\gamma}{2}\zeta(3/2).
}
\tag{17}
$$

Finally, substitute (7), (8), and (17) into the exact recursion (1).
Its coefficient $2$ cancels the $1/2$ in (17), proving (2).

The result is a collective sign for this entire largest-prime sector.
It does not require individual product states or individual cofactors
to have a negative readout. The complementary sector is not estimated
by this proof.
