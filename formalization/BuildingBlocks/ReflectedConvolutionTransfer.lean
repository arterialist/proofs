import Mathlib.MeasureTheory.Function.L2Space
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import Mathlib.Analysis.Complex.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

open MeasureTheory Set
open scoped Interval

namespace BuildingBlocks


private theorem interval_l2_product_bound {T : ℝ} (hT : 0 ≤ T)
    {f g : ℝ → ℂ}
    (hf : MemLp f 2 (volume.restrict (Ioc 0 T)))
    (hg : MemLp g 2 (volume.restrict (Ioc 0 T))) :
    ‖∫ t in (0 : ℝ)..T, f t * g t‖ ≤
      Real.sqrt (∫ t in (0 : ℝ)..T, ‖f t‖ ^ 2) *
        Real.sqrt (∫ t in (0 : ℝ)..T, ‖g t‖ ^ 2) := by
  have hh := integral_mul_norm_le_Lp_mul_Lq Real.HolderConjugate.two_two
    (by simpa using hf) (by simpa using hg)
  calc
    _ ≤ ∫ t in (0 : ℝ)..T, ‖f t * g t‖ :=
      intervalIntegral.norm_integral_le_integral_norm hT
    _ = ∫ t in (0 : ℝ)..T, ‖f t‖ * ‖g t‖ := by simp only [norm_mul]
    _ ≤ _ := by
      simpa only [Real.rpow_two, ← Real.sqrt_eq_rpow,
        ← intervalIntegral.integral_of_le hT] using hh

private theorem reflected_square_integral (T : ℝ) (f : ℝ → ℂ) :
    (∫ t in (0 : ℝ)..T, ‖f (T - t)‖ ^ 2) =
      ∫ t in (0 : ℝ)..T, ‖f t‖ ^ 2 := by
  simpa only [sub_self, sub_zero] using
    intervalIntegral.integral_comp_sub_left (fun t => ‖f t‖ ^ 2) (a := 0) (b := T) T

private theorem reflected_transfer_aux {T : ℝ} (hT : 0 ≤ T)
    {a b p q : ℝ → ℂ}
    (ha : MemLp a 2 (volume.restrict (Ioc 0 T)))
    (hp : MemLp p 2 (volume.restrict (Ioc 0 T)))
    (hb : MemLp (fun t => b (T - t)) 2 (volume.restrict (Ioc 0 T)))
    (hq : MemLp (fun t => q (T - t)) 2 (volume.restrict (Ioc 0 T))) :
    ‖(∫ t in (0 : ℝ)..T, a t * b (T - t)) -
        (∫ t in (0 : ℝ)..T, p t * q (T - t))‖ ≤
      Real.sqrt (∫ t in (0 : ℝ)..T, ‖a t - p t‖ ^ 2) *
        Real.sqrt (∫ t in (0 : ℝ)..T, ‖b t‖ ^ 2) +
      Real.sqrt (∫ t in (0 : ℝ)..T, ‖p t‖ ^ 2) *
        Real.sqrt (∫ t in (0 : ℝ)..T, ‖b t - q t‖ ^ 2) := by
  have hiab : IntervalIntegrable (fun t => a t * b (T - t)) volume 0 T :=
    (intervalIntegrable_iff_integrableOn_Ioc_of_le hT).mpr (ha.integrable_mul hb)
  have hipq : IntervalIntegrable (fun t => p t * q (T - t)) volume 0 T :=
    (intervalIntegrable_iff_integrableOn_Ioc_of_le hT).mpr (hp.integrable_mul hq)
  have hie : IntervalIntegrable (fun t => (a t - p t) * b (T - t)) volume 0 T :=
    (intervalIntegrable_iff_integrableOn_Ioc_of_le hT).mpr ((ha.sub hp).integrable_mul hb)
  have hif : IntervalIntegrable (fun t => p t * (b (T - t) - q (T - t))) volume 0 T :=
    (intervalIntegrable_iff_integrableOn_Ioc_of_le hT).mpr (hp.integrable_mul (hb.sub hq))
  have hid : (fun t => a t * b (T - t) - p t * q (T - t)) =
      (fun t => (a t - p t) * b (T - t) + p t * (b (T - t) - q (T - t))) := by
    funext t
    ring
  rw [← intervalIntegral.integral_sub hiab hipq, hid, intervalIntegral.integral_add hie hif]
  apply (norm_add_le _ _).trans
  have hfirst := interval_l2_product_bound hT (ha.sub hp) hb
  have hsecond := interval_l2_product_bound hT hp (hb.sub hq)
  simp only [Pi.sub_apply] at hfirst hsecond
  rw [reflected_square_integral T b] at hfirst
  have hr := reflected_square_integral T (fun t => b t - q t)
  rw [hr] at hsecond
  exact add_le_add hfirst hsecond

