import BuildingBlocks.IntegerCarryPrimitiveAnalytic
import Mathlib.MeasureTheory.Function.Floor
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus

open Filter Set MeasureTheory
open scoped Topology

namespace BuildingBlocks.IntegerCarryPhase

theorem bernoulliOne_abs_le (x : ℝ) : |bernoulliOne x| ≤ 1 / 2 := by
  have h0 := Int.fract_nonneg x
  have h1 := Int.fract_lt_one x
  rw [abs_le]
  unfold bernoulliOne
  constructor <;> linarith

theorem phase_intervalIntegrable (r a b : ℝ) : IntervalIntegrable (phase r) volume a b := by
  have hm : Measurable (phase r) := by
    unfold phase bernoulliOne
    fun_prop
  apply (intervalIntegrable_const (c := |r| / 2 + 1 / 2)).mono_fun' hm.aestronglyMeasurable
  apply Eventually.of_forall
  intro x
  change ‖phase r x‖ ≤ |r| / 2 + 1 / 2
  rw [Real.norm_eq_abs]
  calc
    |phase r x| ≤ |r| * |bernoulliOne x| + |bernoulliOne (r * x)| := by
      simpa [phase, Real.norm_eq_abs, abs_mul] using norm_sub_le (r * bernoulliOne x) (bernoulliOne (r * x))
    _ ≤ |r| / 2 + 1 / 2 := by
      have h := mul_le_mul_of_nonneg_left (bernoulliOne_abs_le x) (abs_nonneg r)
      linarith [bernoulliOne_abs_le (r * x)]

theorem fract_hasDerivWithinAt_right (x : ℝ) :
    HasDerivWithinAt (Int.fract : ℝ → ℝ) 1 (Ioi x) x := by
  have hv : ∀ᶠ y in 𝓝[≥] x, ⌊y⌋ = ⌊x⌋ :=
    tendsto_pure.mp (tendsto_floor_right_pure_floor x)
  apply ((hasDerivAt_id x).sub_const (⌊x⌋ : ℝ)).hasDerivWithinAt.congr_of_eventuallyEq
  · filter_upwards [hv.filter_mono (nhdsWithin_mono x Ioi_subset_Ici_self)] with y hy
    simp only [Int.fract, hy, id_eq]
  · rfl

theorem unitPrimitive_hasDerivWithinAt_right (x : ℝ) :
    HasDerivWithinAt unitPrimitive (bernoulliOne x) (Ioi x) x := by
  have hf := fract_hasDerivWithinAt_right x
  convert ((hf.pow 2).sub hf).div_const 2 using 1
  simp only [bernoulliOne]
  ring

theorem primitiveFormula_hasDerivWithinAt_right (r x : ℝ) (hr : 0 < r) :
    HasDerivWithinAt (primitiveFormula r) (phase r x) (Ioi x) x := by
  have hm : MapsTo (fun y : ℝ => r * y) (Ioi x) (Ioi (r * x)) := by
    intro y hy
    exact mul_lt_mul_of_pos_left hy hr
  have h0 := (unitPrimitive_hasDerivWithinAt_right x).const_mul r
  have h1 := ((unitPrimitive_hasDerivWithinAt_right (r * x)).comp x
    ((hasDerivAt_id x).const_mul r).hasDerivWithinAt hm).div_const r
  convert h0.sub h1 using 1
  simp only [phase]
  field_simp

/-- Full interval identity, including all corners and the real-scale initial trace. -/
theorem phase_integral_eq_sub (r a b : ℝ) (hr : 0 < r) :
    (∫ x in a..b, phase r x) = primitiveFormula r b - primitiveFormula r a := by
  apply intervalIntegral.integral_eq_sub_of_hasDeriv_right
    (primitiveFormula_continuous r).continuousOn
  · intro x hx
    exact primitiveFormula_hasDerivWithinAt_right r x hr
  · exact phase_intervalIntegrable r a b

/-- Actual integer carry primitive, with its starting endpoint proved to vanish. -/
theorem phase_nat_integral (m : ℕ) (x : ℝ) (hm : 0 < m) :
    (∫ y in (1 : ℝ)..x, phase (m : ℝ) y) = primitiveFormula (m : ℝ) x := by
  rw [phase_integral_eq_sub (m : ℝ) 1 x (by exact_mod_cast hm)]
  have hz := primitiveFormula_nat_integer m 1
  simpa using hz

#print axioms bernoulliOne_abs_le
#print axioms phase_intervalIntegrable
#print axioms fract_hasDerivWithinAt_right
#print axioms unitPrimitive_hasDerivWithinAt_right
#print axioms primitiveFormula_hasDerivWithinAt_right
#print axioms phase_integral_eq_sub
#print axioms phase_nat_integral

end BuildingBlocks.IntegerCarryPhase
