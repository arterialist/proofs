import BuildingBlocks.AllPrimeMemoryKernel

/-! Positivity and exponential decay of the actual transposed memory charge.
The original relative-charge kernel and every prime-power cell are retained. -/

open MeasureTheory Real Set

namespace BuildingBlocks.SuccessorCharge

theorem kernel_nonneg_of_log_two_le {u : ℝ} (hu : log 2 ≤ u) : 0 ≤ kernel u := by
  have hu0 : 0 < u := lt_of_lt_of_le (log_pos (by norm_num)) hu
  have he : exp (-u) < 1 := by simpa using exp_lt_one_iff.mpr (neg_neg_of_pos hu0)
  have hr0 : 0 < sqrt (1 - exp (-u)) := sqrt_pos.2 (sub_pos.2 he)
  have hr1 : sqrt (1 - exp (-u)) ≤ 1 := by
    apply (sqrt_le_iff).2
    exact ⟨by norm_num, by have := exp_pos (-u); nlinarith⟩
  simp only [kernel, if_neg (not_lt.mpr hu), weight]
  apply sub_nonneg.2
  rw [inv_eq_one_div]
  exact (le_div_iff₀ hr0).2 (by simpa using hr1)

theorem exponential_memory_integrable {F : ℝ → ℝ} (hF : MemLp F 2 volume) :
    IntegrableOn (fun w => exp (-w) * F w) (Ioi (0 : ℝ)) := by
  have he : MemLp (fun w : ℝ => exp (-w)) 2 (volume.restrict (Ioi (0 : ℝ))) := by
    apply (memLp_two_iff_integrable_sq (by fun_prop)).2
    have hid (w : ℝ) : exp (-w) ^ 2 = exp (-2 * w) := by
      rw [pow_two, ← exp_add]
      congr 1
      ring
    simp_rw [hid]
    exact integrableOn_exp_mul_Ioi (by norm_num : (-2 : ℝ) < 0) 0
  exact he.integrable_mul (hF.restrict _)

/-- Positivity comes from the true activation threshold, so the negative
initial part of the successor charge kernel never enters this integral. -/
theorem memoryDefectKernel_nonneg_decay {F : ℝ → ℝ}
    (hm : Measurable F) (hF : MemLp F 2 volume)
    (hpos : ∀ w, 0 ≤ F w) (hzero : ∀ w < log 2, F w = 0)
    {u : ℝ} (hu : 0 ≤ u) :
    0 ≤ memoryDefectKernel F u ∧
      memoryDefectKernel F u ≤ exp (-u) * ∫ w in Ioi (0 : ℝ), exp (-w) * F w := by
  have hc : ∀ᵐ w : ℝ, w < 0 → F w = 0 :=
    Filter.Eventually.of_forall (fun w hw => hzero w (hw.trans (log_pos (by norm_num))))
  rw [memoryDefectKernel_causal hc hu]
  have hnn (w : ℝ) : 0 ≤ kernel (u + w) * F w := by
    by_cases hw : w < log 2
    · simp [hzero w hw]
    · exact mul_nonneg (kernel_nonneg_of_log_two_le (by linarith [le_of_not_gt hw])) (hpos w)
  have hb (w : ℝ) : |kernel (u + w) * F w| ≤
      (2 * exp (-u)) * (exp (-w) * F w) := by
    rw [abs_mul, abs_of_nonneg (hpos w)]
    have h := mul_le_mul_of_nonneg_right (kernel_abs_le_exp (u + w)) (hpos w)
    convert h using 1
    rw [neg_add, exp_add]
    ring
  have hmajor := (exponential_memory_integrable hF).const_mul (2 * exp (-u))
  have hi : IntegrableOn (fun w => kernel (u + w) * F w) (Ioi (0 : ℝ)) := by
    apply hmajor.mono' (by exact ((measurable_kernel.comp (measurable_const.add measurable_id)).mul hm).aestronglyMeasurable)
    exact Filter.Eventually.of_forall (fun w => by simpa only [Real.norm_eq_abs] using hb w)
  constructor
  · exact mul_nonneg (by norm_num) (integral_nonneg hnn)
  · have hi_le := integral_mono_ae hi hmajor
      (Filter.Eventually.of_forall (fun w => (le_abs_self _).trans (hb w)))
    rw [integral_const_mul] at hi_le
    nlinarith

end BuildingBlocks.SuccessorCharge

namespace BuildingBlocks.PrimeSeedMass

theorem allPrimeSeed_eq_zero_before_log_two {v : ℝ} (hv : v < log 2) :
    allPrimeSeed v = 0 := by
  unfold allPrimeSeed
  have hz (p : Nat.Primes) : seed (log p) v = 0 := by
    apply seed_eq_zero
    exact hv.trans_le (log_le_log (by norm_num) (by exact_mod_cast p.property.two_le))
  simp_rw [hz, tsum_zero]

theorem allPrimeSeed_defectKernel_nonneg_decay {u : ℝ} (hu : 0 ≤ u) :
    0 ≤ SuccessorCharge.memoryDefectKernel allPrimeSeed u ∧
    SuccessorCharge.memoryDefectKernel allPrimeSeed u ≤
      exp (-u) * ∫ w in Ioi (0 : ℝ), exp (-w) * allPrimeSeed w :=
  SuccessorCharge.memoryDefectKernel_nonneg_decay measurable_allPrimeSeed allPrimeSeed_memLp_two
    allPrimeSeed_nonneg (fun _ hw => allPrimeSeed_eq_zero_before_log_two hw) hu

end BuildingBlocks.PrimeSeedMass
