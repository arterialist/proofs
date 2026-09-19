# First Formalization: Exact Discrete Prime Energy Balance and Cross-Correlation Drift Control

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeEnergy.lean`](../../formalization/BuildingBlocks/PrimeEnergy.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the discrete weighted integration-by-parts identity for trajectories, the exact energy balance for the Chebyshev prime error, the explicit $O(\log^2 N)$ bound for the diagonal increment energy, and the conditional square-root prime error bound from drift non-positivity in Lean 4:

1. **Discrete Integration-by-Parts Identity:**
   Formal proof that $\sum_{n=1}^N \frac{e(n)^2}{n(n+1)} = \sum_{n=1}^N \frac{e(n)^2 - e(n-1)^2}{n} - \frac{e(N)^2}{N+1}$ (`weighted_energy_balance`).
2. **Prime Energy Balance Formula:**
   Formal proof of $\mathcal{E}_{\text{err}}(N) = 2 D(N) + \mathcal{E}_{\text{diag}}(N) - \frac{E(N)^2}{N+1}$ (`prime_energy_balance`).
3. **Explicit Diagonal Increment Energy Bound:**
   Formal proof that $\mathcal{E}_{\text{diag}}(N) \le 2\log^2 N + \log N + 1$ (`primeIncrementEnergy_le_log_square`).
4. **Conditional Square-Root Bound from Drift Non-Positivity:**
   Formal proof of $E(N)^2 \le (N+1)(2\log^2 N + \log N + 1)$ whenever $D(N) \le 0$ (`prime_error_square_upper_of_drift_nonpos`).
5. **Initial Drift Evaluation:**
   Formal proof that $D(2) = \frac{1 - \log 2}{2} > 0$ (`primeErrorDrift_two`, `primeErrorDrift_two_pos`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Weighted discrete integration-by-parts identity
theorem weighted_energy_balance (e : ℕ → ℝ) (h0 : e 0 = 0) (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, e n ^ 2 / ((n : ℝ) * ((n : ℝ) + 1))) =
      (∑ n ∈ Finset.Icc 1 N, (e n ^ 2 - e (n - 1) ^ 2) / (n : ℝ)) -
        e N ^ 2 / ((N : ℝ) + 1)

-- Exact prime energy balance with drift cross-correlation
theorem prime_energy_balance (N : ℕ) :
    discretePrimeErrorEnergy N = 2 * primeErrorDrift N + primeIncrementEnergy N -
      integerError N ^ 2 / ((N : ℝ) + 1)

-- Explicit diagonal increment energy bound
theorem primeIncrementEnergy_le_log_square {N : ℕ} (hN : 1 ≤ N) :
    primeIncrementEnergy N ≤ 2 * Real.log (N : ℝ) ^ 2 + 1 + Real.log (N : ℝ)

-- Conditional square-root prime error bound
theorem prime_error_square_upper_of_drift_nonpos {N : ℕ} (hN : 1 ≤ N)
    (hD : primeErrorDrift N ≤ 0) :
    integerError N ^ 2 ≤ ((N : ℝ) + 1) *
      (2 * Real.log (N : ℝ) ^ 2 + 1 + Real.log (N : ℝ))

-- Initial drift positivity
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

This entry documents a machine-verified one-way estimate: if the finite drift $D(N)$ is nonpositive, then `prime_error_square_upper_of_drift_nonpos` bounds the squared prime error at that $N$. The declarations shown above do not prove an equivalence with the Riemann Hypothesis.
