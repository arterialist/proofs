# Contribution 330: Exact Pointwise Goldbach Cofactor Abel Decomposition and Packet Variation Bound

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/GoldbachCofactorPointwiseAbelFinite.lean`](../../formalization/BuildingBlocks/GoldbachCofactorPointwiseAbelFinite.lean), [`building-blocks/goldbach/pointwise-abel.md`](../../building-blocks/goldbach/pointwise-abel.md)  
**Classification:** Analytic Number Theory / Additive Combinatorics / Goldbach Conjecture / Abel Summation / Total Variation Bounds / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the pointwise estimation of the Goldbach cofactor remainder $\mathcal{R}(s)$, one isolates a chosen zero packet $F$ (such as prime power zeros or spectral projections) and bounds the contribution of the residual error $R(m) = \text{primeError}(m) - F(m)$ convolved against ratio errors.

This contribution proves:

1. **Exact Finite Abel Summation with Endpoints:**  
   For any sequences $R$ and $w$ and index $k$:
   $$
   \sum_{m=2}^{k+2} (R(m) - R(m-1)) w(m) = R(k+2) w(k+2) - R(1) w(2) + \sum_{m=2}^{k+1} R(m) (w(m) - w(m+1)).
   $$
2. **Exact Total Variation Error Bound:**  
   If $|R(m)| \le M$ for all $m \in [1, k+2]$:
   $$
   \left| \sum_{m=2}^{k+2} (R(m) - R(m-1)) w(m) \right| \le M \left( |w(k+2)| + |w(2)| + \sum_{m=2}^{k+1} |w(m) - w(m+1)| \right).
   $$
3. **Exact Pointwise Abel Packet Decomposition:**  
   For any total $s \ge 4$ and arbitrary packet $F$:
   $$
   \begin{aligned}
   \mathcal{R}(s) &= \sum_{m=2}^{s-2} (F(m) - F(m-1)) \text{ratioError}(s-m) \\
   &\quad + R(s-2) \text{ratioError}(2) - R(1) \text{ratioError}(s-2) \\
   &\quad + \sum_{m=2}^{s-3} R(m) (\text{ratioError}(s-m) - \text{ratioError}(s-(m+1))).
   \end{aligned}
   $$
4. **Finite Packet Error Estimate:**  
   If the residual satisfies $|R(m)| \le M$ on $[1, s-2]$:
   $$
   \left| \mathcal{R}(s) - \sum_{m=2}^{s-2} (F(m) - F(m-1)) \text{ratioError}(s-m) \right| \le M \left( |\text{ratioError}(2)| + |\text{ratioError}(s-2)| + \sum_{m=2}^{s-3} |\Delta \text{ratioError}(s-m)| \right).
   $$

---

## 2. Mathematical Proof

### 2.1. Abel Summation with Boundary Terms
Expanding $\sum_{m=2}^{k+2} (R(m) - R(m-1)) w(m) = \sum_{m=2}^{k+2} R(m) w(m) - \sum_{m=1}^{k+1} R(m) w(m+1)$.
Isolating $m = k+2$ from the first sum ($R(k+2)w(k+2)$) and $m = 1$ from the second sum ($-R(1)w(2)$) leaves the common interior sum $\sum_{m=2}^{k+1} R(m) (w(m) - w(m+1))$.

### 2.2. Convolution Reversal and Discrete Derivative
By the change of variables $y \mapsto s - m$, the centered pair remainder $\sum (\Lambda(y)-1)\text{ratioError}(y)$ is reversed to $\sum (\Lambda(m)-1)\text{ratioError}(s-m)$.
Since $\text{primeError}(m) - \text{primeError}(m-1) = \Lambda(m) - 1$, this expresses the centered remainder as the discrete convolution of $\Delta \text{primeError}$ with $\text{ratioError}$.
Splitting $\text{primeError} = F + R$ and applying the exact Abel formula yields the result.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.GoldbachCofactorPointwiseAbelFinite` in `formalization/BuildingBlocks/GoldbachCofactorPointwiseAbelFinite.lean`):
```lean
theorem finite_difference_abel (R w : ℕ → ℝ) (k : ℕ) :
    (∑ m ∈ Icc 2 (k + 2), (R m - R (m - 1)) * w m) =
      R (k + 2) * w (k + 2) - R 1 * w 2 +
        ∑ m ∈ Ico 2 (k + 2), R m * (w m - w (m + 1))

theorem finite_difference_abs_le_variation (R w : ℕ → ℝ) (k : ℕ) (M : ℝ)
    (hR : ∀ m ∈ Icc 1 (k + 2), |R m| ≤ M) :
    |∑ m ∈ Icc 2 (k + 2), (R m - R (m - 1)) * w m| ≤
      M * (|w (k + 2)| + |w 2| +
        ∑ m ∈ Ico 2 (k + 2), |w m - w (m + 1)|)

theorem centeredPairRemainder_packet_abel (F : ℕ → ℝ) (s : ℕ) (hs : 4 ≤ s) :
    centeredPairRemainder s =
      (∑ m ∈ Icc 2 (s - 2),
        (F m - F (m - 1)) * ratioError (s - m)) +
      residual F (s - 2) * ratioError 2 -
      residual F 1 * ratioError (s - 2) +
      (∑ m ∈ Ico 2 (s - 2),
        residual F m *
          (ratioError (s - m) - ratioError (s - (m + 1))))

theorem centeredPairRemainder_packet_error_bound
    (F : ℕ → ℝ) (s : ℕ) (hs : 4 ≤ s) (M : ℝ)
    (hR : ∀ m ∈ Icc 1 (s - 2), |residual F m| ≤ M) :
    |centeredPairRemainder s -
      ∑ m ∈ Icc 2 (s - 2),
        (F m - F (m - 1)) * ratioError (s - m)| ≤
      M * (|ratioError 2| + |ratioError (s - 2)| +
        ∑ m ∈ Ico 2 (s - 2),
          |ratioError (s - m) - ratioError (s - (m + 1))|)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Hardy & Littlewood (1923) *Some problems of 'Partitio Numerorum'; III: On the expression of a number as a sum of primes*; Montgomery & Vaughan (1975) *The exceptional set in Goldbach's problem*. Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes an exact finite Abel identity for arbitrary prime error packets and bounded residuals, decoupling the zero packet from total variation bounds on ratio errors.
- **Target Venues:** *Journal of Number Theory* or *Integers*.
