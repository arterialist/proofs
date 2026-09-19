# Exact negative cross-prime covariance and upper-orthant product bounds

**Status:** mathematical proof via finite-grid martingale coupling, September 2026. The scope is the exact cutoff law below; this page does not claim full negative association.
Note location:
- [building-blocks/prime-distribution/prime-score-negative-covariance.md](../building-blocks/prime-distribution/prime-score-negative-covariance.md)

Attribution: Arterialist RH research team, September 2026.
In probabilistic number theory, the heuristic that prime factors compete for space has been known since
Kubilius (1962). This theorem proves exact pairwise negative covariance and an upper-orthant product
inequality for increasing functions of distinct prime valuations under the arithmetic causal ramp
distribution. The product inequality is obtained from the finite divisibility comparison below; it is
not a claim of full negative association for arbitrary increasing functions of grouped coordinates.

## Statement

For any real $x > 1$, define the arithmetic causal ramp probability distribution on $\{n \in \mathbb{N} : n < x\}$:
\[
 Z_x = \sum_{n < x} \frac{x-n}{\sqrt{n}}, \qquad P_x(n) = \frac{x-n}{\sqrt{n} Z_x}.
\]
For each prime $p$, define the prime-power score:
\[
 m_p(n) = \log p \sum_{j=1}^{v_p(n)} p^{j/2}.
\]

**Theorem 1 (Exact Pairwise Negative Covariance).**
For any distinct primes $p \ne q$ and any real $x > \max(p, q)$:
\[
 \boxed{\quad \operatorname{Cov}_x(m_p, m_q) < 0. \quad}
\]
Moreover, the exact covariance identity holds:
\[
 -\operatorname{Cov}_x(m_p, m_q) = \frac{\log p}{Z_x} \sum_{p^j < x} p^j Z_{x/p^j} \left[ \mu_q(x) - \mu_q(x/p^j) \right] > 0,
\]
where $\mu_q(x) = \mathbb{E}_x m_q$ is strictly increasing on $(q, \infty)$.

**Theorem 2 (Upper-orthant product inequality for prime valuations).**
For any finite set of distinct primes $S \subset \mathbb{P}$ and any non-decreasing functions $f_p : \mathbb{N}_0 \to [0, \infty)$:
\[
 \boxed{\quad \mathbb{E}_x \prod_{p \in S} f_p(v_p(n)) \le \prod_{p \in S} \mathbb{E}_x f_p(v_p(n)). \quad}
\]
In particular, for any thresholds $k_p \in \mathbb{N}_0$:
\[
 P_x\left(\bigcap_{p \in S} \{v_p(n) \ge k_p\}\right) \le \prod_{p \in S} P_x(v_p(n) \ge k_p).
\]

## Proof mechanism: The finite-grid martingale coupling

The entire monotonicity relies on a discrete coupling of uniform grid variables:
Let $X_N \sim \operatorname{Uniform}(\{j/(N+1) : 1 \le j \le N\})$.
Conditionally on $X_N = j/(N+1)$, define $Y \in \{j/(N+2), (j+1)/(N+2)\}$ with probabilities
$(N+1-j)/(N+1)$ and $j/(N+1)$, which satisfies $\mathbb{E}[Y \mid X_N] = X_N$ and $Y \sim X_{N+1}$.
Strict Jensen convexity of $t \mapsto 1/\sqrt{t}$ on $(0, 1)$ establishes that the power-sum ratio
$T_N = \left(\sum_{n=1}^N n^{1/2}\right) / \left(\sum_{n=1}^N n^{-1/2}\right)$ satisfies:
\[
 \frac{T_{N+1}}{N+2} < \frac{T_N}{N+1} \qquad (N \ge 1).
\]
This implies that the dilation ratio $F_a(x) = a Z_{x/a} / Z_x$ is strictly increasing for $x > a$,
which establishes the strict monotonicity of $\mu_q(x)$ and drives the strict positivity of the
covariance bracket.

Full proof:
- [building-blocks/prime-distribution/prime-score-negative-covariance.md](../building-blocks/prime-distribution/prime-score-negative-covariance.md)
