import BuildingBlocks.ActualFullCenteredMellin
import Mathlib.Analysis.MellinInversion
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals

/-! Actual full-numerator Mellin--Perron inversion.

The literal actual arithmetic row is reconstructed for every c > 2 and x > 0.
Continuity at all real cutoff births and vertical absolute convergence are
proved internally. This supplies identities and convergence, not the
complete contour upper bound or the eventual RH sign. -/

open MeasureTheory Set Filter
open scoped Topology

namespace BuildingBlocks.ActualFullCenteredMellinVertical

noncomputable def absMass (f : ℕ → ℂ) (σ : ℝ) : ℝ :=
  ∑' n : ℕ, ‖LSeries.term f (σ : ℂ) n‖

theorem absMass_nonneg (f : ℕ → ℂ) (σ : ℝ) : 0 ≤ absMass f σ :=
  tsum_nonneg (fun _ => norm_nonneg _)

theorem norm_LSeries_le_absMass {f : ℕ → ℂ} {s : ℂ}
    (hf : LSeriesSummable f s) : ‖LSeries f s‖ ≤ absMass f s.re := by
  calc
    ‖LSeries f s‖ ≤ ∑' n : ℕ, ‖LSeries.term f s n‖ :=
      norm_tsum_le_tsum_norm hf.norm
    _ = absMass f s.re := by
      apply tsum_congr
      intro n
      simp only [LSeries.norm_term_eq, Complex.ofReal_re]

noncomputable def mangoldt : ℕ → ℂ :=
  fun n => (ArithmeticFunction.vonMangoldt n : ℂ)

theorem norm_negative_logDeriv_le {s : ℂ} (hs : 1 < s.re) :
    ‖-logDeriv riemannZeta s‖ ≤ absMass mangoldt s.re := by
  have he : -logDeriv riemannZeta s = LSeries mangoldt s := by
    rw [logDeriv_apply]
    simpa only [mangoldt, neg_div] using
      (ArithmeticFunction.LSeries_vonMangoldt_eq_deriv_riemannZeta_div hs).symm
  rw [he]
  exact norm_LSeries_le_absMass (ArithmeticFunction.LSeriesSummable_vonMangoldt hs)

theorem norm_zeta_le {s : ℂ} (hs : 1 < s.re) :
    ‖riemannZeta s‖ ≤ absMass (1 : ℕ → ℂ) s.re := by
  rw [← LSeries_one_eq_riemannZeta hs]
  exact norm_LSeries_le_absMass (LSeriesSummable_one_iff.mpr hs)

noncomputable def coreAllowance (σ : ℝ) : ℝ :=
  absMass mangoldt σ + 1 + 1 / (σ - 1)

noncomputable def verticalAllowance (σ : ℝ) : ℝ :=
  absMass (1 : ℕ → ℂ) (σ + 1 / 2) * coreAllowance σ ^ 2

noncomputable def fullFactor (s : ℂ) : ℂ :=
  riemannZeta (s + 1 / 2) * LogDerivativePole.centeredZetaLogDerivative s ^ 2 /
    (s * (s + 1))

theorem norm_centered_le {s : ℂ} (hs : 1 < s.re) :
    ‖LogDerivativePole.centeredZetaLogDerivative s‖ ≤ coreAllowance s.re := by
  have hd : 0 < s.re - 1 := sub_pos.mpr hs
  have hs1 : s ≠ 1 := by
    intro he
    simp [he] at hs
  have hre : s.re - 1 ≤ ‖s - 1‖ := by
    simpa only [Complex.sub_re, Complex.one_re] using Complex.re_le_norm (s - 1)
  have hinv : 1 / ‖s - 1‖ ≤ 1 / (s.re - 1) :=
    one_div_le_one_div_of_le hd hre
  have hsplit : s / (s - 1) = 1 + 1 / (s - 1) := by
    field_simp [sub_ne_zero.mpr hs1]
    ring
  have hτ : ‖s / (s - 1)‖ ≤ 1 + 1 / (s.re - 1) := by
    rw [hsplit]
    calc
      ‖(1 : ℂ) + 1 / (s - 1)‖ ≤ ‖(1 : ℂ)‖ + ‖1 / (s - 1)‖ := norm_add_le _ _
      _ ≤ 1 + 1 / (s.re - 1) := by
        simpa only [norm_one, norm_div] using add_le_add_left hinv 1
  unfold LogDerivativePole.centeredZetaLogDerivative coreAllowance
  exact (norm_sub_le _ _).trans (by
    have hp := norm_negative_logDeriv_le hs
    linarith)

