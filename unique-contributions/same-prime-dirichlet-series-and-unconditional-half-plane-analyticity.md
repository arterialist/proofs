# Contribution 64: Same-Prime Dirichlet Series and Unconditional Half-Plane Analyticity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SamePrimeDirichlet.lean`](../../formalization/BuildingBlocks/SamePrimeDirichlet.lean)  
**Classification:** Analytic Number Theory / Dirichlet Series / Euler Products / Complex Analysis

---

## 1. Executive Summary and Mathematical Statement

In the Montgomery pair correlation conjecture and Goldbach circle method analyses, the diagonal terms in the double sum $\sum_{p, q} \frac{\Lambda(p)\Lambda(q)}{p^s q^s}$ correspond to $p = q$. The resulting "same-prime" Dirichlet series captures the diagonal prime correlation and second-order fluctuations of the logarithmic derivative of the Riemann zeta function.

This contribution proves:

1. **Closed-Form Representation of the Same-Prime Dirichlet Series:**  
   The same-prime diagonal series is given by:
   $$
   H(s) = \sum_{p} \frac{(\log p)^2 p^{-2s}}{(1 - p^{-s})^2} = \sum_{p} \sum_{k=0}^\infty (\log p)^2 (k+1) p^{-(k+2)s},
   $$
   where every prime power exponent $k+2$ appears with its exact multiplicity $k+1 = \sum_{\substack{j_1, j_2 \ge 1 \\ j_1 + j_2 = k+2}} 1$, coming from all partitions into proper powers.
2. **Explicit Uniform Majorant on Half-Planes:**  
   For every abscissa $\sigma > 1/2$, the double sequence is controlled by a factorized summable majorant on the closed half-plane $\operatorname{Re}(s) \ge \sigma$:
   $$
   \left| (\log p)^2 (k+1) p^{-(k+2)s} \right| \le \frac{(\log p)^2}{p^{2\sigma}} (k+1) (2^{-\sigma})^k = \operatorname{majorant}(\sigma, p, k).
   $$
   The prime component is summable by comparison to $L(2\sigma, 1)$ since $2\sigma > 1$, and the geometric power series $\sum_{k=0}^\infty (k+1) 2^{-k\sigma} = (1 - 2^{-\sigma})^{-2}$ converges absolutely since $2^{-\sigma} < 1$.
3. **Locally Uniform Convergence:**  
   The partial sums of the double series converge locally uniformly on $\{s \in \mathbb{C} \mid \operatorname{Re}(s) > 1/2\}$.
4. **Unconditional Holomorphy and Analyticity Across $\operatorname{Re}(s) > 1/2$:**  
   $H(s)$ defines a holomorphic function on the open half-plane $\operatorname{Re}(s) > 1/2$, and is complex analytic at every point $s$ with $\operatorname{Re}(s) > 1/2$, without any Riemann Hypothesis or zero-free region assumption.

---

## 2. Mathematical Proof

### 2.1. Power Expansion of Diagonal Euler Factors
For $\operatorname{Re}(s) > 0$, $|p^{-s}| = p^{-\operatorname{Re}(s)} \le 2^{-\operatorname{Re}(s)} < 1$.
Expanding the binomial power series:
$$
(1 - p^{-s})^{-2} = \sum_{k=0}^\infty (k+1) p^{-ks}.
$$
Multiplying by $(\log p)^2 p^{-2s}$ yields:
$$
\frac{(\log p)^2 p^{-2s}}{(1 - p^{-s})^2} = \sum_{k=0}^\infty (\log p)^2 (k+1) p^{-(k+2)s}.
$$

### 2.2. Summability of the Majorant
Let $\operatorname{Re}(s) \ge \sigma > 1/2$. For every prime $p \ge 2$:
$$
|p^{-(k+2)s}| = p^{-(k+2)\operatorname{Re}(s)} \le p^{-2\sigma} p^{-k\sigma} \le p^{-2\sigma} 2^{-k\sigma}.
$$
Thus:
$$
\sum_{p} \sum_{k=0}^\infty |(\log p)^2 (k+1) p^{-(k+2)s}| \le \left( \sum_p \frac{(\log p)^2}{p^{2\sigma}} \right) \left( \sum_{k=0}^\infty (k+1) 2^{-k\sigma} \right).
$$
Since $\sigma > 1/2$, $2\sigma > 1$, so $\sum_n \frac{(\log n)^2}{n^{2\sigma}} < \infty$ by the abscissa of convergence of differentiated Dirichlet series.
Since $\sigma > 0$, $r = 2^{-\sigma} < 1$, so $\sum_{k=0}^\infty (k+1) r^k = \frac{1}{(1 - r)^2} < \infty$.
Hence the majorant is summable on $\operatorname{Primes} \times \mathbb{N}$.

### 2.3. Analyticity
By the Weierstrass M-test for several indices and Fubini–Tonelli for sums, the series converges absolutely and locally uniformly. Each term $s \mapsto (\log p)^2 (k+1) p^{-(k+2)s}$ is entire. By Morera's theorem / Weierstrass theorem for uniform limits of holomorphic functions, $H(s)$ is holomorphic on $\operatorname{Re}(s) > 1/2$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SamePrimeDirichlet`):
```lean
theorem uniform_majorant {σ : ℝ} (hσ : 1/2 < σ) :
    Summable (majorant σ) ∧
    ∀ (i : Nat.Primes × ℕ) (s : ℂ), σ ≤ s.re →
      ‖powerTerm i.1 i.2 s‖ ≤ majorant σ i

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

- **Prior Literature:** The same-prime series appears in Montgomery's pair correlation paper (1973) and Goldston–Pintz–Yıldırım (2009) as an asymptotic quantity. A rigorous, machine-checked proof of its unconditional analyticity on $\operatorname{Re}(s) > 1/2$ with exact power multiplicity formulas had not been formalized in Lean 4.
- **Advancement:** Gives a Lean 4 proof of analyticity for the stated diagonal pair-correlation Dirichlet series on $\operatorname{Re}(s) > 1/2$. Priority among formalizations is not established by this audit.
- **Target Venues:** *Journal of Number Theory* or *Mathematische Zeitschrift*.
