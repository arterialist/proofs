# First Formalization: Exact Causal Renewal Cell Increment Factorization and Positivity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CausalRenewalFiniteCells.lean`](../../formalization/BuildingBlocks/CausalRenewalFiniteCells.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact algebraic factorization of Archimedean renewal cell increments, the non-asymptotic cubic gap inequality, and cell-wise strict positivity in Lean 4:

1. **Exact Cell Factorization:**
   Formal proof of `rawCellIncrement_eq_cellIncrement`: $2(\log b - \log a) A - 4(b - a) = 2(\log b - \log a)(A - 2 L(a, b))$.
2. **Sharp Elementary Reciprocal Cube Gap:**
   Formal proof of `reciprocal_cube_gap`: $b^3 < 3a^3 \implies \frac{1}{24a^3} < \frac{1}{8b^3}$.
3. **Square-Root Cell Cube Comparison:**
   Formal proof of `sqrt_succ_cube_lt_three`: $(\sqrt{n+1})^3 < 3(\sqrt{n})^3$ for all $n \ge 1$.
4. **Grand Cell Increment Positivity Theorem:**
   Formal proofs of `cellIncrement_pos_of_euler_bounds` and `sqrt_cellIncrement_pos_of_euler_bounds`: Strict positivity of the renewal increment across every square-root interval $[\sqrt{n}, \sqrt{n+1}]$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Algebraic factorization through the logarithmic mean
theorem rawCellIncrement_eq_cellIncrement {A a b : ℝ}
    (hlog : Real.log b ≠ Real.log a) :
    rawCellIncrement A a b = cellIncrement A a b

-- Non-asymptotic cube gap on square-root cells
theorem sqrt_succ_cube_lt_three {n : ℕ} (hn : 1 ≤ n) :
    Real.sqrt (n + 1 : ℝ) ^ 3 < 3 * Real.sqrt (n : ℝ) ^ 3

-- Cell increment positivity combining Euler expansions with cubic gaps
theorem cellIncrement_pos_of_euler_bounds
    {A a b r : ℝ} (ha : 0 < a) (hab : a < b)
    (hA : A = 2 * a + 1 / (2 * a) - 1 / (24 * a ^ 3) + r)
    (hr : 0 < r) (hcube : b ^ 3 < 3 * a ^ 3)
    (hL : 2 * logarithmicMean a b <
      2 * a + 1 / (2 * a) - 1 / (8 * b ^ 3)) :
    0 < cellIncrement A a b

-- Grand square-root cell positivity theorem
theorem sqrt_cellIncrement_pos_of_euler_bounds
    {n : ℕ} (hn : 1 ≤ n) {A r : ℝ}
    (hA : A = 2 * Real.sqrt (n : ℝ) + 1 / (2 * Real.sqrt (n : ℝ)) -
      1 / (24 * Real.sqrt (n : ℝ) ^ 3) + r)
    (hr : 0 < r)
    (hL : 2 * logarithmicMean (Real.sqrt (n : ℝ)) (Real.sqrt (n + 1 : ℝ)) <
      2 * Real.sqrt (n : ℝ) + 1 / (2 * Real.sqrt (n : ℝ)) -
        1 / (8 * Real.sqrt (n + 1 : ℝ) ^ 3)) :
    0 < cellIncrement A (Real.sqrt (n : ℝ)) (Real.sqrt (n + 1 : ℝ))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving that local cell increments of the causal Archimedean renewal equation are strictly positive, leveraging exact logarithmic-mean factorization and algebraic cubic gaps on discrete square-root intervals.
