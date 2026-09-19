# First Formalization: Exact Factorial Floor-Derivative Obstruction and N=13 Mertens Counterexample

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/FactorialFloorDerivativeObstruction.lean`](../../formalization/BuildingBlocks/FactorialFloorDerivativeObstruction.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact integer certificate for the $N=13$ floor-derivative energy contraction failure and certifies the algebraic identities of the first-cell Mertens trace in Lean 4:

1. **Grouped Coefficients and Floor Rows:**
   Formal definition of `coeff13` and `floorRow13`, with proofs `floorRow13_eq_one`, `coeff13_sum`, and `coeff13_firstMoment`.
2. **Discrete Derivative Distribution:**
   Formal proof of interior vanishing `floorRow13_difference_interior` and terminal concentration `floorRow13_difference_terminal`.
3. **Exact Certificate Arithmetic:**
   Formal definition of `certificateNumerator` ($5^{35} \cdot 13^{104}$) and `certificateDenominator` ($2^{61} \cdot 3^{25} \cdot 7^{28} \cdot 11 \cdot 17^{30} \cdot 19^{36}$), with proofs `certificateDenominator_lt_numerator` and `certificate_log_ratio_pos`.
4. **First-Cell Algebra:**
   Formal proofs of `firstCell_sum_sub_one` and `firstCell_length_normalization`.
5. **2D Telescoping Identity:**
   Formal proof of `rectangle_double_telescope`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact integer certificate of floor derivative energy contraction failure
theorem certificateDenominator_lt_numerator :
    certificateDenominator < certificateNumerator

-- Strictly positive logarithmic energy surplus
theorem certificate_log_ratio_pos :
    0 < Real.log ((certificateNumerator : ℝ) / certificateDenominator)

-- Constant floor row values at cutoff 13
theorem floorRow13_eq_one {k : ℕ} (hk1 : 1 ≤ k) (hk13 : k ≤ 13) :
    floorRow13 k = 1

-- Interior vanishing of discrete derivatives
theorem floorRow13_difference_interior {k : ℕ} (hk1 : 1 ≤ k) (hk13 : k < 13) :
    floorRow13 k - floorRow13 (k + 1) = 0

-- Terminal edge derivative concentration
theorem floorRow13_difference_terminal :
    floorRow13 13 - floorRow13 14 = 1

-- 2D boundary telescope identity
theorem rectangle_double_telescope (F : ℕ → ℕ → ℤ) (N : ℕ) :
    (∑ k ∈ Finset.range N, ∑ l ∈ Finset.range N,
      (F k l - F (k + 1) l - F k (l + 1) + F (k + 1) (l + 1))) =
      F 0 0 - F N 0 - F 0 N + F N N
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 establishing the $N=13$ grouped Möbius floor-derivative obstruction and certifying the exact positive logarithmic surplus of factorial energy via multiprecision integer arithmetic.
