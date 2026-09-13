import BuildingBlocks.SuccessorFeedbackFloorL1

/-! Transposition of the complete floor-error derivative against a bounded
source. The endpoint and the full integrable tail form one fixed bracket. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

noncomputable def floorSourceBracket (g : ℝ → ℂ) (t : ℝ) : ℂ :=
  g (t + 1) + ∫ x : ℝ, g (x + t) * (clippedRootDerivative x : ℂ)

private theorem root_complex_integrable :
    Integrable (fun x : ℝ => (clippedRootDerivative x : ℂ)) :=
  clippedRootDerivative_integrable.ofReal

private theorem bracketTail_integrable {g : ℝ → ℂ} (hg : Measurable g)
    {M : ℝ} (hb : ∀ x, ‖g x‖ ≤ M) (t : ℝ) :
    Integrable (fun x : ℝ => g (x + t) * (clippedRootDerivative x : ℂ)) :=
  root_complex_integrable.bdd_mul' (hg.comp (measurable_id.add_const t)).aestronglyMeasurable
    (Eventually.of_forall (fun x => hb (x + t)))

theorem floorSourceBracket_bound {g : ℝ → ℂ} (hg : Measurable g)
    {M : ℝ} (hb : ∀ x, ‖g x‖ ≤ M) (t : ℝ) :
    ‖floorSourceBracket g t‖ ≤ 2 * M := by
  have hi := bracketTail_integrable hg hb t
  have hn : ‖∫ x : ℝ, g (x + t) * (clippedRootDerivative x : ℂ)‖ ≤ M := by
    calc
      _ ≤ ∫ x : ℝ, ‖g (x + t) * (clippedRootDerivative x : ℂ)‖ :=
        norm_integral_le_integral_norm _
      _ ≤ ∫ x : ℝ, M * |clippedRootDerivative x| := by
        apply integral_mono_ae hi.norm (clippedRootDerivative_integrable.norm.const_mul M)
        filter_upwards with x
        simpa only [norm_mul, Complex.norm_real, Real.norm_eq_abs] using
          mul_le_mul_of_nonneg_right (hb (x + t)) (abs_nonneg (clippedRootDerivative x))
      _ = M := by rw [integral_const_mul, clippedRootDerivative_integral_norm, mul_one]
  exact (norm_add_le _ _).trans (by linarith [hb (t + 1)])

theorem floorSourceBracket_measurable {g : ℝ → ℂ} (hg : Measurable g) :
    Measurable (floorSourceBracket g) := by
  have hm : Measurable (fun p : ℝ × ℝ =>
      g (p.2 + p.1) * (clippedRootDerivative p.2 : ℂ)) := by
    exact (hg.comp (measurable_snd.add measurable_fst)).mul
      (Complex.measurable_ofReal.comp (clippedRootDerivative_measurable.comp measurable_snd))
  exact (hg.comp (measurable_id.add_const 1)).add hm.stronglyMeasurable.integral_prod_right'.measurable

