import BuildingBlocks.PrimeMemoryChargeDecay

/-! The full-prime transposed charge acts directly on causal finite mixed
energy, without assuming an absolute source charge or unweighted L² source. -/

open MeasureTheory Real Set
open scoped ENNReal

namespace BuildingBlocks.SuccessorCharge

theorem reference_square_integral :
    (∫ u in Ioi (0 : ℝ), exp (-u / 2) ^ 2) = 1 := by
  have he (u : ℝ) : exp (-u / 2) ^ 2 = exp (-1 * u) := by
    rw [pow_two, ← exp_add]
    congr 1
    ring
  simp_rw [he]
  rw [integral_exp_mul_Ioi (by norm_num)]
  norm_num

theorem decaying_functional_bound {d f : ℝ → ℝ} {M : ℝ} (hM : 0 ≤ M)
    (hd : AEStronglyMeasurable d (volume.restrict (Ioi (0 : ℝ))))
    (hmf : Measurable f)
    (hbound : ∀ u > 0, |d u| ≤ M * exp (-u))
    (hf : MemLp (fun u => exp (-u / 2) * f u) 2 (volume.restrict (Ioi (0 : ℝ)))) :
    IntegrableOn (fun u => d u * f u) (Ioi (0 : ℝ)) ∧
      |∫ u in Ioi (0 : ℝ), d u * f u| ≤
        M * sqrt (∫ u in Ioi (0 : ℝ), (exp (-u / 2) * f u) ^ 2) := by
  let g : ℝ → ℝ := fun u => exp (-u / 2) * f u
  have he (u : ℝ) : exp (-u / 2) * |g u| = exp (-u) * |f u| := by
    dsimp [g]
    rw [abs_mul, abs_of_pos (exp_pos _), ← mul_assoc, ← exp_add]
    congr 2
    ring
  have hi := reference_memLp.integrable_mul hf.norm
  have hdom : IntegrableOn (fun u => M * (exp (-u / 2) * |g u|)) (Ioi (0 : ℝ)) := by
    simpa only [Pi.mul_def, Real.norm_eq_abs] using hi.const_mul M
  have hb : ∀ᵐ u ∂(volume.restrict (Ioi (0 : ℝ))),
      |d u * f u| ≤ M * (exp (-u / 2) * |g u|) := by
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with u hu
    rw [abs_mul, he]
    exact (mul_le_mul_of_nonneg_right (hbound u hu) (abs_nonneg _)).trans_eq (by ring)
  have hint : IntegrableOn (fun u => d u * f u) (Ioi (0 : ℝ)) := by
    apply hdom.mono' (hd.mul hmf.aestronglyMeasurable)
    simpa only [Real.norm_eq_abs] using hb
  refine ⟨hint, ?_⟩
  have hcs := MixedEnergy.integral_mul_abs_le_sqrt reference_memLp hf.norm
  simp only [Real.norm_eq_abs, sq_abs, reference_square_integral, sqrt_one, one_mul] at hcs
  have hp : 0 ≤ ∫ u in Ioi (0 : ℝ), exp (-u / 2) * |g u| :=
    integral_nonneg (fun _ => mul_nonneg (exp_pos _).le (abs_nonneg _))
  have hcs' : (∫ u in Ioi (0 : ℝ), exp (-u / 2) * |g u|) ≤
      sqrt (∫ u in Ioi (0 : ℝ), g u ^ 2) := by
    change |(∫ u in Ioi (0 : ℝ), exp (-u / 2) * |g u|)| ≤
      sqrt (∫ u in Ioi (0 : ℝ), g u ^ 2) at hcs
    rwa [abs_of_nonneg hp] at hcs
  calc
    _ ≤ ∫ u in Ioi (0 : ℝ), |d u * f u| := by
      simpa only [Real.norm_eq_abs] using norm_integral_le_integral_norm (fun u => d u * f u)
    _ ≤ ∫ u in Ioi (0 : ℝ), M * (exp (-u / 2) * |g u|) :=
      integral_mono_ae hint.norm hdom (by simpa only [Real.norm_eq_abs] using hb)
    _ = M * ∫ u in Ioi (0 : ℝ), exp (-u / 2) * |g u| := integral_const_mul _ _
    _ ≤ _ := mul_le_mul_of_nonneg_left hcs' hM

theorem aestronglyMeasurable_memoryDefectKernel {F : ℝ → ℝ} (hm : Measurable F) :
    AEStronglyMeasurable (memoryDefectKernel F) (volume.restrict (Ioi (0 : ℝ))) := by
  have hj : Measurable (fun z : ℝ × ℝ => kernel z.2 * F (z.2 - z.1)) :=
    (measurable_kernel.comp measurable_snd).mul (by fun_prop)
  have ha : AEStronglyMeasurable (fun z : ℝ × ℝ => kernel z.2 * F (z.2 - z.1))
      ((volume.restrict (Ioi (0 : ℝ))).prod (volume.restrict (Ioi (0 : ℝ)))) := hj.aestronglyMeasurable
  exact ha.integral_prod_right'.const_mul (1 / 2 : ℝ)

