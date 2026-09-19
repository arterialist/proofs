# First Formalization: Exact Discrete Abel Summation of Chebyshev Errors and Uniform Signed First Moments

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSignedAverage.lean`](../../formalization/BuildingBlocks/PrimeSignedAverage.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the discrete Abel summation identity for Chebyshev prime errors, the harmonic-weight identity, the logarithmic prime mass difference bounds, and the unconditional uniform $O(1)$ bound on the signed first moment of the prime error in Lean 4:

1. **Discrete Abel Summation for Prime Errors:**
   Formal proof of $\sum_{n=1}^N (\psi(n) - n)(v(n) - v(n+1)) = \sum_{n=1}^N (\Lambda(n) - 1)v(n) - (\psi(N) - N)v(N+1)$ (`integerError_partial_summation`).
2. **Harmonic Weight Representation:**
   Formal proof of $\sum_{n=1}^N \frac{\psi(n) - n}{n(n+1)} = \sum_{n=1}^N \frac{\Lambda(n)}{n} - H_N - \frac{\psi(N) - N}{N+1}$ (`signedPrimeErrorAverage_eq`).
3. **Logarithmic Prime Mass Difference:**
   Formal proof that $-2 \le \sum_{n=1}^N \frac{\Lambda(n)}{n} - H_N \le 4\log 2$ (`logarithmicPrimeMass_sub_harmonic_bounds`).
4. **Diagonal Chebyshev Increment Energy:**
   Formal proof of $\sum_{n=1}^N \frac{(\Lambda(n)-1)^2}{n} \le \log^2 N + (4\log 2 + 1)\log N + 1$ (`primeIncrementEnergy_le_chebyshev`).
5. **Uniform Boundedness of Signed First Moment:**
   Formal proof that $|\sum_{n=1}^N \frac{\psi(n) - n}{n(n+1)}| \le 2 + 4\log 2$ unconditionally for all $N \ge 0$ (`signedPrimeErrorAverage_abs_le`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Logarithmic prime mass bounds
theorem logarithmicPrimeMass_bounds {N : ℕ} (hN : 1 ≤ N) :
    Real.log N - 1 ≤ logarithmicPrimeMass N ∧
    logarithmicPrimeMass N ≤ Real.log N + 4 * Real.log 2

-- Diagonal Chebyshev increment energy
theorem primeIncrementEnergy_le_chebyshev {N : ℕ} (hN : 1 ≤ N) :
    primeIncrementEnergy N ≤ Real.log (N : ℝ) ^ 2 +
      (4 * Real.log 2 + 1) * Real.log (N : ℝ) + 1

-- Prime mass harmonic difference
theorem logarithmicPrimeMass_sub_harmonic_bounds {N : ℕ} (hN : 1 ≤ N) :
    -2 ≤ logarithmicPrimeMass N - (harmonic N : ℝ) ∧
    logarithmicPrimeMass N - (harmonic N : ℝ) ≤ 4 * Real.log 2

-- Discrete Abel summation
theorem integerError_partial_summation (v : ℕ → ℝ) (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, integerError n * (v n - v (n + 1))) =
      (∑ n ∈ Finset.Icc 1 N, primeIncrement n * v n) - integerError N * v (N + 1)

-- Signed prime error average identity
theorem signedPrimeErrorAverage_eq (N : ℕ) :
    signedPrimeErrorAverage N = logarithmicPrimeMass N - (harmonic N : ℝ) -
      integerError N / ((N : ℝ) + 1)

-- Unconditional uniform bound
theorem signedPrimeErrorAverage_abs_le (N : ℕ) :
    |signedPrimeErrorAverage N| ≤ 2 + 4 * Real.log 2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving an unconditional $O(1)$ bound on the signed harmonic first moment $\sum_{n=1}^N \frac{\psi(n)-n}{n(n+1)}$ with explicit constant $2+4\log 2$.