/-- Exact Fubini transposition, with the endpoint shift and infinite tail kept
in the same source bracket. -/
theorem floorAgeError_pairing {z : ℂ} (hz : 0 < z.re) {g : ℝ → ℂ}
    (hg : Measurable g) {M : ℝ} (hb : ∀ x, ‖g x‖ ≤ M) :
    (∫ y : ℝ, g y * floorAgeError z y) =
      ∫ t in Ioi (0 : ℝ), floorWeightError z t * floorSourceBracket g t := by
  let f := floorErrorExtension z
  let k := fun x : ℝ => (clippedRootDerivative x : ℂ)
  have hf : Integrable f := floorErrorExtension_integrable hz
  have hk : Integrable k := root_complex_integrable
  have hc := hf.integrable_convolution (L := ContinuousLinearMap.mul ℂ ℂ) hk
  change Integrable (fun y : ℝ => ∫ t : ℝ, f t * k (y - t)) at hc
  have hp := hf.convolution_integrand (ContinuousLinearMap.mul ℂ ℂ) hk
  change Integrable (fun p : ℝ × ℝ => f p.2 * k (p.1 - p.2)) at hp
  have hgp : Integrable (fun p : ℝ × ℝ => g p.1 * (f p.2 * k (p.1 - p.2))) :=
    hp.bdd_mul' (hg.comp measurable_fst).aestronglyMeasurable
      (Eventually.of_forall (fun p => hb p.1))
  have hshift : Integrable (fun y : ℝ => g y * f (y - 1)) :=
    (hf.comp_sub_right 1).bdd_mul' hg.aestronglyMeasurable (Eventually.of_forall hb)
  have htail : Integrable (fun y : ℝ => g y * ∫ t : ℝ, f t * k (y - t)) :=
    hc.bdd_mul' hg.aestronglyMeasurable (Eventually.of_forall hb)
  have he : (∫ y : ℝ, g y * f (y - 1)) = ∫ t : ℝ, f t * g (t + 1) := by
    have hs := integral_add_right_eq_self (μ := volume) (fun y : ℝ => g y * f (y - 1)) 1
    simp only [add_sub_cancel_right] at hs
    rw [← hs]
    exact integral_congr_ae (Eventually.of_forall (fun t => mul_comm _ _))
  have ht : (∫ y : ℝ, g y * ∫ t : ℝ, f t * k (y - t)) =
      ∫ t : ℝ, f t * ∫ x : ℝ, g (x + t) * k x := by
    simp_rw [← integral_const_mul]
    rw [integral_integral_swap hgp]
    apply integral_congr_ae
    filter_upwards with t
    have hs := integral_add_right_eq_self (μ := volume) (fun y : ℝ => g y * (f t * k (y - t))) t
    rw [← hs]
    simp only [add_sub_cancel_right]
    apply integral_congr_ae
    filter_upwards with x
    ring
  have hleft : Integrable (fun t : ℝ => f t * g (t + 1)) := by
    exact (hf.bdd_mul' (hg.comp (measurable_id.add_const 1)).aestronglyMeasurable
      (Eventually.of_forall (fun t => hb (t + 1)))).congr
        (Eventually.of_forall (fun t => mul_comm _ _))
  have hright : Integrable (fun t : ℝ => f t * ∫ x : ℝ, g (x + t) * k x) := by
    have hi := hgp.integral_prod_right
    apply hi.congr
    filter_upwards with t
    have hs := integral_add_right_eq_self (μ := volume) (fun y : ℝ => g y * (f t * k (y - t))) t
    rw [← hs]
    simp only [add_sub_cancel_right]
    rw [← integral_const_mul]
    apply integral_congr_ae
    filter_upwards with x
    ring
  calc
    _ = (∫ y : ℝ, g y * f (y - 1)) +
        ∫ y : ℝ, g y * ∫ t : ℝ, f t * k (y - t) := by
      simp only [floorAgeError, mul_add]
      exact integral_add hshift htail
    _ = (∫ t : ℝ, f t * g (t + 1)) +
        ∫ t : ℝ, f t * ∫ x : ℝ, g (x + t) * k x := by rw [he, ht]
    _ = ∫ t : ℝ, f t * floorSourceBracket g t := by
      rw [← integral_add hleft hright]
      apply integral_congr_ae
      filter_upwards with t
      simp only [floorSourceBracket, mul_add, k]
    _ = _ := by
      change (∫ t : ℝ, floorErrorExtension z t * floorSourceBracket g t) = _
      rw [show (fun t : ℝ => floorErrorExtension z t * floorSourceBracket g t) =
        (Ioi (0 : ℝ)).indicator (fun t => floorWeightError z t * floorSourceBracket g t) by
          funext t; by_cases ht : t ∈ Ioi (0 : ℝ) <;> simp [floorErrorExtension, ht]]
      exact integral_indicator measurableSet_Ioi