theorem norm_denominator_ge {s : ℂ} (hs : 1 < s.re) :
    1 + s.im ^ 2 ≤ ‖s * (s + 1)‖ := by
  have ha : 1 + s.im ^ 2 ≤ ‖s‖ ^ 2 := by
    rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]
    nlinarith
  have hb : 1 + s.im ^ 2 ≤ ‖s + 1‖ ^ 2 := by
    rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]
    simp only [Complex.add_re, Complex.add_im, Complex.one_re, Complex.one_im, add_zero]
    nlinarith
  have hm := mul_le_mul ha hb (by positivity : 0 ≤ 1 + s.im ^ 2)
    (by positivity : 0 ≤ ‖s‖ ^ 2)
  rw [norm_mul]
  apply (sq_le_sq₀ (by positivity) (by positivity)).mp
  nlinarith [hm]

theorem norm_fullFactor_le {s : ℂ} (hs : 1 < s.re) :
    ‖fullFactor s‖ ≤ verticalAllowance s.re / (1 + s.im ^ 2) := by
  have hsζ : 1 < (s + 1 / 2).re := by
    simp only [Complex.add_re, Complex.div_ofNat_re, Complex.one_re]
    linarith
  have hz := norm_zeta_le hsζ
  have hh := norm_centered_le hs
  have hmass := absMass_nonneg (1 : ℕ → ℂ) (s.re + 1 / 2)
  have hcore : 0 ≤ coreAllowance s.re := (norm_nonneg _).trans hh
  have hnum : ‖riemannZeta (s + 1 / 2)‖ *
      ‖LogDerivativePole.centeredZetaLogDerivative s‖ ^ 2 ≤ verticalAllowance s.re := by
    unfold verticalAllowance
    simp only [Complex.add_re, Complex.div_ofNat_re, Complex.one_re] at hz
    gcongr
  have hden := norm_denominator_ge hs
  have hq : 0 < 1 + s.im ^ 2 := by positivity
  have hn : 0 ≤ verticalAllowance s.re := by
    unfold verticalAllowance
    positivity
  unfold fullFactor
  rw [norm_div, norm_mul, norm_pow]
  calc
    _ ≤ verticalAllowance s.re / ‖s * (s + 1)‖ :=
      div_le_div_of_nonneg_right hnum (norm_nonneg _)
    _ ≤ verticalAllowance s.re / (1 + s.im ^ 2) :=
      div_le_div_of_nonneg_left hn hq hden

theorem analyticAt_fullFactor {s : ℂ} (hs : 1 < s.re) : AnalyticAt ℂ fullFactor s := by
  have hs1 : s ≠ 1 := by intro he; simp [he] at hs
  have hz := zeta_analytic_off_pole s hs1
  have hlog := LogDerivativePole.analyticAt_logDeriv hz
    (riemannZeta_ne_zero_of_one_lt_re hs)
  have hcenter : AnalyticAt ℂ LogDerivativePole.centeredZetaLogDerivative s := by
    exact hlog.neg.sub (analyticAt_id.div (analyticAt_id.sub analyticAt_const)
      (sub_ne_zero.mpr hs1))
  have hmult := ShiftedZetaMultiplier.analyticAt_M (s := s) (by
    change (1 : ℝ) / 2 < s.re
    linarith)
  have heq : fullFactor = (fun z : ℂ => ShiftedZetaMultiplier.M z *
      LogDerivativePole.centeredZetaLogDerivative z ^ 2) := by
    funext z
    simp only [fullFactor, ShiftedZetaMultiplier.M, div_mul_eq_mul_div]
  rw [heq]
  exact hmult.mul (hcenter.pow 2)

theorem continuous_fullFactor_vertical {σ : ℝ} (hσ : 1 < σ) :
    Continuous (fun t : ℝ => fullFactor ((σ : ℂ) + t * Complex.I)) := by
  apply continuous_iff_continuousAt.mpr
  intro t
  have hs : 1 < ((σ : ℂ) + t * Complex.I).re := by simpa using hσ
  have hmap : ContinuousAt (fun u : ℝ => (σ : ℂ) + (u : ℂ) * Complex.I) t := by
    fun_prop
  exact ContinuousAt.comp (f := fun u : ℝ => (σ : ℂ) + (u : ℂ) * Complex.I)
    (analyticAt_fullFactor hs).continuousAt hmap

