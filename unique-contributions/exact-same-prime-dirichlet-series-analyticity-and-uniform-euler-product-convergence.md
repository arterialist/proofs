# Contribution 169: Exact Same-Prime Dirichlet Series Analyticity and Uniform Euler Product Convergence

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SamePrimeDirichlet.lean`](../../formalization/BuildingBlocks/SamePrimeDirichlet.lean), [`building-blocks/dirichlet/same-prime-dirichlet.md`](../../building-blocks/dirichlet/same-prime-dirichlet.md)  
**Classification:** Analytic Number Theory / Dirichlet Series / Euler Products / Several Complex Variables / Weierstrass M-Test / Prime Powers / Zero-Free Half-Planes

---

## 1. Executive Summary and Mathematical Statement

In the pair correlation of primes and the spectral theory of Dirichlet convolutions, the diagonal contribution consists of pairs of prime powers $p^j$ and $p^k$ arising from the same base prime $p$. The corresponding 2D Dirichlet series sums over all pairs $(p, k) \in \mathcal{P} \times \mathbb{N}$ with proper power exponents $k+2$ and multiplicity $k+1$.

This contribution proves:

1. **Summability of the Prime-Power Majorant on $\text{Re}(s) > 1/2$:**  
   For any $\sigma > 1/2$, the bivariate sequence on $\mathcal{P} \times \mathbb{N}$ defined by:
   $$
   M(\sigma, p, k) = \frac{\log^2 p}{p^{2\sigma}} (k+1) 2^{-\sigma k}
   $$
   is strictly summable on $\mathcal{P} \times \mathbb{N}$.
2. **Exact Proper-Power Geometric Summation:**  
   For each fixed prime $p$ and any $\text{Re}(s) > 0$, the proper-power geometric series evaluates in closed form to:
   $$
   \sum_{k=0}^\infty \log^2 p (k+1) p^{-(k+2)s} = \frac{\log^2 p \cdot p^{-2s}}{(1 - p^{-s})^2} = \frac{\log^2 p}{(p^s - 1)^2}.
   $$
3. **Exact Bivariate-to-Euler Sum Identity:**  
   For all $\text{Re}(s) > 1/2$, the 2D series converges absolutely and equals the Euler prime sum:
   $$
   \sum_{(p, k) \in \mathcal{P} \times \mathbb{N}} \log^2 p (k+1) p^{-(k+2)s} = \sum_{p \in \mathcal{P}} \frac{\log^2 p}{(p^s - 1)^2} = H(s).
   $$
4. **Locally Uniform Convergence and Analyticity on $\text{Re}(s) > 1/2$:**  
   The finite partial sums $\sum_{(p, k) \in \mathcal{F}} \log^2 p (k+1) p^{-(k+2)s}$ converge uniformly to $H(s)$ on half-planes $\text{Re}(s) \ge \sigma > 1/2$. Consequently, $H(s)$ is holomorphic and analytic on the entire half-plane:
   $$
   \mathcal{H}_{1/2} = \{ s \in \mathbb{C} : \text{Re}(s) > 1/2 \}.
   $$
   In particular, $H(s)$ has NO POLES or singularities anywhere on $\text{Re}(s) > 1/2$.

---

## 2. Mathematical Proof

### 2.1. Prime Majorant Summability
For $\sigma > 1/2$, $2\sigma > 1$. The sum $\sum_{n=1}^\infty \frac{\log^2 n}{n^{2\sigma}}$ converges because the abscissa of absolute convergence of the second logarithmic derivative of $\zeta(s)$ is $1$. Restricting to primes $\mathcal{P} \subset \mathbb{N}$ preserves summability:
$$
\sum_{p \in \mathcal{P}} \frac{\log^2 p}{p^{2\sigma}} < \infty.
$$
For the geometric factor in $k$, since $\sigma > 1/2 > 0$, $2^{-\sigma} < 1$.
The binomial series $\sum_{k=0}^\infty (k+1) (2^{-\sigma})^k = \frac{1}{(1 - 2^{-\sigma})^2} < \infty$.
By Tonelli's theorem for non-negative double series, the product majorant $M(\sigma, p, k)$ is summable on $\mathcal{P} \times \mathbb{N}$.

### 2.2. Termwise Bound and Absolute Convergence
For any $s$ with $\text{Re}(s) \ge \sigma$:
$$
\|p^{-s}\| = p^{-\text{Re}(s)} \le p^{-\sigma} \le 2^{-\sigma} < 1.
$$
The general power term satisfies:
$$
\| \text{powerTerm}(p, k, s) \| = \log^2 p (k+1) p^{-(k+2)\text{Re}(s)} \le \frac{\log^2 p}{p^{2\sigma}} (k+1) 2^{-\sigma k} = M(\sigma, p, k).
$$
By the Weierstrass $M$-test, the 2D series converges absolutely and uniformly on $\{s \in \mathbb{C} : \text{Re}(s) \ge \sigma\}$.

### 2.3. Closed-Form Summation
For each fixed $p$, using the identity for the derivative of a geometric series:
$$
\sum_{k=0}^\infty (k+1) z^{k+2} = z^2 \sum_{k=0}^\infty (k+1) z^k = \frac{z^2}{(1-z)^2} \quad (|z| < 1).
$$
Setting $z = p^{-s}$ yields:
$$
\sum_{k=0}^\infty \text{powerTerm}(p, k, s) = \log^2 p \frac{p^{-2s}}{(1 - p^{-s})^2} = \frac{\log^2 p}{(p^s - 1)^2}.
$$
By Fubini's theorem for absolutely summable double series, summing over $p$ gives $H(s)$.

### 2.4. Analyticity on $\text{Re}(s) > 1/2$
Each term $\text{powerTerm}(p, k, s)$ is an entire function of $s$.
Since the series converges locally uniformly on the open half-plane $\text{Re}(s) > 1/2$, Weierstrass's theorem on uniform limits of analytic functions implies that $H(s)$ is analytic on $\text{Re}(s) > 1/2$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SamePrimeDirichlet` in `formalization/BuildingBlocks/SamePrimeDirichlet.lean`):
```lean
lemma primeMajorant_summable {σ : ℝ} (hσ : 1/2 < σ) :
    Summable (primeMajorant σ)

lemma majorant_summable {σ : ℝ} (hσ : 1/2 < σ) : Summable (majorant σ)

theorem powerTerm_norm_summable {s : ℂ} (hs : 1/2 < s.re) :
    Summable (fun i : Nat.Primes × ℕ => ‖powerTerm i.1 i.2 s‖)

theorem powerTerm_hasSum (p : Nat.Primes) {s : ℂ} (hs : 0 < s.re) :
    HasSum (fun k => powerTerm p k s) (samePrimeTerm p s)

theorem expanded_eq_H {s : ℂ} (hs : 1/2 < s.re) : expanded s = H s

theorem expanded_uniformConvergence {σ : ℝ} (hσ : 1/2 < σ) :
    TendstoUniformlyOn
      (fun t : Finset (Nat.Primes × ℕ) => fun s : ℂ =>
        ∑ i ∈ t, powerTerm i.1 i.2 s)
      expanded Filter.atTop {s : ℂ | σ ≤ s.re}

theorem H_differentiableOn :
    DifferentiableOn ℂ H {s : ℂ | 1/2 < s.re}

theorem H_analyticAt {s : ℂ} (hs : 1/2 < s.re) : AnalyticAt ℂ H s
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dirichlet series of arithmetic convolutions and Euler products (Montgomery-Vaughan 2007, Apostol 1976). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the exact summability of the 2D same-prime majorant and proves that the same-prime Dirichlet series $H(s)$ is analytic throughout the critical half-plane $\text{Re}(s) > 1/2$ in Lean 4.
- **Target Venues:** *Ramanujan Journal* or *Journal of Number Theory*.
