import BuildingBlocks.SuccessorFeedbackClock
import Mathlib.Analysis.SpecialFunctions.Gaussian.GaussianIntegral
import Mathlib.MeasureTheory.Integral.DominatedConvergence

/-! The Gamma–Mellin identity for the actual successor feedback coefficients.
The constant coefficient is removed before integration over the whole positive axis. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

noncomputable def gammaKernel (z : ℂ) (r t : ℝ) : ℂ :=
  (t : ℂ) ^ (z - 1) * (Real.exp (-(r * t)) : ℂ)

theorem gammaKernel_norm (z : ℂ) (r : ℝ) {t : ℝ} (ht : 0 < t) :
    ‖gammaKernel z r t‖ = t ^ (z.re - 1) * exp (-(r * t)) := by
  rw [gammaKernel, norm_mul, Complex.norm_cpow_eq_rpow_re_of_pos ht,
    Complex.norm_real, Real.norm_eq_abs, abs_of_pos (exp_pos _)]
  simp

theorem gammaKernel_integrable {z : ℂ} (hz : 0 < z.re) {r : ℝ} (hr : 0 < r) :
    IntegrableOn (gammaKernel z r) (Ioi 0) := by
  have hi : IntegrableOn (fun t : ℝ => t ^ (z.re - 1) * exp (-(r * t))) (Ioi 0) := by
    simpa only [Real.rpow_one, neg_mul] using
      (integrableOn_rpow_mul_exp_neg_mul_rpow (p := 1) (s := z.re - 1)
        (by linarith) le_rfl hr)
  apply hi.mono'
  · apply ContinuousOn.aestronglyMeasurable _ measurableSet_Ioi
    apply ContinuousOn.mul
    · exact continuousOn_of_forall_continuousAt (fun t ht =>
        (continuousAt_cpow_const
          (Complex.ofReal_mem_slitPlane.mpr ht)).comp Complex.continuous_ofReal.continuousAt)
    · fun_prop
  · filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
    exact (gammaKernel_norm z r ht).le

theorem gammaKernel_integral {z : ℂ} (hz : 0 < z.re) {r : ℝ} (hr : 0 < r) :
    (∫ t in Ioi (0 : ℝ), gammaKernel z r t) =
      (1 / (r : ℂ)) ^ z * Complex.Gamma z := by
  simpa only [gammaKernel, Complex.ofReal_exp, Complex.ofReal_neg, Complex.ofReal_mul] using
    Complex.integral_cpow_mul_exp_neg_mul_Ioi hz hr

theorem gammaKernel_integral_norm {z : ℂ} (hz : 0 < z.re) {r : ℝ} (hr : 0 < r) :
    (∫ t in Ioi (0 : ℝ), ‖gammaKernel z r t‖) =
      (1 / r) ^ z.re * Real.Gamma z.re := by
  rw [setIntegral_congr_fun measurableSet_Ioi (fun t ht => gammaKernel_norm z r ht)]
  exact Real.integral_rpow_mul_exp_neg_mul_Ioi hz hr

noncomputable def gammaDriverTerm (j : ℕ) (z : ℂ) (t : ℝ) : ℂ :=
  (driver (j + 1) : ℂ) * gammaKernel z (j + 1) t

theorem gammaDriverTerm_integrable (j : ℕ) {z : ℂ} (hz : 0 < z.re) :
    IntegrableOn (gammaDriverTerm j z) (Ioi 0) :=
  (gammaKernel_integrable hz (by positivity : 0 < (j : ℝ) + 1)).const_mul _

theorem gammaDriverTerm_integral_norm (j : ℕ) {z : ℂ} (hz : 0 < z.re) :
    (∫ t in Ioi (0 : ℝ), ‖gammaDriverTerm j z t‖) =
      |driver (j + 1)| / (j + 1 : ℝ) ^ z.re * Real.Gamma z.re := by
  simp only [gammaDriverTerm, norm_mul, Complex.norm_real, Real.norm_eq_abs]
  rw [integral_const_mul, gammaKernel_integral_norm hz (by positivity)]
  rw [one_div, Real.inv_rpow (by positivity), div_eq_mul_inv, mul_assoc]

