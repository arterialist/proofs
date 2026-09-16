import Mathlib.Tactic
import Mathlib.NumberTheory.ArithmeticFunction

/-!
# Exact finite source partition at X = 2

This module proves only the discrete Möbius and finite partition algebra.
The prime-density/Stieltjes identity and rational interval enclosures are
kept in the companion written audit and checker.
-/

namespace BuildingBlocks.PostBranchFullSourceFinite

open scoped BigOperators

noncomputable section

def roughCoefficient2 (n : ℕ) : ℤ :=
  if Odd n then ArithmeticFunction.moebius n else 0

theorem roughCoefficient2_prime {n : ℕ}
    (hn : Nat.Prime n) (hne : n ≠ 2) : roughCoefficient2 n = -1 := by
  simp [roughCoefficient2, hn.odd_of_ne_two hne,
    ArithmeticFunction.moebius_apply_prime hn]

theorem roughCoefficient2_two : roughCoefficient2 2 = 0 := by
  norm_num [roughCoefficient2]

/-- For any finite source set above two, the prime term carries the
opposite Möbius sign and the remaining composite term retains its actual
coefficient (including zeros on squareful integers). -/
theorem finite_prime_rough_split
    (S : Finset ℕ) (f : ℕ → ℝ)
    (hge : ∀ n ∈ S, 3 ≤ n) :
    -(∑ n ∈ S, (roughCoefficient2 n : ℝ) * f n) =
      (∑ n ∈ S.filter Nat.Prime, f n) -
      (∑ n ∈ S.filter (fun n => ¬ Nat.Prime n),
        (roughCoefficient2 n : ℝ) * f n) := by
  have hsplit := Finset.sum_filter_add_sum_filter_not S Nat.Prime
    (fun n => (roughCoefficient2 n : ℝ) * f n)
  have hprime :
      (∑ n ∈ S.filter Nat.Prime,
        (roughCoefficient2 n : ℝ) * f n) =
      ∑ n ∈ S.filter Nat.Prime, -f n := by
    apply Finset.sum_congr rfl
    intro n hn
    rw [Finset.mem_filter] at hn
    rw [roughCoefficient2_prime hn.2 (by have h := hge n hn.1; omega)]
    norm_num
  rw [← hsplit, hprime]
  simp only [Finset.sum_neg_distrib]
  ring

/-- The inclusive Stieltjes prime count has the lower prime-two atom;
subtracting that literal atom leaves the open rough-prime sum. -/
theorem closed_lower_atom_subtraction
    (S : Finset ℕ) (f : ℕ → ℝ) (h2 : 2 ∉ S) :
    (∑ n ∈ insert 2 S, f n) - f 2 = ∑ n ∈ S, f n := by
  rw [Finset.sum_insert h2]
  ring

/-- Exact algebra of the previously studied main-plus-endpoint term and
its source correction. -/
theorem full_minus_studied
    (endpoint prime rough main : ℝ) :
    (endpoint + prime + rough) - (endpoint + main) =
      (prime - main) + rough := by
  ring

end
end BuildingBlocks.PostBranchFullSourceFinite

#print axioms BuildingBlocks.PostBranchFullSourceFinite.roughCoefficient2_prime
#print axioms BuildingBlocks.PostBranchFullSourceFinite.roughCoefficient2_two
#print axioms BuildingBlocks.PostBranchFullSourceFinite.finite_prime_rough_split
#print axioms BuildingBlocks.PostBranchFullSourceFinite.closed_lower_atom_subtraction
#print axioms BuildingBlocks.PostBranchFullSourceFinite.full_minus_studied
