# Adjacent Goldbach totals at a fixed cutoff

This audit changes the **additive total** $N$ to $N+1$ while retaining the
same finite source cutoff $Y$. It is distinct from shifting every source
index in the heat sum.

Put $a_n=\Lambda(n)-1$ and

$$
c_Y(N)=\sum_{\substack{1\leq m,n\leq Y\\m+n=N}}a_ma_n.
$$

For every $Y\geq1$ and every $N$, partition the pairs by the second
index. Those with $1\leq n\leq Y-1$ form the derivative core; the new
$n=1$ pair is born at total $N+1$; and the old $n=Y$ pair departs. The
exact identity is

$$
\boxed{
\begin{aligned}
c_Y(N+1)-c_Y(N)
={}&\sum_{\substack{1\leq m\leq Y\\1\leq n\leq Y-1\\m+n=N}}
 a_m\bigl(\Lambda(n+1)-\Lambda(n)\bigr)\\
&+\mathbf1_{1\leq N\leq Y}\,a_Na_1
-\mathbf1_{Y+1\leq N\leq2Y}\,a_{N-Y}a_Y.
\end{aligned}}
\tag{1}
$$

Here $a_1=-1$. The derivative retains every prime-power jump, including
the neighboring values of $\Lambda$ on both sides of a proper prime
power. The birth and departure conditions are exact at $N=Y$ and
$N=Y+1$; neither face is present outside its stated range. Equation (1)
is finite algebra and does not assume a sign for the derivative or the
faces.

## What adjacent even/odd pairing can prove

The two consecutive totals of an even/odd pair have opposite parity, but
their centered coefficients have no shared sign. At the *same* cutoff
$Y=3$, the first pair is positive:

$$
c_3(2)=1,
\qquad c_3(3)=2(1-\log2)>0.
\tag{2}
$$

The next pair is negative:

$$
c_3(4)<0,
\qquad c_3(5)=2(\log2-1)(\log3-1)<0.
\tag{3}
$$

The total-four proof includes the ordered pairs $(1,3),(2,2),(3,1)$;
the total-five proof keeps the two endpoint pairs $(2,3),(3,2)$.
For $T>0$, the actual shell kernel

$$
K_T(N)=\frac{e^{-Ne^{-2T}}-e^{-Ne^{-T}}}{N}
$$

is strictly positive. Thus the weighted pairs
$c_3(2)K_T(2)+c_3(3)K_T(3)$ and
$c_3(4)K_T(4)+c_3(5)K_T(5)$ also have opposite signs **for every**
$T>0$. A universal coefficientwise or adjacent-pair sign cannot upper
bound the centered shell. A useful pairing would need quantitative
cross-pair cancellation at the actual kernel weights.

## The odd-total asymptotic, with its exact scope

For an odd total $N$, exactly one index of an ordered pair is even. If
$\Lambda(2r)\ne0$, then $2r=2^k$ for some $k\geq1$ and its weight is
$\log2$. Therefore the *bounded* prime-prime coefficient has the exact
form

$$
\boxed{
P_Y(N)=2\log2
\sum_{\substack{k\geq1\\2^k\leq Y\\1\leq N-2^k\leq Y}}
\Lambda(N-2^k)
\qquad(N\ \mathrm{odd}).
}
\tag{4}
$$

The two inequalities on $2^k$ and $N-2^k$ retain both cutoff faces.
The sum retains all odd prime powers in $\Lambda(N-2^k)$. Since there are
at most $\log N/\log2$ admissible exponents and
$\Lambda(j)\leq\log N$ for $1\leq j<N$, equation (4) gives
$0\leq P_Y(N)\leq2(\log N)^2$ for odd $N\geq3$, uniformly in $Y$.

For an **interior** odd total $N\leq Y+1$, the bounded centered
coefficient equals the complete one:

$$
c_Y(N)=P_Y(N)-2\psi(N-1)+(N-1).
\tag{5}
$$

The classical prime number theorem $\psi(x)=x+o(x)$, together with the
bound after (4), yields

$$
c_Y(N)=-N+o(N)
\quad\text{as odd }N\to\infty\text{ with }Y\geq N-1.
\tag{6}
$$

This is an unconditional analytic consequence of PNT, not a statement
about a *fixed* cutoff or about transition totals $Y+2\leq N\leq2Y$.
It shows that the odd centered coefficients are eventually negative in
the interior. The positive heat square must retain compensation from
the other totals; equations (2)--(3) show that adjacent pairing alone
does not provide a uniform sign certificate.

## Lean scope

[CenteredGoldbachAdjacentTotalsFinite.lean](../../formalization/BuildingBlocks/CenteredGoldbachAdjacentTotalsFinite.lean)
formalizes the generic moving-face identity and its literal centered
$\Lambda(n+1)-\Lambda(n)$ core; the odd prime-prime coefficient equals
twice the bounded even-index row; and both unweighted and actual-kernel
weighted adjacent-pair sign counterexamples (2)--(3). The existing
[GoldbachOddCentering.lean](../../formalization/BuildingBlocks/GoldbachOddCentering.lean)
certifies that every nonzero even von Mangoldt coefficient comes from a
power of two. Formula (4)'s explicit $k$ reindex and the PNT consequence
(6) are written mathematics, not theorems in the new Lean module. Public
axiom reports list only `propext`, `Classical.choice`, and `Quot.sound`.
