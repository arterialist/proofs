# First Formalization: Moore–Penrose Pseudoinverse Contraction and Closed-Form Young Optimizers

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SignedCoreGramContraction.lean`](../../formalization/BuildingBlocks/SignedCoreGramContraction.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the foundational operator and matrix algebra governing indefinite signed quadratic forms, Moore–Penrose generalized inverses, and optimal 2-block diagonal dominance balancing:

1. **Complex Mean Polarization:**
   Formal proof of $2\operatorname{Re}(bm^*) = \frac{1}{2}\|m+b\|^2 - \frac{1}{2}\|m-b\|^2$ (`complex_mean_gram_split`) and the resulting $U/W$ signed decomposition (`signedCore_uw_decomposition`).
2. **Singular Schur Pseudoinverse Theorem:**
   Equivalence between quadratic difference form nonnegativity $\forall x, \|Wx\|^2 \le \|A^{1/2}x\|^2$ and range contraction of the Moore–Penrose inverse $\forall y \in \operatorname{range}(A^{1/2}), \|W A^{\dagger/2}y\| \le \|y\|$ under kernel inclusion (`gramDifference_nonnegative_iff_pseudoinverse_contraction`).
3. **Closed-Form Young Splitting Parameters:**
   Construction of `youngEpsilon` and `youngConstant` in closed radical form, proving that the parameter $\varepsilon = \frac{h - g + \sqrt{(h-g)^2 + 4C^2}}{2}$ is strictly positive and simultaneously balances both diagonal margins:
   $h - \varepsilon = c$ and $g - C^2/\varepsilon = c$.
4. **Exact Determinantal Solvability:**
   Formal bidirectional equivalence proving that $0 \le c \iff C^2 \le h g$ (`youngConstant_nonnegative_iff_product`), and existence of a valid positive split parameter $\varepsilon$ if and only if $h > 0, g > 0$, and $C^2 \le h g$ (`exists_young_split_iff_product`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Polarization identity
theorem complex_mean_gram_split (m b : ℂ) :
    2 * (b * star m).re =
      Complex.normSq (m + b) / 2 - Complex.normSq (m - b) / 2

-- Singular Schur pseudoinverse contraction equivalence
theorem gramDifference_nonnegative_iff_pseudoinverse_contraction
    {X Y Z : Type*}
    [SeminormedAddCommGroup Y] [SeminormedAddCommGroup Z]
    (Ahalf : X → Y) (W : X → Z) (pinv : Y → X)
    (rightOnRange : ∀ y ∈ Set.range Ahalf, Ahalf (pinv y) = y)
    (kernelFactor : ∀ x, W x = W (pinv (Ahalf x))) :
    (∀ x, 0 ≤ ‖Ahalf x‖ ^ 2 - ‖W x‖ ^ 2) ↔
      ∀ y ∈ Set.range Ahalf, ‖W (pinv y)‖ ≤ ‖y‖

-- Optimal Young parameters
noncomputable def youngEpsilon (h g C : ℝ) : ℝ :=
  (h - g + Real.sqrt ((h - g) ^ 2 + 4 * C ^ 2)) / 2

noncomputable def youngConstant (h g C : ℝ) : ℝ :=
  (h + g - Real.sqrt ((h - g) ^ 2 + 4 * C ^ 2)) / 2

-- Balanced margins
theorem h_sub_youngEpsilon (h g C : ℝ) :
    h - youngEpsilon h g C = youngConstant h g C

theorem g_sub_div_youngEpsilon {h g C : ℝ} (hC : 0 < C) :
    g - C ^ 2 / youngEpsilon h g C = youngConstant h g C

-- Solvability criterion
theorem youngConstant_nonnegative_iff_product
    {h g C : ℝ} (hh : 0 ≤ h) (hg : 0 ≤ g) :
    0 ≤ youngConstant h g C ↔ C ^ 2 ≤ h * g

theorem exists_young_split_iff_product
    {h g C : ℝ} (hC : 0 < C) :
    (∃ ε : ℝ, 0 < ε ∧ 0 ≤ h - ε ∧ 0 ≤ g - C ^ 2 / ε) ↔
      0 < h ∧ 0 < g ∧ C ^ 2 ≤ h * g
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides an exact, constructive solution to the 2-block diagonal dominance balancing problem for arbitrary seminormed spaces. Rather than relying on approximate iterative semidefinite programming (SDP) solvers, it supplies an exact algebraic certificate via radical expressions that Lean 4 can directly verify.
