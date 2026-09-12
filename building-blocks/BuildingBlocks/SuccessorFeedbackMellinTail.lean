import BuildingBlocks.SuccessorFeedbackGamma

/-! The entire large-parameter tail in the actual Abel/Gamma clock comparison. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

theorem generatingFunction_zero : generatingFunction 0 = driver 0 := by
  unfold generatingFunction
  rw [tsum_eq_single 0]
  · simp
  · intro j hj
    simp [zero_pow hj]

theorem exponentialDriver_bound {t : ℝ} (ht : 1 ≤ t) :
    |generatingFunction (exp (-t)) - driver 0| ≤
      (2 * (4 * log 2 + 1) / (1 - exp (-1))) * exp (-t) := by
  have ht0 : 0 < t := lt_of_lt_of_le zero_lt_one ht
  have he : exp (-t) < 1 := by rw [exp_lt_one_iff]; linarith
  have he1 : exp (-(1 : ℝ)) < 1 := by rw [exp_lt_one_iff]; norm_num
  have hd : 0 < 1 - exp (-t) := sub_pos.mpr he
  have hd1 : 0 < 1 - exp (-(1 : ℝ)) := sub_pos.mpr he1
  have hh := generatingFunction_difference_bound (a := 0) (b := exp (-t))
    le_rfl (exp_pos _).le he
  rw [generatingFunction_zero] at hh
  have hi : (1 - exp (-t))⁻¹ ≤ (1 - exp (-(1 : ℝ)))⁻¹ :=
    inv_le_inv₀ hd hd1 |>.mpr (by linarith [exp_le_exp.mpr (neg_le_neg ht)])
  calc
    _ ≤ 2 * (4 * log 2 + 1) * (exp (-t) * (1 - exp (-t))⁻¹) := by
      convert hh using 1 <;> field_simp <;> ring
    _ ≤ 2 * (4 * log 2 + 1) * (exp (-t) * (1 - exp (-1))⁻¹) := by
      gcongr
    _ = _ := by ring

noncomputable def exponentialTailProfile (t : ℝ) : ℂ :=
  (Ioi (1 : ℝ)).indicator
    (fun u => ((generatingFunction (exp (-u)) - driver 0 : ℝ) : ℂ)) t

theorem measurable_exponentialTailProfile : Measurable exponentialTailProfile := by
  classical
  have hc : ContinuousOn (fun t : ℝ =>
      ((generatingFunction (exp (-t)) - driver 0 : ℝ) : ℂ)) (Ioi 1) := by
    apply continuousOn_of_forall_continuousAt
    intro t ht
    have he : |exp (-t)| < 1 := by
      rw [abs_of_pos (exp_pos _), exp_lt_one_iff]; linarith [show 1 < t from ht]
    exact Complex.continuous_ofReal.continuousAt.comp
      (((generatingFunction_continuousAt he).comp
        (f := fun u : ℝ => exp (-u)) (x := t)
        (continuous_exp.comp continuous_neg).continuousAt).sub continuousAt_const)
  have he : exponentialTailProfile = (Ioi (1 : ℝ)).piecewise
      (fun t => ((generatingFunction (exp (-t)) - driver 0 : ℝ) : ℂ)) (fun _ => 0) := by
    funext t
    by_cases ht : t ∈ Ioi (1 : ℝ) <;> simp [exponentialTailProfile, Set.piecewise, ht]
  rw [he]
  exact hc.measurable_piecewise continuousOn_const measurableSet_Ioi

theorem exponentialTailProfile_norm_bound (t : ℝ) :
    ‖exponentialTailProfile t‖ ≤
      (2 * (4 * log 2 + 1) / (1 - exp (-1))) * exp (-t) := by
  have hd : 0 < 1 - exp (-(1 : ℝ)) := by
    apply sub_pos.mpr; rw [exp_lt_one_iff]; norm_num
  by_cases ht : t ∈ Ioi (1 : ℝ)
  · rw [exponentialTailProfile, indicator_of_mem ht, Complex.norm_real, Real.norm_eq_abs]
    exact exponentialDriver_bound ht.le
  · rw [exponentialTailProfile, indicator_of_notMem ht, norm_zero]
    positivity

