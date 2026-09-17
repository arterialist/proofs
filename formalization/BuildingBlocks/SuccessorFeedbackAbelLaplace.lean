import BuildingBlocks.SuccessorFeedbackAbelClock

/-! The exact positive-age Laplace transform of the original Abel feedback
profile, with the actual clock `r = 1 - exp (-h)`. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

noncomputable def abelProfile (h : ℝ) : ℝ := generatingFunction (1 - exp (-h))

theorem exp_neg_image_Ioi : (fun h : ℝ => exp (-h)) '' Ioi 0 = Ioo 0 1 := by
  ext t
  constructor
  · rintro ⟨h, hh, rfl⟩
    exact ⟨exp_pos _, by rw [exp_lt_one_iff]; exact neg_lt_zero.mpr hh⟩
  · intro ht
    refine ⟨-log t, neg_pos.mpr (log_neg ht.1 ht.2), ?_⟩
    simpa only [neg_neg] using exp_log ht.1

theorem exp_neg_cpow_jacobian (s : ℂ) (h : ℝ) :
    (exp (-h) : ℂ) * (exp (-h) : ℂ) ^ (s - 1) = Complex.exp (-s * h) := by
  rw [Complex.cpow_def_of_ne_zero (Complex.ofReal_ne_zero.mpr (exp_pos _).ne')]
  rw [← Complex.ofReal_log (exp_pos _).le, log_exp, Complex.ofReal_neg,
    Complex.ofReal_exp, Complex.ofReal_neg, ← Complex.exp_add]
  congr 1
  ring

theorem abelProfile_continuousOn : ContinuousOn abelProfile (Ici 0) := by
  apply continuousOn_of_forall_continuousAt
  intro h hh
  have he : |1 - exp (-h)| < 1 := by
    have he1 : exp (-h) ≤ 1 := by rw [exp_le_one_iff]; exact neg_nonpos.mpr hh
    rw [abs_of_nonneg (sub_nonneg.mpr he1)]
    linarith [exp_pos (-h)]
  exact (generatingFunction_continuousAt he).comp
    (f := fun u : ℝ => 1 - exp (-u)) (x := h)
    (continuous_const.sub (continuous_exp.comp continuous_neg)).continuousAt

theorem abelProfile_initial : abelProfile 0 = driver 0 := by
  simp [abelProfile, generatingFunction_zero]

theorem abelProfile_laplace_integrable {s : ℂ} (hs : (1 : ℝ) / 2 < s.re) :
    IntegrableOn (fun h : ℝ => Complex.exp (-s * h) * (abelProfile h : ℂ)) (Ioi 0) := by
  have h := integrableOn_image_iff_integrableOn_abs_deriv_smul (s := Ioi (0 : ℝ))
    measurableSet_Ioi
    (fun h _ => ((hasDerivAt_id h).neg.exp).hasDerivWithinAt)
    (exp_injective.comp neg_injective).injOn
    (fun t : ℝ => (t : ℂ) ^ (s - 1) * (generatingFunction (1 - t) : ℂ))
  simp only [Pi.neg_apply, id_eq, mul_neg_one] at h
  rw [exp_neg_image_Ioi] at h
  have hi := h.mp ((abelTransform_integrable hs).mono_set Ioo_subset_Ioc_self)
  apply hi.congr
  filter_upwards with h
  simp only [neg_mul, mul_one, abs_neg, abs_of_pos (exp_pos _), Complex.real_smul,
    ← mul_assoc, exp_neg_cpow_jacobian, abelProfile]

theorem abelTransform_eq_laplace (s : ℂ) :
    abelTransform s = ∫ h in Ioi (0 : ℝ),
      Complex.exp (-s * h) * (abelProfile h : ℂ) := by
  have he := integral_image_eq_integral_abs_deriv_smul (s := Ioi (0 : ℝ))
    measurableSet_Ioi
    (fun h _ => ((hasDerivAt_id h).neg.exp).hasDerivWithinAt)
    (exp_injective.comp neg_injective).injOn
    (fun t : ℝ => (t : ℂ) ^ (s - 1) * (generatingFunction (1 - t) : ℂ))
  simp only [Pi.neg_apply, id_eq, mul_neg_one] at he
  rw [exp_neg_image_Ioi] at he
  unfold abelTransform
  rw [integral_Ioc_eq_integral_Ioo, he]
  apply integral_congr_ae
  filter_upwards with h
  simp only [neg_mul, mul_one, abs_neg, abs_of_pos (exp_pos _), Complex.real_smul,
    ← mul_assoc, exp_neg_cpow_jacobian, abelProfile]

theorem abelProfile_laplace_eq_dirichlet {s : ℂ} (hs : (1 : ℝ) / 2 < s.re) :
    (∫ h in Ioi (0 : ℝ), Complex.exp (-s * h) * (abelProfile h : ℂ)) =
      Complex.Gamma s * dirichletTransform s + abelClockRemainder s := by
  rw [← abelTransform_eq_laplace, abelTransform_eq_dirichlet hs]

end BuildingBlocks.SuccessorFeedback
