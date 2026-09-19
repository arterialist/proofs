# First Formalization in Lean 4: Logarithmic-Mean Renewal Cell Increment Factorization and Positivity

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 File:** [`formalization/BuildingBlocks/CausalRenewalFiniteCells.lean`](../../formalization/BuildingBlocks/CausalRenewalFiniteCells.lean)  
**Dependencies:** `BuildingBlocks.PrimeStateAndRenewalArch`, `Mathlib.Tactic`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

In the Euler-discrepancy cell decomposition for causal prime renewal operators, continuous scale-space is partitioned into elementary cells $[a, b]$ with square-root endpoints $a = \sqrt{n}$, $b = \sqrt{n+1}$. On each cell, the integral increment of the renewal operator against an arithmetic level $A$ takes the raw form:
\[
\operatorname{rawCellIncrement}(A, a, b) := 2(\log b - \log a)A - 4(b - a).
\]
By introducing the **logarithmic mean**:
\[
L(a, b) := \frac{b - a}{\log b - \log a},
\]
the increment factors identically into:
\[
\operatorname{cellIncrement}(A, a, b) = 2(\log b - \log a)(A - 2L(a, b)).
\]
The positivity of this cell increment is the local engine driving global contractivity and monotonicity of the causal renewal operator. The proof reduces to showing that $2L(a, b) < A$.

Under the signed Euler remainder bound $A = 2a + \frac{1}{2a} - \frac{1}{24a^3} + r$ ($r > 0$) and the logarithmic-mean bound $2L(a, b) < 2a + \frac{1}{2a} - \frac{1}{8b^3}$, positivity requires the elementary cubic denominator comparison $\frac{1}{24a^3} < \frac{1}{8b^3}$, or equivalently $b^3 < 3a^3$.

This Lean 4 formalization machine-checks:
1. The exact algebraic factorization of the cell increment into the logarithmic mean.
2. The cubic ratio gap on natural square-root cells: $\sqrt{n+1}^3 < 3\sqrt{n}^3$ for all $n \ge 1$.
3. The strict positivity of the renewal cell increment under Euler remainder bounds.
4. The finite centered-delay cancellation identity $\sum q_i f(v) + \sum q_i (f(v - d_i) - f(v)) = \sum q_i f(v - d_i)$.

---

## 2. Machine-Verified Theorems

### 2.1 Logarithmic Mean Factorization

```lean
noncomputable def logarithmicMean (a b : ℝ) : ℝ :=
  (b - a) / (Real.log b - Real.log a)

noncomputable def rawCellIncrement (A a b : ℝ) : ℝ :=
  2 * (Real.log b - Real.log a) * A - 4 * (b - a)

noncomputable def cellIncrement (A a b : ℝ) : ℝ :=
  2 * (Real.log b - Real.log a) * (A - 2 * logarithmicMean a b)

theorem rawCellIncrement_eq_cellIncrement {A a b : ℝ}
    (hlog : Real.log b ≠ Real.log a) :
    rawCellIncrement A a b = cellIncrement A a b

theorem cellIncrement_pos {A a b : ℝ} (ha : 0 < a) (hab : a < b)
    (hmean : 2 * logarithmicMean a b < A) :
    0 < cellIncrement A a b
```

### 2.2 Cubic Denominator and Square-Root Cell Bounds

```lean
theorem reciprocal_cube_gap {a b : ℝ} (ha : 0 < a) (hb : 0 < b)
    (hcube : b ^ 3 < 3 * a ^ 3) :
    1 / (24 * a ^ 3) < 1 / (8 * b ^ 3)

theorem sqrt_succ_cube_lt_three {n : ℕ} (hn : 1 ≤ n) :
    Real.sqrt (n + 1 : ℝ) ^ 3 < 3 * Real.sqrt (n : ℝ) ^ 3

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

### 2.3 Local Damping Centered-Delay Cancellation

```lean
theorem finite_local_centered_delay_identity
    {ι : Type*} [DecidableEq ι] (s : Finset ι)
    (q delay : ι → ℝ) (f : ℝ → ℝ) (v : ℝ) :
    (∑ i ∈ s, q i) * f v +
        ∑ i ∈ s, q i * (f (v - delay i) - f v) =
      ∑ i ∈ s, q i * f (v - delay i)
```

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/CausalRenewalFiniteCells.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.CausalRenewalFiniteCells.rawCellIncrement_eq_cellIncrement' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CausalRenewalFiniteCells.cellIncrement_eq_sourceCellIncrement' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CausalRenewalFiniteCells.log_sub_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CausalRenewalFiniteCells.cellIncrement_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CausalRenewalFiniteCells.reciprocal_cube_gap' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CausalRenewalFiniteCells.sqrt_nat_lt_sqrt_succ' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CausalRenewalFiniteCells.sqrt_succ_cube_lt_three' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CausalRenewalFiniteCells.cellIncrement_pos_of_euler_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CausalRenewalFiniteCells.sqrt_cellIncrement_pos_of_euler_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CausalRenewalFiniteCells.finite_local_centered_delay_identity' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CausalRenewalFiniteCells.finite_delay_energy_lower' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All theorems depend strictly on standard foundationals with zero custom axioms and zero `sorry`.
