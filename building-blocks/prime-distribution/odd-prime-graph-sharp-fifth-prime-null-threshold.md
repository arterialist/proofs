# Sharp fifth-prime threshold for the odd Suzuki graph nullspace

Written proof, 2026-09-17. This sharpens the [two-prime graph/log uncertainty theorem](odd-prime-graph-logarithmic-uncertainty.md), whose sufficient radius was $a\ge(\log6)/2$, and extends the [partial-rotation nullspace construction](odd-prime-partial-rotation-nullspace.md) through the $n=5$ birth. It concerns the zero set of the positive **raw prime graph energy**, not the sign of the full Weil form; it proves no RH estimate or Lean theorem.

Put $T=2a$, $I=(-a,a)$, $\phi(x)=\cosh(x/2)$, and $g=F/\phi$. The graph energy $D_a[F]$ vanishes exactly when $g(x)=g(x+\log n)$ almost everywhere on each admissible overlap, for every $n$ with $\Lambda(n)>0$ and $\log n<T$. The admitted shifts below $T<\log6$ are $\log2,\log3,\log4,\log5$ as they enter; $\log4=2\log2$ is redundant whenever its overlap exists. Translating $I$ to $(0,T)$ does not change the period equations. Oddness of $F$ is the reflection law $g(y)=-g(T-y)$.

**Theorem.** The exact transition for the odd graph nullspace is
\[
T_* =\log(50/9)=1.714798\ldots,
\qquad a_*=\tfrac12\log(50/9).
\tag{1}
\]
For every $\log2<T<T_*$, the odd graph nullspace contains infinitely many bounded-variation, finite-logarithmic-energy functions; its intersection with the exact pole-null hyperplane is infinite dimensional. For every $T\ge T_*$, $D_a[F]=0$ and oddness imply $F=0$. In particular the $n=5$ edge removes the odd graph nullspace strictly before the old $T=\log6$ bound.

The key exact reduction is valid for an interval $(0,U)$ of length $U\ge2m$, with a smallest positive local period $m$ and any other periods $p_j>m$. A function with those periods is determined by its restriction to $J=(0,U-m)$: on the last $m$-strip define $f(y)=h(y-m)$. The restriction $h$ has exactly the local periods
\[
R(m,p_2,\ldots,p_k)
=\operatorname{sort}\{m,p_2-m,\ldots,p_k-m\}
\quad\text{on }J.
\tag{2}
\]
Indeed $p_j$ followed by a backward $m$-edge gives the $(p_j-m)$-edge on $J$, and conversely a $(p_j-m)$-edge followed by an $m$-edge gives $p_j$ on $(0,U)$; the $m$-equations themselves define the last strip. This is an isomorphism of local-period solution spaces, and its extension preserves bounded variation for bounded-variation data. Its condition $U\ge2m$ matters: when $m<U<2m$, the central interval $(U-m,m)$ is untouched by every edge of period at least $m$.

Apply (2) successively. Each row lists the cumulative length removed and the reduced periods in increasing order:

| Step | Removed length | Reduced periods |
|---|---|---|
| 0 | $0$ | $\log2,\ \log3,\ \log5$ |
| 1 | $\log2$ | $\log(3/2),\ \log2,\ \log(5/2)$ |
| 2 | $\log3$ | $\log(4/3),\ \log(3/2),\ \log(5/3)$ |
| 3 | $\log4$ | $\log(9/8),\ \log(5/4),\ \log(4/3)$ |
| 4 | $\log(9/2)$ | $\log(10/9),\ \log(9/8),\ \log(32/27)$ |
| 5 | $\log5$ | $\log(81/80),\ \log(16/15),\ \log(10/9)$ |

For $\log5\le T<\log(16/3)$, the first two reductions are valid. At step 2, the interval length is $U=T-\log3$, and
\[
\log(4/3)<U<2\log(4/3).
\]
Thus $(U-\log(4/3),\log(4/3))$ is a positive-length interval on which **none** of the three reduced period edges has an endpoint. For $\log(16/3)\le T<T_*$, the next two reductions are valid. At step 4, $U=T-\log(9/2)$ satisfies
\[
\log(10/9)<U<2\log(10/9),
\]
so $(U-\log(10/9),\log(10/9))$ is again an isolated positive-length interval. Arbitrary bounded-variation functions supported inside either gap solve all reduced period equations, and lifting through the earlier reductions gives graph-null functions on $(0,T)$.

The reflection $y\mapsto T-y$ preserves the original graph. A small interval $J$ in an isolated gap lifts to finitely many translated copies $J+d_i$. Choose $J$ away from the finitely many solutions of $2y=T-d_i-d_j$ and small enough that the lifted support and its reflection are disjoint. Then $f-f\circ(y\mapsto T-y)$ is a nonzero odd graph-null function. Pairwise disjoint such $J$ give infinitely many independent odd functions. Their physical representatives $F(x)=\phi(x)g(x+a)$ are bounded variation on $I$ after zero extension, so their Fourier transforms decay as $O_a(1/|t|)$ and Suzuki's logarithmic archimedean form is finite. The pole moment is one linear functional on this infinite-dimensional space, leaving an infinite-dimensional exact pole-null subspace. Since $T\ge\log5>2\log2$, every point has at least one $\log2$ neighbor inside $I$; the weighted prime row obeys $S_a[F]\ge(\log2)/2\|F\|_2^2$. Interior cutoff and mollification, followed by a one-dimensional pole correction, therefore give smooth compact odd pole-null tests with bounded normalized logarithmic energy and $D_a/S_a\to0$ at every $\log5\le T<T_*$.

At $T=T_*$, step 4 has interval length $2m$ with $m=\log(10/9)$, so the fifth reduction is valid and leaves an interval of length $m$ with periods
\[
r=\log(81/80),\qquad s=\log(16/15),\qquad m=\log(10/9).
\]
Here $r+s=\log(27/25)<m$, and $r/s$ is irrational: a rational ratio would give $(81/80)^q=(16/15)^p$ for positive integers $p,q$, impossible by comparing the exponents of $3$. The standard two-period lemma now makes every measurable local-period function constant on this interval. To see it directly, $r$-periodicity defines a function on the circle of length $r$; because $m-s>r$, the $s$-equation holds on a full $r$-cell and gives invariance under irrational rotation by $s\bmod r$. Its nonconstant Fourier coefficients vanish. Reversing the reductions makes $g$ constant on $(0,T_*)$, and oddness forces that constant to zero. For $T>T_*$, every translated subinterval of length $T_*$ inherits these four prime-power period equations; overlapping subintervals force $g$ constant throughout $(0,T)$, and oddness again gives zero.

This yields a sharper fixed-window graph/logarithmic uncertainty statement at every $a\ge a_*$ by the same compactness argument in the published theorem. The resulting coercivity constant is still window-dependent and nonquantitative; the full Weil sign and RH remain open. Suzuki’s [Fourier formula, §2.4](https://arxiv.org/html/2606.09096v2) supplies the actual prime-power shifts. The local-period proof is related to the classical [Fine–Wilf graph viewpoint](https://arxiv.org/pdf/0906.1780) and the [measurable two-period threshold](https://doi.org/10.2307/44153084); no priority claim is made.
