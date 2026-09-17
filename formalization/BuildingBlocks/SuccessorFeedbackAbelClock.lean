import BuildingBlocks.SuccessorFeedbackMellinTail
import Mathlib.Analysis.SpecialFunctions.Gamma.Deriv

/-! Exact conversion of the literal Abel transform to the original driver
Dirichlet series. All clock, index and initial-value corrections are retained. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

theorem unit_cpow_integrable {s : ℂ} (hs : 0 < s.re) :
    IntegrableOn (fun t : ℝ => (t : ℂ) ^ (s - 1)) (Ioc 0 1) := by
  apply (intervalIntegrable_iff_integrableOn_Ioc_of_le (by norm_num : (0 : ℝ) ≤ 1)).mp
  exact intervalIntegral.intervalIntegrable_cpow' (by simpa using hs : -1 < (s - 1).re)

theorem unit_cpow_integral {s : ℂ} (hs : 0 < s.re) :
    (∫ t in Ioc (0 : ℝ) 1, (t : ℂ) ^ (s - 1)) = 1 / s := by
  have hn : s ≠ 0 := by intro h; simp [h] at hs
  rw [← intervalIntegral.integral_of_le (by norm_num : (0 : ℝ) ≤ 1),
    integral_cpow (Or.inl (by simpa using hs : -1 < (s - 1).re)), sub_add_cancel,
    Complex.ofReal_one, Complex.ofReal_zero, Complex.one_cpow, Complex.zero_cpow hn, sub_zero]

theorem clock_unit_integrable {s : ℂ} (hs : 0 < s.re) :
    IntegrableOn (fun t : ℝ => (t : ℂ) ^ (s - 1) * (clockError t : ℂ)) (Ioc 0 1) := by
  apply (integrableOn_Ioc_iff_integrableOn_Ioo).mpr
  have hi := (clockMellinError_convergent hs).mono_set (Ioo_subset_Ioi_self (b := (1 : ℝ)))
  apply hi.congr_fun _ measurableSet_Ioo
  intro t ht
  simp [clockErrorProfile, ht, smul_eq_mul]

theorem clock_unit_integral (s : ℂ) :
    (∫ t in Ioc (0 : ℝ) 1, (t : ℂ) ^ (s - 1) * (clockError t : ℂ)) =
      clockMellinError s := by
  rw [integral_Ioc_eq_integral_Ioo, clockMellinError_eq_integral]
  rfl

noncomputable def abelTransform (s : ℂ) : ℂ :=
  ∫ t in Ioc (0 : ℝ) 1, (t : ℂ) ^ (s - 1) * (generatingFunction (1 - t) : ℂ)

theorem abelTransform_integrable {s : ℂ} (hs : (1 : ℝ) / 2 < s.re) :
    IntegrableOn (fun t : ℝ => (t : ℂ) ^ (s - 1) *
      (generatingFunction (1 - t) : ℂ)) (Ioc 0 1) := by
  have hg := (gammaDriver_integrable hs).mono_set (Ioc_subset_Ioi_self (b := (1 : ℝ)))
  have hp := (unit_cpow_integrable (by linarith : 0 < s.re)).mul_const (driver 0 : ℂ)
  have hc := clock_unit_integrable (by linarith : 0 < s.re)
  apply ((hg.add hp).sub hc).congr
  filter_upwards with t
  simp only [Pi.add_apply, Pi.sub_apply, clockError, Complex.ofReal_sub]
  ring

/-- The exponential-clock integral splits at one with its entire tail. -/
theorem gammaDriver_unit_integral {s : ℂ} (hs : (1 : ℝ) / 2 < s.re) :
    (∫ t in Ioc (0 : ℝ) 1, (t : ℂ) ^ (s - 1) *
      ((generatingFunction (exp (-t)) - driver 0 : ℝ) : ℂ)) =
      Complex.Gamma s * unshiftedDirichlet s - exponentialMellinTail s := by
  have hi := gammaDriver_integrable hs
  have hu := setIntegral_union (show Disjoint (Ioc (0 : ℝ) 1) (Ioi 1) from
      disjoint_left.mpr (fun _ hx hy => not_lt_of_ge hx.2 hy)) measurableSet_Ioi
    (hi.mono_set (Ioc_subset_Ioi_self (b := (1 : ℝ))))
    (hi.mono_set (Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1)))
  rw [Ioc_union_Ioi_eq_Ioi (by norm_num : (0 : ℝ) ≤ 1),
    gammaDriver_integral hs, ← exponentialMellinTail_eq_integral] at hu
  exact eq_sub_iff_add_eq.mpr hu.symm

