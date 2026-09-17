import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Algebra.Group.Nat.Even

/-!
# Adjacent von Mangoldt atoms and the even prime-power channel

The external successor step cannot connect two nonzero von Mangoldt
weights unless one of the adjacent integers is a power of two. This
keeps every proper prime power in the exact finite statement.
-/

namespace BuildingBlocks.SuccessorMangoldtParity

open scoped ArithmeticFunction

private theorem even_prime_power_is_two_power {n : ℕ}
    (hn : IsPrimePow n) (he : Even n) :
    ∃ k : ℕ, 0 < k ∧ n = 2 ^ k := by
  rcases (isPrimePow_nat_iff n).mp hn with ⟨p, k, hp, hk, hpk⟩
  have hep : Even p := by
    apply (Nat.even_pow' hk.ne').mp
    simpa only [hpk] using he
  have hp2 : p = 2 := (Nat.Prime.even_iff hp).mp hep
  exact ⟨k, hk, by simpa [hp2] using hpk.symm⟩

/-- The surviving even factor carries the exact von Mangoldt weight,
    including every proper power of two. -/
theorem vonMangoldt_two_pow {k : ℕ} (hk : 0 < k) :
    ArithmeticFunction.vonMangoldt (2 ^ k) = Real.log 2 := by
  simpa only [Nat.cast_ofNat] using
    (ArithmeticFunction.vonMangoldt_apply_pow hk.ne').trans
      (ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two)

/-- Every nonzero adjacent von Mangoldt product has a power-of-two
    endpoint. This includes the proper-power arrivals `4, 8, ...`. -/
theorem adjacent_vonMangoldt_support {n : ℕ}
    (h : ArithmeticFunction.vonMangoldt n *
      ArithmeticFunction.vonMangoldt (n + 1) ≠ 0) :
    (∃ k : ℕ, 0 < k ∧ n = 2 ^ k) ∨
      (∃ k : ℕ, 0 < k ∧ n + 1 = 2 ^ k) := by
  have hn0 : ArithmeticFunction.vonMangoldt n ≠ 0 := by
    intro hz
    exact h (by simp [hz])
  have hs0 : ArithmeticFunction.vonMangoldt (n + 1) ≠ 0 := by
    intro hz
    exact h (by simp [hz])
  have hn : IsPrimePow n := ArithmeticFunction.vonMangoldt_ne_zero_iff.mp hn0
  have hs : IsPrimePow (n + 1) :=
    ArithmeticFunction.vonMangoldt_ne_zero_iff.mp hs0
  by_cases he : Even n
  · exact Or.inl (even_prime_power_is_two_power hn he)
  · exact Or.inr (even_prime_power_is_two_power hs
      ((Nat.even_add_one).mpr he))

/-- The exact zero statement used to filter the adjacent prime-power
    channel in the successor-weighted zero trace. -/
theorem adjacent_vonMangoldt_eq_zero {n : ℕ}
    (h : ¬((∃ k : ℕ, 0 < k ∧ n = 2 ^ k) ∨
      (∃ k : ℕ, 0 < k ∧ n + 1 = 2 ^ k))) :
    ArithmeticFunction.vonMangoldt n *
      ArithmeticFunction.vonMangoldt (n + 1) = 0 := by
  by_contra hn
  exact h (adjacent_vonMangoldt_support hn)

end BuildingBlocks.SuccessorMangoldtParity

#print axioms BuildingBlocks.SuccessorMangoldtParity.adjacent_vonMangoldt_support
#print axioms BuildingBlocks.SuccessorMangoldtParity.adjacent_vonMangoldt_eq_zero
#print axioms BuildingBlocks.SuccessorMangoldtParity.vonMangoldt_two_pow
