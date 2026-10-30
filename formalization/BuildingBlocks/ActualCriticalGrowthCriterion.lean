import BuildingBlocks.ActualCriticalConvergence
import BuildingBlocks.ActualCriticalLaplace
import BuildingBlocks.CriticalTransformContinuationRH
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import Mathlib.Analysis.SpecialFunctions.Complex.Analytic

/-!
# One-sided growth criterion for the actual critical sum

The eventual-sign criterion (`ActualCriticalSignCriterion`) deduces Mathlib's
`RiemannHypothesis` from `W x ≤ 0` for all large `x`. The sign is used in exactly
one place: it makes the density `-W(x) x^{-2}` of the Landau measure nonnegative.

Here the sign hypothesis is replaced by the weaker one-sided growth hypothesis
`Re W(x) ≤ C x^{3/2}` for all `x > A`, with any real constant `C`. The Landau
measure now has density `(C x^{3/2} - W(x)) x^{-2}` on `x > A`. Its Laplace
transform differs from the previous one by the explicit term

  `C ∫_A^∞ x^{-s-1/2} dx = C A^{1/2-s}/(s-1/2)`,

which is analytic on `Re s > 1/2`. So the continuation argument goes through
unchanged and the double poles of the filled transform at off-line zeros are
still excluded.

The case `C = 0` is the previous criterion. For `C > 0` the hypothesis allows
positive excursions of `W` of size `C x^{3/2}`; under RH the main term of `W`
is `-(1/6) x^{3/2} log^2 x`, so the hypothesis is expected to hold with every
`C ≥ 0`, while a single zero `ρ` with `Re ρ > 1/2` forces excursions of size
`x^{Re ρ + 1}` and violates it. The hypothesis is therefore still an unproved
arithmetic premise of RH strength; the theorem only sharpens which premise.

No new axioms. All statements are conditional on the stated growth premise.
-/

open MeasureTheory Set Filter
open scoped Topology ENNReal

namespace BuildingBlocks.ActualCriticalGrowthCriterion

open ActualCriticalMeasure MellinCompactCorrection

/-! ### The majorant tail and its Landau measure -/

/-- The majorant `C x^{3/2}`, as a complex-valued function of a real variable. -/
noncomputable def majorant (C : ℝ) (x : ℝ) : ℂ := ((C * x ^ ((3 : ℝ) / 2) : ℝ) : ℂ)

/-- The nonnegative tail `(C x^{3/2} - W x) 1_{x > A}` under the growth premise. -/
noncomputable def growthTail (C A : ℝ) (x : ℝ) : ℂ :=
  tailPart (majorant C) A x + negativeWTail A x

theorem growthTail_im (C A x : ℝ) : (growthTail C A x).im = 0 := by
  by_cases hx : A < x <;> simp [growthTail, tailPart, majorant, hx, negativeWTail_im]

theorem growthTail_re_nonneg {C A : ℝ}
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2)) (x : ℝ) :
    0 ≤ (growthTail C A x).re := by
  by_cases hx : A < x
  · have := hgrow x hx
    simp only [growthTail, tailPart, negativeWTail, majorant, Set.indicator_of_mem (mem_Ioi.mpr hx),
      Complex.add_re, Complex.neg_re, Complex.ofReal_re]
    linarith
  · simp [growthTail, tailPart, negativeWTail, hx]

theorem growthTail_ofReal (C A x : ℝ) :
    growthTail C A x = ((growthTail C A x).re : ℂ) := by
  apply Complex.ext
  · rfl
  · simp [growthTail_im]

theorem measurable_growthTail (C A : ℝ) : Measurable (growthTail C A) := by
  unfold growthTail tailPart majorant
  refine Measurable.add ?_ (measurable_negativeWTail A)
  refine Measurable.indicator ?_ measurableSet_Ioi
  exact Complex.measurable_ofReal.comp (measurable_const.mul (measurable_id.pow_const _))

/-- Density `x^{-2} (C x^{3/2} - W x)` on `x > A`, clipped at zero. Under the
growth premise the clipping is inactive. -/
noncomputable def growthDensity (C A x : ℝ) : ℝ≥0∞ :=
  ENNReal.ofReal (x ^ (-2 : ℝ) * (growthTail C A x).re)

theorem measurable_growthDensity (C A : ℝ) : Measurable (growthDensity C A) :=
  ((measurable_id.pow measurable_const).mul
    (Complex.measurable_re.comp (measurable_growthTail C A))).ennreal_ofReal

/-- The positive Landau measure of the growth criterion. -/
noncomputable def growthMeasure (C A : ℝ) : Measure ℝ :=
  (volume.restrict (Ioi 1)).withDensity (growthDensity C A)

theorem growthDensity_toReal {C A : ℝ}
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2))
    {x : ℝ} (hx : 0 ≤ x) :
    (growthDensity C A x).toReal = x ^ (-2 : ℝ) * (growthTail C A x).re := by
  unfold growthDensity
  exact ENNReal.toReal_ofReal (mul_nonneg (Real.rpow_nonneg hx _) (growthTail_re_nonneg hgrow x))

