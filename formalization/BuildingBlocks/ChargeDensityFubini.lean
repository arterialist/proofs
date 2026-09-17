import BuildingBlocks.SuccessorChargeEnergy
import Mathlib.MeasureTheory.Integral.Prod

open MeasureTheory Set Filter

namespace BuildingBlocks.ChargeDensityFubini

open BuildingBlocks.SuccessorCharge

noncomputable def betaReal (y v : ℝ) : ℝ :=
  (Iic (Real.exp v)).indicator (fun _ => Real.exp (-v / 2)) y

noncomputable def kernelBirth (p : ℝ × ℝ) : ℝ := kernel p.1 * betaReal p.2 p.1

theorem kernelBirth_measurable : Measurable kernelBirth := by
  have hm : MeasurableSet {p : ℝ × ℝ | p.2 ≤ Real.exp p.1} :=
    measurableSet_le measurable_snd (Real.measurable_exp.comp measurable_fst)
  have h : kernelBirth = {p : ℝ × ℝ | p.2 ≤ Real.exp p.1}.indicator
      (fun p => kernel p.1 * Real.exp (-p.1 / 2)) := by
    funext p
    simp [kernelBirth, betaReal, Set.indicator]
  rw [h]
  exact ((measurable_kernel.comp measurable_fst).mul (by fun_prop)).indicator hm

theorem betaReal_integral {v : ℝ} (hv : 0 ≤ v) :
    (∫ y in Ioi (1 : ℝ), betaReal y v) = (Real.exp v - 1) * Real.exp (-v / 2) := by
  unfold betaReal
  rw [setIntegral_indicator measurableSet_Iic]
  have hi : Ioi (1 : ℝ) ∩ Iic (Real.exp v) = Ioc 1 (Real.exp v) := by ext y; simp
  rw [hi, setIntegral_const]
  have he : 1 ≤ Real.exp v := by simpa using Real.exp_le_exp.mpr hv
  simp [sub_nonneg.mpr he]

theorem kernelBirth_fiber_integrable (v : ℝ) :
    IntegrableOn (fun y => kernelBirth (v, y)) (Ioi (1 : ℝ)) := by
  have hi : Integrable ((Ioc (1 : ℝ) (Real.exp v)).indicator
      (fun _ : ℝ => kernel v * Real.exp (-v / 2))) :=
    (integrableOn_const (s := Ioc (1 : ℝ) (Real.exp v)) (by simp)).integrable_indicator measurableSet_Ioc
  apply hi.integrableOn.congr
  filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with y hy
  change (1 : ℝ) < y at hy
  simp [kernelBirth, betaReal, Set.indicator, hy]

theorem kernelBirth_fiber_norm {v : ℝ} (hv : 0 ≤ v) :
    (∫ y in Ioi (1 : ℝ), ‖kernelBirth (v, y)‖) =
      |kernel v| * ((Real.exp v - 1) * Real.exp (-v / 2)) := by
  simp only [kernelBirth, norm_mul, Real.norm_eq_abs]
  have hnon (y : ℝ) : 0 ≤ betaReal y v := by simp [betaReal, Set.indicator]; positivity
  simp_rw [abs_of_nonneg (hnon _)]
  rw [integral_const_mul, betaReal_integral hv]

/-- The full original kernel-density product is absolutely integrable, with y beginning at one. -/
theorem original_density_joint_integrable :
    Integrable kernelBirth ((volume.restrict (Ioi (0 : ℝ))).prod (volume.restrict (Ioi (1 : ℝ)))) := by
  have hmeas : AEStronglyMeasurable kernelBirth
      ((volume.restrict (Ioi (0 : ℝ))).prod (volume.restrict (Ioi (1 : ℝ)))) :=
    kernelBirth_measurable.aestronglyMeasurable
  apply (integrable_prod_iff hmeas).2
  constructor
  · exact Eventually.of_forall kernelBirth_fiber_integrable
  · have hm := hmeas.norm.integral_prod_right'
    apply (reference_integrable.const_mul 2).mono' hm
    filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with v hv
    change 0 < v at hv
    have he : 1 ≤ Real.exp v := by simpa using Real.exp_le_exp.mpr hv.le
    rw [kernelBirth_fiber_norm hv.le, Real.norm_eq_abs, abs_of_nonneg
      (mul_nonneg (abs_nonneg _) (mul_nonneg (sub_nonneg.mpr he) (Real.exp_pos _).le))]
    calc
      _ ≤ (2 * Real.exp (-v)) * (Real.exp v * Real.exp (-v / 2)) :=
        mul_le_mul (kernel_abs_le_exp v)
          (mul_le_mul_of_nonneg_right (by linarith : Real.exp v - 1 ≤ Real.exp v) (Real.exp_pos _).le)
          (mul_nonneg (sub_nonneg.mpr he) (Real.exp_pos _).le) (by positivity)
      _ = _ := by
        calc
          _ = 2 * (Real.exp (-v) * Real.exp v) * Real.exp (-v / 2) := by ring
          _ = _ := by rw [← Real.exp_add, neg_add_cancel, Real.exp_zero]; ring

/-- Fubini uses the original kernel and its one-half factor, even though the density source is not L1. -/
theorem original_density_charge_interchange :
    defect (fun v => ∫ y in Ioi (1 : ℝ), betaReal y v) =
      ∫ y in Ioi (1 : ℝ), defect (fun v => betaReal y v) := by
  have hs := integral_integral_swap (μ := volume.restrict (Ioi (0 : ℝ)))
    (ν := volume.restrict (Ioi (1 : ℝ)))
    (f := fun v y => kernel v * betaReal y v) original_density_joint_integrable
  calc
    _ = (1 / 2 : ℝ) * ∫ v in Ioi (0 : ℝ), ∫ y in Ioi (1 : ℝ), kernel v * betaReal y v := by
      unfold defect
      congr 1
      apply integral_congr_ae
      exact Eventually.of_forall (fun v => (integral_const_mul (kernel v) (fun y => betaReal y v)).symm)
    _ = (1 / 2 : ℝ) * ∫ y in Ioi (1 : ℝ), ∫ v in Ioi (0 : ℝ), kernel v * betaReal y v := congrArg (fun r : ℝ => (1 / 2 : ℝ) * r) hs
    _ = _ := by unfold defect; rw [integral_const_mul]

#print axioms original_density_joint_integrable
#print axioms original_density_charge_interchange

/-- The literal continuum density is evaluated only on the original causal integration domain. -/
theorem original_density_charge_formula :
    defect (fun v => (Real.exp v - 1) * Real.exp (-v / 2)) =
      ∫ y in Ioi (1 : ℝ), defect (fun v => betaReal y v) := by
  rw [← original_density_charge_interchange]
  unfold defect
  congr 1
  apply integral_congr_ae
  filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with v hv
  change 0 < v at hv
  rw [betaReal_integral hv.le]

#print axioms original_density_charge_formula

end BuildingBlocks.ChargeDensityFubini
