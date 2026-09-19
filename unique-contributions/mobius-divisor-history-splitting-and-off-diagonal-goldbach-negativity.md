# Contribution 109: Möbius Divisor History Splitting and Off-Diagonal Goldbach Negativity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CenteredGoldbachHistoryShellFinite.lean`](../../formalization/BuildingBlocks/CenteredGoldbachHistoryShellFinite.lean), [`formalization/BuildingBlocks/CenteredGoldbachHeatScaleIncrementFinite.lean`](../../formalization/BuildingBlocks/CenteredGoldbachHeatScaleIncrementFinite.lean)  
**Classification:** Arithmetic Combinatorics / Goldbach Problem / Möbius Inversion / Divisor History Shells / Definite Off-Diagonal Negativity

---

## 1. Executive Summary and Mathematical Statement

In the additive representation of an integer $N$ as the sum of two prime powers $m + n = N$, the binary prime correlation is governed by the truncated Goldbach coefficient:
$$
r_Y(N) = \sum_{\substack{1 \le m, n \le Y \\ m + n = N}} \Lambda(m) \Lambda(n).
$$
By expanding each von Mangoldt weight through its complete Möbius divisor-logarithm history $\Lambda(k) = \sum_{d \cdot e = k} \mu(d) \log e$, the product $\Lambda(m)\Lambda(n)$ expands into a fourfold sum over divisor pairs $(d, e)$ of $m$ and $(f, g)$ of $n$:
$$
\Lambda(m) \Lambda(n) = \sum_{\substack{d \cdot e = m \\ f \cdot g = n}} \mu(d) \mu(f) \log e \log g.
$$

This contribution proves:

1. **Diagonal/Off-Diagonal Möbius Splitting:**  
   The binary prime correlation splits exactly into diagonal ($d = f$) and off-diagonal ($d \ne f$) divisor channels:
   $$
   r_Y(N) = r_Y^{\text{diag}}(N) + r_Y^{\text{off}}(N).
   $$
2. **Definite Non-Negativity and Logarithmic Dominance of the Diagonal Block:**  
   When $d = f$, the weight involves $\mu(d)^2 \ge 0$, and $\log e \ge 0, \log g \ge 0$, proving that:
   $$
   r_Y^{\text{diag}}(N) \ge 0.
   $$
   Moreover, the primary term $(d, f) = (1, 1)$ yields $\log m \log n$, which establishes the universal lower bound:
   $$
   \log m \log n \le \text{diagonalHistory}(m, n).
   $$
3. **Parity Obstruction for Odd Totals:**  
   If $d = f$, then $d \mid m$ and $d \mid n$, hence $d \mid (m + n) = N$. When $N$ is odd, every common divisor label $d$ must be odd. In particular, the even divisor $d = 2$ cannot participate in the diagonal history of any odd integer.
4. **Universal Non-Positivity of Off-Diagonal Histories:**  
   Because $\Lambda(m) \Lambda(n) \le \log m \log n \le \text{diagonalHistory}(m, n)$ for all $m, n \ge 1$:
   $$
   \text{offDiagonalHistory}(m, n) = \Lambda(m) \Lambda(n) - \text{diagonalHistory}(m, n) \le 0.
   $$
   Consequently, every truncated off-diagonal Goldbach coefficient is non-positive:
   $$
   r_Y^{\text{off}}(N) \le 0.
   $$
5. **Certified Non-Zero Negative Correction:**  
   The off-diagonal correction is strictly negative for genuine prime powers:
   $$
   \text{offDiagonalHistory}(2, 4) = -(\log 2)^2 < 0,
   $$
   and at cutoff $Y = 4$ and total $N = 6$:
   $$
   r_4^{\text{off}}(6) = -2 (\log 2)^2 < 0.
   $$

---

## 2. Mathematical Proof

