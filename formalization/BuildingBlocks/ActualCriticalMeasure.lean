import BuildingBlocks.MellinCompactCorrection
import BuildingBlocks.LaplaceConvergenceAbscissa
import Mathlib.MeasureTheory.Function.Floor
import Mathlib.MeasureTheory.Measure.WithDensity

open MeasureTheory Set
open scoped BigOperators ENNReal

namespace BuildingBlocks.ActualCriticalMeasure

theorem measurable_cutoff (F : ℕ → ℝ → ℂ) (hF : ∀ n, Measurable (F n)) :
    Measurable (fun x : ℝ => ∑ n ∈ Finset.range ⌊x⌋₊, F n x) := by
  have hm : Measurable (fun p : ℝ × ℕ => ∑ n ∈ Finset.range p.2, F n p.1) :=
    measurable_from_prod_countable_left (fun N =>
      (Finset.range N).measurable_fun_sum (fun n _ => hF n))
  exact hm.comp (measurable_id.prodMk Nat.measurable_floor)

theorem measurable_riesz (c : ℕ → ℂ) : Measurable (RieszDirichlet.cutoffSum c) := by
  apply measurable_cutoff
  intro n
  exact measurable_const.mul (Complex.measurable_ofReal.comp
    ((measurable_id.sub measurable_const).max measurable_const))

theorem measurable_etaKernel (a : ℝ) : Measurable (EtaRieszKernel.kernel a) := by
  unfold EtaRieszKernel.kernel
  apply Measurable.ite measurableSet_Ioi _ measurable_const
  fun_prop

theorem measurable_baseline : Measurable EtaBaselineMellin.B := by
  unfold EtaBaselineMellin.B
  apply Measurable.ite measurableSet_Ioi _ measurable_const
  fun_prop

theorem measurable_V : Measurable ActualCenteredMellin.V := by
  have he : Measurable ActualCenteredMellin.etaSum := by
    apply measurable_cutoff
    intro n
    exact measurable_const.mul (measurable_etaKernel (n + 1))
  exact ((measurable_riesz _).sub (measurable_const.mul he)).add measurable_baseline

theorem measurable_W : Measurable ActualCriticalMellin.W := by
  apply measurable_cutoff
  intro n
  exact measurable_const.mul (measurable_V.comp (measurable_id.div_const ((n : ℝ) + 1)))

theorem measurable_negativeWTail (A : ℝ) :
    Measurable (MellinCompactCorrection.negativeWTail A) :=
  (measurable_W.indicator measurableSet_Ioi).neg

/-- The time observable is globally nonnegative and equals log(x) on x>1. -/
noncomputable def time (x : ℝ) : ℝ := max (Real.log x) 0

theorem measurable_time : Measurable time := Real.measurable_log.max measurable_const

theorem time_nonneg (x : ℝ) : 0 ≤ time x := le_max_right _ _

theorem time_eq_log {x : ℝ} (hx : 1 < x) : time x = Real.log x :=
  max_eq_left (Real.log_nonneg hx.le)

/-- The x^(-2) factor keeps the exact Mellin normalization. Under the
separately stated eventual sign, this density equals x^(-2) times -W(x). -/
noncomputable def tailDensity (A x : ℝ) : ℝ≥0∞ :=
  ENNReal.ofReal (x ^ (-2 : ℝ) * (MellinCompactCorrection.negativeWTail A x).re)

theorem measurable_tailDensity (A : ℝ) : Measurable (tailDensity A) := by
  exact ((measurable_id.pow measurable_const).mul
    (Complex.measurable_re.comp (measurable_negativeWTail A))).ennreal_ofReal

/-- A positive measure on the actual x coordinate; no logarithmic Jacobian is
introduced or discarded. Its Laplace observable is time(x)=log(x) on its support. -/
noncomputable def tailMeasure (A : ℝ) : Measure ℝ :=
  (volume.restrict (Ioi 1)).withDensity (tailDensity A)

lemma norm_tail_kernel {A : ℝ}
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    (σ : ℝ) {x : ℝ} (hx : 1 < x) :
    ‖(x : ℂ) ^ (-(σ : ℂ) - 2) * MellinCompactCorrection.negativeWTail A x‖ =
      x ^ (-σ - 2) * (MellinCompactCorrection.negativeWTail A x).re := by
  have hr : MellinCompactCorrection.negativeWTail A x =
      ((MellinCompactCorrection.negativeWTail A x).re : ℂ) := by
    apply Complex.ext
    · rfl
    · simp [MellinCompactCorrection.negativeWTail_im]
  rw [norm_mul, Complex.norm_cpow_eq_rpow_re_of_pos (zero_lt_one.trans hx)]
  nth_rw 1 [hr]
  rw [Complex.norm_real, Real.norm_of_nonneg
    (MellinCompactCorrection.negativeWTail_re_nonneg hsign x)]
  norm_num

