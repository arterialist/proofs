import BuildingBlocks.SuccessorFeedbackRootPrimitive
import Mathlib.MeasureTheory.Integral.IntervalIntegral.IntegrationByParts

/-! Identification of the cancellation kernel with the literal smooth Abel
kernel, by finite-interval integration by parts retaining both endpoints. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

private theorem smoothWeight_age_derivative {z : ℂ} (hz : 0 < z.re)
    {t : ℝ} (ht : 0 ≤ t) :
    HasDerivAt (fun u : ℝ => ((u + 1 : ℝ) : ℂ) ^ (-z)) (-smoothPowerCharge z t) t := by
  have hz0 : z ≠ 0 := by intro h; simp [h] at hz
  have h := (hasDerivAt_ofReal_cpow_const
    (show t + 1 ≠ 0 by linarith) (neg_ne_zero.mpr hz0)).scomp t ((hasDerivAt_id t).add_const 1)
  convert h using 1 <;> simp [smoothPowerCharge]

private theorem smoothRoot_age_derivative {y t : ℝ} (ht : t ≤ y - 1) :
    HasDerivAt (fun u : ℝ => ((2 * (sqrt (y - u) - 1) : ℝ) : ℂ))
      (-(1 / sqrt (y - t) : ℝ) : ℂ) t := by
  have h := ((((hasDerivAt_id t).const_sub y).sqrt
    (show y - t ≠ 0 by linarith)).sub_const 1).const_mul 2
  convert h.ofReal_comp using 1
  simp only [id_eq]
  push_cast
  field_simp
  <;> ring

theorem rootPrimitiveConvolution_eq_finite (f : ℝ → ℂ) (y : ℝ) :
    rootPrimitiveConvolution f y = ∫ t in Ioc (0 : ℝ) (y - 1),
      f t * ((2 * (sqrt (y - t) - 1) : ℝ) : ℂ) := by
  have he : (fun t : ℝ => f t * (causalRootPrimitive (y - t) : ℂ)) =
      (Iic (y - 1)).indicator (fun t => f t * ((2 * (sqrt (y - t) - 1) : ℝ) : ℂ)) := by
    funext t
    by_cases ht : t ≤ y - 1
    · rw [indicator_of_mem (show t ∈ Iic (y - 1) from ht), causalRootPrimitive_eq (by linarith)]
    · rw [indicator_of_notMem (show t ∉ Iic (y - 1) from ht), causalRootPrimitive_eq_zero (by linarith)]
      simp
  unfold rootPrimitiveConvolution
  rw [he, setIntegral_indicator measurableSet_Iic]
  congr 1

