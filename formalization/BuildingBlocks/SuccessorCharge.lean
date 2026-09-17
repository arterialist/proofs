import BuildingBlocks.MixedEnergyAnchoring

/-! The literal successor Jacobian and its relative charge, with the initial
interval retained. This concerns integrable real causal sources. -/

open MeasureTheory Real Set

namespace BuildingBlocks.SuccessorCharge

noncomputable def sigma (v : ℝ) : ℝ := log (1 + exp v)
noncomputable def jacobian (v : ℝ) : ℝ := exp v / (1 + exp v)
noncomputable def amplitude (v : ℝ) : ℝ := sqrt (jacobian v)
noncomputable def weight (u : ℝ) : ℝ := (sqrt (1 - exp (-u)))⁻¹
noncomputable def kernel (u : ℝ) : ℝ := if u < log 2 then -1 else weight u - 1
noncomputable def successor (f : ℝ → ℝ) (v : ℝ) : ℝ := amplitude v * f (sigma v)

theorem jacobian_pos (v : ℝ) : 0 < jacobian v :=
  div_pos (exp_pos v) (by positivity)

theorem sigma_hasDerivAt (v : ℝ) : HasDerivAt sigma (jacobian v) v := by
  exact ((hasDerivAt_exp v).const_add 1).log (by positivity)

theorem sigma_injective : Function.Injective sigma := by
  intro v w h
  have he := congrArg exp h
  simp only [sigma, exp_log (by positivity : 0 < 1 + exp v),
    exp_log (by positivity : 0 < 1 + exp w)] at he
  exact exp_injective (by linarith)

theorem sigma_image_positive : sigma '' Ioi (0 : ℝ) = Ioi (log 2) := by
  ext u
  constructor
  · rintro ⟨v, hv, rfl⟩
    apply log_lt_log (by norm_num)
    have he : 1 < exp v := by simpa using exp_lt_exp.mpr hv
    linarith
  · intro hu
    have he : 2 < exp u := by
      have h := exp_lt_exp.mpr hu
      simpa only [exp_log (by norm_num : (0 : ℝ) < 2)] using h
    refine ⟨log (exp u - 1), log_pos (by linarith), ?_⟩
    unfold sigma
    rw [exp_log (by linarith)]
    have hsum : 1 + (exp u - 1) = exp u := by ring
    rw [hsum, log_exp]

theorem weight_sigma (v : ℝ) : weight (sigma v) = (sqrt (jacobian v))⁻¹ := by
  unfold weight sigma jacobian
  rw [exp_neg, exp_log (by positivity)]
  congr 2
  field_simp
  ring

theorem jacobian_mul_weight_sigma (v : ℝ) :
    jacobian v * weight (sigma v) = amplitude v := by
  rw [weight_sigma, ← div_eq_mul_inv, div_sqrt]
  rfl

/-- The actual successor integral uses the inverse square-root Jacobian on
`u > log 2`, rather than discarding the initial interval. -/
theorem integral_successor (f : ℝ → ℝ) :
    (∫ v in Ioi (0 : ℝ), successor f v) =
      ∫ u in Ioi (log 2), weight u * f u := by
  have h := integral_image_eq_integral_abs_deriv_smul (s := Ioi (0 : ℝ))
    measurableSet_Ioi (fun v _ => (sigma_hasDerivAt v).hasDerivWithinAt)
    sigma_injective.injOn (fun u => weight u * f u)
  rw [sigma_image_positive] at h
  rw [h]
  apply integral_congr_ae
  apply Filter.Eventually.of_forall
  intro v
  simp only [smul_eq_mul, abs_of_pos (jacobian_pos v), ← mul_assoc,
    jacobian_mul_weight_sigma, successor]

theorem weight_bounds {u : ℝ} (hu : log 2 ≤ u) : 0 ≤ weight u ∧ weight u ≤ 2 := by
  have he : exp (-u) ≤ (1 / 2 : ℝ) := by
    have h := exp_le_exp.mpr (neg_le_neg hu)
    simpa only [exp_neg, exp_log (by norm_num : (0 : ℝ) < 2), one_div] using h
  have hd : (1 / 2 : ℝ) ≤ 1 - exp (-u) := by linarith
  have hs : (1 / 2 : ℝ) ≤ sqrt (1 - exp (-u)) := le_sqrt_of_sq_le (by nlinarith)
  constructor
  · exact inv_nonneg.mpr (sqrt_nonneg _)
  · unfold weight
    rw [inv_eq_one_div]
    apply (div_le_iff₀ (by linarith : 0 < sqrt (1 - exp (-u)))).mpr
    linarith

theorem kernel_abs_le (u : ℝ) : |kernel u| ≤ 1 := by
  unfold kernel
  split_ifs with hu
  · norm_num
  · obtain ⟨h0, h2⟩ := weight_bounds (le_of_not_gt hu)
    exact abs_le.mpr ⟨by linarith, by linarith⟩

theorem measurable_kernel : Measurable kernel := by
  unfold kernel
  apply Measurable.ite measurableSet_Iio measurable_const
  unfold weight
  fun_prop

