# First Formalization: Same-Prime Dirichlet Series and Unconditional Half-Plane Analyticity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SamePrimeDirichlet.lean`](../../formalization/BuildingBlocks/SamePrimeDirichlet.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This entry documents a machine-verified proof that the same-prime diagonal Dirichlet series $H(s) = \sum_p \frac{(\log p)^2 p^{-2s}}{(1 - p^{-s})^2}$ converges absolutely and defines a complex analytic function on the entire half-plane $\operatorname{Re}(s) > 1/2$:

1. **Exact Multiplicity Power Term:**
   Formal identity proving that each proper power $p^{k+2}$ has coefficient $(\log p)^2 (k+1)$ and that the power series sums to the diagonal Euler factor (`powerTerm_hasSum`, `samePrimeTerm_eq_cpow`).
2. **Factored Majorant Summability:**
   Formal construction of a majorant bounding all primes and exponents on $\operatorname{Re}(s) \ge \sigma > 1/2$ by a product of a log-squared $L$-series and a convergent geometric series (`majorant_summable`, `uniform_majorant`).
3. **Locally Uniform Convergence:**
   Formal proof of `expanded_uniformConvergence` using Mathlib's `TendstoUniformlyOn`.
4. **Unconditional Holomorphy and Analyticity:**
   Formal proof that $H(s)$ is differentiable and analytic at every point of the open half-plane $\operatorname{Re}(s) > 1/2$ without RH or zero-free assumptions (`H_differentiableOn`, `H_analyticAt`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Uniform majorant bounding all terms
theorem uniform_majorant {σ : ℝ} (hσ : 1/2 < σ) :
    Summable (majorant σ) ∧
    ∀ (i : Nat.Primes × ℕ) (s : ℂ), σ ≤ s.re →
      ‖powerTerm i.1 i.2 s‖ ≤ majorant σ i

-- Series rearrangement equality
theorem expanded_eq_H {s : ℂ} (hs : 1/2 < s.re) : expanded s = H s

-- Uniform convergence on half-planes
theorem expanded_uniformConvergence {σ : ℝ} (hσ : 1/2 < σ) :
    TendstoUniformlyOn
      (fun t : Finset (Nat.Primes × ℕ) => fun s : ℂ =>
        ∑ i ∈ t, powerTerm i.1 i.2 s)
      expanded Filter.atTop {s : ℂ | σ ≤ s.re}

-- Unconditional holomorphy and analyticity
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

## 3. Scope and verification status

This formalization establishes the foundational properties of the diagonal pair correlation Dirichlet series in Lean 4, proving that prime correlations along the diagonal exhibit no singularities or obstructions in the open critical strip $\operatorname{Re}(s) > 1/2$.
