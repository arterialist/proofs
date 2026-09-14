# The prime-state projector and its forced cutoff cancellation

Let

$$
P_x(n)=\frac{x-n}{\sqrt n\,Z_x},\qquad
Z_x=\sum_{n<x}\frac{x-n}{\sqrt n},
$$

and use the exact state readout

$$
\mathcal D_x(n)
=(S(n)-1)^2-\sum_pm_p(n)^2-z_x(n)(S(n)-1)+R(z_x(n)),
\qquad z_x(n)=x/n-1.
\tag{1}
$$

Thus $W(x)=Z_x\mathbb E_x\mathcal D_x$.  The uniform state hard wall
gives a polynomial projector converging exponentially to the indicator of
the prime states.  This note computes the contribution selected by that
projector and shows that it must be centered before it can see the RH
boundary layer.

## Exact prime-boundary formula

If $n=p$ is prime, then $S(p)=m_p(p)=\sqrt p\log p$.  Hence

$$
\mathcal D_x(p)
=\frac xp+R(x/p-1)-(1+x/p)\sqrt p\log p.
\tag{2}
$$

Define the unnormalized prime-state boundary

$$
B_{\mathbb P}(x)=
\sum_{p<x}\frac{x-p}{\sqrt p}\,\mathcal D_x(p).
\tag{3}
$$

Put

$$
P_{3/2}(x)=\sum_{p<x}p^{-3/2},\quad
L_{3/2}(x)=\sum_{p<x}(\log p)p^{-3/2},\quad
H_1(x)=\sum_{p<x}\frac{\log p}{p}.
$$

Then the following identity is exact for every real $x>2$:

$$
\boxed{
\begin{aligned}
B_{\mathbb P}(x)={}&x^2\left[
 \frac12P_{3/2}(x)\log x+\frac14P_{3/2}(x)
 -\frac12L_{3/2}(x)-H_1(x)\right]\\
&+\sum_{p<x}p\log p-\frac14\sum_{p<x}\sqrt p.
\end{aligned}}
\tag{4}
$$

### Proof

For $y=x/p$ the definition

$$
R(y-1)=\frac{y^2}{2(y-1)}\log y-\frac12-\frac34(y-1)
$$

gives

$$
\frac{x-p}{\sqrt p}R(x/p-1)
=\frac{x^2}{p^{3/2}}\left(\frac12\log\frac xp-\frac34\right)
 +\frac{x}{\sqrt p}-\frac{\sqrt p}{4}.
\tag{5}
$$

The first term of (2) contributes

$$
\frac{x-p}{\sqrt p}\frac xp
=\frac{x^2}{p^{3/2}}-\frac{x}{\sqrt p},
\tag{6}
$$

so the two $x/\sqrt p$ terms cancel.  Finally,

$$
-\frac{x-p}{\sqrt p}(1+x/p)\sqrt p\log p
=-\frac{x^2\log p}{p}+p\log p.
\tag{7}
$$

Summing (5)--(7) proves (4).

## Asymptotic size and sign

Let

$$
P(3/2)=\sum_pp^{-3/2},\qquad
L(3/2)=\sum_p(\log p)p^{-3/2},
$$

and let $B_1$ be the finite constant in

$$
H_1(x)=\log x+B_1+o(1).
$$

The prime number theorem and partial summation give

$$
\sum_{p<x}p\log p=\frac{x^2}{2}+o(x^2),qquad
\sum_{p<x}\sqrt p=o(x^2),
$$

while the tails of $P_{3/2}$ and $L_{3/2}$ contribute $o(x^2)$ in
(4).  Therefore

$$
\boxed{
B_{\mathbb P}(x)
=\left(\frac12P(3/2)-1\right)x^2\log x+C_{\mathbb P}x^2+o(x^2),
}
\tag{8}
$$

where

$$
C_{\mathbb P}
=\frac14P(3/2)-\frac12L(3/2)-B_1+\frac12.
\tag{9}
$$

The logarithmic coefficient is strictly negative.  Indeed

$$
P(3/2)<\sum_{n\ge2}n^{-3/2}<2,
$$

so $P(3/2)/2-1<0$.

## Forced composite compensation

Let $B_{\mathbb C}(x)$ be the same unnormalized sum over composite
states $n<x$.  The state projector proves that (3) and its composite
counterpart are exact spectral pieces of the allocation law, and

$$
W(x)=B_{\mathbb P}(x)+B_{\mathbb C}(x).
\tag{10}
$$

Since the complete centered readout satisfies $W(x)=o(x^2)$, (8) forces

$$
\boxed{
B_{\mathbb C}(x)
=\left(1-\frac12P(3/2)\right)x^2\log x
-C_{\mathbb P}x^2+o(x^2).
}
\tag{11}
$$

Thus the isolated prime boundary and uniformly gapped composite interior
cancel not only at order $x^2$, but first at the larger order
$x^2\log x$.  The hard-wall projector is therefore useful only after
orthogonalization against these two explicit cutoff modes.  A direct
positive estimate of either projected piece cannot reach the
$x^{3/2}\log^2x$ RH layer.

For projector degree $k$, writing $q_k(n)=r(n)^k$, the finite approximation
obeys

$$
\left|Z_x\mathbb E_x[q_k\mathcal D_x]-B_{\mathbb P}(x)\right|
\le c_*^k\sum_{\substack{n<x\\n\ {\rm composite}}}
\frac{x-n}{\sqrt n}|\mathcal D_x(n)|.
\tag{12}
$$

Consequently the correct next object is a **centered state projector**:
subtract from $q_k\mathcal D_x$ the explicit $x^2\log x$ and $x^2$
boundary modes in (8) before passing to large $k$.  Only that centered
projector can couple to the already centered quadratic prime error rather
than recreating the macroscopic cancellation state by state.
