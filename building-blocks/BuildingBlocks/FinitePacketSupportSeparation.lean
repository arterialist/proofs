import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.Tactic

open Finset
open scoped BigOperators

namespace BuildingBlocks.FinitePacketSupportSeparation

/-- Literal finite real packet array, including both endpoint coefficients. -/
noncomputable def array (eta : ℝ → ℝ) (c : ℕ → ℝ) (N : ℕ) (L u : ℝ) : ℝ :=
  ∑ j ∈ range (N + 1), c j * eta (u - (j : ℝ) * L)

theorem array_first (eta : ℝ → ℝ) (c : ℕ → ℝ) (N : ℕ) (L : ℝ)
    (hL : 0 < L) (hz : ∀ v, L ≤ |v| → eta v = 0) :
    array eta c N L 0 = c 0 * eta 0 := by
  unfold array
  rw [Finset.sum_eq_single 0]
  · simp
  · intro j hj hj0
    have hj1 : (1 : ℝ) ≤ (j : ℝ) := by exact_mod_cast (by omega : 1 ≤ j)
    have hp : 0 ≤ (j : ℝ) * L := mul_nonneg (Nat.cast_nonneg j) hL.le
    rw [hz _ (by simp only [zero_sub, abs_neg, abs_of_nonneg hp]; nlinarith)]
    simp
  · simp

theorem array_last (eta : ℝ → ℝ) (c : ℕ → ℝ) (N : ℕ) (L : ℝ)
    (hL : 0 < L) (hz : ∀ v, L ≤ |v| → eta v = 0) :
    array eta c N L ((N : ℝ) * L) = c N * eta 0 := by
  unfold array
  rw [Finset.sum_eq_single N]
  · simp
  · intro j hj hjN
    have hgap : (j : ℝ) + 1 ≤ (N : ℝ) := by
      exact_mod_cast (by have h := mem_range.mp hj; omega : j + 1 ≤ N)
    have hp : 0 ≤ (N : ℝ) * L - (j : ℝ) * L := by nlinarith
    rw [hz _ (by rw [abs_of_nonneg hp]; nlinarith)]
    simp
  · simp

/-- Every translated support interval must contain the two nonzero endpoint packets. -/
theorem translated_interval_length (eta : ℝ → ℝ) (c : ℕ → ℝ) (N : ℕ)
    (L shift a b : ℝ) (hL : 0 < L) (hz : ∀ v, L ≤ |v| → eta v = 0)
    (he : eta 0 ≠ 0) (hc0 : c 0 = 1) (hcN : c N = 1)
    (hcover : ∀ u, array eta c N L u ≠ 0 → a ≤ u + shift ∧ u + shift ≤ b) :
    (N : ℝ) * L ≤ b - a := by
  have hfirst : array eta c N L 0 ≠ 0 := by rw [array_first eta c N L hL hz, hc0, one_mul]; exact he
  have hlast : array eta c N L ((N : ℝ) * L) ≠ 0 := by
    rw [array_last eta c N L hL hz, hcN, one_mul]; exact he
  have ha := (hcover 0 hfirst).1
  have hb := (hcover ((N : ℝ) * L) hlast).2
  linarith

/-- Coefficients (1,h-1,h,...,h,h-1,1) of the written q-flat family. -/
noncomputable def qFlatCoefficient (J : ℕ) (h : ℝ) (j : ℕ) : ℝ :=
  if j = 0 ∨ j = J + 1 then 1 else if j = 1 ∨ j = J then h - 1 else h

theorem qFlat_endpoints (J : ℕ) (h : ℝ) :
    qFlatCoefficient J h 0 = 1 ∧ qFlatCoefficient J h (J + 1) = 1 := by
  simp [qFlatCoefficient]

/-- No translated q-flat carrier fits the reported support-1.6 window. -/
theorem qFlat_not_small_window (eta : ℝ → ℝ) (J : ℕ) (h shift : ℝ)
    (hJ : 3 ≤ J) (he : eta 0 ≠ 0)
    (hz : ∀ v, Real.log 2 ≤ |v| → eta v = 0) :
    ¬ (∀ u, array eta (qFlatCoefficient J h) (J + 1) (Real.log 2) u ≠ 0 →
      -(4 / 5 : ℝ) ≤ u + shift ∧ u + shift ≤ (4 / 5 : ℝ)) := by
  intro hcover
  have heps := qFlat_endpoints J h
  have hl : (1 / 2 : ℝ) < Real.log 2 := by
    have hlog := Real.log_two_gt_d9
    linarith
  have hlength := translated_interval_length eta (qFlatCoefficient J h) (J + 1)
    (Real.log 2) shift (-(4 / 5 : ℝ)) (4 / 5 : ℝ) (by linarith) hz he
    heps.1 heps.2 hcover
  have hN : (4 : ℝ) ≤ ((J + 1 : ℕ) : ℝ) := by exact_mod_cast (by omega : 4 ≤ J + 1)
  nlinarith

#print axioms qFlat_endpoints
#print axioms qFlat_not_small_window
#print axioms array_first
#print axioms array_last
#print axioms translated_interval_length

end BuildingBlocks.FinitePacketSupportSeparation
