import BuildingBlocks.FactorialBinetGoldbachFinite
import BuildingBlocks.GoldbachHeatConvolution

/-!
# Centered additive pairs after every multiplicative cofactor history

These finite identities distinguish the signed centered source from the
positive uncentered cofactor source. The analytic Binet estimates and the
infinite heat-energy comparison are separate written results.
-/

namespace BuildingBlocks.FactorialBinetCenteredGoldbachFinite

open Finset
open scoped BigOperators
open BuildingBlocks.FactorialBinetGoldbachFinite
open BuildingBlocks.GoldbachHeat

noncomputable section

/-- The complete divisor reference mass, including the cofactor-one row. -/
def divisorMass (v : ℕ → ℝ) (n : ℕ) : ℝ :=
  ∑ m ∈ n.divisors, v m

/-- The centered source has every prime power and every multiplicative
cofactor, including the negative density endpoint at one. -/
def centeredSource (v : ℕ → ℝ) (n : ℕ) : ℝ :=
  ∑ m ∈ n.divisors, v m * centeredCoefficient (n / m)

theorem centeredSource_eq_primeSource_sub_mass (v : ℕ → ℝ) (n : ℕ) :
    centeredSource v n = primeSource v n - divisorMass v n := by
  unfold centeredSource primeSource divisorMass
  simp only [centeredCoefficient, mul_sub, mul_one, sum_sub_distrib]

@[simp] theorem centeredSource_one (v : ℕ → ℝ) :
    centeredSource v 1 = -v 1 := by
  simp [centeredSource]

/-- The direct centered row is exact, but the remaining proper-cofactor
sum is signed; positivity from the uncentered source cannot be reused. -/
theorem centeredSource_direct_add_proper (v : ℕ → ℝ) {n : ℕ}
    (hn : n ≠ 0) :
    centeredSource v n =
      v 1 * centeredCoefficient n +
        ∑ m ∈ n.divisors.erase 1,
          v m * centeredCoefficient (n / m) := by
  unfold centeredSource
  have hmem : 1 ∈ n.divisors := Nat.one_mem_divisors.mpr hn
  have hs := Finset.sum_erase_add (n.divisors)
    (fun m => v m * centeredCoefficient (n / m)) hmem
  simpa only [Nat.div_one, add_comm] using hs.symm

/-- Ordered additive totals are indexed from one, so k denotes
the actual total k + 2. -/
def centeredPair (v : ℕ → ℝ) (k : ℕ) : ℝ :=
  ∑ p ∈ Finset.antidiagonal k,
    centeredSource v (p.1 + 1) * centeredSource v (p.2 + 1)

/-- Exact four-index expansion. The inner factors are the actual
centered von Mangoldt coefficients, including both one endpoints. -/
theorem centeredPair_complete_expansion (v : ℕ → ℝ) (k : ℕ) :
    centeredPair v k =
      ∑ p ∈ Finset.antidiagonal k,
        ∑ m ∈ (p.1 + 1).divisors,
          ∑ n ∈ (p.2 + 1).divisors,
            v m * v n *
              (centeredCoefficient ((p.1 + 1) / m) *
                centeredCoefficient ((p.2 + 1) / n)) := by
  unfold centeredPair centeredSource
  apply sum_congr rfl
  intro p hp
  rw [Finset.sum_mul]
  apply sum_congr rfl
  intro m hm
  rw [Finset.mul_sum]
  apply sum_congr rfl
  intro n hn
  ring

/-- The first additive total retains the negative density endpoint twice. -/
@[simp] theorem centeredPair_zero (v : ℕ → ℝ) :
    centeredPair v 0 = (v 1) ^ 2 := by
  simp [centeredPair]
  ring

