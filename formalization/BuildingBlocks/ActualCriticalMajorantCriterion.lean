import BuildingBlocks.ActualCriticalGrowthCriterion

/-!
# Majorant criterion for the actual critical sum

Abstract form of the one-sided growth criterion. A *majorant datum* on the cutoff `A` is a
real function `g` together with a function `F` analytic on `Re s > 1/2` that agrees with the
tail Mellin integral `∫_A^∞ g(x) x^{-s-2} dx` on `Re s > 1`. Then

  `(∀ x > A, Re W(x) ≤ g(x)) → RiemannHypothesis`.

The proof is the Landau argument of `ActualCriticalGrowthCriterion` with the positive measure
`(g(x) - W(x)) x^{-2} dx` on `x > A`; the only property of the majorant that the argument uses
is the analytic continuation `F` of its tail transform past the line `Re s = 1`.

The power majorant `g(x) = C x^{3/2}` is recovered as the instance `powerData`.
-/

open MeasureTheory Set Filter
open scoped Topology ENNReal

namespace BuildingBlocks.ActualCriticalMajorantCriterion

open ActualCriticalMeasure MellinCompactCorrection ActualCriticalGrowthCriterion

/-- A majorant with an analytic continuation of its tail Mellin transform past `Re s = 1`. -/
structure MajorantData (A : ℝ) where
  /-- The majorant. -/
  g : ℝ → ℝ
  measurable_g : Measurable g
  /-- The continuation of the tail transform. -/
  F : ℂ → ℂ
  analytic_F : AnalyticOnNhd ℂ F {s : ℂ | (1 : ℝ) / 2 < s.re}
  integrable_kernel : ∀ s : ℂ, 1 < s.re →
    IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-s - 2) * (g x : ℂ)) (Ioi A)
  integral_kernel : ∀ s : ℂ, 1 < s.re →
    (∫ x : ℝ in Ioi A, (x : ℂ) ^ (-s - 2) * (g x : ℂ)) = F s

variable {A : ℝ}

/-- The complex-valued majorant. -/
noncomputable def gC (D : MajorantData A) (x : ℝ) : ℂ := (D.g x : ℂ)

/-- The nonnegative tail `(g x - W x) 1_{x > A}`. -/
noncomputable def growthTail (D : MajorantData A) (x : ℝ) : ℂ :=
  tailPart (gC D) A x + negativeWTail A x

theorem growthTail_im (D : MajorantData A) (x : ℝ) : (growthTail D x).im = 0 := by
  by_cases hx : A < x <;> simp [growthTail, tailPart, gC, hx, negativeWTail_im]

theorem growthTail_re_nonneg (D : MajorantData A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x) (x : ℝ) :
    0 ≤ (growthTail D x).re := by
  by_cases hx : A < x
  · have := hgrow x hx
    simp only [growthTail, tailPart, negativeWTail, gC, Set.indicator_of_mem (mem_Ioi.mpr hx),
      Complex.add_re, Complex.neg_re, Complex.ofReal_re]
    linarith
  · simp [growthTail, tailPart, negativeWTail, hx]

theorem growthTail_ofReal (D : MajorantData A) (x : ℝ) :
    growthTail D x = ((growthTail D x).re : ℂ) := by
  apply Complex.ext
  · rfl
  · simp [growthTail_im]

theorem measurable_growthTail (D : MajorantData A) : Measurable (growthTail D) := by
  unfold growthTail tailPart gC
  refine Measurable.add ?_ (measurable_negativeWTail A)
  refine Measurable.indicator ?_ measurableSet_Ioi
  exact Complex.measurable_ofReal.comp D.measurable_g

noncomputable def growthDensity (D : MajorantData A) (x : ℝ) : ℝ≥0∞ :=
  ENNReal.ofReal (x ^ (-2 : ℝ) * (growthTail D x).re)

