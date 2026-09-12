# Combined prime and density covariance at every cutoff

The negative cross-prime covariances and the positive density correction have a combined leading term that is positive. Their exact combination also admits bounds at every real cutoff. The proof uses the classical explicit Chebyshev estimate cited below and the prime number theorem for its asymptotic statements. It is written mathematics, not a Lean formalization; no priority claim is made. These bounds retain the literal same-prime allocation diagonal, the mean, the endpoint and the continuous density term. They do not determine the sign of the remaining density difference or the eventual sign of the critical sum.

## Definitions and exact scale increment

For $x>1$, use

$$
Z_x=\sum_{n<x}\frac{x-n}{\sqrt n},\qquad
P_x(n)=\frac{x-n}{\sqrt n Z_x},\qquad z_x(n)=x/n-1,
$$

$$
m_p(n)=\log p\sum_{j=1}^{v_p(n)}p^{j/2},\qquad
S=\sum_p m_p,\qquad
\mu_p=E_xm_p,\quad\mu=E_xS,\quad\beta=E_xz_x.
$$

Every arithmetic sum below includes all prime powers satisfying $p^j<x$. Define

$$
d(x)=\beta(x)-\mu(x),\qquad
w_{p,j}(x)=\frac{(\log p)p^jZ_{x/p^j}}{Z_x},\qquad
\Delta_a f=f(x)-f(x/a),
$$

$$
\mathcal C(x)=2\sum_{p<q}\operatorname{Cov}_x(m_p,m_q)
-\operatorname{Cov}_x(z_x,S).
$$

The [prime-score](prime-score-negative-covariance.md) and [density-prime](density-prime-covariance.md) size-bias identities give

$$
-\operatorname{Cov}_x(m_p,m_q)
=\sum_jw_{p,j}\Delta_{p^j}\mu_q\quad(p\ne q),\qquad
-\operatorname{Cov}_x(z_x,m_p)=\sum_jw_{p,j}\Delta_{p^j}\beta.
$$

Summing ordered distinct-prime terms once therefore yields

$$
\boxed{\mathcal C
=\sum_{p,j}w_{p,j}
\bigl[\Delta_{p^j}d+\Delta_{p^j}\mu_p\bigr].}
\tag{1}
$$

The factor in $d$ is one. The different expression $\beta-2\mu$ appears in the centered mean below.

Retain the literal same-prime allocation term

$$
t_p(k)=(\log p)^2
\sum_{\substack{\ell,r\ge1\\\ell+r\le k}}p^{(\ell+r)/2},\qquad
\mathcal D(x)=E_x\sum_pt_p(v_p(n)).
$$

Expanding the smaller-scale mean and grouping $j+k=r$ gives

$$
\sum_{p,j}w_{p,j}\mu_p(x/p^j)
=\sum_p(\log p)^2\sum_{r\ge2}(r-1)
\frac{p^rZ_{x/p^r}}{Z_x}
=\mathcal D(x).
\tag{2}
$$

In particular, this is not $E_x\sum_pm_p^2$. Set

$$
T(x)=\sum_{p,j}w_{p,j}(x)d(x/p^j).
$$

Since $\sum_jw_{p,j}=\mu_p$, equations (1) and (2) give

$$
\boxed{\mathcal C-\sum_p\mu_p^2
=\mu d-T-\mathcal D.}
\tag{3}
$$

## Failure of monotonicity and an all-scale replacement

On $1<x<2$, one has $d(x)=x-1$. Immediately to the right of $2$,

$$
Z_x=x-1+\frac{x-2}{\sqrt2},\qquad
\mu(x)=\frac{(\log2)(x-2)}{Z_x},
$$

$$
Z_x\beta(x)=(x-1)^2+\frac{(x-2)^2}{2\sqrt2}.
$$

Consequently

