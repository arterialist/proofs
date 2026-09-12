# Cutoff energy versus the full-period gcd form

A common-period covariance identity does not give a uniform subpower comparison on the actual cutoff interval. The following construction uses consecutive integer labels strictly below the cutoff and coefficients all equal to one. It is a written counterexample for arbitrary coefficients, with no claim about cancellation for the Möbius coefficients.

For a positive integer $d$, put $r_d(t)=\{t/d\}-1/2$. If $D$ is a finite nonempty set of positive integers, define
$$
R_D(t)=\sum_{d\in D}r_d(t),\qquad
Q_D=\frac1{12}\sum_{d,e\in D}\frac{\gcd(d,e)^2}{de}.
$$
Here $Q_D$ is exactly the mean of $|R_D|^2$ over a common full period. In contrast, put
$$
E_X(D)=\frac1X\int_X^{2X}|R_D(t)|^2\,dt.
$$
For every integer $M\ge1$, the actual labels
$$
X=10M,\qquad D=\{9M,9M+1,\ldots,10M-1\}
$$
satisfy
$$
\boxed{E_X(D)\ge\frac{X^2}{12960},\qquad
0<Q_D\le\frac{11X}{24},\qquad
\frac{E_X(D)}{Q_D}\ge\frac{X}{5940}.}                 \tag{1}
$$
Thus no estimate $E_X(D)\le C_\varepsilon X^\varepsilon Q_D$, uniform over such integer label sets and coefficients, can hold for any fixed $\varepsilon<1$. In particular, a uniform factor $X^{o(1)}$ is impossible.

## The exact complete-period identity

For positive integers $d,e$, write $d=ga$, $e=gb$ with $g=\gcd(d,e)$ and $(a,b)=1$. A common period is $gab$. Substitution $t=gu$ gives
$$
\frac1{gab}\int_0^{gab}r_d(t)r_e(t)\,dt
=\frac1{ab}\int_0^{ab}
\left(\{u/a\}-\frac12\right)
\left(\{u/b\}-\frac12\right)du.                     \tag{2}
$$
Partition the latter integral into $u=k+v$, $0\le k<ab$, $0\le v<1$. The Chinese remainder theorem makes $(k\bmod a,k\bmod b)$ run through every residue pair. For each $v$,
$$
\sum_{j=0}^{a-1}\left(\frac{j+v}{a}-\frac12\right)=v-\frac12.
$$
The sum of the products over all residue pairs is therefore $(v-1/2)^2$. Its integral is $1/12$, so (2) equals
$$
\frac1{12ab}=\frac{\gcd(d,e)^2}{12de}.              \tag{3}
$$
The values at the integer jumps do not affect these integrals. Expanding the finite square proves the asserted formula for $Q_D$ over any common full period.

This is the classical Franel–Landau covariance identity. A primary modern source is [Aistleitner, Berkes, Seip and Weber, *Convergence of series of dilated functions and spectral norms of GCD matrices*, equation (19)](https://arxiv.org/pdf/1407.5403), which states the corresponding identity for $\{kx\}-1/2$ on $[0,1]$ and attributes it to Franel and Landau. To pass between the conventions, take a common multiple $L$ of $d,e$ and substitute $t=Lx$; then the dilation indices are $L/d,L/e$, whose gcd ratio equals $\gcd(d,e)^2/(de)$. Full-period estimates retain that averaging hypothesis.

## Coherent overlap on the cutoff interval

For the stated set $D$, there are exactly $M=X/10$ labels. Every $t\in[X,11X/10]$ and $d\in D$ satisfy
$$
1<\frac td\le\frac{11}{9}<2.
$$
These inequalities include both integration endpoints. Consequently
$$
r_d(t)=\frac td-\frac32\le-\frac5{18},\qquad
R_D(t)\le-\frac{5M}{18}.
$$
Integrating the square over just this interval gives
$$
E_X(D)\ge\frac1{10}\left(\frac{5M}{18}\right)^2
=\frac{X^2}{12960}.                                \tag{4}
$$
No stochastic averaging or independence is used: the same sign holds throughout a common interval of length $X/10$.

## Bounding the complete gcd form

All summands of the gcd form are nonnegative, so retaining all pairs with $d,e\le X$ is an upper bound. Parametrizing each pair uniquely as $d=ga,e=gb$, $(a,b)=1$, gives
$$
\begin{aligned}
12Q_D
&\le\sum_{d,e\le X}\frac{\gcd(d,e)^2}{de}\\
&=\sum_{\substack{a,b\le X\\(a,b)=1}}
\frac{\lfloor X/\max(a,b)\rfloor}{ab}\\
&\le X\sum_{a,b\ge1}\frac1{ab\max(a,b)}.
\end{aligned}                                     \tag{5}
$$
The last positive double sum is bounded by elementary integral comparisons:
$$
\begin{aligned}
\sum_{a,b\ge1}\frac1{ab\max(a,b)}
&=\sum_{a\ge1}\frac1{a^3}
+2\sum_{a\ge1}\frac1a\sum_{b>a}\frac1{b^2}\\
&\le\sum_{a\ge1}\frac1{a^3}
+2\sum_{a\ge1}\frac1{a^2}
\le\frac32+4=\frac{11}{2}.
\end{aligned}
$$
Here $\sum_{b>a}b^{-2}\le\int_a^\infty u^{-2}du=1/a$, while the other two series are bounded by their first term plus the corresponding integral on $[1,\infty)$. Thus $Q_D\le11X/24$. Its positive diagonal makes $Q_D>0$, so division of (4) by this bound proves (1).

## Scope and related arithmetic kernels

The example proves that complete-period gcd covariance cannot be inserted into a local cutoff estimate for arbitrary coefficients with only a subpower loss. The same conclusion applies to a proposed universal quadratic-form comparison, because its coefficient vector must include the all-one vector used here. It does not disprove an estimate for a specially structured signed vector.

The [incomplete carry-covariance formulas](incomplete-carry-covariance.md) retain finite averaging kernels and explicit endpoint terms instead of replacing them by complete-period values. The [actual temporal divisor-history covariance](temporal-floor-covariance.md) is a different kernel: its positive terminal-prime subblock is canceled to leading order by the full signed complement. Neither construction is replaced by the all-one sawtooth example.

Equations (1)–(5) are written elementary proofs. No new Lean formalization, arithmetic prime-error bound or priority claim is made.