/-- The `x^{-2}` normalization turns the Laplace exponential in `time x = log x`
into the Mellin exponent `-s-2`. -/
theorem density_smul_exp {C A : ℝ}
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2))
    {x : ℝ} (hx : 1 < x) (s : ℂ) :
    (growthDensity C A x).toReal • Complex.exp (-s * (time x : ℂ)) =
      (x : ℂ) ^ (-s - 2) * growthTail C A x := by
  have hx0 : 0 < x := lt_trans zero_lt_one hx
  have hn : (x : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hx0.ne'
  have he : Complex.exp (-s * (Real.log x : ℂ)) = (x : ℂ) ^ (-s) := by
    rw [Complex.cpow_def_of_ne_zero hn, ← Complex.ofReal_log hx0.le]
    congr 1
    ring
  rw [growthDensity_toReal hgrow hx0.le, time_eq_log hx, he]
  simp only [Complex.real_smul, Complex.ofReal_mul]
  rw [← growthTail_ofReal, Complex.ofReal_cpow hx0.le]
  norm_num only [Complex.ofReal_neg, Complex.ofReal_ofNat]
  rw [show (x : ℂ) ^ (-2 : ℂ) * growthTail C A x * (x : ℂ) ^ (-s) =
      ((x : ℂ) ^ (-2 : ℂ) * (x : ℂ) ^ (-s)) * growthTail C A x by ring,
    ← Complex.cpow_add _ _ hn]
  congr 2
  ring

/-! ### Laplace transform of the growth measure -/

/-- The Laplace moment is the actual Mellin integral of the growth tail. -/
theorem moment_eq_integral {C A : ℝ}
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2)) (s : ℂ) :
    LaplaceMomentDerivatives.moment (growthMeasure C A) time 0 s =
      ∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * growthTail C A x := by
  unfold LaplaceMomentDerivatives.moment LaplaceMomentDerivatives.integrand growthMeasure
  simp only [pow_zero, one_mul]
  rw [integral_withDensity_eq_integral_toReal_smul (measurable_growthDensity C A)
    (Filter.Eventually.of_forall (fun x => ENNReal.ofReal_lt_top))]
  apply setIntegral_congr_fun measurableSet_Ioi
  intro x hx
  exact density_smul_exp hgrow hx s

/-- Pointwise: the majorant kernel is a single complex power. -/
theorem majorant_kernel_eq {C : ℝ} {x : ℝ} (hx : 0 < x) (s : ℂ) :
    (x : ℂ) ^ (-s - 2) * majorant C x = (C : ℂ) * (x : ℂ) ^ (-s - 1 / 2) := by
  have hn : (x : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hx.ne'
  unfold majorant
  rw [Complex.ofReal_mul, Complex.ofReal_cpow hx.le]
  rw [show (x : ℂ) ^ (-s - 2) * ((C : ℂ) * (x : ℂ) ^ (((3 : ℝ) / 2 : ℝ) : ℂ)) =
      (C : ℂ) * ((x : ℂ) ^ (-s - 2) * (x : ℂ) ^ (((3 : ℝ) / 2 : ℝ) : ℂ)) by ring,
    ← Complex.cpow_add _ _ hn]
  congr 2
  push_cast
  ring

/-- Explicit tail transform of the majorant: `C A^{1/2-s}/(s-1/2)`, written in
the form returned by `integral_Ioi_cpow_of_lt`. -/
noncomputable def majorantTransform (C A : ℝ) (s : ℂ) : ℂ :=
  (C : ℂ) * (-(A : ℂ) ^ (-s - 1 / 2 + 1) / (-s - 1 / 2 + 1))

theorem integrableOn_majorant_kernel {A : ℝ} (hA : 0 < A) {s : ℂ} (hs : 1 < s.re) (C : ℝ) :
    IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-s - 2) * majorant C x) (Ioi A) := by
  have hre : (-s - 1 / 2 : ℂ).re < -1 := by
    simp only [Complex.sub_re, Complex.neg_re, Complex.div_re, Complex.one_re, Complex.one_im,
      Complex.re_ofNat, Complex.im_ofNat]
    norm_num
    linarith
  have hi : IntegrableOn (fun x : ℝ => (C : ℂ) * (x : ℂ) ^ (-s - 1 / 2)) (Ioi A) :=
    (integrableOn_Ioi_cpow_of_lt hre hA).const_mul (C : ℂ)
  refine hi.congr_fun ?_ measurableSet_Ioi
  intro x hx
  exact (majorant_kernel_eq (lt_trans hA (mem_Ioi.mp hx)) s).symm

theorem integral_majorant_kernel {A : ℝ} (hA : 0 < A) {s : ℂ} (hs : 1 < s.re) (C : ℝ) :
    (∫ x : ℝ in Ioi A, (x : ℂ) ^ (-s - 2) * majorant C x) = majorantTransform C A s := by
  have hre : (-s - 1 / 2 : ℂ).re < -1 := by
    simp only [Complex.sub_re, Complex.neg_re, Complex.div_re, Complex.one_re, Complex.one_im,
      Complex.re_ofNat, Complex.im_ofNat]
    norm_num
    linarith
  have hcongr : (∫ x : ℝ in Ioi A, (x : ℂ) ^ (-s - 2) * majorant C x) =
      ∫ x : ℝ in Ioi A, (C : ℂ) * (x : ℂ) ^ (-s - 1 / 2) := by
    apply setIntegral_congr_fun measurableSet_Ioi
    intro x hx
    exact majorant_kernel_eq (lt_trans hA (mem_Ioi.mp hx)) s
  rw [hcongr, integral_const_mul, integral_Ioi_cpow_of_lt hre hA]
  rfl

