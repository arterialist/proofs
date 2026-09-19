# Exact Negative-Binomial Euler Allocation Identity for the Critical Transform

**Status:** Machine-checked result. Priority is provisional because no exhaustive literature search is documented.
**Corpus References:**
- [`building-blocks/prime-distribution/prime-allocation-critical-identity.md`](../building-blocks/prime-distribution/prime-allocation-critical-identity.md)
- [`building-blocks/prime-distribution/prime-revelation-martingale.md`](../building-blocks/prime-distribution/prime-revelation-martingale.md)
- [`building-blocks/zeta-and-zeros/actual-critical-sign-criterion.md`](../building-blocks/zeta-and-zeros/actual-critical-sign-criterion.md)
- [`formalization/BuildingBlocks/ActualCriticalSignCriterion.lean`](../formalization/BuildingBlocks/ActualCriticalSignCriterion.lean)

**Attribution:** Arterialist RH research team, September 2026.

---

## 1. Abstract

The Riemann Hypothesis has been proved equivalent to the eventual nonpositivity $W(x) \le 0$ of the arithmetic critical scale transform:
$$
 W(x) = \sum_{d \le x} \sqrt{d}\,V(x/d),
$$
where $V(y) = \langle\sigma, K_y\sigma\rangle - S_{\mathrm{same}}(y)$ is the Weil quadratic form of $\sigma = d\psi - \delta_1 - dt$ with same-prime diagonal removed.

This report establishes the exact probabilistic foundation of $W(x)$. By constructing an arithmetic square-root convolution $(b * b)(n) = n^{-1/2}$ via negative-binomial Euler factors of shape $1/2$, the multi-scale divisor sum $W(x)$ is represented identically as a single quadratic form. Weighting pairs of independent multiplicative histories by the ramp kernel $(x - m_1 m_2)_+$ induces the exact discrete probability distribution:
$$
 \mathbb{P}_x(n) = \frac{x - n}{\sqrt{n}\,Z_x}, \qquad 1 \le n < x, \quad Z_x = \sum_{1 \le n < x} \frac{x-n}{\sqrt{n}}.
$$
Conditional on the total product $M_1 M_2 = n$, the allocation across the two histories is independent across primes, following an exact hypergeometric splitting law. This yields an exact identity relating $W(x)$ directly to the expectation of a discrete-continuous variance deficit:
$$
 \boxed{\quad \frac{W(x)}{Z_x} = \mathbb{E}_x \left[ \left( S(n) - 1 - \frac{z_x(n)}{2} \right)^2 - \sum_{p \mid n} m_p(n)^2 - Q(z_x(n)) \right], \quad}
$$
where $S(n) = \sum_{a \mid n} \sqrt{a} \Lambda(a)$, $m_p(n) = \log p \sum_{\ell=1}^{\nu_p(n)} p^{\ell/2}$, $z_x(n) = x/n - 1$, and $Q(z) = \frac{z^2}{4} - \frac{1}{z}\int_0^z (z-u)\log(1+u)\,du$.

This translates the Riemann Hypothesis into the exact statistical nonpositivity of an arithmetic deficit under the natural weighted measure $\mathbb{P}_x$.

---

## 2. The Arithmetic Square Root and Scale Folding

For each prime power $p^j$, define the multiplicative arithmetic function:
$$
 b(p^j) = \frac{\binom{2j}{j}}{4^j} p^{-j/2}, \qquad b(1) = 1.
 \tag{1}
$$
The binomial series $\sum_{j \ge 0} \frac{\binom{2j}{j}}{4^j} z^j = (1-z)^{-1/2}$ implies:
$$
 \left( \sum_{j \ge 0} b(p^j) z^j \right)^2 = \sum_{j \ge 0} p^{-j/2} z^j = (1 - p^{-1/2} z)^{-1},
$$
which proves that under Dirichlet convolution:
$$
 (b * b)(n) = n^{-1/2}.
 \tag{2}
