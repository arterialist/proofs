# A fixed-logarithm bound for a central Möbius–divisor block

Let $\mu$ be the Möbius function, $d$ the divisor function and $\gamma$ Euler's constant. Define

```math
H(q)=\log(q!)-\sum_{n\le q}d(n)+2\gamma q.
```

For every positive integer $L$,

```math
\boxed{\left|\sum_{L<n\le2L}\mu(n)H(\lfloor L^2/n\rfloor)\right|
\ll L^{19/16}\log^6(2L).} \tag{1}
```

The implied constant is absolute. In the parameter $X=L^2$, this is $O(X^{19/32}\log^6(2X))$. It concerns one divisor block. It supplies neither a square-root estimate for that block nor a bound for the complete prime error.

The proof is an application of the classical truncated Voronoï formula, Vaughan's finite decomposition, and the van der Corput inequalities. Robert–Sargos's more general monomial theorem gives the same power with an arbitrary positive power loss; it does not by itself give the fixed logarithmic loss proved here. No priority or analytic Lean-formalization claim is made.

## Removing floors before the transform

Put

```math
\Delta(x)=\sum_{n\le x}d(n)-A(x),\qquad
A(x)=x\log x+(2\gamma-1)x,
\qquad J(q)=\log(q!)-q\log q+q.
```

For $q=\lfloor x\rfloor\ge1$, the step function $\sum_{n\le x}d(n)$ has exactly the same value at $q$ and $x$. Therefore

```math
H(q)=-\Delta(x)+J(q)-[A(x)-A(q)].
```

Integral comparison gives $1\le J(q)\le1+\log q$. Since $A'(x)=\log x+2\gamma$, the last two terms are $O(\log(2L))$ uniformly at $x=L^2/n$, $L<n\le2L$.

