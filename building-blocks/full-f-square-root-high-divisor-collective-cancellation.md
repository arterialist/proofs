# Collective cancellation of the square-root high-divisor source

2026-09-16. This is an unconditional, written estimate for the **complete**
signed high-divisor block of the actual first-clock factorial-ground score.
It identifies the complementary high-divisor sector which cancels the
rough-semiprime profile in
[the rough-sector note](full-f-square-root-rough-semiprime-covariance-obstruction.md).
The saving comes from the classical zero-free-region Mertens bound. It is
smaller than every logarithmic power, but does not reach any fixed power of
$X$ and gives no RH estimate. No Lean formalization is claimed.

Fix a finite clock $s$, with $p_s>0$, and let
$$
F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x,
\qquad F(x)\longrightarrow\kappa_F>0.
$$
The actual $F$ is continuous and satisfies
$F'(x)=-(\psi(x)-x)/x^2$ away from prime-power atoms. For $X$ large,
$D=\lfloor\sqrt X\rfloor$, and $X\le Y\le2X$, set
$$
w_Y(x)=\frac{p_s^2Y\log^2(x/Y)}{x^2F(x)}
       \mathbf1_{[Y,2Y)}(x),\qquad
a_D(n)=\sum_{\substack{d\mid n\\d\le D}}\mu(d)\log(n/d),
\qquad t_D(n)=\Lambda(n)-a_D(n).
$$
Write
$$
T_D(Y)=\sum_n t_D(n)w_Y(n),\qquad
L_D(Y)=\sum_n a_D(n)w_Y(n)-\int_Y^{2Y}w_Y(x)\,dx,
\qquad B(Y)=L_D(Y)+T_D(Y).
$$
All intervals and divisor cutoffs here are literal. Prime powers remain in
$\Lambda$, $\psi$, and $F$.

**Theorem.** There are constants $c,C_s>0$ such that, for all sufficiently
large $X$,
$$
\boxed{\quad
\sup_{X\le Y\le2X}\bigl(|T_D(Y)|+|L_D(Y)|+|B(Y)|\bigr)
\le C_s\exp(-c\sqrt{\log X}).
\quad}                                                     \tag{1}
$$
In particular, with
$\langle f,g\rangle_X=\int_X^{2X}f(Y)g(Y)\,dY/Y$,
each of the three complete energies is
$O_s(\exp(-2c\sqrt{\log X}))$ after decreasing $c$ if necessary.

**Proof.** The full Euler identity is
$\Lambda(n)=\sum_{d\mid n}\mu(d)\log(n/d)$. Therefore the high block has
the exact quotient grouping
$$
T_D(Y)=\sum_{m\ge2}(\log m)
              \sum_{d>D}\mu(d)w_Y(md).                    \tag{2}
$$
The sign in (2) is **positive**: $t_D$ is the omitted divisor tail. For
example, the two $d>D$ prime divisors of a $D$-rough semiprime together
give its negative coefficient. The $m=1$ term is zero, and the support
forces $m<2Y/D\le4X/D$.

