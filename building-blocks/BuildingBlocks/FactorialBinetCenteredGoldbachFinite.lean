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

end

#print axioms centeredSource_eq_primeSource_sub_mass
#print axioms centeredSource_one
#print axioms centeredSource_direct_add_proper
#print axioms centeredPair_complete_expansion
#print axioms centeredPair_zero

end BuildingBlocks.FactorialBinetCenteredGoldbachFinite
