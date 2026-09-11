import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Tactic.Linarith
import Lean.Elab.Tactic.Omega

namespace BuildingBlocks

/-- Both nonunit parts of a coprime factorization force the actual
von Mangoldt source to vanish. -/
theorem vonMangoldt_coprime_mul_eq_zero {a b : ℕ} (hab : a.Coprime b)
    (ha : a ≠ 1) (hb : b ≠ 1) :
    ArithmeticFunction.vonMangoldt (a * b) = 0 := by
  apply ArithmeticFunction.vonMangoldt_eq_zero_iff.mpr
  intro hp
  have ha0 : 0 < a := Nat.pos_of_ne_zero (fun h => hp.ne_zero (by simp [h]))
  have hb0 : 0 < b := Nat.pos_of_ne_zero (fun h => hp.ne_zero (by simp [h]))
  have ha2 : 2 ≤ a := by omega
  have hb2 : 2 ≤ b := by omega
  rcases (hab.isPrimePow_dvd_mul hp).mp (dvd_refl (a * b)) with h | h
  · have hh := Nat.le_of_dvd ha0 h
    nlinarith
  · have hh := Nat.le_of_dvd hb0 h
    nlinarith

/-- Exact readout for the coprime smooth/rough factorization.
This includes the unit input and all proper prime powers.
Only coprimality is needed for the algebraic identity. -/
theorem vonMangoldt_coprime_factor_readout {a b : ℕ} (hab : a.Coprime b) :
    ArithmeticFunction.vonMangoldt (a * b) =
      (if b = 1 then ArithmeticFunction.vonMangoldt a else 0) +
      (if a = 1 then ArithmeticFunction.vonMangoldt b else 0) := by
  by_cases ha : a = 1
  · subst a
    simp
  by_cases hb : b = 1
  · subst b
    simp
  simp [ha, hb, vonMangoldt_coprime_mul_eq_zero hab ha hb]

/-- Deleting a large smooth part removes actual von Mangoldt mass only
when the rough part is one. No event-count hypothesis is used. -/
theorem vonMangoldt_deleted_coprime_factor {a b D : ℕ} (hab : a.Coprime b)
    (hD : 1 ≤ D) :
    (if D < a then ArithmeticFunction.vonMangoldt (a * b) else 0) =
      if D < a ∧ b = 1 then ArithmeticFunction.vonMangoldt a else 0 := by
  by_cases hDa : D < a
  · have ha : a ≠ 1 := by omega
    rw [if_pos hDa, vonMangoldt_coprime_factor_readout hab]
    simp [hDa, ha]
  · simp [hDa]

end BuildingBlocks
