import BuildingBlocks.CompensatedMemoryKernel

/-! Absolute Fubini for the actual relative-charge memory kernel. -/

open MeasureTheory Real Set

namespace BuildingBlocks.SuccessorCharge

theorem memory_absolute_column_bound {F f : ℝ → ℝ} (hF : MemLp F 2 volume)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    (∫ u in Ioi (0 : ℝ), ‖F (v - u) * f u‖) ≤
      sqrt (∫ x, F x ^ 2) * sqrt (∫ u in Ioi (0 : ℝ), f u ^ 2) := by
  have h := causalMemory_bound hF.norm hf.norm v
  simp only [causalMemory, Real.norm_eq_abs, sq_abs] at h
  rw [abs_of_nonneg (integral_nonneg (fun u => mul_nonneg (abs_nonneg _) (abs_nonneg _)))] at h
  simpa only [Real.norm_eq_abs, abs_mul] using h

theorem memory_charge_product_integrable {F f : ℝ → ℝ}
    (hmF : Measurable F) (hmf : Measurable f) (hF : MemLp F 2 volume)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    Integrable (fun z : ℝ × ℝ => kernel z.1 * (F (z.1 - z.2) * f z.2))
      ((volume.restrict (Ioi (0 : ℝ))).prod (volume.restrict (Ioi (0 : ℝ)))) := by
  have hm : Measurable (fun z : ℝ × ℝ => kernel z.1 * (F (z.1 - z.2) * f z.2)) :=
    (measurable_kernel.comp measurable_fst).mul (by fun_prop)
  apply (integrable_prod_iff hm.aestronglyMeasurable).2
  constructor
  · exact Filter.Eventually.of_forall (fun v =>
      ((reflected_halfline_memLp hF v).integrable_mul hf).const_mul (kernel v))
  · let M := sqrt (∫ x, F x ^ 2) * sqrt (∫ u in Ioi (0 : ℝ), f u ^ 2)
    apply (kernel_integrable.norm.mul_const M).mono' hm.norm.aestronglyMeasurable.integral_prod_right'
    apply Filter.Eventually.of_forall
    intro v
    have hn : 0 ≤ ∫ u in Ioi (0 : ℝ), ‖kernel v * (F (v - u) * f u)‖ :=
      integral_nonneg (fun _ => norm_nonneg _)
    change |∫ u in Ioi (0 : ℝ), ‖kernel v * (F (v - u) * f u)‖| ≤ ‖kernel v‖ * M
    rw [abs_of_nonneg hn]
    simp_rw [norm_mul (kernel v)]
    rw [integral_const_mul]
    exact mul_le_mul_of_nonneg_left (memory_absolute_column_bound hF hf v) (norm_nonneg _)

noncomputable def memoryDefectKernel (F : ℝ → ℝ) (u : ℝ) : ℝ :=
  (1 / 2) * ∫ v in Ioi (0 : ℝ), kernel v * F (v - u)

theorem memoryDefectKernel_integrand_integrable {F : ℝ → ℝ}
    (hF : MemLp F 2 volume) (u : ℝ) :
    IntegrableOn (fun v => kernel v * F (v - u)) (Ioi (0 : ℝ)) := by
  have ht : MemLp (fun v => F (v - u)) 2 (volume.restrict (Ioi (0 : ℝ))) := by
    simpa only [sub_eq_add_neg] using
      (MixedEnergy.translated_memLp hF (-u)).restrict (Ioi (0 : ℝ))
  exact kernel_memLp.integrable_mul ht

/-- The original relative charge, not an absolute output charge, has the
transposed-kernel representation on the full L² column domain. -/
theorem defect_causalMemory {F f : ℝ → ℝ}
    (hmF : Measurable F) (hmf : Measurable f) (hF : MemLp F 2 volume)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    defect (causalMemory F f) =
      ∫ u in Ioi (0 : ℝ), memoryDefectKernel F u * f u := by
  have hprod := memory_charge_product_integrable hmF hmf hF hf
  have he : defect (causalMemory F f) =
      (1 / 2) * ∫ v in Ioi (0 : ℝ), ∫ u in Ioi (0 : ℝ),
        kernel v * (F (v - u) * f u) := by
    unfold defect causalMemory
    simp_rw [integral_const_mul]
  rw [he, integral_integral_swap hprod]
  simp_rw [← mul_assoc, integral_mul_const]
  rw [← integral_const_mul]
  simp only [memoryDefectKernel, mul_assoc]

theorem memoryDefectKernel_pair_integrable {F f : ℝ → ℝ}
    (hmF : Measurable F) (hmf : Measurable f) (hF : MemLp F 2 volume)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    IntegrableOn (fun u => memoryDefectKernel F u * f u) (Ioi (0 : ℝ)) := by
  have h := (memory_charge_product_integrable hmF hmf hF hf).integral_prod_right.const_mul (1 / 2 : ℝ)
  apply h.congr
  exact Filter.Eventually.of_forall (fun u => by
    dsimp only
    simp only [← mul_assoc, integral_mul_const, memoryDefectKernel])

noncomputable def correctedMemoryKernel (F : ℝ → ℝ) (v u : ℝ) : ℝ :=
  memoryKernel F v u + (causalMemory F (fun w => exp (-w / 2)) v / 2) * kernel u -
    exp (-v / 2) * memoryDefectKernel F u

theorem memoryKernel_pair_integrable {F f : ℝ → ℝ}
    (hmF : Measurable F) (hF : MemLp F 2 volume)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    IntegrableOn (fun u => memoryKernel F v u * f u) (Ioi (0 : ℝ)) := by
  apply ((memory_first_column_integrable hF hf v).sub
    (memory_second_column_integrable hmF hF hf v)).congr
  exact Filter.Eventually.of_forall (fun u => by
    simp only [Pi.sub_apply]
    unfold memoryKernel
    ring)

