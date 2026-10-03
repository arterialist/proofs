import BuildingBlocks.ActualFullCenteredMellinInversion
import BuildingBlocks.ActualEq22ForwardMellin

/-! Native initial-line inversion for the Eq22 a = 0 Mellin row.

Actual continuity, forward convergence and vertical absolute integrability
are discharged for c > 2 and x > 0. Literal original-object identification
is composed in ActualEq22OriginalMellin. The existing contour upper remains written
and unformalized; stronger arithmetic estimates and the eventual RH sign remain open. -/

open MeasureTheory Set Filter
open scoped Topology

namespace BuildingBlocks.ActualEq22MellinInversion

open ActualFullCenteredMellinVertical

noncomputable def coreAllowance0 (σ : ℝ) : ℝ := coreAllowance σ + 1

noncomputable def verticalAllowance0 (σ : ℝ) : ℝ :=
  absMass (1 : ℕ → ℂ) (σ + 1 / 2) * coreAllowance0 σ ^ 2

noncomputable def fullFactor0 (s : ℂ) : ℂ :=
  riemannZeta (s + 1 / 2) *
    (LogDerivativePole.centeredZetaLogDerivative s + 1) ^ 2 / (s * (s + 1))

theorem norm_centered_add_one_le {s : ℂ} (hs : 1 < s.re) :
    ‖LogDerivativePole.centeredZetaLogDerivative s + 1‖ ≤ coreAllowance0 s.re := by
  exact (norm_add_le _ _).trans (by
    simpa only [norm_one, coreAllowance0] using
      add_le_add_right (norm_centered_le hs) 1)

theorem norm_fullFactor0_le {s : ℂ} (hs : 1 < s.re) :
    ‖fullFactor0 s‖ ≤ verticalAllowance0 s.re / (1 + s.im ^ 2) := by
  have hsζ : 1 < (s + 1 / 2).re := by
    simp only [Complex.add_re, Complex.div_ofNat_re, Complex.one_re]
    linarith
  have hz := norm_zeta_le hsζ
  have hh := norm_centered_add_one_le hs
  have hmass := absMass_nonneg (1 : ℕ → ℂ) (s.re + 1 / 2)
  have hcore : 0 ≤ coreAllowance0 s.re := (norm_nonneg _).trans hh
  have hnum : ‖riemannZeta (s + 1 / 2)‖ *
      ‖LogDerivativePole.centeredZetaLogDerivative s + 1‖ ^ 2 ≤
        verticalAllowance0 s.re := by
    unfold verticalAllowance0
    simp only [Complex.add_re, Complex.div_ofNat_re, Complex.one_re] at hz
    gcongr
  have hden := norm_denominator_ge hs
  have hq : 0 < 1 + s.im ^ 2 := by positivity
  have hn : 0 ≤ verticalAllowance0 s.re := by unfold verticalAllowance0; positivity
  unfold fullFactor0
  rw [norm_div, norm_mul, norm_pow]
  calc
    _ ≤ verticalAllowance0 s.re / ‖s * (s + 1)‖ :=
      div_le_div_of_nonneg_right hnum (norm_nonneg _)
    _ ≤ verticalAllowance0 s.re / (1 + s.im ^ 2) :=
      div_le_div_of_nonneg_left hn hq hden

theorem analyticAt_fullFactor0 {s : ℂ} (hs : 1 < s.re) :
    AnalyticAt ℂ fullFactor0 s := by
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
  have heq : fullFactor0 = (fun z : ℂ => ShiftedZetaMultiplier.M z *
      (LogDerivativePole.centeredZetaLogDerivative z + 1) ^ 2) := by
    funext z
    simp only [fullFactor0, ShiftedZetaMultiplier.M, div_mul_eq_mul_div]
  rw [heq]
  exact hmult.mul ((hcenter.add analyticAt_const).pow 2)

theorem continuous_fullFactor0_vertical {σ : ℝ} (hσ : 1 < σ) :
    Continuous (fun t : ℝ => fullFactor0 ((σ : ℂ) + t * Complex.I)) := by
  apply continuous_iff_continuousAt.mpr
  intro t
  have hs : 1 < ((σ : ℂ) + t * Complex.I).re := by simpa using hσ
  have hmap : ContinuousAt (fun u : ℝ => (σ : ℂ) + (u : ℂ) * Complex.I) t := by
    fun_prop
  exact ContinuousAt.comp (f := fun u : ℝ => (σ : ℂ) + (u : ℂ) * Complex.I)
    (analyticAt_fullFactor0 hs).continuousAt hmap

