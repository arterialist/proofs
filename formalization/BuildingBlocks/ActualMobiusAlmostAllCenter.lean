/-
Copyright (c) 2026 Andrew. All rights reserved.
Released under the MIT license as described in the file LICENSE.

Exponent algebra for the almost-all-center short-interval Möbius slice.

Written source:
../../building-blocks/weil-and-spectral/actual-mobius-tail-almost-all-center-small-n.md.

This file does not formalize the cited short-interval theorem, measure
averaging, partial summation, or any asymptotic Möbius estimate.
-/
import Mathlib

namespace BuildingBlocks.ActualMobiusAlmostAllCenter

/-- Largest outer-variable exponent for which the inner Möbius interval
meets the source theorem's lower length exponent one third plus epsilon. -/
noncomputable def smallNThreshold (lambda epsilon : ℝ) : ℝ :=
  lambda - 1 / (2 / 3 - epsilon)

/-- At the threshold, the inner interval exponent and the required
short-interval exponent agree exactly. -/
theorem threshold_balance {lambda epsilon : ℝ} (hden : 2 / 3 - epsilon ≠ 0) :
    lambda - 1 - smallNThreshold lambda epsilon =
      (1 / 3 + epsilon) * (lambda - smallNThreshold lambda epsilon) := by
  have hkey : 1 / (2 / 3 - epsilon) - 1 =
      (1 / 3 + epsilon) * (1 / (2 / 3 - epsilon)) := by
    rw [div_eq_mul_inv]
    simp only [one_mul]
    calc
      (2 / 3 - epsilon)⁻¹ - 1 =
          (1 - (2 / 3 - epsilon)) * (2 / 3 - epsilon)⁻¹ := by
            rw [sub_mul, one_mul, mul_inv_cancel₀ hden]
      _ = (1 / 3 + epsilon) * (2 / 3 - epsilon)⁻¹ := by ring
  unfold smallNThreshold
  linarith

/-- Below the threshold, the physical inner interval is strictly longer
than the source theorem's lower boundary in exponent coordinates. -/
theorem lower_shortInterval_margin {lambda epsilon z : ℝ}
    (hden : 0 < 2 / 3 - epsilon)
    (hz : z < smallNThreshold lambda epsilon) :
    (1 / 3 + epsilon) * (lambda - z) < lambda - 1 - z := by
  have hz' : 1 / (2 / 3 - epsilon) < lambda - z := by
    unfold smallNThreshold at hz
    linarith
  have hmul := (div_lt_iff₀ hden).mp hz'
  nlinarith

/-- A sufficient upper-length condition throughout nonnegative outer
exponents. -/
theorem upper_shortInterval_margin {lambda epsilon z : ℝ}
    (he : 0 ≤ epsilon) (hz : 0 ≤ z) (hel : epsilon * lambda ≤ 1) :
    lambda - 1 - z ≤ (1 - epsilon) * (lambda - z) := by
  have hprod : epsilon * (lambda - z) ≤ 1 := by
    nlinarith [mul_nonneg he hz]
  nlinarith

theorem threshold_at_epsilon_zero (lambda : ℝ) :
    smallNThreshold lambda 0 = lambda - 3 / 2 := by
  unfold smallNThreshold
  norm_num

theorem critical_threshold :
    smallNThreshold 2 0 = 1 / 2 := by
  rw [threshold_at_epsilon_zero]
  norm_num

end BuildingBlocks.ActualMobiusAlmostAllCenter
