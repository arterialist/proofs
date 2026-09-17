import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import Mathlib.MeasureTheory.Integral.Prod

open Set MeasureTheory Real
open scoped Interval

namespace BuildingBlocks.FrullaniIntegral

theorem rectangle_exp_integrable (a b : ℝ) (ha : 0 < a) :
    Integrable (fun z : ℝ × ℝ => Real.exp (-z.1 * z.2))
      ((volume.restrict (Ioc a b)).prod (volume.restrict (Ioi 0))) := by
  have hi : Integrable (fun _x : ℝ => (1 : ℝ)) (volume.restrict (Ioc a b)) :=
    integrable_const _
  have ht := integrableOn_exp_mul_Ioi (by linarith : -a < 0) 0
  have hm := hi.mul_prod ht
  have hc : Continuous (fun z : ℝ × ℝ => Real.exp (-z.1 * z.2)) := by fun_prop
  apply hm.mono' hc.aestronglyMeasurable
  rw [Measure.prod_restrict]
  filter_upwards [self_mem_ae_restrict (measurableSet_Ioc.prod measurableSet_Ioi)] with z hz
  rw [Real.norm_eq_abs, abs_of_pos (Real.exp_pos _)]
  change Real.exp (-z.1 * z.2) ≤ 1 * Real.exp (-a * z.2)
  simp only [one_mul]
  apply Real.exp_le_exp.mpr
  have hx : a < z.1 := hz.1.1
  have ht : 0 < z.2 := hz.2
  nlinarith

theorem parameter_exp_integral (a b t : ℝ) (ht : 0 < t) :
    (∫ x in a..b, Real.exp (-x * t)) =
      (Real.exp (-a * t) - Real.exp (-b * t)) / t := by
  have h := intervalIntegral.mul_integral_comp_mul_left
    (f := Real.exp) (-t) (a := a) (b := b)
  rw [integral_exp] at h
  have he : (fun x : ℝ => Real.exp (-t * x)) =
      (fun x : ℝ => Real.exp (-x * t)) := by
    funext x
    congr 1
    ring
  rw [he, show -t * a = -a * t by ring, show -t * b = -b * t by ring] at h
  apply (eq_div_iff (ne_of_gt ht)).mpr
  linarith

theorem ordered_frullani (a b : ℝ) (ha : 0 < a) (hab : a ≤ b) :
    (∫ t in Ioi 0, (Real.exp (-a * t) - Real.exp (-b * t)) / t) = Real.log (b / a) := by
  have hi := rectangle_exp_integrable a b ha
  rw [← uIoc_of_le hab] at hi
  have hs := intervalIntegral_integral_swap
    (f := fun x t : ℝ => Real.exp (-x * t)) hi
  dsimp only at hs
  have hleft : (∫ x in a..b, ∫ t in Ioi 0, Real.exp (-x * t)) =
      ∫ x in a..b, 1 / x := by
    apply intervalIntegral.integral_congr
    intro x hx
    rw [uIcc_of_le hab] at hx
    have hx0 : 0 < x := lt_of_lt_of_le ha hx.1
    change (∫ t in Ioi 0, Real.exp (-x * t)) = 1 / x
    rw [integral_exp_mul_Ioi (by linarith : -x < 0)]
    simp
  have hright : (∫ t in Ioi 0, ∫ x in a..b, Real.exp (-x * t)) =
      ∫ t in Ioi 0, (Real.exp (-a * t) - Real.exp (-b * t)) / t := by
    apply integral_congr_ae
    filter_upwards [self_mem_ae_restrict measurableSet_Ioi] with t ht
    exact parameter_exp_integral a b t ht
  rw [hleft, hright, integral_one_div_of_pos ha (lt_of_lt_of_le ha hab)] at hs
  exact hs.symm

theorem ordered_frullani_integrable (a b : ℝ) (ha : 0 < a) (hab : a ≤ b) :
    IntegrableOn (fun t => (Real.exp (-a * t) - Real.exp (-b * t)) / t) (Ioi 0) := by
  have hi := (rectangle_exp_integrable a b ha).integral_prod_right
  apply hi.congr
  filter_upwards [self_mem_ae_restrict measurableSet_Ioi] with t ht
  rw [← intervalIntegral.integral_of_le hab]
  exact parameter_exp_integral a b t ht

theorem frullani_integrable (a b : ℝ) (ha : 0 < a) (hb : 0 < b) :
    IntegrableOn (fun t => (Real.exp (-a * t) - Real.exp (-b * t)) / t) (Ioi 0) := by
  rcases le_total a b with hab | hba
  · exact ordered_frullani_integrable a b ha hab
  · apply (ordered_frullani_integrable b a hb hba).neg.congr
    exact Filter.Eventually.of_forall (fun t => by
      change -((Real.exp (-b * t) - Real.exp (-a * t)) / t) =
        (Real.exp (-a * t) - Real.exp (-b * t)) / t
      ring)

theorem frullani (a b : ℝ) (ha : 0 < a) (hb : 0 < b) :
    (∫ t in Ioi 0, (Real.exp (-a * t) - Real.exp (-b * t)) / t) = Real.log (b / a) := by
  rcases le_total a b with hab | hba
  · exact ordered_frullani a b ha hab
  · have he : (∫ t in Ioi 0, (Real.exp (-a * t) - Real.exp (-b * t)) / t) =
        -(∫ t in Ioi 0, (Real.exp (-b * t) - Real.exp (-a * t)) / t) := by
      rw [← integral_neg]
      apply integral_congr_ae
      exact Filter.Eventually.of_forall (fun t => by
        change (Real.exp (-a * t) - Real.exp (-b * t)) / t =
          -((Real.exp (-b * t) - Real.exp (-a * t)) / t)
        ring)
    rw [he, ordered_frullani b a hb hba,
      Real.log_div (ne_of_gt ha) (ne_of_gt hb),
      Real.log_div (ne_of_gt hb) (ne_of_gt ha)]
    ring

#print axioms rectangle_exp_integrable
#print axioms parameter_exp_integral
#print axioms ordered_frullani
#print axioms ordered_frullani_integrable
#print axioms frullani_integrable
#print axioms frullani

end BuildingBlocks.FrullaniIntegral
