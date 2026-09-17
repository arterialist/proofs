# The first-window compensated quotient is an RH criterion

2026-09-16. Written inverse theorem and exact Type-I reduction; no
unconditional RH-scale estimate is proved. The result concerns the
actual factorial ground, every von Mangoldt prime power, the positive
first-block clock factor, and the literal half-open window. It isolates
the required low/high covariance in a rank-two compensated high-divisor
score. This is an RH-equivalent reorganization, not an unconditional
bound. The Mellin multiplier is the one already proved zero-free in
[the single-fiber criterion](factorial-f-ground-m2-fiber-rh-criterion.md).

Fix $p_s>0$ and put
$$
F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x,
\qquad E(x)=\psi(x)-x,
$$
$$
w_Y(x)=\frac{p_s^2Y\log^2(x/Y)}{x^2F(x)}
                \mathbf1_{[Y,2Y)}(x),
\qquad
B_s(Y)=\int_{[Y,2Y)}w_Y(x)\,dE(x).
$$
The ground $F$ is positive on $x>1$, continuous at prime-power atoms,
and tends to $\kappa_F>0$. Let $X$ run through dyadic values $2^k$,
$D=\lfloor\sqrt X\rfloor$, and $X\le Y\le2X$. Define
$$
A_D=\sum_{d\le D}\frac{\mu(d)}d,
\qquad B_D^\mu=\sum_{d\le D}\frac{\mu(d)\log d}{d},
$$
$$
T_D(Y)=\sum_n\left(\Lambda(n)-
\sum_{\substack{d\mid n\\d\le D}}\mu(d)\log(n/d)\right)w_Y(n),
\quad V(Y)=\int_Y^{2Y}w_Y(x)dx,
\quad M_1(Y)=\int_Y^{2Y}w_Y(x)\log x\,dx,
$$
and the **compensated high quotient**
$$
Q_D(Y)=T_D(Y)+A_D M_1(Y)-(B_D^\mu+1)V(Y).             \tag{1}
$$
Write $\|f\|_X^2=\int_X^{2X}|f(Y)|^2dY/Y$.

**Theorem.** The following statements are equivalent:

1. RH.
2. For every $\varepsilon>0$,
   $B_s(Y)=O_{s,\varepsilon}(Y^{-1/2+\varepsilon})$ for all real $Y\ge4$.
3. For every $\varepsilon>0$,
   $\|B_s\|_X^2=O_{s,\varepsilon}(X^{-1+\varepsilon})$ for every
   sufficiently large dyadic $X$.
4. For every $\varepsilon>0$,
   $\|Q_D\|_X^2=O_{s,\varepsilon}(X^{-1+\varepsilon})$ for every
   sufficiently large dyadic $X$, with $D=\lfloor\sqrt X\rfloor$.

The exact bridge between 3 and 4 is the unconditional, uniform identity
$$
\boxed{\quad B_s(Y)=Q_D(Y)+\mathcal E_D(Y),\qquad
|\mathcal E_D(Y)|\ll_s\frac{D\log(2X)}X
\ll_s X^{-1/2}\log(2X).
\quad}                                                     \tag{2}
$$
Thus the desired cancellation is between the **complete signed high
quotient** and its two continuous truncated-Möbius moments. Bounding
$T_D$ alone at the full-score scale is an unnecessarily strong target;
the [critical-zero barrier](full-f-square-root-high-divisor-critical-zero-barrier.md)
shows that it would fail under RH.

## The exact rank-two bridge

The Euler identity $\Lambda=\mu*\log$ gives, without approximation,
$$
B_s(Y)-T_D(Y)
=\sum_{d\le D}\mu(d)
      \sum_{m\ge1}\log m\,w_Y(dm)-V(Y).
$$
For each $d\le D$, compare the lattice sum with its spacing-$d$
integral. The exact integral equals
$$
\frac1d\int_Y^{2Y}\log(x/d)w_Y(x)dx.
$$
The first-block weight satisfies
$\|w_Y\|_\infty+\operatorname{Var}_{[Y,2Y]}w_Y\ll_s X^{-1}$
on the shell; its lower value is zero, while the half-open upper
endpoint is included in the variation. Hence the lattice error per
$d$ is $O_s(\log(2X)/X)$, including both partial endpoint cells.
Summing $d\le D$ gives (2), since the integral sum is
$A_DM_1-B_D^\mu V$. Consequently
$$
\|B_s-Q_D\|_X\ll_s X^{-1/2}\log(2X),              \tag{3}
$$
and statements 3 and 4 are equivalent after allowing every
$\varepsilon>0$.

