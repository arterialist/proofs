import BuildingBlocks.SuccessorCharge
import Mathlib.MeasureTheory.Function.L2Space

/-! The actual successor charge on causal sources of finite mixed energy. -/

open MeasureTheory Real Set
open scoped ENNReal

namespace BuildingBlocks.SuccessorCharge

theorem kernel_abs_le_exp (u : ℝ) : |kernel u| ≤ 2 * exp (-u) := by
  by_cases hu : u < log 2
  · have he : (1 / 2 : ℝ) < exp (-u) := by
      have h := exp_lt_exp.mpr (neg_lt_neg hu)
      simpa only [exp_neg, exp_log (by norm_num : (0 : ℝ) < 2), one_div] using h
    simp only [kernel, if_pos hu, abs_neg, abs_one]
    linarith
  · have he : exp (-u) ≤ (1 / 2 : ℝ) := by
      have h := exp_le_exp.mpr (neg_le_neg (le_of_not_gt hu))
      simpa only [exp_neg, exp_log (by norm_num : (0 : ℝ) < 2), one_div] using h
    have hd : 0 ≤ 1 - exp (-u) := by linarith
    have hr : (1 / 2 : ℝ) ≤ sqrt (1 - exp (-u)) := le_sqrt_of_sq_le (by nlinarith)
    have hr0 : 0 < sqrt (1 - exp (-u)) := by linarith
    have hr1 : sqrt (1 - exp (-u)) ≤ 1 := by
      apply (sqrt_le_iff).mpr
      exact ⟨by norm_num, by have := exp_pos (-u); nlinarith⟩
    have hs := sq_sqrt hd
    have hk : 0 ≤ weight u - 1 := by
      unfold weight
      rw [inv_eq_one_div]
      exact sub_nonneg.mpr ((le_div_iff₀ hr0).mpr (by simpa using hr1))
    have hid : weight u - 1 = exp (-u) /
        (sqrt (1 - exp (-u)) * (1 + sqrt (1 - exp (-u)))) := by
      unfold weight
      field_simp
      nlinarith
    have hb : (1 / 2 : ℝ) ≤ sqrt (1 - exp (-u)) *
        (1 + sqrt (1 - exp (-u))) := by nlinarith
    simp only [kernel, if_neg hu, abs_of_nonneg hk]
    rw [hid]
    apply (div_le_iff₀ (by positivity)).mpr
    nlinarith [exp_pos (-u)]

noncomputable def weightedKernel (u : ℝ) : ℝ := exp (u / 2) * kernel u

theorem weightedKernel_abs_le (u : ℝ) : |weightedKernel u| ≤ 2 * exp (-u / 2) := by
  calc
    |weightedKernel u| = exp (u / 2) * |kernel u| := by
      simp only [weightedKernel, abs_mul, abs_of_pos (exp_pos _)]
    _ ≤ exp (u / 2) * (2 * exp (-u)) :=
      mul_le_mul_of_nonneg_left (kernel_abs_le_exp u) (exp_pos _).le
    _ = 2 * exp (-u / 2) := by
      rw [mul_left_comm, ← exp_add]
      congr 2
      ring

theorem weightedKernel_square_le (u : ℝ) : weightedKernel u ^ 2 ≤ 4 * exp (-u) := by
  have h := sq_le_sq₀ (abs_nonneg (weightedKernel u)) (by positivity) |>.mpr
    (weightedKernel_abs_le u)
  rw [sq_abs] at h
  have he : exp (-u / 2) ^ 2 = exp (-u) := by
    rw [pow_two, ← exp_add]
    congr 1
    ring
  nlinarith

theorem measurable_weightedKernel : Measurable weightedKernel := by
  unfold weightedKernel
  exact (by fun_prop : Measurable (fun u : ℝ => exp (u / 2))).mul measurable_kernel