theorem integrable_fullFactor_vertical {σ : ℝ} (hσ : 1 < σ) :
    Integrable (fun t : ℝ => fullFactor ((σ : ℂ) + t * Complex.I)) := by
  apply (integrable_inv_one_add_sq.const_mul (verticalAllowance σ)).mono'
    (continuous_fullFactor_vertical hσ).aestronglyMeasurable
  filter_upwards with t
  have hs : 1 < ((σ : ℂ) + t * Complex.I).re := by simpa using hσ
  simpa only [Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.I_re,
    Complex.I_im, Complex.ofReal_im, mul_zero, zero_mul, sub_zero, add_zero,
    Complex.add_im, Complex.mul_im, mul_one, zero_add, div_eq_mul_inv] using
      norm_fullFactor_le hs

theorem mellin_fullNumerator_vertical_eq (c t : ℝ) (hc : 2 < c) :
    mellin ActualFullCenteredMellin.fullNumerator ((-c : ℂ) + t * Complex.I) =
      fullFactor ((c - 1 : ℂ) - t * Complex.I) := by
  have hs : 1 < ((c - 1 : ℂ) - t * Complex.I).re := by
    simp
    linarith
  have he := (ActualFullCenteredMellin.hasMellin_fullNumerator hs).2
  have harg : -((c - 1 : ℂ) - t * Complex.I) - 1 = (-c : ℂ) + t * Complex.I := by ring
  simpa only [harg, fullFactor] using he

theorem verticalIntegrable_fullNumerator (c : ℝ) (hc : 2 < c) :
    Complex.VerticalIntegrable (mellin ActualFullCenteredMellin.fullNumerator) (-c) := by
  have hσ : 1 < c - 1 := by linarith
  have hi := (integrable_fullFactor_vertical hσ).comp_neg
  unfold Complex.VerticalIntegrable
  convert hi using 1
  ext t
  simp only [Complex.ofReal_neg, Complex.ofReal_sub, Complex.ofReal_one]
  rw [mellin_fullNumerator_vertical_eq c t hc]
  congr 1
  ring

end BuildingBlocks.ActualFullCenteredMellinVertical

open scoped BigOperators
open MeasureTheory Set Filter

namespace BuildingBlocks.ActualFullCenteredMellinInversion

private theorem cutoff_eq_fixed_sum
    (g : ℕ → ℝ → ℂ)
    (hz : ∀ (n : ℕ) (x : ℝ), x ≤ (n : ℝ) + 1 → g n x = 0)
    {N : ℕ} {x : ℝ} (hx : x ≤ N) :
    (∑ n ∈ Finset.range ⌊x⌋₊, g n x) = ∑ n ∈ Finset.range N, g n x := by
  have hfloor : ⌊x⌋₊ ≤ N := by
    simpa using Nat.floor_mono hx
  apply Finset.sum_subset (Finset.range_mono hfloor)
  intro n hn hnout
  have hnx : ⌊x⌋₊ ≤ n := by simpa using hnout
  have hlt := Nat.lt_floor_add_one x
  have hnr : (⌊x⌋₊ : ℝ) ≤ n := by exact_mod_cast hnx
  exact hz n x (by linarith)

private theorem cutoff_continuous
    (g : ℕ → ℝ → ℂ) (hg : ∀ n, Continuous (g n))
    (hz : ∀ (n : ℕ) (x : ℝ), x ≤ (n : ℝ) + 1 → g n x = 0) :
    Continuous (fun x => ∑ n ∈ Finset.range ⌊x⌋₊, g n x) := by
  apply continuous_iff_continuousAt.mpr
  intro x
  obtain ⟨N, hN⟩ := exists_nat_gt x
  have hcont : Continuous (fun y => ∑ n ∈ Finset.range N, g n y) :=
    continuous_finset_sum _ (fun n _ => hg n)
  apply hcont.continuousAt.congr_of_eventuallyEq
  filter_upwards [eventually_lt_nhds hN] with y hy
  exact cutoff_eq_fixed_sum g hz hy.le

theorem continuous_tent (a : ℝ) : Continuous (RieszTentMellin.tent a) := by
  unfold RieszTentMellin.tent
  fun_prop

