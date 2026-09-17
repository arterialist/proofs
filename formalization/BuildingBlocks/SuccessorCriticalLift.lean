import BuildingBlocks.SuccessorCharge
import BuildingBlocks.MixedEnergyKernel

/-! Exact critical-coordinate successor and predecessor formulas, retaining
the initial interval of the causal half-line. -/

open MeasureTheory Real Set
open scoped ENNReal

namespace BuildingBlocks.SuccessorCharge

theorem amplitude_eq_exp (v : ℝ) :
    amplitude v = exp ((v - sigma v) / 2) := by
  have he : exp (v - sigma v) = jacobian v := by
    rw [exp_sub, sigma, exp_log (by positivity)]
    rfl
  unfold amplitude
  rw [← he]
  have hs : exp ((v - sigma v) / 2) ^ 2 = exp (v - sigma v) := by
    rw [pow_two, ← exp_add]
    congr 1
    ring
  rw [← hs, sqrt_sq (exp_pos _).le]

theorem successor_physicalLift (H : ℝ → ℝ) (v : ℝ) :
    successor (MixedEnergy.physicalLift H) v =
      exp (v / 2) * H (exp v + 1) := by
  rw [successor, amplitude_eq_exp, MixedEnergy.physicalLift, ← mul_assoc, ← exp_add]
  rw [show (v - sigma v) / 2 + sigma v / 2 = v / 2 by ring]
  rw [sigma, exp_log (by positivity), add_comm 1]

noncomputable def predecessor (f : ℝ → ℝ) (u : ℝ) : ℝ :=
  if log 2 < u then weight u * f (log (exp u - 1)) else 0

theorem predecessor_initial (f : ℝ → ℝ) {u : ℝ} (hu : u ≤ log 2) :
    predecessor f u = 0 := by simp [predecessor, not_lt.mpr hu]

theorem weight_eq_exp {u : ℝ} (hu : log 2 < u) :
    weight u = exp ((u - log (exp u - 1)) / 2) := by
  have he : 2 < exp u := by
    simpa only [exp_log (by norm_num : (0 : ℝ) < 2)] using exp_lt_exp.mpr hu
  have hp : 0 < exp u - 1 := by linarith
  have hsig : sigma (log (exp u - 1)) = u := by
    unfold sigma
    rw [exp_log hp, show 1 + (exp u - 1) = exp u by ring, log_exp]
  have hw := weight_sigma (log (exp u - 1))
  change weight (sigma (log (exp u - 1))) = (amplitude (log (exp u - 1)))⁻¹ at hw
  rw [hsig, amplitude_eq_exp, hsig, ← exp_neg] at hw
  rw [hw]
  congr 1
  ring

theorem predecessor_physicalLift (H : ℝ → ℝ) {u : ℝ} (hu : log 2 < u) :
    predecessor (MixedEnergy.physicalLift H) u =
      exp (u / 2) * H (exp u - 1) := by
  have he : 2 < exp u := by
    simpa only [exp_log (by norm_num : (0 : ℝ) < 2)] using exp_lt_exp.mpr hu
  rw [predecessor, if_pos hu, weight_eq_exp hu, MixedEnergy.physicalLift,
    exp_log (by linarith), ← mul_assoc, ← exp_add]
  congr 1
  congr 1
  ring

theorem inverse_sigma (v : ℝ) : log (exp (sigma v) - 1) = v := by
  rw [sigma, exp_log (by positivity), add_sub_cancel_left, log_exp]

theorem integral_successor_pair (f g : ℝ → ℝ) :
    (∫ v in Ioi (0 : ℝ), f v * successor g v) =
      ∫ u in Ioi (log 2), (weight u * f (log (exp u - 1))) * g u := by
  have h := integral_image_eq_integral_abs_deriv_smul (s := Ioi (0 : ℝ))
    measurableSet_Ioi (fun v _ => (sigma_hasDerivAt v).hasDerivWithinAt)
    sigma_injective.injOn (fun u => (weight u * f (log (exp u - 1))) * g u)
  rw [sigma_image_positive] at h
  rw [h]
  apply integral_congr_ae
  exact Filter.Eventually.of_forall (fun v => by
    dsimp only
    rw [smul_eq_mul, abs_of_pos (jacobian_pos v), inverse_sigma]
    rw [← mul_assoc, ← mul_assoc, jacobian_mul_weight_sigma, successor]
    ring)

