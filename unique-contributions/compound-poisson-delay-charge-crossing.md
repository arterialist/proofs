# Compound Poisson Delay Semigroup and the Unique Prime-Error Charge Crossing Law

**Authors:** Arterialist RH Research Team  
**Date:** September 2026  
**Status:** Completed Analytic Proof & Non-Asymptotic Bounds  
**Target Journal:** *Stochastic Processes and their Applications* / *Electron. J. Probab.*  
**Primary References in Repo:**
- [`building-blocks/dynamics-and-feedback/actual-source-causal-charge-law.md`](../building-blocks/dynamics-and-feedback/actual-source-causal-charge-law.md)
- [`building-blocks/factorial-and-renewal/charge-compensated-clock-response.md`](../building-blocks/factorial-and-renewal/charge-compensated-clock-response.md)
- [`building-blocks/successor-and-division/positive-successor-seed-jump-process.md`](../building-blocks/successor-and-division/positive-successor-seed-jump-process.md)

---

## Abstract

We construct the continuous compound Poisson delay semigroup $\mathcal{U}_t = \mathbb{E}[R_{X_t}]$ associated with prime jump measures on the causal Hilbert space $\mathcal{E}$ of arithmetic histories. Acting on the actual physical prime error history $a(u) = e^{-u/2}[\psi(e^u) - e^u]$, we prove that the resulting relative charge observable $Q_{\mathrm{rel}}(t) := \delta(\mathcal{U}_t a)$ is an entire function of $t$ that transitions strictly monotonically from its positive arithmetic baseline $Q_{\mathrm{rel}}(0) = \kappa > 0$ to negative infinity as $t \to \infty$. We establish that $Q_{\mathrm{rel}}(t)$ possesses a unique, simple real zero $t_* \in (0, \infty)$, and we prove sharp non-asymptotic two-sided bounds:
$$
 \frac{1}{\eta_1} \log\left(1 + \frac{\kappa}{\beta}\right) \le t_* \le \frac{1}{\eta_1} \log\left(1 + \frac{\kappa}{b_1}\right),