/-- The tail of the majorant over `(1, ∞)` is the integral over `(A, ∞)`. -/
theorem integral_majorant_tail {A : ℝ} (hA : 1 ≤ A) {s : ℂ} (hs : 1 < s.re) (C : ℝ) :
    (∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * tailPart (majorant C) A x) =
      majorantTransform C A s := by
  rw [← integral_majorant_kernel (lt_of_lt_of_le zero_lt_one hA) hs C]
  have h1 : (∫ x : ℝ in Ioi A, (x : ℂ) ^ (-s - 2) * majorant C x) =
      ∫ x : ℝ in Ioi A, (x : ℂ) ^ (-s - 2) * tailPart (majorant C) A x := by
    apply setIntegral_congr_fun measurableSet_Ioi
    intro x hx
    simp [tailPart, mem_Ioi.mp hx]
  rw [h1]
  apply setIntegral_eq_of_subset_of_forall_sdiff_eq_zero measurableSet_Ioi
    (Ioi_subset_Ioi hA)
  intro x hx
  have hxA : ¬ A < x := by have := hx.2; simp only [mem_Ioi, not_lt] at this; linarith
  simp [tailPart, hxA]

theorem integrableOn_majorant_tail {A : ℝ} (hA : 1 ≤ A) {s : ℂ} (hs : 1 < s.re) (C : ℝ) :
    IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-s - 2) * tailPart (majorant C) A x) (Ioi 1) := by
  have hi := integrableOn_majorant_kernel (lt_of_lt_of_le zero_lt_one hA) hs C
  have heq : (fun x : ℝ => (x : ℂ) ^ (-s - 2) * tailPart (majorant C) A x) =
      (Ioi A).indicator (fun x : ℝ => (x : ℂ) ^ (-s - 2) * majorant C x) := by
    funext x
    by_cases hx : A < x
    · simp [tailPart, hx]
    · simp [tailPart, hx]
  rw [heq]
  have hres : IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-s - 2) * majorant C x) (Ioi A)
      (volume.restrict (Ioi 1)) := by
    rw [IntegrableOn, Measure.restrict_restrict measurableSet_Ioi, Ioi_inter_Ioi,
      sup_eq_left.mpr hA]
    exact hi
  exact (integrable_indicator_iff measurableSet_Ioi).mpr hres

theorem integrableOn_negativeWTail_kernel {A : ℝ} (hA : 1 ≤ A) {s : ℂ} (hs : 1 < s.re) :
    IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-s - 2) * negativeWTail A x) (Ioi 1) := by
  have hm := (hasMellin_negativeWTail hA hs).1
  have hi0 : IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-s - 2) * negativeWTail A x) (Ioi 0) := by
    have h := hm
    rw [MellinConvergent] at h
    have hpow : (-s - 1) - 1 = -s - 2 := by ring
    rw [hpow] at h
    exact h
  exact hi0.mono_set (Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))

theorem integral_negativeWTail_kernel {A : ℝ} (hA : 1 ≤ A) (s : ℂ) :
    (∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * negativeWTail A x) =
      mellin (negativeWTail A) (-s - 1) := by
  unfold mellin
  simp only [smul_eq_mul, show (-s - 1) - 1 = -s - 2 by ring]
  symm
  apply setIntegral_eq_of_subset_of_forall_sdiff_eq_zero measurableSet_Ioi
    (Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))
  intro x hx
  have hxA : ¬ A < x := by have := hx.2; simp only [mem_Ioi, not_lt] at this; linarith
  simp [negativeWTail, tailPart, hxA]

/-- Laplace transform of the growth measure on the absolute-convergence half-plane:
the explicit majorant term plus the compact initial part, minus the filled transform. -/
theorem moment_eq_majorant_add_initial_sub_filled {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2))
    {s : ℂ} (hs : 1 < s.re) :
    LaplaceMomentDerivatives.moment (growthMeasure C A) time 0 s =
      majorantTransform C A s +
        (mellin (initialPart ActualCriticalMellin.W A) (-s - 1) -
          CriticalTransformPoles.filledTransform s) := by
  rw [moment_eq_integral hgrow s]
  have hsplit : (∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * growthTail C A x) =
      (∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * tailPart (majorant C) A x) +
        ∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * negativeWTail A x := by
    rw [← integral_add (integrableOn_majorant_tail hA hs C) (integrableOn_negativeWTail_kernel hA hs)]
    apply setIntegral_congr_fun measurableSet_Ioi
    intro x _
    simp only [growthTail]
    ring
  rw [hsplit, integral_majorant_tail hA hs C, integral_negativeWTail_kernel hA s,
    (hasMellin_negativeWTail hA hs).2]

/-! ### Convergence to the right of one half -/

lemma norm_growth_kernel {C A : ℝ}
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2))
    (σ : ℝ) {x : ℝ} (hx : 1 < x) :
    ‖(x : ℂ) ^ (-(σ : ℂ) - 2) * growthTail C A x‖ =
      x ^ (-σ - 2) * (growthTail C A x).re := by
  rw [norm_mul, Complex.norm_cpow_eq_rpow_re_of_pos (zero_lt_one.trans hx)]
  nth_rw 1 [growthTail_ofReal]
  rw [Complex.norm_real, Real.norm_of_nonneg (growthTail_re_nonneg hgrow x)]
  norm_num

lemma density_exp_eq_enorm {C A : ℝ}
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2))
    (σ : ℝ) {x : ℝ} (hx : 1 < x) :
    growthDensity C A x * ENNReal.ofReal (Real.exp (-σ * time x)) =
      ‖(x : ℂ) ^ (-(σ : ℂ) - 2) * growthTail C A x‖ₑ := by
  have hn : 0 ≤ x ^ (-2 : ℝ) * (growthTail C A x).re :=
    mul_nonneg (Real.rpow_nonneg (zero_lt_one.trans hx).le _) (growthTail_re_nonneg hgrow x)
  rw [growthDensity, ← ENNReal.ofReal_mul hn, ← ofReal_norm_eq_enorm,
    norm_growth_kernel hgrow σ hx, time_eq_log hx]
  congr 1
  calc
    _ = (x ^ (-2 : ℝ) * Real.exp (-σ * Real.log x)) * (growthTail C A x).re := by ring
    _ = _ := by rw [ActualCriticalMeasure.real_weight_identity (zero_lt_one.trans hx)]

