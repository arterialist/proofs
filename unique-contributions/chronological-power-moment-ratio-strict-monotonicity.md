# Unique Contribution 76: Chronological Power Moment Ratio Strict Monotonicity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ChronologicalPowerRatio.lean`](../../formalization/BuildingBlocks/ChronologicalPowerRatio.lean)  
**Classification:** Classical Analysis / Discrete Inequalities / Power Moment Sequences / Monotonicity of Ratios

---

## 1. Executive Summary and Mathematical Statement

Let $A(n)$ and $B(n)$ denote the inverse-square-root mass and the first moment of the first $n$ positive integers:
\[
A(n) = \sum_{j=1}^n \frac{1}{\sqrt{j}}, \quad B(n) = \sum_{j=1}^n \sqrt{j}, \quad D(n) = (n+1) A(n).
\]
In continuous chronological divisibility and boundary reflection bounds, the effective mean clock position is governed by the normalized power ratio:
\[
R(n) = \frac{B(n)}{D(n)} = \frac{\sum_{j=1}^n \sqrt{j}}{(n+1) \sum_{j=1}^n \frac{1}{\sqrt{j}}}.
\]

This contribution proves:

1. **Non-Asymptotic Bound on Inverse-Square-Root Mass:**  
   For all integers $n \ge 1$:
   \[
   A(n) \le 2 \sqrt{n} - 1.
   \]
2. **Strict Monotonicity of the Increment Controller:**  
   The sequence $h(n) = \frac{A(n)}{\sqrt{n+1}} + \frac{1}{n+1}$ is **strictly monotone increasing**:
   \[
   \forall n \in \mathbb{N}, \quad h(n) < h(n+1).
   \]
3. **Moment Comparison Inequality:**  
   For all $n \ge 1$, the scaled mass strictly bounds the moment:
   \[
   D(n) < B(n) (1 + h(n)).
   \]
4. **Strict Decreasing Monotonicity of the Normalized Power Ratio:**  
   The sequence of normalized power ratios $R(n) = \frac{B(n)}{D(n)}$ is **strictly decreasing** for all $n \ge 1$:
   \[
   \frac{B(n+1)}{D(n+1)} < \frac{B(n)}{D(n)},
   \]
   and for all $1 \le k < N$:
   \[
   \frac{B(N)}{D(N)} < \frac{B(k)}{D(k)}.
   \]
   In particular, $R(n)$ decreases strictly from $R(1) = 1/2$ toward the continuous limit $\lim_{n \to \infty} R(n) = 1/3$.

---

## 2. Mathematical Proof

### 2.1. Step Inequality and Mass Bound
The difference between square roots satisfies $\frac{1}{\sqrt{n+1}} \le 2(\sqrt{n+1} - \sqrt{n})$.
Summing this telescoping inequality for $j=1$ to $n-1$ and using the base case $A(1) = 1 = 2\sqrt{1} - 1$ proves by induction that $A(n) \le 2\sqrt{n} - 1$.

### 2.2. Monotonicity of $h(n)$
Expressing $h(n+1) - h(n)$ in terms of $A(n)$ and expanding via $A(n) \le 2\sqrt{n} - 1$, algebraic simplification via difference of squares reveals that $h(n+1) - h(n) > 0$ for all $n \ge 0$.

### 2.3. Identity for $D(n)$
By definition, $D(n+1) - D(n) = (n+2)A(n+1) - (n+1)A(n) = A(n) + \frac{n+2}{\sqrt{n+1}} = \sqrt{n+1}(1 + h(n))$.
Thus $D(n) = \sum_{j=0}^{n-1} \sqrt{j+1}(1 + h(j))$.
Since $h(j) < h(n)$ for all $j < n$, we obtain:
\[
D(n) < (1 + h(n)) \sum_{j=0}^{n-1} \sqrt{j+1} = B(n)(1 + h(n)).
\]

### 2.4. Strict Decrease of $B(n)/D(n)$
Cross-multiplying $\frac{B(n+1)}{D(n+1)} < \frac{B(n)}{D(n)}$ is equivalent to:
\[
B(n+1) D(n) < B(n) D(n+1).
\]
Substituting $B(n+1) = B(n) + \sqrt{n+1}$ and $D(n+1) = D(n) + \sqrt{n+1}(1 + h(n))$:
\[
(B(n) + \sqrt{n+1}) D(n) < B(n) (D(n) + \sqrt{n+1}(1 + h(n))) \iff \sqrt{n+1} D(n) < \sqrt{n+1} B(n)(1 + h(n)).
\]
Dividing by $\sqrt{n+1} > 0$ yields $D(n) < B(n)(1 + h(n))$, which was established above.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ChronologicalPowerRatio`):
```lean
theorem A_bound (n : ℕ) (hn : 1 ≤ n) : A n ≤ 2 * Real.sqrt n - 1

theorem h_strictMono : StrictMono h

theorem D_lt_B_mul (n : ℕ) (hn : 1 ≤ n) : D n < B n * (1 + h n)

theorem normalizedRatio_succ_lt (n : ℕ) (hn : 1 ≤ n) :
    B (n + 1) / D (n + 1) < B n / D n

theorem normalizedRatio_lt {k N : ℕ} (hk : 1 ≤ k) (hkn : k < N) :
    B N / D N < B k / D k
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Discrete inequalities for sums of powers $\sum j^p$ (Euler–Maclaurin, Stolz–Cesàro) typically yield asymptotic expansions. The strict monotonicity of the ratio $\sum_{j=1}^n \sqrt{j} / ((n+1)\sum_{j=1}^n j^{-1/2})$ for every finite integer $n \ge 1$ had not been formalized in Lean 4.
- **Advancement:** Proves strict discrete monotonicity and strict anti-monotonicity of the normalized chronological moment ratio.
- **Target Venues:** *Journal of Mathematical Inequalities* or *American Mathematical Monthly*.
