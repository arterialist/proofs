import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity

open Finset Filter Set MeasureTheory
open scoped Topology BigOperators Interval

namespace BuildingBlocks

theorem affine_square_unit_integral (j A B : ℝ) :
    (∫ x in j..(j + 1), (B * x - A) ^ 2) =
      (B * (j + 1 / 2) - A) ^ 2 + B ^ 2 / 12 := by
  have he : (fun x : ℝ => (B * x - A) ^ 2) =
      (fun x => B ^ 2 * x ^ 2 - (2 * B * A) * x + A ^ 2) := by
    funext x
    ring
  have h2 : IntervalIntegrable (fun x : ℝ => B ^ 2 * x ^ 2) volume j (j + 1) :=
    (by fun_prop : Continuous (fun x : ℝ => B ^ 2 * x ^ 2)).intervalIntegrable _ _
  have h1 : IntervalIntegrable (fun x : ℝ => (2 * B * A) * x) volume j (j + 1) :=
    (by fun_prop : Continuous (fun x : ℝ => (2 * B * A) * x)).intervalIntegrable _ _
  rw [he, intervalIntegral.integral_add (h2.sub h1) intervalIntegrable_const,
    intervalIntegral.integral_sub h2 h1, intervalIntegral.integral_const_mul,
    intervalIntegral.integral_const_mul, integral_pow, integral_id,
    intervalIntegral.integral_const]
  simp only [smul_eq_mul]
  ring

/-- A rational lower bound uniform in the freely chosen constant B. -/
theorem reciprocal_window_variance {j : ℝ} (hj : 1 ≤ j) (A B : ℝ) :
    A ^ 2 ≤ 24 * (j + 1) ^ 4 *
      ∫ x in j..(j + 1), (B - A / x) ^ 2 := by
  have hj0 : 0 < j := by linarith
  have hpoly : IntervalIntegrable (fun x : ℝ => (B * x - A) ^ 2) volume j (j + 1) := by
    apply Continuous.intervalIntegrable
    fun_prop
  have hw : IntervalIntegrable (fun x : ℝ => (B - A / x) ^ 2) volume j (j + 1) := by
    apply ContinuousOn.intervalIntegrable
    rw [uIcc_of_le (by linarith : j ≤ j + 1)]
    apply ContinuousOn.pow
    apply continuousOn_const.sub
    apply continuousOn_const.div continuousOn_id
    intro x hx
    exact (hj0.trans_le hx.1).ne'
  have hpw : (∫ x in j..(j + 1), (B * x - A) ^ 2) ≤
      (j + 1) ^ 2 * ∫ x in j..(j + 1), (B - A / x) ^ 2 := by
    rw [← intervalIntegral.integral_const_mul]
    apply intervalIntegral.integral_mono_on (by linarith) hpoly (hw.const_mul _)
    intro x hx
    have hx0 : 0 < x := hj0.trans_le hx.1
    have he : (B * x - A) ^ 2 = x ^ 2 * (B - A / x) ^ 2 := by field_simp
    rw [he]
    apply mul_le_mul_of_nonneg_right ?_ (sq_nonneg _)
    exact (sq_le_sq₀ hx0.le (by linarith : 0 ≤ j + 1)).mpr hx.2
  have hvar : A ^ 2 ≤ 24 * (j + 1) ^ 2 *
      ((B * (j + 1 / 2) - A) ^ 2 + B ^ 2 / 12) := by
    have hA : A ^ 2 ≤ 2 * (B * (j + 1 / 2) - A) ^ 2 +
        2 * (B * (j + 1 / 2)) ^ 2 := by
      nlinarith [sq_nonneg (2 * B * (j + 1 / 2) - A)]
    have h1 : 2 * (B * (j + 1 / 2) - A) ^ 2 ≤
        (24 * (j + 1) ^ 2) * (B * (j + 1 / 2) - A) ^ 2 := by
      apply mul_le_mul_of_nonneg_right ?_ (sq_nonneg _)
      nlinarith [sq_nonneg j]
    have h2 : 2 * (B * (j + 1 / 2)) ^ 2 ≤
        2 * (j + 1) ^ 2 * B ^ 2 := by
      have hh : (j + 1 / 2) ^ 2 ≤ (j + 1) ^ 2 := by nlinarith
      have hh' := mul_le_mul_of_nonneg_right hh (sq_nonneg B)
      nlinarith
    nlinarith
  rw [← affine_square_unit_integral] at hvar
  have hh := mul_le_mul_of_nonneg_left hpw (show 0 ≤ 24 * (j + 1) ^ 2 by positivity)
  nlinarith

end BuildingBlocks