theorem laplace_mass_eq_norm {C A : ℝ}
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2)) (σ : ℝ) :
    LaplaceConvergenceAbscissa.mass (growthMeasure C A) time σ =
      ∫⁻ x : ℝ in Ioi 1, ‖(x : ℂ) ^ (-(σ : ℂ) - 2) * growthTail C A x‖ₑ := by
  unfold LaplaceConvergenceAbscissa.mass growthMeasure
  have hg : Measurable (fun y : ℝ => ENNReal.ofReal (Real.exp (-σ * time y))) :=
    (Real.measurable_exp.comp (measurable_const.mul measurable_time)).ennreal_ofReal
  rw [lintegral_withDensity_eq_lintegral_mul _ (measurable_growthDensity C A) hg]
  apply lintegral_congr_ae
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
  exact density_exp_eq_enorm hgrow σ hx

theorem laplace_integrable {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2))
    {σ : ℝ} (hσ : 1 < σ) :
    Integrable (fun x => Real.exp (-σ * time x)) (growthMeasure C A) := by
  have hi : IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-(σ : ℂ) - 2) * growthTail C A x) (Ioi 1) := by
    have h1 := integrableOn_majorant_tail hA (s := (σ : ℂ)) (by simpa using hσ) C
    have h2 := integrableOn_negativeWTail_kernel hA (s := (σ : ℂ)) (by simpa using hσ)
    refine (h1.add h2).congr_fun ?_ measurableSet_Ioi
    intro x _
    simp only [Pi.add_apply, growthTail]
    ring
  apply (LaplaceConvergenceAbscissa.integrable_iff_mem (growthMeasure C A) time measurable_time σ).2
  change LaplaceConvergenceAbscissa.mass (growthMeasure C A) time σ < ∞
  rw [laplace_mass_eq_norm hgrow σ]
  exact hasFiniteIntegral_iff_enorm.mp hi.2

theorem convergenceSet_nonempty {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    (LaplaceConvergenceAbscissa.convergenceSet (growthMeasure C A) time).Nonempty := by
  refine ⟨2, ?_⟩
  exact (LaplaceConvergenceAbscissa.integrable_iff_mem (growthMeasure C A) time measurable_time 2).1
    (laplace_integrable hA hgrow (by norm_num))

/-- The analytic candidate for the continuation of the Laplace transform. -/
noncomputable def growthTransform (C A : ℝ) (s : ℂ) : ℂ :=
  majorantTransform C A s +
    (mellin (initialPart ActualCriticalMellin.W A) (-s - 1) -
      CriticalTransformPoles.filledTransform s)

theorem majorantTransform_analyticAt {C A : ℝ} (hA : 0 < A) {s : ℂ} (hs : s ≠ 1 / 2) :
    AnalyticAt ℂ (majorantTransform C A) s := by
  unfold majorantTransform
  have hbase : AnalyticAt ℂ (fun _ : ℂ => (A : ℂ)) s := analyticAt_const
  have hexp : AnalyticAt ℂ (fun z : ℂ => -z - 1 / 2 + 1) s :=
    ((analyticAt_id.neg).sub analyticAt_const).add analyticAt_const
  have hpow : AnalyticAt ℂ (fun z : ℂ => (A : ℂ) ^ (-z - 1 / 2 + 1)) s :=
    hbase.cpow hexp (Complex.ofReal_mem_slitPlane.mpr hA)
  have hden : (-s - 1 / 2 + 1 : ℂ) ≠ 0 := by
    intro h
    apply hs
    linear_combination -h
  exact analyticAt_const.mul (hpow.neg.div hexp hden)

theorem growthTransform_analyticAt_real {C A : ℝ} (hA : 1 ≤ A) {σ : ℝ} (hσ : (1 : ℝ) / 2 < σ) :
    AnalyticAt ℂ (growthTransform C A) (σ : ℂ) := by
  have hne : (σ : ℂ) ≠ 1 / 2 := by
    intro h
    have := congrArg Complex.re h
    simp at this
    linarith
  exact (majorantTransform_analyticAt (lt_of_lt_of_le zero_lt_one hA) hne).add
    (((MellinCompactCorrection.differentiable_W_initialPart A).analyticAt (σ : ℂ)).sub
      (CriticalTransformRealAxis.analyticAt_filledTransform_real hσ))

theorem growthTransform_eq_laplace {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2))
    {s : ℂ} (hs : 1 < s.re) :
    growthTransform C A s =
      LaplaceMomentDerivatives.moment (growthMeasure C A) time 0 s :=
  (moment_eq_majorant_add_initial_sub_filled hA hgrow hs).symm

