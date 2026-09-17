# Suzuki's Riesz signal as a Volterra functional of the actual factorial ground

Written calculation, 17 September 2026. This connects the actual positive
factorial ground to the first weighted Chebyshev sign criterion in
[Suzuki, *On variants of Chebyshev's conjecture*, Theorem 1](https://link.springer.com/article/10.1007/s11139-025-01238-9).
The [published correction](https://link.springer.com/article/10.1007/s11139-025-01289-y)
does not change that theorem. The finite-horizon sign below is unconditional
and uses every von Mangoldt prime power. It does not establish Suzuki's
eventual pointwise sign or RH.

Put
\[
 \psi(x)=\sum_{n\le x}\Lambda(n),\qquad
 F(x)=\log x-\sum_{n\le x}\frac{\Lambda(n)}n+\frac{\psi(x)}x,
 \qquad x\ge1.
\tag{1}
\]
The right-continuous actual $F$ has $F(1)=0$, is continuous at every
prime-power arrival, is strictly positive for $x>1$, and tends to
$\kappa_F=1+\gamma$. Between arrivals,
$F'(x)=-(\psi(x)-x)/x^2$. Define Suzuki's first Riesz signal
\[
 S(x)=\sum_{n\le x}\frac{\Lambda(n)}{\sqrt n}
                \log\frac{x}{n}-4\sqrt x.
\tag{2}
\]
The summand at $n=x$ is zero, so there is no half-atom convention in (2).
Suzuki proves that RH is equivalent to $S(x)\le0$ for every sufficiently
large $x$; the sign proved here is an averaged statement.

## Exact ground identity

For every real $x\ge1$,
\[
 \boxed{\quad
 S(x)=\frac14\int_1^x\frac{F(t)}{\sqrt t}
                 \log\frac{x}{t}\,dt
       -\sqrt x F(x)-\log x-4.
 \quad}
\tag{3}
\]
All endpoints in (3) are literal. At $x=1$, both sides equal $-4$.

Here is a derivation that keeps the atoms. Write
$A(t)=\sum_{n\le t}\Lambda(n)/n$, $E(t)=\psi(t)-t$, and
$k_x(t)=t^{-1/2}(1-\tfrac12\log(x/t))$. Finite Stieltjes integration by
parts, using that $\sqrt t\log(x/t)$ vanishes at $t=x$ and $A(1)=0$,
gives
\[
 \sum_{n\le x}\frac{\Lambda(n)}{\sqrt n}\log\frac{x}{n}
       =\int_1^x A(t)k_x(t)\,dt.
\]
Equation (1) says $A(t)=\log t+1+E(t)/t-F(t)$. Elementary integration
of its first two terms is exact:
\[
 \int_1^x(\log t+1)k_x(t)\,dt
      =4\sqrt x-\log x-4.
\]
Finally $E(t)/t=-tF'(t)$ almost everywhere. Integrating this term by
parts, with $F(1)=0$, and combining the remaining $-F k_x$ term gives
\[
 \int_1^x(E(t)/t-F(t))k_x(t)\,dt
   =-\sqrt xF(x)
     +\frac14\int_1^xF(t)t^{-1/2}\log(x/t)\,dt.
\]
Continuity of $F$ at the source atoms makes the ordinary integration
by parts valid with no hidden jump term. These formulas prove (3).

In logarithmic time let
\[
 u=\log x,\quad A_F(u)=e^{u/2}F(e^u)>0,\quad
 V_F(u)=\frac14\int_0^u(u-s)A_F(s)\,ds.
\]
Then (3) is the causal Volterra identity
\[
 S(e^u)=V_F(u)-A_F(u)-u-4,
 \qquad V_F''(u)=\tfrac14 A_F(u),\quad V_F(0)=V_F'(0)=0.
\tag{4}
\]
Thus the actual factorial ground is a positive forcing of a twofold
Volterra primitive, while the endpoint remains a signed subtraction.

## An unconditional finite-horizon phase constraint

For every $T>0$ and real $z\ge1/2$,
\[
 \boxed{\qquad
 \int_0^T e^{-zu}S(e^u)\,du<0.
 \qquad}
\tag{5}
\]
Indeed Fubini applied to (4) gives the exact formula
\[
 \begin{aligned}
 \int_0^T e^{-zu}S(e^u)\,du
 ={}&\int_0^T e^{-zs}A_F(s)
  \left\{\frac{1-(1+z(T-s))e^{-z(T-s)}}{4z^2}-1\right\}ds\\
 &-\int_0^T e^{-zu}(u+4)\,du .
 \end{aligned}
\tag{6}
\]
For $z\ge1/2$, the braces are nonpositive because
$0\le1-(1+y)e^{-y}<1$ for $y\ge0$ and $1/(4z^2)\le1$.
The last integral is strictly negative, proving (5). This retains the
entire finite prefix and the terminal Volterra factor; no limit or
eventual sign assumption is used.

At the boundary $z=1/2$, formula (6) is especially concrete. With
$X=e^T$ it becomes
\[
 \boxed{\quad
 \int_1^X S(x)x^{-3/2}\,dx
 =-\frac1{\sqrt X}\int_1^X\frac{F(t)}{\sqrt t}
       \left(1+\frac12\log\frac Xt\right)dt
   -12+\frac{2\log X+12}{\sqrt X}<0
 \quad(X>1).}
\tag{6a}
\]
Both terms on the right are negative: the first by $F>0$, and the
second since $(2T+12)e^{-T/2}<12$ for $T>0$.

The infinite-horizon identity for $z>1/2$ is
\[
 \boxed{\quad
 \int_0^\infty e^{-zu}S(e^u)\,du
  =\left(\frac1{4z^2}-1\right)
       \int_1^\infty F(x)x^{-z-1/2}\,dx
     -\frac1{z^2}-\frac4z<0.
 \quad}
\tag{7}
\]
Both integrals converge absolutely there, since $F$ is bounded and
$S(x)=O(\sqrt x\log x)$ follows directly from $\psi(x)=O(x)$.
Alternatively, absolute Dirichlet summation for $s=z+1/2>1$ gives
\[
 \int_0^\infty e^{-zu}S(e^u)\,du
   =-\frac1{z^2}\frac{\zeta'}{\zeta}(z+\tfrac12)
     -\frac4{z-1/2}.
\tag{8}
\]
The two versions agree exactly. The prime pole in (8) cancels at
$z=1/2$. Since $F(x)-\kappa_F$ is integrable against $dx/x$ by the
classical zero-free-region PNT error, (7) has the endpoint value
\[
 \int_0^\infty e^{-u/2}S(e^u)\,du
     =-4\kappa_F-12=-16-4\gamma.
\tag{9}
\]
The finite-horizon version at this endpoint is already negative by
(6), without invoking the PNT tail.

There is a separate **real-axis analytic-continuation sign** below the
damping threshold. Write $\eta(s)=(1-2^{1-s})\zeta(s)$. The established
[strict increase of $\eta(s)$ for real $s>0$](https://www.renyi.hu/~gharcos/dirichlet_eta.pdf)
implies that $(1-s)(-\zeta(s))$ increases strictly on $0<s<1$:
with $t=1-s$ it equals
$\eta(s)t/(2^t-1)$, and $t/(2^t-1)$ decreases in $t>0$.
Logarithmic differentiation therefore gives
\[
 \frac{\zeta'}{\zeta}(s)>\frac1{1-s}\qquad(0<s<1).
\tag{10}
\]
For $0<z<1/2$, put $s=z+1/2$. Since $4z^2<1$, (10) gives
\[
 \boxed{\quad
 -\frac1{z^2}\frac{\zeta'}{\zeta}(z+\tfrac12)
     -\frac4{z-1/2}<0 \qquad(0<z<1/2).
 \quad}
\tag{11}
\]
This is the continuation of the algebraic right side of (8), **not**
the value of its original Laplace integral: the PNT-scale bound does
not make that integral converge for $z<1/2$. It signs the transform
only at real parameters. A nonreal zeta zero would still create a
complex pole, so (11) supplies no zero-free strip.

The cutoff $z=1/2$ is sharp for an argument using only $F>0$. For
$0<z<1/2$, the limiting coefficient $1/(4z^2)-1$ in (7) is positive.
Start with the positive smooth ground $F_0(x)=\kappa(1-1/x)$, whose
signal defined by the right side of (3) is exactly
$S_{F_0}(x)=-(\kappa+1)\log x-4$. Add a nonnegative, nonzero smooth
bump $B$ supported in $(2,4)$ and replace $F_0$ by $F_0+M B$.
This keeps $F(1)=0$, positivity, and the positive limit $\kappa$.
The bump adds
$M(1/(4z^2)-1)\int_1^\infty B(x)x^{-z-1/2}dx>0$ to (7), so a
large $M$ reverses its sign. This is an abstract positive-ground
countermodel, not the actual von Mangoldt source. It identifies the
missing ingredient: a signed arithmetic phase estimate below the
$z=1/2$ damping threshold, or a pointwise comparison in (3).

Equation (3) is an exact interface between the already established
Suzuki criterion and this project's actual $F$-ground dynamics. The
unconditional cone (5) is weaker than Suzuki's eventual pointwise
inequality. Neither (3) nor (5) locates all zeta zeros, and their
analytic/measure-theoretic formalization in Lean remains open.
