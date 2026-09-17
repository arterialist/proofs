import BuildingBlocks.FactorialClockCofactorFinite

/-!
# Complete cofactor prime source and its additive pairs

The finite algebra here applies to the positive Binet residual coefficient
`v = -r` once its analytic positivity is supplied. The theorems themselves
retain every prime power, cofactor and ordered additive pair.
-/

namespace BuildingBlocks.FactorialBinetGoldbachFinite

open Finset
open scoped BigOperators

noncomputable section

/-- The complete multiplicative-history source for a cofactor weight. -/
def primeSource (v : ℕ → ℝ) (n : ℕ) : ℝ :=
  ∑ m ∈ n.divisors, v m * ArithmeticFunction.vonMangoldt (n / m)

theorem primeSource_prefix (v : ℕ → ℝ) (N : ℕ) :
    (∑ n ∈ Icc 1 N, primeSource v n) =
      ∑ m ∈ Icc 1 N, v m * BuildingBlocks.CoarsePrimitive.psi (N / m) := by
  simpa only [primeSource] using
    FactorialClockCofactorFinite.weighted_prime_source_prefix v N

theorem primeSource_nonneg (v : ℕ → ℝ) (hv : ∀ m, 0 ≤ v m) (n : ℕ) :
    0 ≤ primeSource v n := by
  unfold primeSource
  apply sum_nonneg
  intro m hm
  exact mul_nonneg (hv m) ArithmeticFunction.vonMangoldt_nonneg

/-- The direct cofactor-one prime arrival survives every positive
complete-history extension. -/
theorem direct_prime_le_source (v : ℕ → ℝ) (hv : ∀ m, 0 ≤ v m) (n : ℕ) :
    v 1 * ArithmeticFunction.vonMangoldt n ≤ primeSource v n := by
  by_cases hn : n = 0
  · subst n
    simp [primeSource]
  · unfold primeSource
    have h := Finset.single_le_sum
      (s := n.divisors)
      (f := fun m => v m * ArithmeticFunction.vonMangoldt (n / m))
      (fun m _ => mul_nonneg (hv m) ArithmeticFunction.vonMangoldt_nonneg)
      (Nat.one_mem_divisors.mpr hn)
    simpa using h

/-- Every proper cofactor is at least two, so its weight can be paid
by `v 2`. The remaining direct row is the literal von Mangoldt atom. -/
theorem primeSource_le_direct_add_log (v : ℕ → ℝ)
    (hv2 : ∀ m, 2 ≤ m → v m ≤ v 2) (n : ℕ) :
    primeSource v n ≤ v 2 * Real.log (n : ℝ) +
      (v 1 - v 2) * ArithmeticFunction.vonMangoldt n := by
  by_cases hn : n = 0
  · subst n
    simp [primeSource]
  · have hmem : 1 ∈ n.divisors := Nat.one_mem_divisors.mpr hn
    have hsource : primeSource v n =
        v 1 * ArithmeticFunction.vonMangoldt n +
          ∑ m ∈ n.divisors.erase 1,
            v m * ArithmeticFunction.vonMangoldt (n / m) := by
      unfold primeSource
      have hs := Finset.sum_erase_add (n.divisors)
        (fun m => v m * ArithmeticFunction.vonMangoldt (n / m)) hmem
      simpa only [Nat.div_one, add_comm] using hs.symm
    have hlogs :
        (∑ m ∈ n.divisors.erase 1,
          ArithmeticFunction.vonMangoldt (n / m)) =
          Real.log (n : ℝ) - ArithmeticFunction.vonMangoldt n := by
      have hs := Finset.sum_erase_add (n.divisors)
        (fun m => ArithmeticFunction.vonMangoldt (n / m)) hmem
      rw [Nat.sum_div_divisors, ArithmeticFunction.vonMangoldt_sum] at hs
      simpa only [Nat.div_one] using (sub_eq_of_eq_add hs.symm).symm
    have htail :
        (∑ m ∈ n.divisors.erase 1,
          v m * ArithmeticFunction.vonMangoldt (n / m)) ≤
          v 2 * (∑ m ∈ n.divisors.erase 1,
            ArithmeticFunction.vonMangoldt (n / m)) := by
      rw [Finset.mul_sum]
      apply sum_le_sum
      intro m hm
      have hm1 : m ≠ 1 := (Finset.mem_erase.mp hm).1
      have hdiv : m ∣ n := (Nat.mem_divisors.mp (Finset.mem_erase.mp hm).2).1
      have hmpos : 0 < m := Nat.pos_of_dvd_of_pos hdiv (Nat.pos_of_ne_zero hn)
      have hm2 : 2 ≤ m := by omega
      exact mul_le_mul_of_nonneg_right (hv2 m hm2)
        ArithmeticFunction.vonMangoldt_nonneg
    rw [hsource]
    calc
      v 1 * ArithmeticFunction.vonMangoldt n +
          ∑ m ∈ n.divisors.erase 1,
            v m * ArithmeticFunction.vonMangoldt (n / m) ≤
        v 1 * ArithmeticFunction.vonMangoldt n +
          v 2 * (∑ m ∈ n.divisors.erase 1,
            ArithmeticFunction.vonMangoldt (n / m)) :=
        add_le_add_left htail _
      _ = v 2 * Real.log (n : ℝ) +
            (v 1 - v 2) * ArithmeticFunction.vonMangoldt n := by
        rw [hlogs]
        ring

