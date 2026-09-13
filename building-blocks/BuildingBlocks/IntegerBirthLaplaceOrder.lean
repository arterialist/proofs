import BuildingBlocks.IntegerBirthSourceBound
import Mathlib.Analysis.SpecialFunctions.Gaussian.GaussianIntegral
import Mathlib.MeasureTheory.Integral.DominatedConvergence
import Mathlib.MeasureTheory.Function.Floor

open MeasureTheory Set
open scoped BigOperators

namespace BuildingBlocks.IntegerBirthLaplaceOrder

open IntegerBirthKernel IntegerBirthSourceBound

private noncomputable abbrev μ : Measure ℝ := volume.restrict (Ioi (0 : ℝ))

/-- The actual kernels are measurable, including both explicit branch values. -/
theorem U_measurable (n : ℕ) : Measurable (U n) := by
  unfold U q
  apply Measurable.sub_const
  apply Measurable.ite (measurableSet_singleton 0) measurable_const
  exact Measurable.ite measurableSet_Iic (by fun_prop) (by fun_prop)

theorem interpolant_measurable (n : ℕ) : Measurable (interpolant n) := by
  have hf : Measurable (fun u : ℝ => (⌊u⌋₊ : ℝ)) :=
    (measurable_from_nat : Measurable (fun j : ℕ => (j : ℝ))).comp Nat.measurable_floor
  unfold interpolant
  exact (((hf.add_const 1).sub measurable_id).mul ((U_measurable n).comp hf)).add
    ((measurable_id.sub hf).mul ((U_measurable n).comp (hf.add_const 1)))

private theorem moment_integrable {t : ℝ} (ht : 0 < t) :
    Integrable (fun u : ℝ => Real.exp (-t*u)*u) μ := by
  have hh := integrableOn_rpow_mul_exp_neg_mul_rpow (p := 1) (s := 1)
    (by norm_num) (by norm_num) ht
  simpa only [Real.rpow_one, mul_comm] using hh

private theorem dominated_integrable {t : ℝ} (ht : 0 < t) (n : ℕ) {F : ℝ → ℝ}
    (hF : Measurable F) (hbound : ∀ u, 0 ≤ u → ‖F u‖ ≤ (boundConstant*u)*birthWeight n) :
    Integrable (fun u => Real.exp (-t*u)*F u) μ := by
  apply ((moment_integrable ht).const_mul (boundConstant*birthWeight n)).mono'
    ((by fun_prop : Measurable (fun u => Real.exp (-t*u)*F u)).aestronglyMeasurable)
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with u hu
  rw [norm_mul, Real.norm_eq_abs, abs_of_pos (Real.exp_pos _)]
  have hh := mul_le_mul_of_nonneg_left (hbound u hu.le) (Real.exp_pos (-t*u)).le
  convert hh using 1 <;> ring

private theorem dominated_integral_norm_bound {t : ℝ} (ht : 0 < t) (n : ℕ) {F : ℝ → ℝ}
    (hF : Measurable F) (hbound : ∀ u, 0 ≤ u → ‖F u‖ ≤ (boundConstant*u)*birthWeight n) :
    (∫ u, ‖Real.exp (-t*u)*F u‖ ∂μ) ≤
      birthWeight n*(boundConstant*(∫ u : ℝ, Real.exp (-t*u)*u ∂μ)) := by
  have hi := dominated_integrable ht n hF hbound
  have hm := (moment_integrable ht).const_mul (boundConstant*birthWeight n)
  have hh : (∫ u, ‖Real.exp (-t*u)*F u‖ ∂μ) ≤
      ∫ u : ℝ, (boundConstant*birthWeight n)*(Real.exp (-t*u)*u) ∂μ := by
    apply integral_mono_ae hi.norm hm
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with u hu
    rw [norm_mul, Real.norm_eq_abs, abs_of_pos (Real.exp_pos _)]
    have hk := mul_le_mul_of_nonneg_left (hbound u hu.le) (Real.exp_pos (-t*u)).le
    convert hk using 1 <;> ring
  rw [integral_const_mul] at hh
  convert hh using 1 <;> ring

noncomputable def laplaceSource (t : ℝ) (n : ℕ) (u : ℝ) : ℝ := Real.exp (-t*u)*sourceTerm n u
noncomputable def laplaceInterpolated (t : ℝ) (n : ℕ) (u : ℝ) : ℝ := Real.exp (-t*u)*interpolatedTerm n u

theorem laplaceSource_integrable {t : ℝ} (ht : 0 < t) (n : ℕ) : Integrable (laplaceSource t n) μ :=
  dominated_integrable ht n ((U_measurable (n+2)).const_mul _) (fun _ hu => sourceTerm_bound n hu)

