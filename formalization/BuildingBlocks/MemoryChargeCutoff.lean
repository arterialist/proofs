import BuildingBlocks.MemoryChargeEnergy
import BuildingBlocks.PrimeSeedSquareConvergence

/-! Quantitative decay of the actual omitted-prime relative-charge term.
Cutoffs admit exactly p<P and retain all powers of each admitted prime. -/

open MeasureTheory Real Set
open scoped ENNReal

namespace BuildingBlocks.SuccessorCharge

theorem memoryDefectKernel_sub {F G : ℝ → ℝ} (hF : MemLp F 2 volume)
    (hG : MemLp G 2 volume) (u : ℝ) :
    memoryDefectKernel (fun w => F w - G w) u = memoryDefectKernel F u - memoryDefectKernel G u := by
  unfold memoryDefectKernel
  simp_rw [mul_sub]
  rw [integral_sub (memoryDefectKernel_integrand_integrable hF u)
    (memoryDefectKernel_integrand_integrable hG u)]
  ring

end BuildingBlocks.SuccessorCharge

namespace BuildingBlocks.PrimeSeedMass

noncomputable def primeSeedRemainder (P : ℕ) (v : ℝ) : ℝ :=
  allPrimeSeed v - finitePrimeSeed (primesBelow P) v

theorem measurable_primeSeedRemainder (P : ℕ) : Measurable (primeSeedRemainder P) :=
  measurable_allPrimeSeed.sub (measurable_finitePrimeSeed _)

theorem primeSeedRemainder_memLp (P : ℕ) : MemLp (primeSeedRemainder P) 2 volume :=
  allPrimeSeed_memLp_two.sub (finitePrimeSeed_memLp_two _)

theorem primeSeedRemainder_nonneg (P : ℕ) (v : ℝ) : 0 ≤ primeSeedRemainder P v :=
  sub_nonneg.2 (finitePrimeSeed_le_allPrimeSeed _ _)

theorem primeSeedRemainder_eq_zero {P : ℕ} (hP : 0 < P) {v : ℝ}
    (hv : v < log (P : ℝ)) : primeSeedRemainder P v = 0 := by
  have he : allPrimeSeed v = finitePrimeSeed (primesBelow P) v := by
    unfold allPrimeSeed finitePrimeSeed
    apply tsum_eq_sum
    intro p hp
    have hle : P ≤ (p : ℕ) := Nat.le_of_not_gt (by simpa using hp)
    apply seed_eq_zero
    exact hv.trans_le (log_le_log (by exact_mod_cast hP) (by exact_mod_cast hle))
  simp only [primeSeedRemainder, he, sub_self]

theorem three_log_two_le_log_cutoff {P : ℕ} (hP : 8 ≤ P) :
    3 * log 2 ≤ log (P : ℝ) := by
  have h := log_le_log (by norm_num : (0 : ℝ) < 8) (show (8 : ℝ) ≤ (P : ℝ) by exact_mod_cast hP)
  rw [show (8 : ℝ) = 2 ^ (3 : ℕ) by norm_num, log_pow] at h
  exact h

theorem primeSeedRemainder_bound {P : ℕ} (hP : 8 ≤ P) (v : ℝ) :
    primeSeedRemainder P v ≤ (64 * log 2 + 30) / log (P : ℝ) := by
  have hP0 : 0 < P := by omega
  have hl := three_log_two_le_log_cutoff hP
  have hlog : 0 < log (P : ℝ) := lt_of_lt_of_le (by positivity) hl
  by_cases hv : v < log (P : ℝ)
  · rw [primeSeedRemainder_eq_zero hP0 hv]
    positivity
  · have hv0 : 0 < v := hlog.trans_le (le_of_not_gt hv)
    have hage := allPrimeSeed_age_bound (hl.trans (le_of_not_gt hv))
    have hd : primeSeedRemainder P v ≤ allPrimeSeed v :=
      sub_le_self _ (finitePrimeSeed_nonneg _ _)
    apply hd.trans
    apply (le_div_iff₀ hlog).2
    calc
      allPrimeSeed v * log (P : ℝ) ≤ allPrimeSeed v * v :=
        mul_le_mul_of_nonneg_left (le_of_not_gt hv) (allPrimeSeed_nonneg v)
      _ ≤ _ := by simpa only [mul_comm] using hage

