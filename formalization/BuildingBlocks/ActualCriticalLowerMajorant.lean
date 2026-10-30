import BuildingBlocks.ActualCriticalMajorantCriterion
import BuildingBlocks.ActualCriticalLowerExcursion

/-!
# Lower majorants: the abstract form of the excursion theorem

For a majorant datum `D` (a real function `g` whose tail Mellin transform continues analytically
to `Re s > 1/2` as `F`), the mirror criterion

  `(∀ x > A, -g(x) ≤ Re W(x)) → RiemannHypothesis`

holds by the Landau argument with the positive measure `(g + W) x^{-2} dx`. If moreover
`(σ - 1/2) F(σ)` stays bounded as `σ → 1/2⁺` (the transform has at most a simple pole at `1/2`),
then the premise can never hold: the same contradiction as in `ActualCriticalLowerExcursion`
applies, since the transform of `W` has a triple pole at `1/2` with negative leading
coefficient (its real part tends to `-∞` faster than `1/(σ-1/2)`).

So the exact scale separating the two one-sided questions is the pole order of the majorant's
transform at `s = 1/2`: lower majorants of order `x^{3/2}` (simple pole) are excluded
unconditionally; the upper question at order `x^{3/2} log^2 x` (triple pole) is RH.
-/

open MeasureTheory Set Filter Topology
open scoped ENNReal

namespace BuildingBlocks.ActualCriticalLowerMajorant

open ActualCriticalMeasure MellinCompactCorrection ActualCriticalGrowthCriterion
  ActualCriticalMajorantCriterion ActualCriticalLowerExcursion

variable {A : ℝ}

/-- The nonnegative tail `(g x + W x) 1_{x > A}`. -/
noncomputable def lowerTail (D : MajorantData A) (x : ℝ) : ℂ :=
  tailPart (gC D) A x + tailPart ActualCriticalMellin.W A x

theorem lowerTail_eq (D : MajorantData A) (x : ℝ) :
    lowerTail D x = tailPart (gC D) A x - negativeWTail A x := by
  simp only [lowerTail, negativeWTail, sub_neg_eq_add]

theorem lowerTail_im (D : MajorantData A) (x : ℝ) : (lowerTail D x).im = 0 := by
  by_cases hx : A < x <;> simp [lowerTail, tailPart, gC, hx, ActualCriticalMellin.W_real]

theorem lowerTail_re_nonneg (D : MajorantData A)
    (hlow : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re) (x : ℝ) :
    0 ≤ (lowerTail D x).re := by
  by_cases hx : A < x
  · have := hlow x hx
    simp only [lowerTail, tailPart, gC, Set.indicator_of_mem (mem_Ioi.mpr hx),
      Complex.add_re, Complex.ofReal_re]
    linarith
  · simp [lowerTail, tailPart, hx]

theorem lowerTail_ofReal (D : MajorantData A) (x : ℝ) :
    lowerTail D x = ((lowerTail D x).re : ℂ) := by
  apply Complex.ext
  · rfl
  · simp [lowerTail_im]

theorem measurable_lowerTail (D : MajorantData A) : Measurable (lowerTail D) := by
  have h : lowerTail D = fun x => tailPart (gC D) A x - negativeWTail A x := by
    funext x
    exact lowerTail_eq D x
  rw [h]
  refine Measurable.sub ?_ (measurable_negativeWTail A)
  refine Measurable.indicator ?_ measurableSet_Ioi
  exact Complex.measurable_ofReal.comp D.measurable_g

noncomputable def lowerDensity (D : MajorantData A) (x : ℝ) : ℝ≥0∞ :=
  ENNReal.ofReal (x ^ (-2 : ℝ) * (lowerTail D x).re)

theorem measurable_lowerDensity (D : MajorantData A) : Measurable (lowerDensity D) :=
  ((measurable_id.pow measurable_const).mul
    (Complex.measurable_re.comp (measurable_lowerTail D))).ennreal_ofReal