## Mellin inverse for the actual first window

It remains to prove that statement 3 forces RH. Choose a fixed $a=4$.
On $[a,\infty)$ define the signed measure
$$
d\mathcal A(x)=F(x)^{-1}dE(x)
=\sum_{n\ge a}\frac{\Lambda(n)}{F(n)}\delta_n(dx)
  -\frac{dx}{F(x)}.
$$
Put $L=\log2$ and
$$
C(z)=\int_0^L t^2e^{(z-2)t}dt.
$$
The companion single-fiber theorem proves $C(z)\ne0$ on
$1/2\le\Re z\le5/4$ and
$|C(\sigma+i\tau)|\gg(1+|\tau|)^{-1}$ uniformly there.
For $\Re z>1$, set
$$
W_F(z)=\int_{[a,\infty)}x^{-z}d\mathcal A(x).
$$
Both atomic and density parts converge absolutely. Fubini with the
literal window gives
$$
\boxed{\quad
\int_a^\infty Y^{1-z}B_s(Y)\,\frac{dY}{Y}
=p_s^2 C(z)W_F(z)-p_s^2\mathcal B_a(z),
\quad}                                                     \tag{4}
$$
where the finite boundary correction is
$$
\mathcal B_a(z)=\int_{[a,2a)}x^{-z}
   \left(\int_{\log(x/a)}^L t^2e^{(z-2)t}dt\right)
                                      d\mathcal A(x).      \tag{5}
$$
To check (4), for a fixed $x\ge a$ the possible bases satisfy
$Y\in[a,\infty)\cap(x/2,x]$. Substitution $Y=xe^{-t}$ gives
$x^{-z}t^2e^{(z-2)t}dt$ with
$0\le t<\min(L,\log(x/a))$. For $x\ge2a$ this is the full
$C(z)$; for $a\le x<2a$, the omitted part is (5). The isolated upper
boundary $x=2Y$ has zero $dY$ measure. Since $d\mathcal A$ has finite
variation on $[a,2a]$, $\mathcal B_a$ is entire. Moreover,
$|x^{-z}e^{(z-2)t}|=x^{-\Re z}e^{(\Re z-2)t}$; absolute integration
over this finite interval bounds $\mathcal B_a$ uniformly in $\Im z$
on every fixed vertical strip.

Suppose statement 3. Cauchy--Schwarz on successive dyadic shells makes
the left side of (4) holomorphic on $\Re z>1/2$. Indeed its shell at
scale $X$ is bounded by
$X^{1-\Re z}\|B_s\|_X(\log2)^{1/2}$; choose an
exponent slack smaller than $\Re z-1/2$ and sum geometrically.
Division by the zero-free $C(z)$ therefore continues $W_F$ to
$\Re z>1/2$. On $3/4\le\Re z\le9/8$, choose the $\varepsilon$ in
statement 3 sufficiently small. The Mellin integral and (5) are then
uniformly bounded in $\Im z$, while $C(z)^{-1}=O(1+|\Im z|)$; hence
$$
W_F(\sigma+i\tau)=O_s(1+|\tau|)
\qquad(3/4\le\sigma\le9/8).                           \tag{6}
$$

For $x>a$, take the cubic Riesz mean of the weighted source,
$$
S_3(x)=\int_{[a,x)}(x-t)^3d\mathcal A(t)
=\frac6{2\pi i}\int_{(c)}
\frac{W_F(z)x^{z+3}}{z(z+1)(z+2)(z+3)}dz,
\qquad1<c<9/8.                                        \tag{7}
$$
The beta-kernel integral is absolutely valid on the initial line.
Equation (6) permits shifting it to $\Re z=3/4$; horizontal integrals
vanish because the integrand is $O(|\Im z|^{-3})$ on the fixed strip.
Thus $S_3(x)\ll_s x^{15/4}$.

Let $h=x^{15/16}$ and take the third forward difference of (7). An
atom at $t\le x$ contributes exactly $6h^3$ to
$\Delta_h^3(x-t)_+^3$; only $x<t<x+3h$ produces a boundary term, of
absolute size at most $O(h^3)$ per unit total variation. On this
interval the trivial source envelope gives
$$
|\mathcal A|([x,x+3h])\ll (h+1)\log(2x),             \tag{8}
$$
because $F$ is bounded below, each integer atom has
$\Lambda(n)\le\log(2x)$, and the continuous density is bounded.
Dividing the finite difference by $6h^3$ yields
$$
|\mathcal A([a,x])|
\ll_s x^{15/4}h^{-3}+h\log(2x)
\ll_s x^{15/16}\log(2x).                              \tag{9}
$$
An atom at $t=x$ changes the estimate by only $O(\log x)$.