theorem weightedKernel_square_integrable :
    IntegrableOn (fun u => weightedKernel u ^ 2) (Ioi (0 : ℝ)) := by
  have hd := (integrableOn_exp_mul_Ioi (a := -1) (by norm_num) 0).const_mul 4
  apply hd.mono' (measurable_weightedKernel.pow_const 2).aestronglyMeasurable
  apply Filter.Eventually.of_forall
  intro u
  change |weightedKernel u ^ 2| ≤ 4 * exp (-1 * u)
  rw [abs_of_nonneg (sq_nonneg (weightedKernel u)), neg_one_mul]
  exact weightedKernel_square_le u

theorem weightedKernel_square_integral_le :
    (∫ u in Ioi (0 : ℝ), weightedKernel u ^ 2) ≤ 4 := by
  have hd := (integrableOn_exp_mul_Ioi (a := -1) (by norm_num) 0).const_mul 4
  have h := integral_mono weightedKernel_square_integrable hd
    (fun u => by simpa only [neg_one_mul] using weightedKernel_square_le u)
  rw [integral_const_mul, integral_exp_mul_Ioi (by norm_num)] at h
  norm_num at h ⊢
  exact h

theorem weightedKernel_memLp : MemLp weightedKernel 2 (volume.restrict (Ioi (0 : ℝ))) :=
  (memLp_two_iff_integrable_sq measurable_weightedKernel.aestronglyMeasurable).2
    weightedKernel_square_integrable

/-- Charge is defined on the weighted physical L² domain, even when the
unweighted source integral does not exist. -/
theorem defect_bound_weighted {f : ℝ → ℝ}
    (hf : MemLp (fun u => exp (-u / 2) * f u) 2 (volume.restrict (Ioi (0 : ℝ)))) :
    IntegrableOn (fun u => kernel u * f u) (Ioi (0 : ℝ)) ∧
      |defect f| ≤ sqrt (∫ u in Ioi (0 : ℝ), (exp (-u / 2) * f u) ^ 2) := by
  let g : ℝ → ℝ := fun u => exp (-u / 2) * f u
  have hi : ∀ u, weightedKernel u * g u = kernel u * f u := by
    intro u
    unfold weightedKernel g
    calc
      (exp (u / 2) * kernel u) * (exp (-u / 2) * f u) =
          (exp (u / 2) * exp (-u / 2)) * (kernel u * f u) := by ring
      _ = _ := by
        rw [← exp_add, show u / 2 + -u / 2 = 0 by ring, exp_zero, one_mul]
  have hp := weightedKernel_memLp.integrable_mul hf
  have hint : IntegrableOn (fun u => kernel u * f u) (Ioi (0 : ℝ)) := by
    apply hp.congr
    exact Filter.Eventually.of_forall hi
  refine ⟨hint, ?_⟩
  have hc := integral_mul_norm_le_Lp_mul_Lq Real.HolderConjugate.two_two
    (by simpa using weightedKernel_memLp) (by simpa using hf)
  have hcs : (∫ u in Ioi (0 : ℝ), |weightedKernel u| * |g u|) ≤
      sqrt (∫ u in Ioi (0 : ℝ), weightedKernel u ^ 2) *
        sqrt (∫ u in Ioi (0 : ℝ), g u ^ 2) := by
    simpa only [Real.norm_eq_abs, Real.rpow_two, sq_abs, ← sqrt_eq_rpow] using hc
  have hroot : sqrt (∫ u in Ioi (0 : ℝ), weightedKernel u ^ 2) ≤ 2 :=
    sqrt_le_iff.mpr ⟨by norm_num, by norm_num; exact weightedKernel_square_integral_le⟩
  have hraw : |∫ u in Ioi (0 : ℝ), kernel u * f u| ≤
      2 * sqrt (∫ u in Ioi (0 : ℝ), g u ^ 2) := by
    calc
      _ = |∫ u in Ioi (0 : ℝ), weightedKernel u * g u| := by simp_rw [hi]
      _ ≤ ∫ u in Ioi (0 : ℝ), |weightedKernel u| * |g u| := by
        simpa only [Real.norm_eq_abs, abs_mul] using
          norm_integral_le_integral_norm (fun u => weightedKernel u * g u)
      _ ≤ _ := hcs.trans (mul_le_mul_of_nonneg_right hroot (sqrt_nonneg _))
  calc
    |defect f| = (1 / 2 : ℝ) * |∫ u in Ioi (0 : ℝ), kernel u * f u| := by
      simp [defect, abs_mul]
    _ ≤ (1 / 2 : ℝ) * (2 * sqrt (∫ u in Ioi (0 : ℝ), g u ^ 2)) :=
      mul_le_mul_of_nonneg_left hraw (by norm_num)
    _ = _ := by ring

