import Mathlib.Analysis.SpecialFunctions.Trigonometric.Series
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Tactic

namespace BuildingBlocks.AdditiveHeatWeight

theorem quadratic_le_cosh (x : ℝ) : 1 + x ^ 2 / 2 ≤ Real.cosh x := by
  have h := (Real.hasSum_cosh x).summable.sum_le_tsum (Finset.range 2)
    (fun i _ => div_nonneg (by rw [pow_mul]; exact pow_nonneg (sq_nonneg x) i)
      (Nat.cast_nonneg _))
  rw [← Real.cosh_eq_tsum] at h
  norm_num [Finset.sum_range_succ] at h
  exact h

theorem physical_denominator_le_cosh (ξ : ℝ) :
    1 + 4 * ξ ^ 2 ≤ Real.cosh (Real.pi * ξ) := by
  have hp : 8 ≤ Real.pi ^ 2 := by nlinarith [Real.pi_gt_three]
  have hm := mul_nonneg (sub_nonneg.mpr hp) (sq_nonneg ξ)
  have hc := quadratic_le_cosh (Real.pi * ξ)
  nlinarith

theorem heat_weight_le_physical (ξ : ℝ) :
    Real.pi / Real.cosh (Real.pi * ξ) ≤
      (Real.pi / 4) / (1 / 4 + ξ ^ 2) := by
  have hd : 0 < (1 : ℝ) / 4 + ξ ^ 2 := by positivity
  have hc := physical_denominator_le_cosh ξ
  have hcp : 0 < Real.cosh (Real.pi * ξ) := Real.cosh_pos _
  apply (div_le_div_iff₀ hcp hd).mpr
  have hm := mul_nonneg Real.pi_pos.le (sub_nonneg.mpr hc)
  nlinarith

theorem weighted_heat_le_physical (ξ w : ℝ) (hw : 0 ≤ w) :
    (Real.pi / Real.cosh (Real.pi * ξ)) * w ≤
      ((Real.pi / 4) / (1 / 4 + ξ ^ 2)) * w :=
  mul_le_mul_of_nonneg_right (heat_weight_le_physical ξ) hw

#print axioms quadratic_le_cosh
#print axioms physical_denominator_le_cosh
#print axioms heat_weight_le_physical
#print axioms weighted_heat_le_physical

end BuildingBlocks.AdditiveHeatWeight
