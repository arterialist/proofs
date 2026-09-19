# First Formalization: Exact Cumulative Odd Goldbach Lacunary Chebyshev Convolution and Step Dynamics

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/GoldbachOddCumulativeFinite.lean`](../../formalization/BuildingBlocks/GoldbachOddCumulativeFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact dyadic reindexing of the cumulative odd Goldbach sum, the exact lacunary Chebyshev error representation of its centered residual, and the discrete one-step derivative dynamics in Lean 4:

1. **Odd Partner and Cumulative Odd Definitions:**
   Formal definitions of `oddPartner`, `cumulativeOdd`, and `oddPartner_eq_psi_sub_pow2`.
2. **Cumulative Dyadic Representation:**
   Formal proofs of `shifted_odd_row`, `cumulativeOdd_eq_power_sum`, and `cumulativeOdd_eq_complete`.
3. **Lacunary Chebyshev Error Convolution:**
   Formal definitions of `integerPrimeError`, `oddBaseline`, and `oddResidual`, with proof of `oddResidual_eq_error_convolution`.
4. **Step Dynamics and Lower Bound:**
   Formal proofs of `integerPrimeError_succ`, `oddResidual_succ`, and `oddResidual_succ_lower`.
5. **Odd-to-Even Parity Collapse:**
   Formal definition of `binaryPairCount`, proof of `evenWeight_eq_indicator`, and proof of `oddResidual_succ_odd`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact dyadic reindexing of cumulative odd Goldbach sums
theorem cumulativeOdd_eq_power_sum (X : ℕ) :
    cumulativeOdd X =
      2 * Real.log 2 *
        ∑ k ∈ Icc 1 (Nat.log 2 X), oddPartner (X - 2 ^ k)

-- Exact lacunary convolution with Chebyshev error
theorem oddResidual_eq_error_convolution (X : ℕ) :
    oddResidual X =
      2 * Real.log 2 *
        ∑ k ∈ Icc 1 (Nat.log 2 X), integerPrimeError (X - 2 ^ k)

-- Exact one-step discrete clock derivative
theorem oddResidual_succ (X : ℕ) :
    oddResidual (X + 1) - oddResidual X =
      2 * Real.log 2 *
        ∑ k ∈ Icc 1 (Nat.log 2 X), (Λ (X + 1 - 2 ^ k) - 1)

-- Unconditional lower bound on step decay
theorem oddResidual_succ_lower (X : ℕ) :
    -(2 * Real.log 2) * (Nat.log 2 X : ℝ) ≤
      oddResidual (X + 1) - oddResidual X

-- Complete collapse to binary-pair indicator on odd-to-even steps
theorem oddResidual_succ_odd (X : ℕ) (hodd : Odd X) :
    oddResidual (X + 1) - oddResidual X =
      2 * Real.log 2 *
        (Real.log 2 * binaryPairCount X - (Nat.log 2 X : ℝ))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 establishing the exact representation of cumulative odd Goldbach counts via lacunary dyadic Chebyshev error sums, and proving the exact binary-pair collapse of its discrete step derivative.
