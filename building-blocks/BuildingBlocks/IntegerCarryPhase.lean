import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Tactic

namespace BuildingBlocks.IntegerCarryPhase

noncomputable def bernoulliOne (x : ℝ) : ℝ := Int.fract x - 1 / 2
noncomputable def unitPrimitive (x : ℝ) : ℝ := ((Int.fract x) ^ 2 - Int.fract x) / 2
noncomputable def phase (r x : ℝ) : ℝ := r * bernoulliOne x - bernoulliOne (r * x)
/-- The published closed formula, identified with the phase integral in IntegerCarryPrimitiveIntegral. -/
noncomputable def primitiveFormula (r x : ℝ) : ℝ := r * unitPrimitive x - unitPrimitive (r * x) / r

theorem unitPrimitive_bounds (x : ℝ) : -1 / 8 ≤ unitPrimitive x ∧ unitPrimitive x ≤ 0 := by
  have h0 := Int.fract_nonneg x
  have h1 := Int.fract_lt_one x
  unfold unitPrimitive
  constructor
  · nlinarith [sq_nonneg (Int.fract x - 1 / 2)]
  · nlinarith [mul_nonneg h0 (sub_nonneg.mpr h1.le)]

theorem phase_mul_cocycle (r s x : ℝ) :
    phase (r * s) x = s * phase r x + phase s (r * x) := by
  unfold phase
  rw [show s * (r * x) = (r * s) * x by ring]
  ring

theorem fract_nat_mul_fract (m : ℕ) (x : ℝ) :
    Int.fract ((m : ℝ) * Int.fract x) = Int.fract ((m : ℝ) * x) := by
  have he : (m : ℝ) * Int.fract x = (m : ℝ) * x - ((m : ℤ) * ⌊x⌋ : ℤ) := by
    simp only [Int.fract, Int.cast_mul, Int.cast_natCast]
    ring
  rw [he, Int.fract_sub_intCast]

/-- Actual integer floor carry, including right-continuous endpoints. -/
theorem phase_nat_floor (m : ℕ) (x : ℝ) :
    phase (m : ℝ) x = (⌊(m : ℝ) * Int.fract x⌋ : ℝ) - ((m : ℝ) - 1) / 2 := by
  have hf := fract_nat_mul_fract m x
  rw [Int.fract] at hf
  unfold phase bernoulliOne
  linarith

theorem primitiveFormula_nat_integer (m N : ℕ) :
    primitiveFormula (m : ℝ) (N : ℝ) = 0 := by
  unfold primitiveFormula unitPrimitive
  rw [← Nat.cast_mul, Int.fract_natCast, Int.fract_natCast]
  simp

theorem primitiveFormula_mul_cocycle (r s x : ℝ) (hr : r ≠ 0) (hs : s ≠ 0) :
    primitiveFormula (r * s) x = s * primitiveFormula r x + primitiveFormula s (r * x) / r := by
  unfold primitiveFormula
  rw [show s * (r * x) = (r * s) * x by ring]
  field_simp
  ring

/-- Uniform normalized error, retaining the complete dilated fractional-part term. -/
theorem primitiveFormula_normalized_error (r x : ℝ) (hr : 0 < r) :
    0 ≤ -unitPrimitive x - (-primitiveFormula r x) / r ∧
    -unitPrimitive x - (-primitiveFormula r x) / r ≤ 1 / (8 * r ^ 2) := by
  have hb := unitPrimitive_bounds (r * x)
  have he : -unitPrimitive x - (-primitiveFormula r x) / r =
      -unitPrimitive (r * x) / r ^ 2 := by
    unfold primitiveFormula
    field_simp
    ring
  rw [he]
  constructor
  · exact div_nonneg (by linarith [hb.2]) (sq_nonneg r)
  · apply (div_le_iff₀ (sq_pos_of_pos hr)).mpr
    field_simp
    nlinarith [hb.1]

#print axioms unitPrimitive_bounds
#print axioms phase_mul_cocycle
#print axioms fract_nat_mul_fract
#print axioms phase_nat_floor
#print axioms primitiveFormula_nat_integer
#print axioms primitiveFormula_mul_cocycle
#print axioms primitiveFormula_normalized_error

end BuildingBlocks.IntegerCarryPhase