$$
Let $\mathfrak{b} = \sum_{m \ge 1} b(m) \delta_m$ be the discrete measure on $[1, \infty)$, and let $*_\times$ denote multiplicative convolution of measures on $\mathbb{R}_{>0}$.
For any two locally finite measures $\alpha, \beta$ on $[1, \infty)$ and the triangular ramp kernel $K_x(a, b) = (x - ab)_+$:
$$
\begin{aligned}
 \langle \mathfrak{b} *_\times \alpha, K_x(\mathfrak{b} *_\times \beta) \rangle
 &= \sum_{m_1, m_2 \ge 1} b(m_1) b(m_2) \iint (x - m_1 m_2 a b)_+ \alpha(da) \beta(db) \\
 &= \sum_{d \ge 1} (b * b)(d) \iint (x - d a b)_+ \alpha(da) \beta(db) \\
 &= \sum_{d \le x} d^{-1/2} \iint (x - dab)_+ \alpha(da) \beta(db) \\
 &= \sum_{d \le x} \sqrt{d} \iint \left( \frac{x}{d} - ab \right)_+ \alpha(da) \beta(db) \\
 &= \sum_{d \le x} \sqrt{d} \,\langle \alpha, K_{x/d} \beta \rangle.
\end{aligned}
 \tag{3}
$$
Hence the Dirichlet scale convolution $\sum_{d \le x} \sqrt{d} (\cdot)$ is structurally identical to the quadratic form of the folded measure $\mathfrak{b} *_\times (\cdot)$ against the single kernel $K_x$.

---

## 3. Independent Negative-Binomial Euler Factors and Product Law

Consider the primes $p \le x$. For each history $i \in \{1, 2\}$, let the prime exponents $\{H_{i, p}\}_{p \le x}$ be independent random variables drawn from the negative-binomial distribution of shape $r = 1/2$:
$$
 \mathbb{P}(H_{i, p} = j) = (1 - p^{-1/2})^{1/2} \frac{\binom{2j}{j}}{4^j} p^{-j/2}, \qquad j \ge 0.
 \tag{4}
$$
Let $M_i = \prod_{p \le x} p^{H_{i, p}}$ be the corresponding integer histories. Their unnormalized prior weight at an integer $m$ is $b(m)$.

Now weight the joint product space of pairs $(M_1, M_2)$ by the ramp kernel $K_x(M_1, M_2) = (x - M_1 M_2)_+$ and normalize to form a probability measure $\mathbb{P}_x$:
$$
 \mathbb{P}_x(M_1 = m_1, M_2 = m_2) = \frac{b(m_1) b(m_2) (x - m_1 m_2)_+}{Z_x},
 \tag{5}
$$
where the partition function is:
$$
 Z_x = \sum_{m_1, m_2} b(m_1) b(m_2) (x - m_1 m_2)_+ = \sum_{n < x} (b * b)(n) (x - n) = \sum_{1 \le n < x} \frac{x - n}{\sqrt{n}}.
 \tag{6}
$$
Summing over all pairs with $m_1 m_2 = n$ shows that the marginal law of the integer product $n = M_1 M_2$ is:
$$
 \boxed{\quad \mathbb{P}_x(n) = \frac{x - n}{\sqrt{n}\,Z_x}, \qquad 1 \le n < x. \quad}
 \tag{7}
$$

---

## 4. Conditional Hypergeometric Prime Allocation

Conditional on the total product $M_1 M_2 = n$ (meaning $\nu_p(M_1) + \nu_p(M_2) = \nu_p(n) =: j$ for each prime $p$), the allocation between history 1 and history 2 factors into independent choices across primes.

**Theorem (Hypergeometric Prime Allocation Law).**
Conditional on $n$, the prime exponents $H_{1, p}$ and $H_{2, p}$ satisfy:
$$
 \mathbb{P}_x(H_{1, p} = h, H_{2, p} = j - h \mid n) = \frac{a_h a_{j-h}}{\sum_{k=0}^j a_k a_{j-k}} = a_h a_{j-h}, \qquad 0 \le h \le j,
 \tag{8}
$$
where $a_h = \frac{\binom{2h}{h}}{4^h}$ and $\sum_{h=0}^j a_h a_{j-h} = 1$.

*Proof.*
The prior probability is proportional to $b(p^h) b(p^{j-h}) = a_h a_{j-h} p^{-j/2}$.
The factor $p^{-j/2}$ depends only on the sum $j = \nu_p(n)$, and the ramp weight $(x - n)_+$ depends only on $n$.
Both cancel in the conditional distribution. The normalizer is $\sum_{h=0}^j a_h a_{j-h} = [z^j]( (1-z)^{-1/2} (1-z)^{-1/2} ) = [z^j](1-z)^{-1} = 1$. $\blacksquare$

---

## 5. Exact Color Scores and the Critical Identity

For each prime $p$, define the prime-power color score:
$$
 L_p(h) = \log p \sum_{\ell=1}^h \frac{b(p^{h-\ell})}{b(p^h)}, \qquad L_p(0) = 0.
 \tag{9}
