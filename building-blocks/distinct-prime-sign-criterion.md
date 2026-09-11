# An eventual-sign criterion from the distinct-prime convolution

This note proves an equivalence between the Riemann hypothesis and eventual negativity of a centered multiplicative convolution after subtracting the contributions from powers of the same prime. The eventual sign remains unproved unconditionally. The argument is a written mathematical proof, with no Lean formalization. Exact publication priority is unresolved; no originality claim is made.

Let $\Lambda$ be the usual von Mangoldt function, including every prime power, and let $x\geq1$ be real. Define

```math
\begin{aligned}
N(x)={}&\sum_{ab\leq x}(x-ab)\Lambda(a)\Lambda(b)
-x^2\sum_{n\leq x}\frac{\Lambda(n)}n
+\sum_{n\leq x}n\Lambda(n)\\
&+\frac{x^2}{2}\log x+\frac{x^2}{4}-\frac14,
\end{aligned}\tag{1}
```

where all summation variables are positive integers. In particular, the third term is $\sum n\Lambda(n)$. Put

```math
P(n)=\Lambda(n)\bigl(\log n-\Lambda(n)\bigr),\qquad
B(x)=\sum_{n\leq x}(x-n)P(n),\qquad
N_{\rm dist}(x)=N(x)-B(x).\tag{2}
```

Then

```math
\boxed{\mathrm{RH}\quad\Longleftrightarrow\quad
N_{\rm dist}(x)<0\text{ for all sufficiently large real }x.}\tag{3}
```

The condition with eventual $N_{\rm dist}(x)\leq0$ is equivalent as well. Eventual $N_{\rm dist}(x)\geq0$ is impossible.

The only hypothesis in the implication from RH to eventual negativity is RH. The other inputs are classical unconditional results: the prime number theorem, Landau's theorem for Laplace transforms of eventually nonnegative functions, the Hadamard product and functional equation of $\xi$, local zero counting, explicit zero-count bounds, and rigorous verification of low zeros. The proof neither assumes simplicity above the verified height nor uses linear independence of zero ordinates or moments of $1/\zeta'(\rho)$.

## The exact measure and Mellin transform

On $[1,\infty)$, use the locally finite signed measure

```math
d\nu(u)=\sum_{n\geq1}\Lambda(n)\,\delta_n(du)-du-\delta_1(du).
\tag{4}
```

Its cumulative mass is $\nu([1,x])=\psi(x)-x$, including at $x=1$. Thus the initial atom is $-\delta_1$. For every fixed $x$, all the following product-measure integrals take place in the compact square $[1,x]^2$:

```math
N(x)=\iint (x-ab)_+\,d\nu(a)\,d\nu(b).\tag{5}
```

To verify (5), the atomic-atomic term is the first sum in (1). The atomic-density and atomic-initial terms together are

```math
-2\sum_{n\leq x}\Lambda(n)\int_1^{x/n}(x-nt)\,dt
-2\sum_{n\leq x}(x-n)\Lambda(n)
=-x^2\sum_{n\leq x}\frac{\Lambda(n)}n+\sum_{n\leq x}n\Lambda(n).
```

The density-density contribution is
$x^2\log x/2-3x^2/4+x-1/4$. The density-initial contribution is $(x-1)^2$, and the initial-initial contribution is $x-1$. Their sum is the last three terms of (1). At an upper endpoint $ab=x$, the kernel is zero; no choice of half-weight is needed.

Set

```math
L(s)=-\frac{\zeta'}{\zeta}(s),\qquad
G(s)=L(s)-\frac{s}{s-1}=L(s)-\frac1{s-1}-1.
\tag{6}
```

For $\sigma=\Re s>1$,

```math
\int_1^\infty u^{-s}\,d\nu(u)=G(s),\qquad
\int_1^\infty u^{-\sigma}\,d|\nu|(u)<\infty.
```

The elementary kernel integral is

```math
\int_{ab}^\infty (x-ab)x^{-s-2}\,dx
=\frac{(ab)^{-s}}{s(s+1)}.
```

Applying the same formula with the real exponent $\sigma$ proves absolute integrability against $|\nu|\otimes|\nu|$. Fubini therefore gives the actual identity

```math
\int_1^\infty N(x)x^{-s-2}\,dx=\frac{G(s)^2}{s(s+1)}
\qquad(\Re s>1).
\tag{7}
```

In particular, the constant $-1$ in (6) cannot be removed.

