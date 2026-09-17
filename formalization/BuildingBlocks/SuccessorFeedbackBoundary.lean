import BuildingBlocks.SuccessorFeedbackDifference

/-! The terminal strip in converting an ordinary successor increment into its
relative charge. The unweighted source integral is never separated at infinity. -/

open MeasureTheory Real Set Filter
open scoped Topology Interval

namespace BuildingBlocks.SuccessorCharge

theorem sigma_strictMono : StrictMono sigma := by
  intro v w hvw
  exact log_lt_log (by positivity) (by have := exp_lt_exp.mpr hvw; linarith)

theorem sigma_zero : sigma 0 = log 2 := by norm_num [sigma]

theorem sigma_image_Ioc {R : ℝ} : sigma '' Ioc 0 R = Ioc (log 2) (sigma R) := by
  ext u
  constructor
  · rintro ⟨v, hv, rfl⟩
    exact ⟨by simpa only [sigma_zero] using sigma_strictMono hv.1,
      sigma_strictMono.monotone hv.2⟩
  · intro hu
    refine ⟨log (exp u - 1), ⟨?_, ?_⟩, sigma_inverse hu.1⟩
    · apply sigma_strictMono.lt_iff_lt.mp
      rw [sigma_zero, sigma_inverse hu.1]
      exact hu.1
    · apply sigma_strictMono.le_iff_le.mp
      rw [sigma_inverse hu.1]
      exact hu.2

theorem intervalIntegral_successor {R : ℝ} (hR : 0 ≤ R) (f : ℝ → ℝ) :
    (∫ v in 0..R, successor f v) =
      ∫ u in log 2..sigma R, weight u * f u := by
  have hs : log 2 ≤ sigma R := by
    simpa only [sigma_zero] using sigma_strictMono.monotone hR
  rw [intervalIntegral.integral_of_le hR, intervalIntegral.integral_of_le hs]
  have h := integral_image_eq_integral_abs_deriv_smul (s := Ioc 0 R)
    measurableSet_Ioc (fun v _ => (sigma_hasDerivAt v).hasDerivWithinAt)
    sigma_injective.injOn (fun u => weight u * f u)
  rw [sigma_image_Ioc] at h
  rw [h]
  apply integral_congr_ae
  exact Eventually.of_forall (fun v => by
    dsimp only
    rw [smul_eq_mul, abs_of_pos (jacobian_pos v), ← mul_assoc,
      jacobian_mul_weight_sigma, successor])

theorem profile_intervalIntegrable {H : ℝ → ℝ} (hH : Measurable H)
    {M : ℝ} (hb : ∀ x, 0 < x → |H x| ≤ M) (j : ℕ) (a b : ℝ) :
    IntervalIntegrable (successor^[j] (MixedEnergy.physicalLift H)) volume a b := by
  have he : IntervalIntegrable (fun v : ℝ => exp (v / 2)) volume a b :=
    (by fun_prop : Continuous (fun v : ℝ => exp (v / 2))).intervalIntegrable a b
  rw [intervalIntegrable_iff] at he ⊢
  have hm : Measurable (fun v : ℝ => H (exp v + j)) :=
    hH.comp (measurable_exp.add_const _)
  have hi := he.bdd_mul' hm.aestronglyMeasurable
    (Eventually.of_forall (fun v => by simpa only [Real.norm_eq_abs] using hb (exp v + j) (by positivity)))
  apply hi.congr
  exact Eventually.of_forall (fun v => by
    rw [successor_iterate_physicalLift]
    exact mul_comm _ _)

theorem kernel_profile_intervalIntegrable {H : ℝ → ℝ} (hH : Measurable H)
    {M : ℝ} (hb : ∀ x, 0 < x → |H x| ≤ M) (j : ℕ) (a b : ℝ) :
    IntervalIntegrable (fun v => kernel v * successor^[j] (MixedEnergy.physicalLift H) v)
      volume a b := by
  have hi := profile_intervalIntegrable hH hb j a b
  rw [intervalIntegrable_iff] at hi ⊢
  exact hi.bdd_mul' measurable_kernel.aestronglyMeasurable
    (Eventually.of_forall (fun v => by simpa only [Real.norm_eq_abs] using kernel_abs_le v))

