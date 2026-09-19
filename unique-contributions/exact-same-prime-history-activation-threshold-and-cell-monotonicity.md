# Contribution 178: Exact Same-Prime History Activation Threshold and Cell Monotonicity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SamePrimeFirstSquare.lean`](../../formalization/BuildingBlocks/SamePrimeFirstSquare.lean), [`building-blocks/primes/same-prime-first-square.md`](../../building-blocks/primes/same-prime-first-square.md)  
**Classification:** Analytic Number Theory / Causal Renewal Dynamics / Prime Powers / Hard Dead-Time Obstructions / Monotonicity / Piecewise Smooth Dynamics

---

## 1. Executive Summary and Mathematical Statement

In the pair correlation of prime powers, the self-interaction residual $s(v) = \sum_{p} \sum_{m \ge 2} w(p, m) h(v - m\log p)$ represents the energy contributed by proper prime powers $p^m$ ($m \ge 2$) under the causal tent kernel $h$. Determining the precise dead-time interval during which this function remains inactive is crucial for short-time causal bounds.

This contribution proves:

1. **Absolute Proper-Power Floor:**  
   For any prime $p$ and integer $m \ge 2$:
   $$
   4 \le p^m.
   $$
   The absolute minimal proper prime power across all primes is $2^2 = 4$.
2. **Exact Dead-Time Support Vanishing:**  
   The same-prime history function $s(v)$ vanishes identically on the initial logarithmic dead-time interval:
   $$
   v \le \log 4 \implies s(v) = 0.
   $$
   No proper prime power contributes any activity before the threshold $v = \log 4 \approx 1.386294...$.
3. **Exact Activation Dichotomy:**  
   The function $s(v)$ satisfies the exact if-and-only-if threshold criterion:
   $$
   s(v) > 0 \iff v > \log 4.
   $$
   Immediately upon crossing $v = \log 4$, the $(p=2, m=2)$ term activates with exact weight $\frac{\log^2 2}{2}$, rendering $s(v)$ strictly positive.
4. **Strict Cell Monotonicity of the Renewal Profile:**  
   For every integer $k \ge 1$, the renewal profile $H(x)$ is strictly monotone increasing on the closed integer cell $[k, k+1]$:
   $$
   x, y \in [k, k+1], \quad x < y \implies H(x) < H(y).
   $$
   This strict monotonicity is governed by the derivative $\frac{d}{dx} \text{cell}_k(x) = \frac{3 B(k) - x A(k)}{x^{5/2}} > 0$.

---

## 2. Mathematical Proof

### 2.1. Dead-Time Inactivity
Each summand in $s(v)$ has the form $w(p, m) h(v - m\log p)$, where $h(u) = 0$ for $u \le 0$.
A term can only be non-zero if $v > m\log p$, which is equivalent to $e^v > p^m$.
For any prime $p$ and $m \ge 2$, $p^m \ge 2^2 = 4$.
Therefore, if $v \le \log 4$, then $e^v \le 4 \le p^m$ for all $p$ and $m \ge 2$.
Consequently, $v - m\log p \le 0$, so $h(v - m\log p) = 0$ for every pair $(p, m)$.
Thus $s(v) = 0$.

### 2.2. Activation at the First Square
For $v > \log 4$, $e^v > 4 = 2^2$.
The term corresponding to $p = 2$ and $m = 2$ has weight $w(2, 2) = \frac{(2-1)\log^2 2}{\sqrt{2^2}} = \frac{\log^2 2}{2} > 0$.
The argument $v - 2\log 2 = v - \log 4 > 0$.
Since the tent profile $h(u) > 0$ for all $u > 0$, we have $w(2, 2) h(v - \log 4) > 0$.
Since all other terms are non-negative, $s(v) \ge w(2, 2) h(v - \log 4) > 0$.
Combining with the inactivity for $v \le \log 4$ yields $s(v) > 0 \iff v > \log 4$.

### 2.3. Cell Derivative and Strict Monotonicity
On each cell $[k, k+1]$, the renewal profile satisfies $\text{cell}_k(x) = \frac{x A(k) - B(k)}{x^{3/2}}$.
Differentiating with respect to $x$:
$$
\frac{d}{dx} \text{cell}_k(x) = \frac{A(k) x^{3/2} - (x A(k) - B(k)) \frac{3}{2} x^{1/2}}{x^3} = \frac{3 B(k) - x A(k)}{2 x^{5/2}}.
$$
By the same-prime aggregation kernel coercivity theorem, $3 B(k) - x A(k) \ge k > 0$ for all $x \in [k, k+1]$.
Since the derivative is strictly positive on $(k, k+1)$ and continuous on $[k, k+1]$, the mean value theorem implies that $\text{cell}_k$ (and therefore $H$) is strictly monotone increasing on $[k, k+1]$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SamePrimeFirstSquare` in `formalization/BuildingBlocks/SamePrimeFirstSquare.lean`):
```lean
theorem four_le_prime_power {p m : ℕ} (hp : p.Prime) (hm : 2 ≤ m) : 4 ≤ p ^ m

theorem s_eq_zero_of_le_log_four {v : ℝ} (hv : v ≤ Real.log 4) : s v = 0

theorem s_pos_of_log_four_lt {v : ℝ} (hv : Real.log 4 < v) : 0 < s v

theorem s_pos_iff (v : ℝ) : 0 < s v ↔ Real.log 4 < v

theorem H_strictMonoOn_cell {k : ℕ} (hk : 1 ≤ k) :
    StrictMonoOn H (Set.Icc (k : ℝ) ((k : ℝ) + 1))
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Prime-power support intervals and delay differential equations in number theory (Wheeler 1974, Hildebrand 1986). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Proves the sharp activation criterion $s(v) > 0 \iff v > \log 4$ and cell strict monotonicity in Lean 4.
- **Target Venues:** *Acta Arithmetica* or *Journal of Mathematical Analysis and Applications*.
