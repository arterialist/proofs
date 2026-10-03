import BuildingBlocks.ActualFullCenteredMellinInversion
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals

/-! Finite-height initial-line approximation for the actual full numerator.

For every c > 2, x > 0 and real T > 0, the native Perron truncation error
is at most x^c * verticalAllowance(c-1) / (pi*T), with a T >= 1 specialization.
Both complement tails, all endpoints and the exact 1/(2*pi) normalization
are retained. The existing complete analytic upper remains proved in written
analysis and unformalized; stronger arithmetic estimates, the eventual signed
premise and RH remain open. No novelty or RH-frontier claim is made. -/

open MeasureTheory Set

namespace BuildingBlocks.PerronTruncationInterval

/-- The residual of a set truncation is exactly the complement integral. -/
theorem integral_sub_setIntegral_eq_compl {f : ℝ → ℂ} {s : Set ℝ}
    (hs : MeasurableSet s) (hf : Integrable f) :
    (∫ t : ℝ, f t) - (∫ t : ℝ in s, f t) = ∫ t : ℝ in sᶜ, f t := by
  exact (setIntegral_compl hs hf).symm

/-- A generic norm bound for the complete residual, without a tail estimate. -/
theorem norm_integral_sub_setIntegral_le_compl {f : ℝ → ℂ} {s : Set ℝ}
    (hs : MeasurableSet s) (hf : Integrable f) :
    ‖(∫ t : ℝ, f t) - (∫ t : ℝ in s, f t)‖ ≤
      ∫ t : ℝ in sᶜ, ‖f t‖ := by
  rw [integral_sub_setIntegral_eq_compl hs hf]
  exact norm_integral_le_integral_norm f

theorem integral_sub_integral_Icc_eq_compl {f : ℝ → ℂ}
    (hf : Integrable f) (T : ℝ) :
    (∫ t : ℝ, f t) - (∫ t : ℝ in Icc (-T) T, f t) =
      ∫ t : ℝ in (Icc (-T) T)ᶜ, f t := by
  exact integral_sub_setIntegral_eq_compl measurableSet_Icc hf

theorem norm_integral_sub_integral_Icc_le_compl {f : ℝ → ℂ}
    (hf : Integrable f) (T : ℝ) :
    ‖(∫ t : ℝ, f t) - (∫ t : ℝ in Icc (-T) T, f t)‖ ≤
      ∫ t : ℝ in (Icc (-T) T)ᶜ, ‖f t‖ := by
  exact norm_integral_sub_setIntegral_le_compl measurableSet_Icc hf

/-- Lebesgue-null endpoints identify an oriented interval with its closed set. -/
theorem intervalIntegral_eq_integral_Icc (f : ℝ → ℂ) {a b : ℝ}
    (hab : a ≤ b) :
    (∫ t : ℝ in a..b, f t) = ∫ t : ℝ in Icc a b, f t := by
  rw [intervalIntegral.integral_of_le hab, integral_Icc_eq_integral_Ioc]

theorem symmetric_intervalIntegral_eq_integral_Icc (f : ℝ → ℂ)
    {T : ℝ} (hT : 0 ≤ T) :
    (∫ t : ℝ in (-T)..T, f t) = ∫ t : ℝ in Icc (-T) T, f t := by
  exact intervalIntegral_eq_integral_Icc f (by linarith)

theorem integral_sub_symmetric_interval_eq_compl {f : ℝ → ℂ}
    (hf : Integrable f) {T : ℝ} (hT : 0 ≤ T) :
    (∫ t : ℝ, f t) - (∫ t : ℝ in (-T)..T, f t) =
      ∫ t : ℝ in (Icc (-T) T)ᶜ, f t := by
  rw [symmetric_intervalIntegral_eq_integral_Icc f hT]
  exact integral_sub_integral_Icc_eq_compl hf T

theorem norm_integral_sub_symmetric_interval_le_compl {f : ℝ → ℂ}
    (hf : Integrable f) {T : ℝ} (hT : 0 ≤ T) :
    ‖(∫ t : ℝ, f t) - (∫ t : ℝ in (-T)..T, f t)‖ ≤
      ∫ t : ℝ in (Icc (-T) T)ᶜ, ‖f t‖ := by
  rw [integral_sub_symmetric_interval_eq_compl hf hT]
  exact norm_integral_le_integral_norm f

