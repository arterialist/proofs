import Mathlib.Tactic

/-!
# Exponent algebra for the global `c * 1` long-free-factor range

This file proves only the rational identities and inequalities used in the
analytic audit. It does not formalize the Robert--Sargos estimate, packet
partial summation, or a bound for the Möbius sum.

The companion note is
`building-blocks/weil-and-spectral/actual-mobius-global-long-free-factor-reduction.md`.
-/

namespace BuildingBlocks.GlobalCOneLongFreeFactor

noncomputable section

def dStar (lambda : ℝ) : ℝ := 2 * (lambda + 1) / 5

def gammaZero (lambda : ℝ) : ℝ := (4 - lambda) / 10

def cutoffU (lambda : ℝ) : ℝ := (42 * lambda - 55) / 126

def exponentOne (lambda delta w : ℝ) : ℝ :=
  (dStar lambda + delta) / 2 - lambda / 4 - w / 4

def exponentTwo (lambda delta w : ℝ) : ℝ :=
  dStar lambda + delta - lambda / 2 - w / 2

def exponentThree (lambda delta : ℝ) : ℝ :=
  dStar lambda + delta - lambda / 2 - 1

theorem exponentOne_eq (lambda delta w : ℝ) :
    exponentOne lambda delta w =
      gammaZero lambda / 2 + delta / 2 - w / 4 := by
  simp [exponentOne, dStar, gammaZero]
  ring

theorem exponentTwo_eq (lambda delta w : ℝ) :
    exponentTwo lambda delta w =
      gammaZero lambda + delta - w / 2 := by
  simp [exponentTwo, dStar, gammaZero]
  ring

theorem exponentThree_eq (lambda delta : ℝ) :
    exponentThree lambda delta = -(1 - gammaZero lambda - delta) := by
  simp [exponentThree, dStar, gammaZero]
  ring

theorem exponent_savings {lambda delta theta w : ℝ}
    (hw : 2 * gammaZero lambda + 2 * delta + theta ≤ w)
    (hthird : delta + theta / 4 ≤ 1 - gammaZero lambda) :
    exponentOne lambda delta w ≤ -theta / 4 ∧
      exponentTwo lambda delta w ≤ -theta / 2 ∧
      exponentThree lambda delta ≤ -theta / 4 := by
  rw [exponentOne_eq, exponentTwo_eq, exponentThree_eq]
  constructor
  · linarith
  constructor <;> linarith

theorem saving_pos {lambda delta theta : ℝ}
    (htheta : 0 < theta)
    (hthird : delta < 1 - gammaZero lambda) :
    0 < min (theta / 4) (1 - gammaZero lambda - delta) := by
  rw [lt_min_iff]
  constructor <;> linarith

theorem q_cutoff_identity (lambda delta theta : ℝ) :
    (dStar lambda + delta) -
        (2 * gammaZero lambda + 2 * delta + theta) =
      (3 * lambda - 2) / 5 - delta - theta := by
  simp [dStar, gammaZero]
  ring

theorem old_cutoff_gap (lambda : ℝ) :
    (3 * lambda - 2) / 5 - 2 * cutoffU lambda =
      (149 - 21 * lambda) / 315 := by
  simp [cutoffU]
  ring

theorem old_cutoff_gap_pos {lambda : ℝ} (hlambda : lambda < 29 / 14) :
    0 < (3 * lambda - 2) / 5 - 2 * cutoffU lambda := by
  rw [old_cutoff_gap]
  nlinarith

theorem strict_extension_of_gap {lambda delta theta : ℝ}
    (hgap : delta + theta < (149 - 21 * lambda) / 315) :
    2 * cutoffU lambda < (3 * lambda - 2) / 5 - delta - theta := by
  rw [show (3 * lambda - 2) / 5 =
      2 * cutoffU lambda + (149 - 21 * lambda) / 315 by
    linarith [old_cutoff_gap lambda]]
  linarith

def collisionExponent (lambda d alpha : ℝ) : ℝ :=
  (3 * d - lambda - 1 - alpha) / 4

theorem balanced_collision (lambda delta w : ℝ) :
    collisionExponent lambda (dStar lambda + delta)
        ((dStar lambda + delta - w) / 2) =
      (5 * delta + w) / 8 := by
  simp [collisionExponent, dStar]
  ring

theorem bounded_t_balanced_collision (lambda delta : ℝ) :
    collisionExponent lambda (dStar lambda + delta)
        ((dStar lambda + delta) / 2) =
      5 * delta / 8 := by
  simpa using balanced_collision lambda delta 0

theorem balanced_threshold_gap (lambda delta : ℝ) :
    (3 * (dStar lambda + delta) - lambda - 1) -
        (dStar lambda + delta) / 2 =
      5 * delta / 2 := by
  simp [dStar]
  ring

end

end BuildingBlocks.GlobalCOneLongFreeFactor
