# Square-root aggregation of the distinct-prime sign criterion

Positive aggregation over all multiples gives an eventual-sign criterion that preserves every zero multiplicity and separates the deterministic same-prime contribution by an extra logarithm. This is a written mathematical result. It is not a Lean formalization or an unconditional proof of its sign.

Use the actual von Mangoldt function, including every prime power, and define for real $x\ge1$
```math
\begin{aligned}
N(x)={}&\sum_{ab\le x}(x-ab)\Lambda(a)\Lambda(b)
-x^2\sum_{n\le x}\frac{\Lambda(n)}n
+\sum_{n\le x}n\Lambda(n)\\
&+\frac{x^2}{2}\log x+\frac{x^2}{4}-\frac14,\\
T(x)={}&\sum_{p^k\le x}(x-p^k)(k-1)(\log p)^2,
\qquad V(x)=N(x)-T(x).
\end{aligned}
\tag{1}
```
The sum defining $T$ can start at $k=2$. It is precisely the same-base part of the convolution, with all exponent pairs counted. Put
```math
\boxed{W(x)=\sum_{d\le x}\sqrt d\,V(x/d).}
\tag{2}
```
Then
```math
\boxed{\mathrm{RH}\iff W(x)<0\text{ for all sufficiently large real }x.}
\tag{3}
```
Eventual $W\le0$ is equivalent as well. Eventual $W\ge0$ is impossible. Under RH there is the stronger asymptotic
```math
\boxed{W(x)=-\frac16x^{3/2}\log^2x
+O(x^{3/2}\log x).}
\tag{4}
```
The converse proof needs no numerical upper bound on a zero sum, finite simplicity verification, or assumption on multiplicities or gaps.

The exact arithmetic identification is inherited from
$\sigma=\sum_n\Lambda(n)\delta_n-du-\delta_1$ on $[1,\infty)$. In particular,
$N(x)=\iint(x-ab)_+d\sigma(a)d\sigma(b)$, with the initial atom retained. Write
```math
G(s)=-\frac{\zeta'}{\zeta}(s)-\frac{s}{s-1},
\qquad
H(s)=\sum_p\frac{(\log p)^2p^{-2s}}{(1-p^{-s})^2}.
```
The first-Riesz calculation in the [distinct-prime sign criterion](distinct-prime-sign-criterion.md), by absolute Fubini for $\Re s>1$, gives
```math
\int_1^\infty V(x)x^{-s-2}dx
=F(s):=\frac{G(s)^2-H(s)}{s(s+1)}.
\tag{5}
```
Substitute $x=du$ into (2). The factor contributed by each summand is $d^{-s-1/2}$. Absolute Fubini is again justified by the total-variation bound for the measures in (1) and the convergent sum $\sum_d d^{-\Re s-1/2}$. Thus
```math
\boxed{\int_1^\infty W(x)x^{-s-2}dx
=\zeta(s+\tfrac12)F(s)\qquad(\Re s>1).}
\tag{6}
```

There is an essential reason for the shifted multiplier. Ordinary aggregation $\sum_d dV(x/d)$ multiplies (5) by $\zeta(s)$. At a zero of multiplicity $m$, that product has leading exponent $m-2$, so it loses the pole when $m\ge2$. By contrast, $\zeta(s+1/2)$ is holomorphic and nonzero throughout $\Re s>1/2$, by its absolutely convergent Euler product. If $\rho$ is any zero there, of any multiplicity $m$, the double-pole coefficient in (6) is
```math
\frac{m^2\zeta(\rho+1/2)}{\rho(\rho+1)}\ne0.
\tag{7}
```