theorem integral_predecessor_pair (f g : ℝ → ℝ) :
    (∫ u in Ioi (0 : ℝ), predecessor f u * g u) =
      ∫ u in Ioi (log 2), (weight u * f (log (exp u - 1))) * g u := by
  simp only [predecessor, ite_mul, zero_mul]
  change (∫ u in Ioi (0 : ℝ), (Ioi (log 2)).indicator
    (fun u => (weight u * f (log (exp u - 1))) * g u) u) = _
  rw [setIntegral_indicator measurableSet_Ioi,
    inter_eq_right.mpr (Ioi_subset_Ioi (log_pos (by norm_num : (1 : ℝ) < 2)).le)]

/-- The original half-line adjoint uses the predecessor with its complete
zero initial interval. The equality is the literal change-of-variables formula. -/
theorem successor_predecessor_adjoint (f g : ℝ → ℝ) :
    (∫ v in Ioi (0 : ℝ), f v * successor g v) =
      ∫ u in Ioi (0 : ℝ), predecessor f u * g u := by
  rw [integral_successor_pair, integral_predecessor_pair]

theorem amplitude_mul_weight_sigma (v : ℝ) : amplitude v * weight (sigma v) = 1 := by
  rw [weight_sigma, amplitude, mul_inv_cancel₀ (ne_of_gt (sqrt_pos.mpr (jacobian_pos v)))]

theorem sigma_inverse {u : ℝ} (hu : log 2 < u) : sigma (log (exp u - 1)) = u := by
  have he : 2 < exp u := by
    simpa only [exp_log (by norm_num : (0 : ℝ) < 2)] using exp_lt_exp.mpr hu
  unfold sigma
  rw [exp_log (by linarith), show 1 + (exp u - 1) = exp u by ring, log_exp]

/-- Advancing after the causal predecessor recovers the whole input on the
positive half-line. -/
theorem successor_predecessor (f : ℝ → ℝ) {v : ℝ} (hv : 0 < v) :
    successor (predecessor f) v = f v := by
  have hs : log 2 < sigma v := by
    have hm : sigma v ∈ sigma '' Ioi (0 : ℝ) := ⟨v, hv, rfl⟩
    rwa [sigma_image_positive] at hm
  rw [successor, predecessor, if_pos hs, inverse_sigma, ← mul_assoc,
    amplitude_mul_weight_sigma, one_mul]

/-- The opposite composition removes exactly the initial cell. -/
theorem predecessor_successor (f : ℝ → ℝ) (u : ℝ) :
    predecessor (successor f) u = (Ioi (log 2)).indicator f u := by
  by_cases hu : log 2 < u
  · rw [predecessor, if_pos hu, successor, sigma_inverse hu,
      indicator_of_mem (s := Ioi (log 2)) hu, ← mul_assoc]
    have h := amplitude_mul_weight_sigma (log (exp u - 1))
    rw [sigma_inverse hu, mul_comm] at h
    rw [h, one_mul]
  · rw [predecessor, if_neg hu, indicator_of_notMem (s := Ioi (log 2)) hu]

/-- The successor discards precisely the input square mass on the initial
interval. This nonnegative-integral identity does not assume finite L² mass. -/
theorem successor_square_lintegral (f : ℝ → ℝ) :
    (∫⁻ v in Ioi (0 : ℝ), ENNReal.ofReal (successor f v ^ 2)) =
      ∫⁻ u in Ioi (log 2), ENNReal.ofReal (f u ^ 2) := by
  have h := lintegral_image_eq_lintegral_abs_deriv_mul (s := Ioi (0 : ℝ))
    measurableSet_Ioi (fun v _ => (sigma_hasDerivAt v).hasDerivWithinAt)
    sigma_injective.injOn (fun u => ENNReal.ofReal (f u ^ 2))
  rw [sigma_image_positive] at h
  rw [h]
  apply lintegral_congr
  intro v
  rw [abs_of_pos (jacobian_pos v), ← ENNReal.ofReal_mul (jacobian_pos v).le,
    successor, mul_pow, amplitude, sq_sqrt (jacobian_pos v).le]