theorem gammaDriverTerm_norm_summable {z : ℂ} (hz : (1 : ℝ) / 2 < z.re) :
    Summable (fun j : ℕ => ∫ t in Ioi (0 : ℝ), ‖gammaDriverTerm j z t‖) := by
  have h := (unshiftedDirichlet_summable hz).norm.mul_right (Real.Gamma z.re)
  apply h.congr
  intro j
  rw [gammaDriverTerm_integral_norm j (by linarith)]
  simp only [norm_div, Complex.norm_real, Real.norm_eq_abs]
  rw [show ((j + 1 : ℕ) : ℂ) = ((j + 1 : ℝ) : ℂ) by push_cast; rfl,
    Complex.norm_cpow_eq_rpow_re_of_pos (by positivity)]

theorem gammaDriverTerm_integral (j : ℕ) {z : ℂ} (hz : 0 < z.re) :
    (∫ t in Ioi (0 : ℝ), gammaDriverTerm j z t) =
      ((driver (j + 1) : ℂ) / ((j + 1 : ℕ) : ℂ) ^ z) * Complex.Gamma z := by
  simp only [gammaDriverTerm]
  rw [integral_const_mul, gammaKernel_integral hz (by positivity)]
  rw [one_div, Complex.inv_cpow _ _ (by
    rw [Complex.arg_ofReal_of_nonneg (by positivity)]; exact Real.pi_pos.ne)]
  simp only [Nat.cast_add, Nat.cast_one, Complex.ofReal_add, Complex.ofReal_natCast,
    Complex.ofReal_one, div_eq_mul_inv, mul_assoc]

