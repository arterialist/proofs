# First Formalization: Exact Centered Poisson Covariance Kernel Geometric Tail Identity and Positivity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualCenteredPoissonKernel.lean`](../../formalization/BuildingBlocks/ActualCenteredPoissonKernel.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact algebraic factorization of the centered Poisson covariance kernel into a shifted geometric tail and proves its entrywise non-negativity on the unit parameter interval $[0, 1]$ in Lean 4:

1. **Shifted Geometric Tail Identity:**
   Formal proof of `centeredKernel_eq_tail`: $q^{\max(n, m)} - q^{n+m} = (1 - q) \sum_{k=0}^{\min(n, m)-1} q^{\max(n, m)+k}$.
2. **Unconditional Non-Negativity:**
   Formal proof of `centeredKernel_nonneg`: Non-negativity $0 \le q^{\max(n, m)} - q^{n+m}$ for all $q \in [0, 1]$ and all $n, m \in \mathbb{N}$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Shifted geometric tail factorization of centered Poisson covariance
theorem centeredKernel_eq_tail (q : ℝ) (n m : ℕ) :
    q ^ max n m - q ^ (n + m) =
      (1 - q) * ∑ k ∈ range (min n m), q ^ (max n m + k)

-- Entrywise non-negativity for subcritical and critical contraction parameters
theorem centeredKernel_nonneg {q : ℝ} (hq0 : 0 ≤ q) (hq1 : q ≤ 1)
    (n m : ℕ) : 0 ≤ q ^ max n m - q ^ (n + m)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the shifted geometric tail identity and entrywise non-negativity of centered Poisson covariance kernels.
