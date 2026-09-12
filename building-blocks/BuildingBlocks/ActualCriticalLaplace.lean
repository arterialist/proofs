import BuildingBlocks.ActualCriticalMeasure
import BuildingBlocks.LaplaceMomentDerivatives
import Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap

open MeasureTheory Set
open scoped ENNReal

namespace BuildingBlocks.ActualCriticalLaplace

open ActualCriticalMeasure MellinCompactCorrection

/-- The density is its actual, unclipped real expression under the explicit sign. -/
theorem tailDensity_toReal {A : ℝ}
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {x : ℝ} (hx : 0 ≤ x) :
    (tailDensity A x).toReal = x^(-2 : ℝ) * (negativeWTail A x).re := by
  unfold tailDensity
  exact ENNReal.toReal_ofReal (mul_nonneg (Real.rpow_nonneg hx _) (negativeWTail_re_nonneg hsign x))

/-- The exact x^(-2) normalization changes the Laplace exponential into the
Mellin exponent -s-2. -/
theorem density_smul_exp {A : ℝ}
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {x : ℝ} (hx : 1 < x) (s : ℂ) :
    (tailDensity A x).toReal • Complex.exp (-s * (time x : ℂ)) =
      (x : ℂ)^(-s-2) * negativeWTail A x := by
  have hx0 : 0 < x := lt_trans zero_lt_one hx
  have hn : (x : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hx0.ne'
  have ht : ((negativeWTail A x).re : ℂ) = negativeWTail A x := by
    apply Complex.ext <;> simp [negativeWTail_im]
  have he : Complex.exp (-s * (Real.log x : ℂ)) = (x : ℂ)^(-s) := by
    rw [Complex.cpow_def_of_ne_zero hn, ← Complex.ofReal_log hx0.le]
    congr 1
    ring
  rw [tailDensity_toReal hsign hx0.le, time_eq_log hx, he]
  simp only [Complex.real_smul, Complex.ofReal_mul]
  rw [ht, Complex.ofReal_cpow hx0.le]
  norm_num only [Complex.ofReal_neg, Complex.ofReal_ofNat]
  rw [show (x : ℂ)^(-2 : ℂ) * negativeWTail A x * (x : ℂ)^(-s) =
      ((x : ℂ)^(-2 : ℂ) * (x : ℂ)^(-s)) * negativeWTail A x by ring,
    ← Complex.cpow_add _ _ hn]
  congr 2
  ring

/-- This equality is an equality of the actual integrals, not continuation.
The eventual sign is needed to identify the positive density with the tail. -/
theorem moment_eq_mellin_negativeWTail {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) (s : ℂ) :
    LaplaceMomentDerivatives.moment (tailMeasure A) time 0 s =
      mellin (negativeWTail A) (-s-1) := by
  unfold LaplaceMomentDerivatives.moment LaplaceMomentDerivatives.integrand tailMeasure
  simp only [pow_zero, one_mul]
  rw [integral_withDensity_eq_integral_toReal_smul (measurable_tailDensity A)
    (Filter.Eventually.of_forall (fun x => ENNReal.ofReal_lt_top))]
  have he : (∫ x : ℝ in Ioi 1,
      (tailDensity A x).toReal • Complex.exp (-s * (time x : ℂ))) =
      ∫ x : ℝ in Ioi 1, (x : ℂ)^(-s-2) * negativeWTail A x := by
    apply setIntegral_congr_fun measurableSet_Ioi
    intro x hx
    exact density_smul_exp hsign hx s
  rw [he]
  unfold mellin
  simp only [smul_eq_mul, show (-s-1)-1 = -s-2 by ring]
  symm
  apply setIntegral_eq_of_subset_of_forall_diff_eq_zero measurableSet_Ioi
    (Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))
  intro x hx
  have hxA : ¬ A < x := by have := hx.2; simp only [mem_Ioi, not_lt] at this; linarith
  simp [negativeWTail, tailPart, hxA]

/-- Actual positive-measure Laplace transform on the established absolute
convergence half-plane, with the full compact initial correction retained. -/
theorem moment_eq_initial_sub_filledTransform {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {s : ℂ} (hs : 1 < s.re) :
    LaplaceMomentDerivatives.moment (tailMeasure A) time 0 s =
      mellin (initialPart ActualCriticalMellin.W A) (-s-1) -
        CriticalTransformPoles.filledTransform s := by
  rw [moment_eq_mellin_negativeWTail hA hsign]
  exact (hasMellin_negativeWTail hA hs).2

end BuildingBlocks.ActualCriticalLaplace
