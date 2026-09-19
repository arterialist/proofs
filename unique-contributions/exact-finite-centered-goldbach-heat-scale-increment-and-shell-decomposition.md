# Unique Contribution 314: Exact Finite Centered-Goldbach Heat Scale Increment and Shell Decomposition

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CenteredGoldbachHeatScaleIncrementFinite.lean`](../../formalization/BuildingBlocks/CenteredGoldbachHeatScaleIncrementFinite.lean), [`building-blocks/goldbach-heat/scale-increment.md`](../../building-blocks/goldbach-heat/scale-increment.md)  
**Classification:** Analytic Number Theory / Additive Combinatorics / Heat Flow Regularization / Goldbach Variations / Scale Increments / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the heat-flow regularization of centered Goldbach convolutions, the physical temperature $t \in [e^{-2T}, e^{-T}]$ governs the exposure of newly active scale horizons. Under logarithmic horizon doubling $T \mapsto 2T$, the change in the total heat horizon is governed by a finite scale shell.

This contribution proves:

1. **Exact Finite Heat-Scale Increment as Squared Heat Flow:**  
   For any literal integer cutoff $Y$ and horizon parameter $T$:
   \[
   \Delta_T \mathcal{H}_Y(T) = \int_{e^{-2T}}^{e^{-T}} \left( \sum_{m=1}^Y (\Lambda(m) - 1) e^{-mt} \right)^2 dt.
   \]
   Consequently, the finite heat-scale increment is strictly non-negative: $\Delta_T \mathcal{H}_Y(T) \ge 0$.
2. **Exact Horizon Doubling Identity:**  
   The discrete scale increment is identically equal to the finite coefficient sum:
   \[
   \mathcal{H}_Y(2T) - \mathcal{H}_Y(T) = \sum_{N=2}^{2Y} c_Y(N) \mathcal{K}_{\text{shell}}(T, N),
   \]
   where $\mathcal{K}_{\text{shell}}(T, N) = \frac{e^{-N e^{-2T}} - e^{-N e^{-T}}}{N}$.
3. **Exact Four-Way Centering Shell Decomposition:**  
   The full shell increment decomposes into:
   \[
   \Delta_T \mathcal{H}_Y(T) = \Delta_T^{\text{prime}} - \Delta_T^{\text{left}} - \Delta_T^{\text{right}} + \Delta_T^{\text{count}},
   \]
   where each component is individually non-negative for $T \ge 0$:
   - Prime-prime packet: $\Delta_T^{\text{prime}}(Y, T) \ge 0$
   - Left marginal centering: $\Delta_T^{\text{left}}(Y, T) \ge 0$
   - Right marginal centering: $\Delta_T^{\text{right}}(Y, T) \ge 0$
   - Background pair count: $\Delta_T^{\text{count}}(Y, T) \ge 0$.
4. **Exact Parity Splitting:**  
   The scale increment splits cleanly across parity classes:
   \[
   \Delta_T \mathcal{H}_Y(T) = \Delta_T^{\text{even}}(Y, T) + \Delta_T^{\text{odd}}(Y, T).
   \]
5. **Pointwise Centered Truncation Inequality:**  
   $c_Y(N) \le c_Y^{\text{prime}}(N) + c_Y^{\text{count}}(N)$, showing that signed centering compensation comes entirely from the marginal von Mangoldt subtractions.

---

## 2. Mathematical Proof

### 2.1. Exponential Heat Integral
For $N \in \mathbb{N}_{\ge 1}$, the antiderivative of $e^{-Nt}$ is $-e^{-Nt}/N$. Thus:
\[
\int_{e^{-2T}}^{e^{-T}} e^{-Nt} dt = \frac{e^{-N e^{-2T}} - e^{-N e^{-T}}}{N} = \mathcal{K}_{\text{shell}}(T, N).
\]
By the definition of the centered finite heat flow:
\[
\left( \sum_{m=1}^Y (\Lambda(m) - 1) e^{-mt} \right)^2 = \sum_{N=2}^{2Y} c_Y(N) e^{-Nt}.
\]
Integrating term-by-term yields $\int_{e^{-2T}}^{e^{-T}} (\text{finiteHeat}(t))^2 dt = \sum_{N=2}^{2Y} c_Y(N) \mathcal{K}_{\text{shell}}(T, N) = \Delta_T \mathcal{H}_Y(T)$.

### 2.2. Centering Algebraic Decomposition
At each total $N = m + n$, the centered product expands as:
\[
(\Lambda(m) - 1)(\Lambda(n) - 1) = \Lambda(m)\Lambda(n) - \Lambda(m) - \Lambda(n) + 1.
\]
Summing over $(m, n) \in [1, Y]^2$ with $m + n = N$ gives:
\[
c_Y(N) = c_Y^{\text{prime}}(N) - c_Y^{\text{left}}(N) - c_Y^{\text{right}}(N) + c_Y^{\text{count}}(N).
\]
Multiplying by $\mathcal{K}_{\text{shell}}(T, N)$ and summing over $N \in [2, 2Y]$ yields the 4-way decomposition.

### 2.3. Kernel Positivity
For $T \ge 0$, $-2T \le -T \implies e^{-2T} \le e^{-T}$.
Thus $-N e^{-2T} \ge -N e^{-T}$, which implies $e^{-N e^{-2T}} \ge e^{-N e^{-T}}$.
Hence $\mathcal{K}_{\text{shell}}(T, N) \ge 0$.
Since $\Lambda(m) \ge 0$, each component sum has non-negative coefficients and is therefore non-negative.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite` in `formalization/BuildingBlocks/CenteredGoldbachHeatScaleIncrementFinite.lean`):
```lean
theorem finiteHeatHorizon_double_sub (Y : ℕ) (T : ℝ) :
    finiteHeatHorizon Y (2 * T) - finiteHeatHorizon Y T =
      finiteHeatScaleIncrement Y T

theorem finiteHeatScaleIncrement_eq_integral (Y : ℕ) (T : ℝ) :
    finiteHeatScaleIncrement Y T =
      ∫ t in exp (-2 * T)..exp (-T),
        (finiteHeat centeredCoefficient Y t) ^ 2

theorem finiteHeatScaleIncrement_decomposition (Y : ℕ) (T : ℝ) :
    finiteHeatScaleIncrement Y T =
      primeScaleIncrement Y T - leftMarginalScaleIncrement Y T -
        rightMarginalScaleIncrement Y T + pairCountScaleIncrement Y T

theorem finiteHeatScaleIncrement_parity (Y : ℕ) (T : ℝ) :
    finiteHeatScaleIncrement Y T =
      evenScaleIncrement Y T + oddScaleIncrement Y T

theorem shellKernel_nonneg {T : ℝ} (hT : 0 ≤ T) {N : ℕ} (hN : 0 < N) :
    0 ≤ shellKernel T N
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Hardy & Littlewood (1923) *Some problems of 'Partitio Numerorum'; III: On the expression of a number as a sum of primes*; Goldston, Pintz & Yıldırım (2009) *Primes in tuples I*. Machine verification of exact finite centered heat scale increments, horizon doubling identities, and 4-way marginal decompositions in Lean 4 is new.
- **Advancement:** Establishes an exact non-asymptotic heat flow framework for centered Goldbach convolutions, providing certified non-negative scale increments and explicit parity splitting.
- **Target Venues:** *International Journal of Number Theory* or *Journal of Number Theory*.