theorem continuous_rieszCutoff (c : ℕ → ℂ) :
    Continuous (RieszDirichlet.cutoffSum c) := by
  apply cutoff_continuous
  · intro n
    exact continuous_const.mul (continuous_tent ((n : ℝ) + 1))
  · intro n x hx
    have h : x - ((n : ℝ) + 1) ≤ 0 := by linarith
    simp [RieszTentMellin.tent, max_eq_right h]

theorem continuous_etaKernel {a : ℝ} (ha : 0 < a) :
    Continuous (EtaRieszKernel.kernel a) := by
  have he : EtaRieszKernel.kernel a = fun x => RieszTentMellin.tent a x +
      (((max (x - a) 0) ^ 2 / (2 * a) : ℝ) : ℂ) := by
    funext x
    exact EtaRieszKernel.kernel_eq_tent_add_square ha x
  rw [he]
  apply (continuous_tent a).add
  fun_prop

theorem continuous_etaSum : Continuous ActualCenteredMellin.etaSum := by
  apply cutoff_continuous
  · intro n
    exact continuous_const.mul (continuous_etaKernel (by positivity))
  · intro n x hx
    simp [EtaRieszKernel.kernel_eq_zero hx]

private theorem baseline_eq_max (x : ℝ) : EtaBaselineMellin.B x =
    ((max x 1 : ℝ) : ℂ) ^ 2 / 2 * (Real.log (max x 1) : ℂ) +
      ((max x 1 : ℝ) : ℂ) ^ 2 / 4 - 1 / 4 := by
  by_cases hx : 1 < x
  · simp [EtaBaselineMellin.B, hx, max_eq_left hx.le]
  · simp [EtaBaselineMellin.B, hx, max_eq_right (le_of_not_gt hx)]

theorem continuous_baseline : Continuous EtaBaselineMellin.B := by
  have he : EtaBaselineMellin.B = fun x =>
      ((max x 1 : ℝ) : ℂ) ^ 2 / 2 * (Real.log (max x 1) : ℂ) +
        ((max x 1 : ℝ) : ℂ) ^ 2 / 4 - 1 / 4 := funext baseline_eq_max
  rw [he]
  have hmax : Continuous (fun x : ℝ => max x 1) := continuous_id.max continuous_const
  have hlog : Continuous (fun x : ℝ => Real.log (max x 1)) :=
    hmax.log (fun x => ne_of_gt (lt_of_lt_of_le zero_lt_one (le_max_right x 1)))
  fun_prop

theorem continuous_N : Continuous ActualCenteredMellin.N := by
  change Continuous (fun x => RieszDirichlet.cutoffSum DistinctPrimeRieszMellin.fullPair x -
    2 * ActualCenteredMellin.etaSum x + EtaBaselineMellin.B x)
  exact (continuous_rieszCutoff DistinctPrimeRieszMellin.fullPair).sub
    (continuous_const.mul continuous_etaSum) |>.add continuous_baseline

theorem continuous_fullNumerator : Continuous ActualFullCenteredMellin.fullNumerator := by
  apply cutoff_continuous
  · intro n
    unfold CriticalMultipleMellin.scaled
    apply continuous_const.mul
    exact continuous_N.comp (continuous_id.div_const ((n : ℝ) + 1))
  · intro n x hx
    have hd : (0 : ℝ) < n + 1 := by positivity
    have hxd : x / ((n : ℝ) + 1) ≤ 1 := (div_le_one hd).mpr hx
    simp [CriticalMultipleMellin.scaled, ActualFullCenteredMellin.N_zero hxd]

theorem fullNumerator_mellin_convergent {c : ℝ} (hc : 2 < c) :
    MellinConvergent ActualFullCenteredMellin.fullNumerator (-c : ℂ) := by
  have h := ActualFullCenteredMellin.hasMellin_fullNumerator
    (s := (c : ℂ) - 1) (by simp; linarith)
  have he : -((c : ℂ) - 1) - 1 = (-c : ℂ) := by ring
  rw [he] at h
  exact h.1

