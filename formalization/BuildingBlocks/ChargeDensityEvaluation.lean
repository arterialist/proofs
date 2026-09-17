import BuildingBlocks.ChargeOriginalBirth
import BuildingBlocks.ChargeDensityFubini

open MeasureTheory Set Filter
open scoped Interval Topology

namespace BuildingBlocks.ChargeDensityEvaluation

open BuildingBlocks.SuccessorCharge

noncomputable def cutoff (R v : ℝ) : ℝ :=
  (Iic (Real.log R)).indicator (fun v => Real.exp (v / 2)) v

theorem cutoff_integrable {R : ℝ} (_hR : 1 ≤ R) : IntegrableOn (cutoff R) (Ioi (0 : ℝ)) := by
  have hi : Integrable ((Ioc (0 : ℝ) (Real.log R)).indicator (fun v => Real.exp (v / 2))) :=
    ((by fun_prop : Continuous (fun v : ℝ => Real.exp (v / 2))).integrableOn_Icc.mono_set Ioc_subset_Icc_self).integrable_indicator measurableSet_Ioc
  apply hi.integrableOn.congr
  filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with v hv
  change 0 < v at hv
  simp [cutoff, Set.indicator, hv]

theorem cutoff_mass {R : ℝ} (hR : 1 ≤ R) :
    (∫ v in Ioi (0 : ℝ), cutoff R v) = 2 * (Real.sqrt R - 1) := by
  have hR0 : 0 < R := by linarith
  have hl : 0 ≤ Real.log R := Real.log_nonneg hR
  unfold cutoff
  rw [setIntegral_indicator measurableSet_Iic]
  have hi : Ioi (0 : ℝ) ∩ Iic (Real.log R) = Ioc 0 (Real.log R) := by ext v; simp
  rw [hi, ← intervalIntegral.integral_of_le hl]
  have hd (v : ℝ) : HasDerivAt (fun v : ℝ => 2 * Real.exp (v / 2)) (Real.exp (v / 2)) v := by
    convert (((hasDerivAt_id v).div_const 2).exp.const_mul 2) using 1
    norm_num [id_eq]
    ring
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt
    (fun v _ => hd v) ((by fun_prop : Continuous (fun v : ℝ => Real.exp (v / 2))).intervalIntegrable _ _)]
  rw [Real.exp_half, Real.exp_log hR0]
  norm_num
  ring

theorem successor_cutoff {R : ℝ} (hR : 2 ≤ R) : successor (cutoff R) = cutoff (R - 1) := by
  funext v
  have hR0 : 0 < R := by linarith
  have hRm : 0 < R - 1 := by linarith
  have hy : 0 < 1 + Real.exp v := by positivity
  have hs : Real.sqrt (1 + Real.exp v) ≠ 0 := (Real.sqrt_pos.mpr hy).ne'
  have hc : Real.log (1 + Real.exp v) ≤ Real.log R ↔ v ≤ Real.log (R - 1) := by
    rw [Real.log_le_log_iff hy hR0, Real.le_log_iff_exp_le hRm]
    constructor <;> intro h <;> linarith
  unfold successor amplitude jacobian sigma cutoff
  simp only [Set.indicator, mem_Iic]
  simp only [hc]
  split_ifs
  · rw [Real.exp_half, Real.exp_log hy, Real.sqrt_div (Real.exp_pos v).le]
    rw [div_mul_cancel₀ _ hs, Real.exp_half]
  · simp

theorem cutoff_defect {R : ℝ} (hR : 2 ≤ R) :
    defect (cutoff R) = Real.sqrt (R - 1) - Real.sqrt R := by
  rw [defect_eq_charge_difference (cutoff_integrable (by linarith)), successor_cutoff hR]
  unfold charge
  rw [cutoff_mass (by linarith : 1 ≤ R - 1), cutoff_mass (by linarith : 1 ≤ R)]
  ring

theorem kernel_growth_integrable :
    IntegrableOn (fun v => kernel v * Real.exp (v / 2)) (Ioi (0 : ℝ)) := by
  apply (reference_integrable.const_mul 2).mono' ((measurable_kernel.mul (by fun_prop)).aestronglyMeasurable)
  exact Eventually.of_forall (fun v => by
    rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_of_pos (Real.exp_pos _)]
    calc
      _ ≤ (2 * Real.exp (-v)) * Real.exp (v / 2) := mul_le_mul_of_nonneg_right (kernel_abs_le_exp v) (Real.exp_pos _).le
      _ = _ := by rw [mul_assoc, ← Real.exp_add]; congr 2; ring)

