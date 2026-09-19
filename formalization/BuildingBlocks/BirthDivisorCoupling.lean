import Mathlib.NumberTheory.Divisors
import Lean.Elab.Tactic.Omega
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Data.Nat.Totient

open Finset

namespace BuildingBlocks.BirthDivisor

/-- Both neighboring factorizations are retained, at their integer label. -/
def weightedCurrent (n d : ℕ) : ℤ :=
  (if d ∈ (n - 1).divisors then (Nat.totient d : ℤ) else 0) -
  (if d ∈ (n + 1).divisors then (Nat.totient d : ℤ) else 0)

/-- A fixed divisor-coordinate contraction recovers a constant successor
increment. This finite identity asserts no bound for a prime-error energy. -/
theorem sum_weightedCurrent (n : ℕ) (hn : 2 ≤ n) :
    ∑ d ∈ (n - 1).divisors ∪ (n + 1).divisors, weightedCurrent n d = -2 := by
  classical
  simp only [weightedCurrent, Finset.sum_sub_distrib, Finset.sum_ite_mem,
    Finset.inter_eq_right.mpr Finset.subset_union_left,
    Finset.inter_eq_right.mpr Finset.subset_union_right]
  have hm : (∑ d ∈ (n - 1).divisors, (Nat.totient d : ℤ)) = (n - 1 : ℕ) := by
    exact_mod_cast Nat.sum_totient (n - 1)
  have hp : (∑ d ∈ (n + 1).divisors, (Nat.totient d : ℤ)) = (n + 1 : ℕ) := by
    exact_mod_cast Nat.sum_totient (n + 1)
  rw [hm, hp]
  omega

end BuildingBlocks.BirthDivisor

#print axioms BuildingBlocks.BirthDivisor.sum_weightedCurrent
