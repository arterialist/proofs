import BuildingBlocks.SuccessorFeedbackFloorAgeDerivative
import Mathlib.Analysis.Convolution

/-! The literal floor-error age derivative as an L¹ convolution. Its complete
kernel has norm one and mass minus one, retaining the endpoint cancellation. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorFeedback

theorem clippedRootDerivative_eq_indicator : clippedRootDerivative =
    (Ioi (1 : ℝ)).indicator (fun x => -(1 / 2 : ℝ) * x ^ (-(3 / 2 : ℝ))) := by
  funext x
  simp [clippedRootDerivative, indicator_apply]

theorem clippedRootDerivative_integrable : Integrable clippedRootDerivative := by
  have h : IntegrableOn (fun x : ℝ => -(1 / 2 : ℝ) * x ^ (-(3 / 2 : ℝ))) (Ioi 1) :=
    (integrableOn_Ioi_rpow_of_lt (by norm_num : -(3 / 2 : ℝ) < -1)
      (by norm_num : (0 : ℝ) < 1)).const_mul _
  rw [clippedRootDerivative_eq_indicator]
  exact h.integrable_indicator measurableSet_Ioi

theorem clippedRootDerivative_integral : (∫ x : ℝ, clippedRootDerivative x) = -1 := by
  rw [clippedRootDerivative_eq_indicator, integral_indicator measurableSet_Ioi,
    integral_const_mul, integral_Ioi_rpow_of_lt (by norm_num) (by norm_num : (0 : ℝ) < 1)]
  norm_num

theorem clippedRootDerivative_integral_norm : (∫ x : ℝ, |clippedRootDerivative x|) = 1 := by
  have he : (fun x => |clippedRootDerivative x|) = (fun x => -clippedRootDerivative x) := by
    funext x
    apply abs_of_nonpos
    unfold clippedRootDerivative
    split_ifs with hx
    · exact mul_nonpos_of_nonpos_of_nonneg (by norm_num) (rpow_nonneg (by linarith) _)
    · exact le_rfl
  rw [he, integral_neg, clippedRootDerivative_integral]
  norm_num

noncomputable def floorErrorExtension (z : ℂ) : ℝ → ℂ :=
  (Ioi (0 : ℝ)).indicator (floorWeightError z)

theorem floorErrorExtension_integrable {z : ℂ} (hz : 0 < z.re) :
    Integrable (floorErrorExtension z) :=
  (floorWeightError_integrable hz).integrable_indicator measurableSet_Ioi

noncomputable def floorAgeError (z : ℂ) (y : ℝ) : ℂ :=
  floorErrorExtension z (y - 1) +
    ∫ t : ℝ, floorErrorExtension z t * (clippedRootDerivative (y - t) : ℂ)

private theorem rootDerivative_complex_integrable :
    Integrable (fun x : ℝ => (clippedRootDerivative x : ℂ)) :=
  clippedRootDerivative_integrable.ofReal

theorem floorAgeError_integrable {z : ℂ} (hz : 0 < z.re) : Integrable (floorAgeError z) := by
  have hf := floorErrorExtension_integrable hz
  have hc := hf.integrable_convolution (L := ContinuousLinearMap.mul ℂ ℂ)
    rootDerivative_complex_integrable
  exact (hf.comp_sub_right 1).add hc

theorem floorAgeError_eq {z : ℂ} {y : ℝ} (hy : 1 < y) :
    floorAgeError z y = floorWeightError z (y - 1) - (1 / 2 : ℂ) *
      ∫ t in Ioo (0 : ℝ) (y - 1), floorWeightError z t *
        ((y - t) ^ (-(3 / 2 : ℝ)) : ℝ) := by
  have he : (fun t : ℝ => floorErrorExtension z t * (clippedRootDerivative (y - t) : ℂ)) =
      (Ioi (0 : ℝ)).indicator (fun t => floorWeightError z t *
        (clippedRootDerivative (y - t) : ℂ)) := by
    funext t
    by_cases ht : t ∈ Ioi (0 : ℝ) <;> simp [floorErrorExtension, ht]
  have hp : floorErrorExtension z (y - 1) = floorWeightError z (y - 1) := by
    exact indicator_of_mem (show y - 1 ∈ Ioi (0 : ℝ) from sub_pos.mpr hy) _
  rw [floorAgeError, hp, he, integral_indicator measurableSet_Ioi,
    clippedConvolution_derivative_eq_finite]
  ring

