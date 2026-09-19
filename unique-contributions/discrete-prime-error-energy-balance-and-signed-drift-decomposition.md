# Contribution 65: Discrete Prime Error Energy Balance and Signed Drift Decomposition

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PrimeEnergy.lean`](../../formalization/BuildingBlocks/PrimeEnergy.lean)  
**Classification:** Analytic Number Theory / Energy Methods / Prime Trajectories / Discrete Integration by Parts

---

## 1. Executive Summary and Mathematical Statement

In the analytic theory of the Riemann Hypothesis, bounding the Chebyshev error $E(N) = \psi(N) - N$ by $O(\sqrt{N} \log^2 N)$ is equivalent to RH. While continuous Mellin-transform techniques dominate the literature, discrete trajectory and energy methods offer direct physical bounds on the cumulative error.

This contribution proves:

1. **Discrete Integration-by-Parts Identity for General Trajectories:**  
   For ANY discrete trajectory $e: \mathbb{N} \to \mathbb{R}$ with $e(0) = 0$:
   $$
   \sum_{n=1}^N \frac{e(n)^2}{n(n+1)} = \sum_{n=1}^N \frac{e(n)^2 - e(n-1)^2}{n} - \frac{e(N)^2}{N+1}.
   $$
2. **Exact Prime Error Energy Balance Equation:**  
   For the Chebyshev prime error $E(n) = \psi(n) - n$ with prime increments $\Delta_n = \Lambda(n) - 1$:
   $$
   \mathcal{E}(N) = 2 \mathcal{D}(N) + \mathcal{I}(N) - \frac{E(N)^2}{N+1},
   $$
   where:
   - **Cumulative discrete error energy:** $\mathcal{E}(N) = \sum_{n=1}^N \frac{E(n)^2}{n(n+1)}$,
   - **Diagonal increment energy:** $\mathcal{I}(N) = \sum_{n=1}^N \frac{(\Lambda(n)-1)^2}{n}$,
   - **Off-diagonal signed error drift:** $\mathcal{D}(N) = \sum_{n=1}^N \frac{E(n-1)(\Lambda(n)-1)}{n} = \sum_{1 \le m < n \le N} \frac{(\Lambda(m)-1)(\Lambda(n)-1)}{n}$.
3. **Log-Square Bound for Diagonal Increment Energy:**  
   Using the divisor identity $\sum_{n \le N} \Lambda(n)/n \le 2 \log N$, the diagonal energy satisfies the unconditional bound:
   $$
   \mathcal{I}(N) \le 2 (\log N)^2 + \log N + 1.
   $$
4. **RH Equivalence via Drift Bounds and the Positivity Obstruction:**  
   - If the signed drift were nonpositive $\mathcal{D}(N) \le 0$, then $E(N)^2 \le (N+1)(2 \log^2 N + \log N + 1)$, which would unconditionally prove $E(N) = O(\sqrt{N} \log N)$ (and hence RH).
   - However, at $N = 2$, the signed drift is strictly positive:
     $$
     \mathcal{D}(2) = \frac{1 - \log 2}{2} > 0.
     $$
     This obstruction proves that the cumulative signed drift $\mathcal{D}(N)$ cannot be uniformly nonpositive, demonstrating that prime energy cannot be controlled by diagonal bounds alone without subtle off-diagonal phase cancellation.

---

## 2. Mathematical Proof

### 2.1. Weighted Energy Balance
By induction on $N$:
$$
\frac{e(n)^2 - e(n-1)^2}{n} = \frac{e(n)^2}{n} - \frac{e(n-1)^2}{n}.
$$
Summing by parts:
$$
\sum_{n=1}^N \frac{e(n)^2}{n} - \sum_{n=1}^N \frac{e(n-1)^2}{n} = \sum_{n=1}^{N-1} e(n)^2 \left( \frac{1}{n} - \frac{1}{n+1} \right) + \frac{e(N)^2}{N} = \sum_{n=1}^N \frac{e(n)^2}{n(n+1)} + \frac{e(N)^2}{N+1}.
$$
Rearranging yields the identity.

### 2.2. Prime Energy Balance
Since $E(n) = E(n-1) + \Delta_n$:
$$
E(n)^2 - E(n-1)^2 = (E(n-1) + \Delta_n)^2 - E(n-1)^2 = 2 E(n-1)\Delta_n + \Delta_n^2.
$$
Dividing by $n$ and summing from $n=1$ to $N$:
$$
\sum_{n=1}^N \frac{E(n)^2 - E(n-1)^2}{n} = 2 \mathcal{D}(N) + \mathcal{I}(N).
$$
Substituting into the weighted energy balance gives $\mathcal{E}(N) = 2 \mathcal{D}(N) + \mathcal{I}(N) - \frac{E(N)^2}{N+1}$.

### 2.3. Diagonal Bound
For each $n \le N$, $\Lambda(n) \le \log N$. Thus $(\Lambda(n) - 1)^2 \le \Lambda(n) \log N + 1$.
Dividing by $n$ and summing:
$$
\mathcal{I}(N) \le \log N \sum_{n=1}^N \frac{\Lambda(n)}{n} + H_N \le 2 (\log N)^2 + \log N + 1.
$$

### 2.4. Positivity Obstruction at $N = 2$
For $N = 2$: $E(0) = 0$, $E(1) = \Lambda(1) - 1 = -1$, $\Delta_2 = \Lambda(2) - 1 = \log 2 - 1$.
Then $\mathcal{D}(2) = \frac{E(1)\Delta_2}{2} = \frac{(-1)(\log 2 - 1)}{2} = \frac{1 - \log 2}{2}$.
Since $\log 2 \approx 0.69315 < 1$, $\mathcal{D}(2) > 0$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks`):
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

- **Prior Literature:** Discrete energy identities connecting quadratic cumulative errors of arithmetical functions to martingale/drift decompositions appear in probability theory, but have not been formalized for the Chebyshev prime trajectory in Lean 4.
- **Advancement:** Establishes the exact discrete energy balance for $\psi(N) - N$, proves the $O(\log^2 N)$ diagonal energy bound, and formalizes the positivity obstruction $\mathcal{D}(2) > 0$.
- **Target Venues:** *Proceedings of the American Mathematical Society* or *Discrete Mathematics*.
