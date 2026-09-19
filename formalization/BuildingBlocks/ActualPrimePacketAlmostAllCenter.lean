/-
Copyright (c) 2026 Andrew. All rights reserved.
Released under the MIT license as described in the file LICENSE.

Exponent algebra for the almost-all-center Selberg estimate of the complete
actual prime packet.

Written source:
../../building-blocks/weil-and-spectral/actual-prime-packet-selberg-almost-all-center.md.

This file does not formalize the Saffari--Vaughan theorem, Stieltjes
integration, the Schwartz-shell argument, or the proper-power count.
-/
import Mathlib

namespace BuildingBlocks.ActualPrimePacketAlmostAllCenter

/-- Power of `T` in the square-root normalized mean-square envelope
`sqrt(N) / T`, when `N = T^lambda`. -/
noncomputable def averagePrefactorExponent (lambda : ℝ) : ℝ :=
  lambda / 2 - 1

/-- The mean-square prefactor has exponent zero at the critical geometry
`lambda = 2`. -/
theorem critical_prefactor : averagePrefactorExponent 2 = 0 := by
  norm_num [averagePrefactorExponent]

/-- Above the critical geometry the mean-square prefactor grows as a fixed
positive power. -/
theorem prefactor_positive_above_critical {lambda : ℝ} (hlambda : 2 < lambda) :
    0 < averagePrefactorExponent lambda := by
  unfold averagePrefactorExponent
  linarith

/-- For `lambda >= 2` and `epsilon < 1/3`, the physical interval exponent
`lambda - 1` is strictly above the unconditional Selberg threshold
`lambda * (1/6 + epsilon)`. -/
theorem selberg_range_of_critical_or_larger {lambda epsilon : ℝ}
    (hlambda : 2 ≤ lambda) (hepsilon : epsilon < 1 / 3) :
    (1 / 6 + epsilon) * lambda < lambda - 1 := by
  have hhalf : 1 / 6 + epsilon < 1 / 2 := by linarith
  have hlambda_pos : 0 < lambda := lt_of_lt_of_le (by norm_num) hlambda
  have hmul : (1 / 6 + epsilon) * lambda < (1 / 2) * lambda :=
    by simpa [mul_comm] using (mul_lt_mul_iff_right₀ hlambda_pos).2 hhalf
  nlinarith

/-- Power of `T` contributed at the natural packet scale by a zero with real
part `beta`. -/
noncomputable def zeroModeExponent (lambda beta : ℝ) : ℝ :=
  lambda * (beta - 1 / 2) - 1

/-- Exact gap between a single zero-mode exponent and the unconditional
mean-square envelope exponent. -/
theorem zeroMode_sub_prefactor (lambda beta : ℝ) :
    zeroModeExponent lambda beta - averagePrefactorExponent lambda =
      lambda * (beta - 1) := by
  unfold zeroModeExponent averagePrefactorExponent
  ring

/-- Every fixed zero with real part below one lies below this envelope. This
records why the estimate is not an RH-scale exclusion. -/
theorem offline_zero_below_envelope {lambda beta : ℝ}
    (hlambda : 0 < lambda) (hbeta : beta < 1) :
    zeroModeExponent lambda beta < averagePrefactorExponent lambda := by
  rw [← sub_neg]
  rw [zeroMode_sub_prefactor]
  exact mul_neg_of_pos_of_neg hlambda (sub_neg.mpr hbeta)

/-- The elementary proper-power term `T^(-1)` is smaller in power than the
prime mean-square prefactor throughout `lambda >= 2`. -/
theorem proper_power_below_prime_scale {lambda : ℝ} (hlambda : 2 ≤ lambda) :
    (-1 : ℝ) ≤ averagePrefactorExponent lambda := by
  unfold averagePrefactorExponent
  linarith

end BuildingBlocks.ActualPrimePacketAlmostAllCenter
