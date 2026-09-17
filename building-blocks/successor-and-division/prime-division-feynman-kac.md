# Prime-division paths, their weight and the surviving adjoint term

The full prime-power division chain admits an exact positive-time Feynman–Kac representation. Its completed weight has first moment $\sqrt n$, but its second moment is already infinite when the starting integer is a prime at least $5$. A finite adjoint identity retains the actual signed prime-error term. These are written proofs, not Lean formalizations or an RH estimate.

## The finite chain and its tilted rates

Fix a positive integer $n_0$ and use its finite divisor set as state space. Let

$$
\mathcal Lf(n)=\sum_{q=p^k\mid n}\Lambda(q)[f(n/q)-f(n)],
\qquad h(n)=n^{-1/2},
\qquad F(n)=\sum_{q\mid n}\sqrt q\,\Lambda(q).
\tag{1}
$$

All sums over $q$ include every prime power with positive exponent. Since $\sum_{q\mid n}\Lambda(q)=\log n$, direct conjugation gives

$$
h^{-1}\mathcal L(hf)=\mathcal L^h f+Uf,
\quad
\mathcal L^h f(n)=\sum_{q\mid n}\sqrt q\,\Lambda(q)[f(n/q)-f(n)],
\quad U(n)=F(n)-\log n\ge0.
\tag{2}
$$

At $1$, both generators vanish, $h(1)=1$ and $U(1)=0$. At every $n>1$, $U(n)>0$. Each chain makes only strictly downward divisor jumps and is absorbed at $1$ in finite time almost surely.

If $P_t=e^{t\mathcal L}$ and $X_t$ has generator $\mathcal L^h$, then for every function $f$ on the divisor set,

$$
\frac{P_t(hf)(n)}{h(n)}
=\mathbb E_n^h\left[e^{\int_0^tU(X_s)\,ds}f(X_t)\right].
\tag{3}
$$

For completeness, conditioning the right side on its first short time interval gives the backward equation $v'=(\mathcal L^h+U)v$ with initial value $f$. All rates and potentials are bounded on this finite state space, so differentiation is justified. The left side solves the same finite system by (2), proving (3) by uniqueness. This is the classical finite-state Feynman–Kac mechanism; see [Fitzsimmons–Pitman, §§4–5](https://www.stat.berkeley.edu/~pitman/kac.pdf). The particular arithmetic rates and consequences below follow directly from (1).

With $f=1$, the original chain has $h(X_t)$ increasing to $1$. Hence

$$
1\le\frac{P_th(n)}{h(n)}\uparrow\sqrt n.
$$

For the tilted chain let $\tau_1$ be absorption time. Since $U\ge0$ and vanishes at $1$, monotone convergence in (3) proves the complete path budget

$$
\boxed{\mathbb E_n^h e^{\int_0^{\tau_1}U(X_s)\,ds}=\sqrt n.}
\tag{4}
$$

Jensen's inequality then gives

$$
\mathbb E_n^h\int_0^{\tau_1}U(X_s)\,ds\le\tfrac12\log n.
$$

The exponential weight is essential. Indeed, $F(n)>\log n$ for $n>1$, while every unweighted expectation of $\log D$ over divisors $D\mid n$ is at most $\log n$. Formula (3) does not turn the tilted dynamics into an unweighted contraction.

## The completed second moment fails at one prime

Starting at a prime $p$, the tilted chain makes the single jump $p\to1$, after a waiting time $T$ with rate $\alpha=\sqrt p\log p$. Put $u=(\sqrt p-1)\log p$ and $Z=e^{uT}$. For every real $r$,

$$
\mathbb E Z^r
=\alpha\int_0^\infty e^{-(\alpha-ru)t}\,dt
=\begin{cases}
\displaystyle\frac{\sqrt p}{\sqrt p-r(\sqrt p-1)},
&\sqrt p-r(\sqrt p-1)>0,\\[5pt]
+\infty,&\sqrt p-r(\sqrt p-1)\le0.
\end{cases}
\tag{5}
$$

Thus $\mathbb EZ=\sqrt p$, but $\mathbb EZ^2=\infty$ for every prime $p\ge5$, including divergence at the limiting exponent in (5). This is a statement about one absorption-completed path. At each fixed finite time the weight $e^{u\min(T,t)}$ is bounded. Two independent completed paths have product expectation $p$ by their finite first moments. Neither alternative is ruled out by the second-moment obstruction.

## The exact same-prime drift

Write

$$
F_p(n)=(\log p)\sum_{k=1}^{v_p(n)}p^{k/2},\quad
F=\sum_pF_p,\quad Q(n)=\sum_pF_p(n)^2,
$$

$$
T(n)=\sum_p(\log p)^2\sum_{k=2}^{v_p(n)}(k-1)p^{k/2}.
$$

The two successive divisions on a fixed prime chain give

$$
\sum_{i=1}^{v_p(n)}p^{i/2}(\log p)F_p(n/p^i)
=(\log p)^2\sum_{k=2}^{v_p(n)}(k-1)p^{k/2}.
$$

A division by a different prime leaves $F_p$ unchanged. Subtracting the diagonal rate term therefore proves

$$
\boxed{\mathcal L^hF=T-Q.}
\tag{6}
$$

For a real cutoff $x>1$, set $r_x(n)=1+x/n$. Then

$$
F^2-Q-r_xF
=(\mathcal L^h+U)F+(\log n-r_x)F-T.
\tag{7}
$$

The multiplier $\log n-r_x$ is signed. Centering has not removed the positive Feynman–Kac potential from the complete arithmetic expression.

