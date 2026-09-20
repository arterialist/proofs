# Contribution 276: Exact Same-Prime Dirichlet Series and Half-Plane Holomorphy

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SamePrimeDirichlet.lean`](../../formalization/BuildingBlocks/SamePrimeDirichlet.lean), [`building-blocks/prime-distribution/same-prime-dirichlet.md`](../../building-blocks/prime-distribution/same-prime-dirichlet.md)  
**Classification:** Analytic Number Theory / Dirichlet Series / Prime Powers / Holomorphic Continuation / Euler Products / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the Montgomery-Dyson pair correlation conjecture and prime-power autocorrelation analysis, the prime sum splits into distinct-prime cross pairs and diagonal same-prime pairs. The same-prime contribution generates a Dirichlet series with arithmetic weights involving $(\log p)^2$ and multiplicity $k+1$ for powers $p^{k+2}$.

This contribution proves:

1. **Holomorphy and Analyticity on the Critical Half-Plane $\text{Re}(s) > 1/2$:**  
   The same-prime Euler series:
   $$
   H(s) = \sum_{p \in \mathcal{P}} \frac{(\log p)^2 p^{-2s}}{(1 - p^{-s})^2}
   $$
   is unconditionally holomorphic on the open half-plane $\{s \in \mathbb{C} : \text{Re}(s) > 1/2\}$ and analytic at every point $s$ with $\text{Re}(s) > 1/2$, without assuming the Riemann Hypothesis or any zero-free region.
2. **Exact Power-Term Multiplicity Factorization:**  
   For each individual prime $p$ and any $s \in \mathbb{C}$ with $\text{Re}(s) > 0$, the series over all higher powers $k \ge 0$ converges absolutely to the closed-form Euler factor:
   $$
   \sum_{k=0}^\infty (\log p)^2 (k+1) p^{-(k+2)s} = \frac{(\log p)^2 p^{-2s}}{(1 - p^{-s})^2}.
   $$
3. **Double-Sum Reordering Identity:**  
   For all $s \in \mathbb{C}$ with $\text{Re}(s) > 1/2$:
   $$
   \sum_{(p, k) \in \mathcal{P} \times \mathbb{N}} (\log p)^2 (k+1) p^{-(k+2)s} = \sum_{p \in \mathcal{P}} \frac{(\log p)^2 p^{-2s}}{(1 - p^{-s})^2} = H(s).
   $$
4. **Locally Uniform Convergence via Bounded Majorant:**  
   For every $\sigma > 1/2$, there exists a single summable majorant:
   $$
   M_\sigma(p, k) = \frac{(\log p)^2}{p^{2\sigma}} (k+1) 2^{-k\sigma}
   $$
   such that $\sum_{(p, k)} M_\sigma(p, k) < \infty$, guaranteeing uniform convergence of the partial sums on the entire closed half-plane $\{s \in \mathbb{C} : \text{Re}(s) \ge \sigma\}$.

---

## 2. Mathematical Proof

### 2.1. Individual Prime Geometric Sum
Let $w = p^{-s}$. Since $\text{Re}(s) > 0$ and $p \ge 2$:
$$
|w| = |p^{-s}| = p^{-\text{Re}(s)} \le 2^{-\text{Re}(s)} < 1.
$$
By the binomial geometric series with exponent $-2$:
$$
\sum_{k=0}^\infty (k+1) w^k = \frac{1}{(1-w)^2}.
$$
Multiplying by $(\log p)^2 w^2 = (\log p)^2 p^{-2s}$:
$$
\sum_{k=0}^\infty (\log p)^2 (k+1) p^{-(k+2)s} = (\log p)^2 p^{-2s} \sum_{k=0}^\infty (k+1) (p^{-s})^k = \frac{(\log p)^2 p^{-2s}}{(1 - p^{-s})^2}.
$$

### 2.2. Summability of Prime Majorant
For $p \ge 2$ and $\text{Re}(s) \ge \sigma > 1/2$:
$$
|p^{-(k+2)s}| = |p^{-2s}| \cdot |p^{-s}|^k \le p^{-2\sigma} \cdot 2^{-k\sigma}.
$$
Thus:
$$
|(\log p)^2 (k+1) p^{-(k+2)s}| \le \frac{(\log p)^2}{p^{2\sigma}} (k+1) 2^{-k\sigma} = M_\sigma(p, k).
$$
Summing over $k \in \mathbb{N}$:
$$
\sum_{k=0}^\infty (k+1) 2^{-k\sigma} = \frac{1}{(1 - 2^{-\sigma})^2} < \infty.
$$
Summing over primes $p \in \mathcal{P}$:
Since $2\sigma > 1$, the Dirichlet series $\sum_n (\log n)^2 n^{-2\sigma}$ converges absolutely by comparison with $\zeta(2\sigma)$ and its derivatives. By restriction to the subset of primes, $\sum_p (\log p)^2 p^{-2\sigma} < \infty$.
Hence the product series $\sum_{p, k} M_\sigma(p, k)$ converges absolutely.

### 2.3. Holomorphy
Each term $s \mapsto (\log p)^2 (k+1) p^{-(k+2)s}$ is entire on $\mathbb{C}$. By the Weierstrass uniform convergence theorem for series of holomorphic functions on open subsets, the locally uniform limit $H(s)$ is holomorphic on $\{s : \text{Re}(s) > \sigma\}$. Since this holds for every $\sigma > 1/2$, $H(s)$ is holomorphic on $\text{Re}(s) > 1/2$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SamePrimeDirichlet` in `formalization/BuildingBlocks/SamePrimeDirichlet.lean`):
```lean
theorem powerTerm_hasSum (p : Nat.Primes) {s : ℂ} (hs : 0 < s.re) :
    HasSum (fun k => powerTerm p k s) (samePrimeTerm p s)

theorem expanded_eq_H {s : ℂ} (hs : 1/2 < s.re) : expanded s = H s

theorem uniform_majorant {σ : ℝ} (hσ : 1/2 < σ) :
    Summable (majorant σ) ∧
    ∀ (i : Nat.Primes × ℕ) (s : ℂ), σ ≤ s.re →
      ‖powerTerm i.1 i.2 s‖ ≤ majorant σ i

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

- **Prior Literature:** Pair correlation of zeros and prime-power sums (Montgomery 1973, Goldston-Pintz-Yıldırım 2009). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the unconditional holomorphy and exact double-sum rearrangement of the same-prime Dirichlet series up to the critical boundary $\text{Re}(s) = 1/2$ without RH.
- **Target Venues:** *Ramanujan Journal* or *Journal of Number Theory*.
