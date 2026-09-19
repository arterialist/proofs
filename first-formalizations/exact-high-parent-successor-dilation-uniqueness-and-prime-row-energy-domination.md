# First Formalization: Exact High-Parent Successor Dilation Uniqueness and Prime Row Energy Domination

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SuccessorHighParentPrimeRow.lean`](../../formalization/BuildingBlocks/SuccessorHighParentPrimeRow.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact uniqueness of integer dilations above the square-root scale $r < n^2$, the complete elimination of cross-terms in high-parent prime row energy, and the reciprocal-square tail domination of normalized row energy in Lean 4:

1. **Cell Length Estimates:**
   Formal definitions of `cellLength`, with proofs `cellLength_upper`, `cellLength_lower`, `cellLength_pos`, and `cellLength_ratio_le`.
2. **Dilation Uniqueness Above Square-Root Scale:**
   Formal proof of `high_parent_child_dilation_unique`, definition of `highParentChildren`, and proof of `highParentChildren_card_le_one`.
3. **Cross-Term Elimination:**
   Formal proof of `highParent_vonMangoldt_sum_sq`.
4. **Energy Estimates and Normalization:**
   Formal proofs of `highParent_cell_ratio_le`, `highParent_vonMangoldt_cell_term_le`, `highParent_child_sum_le`, and `highParent_vonMangoldt_normalized_row_energy_le`.
5. **Unnormalized Energy Bound:**
   Formal proof of `highParent_vonMangoldt_row_energy_le`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact dilation uniqueness above square-root scale
theorem high_parent_child_dilation_unique
    {r n d e : ℕ} (hrn : r < n * n)
    (hdlo : d * n ≤ r) (hdhi : r < d * (n + 1))
    (helo : e * n ≤ r) (hehi : r < e * (n + 1)) :
    d = e

-- Cardinality of active dilation set is at most one
theorem highParentChildren_card_le_one
    {r n D : ℕ} (hrn : r < n * n) :
    (highParentChildren r n D).card ≤ 1

-- Complete elimination of cross terms in high parent prime power sums
theorem highParent_vonMangoldt_sum_sq
    {r n D : ℕ} (hrn : r < n * n) :
    (∑ d ∈ highParentChildren r n D,
        ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2 =
      ∑ d ∈ highParentChildren r n D,
        (ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2

-- Exact normalized row energy bound by reciprocal square tail
theorem highParent_vonMangoldt_normalized_row_energy_le (r D : ℕ) :
    (∑ n ∈ (Finset.Icc 1 r).filter (fun n => r < n * n),
      (Real.sqrt (cellLength r / cellLength n) *
        ∑ d ∈ highParentChildren r n D,
          ArithmeticFunction.vonMangoldt d / Real.sqrt d) ^ 2) ≤
      2 * ∑ d ∈ Finset.Ioc D r,
        (ArithmeticFunction.vonMangoldt d / (d : ℝ)) ^ 2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 establishing dilation uniqueness above the square-root parent scale, eliminating off-diagonal interference in operator row sums and bounding normalized high-parent prime energy by reciprocal-square tails.
