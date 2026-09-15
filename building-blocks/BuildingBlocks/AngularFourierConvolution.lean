import Mathlib.Analysis.Convolution
import Mathlib.Analysis.Fourier.FourierTransform
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace

open MeasureTheory

namespace BuildingBlocks.AngularFourierConvolution

noncomputable def phase (ξ x : ℝ) : ℂ := Complex.exp (-Complex.I * (ξ : ℂ) * (x : ℂ))

noncomputable def transform (f : ℝ → ℂ) (ξ : ℝ) : ℂ := ∫ x : ℝ, phase ξ x * f x

theorem phase_add (ξ x y : ℝ) : phase ξ (x + y) = phase ξ x * phase ξ y := by
  unfold phase
  rw [← Complex.exp_add]
  congr 1
  push_cast
  ring

theorem translated_integral (g : ℝ → ℂ) (ξ v : ℝ) :
    (∫ h : ℝ, phase ξ h * g (h - v)) = phase ξ v * transform g ξ := by
  calc
    _ = ∫ h : ℝ, phase ξ (h + v) * g h := by
      simpa only [sub_add_cancel] using
        integral_sub_right_eq_self (fun h : ℝ => phase ξ (h + v) * g h) v
    _ = _ := by
      simp_rw [phase_add, mul_comm (phase ξ _ ) (phase ξ v), mul_assoc]
      rw [integral_const_mul]
      rfl

/-- The full L¹ convolution theorem in angular-frequency convention. -/
theorem transform_convolution {f g : ℝ → ℂ} (hf : Integrable f) (hg : Integrable g)
    (ξ : ℝ) :
    transform (convolution f g (ContinuousLinearMap.mul ℂ ℂ) volume) ξ =
      transform f ξ * transform g ξ := by
  have hi := hf.convolution_integrand (ContinuousLinearMap.mul ℂ ℂ) hg
  have hw : Integrable (fun p : ℝ × ℝ =>
      phase ξ p.1 * (f p.2 * g (p.1 - p.2))) (volume.prod volume) := by
    apply hi.bdd_mul
    · exact (by unfold phase; fun_prop : Continuous (fun p : ℝ × ℝ => phase ξ p.1)).aestronglyMeasurable
    · exact ⟨1, fun p => by simp [phase, Complex.norm_exp, Complex.mul_re, Complex.mul_im]⟩
  calc
    _ = ∫ h : ℝ, ∫ v : ℝ, phase ξ h * (f v * g (h - v)) := by
      unfold transform
      simp only [convolution_def, ContinuousLinearMap.mul_apply', integral_const_mul]
    _ = ∫ v : ℝ, ∫ h : ℝ, phase ξ h * (f v * g (h - v)) :=
      integral_integral_swap hw
    _ = ∫ v : ℝ, (phase ξ v * f v) * transform g ξ := by
      congr 1
      funext v
      calc
        _ = f v * ∫ h : ℝ, phase ξ h * g (h - v) := by
          rw [← integral_const_mul]
          apply integral_congr_ae
          exact Filter.Eventually.of_forall (fun h => by ring)
        _ = _ := by rw [translated_integral]; ring
    _ = _ := integral_mul_const _ _

theorem phase_reflect (ξ x : ℝ) : phase ξ (-x) = phase (-ξ) x := by
  unfold phase
  congr 1
  push_cast
  ring

theorem transform_reflect (f : ℝ → ℂ) (ξ : ℝ) :
    transform (fun x : ℝ => f (-x)) ξ = transform f (-ξ) := by
  calc
    _ = ∫ x : ℝ, phase ξ (-x) * f x := by
      simpa using (Measure.integral_comp_mul_left
        (fun x : ℝ => phase ξ x * f (-x)) (-1)).symm
    _ = _ := by simp_rw [phase_reflect]; rfl

theorem phase_conj (ξ x : ℝ) : starRingEnd ℂ (phase ξ x) = phase (-ξ) x := by
  unfold phase
  rw [← Complex.exp_conj]
  congr 1
  simp only [map_mul, map_neg, Complex.conj_I, Complex.conj_ofReal, Complex.ofReal_neg]
  ring

theorem transform_real_conj (f : ℝ → ℝ) (ξ : ℝ) :
    transform (fun x : ℝ => (f x : ℂ)) (-ξ) =
      starRingEnd ℂ (transform (fun x : ℝ => (f x : ℂ)) ξ) := by
  unfold transform
  rw [← integral_conj]
  apply integral_congr_ae
  exact Filter.Eventually.of_forall (fun x => by
    simp only [map_mul, Complex.conj_ofReal, phase_conj])

open scoped FourierTransform

theorem transform_eq_mathlib (f : ℝ → ℂ) (ξ : ℝ) :
    transform f ξ = 𝓕 f (ξ / (2 * Real.pi)) := by
  rw [Real.fourierIntegral_real_eq_integral_exp_smul]
  apply integral_congr_ae
  filter_upwards [] with v
  simp only [smul_eq_mul]
  congr 1
  unfold phase
  congr 1
  push_cast
  have hp : (Real.pi : ℂ) ≠ 0 := by exact_mod_cast Real.pi_ne_zero
  field_simp

#print axioms translated_integral
#print axioms transform_convolution
#print axioms transform_reflect
#print axioms transform_real_conj
#print axioms transform_eq_mathlib

end BuildingBlocks.AngularFourierConvolution