theorem integrable_fullFactor0_vertical {σ : ℝ} (hσ : 1 < σ) :
    Integrable (fun t : ℝ => fullFactor0 ((σ : ℂ) + t * Complex.I)) := by
  apply (integrable_inv_one_add_sq.const_mul (verticalAllowance0 σ)).mono'
    (continuous_fullFactor0_vertical hσ).aestronglyMeasurable
  filter_upwards with t
  have hs : 1 < ((σ : ℂ) + t * Complex.I).re := by simpa using hσ
  simpa only [Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.I_re,
    Complex.I_im, Complex.ofReal_im, mul_zero, zero_mul, sub_zero, add_zero,
    Complex.add_im, Complex.mul_im, mul_one, zero_add, div_eq_mul_inv] using
      norm_fullFactor0_le hs

theorem mellin_C_vertical_eq (c t : ℝ) (hc : 2 < c) :
    mellin ActualEq22ForwardMellin.C ((-c : ℂ) + t * Complex.I) =
      fullFactor0 ((c - 1 : ℂ) - t * Complex.I) := by
  have hs : 1 < ((c - 1 : ℂ) - t * Complex.I).re := by simp; linarith
  have he := (ActualEq22ForwardMellin.hasMellin_C hs).2
  have harg : -((c - 1 : ℂ) - t * Complex.I) - 1 = (-c : ℂ) + t * Complex.I := by ring
  simpa only [harg, fullFactor0] using he

theorem verticalIntegrable_C (c : ℝ) (hc : 2 < c) :
    Complex.VerticalIntegrable (mellin ActualEq22ForwardMellin.C) (-c) := by
  have hσ : 1 < c - 1 := by linarith
  have hi := (integrable_fullFactor0_vertical hσ).comp_neg
  unfold Complex.VerticalIntegrable
  convert hi using 1
  ext t
  simp only [Complex.ofReal_neg, Complex.ofReal_sub, Complex.ofReal_one]
  rw [mellin_C_vertical_eq c t hc]
  congr 1
  ring

theorem C_mellin_convergent {c : ℝ} (hc : 2 < c) :
    MellinConvergent ActualEq22ForwardMellin.C (-c : ℂ) := by
  have h := ActualEq22ForwardMellin.hasMellin_C (s := (c : ℂ) - 1) (by simp; linarith)
  have he : -((c : ℂ) - 1) - 1 = (-c : ℂ) := by ring
  rw [he] at h
  exact h.1

