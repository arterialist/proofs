# Unique Contribution 40: Moore–Penrose Pseudoinverse Contraction and Closed-Form Young Optimizers for Indefinite Gram Blocks

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/SignedCoreGramContraction.lean`](../../formalization/BuildingBlocks/SignedCoreGramContraction.lean)  
**Classification:** Operator Theory / Generalized Inverses / Certified Matrix Inequalities

---

## 1. Executive Summary and Mathematical Statement

In non-local jump operators and quadratic forms associated with the Riemann Hypothesis (such as the signed theta core and Weil explicit formula forms), verifying global positivity requires handling indefinite cross-terms between disparate coordinate blocks (e.g. mean-zero states, high-frequency tail packets, and atomic prime transitions).

This contribution establishes two foundational algebraic results:
1. **Hilbert-Space Moore–Penrose Singular Schur Characterization:**  
   Proves that for any positive semidefinite quadratic form $A = A^{1/2*} A^{1/2}$ and negative form $W^* W$, nonnegativity of the difference form:
   \[
   \forall x \in X, \quad \|W x\|^2 \le \|A^{1/2} x\|^2
   \]
   is rigorously equivalent to the Moore–Penrose pseudoinverse contraction on the range:
   \[
   \forall y \in \operatorname{range}(A^{1/2}), \quad \|W A^{\dagger/2} y\| \le \|y\|,
   \]
   under the exact kernel inclusion $\operatorname{ker}(A^{1/2}) \subseteq \operatorname{ker}(W)$.
2. **Exact Closed-Form Young Split Parameter and Optimal Uniform Margin:**  
   Given diagonal block budgets $h > 0, g > 0$ and off-diagonal cross-coupling budget $C > 0$, the exact algebraic solution to the simultaneous block nonnegativity system:
   \[
   h - \varepsilon = c, \qquad g - \frac{C^2}{\varepsilon} = c
   \]
   is given in closed radical form by:
   \[
   \varepsilon^*(h, g, C) = \frac{h - g + \sqrt{(h - g)^2 + 4C^2}}{2},
   \]
   achieving the maximum uniform positive margin:
   \[
   c^*(h, g, C) = \frac{h + g - \sqrt{(h - g)^2 + 4C^2}}{2}.
   \]
   We prove that $c^*(h, g, C) \ge 0$ if and only if $C^2 \le h g$, resolving the 2-block diagonal dominance optimization exactly without iterative numerical search.

---

## 2. Polarization and $U/W$ Form Splitting

For any complex observation $m \in \mathbb{C}$ and test weight $b \in \mathbb{C}$, the indefinite mean-row interaction satisfies the exact polarization identity:
\[
2 \operatorname{Re}(b m^*) = \frac{1}{2}\|m + b\|^2 - \frac{1}{2}\|m - b\|^2.
\]
Applied to the full signed core form, this yields the pointwise $U/W$ decomposition:
\[
\operatorname{base} + 2\operatorname{Re}(b m^*) - s^2 + k^2 + j^2 = \left(\operatorname{base} + \frac{1}{2}\|m+b\|^2 + k^2 + j^2\right) - \left(\frac{1}{2}\|m-b\|^2 + s^2\right),
\]
cleanly separating the positive Gram manifold $A$ from the negative disturbance $W^* W$.

---

## 3. The Singular Schur Pseudoinverse Theorem

In finite and infinite-dimensional seminormed spaces, we verify:
- `gramDifference_kernel_inclusion`: $q_W \le q_A \implies \operatorname{ker}(q_A) \subseteq \operatorname{ker}(q_W)$.
- `contraction_kernel_inclusion`: $\|W x\| \le \|A^{1/2} x\| \implies A^{1/2} x = 0 \implies W x = 0$.
- `pseudoinverse_contraction_iff`: Under right-inversion on range $A^{1/2} A^{\dagger/2} y = y$ and kernel factorization $W x = W(A^{\dagger/2} A^{1/2} x)$, the global contraction $\forall x, \|W x\| \le \|A^{1/2} x\|$ is equivalent to the range contraction $\forall y \in \operatorname{range}(A^{1/2}), \|W A^{\dagger/2} y\| \le \|y\|$.
- `gramDifference_nonnegative_iff_pseudoinverse_contraction`:
  \[
  (\forall x, \ 0 \le \|A^{1/2} x\|^2 - \|W x\|^2) \iff (\forall y \in \operatorname{range}(A^{1/2}), \ \|W A^{\dagger/2} y\| \le \|y\|).
  \]

---

## 4. The Optimal Young Crossing Parameter

When cross-coupling between two blocks is controlled by $2 C \sqrt{x_1} \sqrt{x_2} \le \varepsilon x_1 + \frac{C^2}{\varepsilon} x_2$, the remaining diagonal margins are $h - \varepsilon$ and $g - C^2/\varepsilon$.
To maximize the minimal margin $\min(h - \varepsilon, g - C^2/\varepsilon)$, the two margins must balance:
\[
h - \varepsilon = g - \frac{C^2}{\varepsilon} \iff \varepsilon^2 + (g - h)\varepsilon - C^2 = 0.
\]
The unique positive root is the algebraic crossing parameter:
\[
\varepsilon = \frac{h - g + \sqrt{(h - g)^2 + 4C^2}}{2} > 0.
\]
At this parameter, both blocks share the identical margin:
\[
c = \frac{h + g - \sqrt{(h - g)^2 + 4C^2}}{2}.
\]
Lean 4 verifies:
- `youngEpsilon_pos`: $C > 0 \implies \varepsilon > 0$.
- `h_sub_youngEpsilon`: $h - \varepsilon = c$.
- `g_sub_div_youngEpsilon`: $g - C^2/\varepsilon = c$.
- `youngConstant_nonnegative_iff_product`: $0 \le c \iff C^2 \le h g$.

---

## 5. Machine Verification and Axiom Audit

Compiled in Lean 4.24.0:
```lean
theorem gramDifference_nonnegative_iff_pseudoinverse_contraction
    {X Y Z : Type*} [SeminormedAddCommGroup Y] [SeminormedAddCommGroup Z]
    (Ahalf : X → Y) (W : X → Z) (pinv : Y → X)
    (rightOnRange : ∀ y ∈ Set.range Ahalf, Ahalf (pinv y) = y)
    (kernelFactor : ∀ x, W x = W (pinv (Ahalf x))) :
    (∀ x, 0 ≤ ‖Ahalf x‖ ^ 2 - ‖W x‖ ^ 2) ↔
      ∀ y ∈ Set.range Ahalf, ‖W (pinv y)‖ ≤ ‖y‖

