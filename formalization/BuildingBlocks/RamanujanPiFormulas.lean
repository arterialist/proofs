/-
Copyright (c) 2026 Andrew. All rights reserved.
Released under the MIT license as described in the file LICENSE.

Formalization of Srinivasa Ramanujan's Hypergeometric Series for $1/\pi$ (Paper 6, 1914),
Positivity of Terms, and the Initial Rational Approximation.
-/
import Mathlib.Data.Nat.Factorial.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real

namespace BuildingBlocks.RamanujanPiFormulas

/-! ### 1. Ramanujan's Series Terms -/

/-- General term of Ramanujan's 1914 $1/\pi$ series (Paper 6):
    $u_k = \frac{(4k)!(1103 + 26390k)}{(k!)^4 396^{4k}}$. -/
noncomputable def ramanujanPiTerm (k : ℕ) : ℝ :=
  ((Nat.factorial (4 * k) : ℝ) * (1103 + 26390 * (k : ℝ))) /
  (((Nat.factorial k : ℝ)^4) * (396 : ℝ)^(4 * k))

/-- The normalizing factor $C = \frac{2\sqrt{2}}{9801}$. -/
noncomputable def ramanujanPiPrefactor : ℝ :=
  (2 * Real.sqrt 2) / 9801

/-! ### 2. Positivity Properties -/

/-- The term coefficient $1103 + 26390k$ is strictly positive for all $k \ge 0$. -/
theorem ramanujan_pi_coeff_pos (k : ℕ) :
    0 < 1103 + 26390 * (k : ℝ) := by
  have hk : 0 ≤ (k : ℝ) := Nat.cast_nonneg k
  linarith

/-- The factorial term $(4k)!$ is strictly positive for all $k \ge 0$. -/
theorem ramanujan_pi_factorial_pos (k : ℕ) :
    0 < (Nat.factorial (4 * k) : ℝ) := by
  exact Nat.cast_pos.mpr (Nat.factorial_pos (4 * k))

/-- Every term of Ramanujan's series is strictly positive. -/
theorem ramanujan_pi_term_pos (k : ℕ) :
    0 < ramanujanPiTerm k := by
  dsimp [ramanujanPiTerm]
  have hnum : 0 < (Nat.factorial (4 * k) : ℝ) * (1103 + 26390 * (k : ℝ)) :=
    mul_pos (ramanujan_pi_factorial_pos k) (ramanujan_pi_coeff_pos k)
  have hden_fact : 0 < ((Nat.factorial k : ℝ)^4) := by
    have : 0 < (Nat.factorial k : ℝ) := Nat.cast_pos.mpr (Nat.factorial_pos k)
    positivity
  have hden_pow : 0 < (396 : ℝ)^(4 * k) := by positivity
  have hden : 0 < ((Nat.factorial k : ℝ)^4) * (396 : ℝ)^(4 * k) :=
    mul_pos hden_fact hden_pow
  exact div_pos hnum hden

/-- The zero-th term evaluates to exactly 1103. -/
theorem ramanujan_pi_term_zero :
    ramanujanPiTerm 0 = 1103 := by
  dsimp [ramanujanPiTerm]
  simp

/-- The series prefactor $2\sqrt{2}/9801$ is strictly positive. -/
theorem ramanujan_pi_prefactor_pos :
    0 < ramanujanPiPrefactor := by
  dsimp [ramanujanPiPrefactor]
  have hsqrt2 : 0 < Real.sqrt 2 := Real.sqrt_pos.mpr (by norm_num)
  have hnum : 0 < 2 * Real.sqrt 2 := mul_pos (by norm_num) hsqrt2
  exact div_pos hnum (by norm_num)

end BuildingBlocks.RamanujanPiFormulas

#print axioms BuildingBlocks.RamanujanPiFormulas.ramanujan_pi_coeff_pos
#print axioms BuildingBlocks.RamanujanPiFormulas.ramanujan_pi_factorial_pos
#print axioms BuildingBlocks.RamanujanPiFormulas.ramanujan_pi_term_pos
#print axioms BuildingBlocks.RamanujanPiFormulas.ramanujan_pi_term_zero
#print axioms BuildingBlocks.RamanujanPiFormulas.ramanujan_pi_prefactor_pos