noncomputable def lowerMeasure (D : MajorantData A) : Measure ℝ :=
  (volume.restrict (Ioi 1)).withDensity (lowerDensity D)

theorem lowerDensity_toReal (D : MajorantData A)
    (hlow : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re)
    {x : ℝ} (hx : 0 ≤ x) :
    (lowerDensity D x).toReal = x ^ (-2 : ℝ) * (lowerTail D x).re := by
  unfold lowerDensity
  exact ENNReal.toReal_ofReal (mul_nonneg (Real.rpow_nonneg hx _) (lowerTail_re_nonneg D hlow x))

theorem lower_density_smul_exp (D : MajorantData A)
    (hlow : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re)
    {x : ℝ} (hx : 1 < x) (s : ℂ) :
    (lowerDensity D x).toReal • Complex.exp (-s * (time x : ℂ)) =
      (x : ℂ) ^ (-s - 2) * lowerTail D x := by
  have hx0 : 0 < x := lt_trans zero_lt_one hx
  have hn : (x : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hx0.ne'
  have he : Complex.exp (-s * (Real.log x : ℂ)) = (x : ℂ) ^ (-s) := by
    rw [Complex.cpow_def_of_ne_zero hn, ← Complex.ofReal_log hx0.le]
    congr 1
    ring
  rw [lowerDensity_toReal D hlow hx0.le, time_eq_log hx, he]
  simp only [Complex.real_smul, Complex.ofReal_mul]
  rw [← lowerTail_ofReal, Complex.ofReal_cpow hx0.le]
  norm_num only [Complex.ofReal_neg, Complex.ofReal_ofNat]
  rw [show (x : ℂ) ^ (-2 : ℂ) * lowerTail D x * (x : ℂ) ^ (-s) =
      ((x : ℂ) ^ (-2 : ℂ) * (x : ℂ) ^ (-s)) * lowerTail D x by ring,
    ← Complex.cpow_add _ _ hn]
  congr 2
  ring

theorem lower_moment_eq_integral (D : MajorantData A)
    (hlow : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re) (s : ℂ) :
    LaplaceMomentDerivatives.moment (lowerMeasure D) time 0 s =
      ∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * lowerTail D x := by
  unfold LaplaceMomentDerivatives.moment LaplaceMomentDerivatives.integrand lowerMeasure
  simp only [pow_zero, one_mul]
  rw [integral_withDensity_eq_integral_toReal_smul (measurable_lowerDensity D)
    (Filter.Eventually.of_forall (fun x => ENNReal.ofReal_lt_top))]
  apply setIntegral_congr_fun measurableSet_Ioi
  intro x hx
  exact lower_density_smul_exp D hlow hx s

theorem lower_moment_eq_F_add_filled_sub_initial (D : MajorantData A) (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re)
    {s : ℂ} (hs : 1 < s.re) :
    LaplaceMomentDerivatives.moment (lowerMeasure D) time 0 s =
      D.F s + (CriticalTransformPoles.filledTransform s -
        mellin (initialPart ActualCriticalMellin.W A) (-s - 1)) := by
  rw [lower_moment_eq_integral D hlow s]
  have hsplit : (∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * lowerTail D x) =
      (∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * tailPart (gC D) A x) -
        ∫ x : ℝ in Ioi 1, (x : ℂ) ^ (-s - 2) * negativeWTail A x := by
    rw [← integral_sub (integrableOn_majorant_tail D hA hs) (integrableOn_negativeWTail_kernel hA hs)]
    apply setIntegral_congr_fun measurableSet_Ioi
    intro x _
    simp only [lowerTail_eq]
    ring
  rw [hsplit, integral_majorant_tail D hA hs, integral_negativeWTail_kernel hA s,
    (hasMellin_negativeWTail hA hs).2]
  ring

lemma norm_lower_kernel (D : MajorantData A)
    (hlow : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re)
    (σ : ℝ) {x : ℝ} (hx : 1 < x) :
    ‖(x : ℂ) ^ (-(σ : ℂ) - 2) * lowerTail D x‖ = x ^ (-σ - 2) * (lowerTail D x).re := by
  rw [norm_mul, Complex.norm_cpow_eq_rpow_re_of_pos (zero_lt_one.trans hx)]
  nth_rw 1 [lowerTail_ofReal]
  rw [Complex.norm_real, Real.norm_of_nonneg (lowerTail_re_nonneg D hlow x)]
  norm_num

lemma lower_density_exp_eq_enorm (D : MajorantData A)
    (hlow : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re)
    (σ : ℝ) {x : ℝ} (hx : 1 < x) :
    lowerDensity D x * ENNReal.ofReal (Real.exp (-σ * time x)) =
      ‖(x : ℂ) ^ (-(σ : ℂ) - 2) * lowerTail D x‖ₑ := by
  have hn : 0 ≤ x ^ (-2 : ℝ) * (lowerTail D x).re :=
    mul_nonneg (Real.rpow_nonneg (zero_lt_one.trans hx).le _) (lowerTail_re_nonneg D hlow x)
  rw [lowerDensity, ← ENNReal.ofReal_mul hn, ← ofReal_norm_eq_enorm,
    norm_lower_kernel D hlow σ hx, time_eq_log hx]
  congr 1
  calc
    _ = (x ^ (-2 : ℝ) * Real.exp (-σ * Real.log x)) * (lowerTail D x).re := by ring
    _ = _ := by rw [ActualCriticalMeasure.real_weight_identity (zero_lt_one.trans hx)]

theorem lower_laplace_mass_eq_norm (D : MajorantData A)
    (hlow : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re) (σ : ℝ) :
    LaplaceConvergenceAbscissa.mass (lowerMeasure D) time σ =
      ∫⁻ x : ℝ in Ioi 1, ‖(x : ℂ) ^ (-(σ : ℂ) - 2) * lowerTail D x‖ₑ := by
  unfold LaplaceConvergenceAbscissa.mass lowerMeasure
  have hg : Measurable (fun y : ℝ => ENNReal.ofReal (Real.exp (-σ * time y))) :=
    (Real.measurable_exp.comp (measurable_const.mul measurable_time)).ennreal_ofReal
  rw [lintegral_withDensity_eq_lintegral_mul _ (measurable_lowerDensity D) hg]
  apply lintegral_congr_ae
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
  exact lower_density_exp_eq_enorm D hlow σ hx

theorem lower_laplace_integrable (D : MajorantData A) (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re)
    {σ : ℝ} (hσ : 1 < σ) :
    Integrable (fun x => Real.exp (-σ * time x)) (lowerMeasure D) := by
  have hi : IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-(σ : ℂ) - 2) * lowerTail D x) (Ioi 1) := by
    have h1 := integrableOn_majorant_tail D hA (s := (σ : ℂ)) (by simpa using hσ)
    have h2 := integrableOn_negativeWTail_kernel hA (s := (σ : ℂ)) (by simpa using hσ)
    refine (h1.sub h2).congr_fun ?_ measurableSet_Ioi
    intro x _
    simp only [Pi.sub_apply, lowerTail_eq]
    ring
  apply (LaplaceConvergenceAbscissa.integrable_iff_mem (lowerMeasure D) time measurable_time σ).2
  change LaplaceConvergenceAbscissa.mass (lowerMeasure D) time σ < ∞
  rw [lower_laplace_mass_eq_norm D hlow σ]
  exact hasFiniteIntegral_iff_enorm.mp hi.2