### 2.1. Algebraic History Expansion
Since $\Lambda(m) = \sum_{d \mid m} \mu(d) \log(m/d)$, the product $\Lambda(m)\Lambda(n)$ is:
$$
\sum_{d \mid m} \sum_{f \mid n} \mu(d) \mu(f) \log(m/d) \log(n/f).
$$
Partition the divisor index set into $\{ (d, f) : d = f \}$ and $\{ (d, f) : d \ne f \}$.
For $d = f$, the coefficient is $\mu(d)^2 \in \{0, 1\}$. Since $m/d \ge 1$ and $n/d \ge 1$, the logarithms are non-negative, so every summand is non-negative.
The sub-sum containing $(d, f) = (1, 1)$ gives $1 \cdot 1 \cdot \log m \cdot \log n$.
Since all other summands for $d = f > 1$ are $\ge 0$, $\text{diagonalHistory}(m, n) \ge \log m \log n$.

### 2.2. Non-Positivity of Off-Diagonal Channel
By Chebyshev's bound, $\Lambda(k) \le \log k$ for all $k \ge 1$.
Therefore:
$$
\Lambda(m) \Lambda(n) \le \log m \log n \le \text{diagonalHistory}(m, n).
$$
Subtracting $\text{diagonalHistory}(m, n)$ yields:
$$
\text{offDiagonalHistory}(m, n) = \Lambda(m) \Lambda(n) - \text{diagonalHistory}(m, n) \le 0.
$$
Summing over $m + n = N$ with $1 \le m, n \le Y$ gives $r_Y^{\text{off}}(N) \le 0$.

### 2.3. Explicit Evaluation at $(2, 4)$
Divisors of $2$: $(1, 2), (2, 1)$.
Divisors of $4$: $(1, 4), (2, 2), (4, 1)$.
The diagonal pairs $(d = f)$ are:
- $(1, 2) \times (1, 4) \implies 1 \cdot \log 2 \cdot \log 4 = 2(\log 2)^2$.
- $(2, 1) \times (2, 2) \implies (-1)^2 \cdot \log 1 \cdot \log 2 = 0$.
Total diagonal history $= 2(\log 2)^2$.
Meanwhile, $\Lambda(2)\Lambda(4) = (\log 2)(\log 2) = (\log 2)^2$.
Thus $\text{offDiagonalHistory}(2, 4) = (\log 2)^2 - 2(\log 2)^2 = -(\log 2)^2 < 0$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CenteredGoldbachHistoryShellFinite`):
```lean
theorem pairHistory_eq_prime_pair (m n : ℕ) :
    pairHistory m n =
      ArithmeticFunction.vonMangoldt m * ArithmeticFunction.vonMangoldt n

theorem primeCoefficient_history_split (Y N : ℕ) :
    truncatedPrimeCoefficient Y N =
      diagonalCoefficient Y N + offDiagonalCoefficient Y N

theorem diagonal_label_odd_of_odd_total {m n N d e f : ℕ}
    (hm : m = d * e) (hn : n = d * f) (hN : m + n = N)
    (hodd : Odd N) : Odd d

theorem diagonalCoefficient_nonneg (Y N : ℕ) :
    0 ≤ diagonalCoefficient Y N

theorem log_pair_le_diagonalHistory {m n : ℕ} (hm : 0 < m) (hn : 0 < n) :
    log m * log n ≤ diagonalHistory m n

theorem offDiagonalCoefficient_nonpos (Y N : ℕ) :
    offDiagonalCoefficient Y N ≤ 0

theorem offDiagonalCoefficient_four_six :
    offDiagonalCoefficient 4 6 = -2 * (log 2) ^ 2

theorem offDiagonalCoefficient_four_six_neg :
    offDiagonalCoefficient 4 6 < 0
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Circle method decompositions of Goldbach's problem (Hardy-Littlewood 1923, Vinogradov 1937, Helfgott 2013). Sieve methods typically analyze bilinear forms via Vaughan or Heath-Brown identities. The explicit fine-grained splitting of the binary prime correlation into an always-dominant non-negative diagonal history and an unconditionally non-positive off-diagonal history $r_Y^{\text{off}}(N) \le 0$ with exact evaluations is novel.
- **Advancement:** Establishes machine-verified definite sign splitting of Goldbach prime pair correlations via Möbius divisor histories.
- **Target Venues:** *Ramanujan Journal* or *Journal of Number Theory*.
