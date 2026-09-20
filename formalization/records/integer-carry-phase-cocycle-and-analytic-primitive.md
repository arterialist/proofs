# First Formalization in Lean 4: Integer Carry Phase Cocycle and Analytic Primitive

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 Files:** [`formalization/BuildingBlocks/IntegerCarryPhase.lean`](../../formalization/BuildingBlocks/IntegerCarryPhase.lean), [`formalization/BuildingBlocks/IntegerCarryPrimitiveAnalytic.lean`](../../formalization/BuildingBlocks/IntegerCarryPrimitiveAnalytic.lean)  
**Dependencies:** `Mathlib.Algebra.Order.Floor.Ring`, `Mathlib.Topology.Algebra.Order.Floor`, `Mathlib.Analysis.Calculus.Deriv.Basic`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

The integer-scale carry phase:
\[
\operatorname{phase}(r, x) = r \cdot B_1(x) - B_1(rx), \qquad B_1(x) = \{x\} - 1/2,
\]
represents the normalized discrepancy between dilated fractional parts. At integer scales $m \in \mathbb{N}$, it coincides with the discrete floor carry $\lfloor m\{x\}\rfloor - \frac{m-1}{2}$.

This Lean 4 formalization establishes:
1. **Unit Parabolic Bounds:** Proves $-1/8 \le u(x) \le 0$ for $u(x) = (\{x\}^2 - \{x\})/2$.
2. **Multiplicative Cocycle:** Proves the exact dilation cocycle:
   \[
   \operatorname{phase}(rs, x) = s \operatorname{phase}(r, x) + \operatorname{phase}(s, rx).
   \]
3. **Floor Representation:** Proves $\operatorname{phase}(m, x) = \lfloor m\{x\}\rfloor - (m-1)/2$ using exact fractional-part arithmetic `fract_nat_mul_fract`.
4. **Primitive Cocycle and Integer Root Identity:** Proves that the continuous primitive $P(r, x) = r u(x) - u(rx)/r$ satisfies:
   \[
   P(rs, x) = s P(r, x) + P(s, rx)/r,
   \]
   and vanishes at all natural integers $P(m, N) = 0$.
5. **Analytic Regularity across Corners:** Proves global continuity `primitiveFormula_continuous` and almost-everywhere differentiability `primitiveFormula_hasDerivAt` producing $\operatorname{phase}(r, x)$ off integer and fractional corners.
6. **Uniform Limiting Error:** Proves the two-sided uniform error bounds:
   \[
   0 \le -u(x) - \frac{-P(r, x)}{r} \le \frac{1}{8r^2}.
   \]

---

## 2. Machine-Verified Theorems

```lean
noncomputable def bernoulliOne (x : ℝ) : ℝ := Int.fract x - 1 / 2
noncomputable def unitPrimitive (x : ℝ) : ℝ := ((Int.fract x) ^ 2 - Int.fract x) / 2
noncomputable def phase (r x : ℝ) : ℝ := r * bernoulliOne x - bernoulliOne (r * x)
noncomputable def primitiveFormula (r x : ℝ) : ℝ := r * unitPrimitive x - unitPrimitive (r * x) / r

theorem unitPrimitive_bounds (x : ℝ) : -1 / 8 ≤ unitPrimitive x ∧ unitPrimitive x ≤ 0

theorem phase_mul_cocycle (r s x : ℝ) :
    phase (r * s) x = s * phase r x + phase s (r * x)

theorem fract_nat_mul_fract (m : ℕ) (x : ℝ) :
    Int.fract ((m : ℝ) * Int.fract x) = Int.fract ((m : ℝ) * x)

theorem phase_nat_floor (m : ℕ) (x : ℝ) :
    phase (m : ℝ) x = (⌊(m : ℝ) * Int.fract x⌋ : ℝ) - ((m : ℝ) - 1) / 2

theorem primitiveFormula_nat_integer (m N : ℕ) :
    primitiveFormula (m : ℝ) (N : ℝ) = 0

theorem primitiveFormula_mul_cocycle (r s x : ℝ) (hr : r ≠ 0) (hs : s ≠ 0) :
    primitiveFormula (r * s) x = s * primitiveFormula r x + primitiveFormula s (r * x) / r

theorem primitiveFormula_normalized_error (r x : ℝ) (hr : 0 < r) :
    0 ≤ -unitPrimitive x - (-primitiveFormula r x) / r ∧
    -unitPrimitive x - (-primitiveFormula r x) / r ≤ 1 / (8 * r ^ 2)

theorem unitPrimitive_continuous : Continuous unitPrimitive

theorem primitiveFormula_continuous (r : ℝ) : Continuous (primitiveFormula r)

theorem primitiveFormula_hasDerivAt (r x : ℝ) (hr : r ≠ 0)
    (hx : x ≠ (⌊x⌋ : ℝ)) (hrx : r * x ≠ (⌊r * x⌋ : ℝ)) :
    HasDerivAt (primitiveFormula r) (phase r x) x
```

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/IntegerCarryPhase.lean
lake env lean formalization/BuildingBlocks/IntegerCarryPrimitiveAnalytic.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.IntegerCarryPhase.unitPrimitive_bounds' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.IntegerCarryPhase.phase_mul_cocycle' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.IntegerCarryPhase.phase_nat_floor' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.IntegerCarryPhase.primitiveFormula_nat_integer' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.IntegerCarryPhase.primitiveFormula_mul_cocycle' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.IntegerCarryPhase.primitiveFormula_normalized_error' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.IntegerCarryPhase.primitiveFormula_continuous' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.IntegerCarryPhase.primitiveFormula_hasDerivAt' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All theorems depend strictly on foundational axioms with zero custom postulates.
