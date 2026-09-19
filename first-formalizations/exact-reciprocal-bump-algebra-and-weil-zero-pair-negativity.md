# First Formalization: Exact Reciprocal Bump Algebra and Weil Zero-Pair Negativity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualWeilZeroPairAlgebra.lean`](../../formalization/BuildingBlocks/ActualWeilZeroPairAlgebra.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact algebraic collapse of reciprocal bump convolution factors, the reflected conjugate order swap, the paired real part identity, and the sharp linear negativity upper bound in Lean 4:

1. **Reciprocal Bump Factor Identity:**
   Formal proof of $(1 - z)(1 - z^{-1}) = 2 - z - z^{-1}$ (`reciprocal_bump_factor`).
2. **Conjugation Reflection:**
   Formal proof of $W^* (1 - (\bar{z})^{-1})(1 - \bar{z}) = \overline{W(1-z)(1-z^{-1})}$ (`reflected_bump_factor`).
3. **Paired Real Part:**
   Formal proof that the combined real contribution equals $2 \operatorname{Re}(W(2 - z - z^{-1}))$ (`paired_bump_factor`).
4. **Linear Asymptotic Negativity Bound:**
   Formal proof that $2 \operatorname{Re}(W(2 - u r - \bar{u}/r)) \le 4 M + 2 M/r - 2 b r$ (`central_pair_upper`), and with $M = \|W\|$ for unimodular phase (`central_pair_upper_norm`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Reciprocal bump algebraic expansion
theorem reciprocal_bump_factor (z : ℂ) (hz : z ≠ 0) :
    (1 - z) * (1 - z⁻¹) = 2 - z - z⁻¹

-- Star involution and swap
theorem reflected_bump_factor (W z : ℂ) :
    (star W) * ((1 - (star z)⁻¹) * (1 - star z)) =
      star (W * ((1 - z) * (1 - z⁻¹)))

-- Paired zero-side real part identity
theorem paired_bump_factor (W z : ℂ) (hz : z ≠ 0) :
    (W * ((1 - z) * (1 - z⁻¹))).re +
      ((star W) * ((1 - (star z)⁻¹) * (1 - star z))).re =
      2 * (W * (2 - z - z⁻¹)).re

-- Linear negativity upper bound
theorem central_pair_upper (W u : ℂ) (r b M : ℝ)
    (hr : 0 < r) (hmain : b ≤ (W * u).re)
    (hbase : W.re ≤ M) (htail : -(W * star u).re ≤ M) :
    2 * (W * (2 - u * (r : ℂ) - star u / (r : ℂ))).re ≤
      4 * M + 2 * M / r - 2 * b * r

-- Norm-specialized bound for unit ordinate phase
theorem central_pair_upper_norm (W u : ℂ) (r b : ℝ)
    (hr : 0 < r) (hu : ‖u‖ = 1) (hmain : b ≤ (W * u).re) :
    2 * (W * (2 - u * (r : ℂ) - star u / (r : ℂ))).re ≤
      4 * ‖W‖ + 2 * ‖W‖ / r - 2 * b * r
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the exact paired reciprocal bump algebraic identity and the resulting linear negativity bound $-2 b r$ for zero pairs in the Weil explicit formula.
