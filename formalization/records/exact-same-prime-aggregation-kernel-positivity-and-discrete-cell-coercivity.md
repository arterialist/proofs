# Contribution 175: Exact Same-Prime Aggregation Kernel Positivity and Discrete Cell Coercivity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SamePrimeAggregationKernel.lean`](../../formalization/BuildingBlocks/SamePrimeAggregationKernel.lean), [`building-blocks/primes/same-prime-aggregation-kernel.md`](../../building-blocks/primes/same-prime-aggregation-kernel.md)  
**Classification:** Analytic Number Theory / Renewal Theory / Kernel Positivity / Discrete Cell Geometry / Square Root Sums / Coercivity

---

## 1. Executive Summary and Mathematical Statement

In the pair correlation of prime powers and same-prime birth renewal dynamics, the aggregation kernel balances root sums $B(k) = \sum_{j=1}^k \sqrt{j}$ against reciprocal root sums $A(k) = \sum_{j=1}^k \frac{1}{\sqrt{j}}$. Establishing strict positivity throughout the continuum cell $x \in [k, k+1]$ ensures that same-prime memory feedback cannot produce negative destabilizing cancelation.

This contribution proves:

1. **Exact Next-Integer Kernel Increment Formula:**  
   For $F(k) = 3 B(k) - (k+1) A(k)$, the discrete increment is given by:
   $$
   F(k+1) - F(k) = \frac{2k+1}{\sqrt{k+1}} - A(k).
   $$
2. **Adjacent Root Square Coercivity:**  
   From the non-negativity of $(\sqrt{k+1} - \sqrt{k})^2 \ge 0$:
   $$
   2\sqrt{k} \le \frac{2k+1}{\sqrt{k+1}}.
   $$
3. **Uniform Increment Coercivity:**  
   Using the telescoping bound $A(k) \le 2\sqrt{k} - 1$, every discrete coefficient increment satisfies:
   $$
   F(k+1) - F(k) \ge 1 \quad (\forall k \ge 1).
   $$
4. **Exact Discrete Growth Lower Bound:**  
   With the initial base evaluation $F(1) = 1$, induction yields:
   $$
   F(k) \ge k \quad (\forall k \ge 1).
   $$
5. **Continuum Cell Positivity and Coercivity:**  
   For any integer $k \ge 1$ and every real point $x \in [k, k+1]$:
   $$
   3 B(k) - x A(k) \ge F(k) \ge k > 0.
   $$
   The same-prime aggregation kernel remains strictly positive and bounded below by $k$ throughout the entirety of the closed real cell $[k, k+1]$.

---

## 2. Mathematical Proof

### 2.1. Discrete Increment Algebraic Identity
Since $B(k+1) = B(k) + \sqrt{k+1}$ and $A(k+1) = A(k) + \frac{1}{\sqrt{k+1}}$:
$$
F(k+1) = 3(B(k) + \sqrt{k+1}) - (k+2)(A(k) + \frac{1}{\sqrt{k+1}})
$$
$$
= (3 B(k) - (k+1) A(k)) + 3\sqrt{k+1} - A(k) - \frac{k+2}{\sqrt{k+1}}
$$
$$
= F(k) - A(k) + \frac{3(k+1) - (k+2)}{\sqrt{k+1}} = F(k) - A(k) + \frac{2k+1}{\sqrt{k+1}}.
$$

### 2.2. Quotient Lower Bound
Expanding $(\sqrt{k+1} - \sqrt{k})^2 = (k+1) - 2\sqrt{k(k+1)} + k \ge 0$:
$$
2k+1 \ge 2\sqrt{k}\sqrt{k+1} \implies \frac{2k+1}{\sqrt{k+1}} \ge 2\sqrt{k}.
$$

### 2.3. Increment Lower Bound
Combining the quotient bound with $A(k) \le 2\sqrt{k} - 1$:
$$
F(k+1) - F(k) = \frac{2k+1}{\sqrt{k+1}} - A(k) \ge 2\sqrt{k} - (2\sqrt{k} - 1) = 1.
$$

### 2.4. Induction and Continuum Extension
Since $A(1) = 1$ and $B(1) = 1$, $F(1) = 3(1) - 2(1) = 1$.
Since $F(k+1) \ge F(k) + 1$, induction yields $F(k) \ge k$.
For any $x \in [k, k+1]$, $x \le k+1$. Since $A(k) \ge 0$:
$$
-x A(k) \ge -(k+1) A(k) \implies 3 B(k) - x A(k) \ge 3 B(k) - (k+1) A(k) = F(k) \ge k > 0.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.SamePrimeAggregationKernel` in `formalization/BuildingBlocks/SamePrimeAggregationKernel.lean`):
```lean
theorem F_succ_sub (k : ℕ) :
    F (k + 1) - F k = (2 * (k : ℝ) + 1) / Real.sqrt (k + 1) - A k

theorem quotient_ge (k : ℕ) :
    2 * Real.sqrt k ≤ (2 * (k : ℝ) + 1) / Real.sqrt (k + 1)

theorem F_succ_sub_ge_one {k : ℕ} (hk : 1 ≤ k) :
    1 ≤ F (k + 1) - F k

theorem F_ge {k : ℕ} (hk : 1 ≤ k) : (k : ℝ) ≤ F k

theorem cell_kernel_ge {k : ℕ} (hk : 1 ≤ k) {x : ℝ}
    (hx : x ∈ Set.Icc (k : ℝ) ((k : ℝ) + 1)) :
    (k : ℝ) ≤ 3 * B k - x * A k

theorem cell_kernel_pos {k : ℕ} (hk : 1 ≤ k) {x : ℝ}
    (hx : x ∈ Set.Icc (k : ℝ) ((k : ℝ) + 1)) :
    0 < 3 * B k - x * A k
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Discrete renewal kernels and monotonicity of power sum ratios (Feller 1968, Askey 1975). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the exact identity $F(k+1) - F(k) = \frac{2k+1}{\sqrt{k+1}} - A(k)$ and proves cell coercivity $3 B(k) - x A(k) \ge k > 0$ on $[k, k+1]$ in Lean 4.
- **Target Venues:** *Integral Equations and Operator Theory* or *Journal of Mathematical Analysis and Applications*.