theorem lower_convergenceSet_nonempty (D : MajorantData A) (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re) :
    (LaplaceConvergenceAbscissa.convergenceSet (lowerMeasure D) time).Nonempty := by
  refine ⟨2, ?_⟩
  exact (LaplaceConvergenceAbscissa.integrable_iff_mem (lowerMeasure D) time measurable_time 2).1
    (lower_laplace_integrable D hA hlow (by norm_num))

noncomputable def lowerTransform (D : MajorantData A) (s : ℂ) : ℂ :=
  D.F s + (CriticalTransformPoles.filledTransform s -
    mellin (initialPart ActualCriticalMellin.W A) (-s - 1))

theorem lowerTransform_analyticAt_real (D : MajorantData A) {σ : ℝ} (hσ : (1 : ℝ) / 2 < σ) :
    AnalyticAt ℂ (lowerTransform D) (σ : ℂ) :=
  (D.analytic_F (σ : ℂ) (by simpa using hσ)).add
    ((CriticalTransformRealAxis.analyticAt_filledTransform_real hσ).sub
      ((MellinCompactCorrection.differentiable_W_initialPart A).analyticAt (σ : ℂ)))

theorem lowerTransform_eq_laplace (D : MajorantData A) (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re)
    {s : ℂ} (hs : 1 < s.re) :
    lowerTransform D s = LaplaceMomentDerivatives.moment (lowerMeasure D) time 0 s :=
  (lower_moment_eq_F_add_filled_sub_initial D hA hlow hs).symm