theorem measurable_growthDensity (D : MajorantData A) : Measurable (growthDensity D) :=
  ((measurable_id.pow measurable_const).mul
    (Complex.measurable_re.comp (measurable_growthTail D))).ennreal_ofReal

noncomputable def growthMeasure (D : MajorantData A) : Measure ℝ :=
  (volume.restrict (Ioi 1)).withDensity (growthDensity D)

theorem growthDensity_toReal (D : MajorantData A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x)
    {x : ℝ} (hx : 0 ≤ x) :
    (growthDensity D x).toReal = x ^ (-2 : ℝ) * (growthTail D x).re := by
  unfold growthDensity
  exact ENNReal.toReal_ofReal (mul_nonneg (Real.rpow_nonneg hx _) (growthTail_re_nonneg D hgrow x))

theorem density_smul_exp (D : MajorantData A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x)
    {x : ℝ} (hx : 1 < x) (s : ℂ) :
    (growthDensity D x).toReal • Complex.exp (-s * (time x : ℂ)) =
      (x : ℂ) ^ (-s - 2) * growthTail D x := by
  have hx0 : 0 < x := lt_trans zero_lt_one hx
  have hn : (x : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hx0.ne'
  have he : Complex.exp (-s * (Real.log x : ℂ)) = (x : ℂ) ^ (-s) := by
    rw [Complex.cpow_def_of_ne_zero hn, ← Complex.ofReal_log hx0.le]
    congr 1
    ring
  rw [growthDensity_toReal D hgrow hx0.le, time_eq_log hx, he]
  simp only [Complex.real_smul, Complex.ofReal_mul]
  rw [← growthTail_ofReal, Complex.ofReal_cpow hx0.le]
  norm_num only [Complex.ofReal_neg, Complex.ofReal_ofNat]
  rw [show (x : ℂ) ^ (-2 : ℂ) * growthTail D x * (x : ℂ) ^ (-s) =
      ((x : ℂ) ^ (-2 : ℂ) * (x : ℂ) ^ (-s)) * growthTail D x by ring,
    ← Complex.cpow_add _ _ hn]
  congr 2
  ring

theorem moment_eq_integral (D : MajorantData A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x) (s : ℂ) :
    LaplaceMomentDerivatives.moment (growthMeasure D) time 0 s =
      ∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * growthTail D x := by
  unfold LaplaceMomentDerivatives.moment LaplaceMomentDerivatives.integrand growthMeasure
  simp only [pow_zero, one_mul]
  rw [integral_withDensity_eq_integral_toReal_smul (measurable_growthDensity D)
    (Filter.Eventually.of_forall (fun x => ENNReal.ofReal_lt_top))]
  apply setIntegral_congr_fun measurableSet_Ioi
  intro x hx
  exact density_smul_exp D hgrow hx s

theorem integral_majorant_tail (D : MajorantData A) (hA : 1 ≤ A) {s : ℂ} (hs : 1 < s.re) :
    (∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * tailPart (gC D) A x) = D.F s := by
  rw [← D.integral_kernel s hs]
  have h1 : (∫ x : ℝ in Ioi A, (x : ℂ) ^ (-s - 2) * (D.g x : ℂ)) =
      ∫ x : ℝ in Ioi A, (x : ℂ) ^ (-s - 2) * tailPart (gC D) A x := by
    apply setIntegral_congr_fun measurableSet_Ioi
    intro x hx
    simp [tailPart, gC, mem_Ioi.mp hx]
  rw [h1]
  apply setIntegral_eq_of_subset_of_forall_sdiff_eq_zero measurableSet_Ioi
    (Ioi_subset_Ioi hA)
  intro x hx
  have hxA : ¬ A < x := by have := hx.2; simp only [mem_Ioi, not_lt] at this; linarith
  simp [tailPart, hxA]

theorem integrableOn_majorant_tail (D : MajorantData A) (hA : 1 ≤ A) {s : ℂ} (hs : 1 < s.re) :
    IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-s - 2) * tailPart (gC D) A x) (Ioi 1) := by
  have hi := D.integrable_kernel s hs
  have heq : (fun x : ℝ => (x : ℂ) ^ (-s - 2) * tailPart (gC D) A x) =
      (Ioi A).indicator (fun x : ℝ => (x : ℂ) ^ (-s - 2) * (D.g x : ℂ)) := by
    funext x
    by_cases hx : A < x
    · simp [tailPart, gC, hx]
    · simp [tailPart, hx]
  rw [heq]
  have hres : IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-s - 2) * (D.g x : ℂ)) (Ioi A)
      (volume.restrict (Ioi 1)) := by
    rw [IntegrableOn, Measure.restrict_restrict measurableSet_Ioi, Ioi_inter_Ioi,
      sup_eq_left.mpr hA]
    exact hi
  exact (integrable_indicator_iff measurableSet_Ioi).mpr hres

