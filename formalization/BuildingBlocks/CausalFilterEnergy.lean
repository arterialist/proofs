import Mathlib.MeasureTheory.Integral.IntervalIntegral.IntegrationByParts
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

open Set MeasureTheory
open scoped Interval

namespace BuildingBlocks

/-- The energy identity for the causal filter `r' = f - rate r`, with its
actual zero initial condition. Right derivatives allow step-function input. -/
theorem causalFilter_cross_integral {T rate : ℝ} {f r : ℝ → ℝ}
    (hr : ContinuousOn r (uIcc 0 T)) (hr0 : r 0 = 0)
    (hf : IntervalIntegrable f volume 0 T)
    (hd : ∀ t ∈ Ioo (min 0 T) (max 0 T),
      HasDerivWithinAt r (f t - rate * r t) (Ioi t) t) :
    2 * (∫ t in (0 : ℝ)..T, r t * f t) =
      r T ^ 2 + 2 * rate * ∫ t in (0 : ℝ)..T, r t ^ 2 := by
  have hrf : IntervalIntegrable (fun t => r t * f t) volume 0 T := by
    simpa only [mul_comm] using hf.mul_continuousOn hr
  have hr2 : IntervalIntegrable (fun t => r t ^ 2) volume 0 T :=
    (hr.pow 2).intervalIntegrable
  have heq : (fun t => 2 * r t * (f t - rate * r t)) =
      (fun t => 2 * (r t * f t) - (2 * rate) * r t ^ 2) := by
    funext t
    ring
  have hi : IntervalIntegrable (fun t => 2 * r t * (f t - rate * r t))
      volume 0 T := by
    rw [heq]
    exact (hrf.const_mul 2).sub (hr2.const_mul (2 * rate))
  have h := intervalIntegral.integral_eq_sub_of_hasDeriv_right
    (hr.pow 2) (fun t ht => by simpa using (hd t ht).pow 2) hi
  rw [heq, intervalIntegral.integral_sub (hrf.const_mul 2)
      (hr2.const_mul (2 * rate)), intervalIntegral.integral_const_mul,
    intervalIntegral.integral_const_mul] at h
  simp only [hr0, zero_pow (by decide : (2 : ℕ) ≠ 0), sub_zero] at h
  linarith

/-- Exact dissipated energy; no boundedness or arithmetic error estimate is
assumed. The terminal square records the filter's boundary contribution. -/
theorem causalFilter_energy_identity {T rate : ℝ} {f r : ℝ → ℝ}
    (hr : ContinuousOn r (uIcc 0 T)) (hr0 : r 0 = 0)
    (hf : IntervalIntegrable f volume 0 T)
    (hf2 : IntervalIntegrable (fun t => f t ^ 2) volume 0 T)
    (hd : ∀ t ∈ Ioo (min 0 T) (max 0 T),
      HasDerivWithinAt r (f t - rate * r t) (Ioi t) t) :
    (∫ t in (0 : ℝ)..T, (f t - r t)^2) =
      (∫ t in (0 : ℝ)..T, f t ^ 2) - r T ^ 2 -
        (2 * rate - 1) * ∫ t in (0 : ℝ)..T, r t ^ 2 := by
  have hrf : IntervalIntegrable (fun t => r t * f t) volume 0 T := by
    simpa only [mul_comm] using hf.mul_continuousOn hr
  have hr2 : IntervalIntegrable (fun t => r t ^ 2) volume 0 T :=
    (hr.pow 2).intervalIntegrable
  have heq : (fun t => (f t - r t)^2) =
      (fun t => f t ^ 2 - 2 * (r t * f t) + r t ^ 2) := by
    funext t
    ring
  rw [heq, intervalIntegral.integral_add (hf2.sub (hrf.const_mul 2)) hr2,
    intervalIntegral.integral_sub hf2 (hrf.const_mul 2),
    intervalIntegral.integral_const_mul,
    causalFilter_cross_integral hr hr0 hf hd]
  ring

theorem causalFilter_energy_contraction {T rate : ℝ} {f r : ℝ → ℝ}
    (hT : 0 ≤ T) (hrate : 1 / 2 ≤ rate)
    (hr : ContinuousOn r (uIcc 0 T)) (hr0 : r 0 = 0)
    (hf : IntervalIntegrable f volume 0 T)
    (hf2 : IntervalIntegrable (fun t => f t ^ 2) volume 0 T)
    (hd : ∀ t ∈ Ioo (min 0 T) (max 0 T),
      HasDerivWithinAt r (f t - rate * r t) (Ioi t) t) :
    (∫ t in (0 : ℝ)..T, (f t - r t)^2) ≤
      ∫ t in (0 : ℝ)..T, f t ^ 2 := by
  rw [causalFilter_energy_identity hr hr0 hf hf2 hd]
  have hi : 0 ≤ ∫ t in (0 : ℝ)..T, r t ^ 2 :=
    intervalIntegral.integral_nonneg hT (fun t _ => sq_nonneg _)
  have hm : 0 ≤ (2 * rate - 1) * ∫ t in (0 : ℝ)..T, r t ^ 2 :=
    mul_nonneg (by linarith) hi
  nlinarith [sq_nonneg (r T)]

/-- The same energy identity bounds the causal response itself by the input,
with squared gain `rate⁻²` when the rate is positive. -/
theorem causalFilter_response_bound {T rate : ℝ} {f r : ℝ → ℝ}
    (hT : 0 ≤ T) (hrate : 0 ≤ rate)
    (hr : ContinuousOn r (uIcc 0 T)) (hr0 : r 0 = 0)
    (hf : IntervalIntegrable f volume 0 T)
    (hf2 : IntervalIntegrable (fun t => f t ^ 2) volume 0 T)
    (hd : ∀ t ∈ Ioo (min 0 T) (max 0 T),
      HasDerivWithinAt r (f t - rate * r t) (Ioi t) t) :
    rate ^ 2 * (∫ t in (0 : ℝ)..T, r t ^ 2) ≤
      ∫ t in (0 : ℝ)..T, f t ^ 2 := by
  have hrf : IntervalIntegrable (fun t => r t * f t) volume 0 T := by
    simpa only [mul_comm] using hf.mul_continuousOn hr
  have hr2 : IntervalIntegrable (fun t => r t ^ 2) volume 0 T :=
    (hr.pow 2).intervalIntegrable
  have heq : (fun t => (f t - rate * r t)^2) =
      (fun t => f t ^ 2 - (2 * rate) * (r t * f t) +
        rate ^ 2 * r t ^ 2) := by
    funext t
    ring
  have hnonneg : 0 ≤ ∫ t in (0 : ℝ)..T, (f t - rate * r t)^2 :=
    intervalIntegral.integral_nonneg hT (fun t _ => sq_nonneg _)
  rw [heq, intervalIntegral.integral_add
      (hf2.sub (hrf.const_mul (2 * rate))) (hr2.const_mul (rate ^ 2)),
    intervalIntegral.integral_sub hf2 (hrf.const_mul (2 * rate)),
    intervalIntegral.integral_const_mul,
    intervalIntegral.integral_const_mul] at hnonneg
  have hc := causalFilter_cross_integral hr hr0 hf hd
  have hm := mul_nonneg hrate (sq_nonneg (r T))
  nlinarith

end BuildingBlocks

#print axioms BuildingBlocks.causalFilter_cross_integral
#print axioms BuildingBlocks.causalFilter_energy_identity
#print axioms BuildingBlocks.causalFilter_energy_contraction
#print axioms BuildingBlocks.causalFilter_response_bound