theorem lower_finite_abscissa_le_half (D : MajorantData A) (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re)
    (hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet (lowerMeasure D) time)) :
    sInf (LaplaceConvergenceAbscissa.convergenceSet (lowerMeasure D) time) ≤ (1 : ℝ) / 2 := by
  by_contra hle
  have hhalf := lt_of_not_ge hle
  have hne := lower_convergenceSet_nonempty D hA hlow
  have ht : ∀ᵐ x ∂lowerMeasure D, 0 ≤ time x := Eventually.of_forall time_nonneg
  have hL := LaplaceConvergenceAnalytic.analyticOnNhd_above_inf measurable_time ht hne hbdd
  obtain ⟨R, hR, hF, heq⟩ := RealAxisAnalyticContinuation.exists_right_disk_agreement
    (F := lowerTransform D) (β := (1 : ℝ) / 2) (B := 1)
    (fun σ hσ => lowerTransform_analyticAt_real D hσ) hL
    (fun σ hσ => lowerTransform_eq_laplace D hA hlow (s := (σ : ℂ)) (by simpa using hσ)) hhalf
  exact LandauSingularity.finite_abscissa_singular measurable_time ht hne hbdd hR hF heq

theorem lower_laplace_analyticOnNhd_above_half (D : MajorantData A) (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re) :
    AnalyticOnNhd ℂ (LaplaceMomentDerivatives.moment (lowerMeasure D) time 0)
      {s : ℂ | (1 : ℝ) / 2 < s.re} := by
  have ht : ∀ᵐ x ∂lowerMeasure D, 0 ≤ time x := Eventually.of_forall time_nonneg
  by_cases hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet (lowerMeasure D) time)
  · apply (LaplaceConvergenceAnalytic.analyticOnNhd_above_inf
      measurable_time ht (lower_convergenceSet_nonempty D hA hlow) hbdd).mono
    intro s hs
    exact (lower_finite_abscissa_le_half D hA hlow hbdd).trans_lt hs
  · exact (LaplaceConvergenceAnalytic.analyticOnNhd_of_not_bddBelow
      measurable_time ht hbdd).mono (subset_univ _)

noncomputable def lowerContinuation (D : MajorantData A) (s : ℂ) : ℂ :=
  LaplaceMomentDerivatives.moment (lowerMeasure D) time 0 s - D.F s +
    mellin (initialPart ActualCriticalMellin.W A) (-s - 1)

theorem lowerContinuation_analyticOnNhd (D : MajorantData A) (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re) :
    AnalyticOnNhd ℂ (lowerContinuation D) {s : ℂ | (1 : ℝ) / 2 < s.re} := by
  intro s hs
  exact ((lower_laplace_analyticOnNhd_above_half D hA hlow s hs).sub (D.analytic_F s hs)).add
    ((MellinCompactCorrection.differentiable_W_initialPart A).analyticAt s)