theorem moment_eq_F_add_initial_sub_filled (D : MajorantData A) (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x)
    {s : ℂ} (hs : 1 < s.re) :
    LaplaceMomentDerivatives.moment (growthMeasure D) time 0 s =
      D.F s + (mellin (initialPart ActualCriticalMellin.W A) (-s - 1) -
        CriticalTransformPoles.filledTransform s) := by
  rw [moment_eq_integral D hgrow s]
  have hsplit : (∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * growthTail D x) =
      (∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * tailPart (gC D) A x) +
        ∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * negativeWTail A x := by
    rw [← integral_add (integrableOn_majorant_tail D hA hs) (integrableOn_negativeWTail_kernel hA hs)]
    apply setIntegral_congr_fun measurableSet_Ioi
    intro x _
    simp only [growthTail]
    ring
  rw [hsplit, integral_majorant_tail D hA hs, integral_negativeWTail_kernel hA s,
    (hasMellin_negativeWTail hA hs).2]

lemma norm_growth_kernel (D : MajorantData A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x)
    (σ : ℝ) {x : ℝ} (hx : 1 < x) :
    ‖(x : ℂ) ^ (-(σ : ℂ) - 2) * growthTail D x‖ = x ^ (-σ - 2) * (growthTail D x).re := by
  rw [norm_mul, Complex.norm_cpow_eq_rpow_re_of_pos (zero_lt_one.trans hx)]
  nth_rw 1 [growthTail_ofReal]
  rw [Complex.norm_real, Real.norm_of_nonneg (growthTail_re_nonneg D hgrow x)]
  norm_num

lemma density_exp_eq_enorm (D : MajorantData A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x)
    (σ : ℝ) {x : ℝ} (hx : 1 < x) :
    growthDensity D x * ENNReal.ofReal (Real.exp (-σ * time x)) =
      ‖(x : ℂ) ^ (-(σ : ℂ) - 2) * growthTail D x‖ₑ := by
  have hn : 0 ≤ x ^ (-2 : ℝ) * (growthTail D x).re :=
    mul_nonneg (Real.rpow_nonneg (zero_lt_one.trans hx).le _) (growthTail_re_nonneg D hgrow x)
  rw [growthDensity, ← ENNReal.ofReal_mul hn, ← ofReal_norm_eq_enorm,
    norm_growth_kernel D hgrow σ hx, time_eq_log hx]
  congr 1
  calc
    _ = (x ^ (-2 : ℝ) * Real.exp (-σ * Real.log x)) * (growthTail D x).re := by ring
    _ = _ := by rw [ActualCriticalMeasure.real_weight_identity (zero_lt_one.trans hx)]

