# Unique Contribution 302: Exact Ordered Division Rod Telescoping and Additive Gap Majorization

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/DivisionRod.lean`](../../formalization/BuildingBlocks/DivisionRod.lean), [`building-blocks/renewal-rod/division-rod.md`](../../building-blocks/renewal-rod/division-rod.md)  
**Classification:** Combinatorial Number Theory / Multiplicative Telescoping / Division Chains / Additive Gap Bounds / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the non-perturbative analysis of renewal processes with divisor transitions, chains of transitions are geometrically represented by disjoint "division rods" $[L_i, R_i]$, where each left endpoint divides the right endpoint ($L_i \mid R_i$) and the rods are strictly separated ($R_i < L_{i+1}$). A central problem in bounding amplification along renewal cascades is controlling the product of ratios $\prod (R_i / L_i)$.

This contribution proves:

1. **Exact Multiplicative Telescoping Bound:**  
   For any sequence of strictly separated proper division rods $(L_i, R_i)_{i=0}^{k-1}$ with $R_i \le N$ and $1 \le N$:
   \[
   \prod_{i=0}^{k-1} \frac{R_i}{L_i} \le N.
   \]
   The multiplicative product of exact integer ratios cannot exceed the global right endpoint bound $N$.
2. **Exact Additive Gap Majorization:**  
   The multiplicative product is majorized by one plus the total sum of rod gaps:
   \[
   \prod_{i=0}^{k-1} \frac{R_i}{L_i} \le 1 + \sum_{i=0}^{k-1} (R_i - L_i).
   \]
3. **Strict Separation Strictness for Multiple Rods ($k \ge 2$):**  
   Whenever $k \ge 2$, strict separation $R_i < L_{i+1}$ forces the additive gap inequality to be strictly sharp:
   \[
   \prod_{i=0}^{k-1} \frac{R_i}{L_i} < 1 + \sum_{i=0}^{k-1} (R_i - L_i).
   \]
4. **Proper Divisibility Gap Coverage:**  
   Every proper rod satisfies $2 L_i \le R_i$, which implies:
   \[
   R_i \le 2(R_i - L_i).
   \]
   The right endpoint is bounded by twice the gap width.
5. **Sharpness Classification:**  
   Equality in the additive gap bound $\prod (R_i/L_i) = 1 + \sum (R_i - L_i)$ holds if and only if $k = 1$ and $L_0 = 1$.

---

## 2. Mathematical Proof

### 2.1. Multiplicative Prefix Telescoping
By induction on $n$, for any sequence where $R_i < L_{i+1}$:
- Base case $n = 0$: $\frac{R_0}{L_0} \le R_0$ since $L_0 \ge 1$.
- Inductive step: Assume $\prod_{i=0}^{n-1} (R_i/L_i) \le R_{n-1}$.
  By separation, $R_{n-1} < L_n$, so $\prod_{i=0}^{n-1} (R_i/L_i) \le L_n$.
  Multiplying by $R_n/L_n$:
  \[
  \left(\prod_{i=0}^{n-1} \frac{R_i}{L_i}\right) \frac{R_n}{L_n} \le L_n \cdot \frac{R_n}{L_n} = R_n.
  \]
  Thus $\prod_{i=0}^{k-1} (R_i/L_i) \le R_{k-1} \le N$.

### 2.2. Additive Gap Induction
Let $P_n = \prod_{i=0}^{n-1} q_i$, where $q_i = R_i / L_i \ge 2$.
Write $q_n = 1 + (q_n - 1)$.
Then:
\[
P_{n+1} = P_n q_n = P_n + P_n (q_n - 1).
\]
By induction, $P_n \le 1 + \sum_{i=0}^{n-1} (R_i - L_i)$.
Furthermore, $P_n \le L_n$. Since $L_n (q_n - 1) = L_n (R_n/L_n - 1) = R_n - L_n$, we obtain:
\[
P_{n+1} \le \left( 1 + \sum_{i=0}^{n-1} (R_i - L_i) \right) + L_n (q_n - 1) = 1 + \sum_{i=0}^n (R_i - L_i).
\]
When $k \ge 2$, $P_{n} < L_n$ strictly by separation, and $q_n - 1 \ge 1 > 0$, making the inequality strictly sharp.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.RenewalRod` in `formalization/BuildingBlocks/DivisionRod.lean`):
```lean
theorem ordered_division_product_le
    (rods : ℕ → DivisionRod) (length N : ℕ) (hN : 1 ≤ N)
    (hsep : ∀ i, i + 1 < length → (rods i).right < (rods (i + 1)).left)
    (hbound : ∀ i < length, (rods i).right ≤ N) :
    (∏ i ∈ Finset.range length, (rods i).right / (rods i).left) ≤ N

theorem ordered_product_le_one_add_total_gap
    (rods : ℕ → DivisionRod) (length : ℕ)
    (hsep : ∀ i, i + 1 < length → (rods i).right < (rods (i + 1)).left) :
    (∏ i ∈ Finset.range length, (rods i).ratio) ≤
      1 + ∑ i ∈ Finset.range length, ((rods i).right - (rods i).left)

theorem ordered_product_lt_one_add_total_gap
    (rods : ℕ → DivisionRod) (length : ℕ) (hlen : 2 ≤ length)
    (hsep : ∀ i, i + 1 < length → (rods i).right < (rods (i + 1)).left) :
    (∏ i ∈ Finset.range length, (rods i).ratio) <
      1 + ∑ i ∈ Finset.range length, ((rods i).right - (rods i).left)

theorem endpoint_product_bounds
    (left right : ℕ → ℕ) (length N : ℕ) (hN : 1 ≤ N)
    (hpos : ∀ i < length, 0 < left i)
    (hproper : ∀ i < length, left i < right i)
    (hdiv : ∀ i < length, left i ∣ right i)
    (hsep : ∀ i, i + 1 < length → right i < left (i + 1))
    (hbound : ∀ i < length, right i ≤ N) :
    (∏ i ∈ Finset.range length, right i / left i) ≤ N ∧
    (∏ i ∈ Finset.range length, right i / left i) ≤
      1 + ∑ i ∈ Finset.range length, (right i - left i)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Multiplicative number theory and division graphs (Erdős 1938); divisor chains and Dilworth's theorem (Anderson 1967). Machine verification of discrete multiplicative telescoping bounds and strict additive gap majorization for separated proper division rods in Lean 4 is new.
- **Advancement:** Provides an exact non-asymptotic combinatorial barrier bounding multiplicative amplification across disjoint divisor intervals by the linear additive gap sum.
- **Target Venues:** *Discrete Mathematics* or *The Electronic Journal of Combinatorics*.