theorem gammaDriverTerm_hasSum (z : ℂ) {t : ℝ} (ht : 0 < t) :
    HasSum (fun j : ℕ => gammaDriverTerm j z t)
      ((t : ℂ) ^ (z - 1) *
        ((generatingFunction (exp (-t)) - driver 0 : ℝ) : ℂ)) := by
  have he : |exp (-t)| < 1 := by
    rw [abs_of_pos (exp_pos _), exp_lt_one_iff]; linarith
  have h := (driver_series_summable he).hasSum
  have htail : HasSum (fun j : ℕ => driver (j + 1) * exp (-t) ^ (j + 1))
      (generatingFunction (exp (-t)) - driver 0) := by
    have hs := h.summable.sum_add_tsum_nat_add 1
    simp only [Finset.sum_range_one, pow_zero, mul_one] at hs
    have heq : (∑' j : ℕ, driver (j + 1) * exp (-t) ^ (j + 1)) =
        generatingFunction (exp (-t)) - driver 0 := by
      unfold generatingFunction
      linarith [hs]
    rw [← heq]
    exact (h.summable.comp_injective (add_left_injective 1)).hasSum
  have hc := (Complex.hasSum_ofReal.mpr htail).mul_left ((t : ℂ) ^ (z - 1))
  convert hc using 1
  ext j
  simp only [gammaDriverTerm, gammaKernel, Complex.ofReal_mul]
  have heq : exp (-t) ^ (j + 1) = exp (-((j + 1 : ℝ) * t)) := by
    rw [← exp_nat_mul]
    congr 1
    push_cast
    ring
  rw [heq]
  ring

theorem gammaDriver_integrable {z : ℂ} (hz : (1 : ℝ) / 2 < z.re) :
    IntegrableOn (fun t : ℝ => (t : ℂ) ^ (z - 1) *
      ((generatingFunction (exp (-t)) - driver 0 : ℝ) : ℂ)) (Ioi 0) := by
  constructor
  · apply ContinuousOn.aestronglyMeasurable _ measurableSet_Ioi
    apply continuousOn_of_forall_continuousAt
    intro t ht
    have he : |exp (-t)| < 1 := by
      rw [abs_of_pos (exp_pos _), exp_lt_one_iff]; exact neg_lt_zero.mpr ht
    exact ((continuousAt_cpow_const (Complex.ofReal_mem_slitPlane.mpr ht)).comp
      Complex.continuous_ofReal.continuousAt).mul
      (Complex.continuous_ofReal.continuousAt.comp
        (((generatingFunction_continuousAt he).comp
          (f := fun u : ℝ => exp (-u)) (x := t)
          (continuous_exp.comp continuous_neg).continuousAt).sub continuousAt_const))
  · rw [hasFiniteIntegral_iff_enorm]
    calc
      _ ≤ ∫⁻ t in Ioi (0 : ℝ), ∑' j : ℕ, ‖gammaDriverTerm j z t‖ₑ := by
        apply lintegral_mono_ae
        filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
        rw [← (gammaDriverTerm_hasSum z ht).tsum_eq]
        exact enorm_tsum_le_tsum_enorm
      _ = ∑' j : ℕ, ∫⁻ t in Ioi (0 : ℝ), ‖gammaDriverTerm j z t‖ₑ :=
        lintegral_tsum (fun j =>
          (gammaDriverTerm_integrable j (by linarith : 0 < z.re)).aestronglyMeasurable.enorm)
      _ = ENNReal.ofReal (∑' j : ℕ, ∫ t in Ioi (0 : ℝ), ‖gammaDriverTerm j z t‖) := by
        simp_rw [← ofReal_integral_norm_eq_lintegral_enorm
          (gammaDriverTerm_integrable _ (by linarith : 0 < z.re))]
        exact (ENNReal.ofReal_tsum_of_nonneg (fun j => integral_nonneg (fun t => norm_nonneg _))
          (gammaDriverTerm_norm_summable hz)).symm
      _ < ⊤ := ENNReal.ofReal_lt_top

/-- The literal Gamma–Mellin conversion, with the initial driver subtracted.
Absolute convergence is established on precisely the coefficient half-plane. -/
theorem gammaDriver_integral {z : ℂ} (hz : (1 : ℝ) / 2 < z.re) :
    (∫ t in Ioi (0 : ℝ), (t : ℂ) ^ (z - 1) *
      ((generatingFunction (exp (-t)) - driver 0 : ℝ) : ℂ)) =
      Complex.Gamma z * unshiftedDirichlet z := by
  calc
    _ = ∫ t in Ioi (0 : ℝ), ∑' j : ℕ, gammaDriverTerm j z t := by
      apply setIntegral_congr_fun measurableSet_Ioi
      intro t ht
      exact (gammaDriverTerm_hasSum z ht).tsum_eq.symm
    _ = ∑' j : ℕ, ∫ t in Ioi (0 : ℝ), gammaDriverTerm j z t :=
      (integral_tsum_of_summable_integral_norm
        (fun j => gammaDriverTerm_integrable j (by linarith))
        (gammaDriverTerm_norm_summable hz)).symm
    _ = Complex.Gamma z * unshiftedDirichlet z := by
      simp_rw [gammaDriverTerm_integral _ (by linarith : 0 < z.re)]
      rw [tsum_mul_right, mul_comm]
      rfl

/-- Compatibility with the original `(j+1)` Dirichlet convention. -/
theorem gammaDriver_integral_eq_shifted {z : ℂ} (hz : (1 : ℝ) / 2 < z.re) :
    (∫ t in Ioi (0 : ℝ), (t : ℂ) ^ (z - 1) *
      ((generatingFunction (exp (-t)) - driver 0 : ℝ) : ℂ)) =
      Complex.Gamma z * (dirichletTransform z - indexCorrection z) := by
  rw [gammaDriver_integral hz, indexCorrection_eq_difference hz]
  ring

end BuildingBlocks.SuccessorFeedback