theorem mellinInv_C {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    mellinInv (-c) (mellin ActualEq22ForwardMellin.C) x = ActualEq22ForwardMellin.C x := by
  have hf : MellinConvergent ActualEq22ForwardMellin.C ((-c : ℝ) : ℂ) := by
    simpa only [Complex.ofReal_neg] using C_mellin_convergent hc
  exact mellin_inversion (-c) ActualEq22ForwardMellin.C hx hf (verticalIntegrable_C c hc)
    ActualEq22ForwardMellin.continuous_C.continuousAt

noncomputable def perronKernel0 (c x t : ℝ) : ℂ :=
  (x : ℂ) ^ ((c : ℂ) + t * Complex.I) *
    fullFactor0 ((c : ℂ) - 1 + t * Complex.I)

theorem norm_perronKernel0_le {c x : ℝ} (hc : 2 < c) (hx : 0 < x) (t : ℝ) :
    ‖perronKernel0 c x t‖ ≤
      x ^ c * (verticalAllowance0 (c - 1) / (1 + t ^ 2)) := by
  have hs : 1 < ((c : ℂ) - 1 + t * Complex.I).re := by simp; linarith
  have hf : ‖fullFactor0 ((c : ℂ) - 1 + t * Complex.I)‖ ≤
      verticalAllowance0 (c - 1) / (1 + t ^ 2) := by
    simpa using norm_fullFactor0_le hs
  have hp : ‖(x : ℂ) ^ ((c : ℂ) + t * Complex.I)‖ = x ^ c := by
    rw [Complex.norm_cpow_eq_rpow_re_of_pos hx]
    congr 1
    simp
  unfold perronKernel0
  rw [norm_mul, hp]
  exact mul_le_mul_of_nonneg_left hf (Real.rpow_nonneg hx.le c)

theorem integrable_perronKernel0 {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    Integrable (perronKernel0 c x) := by
  have hx0 : (x : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hx.ne'
  have hpow : Continuous (fun t : ℝ => (x : ℂ) ^ ((c : ℂ) + t * Complex.I)) := by
    simp_rw [Complex.cpow_def_of_ne_zero hx0]
    fun_prop
  have hfactor : Continuous (fun t : ℝ => fullFactor0 ((c : ℂ) - 1 + t * Complex.I)) := by
    simpa only [Complex.ofReal_sub, Complex.ofReal_one] using
      continuous_fullFactor0_vertical (σ := c - 1) (by linarith)
  have hk : Continuous (perronKernel0 c x) := hpow.mul hfactor
  apply (integrable_inv_one_add_sq.const_mul
    (x ^ c * verticalAllowance0 (c - 1))).mono' hk.aestronglyMeasurable
  filter_upwards with t
  simpa only [div_eq_mul_inv, mul_assoc] using norm_perronKernel0_le hc hx t

theorem mellinInv_kernel_eq_perron0_neg {c : ℝ} (hc : 2 < c) (x t : ℝ) :
    (x : ℂ) ^ (-((-c : ℂ) + t * Complex.I)) *
      mellin ActualEq22ForwardMellin.C ((-c : ℂ) + t * Complex.I) =
      perronKernel0 c x (-t) := by
  rw [mellin_C_vertical_eq c t hc]
  unfold perronKernel0
  have he1 : -((-c : ℂ) + t * Complex.I) =
      (c : ℂ) + (-t : ℝ) * Complex.I := by push_cast; ring
  have he2 : (c - 1 : ℂ) - t * Complex.I =
      (c : ℂ) - 1 + (-t : ℝ) * Complex.I := by push_cast; ring
  rw [he1, he2]

theorem integrable_mellinInv_C_kernel {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    Integrable (fun t : ℝ =>
      (x : ℂ) ^ (-((-c : ℂ) + t * Complex.I)) *
        mellin ActualEq22ForwardMellin.C ((-c : ℂ) + t * Complex.I)) := by
  have h := (integrable_perronKernel0 hc hx).comp_neg
  apply h.congr
  filter_upwards with t
  exact (mellinInv_kernel_eq_perron0_neg hc x t).symm

theorem C_eq_perron {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    ActualEq22ForwardMellin.C x = (1 / (2 * Real.pi) : ℝ) • ∫ t : ℝ, perronKernel0 c x t := by
  rw [← mellinInv_C hc hx]
  unfold mellinInv
  simp only [Complex.ofReal_neg, smul_eq_mul]
  simp_rw [mellinInv_kernel_eq_perron0_neg hc]
  rw [integral_neg_eq_self]

/-- The +1 is combined exactly with the original count pole after shifting.
No pole or regular unit term is deleted. -/
noncomputable def perronFactor0 (s : ℂ) : ℂ :=
  riemannZeta (s - 1 / 2) *
    (1 / (s - 2) + deriv riemannZeta (s - 1) / riemannZeta (s - 1)) ^ 2 /
    (s * (s - 1))

theorem perronFactor0_eq_fullFactor0 {s : ℂ} (hs : 2 < s.re) :
    perronFactor0 s = fullFactor0 (s - 1) := by
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
  unfold perronFactor0 fullFactor0 LogDerivativePole.centeredZetaLogDerivative
  simp only [logDeriv_apply]
  rw [ha, hb, hd, hτ, mul_comm (s - 1) s]
  ring

theorem perronKernel0_eq_closed_form {c : ℝ} (hc : 2 < c) (x t : ℝ) :
    perronKernel0 c x t =
      (x : ℂ) ^ ((c : ℂ) + t * Complex.I) *
        perronFactor0 ((c : ℂ) + t * Complex.I) := by
  have hs : 2 < ((c : ℂ) + t * Complex.I).re := by simpa using hc
  have he : (c : ℂ) - 1 + t * Complex.I = ((c : ℂ) + t * Complex.I) - 1 := by ring
  unfold perronKernel0
  rw [he, ← perronFactor0_eq_fullFactor0 hs]

theorem C_eq_closed_perron {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    ActualEq22ForwardMellin.C x = (1 / (2 * Real.pi) : ℝ) • ∫ t : ℝ,
      (x : ℂ) ^ ((c : ℂ) + t * Complex.I) *
        perronFactor0 ((c : ℂ) + t * Complex.I) := by
  rw [C_eq_perron hc hx]
  congr 1
  apply integral_congr_ae
  filter_upwards with t
  exact perronKernel0_eq_closed_form hc x t

theorem integrable_closed_perron0 {c x : ℝ} (hc : 2 < c) (hx : 0 < x) :
    Integrable (fun t : ℝ => (x : ℂ) ^ ((c : ℂ) + t * Complex.I) *
      perronFactor0 ((c : ℂ) + t * Complex.I)) := by
  apply (integrable_perronKernel0 hc hx).congr
  filter_upwards with t
  exact perronKernel0_eq_closed_form hc x t

end BuildingBlocks.ActualEq22MellinInversion