end BuildingBlocks.SuccessorCharge

namespace BuildingBlocks.PrimeSeedMass

theorem allPrimeSeed_memory_charge_bound_weighted {f : ℝ → ℝ} (hmf : Measurable f)
    (hf : MemLp (fun u => exp (-u / 2) * f u) 2 (volume.restrict (Ioi (0 : ℝ)))) :
    IntegrableOn (fun u => SuccessorCharge.memoryDefectKernel allPrimeSeed u * f u) (Ioi (0 : ℝ)) ∧
      |∫ u in Ioi (0 : ℝ), SuccessorCharge.memoryDefectKernel allPrimeSeed u * f u| ≤
        (∫ w in Ioi (0 : ℝ), exp (-w) * allPrimeSeed w) *
          sqrt (∫ u in Ioi (0 : ℝ), (exp (-u / 2) * f u) ^ 2) := by
  apply SuccessorCharge.decaying_functional_bound
    (integral_nonneg (fun w => mul_nonneg (exp_pos _).le (allPrimeSeed_nonneg w)))
    (SuccessorCharge.aestronglyMeasurable_memoryDefectKernel measurable_allPrimeSeed) hmf
    (fun u hu => ?_) hf
  obtain ⟨hn, hb⟩ := allPrimeSeed_defectKernel_nonneg_decay hu.le
  rw [abs_of_nonneg hn, mul_comm]
  exact hb

theorem allPrimeSeed_memory_charge_bound_energy {H : ℝ → ℝ} (hH : Measurable H)
    (hzero : ∀ᵐ x : ℝ, x < 1 → H x = 0) (hE : MixedEnergy.energy H < ∞) :
    IntegrableOn (fun u => SuccessorCharge.memoryDefectKernel allPrimeSeed u *
      MixedEnergy.physicalLift H u) (Ioi (0 : ℝ)) ∧
      |∫ u in Ioi (0 : ℝ), SuccessorCharge.memoryDefectKernel allPrimeSeed u *
        MixedEnergy.physicalLift H u| ≤
        (∫ w in Ioi (0 : ℝ), exp (-w) * allPrimeSeed w) * sqrt ((MixedEnergy.energy H).toReal) := by
  obtain ⟨hi, hb⟩ := SuccessorCharge.causal_source_square hH hzero hE
  have he (u : ℝ) : exp (-u / 2) * MixedEnergy.physicalLift H u = H (exp u) := by
    unfold MixedEnergy.physicalLift
    rw [← mul_assoc, ← exp_add]
    rw [show -u / 2 + u / 2 = 0 by ring, exp_zero, one_mul]
  have hf : MemLp (fun u => exp (-u / 2) * MixedEnergy.physicalLift H u)
      2 (volume.restrict (Ioi (0 : ℝ))) := by
    simp_rw [he]
    exact (memLp_two_iff_integrable_sq (hH.comp measurable_exp).aestronglyMeasurable).2 hi
  have hm : Measurable (MixedEnergy.physicalLift H) := by
    unfold MixedEnergy.physicalLift
    fun_prop
  obtain ⟨hint, hbound⟩ := allPrimeSeed_memory_charge_bound_weighted hm hf
  refine ⟨hint, hbound.trans ?_⟩
  simp_rw [he]
  exact mul_le_mul_of_nonneg_left (sqrt_le_sqrt hb)
    (integral_nonneg (fun w => mul_nonneg (exp_pos _).le (allPrimeSeed_nonneg w)))

/-- The original exponential-reference rank term is an L¹ output on the
actual causal finite-energy domain. Its distributional derivative is not
asserted to be L¹. -/
theorem allPrimeSeed_memory_charge_rank_bound {H : ℝ → ℝ} (hH : Measurable H)
    (hzero : ∀ᵐ x : ℝ, x < 1 → H x = 0) (hE : MixedEnergy.energy H < ∞) :
    let J := ∫ u in Ioi (0 : ℝ), SuccessorCharge.memoryDefectKernel allPrimeSeed u *
      MixedEnergy.physicalLift H u
    IntegrableOn (fun v => exp (-v / 2) * J) (Ioi (0 : ℝ)) ∧
      (∫ v in Ioi (0 : ℝ), |exp (-v / 2) * J|) ≤
        2 * (∫ w in Ioi (0 : ℝ), exp (-w) * allPrimeSeed w) * sqrt ((MixedEnergy.energy H).toReal) := by
  dsimp only
  constructor
  · exact SuccessorCharge.reference_integrable.mul_const _
  · simp_rw [abs_mul, abs_of_pos (exp_pos _)]
    rw [integral_mul_const, SuccessorCharge.reference_integral]
    have hb := (allPrimeSeed_memory_charge_bound_energy hH hzero hE).2
    nlinarith

end BuildingBlocks.PrimeSeedMass