At $n=p^a$, one has $P(n)=(a-1)(\log p)^2$; at other integers $P(n)=0$. This is exactly the part of $(\Lambda*\Lambda)(n)$ in which the two factors are powers of the same prime. Consequently

```math
H(s):=\sum_n\frac{P(n)}{n^s}
=\sum_p\frac{(\log p)^2p^{-2s}}{(1-p^{-s})^2}
=\sum_{a\geq2}(a-1)\sum_p(\log p)^2p^{-as}.
\tag{8}
```

These series converge absolutely and locally uniformly for $\Re s>1/2$. The same positive-kernel Fubini calculation gives

```math
\int_1^\infty N_{\rm dist}(x)x^{-s-2}\,dx
=F(s):=\frac{G(s)^2-H(s)}{s(s+1)}
\qquad(\Re s>1).
\tag{9}
```

## The real pole and Landau's implication

Write $Q(z)=\sum_p(\log p)^2p^{-z}$. Near $s=1/2$,

```math
H(s)=(\log\zeta)''(2s)+R(s),\tag{10}
```

with $R$ holomorphic there. Indeed, the terms of (8) with $a\geq3$ converge locally uniformly in $\Re s>1/3$, while

```math
Q(2s)=(\log\zeta)''(2s)
-\sum_{p,j\geq2}j(\log p)^2p^{-2js},
```

and the last series converges in $\Re s>1/4$. The notation $(\log\zeta)''$ means the meromorphic derivative of $\zeta'/\zeta$, and does not require a global logarithm. The Laurent expansion of $\zeta$ at 1 gives

```math
H(s)=\frac1{4(s-1/2)^2}+O(1).
```

Since $\zeta(1/2)\ne0$, (9) has real leading coefficient

```math
F(s)=-\frac1{3(s-1/2)^2}+O\bigl(|s-1/2|^{-1}\bigr).
\tag{11}
```

Only local continuation near the real point is asserted here. Continuations farther left can encounter zeros of $\zeta(2s)$.

There is no real singularity of $F$ at any real $s>1/2$. In particular, $G$ has a removable singularity at 1. The absence of real zeros of $\zeta$ in $(0,1)$ follows, for example, from the positive alternating eta series and $\zeta(s)=\eta(s)/(1-2^{1-s})$.

Suppose $N_{\rm dist}$ is eventually of one sign. The functions in (1) and (2) have polynomial growth, so their Mellin integrals have a finite upper bound for the abscissa of convergence. With $x=e^u$, (9) becomes a Laplace transform of $e^{-u}N_{\rm dist}(e^u)$. Discarding a bounded initial interval changes that transform by an entire function. Landau's theorem, in the Mellin form stated in [Suzuki, Proposition 1](https://arxiv.org/html/2411.07436#S2.SS4), says that a finite abscissa for a nonnegative Laplace integrand is a singular point on the real axis. The same applies after changing the sign of an eventually nonpositive integrand. Since there is no real singularity above $1/2$, the abscissa is at most $1/2$, or is $-\infty$.

If $\rho$ were a zero with $\Re\rho>1/2$, of multiplicity $m$, then $G$ would have principal part $-m/(s-\rho)$. The function $H$ is holomorphic there. Thus $F$ would have the uncancelled double-pole coefficient

```math
\frac{m^2}{\rho(\rho+1)}.
```

This contradicts holomorphy of the convergent transform throughout $\Re s>1/2$. The functional equation now gives RH. The numerator is positive; the displayed coefficient at a nonreal zero is generally complex.

If the eventual sign had been nonnegative, the transform for real $s>1/2$ would be bounded below, uniformly as $s\downarrow1/2$, by the integral over a fixed initial compact interval. Equation (11) makes it tend to $-\infty$. Hence eventual nonnegativity is impossible.

## The weighted boundary estimate under RH

Assume RH for the proof of eventual negativity. Let the sums below run over distinct nontrivial zeros, both positive and negative ordinates, and let $m_\rho$ be their multiplicities. Define

```math
C_2=\sum_{\rho}\frac{m_\rho^2}{|\rho(\rho+1)|},\qquad
w_\varepsilon(t)=\frac1{|(1/2+\varepsilon+it)(3/2+\varepsilon+it)|}.
```

We prove, rather than assume, the precise estimate needed:

```math
\lim_{\varepsilon\downarrow0}\varepsilon
\int_{\mathbb R}|G(1/2+\varepsilon+it)|^2w_\varepsilon(t)\,dt
=\pi C_2.
\tag{12}
```

