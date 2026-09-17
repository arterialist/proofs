import BuildingBlocks.SuccessorCriticalLift

/-! Inner products under the critical exponential coordinate change and the
exact successor/predecessor output ranges. -/

open MeasureTheory Real Set
open scoped ENNReal

namespace BuildingBlocks.MixedEnergy

theorem exp_image_Ioi (a : ℝ) : exp '' Ioi a = Ioi (exp a) := by
  ext x
  constructor
  · rintro ⟨v, hv, rfl⟩
    exact exp_lt_exp.mpr hv
  · intro hx
    have hp : 0 < x := lt_trans (exp_pos a) hx
    refine ⟨log x, ?_, exp_log hp⟩
    exact exp_lt_exp.mp (by simpa only [exp_log hp] using hx)

theorem physicalLift_mul (H G : ℝ → ℝ) (v : ℝ) :
    physicalLift H v * physicalLift G v = exp v * (H (exp v) * G (exp v)) := by
  have he : exp (v / 2) * exp (v / 2) = exp v := by
    rw [← exp_add, add_halves]
  unfold physicalLift
  calc
    _ = (exp (v / 2) * exp (v / 2)) * (H (exp v) * G (exp v)) := by ring
    _ = _ := by rw [he]

/-- Both inputs carry the critical square-root Jacobian. -/
theorem physicalLift_pair_integral (H G : ℝ → ℝ) (a : ℝ) :
    (∫ v in Ioi a, physicalLift H v * physicalLift G v) =
      ∫ x in Ioi (exp a), H x * G x := by
  have h := integral_image_eq_integral_abs_deriv_smul (s := Ioi a) measurableSet_Ioi
    (fun v _ => (hasDerivAt_exp v).hasDerivWithinAt) exp_injective.injOn
    (fun x => H x * G x)
  rw [exp_image_Ioi] at h
  rw [h]
  apply integral_congr_ae
  exact Filter.Eventually.of_forall (fun v => by
    dsimp only
    rw [smul_eq_mul, abs_of_pos (exp_pos v), physicalLift_mul])

theorem physicalLift_square_lintegral (H : ℝ → ℝ) (a : ℝ) :
    (∫⁻ v in Ioi a, ENNReal.ofReal (physicalLift H v ^ 2)) =
      ∫⁻ x in Ioi (exp a), ENNReal.ofReal (H x ^ 2) := by
  have h := lintegral_image_eq_lintegral_abs_deriv_mul (s := Ioi a) measurableSet_Ioi
    (fun v _ => (hasDerivAt_exp v).hasDerivWithinAt) exp_injective.injOn
    (fun x => ENNReal.ofReal (H x ^ 2))
  rw [exp_image_Ioi] at h
  rw [h]
  apply lintegral_congr
  intro v
  rw [abs_of_pos (exp_pos v), ← ENNReal.ofReal_mul (exp_pos v).le]
  simp only [pow_two, physicalLift_mul]

theorem measurable_physicalLift {H : ℝ → ℝ} (hH : Measurable H) :
    Measurable (physicalLift H) := by unfold physicalLift; fun_prop

theorem physicalLift_memLp {H : ℝ → ℝ} (hH : Measurable H) (a : ℝ)
    (hf : MemLp H 2 (volume.restrict (Ioi (exp a)))) :
    MemLp (physicalLift H) 2 (volume.restrict (Ioi a)) := by
  apply (memLp_two_iff_integrable_sq (measurable_physicalLift hH).aestronglyMeasurable).2
  refine ⟨((measurable_physicalLift hH).pow_const 2).aestronglyMeasurable, ?_⟩
  have hi := hf.integrable_sq.hasFiniteIntegral
  rw [hasFiniteIntegral_iff_ofReal (Filter.Eventually.of_forall (fun x => sq_nonneg (H x)))] at hi
  rw [hasFiniteIntegral_iff_ofReal
    (Filter.Eventually.of_forall (fun v => sq_nonneg (physicalLift H v))), physicalLift_square_lintegral]
  exact hi

end BuildingBlocks.MixedEnergy

namespace BuildingBlocks.SuccessorCharge

theorem critical_successor_pair (H G : ℝ → ℝ) :
    (∫ v in Ioi (0 : ℝ), MixedEnergy.physicalLift H v *
      successor (MixedEnergy.physicalLift G) v) =
      ∫ x in Ioi (1 : ℝ), H x * G (x + 1) := by
  have he : successor (MixedEnergy.physicalLift G) =
      MixedEnergy.physicalLift (fun x => G (x + 1)) := by
    funext v
    exact successor_physicalLift G v
  rw [he, MixedEnergy.physicalLift_pair_integral, exp_zero]

