# Contribution 333: Exact Odd Goldbach Dyadic Lacunary Reduction and Uniform Two-Log-Squared Bound

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/GoldbachOddPowerBoundFinite.lean`](../../formalization/BuildingBlocks/GoldbachOddPowerBoundFinite.lean), [`building-blocks/goldbach/odd-power-bound.md`](../../building-blocks/goldbach/odd-power-bound.md)  
**Classification:** Analytic Number Theory / Additive Combinatorics / Goldbach Problem / Von Mangoldt Function / Dyadic Lacunary Reductions / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

For any odd integer $N$, the representation of $N$ as a sum of two prime powers $N = p^a + q^b$ requires that exactly one of the summands is even, forcing it to be a power of 2 ($2^k$). Thus, the odd Goldbach sum is fundamentally lacunary.

This contribution proves:

1. **Exact Even Von Mangoldt Summation:**  
   For any cutoff $Y \ge 1$:
   $$
   \sum_{m=1}^Y \mathbf{1}_{\text{Even}(m)} \Lambda(m) = \lfloor \log_2 Y \rfloor \log 2.
   $$
2. **Exact Dyadic Lacunary Reduction:**  
   For any odd integer $N$ and source cutoff $Y$, the truncated prime coefficient collapses from a 2D convolution to a 1D lacunary sum:
   $$
   C_Y(N) = 2 \log 2 \sum_{k=1}^{\lfloor \log_2 Y \rfloor} \mathbf{1}_{2^k \le N, N-2^k \in [1, Y]} \Lambda(N - 2^k).
   $$
3. **Logarithmic Count Bound:**  
   With the admissible power set of cardinality $\le \lfloor \log_2 N \rfloor$:
   $$
   C_Y(N) \le 2 \log 2 \lfloor \log_2 N \rfloor \log N.
   $$
4. **Uniform Two-Log-Squared Upper Bound:**  
   Because $\lfloor \log_2 N \rfloor \log 2 \le \log N$, for all odd $N$ and all source cutoffs $Y$:
   $$
   C_Y(N) \le 2 (\log N)^2.
   $$

---

## 2. Mathematical Proof

### 2.1. Even Support of Von Mangoldt
By definition, $\Lambda(m) \ne 0 \iff m = p^k$. If $m$ is even, $p = 2$, so $m = 2^k$.
Each power of 2 has weight $\Lambda(2^k) = \log 2$.
The number of powers $2^k \le Y$ with $k \ge 1$ is exactly $\lfloor \log_2 Y \rfloor$. Summing gives $\lfloor \log_2 Y \rfloor \log 2$.

### 2.2. Odd Total Parity Splitting
Since $N$ is odd, in any pair $m + n = N$, one summand is even and the other is odd.
The sum over all pairs splits symmetrically into twice the sum where $m$ is even.
Restricting to the support of $\Lambda$, $m$ must be $2^k$.
Hence $C_Y(N) = 2 \sum_{k \le \log_2 Y} \Lambda(2^k) \Lambda(N - 2^k) = 2 \log 2 \sum_{k \le \log_2 Y} \Lambda(N - 2^k)$.

### 2.3. Bounding the Lacunary Sum
Each term satisfies $\Lambda(N - 2^k) \le \log(N - 2^k) \le \log N$.
The number of terms $k$ such that $2^k \le N$ is at most $\lfloor \log_2 N \rfloor$.
Multiplying: $C_Y(N) \le 2 \log 2 \lfloor \log_2 N \rfloor \log N \le 2 (\log N)^2$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.GoldbachOddPowerBoundFinite` in `formalization/BuildingBlocks/GoldbachOddPowerBoundFinite.lean`):
```lean
theorem even_vonMangoldt_sum (Y : ℕ) :
    (∑ m ∈ Icc 1 Y,
      if Even m then ArithmeticFunction.vonMangoldt m else 0) =
      (Nat.log 2 Y : ℝ) * Real.log 2

theorem odd_primeCoefficient_power_sum {N : ℕ} (hodd : Odd N) (Y : ℕ) :
    BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedPrimeCoefficient Y N =
      2 * Real.log 2 *
        ∑ k ∈ Icc 1 (Nat.log 2 Y),
          if 2 ^ k ≤ N ∧ N - 2 ^ k ∈ Icc 1 Y then
            ArithmeticFunction.vonMangoldt (N - 2 ^ k) else 0

theorem odd_primeCoefficient_le_log_count {N : ℕ} (hodd : Odd N) (Y : ℕ) :
    BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedPrimeCoefficient Y N ≤
      2 * Real.log 2 * (Nat.log 2 N : ℝ) * Real.log (N : ℝ)

theorem odd_primeCoefficient_le_two_log_sq {N : ℕ} (hodd : Odd N) (Y : ℕ) :
    BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedPrimeCoefficient Y N ≤
      2 * (Real.log (N : ℝ)) ^ 2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Hardy & Littlewood (1923) *Partitio Numerorum*; Vinogradov (1937) *Representation of an odd number as a sum of three primes*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the exact algebraic parity collapse of odd Goldbach convolution sums into dyadic lacunary orbits, producing a uniform $2(\log N)^2$ majorant independent of source truncation.
- **Target Venues:** *American Mathematical Monthly* or *Integers*.