/-- Landau: the finite abscissa of the growth measure is at most one half. -/
theorem finite_abscissa_le_half {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2))
    (hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet (growthMeasure C A) time)) :
    sInf (LaplaceConvergenceAbscissa.convergenceSet (growthMeasure C A) time) ≤ (1 : ℝ) / 2 := by
  by_contra hle
  have hhalf := lt_of_not_ge hle
  have hne := convergenceSet_nonempty hA hgrow
  have ht : ∀ᵐ x ∂growthMeasure C A, 0 ≤ time x :=
    Eventually.of_forall time_nonneg
  have hL := LaplaceConvergenceAnalytic.analyticOnNhd_above_inf
    measurable_time ht hne hbdd
  obtain ⟨R, hR, hF, heq⟩ := RealAxisAnalyticContinuation.exists_right_disk_agreement
    (F := growthTransform C A) (β := (1 : ℝ) / 2) (B := 1)
    (fun σ hσ => growthTransform_analyticAt_real hA hσ) hL
    (fun σ hσ => growthTransform_eq_laplace hA hgrow (s := (σ : ℂ)) (by simpa using hσ)) hhalf
  exact LandauSingularity.finite_abscissa_singular measurable_time ht hne hbdd hR hF heq

theorem laplace_analyticOnNhd_above_half {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    AnalyticOnNhd ℂ (LaplaceMomentDerivatives.moment (growthMeasure C A) time 0)
      {s : ℂ | (1 : ℝ) / 2 < s.re} := by
  have ht : ∀ᵐ x ∂growthMeasure C A, 0 ≤ time x :=
    Eventually.of_forall time_nonneg
  by_cases hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet (growthMeasure C A) time)
  · apply (LaplaceConvergenceAnalytic.analyticOnNhd_above_inf
      measurable_time ht (convergenceSet_nonempty hA hgrow) hbdd).mono
    intro s hs
    exact (finite_abscissa_le_half hA hgrow hbdd).trans_lt hs
  · exact (LaplaceConvergenceAnalytic.analyticOnNhd_of_not_bddBelow
      measurable_time ht hbdd).mono (subset_univ _)

/-! ### Continuation and the Riemann hypothesis -/

/-- The continuation of the filled transform built from the growth measure. -/
noncomputable def continuation (C A : ℝ) (s : ℂ) : ℂ :=
  majorantTransform C A s + mellin (initialPart ActualCriticalMellin.W A) (-s - 1) -
    LaplaceMomentDerivatives.moment (growthMeasure C A) time 0 s

theorem continuation_analyticOnNhd {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    AnalyticOnNhd ℂ (continuation C A) {s : ℂ | (1 : ℝ) / 2 < s.re} := by
  intro s hs
  have hne : s ≠ 1 / 2 := by
    intro h
    rw [h] at hs
    simp at hs
  exact ((majorantTransform_analyticAt (lt_of_lt_of_le zero_lt_one hA) hne).add
    ((MellinCompactCorrection.differentiable_W_initialPart A).analyticAt s)).sub
    (laplace_analyticOnNhd_above_half hA hgrow s hs)

theorem continuation_eq_filledTransform {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2))
    {s : ℂ} (hs : 1 < s.re) :
    continuation C A s = CriticalTransformPoles.filledTransform s := by
  unfold continuation
  rw [moment_eq_majorant_add_initial_sub_filled hA hgrow hs]
  ring

/-- **One-sided growth criterion.** If `Re W(x) ≤ C x^{3/2}` for all `x > A`
(any real `C`, any `A ≥ 1`), then the Riemann hypothesis holds. The case `C = 0`
is the eventual-sign criterion. The growth premise is the explicit, still
unproved arithmetic hypothesis. -/
theorem RiemannHypothesis_of_growth_after {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    RiemannHypothesis :=
  CriticalTransformContinuationRH.RiemannHypothesis_of_holomorphic_continuation
    (continuation_analyticOnNhd hA hgrow)
    (fun _ hs => continuation_eq_filledTransform hA hgrow hs)

theorem cutoff_of_eventually_growth {C : ℝ}
    (hgrow : ∀ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    ∃ A : ℝ, 1 ≤ A ∧ ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2) := by
  obtain ⟨B, hB⟩ := eventually_atTop.1 hgrow
  refine ⟨max 1 B, le_max_left _ _, ?_⟩
  intro x hx
  exact hB x ((le_max_right 1 B).trans hx.le)

/-- Filter form: an eventual one-sided bound `Re W(x) ≤ C x^{3/2}` implies RH. -/
theorem RiemannHypothesis_of_eventually_growth {C : ℝ}
    (hgrow : ∀ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    RiemannHypothesis := by
  obtain ⟨A, hA, hg⟩ := cutoff_of_eventually_growth hgrow
  exact RiemannHypothesis_of_growth_after hA hg

/-- The eventual-sign criterion is the special case `C = 0`. -/
theorem RiemannHypothesis_of_eventually_nonpos'
    (hsign : ∀ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re ≤ 0) :
    RiemannHypothesis := by
  apply RiemannHypothesis_of_eventually_growth (C := 0)
  filter_upwards [hsign] with x hx
  simpa using hx

/-! ### The mirror criterion: a one-sided lower bound

The same argument with the nonnegative tail `(C x^{3/2} + W x) 1_{x > A}` shows that an
eventual lower bound `-C x^{3/2} ≤ Re W(x)` also implies RH. Its Laplace transform is the
majorant term plus `filledTransform - initial`. -/

/-- The nonnegative tail `(C x^{3/2} + W x) 1_{x > A}` under a lower growth premise. -/
noncomputable def lowerTail (C A : ℝ) (x : ℝ) : ℂ :=
  tailPart (majorant C) A x + tailPart ActualCriticalMellin.W A x

theorem lowerTail_eq (C A x : ℝ) : lowerTail C A x = tailPart (majorant C) A x - negativeWTail A x := by
  simp only [lowerTail, negativeWTail, sub_neg_eq_add]

theorem lowerTail_im (C A x : ℝ) : (lowerTail C A x).im = 0 := by
  by_cases hx : A < x <;> simp [lowerTail, tailPart, majorant, hx, ActualCriticalMellin.W_real]

theorem lowerTail_re_nonneg {C A : ℝ}
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re) (x : ℝ) :
    0 ≤ (lowerTail C A x).re := by
  by_cases hx : A < x
  · have := hlow x hx
    simp only [lowerTail, tailPart, majorant, Set.indicator_of_mem (mem_Ioi.mpr hx),
      Complex.add_re, Complex.ofReal_re]
    linarith
  · simp [lowerTail, tailPart, hx]

theorem lowerTail_ofReal (C A x : ℝ) : lowerTail C A x = ((lowerTail C A x).re : ℂ) := by
  apply Complex.ext
  · rfl
  · simp [lowerTail_im]

theorem measurable_lowerTail (C A : ℝ) : Measurable (lowerTail C A) := by
  have h : lowerTail C A = fun x => tailPart (majorant C) A x - negativeWTail A x := by
    funext x
    exact lowerTail_eq C A x
  rw [h]
  refine Measurable.sub ?_ (measurable_negativeWTail A)
  refine Measurable.indicator ?_ measurableSet_Ioi
  exact Complex.measurable_ofReal.comp (measurable_const.mul (measurable_id.pow_const _))

noncomputable def lowerDensity (C A x : ℝ) : ℝ≥0∞ :=
  ENNReal.ofReal (x ^ (-2 : ℝ) * (lowerTail C A x).re)

theorem measurable_lowerDensity (C A : ℝ) : Measurable (lowerDensity C A) :=
  ((measurable_id.pow measurable_const).mul
    (Complex.measurable_re.comp (measurable_lowerTail C A))).ennreal_ofReal

/-- The positive Landau measure of the lower growth criterion. -/
noncomputable def lowerMeasure (C A : ℝ) : Measure ℝ :=
  (volume.restrict (Ioi 1)).withDensity (lowerDensity C A)

theorem lowerDensity_toReal {C A : ℝ}
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re)
    {x : ℝ} (hx : 0 ≤ x) :
    (lowerDensity C A x).toReal = x ^ (-2 : ℝ) * (lowerTail C A x).re := by
  unfold lowerDensity
  exact ENNReal.toReal_ofReal (mul_nonneg (Real.rpow_nonneg hx _) (lowerTail_re_nonneg hlow x))