/-- At a composite integer, the direct prime-power atom pays at most
half of the full divisor logarithm. -/
theorem vonMangoldt_composite_le_half_log (n : ℕ)
    (hn : 2 ≤ n) (hnp : ¬ n.Prime) :
    ArithmeticFunction.vonMangoldt n ≤ Real.log (n : ℝ) / 2 := by
  by_cases hpow : IsPrimePow n
  · obtain ⟨p, k, hp, hk, hpk⟩ := (isPrimePow_nat_iff n).mp hpow
    have hk2 : 2 ≤ k := by
      by_contra h
      have hk1 : k = 1 := by omega
      subst k
      simp only [pow_one] at hpk
      subst n
      exact hnp hp
    rw [← hpk, ArithmeticFunction.vonMangoldt_apply_pow (by omega : k ≠ 0),
      ArithmeticFunction.vonMangoldt_apply_prime hp]
    push_cast
    rw [Real.log_pow]
    have hp1 : (1 : ℝ) ≤ (p : ℝ) := by exact_mod_cast (le_of_lt hp.one_lt)
    have hlog : 0 ≤ Real.log (p : ℝ) := Real.log_nonneg hp1
    have hkreal : (2 : ℝ) ≤ (k : ℝ) := by exact_mod_cast hk2
    have hprod : 0 ≤ ((k : ℝ) - 2) * Real.log (p : ℝ) :=
      mul_nonneg (sub_nonneg.mpr hkreal) hlog
    nlinarith
  · rw [ArithmeticFunction.vonMangoldt_eq_zero_iff.mpr hpow]
    have hn1 : (1 : ℝ) ≤ (n : ℝ) := by exact_mod_cast (by omega : 1 ≤ n)
    have hlog : 0 ≤ Real.log (n : ℝ) := Real.log_nonneg hn1
    linarith

theorem primeSource_prime_eq_direct (v : ℕ → ℝ)
    (hv : ∀ m, 0 ≤ v m) (hv2 : ∀ m, 2 ≤ m → v m ≤ v 2)
    {p : ℕ} (hp : p.Prime) :
    primeSource v p = v 1 * Real.log (p : ℝ) := by
  have hlo := direct_prime_le_source v hv p
  have hhi := primeSource_le_direct_add_log v hv2 p
  rw [ArithmeticFunction.vonMangoldt_apply_prime hp] at hlo hhi
  apply le_antisymm
  · calc
      primeSource v p ≤ v 2 * Real.log (p : ℝ) +
          (v 1 - v 2) * Real.log (p : ℝ) := hhi
      _ = v 1 * Real.log (p : ℝ) := by ring
  · exact hlo

theorem primeSource_composite_le (v : ℕ → ℝ)
    (hv2 : ∀ m, 2 ≤ m → v m ≤ v 2) (hv12 : v 2 ≤ v 1)
    {n : ℕ} (hn : 2 ≤ n) (hnp : ¬ n.Prime) :
    primeSource v n ≤ (v 1 + v 2) / 2 * Real.log (n : ℝ) := by
  have hsource := primeSource_le_direct_add_log v hv2 n
  have hlam := vonMangoldt_composite_le_half_log n hn hnp
  have hdiff : 0 ≤ v 1 - v 2 := sub_nonneg.mpr hv12
  have hmul := mul_le_mul_of_nonneg_left hlam hdiff
  nlinarith

/-- The rational hard wall follows from a first-versus-second
cofactor ratio. The Binet-specific ratio is an analytic input. -/
theorem primeSource_composite_le_rational (v : ℕ → ℝ)
    (hv2 : ∀ m, 2 ≤ m → v m ≤ v 2) (hv12 : v 2 ≤ v 1)
    (hratio : (40 : ℝ) * v 2 ≤ 7 * v 1)
    {n : ℕ} (hn : 2 ≤ n) (hnp : ¬ n.Prime) :
    primeSource v n ≤ (47 / 80 : ℝ) * v 1 * Real.log (n : ℝ) := by
  have hbase := primeSource_composite_le v hv2 hv12 hn hnp
  have hcoeff : (v 1 + v 2) / 2 ≤ (47 / 80 : ℝ) * v 1 := by
    linarith
  have hn1 : (1 : ℝ) ≤ (n : ℝ) := by exact_mod_cast (by omega : 1 ≤ n)
  have hlog : 0 ≤ Real.log (n : ℝ) := Real.log_nonneg hn1
  exact hbase.trans (by nlinarith [mul_le_mul_of_nonneg_right hcoeff hlog])

