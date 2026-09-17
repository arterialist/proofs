import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Tactic
import Mathlib.Algebra.Ring.Parity

open scoped BigOperators

namespace BuildingBlocks.GoldbachOddCentering

noncomputable def d (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n - 1

noncomputable def o (n : ℕ) : ℝ :=
  if Odd n then ArithmeticFunction.vonMangoldt n - 2 else 0

noncomputable def q (n : ℕ) : ℝ :=
  (if Even n then ArithmeticFunction.vonMangoldt n else 0) + (if Odd n then 1 else -1)

theorem coefficient_decomposition (n : ℕ) : d n = o n + q n := by
  rcases Nat.even_or_odd n with he | ho
  · have hn : ¬Odd n := Nat.not_odd_iff_even.mpr he
    simp [d, o, q, he, hn]
    ring
  · have hn : ¬Even n := Nat.not_even_iff_odd.mpr ho
    simp [d, o, q, ho, hn]
    ring

theorem origin_coefficients : d 1 = -1 ∧ o 1 = -2 ∧ q 1 = 1 := by
  norm_num [d, o, q]

/-- Arbitrary finite weighted heat sums retain both explicit correction terms. -/
theorem finite_weighted_heat_decomposition (s : Finset ℕ) (w : ℕ → ℝ) (t : ℝ) :
    (∑ n ∈ s, w n * d n * Real.exp (-(n : ℝ) * t)) =
      (∑ n ∈ s, w n * o n * Real.exp (-(n : ℝ) * t)) +
        ∑ n ∈ s, w n * q n * Real.exp (-(n : ℝ) * t) := by
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n _
  rw [coefficient_decomposition]
  ring

theorem even_nonzero_vonMangoldt {n : ℕ} (he : Even n)
    (hn : ArithmeticFunction.vonMangoldt n ≠ 0) :
    ∃ k : ℕ, 1 ≤ k ∧ n = 2^k ∧ ArithmeticFunction.vonMangoldt n = Real.log 2 := by
  rcases ArithmeticFunction.vonMangoldt_ne_zero_iff.mp hn with ⟨p, k, hp, hk, hpow⟩
  have hd : 2 ∣ p^k := by rw [hpow]; exact he.two_dvd
  have hd2 : 2 ∣ p := Nat.prime_two.dvd_of_dvd_pow hd
  have hp2 : p = 2 := ((Nat.prime_dvd_prime_iff_eq Nat.prime_two hp.nat_prime).mp hd2).symm
  subst p
  refine ⟨k, hk, hpow.symm, ?_⟩
  rw [← hpow, ArithmeticFunction.vonMangoldt_apply_pow (by omega),
    ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two]
  norm_num

theorem even_vonMangoldt_support {n : ℕ} (he : Even n) :
    ArithmeticFunction.vonMangoldt n ≠ 0 ↔ ∃ k : ℕ, 1 ≤ k ∧ n = 2^k := by
  constructor
  · intro hn
    obtain ⟨k, hk, hpow, _⟩ := even_nonzero_vonMangoldt he hn
    exact ⟨k, hk, hpow⟩
  · rintro ⟨k, hk, rfl⟩
    rw [ArithmeticFunction.vonMangoldt_apply_pow (by omega),
      ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two]
    exact (Real.log_pos (by norm_num : (1 : ℝ) < 2)).ne'

#print axioms coefficient_decomposition
#print axioms origin_coefficients
#print axioms finite_weighted_heat_decomposition
#print axioms even_nonzero_vonMangoldt
#print axioms even_vonMangoldt_support

end BuildingBlocks.GoldbachOddCentering
