# First Formalization: Exact Same-Prime Dirichlet Series Analyticity and Uniform Euler Product Convergence

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SamePrimeDirichlet.lean`](../../formalization/BuildingBlocks/SamePrimeDirichlet.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the summability of the 2D prime-power majorant, the closed-form geometric summation of same-prime proper powers, the exact equality between the expanded bivariate series and the Euler sum $H(s)$, and the locally uniform convergence and analyticity of $H(s)$ on $\text{Re}(s) > 1/2$ in Lean 4:

1. **2D Majorant Summability:**
   Formal proof that $M(\sigma, p, k) = \frac{\log^2 p}{p^{2\sigma}}(k+1)2^{-\sigma k}$ is summable on $\mathcal{P} \times \mathbb{N}$ for $\sigma > 1/2$ (`majorant_summable`).
2. **Proper-Power Geometric Sum:**
   Formal proof that $\sum_k \log^2 p (k+1) p^{-(k+2)s} = \frac{\log^2 p}{(p^s - 1)^2}$ (`powerTerm_hasSum`).
3. **Bivariate-to-Euler Equivalence:**
   Formal proof that $\sum_{(p, k)} \text{powerTerm}(p, k, s) = H(s)$ on $\text{Re}(s) > 1/2$ (`expanded_eq_H`).
4. **Locally Uniform Convergence:**
   Formal proof of the Weierstrass $M$-test for partial sums of $H(s)$ on $\text{Re}(s) \ge \sigma > 1/2$ (`expanded_uniformConvergence`).
5. **Holomorphy and Analyticity:**
   Formal proof that $H(s)$ is differentiable and analytic on $\text{Re}(s) > 1/2$ (`H_differentiableOn`, `H_analyticAt`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Prime-power 2D majorant summability
lemma majorant_summable {σ : ℝ} (hσ : 1/2 < σ) : Summable (majorant σ)

-- Absolute summability of proper power terms
theorem powerTerm_norm_summable {s : ℂ} (hs : 1/2 < s.re) :
    Summable (fun i : Nat.Primes × ℕ => ‖powerTerm i.1 i.2 s‖)

-- Closed-form geometric summation of proper powers
theorem powerTerm_hasSum (p : Nat.Primes) {s : ℂ} (hs : 0 < s.re) :
    HasSum (fun k => powerTerm p k s) (samePrimeTerm p s)

-- Bivariate sum equals Euler prime sum
theorem expanded_eq_H {s : ℂ} (hs : 1/2 < s.re) : expanded s = H s

-- Locally uniform convergence on half-planes
theorem expanded_uniformConvergence {σ : ℝ} (hσ : 1/2 < σ) :
    TendstoUniformlyOn
      (fun t : Finset (Nat.Primes × ℕ) => fun s : ℂ =>
        ∑ i ∈ t, powerTerm i.1 i.2 s)
      expanded Filter.atTop {s : ℂ | σ ≤ s.re}

-- Analyticity on the critical half-plane Re(s) > 1/2
theorem H_differentiableOn :
    DifferentiableOn ℂ H {s : ℂ | 1/2 < s.re}

theorem H_analyticAt {s : ℂ} (hs : 1/2 < s.re) : AnalyticAt ℂ H s
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving that the 2D Dirichlet series of same-prime proper powers converges absolutely and locally uniformly on $\text{Re}(s) > 1/2$ to an analytic function $H(s)$ with zero singularities.