theorem abelTransform_eq {s : ℂ} (hs : (1 : ℝ) / 2 < s.re) :
    abelTransform s = Complex.Gamma s * unshiftedDirichlet s - exponentialMellinTail s +
      (driver 0 : ℂ) / s - clockMellinError s := by
  have hg := (gammaDriver_integrable hs).mono_set (Ioc_subset_Ioi_self (b := (1 : ℝ)))
  have hp := (unit_cpow_integrable (by linarith : 0 < s.re)).mul_const (driver 0 : ℂ)
  have hc := clock_unit_integrable (by linarith : 0 < s.re)
  have he : (fun t : ℝ => (t : ℂ) ^ (s - 1) * (generatingFunction (1 - t) : ℂ)) =
      (fun t : ℝ => ((t : ℂ) ^ (s - 1) *
        ((generatingFunction (exp (-t)) - driver 0 : ℝ) : ℂ) +
        (t : ℂ) ^ (s - 1) * (driver 0 : ℂ)) - (t : ℂ) ^ (s - 1) * (clockError t : ℂ)) := by
    funext t
    simp only [clockError, Complex.ofReal_sub]
    ring
  unfold abelTransform
  have ha : IntegrableOn (fun t : ℝ => (t : ℂ) ^ (s - 1) *
      ((generatingFunction (exp (-t)) - driver 0 : ℝ) : ℂ) +
      (t : ℂ) ^ (s - 1) * (driver 0 : ℂ)) (Ioc 0 1) := hg.add hp
  rw [he, integral_sub ha hc, integral_add hg hp,
    gammaDriver_unit_integral hs, integral_mul_const,
    unit_cpow_integral (by linarith : 0 < s.re), clock_unit_integral]
  ring

noncomputable def abelClockRemainder (s : ℂ) : ℂ :=
  -(Complex.Gamma s * indexCorrection s) - exponentialMellinTail s +
    (driver 0 : ℂ) / s - clockMellinError s

/-- Every non-Dirichlet term in the exact Abel clock conversion continues
holomorphically to the full right half-plane. -/
theorem abelClockRemainder_analyticOnNhd :
    AnalyticOnNhd ℂ abelClockRemainder {s : ℂ | 0 < s.re} := by
  apply DifferentiableOn.analyticOnNhd _ (isOpen_lt continuous_const Complex.continuous_re)
  intro s hs
  have hg : DifferentiableAt ℂ Complex.Gamma s := by
    apply Complex.differentiableAt_Gamma
    intro m he
    have := congrArg Complex.re he
    simp only [Complex.neg_re, Complex.natCast_re] at this
    have hm : (0 : ℝ) ≤ m := Nat.cast_nonneg m
    linarith [show 0 < s.re from hs]
  have hn : s ≠ 0 := by intro he; simp [he] at hs
  exact (((hg.mul (indexCorrection_differentiableAt (by linarith [show 0 < s.re from hs]))).neg.sub
    (exponentialMellinTail_differentiable s)).add
    (differentiableAt_const (driver 0 : ℂ) |>.div differentiableAt_id hn) |>.sub
    (clockMellinError_differentiableAt hs)).differentiableWithinAt

theorem abelTransform_eq_dirichlet {s : ℂ} (hs : (1 : ℝ) / 2 < s.re) :
    abelTransform s = Complex.Gamma s * dirichletTransform s + abelClockRemainder s := by
  rw [abelTransform_eq hs, abelClockRemainder, indexCorrection_eq_difference hs]
  ring

end BuildingBlocks.SuccessorFeedback