theorem exponential_remainder_mass_bound {P : ℕ} (hP : 8 ≤ P) :
    (∫ w in Ioi (0 : ℝ), exp (-w) * primeSeedRemainder P w) ≤
      (64 * log 2 + 30) / ((P : ℝ) * log (P : ℝ)) := by
  have hP0 : 0 < P := by omega
  have hlog : 0 < log (P : ℝ) := log_pos (by exact_mod_cast (show 1 < P by omega))
  have he : (∫ w in Ioi (0 : ℝ), exp (-w) * primeSeedRemainder P w) =
      ∫ w in Ioi (log (P : ℝ)), exp (-w) * primeSeedRemainder P w := by
    have hn : ∀ᵐ w : ℝ, w ≠ log (P : ℝ) := by rw [ae_iff]; simp
    have hs : ∀ᵐ w ∂(volume.restrict (Ioi (0 : ℝ))),
        w ∉ Ioi (log (P : ℝ)) → exp (-w) * primeSeedRemainder P w = 0 := by
      filter_upwards [ae_restrict_of_ae hn] with w hw hnot
      have hlt : w < log (P : ℝ) := lt_of_le_of_ne (le_of_not_gt hnot) hw
      rw [primeSeedRemainder_eq_zero hP0 hlt, mul_zero]
    have hi := setIntegral_eq_integral_of_ae_compl_eq_zero hs
    rw [Measure.restrict_restrict measurableSet_Ioi,
      inter_eq_left.mpr (Ioi_subset_Ioi hlog.le)] at hi
    exact hi.symm
  rw [he]
  have hi := (SuccessorCharge.exponential_memory_integrable (primeSeedRemainder_memLp P)).mono_set
    (Ioi_subset_Ioi hlog.le)
  have hd := (integrableOn_exp_mul_Ioi (by norm_num : (-1 : ℝ) < 0) (log (P : ℝ))).mul_const
    ((64 * log 2 + 30) / log (P : ℝ))
  have hb := integral_mono hi hd (fun w => by
    simpa only [neg_one_mul] using mul_le_mul_of_nonneg_left
      (primeSeedRemainder_bound hP w) (exp_pos (-w)).le)
  rw [integral_mul_const, integral_exp_mul_Ioi (by norm_num)] at hb
  have hPr : (P : ℝ) ≠ 0 := by positivity
  have hln : log (P : ℝ) ≠ 0 := hlog.ne'
  convert hb using 1
  rw [neg_one_mul, exp_neg, exp_log (by positivity)]
  field_simp

theorem remainder_defectKernel_identity (P : ℕ) (u : ℝ) :
    SuccessorCharge.memoryDefectKernel (primeSeedRemainder P) u =
      SuccessorCharge.memoryDefectKernel allPrimeSeed u -
        SuccessorCharge.memoryDefectKernel (finitePrimeSeed (primesBelow P)) u :=
  SuccessorCharge.memoryDefectKernel_sub allPrimeSeed_memLp_two (finitePrimeSeed_memLp_two _) u

theorem remainder_defectKernel_bound {P : ℕ} (hP : 8 ≤ P) {u : ℝ} (hu : 0 ≤ u) :
    0 ≤ SuccessorCharge.memoryDefectKernel (primeSeedRemainder P) u ∧
    SuccessorCharge.memoryDefectKernel (primeSeedRemainder P) u ≤
      ((64 * log 2 + 30) / ((P : ℝ) * log (P : ℝ))) * exp (-u) := by
  have hzero : ∀ w < log 2, primeSeedRemainder P w = 0 := by
    intro w hw
    apply primeSeedRemainder_eq_zero (by omega)
    exact hw.trans_le (log_le_log (by norm_num)
      (show (2 : ℝ) ≤ (P : ℝ) by exact_mod_cast (show 2 ≤ P by omega)))
  obtain ⟨hn, hb⟩ := SuccessorCharge.memoryDefectKernel_nonneg_decay
    (measurable_primeSeedRemainder P) (primeSeedRemainder_memLp P)
    (primeSeedRemainder_nonneg P) hzero hu
  refine ⟨hn, hb.trans ?_⟩
  simpa only [mul_comm] using mul_le_mul_of_nonneg_left
    (exponential_remainder_mass_bound hP) (exp_pos (-u)).le

