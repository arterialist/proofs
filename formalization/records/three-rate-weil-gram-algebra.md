# First Formalization in Lean 4: Three-Exponential-Rate Weil Gram Determinant Bilinear Factorization

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 File:** [`formalization/BuildingBlocks/ThreeRateWeilGramAlgebra.lean`](../../formalization/BuildingBlocks/ThreeRateWeilGramAlgebra.lean)  
**Dependencies:** `Mathlib.Tactic`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

For three distinct causal exponential rates $a, b, c > 1/2$, the complete arithmetic Weil quadratic form evaluates to the symmetric $3 \times 3$ Gram matrix with diagonal entries $A/a, B/b, C/c$ and off-diagonal entries $\frac{A+B}{a+b}, \frac{A+C}{a+c}, \frac{B+C}{b+c}$, where $A = F(a), B = F(b), C = F(c)$ with $F(a) = \frac{\xi'}{\xi}(a+1/2)$.

This Lean 4 formalization machine-checks the exact algebraic structure of this determinant:
1. Clearing the positive rational denominator $a b c (a+b)^2 (a+c)^2 (b+c)^2$ yields the degree-8 polynomial `gramDetNumerator`.
2. The polynomial factors **bilinearly into the product of two second-divided-difference numerators**:
   \[
   \operatorname{gramDetNumerator}(a, b, c, A, B, C) = H_{\mathrm{num}}(a, b, c, A, B, C) \cdot J_{\mathrm{num}}(a, b, c, A, B, C),
   \]
   where:
   \[
   H_{\mathrm{num}} = aA(b^2-c^2) + bB(c^2-a^2) + cC(a^2-b^2),
   \]
   \[
   J_{\mathrm{num}} = aBC(b^2-c^2) + bAC(c^2-a^2) + cAB(a^2-b^2).
   \]
3. The exact rational determinant identity holds for all non-zero rates:
   \[
   \det [K(a_i, a_j)] = \frac{H_{\mathrm{num}} \cdot J_{\mathrm{num}}}{a b c (a+b)^2 (a+c)^2 (b+c)^2}.
   \]
4. Proves that positive rates $a, b, c > 0$ together with strict positivity of the two divided-difference numerators $H_{\mathrm{num}} > 0$ and $J_{\mathrm{num}} > 0$ strictly imply $\det [K(a_i, a_j)] > 0$.

---

## 2. Machine-Verified Theorems

### 2.1 Divided Difference Numerators and Exact Factorization

```lean
def hNumerator (a b c A B C : ℝ) : ℝ :=
  a * A * (b ^ 2 - c ^ 2) +
  b * B * (c ^ 2 - a ^ 2) +
  c * C * (a ^ 2 - b ^ 2)

def jNumerator (a b c A B C : ℝ) : ℝ :=
  a * B * C * (b ^ 2 - c ^ 2) +
  b * A * C * (c ^ 2 - a ^ 2) +
  c * A * B * (a ^ 2 - b ^ 2)

def gramDetNumerator (a b c A B C : ℝ) : ℝ :=
  A * B * C * (a + b) ^ 2 * (a + c) ^ 2 * (b + c) ^ 2 +
  2 * a * b * c * (A + B) * (A + C) * (B + C) *
      (a + b) * (a + c) * (b + c) -
  b * c * A * (B + C) ^ 2 * (a + b) ^ 2 * (a + c) ^ 2 -
  a * c * B * (A + C) ^ 2 * (a + b) ^ 2 * (b + c) ^ 2 -
  a * b * C * (A + B) ^ 2 * (a + c) ^ 2 * (b + c) ^ 2

theorem gram_det_numerator_factor (a b c A B C : ℝ) :
    gramDetNumerator a b c A B C =
      hNumerator a b c A B C * jNumerator a b c A B C

theorem gram_det_numerator_pos {a b c A B C : ℝ}
    (hH : 0 < hNumerator a b c A B C)
    (hJ : 0 < jNumerator a b c A B C) :
    0 < gramDetNumerator a b c A B C
```

### 2.2 Rational Determinant Formula and Positivity

```lean
noncomputable def gramDetFormula (a b c A B C : ℝ) : ℝ :=
  (A / a) * (B / b) * (C / c) +
  2 * ((A + B) / (a + b)) * ((A + C) / (a + c)) * ((B + C) / (b + c)) -
  (A / a) * ((B + C) / (b + c)) ^ 2 -
  (B / b) * ((A + C) / (a + c)) ^ 2 -
  (C / c) * ((A + B) / (a + b)) ^ 2

theorem gram_det_formula_factor (a b c A B C : ℝ)
    (ha : a ≠ 0) (hb : b ≠ 0) (hc : c ≠ 0)
    (hab : a + b ≠ 0) (hac : a + c ≠ 0) (hbc : b + c ≠ 0) :
    gramDetFormula a b c A B C =
      hNumerator a b c A B C * jNumerator a b c A B C /
        (a * b * c * (a + b) ^ 2 * (a + c) ^ 2 * (b + c) ^ 2)

theorem gram_det_formula_pos {a b c A B C : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (hH : 0 < hNumerator a b c A B C)
    (hJ : 0 < jNumerator a b c A B C) :
    0 < gramDetFormula a b c A B C
```

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/ThreeRateWeilGramAlgebra.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.ThreeRateWeilGramAlgebra.gram_det_numerator_factor' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ThreeRateWeilGramAlgebra.gram_det_numerator_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ThreeRateWeilGramAlgebra.gram_det_formula_factor' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ThreeRateWeilGramAlgebra.gram_det_formula_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All theorems depend strictly on foundational axioms with zero custom postulates.
