# First Formalization in Lean 4: Dyadic Divisor Prime Discrepancy and Factorial Identification

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 File:** [`formalization/BuildingBlocks/DivisionDyadicPrimeAverage.lean`](../../formalization/BuildingBlocks/DivisionDyadicPrimeAverage.lean)  
**Dependencies:** `BuildingBlocks.MertensArithmetic`, `BuildingBlocks.DivisionDyadicFactorial`, `Mathlib.NumberTheory.Harmonic.Bounds`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

This Lean 4 formalization connects the actual arithmetic prime-power Chebyshev function $\psi(x) = \sum_{n \le x}\Lambda(n)$ directly to the dyadic factorial deficit:
1. **Vanishing Upper-Cutoff Extension:** Proves that extending the dyadic divisor sum $\sum_{d=1}^N \psi(\lfloor 2N/d\rfloor)$ to $2N$ introduces only terms where $\lfloor 2N/d\rfloor = 1$, where $\psi(1) = 0$, thereby equating the partial sum to the full log-factorial $\log((2N)!)$ via `BuildingBlocks.MertensTransfer.logFactorial_eq_sum_psi`.
2. **Exact Discrepancy-Deficit Duality:** Evaluates the complete dyadic divisor prime discrepancy:
   \[
   D_N = \sum_{d=1}^N \left( \psi\left(\left\lfloor \frac{2N}{d}\right\rfloor\right) - \psi\left(\left\lfloor \frac{N}{d}\right\rfloor\right) - \frac{N}{d} \right)
   \]
   identically to $\log((2N)!/N!) - N H_N = -A_N$.
3. **Unconditional Strict Negativity across All Integers:** Machine-proves that $D_N < -N(3/2 - \log 4) < 0$ for every $N \ge 1$, establishing that the complete divisor sum of the actual Chebyshev prime-power function is strictly negative for all natural numbers, and proves the normalized bound $D_N / N < \log 4 - 3/2 \approx -0.1137056$.

---

## 2. Machine-Verified Theorems

```lean
noncomputable def dyadicDivisorPrimeDiscrepancy (N : ℕ) : ℝ :=
  ∑ d ∈ Finset.Icc 1 N,
    (psi (2 * N / d) - psi (N / d) - (N : ℝ) / (d : ℝ))

theorem sum_psi_two_mul_div_eq_logFactorial (N : ℕ) :
    (∑ d ∈ Finset.Icc 1 N, psi (2 * N / d)) = logFactorial (2 * N)

theorem dyadicDivisorPrimeDiscrepancy_eq_factorial (N : ℕ) :
    dyadicDivisorPrimeDiscrepancy N =
      Real.log (((2 * N).factorial : ℝ) / (N.factorial : ℝ)) -
        (N : ℝ) * (harmonic N : ℝ)

theorem dyadicDivisorPrimeDiscrepancy_eq_neg_deficit (N : ℕ) :
    dyadicDivisorPrimeDiscrepancy N = -dyadicFactorialDeficit N

theorem dyadicDivisorPrimeDiscrepancy_lt {N : ℕ} (hN : 1 ≤ N) :
    dyadicDivisorPrimeDiscrepancy N <
      -(N : ℝ) * (3 / 2 - Real.log 4)

theorem dyadicDivisorPrimeDiscrepancy_neg {N : ℕ} (hN : 1 ≤ N) :
    dyadicDivisorPrimeDiscrepancy N < 0

theorem dyadicDivisorPrimeDiscrepancy_div_lt {N : ℕ} (hN : 1 ≤ N) :
    dyadicDivisorPrimeDiscrepancy N / (N : ℝ) < Real.log 4 - 3 / 2
```

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/DivisionDyadicPrimeAverage.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.sum_psi_two_mul_div_eq_logFactorial' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.dyadicDivisorPrimeDiscrepancy_eq_factorial' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.dyadicDivisorPrimeDiscrepancy_eq_neg_deficit' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.dyadicDivisorPrimeDiscrepancy_lt' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.dyadicDivisorPrimeDiscrepancy_neg' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.dyadicDivisorPrimeDiscrepancy_div_lt' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All declarations depend strictly on foundational axioms with zero custom axioms.
