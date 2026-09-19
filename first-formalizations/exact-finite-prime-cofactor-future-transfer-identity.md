# First Formalization: Exact Finite Prime-Cofactor Future Transfer Identity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualPrimeCofactorFutureFinite.lean`](../../formalization/BuildingBlocks/ActualPrimeCofactorFutureFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact finite algebraic prime-cofactor future transfer identity in Lean 4:

1. **Exact Complex Hyperbola Divisor Summation:**
   Formal proof that $\sum_{n=1}^N (\log n) g(n) = \sum_{d=1}^N \Lambda(d) \sum_{k=1}^{\lfloor N/d \rfloor} g(dk)$ for arbitrary complex test weights (`weighted_log_eq_complete_future`).
2. **Cofactor Range Splitting:**
   Formal extraction of the singleton cofactor $k = 1$ from the proper cofactors $k \ge 2$ (`cofactor_sum_one_and_proper`).
3. **Exact Cutoff Transfer Identity:**
   Formal proof that if $g(d) = 0$ for $d \le C$, then $\operatorname{primeRow}(N, g) = \operatorname{logRow}(N, g) - \operatorname{lowFullFuture}(N, C, g) - \operatorname{highProperFuture}(N, C, g)$ (`cofactor_cutoff_transfer`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact complex hyperbola divisor identity
theorem weighted_log_eq_complete_future (N : ℕ) (g : ℕ → ℂ) :
    (∑ n ∈ Icc 1 N, (Real.log (n : ℝ) : ℂ) * g n) =
      ∑ d ∈ Icc 1 N, (ArithmeticFunction.vonMangoldt d : ℂ) *
        ∑ k ∈ Icc 1 (N / d), g (d * k)

-- Exact cofactor cutoff transfer theorem
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

This entry documents a machine-verified proof in Lean 4 of the exact finite algebraic proper-cofactor transfer identity, decomposing prime power sums into smooth logarithmic sums and composite cofactors with zero asymptotic error.