theorem laplaceInterpolated_integrable {t : ℝ} (ht : 0 < t) (n : ℕ) : Integrable (laplaceInterpolated t n) μ :=
  dominated_integrable ht n ((interpolant_measurable (n+2)).const_mul _) (fun _ hu => interpolatedTerm_bound n hu)

/-- All complete birth integrals are absolutely summable at every actual positive t. -/
theorem laplaceSource_integral_norm_summable {t : ℝ} (ht : 0 < t) :
    Summable (fun n => ∫ u, ‖laplaceSource t n u‖ ∂μ) := by
  apply (summable_birthWeight.mul_right (boundConstant*(∫ u : ℝ, Real.exp (-t*u)*u ∂μ))).of_nonneg_of_le
    (fun n => integral_nonneg (fun u => norm_nonneg _))
  intro n
  exact dominated_integral_norm_bound ht n ((U_measurable (n+2)).const_mul _) (fun _ hu => sourceTerm_bound n hu)

theorem laplaceInterpolated_integral_norm_summable {t : ℝ} (ht : 0 < t) :
    Summable (fun n => ∫ u, ‖laplaceInterpolated t n u‖ ∂μ) := by
  apply (summable_birthWeight.mul_right (boundConstant*(∫ u : ℝ, Real.exp (-t*u)*u ∂μ))).of_nonneg_of_le
    (fun n => integral_nonneg (fun u => norm_nonneg _))
  intro n
  exact dominated_integral_norm_bound ht n ((interpolant_measurable (n+2)).const_mul _) (fun _ hu => interpolatedTerm_bound n hu)

/-- Both actual countable integral exchanges are justified by the preceding absolute bounds. -/
theorem actual_laplace_exchanges {t : ℝ} (ht : 0 < t) :
    (∑' n, ∫ u, laplaceSource t n u ∂μ) = (∫ u, ∑' n, laplaceSource t n u ∂μ) ∧
    (∑' n, ∫ u, laplaceInterpolated t n u ∂μ) = (∫ u, ∑' n, laplaceInterpolated t n u ∂μ) :=
  ⟨integral_tsum_of_summable_integral_norm (laplaceSource_integrable ht) (laplaceSource_integral_norm_summable ht),
   integral_tsum_of_summable_integral_norm (laplaceInterpolated_integrable ht) (laplaceInterpolated_integral_norm_summable ht)⟩

/-- Full actual Lambda-weighted Laplace interpolation inequality, with all sums defined absolutely. -/
theorem actual_laplace_interpolation_le {t : ℝ} (ht : 0 < t) :
    (∑' n, ∫ u, laplaceSource t n u ∂μ) ≤ ∑' n, ∫ u, laplaceInterpolated t n u ∂μ := by
  have hS := (hasSum_integral_of_summable_integral_norm (laplaceSource_integrable ht)
    (laplaceSource_integral_norm_summable ht)).summable
  have hI := (hasSum_integral_of_summable_integral_norm (laplaceInterpolated_integrable ht)
    (laplaceInterpolated_integral_norm_summable ht)).summable
  apply hS.tsum_le_tsum _ hI
  intro n
  apply integral_mono_ae (laplaceSource_integrable ht n) (laplaceInterpolated_integrable ht n)
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with u hu
  exact mul_le_mul_of_nonneg_left
    (mul_le_mul_of_nonneg_left
      (sub_nonneg.mp (interpolation_nonnegative (by omega : 2 ≤ n+2) hu.le))
      ArithmeticFunction.vonMangoldt_nonneg) (Real.exp_pos _).le

/-- The integral defect retains the actual nonnegative complete-history integrand. -/
theorem actual_laplace_defect {t : ℝ} (ht : 0 < t) :
    (∑' n, ∫ u, laplaceInterpolated t n u ∂μ) - (∑' n, ∫ u, laplaceSource t n u ∂μ) =
      ∑' n, ∫ u, Real.exp (-t*u)*ArithmeticFunction.vonMangoldt (n+2)*
        (interpolant (n+2) u-U (n+2) u) ∂μ := by
  have hS := (hasSum_integral_of_summable_integral_norm (laplaceSource_integrable ht)
    (laplaceSource_integral_norm_summable ht)).summable
  have hI := (hasSum_integral_of_summable_integral_norm (laplaceInterpolated_integrable ht)
    (laplaceInterpolated_integral_norm_summable ht)).summable
  rw [← hI.tsum_sub hS]
  apply tsum_congr
  intro n
  rw [← integral_sub (laplaceInterpolated_integrable ht n) (laplaceSource_integrable ht n)]
  apply integral_congr_ae
  filter_upwards [] with u
  unfold laplaceInterpolated laplaceSource interpolatedTerm sourceTerm
  ring

#print axioms laplaceSource_integral_norm_summable
#print axioms actual_laplace_exchanges
#print axioms actual_laplace_interpolation_le
#print axioms actual_laplace_defect

end BuildingBlocks.IntegerBirthLaplaceOrder
