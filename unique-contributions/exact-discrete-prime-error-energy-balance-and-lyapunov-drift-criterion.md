# Unique Contribution 278: Exact Discrete Prime Error Energy Balance and Lyapunov Drift Criterion

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeEnergy.lean`](../../formalization/BuildingBlocks/PrimeEnergy.lean), [`building-blocks/prime-distribution/prime-energy.md`](../../building-blocks/prime-distribution/prime-energy.md)  
**Classification:** Analytic Number Theory / Discrete Energy Methods / Chebyshev Function / Prime Drift / Lyapunov Functions / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the dynamics of arithmetic fluctuations, energy methods provide a discrete counterpart to contour integration. This file formulates an exact discrete integration-by-parts identity for the Chebyshev prime error $e(n) = \psi(n) - n$, defining a discrete Dirichlet energy, a diagonal prime-power increment energy, and an off-diagonal signed drift.

This contribution proves:

1. **Exact Discrete Prime Error Energy Balance Identity:**  
   For every cutoff $N \ge 1$:
   \[
   \sum_{n=1}^N \frac{(\psi(n) - n)^2}{n(n+1)} = 2 \cdot \text{primeErrorDrift}(N) + \text{primeIncrementEnergy}(N) - \frac{(\psi(N) - N)^2}{N+1},
   \]
   where:
   \[
   \text{primeErrorDrift}(N) = \sum_{n=1}^N \frac{(\psi(n-1) - (n-1))(\Lambda(n) - 1)}{n},
   \]
   and:
   \[
   \text{primeIncrementEnergy}(N) = \sum_{n=1}^N \frac{(\Lambda(n) - 1)^2}{n}.
   \]
2. **Unconditional $O(\log^2 N)$ Bound on Diagonal Prime Increment Energy:**  
   For every $N \ge 1$:
   \[
   \text{primeIncrementEnergy}(N) \le 2 \log^2 N + \log N + 1.
   \]
   This establishes that the diagonal increment energy is always controlled by Chebyshev's elementary reciprocal mass bound $\sum_{n \le N} \Lambda(n)/n \le 2 \log N$ and harmonic numbers.
3. **Lyapunov Criterion for Quasi-Optimal Prime Error Bounds:**  
   If the cumulative signed drift is nonpositive ($\text{primeErrorDrift}(N) \le 0$), then the terminal prime error unconditionally satisfies:
   \[
   (\psi(N) - N)^2 \le (N+1)(2 \log^2 N + \log N + 1),
   \]
   which implies $|\psi(N) - N| \le \sqrt{2} \sqrt{N} \log N (1 + o(1))$, the sharp Riemann Hypothesis bound.
4. **Early Drift Positivity and Failure of Monotonic Nonpositivity:**  
   At $N = 2$, the drift is strictly positive:
   \[
   \text{primeErrorDrift}(2) = \frac{1 - \log 2}{2} > 0.
   \]
   This rigorously isolates why the drift cannot be bounded by a trivial sign property, necessitating collective oscillatory cancellation.
5. **Universal Weighted Discrete Integration-by-Parts Identity:**  
   For any sequence $e : \mathbb{N} \to \mathbb{R}$ with $e(0) = 0$:
   \[
   \sum_{n=1}^N \frac{e(n)^2}{n(n+1)} = \sum_{n=1}^N \frac{e(n)^2 - e(n-1)^2}{n} - \frac{e(N)^2}{N+1}.
   \]

---

## 2. Mathematical Proof

### 2.1. Discrete Weighted Energy Identity
Using the partial fraction $\frac{1}{n(n+1)} = \frac{1}{n} - \frac{1}{n+1}$:
\[
\sum_{n=1}^N \frac{e(n)^2}{n(n+1)} = \sum_{n=1}^N \left( \frac{e(n)^2}{n} - \frac{e(n)^2}{n+1} \right).
\]
Summing by parts:
\[
\sum_{n=1}^N \frac{e(n)^2}{n} - \sum_{n=1}^N \frac{e(n)^2}{n+1} = \sum_{n=1}^N \frac{e(n)^2}{n} - \sum_{n=2}^{N+1} \frac{e(n-1)^2}{n} = \sum_{n=1}^N \frac{e(n)^2 - e(n-1)^2}{n} - \frac{e(N)^2}{N+1},
\]
since $e(0) = 0$.

### 2.2. Expanding Quadratic Differences
With $e(n) = \psi(n) - n$ and $e(n) - e(n-1) = \Lambda(n) - 1$:
\[
e(n)^2 - e(n-1)^2 = (e(n) - e(n-1))(e(n) + e(n-1)) = (\Lambda(n) - 1)(2 e(n-1) + (\Lambda(n) - 1)).
\]
Dividing by $n$ and summing yields:
\[
\sum_{n=1}^N \frac{e(n)^2 - e(n-1)^2}{n} = 2 \sum_{n=1}^N \frac{e(n-1)(\Lambda(n)-1)}{n} + \sum_{n=1}^N \frac{(\Lambda(n)-1)^2}{n} = 2 \cdot \text{primeErrorDrift}(N) + \text{primeIncrementEnergy}(N).
\]

### 2.3. Increment Energy Upper Bound
For each $n \le N$, $\Lambda(n) \le \log n \le \log N$.
\[
(\Lambda(n) - 1)^2 \le \Lambda(n)^2 + 1 \le \Lambda(n) \log N + 1.
\]
Dividing by $n$:
\[
\frac{(\Lambda(n)-1)^2}{n} \le \log N \frac{\Lambda(n)}{n} + \frac{1}{n}.
\]
Summing over $1 \le n \le N$:
\[
\text{primeIncrementEnergy}(N) \le \log N \sum_{n=1}^N \frac{\Lambda(n)}{n} + H_N.
\]
Using $\sum_{n=1}^N \frac{\Lambda(n)}{n} \le 2 \log N$ and $H_N \le 1 + \log N$:
\[
\text{primeIncrementEnergy}(N) \le 2 \log^2 N + \log N + 1.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/PrimeEnergy.lean`):
```lean
theorem weighted_energy_balance (e : ℕ → ℝ) (h0 : e 0 = 0) (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, e n ^ 2 / ((n : ℝ) * ((n : ℝ) + 1))) =
      (∑ n ∈ Finset.Icc 1 N, (e n ^ 2 - e (n - 1) ^ 2) / (n : ℝ)) -
        e N ^ 2 / ((N : ℝ) + 1)

theorem prime_energy_balance (N : ℕ) :
    discretePrimeErrorEnergy N = 2 * primeErrorDrift N + primeIncrementEnergy N -
      integerError N ^ 2 / ((N : ℝ) + 1)

theorem primeIncrementEnergy_le_log_square {N : ℕ} (hN : 1 ≤ N) :
    primeIncrementEnergy N ≤ 2 * Real.log (N : ℝ) ^ 2 + 1 + Real.log (N : ℝ)

theorem prime_error_square_upper_of_drift_nonpos {N : ℕ} (hN : 1 ≤ N)
    (hD : primeErrorDrift N ≤ 0) :
    integerError N ^ 2 ≤ ((N : ℝ) + 1) *
      (2 * Real.log (N : ℝ) ^ 2 + 1 + Real.log (N : ℝ))

theorem primeErrorDrift_two_pos : 0 < primeErrorDrift 2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dirichlet energy methods for discrete martingales and arithmetic random walks (Billingsley 1995, Tao 2016). Formulating exact discrete weighted integration-by-parts for the Chebyshev prime error trajectory and extracting the explicit Lyapunov drift condition in Lean 4 is new.
- **Advancement:** Establishes an exact non-asymptotic energy balance identity for prime fluctuations, reducing the Riemann Hypothesis to the sign / growth control of the discrete bilinear drift.
- **Target Venues:** *Journal of Number Theory* or *Discrete Analysis*.
