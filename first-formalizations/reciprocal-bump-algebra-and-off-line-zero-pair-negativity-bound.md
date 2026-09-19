# First Formalization: Reciprocal Bump Algebra and Off-Line Zero-Pair Negativity Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualWeilZeroPairAlgebra.lean`](../../formalization/BuildingBlocks/ActualWeilZeroPairAlgebra.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact algebra of reciprocal bump factors and paired zero upper bounds under functional-equation reflection in Lean 4:

1. **Reciprocal Bump Factor Identity:**
   Formal proof that $(1 - z)(1 - z^{-1}) = 2 - z - z^{-1}$ for $z \ne 0$ (`reciprocal_bump_factor`).
2. **Conjugate Reflection Swap:**
   Formal derivation of $\bar{W}(1 - \bar{z}^{-1})(1 - \bar{z}) = \overline{W(1-z)(1-z^{-1})}$ (`reflected_bump_factor`).
3. **Paired Bump Factor Real Part:**
   Formal proof that the sum of real parts of a reflected pair equals $2 \operatorname{Re}(W(2 - z - z^{-1}))$ (`paired_bump_factor`).
4. **Off-Line Negativity Upper Bound:**
   Formal proofs of the upper bound $4M + 2M/r - 2br$ and normalized version $4\|W\| + 2\|W\|/r - 2br$ isolating the negative linear term $-2br$ (`central_pair_upper`, `central_pair_upper_norm`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Reciprocal bump factor identity
theorem reciprocal_bump_factor (z : ℂ) (hz : z ≠ 0) :
    (1 - z) * (1 - z⁻¹) = 2 - z - z⁻¹

-- Conjugate reflection swap
theorem reflected_bump_factor (W z : ℂ) :
    (star W) * ((1 - (star z)⁻¹) * (1 - star z)) =
      star (W * ((1 - z) * (1 - z⁻¹)))

-- Paired bump factor evaluation
theorem paired_bump_factor (W z : ℂ) (hz : z ≠ 0) :
    (W * ((1 - z) * (1 - z⁻¹))).re +
      ((star W) * ((1 - (star z)⁻¹) * (1 - star z))).re =
      2 * (W * (2 - z - z⁻¹)).re

-- Off-line zero-pair negativity bound
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

This formalization provides the first machine-verified proof in Lean 4 of the reciprocal bump factor expansion and the quantitative linear negativity bound $4\|W\| + 2\|W\|/r - 2br$ for off-line zero pairs in Weil-type quadratic forms.
