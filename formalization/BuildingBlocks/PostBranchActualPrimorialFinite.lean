import BuildingBlocks.PostBranchDoubleAbelFinite
import Mathlib.NumberTheory.ArithmeticFunction
import Mathlib.Tactic

/-! Exact finite actual Möbius packet at the first post-branch primorial. -/

namespace BuildingBlocks.PostBranchActualPrimorialFinite

open scoped BigOperators
open BuildingBlocks.PostBranchDoubleAbelFinite

noncomputable section

def coefficient6 (n : ℕ) : ℝ :=
  if n ∣ 6 then (ArithmeticFunction.moebius n : ℤ) else 0

private lemma mu_two : ArithmeticFunction.moebius 2 = -1 :=
  ArithmeticFunction.moebius_apply_prime (by norm_num)

private lemma mu_three : ArithmeticFunction.moebius 3 = -1 :=
  ArithmeticFunction.moebius_apply_prime (by norm_num)

private lemma mu_six : ArithmeticFunction.moebius 6 = 1 := by
  have h := ArithmeticFunction.isMultiplicative_moebius.map_mul_of_coprime
    (by norm_num : Nat.Coprime 2 3)
  simpa [mu_two, mu_three] using h

/-- All six integer coefficient slots, including nondivisors and terminal face. -/
theorem coefficient6_table :
    coefficient6 1 = 1 ∧ coefficient6 2 = -1 ∧
    coefficient6 3 = -1 ∧ coefficient6 4 = 0 ∧
    coefficient6 5 = 0 ∧ coefficient6 6 = 1 := by
  norm_num [coefficient6, mu_two, mu_three, mu_six]

/-- The actual primorial-divisor Mertens prefix, before its vanishing terminal. -/
theorem prefix6_table :
    partialSum coefficient6 1 = 1 ∧ partialSum coefficient6 2 = 0 ∧
    partialSum coefficient6 3 = -1 ∧ partialSum coefficient6 4 = -1 ∧
    partialSum coefficient6 5 = -1 ∧ partialSum coefficient6 6 = 0 := by
  obtain ⟨h1,h2,h3,h4,h5,h6⟩ := coefficient6_table
  norm_num [partialSum, Finset.sum_range_succ, h1,h2,h3,h4,h5,h6]

/-- The actual p=5 primorial packet satisfies finite double Abel, with
both terminal divisor faces included before the zero-total reduction. -/
theorem actual_six_double_abel (K : ℕ → ℕ → ℝ) :
    (∑ i ∈ Finset.range 6, ∑ j ∈ Finset.range 6,
      coefficient6 (i+1) * coefficient6 (j+1) * K (i+1) (j+1)) =
      ∑ i ∈ Finset.range 5, ∑ j ∈ Finset.range 5,
        partialSum coefficient6 (i+1) * partialSum coefficient6 (j+1) *
          (K (i+1) (j+1) - K (i+2) (j+1) -
            K (i+1) (j+2) + K (i+2) (j+2)) := by
  exact finite_double_abel_of_totals_zero coefficient6 coefficient6 K 5 5
    prefix6_table.2.2.2.2.2 prefix6_table.2.2.2.2.2

end
end BuildingBlocks.PostBranchActualPrimorialFinite

#print axioms BuildingBlocks.PostBranchActualPrimorialFinite.coefficient6_table
#print axioms BuildingBlocks.PostBranchActualPrimorialFinite.prefix6_table
#print axioms BuildingBlocks.PostBranchActualPrimorialFinite.actual_six_double_abel