theorem weighted_profile_intervalIntegrable {H : ℝ → ℝ} (hH : Measurable H)
    {M : ℝ} (hb : ∀ x, 0 < x → |H x| ≤ M) (j : ℕ)
    {a b : ℝ} (ha : log 2 ≤ a) (hab : a ≤ b) :
    IntervalIntegrable (fun v => weight v * successor^[j] (MixedEnergy.physicalLift H) v)
      volume a b := by
  have hi := profile_intervalIntegrable hH hb j a b
  rw [intervalIntegrable_iff_integrableOn_Ioc_of_le hab] at hi ⊢
  have hm : Measurable weight := by unfold weight; fun_prop
  apply hi.bdd_mul' (c := 2) hm.aestronglyMeasurable
  filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioc] with v hv
  have hw := weight_bounds (ha.trans hv.1.le)
  simpa only [Real.norm_eq_abs, abs_of_nonneg hw.1] using hw.2

theorem lt_sigma (v : ℝ) : v < sigma v := by
  calc
    v = log (exp v) := (log_exp v).symm
    _ < _ := log_lt_log (exp_pos v) (by have := exp_pos v; linarith)

theorem interval_kernel_partition {R : ℝ} (hR : log 2 ≤ R) (f : ℝ → ℝ) :
    (∫ v in 0..R, f v + kernel v * f v) =
      ∫ v in log 2..R, weight v * f v := by
  have h0R : 0 ≤ R := (log_pos (by norm_num : (1 : ℝ) < 2)).le.trans hR
  rw [intervalIntegral.integral_of_le h0R, intervalIntegral.integral_of_le hR]
  have h := integral_congr_ae
    (ae_restrict_of_ae (s := Ioc (0 : ℝ) R) (source_partition_ae f))
  rw [setIntegral_indicator measurableSet_Ioi] at h
  have he : Ioc (0 : ℝ) R ∩ Ioi (log 2) = Ioc (log 2) R := by
    ext x
    simp only [mem_inter_iff, mem_Ioc, mem_Ioi]
    constructor
    · rintro ⟨⟨_, hxR⟩, hx⟩
      exact ⟨hx, hxR⟩
    · rintro ⟨hx, hxR⟩
      exact ⟨⟨lt_trans (log_pos (by norm_num)) hx, hxR⟩, hx⟩
  rw [he] at h
  exact h.symm

