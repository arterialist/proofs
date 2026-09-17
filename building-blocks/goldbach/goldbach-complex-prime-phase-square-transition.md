# A prime-square phase transition in the complete Goldbach cut

Written arithmetic proof, 17 September 2026. A complex phase on every
generator below a moving square-root cutoff gives a nonnegative **Hermitian**
Goldbach cut. Unlike the real sign flip, its leading critical-scale energy
sees prime squares. The maximizing phase changes continuously until the
cutoff reaches $8\sqrt X/3$, where the real sign flip takes over. This is
an unconditional additive coupling of complete multiplicative histories,
not a centered Goldbach error bound or an RH proof.

## Exact finite energy

For fixed $c>0$, $X\ge4$, and $\theta\in\mathbb R$, put
$z=c\sqrt X$. Define the completely multiplicative phase

\[
 \chi(p)=\begin{cases}e^{i\theta},&p\le z,\\1,&p>z,\end{cases}
 \qquad \chi(p^k)=e^{ik\theta}\quad(p\le z).
 \tag{1}
\]

Let every von Mangoldt coefficient, including every proper prime power,
enter the ordered additive triangle:

\[
 G(X)=\sum_{a+b\le X}\Lambda(a)\Lambda(b),\qquad
 G_\chi^H(X)=\sum_{a+b\le X}\Lambda(a)\Lambda(b)
                    \chi(a)\overline{\chi(b)}.
 \tag{2}
\]

The triangle is symmetric under swapping $a,b$, so $G_\chi^H$ is real.
The unit-modulus identity gives the exact cut energy

\[
 \boxed{D_{c,\theta}(X):=G(X)-G_\chi^H(X)
 =\frac12\sum_{a+b\le X}\Lambda(a)\Lambda(b)
       |\chi(a)-\chi(b)|^2\ge0.}
 \tag{3}
\]

Both orientations and equality at $a+b=X$ are included. For
$\theta=\pi$, conjugation is immaterial and (3) reduces to the earlier
[real prime-history cut](goldbach-complete-prime-phase-cut-energy.md).
For a nonreal phase the conjugate in (2) is essential; the ordinary
holomorphic square $\sum\Lambda(a)\Lambda(b)\chi(a)\chi(b)$ is a
different observable and has no such cut sign.

The real-angle finite cut identity underlying (3), with the actual
mathlib `vonMangoldt` weights and the full ordered triangle, is formalized in
[GoldbachPrimePhaseCutFinite.lean](../../formalization/BuildingBlocks/GoldbachPrimePhaseCutFinite.lean).
The Lean phase is an arbitrary real index function; (1) is its arithmetic
specialization in the written proof, not a separately formalized
completely multiplicative construction. The same module proves the
nonnegative energy and the
pointwise decomposition used next. Its principal theorems compile with
only `propext`, `Classical.choice`, and `Quot.sound`.

## Separating one active prime power from two

Write $h(a)=1-\operatorname{Re}\chi(a)$ and
$j(a)=\operatorname{Im}\chi(a)$. Pointwise,

\[
 1-\operatorname{Re}(\chi(a)\overline{\chi(b)})
 =h(a)+h(b)-h(a)h(b)-j(a)j(b).
 \tag{4}
\]

Therefore, with $\psi(y)=\sum_{n\le y}\Lambda(n)$,

\[
 D_{c,\theta}(X)
 =2\sum_{a\le X}\Lambda(a)h(a)\psi(X-a)
 -\sum_{a+b\le X}\Lambda(a)\Lambda(b)
       \bigl(h(a)h(b)+j(a)j(b)\bigr).
 \tag{5}
\]

Both $h$ and $j$ vanish unless $a=p^k\le X$ with $p\le z$.
The complete mass of these possibly active coordinates is

\[
 M_z(X)=\sum_{\substack{p\le z,\ k\ge1\\p^k\le X}}\log p
 \ll_c\sqrt X+X^{1/3}\log(2X)=O_c(\sqrt X).
 \tag{6}
\]