$$
where $\eta_1 = \widehat{\nu}(1)$, $b_1 = -\frac{1}{2} c_1 L_a(1) > 0$, $\beta = \sum_{j \ge 1} b_j < \infty$, and $L_a(j) = \frac{-\zeta'/\zeta(j+1/2)}{j+1/2} - \frac{1}{j-1/2} < 0$. Furthermore, we establish the exponential leading asymptotic $Q_{\mathrm{rel}}(t) = -b_1 e^{-t\Phi(1)} + O(e^{-t\Phi(2)})$ as $t \to \infty$. This rigorously establishes the exact causal dissipation of prime-error charges under positive delay dynamics.

---

## 1. Introduction and Setup

In the study of arithmetic fluctuations, the normalized Chebyshev prime error is defined physically on $\mathbb{R}_{\ge 0}$ by:
$$
 a(u) := e^{-u/2}[\psi(e^u) - e^u], \quad u \ge 0,
$$
which has an arithmetic relative charge $\delta(a) = \kappa > 0$. Under causal feedback dynamics, delays are mediated by the positive jump measure:
$$
 \nu(dv) := B(v) \frac{dv}{v}, \quad \operatorname{supp}(\nu) \subseteq [\log 2, \infty),
$$
with total jump intensity $\lambda := \nu((0, \infty)) \in (0, \infty)$ and Laplace exponent:
$$
 \Phi(s) := \int_0^\infty (1 - e^{-sv})\nu(dv) = \lambda - \widehat{\nu}(s), \quad \widehat{\nu}(s) := \int_0^\infty e^{-sv}\nu(dv).
$$
Let $X_t$ be a standard compound Poisson process with jump distribution $\nu/\lambda$ and rate $\lambda$, so that for $s \ge 0$:
$$
 \mathbb{E}[e^{-s X_t}] = e^{-t \Phi(s)}.
$$
The shift operator $(R_v g)(u) := g(u - v)\mathbf{1}_{u \ge v}$ defines a bounded strongly continuous contractive semigroup on $\mathcal{E}$, yielding the averaged causal delay semigroup:
$$
 \mathcal{U}_t := \mathbb{E}[R_{X_t}] = e^{-\lambda t} I + \int_{\log 2}^\infty R_v \, \mathbb{P}(X_t \in dv).
$$
The observable of interest is the time-evolved relative charge:
$$
 Q_{\mathrm{rel}}(t) := \delta(\mathcal{U}_t a).
$$

---

## 2. Arithmetic Laplace Transform and Port Strict Negativity

### Theorem 1 (Laplace Evaluation of Physical History)
For every integer $j \ge 1$, let $s = j + 1/2 > 1$. The Laplace transform $L_a(j) := \int_0^\infty e^{-ju} a(u) du$ evaluates identically to:
$$
 L_a(j) = \frac{-\zeta'/\zeta(s)}{s} - \frac{1}{s-1}.
$$
Moreover, for every $s > 1$, $-\zeta'/\zeta(s) < \frac{1}{s-1}$, and consequently:
$$
 -\frac{1}{j-1/2} \le L_a(j) < -\frac{1}{j+1/2} < 0.
$$

*Proof.* By definition of $\psi(x) = \sum_{n \le x}\Lambda(n)$, substituting $x = e^u$ converts the Laplace integral into the standard Mellin transform of $\psi(x) - x$. Tonelli's theorem on the prime-power sum yields:
$$
 \int_0^\infty e^{-ju} e^{-u/2}\psi(e^u) du = \sum_{n \ge 1}\Lambda(n) \int_{\log n}^\infty e^{-(j+1/2)u} du = \frac{1}{s}\sum_{n \ge 1}\frac{\Lambda(n)}{n^s} = \frac{-\zeta'/\zeta(s)}{s}.
$$
The background density integrates to:
$$
 \int_0^\infty e^{-(j+1/2)u} e^u du = \int_0^\infty e^{-(s-1)u} du = \frac{1}{s-1}.
$$
Subtracting the two yields the exact closed form. The strict inequality $-\zeta'/\zeta(s) < \frac{1}{s-1}$ follows from the elementary tail comparison $\mathbb{P}_s(N \ge x) < x^{1-s}$ under the zeta probability measure $\mathbb{P}_s(N=n) = n^{-s}/\zeta(s)$, or from Alzer–Kwong (2021). $\blacksquare$

### Corollary 2 (Strict Deterministic Port Signs)
Let $K = B*$ and $\mathcal{A} = (1/2 - \partial)K$ be the complete memory and derivative operators, with column kernels $d_K(u) = \frac{1}{2}\sum_{j \ge 1} c_j e^{-ju}\widehat{B}(j)$ and $d_{\mathcal{A}}(u) = \frac{1}{2}\sum_{j \ge 1}(1/2 - j)c_j e^{-ju}\widehat{B}(j)$, where $c_j = \binom{2j}{j}/4^j > 0$. Then:
$$
 \delta(K a) = \frac{1}{2}\sum_{j \ge 1} c_j \widehat{B}(j) L_a(j) < 0,
$$
$$
 \delta(\mathcal{A} a) = \frac{1}{2}\sum_{j \ge 1} \left(\frac{1}{2} - j\right) c_j \widehat{B}(j) L_a(j) > 0.
$$
In particular, the memory port and derivative port exhibit deterministic, invariant, and opposing signs.

---

## 3. The Continuous Compound Poisson Delay Semigroup

### Theorem 3 (Exact Entire Expansion of $Q_{\mathrm{rel}}(t)$)
For all $t \ge 0$, the relative charge decomposes as:
$$
 Q_{\mathrm{rel}}(t) = e^{-\lambda t}\kappa + \frac{1}{2}\sum_{j \ge 1} c_j L_a(j) \left[ e^{-t\Phi(j)} - e^{-\lambda t} \right].
$$
Equivalently, setting $b_j := -\frac{1}{2} c_j L_a(j) > 0$ and $\eta_j := \widehat{\nu}(j) \in (0, \lambda)$:
$$
 e^{\lambda t} Q_{\mathrm{rel}}(t) = \kappa - \sum_{j \ge 1} b_j \left( e^{t \eta_j} - 1 \right).
$$

*Proof.* For any fixed delay $v \ge \log 2$, the delayed history $R_v a$ falls entirely into the positive kernel branch of the causal charge functional:
$$
 \delta(R_v a) = \frac{1}{2}\sum_{j \ge 1} c_j e^{-jv} L_a(j) = -\sum_{j \ge 1} b_j e^{-jv} < 0.
$$
The compound Poisson process $X_t$ has a discrete mass $\mathbb{P}(X_t = 0) = e^{-\lambda t}$ at $v = 0$, where the history retains its arithmetic charge $\delta(a) = \kappa > 0$. On the complement $\{X_t > 0\}$, all paths satisfy $X_t \ge \log 2$. Taking expectations:
$$
 \mathbb{E}[\delta(R_{X_t} a)] = e^{-\lambda t}\kappa + \mathbb{E}\left[ \mathbf{1}_{\{X_t > 0\}} \sum_{j \ge 1} (-b_j) e^{-j X_t} \right].
$$
Since $\sum_{j \ge 1} b_j < \infty$ and $\mathbb{E}[e^{-j X_t}] = e^{-t \Phi(j)} = e^{-\lambda t} e^{t \eta_j}$, we obtain:
$$
 \mathbb{E}\left[ \mathbf{1}_{\{X_t > 0\}} e^{-j X_t} \right] = \mathbb{E}[e^{-j X_t}] - \mathbb{P}(X_t = 0) = e^{-t\Phi(j)} - e^{-\lambda t}.
$$
Multiplying by $e^{\lambda t}$ yields the stated expression. Since $0 < \eta_j \le \eta_1 < \lambda$, the series converges locally uniformly on $\mathbb{C}$, proving entireness. $\blacksquare$

---

## 4. Unique Charge Crossing and Non-Asymptotic Bounds

### Theorem 4 (Monotonicity and Unique Simple Crossing)
The function $F(t) := e^{\lambda t} Q_{\mathrm{rel}}(t)$ satisfies:
1. $F(0) = \kappa > 0$.
2. For all $t \ge 0$, $F'(t) = -\sum_{j \ge 1} b_j \eta_j e^{t \eta_j} < 0$.
3. $\lim_{t \to \infty} F(t) = -\infty$.

Consequently, $Q_{\mathrm{rel}}(t)$ has a unique zero $t_* \in (0, \infty)$, which is strictly simple ($Q_{\mathrm{rel}}'(t_*) < 0$).

### Theorem 5 (Non-Asymptotic Two-Sided Bounds on $t_*$)
The unique crossing time $t_*$ satisfies:
$$
 \frac{1}{\eta_1} \log\left(1 + \frac{\kappa}{\beta}\right) \le t_* \le \frac{1}{\eta_1} \log\left(1 + \frac{\kappa}{b_1}\right),
$$
where $\beta := \sum_{j \ge 1} b_j = -\frac{1}{2}\int_0^\infty k_+(u) a(u) du \in (0, \infty)$.

*Proof.*
- **Upper Bound:** Since $\eta_1 > \eta_2 > \cdots > 0$ and $b_j > 0$:
  $$
   \sum_{j \ge 1} b_j (e^{t \eta_j} - 1) \ge b_1 (e^{t \eta_1} - 1).
  $$
  At $t = t_0 := \frac{1}{\eta_1}\log(1 + \kappa/b_1)$, the first term alone equals $b_1(e^{t_0 \eta_1} - 1) = \kappa$. Hence $F(t_0) \le \kappa - \kappa = 0$. By strict decrease of $F$, $t_* \le t_0$.
- **Lower Bound:** Since $\eta_j \le \eta_1$ for all $j$:
  $$
   \sum_{j \ge 1} b_j (e^{t \eta_j} - 1) \le \sum_{j \ge 1} b_j (e^{t \eta_1} - 1) = \beta (e^{t \eta_1} - 1).
  $$
  At $t = t_1 := \frac{1}{\eta_1}\log(1 + \kappa/\beta)$, the upper bound equals $\beta(e^{t_1 \eta_1} - 1) = \kappa$. Hence $F(t_1) \ge \kappa - \kappa = 0$, implying $t_* \ge t_1$. $\blacksquare$

### Theorem 6 (Leading Exponential Asymptotic)
As $t \to \infty$:
$$
 Q_{\mathrm{rel}}(t) = -b_1 e^{-t\Phi(1)} + O\left(e^{-t\Phi(2)}\right),
$$
where $0 < \Phi(1) < \Phi(2) < \lambda$.

*Proof.* From the expansion $Q_{\mathrm{rel}}(t) = e^{-\lambda t}\kappa - \sum_{j \ge 1} b_j (e^{-t\Phi(j)} - e^{-\lambda t})$, the leading decay rate is governed by $\min_{j \ge 1}\Phi(j) = \Phi(1)$, since $\Phi(s) = \lambda - \widehat{\nu}(s)$ is strictly increasing in $s$. Isolating $j=1$ and noting $\Phi(1) < \Phi(2) < \lambda$ yields the result. $\blacksquare$

---

## 5. Literature context and priority status

1. **Zeta Distributions and Compound Poisson Laws:** Biane, Pitman, and Yor (2001) studied Brownian excursions, the Riemann zeta function, and infinitely divisible laws. Lin and Hu (2001) investigated compound Poisson representations of zeta distributions. However, their focus was on probability distributions on $\mathbb{R}$ whose characteristic functions are related to $\zeta(s)$.
2. **Chebyshev Error Transforms:** Previous work by Cramér, Ingham, and Montgomery examined the oscillations of $\psi(x) - x$ through Mellin and Laplace inversion, but did not couple $\psi(e^u) - e^u$ to a causal delay semigroup $R_{X_t}$ or study the induced relative charge dynamics.
3. **Priority status:** The page documents the stated sign, balance, entireness, crossing, and explicit bounds. Their priority is provisional because this audit did not perform an exhaustive literature search.

---

## 6. Summary of Equations and Constants

| Quantity | Formula | Analytic Role |
|---|---|---|
| $a(u)$ | $e^{-u/2}[\psi(e^u) - e^u]$ | Physical prime error history |
| $L_a(j)$ | $\frac{-\zeta'/\zeta(j+1/2)}{j+1/2} - \frac{1}{j-1/2}$ | Discrete Laplace coefficients ($L_a(j) < 0$) |
| $b_j$ | $-\frac{1}{2} c_j L_a(j) > 0$ | Positive modal charge coefficients |
| $\beta$ | $\sum_{j \ge 1} b_j = -\frac{1}{2}\int_0^\infty k_+(u)a(u)du$ | Total positive modal charge mass |
| $\Phi(s)$ | $\lambda - \widehat{\nu}(s)$ | Compound Poisson Laplace exponent |
| $Q_{\mathrm{rel}}(t)$ | $\delta(\mathcal{U}_t a)$ | Time-evolved relative charge observable |
| $t_*$ | Unique root of $Q_{\mathrm{rel}}(t) = 0$ | Exact charge crossing dissipation time |
