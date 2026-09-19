# First Formalization: Exact Same-Prime Aggregation Kernel Positivity and Discrete Cell Coercivity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SamePrimeAggregationKernel.lean`](../../formalization/BuildingBlocks/SamePrimeAggregationKernel.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the discrete increment formula for the same-prime aggregation kernel, the quotient lower bound from root differences, the increment coercivity $\Delta F(k) \ge 1$, the discrete growth bound $F(k) \ge k$, and the continuum cell positivity on $[k, k+1]$ in Lean 4:

1. **Kernel Increment Formula:**
   Formal proof that $F(k+1) - F(k) = \frac{2k+1}{\sqrt{k+1}} - A(k)$ (`F_succ_sub`).
2. **Adjacent Root Coercivity:**
   Formal proof that $2\sqrt{k} \le \frac{2k+1}{\sqrt{k+1}}$ (`quotient_ge`).
3. **Discrete Increment Coercivity:**
   Formal proof that $F(k+1) - F(k) \ge 1$ for all $k \ge 1$ (`F_succ_sub_ge_one`).
4. **Discrete Growth Lower Bound:**
   Formal proof by induction that $F(k) \ge k$ for all $k \ge 1$ (`F_ge`).
5. **Continuum Cell Positivity:**
   Formal proof that $3 B(k) - x A(k) \ge k > 0$ for all $x \in [k, k+1]$ (`cell_kernel_ge`, `cell_kernel_pos`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Kernel increment algebraic identity
theorem F_succ_sub (k : ℕ) :
    F (k + 1) - F k = (2 * (k : ℝ) + 1) / Real.sqrt (k + 1) - A k

-- Adjacent root coercivity
theorem quotient_ge (k : ℕ) :
    2 * Real.sqrt k ≤ (2 * (k : ℝ) + 1) / Real.sqrt (k + 1)

-- Increment coercivity
theorem F_succ_sub_ge_one {k : ℕ} (hk : 1 ≤ k) :
    1 ≤ F (k + 1) - F k

-- Discrete growth lower bound
theorem F_ge {k : ℕ} (hk : 1 ≤ k) : (k : ℝ) ≤ F k

-- Continuum cell coercivity and strict positivity
theorem cell_kernel_ge {k : ℕ} (hk : 1 ≤ k) {x : ℝ}
    (hx : x ∈ Set.Icc (k : ℝ) ((k : ℝ) + 1)) :
    (k : ℝ) ≤ 3 * B k - x * A k

theorem cell_kernel_pos {k : ℕ} (hk : 1 ≤ k) {x : ℝ}
    (hx : x ∈ Set.Icc (k : ℝ) ((k : ℝ) + 1)) :
    0 < 3 * B k - x * A k
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving continuum cell positivity and coercivity $3 B(k) - x A(k) \ge k > 0$ for same-prime renewal kernels.
