# Contribution 315: Exact Adjacent Additive Totals Discrete Derivative and Goldbach Pairing Oscillation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CenteredGoldbachAdjacentTotalsFinite.lean`](../../formalization/BuildingBlocks/CenteredGoldbachAdjacentTotalsFinite.lean), [`building-blocks/goldbach-heat/adjacent-totals.md`](../../building-blocks/goldbach-heat/adjacent-totals.md)  
**Classification:** Analytic Number Theory / Additive Combinatorics / Discrete Differences / Adjacent Goldbach Convolutions / Parity Pairing Obstructions / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the fine structure of truncated Goldbach convolutions $C_Y(N) = \sum_{m, n \le Y, m+n=N} a_m a_n$, understanding the step difference $C_Y(N+1) - C_Y(N)$ between adjacent totals at a fixed cutoff $Y$ is essential for detecting local smoothing or cancellation across parity classes.

This contribution proves:

1. **Exact Discrete Derivative Formula for Truncated Convolutions:**  
   For any real sequence $a : \mathbb{N} \to \mathbb{R}$, cutoff $Y \ge 1$, and total $N$:
   $$
   C_Y(N+1) - C_Y(N) = \text{core}(a, Y, N) + \text{birth}(a, Y, N) - \text{departure}(a, Y, N),
   $$
   where:
   - $\text{core}(a, Y, N) = \sum_{m=1}^Y \sum_{n=1}^{Y-1} \mathbf{1}_{m+n=N} a_m (a_{n+1} - a_n)$
   - $\text{birth}(a, Y, N) = \mathbf{1}_{N \in [1, Y]} a_N a_1$
   - $\text{departure}(a, Y, N) = \mathbf{1}_{N - Y \in [1, Y]} a_{N-Y} a_Y$.
2. **Exact Interior Cancellation of Centering Constants:**  
   For the centered coefficients $c(m) = \Lambda(m) - 1$, the centering background $-1$ cancels identically inside the interior discrete derivative:
   $$
   \text{core}(c, Y, N) = \sum_{m=1}^Y \sum_{n=1}^{Y-1} \mathbf{1}_{m+n=N} c(m) (\Lambda(n+1) - \Lambda(n)).
   $$
3. **Odd Total Symmetry Factor:**  
   For any odd integer $N$, the truncated prime-prime convolution exhibits an exact factor of 2:
   $$
   c_Y^{\text{prime}}(N) = 2 \sum_{m=1}^Y \sum_{n=1}^Y \mathbf{1}_{m+n=N \land \text{Even}(m)} \Lambda(m) \Lambda(n).
   $$
4. **Refutation of Universal Sign for Adjacent Parity Pairs:**  
   The hypothesis that adjacent even/odd pairs $P(Y, N) = c_Y(N) + c_Y(N+1)$ have a definite sign is rigorously refuted:
   $$
   P(3, 2) = c_3(2) + c_3(3) = 1 + 2(1 - \log 2) > 0,
   $$
   whereas:
   $$
   P(3, 4) = c_3(4) + c_3(5) < 0.
   $$
5. **Weighted Heat-Shell Sign Oscillation:**  
   Even under the strictly positive heat-shell weighting $\mathcal{K}_{\text{shell}}(T, N) > 0$, the weighted adjacent pairs exhibit sign reversals:
   $$
   \mathcal{W}_3(2, T) > 0 \quad \text{and} \quad \mathcal{W}_3(4, T) < 0 \qquad (\forall T > 0).
   $$

---

## 2. Mathematical Proof

### 2.1. Decomposition of Truncated Adjacent Sums
At cutoff $Y = K + 1$, split the index $n \in [1, K+1]$:
$$
\sum_{n=1}^{K+1} \mathbf{1}_{m+n=N+1} a_m a_n = \mathbf{1}_{m+1=N+1} a_m a_1 + \sum_{n=1}^K \mathbf{1}_{m+n+1=N+1} a_m a_{n+1} = \mathbf{1}_{m=N} a_m a_1 + \sum_{n=1}^K \mathbf{1}_{m+n=N} a_m a_{n+1}.
$$
Similarly:
$$
\sum_{n=1}^{K+1} \mathbf{1}_{m+n=N} a_m a_n = \sum_{n=1}^K \mathbf{1}_{m+n=N} a_m a_n + \mathbf{1}_{m+K+1=N} a_m a_{K+1}.
$$
Subtracting the two expressions gives the interior difference $\sum_{n=1}^K \mathbf{1}_{m+n=N} a_m (a_{n+1} - a_n)$ plus the birth term at $n=1$ minus the departure term at $n=Y$.

### 2.2. Centering Background Cancellation
Since $c(n+1) - c(n) = (\Lambda(n+1) - 1) - (\Lambda(n) - 1) = \Lambda(n+1) - \Lambda(n)$, the $-1$ shift drops out of the discrete derivative.

### 2.3. Parity Symmetry
If $N$ is odd and $m + n = N$, then $m$ and $n$ have opposite parities.
Thus $\mathbf{1}_{m+n=N} = \mathbf{1}_{m+n=N \land \text{Even}(m)} + \mathbf{1}_{m+n=N \land \text{Even}(n)}$.
By symmetry of indices $m \leftrightarrow n$ in the double sum, both sub-sums are equal, giving twice the even-row sum.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CenteredGoldbachAdjacentTotalsFinite` in `formalization/BuildingBlocks/CenteredGoldbachAdjacentTotalsFinite.lean`):
```lean
theorem boundedCoefficient_adjacent {Y : ℕ} (hY : 1 ≤ Y) (a : ℕ → ℝ) (N : ℕ) :
    boundedCoefficient a Y (N + 1) - boundedCoefficient a Y N =
      adjacentDerivativeCore a Y N + birthFace a Y N - departureFace a Y N

theorem centered_adjacent_derivative_eq_mangoldt (Y N : ℕ) :
    adjacentDerivativeCore centeredCoefficient Y N =
      ∑ m ∈ Icc 1 Y, ∑ n ∈ Icc 1 (Y - 1),
        if m + n = N then centeredCoefficient m *
          (ArithmeticFunction.vonMangoldt (n + 1) -
            ArithmeticFunction.vonMangoldt n) else 0

theorem odd_primeCoefficient_eq_two_evenPrimeRow {N : ℕ} (hodd : Odd N) (Y : ℕ) :
    BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedPrimeCoefficient Y N =
      2 * evenPrimeRow Y N

theorem adjacentPair_three_two_pos : 0 < adjacentPair 3 2

theorem adjacentPair_three_four_neg : adjacentPair 3 4 < 0

theorem weightedAdjacentPair_three_two_pos {T : ℝ} (hT : 0 < T) :
    0 < weightedAdjacentPair 3 2 T

theorem weightedAdjacentPair_three_four_neg {T : ℝ} (hT : 0 < T) :
    weightedAdjacentPair 3 4 T < 0
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Tao (2014) *Every odd number greater than 1 is the sum of at most five primes*; Helfgott (2013) *The ternary Goldbach conjecture*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes exact boundary and interior discrete derivative formulas for finite convolutions and proves persistent sign oscillation in adjacent even/odd pairings under heat kernels.
- **Target Venues:** *Integers* or *Ramanujan Journal*.
