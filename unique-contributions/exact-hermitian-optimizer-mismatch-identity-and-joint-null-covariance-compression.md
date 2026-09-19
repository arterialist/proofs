# Unique Contribution 308: Exact Hermitian Optimizer-Mismatch Identity and Joint-Null Covariance Compression

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/OptimizerMismatch.lean`](../../formalization/BuildingBlocks/OptimizerMismatch.lean), [`building-blocks/optimizer-mismatch/scalar-algebra.md`](../../building-blocks/optimizer-mismatch/scalar-algebra.md)  
**Classification:** Optimization Theory / Variational Calculus / Hermitian Quadratic Forms / Residual Gain / Covariance Loss / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the variational analysis of infinite-dimensional quadratic forms subjected to finite truncation or regularization, the exact value function depends on an optimal scalar choice $c \in \mathbb{C}$. When comparing a truncated form $Q$ with a target form $C$, evaluating $C$ at the optimizer for $Q$ produces an optimizer-mismatch penalty.

This contribution proves:

1. **Exact Hermitian Optimizer-Mismatch Identity:**  
   For any two Hermitian affine quadratic forms $Q$ and $C$ with denominators $d_Q, d_C \ne 0$, numerators $z_Q + m, z_C + m$, and optimizers $c_Q = (z_Q + m)/d_Q$, $c_C = (z_C + m)/d_C$:
   \[
   \mathcal{V}_C(m) - \mathcal{V}_Q(m) = \mathcal{Q}_{Q - C}(c_Q) + d_C |c_Q - c_C|^2,
   \]
   where $\mathcal{Q}_{Q-C}(c) = (q_{ff} - c_{ff}) - 2 \text{Re}(\bar{c}(z_Q - z_C)) + (d_Q - d_C)|c|^2$ is the residual quadratic form evaluated at the old optimizer $c_Q$, and $d_C |c_Q - c_C|^2$ is the metric mismatch penalty.
2. **Exact Signed Lower Bound Under Finite Observations:**  
   Given an observed lower bound $\text{obs} \le \mathcal{Q}_{Q-C}(c_Q)$:
   \[
   \mathcal{V}_Q(m) + \text{obs} = \mathcal{V}_C(m) - \left( \mathcal{Q}_{Q-C}(c_Q) - \text{obs} + d_C |c_Q - c_C|^2 \right).
   \]
   The discrepancy subtracted from $\mathcal{V}_C(m)$ is strictly non-negative whenever $d_C \ge 0$.
3. **Common Nullspace Optimization Collapse:**  
   On the common nullspace where $z_Q + m = 0$, the old optimizer vanishes identically ($c_Q = 0$), the true optimizer becomes $c_C = -(z_Q - z_C)/d_C$, and the mismatch reduces to:
   \[
   \mathcal{V}_Q(m) + \text{obs} = \mathcal{V}_C(m) - \left( (q_{ff} - c_{ff}) - \text{obs} + \frac{|z_Q - z_C|^2}{d_C} \right).
   \]
4. **Joint-Null Covariance Compression:**  
   When the difference form is non-negative, Cauchy–Schwarz $|z_Q - z_C|^2 \le D_{ff} D_{qq}$ compresses the total joint-null loss into a single covariance ratio:
   \[
   D_{ff} + \frac{|z_Q - z_C|^2}{C_{qq}} \le \frac{Q_{qq}}{C_{qq}} D_{ff}.
   \]
5. **Exact Completion of the Hermitian Affine Square:**  
   For any $d \ne 0$:
   \[
   d |c|^2 - 2 \text{Re}(\bar{c}(z + m)) = d \left| c - \frac{z + m}{d} \right|^2 - \frac{|z + m|^2}{d}.
   \]

---

## 2. Mathematical Proof

### 2.1. Completion of the Affine Square
Writing $c = u + iv$ and $z + m = a + ib$:
\[
d |c|^2 - 2 \text{Re}(\bar{c}(z + m)) = d(u^2 + v^2) - 2(ua + vb) = d \left( u - \frac{a}{d} \right)^2 + d \left( v - \frac{b}{d} \right)^2 - \frac{a^2 + b^2}{d}.
\]
In complex form:
\[
d |c - c^*|^2 - \frac{|z+m|^2}{d}, \qquad \text{where } c^* = \frac{z+m}{d}.
\]
For $d > 0$, the minimum is uniquely attained at $c = c^*$, giving value $-|z+m|^2 / d$.

### 2.2. Value Difference Identity
The optimized values are $\mathcal{V}_Q = \text{base} - q_{ff} + |z_Q + m|^2 / d_Q$ and $\mathcal{V}_C = \text{base} - c_{ff} + |z_C + m|^2 / d_C$.
Subtracting $\mathcal{V}_Q$ from $\mathcal{V}_C$ and expanding $c_Q = (z_Q + m)/d_Q$ and $c_C = (z_C + m)/d_C$:
\[
\mathcal{V}_C - \mathcal{V}_Q = (q_{ff} - c_{ff}) + \frac{|z_C + m|^2}{d_C} - \frac{|z_Q + m|^2}{d_Q}.
\]
Expanding the residual quadratic form at $c_Q$:
\[
\mathcal{Q}_{Q-C}(c_Q) = (q_{ff} - c_{ff}) - 2 \text{Re}\left( \bar{c}_Q (z_Q - z_C) \right) + (d_Q - d_C) |c_Q|^2.
\]
Direct algebraic manipulation reveals that adding $d_C |c_Q - c_C|^2$ to $\mathcal{Q}_{Q-C}(c_Q)$ produces an exact identity with $\mathcal{V}_C - \mathcal{V}_Q$.

### 2.3. Covariance Loss Ratio
If $Q_{qq} = C_{qq} + D_{qq}$ with $C_{qq} > 0$ and $|z_Q - z_C|^2 \le D_{ff} D_{qq}$:
\[
D_{ff} + \frac{|z_Q - z_C|^2}{C_{qq}} \le D_{ff} + \frac{D_{ff} D_{qq}}{C_{qq}} = D_{ff} \left( 1 + \frac{D_{qq}}{C_{qq}} \right) = D_{ff} \left( \frac{C_{qq} + D_{qq}}{C_{qq}} \right) = \frac{Q_{qq}}{C_{qq}} D_{ff}.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.OptimizerMismatch` in `formalization/BuildingBlocks/OptimizerMismatch.lean`):
```lean
theorem affine_completion_of_square
    (z m c : ℂ) (d : ℝ) (hd : d ≠ 0) :
    affineScalarEnergy z m c d =
      d * Complex.normSq (c - affineOptimizer z m d) -
        Complex.normSq (z + m) / d

theorem optimizer_mismatch_identity
    (base qff cff dQ dC : ℝ) (zQ zC m : ℂ)
    (hdQ : dQ ≠ 0) (hdC : dC ≠ 0) :
    affineOptimizedValue base cff dC zC m -
        affineOptimizedValue base qff dQ zQ m =
      residualQuadratic (qff - cff) (dQ - dC) (zQ - zC)
          (affineOptimizer zQ m dQ) +
        dC * Complex.normSq
          (affineOptimizer zQ m dQ - affineOptimizer zC m dC)

theorem observed_optimizer_mismatch_joint_null
    (base qff cff dQ dC obs : ℝ) (zQ zC m : ℂ)
    (hdQ : dQ ≠ 0) (hdC : dC ≠ 0) (hnull : zQ + m = 0) :
    affineOptimizedValue base qff dQ zQ m + obs =
      affineOptimizedValue base cff dC zC m -
        ((qff - cff) - obs + Complex.normSq (zQ - zC) / dC)

theorem jointNull_loss_le_covariance_ratio
    {Dff Dqq Cqq Qqq mixedSq : ℝ}
    (hCqq : 0 < Cqq)
    (hQ : Qqq = Cqq + Dqq)
    (hmixed : mixedSq ≤ Dff * Dqq) :
    Dff + mixedSq / Cqq ≤ (Qqq / Cqq) * Dff
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Rayleigh–Ritz method (Ritz 1909); Weinstein–Aronszajn intermediate problems (Aronszajn 1951); Kato (1995) *Perturbation Theory for Linear Operators*. Machine verification of exact non-asymptotic optimizer-mismatch identities and joint-null covariance compression in Lean 4 is new.
- **Advancement:** Provides an exact algebraic identity decomposing variational mismatch into residual evaluation and metric projection discrepancy, establishing certified lower comparison bounds.
- **Target Venues:** *SIAM Journal on Optimization* or *Linear Algebra and its Applications*.