theorem exponentialTailProfile_integrable : Integrable exponentialTailProfile := by
  have hi' : IntegrableOn (fun t : ℝ =>
      (2 * (4 * log 2 + 1) / (1 - exp (-1))) * exp (-t)) (Ioi 1) :=
    (integrableOn_exp_neg_Ioi 1).const_mul _
  have hi := hi'.integrable_indicator measurableSet_Ioi
  apply hi.mono' measurable_exponentialTailProfile.aestronglyMeasurable
  exact Eventually.of_forall (fun t => by
    by_cases ht : t ∈ Ioi (1 : ℝ)
    · rw [indicator_of_mem ht]
      exact exponentialTailProfile_norm_bound t
    · rw [exponentialTailProfile, indicator_of_notMem ht, indicator_of_notMem ht, norm_zero])

theorem exponentialTailProfile_isBigO_top :
    exponentialTailProfile =O[atTop] (fun t : ℝ => exp (-(1 : ℝ) * t)) := by
  apply Asymptotics.IsBigO.of_bound (2 * (4 * log 2 + 1) / (1 - exp (-1)))
  exact Eventually.of_forall (fun t => by
    simpa only [neg_mul, one_mul, Real.norm_eq_abs, abs_of_pos (exp_pos _)] using
      exponentialTailProfile_norm_bound t)

theorem exponentialTailProfile_isBigO_zero (b : ℝ) :
    exponentialTailProfile =O[𝓝[>] (0 : ℝ)] (fun t : ℝ => t ^ (-b)) := by
  apply Asymptotics.IsBigO.of_bound 0
  filter_upwards [eventually_nhdsWithin_of_eventually_nhds
    (eventually_lt_nhds (show (0 : ℝ) < 1 by norm_num))] with t ht
  rw [exponentialTailProfile, indicator_of_notMem (show t ∉ Ioi (1 : ℝ) by
    intro h; exact (not_lt_of_ge ht.le) h), norm_zero, zero_mul]

noncomputable def exponentialMellinTail (s : ℂ) : ℂ := mellin exponentialTailProfile s

theorem exponentialMellinTail_convergent (s : ℂ) : MellinConvergent exponentialTailProfile s :=
  mellinConvergent_of_isBigO_rpow_exp (by norm_num : (0 : ℝ) < 1)
    exponentialTailProfile_integrable.integrableOn.locallyIntegrableOn
    exponentialTailProfile_isBigO_top (exponentialTailProfile_isBigO_zero (s.re - 1))
    (by linarith)

theorem exponentialMellinTail_differentiable : Differentiable ℂ exponentialMellinTail := by
  intro s
  exact mellin_differentiableAt_of_isBigO_rpow_exp (by norm_num : (0 : ℝ) < 1)
    exponentialTailProfile_integrable.integrableOn.locallyIntegrableOn
    exponentialTailProfile_isBigO_top (exponentialTailProfile_isBigO_zero (s.re - 1))
    (by linarith)

theorem exponentialMellinTail_eq_integral (s : ℂ) :
    exponentialMellinTail s = ∫ t in Ioi (1 : ℝ), (t : ℂ) ^ (s - 1) *
      ((generatingFunction (exp (-t)) - driver 0 : ℝ) : ℂ) := by
  unfold exponentialMellinTail mellin
  have he : (fun t : ℝ => (t : ℂ) ^ (s - 1) • exponentialTailProfile t) =
      (Ioi (1 : ℝ)).indicator (fun t => (t : ℂ) ^ (s - 1) *
        ((generatingFunction (exp (-t)) - driver 0 : ℝ) : ℂ)) := by
    funext t
    by_cases ht : t ∈ Ioi (1 : ℝ) <;> simp [exponentialTailProfile, ht, smul_eq_mul]
  rw [he, setIntegral_indicator measurableSet_Ioi,
    inter_eq_right.mpr (Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))]

end BuildingBlocks.SuccessorFeedback