/-- Exact finite truncation. The only discrepancy is the terminal strip
`R < u ≤ log(1+exp R)`; the initial cell is already included in the kernel. -/
theorem profile_finite_charge_identity {H : ℝ → ℝ} (hH : Measurable H)
    {M : ℝ} (hb : ∀ x, 0 < x → |H x| ≤ M) (j : ℕ)
    {R : ℝ} (hR : log 2 ≤ R) :
    (∫ v in 0..R, successor (successor^[j] (MixedEnergy.physicalLift H)) v -
      successor^[j] (MixedEnergy.physicalLift H) v) -
      (∫ v in 0..R, kernel v * successor^[j] (MixedEnergy.physicalLift H) v) =
      ∫ u in R..sigma R, weight u * successor^[j] (MixedEnergy.physicalLift H) u := by
  have h0R : 0 ≤ R := (log_pos (by norm_num : (1 : ℝ) < 2)).le.trans hR
  have hF := profile_intervalIntegrable hH hb j 0 R
  have hS := profile_intervalIntegrable hH hb (j + 1) 0 R
  rw [Function.iterate_succ_apply'] at hS
  have hk := kernel_profile_intervalIntegrable hH hb j 0 R
  have hp := interval_kernel_partition hR (successor^[j] (MixedEnergy.physicalLift H))
  rw [intervalIntegral.integral_add hF hk] at hp
  have ha := intervalIntegral.integral_add_adjacent_intervals
    (weighted_profile_intervalIntegrable hH hb j le_rfl hR)
    (weighted_profile_intervalIntegrable hH hb j hR (lt_sigma R).le)
  rw [intervalIntegral.integral_sub hS hF, intervalIntegral_successor h0R]
  linarith

theorem sigma_sub_self (v : ℝ) : sigma v - v = log (1 + exp (-v)) := by
  have he : 1 + exp v = exp v * (1 + exp (-v)) := by
    rw [mul_add, mul_one, ← exp_add, add_neg_cancel, exp_zero]
    ring
  rw [sigma, he, log_mul (ne_of_gt (exp_pos _)) (by positivity), log_exp]
  ring

theorem sigma_sub_self_le (v : ℝ) : sigma v - v ≤ exp (-v) := by
  rw [sigma_sub_self]
  have h := log_le_sub_one_of_pos (by positivity : 0 < 1 + exp (-v))
  linarith

theorem sigma_le_add_log_two {v : ℝ} (hv : 0 ≤ v) : sigma v ≤ v + log 2 := by
  have he : exp (-v) ≤ 1 := by simpa using exp_le_exp.mpr (neg_nonpos.mpr hv)
  have h := log_le_log (by positivity : 0 < 1 + exp (-v))
    (show 1 + exp (-v) ≤ 2 by linarith)
  rw [← sigma_sub_self] at h
  linarith

theorem terminal_strip_bound {H : ℝ → ℝ} {M : ℝ} (hM : 0 ≤ M)
    (hb : ∀ x, 0 < x → |H x| ≤ M) (j : ℕ)
    {R : ℝ} (hR : log 2 ≤ R) :
    |∫ u in R..sigma R, weight u * successor^[j] (MixedEnergy.physicalLift H) u| ≤
      4 * M * exp (-R / 2) := by
  have h0R : 0 ≤ R := (log_pos (by norm_num : (1 : ℝ) < 2)).le.trans hR
  have hcoef : exp (log (2 : ℝ) / 2) ≤ 2 := by
    calc
      _ ≤ exp (log 2) := exp_le_exp.mpr (by have := log_pos (by norm_num : (1 : ℝ) < 2); linarith)
      _ = 2 := exp_log (by norm_num)
  have hbound (u : ℝ) (hu : u ∈ Ι R (sigma R)) :
      ‖weight u * successor^[j] (MixedEnergy.physicalLift H) u‖ ≤
        4 * M * exp (R / 2) := by
    rw [uIoc_of_le (lt_sigma R).le] at hu
    have hw := weight_bounds (hR.trans hu.1.le)
    have he : exp (u / 2) ≤ 2 * exp (R / 2) := by
      calc
        _ ≤ exp ((R + log 2) / 2) := exp_le_exp.mpr (by
          have := hu.2.trans (sigma_le_add_log_two h0R); linarith)
        _ = exp (R / 2) * exp (log 2 / 2) := by rw [← exp_add]; congr 1; ring
        _ ≤ exp (R / 2) * 2 := mul_le_mul_of_nonneg_left hcoef (exp_pos _).le
        _ = _ := mul_comm _ _
    rw [Real.norm_eq_abs, abs_mul, abs_of_nonneg hw.1, successor_iterate_physicalLift,
      abs_mul, abs_of_pos (exp_pos _)]
    calc
      _ ≤ 2 * ((2 * exp (R / 2)) * M) :=
        mul_le_mul hw.2 (mul_le_mul he (hb _ (by positivity))
          (abs_nonneg _) (by positivity)) (by positivity) (by norm_num)
      _ = _ := by ring
  have h := intervalIntegral.norm_integral_le_of_norm_le_const hbound
  rw [Real.norm_eq_abs, abs_of_nonneg (sub_nonneg.mpr (lt_sigma R).le)] at h
  calc
    _ ≤ 4 * M * exp (R / 2) * (sigma R - R) := h
    _ ≤ 4 * M * exp (R / 2) * exp (-R) :=
      mul_le_mul_of_nonneg_left (sigma_sub_self_le R) (by positivity)
    _ = _ := by rw [mul_assoc (4 * M), ← exp_add]; congr 2; ring

/-- Passing to the infinite interval uses integrability only of the difference
and of the relative kernel product. No integral of either source term is used. -/
theorem profile_relative_charge {H : ℝ → ℝ} (hH : Measurable H)
    {M : ℝ} (hM : 0 ≤ M) (hb : ∀ x, 0 < x → |H x| ≤ M) (j : ℕ)
    (hi : IntegrableOn (fun v => successor (successor^[j] (MixedEnergy.physicalLift H)) v -
      successor^[j] (MixedEnergy.physicalLift H) v) (Ioi (0 : ℝ))) :
    (∫ v in Ioi (0 : ℝ), successor (successor^[j] (MixedEnergy.physicalLift H)) v -
      successor^[j] (MixedEnergy.physicalLift H) v) =
      ∫ v in Ioi (0 : ℝ), kernel v * successor^[j] (MixedEnergy.physicalLift H) v := by
  have hd := intervalIntegral_tendsto_integral_Ioi 0 hi tendsto_id
  have hk := intervalIntegral_tendsto_integral_Ioi 0
    (iterate_charge_integrable hH hM hb j) tendsto_id
  have he : Tendsto (fun R : ℝ => 4 * M * exp (-R / 2)) atTop (𝓝 0) := by
    have hh := tendsto_exp_neg_atTop_nhds_zero.comp
      ((tendsto_div_const_atTop_of_pos (by norm_num : (0 : ℝ) < 2)).mpr
        (tendsto_id : Tendsto (fun R : ℝ => R) atTop atTop))
    simpa only [Function.comp_def, neg_div, mul_zero] using hh.const_mul (4 * M)
  have hz : Tendsto (fun R : ℝ =>
      (∫ v in 0..R, successor (successor^[j] (MixedEnergy.physicalLift H)) v -
        successor^[j] (MixedEnergy.physicalLift H) v) -
      (∫ v in 0..R, kernel v * successor^[j] (MixedEnergy.physicalLift H) v))
      atTop (𝓝 0) := by
    apply squeeze_zero_norm' _ he
    filter_upwards [eventually_ge_atTop (log (2 : ℝ))] with R hR
    rw [Real.norm_eq_abs, profile_finite_charge_identity hH hb j hR]
    exact terminal_strip_bound hM hb j hR
  exact sub_eq_zero.mp (tendsto_nhds_unique (hd.sub hk) hz)

end BuildingBlocks.SuccessorCharge

namespace BuildingBlocks.SuccessorFeedback

private theorem profile_innovation_ae (j : ℕ) :
    (fun v => SuccessorCharge.successor
      (SuccessorCharge.successor^[j] (MixedEnergy.physicalLift physicalError)) v -
      SuccessorCharge.successor^[j] (MixedEnergy.physicalLift physicalError) v) =ᵐ[
        volume.restrict (Ioi (0 : ℝ))] innovation j := by
  filter_upwards [source_iterate_eq_ae j, source_iterate_eq_ae (j + 1)] with v hj hj1
  rw [innovation, hj, hj1, Function.iterate_succ_apply']

/-- The actual driver is half the ordinary successor difference integral,
with its terminal strip proved to vanish uniformly in the successor index. -/
theorem driver_eq_innovation_integral (j : ℕ) :
    driver j = (1 / 2 : ℝ) * ∫ v in Ioi (0 : ℝ), innovation j v := by
  have hi := (innovation_integrable j).congr (profile_innovation_ae j).symm
  have h := SuccessorCharge.profile_relative_charge measurable_physicalError
    (by positivity : 0 ≤ 4 * log (2 : ℝ) + 1)
    (fun _ hx => physicalError_abs_le hx) j hi
  have he := integral_congr_ae (profile_innovation_ae j)
  rw [driver_eq_profile_defect, SuccessorCharge.defect, ← h, he]

/-- Literal formula used by the successor-feedback Abel--Mellin transform. -/
theorem driver_eq_difference_integral (j : ℕ) :
    driver j = (1 / 2 : ℝ) * ∫ x in Ioi (1 : ℝ),
      (physicalError (x + j + 1) - physicalError (x + j)) / sqrt x := by
  rw [driver_eq_innovation_integral, innovation_integral]
  rfl

end BuildingBlocks.SuccessorFeedback