/-- The complete original-reference kernel, including both initial and
rank-one charge terms, on an absolutely integrable column domain. -/
theorem corrected_memory_kernel_identity {F f : ℝ → ℝ}
    (hmF : Measurable F) (hmf : Measurable f) (hF : MemLp F 2 volume)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    compensated (causalMemory F f) v - causalMemory F (compensated f) v =
      ∫ u in Ioi (0 : ℝ), correctedMemoryKernel F v u * f u := by
  have hA := memoryKernel_pair_integrable hmF hF hf v
  have hB := (integrable_defect_of_memLp hf).const_mul
    (causalMemory F (fun w => exp (-w / 2)) v / 2)
  have hD := (memoryDefectKernel_pair_integrable hmF hmf hF hf).const_mul (exp (-v / 2))
  have hexp : (∫ u in Ioi (0 : ℝ), correctedMemoryKernel F v u * f u) =
      (∫ u in Ioi (0 : ℝ), memoryKernel F v u * f u) +
      (causalMemory F (fun w => exp (-w / 2)) v / 2) * (∫ u in Ioi (0 : ℝ), kernel u * f u) -
      exp (-v / 2) * (∫ u in Ioi (0 : ℝ), memoryDefectKernel F u * f u) := by
    have hAB := hA.add hB
    simp only [Pi.add_def] at hAB
    rw [← integral_const_mul, ← integral_const_mul, ← integral_add hA hB,
      ← integral_sub hAB hD]
    apply integral_congr_ae
    exact Filter.Eventually.of_forall (fun u => by dsimp only; unfold correctedMemoryKernel; ring)
  rw [hexp, compensated_memory_commutator hmF hmf hF hf,
    defect_causalMemory hmF hmf hF hf, defect]
  ring

theorem memoryDefectKernel_causal {F : ℝ → ℝ}
    (hzero : ∀ᵐ w : ℝ, w < 0 → F w = 0) {u : ℝ} (hu : 0 ≤ u) :
    memoryDefectKernel F u = (1 / 2) * ∫ w in Ioi (0 : ℝ), kernel (u + w) * F w := by
  have ht : ∀ᵐ v : ℝ, v - u < 0 → F (v - u) = 0 := by
    simpa only [sub_eq_add_neg] using
      (measurePreserving_add_right volume (-u)).quasiMeasurePreserving.tendsto_ae.eventually hzero
  have hn : ∀ᵐ v : ℝ, v ≠ 0 := by rw [ae_iff]; simp
  have hl : (∫ v in Ioi (0 : ℝ), kernel v * F (v - u)) = ∫ v, kernel v * F (v - u) := by
    apply setIntegral_eq_integral_of_ae_compl_eq_zero
    filter_upwards [ht, hn] with v hv hn hout
    have hv0 : v < 0 := lt_of_le_of_ne (le_of_not_gt hout) hn
    rw [hv (by linarith), mul_zero]
  have hr : (∫ w in Ioi (0 : ℝ), kernel (u + w) * F w) = ∫ w, kernel (u + w) * F w := by
    apply setIntegral_eq_integral_of_ae_compl_eq_zero
    filter_upwards [hzero, hn] with w hw hn hout
    rw [hw (lt_of_le_of_ne (le_of_not_gt hout) hn), mul_zero]
  unfold memoryDefectKernel
  rw [hl, hr]
  have he := integral_sub_right_eq_self (μ := volume) (fun w => kernel (u + w) * F w) u
  have ha (v : ℝ) : u + (v - u) = v := by ring
  simp only [ha] at he
  rw [he]

end BuildingBlocks.SuccessorCharge

namespace BuildingBlocks.PrimeSeedMass

theorem finitePrimeSeed_eq_zero_nonpos (S : Finset Nat.Primes) {v : ℝ} (hv : v ≤ 0) :
    finitePrimeSeed S v = 0 := by
  unfold finitePrimeSeed
  apply Finset.sum_eq_zero
  intro p _
  apply seed_eq_zero
  have hp : 0 < log (p : ℝ) := log_pos (by exact_mod_cast p.property.one_lt)
  linarith

theorem finitePrimeSeed_defectKernel_causal (S : Finset Nat.Primes) {u : ℝ} (hu : 0 ≤ u) :
    SuccessorCharge.memoryDefectKernel (finitePrimeSeed S) u =
      (1 / 2) * ∫ w in Ioi (0 : ℝ), SuccessorCharge.kernel (u + w) * finitePrimeSeed S w :=
  SuccessorCharge.memoryDefectKernel_causal
    (Filter.Eventually.of_forall (fun _ hw => finitePrimeSeed_eq_zero_nonpos S hw.le)) hu

theorem finitePrimeSeed_corrected_kernel_identity (S : Finset Nat.Primes) {f : ℝ → ℝ}
    (hmf : Measurable f) (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    SuccessorCharge.compensated (SuccessorCharge.causalMemory (finitePrimeSeed S) f) v -
      SuccessorCharge.causalMemory (finitePrimeSeed S) (SuccessorCharge.compensated f) v =
      ∫ u in Ioi (0 : ℝ), SuccessorCharge.correctedMemoryKernel (finitePrimeSeed S) v u * f u :=
  SuccessorCharge.corrected_memory_kernel_identity (measurable_finitePrimeSeed S) hmf
    (finitePrimeSeed_memLp_two S) hf v

end BuildingBlocks.PrimeSeedMass
