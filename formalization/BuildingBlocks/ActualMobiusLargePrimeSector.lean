import BuildingBlocks.ActualMobiusConvolution
import Mathlib.Tactic

/-!
Exact finite large-prime-sector reindexing for Mathlib's actual `μ * μ`.
The sector is defined by primality, divisibility and `N < p²`, with no
supplied largest-prime labels or squarefree hypothesis. The complementary
sector retains the unit when `N ≥ 1` and repeated small-prime powers. No asymptotic,
signed tail estimate or RH implication is asserted.
-/

namespace BuildingBlocks.ActualMobiusLargePrimeSector

open Finset
open scoped BigOperators
open BuildingBlocks.ActualMobiusConvolution

noncomputable section

def largePrimes (N : ℕ) : Finset ℕ :=
  (Icc 2 N).filter fun p => p.Prime ∧ N < p ^ 2

def largeSector (N : ℕ) : Finset ℕ := by
  classical
  exact (Icc 1 N).filter fun n => ∃ p ∈ largePrimes N, p ∣ n

def smallSector (N : ℕ) : Finset ℕ := Icc 1 N \ largeSector N

def largePairs (N : ℕ) : Finset (Σ _ : ℕ, ℕ) :=
  (largePrimes N).sigma fun p => Icc 1 (N / p)

def pairProduct (a : Σ _ : ℕ, ℕ) : ℕ := a.1 * a.2

theorem mem_largePrimes {N p : ℕ} :
    p ∈ largePrimes N ↔ 2 ≤ p ∧ p ≤ N ∧ p.Prime ∧ N < p ^ 2 := by
  simp [largePrimes, and_assoc]

theorem mem_largeSector {N n : ℕ} :
    n ∈ largeSector N ↔ 1 ≤ n ∧ n ≤ N ∧ ∃ p ∈ largePrimes N, p ∣ n := by
  classical
  simp [largeSector, and_assoc]

theorem mem_largePairs {N : ℕ} {a : Σ _ : ℕ, ℕ} :
    a ∈ largePairs N ↔ a.1 ∈ largePrimes N ∧ 1 ≤ a.2 ∧ a.2 ≤ N / a.1 := by
  simp [largePairs]

