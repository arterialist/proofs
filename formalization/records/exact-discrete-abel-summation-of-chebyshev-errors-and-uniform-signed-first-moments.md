# Contribution 173: Exact Discrete Abel Summation of Chebyshev Errors and Uniform Signed First Moments

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeSignedAverage.lean`](../../formalization/BuildingBlocks/PrimeSignedAverage.lean), [`building-blocks/primes/prime-signed-average.md`](../../building-blocks/primes/prime-signed-average.md)  
**Classification:** Analytic Number Theory / Multiplicative Number Theory / Chebyshev Function / Discrete Abel Summation / First Moments / Explicit Bounds

---

## 1. Executive Summary and Mathematical Statement

The prime error $\psi(n) - n$ exhibits large oscillations. Understanding the extent of cancellation in signed averages of $\psi(n) - n$ is a fundamental problem in analytic number theory. This contribution establishes the exact discrete summation-by-parts identity for the Chebyshev error and proves an unconditional, explicit $O(1)$ uniform bound for the signed first harmonic moment.

This contribution proves:

1. **Exact Discrete Abel Summation for Chebyshev Errors:**  
   For any test sequence $v(n)$ and any positive integer $N$:
   $$
   \sum_{n=1}^N (\psi(n) - n)(v(n) - v(n+1)) = \sum_{n=1}^N (\Lambda(n) - 1) v(n) - (\psi(N) - N) v(N+1).
   $$
2. **Harmonic Weight Specialization:**  
   Choosing $v(n) = 1/n$, where $v(n) - v(n+1) = \frac{1}{n(n+1)}$, yields the exact identity:
   $$
   \sum_{n=1}^N \frac{\psi(n) - n}{n(n+1)} = \sum_{n=1}^N \frac{\Lambda(n)}{n} - H_N - \frac{\psi(N) - N}{N+1},
   $$
   where $H_N = \sum_{n=1}^N 1/n$ is the $N$-th harmonic number.
3. **Logarithmic Prime Mass Difference Bound:**  
   For all $N \ge 1$, the difference between the logarithmically weighted prime sum and the harmonic number is strictly bounded:
   $$
   -2 \le \sum_{n=1}^N \frac{\Lambda(n)}{n} - H_N \le 4 \log 2.
   $$
4. **Sharp Chebyshev Increment Energy Bound:**  
   The diagonal energy of the prime increments satisfies:
   $$
   \sum_{n=1}^N \frac{(\Lambda(n) - 1)^2}{n} \le \log^2 N + (4 \log 2 + 1)\log N + 1.
   $$
5. **Unconditional Uniform Boundedness of Signed First Moment:**  
   For all integers $N \ge 0$:
   $$
   \left| \sum_{n=1}^N \frac{\psi(n) - n}{n(n+1)} \right| \le 2 + 4 \log 2 \approx 4.7725887...
   $$
   The signed first moment of the prime error is uniformly bounded across all scales $N \in \mathbb{N}$ without assuming the Riemann Hypothesis or any zero-free region.

---

## 2. Mathematical Proof

### 2.1. Discrete Abel Summation
By induction on $N$. For $N=0$, both sides are $0$.
For $N+1$, using $\psi(N+1) - (N+1) = (\psi(N) - N) + (\Lambda(N+1) - 1)$:
$$
\sum_{n=1}^{N+1} (\psi(n) - n)(v(n) - v(n+1))
$$
$$
= \left[ \sum_{n=1}^N (\Lambda(n) - 1)v(n) - (\psi(N) - N)v(N+1) \right] + (\psi(N+1) - (N+1))(v(N+1) - v(N+2))
$$
$$
= \sum_{n=1}^N (\Lambda(n) - 1)v(n) - (\psi(N) - N)v(N+1) + (\psi(N) - N)(v(N+1) - v(N+2)) + (\Lambda(N+1) - 1)(v(N+1) - v(N+2))
$$
$$
= \sum_{n=1}^{N+1} (\Lambda(n) - 1)v(n) - (\psi(N+1) - (N+1))v(N+2).
$$

### 2.2. Logarithmic Prime Mass Bounds
Using Chebyshev's identity $N \sum_{n \le N} \frac{\Lambda(n)}{n} - \log(N!) = \sum_{n \le N} \{N/n\} \Lambda(n)$ and the integral bounds on $\log(N!)$:
$$
\log N - 1 \le \sum_{n=1}^N \frac{\Lambda(n)}{n} \le \log N + 4 \log 2.
$$
Combining this with $\log N \le H_N \le 1 + \log N$ gives:
$$
-2 = (\log N - 1) - (1 + \log N) \le \sum_{n=1}^N \frac{\Lambda(n)}{n} - H_N \le (\log N + 4\log 2) - \log N = 4\log 2.
$$

### 2.3. Normalized Terminal Error Bounds
By Chebyshev's linear bound $0 \le \psi(N) \le (4\log 2) N$:
$$
-1 \le \frac{\psi(N) - N}{N+1} \le 4\log 2.
$$

### 2.4. Uniform Bound on Signed Average
Subtracting the normalized terminal error from the prime mass difference:
$$
\sum_{n=1}^N \frac{\psi(n) - n}{n(n+1)} = \left( \sum_{n=1}^N \frac{\Lambda(n)}{n} - H_N \right) - \frac{\psi(N) - N}{N+1}.
$$
The lower bound is $-2 - 4\log 2$ and the upper bound is $4\log 2 - (-1) = 1 + 4\log 2 \le 2 + 4\log 2$.
Therefore:
$$
\left| \sum_{n=1}^N \frac{\psi(n) - n}{n(n+1)} \right| \le 2 + 4 \log 2.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/PrimeSignedAverage.lean`):
```lean
theorem logarithmicPrimeMass_bounds {N : ℕ} (hN : 1 ≤ N) :
    Real.log N - 1 ≤ logarithmicPrimeMass N ∧
    logarithmicPrimeMass N ≤ Real.log N + 4 * Real.log 2

theorem primeIncrementEnergy_le_chebyshev {N : ℕ} (hN : 1 ≤ N) :
    primeIncrementEnergy N ≤ Real.log (N : ℝ) ^ 2 +
      (4 * Real.log 2 + 1) * Real.log (N : ℝ) + 1

theorem logarithmicPrimeMass_sub_harmonic_bounds {N : ℕ} (hN : 1 ≤ N) :
    -2 ≤ logarithmicPrimeMass N - (harmonic N : ℝ) ∧
    logarithmicPrimeMass N - (harmonic N : ℝ) ≤ 4 * Real.log 2

theorem integerError_partial_summation (v : ℕ → ℝ) (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, integerError n * (v n - v (n + 1))) =
      (∑ n ∈ Finset.Icc 1 N, primeIncrement n * v n) - integerError N * v (N + 1)

theorem signedPrimeErrorAverage_eq (N : ℕ) :
    signedPrimeErrorAverage N = logarithmicPrimeMass N - (harmonic N : ℝ) -
      integerError N / ((N : ℝ) + 1)

theorem signedPrimeErrorAverage_abs_le (N : ℕ) :
    |signedPrimeErrorAverage N| ≤ 2 + 4 * Real.log 2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Elementary prime number estimates (Mertens 1874, Chebyshev 1852, Diamond 1982). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the exact identity $\sum_{n=1}^N \frac{\psi(n)-n}{n(n+1)} = \sum \frac{\Lambda(n)}{n} - H_N - \frac{\psi(N)-N}{N+1}$ and the unconditional bound $\le 2 + 4\log 2$ in Lean 4.
- **Target Venues:** *American Mathematical Monthly* or *Journal of Number Theory*.