theorem lower_density_smul_exp {C A : ℝ}
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re)
    {x : ℝ} (hx : 1 < x) (s : ℂ) :
    (lowerDensity C A x).toReal • Complex.exp (-s * (time x : ℂ)) =
      (x : ℂ) ^ (-s - 2) * lowerTail C A x := by
  have hx0 : 0 < x := lt_trans zero_lt_one hx
  have hn : (x : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hx0.ne'
  have he : Complex.exp (-s * (Real.log x : ℂ)) = (x : ℂ) ^ (-s) := by
    rw [Complex.cpow_def_of_ne_zero hn, ← Complex.ofReal_log hx0.le]
    congr 1
    ring
  rw [lowerDensity_toReal hlow hx0.le, time_eq_log hx, he]
  simp only [Complex.real_smul, Complex.ofReal_mul]
  rw [← lowerTail_ofReal, Complex.ofReal_cpow hx0.le]
  norm_num only [Complex.ofReal_neg, Complex.ofReal_ofNat]
  rw [show (x : ℂ) ^ (-2 : ℂ) * lowerTail C A x * (x : ℂ) ^ (-s) =
      ((x : ℂ) ^ (-2 : ℂ) * (x : ℂ) ^ (-s)) * lowerTail C A x by ring,
    ← Complex.cpow_add _ _ hn]
  congr 2
  ring

theorem lower_moment_eq_integral {C A : ℝ}
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re) (s : ℂ) :
    LaplaceMomentDerivatives.moment (lowerMeasure C A) time 0 s =
      ∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * lowerTail C A x := by
  unfold LaplaceMomentDerivatives.moment LaplaceMomentDerivatives.integrand lowerMeasure
  simp only [pow_zero, one_mul]
  rw [integral_withDensity_eq_integral_toReal_smul (measurable_lowerDensity C A)
    (Filter.Eventually.of_forall (fun x => ENNReal.ofReal_lt_top))]
  apply setIntegral_congr_fun measurableSet_Ioi
  intro x hx
  exact lower_density_smul_exp hlow hx s

/-- Laplace transform of the lower measure on the absolute-convergence half-plane. -/
theorem lower_moment_eq_majorant_add_filled_sub_initial {C A : ℝ} (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re)
    {s : ℂ} (hs : 1 < s.re) :
    LaplaceMomentDerivatives.moment (lowerMeasure C A) time 0 s =
      majorantTransform C A s +
        (CriticalTransformPoles.filledTransform s -
          mellin (initialPart ActualCriticalMellin.W A) (-s - 1)) := by
  rw [lower_moment_eq_integral hlow s]
  have hsplit : (∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * lowerTail C A x) =
      (∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * tailPart (majorant C) A x) -
        ∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * negativeWTail A x := by
    rw [← integral_sub (integrableOn_majorant_tail hA hs C) (integrableOn_negativeWTail_kernel hA hs)]
    apply setIntegral_congr_fun measurableSet_Ioi
    intro x _
    simp only [lowerTail_eq]
    ring
  rw [hsplit, integral_majorant_tail hA hs C, integral_negativeWTail_kernel hA s,
    (hasMellin_negativeWTail hA hs).2]
  ring

