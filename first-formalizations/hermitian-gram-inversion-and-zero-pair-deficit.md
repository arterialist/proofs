# Finite-Dimensional Hermitian Gram Inversion and Off-Critical Zero-Pair Linear Deficit

**Authors:** Arterialist Formalization Team  
**Date:** September 2026  
**Lean 4 Version:** 4.24.0  
**Mathlib revision:** `f897ebcf72cd16f89ab4577d0c826cd14afaafc7` from `lake-manifest.json`
**Target Modules:** `BuildingBlocks.ActualWeilZeroPairAlgebra`, `BuildingBlocks.ActualAnnulusGramAlgebra`  
**Foundational Axioms:** Standard Lean 4 foundations (`[propext, Classical.choice, Quot.sound]`), zero custom axioms, zero `sorry` placeholders.

---

## 1. Mathematical Overview

In the spectral theory of the Weil explicit quadratic form, testing against pairs of complex zeros $\rho = \beta + i\gamma$ requires two complementary finite-dimensional algebraic mechanisms:
1. **The Off-Critical Zero-Pair Linear Deficit:** When an off-critical zero pair $(\rho, 1 - \bar{\rho})$ is tested with a translated-bump test function, the algebraic multiplier involves reciprocal factors:
   $$
    (1 - z)(1 - z^{-1}) = 2 - z - z^{-1}.
   $$
   Replacing the algebraic inverse $z^{-1}$ by the complex conjugate $\bar{z}$ would reverse the selected zero sign; retaining the inverse ensures that the reflected zero at $z' = (\bar{z})^{-1}$ matches via complex conjugation:
   $$
    W^* (1 - (\bar{z})^{-1})(1 - \bar{z}) = \left( W(1 - z)(1 - z^{-1}) \right)^*.
   $$
   Summing the zero and its reflection yields:
   $$
    \operatorname{Re}\left[ W(1 - z)(1 - z^{-1}) \right] + \operatorname{Re}\left[ W^* (1 - (\bar{z})^{-1})(1 - \bar{z}) \right] = 2\operatorname{Re}\left[ W(2 - z - z^{-1}) \right].
   $$
   Under radial scaling $z = u r$ with growth factor $r > 0$ and phase $\|u\| = 1$, if the oscillatory coefficient has positive real part $\operatorname{Re}(Wu) \ge b > 0$, the paired contribution satisfies:
   $$
    2\operatorname{Re}\left[ W\left(2 - u r - \frac{\bar{u}}{r}\right) \right] \le 4\|W\| + \frac{2\|W\|}{r} - 2 b r.
   $$
   As $r \to \infty$, the linear term $-2br$ dominates all positive terms, forcing the paired Weil zero contribution to $-\infty$.

2. **Annular Hermitian Gram Positivity:** In the annular decomposition around the critical line, two-bump prime crosses are governed by a $2 \times 2$ Hermitian Gram matrix with diagonal weight $d > 0$ and off-diagonal cross-coupling $p \in \mathbb{C}$:
   $$
    \begin{pmatrix} a^* & b^* \end{pmatrix} \begin{pmatrix} d & -p^* \\ -p & d \end{pmatrix} \begin{pmatrix} a \\ b \end{pmatrix} = d(|a|^2 + |b|^2) - 2\operatorname{Re}(b \bar{a} p).
   $$
   Applying Cauchy–Schwarz and the AM–GM inequality yields:
   $$
    (d - \|p\|)(|a|^2 + |b|^2) \le d(|a|^2 + |b|^2) - 2\operatorname{Re}(b \bar{a} p).
   $$
   Consequently, strict diagonal dominance $\|p\| < d$ guarantees strict positivity for all non-trivial vectors $(a, b) \ne (0, 0)$.

---

## 2. Formalization Details and Verified Signatures

### 2.1 Zero-Pair Reciprocal Algebra (`ActualWeilZeroPairAlgebra.lean`)

```lean
/-- Reciprocal bump factor identity with algebraic inverse. -/
theorem reciprocal_bump_factor (z : ℂ) (hz : z ≠ 0) :
    (1 - z) * (1 - z⁻¹) = 2 - z - z⁻¹

/-- Reflected zero bump multiplier matches complex conjugate. -/
theorem reflected_bump_factor (W z : ℂ) :
    (star W) * ((1 - (star z)⁻¹) * (1 - star z)) =
      star (W * ((1 - z) * (1 - z⁻¹)))

/-- Paired real part of zero and its reflection. -/
theorem paired_bump_factor (W z : ℂ) (hz : z ≠ 0) :
    (W * ((1 - z) * (1 - z⁻¹))).re +
      ((star W) * ((1 - (star z)⁻¹) * (1 - star z))).re =
      2 * (W * (2 - z - z⁻¹)).re

/-- Linear negative deficit for off-critical zero pair under radial growth. -/
theorem central_pair_upper_norm (W u : ℂ) (r b : ℝ)
    (hr : 0 < r) (hu : ‖u‖ = 1) (hmain : b ≤ (W * u).re) :
    2 * (W * (2 - u * (r : ℂ) - star u / (r : ℂ))).re ≤
      4 * ‖W‖ + 2 * ‖W‖ / r - 2 * b * r
```

### 2.2 Annular Hermitian Gram Positivity (`ActualAnnulusGramAlgebra.lean`)

```lean
/-- Two-bump Hermitian prime cross lower bound via AM-GM. -/
theorem signed_gram_lower (d : ℝ) (p a b : ℂ) :
    (d - ‖p‖) * (Complex.normSq a + Complex.normSq b) ≤
      d * (Complex.normSq a + Complex.normSq b) -
        2 * (b * star a * p).re

/-- Strict positivity under diagonal dominance. -/
theorem signed_gram_pos {d : ℝ} {p a b : ℂ}
    (hmargin : ‖p‖ < d) (hnonzero : a ≠ 0 ∨ b ≠ 0) :
    0 < d * (Complex.normSq a + Complex.normSq b) -
      2 * (b * star a * p).re
```

---

## 3. Axiomatic Foundations and Verification

Verification performed via `lake env lean` in the proofs repository:
```bash
~/.elan/bin/lake env lean formalization/BuildingBlocks/ActualWeilZeroPairAlgebra.lean
~/.elan/bin/lake env lean formalization/BuildingBlocks/ActualAnnulusGramAlgebra.lean
```
Axiom check output:
```
'BuildingBlocks.ActualWeilZeroPairAlgebra.reciprocal_bump_factor' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualWeilZeroPairAlgebra.reflected_bump_factor' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualWeilZeroPairAlgebra.paired_bump_factor' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualWeilZeroPairAlgebra.central_pair_upper' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualWeilZeroPairAlgebra.central_pair_upper_norm' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualAnnulusGramAlgebra.signed_gram_lower' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ActualAnnulusGramAlgebra.signed_gram_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
```
The proofs depend exclusively on standard Lean 4 foundations with zero custom axioms and zero `sorry`.

---

## 4. Comparison with Formalized Literature

1. **Mathlib:** Mathlib provides basic complex arithmetic and the AM–GM inequality (`two_mul_le_add_sq`), but possesses no formalization of Weil zero-pairing, reciprocal bump multipliers, or off-critical radial deficit theorems.
2. **AFP / Coq:** No formalization of the spectral zero-pair linear deficit in Weil explicit formulas exists in Isabelle/AFP or Coq/ROC.
3. **Novelty:** Provisional priority claim: this may be an early machine-verified proof that pairing an off-critical zero with its reflection under reciprocal bump convolution produces an inescapable negative linear deficit $-2br$ as the radial scale $r \to \infty$.
