import Mathlib.Tactic

/-!
# Scale algebra for the all-unit real-center mean square

These lemmas check only exponent identities and margins. The analytic
maximal inequality, packet variation bound, and van der Corput
transform in the accompanying note are written mathematics, not
Lean-formalized here.
-/

namespace BuildingBlocks.ActualMobiusAllUnitRealCenterScale

theorem scale (lambda : ℝ) :
    let p := (5 - 2 * lambda) / 5
    let q := lambda / 5
    p + 2 * q = 1 := by
  dsimp
  ring

theorem range (lambda : ℝ)
    (hlow : 2 < lambda) (hhigh : lambda < 29 / 14) :
    let p := (5 - 2 * lambda) / 5
    let q := lambda / 5
    6 / 35 < p ∧ p < 1 / 5 ∧ p < q := by
  dsimp
  constructor
  · nlinarith
  constructor <;> nlinarith

/-- The direct dual-row real-center mean square saves one full factor P
relative to the original full-Gram baseline, at the exponent level. -/
theorem averaged_margin (p q : ℝ) :
    (3 * p + 3 * q) - (2 * p + 3 * q) = p := by
  ring

/-- On a P^(-delta) window, a target T^(-2*rho) is below the averaged
bound when 2*rho < (1-delta)*p. This is just exponent arithmetic. -/
theorem shrinking_window_margin (p q delta rho : ℝ)
    (hrho : 2 * rho < (1 - delta) * p) :
    (2 + delta) * p + 3 * q <
      3 * p + 3 * q - 2 * rho := by
  nlinarith

/-- The squared hard-endpoint transform error P^3 Q^2 is smaller than
the averaged principal scale P^2 Q^3 when P < Q. -/
theorem endpoint_error_margin (p q : ℝ) (hpq : p < q) :
    3 * p + 2 * q < 2 * p + 3 * q := by
  linarith

end BuildingBlocks.ActualMobiusAllUnitRealCenterScale
