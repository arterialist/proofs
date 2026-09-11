import BuildingBlocks.CoarsePrimeBounds
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic

open Filter Set MeasureTheory
open scoped BigOperators Interval

namespace BuildingBlocks

open CoarsePrimitive

/-- The finite prime-power expression for the integral of the actual prime error
from one to `x`. At an integer endpoint its last summand has zero coefficient. -/
noncomputable def primePrimitiveArea (x : ℝ) : ℝ :=
  x * psi ⌊x⌋₊ -
    (∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (n : ℝ) * ArithmeticFunction.vonMangoldt n) -
    (x ^ 2 - 1) / 2

theorem primePrimitiveArea_eq_weighted_sum (x : ℝ) :
    primePrimitiveArea x =
      (∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (x - n) * ArithmeticFunction.vonMangoldt n) -
        (x ^ 2 - 1) / 2 := by
  simp only [primePrimitiveArea, psi_eq_sum_Icc, Finset.mul_sum,
    sub_mul, Finset.sum_sub_distrib]

theorem integral_psi_floor_eq_finite {x : ℝ} (hx : 1 ≤ x) :
    (∫ t in (1 : ℝ)..x, psi ⌊t⌋₊) =
      x * psi ⌊x⌋₊ -
        ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (n : ℝ) * ArithmeticFunction.vonMangoldt n := by
  have hd : IntegrableOn (deriv (fun t : ℝ => t)) (Icc 1 x) := by
    simp only [deriv_id'']
    exact continuous_const.integrableOn_Icc
  have hab := sum_mul_eq_sub_integral_mul₀ ArithmeticFunction.vonMangoldt
    (by simp) x (fun _ _ => differentiableAt_id) hd
  have hs : ∀ N : ℕ,
      (∑ n ∈ Finset.Icc 0 N, ArithmeticFunction.vonMangoldt n) = psi N := by
    intro N
    have hset : Finset.Icc 0 N = Finset.range (N + 1) := by
      ext n
      simp
      omega
    rw [hset, psi]
  simp only [hs, deriv_id, id_eq, one_mul] at hab
  rw [Finset.Icc_eq_cons_Ioc (Nat.zero_le _), Finset.sum_cons] at hab
  simp only [Nat.cast_zero, zero_mul, zero_add,
    ← Finset.Icc_add_one_left_eq_Ioc] at hab
  rw [intervalIntegral.integral_of_le hx]
  linarith

/-- This identity has no prime-error bound as a hypothesis. -/
theorem integral_primeErrorReal_eq_area {x : ℝ} (hx : 1 ≤ x) :
    (∫ t in (1 : ℝ)..x, primeErrorReal t) = primePrimitiveArea x := by
  have hp : IntervalIntegrable (fun t : ℝ => psi ⌊t⌋₊) volume 1 x :=
    (show Monotone (fun t : ℝ => psi ⌊t⌋₊) from
      fun _ _ h => psi_mono (Nat.floor_mono h)).intervalIntegrable
  change (∫ t in (1 : ℝ)..x, (fun t : ℝ => psi ⌊t⌋₊) t - id t) = _
  rw [intervalIntegral.integral_sub hp (continuous_id.intervalIntegrable _ _),
    integral_psi_floor_eq_finite hx]
  simp only [id_eq, integral_id, one_pow, primePrimitiveArea]

/-- Every coarse primitive sample is an explicit finite expression, including
the initial value through the subtraction at the lower endpoint. -/
theorem coarsePrefix_eq_area_sub {X t : ℝ} (hX : 1 ≤ X) (ht : 1 ≤ t) :
    coarsePrefix X t = primePrimitiveArea t - primePrimitiveArea X := by
  have h := intervalIntegral.integral_add_adjacent_intervals
    (primeErrorReal_intervalIntegrable 1 X) (primeErrorReal_intervalIntegrable X t)
  rw [integral_primeErrorReal_eq_area hX, integral_primeErrorReal_eq_area ht] at h
  change (∫ x in X..t, primeErrorReal x) = _
  linarith

end BuildingBlocks