lemma norm_lower_kernel {C A : ℝ}
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re)
    (σ : ℝ) {x : ℝ} (hx : 1 < x) :
    ‖(x : ℂ) ^ (-(σ : ℂ) - 2) * lowerTail C A x‖ =
      x ^ (-σ - 2) * (lowerTail C A x).re := by
  rw [norm_mul, Complex.norm_cpow_eq_rpow_re_of_pos (zero_lt_one.trans hx)]
  nth_rw 1 [lowerTail_ofReal]
  rw [Complex.norm_real, Real.norm_of_nonneg (lowerTail_re_nonneg hlow x)]
  norm_num

lemma lower_density_exp_eq_enorm {C A : ℝ}
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re)
    (σ : ℝ) {x : ℝ} (hx : 1 < x) :
    lowerDensity C A x * ENNReal.ofReal (Real.exp (-σ * time x)) =
      ‖(x : ℂ) ^ (-(σ : ℂ) - 2) * lowerTail C A x‖ₑ := by
  have hn : 0 ≤ x ^ (-2 : ℝ) * (lowerTail C A x).re :=
    mul_nonneg (Real.rpow_nonneg (zero_lt_one.trans hx).le _) (lowerTail_re_nonneg hlow x)
  rw [lowerDensity, ← ENNReal.ofReal_mul hn, ← ofReal_norm_eq_enorm,
    norm_lower_kernel hlow σ hx, time_eq_log hx]
  congr 1
  calc
    _ = (x ^ (-2 : ℝ) * Real.exp (-σ * Real.log x)) * (lowerTail C A x).re := by ring
    _ = _ := by rw [ActualCriticalMeasure.real_weight_identity (zero_lt_one.trans hx)]

theorem lower_laplace_mass_eq_norm {C A : ℝ}
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re) (σ : ℝ) :
    LaplaceConvergenceAbscissa.mass (lowerMeasure C A) time σ =
      ∫⁻ x : ℝ in Ioi 1, ‖(x : ℂ) ^ (-(σ : ℂ) - 2) * lowerTail C A x‖ₑ := by
  unfold LaplaceConvergenceAbscissa.mass lowerMeasure
  have hg : Measurable (fun y : ℝ => ENNReal.ofReal (Real.exp (-σ * time y))) :=
    (Real.measurable_exp.comp (measurable_const.mul measurable_time)).ennreal_ofReal
  rw [lintegral_withDensity_eq_lintegral_mul _ (measurable_lowerDensity C A) hg]
  apply lintegral_congr_ae
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
  exact lower_density_exp_eq_enorm hlow σ hx

theorem lower_laplace_integrable {C A : ℝ} (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re)
    {σ : ℝ} (hσ : 1 < σ) :
    Integrable (fun x => Real.exp (-σ * time x)) (lowerMeasure C A) := by
  have hi : IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-(σ : ℂ) - 2) * lowerTail C A x) (Ioi 1) := by
    have h1 := integrableOn_majorant_tail hA (s := (σ : ℂ)) (by simpa using hσ) C
    have h2 := integrableOn_negativeWTail_kernel hA (s := (σ : ℂ)) (by simpa using hσ)
    refine (h1.sub h2).congr_fun ?_ measurableSet_Ioi
    intro x _
    simp only [Pi.sub_apply]
    rw [lowerTail_eq]
    ring
  apply (LaplaceConvergenceAbscissa.integrable_iff_mem (lowerMeasure C A) time measurable_time σ).2
  change LaplaceConvergenceAbscissa.mass (lowerMeasure C A) time σ < ∞
  rw [lower_laplace_mass_eq_norm hlow σ]
  exact hasFiniteIntegral_iff_enorm.mp hi.2

theorem lower_convergenceSet_nonempty {C A : ℝ} (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re) :
    (LaplaceConvergenceAbscissa.convergenceSet (lowerMeasure C A) time).Nonempty := by
  refine ⟨2, ?_⟩
  exact (LaplaceConvergenceAbscissa.integrable_iff_mem (lowerMeasure C A) time measurable_time 2).1
    (lower_laplace_integrable hA hlow (by norm_num))

noncomputable def lowerTransform (C A : ℝ) (s : ℂ) : ℂ :=
  majorantTransform C A s +
    (CriticalTransformPoles.filledTransform s -
      mellin (initialPart ActualCriticalMellin.W A) (-s - 1))

theorem lowerTransform_analyticAt_real {C A : ℝ} (hA : 1 ≤ A) {σ : ℝ} (hσ : (1 : ℝ) / 2 < σ) :
    AnalyticAt ℂ (lowerTransform C A) (σ : ℂ) := by
  have hne : (σ : ℂ) ≠ 1 / 2 := by
    intro h
    have := congrArg Complex.re h
    simp at this
    linarith
  exact (majorantTransform_analyticAt (lt_of_lt_of_le zero_lt_one hA) hne).add
    ((CriticalTransformRealAxis.analyticAt_filledTransform_real hσ).sub
      ((MellinCompactCorrection.differentiable_W_initialPart A).analyticAt (σ : ℂ)))

theorem lowerTransform_eq_laplace {C A : ℝ} (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re)
    {s : ℂ} (hs : 1 < s.re) :
    lowerTransform C A s =
      LaplaceMomentDerivatives.moment (lowerMeasure C A) time 0 s :=
  (lower_moment_eq_majorant_add_filled_sub_initial hA hlow hs).symm