theorem lowerContinuation_eq_filledTransform (D : MajorantData A) (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re)
    {s : ℂ} (hs : 1 < s.re) :
    lowerContinuation D s = CriticalTransformPoles.filledTransform s := by
  unfold lowerContinuation
  rw [lower_moment_eq_F_add_filled_sub_initial D hA hlow hs]
  ring

/-- **Abstract lower criterion.** `-g(x) ≤ Re W(x)` for all `x > A` implies RH, for any
majorant datum `g`. -/
theorem RiemannHypothesis_of_lower_majorant (D : MajorantData A) (hA : 1 ≤ A)
    (hlow : ∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re) :
    RiemannHypothesis :=
  CriticalTransformContinuationRH.RiemannHypothesis_of_holomorphic_continuation
    (lowerContinuation_analyticOnNhd D hA hlow)
    (fun _ hs => lowerContinuation_eq_filledTransform D hA hlow hs)

/-! ### Unconditional exclusion when the transform has at most a simple pole at `1/2` -/

theorem lower_moment_re_nonneg (D : MajorantData A) (σ : ℝ) :
    0 ≤ (LaplaceMomentDerivatives.moment (lowerMeasure D) time 0 (σ : ℂ)).re := by
  unfold LaplaceMomentDerivatives.moment LaplaceMomentDerivatives.integrand
  simp only [pow_zero, one_mul]
  have hfun : (fun x : ℝ => Complex.exp (-(σ : ℂ) * (time x : ℂ))) =
      fun x : ℝ => ((Real.exp (-σ * time x) : ℝ) : ℂ) := by
    funext x
    push_cast
    rfl
  have key : (∫ x, ((Real.exp (-σ * time x) : ℝ) : ℂ) ∂(lowerMeasure D)) =
      ((∫ x, Real.exp (-σ * time x) ∂(lowerMeasure D) : ℝ) : ℂ) := integral_ofReal
  rw [hfun, key, Complex.ofReal_re]
  exact integral_nonneg (fun x => (Real.exp_pos _).le)