theorem laplace_mass_eq_norm (D : MajorantData A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x) (σ : ℝ) :
    LaplaceConvergenceAbscissa.mass (growthMeasure D) time σ =
      ∫⁻ x : ℝ in Ioi 1, ‖(x : ℂ) ^ (-(σ : ℂ) - 2) * growthTail D x‖ₑ := by
  unfold LaplaceConvergenceAbscissa.mass growthMeasure
  have hg : Measurable (fun y : ℝ => ENNReal.ofReal (Real.exp (-σ * time y))) :=
    (Real.measurable_exp.comp (measurable_const.mul measurable_time)).ennreal_ofReal
  rw [lintegral_withDensity_eq_lintegral_mul _ (measurable_growthDensity D) hg]
  apply lintegral_congr_ae
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
  exact density_exp_eq_enorm D hgrow σ hx

theorem laplace_integrable (D : MajorantData A) (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x)
    {σ : ℝ} (hσ : 1 < σ) :
    Integrable (fun x => Real.exp (-σ * time x)) (growthMeasure D) := by
  have hi : IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-(σ : ℂ) - 2) * growthTail D x) (Ioi 1) := by
    have h1 := integrableOn_majorant_tail D hA (s := (σ : ℂ)) (by simpa using hσ)
    have h2 := integrableOn_negativeWTail_kernel hA (s := (σ : ℂ)) (by simpa using hσ)
    refine (h1.add h2).congr_fun ?_ measurableSet_Ioi
    intro x _
    simp only [Pi.add_apply, growthTail]
    ring
  apply (LaplaceConvergenceAbscissa.integrable_iff_mem (growthMeasure D) time measurable_time σ).2
  change LaplaceConvergenceAbscissa.mass (growthMeasure D) time σ < ∞
  rw [laplace_mass_eq_norm D hgrow σ]
  exact hasFiniteIntegral_iff_enorm.mp hi.2

theorem convergenceSet_nonempty (D : MajorantData A) (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x) :
    (LaplaceConvergenceAbscissa.convergenceSet (growthMeasure D) time).Nonempty := by
  refine ⟨2, ?_⟩
  exact (LaplaceConvergenceAbscissa.integrable_iff_mem (growthMeasure D) time measurable_time 2).1
    (laplace_integrable D hA hgrow (by norm_num))

noncomputable def growthTransform (D : MajorantData A) (s : ℂ) : ℂ :=
  D.F s + (mellin (initialPart ActualCriticalMellin.W A) (-s - 1) -
    CriticalTransformPoles.filledTransform s)

theorem growthTransform_analyticAt_real (D : MajorantData A) {σ : ℝ} (hσ : (1 : ℝ) / 2 < σ) :
    AnalyticAt ℂ (growthTransform D) (σ : ℂ) :=
  (D.analytic_F (σ : ℂ) (by simpa using hσ)).add
    (((MellinCompactCorrection.differentiable_W_initialPart A).analyticAt (σ : ℂ)).sub
      (CriticalTransformRealAxis.analyticAt_filledTransform_real hσ))

theorem growthTransform_eq_laplace (D : MajorantData A) (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x)
    {s : ℂ} (hs : 1 < s.re) :
    growthTransform D s = LaplaceMomentDerivatives.moment (growthMeasure D) time 0 s :=
  (moment_eq_F_add_initial_sub_filled D hA hgrow hs).symm

theorem finite_abscissa_le_half (D : MajorantData A) (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x)
    (hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet (growthMeasure D) time)) :
    sInf (LaplaceConvergenceAbscissa.convergenceSet (growthMeasure D) time) ≤ (1 : ℝ) / 2 := by
  by_contra hle
  have hhalf := lt_of_not_ge hle
  have hne := convergenceSet_nonempty D hA hgrow
  have ht : ∀ᵐ x ∂growthMeasure D, 0 ≤ time x := Eventually.of_forall time_nonneg
  have hL := LaplaceConvergenceAnalytic.analyticOnNhd_above_inf measurable_time ht hne hbdd
  obtain ⟨R, hR, hF, heq⟩ := RealAxisAnalyticContinuation.exists_right_disk_agreement
    (F := growthTransform D) (β := (1 : ℝ) / 2) (B := 1)
    (fun σ hσ => growthTransform_analyticAt_real D hσ) hL
    (fun σ hσ => growthTransform_eq_laplace D hA hgrow (s := (σ : ℂ)) (by simpa using hσ)) hhalf
  exact LandauSingularity.finite_abscissa_singular measurable_time ht hne hbdd hR hF heq