private theorem continuousOn_memLp_two {T : ℝ} (hT : 0 ≤ T)
    {f : ℝ → ℂ} (hf : ContinuousOn f (Icc 0 T)) :
    MemLp f 2 (volume.restrict (Ioc 0 T)) := by
  have hi : IntervalIntegrable f volume 0 T := hf.intervalIntegrable_of_Icc hT
  apply (memLp_two_iff_integrable_sq_norm hi.1.aestronglyMeasurable).mpr
  exact ((hf.norm.pow 2).intervalIntegrable_of_Icc hT).1

/-- Finite-interval reflected-convolution transfer for functions continuous
only on the integration interval. Reflection is eliminated from every L² term. -/
theorem reflected_convolution_transfer_continuousOn {T : ℝ} (hT : 0 ≤ T)
    {a b p q : ℝ → ℂ}
    (ha : ContinuousOn a (Icc 0 T)) (hb : ContinuousOn b (Icc 0 T))
    (hp : ContinuousOn p (Icc 0 T)) (hq : ContinuousOn q (Icc 0 T)) :
    ‖(∫ t in (0 : ℝ)..T, a t * b (T - t)) -
        (∫ t in (0 : ℝ)..T, p t * q (T - t))‖ ≤
      Real.sqrt (∫ t in (0 : ℝ)..T, ‖a t - p t‖ ^ 2) *
        Real.sqrt (∫ t in (0 : ℝ)..T, ‖b t‖ ^ 2) +
      Real.sqrt (∫ t in (0 : ℝ)..T, ‖p t‖ ^ 2) *
        Real.sqrt (∫ t in (0 : ℝ)..T, ‖b t - q t‖ ^ 2) := by
  have href (f : ℝ → ℂ) (hf : ContinuousOn f (Icc 0 T)) :
      ContinuousOn (fun t => f (T - t)) (Icc 0 T) := by
    apply hf.comp (continuous_const.sub continuous_id).continuousOn
    intro t ht
    obtain ⟨ht0, htT⟩ := ht
    change 0 ≤ T - t ∧ T - t ≤ T
    constructor <;> linarith
  exact reflected_transfer_aux hT (continuousOn_memLp_two hT ha)
    (continuousOn_memLp_two hT hp) (continuousOn_memLp_two hT (href b hb))
    (continuousOn_memLp_two hT (href q hq))

private theorem reflected_memLp_two {T : ℝ} (hT : 0 ≤ T)
    {f : ℝ → ℂ} (hm : Measurable f)
    (hf : MemLp f 2 (volume.restrict (Ioc 0 T))) :
    MemLp (fun t => f (T - t)) 2 (volume.restrict (Ioc 0 T)) := by
  have hi : IntervalIntegrable (fun t => ‖f t‖ ^ 2) volume 0 T :=
    (intervalIntegrable_iff_integrableOn_Ioc_of_le hT).mpr
      ((memLp_two_iff_integrable_sq_norm hf.1).mp hf)
  have hr : IntervalIntegrable (fun t => ‖f (T - t)‖ ^ 2) volume 0 T := by
    simpa only [sub_self, sub_zero] using (hi.comp_sub_left T).symm
  apply (memLp_two_iff_integrable_sq_norm
    (hm.comp (measurable_const.sub measurable_id)).aestronglyMeasurable).mpr
  exact hr.1

/-- The same transfer for square-integrable functions. Only the reflected
inputs `b,q` need explicit global measurability; `a,p` may be arbitrary L²
representatives on the interval. This version admits prime-error step functions. -/
theorem reflected_convolution_transfer_memLp {T : ℝ} (hT : 0 ≤ T)
    {a b p q : ℝ → ℂ} (hbmeas : Measurable b) (hqmeas : Measurable q)
    (ha : MemLp a 2 (volume.restrict (Ioc 0 T)))
    (hb : MemLp b 2 (volume.restrict (Ioc 0 T)))
    (hp : MemLp p 2 (volume.restrict (Ioc 0 T)))
    (hq : MemLp q 2 (volume.restrict (Ioc 0 T))) :
    ‖(∫ t in (0 : ℝ)..T, a t * b (T - t)) -
        (∫ t in (0 : ℝ)..T, p t * q (T - t))‖ ≤
      Real.sqrt (∫ t in (0 : ℝ)..T, ‖a t - p t‖ ^ 2) *
        Real.sqrt (∫ t in (0 : ℝ)..T, ‖b t‖ ^ 2) +
      Real.sqrt (∫ t in (0 : ℝ)..T, ‖p t‖ ^ 2) *
        Real.sqrt (∫ t in (0 : ℝ)..T, ‖b t - q t‖ ^ 2) :=
  reflected_transfer_aux hT ha hp (reflected_memLp_two hT hbmeas hb)
    (reflected_memLp_two hT hqmeas hq)

end BuildingBlocks
