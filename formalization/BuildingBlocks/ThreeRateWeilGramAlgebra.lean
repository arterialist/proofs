import Mathlib.Tactic

/-!
The denominator-cleared algebraic core of the three-exponential-rate
Weil Gram determinant. The analytic identification of its entries with
the actual completed-zeta form and the signs of the two divided
differences remain in the companion written proof. No zero-location or
Weil-positivity hypothesis is introduced here.
-/

namespace BuildingBlocks.ThreeRateWeilGramAlgebra

/-- Numerator of the second divided difference of `t ↦ √t F(√t)`
at `a²,b²,c²`, after clearing its Vandermonde denominator. -/
def hNumerator (a b c A B C : ℝ) : ℝ :=
  a * A * (b ^ 2 - c ^ 2) +
  b * B * (c ^ 2 - a ^ 2) +
  c * C * (a ^ 2 - b ^ 2)

/-- Numerator of the second divided difference of `t ↦ √t/F(√t)`
at `a²,b²,c²`, with `A*B*C` also cleared. -/
def jNumerator (a b c A B C : ℝ) : ℝ :=
  a * B * C * (b ^ 2 - c ^ 2) +
  b * A * C * (c ^ 2 - a ^ 2) +
  c * A * B * (a ^ 2 - b ^ 2)

/-- The numerator of the symmetric three-rate Gram determinant after
clearing the positive denominator
`a*b*c*(a+b)^2*(a+c)^2*(b+c)^2`. -/
def gramDetNumerator (a b c A B C : ℝ) : ℝ :=
  A * B * C * (a + b) ^ 2 * (a + c) ^ 2 * (b + c) ^ 2 +
  2 * a * b * c * (A + B) * (A + C) * (B + C) *
      (a + b) * (a + c) * (b + c) -
  b * c * A * (B + C) ^ 2 * (a + b) ^ 2 * (a + c) ^ 2 -
  a * c * B * (A + C) ^ 2 * (a + b) ^ 2 * (b + c) ^ 2 -
  a * b * C * (A + B) ^ 2 * (a + c) ^ 2 * (b + c) ^ 2

/-- The ordinary determinant expansion for the symmetric Gram matrix with
diagonal entries `A/a,B/b,C/c` and off-diagonal entries
`(A+B)/(a+b)`, `(A+C)/(a+c)`, `(B+C)/(b+c)`. -/
noncomputable def gramDetFormula (a b c A B C : ℝ) : ℝ :=
  (A / a) * (B / b) * (C / c) +
  2 * ((A + B) / (a + b)) * ((A + C) / (a + c)) * ((B + C) / (b + c)) -
  (A / a) * ((B + C) / (b + c)) ^ 2 -
  (B / b) * ((A + C) / (a + c)) ^ 2 -
  (C / c) * ((A + B) / (a + b)) ^ 2

/-- Clearing the actual Gram determinant's rational denominators gives
`gramDetNumerator`. -/
theorem gram_det_formula_numerator (a b c A B C : ℝ)
    (ha : a ≠ 0) (hb : b ≠ 0) (hc : c ≠ 0)
    (hab : a + b ≠ 0) (hac : a + c ≠ 0) (hbc : b + c ≠ 0) :
    gramDetFormula a b c A B C =
      gramDetNumerator a b c A B C /
        (a * b * c * (a + b) ^ 2 * (a + c) ^ 2 * (b + c) ^ 2) := by
  simp only [gramDetFormula, gramDetNumerator]
  field_simp

/-- Exact factorization behind the three-rate determinant reduction. -/
theorem gram_det_numerator_factor (a b c A B C : ℝ) :
    gramDetNumerator a b c A B C =
      hNumerator a b c A B C * jNumerator a b c A B C := by
  simp only [gramDetNumerator, hNumerator, jNumerator]
  ring

/-- Positive analytic divided-difference numerators make the cleared
Gram determinant positive. -/
theorem gram_det_numerator_pos {a b c A B C : ℝ}
    (hH : 0 < hNumerator a b c A B C)
    (hJ : 0 < jNumerator a b c A B C) :
    0 < gramDetNumerator a b c A B C := by
  rw [gram_det_numerator_factor]
  exact mul_pos hH hJ

/-- The exact rational factorization of the Gram determinant. -/
theorem gram_det_formula_factor (a b c A B C : ℝ)
    (ha : a ≠ 0) (hb : b ≠ 0) (hc : c ≠ 0)
    (hab : a + b ≠ 0) (hac : a + c ≠ 0) (hbc : b + c ≠ 0) :
    gramDetFormula a b c A B C =
      hNumerator a b c A B C * jNumerator a b c A B C /
        (a * b * c * (a + b) ^ 2 * (a + c) ^ 2 * (b + c) ^ 2) := by
  rw [gram_det_formula_numerator a b c A B C ha hb hc hab hac hbc]
  rw [gram_det_numerator_factor]

/-- Positive rates and the two divided-difference numerators give a
positive determinant for the rational Gram entries. -/
theorem gram_det_formula_pos {a b c A B C : ℝ}
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (hH : 0 < hNumerator a b c A B C)
    (hJ : 0 < jNumerator a b c A B C) :
    0 < gramDetFormula a b c A B C := by
  rw [gram_det_formula_factor a b c A B C
    (ne_of_gt ha) (ne_of_gt hb) (ne_of_gt hc)
    (ne_of_gt (add_pos ha hb)) (ne_of_gt (add_pos ha hc))
    (ne_of_gt (add_pos hb hc))]
  apply div_pos (mul_pos hH hJ)
  positivity

end BuildingBlocks.ThreeRateWeilGramAlgebra

#print axioms BuildingBlocks.ThreeRateWeilGramAlgebra.gram_det_numerator_factor
#print axioms BuildingBlocks.ThreeRateWeilGramAlgebra.gram_det_numerator_pos
#print axioms BuildingBlocks.ThreeRateWeilGramAlgebra.gram_det_formula_factor
#print axioms BuildingBlocks.ThreeRateWeilGramAlgebra.gram_det_formula_pos
