# Contribution 255: Exact Two-Bump Hermitian Gram Lower Bound and Strict Positivity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualAnnulusGramAlgebra.lean`](../../formalization/BuildingBlocks/ActualAnnulusGramAlgebra.lean), [`building-blocks/algebra/actual-annulus-gram-algebra.md`](../../building-blocks/algebra/actual-annulus-gram-algebra.md)  
**Classification:** Operator Theory / Hermitian Matrix Algebra / Gram Matrices / Spectral Gap / Annular Weil Criterion / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the operator-theoretic formulation of the annular Weil positivity criterion, localized bump test functions generate off-diagonal prime cross terms $p = \langle \psi_1, T \psi_2 \rangle$ that perturb the diagonal energy $d (\|a\|^2 + \|b\|^2)$. To guarantee strict positivity of the quadratic form without assuming global operator positivity, one must establish an exact non-asymptotic lower bound on the $2 \times 2$ Hermitian Gram form.

This contribution proves:

1. **Exact Hermitian Gram Lower Bound:**  
   For any diagonal scaling $d \in \mathbb{R}$, off-diagonal cross term $p \in \mathbb{C}$, and state amplitudes $a, b \in \mathbb{C}$:
   $$
   (d - \|p\|)(|a|^2 + |b|^2) \le d (|a|^2 + |b|^2) - 2 \text{Re}(b \bar{a} p).
   $$
   The cross term is bounded above by $\|p\| \cdot |a| \cdot |b|$, which combined with the arithmetic-geometric mean inequality $2|a||b| \le |a|^2 + |b|^2$ yields the exact uniform spectral contraction factor $(d - \|p\|)$.
2. **Strict Positivity under Spectral Gap:**  
   Whenever the cross term satisfies the spectral gap condition $\|p\| < d$ and the state is non-trivial ($(a, b) \ne (0, 0)$):
   $$
   d (|a|^2 + |b|^2) - 2 \text{Re}(b \bar{a} p) > 0.
   $$
   This guarantees that the finite-dimensional Hermitian Gram matrix $\begin{pmatrix} d & -\bar{p} \\ -p & d \end{pmatrix}$ is strictly positive-definite on $\mathbb{C}^2$.

---

## 2. Mathematical Proof

### 2.1. Cauchy-Schwarz and AM-GM Contraction
Let $z = b \bar{a} p \in \mathbb{C}$. Its real part is bounded by its complex modulus:
$$
\text{Re}(b \bar{a} p) \le |b \bar{a} p| = \|p\| \cdot |a| \cdot |b|.
$$
By the elementary inequality $(|a| - |b|)^2 \ge 0$, we have:
$$
2 |a| |b| \le |a|^2 + |b|^2.
$$
Multiplying by $\|p\| \ge 0$:
$$
2 \text{Re}(b \bar{a} p) \le 2 \|p\| |a| |b| \le \|p\| (|a|^2 + |b|^2).
$$
Subtracting this from $d (|a|^2 + |b|^2)$:
$$
d (|a|^2 + |b|^2) - 2 \text{Re}(b \bar{a} p) \ge d (|a|^2 + |b|^2) - \|p\| (|a|^2 + |b|^2) = (d - \|p\|)(|a|^2 + |b|^2).
$$

### 2.2. Strict Positivity
If $(a, b) \ne (0, 0)$, then $|a|^2 + |b|^2 > 0$.
If $\|p\| < d$, then the gap $d - \|p\| > 0$.
The product of two strictly positive real numbers is strictly positive:
$$
(d - \|p\|)(|a|^2 + |b|^2) > 0.
$$
By the lower bound established above:
$$
d (|a|^2 + |b|^2) - 2 \text{Re}(b \bar{a} p) \ge (d - \|p\|)(|a|^2 + |b|^2) > 0.
$$

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualAnnulusGramAlgebra` in `formalization/BuildingBlocks/ActualAnnulusGramAlgebra.lean`):
```lean
theorem signed_gram_lower (d : ℝ) (p a b : ℂ) :
    (d - ‖p‖) * (Complex.normSq a + Complex.normSq b) ≤
      d * (Complex.normSq a + Complex.normSq b) -
        2 * (b * star a * p).re

theorem signed_gram_pos {d : ℝ} {p a b : ℂ}
    (hmargin : ‖p‖ < d) (hnonzero : a ≠ 0 ∨ b ≠ 0) :
    0 < d * (Complex.normSq a + Complex.normSq b) -
      2 * (b * star a * p).re
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Hermitian quadratic forms, Gershgorin disc theorems, and Gram matrix positivity (Horn-Johnson 2012). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the core algebraic positivity lemma required for the finite-dimensional step in the annular Weil criterion.
- **Target Venues:** *Linear Algebra and its Applications* or *Journal of Mathematical Analysis and Applications*.
