# First Formalization: Exact Discrete Hyperbola Cutoff Decomposition and Chebyshev Remainder Bounds

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/MertensCutoff.lean`](../../formalization/BuildingBlocks/MertensCutoff.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the inductive reciprocal square root bound $\sum_{d \le K} \frac{1}{\sqrt{d}} \le 2\sqrt{K}$, the floor square root sum bound $\sum_{d \le K} \sqrt{\lfloor N/d \rfloor} \le 2\sqrt{N}\sqrt{K}$, the large quotient remainder bound $\le 26 N / \sqrt{K}$, the exact cutoff decomposition of the Chebyshev prime error, and the small-quotient remainder estimate in Lean 4:

1. **Reciprocal Square Root Sum Bound:**
   Formal proof by induction that $\sum_{d=1}^K \frac{1}{\sqrt{d}} \le 2\sqrt{K}$ (`reciprocal_sqrt_sum_bound`).
2. **Floor Square Root Sum Bound:**
   Formal proof that $\sum_{d=1}^K \sqrt{\lfloor N/d \rfloor} \le 2\sqrt{N}\sqrt{K}$ (`floor_sqrt_sum_bound`).
3. **Large Quotient Absolute Bound:**
   Formal proof that $\sum_{d \le N/K} |\mu(d)\mathcal{D}(N/d)| \le 26 N / \sqrt{K}$ (`largeQuotientAbsolute_bound`).
4. **Exact Cutoff Decomposition:**
   Formal proof of $\psi(N) - N + 2\gamma = \text{largeQuotients} + \text{smallQuotients}$ (`centered_inverse_cutoff_decomposition`).
5. **Prime Error Cutoff Remainder Bound:**
   Formal proof that $|(\psi(N) - N + 2\gamma) - \text{smallQuotients}| \le 26 N / \sqrt{K}$ (`primeError_cutoff_remainder_bound`).
6. **Small Quotient Index Criterion:**
   Formal characterization $d \in (\lfloor N/K \rfloor, N] \iff d \le N \land \lfloor N/d \rfloor < K$ (`smallQuotient_indices_iff`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Reciprocal square root bound by induction
theorem reciprocal_sqrt_sum_bound (K : ℕ) :
    (∑ d ∈ Finset.Icc 1 K, 1 / Real.sqrt (d : ℝ)) ≤ 2 * Real.sqrt K

-- Floor square root sum bound
theorem floor_sqrt_sum_bound (N K : ℕ) :
    (∑ d ∈ Finset.Icc 1 K, Real.sqrt ((N / d : ℕ) : ℝ)) ≤
      2 * Real.sqrt N * Real.sqrt K

-- Large quotient absolute bound
theorem largeQuotientAbsolute_bound (N K : ℕ) :
    largeQuotientAbsolute N K ≤ 26 * (N : ℝ) / Real.sqrt K

-- Cutoff decomposition
theorem centered_inverse_cutoff_decomposition {N K : ℕ} (hN : 1 ≤ N) :
    integerError N + 2 * Real.eulerMascheroniConstant =
      (∑ d ∈ Finset.Icc 1 (N / K), (ArithmeticFunction.moebius d : ℝ) *
        centeredDivisorForcing (N / d)) + smallQuotientSigned N K

-- Remainder bound
theorem primeError_cutoff_remainder_bound {N K : ℕ} (hN : 1 ≤ N) :
    |integerError N + 2 * Real.eulerMascheroniConstant - smallQuotientSigned N K| ≤
      26 * (N : ℝ) / Real.sqrt K

-- Index equivalence
theorem smallQuotient_indices_iff {N K d : ℕ} (hK : 0 < K) :
    d ∈ Finset.Ioc (N / K) N ↔ d ∈ Finset.Icc 1 N ∧ N / d < K
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing explicit inductive square root sums and non-asymptotic hyperbola quotient remainder bounds with constant 26 for the Chebyshev prime error.
