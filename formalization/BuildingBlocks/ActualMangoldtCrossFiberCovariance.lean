import Mathlib

/-!
# Exponent ledger for the complete Mangoldt cross-fiber covariance

The exact divisor-fiber identity is formalized in
`ActualMobiusHistoryCrossSum`. This module checks the endpoint target,
large-sieve loss, determinant-cell length, and aligned-twist obstruction.
The analytic covariance estimates are written inputs.
-/

namespace BuildingBlocks.ActualMangoldtCrossFiberCovariance

noncomputable section

def p (lambda : ℝ) : ℝ := 1 - 2 * lambda / 5
def q (lambda : ℝ) : ℝ := lambda / 5

theorem physical_scale (lambda : ℝ) :
    p lambda + 2 * q lambda = 1 := by
  simp [p, q]
  ring

/-- The equal-slope covariance `P Q^3` lies a full factor `T` below the
squared zero-saving target `P^2 Q^5`. -/
theorem diagonal_saving_exponent (lambda : ℝ) :
    (2 * p lambda + 5 * q lambda) -
        (p lambda + 3 * q lambda) = 1 := by
  rw [← physical_scale lambda]
  ring

/-- The coefficient-blind bound `P Q^6` exceeds the squared endpoint
`P^2 Q^5` by `Q/P`. -/
theorem coefficient_blind_loss (lambda : ℝ) :
    (p lambda + 6 * q lambda) -
        (2 * p lambda + 5 * q lambda) =
      q lambda - p lambda := by
  ring

theorem coefficient_blind_loss_in_T (lambda : ℝ) :
    q lambda - p lambda = 3 * lambda / 5 - 1 := by
  simp [p, q]
  ring

theorem coefficient_blind_loss_pos {lambda : ℝ} (hlow : 5 / 3 < lambda) :
    0 < q lambda - p lambda := by
  rw [coefficient_blind_loss_in_T]
  linarith

/-- The coprime determinant phase cells have length `Q/P^2`. -/
theorem phase_cell_exponent (lambda : ℝ) :
    q lambda - 2 * p lambda = lambda - 2 := by
  simp [p, q]
  ring

theorem phase_cell_grows {lambda : ℝ} (hlow : 2 < lambda) :
    0 < q lambda - 2 * p lambda := by
  rw [phase_cell_exponent]
  linarith

theorem phase_cell_below_one_fourteenth {lambda : ℝ}
    (hhigh : lambda < 29 / 14) :
    q lambda - 2 * p lambda < 1 / 14 := by
  rw [phase_cell_exponent]
  linarith

/-- The phase-aligned twist has covariance `Q^6`; relative to the squared
endpoint its excess is `Q/P^2`. -/
theorem aligned_twist_excess (lambda : ℝ) :
    6 * q lambda - (2 * p lambda + 5 * q lambda) =
      q lambda - 2 * p lambda := by
  ring

end
end BuildingBlocks.ActualMangoldtCrossFiberCovariance