theorem mellin_fullNumerator_vertical {c : ℝ} (hc : 2 < c) (t : ℝ) :
    mellin ActualFullCenteredMellin.fullNumerator (-c + t * Complex.I) =
      riemannZeta ((c : ℂ) - 1 / 2 - t * Complex.I) *
        LogDerivativePole.centeredZetaLogDerivative ((c : ℂ) - 1 - t * Complex.I) ^ 2 /
        (((c : ℂ) - 1 - t * Complex.I) * ((c : ℂ) - t * Complex.I)) := by
  have h := ActualFullCenteredMellin.hasMellin_fullNumerator
    (s := (c : ℂ) - 1 - t * Complex.I) (by simp; linarith)
  have he1 : -((c : ℂ) - 1 - t * Complex.I) - 1 = -c + t * Complex.I := by ring
  have he2 : ((c : ℂ) - 1 - t * Complex.I) + 1 / 2 =
      (c : ℂ) - 1 / 2 - t * Complex.I := by ring
  have he3 : ((c : ℂ) - 1 - t * Complex.I) + 1 =
      (c : ℂ) - t * Complex.I := by ring
  rw [he1, he2, he3] at h
  exact h.2

end BuildingBlocks.ActualFullCenteredMellinInversion

namespace BuildingBlocks.ActualFullCenteredMellinInversion

open ActualFullCenteredMellinVertical

