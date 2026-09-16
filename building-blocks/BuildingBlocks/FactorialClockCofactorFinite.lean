import Mathlib.Tactic

/-!
# Finite cumulative factorial-clock cofactor

This module proves the exact finite telescoping behind the cumulative
compensated-clock admission. Identification of each admission with the
improper factorial-density integral, Binet's integral and its complex
Dirichlet estimate remain analytic obligations.
-/

namespace BuildingBlocks.FactorialClockCofactorFinite

open Finset

noncomputable section

/-- The Stirling entropy deficit, with its arithmetic endpoint at zero. -/
def cumulative (n : ℕ) : ℝ :=
  (n : ℝ) - (n : ℝ) * Real.log (n : ℝ) + Real.log (n.factorial : ℝ)

/-- The exact one-step clock admission, including the first endpoint. -/
def admission (n : ℕ) : ℝ :=
  if n = 0 then 0 else if n = 1 then 1 else
    1 - ((n - 1 : ℕ) : ℝ) * Real.log ((n : ℝ) / ((n - 1 : ℕ) : ℝ))

theorem cumulative_zero : cumulative 0 = 0 := by
  simp [cumulative]

theorem cumulative_one : cumulative 1 = 1 := by
  simp [cumulative]

theorem cumulative_succ_sub (n : ℕ) (hn : 0 < n) :
    cumulative (n + 1) - cumulative n =
      1 - (n : ℝ) * Real.log (((n + 1 : ℕ) : ℝ) / (n : ℝ)) := by
  have hn0 : (n : ℝ) ≠ 0 := by exact_mod_cast Nat.ne_of_gt hn
  have hfac0 : (n.factorial : ℝ) ≠ 0 := by
    exact_mod_cast Nat.factorial_ne_zero n
  have hlogfac :
      Real.log (((n + 1).factorial : ℕ) : ℝ) =
        Real.log ((n + 1 : ℕ) : ℝ) + Real.log (n.factorial : ℝ) := by
    rw [Nat.factorial_succ]
    push_cast
    rw [Real.log_mul (by positivity) hfac0]
  have hlogdiv := Real.log_div
    (by positivity : (((n + 1 : ℕ) : ℝ) ≠ 0)) hn0
  dsimp [cumulative]
  rw [hlogfac, hlogdiv]
  push_cast
  ring

theorem admission_succ (n : ℕ) (hn : 0 < n) :
    admission (n + 1) =
      1 - (n : ℝ) * Real.log (((n + 1 : ℕ) : ℝ) / (n : ℝ)) := by
  simp [admission, hn.ne']

theorem cumulative_eq_admissions (n : ℕ) :
    cumulative n = ∑ j ∈ range n, admission (j + 1) := by
  induction n with
  | zero => simp [cumulative_zero]
  | succ n ih =>
    rw [sum_range_succ, ← ih]
    by_cases hn : n = 0
    · subst n
      simp [cumulative_one, cumulative_zero, admission]
    · have hnp : 0 < n := Nat.pos_of_ne_zero hn
      rw [admission_succ n hnp, ← cumulative_succ_sub n hnp]
      ring

end

#print axioms cumulative_zero
#print axioms cumulative_one
#print axioms cumulative_succ_sub
#print axioms admission_succ
#print axioms cumulative_eq_admissions
end BuildingBlocks.FactorialClockCofactorFinite
