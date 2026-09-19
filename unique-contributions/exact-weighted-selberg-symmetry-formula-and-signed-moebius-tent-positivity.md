# Unique Contribution 148: Exact Weighted Selberg Symmetry Formula and Signed Möbius Tent Positivity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SelbergTent.lean`](../../formalization/BuildingBlocks/SelbergTent.lean), [`building-blocks/selberg/selberg-tent.md`](../../building-blocks/selberg/selberg-tent.md)  
**Classification:** Analytic Number Theory / Sieve Methods / Weighted Selberg Identities / Triangular Tent Smoothing / Signed Möbius Sums / Unconditional Positivity

---

## 1. Executive Summary and Mathematical Statement

In the theory of the Selberg symmetry formula, applying smoothed cutoff weights—most notably triangular tent filters $w(n) = \max(0, N - n)$ corresponding to first-order Riesz smoothing—smoothes away high-frequency arithmetic oscillations. A fundamental question in sieve theory and the analysis of Möbius randomness is determining whether smoothed signed Möbius sums can be proved to be non-negative without relying on unproved hypotheses.

This contribution proves:

1. **Exact Finite Weighted Selberg Symmetry Identity:**  
   For any integer truncation $N \ge 1$ and an arbitrary weight function $w: \mathbb{N} \to \mathbb{R}$:
   \[
   \sum_{n=1}^N w(n) \Lambda(n) \log n + \sum_{a=1}^N \Lambda(a) \sum_{b=1}^{\lfloor N/a \rfloor} w(ab) \Lambda(b) = \sum_{d=1}^N \mu(d) \sum_{q=1}^{\lfloor N/d \rfloor} w(dq) \log^2 q.
   \]
2. **Exact Triangular Tent Symmetry Identity:**  
   Specializing to the linear tent weight $w(n) = N - n$:
   \[
   \sum_{n=1}^N (N - n) \Lambda(n) \log n + \sum_{a=1}^N \sum_{b=1}^{\lfloor N/a \rfloor} (N - ab) \Lambda(a) \Lambda(b) = \sum_{d=1}^N \mu(d) \sum_{q=1}^{\lfloor N/d \rfloor} (N - dq) \log^2 q.
   \]
3. **Unconditional Positivity of the Signed Möbius Tent Sum:**  
   Despite the pseudo-random sign oscillation of the Möbius function $\mu(d) \in \{-1, 0, 1\}$, the signed double sum is unconditionally non-negative for all integers $N \ge 1$:
   \[
   0 \le \sum_{d=1}^N \mu(d) \sum_{q=1}^{\lfloor N/d \rfloor} (N - dq) \log^2 q.
   \]

---

## 2. Mathematical Proof

### 2.1. Weighted Divisor-Pair Reindexing
Using $\Lambda_2(n) = \sum_{d \mid n} \mu(d) \log^2(n/d)$:
\[
\sum_{n=1}^N w(n) \Lambda_2(n) = \sum_{n=1}^N \sum_{d \mid n} \mu(d) w(n) \log^2(n/d).
\]
Let $n = dq$ where $q = n/d$.
As $n$ ranges over $1 \le n \le N$ and $d$ ranges over divisors of $n$, the pair $(d, q)$ bijectively traverses all positive integers with $dq \le N$, i.e., $1 \le d \le N$ and $1 \le q \le \lfloor N/d \rfloor$.
Thus:
\[
\sum_{n=1}^N w(n) \Lambda_2(n) = \sum_{d=1}^N \mu(d) \sum_{q=1}^{\lfloor N/d \rfloor} w(dq) \log^2 q.
\]

### 2.2. Weighted Prime Decomposition
Using $\Lambda_2(n) = \Lambda(n) \log n + \sum_{d \mid n} \Lambda(d) \Lambda(n/d)$:
\[
\sum_{n=1}^N w(n) \Lambda_2(n) = \sum_{n=1}^N w(n) \Lambda(n) \log n + \sum_{n=1}^N \sum_{d \mid n} w(n) \Lambda(d) \Lambda(n/d).
\]
Reindexing the double sum over factor pairs $a b = n \le N$:
\[
\sum_{n=1}^N \sum_{d \mid n} w(n) \Lambda(d) \Lambda(n/d) = \sum_{a=1}^N \Lambda(a) \sum_{b=1}^{\lfloor N/a \rfloor} w(ab) \Lambda(b).
\]
Equating both expressions yields the general weighted identity.

### 2.3. Proof of Tent Positivity
For $w(n) = N - n$:
On the range $1 \le n \le N$, $w(n) = N - n \ge 0$.
Since $\Lambda_2(n) \ge 0$ for all $n \in \mathbb{N}$ (proved in `SelbergIdentity.lean` via $\Lambda(n) \ge 0$ and $\Lambda(n) \le \log n$):
\[
w(n) \Lambda_2(n) = (N - n) \Lambda_2(n) \ge 0 \quad \text{for every } n \in [1, N].
\]
Therefore, the sum over $n \in [1, N]$ is a sum of non-negative real numbers:
\[
0 \le \sum_{n=1}^N (N - n) \Lambda_2(n).
\]
By the weighted Möbius reindexing identity, this sum is identically equal to the signed Möbius tent sum:
\[
\sum_{n=1}^N (N - n) \Lambda_2(n) = \sum_{d=1}^N \mu(d) \sum_{q=1}^{\lfloor N/d \rfloor} (N - dq) \log^2 q.
\]
This proves unconditional non-negativity.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks` in `formalization/BuildingBlocks/SelbergTent.lean`):
```lean
theorem selberg_weighted_identity (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N,
      w n * ArithmeticFunction.vonMangoldt n * Real.log (n : ℝ)) +
      (∑ a ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt a *
        ∑ b ∈ Finset.Icc 1 (N / a), w (a * b) * ArithmeticFunction.vonMangoldt b) =
      ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
        ∑ q ∈ Finset.Icc 1 (N / d), w (d * q) * Real.log (q : ℝ) ^ 2

theorem selberg_tent_identity (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N,
      ((N : ℝ) - n) * ArithmeticFunction.vonMangoldt n * Real.log (n : ℝ)) +
      (∑ a ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt a *
        ∑ b ∈ Finset.Icc 1 (N / a),
          ((N : ℝ) - (a * b : ℕ)) * ArithmeticFunction.vonMangoldt b) =
      ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
        ∑ q ∈ Finset.Icc 1 (N / d),
          ((N : ℝ) - (d * q : ℕ)) * Real.log (q : ℝ) ^ 2

theorem selberg_moebius_tent_nonneg (N : ℕ) :
    0 ≤ ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
      ∑ q ∈ Finset.Icc 1 (N / d),
        ((N : ℝ) - (d * q : ℕ)) * Real.log (q : ℝ) ^ 2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Selberg's lambda-squared method and smoothed sieve weights (Selberg 1947, Bombieri 1976). While the positivity of $\Lambda_2 * 1$ is well-known in principle, machine formalization of the exact finite weighted identity for arbitrary weights and the unconditional positivity of the signed Möbius tent sum in Lean 4 is novel.
- **Advancement:** Establishes the exact weighted Selberg identity and unconditional non-negativity of the signed Möbius tent sum in Lean 4.
- **Target Venues:** *Integers* or *Journal of Number Theory*.