theorem scaled_residual_eq_compl (r : ℝ) {f : ℝ → ℂ}
    (hf : Integrable f) {T : ℝ} (hT : 0 ≤ T) :
    r • (∫ t : ℝ, f t) - r • (∫ t : ℝ in (-T)..T, f t) =
      r • (∫ t : ℝ in (Icc (-T) T)ᶜ, f t) := by
  rw [← smul_sub, integral_sub_symmetric_interval_eq_compl hf hT]

theorem norm_scaled_residual_le_compl {r : ℝ} (hr : 0 ≤ r)
    {f : ℝ → ℂ} (hf : Integrable f) {T : ℝ} (hT : 0 ≤ T) :
    ‖r • (∫ t : ℝ, f t) - r • (∫ t : ℝ in (-T)..T, f t)‖ ≤
      r * (∫ t : ℝ in (Icc (-T) T)ᶜ, ‖f t‖) := by
  rw [← smul_sub, norm_smul, Real.norm_of_nonneg hr]
  exact mul_le_mul_of_nonneg_left
    (norm_integral_sub_symmetric_interval_le_compl hf hT) hr

theorem norm_perron_normalized_residual_le_compl {f : ℝ → ℂ}
    (hf : Integrable f) {T : ℝ} (hT : 0 ≤ T) :
    ‖(1 / (2 * Real.pi) : ℝ) • (∫ t : ℝ, f t) -
      (1 / (2 * Real.pi) : ℝ) • (∫ t : ℝ in (-T)..T, f t)‖ ≤
      (1 / (2 * Real.pi)) * (∫ t : ℝ in (Icc (-T) T)ᶜ, ‖f t‖) := by
  exact norm_scaled_residual_le_compl (by positivity) hf hT

/-- Actual specialization uses proved full Perron inversion and integrability. -/
theorem fullNumerator_truncation_residual_eq_compl {c x T : ℝ}
    (hc : 2 < c) (hx : 0 < x) (hT : 0 ≤ T) :
    BuildingBlocks.ActualFullCenteredMellin.fullNumerator x -
      (1 / (2 * Real.pi) : ℝ) •
        (∫ t : ℝ in (-T)..T,
          BuildingBlocks.ActualFullCenteredMellinInversion.perronKernel c x t) =
      (1 / (2 * Real.pi) : ℝ) •
        (∫ t : ℝ in (Icc (-T) T)ᶜ,
          BuildingBlocks.ActualFullCenteredMellinInversion.perronKernel c x t) := by
  rw [BuildingBlocks.ActualFullCenteredMellinInversion.fullNumerator_eq_perron hc hx]
  exact scaled_residual_eq_compl _
    (BuildingBlocks.ActualFullCenteredMellinInversion.integrable_perronKernel hc hx) hT

theorem fullNumerator_truncation_residual_le_compl {c x T : ℝ}
    (hc : 2 < c) (hx : 0 < x) (hT : 0 ≤ T) :
    ‖BuildingBlocks.ActualFullCenteredMellin.fullNumerator x -
      (1 / (2 * Real.pi) : ℝ) •
        (∫ t : ℝ in (-T)..T,
          BuildingBlocks.ActualFullCenteredMellinInversion.perronKernel c x t)‖ ≤
      (1 / (2 * Real.pi)) *
        (∫ t : ℝ in (Icc (-T) T)ᶜ,
          ‖BuildingBlocks.ActualFullCenteredMellinInversion.perronKernel c x t‖) := by
  rw [BuildingBlocks.ActualFullCenteredMellinInversion.fullNumerator_eq_perron hc hx]
  exact norm_perron_normalized_residual_le_compl
    (BuildingBlocks.ActualFullCenteredMellinInversion.integrable_perronKernel hc hx) hT

end BuildingBlocks.PerronTruncationInterval

open MeasureTheory Set

namespace BuildingBlocks.PerronTruncationTail

noncomputable def weight (t : ℝ) : ℝ := (1 + t ^ 2)⁻¹

theorem weight_nonneg (t : ℝ) : 0 ≤ weight t := by
  unfold weight
  positivity

theorem integrable_weight : Integrable weight :=
  integrable_inv_one_add_sq

