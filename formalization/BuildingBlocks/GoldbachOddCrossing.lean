import BuildingBlocks.Bridge
import Mathlib.Tactic

/-!
# Odd-lattice sampling of actual prime-error crossings

The complete von Mangoldt source has logarithmically bounded variation
across two consecutive integer arrivals. This finite theorem is the
arithmetic sampling step used with external Littlewood oscillation
results; it makes no global sign-change claim by itself.
-/

namespace BuildingBlocks.GoldbachOddCrossing

noncomputable def E (n : ℕ) : ℝ := BuildingBlocks.psi n - n

private theorem E_step_two (m : ℕ) :
    E (m + 2) - E m =
      ArithmeticFunction.vonMangoldt (m + 1) +
        ArithmeticFunction.vonMangoldt (m + 2) - 2 := by
  unfold E
  rw [show m + 2 = (m + 1) + 1 by omega, BuildingBlocks.psi_succ,
    BuildingBlocks.psi_succ]
  push_cast
  ring

theorem E_step_two_abs_le (m : ℕ) :
    |E (m + 2) - E m| ≤ 2 + 2 * Real.log (m + 2 : ℝ) := by
  rw [E_step_two]
  have ha0 := ArithmeticFunction.vonMangoldt_nonneg (n := m + 1)
  have hb0 := ArithmeticFunction.vonMangoldt_nonneg (n := m + 2)
  have ha1 := ArithmeticFunction.vonMangoldt_le_log (n := m + 1)
  have hb1 := ArithmeticFunction.vonMangoldt_le_log (n := m + 2)
  have hpos1 : (0 : ℝ) < ((m + 1 : ℕ) : ℝ) := by exact_mod_cast (show 0 < m + 1 by omega)
  have hle : Real.log (((m + 1 : ℕ) : ℝ)) ≤ Real.log (((m + 2 : ℕ) : ℝ)) :=
    Real.log_le_log hpos1 (by exact_mod_cast (show m + 1 ≤ m + 2 by omega))
  have hcast : (1 : ℝ) ≤ ((m + 2 : ℕ) : ℝ) := by exact_mod_cast (show 1 ≤ m + 2 by omega)
  have hlog : 0 ≤ Real.log (((m + 2 : ℕ) : ℝ)) := Real.log_nonneg hcast
  simp only [Nat.cast_add, Nat.cast_one, Nat.cast_ofNat] at ha1 hb1 hle hlog
  rw [abs_le]
  constructor <;> nlinarith

/-- A sign crossing between two integer samples of the actual complete
Chebyshev error puts both endpoints within a logarithmic error of zero.
Taking `m` odd gives the parity-aware Goldbach sampling step. -/
theorem two_step_crossing_near_zero (m : ℕ)
    (hcross : (E m ≤ 0 ∧ 0 ≤ E (m + 2)) ∨
      (E (m + 2) ≤ 0 ∧ 0 ≤ E m)) :
    |E m| ≤ 2 + 2 * Real.log (m + 2 : ℝ) ∧
      |E (m + 2)| ≤ 2 + 2 * Real.log (m + 2 : ℝ) := by
  have hstep := E_step_two_abs_le m
  rcases hcross with ⟨h0,h1⟩ | ⟨h0,h1⟩
  · rw [abs_of_nonpos h0, abs_of_nonneg h1]
    rw [abs_of_nonneg (by linarith : 0 ≤ E (m + 2) - E m)] at hstep
    constructor <;> linarith
  · rw [abs_of_nonneg h1, abs_of_nonpos h0]
    rw [abs_of_nonpos (by linarith : E (m + 2) - E m ≤ 0)] at hstep
    constructor <;> linarith

#print axioms E_step_two_abs_le
#print axioms two_step_crossing_near_zero

end BuildingBlocks.GoldbachOddCrossing