theorem lower_finite_abscissa_le_half {C A : ℝ} (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re)
    (hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet (lowerMeasure C A) time)) :
    sInf (LaplaceConvergenceAbscissa.convergenceSet (lowerMeasure C A) time) ≤ (1 : ℝ) / 2 := by
  by_contra hle
  have hhalf := lt_of_not_ge hle
  have hne := lower_convergenceSet_nonempty hA hlow
  have ht : ∀ᵐ x ∂lowerMeasure C A, 0 ≤ time x :=
    Eventually.of_forall time_nonneg
  have hL := LaplaceConvergenceAnalytic.analyticOnNhd_above_inf
    measurable_time ht hne hbdd
  obtain ⟨R, hR, hF, heq⟩ := RealAxisAnalyticContinuation.exists_right_disk_agreement
    (F := lowerTransform C A) (β := (1 : ℝ) / 2) (B := 1)
    (fun σ hσ => lowerTransform_analyticAt_real hA hσ) hL
    (fun σ hσ => lowerTransform_eq_laplace hA hlow (s := (σ : ℂ)) (by simpa using hσ)) hhalf
  exact LandauSingularity.finite_abscissa_singular measurable_time ht hne hbdd hR hF heq

theorem lower_laplace_analyticOnNhd_above_half {C A : ℝ} (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re) :
    AnalyticOnNhd ℂ (LaplaceMomentDerivatives.moment (lowerMeasure C A) time 0)
      {s : ℂ | (1 : ℝ) / 2 < s.re} := by
  have ht : ∀ᵐ x ∂lowerMeasure C A, 0 ≤ time x :=
    Eventually.of_forall time_nonneg
  by_cases hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet (lowerMeasure C A) time)
  · apply (LaplaceConvergenceAnalytic.analyticOnNhd_above_inf
      measurable_time ht (lower_convergenceSet_nonempty hA hlow) hbdd).mono
    intro s hs
    exact (lower_finite_abscissa_le_half hA hlow hbdd).trans_lt hs
  · exact (LaplaceConvergenceAnalytic.analyticOnNhd_of_not_bddBelow
      measurable_time ht hbdd).mono (subset_univ _)

/-- The continuation of the filled transform built from the lower measure. -/
noncomputable def lowerContinuation (C A : ℝ) (s : ℂ) : ℂ :=
  LaplaceMomentDerivatives.moment (lowerMeasure C A) time 0 s - majorantTransform C A s +
    mellin (initialPart ActualCriticalMellin.W A) (-s - 1)

theorem lowerContinuation_analyticOnNhd {C A : ℝ} (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re) :
    AnalyticOnNhd ℂ (lowerContinuation C A) {s : ℂ | (1 : ℝ) / 2 < s.re} := by
  intro s hs
  have hne : s ≠ 1 / 2 := by
    intro h
    rw [h] at hs
    simp at hs
  exact ((lower_laplace_analyticOnNhd_above_half hA hlow s hs).sub
    (majorantTransform_analyticAt (lt_of_lt_of_le zero_lt_one hA) hne)).add
    ((MellinCompactCorrection.differentiable_W_initialPart A).analyticAt s)

theorem lowerContinuation_eq_filledTransform {C A : ℝ} (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re)
    {s : ℂ} (hs : 1 < s.re) :
    lowerContinuation C A s = CriticalTransformPoles.filledTransform s := by
  unfold lowerContinuation
  rw [lower_moment_eq_majorant_add_filled_sub_initial hA hlow hs]
  ring

/-- **Lower one-sided growth criterion.** If `-C x^{3/2} ≤ Re W(x)` for all `x > A`,
then the Riemann hypothesis holds. This hypothesis is of RH strength as well; see the
unconditional excursion theorem below for why it can never hold. -/
theorem RiemannHypothesis_of_lower_growth_after {C A : ℝ} (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re) :
    RiemannHypothesis :=
  CriticalTransformContinuationRH.RiemannHypothesis_of_holomorphic_continuation
    (lowerContinuation_analyticOnNhd hA hlow)
    (fun _ hs => lowerContinuation_eq_filledTransform hA hlow hs)

theorem RiemannHypothesis_of_eventually_lower_growth {C : ℝ}
    (hlow : ∀ᶠ x : ℝ in atTop, -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re) :
    RiemannHypothesis := by
  obtain ⟨B, hB⟩ := eventually_atTop.1 hlow
  exact RiemannHypothesis_of_lower_growth_after (A := max 1 B) (le_max_left _ _)
    (fun x hx => hB x ((le_max_right 1 B).trans hx.le))

/-- Two-sided form: `|Re W(x)| ≤ C x^{3/2}` eventually implies RH. -/
theorem RiemannHypothesis_of_eventually_abs_growth {C : ℝ}
    (habs : ∀ᶠ x : ℝ in atTop, |(ActualCriticalMellin.W x).re| ≤ C * x ^ ((3 : ℝ) / 2)) :
    RiemannHypothesis := by
  apply RiemannHypothesis_of_eventually_growth (C := C)
  filter_upwards [habs] with x hx
  exact (abs_le.mp hx).2

end BuildingBlocks.ActualCriticalGrowthCriterion

#print axioms BuildingBlocks.ActualCriticalGrowthCriterion.RiemannHypothesis_of_growth_after
#print axioms BuildingBlocks.ActualCriticalGrowthCriterion.RiemannHypothesis_of_lower_growth_after
#print axioms BuildingBlocks.ActualCriticalGrowthCriterion.RiemannHypothesis_of_eventually_abs_growth