/-- **Abstract unconditional exclusion.** If `(σ - 1/2) F(σ)` is bounded as `σ → 1/2⁺`, the lower
bound `-g(x) ≤ Re W(x)` fails for some `x > A`. -/
theorem not_eventually_lower_majorant (D : MajorantData A) (hA : 1 ≤ A) {K : ℝ}
    (hK : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), ‖((σ - 1 / 2 : ℝ) : ℂ) * D.F (σ : ℂ)‖ ≤ K) :
    ¬ (∀ x : ℝ, A < x → -(D.g x) ≤ (ActualCriticalMellin.W x).re) := by
  intro hlow
  have hJ := lowerContinuation_analyticOnNhd D hA hlow
  have heq : ∀ s : ℂ, 1 < s.re →
      lowerContinuation D s = CriticalTransformPoles.filledTransform s :=
    fun s hs => lowerContinuation_eq_filledTransform D hA hlow hs
  have hcl := CriticalTransformContinuationRH.cleared_zero_on_rightDomain hJ heq
  have hreal : ∀ σ : ℝ, 1 / 2 < σ → σ < 1 →
      lowerContinuation D (σ : ℂ) = CriticalTransformPoles.filledTransform (σ : ℂ) := by
    intro σ h1 h2
    have hσ1 : (σ : ℂ) ≠ 1 := by
      intro h
      have := congrArg Complex.re h
      simp at this
      linarith
    have hz : riemannZeta (σ : ℂ) ≠ 0 :=
      RiemannZetaRealAxisUnconditional.riemannZeta_ofReal_ne_zero_unconditional h1 h2
    have hdom : (σ : ℂ) ∈ rightDomain := ⟨by simpa using h1, hσ1⟩
    have h0 := hcl (σ : ℂ) hdom
    rw [CriticalTransformContinuationRH.cleared_eq hσ1 hz] at h0
    exact sub_eq_zero.mp ((mul_eq_zero.mp h0).resolve_left (pow_ne_zero 2 hz))
  set G := LogDerivativePole.centeredZetaLogDerivative with hG
  set I : ℂ → ℂ := fun s => mellin (initialPart ActualCriticalMellin.W A) (-s - 1) with hI
  have hhalf : ((((1 : ℝ) / 2 : ℝ)) : ℂ) = (1 / 2 : ℂ) := by push_cast; ring
  have hζ : AnalyticAt ℂ riemannZeta ((((1 : ℝ) / 2 : ℝ)) : ℂ) :=
    zeta_analytic_off_pole _ (by rw [Set.mem_compl_singleton_iff, hhalf]; norm_num)
  have hGcont : ContinuousAt G ((((1 : ℝ) / 2 : ℝ)) : ℂ) := by
    have hd : ContinuousAt (deriv riemannZeta) ((((1 : ℝ) / 2 : ℝ)) : ℂ) := hζ.deriv.continuousAt
    have hq : ContinuousAt (fun s => deriv riemannZeta s / riemannZeta s) ((((1 : ℝ) / 2 : ℝ)) : ℂ) :=
      hd.div hζ.continuousAt riemannZeta_half_ne_zero
    have hr : ContinuousAt (fun s : ℂ => s / (s - 1)) ((((1 : ℝ) / 2 : ℝ)) : ℂ) := by
      apply continuousAt_id.div (continuousAt_id.sub continuousAt_const)
      rw [hhalf]; norm_num
    have hGe : G = fun s => -(deriv riemannZeta s / riemannZeta s) - s / (s - 1) := by
      funext s
      simp [hG, LogDerivativePole.centeredZetaLogDerivative, logDeriv_apply]
    rw [hGe]
    exact hq.neg.sub hr
  have hIcont : ContinuousAt I ((((1 : ℝ) / 2 : ℝ)) : ℂ) :=
    (MellinCompactCorrection.differentiable_W_initialPart A).continuous.continuousAt
  have hcast : Tendsto (fun σ : ℝ => (σ : ℂ)) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 ((((1 : ℝ) / 2 : ℝ)) : ℂ)) :=
    Complex.continuous_ofReal.continuousAt.tendsto.mono_left nhdsWithin_le_nhds
  set B : ℝ := ‖G ((((1 : ℝ) / 2 : ℝ)) : ℂ)‖ + 1 with hB
  set Dc : ℝ := ‖I ((((1 : ℝ) / 2 : ℝ)) : ℂ)‖ + 1 with hDc
  have hGb : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), ‖G (σ : ℂ)‖ ≤ B := by
    have ht := (hGcont.tendsto.comp hcast).norm
    exact (ht.eventually (gt_mem_nhds (lt_add_one _))).mono (fun σ h => h.le)
  have hIb : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), ‖I (σ : ℂ)‖ ≤ Dc := by
    have ht := (hIcont.tendsto.comp hcast).norm
    exact (ht.eventually (gt_mem_nhds (lt_add_one _))).mono (fun σ h => h.le)
  have hmre : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), 1 ≤ (m σ).re := by
    have ht : Tendsto (fun σ => (m σ).re) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 ((4 / 3 : ℂ).re)) :=
      (Complex.continuous_re.tendsto _).comp tendsto_m
    have h43 : (4 / 3 : ℂ).re = 4 / 3 := by norm_num
    rw [h43] at ht
    exact (ht.eventually (lt_mem_nhds (by norm_num : (1 : ℝ) < 4 / 3))).mono (fun σ h => h.le)
  have hmnorm : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), ‖m σ‖ ≤ 2 := by
    have ht := tendsto_m.norm
    have h43 : ‖(4 / 3 : ℂ)‖ = 4 / 3 := by
      rw [show (4 / 3 : ℂ) = (((4 / 3 : ℝ)) : ℂ) by push_cast; ring, Complex.norm_real]
      norm_num
    rw [h43] at ht
    exact (ht.eventually (gt_mem_nhds (by norm_num : (4 / 3 : ℝ) < 2))).mono (fun σ h => h.le)
  set K' : ℝ := 2 * B ^ 2 + |K| + Dc + 1 with hK'
  have hH := eventually_H_re_ge K'
  have hIoo : ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2), σ ∈ Ioo ((1 : ℝ) / 2) 1 :=
    Ioo_mem_nhdsGT (by norm_num)
  obtain ⟨σ, ⟨⟨⟨⟨⟨⟨hσI, hGσ⟩, hIσ⟩, hmσ⟩, hmnσ⟩, hHσ⟩, hFσ⟩⟩ :=
    ((((((hIoo.and hGb).and hIb).and hmre).and hmnorm).and hH).and hK).exists
  have h1 : 1 / 2 < σ := hσI.1
  have h2 : σ < 1 := hσI.2
  have hσ1 : (σ : ℂ) ≠ 1 := by
    intro h
    have := congrArg Complex.re h
    simp at this
    linarith
  have hd0 : 0 < σ - 1 / 2 := by linarith
  have hd1 : σ - 1 / 2 ≤ 1 := by linarith
  have hmom : LaplaceMomentDerivatives.moment (lowerMeasure D) time 0 (σ : ℂ) =
      CriticalTransformPoles.filledTransform (σ : ℂ) + D.F (σ : ℂ) - I (σ : ℂ) := by
    have := hreal σ h1 h2
    unfold lowerContinuation at this
    simp only [hI]
    linear_combination this
  have hfill : CriticalTransformPoles.filledTransform (σ : ℂ) =
      ShiftedZetaMultiplier.M (σ : ℂ) * (G (σ : ℂ) ^ 2 - SamePrimeDirichlet.H (σ : ℂ)) := by
    rw [CriticalTransformPoles.filledTransform_eq_of_ne hσ1]
    rfl
  have hnn : 0 ≤ (((σ - 1 / 2 : ℝ) : ℂ) *
      LaplaceMomentDerivatives.moment (lowerMeasure D) time 0 (σ : ℂ)).re := by
    rw [Complex.re_ofReal_mul]
    exact mul_nonneg hd0.le (lower_moment_re_nonneg D σ)
  rw [hmom, hfill] at hnn
  have hexpand : ((σ - 1 / 2 : ℝ) : ℂ) *
      (ShiftedZetaMultiplier.M (σ : ℂ) * (G (σ : ℂ) ^ 2 - SamePrimeDirichlet.H (σ : ℂ)) +
        D.F (σ : ℂ) - I (σ : ℂ)) =
      m σ * G (σ : ℂ) ^ 2 - m σ * SamePrimeDirichlet.H (σ : ℂ) +
        ((σ - 1 / 2 : ℝ) : ℂ) * D.F (σ : ℂ) -
        ((σ - 1 / 2 : ℝ) : ℂ) * I (σ : ℂ) := by
    unfold m
    ring
  rw [hexpand] at hnn
  simp only [Complex.sub_re, Complex.add_re] at hnn
  have hA1 : (m σ * G (σ : ℂ) ^ 2).re ≤ 2 * B ^ 2 := by
    calc (m σ * G (σ : ℂ) ^ 2).re ≤ ‖m σ * G (σ : ℂ) ^ 2‖ := Complex.re_le_norm _
      _ = ‖m σ‖ * ‖G (σ : ℂ)‖ ^ 2 := by rw [norm_mul, norm_pow]
      _ ≤ 2 * B ^ 2 := by
          apply mul_le_mul hmnσ (pow_le_pow_left₀ (norm_nonneg _) hGσ 2) (by positivity) (by norm_num)
  have hA2 : K' ≤ (m σ * SamePrimeDirichlet.H (σ : ℂ)).re := by
    rw [Complex.mul_re, H_im σ h1, mul_zero, sub_zero]
    have hK0 : 0 ≤ K' := by positivity
    have hHnn : 0 ≤ (SamePrimeDirichlet.H (σ : ℂ)).re := le_trans hK0 hHσ
    calc K' ≤ (SamePrimeDirichlet.H (σ : ℂ)).re := hHσ
      _ = 1 * (SamePrimeDirichlet.H (σ : ℂ)).re := (one_mul _).symm
      _ ≤ (m σ).re * (SamePrimeDirichlet.H (σ : ℂ)).re :=
          mul_le_mul_of_nonneg_right hmσ hHnn
  have hA3 : (((σ - 1 / 2 : ℝ) : ℂ) * D.F (σ : ℂ)).re ≤ |K| :=
    le_trans (Complex.re_le_norm _) (le_trans hFσ (le_abs_self K))
  have hA4 : -Dc ≤ (((σ - 1 / 2 : ℝ) : ℂ) * I (σ : ℂ)).re := by
    rw [Complex.re_ofReal_mul]
    have h := Complex.abs_re_le_norm (I (σ : ℂ))
    have h' : -‖I (σ : ℂ)‖ ≤ (I (σ : ℂ)).re := (abs_le.mp h).1
    have hD0 : 0 ≤ Dc := by rw [hDc]; positivity
    have hn0 : 0 ≤ ‖I (σ : ℂ)‖ := norm_nonneg _
    calc -Dc ≤ -((σ - 1 / 2) * Dc) := by nlinarith [hd0, hd1, hD0]
      _ ≤ -((σ - 1 / 2) * ‖I (σ : ℂ)‖) := by nlinarith [hd0, hIσ, hn0]
      _ = (σ - 1 / 2) * (-‖I (σ : ℂ)‖) := by ring
      _ ≤ (σ - 1 / 2) * (I (σ : ℂ)).re := mul_le_mul_of_nonneg_left h' hd0.le
  linarith