theorem remainder_memory_charge_bound_weighted {P : ℕ} (hP : 8 ≤ P)
    {f : ℝ → ℝ} (hmf : Measurable f)
    (hf : MemLp (fun u => exp (-u / 2) * f u) 2 (volume.restrict (Ioi (0 : ℝ)))) :
    IntegrableOn (fun u => SuccessorCharge.memoryDefectKernel (primeSeedRemainder P) u * f u)
      (Ioi (0 : ℝ)) ∧
    |∫ u in Ioi (0 : ℝ), SuccessorCharge.memoryDefectKernel (primeSeedRemainder P) u * f u| ≤
      ((64 * log 2 + 30) / ((P : ℝ) * log (P : ℝ))) *
        sqrt (∫ u in Ioi (0 : ℝ), (exp (-u / 2) * f u) ^ 2) := by
  have hlog : 0 < log (P : ℝ) := log_pos (by exact_mod_cast (show 1 < P by omega))
  apply SuccessorCharge.decaying_functional_bound (by positivity)
    (SuccessorCharge.aestronglyMeasurable_memoryDefectKernel (measurable_primeSeedRemainder P)) hmf
    (fun u hu => ?_) hf
  obtain ⟨hn, hb⟩ := remainder_defectKernel_bound hP hu.le
  simpa only [abs_of_nonneg hn] using hb

theorem remainder_memory_charge_bound_energy {P : ℕ} (hP : 8 ≤ P)
    {H : ℝ → ℝ} (hH : Measurable H)
    (hzero : ∀ᵐ x : ℝ, x < 1 → H x = 0) (hE : MixedEnergy.energy H < ∞) :
    IntegrableOn (fun u => SuccessorCharge.memoryDefectKernel (primeSeedRemainder P) u *
      MixedEnergy.physicalLift H u) (Ioi (0 : ℝ)) ∧
    |∫ u in Ioi (0 : ℝ), SuccessorCharge.memoryDefectKernel (primeSeedRemainder P) u *
      MixedEnergy.physicalLift H u| ≤
      ((64 * log 2 + 30) / ((P : ℝ) * log (P : ℝ))) * sqrt ((MixedEnergy.energy H).toReal) := by
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
  obtain ⟨hint, hbound⟩ := remainder_memory_charge_bound_weighted hP hm hf
  refine ⟨hint, hbound.trans ?_⟩
  simp_rw [he]
  have hlog : 0 < log (P : ℝ) := log_pos (by exact_mod_cast (show 1 < P by omega))
  exact mul_le_mul_of_nonneg_left (sqrt_le_sqrt hb) (by positivity)

/-- The literal difference of the complete and cutoff transposed charge
kernels, acting on the causal mixed-energy source. -/
theorem cutoff_memory_charge_rank_error {P : ℕ} (hP : 8 ≤ P)
    {H : ℝ → ℝ} (hH : Measurable H)
    (hzero : ∀ᵐ x : ℝ, x < 1 → H x = 0) (hE : MixedEnergy.energy H < ∞) :
    let J := ∫ u in Ioi (0 : ℝ),
      (SuccessorCharge.memoryDefectKernel allPrimeSeed u -
        SuccessorCharge.memoryDefectKernel (finitePrimeSeed (primesBelow P)) u) *
          MixedEnergy.physicalLift H u
    IntegrableOn (fun v => exp (-v / 2) * J) (Ioi (0 : ℝ)) ∧
      (∫ v in Ioi (0 : ℝ), |exp (-v / 2) * J|) ≤
        (2 * (64 * log 2 + 30) / ((P : ℝ) * log (P : ℝ))) * sqrt ((MixedEnergy.energy H).toReal) := by
  dsimp only
  simp_rw [← remainder_defectKernel_identity]
  constructor
  · exact SuccessorCharge.reference_integrable.mul_const _
  · simp_rw [abs_mul, abs_of_pos (exp_pos _)]
    rw [integral_mul_const, SuccessorCharge.reference_integral]
    have hb := (remainder_memory_charge_bound_energy hP hH hzero hE).2
    have ht := mul_le_mul_of_nonneg_left hb (by norm_num : (0 : ℝ) ≤ 2)
    convert ht using 1 <;> ring

end BuildingBlocks.PrimeSeedMass