/-- The literal source retains its lower branch, where the natural floor is
zero. Thus Chebyshev also supplies a whole-line bound. -/
theorem physicalError_abs_le_global (x : ℝ) :
    |physicalError x| ≤ 4 * log 2 + 1 := by
  by_cases hx : 0 < x
  · exact physicalError_abs_le hx
  · have hfloor : ⌊x⌋₊ = 0 := Nat.floor_eq_zero.mpr (by linarith)
    have he : physicalError x = -1 := by
      simp [physicalError, hfloor, CoarsePrimitive.psi]
    rw [he]
    have : 0 ≤ log (2 : ℝ) := log_nonneg (by norm_num)
    simpa using (show (1 : ℝ) ≤ 4 * log 2 + 1 by linarith)

noncomputable def actualFloorBracket : ℝ → ℂ :=
  floorSourceBracket (fun x => (physicalError x : ℂ))

theorem actualFloorBracket_bound (t : ℝ) :
    ‖actualFloorBracket t‖ ≤ 2 * (4 * log 2 + 1) := by
  apply floorSourceBracket_bound (Complex.measurable_ofReal.comp measurable_physicalError)
  intro x
  simpa only [Function.comp_apply, Complex.norm_real, Real.norm_eq_abs] using physicalError_abs_le_global x

theorem actualFloorBracket_measurable : Measurable actualFloorBracket :=
  floorSourceBracket_measurable (Complex.measurable_ofReal.comp measurable_physicalError)

theorem actual_floorAgeError_pairing {z : ℂ} (hz : 0 < z.re) :
    (∫ y : ℝ, (physicalError y : ℂ) * floorAgeError z y) =
      ∫ t in Ioi (0 : ℝ), floorWeightError z t * actualFloorBracket t := by
  apply floorAgeError_pairing hz (Complex.measurable_ofReal.comp measurable_physicalError)
    (M := 4 * log 2 + 1)
  intro x
  simpa only [Function.comp_apply, Complex.norm_real, Real.norm_eq_abs] using physicalError_abs_le_global x

theorem floorSourceBracket_eq (g : ℝ → ℂ) (t : ℝ) :
    floorSourceBracket g t = g (t + 1) - (1 / 2 : ℂ) *
      ∫ x in Ioi (1 : ℝ), g (x + t) * (x ^ (-(3 / 2 : ℝ)) : ℝ) := by
  unfold floorSourceBracket
  rw [clippedRootDerivative_eq_indicator]
  have he : (fun x : ℝ => g (x + t) *
      (((Ioi (1 : ℝ)).indicator (fun x : ℝ => -(1 / 2 : ℝ) * x ^ (-(3 / 2 : ℝ))) x : ℝ) : ℂ)) =
      (Ioi (1 : ℝ)).indicator (fun x => -(1 / 2 : ℂ) *
        (g (x + t) * (x ^ (-(3 / 2 : ℝ)) : ℝ))) := by
    funext x
    by_cases hx : x ∈ Ioi (1 : ℝ)
    · simp only [indicator_of_mem hx, Complex.ofReal_mul, Complex.ofReal_neg,
        Complex.ofReal_div, Complex.ofReal_one, Complex.ofReal_ofNat]
      ring
    · simp [hx]
  rw [he, integral_indicator measurableSet_Ioi, integral_const_mul]
  ring

theorem actual_floorAgeError_pairing_integrable {z : ℂ} (hz : 0 < z.re) :
    Integrable (fun y : ℝ => (physicalError y : ℂ) * floorAgeError z y) := by
  apply (floorAgeError_integrable hz).bdd_mul'
    (Complex.measurable_ofReal.comp measurable_physicalError).aestronglyMeasurable
    (c := 4 * log 2 + 1)
  filter_upwards with y
  simpa only [Function.comp_apply, Complex.norm_real, Real.norm_eq_abs] using
    physicalError_abs_le_global y

theorem actual_floorBracket_integrable {z : ℂ} (hz : 0 < z.re) :
    IntegrableOn (fun t => floorWeightError z t * actualFloorBracket t) (Ioi (0 : ℝ)) := by
  exact ((floorWeightError_integrable hz).bdd_mul'
    actualFloorBracket_measurable.aestronglyMeasurable
    (Eventually.of_forall actualFloorBracket_bound)).congr
      (Eventually.of_forall (fun t => mul_comm _ _))

end BuildingBlocks.SuccessorFeedback
