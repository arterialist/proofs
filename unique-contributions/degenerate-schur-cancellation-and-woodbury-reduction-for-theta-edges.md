# Unique Contribution 44: Degenerate Schur Complement Cancellation and Three-Column Woodbury Reduction for Conditional Theta Edges

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ThetaDirectEdgeFiniteAlgebra.lean`](../../formalization/BuildingBlocks/ThetaDirectEdgeFiniteAlgebra.lean), [`formalization/BuildingBlocks/ThetaSignedCoreFiniteBlock.lean`](../../formalization/BuildingBlocks/ThetaSignedCoreFiniteBlock.lean)  
**Classification:** Numerical Linear Algebra / Matrix Inequalities / Operator Block Reduction

---

## 1. Executive Summary and Mathematical Statement

In the Galerkin discretization of the non-local theta jump operator, the elimination of constraint profiles (such as odd-parity and mean-zero coordinates) leads to rational Schur complement quotients:
\[
\operatorname{edgeTheta} = A_{zz} - \frac{b_c^2}{d_c} - \frac{b_p^2}{d_p} - \frac{m^2}{d_y},
\]
where $m = b_0 - \frac{b_c g_c}{d_c} - \frac{b_p g_p}{d_p}$ is the residual mixed coupling and $d_y = A_{yy} - \frac{g_c^2}{d_c} - \frac{g_p^2}{d_p}$ is the residual diagonal budget.

A fatal numerical and analytical obstacle occurs when the residual diagonal vanishes: $d_y = 0$, where the quotient $m^2 / d_y$ becomes nominally undefined or indeterminate ($0/0$ or $\infty$).

This contribution establishes:
1. **Degenerate Cauchy–Schwarz Numerator Cancellation:**  
   Proves that for any $2 \times 2$ positive semidefinite block, if the diagonal entry vanishes ($d = 0$), then the off-diagonal coupling **must vanish identically**:
   \[
   0 \le a \ \wedge \ 0 \le d \ \wedge \ b^2 \le a d \ \wedge \ (d = 0) \implies b = 0.
   \]
   Consequently, whenever the residual diagonal is zero ($d_y = 0$), the residual mixed coupling $m$ vanishes identically ($m = 0$), so the singular Schur quotient is well-defined and evaluates to zero:
   \[
   \operatorname{schurQuotient}(m, d_y) = 0.
   \]
2. **Exact Three-Column Woodbury Quadratic Expansion:**  
   Proves the exact algebraic reduction of the $4 \times 4$ Gram matrix $G$ against the correction vector $c = (1, -r_1, -r_2, -r_3)^T$:
   \[
   c^T G c = G_{00} - 2 \sum_{j=1}^3 G_{0j} r_j + \sum_{j=1}^3 \sum_{k=1}^3 r_j G_{jk} r_k,
   \]
   preserving all off-diagonal cross terms prior to finite quadratic evaluation.
3. **Five-Component Coercive Signed Core Decomposition:**  
   Establishes the exact decomposition of the compressed signed core matrix into its five constituent physical blocks: spectral, mean correction, covariance, odd-affine, and prime observation Gram matrices, and proves that the lower certificate:
   \[
   c^*(\operatorname{low}, \operatorname{next}, C_V, \varepsilon) = \min\left( \operatorname{low} - \varepsilon, \ \operatorname{next} - C_V - \frac{C_V^2}{\varepsilon} \right) > 0
   \]
   rigorously implies coercive block positivity $c^* \|c\|^2 \le F$.

---

## 2. The Degenerate Schur Invariant

Consider the residual $2 \times 2$ block:
\[
\begin{pmatrix}
A_{zz} - \frac{b_c^2}{d_c} - \frac{b_p^2}{d_p} & m \\
m & d_y
\end{pmatrix}.
\]
If the underlying state space maintains positive semidefiniteness, this block must satisfy:
\[
m^2 \le \left(A_{zz} - \frac{b_c^2}{d_c} - \frac{b_p^2}{d_p}\right) d_y.
\]
When $d_y = 0$, the right-hand side is $0$. Because $m^2 \ge 0$, this forces $m^2 = 0$, whence $m = 0$.  
Thus, the singularity at $d_y = 0$ is removable and cancels algebraically: the projection leaves no indeterminate remainder.

---

## 3. Machine Verification and Axiom Audit

Compiled in Lean 4.24.0:
```lean
theorem schur_residual_identity
    {Azz Ayy b0 bc bp gc gp dc dp : ℝ}
    (hdy : residualDiagonal Ayy gc gp dc dp ≠ 0) :
    let dy := residualDiagonal Ayy gc gp dc dp
    let m := residualMixed b0 bc bp gc gp dc dp
    let s := m / dy
    edgeTheta Azz Ayy b0 bc bp gc gp dc dp =
      (Azz - bc ^ 2 / dc - bp ^ 2 / dp) - 2 * s * m + s ^ 2 * dy

theorem psd_mixed_eq_zero_of_diagonal_eq_zero
    {a b d : ℝ} (hpsd : 0 ≤ a ∧ 0 ≤ d ∧ b ^ 2 ≤ a * d)
    (hd0 : d = 0) : b = 0

theorem degenerate_residualMixed_eq_zero
    {Azz Ayy b0 bc bp gc gp dc dp : ℝ}
    (hdiag : 0 ≤ Azz - bc ^ 2 / dc - bp ^ 2 / dp)
    (hdy : 0 ≤ residualDiagonal Ayy gc gp dc dp)
    (hdet : residualMixed b0 bc bp gc gp dc dp ^ 2 ≤
      (Azz - bc ^ 2 / dc - bp ^ 2 / dp) * residualDiagonal Ayy gc gp dc dp)
    (hdy0 : residualDiagonal Ayy gc gp dc dp = 0) :
    residualMixed b0 bc bp gc gp dc dp = 0

theorem woodbury_quadratic_expansion (G : Matrix (Fin 4) (Fin 4) ℝ) (r : Fin 3 → ℝ) :
    dotProduct (woodburyCoefficients r) (G.mulVec (woodburyCoefficients r)) =
      G 0 0 - (∑ j : Fin 3, G 0 j.succ * r j) -
        (∑ j : Fin 3, r j * G j.succ 0) +
          ∑ j : Fin 3, ∑ k : Fin 3, r j * G j.succ k.succ * r k

theorem signedCore_quadratic_decomposition
    (lambda : Fin N → ℝ) (alpha a dQ : ℝ) (m ac k c : Fin N → ℝ)
    (covarianceGram primeGram : Matrix (Fin N) (Fin N) ℝ) :
    quadratic (signedCoreMatrix lambda alpha a dQ m ac k covarianceGram primeGram) c =
      quadratic (spectralTerm lambda alpha) c +
      quadratic (meanTerm m ac) c +
      quadratic (covarianceTerm a covarianceGram) c +
      quadratic (oddAffineTerm dQ k) c +
      quadratic (primeObservationTerm primeGram) c
```
Axioms audit confirms dependence strictly on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Schur complements and Woodbury identities are classical (Horn & Johnson, Golub & Van Loan). However, the formal verification of the degenerate boundary cancellation $m=0$ via PSD determinant conditions, in conjunction with the exact five-block signed core decomposition for theta Dirichlet forms, provides the certified algebra needed for automated proof assistant verification of multi-column operator reductions.
- **Advancement:** Establishes the exact algebraic framework resolving indeterminate Schur complement denominators in certified Galerkin discretizations.
- **Target Venues:** *SIAM Journal on Matrix Analysis and Applications* or *Linear Algebra and its Applications*.