theorem laplace_analyticOnNhd_above_half (D : MajorantData A) (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x) :
    AnalyticOnNhd ℂ (LaplaceMomentDerivatives.moment (growthMeasure D) time 0)
      {s : ℂ | (1 : ℝ) / 2 < s.re} := by
  have ht : ∀ᵐ x ∂growthMeasure D, 0 ≤ time x := Eventually.of_forall time_nonneg
  by_cases hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet (growthMeasure D) time)
  · apply (LaplaceConvergenceAnalytic.analyticOnNhd_above_inf
      measurable_time ht (convergenceSet_nonempty D hA hgrow) hbdd).mono
    intro s hs
    exact (finite_abscissa_le_half D hA hgrow hbdd).trans_lt hs
  · exact (LaplaceConvergenceAnalytic.analyticOnNhd_of_not_bddBelow
      measurable_time ht hbdd).mono (subset_univ _)

noncomputable def continuation (D : MajorantData A) (s : ℂ) : ℂ :=
  D.F s + mellin (initialPart ActualCriticalMellin.W A) (-s - 1) -
    LaplaceMomentDerivatives.moment (growthMeasure D) time 0 s

theorem continuation_analyticOnNhd (D : MajorantData A) (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x) :
    AnalyticOnNhd ℂ (continuation D) {s : ℂ | (1 : ℝ) / 2 < s.re} := by
  intro s hs
  exact ((D.analytic_F s hs).add
    ((MellinCompactCorrection.differentiable_W_initialPart A).analyticAt s)).sub
    (laplace_analyticOnNhd_above_half D hA hgrow s hs)

theorem continuation_eq_filledTransform (D : MajorantData A) (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x)
    {s : ℂ} (hs : 1 < s.re) :
    continuation D s = CriticalTransformPoles.filledTransform s := by
  unfold continuation
  rw [moment_eq_F_add_initial_sub_filled D hA hgrow hs]
  ring

/-- **Majorant criterion.** If `Re W(x) ≤ g(x)` for all `x > A`, where the tail Mellin
transform of `g` continues analytically to `Re s > 1/2`, then the Riemann hypothesis holds. -/
theorem RiemannHypothesis_of_majorant (D : MajorantData A) (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ D.g x) :
    RiemannHypothesis :=
  CriticalTransformContinuationRH.RiemannHypothesis_of_holomorphic_continuation
    (continuation_analyticOnNhd D hA hgrow)
    (fun _ hs => continuation_eq_filledTransform D hA hgrow hs)

/-! ### The power majorant as an instance -/

/-- The datum for `g(x) = C x^{3/2}`. -/
noncomputable def powerData (C : ℝ) {A : ℝ} (hA : 0 < A) : MajorantData A where
  g := fun x => C * x ^ ((3 : ℝ) / 2)
  measurable_g := measurable_const.mul (measurable_id.pow_const _)
  F := majorantTransform C A
  analytic_F := by
    intro s hs
    have hne : s ≠ 1 / 2 := by
      intro h
      rw [h] at hs
      simp at hs
    exact majorantTransform_analyticAt hA hne
  integrable_kernel := fun s hs => integrableOn_majorant_kernel hA hs C
  integral_kernel := fun s hs => integral_majorant_kernel hA hs C

theorem RiemannHypothesis_of_growth_after' {C A : ℝ} (hA : 1 ≤ A)
    (hgrow : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2)) :
    RiemannHypothesis :=
  RiemannHypothesis_of_majorant (powerData C (lt_of_lt_of_le zero_lt_one hA)) hA hgrow

end BuildingBlocks.ActualCriticalMajorantCriterion
