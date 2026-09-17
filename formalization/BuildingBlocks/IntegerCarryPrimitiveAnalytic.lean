import BuildingBlocks.IntegerCarryPhase
import Mathlib.Topology.Algebra.Order.Floor
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Calculus.Deriv.Mul

open Filter Set
open scoped Topology

namespace BuildingBlocks.IntegerCarryPhase

theorem unitPrimitive_continuous : Continuous unitPrimitive := by
  have hc : Continuous (fun y : ℝ => (y ^ 2 - y) / 2) := by fun_prop
  have hh := hc.continuousOn.comp_fract'' (by norm_num)
  exact hh

/-- Fractional parts have derivative one away from integer endpoints. -/
theorem fract_hasDerivAt (x : ℝ) (hx : x ≠ (⌊x⌋ : ℝ)) :
    HasDerivAt (Int.fract : ℝ → ℝ) 1 x := by
  have hn : Ico (⌊x⌋ : ℝ) ((⌊x⌋ : ℝ) + 1) ∈ 𝓝 x :=
    Ico_mem_nhds ((Int.floor_le x).lt_of_ne hx.symm) (Int.lt_floor_add_one x)
  apply ((hasDerivAt_id x).sub_const (⌊x⌋ : ℝ)).congr_of_eventuallyEq
  filter_upwards [hn] with y hy
  simp only [Int.fract, Int.floor_eq_on_Ico ⌊x⌋ y hy, id_eq]

theorem unitPrimitive_hasDerivAt (x : ℝ) (hx : x ≠ (⌊x⌋ : ℝ)) :
    HasDerivAt unitPrimitive (bernoulliOne x) x := by
  have hf := fract_hasDerivAt x hx
  convert ((hf.pow 2).sub hf).div_const 2 using 1
  simp only [bernoulliOne]
  ring

theorem primitiveFormula_continuous (r : ℝ) : Continuous (primitiveFormula r) := by
  have hi : Continuous (fun x : ℝ => r * x) := continuous_const.mul continuous_id
  exact (continuous_const.mul unitPrimitive_continuous).sub
    ((unitPrimitive_continuous.comp hi).div_const r)

/-- The derivative is the literal phase outside integer and dilated-integer corners. -/
theorem primitiveFormula_hasDerivAt (r x : ℝ) (hr : r ≠ 0)
    (hx : x ≠ (⌊x⌋ : ℝ)) (hrx : r * x ≠ (⌊r * x⌋ : ℝ)) :
    HasDerivAt (primitiveFormula r) (phase r x) x := by
  have h0 := (unitPrimitive_hasDerivAt x hx).const_mul r
  have h1 := ((unitPrimitive_hasDerivAt (r * x) hrx).comp x
    ((hasDerivAt_id x).const_mul r)).div_const r
  convert h0.sub h1 using 1
  simp only [phase]
  field_simp

#print axioms unitPrimitive_continuous
#print axioms fract_hasDerivAt
#print axioms unitPrimitive_hasDerivAt
#print axioms primitiveFormula_continuous
#print axioms primitiveFormula_hasDerivAt

end BuildingBlocks.IntegerCarryPhase
