# First Formalization: Exact Same-Prime Dirichlet Series and Half-Plane Holomorphy

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SamePrimeDirichlet.lean`](../../formalization/BuildingBlocks/SamePrimeDirichlet.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the unconditional absolute convergence, locally uniform convergence, exact double-sum rearrangement, and complex analyticity of the same-prime Dirichlet series on the half-plane $\text{Re}(s) > 1/2$ in Lean 4:

1. **Summability of Prime Majorant:**
   Formal proof of `primeMajorant_summable`: $\sum_{p} (\log p)^2 p^{-2\sigma} < \infty$ for $\sigma > 1/2$.
2. **Individual Prime Geometric Factorization:**
   Formal proof of `powerTerm_hasSum`: Absolute summation of powers $(k+1) p^{-(k+2)s}$ into the closed-form Euler factor.
3. **Double-Sum Rearrangement:**
   Formal proof of `expanded_eq_H`: Sum over all prime powers with multiplicity matches the Euler series $H(s)$ on $\text{Re}(s) > 1/2$.
4. **Locally Uniform Convergence:**
   Formal proof of `expanded_uniformConvergence`: Partial sums converge uniformly on $\{s : \text{Re}(s) \ge \sigma\}$ for any $\sigma > 1/2$.
5. **Holomorphy and Analyticity:**
   Formal proof of `H_differentiableOn`: $H$ is complex-differentiable on $\text{Re}(s) > 1/2$, and `H_analyticAt`: $H$ is analytic at every point of the half-plane.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Individual prime geometric summation
theorem powerTerm_hasSum (p : Nat.Primes) {s : ℂ} (hs : 0 < s.re) :
    HasSum (fun k => powerTerm p k s) (samePrimeTerm p s)

-- Rearrangement into Euler series on Re(s) > 1/2
theorem expanded_eq_H {s : ℂ} (hs : 1/2 < s.re) : expanded s = H s

-- Uniform majorant control
theorem uniform_majorant {σ : ℝ} (hσ : 1/2 < σ) :
    Summable (majorant σ) ∧
    ∀ (i : Nat.Primes × ℕ) (s : ℂ), σ ≤ s.re →
      ‖powerTerm i.1 i.2 s‖ ≤ majorant σ i

-- Locally uniform convergence
theorem expanded_uniformConvergence {σ : ℝ} (hσ : 1/2 < σ) :
    TendstoUniformlyOn
      (fun t : Finset (Nat.Primes × ℕ) => fun s : ℂ =>
        ∑ i ∈ t, powerTerm i.1 i.2 s)
      expanded Filter.atTop {s : ℂ | σ ≤ s.re}

-- Complex differentiability and analyticity
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

This formalization provides the first machine-verified implementation in Lean 4 proving the holomorphy and unconditional double-sum convergence of the same-prime Dirichlet series up to the critical boundary $\text{Re}(s) > 1/2$ without RH assumptions.