Take $R=\lfloor L/8\rfloor$. For sufficiently large $L$, $R\asymp L$ and $L/2\le x<L$. The classical truncated formula [Ivić–Zhai, Lemma 3.1, (3.5)](https://arxiv.org/html/1209.0872#S3) gives

```math
\Delta(x)=\frac{x^{1/4}}{\sqrt2\pi}
\sum_{k\le R}d(k)k^{-3/4}\cos(4\pi\sqrt{kx}-\pi/4)
+O_\eta(x^{1/2+\eta}R^{-1/2}).
```

Consequently, with $e(t)=e^{2\pi it}$,

```math
B_L=-\frac{M_{L,R}}{\sqrt2\pi}
+O_\eta(L^{1+\eta}+L\log(2L)), \tag{2}
```

```math
M_{L,R}=L^{1/4}\Re\left(e(-1/8)
\sum_{k\le R}d(k)k^{-3/4}W_k\right),\quad
W_k=\sum_{L<n\le2L}\mu(n)(n/L)^{-1/4}e(2L\sqrt{k/n}).
```

The truncation is applied to the real argument before any termwise phase approximation. This avoids a separate floor error inside the oscillatory expansion.

## Low frequencies: a divisor-moment shift estimate

We prove, uniformly for $1\le k\le L^{1/2}$ and $L\le z\le2L$,

```math
\left|\sum_{L<n\le z}\mu(n)e(2L\sqrt{k/n})\right|
\ll L^{7/8}\log^5(2L). \tag{3}
```

Let $U=\lfloor L^{1/4}\rfloor$, $a(n)=\mu(n)\mathbf1_{n\le U}$ and $b=\mu-a$. With Dirichlet convolution and $\mathbf1(n)=1$,

```math
\mu=2a-a*a*\mathbf1+b*b*\mathbf1. \tag{4}
```

This follows by expanding the last convolution and using $\mu*\mathbf1=\delta_1$. It is the equal-cutoff Vaughan identity; compare [Green–Tao, Lemma 4.1](https://arxiv.org/html/math/0606087#S4). The $2a$ term vanishes for $n>L$.

Write $F=2\sqrt{kL}$. The Type I terms have $r=uv$, $u,v\le U$, and an unweighted sum over $L/r<w\le z/r$. The second derivative of the phase is comparable to $F/(L/r)^2$. The classical estimate $\sum e(g(n))\ll V\sqrt\lambda+\lambda^{-1/2}+1$ for $|g''|\asymp\lambda$ on an interval of length at most $V$ therefore gives

```math
|S_I|\ll U^2\sqrt F+LF^{-1/2}\log^2(2U)
\ll L^{7/8}\log^2(2L). \tag{5}
```

The additive endpoint term is absorbed by $\sqrt F$. See [Elkies, *Exponential sums III*, inequality II and its proof](https://people.math.harvard.edu/~elkies/M229.09/vdc.pdf).

For Type II, the coefficient of the second factor is $C(s)=\sum_{v\mid s,\ v>U}\mu(v)$, with $C(s)=0$ for $s\le U$ and $|C(s)|\le d(s)$. Split both factors into dyadic intervals. In each nonempty box choose the larger scale $P$ and smaller scale $Q$. Then

```math
PQ\asymp L,\qquad P\gg\sqrt L,\qquad Q\gg L^{1/4},\qquad P\ge Q.
```

The box sum is

```math
T=\sum_{p\asymp P}\alpha_p\sum_{q\asymp Q}\beta_q
\mathbf1_{L<pq\le z}e(2L\sqrt{k/(pq)}),
```

where both coefficients are bounded by the respective divisor functions. Since $d(n)^2\le d_4(n)$ and $\sum_{n\le Z}d_4(n)\le Z(1+\log Z)^3$,

```math
\sum_p|\alpha_p|^2\ll P\log^3(2L),\qquad
\sum_q|\beta_q|^2\ll Q\log^3(2L). \tag{6}
```

The first inequality follows at prime powers from $(a+1)^2\le\binom{a+3}{3}$ and then multiplicativity; the second counts ordered quadruples by three harmonic sums. No pointwise divisor subpower bound is used.

Apply Cauchy–Schwarz in $p$, then the zero-extended shift inequality in $q$ with a common integer $1\le H\le Q$. Summing the expanded squares over $p$ before taking absolute values of lag correlations gives

```math
|T|^2\ll\left(\sum_p|\alpha_p|^2\right)\frac QH
\left[P\sum_q|\beta_q|^2+
\sum_{1\le h\le H}\left|
\sum_q\beta_{q+h}\overline{\beta_q}
\sum_{p\in I(q,h)}e(g_{q,h}(p))\right|\right], \tag{7}
```

where

```math
g_{q,h}(p)=2L\sqrt k\big((q+h)^{-1/2}-q^{-1/2}\big)p^{-1/2}.
```

Here $I(q,h)$ is the intersection of $(P,2P]$, $L<pq\le z$ and $L<p(q+h)\le z$. It is a single interval, possibly empty. To obtain (7), write $H$ times each zero-extended sum as the sum of its $H$ shifts, apply Cauchy on a support of length $O(Q)$, and group ordered shift pairs by their lag. The diagonal has weight $H$ and lag $h$ has weight $2(H-h)$. This explains why the unweighted $p$ sum remains inside the absolute value in (7).

On nonzero terms $q,q+h\in(Q,2Q]$, so

```math
|g''_{q,h}(p)|\asymp\frac{Fh}{QP^2}.
```

The comparison constants are absolute, and the derivative has constant sign. The second-derivative estimate bounds the inner sum by

```math
\sqrt{Fh/Q}+P\sqrt{Q/(Fh)}.
```

The endpoint $1$ is absorbed because the product of these terms is $P\ge1$. Cauchy gives $\sum_q|\beta_{q+h}\beta_q|\le\sum_q|\beta_q|^2$. Substituting (6) into (7), and summing $\sqrt h$ and $h^{-1/2}$, yields

```math
|T|\ll L\log^3(2L)
\left[H^{-1/2}+P^{-1/2}(FH/Q)^{1/4}+(Q/(FH))^{1/4}\right]. \tag{8}
```

Choose $H\asymp\min(Q,L/F)$ by rounding down. For large $L$, both choices are $\gg L^{1/4}$, since $\sqrt L\ll F\ll L^{3/4}$, so rounding is harmless. If $Q\le L/F$, take $H\asymp Q$. The three terms after multiplication by $L$ are bounded by

```math
LQ^{-1/2}\ll L^{7/8},\quad
LF^{1/4}P^{-1/2}\ll LF^{-1/4}\ll L^{7/8},\quad
LF^{-1/4}\ll L^{7/8}.
```

Here $P\gg F$ in the middle inequality. If $Q>L/F$, take $H\asymp L/F$; the terms become $O(\sqrt{LF})$, $O(LP^{-1/4})$, $O(LP^{-1/4})$, all $O(L^{7/8})$. There are $O(\log^2(2L))$ factor boxes. Together with (5), this proves (3). Bounded-variation partial summation against $(n/L)^{-1/4}$ gives the same bound for $W_k$.

## High frequencies and completion

For any interval $I\subseteq(K,2K]\cap[1,R]$, set $a_k=d(k)k^{-3/4}$ and $b_n=\mu(n)(n/L)^{-1/4}$. Cauchy in $n$ gives

```math
\left|\sum_{L<n\le2L}b_n\sum_{k\in I}a_ke(2L\sqrt{k/n})\right|^2
\le L\sum_{L<n\le2L}\left|\sum_{k\in I}a_ke(2L\sqrt{k/n})\right|^2.
```

For $k\ne l$, the correlation phase has derivative $-L(\sqrt k-\sqrt l)t^{-3/2}$. On $[L,2L]$ its magnitude is monotone, at most $1/\sqrt8<1/2$, and at least $|\sqrt k-\sqrt l|/(2^{3/2}\sqrt L)$. Thus it stays away from every integer. The classical first-derivative bound gives

```math
\left|\sum_{L<n\le2L}e(2L(\sqrt k-\sqrt l)n^{-1/2})\right|
\ll\frac{\sqrt{KL}}{|k-l|}.
```

See [Elkies, *Exponential sums II*, the monotone-increment inequality](https://people.math.harvard.edu/~elkies/M229.09/kmv.pdf). The diagonal is $L$. The harmonic row sum and (6)'s divisor argument give

```math
\sum_{k\in I}|a_k|^2\ll K^{-1/2}\log^3(2K),
```

and consequently the contribution of this band to $M_{L,R}$ is

```math
\ll L^{5/4}K^{-1/4}\log^2(2K). \tag{9}
```

Now put $K_0=\lfloor L^{1/4}\rfloor$. The low frequencies, including $k=1$, contribute by (3) and elementary divisor summation at most

```math
L^{1/4}L^{7/8}\log^5(2L)
\sum_{k\le K_0}d(k)k^{-3/4}
\ll L^{19/16}\log^6(2L).
```

For $k>K_0$, sum (9) over intervals starting at $K_0,2K_0,4K_0,\ldots$, allowing an incomplete final interval. The geometric decay bounds their total by $O(L^{5/4}K_0^{-1/4}\log^2(2L))=O(L^{19/16}\log^2(2L))$. Finally fix $\eta=3/16$ in (2). Its remainder is $O(L^{19/16}+L\log(2L))$, which proves (1). The finitely many small $L$ are absorbed into the absolute constant.

For comparison, [Robert–Sargos, Theorem 1, (1.3)](https://perso.univ-st-etienne.fr/rool6510/robert-2006-crelle.pdf), with monomial exponents $1,-1/2,-1/2$, yields a Type II bound $L^{7/8+\varepsilon}$ after divisor normalization and separation of the product cutoff by finite Perron integration. That classical result explains the same central power. The proof above instead tracks divisor second moments and the finite shift range to retain a fixed logarithmic loss. It does not estimate the other divisor blocks or their signed total.