$$
\boxed{d'(2+)=1-\frac1{\sqrt2}-\log2<0.}
\tag{4}
$$

The expression $\beta-2\mu$ likewise increases on $(1,2)$ and has negative right derivative at $2$. Neither function is globally monotone. This does not by itself refute monotonicity restricted to integer dilation pairs. The following argument needs neither assertion.

For every $y>1$,

$$
\boxed{\frac14\beta(y)\le d(y)\le\beta(y).}
\tag{5}
$$

To prove it, use the unconditional bound
$\psi(t)<1.03883t<(26/25)t$ from Rosser and Schoenfeld, [*Approximate formulas for some functions of prime numbers*](https://denisevellachemla.eu/Rosser-Schoenfeld-1962.pdf), Illinois Journal of Mathematics **6** (1962), 64–94, Theorem 12, equation (3.35). For $t\ge4$, this gives
$\psi(t)\le\tfrac32(t-1)$. For $1\le t<4$, the same inequality follows directly from the values $0,\log2,\log6$. Hence

$$
\begin{aligned}
Z_y\mu(y)
&=\sum_{n<y}\sqrt n\int_1^{y/n}\psi(t)\,dt\\
&\le\frac34\sum_{n<y}\sqrt n(y/n-1)^2
=\frac34Z_y\beta(y).
\end{aligned}
$$

Together with $\mu\ge0$, this proves (5).

Define the actual mixed moment

$$
D(x)=\sum_{p,j}w_{p,j}(x)\beta(x/p^j)=E_x[z_xS].
$$

Equation (5) implies $D/4\le T\le D$. Substituting into (3) proves the combined comparison

$$
\boxed{
\mu d+\sum_p\mu_p^2-\mathcal D-D
\le\mathcal C
\le\mu d+\sum_p\mu_p^2-\mathcal D-\frac14D.
}
\tag{6}
$$

All these inequalities hold at every real $x>1$, including integer support transitions.

## A uniform quantitative remainder

The integer dilation ratios

$$
F_a(x)=\frac{aZ_{x/a}}{Z_x}\quad(x>a),\qquad F_a(x)=0\quad(x\le a),
$$

are increasing. Together with $Z_x\sim\tfrac43x^{3/2}$, this proves
$F_a(x)\le a^{-1/2}$ for every integer $a\ge2$. This monotonicity is the [finite power-sum result](prime-score-negative-covariance.md); it does not assert monotonicity of $d$.

For $y\ge2$, restrict the sum defining $Z_y$ to $n\le\lfloor y/2\rfloor$. Since $\lfloor y/2\rfloor\ge y/4$ and $\sum_{n\le m}n^{-1/2}\ge\sqrt m$,

$$
Z_y\ge\frac14y^{3/2},\qquad
Z_y\beta(y)\le\zeta(3/2)y^2.
$$

Thus $\beta(y)<12\sqrt y$. The same bound holds on $(1,2)$, where $\beta(y)=y-1$. Partial summation and $\psi(t)\le(26/25)t$ give

$$
\sum_{a<x}\frac{\Lambda(a)}a
\le\frac{26}{25}(1+\log x).
$$

It follows that

$$
\boxed{0\le T\le D
\le12\sqrt x\sum_{a<x}\frac{\Lambda(a)}a
\le\frac{312}{25}\sqrt x(1+\log x).}
\tag{7}
$$

The diagonal terms satisfy

$$
\sum_p\mu_p^2,\ \mathcal D
\le U(x):=\sum_{p<x}\frac{(\log p)^2}{(\sqrt p-1)^2}
=O(\log^2x).
\tag{8}
$$

Indeed,

$$
\mu_p\le\frac{\log p}{\sqrt p-1},\qquad
E_xt_p\le(\log p)^2\sum_{r\ge2}(r-1)p^{-r/2}
=\frac{(\log p)^2}{(\sqrt p-1)^2},
$$

and

$$
U(x)\le\frac{\log x}{(1-2^{-1/2})^2}
\sum_{a<x}\frac{\Lambda(a)}a.
$$

Therefore (3), (7) and (8) prove

$$
\boxed{\mathcal C(x)=\mu(x)[\beta(x)-\mu(x)]
+O(\sqrt x\log x).}
\tag{9}
$$

This controls the combined covariance rather than estimating only its opposing signs.

## Exact centering and the continuous density term

Let

$$
A(x)=\sum_{n<x}\sqrt n\int_1^{x/n}(\psi(t)-t)\,dt,
\qquad e(x)=\frac{A(x)}{Z_x}
=\mu(x)-1-\frac{\beta(x)}2,
$$

and retain

$$
R(z)=\frac1z\int_0^z(z-u)\log(1+u)\,du.
$$

The [complete two-history identity](prime-allocation-critical-identity.md) for the critical sum is

$$
\frac{W(x)}{Z_x}
=(\mu-1)^2-\sum_p\mu_p^2-\beta(\mu-1)
+E_xR(z)+\mathcal C.
$$

Its mean contribution is $e^2-\beta^2/4$, while
$\mu d=\beta^2/4-(1+e)^2$. Equation (3) consequently gives

$$
\boxed{\frac{W(x)}{Z_x}
=E_xR(z)-T(x)-\mathcal D(x)-1-2e(x).}
\tag{10}
$$

In particular,

$$
E_xR(z)-D-\mathcal D-1-2e
\le\frac{W(x)}{Z_x}
\le E_xR(z)-\frac14D-\mathcal D-1-2e.
\tag{11}
$$

The endpoint is exactly $-1-2e$. The function $R$ and the same-prime diagonal have not been replaced or discarded.

## The leading compensation and its unresolved remainder

Put $\kappa=3\zeta(3/2)/8$. The prime number theorem and dominated convergence in the integrated formula for $\mu$ give

$$
\beta(x)\sim2\kappa\sqrt x,\qquad
\mu(x)\sim d(x)\sim\kappa\sqrt x,
\qquad e(x)=o(\sqrt x).
$$

For example, $y^{-2}\int_1^y\psi(t)dt\to1/2$, uniformly bounded by the preceding explicit prime estimate. After division by $x^2$, the formula for $Z_x\mu(x)$ is dominated by a constant times $\sum n^{-3/2}$, proving $Z_x\mu(x)/x^2\to\zeta(3/2)/2$. The formula for $\beta$ is analogous and needs no prime estimate. Equation (9) now gives

$$
\boxed{\mathcal C(x)\sim\kappa^2x>0.}
\tag{12}
$$

The smaller terms have the limits

$$
D(x)\sim2\kappa\sqrt x\log x,\qquad
T(x)\sim\kappa\sqrt x\log x,\qquad
E_xR(z)\sim\kappa\sqrt x\log x.
\tag{13}
$$

For the first two limits, their numerators are

$$
x^2\sum_{a<x}\frac{\Lambda(a)}aG(x/a),
$$

where respectively

$$
G(y)=\frac{Z_y\beta(y)}{y^2}\longrightarrow\zeta(3/2),
\qquad
G(y)=\frac{Z_yd(y)}{y^2}\longrightarrow\frac12\zeta(3/2).
$$

Both functions are bounded. Split the sum at $a=x/Y$. On the first part, $G$ is uniformly close to its limit when $Y$ is large. On the remaining fixed-ratio interval, partial summation bounds $\sum\Lambda(a)/a$ by $O(1+\log Y)$, independently of large $x$. Using the classical consequence $\sum_{a<x}\Lambda(a)/a\sim\log x$ of the prime number theorem proves the first two limits.

For the density limit, use its exact numerator

$$
Z_xE_xR(z)
=\sum_{n<x}\frac1{\sqrt n}
\left[\frac{x^2}{2n}\log(x/n)-\frac{3x^2}{4n}+x-\frac n4\right].
$$

The first term is $\tfrac12\zeta(3/2)x^2\log x+O(x^2)$ because $\sum n^{-3/2}\log n$ converges; the other terms are $O(x^2)$. Division by $Z_x\sim\tfrac43x^{3/2}$ proves the last limit in (13).

Thus the combined positive covariance cancels the leading negative mean contribution, and $T$ cancels the leading continuous-density contribution. The difference $E_xR(z)-T(x)$ remains unsigned. Neither its sign nor the eventual sign of $W$ follows from (5)–(13). No RH conclusion is asserted.

## Proof status and refutation scope

Equation (4) refutes global monotonicity of $d=\beta-\mu$ and of $\beta-2\mu$; it does not refute comparisons only at integer dilation pairs. Equations (5)–(13) prove the stated bounds and compensations, including the exact endpoint $-1-2e$ and the literal same-prime allocation term $\mathcal D$. They leave the sign of $E_xR-T$ unresolved. No variance term or continuous density term may be dropped on the strength of the separate covariance signs.

The [formal arithmetic criterion](actual-critical-sign-criterion.md) remains a downstream implication with an unproved eventual-sign hypothesis. [Conditional prime dependence](conditional-prime-dependence.md) supplies a further obstruction to a branchwise negative-regression argument under prime revelation.
