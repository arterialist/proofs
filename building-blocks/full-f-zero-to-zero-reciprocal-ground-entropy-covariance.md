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

For the oscillation input, see Montgomery and Vaughan,
[*Multiplicative Number Theory I*, Chapter 15, Theorem 15.11](https://personal.science.psu.edu/rcv4/personal/Publications/MNTI/19.0_pp_463_485_Oscillations_of_error_terms.pdf).
