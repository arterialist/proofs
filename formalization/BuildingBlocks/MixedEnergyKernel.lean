import BuildingBlocks.MixedEnergyBilinear
import Mathlib.MeasureTheory.Function.LpSeminorm.Prod
import Mathlib.MeasureTheory.Group.Prod
import Mathlib.MeasureTheory.Group.Integral

/-! The symmetric translation-kernel identity on the actual L² domain. -/

open MeasureTheory Real Set
open scoped ENNReal

namespace BuildingBlocks.MixedEnergy

theorem lag_lift_memLp {H : ℝ → ℝ} (hH : MemLp H 2 volume) :
    MemLp (fun z : ℝ × ℝ => H z.2) 2 gradientMeasure := hH.comp_snd lagMeasure

theorem lag_backward_memLp {H : ℝ → ℝ} (hH : MemLp H 2 volume) :
    MemLp (fun z : ℝ × ℝ => H (z.2 - z.1)) 2 gradientMeasure := by
  simpa only [Function.comp_def, sub_eq_add_neg, add_comm] using
    (lag_lift_memLp hH).comp_measurePreserving
      (measurePreserving_prod_neg_add lagMeasure volume)

theorem lag_forward_memLp {H : ℝ → ℝ} (hH : MemLp H 2 volume) :
    MemLp (fun z : ℝ × ℝ => H (z.2 + z.1)) 2 gradientMeasure := by
  simpa only [Function.comp_def, add_comm] using
    (lag_lift_memLp hH).comp_measurePreserving
      (measurePreserving_prod_add lagMeasure volume)

theorem gradient_memLp_of_memLp {H : ℝ → ℝ} (hH : MemLp H 2 volume) :
    MemLp (gradient H) 2 gradientMeasure := (lag_lift_memLp hH).sub (lag_backward_memLp hH)

theorem energy_lt_top_of_memLp {H : ℝ → ℝ} (hm : Measurable H)
    (hH : MemLp H 2 volume) : energy H < ∞ := by
  have hi := (gradient_memLp_of_memLp hH).integrable_sq.hasFiniteIntegral
  rw [hasFiniteIntegral_iff_ofReal (Filter.Eventually.of_forall
    (fun z => sq_nonneg (gradient H z))), ← energy_eq_gradient hm] at hi
  exact hi

/-- Both additive orientations are integrated with their original lag weights. -/
noncomputable def symmetricKernelPair (H G : ℝ → ℝ) : ℝ :=
  ∫ z, H z.2 * (G (z.2 - z.1) + G (z.2 + z.1)) ∂gradientMeasure

theorem symmetricKernelPair_integrable {H G : ℝ → ℝ}
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume) :
    Integrable (fun z : ℝ × ℝ => H z.2 * (G (z.2 - z.1) + G (z.2 + z.1)))
      gradientMeasure :=
  (lag_lift_memLp hH).integrable_mul ((lag_backward_memLp hG).add (lag_forward_memLp hG))

theorem lag_pair_integral {H G : ℝ → ℝ}
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume) :
    (∫ z : ℝ × ℝ, H z.2 * G z.2 ∂gradientMeasure) = 2 * ∫ x, H x * G x := by
  rw [gradientMeasure, integral_prod (fun z : ℝ × ℝ => H z.2 * G z.2) ((hH.integrable_mul hG).comp_snd lagMeasure)]
  simp only [integral_const, Measure.real, lagMeasure_mass, ENNReal.toReal_ofNat, smul_eq_mul]

theorem lag_shifted_pair_integral {H G : ℝ → ℝ}
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume) :
    (∫ z : ℝ × ℝ, H (z.2 - z.1) * G (z.2 - z.1) ∂gradientMeasure) =
      2 * ∫ x, H x * G x := by
  rw [gradientMeasure, integral_prod (fun z : ℝ × ℝ => H (z.2 - z.1) * G (z.2 - z.1)) ((lag_backward_memLp hH).integrable_mul
    (lag_backward_memLp hG))]
  simp_rw [show ∀ h : ℝ, (∫ x, H (x - h) * G (x - h)) = ∫ x, H x * G x from
    fun h => integral_sub_right_eq_self (fun x => H x * G x) h]
  simp only [integral_const, Measure.real, lagMeasure_mass, ENNReal.toReal_ofNat, smul_eq_mul]

theorem lag_cross_orientation {H G : ℝ → ℝ}
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume) :
    (∫ z : ℝ × ℝ, H (z.2 - z.1) * G z.2 ∂gradientMeasure) =
      ∫ z : ℝ × ℝ, H z.2 * G (z.2 + z.1) ∂gradientMeasure := by
  rw [gradientMeasure, integral_prod (fun z : ℝ × ℝ => H (z.2 - z.1) * G z.2) ((lag_backward_memLp hH).integrable_mul
    (lag_lift_memLp hG)), integral_prod (fun z : ℝ × ℝ => H z.2 * G (z.2 + z.1)) ((lag_lift_memLp hH).integrable_mul
    (lag_forward_memLp hG))]
  apply integral_congr_ae
  exact Filter.Eventually.of_forall (fun h => by
    simpa only [sub_add_cancel] using
      integral_sub_right_eq_self (fun x => H x * G (x + h)) h)