theorem floorAgeError_integral {z : ℂ} (hz : 0 < z.re) :
    (∫ y : ℝ, floorAgeError z y) = 0 := by
  have hf := floorErrorExtension_integrable hz
  have hc := hf.integrable_convolution (L := ContinuousLinearMap.mul ℂ ℂ)
    rootDerivative_complex_integrable
  change Integrable (fun y : ℝ => ∫ t : ℝ,
    floorErrorExtension z t * (clippedRootDerivative (y - t) : ℂ)) at hc
  have hi := integral_convolution (ContinuousLinearMap.mul ℂ ℂ) hf rootDerivative_complex_integrable
  change (∫ y : ℝ, ∫ t : ℝ, floorErrorExtension z t * (clippedRootDerivative (y - t) : ℂ)) =
    (∫ t : ℝ, floorErrorExtension z t) * ∫ y : ℝ, (clippedRootDerivative y : ℂ) at hi
  have hk : (∫ y : ℝ, (clippedRootDerivative y : ℂ)) = -1 := by
    rw [integral_complex_ofReal, clippedRootDerivative_integral]
    norm_num
  simp only [floorAgeError]
  rw [integral_add (hf.comp_sub_right 1) hc,
    integral_sub_right_eq_self, hi, hk]
  ring

private theorem rootDerivative_convolution_norm_bound {f : ℝ → ℂ} (hf : Integrable f) :
    (∫ y : ℝ, ‖∫ t : ℝ, f t * (clippedRootDerivative (y - t) : ℂ)‖) ≤
      ∫ t : ℝ, ‖f t‖ := by
  have hc := hf.integrable_convolution (L := ContinuousLinearMap.mul ℂ ℂ)
    rootDerivative_complex_integrable
  have hr := hf.norm.integrable_convolution (L := ContinuousLinearMap.mul ℝ ℝ)
    clippedRootDerivative_integrable.norm
  have hi := integral_convolution (ContinuousLinearMap.mul ℝ ℝ) hf.norm
    clippedRootDerivative_integrable.norm
  change (∫ y : ℝ, ∫ t : ℝ, ‖f t‖ * ‖clippedRootDerivative (y - t)‖) =
    (∫ t : ℝ, ‖f t‖) * ∫ y : ℝ, ‖clippedRootDerivative y‖ at hi
  simp only [Real.norm_eq_abs, clippedRootDerivative_integral_norm, mul_one] at hi
  calc
    _ ≤ ∫ y : ℝ, ∫ t : ℝ, ‖f t‖ * |clippedRootDerivative (y - t)| := by
      apply integral_mono_ae hc.norm hr
      filter_upwards with y
      simpa only [norm_mul, Complex.norm_real, Real.norm_eq_abs] using
        (norm_integral_le_integral_norm (fun t : ℝ => f t * (clippedRootDerivative (y - t) : ℂ)))
    _ = _ := hi

/-- The total L¹ cost is at most twice the literal discretization error.
This bound uses the complete tail kernel, rather than a finite age cutoff. -/
theorem floorAgeError_norm_bound {z : ℂ} (hz : 0 < z.re) :
    (∫ y : ℝ, ‖floorAgeError z y‖) ≤
      2 * ∫ t in Ioi (0 : ℝ), ‖floorWeightError z t‖ := by
  have hf := floorErrorExtension_integrable hz
  have hc := hf.integrable_convolution (L := ContinuousLinearMap.mul ℂ ℂ)
    rootDerivative_complex_integrable
  change Integrable (fun y : ℝ => ∫ t : ℝ,
    floorErrorExtension z t * (clippedRootDerivative (y - t) : ℂ)) at hc
  have hh := integral_mono_ae (floorAgeError_integrable hz).norm
    ((hf.comp_sub_right 1).norm.add hc.norm)
    (Eventually.of_forall (fun y => norm_add_le
      (floorErrorExtension z (y - 1))
      (∫ t : ℝ, floorErrorExtension z t * (clippedRootDerivative (y - t) : ℂ))))
  have he : (∫ y : ℝ, ‖floorErrorExtension z y‖) =
      ∫ y in Ioi (0 : ℝ), ‖floorWeightError z y‖ := by
    simp only [floorErrorExtension, norm_indicator_eq_indicator_norm]
    exact integral_indicator measurableSet_Ioi
  have hconv := rootDerivative_convolution_norm_bound hf
  simp only [Pi.add_apply] at hh
  have hs : (∫ a : ℝ, ‖floorErrorExtension z (a - 1)‖) =
      ∫ a : ℝ, ‖floorErrorExtension z a‖ :=
    integral_sub_right_eq_self (fun a : ℝ => ‖floorErrorExtension z a‖) 1
  rw [integral_add (hf.comp_sub_right 1).norm hc.norm, hs] at hh
  rw [← he]
  linarith

theorem floorAbelError_hasDerivAt_floorAgeError_ae {z : ℂ} (hz : 0 < z.re) :
    ∀ᵐ y : ℝ ∂volume.restrict (Ioi 1),
      HasDerivAt (fun u => floorAbelKernel z u - smoothAbelKernel z u) (floorAgeError z y) y := by
  filter_upwards [floorAbelError_hasDerivAt_ae hz, ae_restrict_mem measurableSet_Ioi] with y hd hy
  rwa [floorAgeError_eq hy]

end BuildingBlocks.SuccessorFeedback