Put $M_\mu(u)=\sum_{d\le u}\mu(d)$. The classical zero-free-region bound
gives, for some $c_0,C>0$,
$$
|M_\mu(u)|\le Cu\exp(-c_0\sqrt{\log u})
\qquad(u\ge2).                                         \tag{3}
$$
An explicit primary version is in
[Lee--Leong, *New explicit bounds for Mertens function and the reciprocal of
the Riemann zeta-function*](https://arxiv.org/abs/2208.06141).
Because $D\asymp\sqrt X$, (3) implies
$|M_\mu(u)|\ll u\eta_X$ for every $u\ge D$, where
$\eta_X=\exp(-c_1\sqrt{\log X})$ for a fixed $c_1>0$.

The actual-ground weight has the uniform bounded-variation estimates
$$
\|w_Y\|_\infty+\operatorname{Var}_{[Y,2Y]}w_Y
\ll_s X^{-1},\qquad X\le Y\le2X.                          \tag{4}
$$
Indeed $F$ is bounded away from zero on $[X,4X]$, and
$xF'(x)/F(x)=-(\psi(x)-x)/(xF(x))=O(1)$ almost everywhere there.
Direct differentiation of the formula inside $[Y,2Y)$ gives
$|w_Y'(x)|\ll_s X^{-2}$. The lower endpoint value is zero; the upper
endpoint has a downward jump of size $O_s(X^{-1})$. These observations
prove (4), including the literal half-open endpoint.

For each $m$ in (2), the function $d\mapsto w_Y(md)$ has the same
variation bound (4), and its support ends at $U=2Y/m\le4X/m$. Abel
summation on $d>D$, retaining the term at $D$ and the upper jump, gives
$$
\left|\sum_{d>D}\mu(d)w_Y(md)\right|
\ll_s \sup_{D\le u\le U}|M_\mu(u)|
       \bigl(\|w_Y\|_\infty+\operatorname{Var}w_Y\bigr)
\ll_s\frac{\eta_X}{m}.                                  \tag{5}
$$
The sum is empty when $U\le D$. Consequently
$$
|T_D(Y)|\ll_s\eta_X
\sum_{2\le m<4X/D}\frac{\log m}{m}
\ll_s\eta_X\log^2X
\ll_s\exp(-c_2\sqrt{\log X})                          \tag{6}
$$
uniformly in $Y$. No absolute value was taken over $\mu(d)$ before
Abel summation.

For completeness, the classical prime-number-theorem error gives
$E(x):=\psi(x)-x\ll x\exp(-c_3\sqrt{\log x})$. Since
$B(Y)=\int_{[Y,2Y)}w_Y\,dE$, exact Stieltjes integration by parts yields
$$
B(Y)=w_Y(2Y^-)E((2Y)^-)
       -\int_Y^{2Y}E(x)w_Y'(x)\,dx.                        \tag{7}
$$
The lower boundary vanishes because $w_Y(Y)=0$; the upper atom is
excluded, as required. Equations (4) and (7) give
$B(Y)\ll_s\exp(-c_4\sqrt{\log X})$. Finally $L_D=B-T_D$.
Taking the smallest decay constant and integrating over a shell of
logarithmic length $\log2$ proves (1) and the energy assertion. $\square$

## Exact cancellation of the rough profile

Let $U_R$ be the rough high-divisor score defined in the linked
rough-sector note: it retains $X\le n<4X$ with $P^-(n)>D$, including rough
squares. Put $H_R=T_D-U_R$; this is **all** complementary high-divisor
history, with no sign selection. Equation (1) immediately gives the
strong uniform relation
$$
\boxed{\quad H_R(Y)=-U_R(Y)+O_s(e^{-c\sqrt{\log X}})
\qquad(X\le Y\le2X).\quad}                                \tag{8}
$$
Thus the rough logarithmic-sized score must be canceled by the other
actual high-divisor coefficients, not by a scalar reassignment of the
continuous density.

The rough-sector profile from that note makes (8) quantitative. Define
$$
C_0=\int_1^2\frac{\log^2z}{z^2}\,dz,
\qquad C_1=\int_1^2\frac{\log^3z}{z^2}\,dz,
\qquad L=\log2,
\qquad A_s=\frac{2p_s^2}{\kappa_F}.
$$
Uniformly for $1\le v\le2$,
$$
U_R(vX)=-\frac{A_s}{\log X}(C_0\log v+C_1)
              +o_s(1/\log X),
\qquad
H_R(vX)=+\frac{A_s}{\log X}(C_0\log v+C_1)
              +o_s(1/\log X).                            \tag{9}
$$
In particular, with the strictly positive constant
$$
K_s=A_s^2\left(\frac{C_0^2L^3}{3}
                     +C_0C_1L^2+C_1^2L\right),
$$
the **signed** covariance satisfies
$$
(\log X)^2\|U_R\|_X^2\longrightarrow K_s,
\qquad
(\log X)^2\|H_R\|_X^2\longrightarrow K_s,
\qquad
(\log X)^2\langle U_R,H_R\rangle_X\longrightarrow-K_s.
                                                               \tag{10}
$$
The two positive sector energies and twice their negative cross term
cancel to the much smaller complete energy $\|T_D\|_X^2$ in (1).
This identifies the precise global cross covariance left open by a
separate rough-sector estimate.

For the positive density score $V(Y)=\int_Y^{2Y}w_Y(x)dx$, the same
relation also gives
$$
\langle H_R,V\rangle_X=-\langle U_R,V\rangle_X
                  +O_s(e^{-c\sqrt{\log X}}).
                                                               \tag{11}
$$
The leading coefficient on the left is positive and equals
$$
\frac{2p_s^4C_0}{\kappa_F^2\log X}
       \left(\frac{C_0L^2}{2}+C_1L\right)
       +o_s(1/\log X).
$$
The complementary sector also inherits the same nonconstant
$1/\log X$ profile after optimal scalar-density projection as the
rough sector, with the opposite sign.

## The far density cross cancels as well

The cancellation persists when the positive density is restricted to
points farther than a threshold $H$ from each atomic location. This
addresses the far pairing in the rough-sector note without dropping its
distance indicator. Let
$$
R_X(n,x)=\int_X^{2X}w_Y(n)w_Y(x)\,\frac{dY}{Y},\qquad
G_H(n)=\int_X^{4X}\mathbf1_{|n-x|>H}R_X(n,x)\,dx.
$$
For every $H\ge0$, uniformly in $X$,
$$
\boxed{\quad
\sum_n t_D(n)G_H(n)
=\iint_{|n-x|>H}R_X(n,x)\,d\tau_D(n)\,dx
\ll_s e^{-c\sqrt{\log X}},
\quad}                                                     \tag{12}
$$
where $d\tau_D=\sum_{X\le n<4X}t_D(n)\delta_n$. The left side of (12)
is signed; the displayed $\ll$ means an absolute-value bound.

Here is the variation check needed to apply the proof of (5). For each
$Y$, extend $w_Y$ by zero outside $[Y,2Y)$ and put
$$
N_{Y,H}(u)=\int_{u-H}^{u+H}w_Y(x)\,dx,
\qquad V(Y)=\int_{\mathbb R}w_Y(x)\,dx.
$$
Then $G_H(u)=\int_X^{2X}w_Y(u)[V(Y)-N_{Y,H}(u)]\,dY/Y$.
The nonnegative convolution $N_{Y,H}$ has
$\|N_{Y,H}\|_\infty\le V(Y)=O_s(1)$ and, uniformly in $H$,
$$
\operatorname{Var}_{\mathbb R}N_{Y,H}
\le\int_{\mathbb R}
  \bigl(|w_Y(u+H)|+|w_Y(u-H)|\bigr)du
=2V(Y)=O_s(1).
$$
Its derivative formula holds almost everywhere, including when a moving
boundary crosses the half-open endpoint. Equation (4), the product
variation inequality, and integration over $dY/Y$ therefore give
$$
\|G_H\|_\infty+\operatorname{Var}_{[X,4X]}G_H\ll_s X^{-1}
\qquad\text{uniformly for }H\ge0.                         \tag{13}
$$
Apply the exact divisor grouping (2) with $G_H$ in place of $w_Y$.
For each $m$, the support lies below $4X/m$, and Abel summation with
(3) and (13) again gives $O_s(\eta_X/m)$. Summing $\log m/m$ proves
(12). In particular no smallness condition such as $H=o(X)$ is needed
for the **complete** signed high-divisor pairing.

Let $\tau_R$ be the rough high-divisor measure from the linked note and
$\tau_C=\tau_D-\tau_R$. For $1\le H\le X/4$, the rough coefficients are
nonpositive, the selected semiprime/density rectangles in that note lie
strictly beyond $H$, and their contribution has size $\gg_s1/\log X$.
Its total variation is $O_s(X/\log X)$, while $\|G_H\|_\infty\ll_s1/X$.
Thus, uniformly in this range,
$$
\sum_n G_H(n)\,d\tau_R(n)\asymp_s-\frac1{\log X},
\qquad
\sum_n G_H(n)\,d\tau_C(n)
=-\sum_n G_H(n)\,d\tau_R(n)
 +O_s(e^{-c\sqrt{\log X}})
\asymp_s+\frac1{\log X}.                                   \tag{14}
$$
The complementary high-divisor histories therefore cancel the rough
**far** density cross too, including its literal distance cutoff.

The theorem is a collective cancellation at the classical PNT/Mertens
scale. Its error $e^{-c\sqrt{\log X}}$ is larger than $X^{-\delta}$ for
every fixed $\delta>0$. It therefore does not pay the complete score at
the RH scale or establish a fixed-power covariance estimate.
