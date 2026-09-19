# First Formalization: Exact Mertens-to-Prime-Error Hyperbola Transfer and Remainder Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/HyperbolaMertens.lean`](../../formalization/BuildingBlocks/HyperbolaMertens.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes discrete Abel summation for centered divisor forcing sequences, the exact representation of small-quotient signed sums via Mertens prefix convolutions, the certified boundary error bound, and the fully explicit Mertens-to-prime-error transfer remainder bound in Lean 4:

1. **Discrete Abel Summation:**
   Formal proof of $\sum_{q \le K} H(q)(v(q) - v(q+1)) = \sum_{k \le K} c(k) v(k) - H(K) v(K+1)$ (`centered_partial_summation`).
2. **Small-Quotient Mertens Representation:**
   Formal proof that $S(N, K+1) = \sum_{k \le K} c(k) M(\lfloor N/k \rfloor) - H(K) M(\lfloor N/(K+1) \rfloor)$ (`smallQuotientSigned_partial_summation`).
3. **Certified Boundary Error Bound:**
   Formal proof that $|H(K) M(\lfloor N/(K+1) \rfloor)| \le 13 N / \sqrt{K+1}$ (`centeredMertens_boundary_bound`).
4. **Explicit Mertens Transfer Theorem:**
   Formal proof of $|E(N) + 2\gamma - \sum_{k=1}^K c(k) M(\lfloor N/k \rfloor)| \le 39 N / \sqrt{K+1}$ (`primeError_Mertens_prefix_remainder`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Discrete Abel summation for centered divisor sequences
theorem centered_partial_summation (v : ℕ → ℝ) (K : ℕ) :
    (∑ q ∈ Finset.Icc 1 K, centeredDivisorForcing q * (v q - v (q + 1))) =
      (∑ k ∈ Finset.Icc 1 K, centeredDivisorCoefficient k * v k) -
        centeredDivisorForcing K * v (K + 1)

-- Exact partial summation for small quotient sums
theorem smallQuotientSigned_partial_summation {N K : ℕ} (hKN : K ≤ N) :
    smallQuotientSigned N (K + 1) = centeredMertensPrefix N K -
      centeredDivisorForcing K * (mertens (N / (K + 1)) : ℝ)

-- Certified boundary error bound
theorem centeredMertens_boundary_bound (N K : ℕ) :
    |centeredDivisorForcing K * (mertens (N / (K + 1)) : ℝ)| ≤
      13 * (N : ℝ) / Real.sqrt ((K + 1 : ℕ) : ℝ)

-- Explicit Mertens-to-prime transfer remainder theorem
theorem primeError_Mertens_prefix_remainder {N K : ℕ} (hN : 1 ≤ N) (hKN : K ≤ N) :
    |integerError N + 2 * Real.eulerMascheroniConstant - centeredMertensPrefix N K| ≤
      39 * (N : ℝ) / Real.sqrt ((K + 1 : ℕ) : ℝ)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the explicit finite Mertens-to-prime transfer theorem with verified explicit constants and rigorous hyperbola quotient grouping.
