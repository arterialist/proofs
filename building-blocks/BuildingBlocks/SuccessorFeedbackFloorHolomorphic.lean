import BuildingBlocks.SuccessorFeedbackFloorPairing
import Mathlib.Analysis.Complex.Liouville

/-! Holomorphy of the literal floor-error pairing. Cauchy's estimate turns the
locally uniform L¹ bound into an integrable parameter-derivative majorant. -/

open MeasureTheory Real Set Filter Metric
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

noncomputable def floorErrorParameterDerivative (z : ℂ) (t : ℝ) : ℂ :=
  -(log (⌊t⌋₊ + 1 : ℝ) : ℂ) * floorWeight z t +
    (log (t + 1) : ℂ) * ((t + 1 : ℝ) : ℂ) ^ (-z)

theorem floorWeightError_hasDerivAt (z : ℂ) {t : ℝ} (ht : 0 ≤ t) :
    HasDerivAt (fun w => floorWeightError w t) (floorErrorParameterDerivative z t) z := by
  have hn : (0 : ℝ) < ⌊t⌋₊ + 1 := by positivity
  have hb : 0 < t + 1 := by positivity
  have h := ((hasDerivAt_id z).neg.const_cpow
    (c := ((⌊t⌋₊ + 1 : ℕ) : ℂ))
    (Or.inl (by exact_mod_cast (Nat.succ_ne_zero ⌊t⌋₊)))).sub
      ((hasDerivAt_id z).neg.const_cpow (c := ((t + 1 : ℝ) : ℂ))
        (Or.inl (by exact_mod_cast hb.ne')))
  convert h using 1
  simp only [floorWeightError, floorErrorParameterDerivative, floorWeight,
    Pi.neg_apply, id_eq]
  rw [show ((⌊t⌋₊ + 1 : ℕ) : ℂ) = ((⌊t⌋₊ + 1 : ℝ) : ℂ) by push_cast; rfl,
    ← Complex.ofReal_log hn.le, ← Complex.ofReal_log hb.le]
  ring

theorem floorErrorParameterDerivative_measurable (z : ℂ) :
    Measurable (floorErrorParameterDerivative z) := by
  unfold floorErrorParameterDerivative
  have hm : Measurable (fun t : ℝ => -(log (⌊t⌋₊ + 1 : ℝ) : ℂ)) := by fun_prop
  exact (hm.mul (measurable_floorWeight z)).add (by fun_prop)

/-- Uniform derivative domination on an actual parameter disk, with no
unproved pointwise estimate for the age derivative. -/
theorem floorErrorParameterDerivative_local_bound {z : ℂ} (hz : 0 < z.re)
    {w : ℂ} (hw : w ∈ ball z (z.re / 4)) {t : ℝ} (ht : 0 ≤ t) :
    ‖floorErrorParameterDerivative w t‖ ≤
      (((‖z‖ + z.re + 1) * (2 : ℝ) ^ (‖z‖ + z.re + 2)) / (z.re / 4)) *
        (t + 1) ^ (-(z.re / 2) - 1) := by
  have hr : 0 < z.re / 4 := by linarith
  have hd := Complex.norm_deriv_le_of_forall_mem_sphere_norm_le (c := w) hr
    (floorWeightError_differentiable ht).diffContOnCl
    (C := ((‖z‖ + z.re + 1) * (2 : ℝ) ^ (‖z‖ + z.re + 2)) *
      (t + 1) ^ (-(z.re / 2) - 1))
  have hb : ∀ v ∈ sphere w (z.re / 4), ‖floorWeightError v t‖ ≤
      ((‖z‖ + z.re + 1) * (2 : ℝ) ^ (‖z‖ + z.re + 2)) *
        (t + 1) ^ (-(z.re / 2) - 1) := by
    intro v hv
    have hdist : dist v z < z.re / 2 := by
      have hv' : dist v w = z.re / 4 := mem_sphere.mp hv
      have hw' : dist w z < z.re / 4 := mem_ball.mp hw
      have := dist_triangle v w z
      linarith
    have hre : z.re / 2 ≤ v.re := by
      have h := Complex.re_le_norm (z - v)
      rw [Complex.sub_re] at h
      rw [dist_eq_norm, norm_sub_rev] at hdist
      linarith
    have hnorm : ‖v‖ ≤ ‖z‖ + z.re + 1 := by
      have h := norm_le_norm_add_const_of_dist_le hdist.le
      linarith
    simpa only [show (‖z‖ + z.re + 1) + 1 = ‖z‖ + z.re + 2 by ring] using
      floorWeightError_uniform_bound (by linarith : 0 < z.re / 2) hre hnorm ht
  have h := hd hb
  rw [(floorWeightError_hasDerivAt w ht).deriv] at h
  convert h using 1 <;> ring

noncomputable def floorErrorPairing (b : ℝ → ℂ) (z : ℂ) : ℂ :=
  ∫ t in Ioi (0 : ℝ), floorWeightError z t * b t

theorem floorErrorPairing_integrable {b : ℝ → ℂ} (hb : Measurable b)
    {M : ℝ} (hM : ∀ t, ‖b t‖ ≤ M) {z : ℂ} (hz : 0 < z.re) :
    IntegrableOn (fun t => floorWeightError z t * b t) (Ioi (0 : ℝ)) := by
  exact ((floorWeightError_integrable hz).bdd_mul' hb.aestronglyMeasurable
    (Eventually.of_forall hM)).congr (Eventually.of_forall (fun t => mul_comm _ _))

theorem floorErrorPairing_differentiableAt {b : ℝ → ℂ} (hb : Measurable b)
    {M : ℝ} (hM : ∀ t, ‖b t‖ ≤ M) {z : ℂ} (hz : 0 < z.re) :
    DifferentiableAt ℂ (floorErrorPairing b) z := by
  let C := ((‖z‖ + z.re + 1) * (2 : ℝ) ^ (‖z‖ + z.re + 2)) / (z.re / 4)
  have hC : 0 ≤ C := by dsimp [C]; positivity
  have hmajor : IntegrableOn (fun t : ℝ => (C * M) * (t + 1) ^ (-(z.re / 2) - 1))
      (Ioi (0 : ℝ)) :=
    (integrableOn_add_rpow_Ioi_of_lt (by linarith : -(z.re / 2) - 1 < -1)
      (by norm_num : -(1 : ℝ) < 0)).const_mul (C * M)
  have h := hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (F := fun w t => floorWeightError w t * b t)
    (F' := fun w t => floorErrorParameterDerivative w t * b t)
    (μ := volume.restrict (Ioi (0 : ℝ)))
    (bound := fun t => (C * M) * (t + 1) ^ (-(z.re / 2) - 1))
    (show 0 < z.re / 4 by linarith)
    (Eventually.of_forall (fun w => ((measurable_floorWeightError w).mul hb).aestronglyMeasurable))
    (floorErrorPairing_integrable hb hM hz)
    ((floorErrorParameterDerivative_measurable z).mul hb).aestronglyMeasurable
    ?_ hmajor ?_
  · exact h.2.differentiableAt
  · filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht w hw
    rw [norm_mul]
    have hd := floorErrorParameterDerivative_local_bound hz hw ht.le
    have hm := mul_le_mul hd (hM t) (norm_nonneg (b t))
      (mul_nonneg hC (rpow_nonneg (by have := ht; change 0 < t at this; linarith : 0 ≤ t + 1) _))
    dsimp only [C] at hm ⊢
    nlinarith only [hm]
  · filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht w _
    exact (floorWeightError_hasDerivAt w ht.le).mul_const (b t)

theorem floorErrorPairing_analyticOnNhd {b : ℝ → ℂ} (hb : Measurable b)
    {M : ℝ} (hM : ∀ t, ‖b t‖ ≤ M) :
    AnalyticOnNhd ℂ (floorErrorPairing b) {z : ℂ | 0 < z.re} := by
  apply DifferentiableOn.analyticOnNhd _ (isOpen_lt continuous_const Complex.continuous_re)
  exact fun z hz => (floorErrorPairing_differentiableAt hb hM hz).differentiableWithinAt

noncomputable def actualFloorRemainder (z : ℂ) : ℂ :=
  ∫ y : ℝ, (physicalError y : ℂ) * floorAgeError z y

theorem actualFloorRemainder_eq {z : ℂ} (hz : 0 < z.re) :
    actualFloorRemainder z = floorErrorPairing actualFloorBracket z :=
  actual_floorAgeError_pairing hz

theorem actualFloorRemainder_analyticOnNhd :
    AnalyticOnNhd ℂ actualFloorRemainder {z : ℂ | 0 < z.re} := by
  have h := floorErrorPairing_analyticOnNhd actualFloorBracket_measurable actualFloorBracket_bound
  apply h.congr (isOpen_lt continuous_const Complex.continuous_re)
  intro z hz
  exact (actualFloorRemainder_eq hz).symm

end BuildingBlocks.SuccessorFeedback