theorem predecessor_square_lintegral (f : ℝ → ℝ) :
    (∫⁻ u in Ioi (0 : ℝ), ENNReal.ofReal (predecessor f u ^ 2)) =
      ∫⁻ v in Ioi (0 : ℝ), ENNReal.ofReal (f v ^ 2) := by
  have hp : (∫⁻ u in Ioi (0 : ℝ), ENNReal.ofReal (predecessor f u ^ 2)) =
      ∫⁻ u in Ioi (log 2), ENNReal.ofReal (predecessor f u ^ 2) := by
    calc
      _ = ∫⁻ u in Ioi (0 : ℝ), (Ioi (log 2)).indicator
          (fun u => ENNReal.ofReal (predecessor f u ^ 2)) u := by
        apply lintegral_congr
        intro u
        by_cases hu : log 2 < u
        · rw [indicator_of_mem (s := Ioi (log 2)) hu]
        · rw [indicator_of_notMem (s := Ioi (log 2)) hu,
            predecessor_initial f (le_of_not_gt hu)]
          simp
      _ = _ := by
        rw [lintegral_indicator measurableSet_Ioi, Measure.restrict_restrict measurableSet_Ioi,
          inter_eq_left.mpr (Ioi_subset_Ioi (log_pos (by norm_num : (1 : ℝ) < 2)).le)]
  rw [hp, ← successor_square_lintegral]
  apply lintegral_congr_ae
  filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with v hv
  rw [successor_predecessor f hv]

theorem measurable_successor {f : ℝ → ℝ} (hf : Measurable f) : Measurable (successor f) := by
  unfold successor amplitude jacobian sigma
  fun_prop

theorem measurable_predecessor {f : ℝ → ℝ} (hf : Measurable f) : Measurable (predecessor f) := by
  unfold predecessor
  apply Measurable.ite measurableSet_Ioi _ measurable_const
  unfold weight
  fun_prop

theorem successor_memLp {f : ℝ → ℝ} (hm : Measurable f)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    MemLp (successor f) 2 (volume.restrict (Ioi (0 : ℝ))) := by
  apply (memLp_two_iff_integrable_sq (measurable_successor hm).aestronglyMeasurable).2
  refine ⟨((measurable_successor hm).pow_const 2).aestronglyMeasurable, ?_⟩
  have hi := hf.integrable_sq.hasFiniteIntegral
  rw [hasFiniteIntegral_iff_ofReal (Filter.Eventually.of_forall (fun u => sq_nonneg (f u)))] at hi
  rw [hasFiniteIntegral_iff_ofReal
    (Filter.Eventually.of_forall (fun v => sq_nonneg (successor f v))), successor_square_lintegral]
  exact (lintegral_mono_set (Ioi_subset_Ioi (log_pos (by norm_num : (1 : ℝ) < 2)).le)).trans_lt hi

theorem predecessor_memLp {f : ℝ → ℝ} (hm : Measurable f)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    MemLp (predecessor f) 2 (volume.restrict (Ioi (0 : ℝ))) := by
  apply (memLp_two_iff_integrable_sq (measurable_predecessor hm).aestronglyMeasurable).2
  refine ⟨((measurable_predecessor hm).pow_const 2).aestronglyMeasurable, ?_⟩
  have hi := hf.integrable_sq.hasFiniteIntegral
  rw [hasFiniteIntegral_iff_ofReal (Filter.Eventually.of_forall (fun u => sq_nonneg (f u)))] at hi
  rw [hasFiniteIntegral_iff_ofReal
    (Filter.Eventually.of_forall (fun u => sq_nonneg (predecessor f u))), predecessor_square_lintegral]
  exact hi

end BuildingBlocks.SuccessorCharge