## A stable finite operator and its actual adjoint

On the integers $1\le n\le\lfloor x\rfloor$, define

$$
A_x=\mathcal L^h+F-r_x=\Gamma^h-r_x,
\qquad \Gamma^hf(n)=\sum_{q\mid n}\sqrt q\,\Lambda(q)f(n/q).
\tag{8}
$$

This triangular matrix has diagonal $-r_x(n)<0$ and nonnegative off-diagonal entries. Its exponential is positive: adding a sufficiently large scalar multiple of the identity gives a matrix with nonnegative entries, to which the exponential power series applies. All eigenvalues are negative, so the finite semigroup decays as time tends to infinity. It need not be a supremum-norm contraction. At $1$ it introduces killing at rate $1+x$, unlike the original absorbing chain.

Put $w_x(n)=(x-n)/\sqrt n$ and

$$
B(y)=\frac{y^2}{2}\log y+\frac{y^2}{4}-\frac14,
\qquad B_{\rm crit}(x)=\sum_{d\le x}\sqrt d\,B(x/d).
$$

The [complete allocation identity](../prime-distribution/prime-allocation-critical-identity.md), with its endpoint and both density terms, is exactly

$$
W(x)=B_{\rm crit}(x)+\sum_{n\le x}w_x(n)
[F(n)^2-Q(n)-r_x(n)F(n)].
$$

Using (6) in this identity gives

$$
W(x)=B_{\rm crit}(x)+\sum_{n\le x}w_x(n)A_xF(n)
-\sum_{n\le x}w_x(n)T(n).
\tag{9}
$$

All endpoints $n=x$ have zero weight. Reindexing $n=qm$ in the finite positive-shift term proves

$$
\boxed{\sum_{n\le x}w_x(n)A_xF(n)
=\sum_{m\le x}\sqrt m\,F(m)
\left[R_\Lambda(x/m)-((x/m)^2-1)\right],}
\tag{10}
$$

where

$$
R_\Lambda(y)=\sum_{q\le y}(y-q)\Lambda(q)
=\int_1^y\psi(t)\,dt
=I_E(y)+\frac{y^2-1}{2},\quad
I_E(y)=\int_1^y(\psi(t)-t)\,dt.
$$

Indeed, $\sum w_x\Gamma^hF=\sum_m\sqrt m F(m)R_\Lambda(x/m)$ and $w_x(m)r_x(m)=\sqrt m((x/m)^2-1)$. This also verifies the lower endpoint $y=1$. The signed actual $I_E$ remains in (10), with deterministic subtraction $-(y^2-1)/2$.

## Why a fixed Chebyshev slack does not pay the baseline

An unconditional bound $\psi(t)\le ct$ with fixed $1<c<2$ makes the brackets in (10) nonpositive. For an available explicit choice see [the Rosser–Schoenfeld bound used in the combined covariance theorem](../prime-distribution/combined-prime-density-covariance.md#failure-of-monotonicity-and-an-all-scale-replacement). Set

$$
R_x=\sum_{n\le x}w_x(n)r_x(n)F(n).
$$

Integrating the Chebyshev bound in (10) gives

$$
W(x)\le B_{\rm crit}(x)-(1-c/2)R_x
-\sum_{n\le x}w_x(n)T(n).
\tag{11}
$$

The right side has positive leading term

$$
\frac{c-1}{2}\zeta(3/2)x^2\log x+O(x^2).
\tag{12}
$$

Here is a proof of the asymptotics with all powers retained. The explicit baseline gives $B_{\rm crit}(x)=\tfrac12\zeta(3/2)x^2\log x+O(x^2)$ by convergence of $\sum d^{-3/2}\log d$. On writing $n=qm$,

$$
R_x=x^2\sum_{m\le x}m^{-3/2}\sum_{q\le x/m}\frac{\Lambda(q)}q
-\sum_{m\le x}\sqrt m\sum_{q\le x/m}q\Lambda(q).
$$

Quantitative PNT and partial summation give $\sum_{q\le y}\Lambda(q)/q=\log y+O(1)$; the same classical input is stated in the [harmonic quadrature theorem](../analytic-methods/harmonic-quadrature-correction.md). The first term is $\zeta(3/2)x^2\log x+O(x^2)$, and the second is $O(x^2)$ by $\sum_{q\le y}q\Lambda(q)\le y\psi(y)=O(y^2)$. Finally,

$$
0\le\sum_{n\le x}w_x(n)T(n)
\le2x^{3/2}\sum_{p^k\le x,\ k\ge2}
\frac{(k-1)(\log p)^2}{p^{k/2}}
=O(x^{3/2}\log^3x)=o(x^2).
$$

The $k=2$ part is bounded by the corresponding integer harmonic logarithm sum, and the complete $k\ge3$ tail converges. These estimates prove (12). A favorable sign for every finite adjoint coefficient therefore leaves too much slack to prove the sign of $W$.

The centered drift itself can be positive. For distinct primes $p,q\ge11$, let $n=pq$, $x=2n$, $a=\sqrt p\log p>3$ and $b=\sqrt q\log q>3$. Then $T(n)=0$ and

$$
A_xF(n)-T(n)=2ab-3(a+b)>0,
$$

since $3/a+3/b<2$. This exact example and (12) have different scopes: one excludes pointwise nonpositivity, while the other computes the excess in a proposed aggregate majorant. Neither asserts that the full $W$ is positive. The chain, its weight, the same-prime term and the baseline all remain part of the construction.