/-- Four attains the exact composite coefficient in the hard wall. -/
theorem primeSource_four (v : ℕ → ℝ) :
    primeSource v 4 = (v 1 + v 2) * Real.log (2 : ℝ) := by
  have hdiv : (4 : ℕ).divisors = {1, 2, 4} := by decide
  have h4 : ArithmeticFunction.vonMangoldt 4 = Real.log (2 : ℝ) := by
    rw [show (4 : ℕ) = 2 ^ 2 by norm_num,
      ArithmeticFunction.vonMangoldt_apply_pow (by norm_num : (2 : ℕ) ≠ 0),
      ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two]
    norm_num
  simp [primeSource, hdiv, h4,
    ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two]
  ring

/-- Ordered additive pairs of the complete prime source. -/
def goldbachPair (v : ℕ → ℝ) (k : ℕ) : ℝ :=
  ∑ p ∈ Finset.antidiagonal k, primeSource v p.1 * primeSource v p.2

/-- Exact finite ordered-pair expansion. The outer antidiagonal fixes
ordinary additive succession; both inner divisor sums keep complete
multiplicative histories. -/
theorem goldbachPair_complete_expansion (v : ℕ → ℝ) (k : ℕ) :
    goldbachPair v k =
      ∑ p ∈ Finset.antidiagonal k,
        ∑ m ∈ p.1.divisors, ∑ n ∈ p.2.divisors,
          v m * v n *
            (ArithmeticFunction.vonMangoldt (p.1 / m) *
              ArithmeticFunction.vonMangoldt (p.2 / n)) := by
  unfold goldbachPair primeSource
  apply sum_congr rfl
  intro p hp
  rw [Finset.sum_mul]
  apply sum_congr rfl
  intro m hm
  rw [Finset.mul_sum]
  apply sum_congr rfl
  intro n hn
  ring

theorem goldbachPair_nonneg (v : ℕ → ℝ) (hv : ∀ m, 0 ≤ v m) (k : ℕ) :
    0 ≤ goldbachPair v k := by
  unfold goldbachPair
  apply sum_nonneg
  intro p hp
  exact mul_nonneg (primeSource_nonneg v hv p.1) (primeSource_nonneg v hv p.2)

/-- The undilated ordered Goldbach coefficient is an actual nonnegative
subrow of the complete cofactor-pair coefficient. -/
theorem direct_goldbach_le_pair (v : ℕ → ℝ) (hv : ∀ m, 0 ≤ v m) (k : ℕ) :
    (v 1) ^ 2 *
        (∑ p ∈ Finset.antidiagonal k,
          ArithmeticFunction.vonMangoldt p.1 * ArithmeticFunction.vonMangoldt p.2) ≤
      goldbachPair v k := by
  rw [goldbachPair, Finset.mul_sum]
  apply sum_le_sum
  intro p hp
  have ha := direct_prime_le_source v hv p.1
  have hb := direct_prime_le_source v hv p.2
  have hright : 0 ≤ v 1 * ArithmeticFunction.vonMangoldt p.2 :=
    mul_nonneg (hv 1) ArithmeticFunction.vonMangoldt_nonneg
  have hleft : 0 ≤ primeSource v p.1 := primeSource_nonneg v hv p.1
  calc
    (v 1) ^ 2 *
        (ArithmeticFunction.vonMangoldt p.1 * ArithmeticFunction.vonMangoldt p.2) =
      (v 1 * ArithmeticFunction.vonMangoldt p.1) *
        (v 1 * ArithmeticFunction.vonMangoldt p.2) := by ring
    _ ≤ primeSource v p.1 * (v 1 * ArithmeticFunction.vonMangoldt p.2) :=
      mul_le_mul_of_nonneg_right ha hright
    _ ≤ primeSource v p.1 * primeSource v p.2 :=
      mul_le_mul_of_nonneg_left hb hleft

end

#print axioms primeSource_prefix
#print axioms primeSource_nonneg
#print axioms direct_prime_le_source
#print axioms primeSource_le_direct_add_log
#print axioms vonMangoldt_composite_le_half_log
#print axioms primeSource_prime_eq_direct
#print axioms primeSource_composite_le
#print axioms primeSource_composite_le_rational
#print axioms primeSource_four
#print axioms goldbachPair_complete_expansion
#print axioms goldbachPair_nonneg
#print axioms direct_goldbach_le_pair

end BuildingBlocks.FactorialBinetGoldbachFinite
