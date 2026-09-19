import Mathlib.Tactic

/-!
# Exponent ledger for the critical semiprime alias-dispersion target

This module checks the scale identities and normalization gaps in the
companion private note. It does not formalize Poisson summation or prove the
required exponential-sum estimate.
-/

namespace BuildingBlocks.ActualMobiusCriticalSemiprimeAliasDispersion

theorem critical_scale_ledger (lambda : ℝ) :
    let p := 1 - 2 * lambda / 5
    let q := lambda / 5
    let c := 4 * lambda / 5 - 1
    let d := 3 * lambda / 5
    c + p = 2 * q ∧ d = c + p + q ∧ d = 3 * q ∧ lambda = 5 * q := by
  dsimp
  constructor
  · ring
  constructor
  · ring
  constructor <;> ring

/-- The reciprocal multiplier has exponent `-q`, the alias range has
exponent `2*q`, and Fourier resolution `1/P` becomes displacement thickness
`Q/P`. -/
theorem full_alias_ledger (lambda : ℝ) :
    let p := 1 - 2 * lambda / 5
    let q := lambda / 5
    let d := 3 * lambda / 5
    lambda - 2 * d = -q ∧
      d - q = 2 * q ∧
      2 * d - lambda - p = q - p := by
  dsimp
  constructor
  · ring
  constructor <;> ring

/-- Raw mass, the desired first-moment exponent, and the relative saving
that the critical packet requires. -/
theorem packet_normalization_ledger (lambda : ℝ) :
    let p := 1 - 2 * lambda / 5
    let d := 3 * lambda / 5
    p + d = 1 + lambda / 5 ∧
      p + lambda / 2 = 1 + lambda / 10 ∧
      (p + d) - (p + lambda / 2) = lambda / 10 := by
  dsimp
  constructor
  · ring
  constructor <;> ring

/-- The direct `q=q'` sector has exactly the unsaved target-(B) exponent,
whereas the literal product diagonal is smaller by `Q^2`. -/
theorem targetB_diagonal_ledger (lambda : ℝ) :
    let p := 1 - 2 * lambda / 5
    let q := lambda / 5
    p + q + 2 * (2 * q) = p + 5 * q ∧
      (p + 5 * q) - (p + 3 * q) = 2 * q := by
  dsimp
  constructor <;> ring

/-- The literal product diagonal is smaller than target (C) by one factor
`P`. -/
theorem targetC_diagonal_ledger (lambda : ℝ) :
    let p := 1 - 2 * lambda / 5
    let q := lambda / 5
    (2 * p + 3 * q) - (p + 3 * q) = p := by
  dsimp
  ring

/-- The first term in Cao--Zhai Theorem 6 misses the first-moment target in
the orientation with the short reciprocal variable distinguished. -/
theorem cao_zhai_short_orientation_excess (lambda : ℝ) :
    (3 * lambda + 5) / 8 - (1 + lambda / 10) =
      (11 * lambda - 15) / 40 := by
  ring

/-- Swapping the two reciprocal variables also misses the target. -/
theorem cao_zhai_long_orientation_excess (lambda : ℝ) :
    (9 * lambda + 35) / 40 - (1 + lambda / 10) =
      (lambda - 1) / 8 := by
  ring

theorem cao_zhai_excesses_positive (lambda : ℝ) (h : 2 < lambda) :
    0 < (11 * lambda - 15) / 40 ∧ 0 < (lambda - 1) / 8 := by
  constructor <;> nlinarith

/-- For the actual prime `q` fiber, the collective-sampling residual bound
`P Q^4` improves the unsaved target `P Q^5` by one factor `Q`. -/
theorem residual_sampling_gain (lambda : ℝ) :
    let p := 1 - 2 * lambda / 5
    let q := lambda / 5
    (p + 5 * q) - (p + 4 * q) = lambda / 5 := by
  dsimp
  ring

theorem residual_sampling_gain_positive (lambda : ℝ) (h : 2 < lambda) :
    0 < lambda / 5 := by
  nlinarith

/-- The actual-prime continuous-sampling estimate is stronger than the
alternative `Q^5` estimate by `Q/P`. -/
theorem sampling_vs_fixedQ (lambda : ℝ) :
    let p := 1 - 2 * lambda / 5
    let q := lambda / 5
    5 * q - (p + 4 * q) = 3 * lambda / 5 - 1 := by
  dsimp
  ring

/-- Enlarging the prime `q` fiber to arbitrary integers can cost a factor
`P` from repeated reduced fractions, leaving the weaker `P^2 Q^4` bound. -/
theorem compositeQ_majorant_gain (lambda : ℝ) :
    let p := 1 - 2 * lambda / 5
    let q := lambda / 5
    (p + 5 * q) - (2 * p + 4 * q) = 3 * lambda / 5 - 1 := by
  dsimp
  ring

/-- The unsigned two-parameter local-density bound `Q^6` exceeds target
`P Q^5` by exactly the same critical exponent `q-p`. -/
theorem offDiagonal_schur_deficit (lambda : ℝ) :
    let p := 1 - 2 * lambda / 5
    let q := lambda / 5
    6 * q - (p + 5 * q) = 3 * lambda / 5 - 1 := by
  dsimp
  ring

end BuildingBlocks.ActualMobiusCriticalSemiprimeAliasDispersion
