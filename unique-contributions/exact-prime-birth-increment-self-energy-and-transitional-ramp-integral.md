# Unique Contribution 227: Exact Prime Birth Increment Self-Energy and Transitional Ramp Integral

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChargeFrozenBirthMetric.lean`](../../formalization/BuildingBlocks/ChargeFrozenBirthMetric.lean), [`building-blocks/charge/charge-frozen-birth-metric.md`](../../building-blocks/charge/charge-frozen-birth-metric.md)  
**Classification:** Real Analysis / Analytic Number Theory / Energy Integrals / Prime Birth Increments / Piecewise Dynamics / Hilbert Space Norms

---

## 1. Executive Summary and Mathematical Statement

The prime birth increment $\text{increment}(N, v) = \text{causalSource}(N+1, v) - \text{causalSource}(N, v)$ measures the exact change in arithmetic causal energy as the truncation threshold moves from $N$ to $N+1$. Analyzing the self-energy $\|\text{increment}(N)\|_{L^2}^2$ requires integrating a non-smooth function exhibiting three distinct regimes across the scale transition.

This contribution proves:

1. **Exact Three-Regime Piecewise Representation:**  
   For all $v > 0$, the prime birth increment decomposes into three distinct geometric regimes:
   \[
   \text{increment}(N, v) = 
   \begin{cases}
   0 & \text{if } e^v \le N, \\
   -(e^v - N) e^{-v/2} & \text{if } N < e^v < N+1, \\
   (\Lambda(N+1) - 1) e^{-v/2} & \text{if } e^v \ge N+1.
   \end{cases}
   \]
2. **Exact Transitional Ramp Integral:**  
   The $L^2$ energy accumulated during the continuous boundary transition $v \in (\log N, \log(N+1))$ evaluates in closed form without approximations:
   \[
   \int_{\log N}^{\log(N+1)} (e^v - N)^2 e^{-v} \, dv = 1 + \frac{N}{N+1} - 2N \log\left(1 + \frac{1}{N}\right).
   \]
3. **Exact Total Self-Energy Formula:**  
   For every integer $N \ge 2$, the total $L^2((0, \infty))$ self-energy of the prime birth increment evaluates to:
   \[
   \int_0^\infty (\text{increment}(N, v))^2 \, dv = 1 + \frac{N}{N+1} - 2N \log\left(1 + \frac{1}{N}\right) + \frac{(\Lambda(N+1) - 1)^2}{N+1}.
   \]
4. **Asymptotic Energy Decoupling:**  
   The ramp self-energy decays quadratically as $\frac{1}{3N^2} + O(N^{-3})$, whereas the discrete prime fluctuation energy scales as $\frac{(\Lambda(N+1) - 1)^2}{N+1}$, rigorously isolating the continuous geometric boundary cost from the arithmetic prime impulse.

---

## 2. Mathematical Proof

### 2.1. Regimes
- **Prefix ($e^v \le N$):** In $\text{source}(K, v) = (\psi(\lfloor \min(e^v, K) \rfloor) - \min(e^v, K))e^{-v/2}$, for both $K = N$ and $K = N+1$, $\min(e^v, K) = e^v$. Thus both sources match identically, yielding $\text{increment}(N, v) = 0$.
- **Ramp ($N < e^v < N+1$):** Here $\min(e^v, N) = N$ with $\lfloor N \rfloor = N$, while $\min(e^v, N+1) = e^v$ with $\lfloor e^v \rfloor = N$. Thus $\psi(\lfloor \min \rfloor) = \psi(N)$ for both, leaving $(e^v - N)e^{-v/2}$ with a negative sign: $-(e^v - N)e^{-v/2}$.
- **Terminal ($e^v \ge N+1$):** Both minima freeze: $\min(e^v, N) = N$ and $\min(e^v, N+1) = N+1$. The difference is:
  \[
  [(\psi(N+1) - (N+1)) - (\psi(N) - N)] e^{-v/2} = (\psi(N+1) - \psi(N) - 1) e^{-v/2} = (\Lambda(N+1) - 1) e^{-v/2}.
  \]

### 2.2. Ramp Integral Evaluation
Expanding the integrand:
\[
(e^v - N)^2 e^{-v} = (e^{2v} - 2N e^v + N^2) e^{-v} = e^v - 2N + N^2 e^{-v}.
\]
Integrating term-by-term from $a = \log N$ to $b = \log(N+1)$:
- $\int_a^b e^v dv = e^b - e^a = (N+1) - N = 1$.
- $\int_a^b -2N dv = -2N (b - a) = -2N \log(1 + 1/N)$.
- $\int_a^b N^2 e^{-v} dv = N^2 (e^{-a} - e^{-b}) = N^2 (1/N - 1/(N+1)) = N - \frac{N^2}{N+1} = \frac{N}{N+1}$.
Summing these gives $1 + \frac{N}{N+1} - 2N \log(1 + 1/N)$.

### 2.3. Terminal Tail Integral
For $v > b = \log(N+1)$:
\[
\int_b^\infty (\Lambda(N+1) - 1)^2 e^{-v} \, dv = (\Lambda(N+1) - 1)^2 e^{-b} = \frac{(\Lambda(N+1) - 1)^2}{N+1}.
\]
Summing the prefix ($0$), ramp, and tail integrals establishes the theorem.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChargeFrozenBirthMetric` in `formalization/BuildingBlocks/ChargeFrozenBirthMetric.lean`):
```lean
theorem increment_piecewise {N : ℕ} {v : ℝ} (hv : 0 < v) :
    increment N v = if Real.exp v ≤ (N : ℝ) then 0 else
      if Real.exp v < ((N + 1 : ℕ) : ℝ) then -(Real.exp v - (N : ℝ)) * Real.exp (-v / 2)
      else (ArithmeticFunction.vonMangoldt (N + 1) - 1) * Real.exp (-v / 2)

theorem increment_square_integral_split {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), (increment N v)^2) =
      (∫ v in Ioo (Real.log (N : ℝ)) (Real.log ((N + 1 : ℕ) : ℝ)),
        (Real.exp v - (N : ℝ))^2 * Real.exp (-v)) +
          (ArithmeticFunction.vonMangoldt (N + 1) - 1)^2 / ((N + 1 : ℕ) : ℝ)

theorem ramp_square_integral {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioo (Real.log (N : ℝ)) (Real.log ((N + 1 : ℕ) : ℝ)),
      (Real.exp v - (N : ℝ))^2 * Real.exp (-v)) =
        1 + (N : ℝ) / ((N + 1 : ℕ) : ℝ) - 2 * (N : ℝ) * Real.log (1 + 1 / (N : ℝ))

theorem increment_square_integral_evaluated {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), (increment N v)^2) =
      1 + (N : ℝ) / ((N + 1 : ℕ) : ℝ) - 2 * (N : ℝ) * Real.log (1 + 1 / (N : ℝ)) +
        (ArithmeticFunction.vonMangoldt (N + 1) - 1)^2 / ((N + 1 : ℕ) : ℝ)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Incremental energy formulations and piecewise step-function integrals in variational analysis (Evans 2010, Montgomery-Vaughan 2007). Closed-form integration of prime birth increments and exact geometric ramp energy evaluation in Lean 4 is new.
- **Advancement:** Establishes the exact closed-form energy of infinitesimal prime births, decomposing the continuous boundary cost $1 + \frac{N}{N+1} - 2N\log(1+1/N)$ from the arithmetic impulse $\frac{(\Lambda(N+1)-1)^2}{N+1}$.
- **Target Venues:** *Journal of Mathematical Analysis and Applications* or *Proceedings of the Edinburgh Mathematical Society*.
