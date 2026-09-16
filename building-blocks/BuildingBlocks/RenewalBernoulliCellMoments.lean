import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Tactic

open scoped Interval

namespace BuildingBlocks.RenewalBernoulliCellMoments

/-- Leading centered profile of the exact logarithmic renewal cell. -/
noncomputable def f0 (r : ℝ) : ℝ :=
  (-1 / 2 : ℝ) * r ^ 2 + (1 / 2 : ℝ) * r + (-1 / 12 : ℝ)

/-- First correction to the centered renewal-cell profile. -/
noncomputable def f1 (r : ℝ) : ℝ :=
  (5 / 12 : ℝ) * r ^ 3 - (1 / 4 : ℝ) * r ^ 2 - (1 / 24 : ℝ) * r

/-- Second correction to the centered renewal-cell profile. -/
noncomputable def f2 (r : ℝ) : ℝ :=
  (-11 / 32 : ℝ) * r ^ 4 + (1 / 6 : ℝ) * r ^ 3 +
    (1 / 48 : ℝ) * r ^ 2 + (23 / 2880 : ℝ)

/-- The leading centered cell has zero mean. -/
theorem f0_mean : (∫ r in (0 : ℝ)..1, f0 r) = 0 := by
  unfold f0
  rw [intervalIntegral.integral_add (by apply Continuous.intervalIntegrable; fun_prop)
    (by apply Continuous.intervalIntegrable; fun_prop)]
  rw [intervalIntegral.integral_add (by apply Continuous.intervalIntegrable; fun_prop)
    (by apply Continuous.intervalIntegrable; fun_prop)]
  simp [intervalIntegral.integral_const_mul, integral_pow]
  rw [intervalIntegral.integral_const_mul]
  rw [integral_id]
  norm_num

/-- The first moment of the leading centered cell also vanishes. -/
theorem f0_first_moment : (∫ r in (0 : ℝ)..1, r * f0 r) = 0 := by
  have hfun : (fun r : ℝ => r * f0 r) =
      (fun r : ℝ => (-1 / 2 : ℝ) * r ^ 3 + (1 / 2 : ℝ) * r ^ 2 +
        (-1 / 12 : ℝ) * r) := by
    funext r
    dsimp [f0]
    ring
  rw [hfun]
  rw [intervalIntegral.integral_add (by apply Continuous.intervalIntegrable; fun_prop)
    (by apply Continuous.intervalIntegrable; fun_prop)]
  rw [intervalIntegral.integral_add (by apply Continuous.intervalIntegrable; fun_prop)
    (by apply Continuous.intervalIntegrable; fun_prop)]
  simp [intervalIntegral.integral_const_mul, integral_pow]
  rw [intervalIntegral.integral_const_mul]
  rw [integral_id]
  norm_num

private theorem integral_poly4 (a b c d e : ℝ) :
    (∫ r in (0 : ℝ)..1,
      a * r ^ 4 + b * r ^ 3 + c * r ^ 2 + d * r + e) =
        a / 5 + b / 4 + c / 3 + d / 2 + e := by
  rw [intervalIntegral.integral_add (by apply Continuous.intervalIntegrable; fun_prop)
    (by apply Continuous.intervalIntegrable; fun_prop)]
  rw [intervalIntegral.integral_add (by apply Continuous.intervalIntegrable; fun_prop)
    (by apply Continuous.intervalIntegrable; fun_prop)]
  rw [intervalIntegral.integral_add (by apply Continuous.intervalIntegrable; fun_prop)
    (by apply Continuous.intervalIntegrable; fun_prop)]
  rw [intervalIntegral.integral_add (by apply Continuous.intervalIntegrable; fun_prop)
    (by apply Continuous.intervalIntegrable; fun_prop)]
  simp [intervalIntegral.integral_const_mul, integral_pow]
  rw [intervalIntegral.integral_const_mul, integral_id]
  ring

theorem f0_second_moment :
    (∫ r in (0 : ℝ)..1, r ^ 2 * f0 r) = -(1 / 360 : ℝ) := by
  have hfun : (fun r : ℝ => r ^ 2 * f0 r) =
      (fun r : ℝ => (-1 / 2 : ℝ) * r ^ 4 + (1 / 2 : ℝ) * r ^ 3 +
        (-1 / 12 : ℝ) * r ^ 2 + (0 : ℝ) * r + 0) := by
    funext r
    dsimp [f0]
    ring
  rw [hfun, integral_poly4]
  norm_num

theorem f1_mean : (∫ r in (0 : ℝ)..1, f1 r) = 0 := by
  have hfun : f1 =
      (fun r : ℝ => (0 : ℝ) * r ^ 4 + (5 / 12 : ℝ) * r ^ 3 +
        (-1 / 4 : ℝ) * r ^ 2 + (-1 / 24 : ℝ) * r + 0) := by
    funext r
    dsimp [f1]
    ring
  rw [hfun, integral_poly4]
  norm_num

theorem f1_first_moment :
    (∫ r in (0 : ℝ)..1, r * f1 r) = (1 / 144 : ℝ) := by
  have hfun : (fun r : ℝ => r * f1 r) =
      (fun r : ℝ => (5 / 12 : ℝ) * r ^ 4 + (-1 / 4 : ℝ) * r ^ 3 +
        (-1 / 24 : ℝ) * r ^ 2 + (0 : ℝ) * r + 0) := by
    funext r
    dsimp [f1]
    ring
  rw [hfun, integral_poly4]
  norm_num

theorem f2_mean : (∫ r in (0 : ℝ)..1, f2 r) = -(7 / 576 : ℝ) := by
  have hfun : f2 =
      (fun r : ℝ => (-11 / 32 : ℝ) * r ^ 4 + (1 / 6 : ℝ) * r ^ 3 +
        (1 / 48 : ℝ) * r ^ 2 + (0 : ℝ) * r + (23 / 2880 : ℝ)) := by
    funext r
    dsimp [f2]
    ring
  rw [hfun, integral_poly4]
  norm_num

/-- The exact real coefficient surviving after the two canceled cell moments.
The analytic asymptotic connecting these profiles to the renewal kernel is
proved in the accompanying written note. -/
theorem phase_coefficient_real (z : ℝ) :
    (∫ r in (0 : ℝ)..1,
      f2 r - (z + 1) * r * f1 r +
        ((z + 1) * (z + 2) / 2) * r ^ 2 * f0 r) =
      -((2 * z + 7) * (2 * z + 9)) / 2880 := by
  let A : ℝ := (z + 1) * (z + 2) / 2
  have hfun :
      (fun r : ℝ => f2 r - (z + 1) * r * f1 r + A * r ^ 2 * f0 r) =
      (fun r : ℝ =>
        ((-11 / 32 : ℝ) - (z + 1) * (5 / 12) - A / 2) * r ^ 4 +
        ((1 / 6 : ℝ) + (z + 1) / 4 + A / 2) * r ^ 3 +
        ((1 / 48 : ℝ) + (z + 1) / 24 - A / 12) * r ^ 2 +
        (0 : ℝ) * r + 23 / 2880) := by
    funext r
    dsimp [f0, f1, f2]
    ring
  change (∫ r in (0 : ℝ)..1, f2 r - (z + 1) * r * f1 r + A * r ^ 2 * f0 r) = _
  rw [hfun, integral_poly4]
  dsimp [A]
  ring

#print axioms f0_mean
#print axioms f0_first_moment
#print axioms f0_second_moment
#print axioms f1_mean
#print axioms f1_first_moment
#print axioms f2_mean
#print axioms phase_coefficient_real

end BuildingBlocks.RenewalBernoulliCellMoments
