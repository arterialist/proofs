# Negative first-window mass between prime-error zeros

2026-09-16. This is an unconditional signed identity for the actual
von Mangoldt source and its factorial ground. On intervals whose
endpoints are continuous zeros of the prime error, the ordinary-base
integral of the source-restricted first-window score is strictly
negative. It does not give a pointwise bound for the unrestricted
first-window score.

Write
$$
E(x)=\psi(x)-x,\qquad
F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x,
\qquad \kappa_F=\lim_{x\to\infty}F(x)>0,
$$
and put $h(x)=F(x)^{-1}-\kappa_F^{-1}$. The ground $F$ is positive
and continuous for $x>1$. On every compact interval away from $1$ it
is absolutely continuous, including across prime-power atoms, and
$$
F'(x)=-\frac{E(x)}{x^2},\qquad
h'(x)=\frac{E(x)}{x^2F(x)^2}
\quad\text{for almost every }x>1.                         \tag{1}
$$

**Theorem.** If $1<a<b$ and $E(a^-)=E(a)=E(b^-)=E(b)=0$, then
$$
\boxed{\quad
\sum_{a\le n<b}\frac{\Lambda(n)}{F(n)}
 -\int_a^b\frac{dx}{F(x)}
=\sum_{a\le n<b}\Lambda(n)h(n)-\int_a^b h(x)\,dx
=-\int_a^b\frac{E(x)^2}{x^2F(x)^2}\,dx<0.
\quad}                                                       \tag{2}
$$
There are infinitely many pairs $a<b$ satisfying these endpoint
conditions. Along a sequence of such pairs, the magnitude on the
right of (2) is at least
$$
\gg x_j^{-1/2}(\log\log\log x_j)^3                     \tag{3}
$$
for some $x_j\in(a,b)$ tending to infinity. The implicit constant
depends only on the classical Littlewood oscillation constant and a
tail upper bound for $F$.

To prove (2), use the signed measure
$dE=\sum_n\Lambda(n)\delta_n-dx$. The function $h$ is continuous at
every atom of $dE$. Stieltjes integration by parts on the literal
half-open interval gives
$$
\int_{[a,b)}h\,dE
=h(b)E(b^-)-h(a)E(a^-)-\int_a^b E(x)h'(x)dx.
$$
The endpoint terms vanish, and (1) gives the second equality in (2).
The first equality follows because
$\int_{[a,b)}dE=E(b^-)-E(a^-)=0$. The integral is
strictly positive before the minus sign: $E$ cannot vanish
identically on a nonempty interval, since between prime-power atoms
it has derivative $-1$.

For existence of the endpoints, recall that $E$ is right-continuous,
decreases with slope $-1$ between prime-power atoms, and has only
upward jumps, of size $\Lambda(n)>0$. Littlewood's unconditional
$E(x)=\Omega_\pm(x^{1/2}\log\log\log x)$ gives arbitrarily large
positive and negative values. After any positive value, choose a
later negative one. The first positive-to-nonpositive passage cannot
be an upward jump. It therefore crosses zero continuously between
atoms. Repeating this construction gives infinitely many continuous
positive-to-negative zeros, and any two of them supply $a,b$ for
(2).

For (3), choose $x_j\to\infty$ with
$A_j:=-E(x_j)\ge c x_j^{1/2}\log\log\log x_j$.
The monotonicity of $\psi$ gives
$$
E(x)\le E(x_j)+(x_j-x)\le-A_j/2
\quad(x_j-A_j/2\le x\le x_j).
$$
By PNT, $A_j=o(x_j)$. Choose a continuous positive-to-negative zero
$a_j$ before this negative interval and another such zero $b_j>x_j$.
There is no zero in $[x_j-A_j/2,x_j]$, so $a_j<x_j-A_j/2$.
Since $F$ is bounded above on a tail,
$$
\int_{a_j}^{b_j}\frac{E(x)^2}{x^2F(x)^2}dx
\ge\int_{x_j-A_j/2}^{x_j}\frac{E(x)^2}{x^2F(x)^2}dx
\gg \frac{A_j^3}{x_j^2},
$$
which proves (3).

The same covariance appears when one integrates actual first-window
scores over their bases. Fix $p_s>0$ and let
$$
w_Y^0(x)=\frac{p_s^2Y\log^2(x/Y)}{x^2}
             \mathbf 1_{[Y,2Y)}(x),
