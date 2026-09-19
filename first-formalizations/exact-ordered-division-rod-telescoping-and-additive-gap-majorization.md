# First Formalization: Exact Ordered Division Rod Telescoping and Additive Gap Majorization

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/DivisionRod.lean`](../../formalization/BuildingBlocks/DivisionRod.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact multiplicative telescoping bound, additive gap majorization, and strict separation gap bounds for ordered proper division rods in Lean 4:

1. **Division Rod Structure and Basic Properties:**
   Formal proof of `DivisionRod.ratio_mul_left`, `DivisionRod.two_mul_left_le` ($2L \le R$), `DivisionRod.right_le_two_mul_gap` ($R \le 2(R-L)$), `DivisionRod.left_mul_ratio_sub_one`, and `DivisionRod.two_le_ratio` ($q \ge 2$).
2. **Multiplicative Telescoping Bound:**
   Formal proof of `ordered_prefix_product_le_last` ($\prod_{i=0}^n q_i \le R_n$) and `ordered_division_product_le` ($\prod q_i \le N$).
3. **Additive Gap Majorization:**
   Formal proof of `prefix_product_le_next_left` and `ordered_product_le_one_add_total_gap`:
   \[
   \prod_{i < k} \frac{R_i}{L_i} \le 1 + \sum_{i < k} (R_i - L_i).
   \]
4. **Strict Gap Majorization for Multiple Rods ($k \ge 2$):**
   Formal proof of `ordered_product_lt_one_add_total_gap`: strict inequality when $k \ge 2$.
5. **Finite Endpoint Interface and Sharpness:**
   Formal proof of `endpoint_product_bounds`, `endpoint_product_le`, and `DivisionRod.singleton_gap_equality`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Multiplicative product bounded by upper threshold N
theorem ordered_division_product_le
    (rods : ℕ → DivisionRod) (length N : ℕ) (hN : 1 ≤ N)
    (hsep : ∀ i, i + 1 < length → (rods i).right < (rods (i + 1)).left)
    (hbound : ∀ i < length, (rods i).right ≤ N) :
    (∏ i ∈ Finset.range length, (rods i).right / (rods i).left) ≤ N

-- Additive gap majorization
theorem ordered_product_le_one_add_total_gap
    (rods : ℕ → DivisionRod) (length : ℕ)
    (hsep : ∀ i, i + 1 < length → (rods i).right < (rods (i + 1)).left) :
    (∏ i ∈ Finset.range length, (rods i).ratio) ≤
      1 + ∑ i ∈ Finset.range length, ((rods i).right - (rods i).left)

-- Strict inequality for length >= 2
theorem ordered_product_lt_one_add_total_gap
    (rods : ℕ → DivisionRod) (length : ℕ) (hlen : 2 ≤ length)
    (hsep : ∀ i, i + 1 < length → (rods i).right < (rods (i + 1)).left) :
    (∏ i ∈ Finset.range length, (rods i).ratio) <
      1 + ∑ i ∈ Finset.range length, ((rods i).right - (rods i).left)

-- Joint endpoint bounds
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

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the discrete multiplicative telescoping bounds and strict additive gap majorization for chains of separated proper division rods.
