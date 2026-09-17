import BuildingBlocks.PrimeSeedCausalSupport
import BuildingBlocks.PrimeSeedCutoffConvergence

/-! The actual finite-activity exponent on the closed right half-plane. -/

open MeasureTheory Real
open scoped MeasureTheory NNReal ENNReal

namespace BuildingBlocks.PrimeSeedMass

noncomputable def laplaceKernel (s : ℂ) (v : ℝ) : ℂ :=
  1 - Complex.exp (-s * (v : ℂ))

theorem laplaceKernel_norm_le {s : ℂ} (hs : 0 ≤ s.re) {v : ℝ} (hv : 0 ≤ v) :
    ‖laplaceKernel s v‖ ≤ 2 := by
  have he : ‖Complex.exp (-s * (v : ℂ))‖ ≤ 1 := by
    rw [Complex.norm_exp, exp_le_one_iff]
    simp only [Complex.mul_re, Complex.neg_re, Complex.neg_im, Complex.ofReal_re,
      Complex.ofReal_im, mul_zero, sub_zero]
    exact mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr hs) hv
  calc
    ‖laplaceKernel s v‖ ≤ ‖(1 : ℂ)‖ + ‖Complex.exp (-s * (v : ℂ))‖ := norm_sub_le _ _
    _ ≤ 2 := by rw [norm_one]; linarith

theorem integrable_laplaceKernel {μ : Measure ℝ} [IsFiniteMeasure μ]
    (hμ : ∀ᵐ v ∂μ, (0 : ℝ) ≤ v) {s : ℂ} (hs : 0 ≤ s.re) :
    Integrable (laplaceKernel s) μ := by
  have hc : Continuous (laplaceKernel s) := by unfold laplaceKernel; fun_prop
  apply Integrable.of_bound hc.aestronglyMeasurable 2
  filter_upwards [hμ] with v hv
  exact laplaceKernel_norm_le hs hv

noncomputable def jumpExponent (μ : Measure ℝ) (s : ℂ) : ℂ :=
  ∫ v, laplaceKernel s v ∂μ

noncomputable def allPrimeExponent (s : ℂ) : ℂ := jumpExponent allPrimeLevyMeasure s

noncomputable def cutoffPrimeExponent (P : ℕ) (s : ℂ) : ℂ :=
  jumpExponent (levyMeasure (primesBelow P)) s

private theorem ae_nonneg_of_le {μ : Measure ℝ} (h : μ ≤ allPrimeLevyMeasure) :
    ∀ᵐ v ∂μ, (0 : ℝ) ≤ v := by
  have hh := allPrimeLevyMeasure_ae_nonneg
  rw [ae_iff] at hh ⊢
  exact le_antisymm ((h _).trans_eq hh) (zero_le _)

private theorem tail_le_all (P : ℕ) : primeTailLevyMeasure P ≤ allPrimeLevyMeasure := by
  rw [← levyMeasure_primesBelow_add_tail P]
  intro A
  rw [Measure.add_apply]
  exact le_add_self

theorem allPrimeExponent_zero : allPrimeExponent 0 = 0 := by
  simp [allPrimeExponent, jumpExponent, laplaceKernel]

theorem allPrimeExponent_norm_le {s : ℂ} (hs : 0 ≤ s.re) :
    ‖allPrimeExponent s‖ ≤ 2 * allPrimeLevyMeasure.real Set.univ := by
  apply norm_integral_le_of_norm_le_const
  filter_upwards [allPrimeLevyMeasure_ae_nonneg] with v hv
  exact laplaceKernel_norm_le hs hv

theorem allPrimeExponent_re_nonneg {s : ℂ} (hs : 0 ≤ s.re) :
    0 ≤ (allPrimeExponent s).re := by
  have hi := integral_re (integrable_laplaceKernel allPrimeLevyMeasure_ae_nonneg hs)
  change (∫ v, (laplaceKernel s v).re ∂allPrimeLevyMeasure) =
    (allPrimeExponent s).re at hi
  rw [← hi]
  apply integral_nonneg_of_ae
  filter_upwards [allPrimeLevyMeasure_ae_nonneg] with v hv
  have he : ‖Complex.exp (-s * (v : ℂ))‖ ≤ 1 := by
    rw [Complex.norm_exp, exp_le_one_iff]
    simp only [Complex.mul_re, Complex.neg_re, Complex.neg_im, Complex.ofReal_re,
      Complex.ofReal_im, mul_zero, sub_zero]
    exact mul_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr hs) hv
  have hr := Complex.re_le_norm (Complex.exp (-s * (v : ℂ)))
  change 0 ≤ (1 - Complex.exp (-s * (v : ℂ))).re
  simp only [Complex.sub_re, Complex.one_re]
  linarith

/-- The complete omitted measure is the exact exponent error. -/
theorem allPrimeExponent_sub_cutoff (P : ℕ) {s : ℂ} (hs : 0 ≤ s.re) :
    allPrimeExponent s - cutoffPrimeExponent P s = jumpExponent (primeTailLevyMeasure P) s := by
  have h := integral_add_measure
    (integrable_laplaceKernel (ae_nonneg_of_le (levyMeasure_primesBelow_le P)) hs)
    (integrable_laplaceKernel (ae_nonneg_of_le (tail_le_all P)) hs)
  rw [levyMeasure_primesBelow_add_tail P] at h
  change jumpExponent allPrimeLevyMeasure s =
    cutoffPrimeExponent P s + jumpExponent (primeTailLevyMeasure P) s at h
  exact sub_eq_iff_eq_add.mpr (h.trans (add_comm _ _))

/-- Uniform on the whole closed right half-plane, including its boundary. -/
theorem allPrimeExponent_cutoff_bound (P : ℕ) (hP : 8 ≤ P) {s : ℂ} (hs : 0 ≤ s.re) :
    ‖allPrimeExponent s - cutoffPrimeExponent P s‖ ≤ 64 / log (P : ℝ) := by
  rw [allPrimeExponent_sub_cutoff P hs]
  have hn : ‖jumpExponent (primeTailLevyMeasure P) s‖ ≤
      2 * (primeTailLevyMeasure P).real Set.univ := by
    apply norm_integral_le_of_norm_le_const
    filter_upwards [ae_nonneg_of_le (tail_le_all P)] with v hv
    exact laplaceKernel_norm_le hs hv
  have ht := ENNReal.toReal_mono (by finiteness) (primeTailLevyMeasure_mass_le_log P hP)
  rw [ENNReal.toReal_ofReal (by positivity)] at ht
  apply hn.trans
  calc
    2 * (primeTailLevyMeasure P).real Set.univ ≤ 2 * (32 / log (P : ℝ)) :=
      mul_le_mul_of_nonneg_left ht (by norm_num)
    _ = _ := by ring

end BuildingBlocks.PrimeSeedMass