The prime and square packets give the $\sqrt X$ terms; Chebyshev and
at most $O(\log X)$ higher exponents bound the rest. Since
$0\le h\le2$ and $|j|\le1$, the second line of (5) has absolute value
at most $5M_z(X)^2=O_c(X)$. The entire critical-order term thus comes
from the one-active-prime-power row in (5), without replacing the exact
two-active row by a sign assertion.

## Critical-scale asymptotic and prime squares

Let $u=\min(c,1)$ and $g(c)=u-u^3/3>0$. The prime number theorem
implies $\sup_{0\le y\le X}|\psi(y)-y|=o(X)$; hence replacing
$\psi(X-p^k)$ by $X-p^k$ in the active rows costs $o_c(X^{3/2})$,
uniformly in $\theta$. The $k\ge3$ rows cost
$O_c(X^{4/3}\log(2X))=o(X^{3/2})$. The two surviving rows are

\[
 \begin{aligned}
 \sum_{p\le c\sqrt X}(\log p)(X-p)
   &=(c+o(1))X^{3/2},\\
 \sum_{p\le u\sqrt X}(\log p)(X-p^2)
   &=\bigl(u-u^3/3+o(1)\bigr)X^{3/2}.
 \end{aligned}
 \tag{7}
\]

The second estimate follows by partial summation from the prime number
theorem in the form $\vartheta(y)=\sum_{p\le y}\log p\sim y$:
$\sum_{p\le u\sqrt X}p^2\log p
 =(u^3/3+o(1))X^{3/2}$. Thus

\[
 \boxed{\quad
 \frac{D_{c,\theta}(X)}{X^{3/2}}
 \longrightarrow A_c(\theta)
 :=2c(1-\cos\theta)+2g(c)(1-\cos2\theta).
 \quad}
 \tag{8}
\]

The convergence is uniform over real $\theta$: every discarded row was
bounded independently of the phase. At $\theta=\pi$, the square term
vanishes and $A_c(\pi)=4c$, recovering the real cut. At
$\theta=\pi/2$, prime squares contribute $4g(c)$, the same
$X^{3/2}$ order as the prime row.

The result also holds when (2) and (3) are restricted to **even additive
totals**. An odd total with two nonzero von Mangoldt weights has one
coordinate equal to a power of two. Its full weighted mass is
$O(X\log(2X))$; multiplying by the cut factor, at most $2$, remains
$o(X^{3/2})$. This parity reduction uses all odd prime powers and does
not assert an individual Goldbach representation.

## The maximizing phase

Set $x=\cos\theta\in[-1,1]$. Since
$1-\cos2\theta=2(1-x^2)$,

\[
 A_c(\theta)=2c(1-x)+4g(c)(1-x^2).
 \tag{9}
\]

This is a strictly concave quadratic in $x$. Its unconstrained maximum
is at $x_*=-c/[4g(c)]$. For $0<c\le1$,
$g(c)=c-c^3/3$ and $c<4g(c)$. For $c\ge1$,
$g(c)=2/3$, so $c<4g(c)$ exactly when $c<8/3$. Consequently

\[
 \boxed{\quad
 \max_{\theta} A_c(\theta)=
 \begin{cases}
 2c+4g(c)+c^2/[4g(c)],&0<c\le8/3,\\
 4c,&c\ge8/3,
 \end{cases}\quad}
 \tag{10}
\]

with agreement at $c=8/3$. Below the threshold the maximizing
phases have $\cos\theta=-c/[4g(c)]$ and are nonreal. At and above it,
the real sign flip $\theta=\pi$ is asymptotically optimal. Uniformity
in (8) also shows that the finite-$X$ maximum divided by $X^{3/2}$
converges to (10). For example at $c=1$, the optimal phase has
$\cos\theta=-3/8$, with coefficient $121/24$, exceeding the real
flip coefficient $4$.

This transition is caused exactly by the complete $p^2$ histories.
Dropping prime squares would erase the $g(c)$ term and predict the
wrong phase and threshold. It is a quantitative additive coupling of
prime generators, but its cut is a deterministic difference of two
uncentered Goldbach observables. Subtracting the common density main
term leaves the translated prime error from (5), so (8) does not bound
$G(X)-X^2/2$, prove binary Goldbach, or supply the RH-scale centered
heat estimate.