theorem causal_source_square {H : ℝ → ℝ} (hH : Measurable H)
    (hzero : ∀ᵐ x : ℝ, x < 1 → H x = 0) (hE : MixedEnergy.energy H < ∞) :
    IntegrableOn (fun u => H (exp u) ^ 2) (Ioi (0 : ℝ)) ∧
      (∫ u in Ioi (0 : ℝ), H (exp u) ^ 2) ≤ (MixedEnergy.energy H).toReal := by
  have hb : (∫⁻ u in Ioi (0 : ℝ), ENNReal.ofReal (H (exp u) ^ 2)) ≤
      MixedEnergy.energy H := by
    rw [MixedEnergy.logarithmic_anchor_identity]
    exact MixedEnergy.causal_anchor_one_div hH hzero
  have hi : IntegrableOn (fun u => H (exp u) ^ 2) (Ioi (0 : ℝ)) := by
    constructor
    · exact ((hH.comp measurable_exp).pow_const 2).aestronglyMeasurable
    · rw [hasFiniteIntegral_iff_ofReal (Filter.Eventually.of_forall (fun u => sq_nonneg (H (exp u))))]
      exact hb.trans_lt hE
  refine ⟨hi, ?_⟩
  rw [← ofReal_integral_eq_lintegral_ofReal hi
    (Filter.Eventually.of_forall (fun u => sq_nonneg (H (exp u))))] at hb
  have h := ENNReal.toReal_mono hE.ne hb
  simpa only [ENNReal.toReal_ofReal (integral_nonneg (fun u => sq_nonneg (H (exp u))))] using h

/-- The literal successor relative charge is a bounded functional of the
causal mixed energy, with no PNT or unweighted integrability premise. -/
theorem defect_bound_causal_energy {H : ℝ → ℝ} (hH : Measurable H)
    (hzero : ∀ᵐ x : ℝ, x < 1 → H x = 0) (hE : MixedEnergy.energy H < ∞) :
    IntegrableOn (fun u => kernel u * MixedEnergy.physicalLift H u) (Ioi (0 : ℝ)) ∧
      |defect (MixedEnergy.physicalLift H)| ≤ sqrt ((MixedEnergy.energy H).toReal) := by
  obtain ⟨hi, hb⟩ := causal_source_square hH hzero hE
  have he (u : ℝ) : exp (-u / 2) * MixedEnergy.physicalLift H u = H (exp u) := by
    unfold MixedEnergy.physicalLift
    rw [← mul_assoc, ← exp_add]
    rw [show -u / 2 + u / 2 = 0 by ring, exp_zero, one_mul]
  have hm : MemLp (fun u => exp (-u / 2) * MixedEnergy.physicalLift H u)
      2 (volume.restrict (Ioi (0 : ℝ))) := by
    simp_rw [he]
    exact (memLp_two_iff_integrable_sq (hH.comp measurable_exp).aestronglyMeasurable).2 hi
  obtain ⟨hint, hbound⟩ := defect_bound_weighted hm
  refine ⟨hint, hbound.trans ?_⟩
  simp_rw [he]
  exact sqrt_le_sqrt hb

end BuildingBlocks.SuccessorCharge