/-- A prime larger than the square-root cutoff occurs only once. -/
theorem quotient_lt_of_large_prime {N n p : ℕ} (_hp : p.Prime)
    (hcut : N < p ^ 2) (hn : n ≤ N) (hdiv : p ∣ n) : n / p < p := by
  by_contra hnot
  have hle : p ≤ n / p := Nat.le_of_not_gt hnot
  have hmul := Nat.mul_le_mul_left p hle
  rw [Nat.mul_div_cancel' hdiv] at hmul
  have hsq : p ^ 2 ≤ n := by simpa [pow_two] using hmul
  omega

theorem quotient_pos_of_prime_dvd {n p : ℕ} (_hp : p.Prime)
    (hn : 0 < n) (hdiv : p ∣ n) : 0 < n / p := by
  have hprod : p * (n / p) = n := Nat.mul_div_cancel' hdiv
  by_contra hnot
  have hz : n / p = 0 := Nat.eq_zero_of_le_zero (Nat.le_of_not_gt hnot)
  rw [hz, mul_zero] at hprod
  omega

theorem large_prime_coprime_quotient {N n p : ℕ} (hp : p.Prime)
    (hcut : N < p ^ 2) (hn0 : 0 < n) (hn : n ≤ N) (hdiv : p ∣ n) :
    p.Coprime (n / p) := by
  exact Nat.coprime_of_lt_prime
    (Nat.ne_of_gt (quotient_pos_of_prime_dvd hp hn0 hdiv))
    (quotient_lt_of_large_prime hp hcut hn hdiv) hp

/-- Coefficient removal uses the existing actual convolution facts. -/
theorem large_prime_coefficient {N n p : ℕ} (hp : p.Prime)
    (hcut : N < p ^ 2) (hn0 : 0 < n) (hn : n ≤ N) (hdiv : p ∣ n) :
    balancedMobiusCoefficient n = -2 * balancedMobiusCoefficient (n / p) := by
  have hcop := large_prime_coprime_quotient hp hcut hn0 hn hdiv
  have hprod : p * (n / p) = n := Nat.mul_div_cancel' hdiv
  calc
    balancedMobiusCoefficient n = balancedMobiusCoefficient (p * (n / p)) := by
      rw [hprod]
    _ = balancedMobiusCoefficient p * balancedMobiusCoefficient (n / p) :=
      balancedMobiusCoefficient_isMultiplicative.map_mul_of_coprime hcop
    _ = -2 * balancedMobiusCoefficient (n / p) := by
      rw [balancedMobiusCoefficient_apply_prime hp]

/-- This prime is maximal among actual prime divisors; no label is supplied. -/
theorem prime_divisor_le_large_prime {N n p q : ℕ} (hp : p.Prime)
    (hcut : N < p ^ 2) (hn0 : 0 < n) (hn : n ≤ N) (hdiv : p ∣ n)
    (hq : q.Prime) (hqdiv : q ∣ n) : q ≤ p := by
  by_cases hqp : q = p
  · omega
  have hcop : q.Coprime p := (Nat.coprime_primes hq hp).mpr hqp
  have hprod : p * (n / p) = n := Nat.mul_div_cancel' hdiv
  have hqprod : q ∣ p * (n / p) := by rw [hprod]; exact hqdiv
  have hqquot : q ∣ n / p := hcop.dvd_of_dvd_mul_left hqprod
  have hqle : q ≤ n / p :=
    Nat.le_of_dvd (quotient_pos_of_prime_dvd hp hn0 hdiv) hqquot
  exact hqle.trans (quotient_lt_of_large_prime hp hcut hn hdiv).le

theorem large_prime_unique {N n p q : ℕ} (hp : p.Prime) (hq : q.Prime)
    (hpcut : N < p ^ 2) (hqcut : N < q ^ 2) (hn0 : 0 < n) (hn : n ≤ N)
    (hpdiv : p ∣ n) (hqdiv : q ∣ n) : p = q := by
  apply Nat.le_antisymm
  · exact prime_divisor_le_large_prime hq hqcut hn0 hn hqdiv hp hpdiv
  · exact prime_divisor_le_large_prime hp hpcut hn0 hn hpdiv hq hqdiv

theorem pairProduct_mem_largeSector {N : ℕ} {a : Σ _ : ℕ, ℕ}
    (ha : a ∈ largePairs N) : pairProduct a ∈ largeSector N := by
  obtain ⟨hpQ, hm1, hmN⟩ := mem_largePairs.mp ha
  obtain ⟨hp2, hpN, hp, hcut⟩ := mem_largePrimes.mp hpQ
  have hpos : 0 < a.1 * a.2 := Nat.mul_pos hp.pos hm1
  have hle : a.1 * a.2 ≤ N := by
    simpa [Nat.mul_comm] using (Nat.le_div_iff_mul_le hp.pos).mp hmN
  apply mem_largeSector.mpr
  exact ⟨hpos, hle, a.1, hpQ, dvd_mul_right a.1 a.2⟩

theorem pairProduct_injective {N : ℕ} {a b : Σ _ : ℕ, ℕ}
    (ha : a ∈ largePairs N) (hb : b ∈ largePairs N)
    (hab : pairProduct a = pairProduct b) : a = b := by
  rcases a with ⟨p, m⟩
  rcases b with ⟨q, l⟩
  obtain ⟨hpQ, hm1, hmN⟩ := mem_largePairs.mp ha
  obtain ⟨hqQ, hl1, hlN⟩ := mem_largePairs.mp hb
  obtain ⟨hp2, hpN, hp, hpcut⟩ := mem_largePrimes.mp hpQ
  obtain ⟨hq2, hqN, hq, hqcut⟩ := mem_largePrimes.mp hqQ
  change p * m = q * l at hab
  have hn0 : 0 < p * m := Nat.mul_pos hp.pos hm1
  have hn : p * m ≤ N := by
    simpa [Nat.mul_comm] using (Nat.le_div_iff_mul_le hp.pos).mp hmN
  have hpdiv : p ∣ p * m := dvd_mul_right p m
  have hqdiv : q ∣ p * m := by rw [hab]; exact dvd_mul_right q l
  have hpq : p = q := large_prime_unique hp hq hpcut hqcut hn0 hn hpdiv hqdiv
  subst q
  have hml : m = l := Nat.eq_of_mul_eq_mul_left hp.pos hab
  subst l
  rfl

theorem pairProduct_surjective {N n : ℕ} (hn : n ∈ largeSector N) :
    ∃ a ∈ largePairs N, pairProduct a = n := by
  obtain ⟨hn1, hnN, p, hpQ, hpdiv⟩ := mem_largeSector.mp hn
  obtain ⟨hp2, hpN, hp, hcut⟩ := mem_largePrimes.mp hpQ
  refine ⟨⟨p, n / p⟩, ?_, ?_⟩
  · apply mem_largePairs.mpr
    exact ⟨hpQ, quotient_pos_of_prime_dvd hp hn1 hpdiv, Nat.div_le_div_right hnN⟩
  · exact Nat.mul_div_cancel' hpdiv

theorem pair_coefficient {N : ℕ} {a : Σ _ : ℕ, ℕ} (ha : a ∈ largePairs N) :
    balancedMobiusCoefficient (pairProduct a) = -2 * balancedMobiusCoefficient a.2 := by
  obtain ⟨hpQ, hm1, hmN⟩ := mem_largePairs.mp ha
  obtain ⟨hp2, hpN, hp, hcut⟩ := mem_largePrimes.mp hpQ
  have hn0 : 0 < a.1 * a.2 := Nat.mul_pos hp.pos hm1
  have hn : a.1 * a.2 ≤ N := by
    simpa [Nat.mul_comm] using (Nat.le_div_iff_mul_le hp.pos).mp hmN
  have hc := large_prime_coefficient hp hcut hn0 hn (dvd_mul_right a.1 a.2)
  simpa [pairProduct, Nat.mul_div_cancel_left _ hp.pos] using hc

/-- Weighted reindexing of the complete actual large-prime sector. -/
theorem weighted_large_sector_reindex (N : ℕ) (f : ℕ → ℝ) :
    (∑ n ∈ largeSector N, (balancedMobiusCoefficient n : ℝ) * f n) =
      -2 * ∑ p ∈ largePrimes N, ∑ m ∈ Icc 1 (N / p),
        (balancedMobiusCoefficient m : ℝ) * f (p * m) := by
  classical
  have hreindex :
      (∑ a ∈ largePairs N,
        (balancedMobiusCoefficient (pairProduct a) : ℝ) * f (pairProduct a)) =
      ∑ n ∈ largeSector N, (balancedMobiusCoefficient n : ℝ) * f n := by
    apply sum_bij (fun a _ => pairProduct a)
    · intro a ha
      exact pairProduct_mem_largeSector ha
    · intro a ha b hb hab
      exact pairProduct_injective ha hb hab
    · intro n hn
      obtain ⟨a, ha, he⟩ := pairProduct_surjective hn
      exact ⟨a, ha, he⟩
    · intro a ha
      rfl
  calc
    (∑ n ∈ largeSector N, (balancedMobiusCoefficient n : ℝ) * f n) =
        ∑ a ∈ largePairs N,
          (balancedMobiusCoefficient (pairProduct a) : ℝ) * f (pairProduct a) :=
      hreindex.symm
    _ = ∑ a ∈ largePairs N,
        -2 * ((balancedMobiusCoefficient a.2 : ℝ) * f (pairProduct a)) := by
      apply sum_congr rfl
      intro a ha
      rw [pair_coefficient ha]
      push_cast
      ring
    _ = -2 * ∑ a ∈ largePairs N,
        (balancedMobiusCoefficient a.2 : ℝ) * f (pairProduct a) := by
      rw [mul_sum]
    _ = -2 * ∑ p ∈ largePrimes N, ∑ m ∈ Icc 1 (N / p),
        (balancedMobiusCoefficient m : ℝ) * f (p * m) := by
      rw [largePairs, sum_sigma]
      rfl

/-- The small sector is retained, without a squarefree or size estimate. -/
theorem weighted_complete_partition (N : ℕ) (f : ℕ → ℝ) :
    (∑ n ∈ Icc 1 N, (balancedMobiusCoefficient n : ℝ) * f n) =
      (∑ n ∈ smallSector N, (balancedMobiusCoefficient n : ℝ) * f n) -
        2 * ∑ p ∈ largePrimes N, ∑ m ∈ Icc 1 (N / p),
          (balancedMobiusCoefficient m : ℝ) * f (p * m) := by
  classical
  have hsub : largeSector N ⊆ Icc 1 N := filter_subset _ _
  have hsplit := sum_sdiff
    (f := fun n => (balancedMobiusCoefficient n : ℝ) * f n) hsub
  change (∑ n ∈ smallSector N, (balancedMobiusCoefficient n : ℝ) * f n) +
    (∑ n ∈ largeSector N, (balancedMobiusCoefficient n : ℝ) * f n) =
    (∑ n ∈ Icc 1 N, (balancedMobiusCoefficient n : ℝ) * f n) at hsplit
  rw [weighted_large_sector_reindex] at hsplit
  linarith

theorem unit_not_largeSector (N : ℕ) : 1 ∉ largeSector N := by
  intro h
  obtain ⟨hn1, hnN, p, hpQ, hpdiv⟩ := mem_largeSector.mp h
  have hp2 : 2 ≤ p := (mem_largePrimes.mp hpQ).1
  have hp1 : p = 1 := Nat.dvd_one.mp hpdiv
  omega

theorem unit_mem_smallSector {N : ℕ} (hN : 1 ≤ N) : 1 ∈ smallSector N := by
  simp [smallSector, hN, unit_not_largeSector]

theorem sectors_zero : largeSector 0 = ∅ ∧ smallSector 0 = ∅ := by
  simp [largeSector, smallSector]

theorem sectors_one : largeSector 1 = ∅ ∧ smallSector 1 = {1} := by
  simp [largeSector, smallSector, largePrimes]

end
end BuildingBlocks.ActualMobiusLargePrimeSector