$$
$$
B_s^{[a,b)}(Y)=\int_{[a,b)}\frac{w_Y^0(x)}{F(x)}\,dE(x),
\qquad
B_0^{[a,b)}(Y)=\int_{[a,b)}w_Y^0(x)\,dE(x).
$$
The superscript restricts the **source** to $[a,b)$; within it every
prime power and the density term remain. For each fixed $x$, the
literal condition $x\in[Y,2Y)$ means $Y\in(x/2,x]$. Thus
$$
\int_0^\infty w_Y^0(x)dY
=p_s^2 J_0,\qquad
J_0=\int_0^{\log2}t^2e^{-2t}dt>0,                  \tag{4}
$$
independently of $x$. The lower endpoint $Y=x/2$ is excluded and
the upper endpoint $Y=x$ has zero weight; both are harmless for
ordinary $dY$ integration. Finite-variation Fubini and (2) yield
$$
\boxed{\quad
\int_0^\infty
 \left(B_s^{[a,b)}(Y)-\kappa_F^{-1}B_0^{[a,b)}(Y)\right)dY
=-p_s^2J_0\int_a^b\frac{E(x)^2}{x^2F(x)^2}dx<0.
\quad}                                                       \tag{5}
$$
The frozen score in (5) has zero ordinary-base integral, since the
same Fubini calculation gives
$$
\int_0^\infty B_0^{[a,b)}(Y)dY
=p_s^2J_0\int_{[a,b)}dE
=p_s^2J_0(E(b^-)-E(a^-))=0.
$$
Therefore the actual score itself satisfies
$$
\boxed{\quad
\int_0^\infty B_s^{[a,b)}(Y)dY
=-p_s^2J_0\int_a^b\frac{E(x)^2}{x^2F(x)^2}dx<0.
\quad}                                                       \tag{6}
$$
For consecutive zero intervals, these identities telescope exactly:
if $a=z_0<z_1<\cdots<z_N=b$ are continuous zeros, then the sum of
their source-restricted scores is $B_s^{[a,b)}$ pointwise, and their
negative entropy integrals add to the right side of (6).
Only bases $Y\in(a/2,b)$ can contribute. Equation (5) compares the
actual and frozen ground after source restriction and base averaging;
(6) is the stronger integrated sign for the actual score. Neither
identity gives a sign for $B_s(Y)$ at each base or an RH-scale bound
for the unrestricted score, whose windows can include source outside
$[a,b)$.

**Finite edge reversal for the actual prime source.** The source
restriction in (6) cannot be removed even after averaging over exactly
the bases that meet $[a,b)$. Define the unrestricted score
$$
B_s(Y)=\int_{[Y,2Y)}\frac{w_Y^0(x)}{F(x)}\,dE(x).
$$
Take
$$
a=\psi(103)
 =6\log2+4\log3+2\log5+2\log7
   +\sum_{\substack{11\le p\le103\\p\text{ prime}}}\log p,
\qquad b=\psi(107)=a+\log107.                         \tag{7}
$$
Exact log enclosures give
$103.2951607344<a<103.2951607345$ and
$107.9679895688<b<107.9679895690$. The only prime power in
$(103,107]$ is $107$, so $\psi$ is constant on $(103,107)$ and
$(107,108)$. In particular $a\in(103,104)$ and $b\in(107,108)$
are continuous zeros of $E$, and they are consecutive continuous
zeros.

Put $\Phi(t)=\int_0^t u^2e^{-2u}du$ and $J_0=\Phi(\log2)$.
Interchanging the ordinary base integral with the finite-variation
source measure gives
$$
\frac{1}{p_s^2}\int_{a/2}^{b}B_s(Y)dY
=\sum_{52\le p^k\le215}\frac{(\log p)K(p^k)}{F(p^k)}
  -\int_{51}^{216}\frac{K(x)}{F(x)}dx,                  \tag{8}
$$
where the 38 prime-power positions are
$53,59,61,64,67,71,73,79,81,83,89,97,101,103,107,109,113,121,125,
127,128,131,137,139,149,151,157,163,167,169,173,179,181,191,193,
197,199,211$, and
$$
K(x)=
\begin{cases}
\Phi(\log(2x/a)),&a/2\le x<a,\\
J_0,&a\le x<b,\\
J_0-\Phi(\log(x/b)),&b\le x<2b,\\
0,&\text{otherwise}.
\end{cases}                                             \tag{9}
$$
The interval $[51,216]$ in (8) merely contains the support of $K$.
The numerical-looking bounds below are **rational interval bounds**,
verified by the self-contained integer-arithmetic
[certificate](certificates/full_f_zero_interval_edge_counterexample.py):
$$
\sum_{52\le p^k\le215}\frac{(\log p)K(p^k)}{F(p^k)}
   >2.43299,
\qquad
M_{.01}:=\frac1{100}\sum_{j=0}^{16499}
  \frac{K(51+(j+1/2)/100)}{F(51+(j+1/2)/100)}
   <2.40154.                                             \tag{10}
$$
For $51\le x<216$ the same finite prime-power computation verifies
$F(x)>1$ and $|E(x)|<20$. Since $0\le K\le J_0<1/4$ and
$|K'(x)|\le1/x$ on each smooth piece, (1) implies
$$
\left|\left(\frac K F\right)'(x)\right|
 <\frac1{51}+\frac5{51^2}<\frac1{40}.
$$
The quotient $K/F$ is continuous across the prime-power atoms and the
four kernel breakpoints, so it is globally $1/40$-Lipschitz on
$[51,216]$. Composite midpoint quadrature therefore has error at
most $165/(4\cdot40\cdot100)=0.0103125$. Equations (8)--(10) prove
the strict opposite sign
$$
\boxed{\quad
\int_{a/2}^{b}B_s(Y)dY
>p_s^2(2.43299-2.40154-0.0103125)
>0.02p_s^2.
\quad}                                                    \tag{11}
$$
By (6), integrating $B_s^{[a,b)}$ over the same base interval gives
exactly the negative quantity on the right of (6). Thus the two edge
regions $[a/2,a)$ and $[b,2b)$ in source space can overturn the
interior entropy sign in the actual, unrestricted first window.

For the oscillation input, see Montgomery and Vaughan,
[*Multiplicative Number Theory I*, Chapter 15, Theorem 15.11](https://personal.science.psu.edu/rcv4/personal/Publications/MNTI/19.0_pp_463_485_Oscillations_of_error_terms.pdf).