/-- The exact Binet-centered additive coefficient at total six,
expressed through its five ordered additive histories. -/
theorem centeredPair_four_exact (v : ℕ → ℝ) :
    centeredPair v 4 =
      -2 * v 1 * (v 1 * (Real.log 5 - 1) - v 5) +
      2 * (v 1 * (Real.log 2 - 1) - v 2) *
        ((v 1 + v 2) * (Real.log 2 - 1) - v 4) +
      (v 1 * (Real.log 3 - 1) - v 3) ^ 2 := by
  have hpair : Finset.antidiagonal 4 =
      {(0, 4), (1, 3), (2, 2), (3, 1), (4, 0)} := by decide
  have h2 : (2 : ℕ).divisors = {1, 2} := by decide
  have h3 : (3 : ℕ).divisors = {1, 3} := by decide
  have h4 : (4 : ℕ).divisors = {1, 2, 4} := by decide
  have h5 : (5 : ℕ).divisors = {1, 5} := by decide
  have hvm2 : ArithmeticFunction.vonMangoldt 2 = Real.log (2 : ℝ) :=
    ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two
  have hvm3 : ArithmeticFunction.vonMangoldt 3 = Real.log (3 : ℝ) :=
    ArithmeticFunction.vonMangoldt_apply_prime (by decide)
  have hvm4 : ArithmeticFunction.vonMangoldt 4 = Real.log (2 : ℝ) := by
    rw [show (4 : ℕ) = 2 ^ 2 by norm_num,
      ArithmeticFunction.vonMangoldt_apply_pow (by norm_num : (2 : ℕ) ≠ 0),
      ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two]
    norm_num
  have hvm5 : ArithmeticFunction.vonMangoldt 5 = Real.log (5 : ℝ) :=
    ArithmeticFunction.vonMangoldt_apply_prime (by decide)
  simp [centeredPair, centeredSource, hpair, h2, h3, h4, h5,
    centeredCoefficient, hvm2, hvm3, hvm4, hvm5]
  ring

/-- The rational component bounds from the Binet moment and logarithm
estimates force a strictly negative centered coefficient at total six. -/
theorem centeredPair_four_neg_of_component_bounds (v : ℕ → ℝ)
    (h1 : (1 / 504 : ℝ) ≤ v 1)
    (h2 : |centeredSource v 2| ≤ (13 / 10000 : ℝ))
    (h3 : |centeredSource v 3| ≤ (7 / 10000 : ℝ))
    (h4 : |centeredSource v 4| ≤ (11 / 10000 : ℝ))
    (h5 : (9 / 10000 : ℝ) ≤ centeredSource v 5) :
    centeredPair v 4 < 0 := by
  have hpair : Finset.antidiagonal 4 =
      {(0, 4), (1, 3), (2, 2), (3, 1), (4, 0)} := by decide
  have heq : centeredPair v 4 =
      -2 * v 1 * centeredSource v 5 +
      2 * centeredSource v 2 * centeredSource v 4 +
      (centeredSource v 3) ^ 2 := by
    simp [centeredPair, hpair]
    ring
  have hprod15 : (1 / 504 : ℝ) * (9 / 10000 : ℝ) ≤
      v 1 * centeredSource v 5 := by
    calc
      (1 / 504 : ℝ) * (9 / 10000 : ℝ) ≤
          (1 / 504 : ℝ) * centeredSource v 5 :=
        mul_le_mul_of_nonneg_left h5 (by norm_num)
      _ ≤ v 1 * centeredSource v 5 :=
        mul_le_mul_of_nonneg_right h1 (by linarith)
  have hprod24 : centeredSource v 2 * centeredSource v 4 ≤
      (13 / 10000 : ℝ) * (11 / 10000 : ℝ) := by
    calc
      centeredSource v 2 * centeredSource v 4 ≤
          |centeredSource v 2 * centeredSource v 4| := le_abs_self _
      _ = |centeredSource v 2| * |centeredSource v 4| := abs_mul _ _
      _ ≤ (13 / 10000 : ℝ) * (11 / 10000 : ℝ) :=
        mul_le_mul h2 h4 (abs_nonneg _) (by norm_num)
  have hsq3 : (centeredSource v 3) ^ 2 ≤ (7 / 10000 : ℝ) ^ 2 := by
    nlinarith [mul_nonneg (sub_nonneg.mpr h3)
      (add_nonneg (by norm_num : 0 ≤ (7 / 10000 : ℝ))
        (abs_nonneg (centeredSource v 3))),
      sq_abs (centeredSource v 3)]
  rw [heq]
  nlinarith

end

#print axioms centeredSource_eq_primeSource_sub_mass
#print axioms centeredSource_one
#print axioms centeredSource_direct_add_proper
#print axioms centeredPair_complete_expansion
#print axioms centeredPair_zero
#print axioms centeredPair_four_exact
#print axioms centeredPair_four_neg_of_component_bounds

end BuildingBlocks.FactorialBinetCenteredGoldbachFinite