First, local zero counting gives $N(t+1)-N(t-1)=O(\log(t+2))$, with multiplicities included. In particular $m_\rho=O(\log(|\gamma|+2))$, so $C_2$ converges. The Hadamard product for $\xi$, together with the elementary gamma-factor estimates, gives uniformly for $0<\varepsilon\leq1/4$ and $|t|\geq3$

```math
G(1/2+\varepsilon+it)
=-\sum_{|\gamma-t|\leq1}
\frac{m_\rho}{\varepsilon+i(t-\gamma)}
+O\bigl(\log^2(|t|+2)\bigr).
\tag{13}
```

Here is sufficient detail for the uniformity in this familiar local decomposition. Start with the convergent Hadamard combination $1/(s-\rho)+1/\rho=s/[\rho(s-\rho)]$. Outside $|\gamma-t|\leq1$, group zeros in unit intervals and use the local count. Zeros with $|\gamma|\leq|t|/2$ contribute $O(\log^2(|t|+2))$; those with comparable height and distance at least 1 contribute the harmonic sum $O(\log^2(|t|+2))$; those with $|\gamma|>2|t|$ contribute $O(\log(|t|+2))$ by the convergent bound $O(|t|/\gamma^2)$. None of these bounds depends on $\varepsilon$. The omitted gamma and rational factors satisfy the same error bound. The zero grouping and Hadamard estimates also appear in the proof of Lemma 3.2 of [Banks and Sinha](https://arxiv.org/html/2209.11768).

For the compact part of (12), take a fixed interval with endpoints that are not zero ordinates. It contains finitely many distinct zeros. In disjoint neighborhoods of their ordinates,

```math
G(1/2+\varepsilon+it)
=-\frac{m_\rho}{\varepsilon+i(t-\gamma)}+O(1).
```

The bounded term here can depend on the chosen finite neighborhoods. The Poisson-kernel identity
$\varepsilon\int_{\mathbb R}(\varepsilon^2+u^2)^{-1}\,du=\pi$
and continuity of $w_\varepsilon$ give the contribution $\pi m_\rho^2w_0(\gamma)$. Cauchy–Schwarz makes the cross term with the bounded remainder tend to zero. On the remaining compact set, $G$ is bounded, so its contribution also tends to zero. This step requires neither a lower bound for gaps nor any bound for a reciprocal derivative.

It remains to justify passing from compact intervals to the whole line. Put $M(t)=\sum_{|\gamma-t|\leq1}m_\rho\ll\log(|t|+2)$. Cauchy–Schwarz applied to the sum in (13), counting each zero with its multiplicity, gives

```math
\left|\sum_{|\gamma-t|\leq1}
\frac{m_\rho}{\varepsilon+i(t-\gamma)}\right|^2
\leq M(t)\sum_{|\gamma-t|\leq1}
\frac{m_\rho}{\varepsilon^2+(t-\gamma)^2}.
```

Since $w_\varepsilon(t)\ll(1+t^2)^{-1}$, integration and Tonelli yield, for $T\geq10$,

```math
\begin{aligned}
\varepsilon\int_{|t|>T}|G(1/2+\varepsilon+it)|^2w_\varepsilon(t)\,dt
&\ll
\sum_{|\gamma|>T-1}\frac{m_\rho\log(|\gamma|+2)}{1+\gamma^2}
+\varepsilon\int_T^\infty\frac{\log^4(t+2)}{t^2}\,dt\\
&\ll\frac{\log^2(T+2)}T+
\varepsilon\frac{\log^4(T+2)}T.
\end{aligned}\tag{14}
```

Both implied constants are independent of $\varepsilon$ and $T$. The first sum uses ordinary zero counting with multiplicities, not a spacing assumption. The right side tends to zero uniformly for $0<\varepsilon\leq1/4$. Combining the compact calculation with (14) proves (12).

## Inversion for the original first Riesz mean

For $c>1$, Mellin inversion of the continuous kernel in (5), with absolute Fubini, gives

```math
N(x)=\frac1{2\pi i}\int_{c-i\infty}^{c+i\infty}
\frac{G(s)^2x^{s+1}}{s(s+1)}\,ds\qquad(x>1).
\tag{15}
```

For a fixed $0<\varepsilon\leq1/4$, shift this contour to $\sigma=1/2+\varepsilon$. Under RH no zero is crossed, and the singularity at 1 has already been removed in $G$. The Hadamard estimates above give $G(\sigma+it)=O_\varepsilon(\log^2(|t|+2))$, uniformly over the closed strip between the two contours. Therefore the horizontal integrals tend to zero, bounded for fixed $x,\varepsilon,c$ by $O_{x,\varepsilon,c}(\log^4 T/T^2)$. Both vertical integrals converge absolutely. There is no need to select heights away from zeros because the entire strip stays a fixed distance $\varepsilon$ to their right.

Taking absolute values in the shifted integral gives

```math
|N(x)|\leq\frac{x^{3/2+\varepsilon}}{2\pi}
\int_{\mathbb R}|G(1/2+\varepsilon+it)|^2w_\varepsilon(t)\,dt.
```

Set $\varepsilon=1/\log x$ for $x\geq e^4$ and apply (12):

```math
\limsup_{x\to\infty}\frac{|N(x)|}{x^{3/2}\log x}
\leq\frac e2C_2.
\tag{16}
```

This controls the whole first Riesz mean, including all terms in (1). It does not discard a simple-pole remainder or require that such residues be absolutely summable.

## An explicit multiplicity bound sufficient for the constant

Put $H_0=3\cdot10^{12}$. [Platt and Trudgian, Theorem 1 and §2](https://arxiv.org/html/2004.09765), rigorously verify all zeros up to a height exceeding $H_0$ by matching sign changes on the critical line with the total count supplied by Turing's method. A sign change accounts for at least one zero with odd multiplicity. Equality of the number of disjoint sign changes with the total count, including multiplicity, forces each to account for exactly one simple zero and leaves no additional zeros. Thus their computation supplies simplicity below $H_0$ as a consequence of its counting method. This is a finite verified result, not a global simplicity assumption.

[Trudgian, Theorem 1 and Corollary 1](https://arxiv.org/html/1208.5846), give the explicit bounds

```math
|S(T)|\leq0.111\log T+0.275\log\log T+2.450
\qquad(T\geq e),
```

```math
\left|N(T)-\frac{T}{2\pi}\log\frac{T}{2\pi e}-\frac78\right|
\leq0.111\log T+0.275\log\log T+2.450+\frac{0.2}{T_0}
\qquad(T\geq T_0\geq e).
\tag{17}
```

For the estimates here, even the weaker coefficients $0.12,0.28,2.6$ suffice. Taking one-sided limits at a zero ordinate in (17) bounds the jump, hence its total multiplicity, by twice the error bound. For every $T\geq H_0$, this gives

```math
m(T)<\log T,\qquad N(T)\leq T\log T.
\tag{18}
```

Both follow by direct substitution at $H_0$ and monotonicity of the ratios $\log\log T/\log T$ and $1/\log T$. Under RH, $|\rho(\rho+1)|\geq\gamma^2$. Writing $N$ for the positive-ordinate count including multiplicities, (18) gives

```math
\begin{aligned}
\sum_{|\gamma|>H_0}\frac{m_\rho^2}{|\rho(\rho+1)|}
&\leq2\int_{(H_0,\infty)}\frac{\log t}{t^2}\,dN(t)\\
&\leq2\int_{H_0}^\infty\frac{(2\log t-1)\log t}{t^2}\,dt\\
&=\frac2{H_0}\left(2\log^2H_0+3\log H_0+3\right)
<2\cdot10^{-9}.
\end{aligned}\tag{19}
```

Integration by parts produces an additional nonpositive boundary term, which was dropped in the second line. For the last numerical inequality one can use $\log H_0<29$, giving an upper bound $3544/(3\cdot10^{12})<2\cdot10^{-9}$.

For the simple zeros below $H_0$,

```math
\sum_{|\gamma|\leq H_0}\frac1{|\rho(\rho+1)|}
\leq\sum_{\rho\text{ with multiplicity}}\frac1{|\rho|^2}
=2+\gamma_E-\log(4\pi)<0.047.
\tag{20}
```

Here $\gamma_E$ is Euler's constant. To check the identity, subtract the logarithmic derivatives of the Hadamard product for $\xi$ at 0 and 1. The functional equation gives
$\sum_\rho1/[\rho(1-\rho)]=2\xi'(1)/\xi(1)=2+\gamma_E-\log(4\pi)$.
Under RH, $\rho(1-\rho)=|\rho|^2$. The inequality in (20) also uses $|\rho+1|\geq|\rho|$. Equations (19) and (20) prove

```math
C_2<0.048,\qquad \frac e2C_2<0.066.
\tag{21}
```

## The same-prime bias and completion of the proof

This last asymptotic uses the unconditional prime number theorem. For the square contribution,

```math
\sum_{p^2\leq t}(\log p)^2
\sim\frac12\sqrt t\log t.
```

Partial summation of $\vartheta(y)\sim y$ proves the displayed formula. For all powers of exponent at least 3, there are at most $O(t^{1/3}\log t)$ pairs $(p,a)$ with $p^a\leq t$, and each weight $(a-1)(\log p)^2$ is at most $(\log t)^2$. Their cumulative contribution is therefore $O(t^{1/3}\log^3t)$. Integrating the cumulative sum of $P$ gives

```math
B(x)=\int_1^x\sum_{n\leq t}P(n)\,dt
\sim\frac13x^{3/2}\log x,
\tag{22}
```

with the higher-power contribution bounded by $O(x^{4/3}\log^3x)$. All prime powers have been retained throughout.

Under RH, combine (16), (21), and (22):

```math
\limsup_{x\to\infty}\frac{N_{\rm dist}(x)}{x^{3/2}\log x}
\leq\frac e2C_2-\frac13
<0.066-\frac13<0.
\tag{23}
```

Thus $N_{\rm dist}(x)<0$ for every sufficiently large real $x$. Landau's argument proves the reverse implication, completing (3). The eventual-sign assertion itself remains unproved without RH.


## A rational-margin corollary

Under RH there is a real $X_0>1$ such that, for every real $x\ge X_0$,

```math
-\frac25 x^{3/2}\log x
<N_{\rm dist}(x)
<-\frac14 x^{3/2}\log x.
\tag{24}
```

Indeed, write $D(x)=x^{3/2}\log x>0$ for $x>1$. Equations (16), (21), and (22) imply

```math
\begin{aligned}
\limsup_{x\to\infty}
\left|\frac{N_{\rm dist}(x)}{D(x)}+\frac13\right|
&\leq\limsup_{x\to\infty}\frac{|N(x)|}{D(x)}
+\lim_{x\to\infty}\left|\frac{B(x)}{D(x)}-\frac13\right|\\
&\leq\frac e2C_2<0.066<\frac1{15}.
\end{aligned}
```

Thus the absolute value is less than $1/15$ for every sufficiently large real $x$. Subtracting $1/3$ gives a lower bound $-2/5$ and an upper bound $-4/15<-1/4$, proving (24). Conversely, the eventual upper inequality in (24), or its non-strict version, implies eventual negativity and hence RH by the argument following (11). This proves another equivalent condition with a fixed rational margin. The proof supplies no effective value of $X_0$.

## Mathematical context and attribution

The motivating question came from arterialist's intuition about prime arrivals under integer succession and multiplicative division histories. The technical proof here uses classical Mellin inversion, logarithmic derivatives, the Hadamard product, Landau's theorem, zero counting, and the prime number theorem.

[Suzuki, *On variants of Chebyshev's conjecture*, Theorem 1](https://arxiv.org/html/2411.07436#S1.SS1) proves an RH criterion from eventual nonpositivity of the different, linear expression

```math
\sum_{n\le x}\frac{\Lambda(n)}{\sqrt n}\log\frac xn-4\sqrt x.
```

His Proposition 1 states the Mellin version of Landau's theorem used above. [Banks and Sinha, *The Riemann Hypothesis via the generalized von Mangoldt function*](https://arxiv.org/html/2209.11768), study the Dirichlet convolutions associated with powers of $-\zeta'/\zeta$; their Lemma 3.2 supplies the related zero-grouping estimates cited in (13).

[Zhao, *On the mean values of the error terms in Mertens' theorems*, §2, equations (15)–(16)](https://arxiv.org/html/2411.18903v2#S2), compares an explicit prime-square bias with zero amplitudes for linear prime-error averages. Those zero sums count multiplicities linearly. In the present quadratic convolution the local double-pole coefficient and the boundary limit involve $m_\rho^2$, so (12) and the multiplicity bound (19) are needed. The finite-zero and explicit-count inputs are due to [Platt and Trudgian](https://arxiv.org/html/2004.09765) and [Trudgian](https://arxiv.org/html/1208.5846), respectively.

These works establish the surrounding analytic methods and related sign criteria. The comparison does not establish priority of the precise subtraction in (2). The remaining problem is to prove its eventual sign from the arithmetic definitions without assuming RH.