/-- Expansion of the literal mixed gradient form gives the original factor 4
and the symmetric full-lag kernel, with no sign assumption. -/
theorem bilinear_eq_symmetricKernelPair {H G : ℝ → ℝ}
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume) :
    bilinear H G = 4 * (∫ x, H x * G x) - symmetricKernelPair H G := by
  have hA := (lag_lift_memLp hH).integrable_mul (lag_lift_memLp hG)
  have hB := (lag_lift_memLp hH).integrable_mul (lag_backward_memLp hG)
  have hC := (lag_backward_memLp hH).integrable_mul (lag_lift_memLp hG)
  have hD := (lag_backward_memLp hH).integrable_mul (lag_backward_memLp hG)
  have hF := (lag_lift_memLp hH).integrable_mul (lag_forward_memLp hG)
  simp only [Pi.mul_def] at hA hB hC hD hF
  have hexp : bilinear H G =
      ((∫ z : ℝ × ℝ, H z.2 * G z.2 ∂gradientMeasure) +
        ∫ z : ℝ × ℝ, H (z.2 - z.1) * G (z.2 - z.1) ∂gradientMeasure) -
      ((∫ z : ℝ × ℝ, H z.2 * G (z.2 - z.1) ∂gradientMeasure) +
        ∫ z : ℝ × ℝ, H (z.2 - z.1) * G z.2 ∂gradientMeasure) := by
    have hAD := hA.add hD
    have hBC := hB.add hC
    simp only [Pi.add_def] at hAD hBC
    rw [← integral_add hA hD, ← integral_add hB hC, ← integral_sub hAD hBC]
    apply integral_congr_ae
    exact Filter.Eventually.of_forall (fun z => by unfold gradient; ring)
  rw [lag_pair_integral hH hG, lag_shifted_pair_integral hH hG,
    lag_cross_orientation hH hG] at hexp
  have hkernel : symmetricKernelPair H G =
      (∫ z : ℝ × ℝ, H z.2 * G (z.2 - z.1) ∂gradientMeasure) +
      ∫ z : ℝ × ℝ, H z.2 * G (z.2 + z.1) ∂gradientMeasure := by
    unfold symmetricKernelPair
    simp_rw [mul_add]
    exact integral_add hB hF
  rw [hkernel]
  linarith [hexp]

theorem translated_memLp {H : ℝ → ℝ} (hH : MemLp H 2 volume) (h : ℝ) :
    MemLp (fun x => H (x + h)) 2 volume :=
  hH.comp_measurePreserving (measurePreserving_add_right volume h)

theorem unitPair_eq_translations {H G : ℝ → ℝ}
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume) :
    unitPair H G = 2 * (∫ x, H x * G x) -
      ∫ x, H x * (G (x - 1) + G (x + 1)) := by
  have hHm : MemLp (fun x => H (x - 1)) 2 volume := by
    simpa only [sub_eq_add_neg] using translated_memLp hH (-1)
  have hGm : MemLp (fun x => G (x - 1)) 2 volume := by
    simpa only [sub_eq_add_neg] using translated_memLp hG (-1)
  have hA := hH.integrable_mul hG
  have hB := hH.integrable_mul hGm
  have hC := hHm.integrable_mul hG
  have hD := hHm.integrable_mul hGm
  have hF := hH.integrable_mul (translated_memLp hG 1)
  simp only [Pi.mul_def] at hA hB hC hD hF
  have hd : (∫ x, H (x - 1) * G (x - 1)) = ∫ x, H x * G x :=
    integral_sub_right_eq_self (fun x => H x * G x) 1
  have hc : (∫ x, H (x - 1) * G x) = ∫ x, H x * G (x + 1) := by
    simpa only [sub_add_cancel] using
      integral_sub_right_eq_self (fun x => H x * G (x + 1)) 1
  have hexp : unitPair H G =
      ((∫ x, H x * G x) + ∫ x, H (x - 1) * G (x - 1)) -
      ((∫ x, H x * G (x - 1)) + ∫ x, H (x - 1) * G x) := by
    have hAD := hA.add hD
    have hBC := hB.add hC
    simp only [Pi.add_def] at hAD hBC
    rw [← integral_add hA hD, ← integral_add hB hC, ← integral_sub hAD hBC]
    exact integral_congr_ae (Filter.Eventually.of_forall (fun x => by ring))
  rw [hd, hc] at hexp
  simp_rw [mul_add]
  rw [integral_add hB hF]
  linarith [hexp]

/-- The physical contact kernel is minus the complete lag kernel plus twice
the sum of the actual successor and predecessor translations. -/
theorem contactForm_eq_kernel {H G : ℝ → ℝ}
    (hH : MemLp H 2 volume) (hG : MemLp G 2 volume) :
    contactForm H G = -symmetricKernelPair H G +
      2 * ∫ x, H x * (G (x - 1) + G (x + 1)) := by
  rw [contactForm, bilinear_eq_symmetricKernelPair hH hG, unitPair_eq_translations hH hG]
  ring

end BuildingBlocks.MixedEnergy
