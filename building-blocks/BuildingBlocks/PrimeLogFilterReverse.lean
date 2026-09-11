import BuildingBlocks.PrimeLogFilter

open Set MeasureTheory
open scoped Interval

namespace BuildingBlocks

open CoarsePrimitive

/-- The inverse estimate for the actual logarithmic prime-error filter, with
its finite terminal square retained. This is an identity, not a bound on the
arithmetic input. -/
theorem primeLogFilter_reverse_energy_identity (T : ℝ) :
    9 * (∫ t in (0 : ℝ)..T, (primeLogError t - primeLogResponse t)^2) -
        (∫ t in (0 : ℝ)..T, primeLogError t ^ 2) =
      2 * (∫ t in (0 : ℝ)..T,
        (2 * primeLogError t - 3 * primeLogResponse t)^2) +
      3 * primeLogResponse T ^ 2 := by
  have hf2 := primeLogError_sq_intervalIntegrable 0 T
  have hrf : IntervalIntegrable
      (fun t => primeLogResponse t * primeLogError t) volume 0 T := by
    simpa only [mul_comm] using
      (primeLogError_intervalIntegrable 0 T).mul_continuousOn
        primeLogResponse_continuous.continuousOn
  have hr2 : IntervalIntegrable (fun t => primeLogResponse t ^ 2) volume 0 T :=
    (primeLogResponse_continuous.pow 2).intervalIntegrable 0 T
  have hexpand : (fun t : ℝ => (2 * primeLogError t - 3 * primeLogResponse t)^2) =
      (fun t => 4 * primeLogError t ^ 2 -
        12 * (primeLogResponse t * primeLogError t) + 9 * primeLogResponse t ^ 2) := by
    funext t
    ring
  have hZ : (∫ t in (0 : ℝ)..T,
      (2 * primeLogError t - 3 * primeLogResponse t)^2) =
      4 * (∫ t in (0 : ℝ)..T, primeLogError t ^ 2) -
        12 * (∫ t in (0 : ℝ)..T, primeLogResponse t * primeLogError t) +
        9 * (∫ t in (0 : ℝ)..T, primeLogResponse t ^ 2) := by
    rw [hexpand, intervalIntegral.integral_add
      ((hf2.const_mul 4).sub (hrf.const_mul 12)) (hr2.const_mul 9),
      intervalIntegral.integral_sub (hf2.const_mul 4) (hrf.const_mul 12)]
    simp only [intervalIntegral.integral_const_mul]
  have hcross : 2 * (∫ t in (0 : ℝ)..T,
      primeLogResponse t * primeLogError t) =
      primeLogResponse T ^ 2 +
        3 * (∫ t in (0 : ℝ)..T, primeLogResponse t ^ 2) := by
    simpa only [show (2 : ℝ) * (3 / 2) = 3 by norm_num] using
      causalFilter_cross_integral
        primeLogResponse_continuous.continuousOn primeLogResponse_zero
        (primeLogError_intervalIntegrable 0 T)
        (fun t _ => primeLogResponse_hasDerivWithinAt_right t)
  rw [primeLogFilter_energy_identity, hZ]
  linarith

/-- The filtered actual prime error controls the input with energy factor nine.
No assumption on RH, prime-error growth, or a covariance sign is used. -/
theorem primeLogFilter_reverse_energy_bound {T : ℝ} (hT : 0 ≤ T) :
    (∫ t in (0 : ℝ)..T, primeLogError t ^ 2) ≤
      9 * (∫ t in (0 : ℝ)..T, (primeLogError t - primeLogResponse t)^2) := by
  have hi : 0 ≤ ∫ t in (0 : ℝ)..T,
      (2 * primeLogError t - 3 * primeLogResponse t)^2 :=
    intervalIntegral.integral_nonneg hT (fun t _ => sq_nonneg _)
  have hid := primeLogFilter_reverse_energy_identity T
  nlinarith [sq_nonneg (primeLogResponse T)]

/-- The forward contraction and its finite inverse estimate in the same norm. -/
theorem primeLogFilter_energy_comparison {T : ℝ} (hT : 0 ≤ T) :
    (∫ t in (0 : ℝ)..T, (primeLogError t - primeLogResponse t)^2) ≤
        (∫ t in (0 : ℝ)..T, primeLogError t ^ 2) ∧
      (∫ t in (0 : ℝ)..T, primeLogError t ^ 2) ≤
        9 * (∫ t in (0 : ℝ)..T, (primeLogError t - primeLogResponse t)^2) := by
  constructor
  · rw [primeLogFilter_energy_identity]
    have hi : 0 ≤ ∫ t in (0 : ℝ)..T, primeLogResponse t ^ 2 :=
      intervalIntegral.integral_nonneg hT (fun t _ => sq_nonneg _)
    nlinarith [sq_nonneg (primeLogResponse T)]
  · exact primeLogFilter_reverse_energy_bound hT

end BuildingBlocks
