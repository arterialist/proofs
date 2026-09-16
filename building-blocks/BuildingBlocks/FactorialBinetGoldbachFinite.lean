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
#print axioms goldbachPair_complete_expansion
#print axioms goldbachPair_nonneg
#print axioms direct_goldbach_le_pair

end BuildingBlocks.FactorialBinetGoldbachFinite
