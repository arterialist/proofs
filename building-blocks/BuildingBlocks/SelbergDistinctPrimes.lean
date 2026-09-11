import Mathlib.NumberTheory.ArithmeticFunction
import BuildingBlocks.SmoothPrimeReadout

open scoped BigOperators

namespace BuildingBlocks


/-- Exactly the same-prime part of the ordered convolution `Λ * Λ`. -/
noncomputable def samePrimePairWeight (n : ℕ) : ℝ :=
  ArithmeticFunction.vonMangoldt n *
    (Real.log (n : ℝ) - ArithmeticFunction.vonMangoldt n)

/-- The remaining ordered pair contribution after removing same-prime histories. -/
noncomputable def distinctPrimePairWeight (n : ℕ) : ℝ :=
  (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n - samePrimePairWeight n

theorem samePrimePairWeight_nonneg (n : ℕ) : 0 ≤ samePrimePairWeight n :=
  mul_nonneg ArithmeticFunction.vonMangoldt_nonneg
    (sub_nonneg.mpr ArithmeticFunction.vonMangoldt_le_log)

theorem samePrimePairWeight_prime_pow {p k : ℕ} (hp : p.Prime) (hk : 1 ≤ k) :
    samePrimePairWeight (p ^ k) = ((k : ℝ) - 1) * Real.log (p : ℝ) ^ 2 := by
  rw [samePrimePairWeight, ArithmeticFunction.vonMangoldt_apply_pow (by omega : k ≠ 0),
    ArithmeticFunction.vonMangoldt_apply_prime hp, Nat.cast_pow, Real.log_pow]
  ring

theorem samePrimePairWeight_eq_zero_of_not_prime_pow {n : ℕ} (hn : ¬IsPrimePow n) :
    samePrimePairWeight n = 0 := by
  simp [samePrimePairWeight, ArithmeticFunction.vonMangoldt_eq_zero_iff.mpr hn]

theorem samePrimePairWeight_eq_zero_unless_proper_power {n : ℕ}
    (hn : ¬∃ p k : ℕ, p.Prime ∧ 2 ≤ k ∧ p ^ k = n) :
    samePrimePairWeight n = 0 := by
  by_cases hpow : IsPrimePow n
  · obtain ⟨p, k, hp, hk, rfl⟩ := (isPrimePow_nat_iff n).mp hpow
    have hk1 : k = 1 := by
      by_contra h
      exact hn ⟨p, k, hp, by omega, rfl⟩
    rw [samePrimePairWeight_prime_pow hp hk, hk1]
    simp
  · exact samePrimePairWeight_eq_zero_of_not_prime_pow hpow

theorem vonMangoldt_convolution_prime_pow {p k : ℕ} (hp : p.Prime) (hk : 1 ≤ k) :
    (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) (p ^ k) =
      ((k : ℝ) - 1) * Real.log (p : ℝ) ^ 2 := by
  cases k with
  | zero => omega
  | succ m =>
    rw [ArithmeticFunction.mul_apply, Nat.sum_divisorsAntidiagonal
      (fun a b => ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b),
      Nat.sum_divisors_prime_pow hp, Finset.sum_range_succ]
    have hz : p ^ (m + 1) / p ^ (m + 1) = 1 := Nat.div_self (pow_pos hp.pos _)
    rw [hz, ArithmeticFunction.vonMangoldt_apply_one, mul_zero, add_zero,
      Finset.sum_range_succ']
    simp only [pow_zero, ArithmeticFunction.vonMangoldt_apply_one, zero_mul, add_zero]
    have hs : (∑ i ∈ Finset.range m,
        ArithmeticFunction.vonMangoldt (p ^ (i + 1)) *
          ArithmeticFunction.vonMangoldt (p ^ (m + 1) / p ^ (i + 1))) =
        ∑ _i ∈ Finset.range m, Real.log (p : ℝ) ^ 2 := by
      apply Finset.sum_congr rfl
      intro i hi
      have him : i < m := Finset.mem_range.mp hi
      rw [Nat.pow_div (by omega : i + 1 ≤ m + 1) hp.pos]
      rw [ArithmeticFunction.vonMangoldt_apply_pow (by omega : i + 1 ≠ 0),
        ArithmeticFunction.vonMangoldt_apply_pow (by omega : m + 1 - (i + 1) ≠ 0),
        ArithmeticFunction.vonMangoldt_apply_prime hp]
      ring
    rw [hs]
    simp [Nat.cast_add, Nat.cast_one]

/-- If two nonzero prime-power atom weights share a prime, their product
label is itself a prime power. This is a support fact about the actual `Λ`. -/
theorem vonMangoldt_pair_zero_of_not_prime_pow_not_coprime {a b : ℕ}
    (hn : ¬IsPrimePow (a * b)) (hab : ¬a.Coprime b) :
    ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b = 0 := by
  by_cases ha : ArithmeticFunction.vonMangoldt a = 0
  · simp [ha]
  by_cases hb : ArithmeticFunction.vonMangoldt b = 0
  · simp [hb]
  obtain ⟨p, i, hp, hi, rfl⟩ :=
    (isPrimePow_nat_iff a).mp (ArithmeticFunction.vonMangoldt_ne_zero_iff.mp ha)
  obtain ⟨q, j, hq, hj, rfl⟩ :=
    (isPrimePow_nat_iff b).mp (ArithmeticFunction.vonMangoldt_ne_zero_iff.mp hb)
  have hpq : p = q := by
    by_contra h
    exact hab (Nat.coprime_pow_primes i j hp hq h)
  subst q
  exfalso
  apply hn
  rw [← pow_add]
  exact (isPrimePow_nat_iff _).mpr ⟨p, i + j, hp, by omega, rfl⟩

theorem distinctPrimePairWeight_eq_coprime_sum (n : ℕ) :
    distinctPrimePairWeight n =
      ∑ d ∈ n.divisors,
        if d.Coprime (n / d) then
          ArithmeticFunction.vonMangoldt d * ArithmeticFunction.vonMangoldt (n / d)
        else 0 := by
  by_cases hn : IsPrimePow n
  · have hsame : (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n =
        samePrimePairWeight n := by
      obtain ⟨p, k, hp, hk, rfl⟩ := (isPrimePow_nat_iff n).mp hn
      rw [vonMangoldt_convolution_prime_pow hp hk, samePrimePairWeight_prime_pow hp hk]
    rw [distinctPrimePairWeight, hsame, sub_self]
    symm
    apply Finset.sum_eq_zero
    intro d hd
    by_cases hc : d.Coprime (n / d)
    · rw [if_pos hc]
      by_cases hd1 : d = 1
      · simp [hd1]
      by_cases hq1 : n / d = 1
      · simp [hq1]
      have hz := vonMangoldt_coprime_mul_eq_zero hc hd1 hq1
      rw [Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1] at hz
      exact (ArithmeticFunction.vonMangoldt_ne_zero_iff.mpr hn hz).elim
    · simp [hc]
  · rw [distinctPrimePairWeight, samePrimePairWeight_eq_zero_of_not_prime_pow hn, sub_zero,
      ArithmeticFunction.mul_apply, Nat.sum_divisorsAntidiagonal
        (fun a b => ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b)]
    apply Finset.sum_congr rfl
    intro d hd
    by_cases hc : d.Coprime (n / d)
    · simp [hc]
    · rw [if_neg hc]
      apply vonMangoldt_pair_zero_of_not_prime_pow_not_coprime _ hc
      simpa only [Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1] using hn

theorem distinctPrimePairWeight_nonneg (n : ℕ) : 0 ≤ distinctPrimePairWeight n := by
  rw [distinctPrimePairWeight_eq_coprime_sum]
  apply Finset.sum_nonneg
  intro d _
  split_ifs
  · exact mul_nonneg ArithmeticFunction.vonMangoldt_nonneg ArithmeticFunction.vonMangoldt_nonneg
  · exact le_rfl

theorem vonMangoldt_convolution_same_distinct (n : ℕ) :
    (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n =
      samePrimePairWeight n + distinctPrimePairWeight n := by
  unfold distinctPrimePairWeight
  ring

end BuildingBlocks
