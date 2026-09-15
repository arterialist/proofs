import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals

namespace BuildingBlocks.PhysicalContinuousArrival
open Real MeasureTheory
noncomputable section

def kernel (s : ℝ) : ℝ := exp (-s / 2) / (1 - exp (-2 * s))

theorem denominator_pos {s : ℝ} (hs : 0 < s) : 0 < 1 - exp (-2 * s) := by
  have h : exp (-2 * s) < exp 0 := exp_lt_exp.mpr (by linarith)
  simpa using sub_pos.mpr h

theorem kernel_nonneg {s : ℝ} (hs : 0 < s) : 0 ≤ kernel s :=
  div_nonneg (exp_nonneg _) (le_of_lt (denominator_pos hs))

theorem denominator_lower {s : ℝ} (hs : 0 < s) :
    2 * s / (1 + 2 * s) ≤ 1 - exp (-2 * s) := by
  have he := add_one_le_exp (2 * s)
  have hp := exp_pos (2 * s)
  have hd : 0 < 1 + 2 * s := by linarith
  rw [show -2 * s = -(2 * s) by ring, exp_neg, ← one_div,
    show 1 - 1 / exp (2 * s) = (exp (2 * s) - 1) / exp (2 * s) by field_simp]
  apply (div_le_div_iff₀ hd hp).mpr
  nlinarith

theorem kernel_rational_bound {s : ℝ} (hs : 0 < s) :
    kernel s ≤ exp (-s / 2) * ((1 + 2 * s) / (2 * s)) := by
  have hp : 0 < 2 * s / (1 + 2 * s) := div_pos (by linarith) (by linarith)
  have h := div_le_div_of_nonneg_left (exp_nonneg (-s / 2)) hp (denominator_lower hs)
  unfold kernel
  convert h using 1
  field_simp

theorem kernel_near_bound {s : ℝ} (hs : 0 < s) (hsmall : s ≤ 1) :
    kernel s ≤ (3 / 2 : ℝ) / s := by
  have he : exp (-s / 2) ≤ 1 := by
    simpa using exp_le_exp.mpr (show -s / 2 ≤ 0 by linarith)
  have hq : 0 ≤ (1 + 2 * s) / (2 * s) := by positivity
  calc
    kernel s ≤ exp (-s / 2) * ((1 + 2 * s) / (2 * s)) := kernel_rational_bound hs
    _ ≤ (1 + 2 * s) / (2 * s) := by simpa using mul_le_mul_of_nonneg_right he hq
    _ ≤ (3 / 2 : ℝ) / s := by
      apply (div_le_div_iff₀ (by linarith : 0 < 2 * s) hs).mpr
      nlinarith

theorem kernel_far_bound {s : ℝ} (hs : 1 ≤ s) :
    kernel s ≤ exp (-s / 2) / (1 - exp (-2)) := by
  have hp : 0 < 1 - exp (-2) := by
    simpa only [mul_one] using denominator_pos zero_lt_one
  have he : exp (-2 * s) ≤ exp (-2) := exp_le_exp.mpr (by linarith)
  exact div_le_div_of_nonneg_left (exp_nonneg _) hp (by linarith)

theorem truncated_boundary_majorant_integral {d : ℝ} (hd : 0 < d) :
    (∫ s : ℝ in d..1, (3 / 2 : ℝ) / s) = -(3 / 2 : ℝ) * log d := by
  simp only [div_eq_mul_inv]
  rw [intervalIntegral.integral_const_mul]
  rw [integral_inv_of_pos hd (by norm_num), one_div, log_inv]
  ring

theorem kernel_continuousOn : ContinuousOn kernel (Set.Ioi 0) := by
  have hn : Continuous (fun s : ℝ => exp (-s / 2)) := by fun_prop
  have hd : Continuous (fun s : ℝ => 1 - exp (-2 * s)) := by fun_prop
  intro s hs
  exact (hn.continuousAt.div hd.continuousAt
    (ne_of_gt (denominator_pos hs))).continuousWithinAt

theorem truncated_kernel_integral_bound {d : ℝ} (hd : 0 < d) (hd1 : d ≤ 1) :
    (∫ s : ℝ in d..1, kernel s) ≤ -(3 / 2 : ℝ) * log d := by
  have hsub : Set.Icc d 1 ⊆ Set.Ioi 0 := fun s hs => lt_of_lt_of_le hd hs.1
  have hk : IntervalIntegrable kernel volume d 1 := by
    apply ContinuousOn.intervalIntegrable
    rw [Set.uIcc_of_le hd1]
    exact kernel_continuousOn.mono hsub
  have hg : IntervalIntegrable (fun s : ℝ => (3 / 2 : ℝ) / s) volume d 1 := by
    apply ContinuousOn.intervalIntegrable
    rw [Set.uIcc_of_le hd1]
    exact continuousOn_const.div continuousOn_id
      (fun s hs => ne_of_gt (hsub hs))
  rw [← truncated_boundary_majorant_integral hd]
  exact intervalIntegral.integral_mono_on hd1 hk hg
    (fun s hs => kernel_near_bound (hsub hs) hs.2)

theorem kernel_far_integrable : IntegrableOn kernel (Set.Ioi 1) := by
  have hi : IntegrableOn (fun s : ℝ => exp (-s / 2) / (1 - exp (-2)))
      (Set.Ioi 1) := by
    have h := (integrableOn_exp_mul_Ioi (by norm_num : (-1 / 2 : ℝ) < 0) 1).div_const
      (1 - exp (-2))
    have heq : (fun s : ℝ => exp (-s / 2) / (1 - exp (-2))) =
        (fun s : ℝ => exp ((-1 / 2) * s) / (1 - exp (-2))) := by
      funext s
      congr 2
      ring
    rw [heq]
    exact h
  have hsub : Set.Ioi (1 : ℝ) ⊆ Set.Ioi 0 := by
    intro s hs
    exact lt_trans (by norm_num : (0 : ℝ) < 1) hs
  apply hi.mono' ((kernel_continuousOn.mono hsub).aestronglyMeasurable measurableSet_Ioi)
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with s hs
  rw [Real.norm_eq_abs, abs_of_nonneg (kernel_nonneg (hsub hs))]
  exact kernel_far_bound (le_of_lt hs)

#print axioms denominator_pos
#print axioms kernel_nonneg
#print axioms denominator_lower
#print axioms kernel_rational_bound
#print axioms kernel_near_bound
#print axioms kernel_far_bound
#print axioms truncated_boundary_majorant_integral
#print axioms kernel_continuousOn
#print axioms truncated_kernel_integral_bound
#print axioms kernel_far_integrable
end
end BuildingBlocks.PhysicalContinuousArrival
