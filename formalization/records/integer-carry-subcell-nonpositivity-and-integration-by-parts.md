# First Formalization in Lean 4: Integer Carry Subcell Nonpositivity and Integration by Parts

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 Files:** [`formalization/BuildingBlocks/IntegerCarryPrimitiveBounds.lean`](../../formalization/BuildingBlocks/IntegerCarryPrimitiveBounds.lean), [`formalization/BuildingBlocks/IntegerCarryPrimitiveIntegral.lean`](../../formalization/BuildingBlocks/IntegerCarryPrimitiveIntegral.lean), [`formalization/BuildingBlocks/IntegerCarryIntegrationByParts.lean`](../../formalization/BuildingBlocks/IntegerCarryIntegrationByParts.lean)  
**Dependencies:** `Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus`, `Mathlib.Analysis.Calculus.ContDiff.Basic`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

This Lean 4 formalization resolves the global sign and boundary dynamics of the integer carry primitive $\Xi_m(x)$ and its action on test functions:
1. **Subcell Product Bound:** Proves the algebraic inequality $s(1-s) \le (j+s)(m-j-s)$ for $0 \le j \le m-1$ and $0 \le s \le 1$.
2. **Unconditional Nonpositivity on $\mathbb{R}$:** Machine-verifies that for every integer $m \ge 1$ and every real point $x \in \mathbb{R}$:
   \[
   -\frac{m}{8} \le \operatorname{primitiveFormula}(m, x) \le 0.
   \]
3. **Real-Scale Counterexample:** Proves $\operatorname{primitiveFormula}(3/2, 1) = 1/12 > 0$, formally demonstrating that integer arithmetic is indispensable for nonpositivity.
4. **Fundamental Theorem of Calculus across Corners:** Formulates one-sided right derivatives `primitiveFormula_hasDerivWithinAt_right` to prove the interval integral identity $\int_a^b \operatorname{phase}(r, x) dx = P(r, b) - P(r, a)$, and shows that the definite integral from the unit origin $\int_1^x \operatorname{phase}(m, y) dy = P(m, x)$ is unconditionally nonpositive:
   \[
   -\frac{m}{8} \le \int_1^x \operatorname{phase}(m, y) dy \le 0 \qquad (\forall x \in \mathbb{R}).
   \]
5. **Exact Integration by Parts with Zero Initial Boundary:** Formalizes:
   \[
   \int_1^X \operatorname{phase}(m, x) g(x) dx = P(m, X) g(X) - \int_1^X P(m, x) g'(x) dx,
   \]
   proving that the initial boundary term vanishes identically for integer scales ($P(m, 1) = 0$), in contrast to real scales which carry the nonzero origin trace $u(r)g(1)/r$.

---

## 2. Machine-Verified Theorems

```lean
theorem subcell_product_bound (m j s : ℝ) (hj : 0 ≤ j) (hjm : j + 1 ≤ m)
    (hs0 : 0 ≤ s) (hs1 : s ≤ 1) :
    s * (1 - s) ≤ (j + s) * (m - j - s)

theorem primitiveFormula_lower (r x : ℝ) (hr : 0 < r) :
    -r / 8 ≤ primitiveFormula r x

theorem primitiveFormula_nat_nonpos (m : ℕ) (x : ℝ) (hm : 0 < m) :
    primitiveFormula (m : ℝ) x ≤ 0

theorem primitiveFormula_nat_bounds (m : ℕ) (x : ℝ) (hm : 0 < m) :
    -(m : ℝ) / 8 ≤ primitiveFormula (m : ℝ) x ∧ primitiveFormula (m : ℝ) x ≤ 0

theorem phase_nat_integral_bounds (m : ℕ) (x : ℝ) (hm : 0 < m) :
    -(m : ℝ) / 8 ≤ (∫ y in (1 : ℝ)..x, phase (m : ℝ) y) ∧
    (∫ y in (1 : ℝ)..x, phase (m : ℝ) y) ≤ 0

theorem primitiveFormula_three_halves_one : primitiveFormula (3 / 2) 1 = 1 / 12

theorem phase_nat_integral (m : ℕ) (x : ℝ) (hm : 0 < m) :
    (∫ y in (1 : ℝ)..x, phase (m : ℝ) y) = primitiveFormula (m : ℝ) x

theorem phase_nat_integrationByParts_from_one (m : ℕ) (X : ℝ) (hm : 0 < m)
    (g : ℝ → ℝ) (hg : ContDiff ℝ 1 g) :
    (∫ x in (1 : ℝ)..X, phase (m : ℝ) x * g x) =
      primitiveFormula (m : ℝ) X * g X -
        ∫ x in (1 : ℝ)..X, primitiveFormula (m : ℝ) x * deriv g x
```

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/IntegerCarryPrimitiveBounds.lean
lake env lean formalization/BuildingBlocks/IntegerCarryIntegrationByParts.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.IntegerCarryPhase.subcell_product_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.IntegerCarryPhase.primitiveFormula_nat_nonpos' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.IntegerCarryPhase.primitiveFormula_nat_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.IntegerCarryPhase.phase_nat_integral_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.IntegerCarryPhase.primitiveFormula_three_halves_one' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.IntegerCarryPhase.phase_nat_integrationByParts_from_one' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All theorems depend strictly on foundational axioms with zero custom postulates.