/-- The power majorant satisfies the simple-pole bound, recovering the concrete theorem. -/
theorem power_prefactor_bounded (C : ℝ) {A : ℝ} (hA : 1 ≤ A) :
    ∀ᶠ σ : ℝ in 𝓝[>] ((1 : ℝ) / 2),
      ‖((σ - 1 / 2 : ℝ) : ℂ) * (powerData C (lt_of_lt_of_le zero_lt_one hA)).F (σ : ℂ)‖ ≤ |C| := by
  filter_upwards [self_mem_nhdsWithin] with σ hσ
  have h1 : 1 / 2 < σ := hσ
  show ‖((σ - 1 / 2 : ℝ) : ℂ) * majorantTransform C A (σ : ℂ)‖ ≤ |C|
  rw [majorant_prefactor hA h1, norm_mul, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs,
    Real.norm_eq_abs]
  have h0 : 0 ≤ A ^ (1 / 2 - σ) := Real.rpow_nonneg (by linarith) _
  have hle : A ^ (1 / 2 - σ) ≤ 1 := Real.rpow_le_one_of_one_le_of_nonpos hA (by linarith)
  rw [abs_of_nonneg h0]
  calc |C| * A ^ (1 / 2 - σ) ≤ |C| * 1 := mul_le_mul_of_nonneg_left hle (abs_nonneg C)
    _ = |C| := mul_one _

theorem not_eventually_lower_growth' (C A : ℝ) (hA : 1 ≤ A) :
    ¬ (∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2)) ≤ (ActualCriticalMellin.W x).re) :=
  not_eventually_lower_majorant (powerData C (lt_of_lt_of_le zero_lt_one hA)) hA
    (power_prefactor_bounded C hA)

end BuildingBlocks.ActualCriticalLowerMajorant

#print axioms BuildingBlocks.ActualCriticalLowerMajorant.RiemannHypothesis_of_lower_majorant
#print axioms BuildingBlocks.ActualCriticalLowerMajorant.not_eventually_lower_majorant
#print axioms BuildingBlocks.ActualCriticalLowerMajorant.not_eventually_lower_growth'
