import BuildingBlocks.HyperbolaProduct
import BuildingBlocks.SelbergReflection
import BuildingBlocks.PrimeLogFilter
import Mathlib.MeasureTheory.Function.JacobianOneDim

open Set MeasureTheory
open scoped Interval

namespace BuildingBlocks

open CoarsePrimitive HyperbolaProduct

/-- Exponential substitution from the measurable change-of-variables theorem.
No continuity assumption is imposed on the integrand. -/
theorem integral_exp_substitution (T : ℝ) (hT : 0 ≤ T) (f : ℝ → ℝ) :
    (∫ a in (1 : ℝ)..Real.exp T, f a) =
      ∫ t in (0 : ℝ)..T, Real.exp t * f (Real.exp t) := by
  have himage : Real.exp '' Ioc 0 T = Ioc 1 (Real.exp T) := by
    ext y
    constructor
    · rintro ⟨t, ht, rfl⟩
      exact ⟨Real.one_lt_exp_iff.mpr ht.1, Real.exp_le_exp.mpr ht.2⟩
    · intro hy
      have hyp : 0 < y := lt_trans zero_lt_one hy.1
      refine ⟨Real.log y, ⟨Real.log_pos hy.1, ?_⟩, Real.exp_log hyp⟩
      exact (Real.log_le_iff_le_exp hyp).mpr hy.2
  have hc := integral_image_eq_integral_abs_deriv_smul
    (s := Ioc 0 T) measurableSet_Ioc
    (fun t _ => (Real.hasDerivAt_exp t).hasDerivWithinAt)
    Real.exp_injective.injOn f
  rw [himage] at hc
  rw [intervalIntegral.integral_of_le (Real.one_le_exp_iff.mpr hT),
    intervalIntegral.integral_of_le hT]
  simpa only [abs_of_pos (Real.exp_pos _), smul_eq_mul] using hc

private theorem primeLog_reflection_integrand (T t : ℝ) :
    Real.exp T * (primeErrorReal (Real.exp t) *
      (primeErrorReal (Real.exp (T - t)) -
        coarsePrefix 1 (Real.exp (T - t)) / Real.exp (T - t))) =
    Real.exp ((3 / 2 : ℝ) * T) *
      (primeLogError t * (primeLogError (T - t) - primeLogResponse (T - t))) := by
  have he1 : Real.exp ((3 / 2 : ℝ) * T) * Real.exp (-(1 / 2 : ℝ) * t) *
      Real.exp (-(1 / 2 : ℝ) * (T - t)) = Real.exp T := by
    rw [← Real.exp_add, ← Real.exp_add]
    congr 1
    ring
  have he2 : Real.exp ((3 / 2 : ℝ) * T) * Real.exp (-(1 / 2 : ℝ) * t) *
      Real.exp (-(3 / 2 : ℝ) * (T - t)) = Real.exp t := by
    rw [← Real.exp_add, ← Real.exp_add]
    congr 1
    ring
  have hr : Real.exp ((3 / 2 : ℝ) * T) *
      (primeLogError t * (primeLogError (T - t) - primeLogResponse (T - t))) =
      Real.exp T * primeErrorReal (Real.exp t) * primeErrorReal (Real.exp (T - t)) -
        Real.exp t * primeErrorReal (Real.exp t) * coarsePrefix 1 (Real.exp (T - t)) := by
    unfold primeLogError primeLogResponse
    calc
      _ = (Real.exp ((3 / 2 : ℝ) * T) * Real.exp (-(1 / 2 : ℝ) * t) *
          Real.exp (-(1 / 2 : ℝ) * (T - t))) *
          primeErrorReal (Real.exp t) * primeErrorReal (Real.exp (T - t)) -
        (Real.exp ((3 / 2 : ℝ) * T) * Real.exp (-(1 / 2 : ℝ) * t) *
          Real.exp (-(3 / 2 : ℝ) * (T - t))) *
          primeErrorReal (Real.exp t) * coarsePrefix 1 (Real.exp (T - t)) := by ring
      _ = _ := by rw [he1, he2]
  rw [hr, Real.exp_sub]
  field_simp

/-- The actual finite arithmetic first Riesz mean in logarithmic time.
The substitution includes the jumps of the prime error and the initial value
`coarsePrefix 1 1 = 0`. -/
theorem selbergCenteredArea_log_reflection {N : ℕ} (hN : 1 ≤ N) :
    selbergCenteredArea N = Real.exp ((3 / 2 : ℝ) * Real.log (N : ℝ)) *
      ∫ t in (0 : ℝ)..Real.log (N : ℝ),
        primeLogError t *
          (primeLogError (Real.log (N : ℝ) - t) -
            primeLogResponse (Real.log (N : ℝ) - t)) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hNp : (0 : ℝ) < N := lt_of_lt_of_le zero_lt_one hNr
  have hT : 0 ≤ Real.log (N : ℝ) := Real.log_nonneg hNr
  rw [selbergCenteredArea_reflection hN]
  have hsub := integral_exp_substitution (Real.log (N : ℝ)) hT
    (fun a => primeErrorReal a *
      (primeErrorReal ((N : ℝ) / a) -
        coarsePrefix 1 ((N : ℝ) / a) / ((N : ℝ) / a)) / a)
  rw [Real.exp_log hNp] at hsub
  rw [hsub, ← intervalIntegral.integral_const_mul,
    ← intervalIntegral.integral_const_mul]
  apply intervalIntegral.integral_congr
  intro t ht
  dsimp only
  have hq : (N : ℝ) / Real.exp t = Real.exp (Real.log (N : ℝ) - t) := by
    rw [Real.exp_sub, Real.exp_log hNp]
  rw [hq]
  have hc : Real.exp t *
      (primeErrorReal (Real.exp t) *
        (primeErrorReal (Real.exp (Real.log (N : ℝ) - t)) -
          coarsePrefix 1 (Real.exp (Real.log (N : ℝ) - t)) /
            Real.exp (Real.log (N : ℝ) - t)) / Real.exp t) =
      primeErrorReal (Real.exp t) *
        (primeErrorReal (Real.exp (Real.log (N : ℝ) - t)) -
          coarsePrefix 1 (Real.exp (Real.log (N : ℝ) - t)) /
            Real.exp (Real.log (N : ℝ) - t)) := by
    field_simp
  rw [hc]
  simpa only [Real.exp_log hNp] using
    primeLog_reflection_integrand (Real.log (N : ℝ)) t

end BuildingBlocks
