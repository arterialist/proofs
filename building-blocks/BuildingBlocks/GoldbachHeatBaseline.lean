import BuildingBlocks.GoldbachHeatSeries

/-! The exact difference between discrete and continuous centering has a
global square-integrable bound, independently of any prime error estimate. -/

open MeasureTheory Real Set

namespace BuildingBlocks.GoldbachHeat

noncomputable def densityCorrection (t : ℝ) : ℝ :=
  1 / (exp t - 1) - (1 + 1 / t) * exp (-t)

theorem densityCorrection_eq {t : ℝ} (ht : 0 < t) :
    densityCorrection t = exp (-t) * (1 / (exp t - 1) - 1 / t) := by
  have he : exp t - 1 ≠ 0 := ne_of_gt (sub_pos.mpr (one_lt_exp_iff.mpr ht))
  unfold densityCorrection
  rw [exp_neg]
  field_simp
  <;> ring

theorem densityCorrection_bounds {t : ℝ} (ht : 0 < t) :
    -exp (-t) ≤ densityCorrection t ∧ densityCorrection t ≤ 0 := by
  have he : 0 < exp t - 1 := sub_pos.mpr (one_lt_exp_iff.mpr ht)
  have hforward := add_one_le_exp t
  have hbackward := mul_le_mul_of_nonneg_right (add_one_le_exp (-t)) (exp_nonneg t)
  rw [← exp_add, neg_add_cancel, exp_zero] at hbackward
  have hlo : -1 ≤ 1 / (exp t - 1) - 1 / t := by
    apply (le_of_sub_nonneg ?_)
    field_simp
    nlinarith
  have hhi : 1 / (exp t - 1) - 1 / t ≤ 0 := by
    exact sub_nonpos.mpr (one_div_le_one_div_of_le ht (by linarith))
  rw [densityCorrection_eq ht]
  constructor
  · simpa using mul_le_mul_of_nonneg_left hlo (exp_nonneg (-t))
  · exact mul_nonpos_of_nonneg_of_nonpos (exp_nonneg _) hhi

theorem densityCorrection_sq_le {t : ℝ} (ht : 0 < t) :
    densityCorrection t ^ 2 ≤ exp (-2 * t) := by
  obtain ⟨hl, hu⟩ := densityCorrection_bounds ht
  have he : exp (-2 * t) = exp (-t) ^ 2 := by
    rw [pow_two, ← exp_add]
    congr 1
    ring
  rw [he]
  nlinarith [exp_pos (-t)]

theorem densityCorrection_measurable : Measurable densityCorrection := by
  unfold densityCorrection
  fun_prop

theorem densityCorrection_square_integrable :
    IntegrableOn (fun t => densityCorrection t ^ 2) (Ioi (0 : ℝ)) := by
  apply (integrableOn_exp_mul_Ioi (a := -2) (by norm_num) 0).mono'
    (densityCorrection_measurable.pow_const 2).aestronglyMeasurable
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  simpa only [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg (densityCorrection t))] using densityCorrection_sq_le ht

theorem densityCorrection_square_integral_le :
    (∫ t in Ioi (0 : ℝ), densityCorrection t ^ 2) ≤ 1 / 2 := by
  calc
    _ ≤ ∫ t in Ioi (0 : ℝ), exp (-2 * t) := by
      apply integral_mono_ae densityCorrection_square_integrable
        (integrableOn_exp_mul_Ioi (a := -2) (by norm_num) 0)
      filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
      exact densityCorrection_sq_le ht
    _ = _ := by rw [integral_exp_mul_Ioi (by norm_num)]; norm_num

theorem mixedCenteredHeat_sub_centered {t : ℝ} (ht : 0 < t) :
    mixedCenteredHeat t - centeredHeat t = densityCorrection t := by
  rw [mixedCenteredHeat_eq ht]
  unfold densityCorrection
  ring

end BuildingBlocks.GoldbachHeat