theorem integrable_kernel_mul {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    IntegrableOn (fun u => kernel u * f u) (Ioi (0 : ℝ)) := by
  apply hf.norm.mono'
    (measurable_kernel.aestronglyMeasurable.mul hf.aestronglyMeasurable)
  apply Filter.Eventually.of_forall
  intro u
  rw [Pi.mul_apply, norm_mul, Real.norm_eq_abs]
  exact mul_le_of_le_one_left (norm_nonneg _) (kernel_abs_le u)

theorem source_partition_ae (f : ℝ → ℝ) :
    (Ioi (log 2)).indicator (fun u => weight u * f u) =ᵐ[volume]
      (fun u => f u + kernel u * f u) := by
  have hn : ∀ᵐ u : ℝ, u ≠ log 2 := by rw [ae_iff]; simp
  filter_upwards [hn] with u hu
  by_cases hlt : u < log 2
  · rw [indicator_of_notMem (s := Ioi (log 2)) (not_lt.mpr hlt.le)]
    simp [kernel, hlt]
  · have hgt : log 2 < u := lt_of_le_of_ne (le_of_not_gt hlt) (Ne.symm hu)
    rw [indicator_of_mem (s := Ioi (log 2)) hgt]
    simp only [kernel, if_neg hlt]
    ring

/-- Exact relative charge, including the discarded initial interval. -/
theorem integral_successor_sub {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    (∫ v in Ioi (0 : ℝ), successor f v) - (∫ u in Ioi (0 : ℝ), f u) =
      ∫ u in Ioi (0 : ℝ), kernel u * f u := by
  have hsub : Ioi (log 2) ⊆ Ioi (0 : ℝ) := Ioi_subset_Ioi (log_pos (by norm_num)).le
  have hi : (∫ u in Ioi (0 : ℝ), (Ioi (log 2)).indicator (fun u => weight u * f u) u) =
      ∫ u in Ioi (log 2), weight u * f u := by
    rw [setIntegral_indicator measurableSet_Ioi, inter_eq_right.mpr hsub]
  have hp := integral_congr_ae (ae_restrict_of_ae (s := Ioi (0 : ℝ)) (source_partition_ae f))
  rw [hi, integral_add hf (integrable_kernel_mul hf)] at hp
  rw [integral_successor, hp]
  ring

theorem integrable_successor {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    IntegrableOn (successor f) (Ioi (0 : ℝ)) := by
  have hsub : Ioi (log 2) ⊆ Ioi (0 : ℝ) := Ioi_subset_Ioi (log_pos (by norm_num)).le
  have hfL := hf.mono_set hsub
  have hw : IntegrableOn (fun u => weight u * f u) (Ioi (log 2)) := by
    have hm : Measurable weight := by unfold weight; fun_prop
    apply (hfL.norm.const_mul 2).mono' (hm.aestronglyMeasurable.mul hfL.aestronglyMeasurable)
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with u hu
    obtain ⟨h0, h2⟩ := weight_bounds hu.le
    rw [Pi.mul_apply, norm_mul, Real.norm_eq_abs, abs_of_nonneg h0]
    exact mul_le_mul_of_nonneg_right h2 (norm_nonneg _)
  have ht := integrableOn_image_iff_integrableOn_abs_deriv_smul (s := Ioi (0 : ℝ))
    measurableSet_Ioi (fun v _ => (sigma_hasDerivAt v).hasDerivWithinAt)
    sigma_injective.injOn (fun u => weight u * f u)
  rw [sigma_image_positive] at ht
  apply (ht.mp hw).congr
  apply Filter.Eventually.of_forall
  intro v
  simp only [smul_eq_mul, abs_of_pos (jacobian_pos v), ← mul_assoc,
    jacobian_mul_weight_sigma, successor]

noncomputable def charge (f : ℝ → ℝ) : ℝ := (1 / 2) * ∫ u in Ioi (0 : ℝ), f u
noncomputable def defect (f : ℝ → ℝ) : ℝ := (1 / 2) * ∫ u in Ioi (0 : ℝ), kernel u * f u

/-- This formula is used on the causal half-line. Its reference has integral two. -/
noncomputable def compensated (f : ℝ → ℝ) (v : ℝ) : ℝ :=
  successor f v - exp (-v / 2) * defect f

theorem reference_integrable : IntegrableOn (fun v : ℝ => exp (-v / 2)) (Ioi (0 : ℝ)) := by
  convert integrableOn_exp_mul_Ioi (a := -(1 / 2 : ℝ)) (by norm_num) 0 using 1
  ext v
  congr 1
  ring

theorem reference_integral : (∫ v in Ioi (0 : ℝ), exp (-v / 2)) = 2 := by
  have h := integral_exp_mul_Ioi (a := -(1 / 2 : ℝ)) (by norm_num) 0
  convert h using 1 <;> norm_num
  congr 1
  funext v
  congr 1
  ring

theorem defect_eq_charge_difference {f : ℝ → ℝ}
    (hf : IntegrableOn f (Ioi (0 : ℝ))) : defect f = charge (successor f) - charge f := by
  unfold defect charge
  rw [← integral_successor_sub hf]
  ring

theorem integrable_compensated {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    IntegrableOn (compensated f) (Ioi (0 : ℝ)) :=
  (integrable_successor hf).sub (reference_integrable.mul_const (defect f))

theorem integral_compensated {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    (∫ v in Ioi (0 : ℝ), compensated f v) = ∫ v in Ioi (0 : ℝ), f v := by
  change (∫ v in Ioi (0 : ℝ), successor f v - exp (-v / 2) * defect f) = _
  rw [integral_sub (integrable_successor hf)
    (reference_integrable.mul_const (defect f)), integral_mul_const, reference_integral]
  have h := integral_successor_sub hf
  unfold defect
  linarith

theorem charge_compensated {f : ℝ → ℝ} (hf : IntegrableOn f (Ioi (0 : ℝ))) :
    charge (compensated f) = charge f := by
  unfold charge
  rw [integral_compensated hf]

end BuildingBlocks.SuccessorCharge
