# A second-order gap in the actual prime-density covariance

This note refines the leading-order compensation in
[Combined prime-density covariance](combined-prime-density-covariance.md).
All cutoffs are real and strict; a term at the cutoff has weight zero.
Every von Mangoldt prime power is included.

Write
\[
 Z_x=\sum_{n<x}\frac{x-n}{\sqrt n},\quad
 B(x)=\sum_{n<x}\frac{(x-n)^2}{n^{3/2}},\quad
 S(n)=\sum_{p^j\mid n}\Lambda(p^j)\sqrt{p^j},
\]
\[
 M(x)=\sum_{n<x}\frac{x-n}{\sqrt n}S(n),\qquad
 F(x)=B(x)/2-M(x)=Z_x(\beta(x)/2-\mu(x)).
\]
The actual all-prime-power mixed moments $D,T$ from the linked covariance
note satisfy, by exact divisor expansion,
\[
 Z_x\bigl(T(x)-D(x)/2\bigr)
   =\sum_{q=p^j<x}\Lambda(q)qF(x/q).                 \tag{1}
\]

**Theorem.** As $x\to\infty$ through all real values,
\[
 \boxed{T(x)-D(x)/2
   =\left(\frac{3\gamma\zeta(3/2)}8+o(1)\right)\sqrt x.} \tag{2}
\]
In particular, $T(x)>D(x)/2$ for every sufficiently large real $x$.
The threshold is not explicit.

**Proof.** Let $E(t)=\psi(t)-t$, $J(u)=\int_1^u E(t)\,dt$, and
$A(y)=\sum_{n<y}\sqrt n\,J(y/n)$. The exact score expansion and
$\int_1^u(t-1)\,dt=(u-1)^2/2$ give
\[
                         F(y)=-Z_y-A(y).             \tag{3}
\]
The signed integral theorem in
[Macroscopic sector sign](../geometry/macroscopic-sector-sign.md) proves
$\int_1^\infty A(y)y^{-3}dy=-(1+\gamma)\zeta(3/2)/2$, using the
unconditional prime number theorem. Direct nonnegative Fubini gives
$\int_1^\infty Z_y y^{-3}dy=\zeta(3/2)/2$. Consequently
\[
              \int_1^\infty F(y)y^{-3}dy
                    =\frac{\gamma\zeta(3/2)}2>0.    \tag{4}
\]
The quantitative prime number theorem yields
$F(y)\ll y^2(\log^{-4}(2y)+y^{-1/2})$.

For fixed $Y\ge2$, the prime number theorem for the *complete*
$\psi(t)=\sum_{q=p^j\le t}\Lambda(q)$ gives weak convergence of
$d\psi(xu)/x$ to $du$ on $1/Y\le u\le1$. The continuous test
$uF(1/u)$ vanishes at $u=1$; hence the part of (1) with $x/Y<q<x$,
divided by $x^2$, tends to $\int_1^Y F(y)y^{-3}dy$. For $q\le x/Y$,
divide into dyadic bands $2^kY<x/q\le2^{k+1}Y$. Chebyshev's bound
$\psi(v)\ll v$ gives $\sum_{U\le q\le2U}\Lambda(q)/q\ll1$, including
proper powers. The normalized absolute tail is therefore
\[
 O\!\left(\sum_{k\ge0}
   \bigl[\log^{-4}(2^kY)+(2^kY)^{-1/2}\bigr]\right)
 =O(\log^{-3}Y+Y^{-1/2}),
\]
uniformly in real $x$. Let $x\to\infty$, then $Y\to\infty$, and use
(4). The numerator in (1) is
$(\gamma\zeta(3/2)/2+o(1))x^2$. Since
$Z_x\sim(4/3)x^{3/2}$, equation (2) follows. ∎

The continuous density response has the **same** second-order term.
With $R_0(x)=Z_xE_xR(z)$ and $D_0(x)=Z_xD(x)$, finite Fubini gives
\[
 \boxed{R_0(x)-D_0(x)/2
     =x^2\int_1^x F(y)y^{-3}dy.}                  \tag{5}
\]
The scalar antiderivatives, moving real cutoff, $n=x$ endpoint, and
complete prime score in (5) are kernel checked in
[ActualVolterraIdentity.lean](../../formalization/BuildingBlocks/ActualVolterraIdentity.lean).
Equation (4) makes both sides of (1) and (5) asymptotic to the same
$\gamma\zeta(3/2)x^2/2$. Their difference $Z_x(E_xR-T)$ remains a
signed prime-error residual; (2) does not bound it at RH scale, sign
the original $W$, prove `CoarsePrimitiveBound`, or prove RH.

The Lean file formalizes (5), not the analytic PNT, weak-convergence,
or asymptotic steps proving (2). Those analytic steps have been
independently checked in writing; their Lean formalization remains open.
