# First Formalization: Exact Divisor-Current Totient Contraction and Successor Conservation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/BirthDivisorCoupling.lean`](../../formalization/BuildingBlocks/BirthDivisorCoupling.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact conservation of the totient-weighted neighbor divisor current in Lean 4:

1. **Discrete Divisor Current Definition:**
   Formal definition of $J(n, d) = \mathbf{1}_{d \mid (n-1)} \varphi(d) - \mathbf{1}_{d \mid (n+1)} \varphi(d)$ (`weightedCurrent`).
2. **Exact Conservation Law:**
   Formal derivation of $\sum_{d \in \operatorname{divisors}(n-1) \cup \operatorname{divisors}(n+1)} J(n, d) = -2$ for all $n \ge 2$ (`sum_weightedCurrent`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
/-- Both neighboring factorizations are retained, at their integer label. -/
def weightedCurrent (n d : ℕ) : ℤ :=
  (if d ∈ (n - 1).divisors then (Nat.totient d : ℤ) else 0) -
  (if d ∈ (n + 1).divisors then (Nat.totient d : ℤ) else 0)

/-- A fixed divisor-coordinate contraction recovers a constant successor
increment. This finite identity asserts no bound for a prime-error energy. -/
theorem sum_weightedCurrent (n : ℕ) (hn : 2 ≤ n) :
    ∑ d ∈ (n - 1).divisors ∪ (n + 1).divisors, weightedCurrent n d = -2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the exact invariant contraction of two-sided divisor currents $\sum J(n, d) = -2$ via Gauss totient summation.