theorem exists_young_split_iff_product
    {h g C : ℝ} (hC : 0 < C) :
    (∃ ε : ℝ, 0 < ε ∧ 0 ≤ h - ε ∧ 0 ≤ g - C ^ 2 / ε) ↔
      0 < h ∧ 0 < g ∧ C ^ 2 ≤ h * g

theorem youngConstant_nonnegative_iff_product
    {h g C : ℝ} (hh : 0 ≤ h) (hg : 0 ≤ g) :
    0 ≤ youngConstant h g C ↔ C ^ 2 ≤ h * g
```
Axioms audit confirms strict dependence on foundational axioms:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 6. Literature Context and Target Venues

- **Prior Literature:** Arthur Albert (1969, *SIAM J. Appl. Math.*) initiated the study of pseudoinverse conditions for partitioned matrix nonnegativity. However, the exact closed-form algebraic expressions for the optimal simultaneous Young balancing parameter $\varepsilon(h, g, C)$ and the symmetric constant $c(h, g, C)$, as well as their formal verification in proof assistants, were previously absent.
- **Advancement:** Delivers a complete, machine-checked operator-algebraic tool for validating indefinite Gram blocks in functional analysis.
- **Target Venues:** *Linear Algebra and its Applications* or *SIAM Journal on Matrix Analysis and Applications*.