theorem mellinInv_fullNumerator {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    mellinInv (-c) (mellin ActualFullCenteredMellin.fullNumerator) x =
      ActualFullCenteredMellin.fullNumerator x := by
  have hf : MellinConvergent ActualFullCenteredMellin.fullNumerator ((-c : ℝ) : ℂ) := by
    simpa only [Complex.ofReal_neg] using fullNumerator_mellin_convergent hc
  exact mellin_inversion (-c) ActualFullCenteredMellin.fullNumerator hx
    hf (verticalIntegrable_fullNumerator c hc)
    continuous_fullNumerator.continuousAt

/-- The literal Perron kernel, using the forward Mellin variable c-1+it. -/
noncomputable def perronKernel (c x t : ℝ) : ℂ :=
  (x : ℂ) ^ ((c : ℂ) + t * Complex.I) *
    fullFactor ((c : ℂ) - 1 + t * Complex.I)

theorem norm_perronKernel_le {c x : ℝ} (hc : 2 < c) (hx : 0 < x) (t : ℝ) :
    ‖perronKernel c x t‖ ≤
      x ^ c * (verticalAllowance (c - 1) / (1 + t ^ 2)) := by
  have hs : 1 < ((c : ℂ) - 1 + t * Complex.I).re := by simp; linarith
  have hf : ‖fullFactor ((c : ℂ) - 1 + t * Complex.I)‖ ≤
      verticalAllowance (c - 1) / (1 + t ^ 2) := by
    simpa using norm_fullFactor_le hs
  have hp : ‖(x : ℂ) ^ ((c : ℂ) + t * Complex.I)‖ = x ^ c := by
    rw [Complex.norm_cpow_eq_rpow_re_of_pos hx]
    congr 1
    simp
  unfold perronKernel
  rw [norm_mul, hp]
  exact mul_le_mul_of_nonneg_left hf (Real.rpow_nonneg hx.le c)

theorem integrable_perronKernel {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    Integrable (perronKernel c x) := by
  have hx0 : (x : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hx.ne'
  have hpow : Continuous (fun t : ℝ => (x : ℂ) ^ ((c : ℂ) + t * Complex.I)) := by
    simp_rw [Complex.cpow_def_of_ne_zero hx0]
    fun_prop
  have hfactor : Continuous (fun t : ℝ => fullFactor ((c : ℂ) - 1 + t * Complex.I)) := by
    simpa only [Complex.ofReal_sub, Complex.ofReal_one] using
      continuous_fullFactor_vertical (σ := c - 1) (by linarith)
  have hk : Continuous (perronKernel c x) := hpow.mul hfactor
  apply (integrable_inv_one_add_sq.const_mul
    (x ^ c * verticalAllowance (c - 1))).mono' hk.aestronglyMeasurable
  filter_upwards with t
  simpa only [div_eq_mul_inv, mul_assoc] using norm_perronKernel_le hc hx t

theorem mellinInv_kernel_eq_perron_neg {c : ℝ} (hc : 2 < c) (x t : ℝ) :
    (x : ℂ) ^ (-((-c : ℂ) + t * Complex.I)) *
      mellin ActualFullCenteredMellin.fullNumerator ((-c : ℂ) + t * Complex.I) =
      perronKernel c x (-t) := by
  rw [ActualFullCenteredMellinVertical.mellin_fullNumerator_vertical_eq c t hc]
  unfold perronKernel
  have he1 : -((-c : ℂ) + t * Complex.I) =
      (c : ℂ) + (-t : ℝ) * Complex.I := by push_cast; ring
  have he2 : (c - 1 : ℂ) - t * Complex.I =
      (c : ℂ) - 1 + (-t : ℝ) * Complex.I := by push_cast; ring
  rw [he1, he2]

theorem integrable_mellinInv_kernel {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    Integrable (fun t : ℝ =>
      (x : ℂ) ^ (-((-c : ℂ) + t * Complex.I)) *
        mellin ActualFullCenteredMellin.fullNumerator ((-c : ℂ) + t * Complex.I)) := by
  have h := (integrable_perronKernel hc hx).comp_neg
  apply h.congr
  filter_upwards with t
  exact (mellinInv_kernel_eq_perron_neg hc x t).symm

theorem mellinInv_eq_perron {c : ℝ} (hc : 2 < c) (x : ℝ) :
    mellinInv (-c) (mellin ActualFullCenteredMellin.fullNumerator) x =
      (1 / (2 * Real.pi) : ℝ) • ∫ t : ℝ, perronKernel c x t := by
  unfold mellinInv
  simp only [Complex.ofReal_neg, smul_eq_mul]
  simp_rw [mellinInv_kernel_eq_perron_neg hc]
  rw [integral_neg_eq_self]

theorem fullNumerator_eq_perron {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    ActualFullCenteredMellin.fullNumerator x =
      (1 / (2 * Real.pi) : ℝ) • ∫ t : ℝ, perronKernel c x t := by
  rw [← mellinInv_fullNumerator hc hx, mellinInv_eq_perron hc]

/-- The explicit shifted full-row factor with the unit and count pole retained. -/
noncomputable def perronFactor (s : ℂ) : ℂ :=
  riemannZeta (s - 1 / 2) *
    (1 / (s - 2) + deriv riemannZeta (s - 1) / riemannZeta (s - 1) + 1) ^ 2 /
    (s * (s - 1))

theorem perronFactor_eq_fullFactor {s : ℂ} (hs : 2 < s.re) :
    perronFactor s = fullFactor (s - 1) := by
  have hs2 : s - 2 ≠ 0 := by
    intro he
    have hr := congrArg Complex.re he
    simp at hr
    linarith
  have hτ : (s - 1) / (s - 2) = 1 + 1 / (s - 2) := by
    field_simp [hs2]
    ring
  have ha : (s - 1) + 1 / 2 = s - 1 / 2 := by ring
  have hb : (s - 1) + 1 = s := by ring
  have hd : (s - 1) - 1 = s - 2 := by ring
  unfold perronFactor fullFactor LogDerivativePole.centeredZetaLogDerivative
  simp only [logDeriv_apply]
  rw [ha, hb, hd, hτ, mul_comm (s - 1) s]
  ring

theorem perronKernel_eq_closed_form {c : ℝ} (hc : 2 < c) (x t : ℝ) :
    perronKernel c x t =
      (x : ℂ) ^ ((c : ℂ) + t * Complex.I) *
        perronFactor ((c : ℂ) + t * Complex.I) := by
  have hs : 2 < ((c : ℂ) + t * Complex.I).re := by simpa using hc
  have he : (c : ℂ) - 1 + t * Complex.I = ((c : ℂ) + t * Complex.I) - 1 := by ring
  unfold perronKernel
  rw [he, ← perronFactor_eq_fullFactor hs]

theorem fullNumerator_eq_closed_perron {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    ActualFullCenteredMellin.fullNumerator x =
      (1 / (2 * Real.pi) : ℝ) • ∫ t : ℝ,
        (x : ℂ) ^ ((c : ℂ) + t * Complex.I) *
          perronFactor ((c : ℂ) + t * Complex.I) := by
  rw [fullNumerator_eq_perron hc hx]
  congr 1
  apply integral_congr_ae
  filter_upwards with t
  exact perronKernel_eq_closed_form hc x t

theorem integrable_closed_perron {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    Integrable (fun t : ℝ => (x : ℂ) ^ ((c : ℂ) + t * Complex.I) *
      perronFactor ((c : ℂ) + t * Complex.I)) := by
  apply (integrable_perronKernel hc hx).congr
  filter_upwards with t
  exact perronKernel_eq_closed_form hc x t

end BuildingBlocks.ActualFullCenteredMellinInversion
