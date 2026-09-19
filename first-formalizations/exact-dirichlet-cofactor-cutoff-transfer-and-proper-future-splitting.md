# First Formalization: Exact Dirichlet Cofactor Cutoff Transfer and Proper Future Splitting

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualPrimeCofactorFutureFinite.lean`](../../formalization/BuildingBlocks/ActualPrimeCofactorFutureFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact weighted Dirichlet hyperbola convolution $\log = \Lambda * 1$, the decomposition into diagonal and proper ($k \ge 2$) cofactors, and the cutoff transfer identity relating the prime-power row, logarithmic row, low-divisor future, and high-divisor proper future in Lean 4:

1. **Weighted Dirichlet Hyperbola Identity:**
   Formal proof of $\sum_{n \le N} g(n) \log n = \sum_{d \le N} \Lambda(d) \sum_{k \le N/d} g(dk)$ (`weighted_log_eq_complete_future`).
2. **Cofactor Cutoff Transfer:**
   Formal derivation of $\operatorname{primeRow} = \operatorname{logRow} - \operatorname{lowFullFuture} - \operatorname{highProperFuture}$ under support vanishing $g(d) = 0$ for $d \le C$ (`cofactor_cutoff_transfer`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact weighted Dirichlet hyperbola convolution identity
theorem weighted_log_eq_complete_future (N : ℕ) (g : ℕ → ℂ) :
    (∑ n ∈ Icc 1 N, (Real.log (n : ℝ) : ℂ) * g n) =
      ∑ d ∈ Icc 1 N, (ArithmeticFunction.vonMangoldt d : ℂ) *
        ∑ k ∈ Icc 1 (N / d), g (d * k)

-- Exact cutoff transfer to low-divisor and high-proper cofactors
theorem cofactor_cutoff_transfer (N C : ℕ) (g : ℕ → ℂ)
    (hvanish : ∀ d, d ≤ C → g d = 0) :
    primeRow N g = logRow N g - lowFullFuture N C g - highProperFuture N C g
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 establishing the exact algebraic transfer between prime-power rows, logarithmic moments, and proper cofactor futures for arbitrary complex test weights under cutoff support vanishing.