lemma real_weight_identity {x : ℝ} (hx : 0 < x) (σ : ℝ) :
    x ^ (-2 : ℝ) * Real.exp (-σ * Real.log x) = x ^ (-σ - 2) := by
  rw [Real.rpow_def_of_pos hx, Real.rpow_def_of_pos hx, ← Real.exp_add]
  congr 1
  ring

lemma density_exp_eq_enorm {A : ℝ}
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    (σ : ℝ) {x : ℝ} (hx : 1 < x) :
    tailDensity A x * ENNReal.ofReal (Real.exp (-σ * time x)) =
      ‖(x : ℂ) ^ (-(σ : ℂ) - 2) * MellinCompactCorrection.negativeWTail A x‖ₑ := by
  have hn : 0 ≤ x ^ (-2 : ℝ) * (MellinCompactCorrection.negativeWTail A x).re :=
    mul_nonneg (Real.rpow_nonneg (zero_lt_one.trans hx).le _)
      (MellinCompactCorrection.negativeWTail_re_nonneg hsign x)
  rw [tailDensity, ← ENNReal.ofReal_mul hn, ← ofReal_norm_eq_enorm,
    norm_tail_kernel hsign σ hx, time_eq_log hx]
  congr 1
  calc
    _ = (x ^ (-2 : ℝ) * Real.exp (-σ * Real.log x)) *
        (MellinCompactCorrection.negativeWTail A x).re := by ring
    _ = _ := by rw [real_weight_identity (zero_lt_one.trans hx)]

/-- This identification requires the actual sign. Without it, ofReal clips the
density and the resulting measure cannot be identified with the signed tail. -/
theorem laplace_mass_eq_norm {A : ℝ}
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) (σ : ℝ) :
    LaplaceConvergenceAbscissa.mass (tailMeasure A) time σ =
      ∫⁻ x : ℝ in Ioi 1, ‖(x : ℂ) ^ (-(σ : ℂ) - 2) *
        MellinCompactCorrection.negativeWTail A x‖ₑ := by
  unfold LaplaceConvergenceAbscissa.mass tailMeasure
  have hg : Measurable (fun y : ℝ => ENNReal.ofReal (Real.exp (-σ * time y))) :=
    (Real.measurable_exp.comp (measurable_const.mul measurable_time)).ennreal_ofReal
  rw [lintegral_withDensity_eq_lintegral_mul _ (measurable_tailDensity A) hg]
  apply lintegral_congr_ae
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
  exact density_exp_eq_enorm hsign σ hx

theorem laplace_integrable {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {σ : ℝ} (hσ : 1 < σ) :
    Integrable (fun x => Real.exp (-σ * time x)) (tailMeasure A) := by
  have hm := (MellinCompactCorrection.hasMellin_negativeWTail hA
    (s := (σ : ℂ)) hσ).1
  have hi0 : IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-(σ : ℂ) - 2) *
      MellinCompactCorrection.negativeWTail A x) (Ioi 0) := by
    simpa only [MellinConvergent, smul_eq_mul,
      show (-(σ : ℂ) - 1) - 1 = -(σ : ℂ) - 2 by ring] using hm
  have hi := hi0.mono_set (Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))
  apply (LaplaceConvergenceAbscissa.integrable_iff_mem (tailMeasure A) time measurable_time σ).2
  change LaplaceConvergenceAbscissa.mass (tailMeasure A) time σ < ∞
  rw [laplace_mass_eq_norm hsign σ]
  exact hasFiniteIntegral_iff_enorm.mp hi.2

theorem convergenceSet_nonempty {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) :
    (LaplaceConvergenceAbscissa.convergenceSet (tailMeasure A) time).Nonempty := by
  refine ⟨2, ?_⟩
  exact (LaplaceConvergenceAbscissa.integrable_iff_mem (tailMeasure A) time measurable_time 2).1
    (laplace_integrable hA hsign (by norm_num))

end BuildingBlocks.ActualCriticalMeasure
