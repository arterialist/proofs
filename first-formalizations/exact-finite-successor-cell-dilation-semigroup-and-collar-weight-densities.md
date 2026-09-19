# First Formalization: Exact Finite Successor-Cell Dilation Semigroup and Collar Weight Densities

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SuccessorCellTransferFinite.lean`](../../formalization/BuildingBlocks/SuccessorCellTransferFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Quot.sound]` (algebraic core) and `[propext, Classical.choice, Quot.sound]` (analytic carry and measure); zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact finite multiplicative semigroup law for left dilation transfer operators, uniform logarithmic carry bounds, phase perturbation bounds, and exact triangular dyadic collar overlap weights in Lean 4:

1. **Finite Cutoff Semigroup Composition:**
   Formal proof of `transfer_mul`: $\text{transfer}(N, a, \text{transfer}(N, b, z)) = \text{transfer}(N, ab, z)$, constructive without `Classical.choice`.
2. **Integer Dilation Interval Partition:**
   Formal proof of `div_eq_iff_child`: Exact characterization of the child fiber $d \cdot n \le r < d(n+1)$.
3. **Logarithmic Telescoping Measure:**
   Formal proof of `sum_log_cell_length`: $\sum_{r=a}^{b-1} \log((r+1)/r) = \log(b/a)$.
4. **Uniform Logarithmic Carry Bound:**
   Formal proof of `log_successor_carry_bound`: $0 \le \log((dn+j)/(dn)) < 1/n$, independent of $d$.
5. **Phase Perturbation Across Carries:**
   Formal proof of `norm_exp_successor_carry_le`: $\|e^{i t \log((dn+j)/(dn))} - 1\| \le |t|/n$.
6. **Exact Triangular Collar Weights:**
   Formal proof of `collarWeight_lower_band`, `collarWeight_upper_band`, and `collarWeight_zero_outside`: Closed-form evaluation of logarithmic overlap measures.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Finite semigroup composition law (constructive)
theorem transfer_mul {R : Type*} [Zero R]
    (N a b : ℕ) (z : ℕ → R) :
    transfer N a (transfer N b z) = transfer N (a * b) z

-- Dilation fiber partition (constructive)
theorem div_eq_iff_child {d n r : ℕ} (hd : 0 < d) :
    r / d = n ↔ d * n ≤ r ∧ r < d * (n + 1)

-- Logarithmic telescoping sum
theorem sum_log_cell_length (a b : ℕ) (ha : 0 < a) (hab : a ≤ b) :
    (∑ r ∈ Finset.Ico a b,
      Real.log (((r + 1 : ℕ) : ℝ) / (r : ℝ))) =
      Real.log ((b : ℝ) / (a : ℝ))

-- Uniform carry bound
theorem log_successor_carry_bound (d n j : ℕ) (hd : 0 < d)
    (hn : 0 < n) (hj : j < d) :
    0 ≤ Real.log (((d * n + j : ℕ) : ℝ) / ((d * n : ℕ) : ℝ)) ∧
      Real.log (((d * n + j : ℕ) : ℝ) / ((d * n : ℕ) : ℝ)) <
        (1 : ℝ) / (n : ℝ)

-- Phase perturbation bound
theorem norm_exp_successor_carry_le (t : ℝ) (d n j : ℕ)
    (hd : 0 < d) (hn : 0 < n) (hj : j < d) :
    ‖Complex.exp
        (((t * Real.log (((d * n + j : ℕ) : ℝ) /
            ((d * n : ℕ) : ℝ)) : ℝ) : ℂ) * Complex.I) - 1‖ ≤
      |t| / (n : ℝ)

-- Exact triangular collar overlap formulas
theorem collarWeight_lower_band (m d : ℕ) (hm : 0 < m)
    (hdm : d < m) (hmd : m < 2 * d) :
    collarWeight m d = Real.log (((2 * d : ℕ) : ℝ) / (m : ℝ))

theorem collarWeight_upper_band (m d : ℕ) (hd : 0 < d)
    (hmd : m ≤ d) (hdm : d < 2 * m) :
    collarWeight m d = Real.log (((2 * m : ℕ) : ℝ) / (d : ℝ))

theorem collarWeight_zero_outside (m d : ℕ)
    (h : 2 * d ≤ m ∨ 2 * m ≤ d) : collarWeight m d = 0
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on foundational axioms:
- Constructive algebraic core: `[propext, Quot.sound]`
- Analytic carry and measure: `[propext, Classical.choice, Quot.sound]`
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 establishing the discrete semigroup property for truncated dilation transfer operators, the uniform $1/n$ carry bound, and the exact piecewise-logarithmic triangular overlap density for opposite dyadic collars.