theorem positive_tail_le {T : ℝ} (hT : 0 < T) :
    (∫ t : ℝ in Ioi T, weight t) ≤ 1 / T := by
  have hr : IntegrableOn (fun t : ℝ => t ^ (-2 : ℝ)) (Ioi T) :=
    integrableOn_Ioi_rpow_of_lt (by norm_num) hT
  have he : (∫ t : ℝ in Ioi T, t ^ (-2 : ℝ)) = 1 / T := by
    simpa only [show (-2 : ℝ) + 1 = -1 by norm_num, Real.rpow_neg_one,
      neg_div_neg_eq, div_one, one_div] using
      integral_Ioi_rpow_of_lt (by norm_num : (-2 : ℝ) < -1) hT
  calc
    (∫ t : ℝ in Ioi T, weight t) ≤
        ∫ t : ℝ in Ioi T, t ^ (-2 : ℝ) := by
      apply setIntegral_mono_on integrable_weight.integrableOn hr measurableSet_Ioi
      intro t ht
      have ht0 : 0 < t := hT.trans ht
      have hsq : 0 < t ^ 2 := sq_pos_of_pos ht0
      have hle : t ^ 2 ≤ 1 + t ^ 2 := by linarith
      simpa only [weight, Real.rpow_neg ht0.le, Real.rpow_two, one_div] using
        one_div_le_one_div_of_le hsq hle
    _ = 1 / T := he

theorem negative_tail_eq_positive_tail (T : ℝ) :
    (∫ t : ℝ in Iio (-T), weight t) = ∫ t : ℝ in Ioi T, weight t := by
  calc
    (∫ t : ℝ in Iio (-T), weight t) = ∫ t : ℝ in Iic (-T), weight t :=
      setIntegral_congr_set Iio_ae_eq_Iic
    _ = Real.arctan (-T) + Real.pi / 2 := integral_Iic_inv_one_add_sq
    _ = Real.pi / 2 - Real.arctan T := by rw [Real.arctan_neg]; ring
    _ = ∫ t : ℝ in Ioi T, weight t := integral_Ioi_inv_one_add_sq.symm

theorem complement_Icc_eq_tails (T : ℝ) :
    (Icc (-T) T)ᶜ = Iio (-T) ∪ Ioi T := by
  ext t
  simp only [mem_compl_iff, mem_Icc, mem_union, mem_Iio, mem_Ioi]
  constructor
  · intro h
    by_cases hleft : -T ≤ t
    · exact Or.inr (lt_of_not_ge (fun hright => h ⟨hleft, hright⟩))
    · exact Or.inl (lt_of_not_ge hleft)
  · rintro (h | h) ⟨hl, hr⟩
    · exact (not_lt_of_ge hl) h
    · exact (not_lt_of_ge hr) h

theorem integral_complement_Icc_eq_twice_positive_tail {T : ℝ} (hT : 0 ≤ T) :
    (∫ t : ℝ in (Icc (-T) T)ᶜ, weight t) =
      2 * ∫ t : ℝ in Ioi T, weight t := by
  have hd : Disjoint (Iio (-T)) (Ioi T) := by
    apply Set.disjoint_left.mpr
    intro t hl hr
    have hleft : t < -T := hl
    have hright : T < t := hr
    linarith
  rw [complement_Icc_eq_tails, setIntegral_union hd measurableSet_Ioi
    integrable_weight.integrableOn integrable_weight.integrableOn,
    negative_tail_eq_positive_tail]
  ring

theorem two_tail_le {T : ℝ} (hT : 0 < T) :
    (∫ t : ℝ in (Icc (-T) T)ᶜ, weight t) ≤ 2 / T := by
  rw [integral_complement_Icc_eq_twice_positive_tail hT.le]
  calc
    2 * (∫ t : ℝ in Ioi T, weight t) ≤ 2 * (1 / T) :=
      mul_le_mul_of_nonneg_left (positive_tail_le hT) (by norm_num)
    _ = 2 / T := by ring

theorem two_tail_le_of_one_le {T : ℝ} (hT : 1 ≤ T) :
    (∫ t : ℝ in (Icc (-T) T)ᶜ, (1 + t ^ 2)⁻¹) ≤ 2 / T :=
  two_tail_le (lt_of_lt_of_le zero_lt_one hT)

