/-
Copyright (c) 2026 Andrew. All rights reserved.
Released under the MIT license as described in the file LICENSE.

Finite and exponent algebra for the critical Möbius-window reduction.

Written source:
../../building-blocks/weil-and-spectral/actual-mobius-critical-window-log-saving.md.

This file does not formalize the cited short-interval theorem, measure
averaging, bounded-variation transfer, or an analytic little-o estimate.
-/
import Mathlib

namespace BuildingBlocks.ActualMobiusCriticalWindowSaving

open scoped ArithmeticFunction

/-- Exact finite split of a logarithmic weight into its shell-center constant
and bounded relative variation. -/
theorem finiteLogSplit {ι : Type*} (S : Finset ι) (a : ι → ℝ)
    (n : ι → ℝ) {N D : ℝ} (hN : N ≠ 0) (hD : D ≠ 0)
    (hn : ∀ i ∈ S, n i ≠ 0) :
    ∑ i ∈ S, Real.log (n i) * a i =
      Real.log (N / D) * ∑ i ∈ S, a i +
        ∑ i ∈ S, Real.log (n i * D / N) * a i := by
  rw [Finset.mul_sum, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  rw [← add_mul]
  congr 1
  rw [← Real.log_mul (div_ne_zero hN hD) (by
    exact div_ne_zero (mul_ne_zero (hn i hi) hD) hN)]
  congr 1
  field_simp

/-- The complete unlogged product fiber vanishes away from `1`. This is the
finite arithmetic-function form of `sum_{m|r} μ(m)=0`. -/
theorem completeUnloggedFiber_zero {r : ℕ} (hr : 1 < r) :
    ∑ p ∈ r.divisorsAntidiagonal,
        ArithmeticFunction.moebius p.1 = 0 := by
  have hconv := congrArg
    (fun f : ArithmeticFunction ℤ => f r)
    (ArithmeticFunction.coe_moebius_mul_coe_zeta (R := ℤ))
  change
    ((ArithmeticFunction.moebius : ArithmeticFunction ℤ) *
      ArithmeticFunction.zeta) r = (1 : ArithmeticFunction ℤ) r at hconv
  calc
    ∑ p ∈ r.divisorsAntidiagonal,
        ArithmeticFunction.moebius p.1 =
      ∑ p ∈ r.divisorsAntidiagonal,
        ArithmeticFunction.moebius p.1 *
          (ArithmeticFunction.zeta : ArithmeticFunction ℤ) p.2 := by
          apply Finset.sum_congr rfl
          intro p hp
          have hprod := (Nat.mem_divisorsAntidiagonal.mp hp).1
          have hp2 : p.2 ≠ 0 := by
            intro hp20
            rw [hp20, mul_zero] at hprod
            omega
          simp [ArithmeticFunction.zeta_apply, hp2]
    _ = ((ArithmeticFunction.moebius : ArithmeticFunction ℤ) *
          ArithmeticFunction.zeta) r := by
      rw [ArithmeticFunction.mul_apply]
    _ = (1 : ArithmeticFunction ℤ) r := hconv
    _ = 0 := by simp [hr.ne']

/-- Outer-variable exponent `lambda-d` at a product shell `D=T^d`. -/
noncomputable def outerExponent (lambda d : ℝ) : ℝ := lambda - d

/-- Möbius-window exponent `d-1`, since its length is `D/T`. -/
noncomputable def windowExponent (d : ℝ) : ℝ := d - 1

/-- Relative short-interval exponent `(d-1)/d`. -/
noncomputable def relativeWindowExponent (d : ℝ) : ℝ := (d - 1) / d

/-- At `lambda=2`, `d=3/2`, both the outer variable and the Möbius window
have exponent `1/2`. -/
theorem critical_outer_and_window :
    outerExponent 2 (3 / 2) = 1 / 2 ∧
      windowExponent (3 / 2) = 1 / 2 := by
  constructor <;> norm_num [outerExponent, windowExponent]

/-- The exact critical Möbius window has relative length exponent `1/3`. -/
theorem critical_relative_window :
    relativeWindowExponent (3 / 2) = 1 / 3 := by
  norm_num [relativeWindowExponent]

/-- Exponent of `(X/D)(D/T)/sqrt(X)`, the normalization left after summing
outer variables and their Möbius windows. -/
noncomputable def normalizedMassExponent (lambda d : ℝ) : ℝ :=
  (lambda - d) + (d - 1) - lambda / 2

/-- The product-shell exponent cancels identically; only the packet prefactor
`T^(lambda/2-1)` remains. -/
theorem normalizedMassExponent_eq (lambda d : ℝ) :
    normalizedMassExponent lambda d = lambda / 2 - 1 := by
  unfold normalizedMassExponent
  ring

/-- The normalization is scale invariant at the critical geometry. -/
theorem critical_normalized_mass :
    normalizedMassExponent 2 (3 / 2) = 0 := by
  rw [normalizedMassExponent_eq]
  norm_num

/-- Equation (1.6) of the cited source is applicable at the critical window:
its lower exponent `1/6 + epsilon` is below `1/3` whenever
`epsilon < 1/6`. -/
theorem critical_maximal_source_range {epsilon : ℝ}
    (hepsilon : epsilon < 1 / 6) :
    1 / 6 + epsilon < relativeWindowExponent (3 / 2) := by
  rw [critical_relative_window]
  linarith

/-- An estimate with logarithmic exponent `B + 1` absorbs the single
`log T` factor in the exact logged/unlogged shell split. -/
theorem absorb_one_log_exponent (B : ℝ) :
    1 - (B + 1) = -B := by
  ring

end BuildingBlocks.ActualMobiusCriticalWindowSaving
