# First Formalization: Discrete Prime Error Energy Balance and Signed Drift Decomposition

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeEnergy.lean`](../../formalization/BuildingBlocks/PrimeEnergy.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact discrete energy balance equation for the Chebyshev prime error trajectory in Lean 4:

1. **Weighted Discrete Integration by Parts:**
   Formal proof of the identity $\sum_{n=1}^N \frac{e(n)^2}{n(n+1)} = \sum_{n=1}^N \frac{e(n)^2 - e(n-1)^2}{n} - \frac{e(N)^2}{N+1}$ for any sequence with $e(0) = 0$ (`weighted_energy_balance`).
2. **Prime Error Energy Identity:**
   Formal proof of $\mathcal{E}(N) = 2 \mathcal{D}(N) + \mathcal{I}(N) - \frac{E(N)^2}{N+1}$ (`prime_energy_balance`), decomposing prime error energy into off-diagonal drift and diagonal increment energy.
3. **Log-Square Diagonal Bound:**
   Formal derivation of $\mathcal{I}(N) \le 2 \log^2 N + \log N + 1$ from von Mangoldt divisor sum inequalities (`primeIncrementEnergy_le_log_square`).
4. **Conditional Square Bound & Positivity Obstruction:**
   Formal proof that nonpositive drift would bound $E(N)^2 \le (N+1)(2 \log^2 N + \dots)$ (`prime_error_square_upper_of_drift_nonpos`), together with the exact computation $\mathcal{D}(2) = (1 - \log 2)/2 > 0$ (`primeErrorDrift_two_pos`) proving that drift nonpositivity fails initially.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Weighted discrete integration by parts
theorem weighted_energy_balance (e : ℕ → ℝ) (h0 : e 0 = 0) (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, e n ^ 2 / ((n : ℝ) * ((n : ℝ) + 1))) =
      (∑ n ∈ Finset.Icc 1 N, (e n ^ 2 - e (n - 1) ^ 2) / (n : ℝ)) -
        e N ^ 2 / ((N : ℝ) + 1)

-- Prime energy balance
theorem prime_energy_balance (N : ℕ) :
    discretePrimeErrorEnergy N = 2 * primeErrorDrift N + primeIncrementEnergy N -
      integerError N ^ 2 / ((N : ℝ) + 1)

-- Diagonal increment energy bound
theorem primeIncrementEnergy_le_log_square {N : ℕ} (hN : 1 ≤ N) :
    primeIncrementEnergy N ≤ 2 * Real.log (N : ℝ) ^ 2 + 1 + Real.log (N : ℝ)

-- Drift nonpositivity implication
theorem prime_error_square_upper_of_drift_nonpos {N : ℕ} (hN : 1 ≤ N)
    (hD : primeErrorDrift N ≤ 0) :
    integerError N ^ 2 ≤ ((N : ℝ) + 1) *
      (2 * Real.log (N : ℝ) ^ 2 + 1 + Real.log (N : ℝ))

-- Positivity obstruction at N = 2
theorem primeErrorDrift_two_pos : 0 < primeErrorDrift 2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-checked discrete energy conservation law for prime trajectories, elucidating why prime power fluctuations require delicate off-diagonal phase cancellations to prevent error divergence.