theorem two_tail_le_literal {T : ℝ} (hT : 0 < T) :
    (∫ t : ℝ in (Icc (-T) T)ᶜ, (1 + t ^ 2)⁻¹) ≤ 2 / T :=
  two_tail_le hT

end BuildingBlocks.PerronTruncationTail

open MeasureTheory Set

namespace BuildingBlocks.ActualFullPerronTruncation

open ActualFullCenteredMellinVertical ActualFullCenteredMellinInversion

theorem verticalAllowance_nonneg (σ : ℝ) : 0 ≤ verticalAllowance σ := by
  unfold verticalAllowance
  exact mul_nonneg (absMass_nonneg _ _) (sq_nonneg _)

theorem integral_norm_perron_complement_le {c x T : ℝ}
    (hc : 2 < c) (hx : 0 < x) (hT : 0 < T) :
    (∫ t : ℝ in (Icc (-T) T)ᶜ, ‖perronKernel c x t‖) ≤
      (x ^ c * verticalAllowance (c - 1)) * (2 / T) := by
  let A : ℝ := x ^ c * verticalAllowance (c - 1)
  have hA : 0 ≤ A :=
    mul_nonneg (Real.rpow_nonneg hx.le c) (verticalAllowance_nonneg _)
  have hk := integrable_perronKernel hc hx
  have hg : Integrable (fun t : ℝ => A * (1 + t ^ 2)⁻¹) :=
    integrable_inv_one_add_sq.const_mul A
  calc
    (∫ t : ℝ in (Icc (-T) T)ᶜ, ‖perronKernel c x t‖) ≤
        ∫ t : ℝ in (Icc (-T) T)ᶜ, A * (1 + t ^ 2)⁻¹ := by
      apply integral_mono_ae hk.norm.integrableOn hg.integrableOn
      filter_upwards with t
      simpa only [A, div_eq_mul_inv, mul_assoc] using norm_perronKernel_le hc hx t
    _ = A * (∫ t : ℝ in (Icc (-T) T)ᶜ, (1 + t ^ 2)⁻¹) :=
      integral_const_mul A _
    _ ≤ A * (2 / T) :=
      mul_le_mul_of_nonneg_left (BuildingBlocks.PerronTruncationTail.two_tail_le_literal hT) hA

/-- Actual complete numerator truncation error with no extra analytic premise. -/
theorem fullNumerator_truncation_error_le_of_pos {c x T : ℝ}
    (hc : 2 < c) (hx : 0 < x) (hT : 0 < T) :
    ‖ActualFullCenteredMellin.fullNumerator x -
      (1 / (2 * Real.pi) : ℝ) •
        (∫ t : ℝ in (-T)..T, perronKernel c x t)‖ ≤
      x ^ c * verticalAllowance (c - 1) / (Real.pi * T) := by
  calc
    _ ≤ (1 / (2 * Real.pi)) *
        (∫ t : ℝ in (Icc (-T) T)ᶜ, ‖perronKernel c x t‖) :=
      BuildingBlocks.PerronTruncationInterval.fullNumerator_truncation_residual_le_compl hc hx hT.le
    _ ≤ (1 / (2 * Real.pi)) *
        ((x ^ c * verticalAllowance (c - 1)) * (2 / T)) :=
      mul_le_mul_of_nonneg_left (integral_norm_perron_complement_le hc hx hT)
        (by positivity)
    _ = x ^ c * verticalAllowance (c - 1) / (Real.pi * T) := by
      field_simp [ne_of_gt Real.pi_pos, ne_of_gt hT]

/-- The requested all-real T >= 1 specialization. -/
theorem fullNumerator_truncation_error_le {c x T : ℝ}
    (hc : 2 < c) (hx : 0 < x) (hT : 1 ≤ T) :
    ‖ActualFullCenteredMellin.fullNumerator x -
      (1 / (2 * Real.pi) : ℝ) •
        (∫ t : ℝ in (-T)..T, perronKernel c x t)‖ ≤
      x ^ c * verticalAllowance (c - 1) / (Real.pi * T) :=
  fullNumerator_truncation_error_le_of_pos hc hx (lt_of_lt_of_le zero_lt_one hT)

end BuildingBlocks.ActualFullPerronTruncation
