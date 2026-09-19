import Mathlib.Tactic

/-!
# Exponent ledger for critical prime-fiber sampling

This module checks the scale, saving, and full-shell Cauchy ledgers for the
companion analytic note. It does not formalize the Montgomery--Vaughan
Hilbert inequality or the continuous sampling argument.
-/

namespace BuildingBlocks.ActualMobiusCriticalPrimeFiberSampling

theorem critical_relations (lambda : ℝ) :
    let p := 1 - 2 * lambda / 5
    let q := lambda / 5
    let c := 4 * lambda / 5 - 1
    c + p = 2 * q ∧ c + p + q = 3 * q ∧ lambda = 5 * q := by
  dsimp
  constructor
  · ring
  constructor <;> ring

theorem prime_sample_bound_exponent (lambda : ℝ) :
    let p := 1 - 2 * lambda / 5
    let q := lambda / 5
    p + 4 * q = 1 + 2 * lambda / 5 := by
  dsimp
  ring

/-- `P Q^4` saves one factor `Q` from the target `P Q^5`. -/
theorem prime_sample_gain (lambda : ℝ) :
    let p := 1 - 2 * lambda / 5
    let q := lambda / 5
    (p + 5 * q) - (p + 4 * q) = lambda / 5 := by
  dsimp
  ring

theorem admissible_rho_positive (lambda rho : ℝ)
    (hgain : 2 * rho < lambda / 5) :
    0 < lambda / 10 - rho := by
  nlinarith

/-- Cauchy in the coherent prime variable costs exactly the saved `Q`, so
the resulting full-shell exponent is again the unsaved target. -/
theorem qCauchy_exhausts_gain (lambda : ℝ) :
    let p := 1 - 2 * lambda / 5
    let q := lambda / 5
    q + (p + 4 * q) = p + 5 * q := by
  dsimp
  ring

end BuildingBlocks.ActualMobiusCriticalPrimeFiberSampling
