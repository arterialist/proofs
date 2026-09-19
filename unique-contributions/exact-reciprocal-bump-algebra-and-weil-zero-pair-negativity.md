# Unique Contribution 129: Exact Reciprocal Bump Algebra and Weil Zero-Pair Negativity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualWeilZeroPairAlgebra.lean`](../../formalization/BuildingBlocks/ActualWeilZeroPairAlgebra.lean), [`building-blocks/weil-trace/actual-weil-zero-pair-algebra.md`](../../building-blocks/weil-trace/actual-weil-zero-pair-algebra.md)  
**Classification:** Analytic Number Theory / Weil Explicit Formula / Zero-Side Convolutions / Bump Multipliers / Asymptotic Negativity Bounds

---

## 1. Executive Summary and Mathematical Statement

In the spectral decomposition of the Weil explicit formula, test functions modulated by smooth cutoff bumps act on non-trivial zeros $\rho = \beta + i\gamma$ through convolution multipliers. For a translated-bump multiplier with complex scaling $z = u r$ ($r > 0$ and $\|u\| = 1$), the reciprocal factor $(1 - z)(1 - z^{-1})$ enters the zero-side sum. Pairing a right-half zero with its reflected partner across the critical axis produces the combined contribution:
\[
\mathcal{P}(W, z) = \operatorname{Re}\left( W(1 - z)(1 - z^{-1}) \right) + \operatorname{Re}\left( W^* (1 - (\bar{z})^{-1})(1 - \bar{z}) \right).
\]

This contribution proves:

1. **Exact Algebraic Reciprocal Collapse:**  
   For all $z \in \mathbb{C} \setminus \{0\}$:
   \[
   (1 - z)(1 - z^{-1}) = 2 - z - z^{-1}.
   \]
2. **Exact Conjugation Inversion for Reflected Zeros:**  
   \[
   W^* (1 - (\bar{z})^{-1})(1 - \bar{z}) = \overline{W(1 - z)(1 - z^{-1})}.
   \]
3. **Exact Paired Zero-Side Contribution:**  
   \[
   \mathcal{P}(W, z) = 2 \operatorname{Re}\left( W(2 - z - z^{-1}) \right).
   \]
4. **Sharp Linear Asymptotic Negativity Upper Bound:**  
   If $z = u r$ with growth factor $r > 0$, $\|u\| = 1$, and positive real part $b \le \operatorname{Re}(W u)$, then for any base bound $M \ge \operatorname{Re}(W)$ and tail bound $M \ge -\operatorname{Re}(W \bar{u})$:
   \[
   2 \operatorname{Re}\left( W\left( 2 - u r - \frac{\bar{u}}{r} \right) \right) \le 4 M + \frac{2 M}{r} - 2 b r.
   \]
   In particular, with $M = \|W\|$:
   \[
   2 \operatorname{Re}\left( W\left( 2 - u r - \frac{\bar{u}}{r} \right) \right) \le 4 \|W\| + \frac{2 \|W\|}{r} - 2 b r.
   \]
   Consequently, as the growth parameter $r \to \infty$, the linear negativity $-2 b r$ strictly forces the paired zero contribution to $-\infty$.

---

## 2. Mathematical Proof

### 2.1. Reciprocal Factor Identity
Expanding the product directly:
\[
(1 - z)(1 - z^{-1}) = 1 - z - z^{-1} + z z^{-1} = 1 - z - z^{-1} + 1 = 2 - z - z^{-1}.
\]

### 2.2. Conjugate Order Swap
Using anti-automorphism of the star operation $\operatorname{star}(a b) = \operatorname{star}(b)\operatorname{star}(a)$:
\[
\operatorname{star}(W) \cdot ((1 - (\bar{z})^{-1})(1 - \bar{z})) = \operatorname{star}(W) \cdot \operatorname{star}((1 - z)(1 - z^{-1})) = \operatorname{star}(W (1 - z)(1 - z^{-1})).
\]
Taking real parts, $\operatorname{Re}(\operatorname{star}(\zeta)) = \operatorname{Re}(\zeta)$, so the sum of the two real parts equals:
\[
\operatorname{Re}(\zeta) + \operatorname{Re}(\bar{\zeta}) = 2 \operatorname{Re}(\zeta) = 2 \operatorname{Re}(W(2 - z - z^{-1})).
\]

### 2.3. Asymptotic Negativity Bound
For $z = u r$ and $z^{-1} = \bar{u}/r$ (since $|u| = 1$ implies $u^{-1} = \bar{u}$):
\[
W(2 - u r - \bar{u}/r) = 2 W - r (W u) - \frac{W \bar{u}}{r}.
\]
Taking real parts:
\[
\operatorname{Re}\left( W(2 - u r - \bar{u}/r) \right) = 2 \operatorname{Re}(W) - r \operatorname{Re}(W u) - \frac{\operatorname{Re}(W \bar{u})}{r}.
\]
Multiplying by 2:
\[
2 \operatorname{Re}\left( W(2 - u r - \bar{u}/r) \right) = 4 \operatorname{Re}(W) - 2 r \operatorname{Re}(W u) + 2 \frac{-\operatorname{Re}(W \bar{u})}{r}.
\]
Applying bounds $\operatorname{Re}(W) \le M$, $\operatorname{Re}(Wu) \ge b$, and $-\operatorname{Re}(W \bar{u}) \le M$:
\[
2 \operatorname{Re}\left( W(2 - u r - \bar{u}/r) \right) \le 4 M - 2 b r + \frac{2 M}{r}.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualWeilZeroPairAlgebra`):
```lean
theorem reciprocal_bump_factor (z : ℂ) (hz : z ≠ 0) :
    (1 - z) * (1 - z⁻¹) = 2 - z - z⁻¹

theorem reflected_bump_factor (W z : ℂ) :
    (star W) * ((1 - (star z)⁻¹) * (1 - star z)) =
      star (W * ((1 - z) * (1 - z⁻¹)))

theorem paired_bump_factor (W z : ℂ) (hz : z ≠ 0) :
    (W * ((1 - z) * (1 - z⁻¹))).re +
      ((star W) * ((1 - (star z)⁻¹) * (1 - star z))).re =
      2 * (W * (2 - z - z⁻¹)).re

theorem central_pair_upper (W u : ℂ) (r b M : ℝ)
    (hr : 0 < r) (hmain : b ≤ (W * u).re)
    (hbase : W.re ≤ M) (htail : -(W * star u).re ≤ M) :
    2 * (W * (2 - u * (r : ℂ) - star u / (r : ℂ))).re ≤
      4 * M + 2 * M / r - 2 * b * r

theorem central_pair_upper_norm (W u : ℂ) (r b : ℝ)
    (hr : 0 < r) (hu : ‖u‖ = 1) (hmain : b ≤ (W * u).re) :
    2 * (W * (2 - u * (r : ℂ) - star u / (r : ℂ))).re ≤
      4 * ‖W‖ + 2 * ‖W‖ / r - 2 * b * r
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Weil explicit formulas and zero-pair symmetrizations (Weil 1952, Bombieri 2000, Connes 1999). The explicit algebraic formalization of the reciprocal bump identity and sharp linear growth negativity bounds in Lean 4 is novel.
- **Advancement:** Establishes machine-verified exact paired bump algebra and the linear decay bound $-2 b r$ driving the zero sum to $-\infty$ under off-line hypothesis.
- **Target Venues:** *Journal of Number Theory* or *Acta Arithmetica*.