#print axioms cutoff_defect
#print axioms kernel_growth_integrable

theorem original_defect_growth : defect (fun v : ℝ => Real.exp (v / 2)) = 0 := by
  have hd : Tendsto (fun R : ℝ => defect (cutoff R)) atTop
      (𝓝 (defect (fun v : ℝ => Real.exp (v / 2)))) := by
    unfold defect
    apply Tendsto.const_mul
    apply tendsto_integral_filter_of_dominated_convergence
      (fun v : ℝ => 2 * Real.exp (-v / 2))
    · exact Eventually.of_forall (fun R => (measurable_kernel.mul
        (((by fun_prop : Measurable (fun v : ℝ => Real.exp (v / 2))).indicator measurableSet_Iic))).aestronglyMeasurable)
    · apply Eventually.of_forall
      intro R
      exact Eventually.of_forall (fun v => by
        unfold cutoff
        simp only [Set.indicator, mem_Iic]
        split_ifs
        · rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_of_pos (Real.exp_pos _)]
          calc
            _ ≤ (2 * Real.exp (-v)) * Real.exp (v / 2) := mul_le_mul_of_nonneg_right (kernel_abs_le_exp v) (Real.exp_pos _).le
            _ = _ := by rw [mul_assoc, ← Real.exp_add]; congr 2; ring
        · simp only [mul_zero, norm_zero]
          positivity)
    · exact reference_integrable.const_mul 2
    · apply Eventually.of_forall
      intro v
      apply tendsto_const_nhds.congr'
      filter_upwards [eventually_ge_atTop (max 2 (Real.exp v))] with R hR
      have hR0 : 0 < R := by linarith [le_max_left (2 : ℝ) (Real.exp v)]
      have hv : v ≤ Real.log R := (Real.le_log_iff_exp_le hR0).mpr ((le_max_right _ _).trans hR)
      simp [cutoff, hv]
  have hs : Tendsto Real.sqrt atTop atTop := by
    change Tendsto (fun x : ℝ => Real.sqrt x) atTop atTop
    simpa only [Real.sqrt_eq_rpow] using tendsto_rpow_atTop (by norm_num : (0 : ℝ) < 1 / 2)
  have hden : Tendsto (fun R : ℝ => Real.sqrt (R - 1) + Real.sqrt R) atTop atTop :=
    tendsto_atTop_mono (fun R => le_add_of_nonneg_left (Real.sqrt_nonneg (R - 1))) hs
  have hz : Tendsto (fun R : ℝ => defect (cutoff R)) atTop (𝓝 0) := by
    have hinv : Tendsto (fun R : ℝ => -(Real.sqrt (R - 1) + Real.sqrt R)⁻¹) atTop (𝓝 0) := by
      simpa only [neg_zero] using hden.inv_tendsto_atTop.neg
    apply hinv.congr'
    filter_upwards [eventually_ge_atTop (2 : ℝ)] with R hR
    rw [cutoff_defect hR]
    have hRp : 0 < R := by linarith
    have hRm : 0 ≤ R - 1 := by linarith
    have hneq : Real.sqrt (R - 1) + Real.sqrt R ≠ 0 := ne_of_gt (by positivity)
    field_simp
    nlinarith [Real.sq_sqrt hRm, Real.sq_sqrt hRp.le]
  exact tendsto_nhds_unique hd hz

theorem original_density_defect :
    defect (fun v : ℝ => (Real.exp v - 1) * Real.exp (-v / 2)) = 1 - Real.pi / 4 := by
  have he (v : ℝ) : (Real.exp v - 1) * Real.exp (-v / 2) = Real.exp (v / 2) - Real.exp (-v / 2) := by
    rw [sub_mul, one_mul, ← Real.exp_add]
    congr 2
    ring
  have hh : IntegrableOn (fun v => kernel v * Real.exp (-v / 2)) (Ioi (0 : ℝ)) :=
    integrable_kernel_mul reference_integrable
  unfold defect
  simp_rw [he, mul_sub]
  rw [integral_sub kernel_growth_integrable hh, mul_sub]
  change defect (fun v => Real.exp (v / 2)) - defect (fun v => Real.exp (-v / 2)) = _
  rw [original_defect_growth, ChargeOriginalBirth.original_defect_reference]
  ring

#print axioms original_defect_growth
#print axioms original_density_defect

end BuildingBlocks.ChargeDensityEvaluation