The function $H$ is holomorphic on $\Re s>1/2$. The apparent singularity of $G$ at 1 is removable, and the zeta function has no real zero in $(0,1)$. Therefore the right side of (6) has no real singularity above $1/2$. Landau's theorem for the Laplace transform of an eventually one-signed function now proves the forward implication from either eventual sign. Indeed, setting $x=e^t$ gives the Laplace transform of $e^{-t}W(e^t)$. Polynomial growth gives an upper bound on its convergence abscissa, and a bounded initial interval contributes an entire function. Landau forces a real singularity at any finite abscissa. Consequently eventual one-sided sign would imply convergence, hence holomorphy, throughout $\Re s>1/2$. Equation (7) excludes every zero there; the functional equation gives RH. This is the established Landau mechanism used, for example, in [Suzuki's Proposition 1](https://arxiv.org/html/2411.07436).

The real endpoint fixes the sign orientation. Near $s=1/2$,
```math
H(s)=\frac1{4(s-1/2)^2}+O(1),\qquad
F(s)=-\frac1{3(s-1/2)^2}+O((s-1/2)^{-1}).
```
For the first identity, separate the $p^2$ terms and compare them with $(\log\zeta)''(2s)$; all remaining series converge locally. Since $\zeta(s+1/2)$ has residue one there, (6) has leading term
```math
-\frac1{3(s-1/2)^3}.
\tag{8}
```
If $W$ were eventually nonnegative, its convergent transform on the real interval $s>1/2$ would be bounded below by the contribution from a fixed compact initial interval. It could not tend to minus infinity as required by (8). This proves the unconditional exclusion of eventual nonnegativity.

Here is the conditional bound needed for (4). Assume RH and put $s=1/2+\varepsilon+it$, $0<\varepsilon\le1/4$. Then
```math
\boxed{
\int_{\mathbb R}
\frac{|\zeta(1+\varepsilon+it)|\,|G(1/2+\varepsilon+it)|^2}
{|(1/2+\varepsilon+it)(3/2+\varepsilon+it)|}\,dt
=O(\varepsilon^{-1}).}
\tag{9}
```
All implied constants are finite and independent of $\varepsilon$; no claim of a small numerical constant is needed.

First, uniformly for $|t|\ge3$,
$|\zeta(1+\varepsilon+it)|\ll\log(|t|+2)$.
This follows directly from [DLMF 25.2.8](https://dlmf.nist.gov/25.2.E8), truncating at an integer comparable to $|t|$: the finite sum is bounded by a harmonic sum, and the fractional-part remainder is $O(|s|N^{-\Re s})=O(1)$. This proof is uniform as $\varepsilon\downarrow0$.

Under RH the Hadamard-product decomposition gives
```math
G(1/2+\varepsilon+it)
=-\sum_{|\gamma-t|\le1}\frac{m_\rho}{\varepsilon+i(t-\gamma)}
+O(\log^2(|t|+2)).
\tag{10}
```
Here the zeros are distinct in the displayed sum and $m_\rho$ records multiplicity. The estimate is uniform in $\varepsilon$. It follows by grouping the remaining zeros into unit intervals in the convergent Hadamard combination $1/(s-\rho)+1/\rho$; the local zero count, with multiplicity, is $O(\log(|t|+2))$. These are also the zero-grouping estimates used in [Banks and Sinha, Lemma 3.2](https://arxiv.org/html/2209.11768).

Cauchy–Schwarz with multiplicity gives
```math
\left|\sum_{|\gamma-t|\le1}\frac{m_\rho}{\varepsilon+i(t-\gamma)}\right|^2
\ll\log(|t|+2)
\sum_{|\gamma-t|\le1}\frac{m_\rho}{\varepsilon^2+(t-\gamma)^2}.
```
Multiplying by the extra logarithmic weight in (9), then integrating and using Tonelli, bounds the large-height part by
```math
\frac C\varepsilon\sum_{|\gamma|\ge2}
\frac{m_\rho\log^2(|\gamma|+2)}{1+\gamma^2}
+C\int_3^\infty\frac{\log^5(t+2)}{t^2}\,dt.
\tag{11}
```
The zero sum converges by $N(T)=O(T\log T)$, with every multiplicity counted. Thus the additional weight does not invalidate the tail estimate.

On compact heights away from zero there are only finitely many zero ordinates. The multiplier is uniformly bounded, and the integral of each pole square is $O(1/\varepsilon)$. A sufficiently small neighborhood of $t=0$ is different: $\zeta(1/2)\ne0$, so $G$ is uniformly bounded there for all sufficiently small $\varepsilon$. The multiplier is at most $C+1/\sqrt{\varepsilon^2+t^2}$, giving $O(\log(1/\varepsilon))$. The remaining compact range of $\varepsilon$ has a uniform finite bound. These observations prove (9), including the multiplier's pole near the real endpoint.

Let $N_*(x)=\sum_{d\le x}\sqrt d\,N(x/d)$. Mellin inversion on $\Re s=c>1$ is absolutely convergent. Under RH its contour can be shifted to $1/2+\varepsilon$: the zeta multiplier has no pole in the strip, the singularity of $G$ at 1 is removable, and all zeros stay a fixed distance to the left. For fixed $\varepsilon$, the horizontal integrals tend to zero by (10), the zeta bound, and the denominator of degree two. Both vertical integrals converge absolutely. Taking absolute values and using (9) gives
```math
|N_*(x)|\ll x^{3/2+\varepsilon}/\varepsilon.
```
Choosing $\varepsilon=1/\log x$ proves
```math
N_*(x)=O(x^{3/2}\log x).
\tag{12}
```
This bounds the full expression (1), without a truncation of pole residues or a reciprocal-derivative estimate.

The deterministic source has the unconditional refinement
```math
T(u)=\frac13u^{3/2}\log u+O(u^{3/2})\qquad(u\ge1).
\tag{13}
```
For completeness, the quantitative PNT gives
$\sum_{p\le y}(\log p)^2=y\log y-y+O(y)$.
Integrating this at $y=\sqrt u$ proves (13) for the square terms. The terms with exponent at least three contribute $O(u^{4/3}\log^3u)=O(u^{3/2})$; all their multiplicities remain present. The quantitative PNT input is unconditional, as in [Johnston and Yang](https://arxiv.org/abs/2204.01980).
Consequently
```math
\begin{aligned}
\sum_{d\le x}\sqrt d\,T(x/d)
&=\frac{x^{3/2}}3\sum_{d\le x}\frac{\log(x/d)}d
+O\left(x^{3/2}\sum_{d\le x}\frac1d\right)\\
&=\frac16x^{3/2}\log^2x+O(x^{3/2}\log x).
\end{aligned}
\tag{14}
```
The error in (13) may be enlarged on the fixed initial compact interval, so this calculation also includes $x/d$ near one. Equations (12) and (14) prove (4), and therefore the other implication in (3).

The arithmetic form of (2) also explains the remaining difficulty. For $v=v_p(n)$, put
```math
A_p(n)=\sum_{k=1}^{v}p^{k/2},\quad
L(n)=\sum_{p\mid n}\log p\,A_p(n),\quad
Q(n)=\sum_{p\mid n}(\log p)^2A_p(n)^2.
```
Finite rearrangement of (1) gives the exact formula
```math
W(x)=B_*(x)+\sum_{n\le x}\frac{x-n}{\sqrt n}
\left[L(n)^2-Q(n)-\left(1+\frac xn\right)L(n)\right],
\tag{15}
```
where
```math
B_*(x)=\frac{x^2}{2}\sum_{d\le x}d^{-3/2}\log(x/d)
+\frac{x^2}{4}\sum_{d\le x}d^{-3/2}
-\frac14\sum_{d\le x}\sqrt d.
\tag{16}
```
The original aggregated same-prime coefficient is
```math
n^{-1/2}\sum_{p\mid n}(\log p)^2
\sum_{r=2}^{v_p(n)}(r-1)p^{r/2}.
```
It cancels from the full convolution before (15) is formed. It is not $Q(n)$, which is the algebraic diagonal of $L(n)^2$.

Actual weighted-divisor independence supplies no termwise sign for (15). If $D\mid n$ has probability proportional to $\sqrt D$, its prime exponents are independent. The variables
$X_p=(1+A_p(n))\log p\,1_{p\mid D}$ satisfy $\mathbb EX_p=\log p A_p(n)$ and zero mixed covariance. Nevertheless, with $r=1+x/n$, the bracket in (15) equals
```math
\mathbb E\left[\left(\sum_pX_p-r/2\right)^2\right]
-\sum_p\mathbb E[X_p^2]-r^2/4,
```
whose sign is not determined by variance nonnegativity. At $n=36,x=72$, put
$u=\log2(\sqrt2+2)>9/4$ and $v=\log3(\sqrt3+3)>9/2$. The bracket is
```math
2uv-3(u+v)=2(u-3/2)(v-3/2)-9/2>0.
```
For every prime-power $n<x$, the bracket is strictly negative. Thus the remaining unconditional task concerns the complete sum and its baseline. A termwise covariance domination cannot establish (3).

This construction uses the existing eventual-sign framework and makes no novelty claim. Its useful change is the shifted, positive multiplier: every multiplicity is preserved, and the RH-conditional main term follows with an unspecified finite analytic constant. The unconditional eventual negative sign remains open. This note has no Lean formalization.
