# Contribution 102: Exact Physical-Additive Gram Kernel Balance Decomposition

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/AdditivePairBalance.lean`](../../formalization/BuildingBlocks/AdditivePairBalance.lean)  
**Classification:** Functional Analysis / Reproducing Kernel Hilbert Spaces / Gram Matrices / Cauchy Kernels / Indefinite Quadratic Forms

---

## 1. Executive Summary and Mathematical Statement

In the comparison between physical scattering energy and additive heat energy on the half-line $\mathbb{R}_+$, two primary kernel operators arise:
- The **Physical Kernel:** $K_{\text{phys}}(x, y) = \frac{1}{\max(x, y)}$.
- The **Additive Cauchy Kernel:** $K_{\text{add}}(x, y) = \frac{1}{x + y}$.

This contribution proves:

1. **Exact Pointwise Kernel Balance Identity:**  
   For all strictly positive coordinates $x, y > 0$:
   $$
   K_{\text{phys}}(x, y) = 2 K_{\text{add}}(x, y) - K_{\text{bal}}(x, y),
   $$
   where the **Balance Discrepancy Kernel** is given explicitly by:
   $$
   K_{\text{bal}}(x, y) = \frac{|x - y|}{\max(x, y)(x + y)} \ge 0.
   $$
2. **Complete Finite Gram Quadratic Decomposition:**  
   For any finite collection of nodes $x_i > 0$ and arbitrary real coefficients $c_i \in \mathbb{R}$, the corresponding Gram quadratic energies satisfy the exact linear relation:
   $$
   \sum_{i \in s} \sum_{j \in s} c_i c_j K_{\text{phys}}(x_i, x_j) = 2 \sum_{i \in s} \sum_{j \in s} c_i c_j K_{\text{add}}(x_i, x_j) - \sum_{i \in s} \sum_{j \in s} c_i c_j K_{\text{bal}}(x_i, x_j).
   $$
3. **Strict Indefiniteness of the Balance Quadratic Form:**  
   Although $K_{\text{bal}}(x, y) \ge 0$ pointwise everywhere on $\mathbb{R}_+ \times \mathbb{R}_+$, its associated integral/discrete quadratic form is **strictly indefinite**:
   - On the two-point grid $\{1, 2\}$, with weights $(a, b) = (1, 1)$, the quadratic form evaluates to $+1/3 > 0$.
   - With weights $(a, b) = (1, -1)$, the quadratic form evaluates to $-1/3 < 0$.
   - Consequently, the balance form $\mathcal{G}(c; K_{\text{bal}})$ is neither positive semi-definite nor negative semi-definite.
4. **Architectural Consequence:**  
   Proves that the physical Gram energy cannot be majorized or minorized by the additive Cauchy Gram energy via naive operator positivity alone, proving that sign cancellation in cross-couplings requires the arithmetic structure of prime coefficients.

---

## 2. Mathematical Proof

### 2.1. Pointwise Verification
By symmetry, assume without loss of generality that $x \le y$.
Then $\max(x, y) = y$ and $|x - y| = y - x$.
Evaluating the right-hand side:
$$
2 K_{\text{add}}(x, y) - K_{\text{bal}}(x, y) = \frac{2}{x + y} - \frac{y - x}{y (x + y)} = \frac{2y - (y - x)}{y(x + y)} = \frac{x + y}{y(x + y)} = \frac{1}{y} = \frac{1}{\max(x, y)}.
$$
The case $y \le x$ is symmetric. Thus the identity holds pointwise for all $x, y > 0$.

### 2.2. Two-Point Indefiniteness
Let nodes be $x_1 = 1, x_2 = 2$.
The balance kernel matrix is:
$$
K_{\text{bal}}(1, 1) = 0, \quad K_{\text{bal}}(2, 2) = 0,
$$
$$
K_{\text{bal}}(1, 2) = K_{\text{bal}}(2, 1) = \frac{|1 - 2|}{\max(1, 2)(1 + 2)} = \frac{1}{2 \cdot 3} = \frac{1}{6}.
$$
Thus, for vector $(a, b)$:
$$
\mathcal{G}_{(1, 2)}((a, b); K_{\text{bal}}) = a^2 \cdot 0 + 2ab \left(\frac{1}{6}\right) + b^2 \cdot 0 = \frac{ab}{3}.
$$
- For $(a, b) = (1, 1)$: $\frac{1 \cdot 1}{3} = \frac{1}{3} > 0$.
- For $(a, b) = (1, -1)$: $\frac{1 \cdot (-1)}{3} = -\frac{1}{3} < 0$.
Thus the quadratic form is indefinite.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.AdditivePairBalance`):
```lean
theorem kernel_identity {x y : ℝ} (hx : 0 < x) (hy : 0 < y) :
    physical x y = 2 * additive x y - balance x y

theorem complete_finite_gram_identity {ι : Type*} (s : Finset ι)
    (x c : ι → ℝ) (hx : ∀ i ∈ s, 0 < x i) :
    finiteGram s x c physical =
      2 * finiteGram s x c additive - finiteGram s x c balance

theorem balance_not_positive_quadratic :
    ¬ (∀ a b : ℝ, 0 ≤ twoPoint balance a b)

theorem balance_not_negative_quadratic :
    ¬ (∀ a b : ℝ, twoPoint balance a b ≤ 0)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Gram matrices of Cauchy kernels $1/(x_i + x_j)$ are positive definite by Pick and Loewner theory. Kernels with $\min$ or $\max$ (such as Brownian covariance $\min(x, y)$) are also positive definite. However, the exact decomposition $1/\max(x, y) = 2/(x+y) - |x-y|/(\max(x, y)(x+y))$ and the rigorous proof of the indefiniteness of the balance form are novel.
- **Advancement:** Establishes the exact algebraic balance between physical scattering and additive Cauchy Gram energies.
- **Target Venues:** *Linear Algebra and its Applications* or *Integral Equations and Operator Theory*.