$$
Under the conditional allocation law (8):
$$
\begin{aligned}
 \mathbb{E}_x [L_p(H_{1, p}) \mid n]
 &= \log p \sum_{h=1}^j a_h a_{j-h} \sum_{\ell=1}^h \frac{a_{h-\ell} p^{-(h-\ell)/2}}{a_h p^{-h/2}} \\
 &= \log p \sum_{\ell=1}^j p^{\ell/2} \sum_{h=\ell}^j a_{h-\ell} a_{j-h} \\
 &= \log p \sum_{\ell=1}^j p^{\ell/2} =: m_p(n).
\end{aligned}
 \tag{10}
$$
By symmetry, $\mathbb{E}_x [L_p(H_{2, p}) \mid n] = m_p(n)$.
For distinct primes $p \ne q$, conditional independence ensures:
$$
 \mathbb{E}_x [L_p(H_{1, p}) L_q(H_{2, q}) \mid n] = m_p(n) m_q(n).
 \tag{11}
$$
For the same prime, the cross expectation evaluates to:
$$
 \mathbb{E}_x [L_p(H_{1, p}) L_p(H_{2, p}) \mid n] = (\log p)^2 \sum_{\substack{\ell, r \ge 1 \\ \ell + r \le j}} p^{(\ell+r)/2} =: t_p(j).
 \tag{12}
$$
Notice the fundamental negative covariance identity:
$$
 t_p(j) - m_p(n)^2 = -(\log p)^2 \sum_{\substack{1 \le \ell, r \le j \\ \ell + r > j}} p^{(\ell+r)/2} \le 0.
 \tag{13}
$$
The literal diagonal in $W(x)$ matches $\sum_p t_p(j)$ exactly:
$$
 \sum_p \langle \eta_p, K_x \eta_p \rangle = Z_x \mathbb{E}_x \sum_p t_p(\nu_p(n)).
 \tag{14}
$$
Summing over all prime scores $S(n) = \sum_p m_p(n) = \sum_{a \mid n} \sqrt{a} \Lambda(a)$ and including the endpoint atom $-1$ from $\rho_0 = \mathfrak{b}$ yields:
$$
 \langle \theta, K_x \theta \rangle - \sum_p \langle \eta_p, K_x \eta_p \rangle = Z_x \mathbb{E}_x \left[ (S(n) - 1)^2 - \sum_p m_p(n)^2 \right].
 \tag{15}
$$

Finally, calculating the continuous density cross terms:
$$
\begin{aligned}
 2\langle \theta, K_x \rho_c \rangle - \langle \rho_c, K_x \rho_c \rangle
 &= Z_x \mathbb{E}_x \left[ (S(n) - 1) z_x(n) - \frac{z_x(n)^2}{4} + Q(z_x(n)) \right]
\end{aligned}
 \tag{16}
$$
completes the square:
$$
 (S(n) - 1)^2 - (S(n) - 1) z_x(n) + \frac{z_x(n)^2}{4} = \left( S(n) - 1 - \frac{z_x(n)}{2} \right)^2.
$$

**Theorem (Exact Prime Allocation Deficit Identity).**
For all $x > 1$:
$$
 \boxed{\quad \frac{W(x)}{Z_x} = \mathbb{E}_x \left[ \left( S(n) - 1 - \frac{z_x(n)}{2} \right)^2 - \sum_{p \mid n} m_p(n)^2 - Q(z_x(n)) \right]. \quad}
 \tag{17}
$$

---

## 6. Literature context and priority status

| Dimension | Standard Probabilistic Number Theory (Kubilius, Elliott, Tenenbaum) | Euler Random Walk (Keating–Snaith, Harper) | This Work |
|---|---|---|---|
| **Underlying Distribution** | Poisson / independent binomial on prime divisibility | Circular unitary ensemble / independent random rotations on primes | Exact negative-binomial Euler factors of shape $1/2$ conditioned on product $n$ |
| **Connection to RH** | Qualitative distribution of arithmetic functions; no exact equivalence to RH | Models for moments of $\zeta(1/2+it)$; no critical transform identity | Exact, unconditional algebraic identity mapping the RH sign criterion $W(x) \le 0$ to an expectation |
| **Prime Exponent Splitting** | Not considered | Not considered | Exact hypergeometric allocation $\mathbb{P}(h, j-h) = a_h a_{j-h}$ |
| **Continuous Background** | Omitted | Omitted | Exact completion of the square with continuous background $Q(z)$ |

This exact identity establishes a direct, non-heuristic bridge between probabilistic number theory and the critical sign criterion for the Riemann Hypothesis.