/-- Literal finite-interval identity. No Beta function or singular continuation
at z=1 is used. -/
theorem smoothAbelKernel_eq_rootPrimitive {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 ≤ y) :
    smoothAbelKernel z y = (causalRootPrimitive y : ℂ) -
      rootPrimitiveConvolution (smoothPowerCharge z) y := by
  have h0 : (0 : ℝ) ≤ y - 1 := by linarith
  let u := fun t : ℝ => ((t + 1 : ℝ) : ℂ) ^ (-z)
  let v := fun t : ℝ => ((2 * (sqrt (y - t) - 1) : ℝ) : ℂ)
  have hu : ∀ t ∈ uIcc (0 : ℝ) (y - 1), HasDerivAt u (-smoothPowerCharge z t) t := by
    intro t ht
    rw [uIcc_of_le h0] at ht
    exact smoothWeight_age_derivative hz ht.1
  have hv : ∀ t ∈ uIcc (0 : ℝ) (y - 1),
      HasDerivAt v (-(1 / sqrt (y - t) : ℝ) : ℂ) t := by
    intro t ht
    rw [uIcc_of_le h0] at ht
    exact smoothRoot_age_derivative ht.2
  have huc : ContinuousOn u (uIcc (0 : ℝ) (y - 1)) := fun t ht => (hu t ht).continuousAt.continuousWithinAt
  have hvc : ContinuousOn v (uIcc (0 : ℝ) (y - 1)) := fun t ht => (hv t ht).continuousAt.continuousWithinAt
  have hqi : IntervalIntegrable (smoothPowerCharge z) volume 0 (y - 1) := by
    rw [intervalIntegrable_iff_integrableOn_Ioc_of_le h0]
    exact (smoothPowerCharge_integrable hz).mono_set Ioc_subset_Ioi_self
  have hri : IntervalIntegrable (fun t : ℝ => (1 / sqrt (y - t) : ℝ)) volume 0 (y - 1) := by
    apply ContinuousOn.intervalIntegrable
    apply continuousOn_const.div (continuous_sqrt.comp (continuous_const.sub continuous_id)).continuousOn
    intro t ht
    rw [uIcc_of_le h0] at ht
    change sqrt (y - t) ≠ 0
    exact (sqrt_pos.mpr (by linarith [ht.2])).ne'
  have hric : IntervalIntegrable (fun t : ℝ => ((1 / sqrt (y - t) : ℝ) : ℂ)) volume 0 (y - 1) :=
    ⟨hri.1.ofReal, hri.2.ofReal⟩
  have h := intervalIntegral.integral_deriv_mul_eq_sub hu hv hqi.neg hric.neg
  have hqv := hqi.mul_continuousOn hvc
  have hur := hric.continuousOn_mul huc
  have he : (∫ t in (0 : ℝ)..(y - 1), (-smoothPowerCharge z t) * v t +
      u t * (-(1 / sqrt (y - t) : ℝ) : ℂ)) =
      -(∫ t in (0 : ℝ)..(y - 1), smoothPowerCharge z t * v t) -
        ∫ t in (0 : ℝ)..(y - 1), u t * (1 / sqrt (y - t) : ℝ) := by
    rw [show (fun t : ℝ => (-smoothPowerCharge z t) * v t +
      u t * (-(1 / sqrt (y - t) : ℝ) : ℂ)) =
      (fun t => -(smoothPowerCharge z t * v t) - u t * (1 / sqrt (y - t) : ℝ)) by
        funext t; push_cast; ring]
    have hh := intervalIntegral.integral_sub hqv.neg hur
    simp only [Pi.neg_apply] at hh
    rw [hh, intervalIntegral.integral_neg]
  rw [he] at h
  have hvend : v (y - 1) = 0 := by simp [v]
  have huinitial : u 0 = 1 := by simp [u]
  have hvinitial : v 0 = (causalRootPrimitive y : ℂ) := by
    simp [v, causalRootPrimitive_eq hy]
  rw [hvend, huinitial, hvinitial, mul_zero, one_mul, zero_sub] at h
  have hqeq : (∫ t in (0 : ℝ)..(y - 1), smoothPowerCharge z t * v t) =
      rootPrimitiveConvolution (smoothPowerCharge z) y := by
    rw [rootPrimitiveConvolution_eq_finite, intervalIntegral.integral_of_le h0]
  have hseq : (∫ t in (0 : ℝ)..(y - 1), u t * (1 / sqrt (y - t) : ℝ)) =
      smoothAbelKernel z y := by
    rw [intervalIntegral.integral_of_le h0, smoothAbelKernel, integral_Icc_eq_integral_Ioc]
    apply setIntegral_congr_fun measurableSet_Ioc
    intro t ht
    simp only [u, smoothAbelIntegrand, one_div_sqrt_eq_rpow (by linarith [ht.2] : 0 ≤ y - t)]
  rw [hqeq, hseq] at h
  linear_combination -h

theorem smoothAbelKernel_hasDerivAt {z : ℂ} (hz : 0 < z.re) {y : ℝ} (hy : 1 < y) :
    HasDerivAt (smoothAbelKernel z) (smoothRootDerivative z y) y := by
  have h := ((causalRootPrimitive_hasDerivAt hy.ne').ofReal_comp).sub
    (rootPrimitiveConvolution_hasDerivAt (smoothPowerCharge_integrable hz) y)
  apply h.congr_of_eventuallyEq
  filter_upwards [eventually_gt_nhds hy] with x hx
  exact smoothAbelKernel_eq_rootPrimitive hz hx.le

end BuildingBlocks.SuccessorFeedback
