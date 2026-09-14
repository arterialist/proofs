import Mathlib.Data.Real.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

/-!
# Algebraic audit for the literal Goldbach successor transfer

This file records the endpoint escape probability and the complete rank-one
compensation identity.  It deliberately keeps the `κ ^ 2` term.
-/

namespace BuildingBlocks.GoldbachSuccessorTransfer

/-- Escape probability at first contact `s = m + n`. -/
noncomputable def contactEscape (m n : ℝ) : ℝ :=
  1 / m + 1 / n - 1 / (m * n)

/-- The initial pair atom and the contact escape exhaust total mass one. -/
theorem contactEscape_add_initialMass {m n : ℝ} (hm : m ≠ 0) (hn : n ≠ 0) :
    contactEscape m n + (1 - 1 / m) * (1 - 1 / n) = 1 := by
  dsimp [contactEscape]
  field_simp
  ring

/-- At a genuine arithmetic endpoint, the contact escape is nonnegative. -/
theorem contactEscape_nonneg {m n : ℝ} (hm : 1 ≤ m) (hn : 1 ≤ n) :
    0 ≤ contactEscape m n := by
  have hm0 : 0 < m := lt_of_lt_of_le zero_lt_one hm
  have hn0 : 0 < n := lt_of_lt_of_le zero_lt_one hn
  rw [show contactEscape m n = (m + n - 1) / (m * n) by
    dsimp [contactEscape]
    field_simp
    ring]
  exact div_nonneg (by linarith) (mul_nonneg hm0.le hn0.le)

/-- At first contact, escape cannot exceed the total probability mass. -/
theorem contactEscape_le_one {m n : ℝ} (hm : 1 ≤ m) (hn : 1 ≤ n) :
    contactEscape m n ≤ 1 := by
  have hm0 : m ≠ 0 := ne_of_gt (lt_of_lt_of_le zero_lt_one hm)
  have hn0 : n ≠ 0 := ne_of_gt (lt_of_lt_of_le zero_lt_one hn)
  rw [← contactEscape_add_initialMass hm0 hn0]
  have hmi : 0 ≤ 1 - 1 / m := by
    rw [sub_nonneg]
    exact (div_le_one (lt_of_lt_of_le zero_lt_one hm)).2 hm
  have hni : 0 ≤ 1 - 1 / n := by
    rw [sub_nonneg]
    exact (div_le_one (lt_of_lt_of_le zero_lt_one hn)).2 hn
  nlinarith [mul_nonneg hmi hni]

/-- Squaring the compensated port retains both cross terms and its square. -/
theorem compensation_square (x κ : ℝ) :
    (x - κ) ^ 2 = x ^ 2 - 2 * κ * x + κ ^ 2 := by
  ring

/-- Exact cumulative compensated pair defect. -/
noncomputable def compensatedDefect
    (escape psi : ℝ → ℝ) (κ X : ℝ) : ℝ :=
  -escape X - 2 * κ * ((X - 1) / X) * psi X + κ ^ 2

/-- Normalization by `X` keeps the rank-one square visible. -/
theorem compensatedDefect_div
    (escape psi : ℝ → ℝ) (κ X : ℝ) (hX : X ≠ 0) :
    compensatedDefect escape psi κ X / X =
      -escape X / X
        - 2 * κ * ((X - 1) / X) * (psi X / X)
        + κ ^ 2 / X := by
  dsimp [compensatedDefect]
  field_simp

end BuildingBlocks.GoldbachSuccessorTransfer