theorem critical_predecessor_pair (H G : ℝ → ℝ) :
    (∫ u in Ioi (0 : ℝ), MixedEnergy.physicalLift H u *
      predecessor (MixedEnergy.physicalLift G) u) =
      ∫ x in Ioi (2 : ℝ), H x * G (x - 1) := by
  have he : (fun u => MixedEnergy.physicalLift H u * predecessor (MixedEnergy.physicalLift G) u) =
      (Ioi (log 2)).indicator (fun u => MixedEnergy.physicalLift H u *
        MixedEnergy.physicalLift (fun x => G (x - 1)) u) := by
    funext u
    by_cases hu : log 2 < u
    · rw [indicator_of_mem (s := Ioi (log 2)) hu, predecessor_physicalLift G hu]
      rfl
    · rw [predecessor_initial _ (le_of_not_gt hu), mul_zero,
        indicator_of_notMem (s := Ioi (log 2)) hu]
  rw [he, setIntegral_indicator measurableSet_Ioi,
    inter_eq_right.mpr (Ioi_subset_Ioi (log_pos (by norm_num : (1 : ℝ) < 2)).le),
    MixedEnergy.physicalLift_pair_integral, exp_log (by norm_num : (0 : ℝ) < 2)]

theorem critical_successor_pair_causal {H : ℝ → ℝ} (G : ℝ → ℝ)
    (hzero : ∀ᵐ x : ℝ, x < 1 → H x = 0) :
    (∫ v in Ioi (0 : ℝ), MixedEnergy.physicalLift H v *
      successor (MixedEnergy.physicalLift G) v) = ∫ x, H x * G (x + 1) := by
  rw [critical_successor_pair]
  apply setIntegral_eq_integral_of_ae_compl_eq_zero
  have hn : ∀ᵐ x : ℝ, x ≠ 1 := by rw [ae_iff]; simp
  filter_upwards [hzero, hn] with x hx hn hout
  have hx1 : x < 1 := lt_of_le_of_ne (le_of_not_gt hout) hn
  rw [hx hx1, zero_mul]

theorem critical_predecessor_pair_causal (H : ℝ → ℝ) {G : ℝ → ℝ}
    (hzero : ∀ᵐ x : ℝ, x < 1 → G x = 0) :
    (∫ u in Ioi (0 : ℝ), MixedEnergy.physicalLift H u *
      predecessor (MixedEnergy.physicalLift G) u) = ∫ x, H x * G (x - 1) := by
  rw [critical_predecessor_pair]
  apply setIntegral_eq_integral_of_ae_compl_eq_zero
  have ht : ∀ᵐ x : ℝ, x - 1 < 1 → G (x - 1) = 0 := by
    simpa only [sub_eq_add_neg] using
      (measurePreserving_add_right volume (-1 : ℝ)).quasiMeasurePreserving.tendsto_ae.eventually hzero
  have hn : ∀ᵐ x : ℝ, x ≠ 2 := by rw [ae_iff]; simp
  filter_upwards [ht, hn] with x hx hn hout
  have hx2 : x < 2 := lt_of_le_of_ne (le_of_not_gt hout) hn
  rw [hx (by linarith), mul_zero]

/-- The exact physical kernel contact equals the two logarithmic boundary-port
pairings. Causality is used separately at each actual output boundary. -/
theorem critical_contact_identity {H G : ℝ → ℝ}
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume)
    (hzH : ∀ᵐ x : ℝ, x < 1 → H x = 0) (hzG : ∀ᵐ x : ℝ, x < 1 → G x = 0) :
    MixedEnergy.contactForm H G = -MixedEnergy.symmetricKernelPair H G +
      2 * ((∫ v in Ioi (0 : ℝ), MixedEnergy.physicalLift H v *
        successor (MixedEnergy.physicalLift G) v) +
      ∫ v in Ioi (0 : ℝ), MixedEnergy.physicalLift H v *
        predecessor (MixedEnergy.physicalLift G) v) := by
  rw [MixedEnergy.contactForm_eq_kernel hH hG, critical_successor_pair_causal G hzH,
    critical_predecessor_pair_causal H hzG]
  have hm : MemLp (fun x => G (x - 1)) 2 volume := by
    simpa only [sub_eq_add_neg] using MixedEnergy.translated_memLp hG (-1)
  have hi := hH.integrable_mul hm
  have hj := hH.integrable_mul (MixedEnergy.translated_memLp hG 1)
  simp only [Pi.mul_def] at hi hj
  simp_rw [mul_add]
  rw [integral_add hi hj]
  ring

theorem critical_contact_bound {H G : ℝ → ℝ}
    (hmH : Measurable H) (hmG : Measurable G)
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume)
    (hzH : ∀ᵐ x : ℝ, x < 1 → H x = 0) (hzG : ∀ᵐ x : ℝ, x < 1 → G x = 0) :
    |-MixedEnergy.symmetricKernelPair H G +
      2 * ((∫ v in Ioi (0 : ℝ), MixedEnergy.physicalLift H v *
        successor (MixedEnergy.physicalLift G) v) +
      ∫ v in Ioi (0 : ℝ), MixedEnergy.physicalLift H v *
        predecessor (MixedEnergy.physicalLift G) v)| ≤
      9 * sqrt ((MixedEnergy.energy H).toReal) * sqrt ((MixedEnergy.energy G).toReal) := by
  rw [← critical_contact_identity hH hG hzH hzG]
  exact MixedEnergy.contactForm_bound hmH hmG
    (MixedEnergy.energy_lt_top_of_memLp hmH hH) (MixedEnergy.energy_lt_top_of_memLp hmG hG)

end BuildingBlocks.SuccessorCharge
