# First Formalization: Exact Discrete Prime Error Energy Balance and Lyapunov Drift Criterion

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeEnergy.lean`](../../formalization/BuildingBlocks/PrimeEnergy.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact discrete integration-by-parts energy balance identity for the Chebyshev prime error, proves the unconditional $O(\log^2 N)$ upper bound on prime increment energy, and derives the conditional Lyapunov drift criterion in Lean 4:

1. **Universal Weighted Integration-by-Parts:**
   Formal proof of `weighted_energy_balance`: $\sum_{n=1}^N \frac{e(n)^2}{n(n+1)} = \sum_{n=1}^N \frac{e(n)^2 - e(n-1)^2}{n} - \frac{e(N)^2}{N+1}$.
2. **Exact Discrete Prime Energy Balance:**
   Formal proof of `prime_energy_balance`: $\text{discretePrimeErrorEnergy}(N) = 2 \cdot \text{primeErrorDrift}(N) + \text{primeIncrementEnergy}(N) - \frac{(\psi(N)-N)^2}{N+1}$.
3. **Unconditional Log-Square Increment Energy Bound:**
   Formal proof of `reciprocal_vonMangoldt_sum_le` and `primeIncrementEnergy_le_log_square`: $\text{primeIncrementEnergy}(N) \le 2 \log^2 N + \log N + 1$.
4. **Conditional Drift Criterion:**
   Formal proof of `prime_error_square_upper_of_drift_nonpos`: $(\psi(N)-N)^2 \le (N+1)(2 \log^2 N + \log N + 1)$ whenever $\text{primeErrorDrift}(N) \le 0$.
5. **Early Drift Positivity:**
   Formal proof of `primeErrorDrift_two` and `primeErrorDrift_two_pos`: $\text{primeErrorDrift}(2) = (1 - \log 2)/2 > 0$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Weighted discrete integration by parts
theorem weighted_energy_balance (e : ℕ → ℝ) (h0 : e 0 = 0) (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, e n ^ 2 / ((n : ℝ) * ((n : ℝ) + 1))) =
      (∑ n ∈ Finset.Icc 1 N, (e n ^ 2 - e (n - 1) ^ 2) / (n : ℝ)) -
        e N ^ 2 / ((N : ℝ) + 1)

-- Prime error energy balance
theorem prime_energy_balance (N : ℕ) :
    discretePrimeErrorEnergy N = 2 * primeErrorDrift N + primeIncrementEnergy N -
      integerError N ^ 2 / ((N : ℝ) + 1)

-- Log-squared diagonal bound
theorem primeIncrementEnergy_le_log_square {N : ℕ} (hN : 1 ≤ N) :
    primeIncrementEnergy N ≤ 2 * Real.log (N : ℝ) ^ 2 + 1 + Real.log (N : ℝ)

-- Conditional Lyapunov bound
theorem prime_error_square_upper_of_drift_nonpos {N : ℕ} (hN : 1 ≤ N)
    (hD : primeErrorDrift N ≤ 0) :
    integerError N ^ 2 ≤ ((N : ℝ) + 1) *
      (2 * Real.log (N : ℝ) ^ 2 + 1 + Real.log (N : ℝ))

-- Early drift positivity
theorem primeErrorDrift_two_pos : 0 < primeErrorDrift 2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the exact discrete energy identity connecting prime errors, diagonal increment energies, and off-diagonal drift, isolating the exact discrete Lyapunov condition for the Riemann Hypothesis.