Since $dE=F\,d\mathcal A$, Abel summation transfers (9) to a fixed
power bound for the actual prime error. The ground is bounded and
Chebyshev's elementary bound $\psi(x)=O(x)$ includes all prime powers.
Thus $E(x)=O(x)$ and $F'(x)=-E(x)/x^2=O(1/x)$ almost everywhere.
Consequently
$$
E(x)=O_\theta(x^\theta)
\quad\text{for every }\theta>15/16.                      \tag{10}
$$
No zero-free strip or RH estimate was used to obtain (10).

## Removing the ground and bootstrapping zeros

Fix one $15/16<\theta<1$ in (10). Since
$F(x)-\kappa_F=\int_x^\infty E(t)t^{-2}dt$,
$$
\delta(x):=F(x)^{-1}-\kappa_F^{-1}
=O_\theta(x^{\theta-1}),
\qquad\delta'(x)=O_\theta(x^{\theta-2})
\quad\text{a.e.}                                       \tag{11}
$$
Let $B_0(Y)$ denote the *unscaled* frozen-ground first-window score,
obtained from $B_s$ by replacing $F$ with $1$ but retaining $p_s^2$.
Stieltjes integration by parts of the difference gives
$$
B_s(Y)=\kappa_F^{-1}B_0(Y)
               +O_{s,\theta}(Y^{2\theta-2}).             \tag{12}
$$
Indeed the difference weight is
$p_s^2Y\log^2(x/Y)\delta(x)/x^2$. It is
$O(Y^{\theta-2})$, its derivative is $O(Y^{\theta-3})$ on
$[Y,2Y)$, and $E(x)=O(Y^\theta)$ there. The lower endpoint is zero;
the upper half-open boundary contributes
$O(Y^{2\theta-2})$ and the derivative integral the same.

The Mellin calculation (4) with $F=1$ says that the transform of
$B_0$ is $p_s^2 C(z)W_0(z)$ plus an entire finite correction, where
$$
W_0(z)=\int_{[a,\infty)}x^{-z}dE(x)
=-\frac{\zeta'(z)}{\zeta(z)}
  -\sum_{n<a}\Lambda(n)n^{-z}
  -\frac{a^{1-z}}{z-1}
\quad(\Re z>1).                                         \tag{13}
$$
The pole at $z=1$ cancels. Suppose currently
$E(x)=O(x^{1-\beta})$ for some $0<\beta<1/2$, while statement 3
holds. Equation (12) makes the difference
$B_s-\kappa_F^{-1}B_0$ pointwise $O(Y^{-2\beta})$.
Together with the assumed dyadic $L^2$ bound for $B_s$, this gives
$\|B_0\|_X=O_{s,q}(X^{-q})$ for every
$q<\min(1/2,2\beta)$. Cauchy--Schwarz on each dyadic shell and
geometric summation make the Mellin transform of $B_0$ holomorphic
on $\Re z>1-q$. Since $C(z)$ has no zero on this region below $1$,
(13) excludes every zeta zero with $\Re\rho>1-q$.
The classical truncated explicit formula for $\psi$, with the usual
zero count and endpoint bracketing, then improves (10) to
$E(x)=O_\varepsilon(x^{1-q+\varepsilon})$.
Choose a small exponent slack and repeat. Starting from any
$\beta<1/16$ supplied by (10), finitely many doublings reach
$\beta>1/4$; then $2\beta>1/2$ and the last pass excludes every zero
with $\Re\rho>1/2$. Functional-equation symmetry gives RH.

Conversely RH gives
$E(x)=O_\varepsilon(x^{1/2+\varepsilon})$. The weight and its total
variation on $[Y,2Y)$ are $O_s(Y^{-1})$, so Stieltjes integration by
parts gives statement 2. Statement 2 immediately gives statement 3,
and (2)--(3) give statement 4. The preceding argument gives
3 $\Rightarrow$ 1, completing the equivalences.

This is a criterion, not an unconditional estimate. The rank-two
compensation in (1) records exactly what a direct covariance proof
would need to make small: the switched high-divisor sum together with
the continuous Type-I moments, measured before any separate-sector
absolute values are taken.
