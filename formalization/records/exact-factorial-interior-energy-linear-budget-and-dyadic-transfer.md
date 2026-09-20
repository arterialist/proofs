# Contribution 290: Exact Factorial Interior Energy Linear Budget and Dyadic Transfer

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/FactorialBirthInteriorBound.lean`](../../formalization/BuildingBlocks/FactorialBirthInteriorBound.lean), [`building-blocks/factorial-cells/interior-bounds.md`](../../building-blocks/factorial-cells/interior-bounds.md)  
**Classification:** Analytic Number Theory / Harmonic Analysis / Factorial Energy / LCM Decompositions / Dyadic Sums / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the spectral energy decomposition of factorial cell processes, the total integrated energy decomposes into an escaping boundary term and a bulk interior term:
$$
\text{integratedEnergy}(N) = \text{boundaryEnergy}(N) + \text{interiorEnergy}(N).
$$
Controlling the difference between boundary energy and total energy requires proving that the bulk interior energy is strictly subordinated to the boundary dynamics.

This contribution proves:

1. **Unconditional Linear Bound for Bulk Interior Energy:**  
   For every integer $N \in \mathbb{N}$:
   $$
   |\text{interiorEnergy}(N)| \le \frac{5}{4} N.
   $$
2. **Two-Regime Interior Density Decomposition:**  
   The interior density $\text{interiorRow}(N, t)$ decomposes into:
   - **Near origin ($0 < t \le 1$):** $|\text{interiorRow}(N, t)| \le \frac{N}{4}$, exploiting the linear origin vanishing $\beta(t) \le t/2$ of the clock factor $\beta(t) = \frac{1 - e^{-t}}{1 + e^{-t}}$.
   - **Large times ($t > 1$):** $|\text{interiorRow}(N, t)| \le \frac{N}{t^2}$, governed by the summable inverse-square weight tail.
3. **Exact Dyadic Interior Horizon Budget:**  
   For any dyadic scale $X \in \mathbb{N}$:
   $$
   \left| \sum_{N=X}^{2X-1} \text{interiorEnergy}(N) \right| \le \frac{5}{8} X (3X - 1).
   $$
4. **Energy-to-Boundary Transfer Inequalities:**  
   For all $N \in \mathbb{N}$:
   $$
   \text{integratedEnergy}(N) \le \text{boundaryEnergy}(N) + \frac{5}{4} N,
   $$
   $$
   \text{boundaryEnergy}(N) \le \text{integratedEnergy}(N) + \frac{5}{4} N.
   $$
5. **Finite Clock Band Bounds:**  
   On any finite clock window $[0, T]$ with $T \ge 0$:
   $$
   \left| \int_0^T \text{interiorRow}(N, t) dt \right| \le \frac{N T}{4}.
   $$

---

## 2. Mathematical Proof

### 2.1. Decomposition into Origin and Tail
The clock modulation factor is:
$$
\beta(t) = \frac{1 - e^{-t}}{1 + e^{-t}} = \tanh(t/2).
$$
For $t \ge 0$, $\beta(t) \le t/2$ via monotonicity of $t - 2 + (t+2)e^{-t}$.
Combining with the absolute response envelope $|\text{response}(N, 2t)| \le N$ and weight bound $w(t) \le \frac{1}{2t}$:
$$
|\text{interiorRow}(N, t)| = \beta(t) |\text{response}(N, 2t)| w(t) \le \left(\frac{t}{2}\right) N \left(\frac{1}{2t}\right) = \frac{N}{4}.
$$
For $t > 1$, using $\beta(t) \le 1$ and $w(t) \le 1/t^2$:
$$
|\text{interiorRow}(N, t)| \le 1 \cdot N \cdot \frac{1}{t^2} = \frac{N}{t^2}.
$$

### 2.2. Integration Across Regimes
Integrating across $[0, 1]$ and $(1, \infty)$:
$$
\int_0^1 |\text{interiorRow}(N, t)| dt \le \frac{N}{4} \cdot 1 = \frac{N}{4},
$$
$$
\int_1^\infty |\text{interiorRow}(N, t)| dt \le \int_1^\infty \frac{N}{t^2} dt = N \left[ -\frac{1}{t} \right]_1^\infty = N.
$$
Summing both intervals:
$$
|\text{interiorEnergy}(N)| \le \frac{N}{4} + N = \frac{5}{4} N.
$$

### 2.3. Dyadic Summation
Summing over the dyadic window $N \in [X, 2X)$:
$$
\sum_{N=X}^{2X-1} N = \frac{(2X)(2X-1)}{2} - \frac{X(X-1)}{2} = \frac{X(3X-1)}{2}.
$$
Multiplying by $5/4$ yields the exact dyadic bound:
$$
\frac{5}{4} \cdot \frac{X(3X-1)}{2} = \frac{5}{8} X(3X - 1).
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.FactorialBirthInteriorBound` in `formalization/BuildingBlocks/FactorialBirthInteriorBound.lean`):
```lean
theorem beta_le_half (t : ℝ) (ht : 0 ≤ t) : beta t ≤ t / 2

theorem interior_row_uniform (N : ℕ) (t : ℝ) (ht : 0 < t) :
    |interiorRow N t| ≤ (N : ℝ) / 4

theorem interior_row_tail (N : ℕ) (t : ℝ) (ht : 0 < t) :
    |interiorRow N t| ≤ (N : ℝ) / t ^ 2

theorem interior_energy_linear (N : ℕ) : |interiorEnergy N| ≤ 5 * (N : ℝ) / 4

theorem dyadic_interior_budget (X : ℕ) :
    |∑ N ∈ Ico X (2 * X), interiorEnergy N| ≤ 5 * (X : ℝ) * (3 * (X : ℝ) - 1) / 8

theorem actual_energy_upper (N : ℕ) :
    FactorialBinaryIntegrability.integratedEnergy N ≤ boundaryEnergy N + 5 * (N : ℝ) / 4

theorem actual_boundary_upper (N : ℕ) :
    boundaryEnergy N ≤ FactorialBinaryIntegrability.integratedEnergy N + 5 * (N : ℝ) / 4
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Bounded variation in spectral theory, Hardy spaces, and Dirichlet series transfers. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes that the interior bulk contribution of factorial cell energy is strictly sub-dominant ($O(N)$ vs potential quadratic growth), proving that boundary energy captures the dominant asymptotics.
- **Target Venues:** *Journal of Mathematical Analysis and Applications* or *Forum Mathematicum*.
