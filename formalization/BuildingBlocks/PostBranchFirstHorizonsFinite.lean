import Mathlib.Tactic
import Mathlib.NumberTheory.ArithmeticFunction

/-!
# Actual rough-source clocks X = 2,3,4,5

The analytic signs are in the companion rational interval checker.  This
module fixes the literal primorial cutoffs and Möbius source coefficients,
including their zero value on a repeated prime factor.
-/

namespace BuildingBlocks.PostBranchFirstHorizonsFinite

noncomputable section

def clockPrimorial (X : ℕ) : ℕ :=
  ∏ p ∈ (Finset.range (X+1)).filter Nat.Prime, p

def roughCoefficient (X n : ℕ) : ℤ :=
  if Nat.Coprime n (clockPrimorial X) then ArithmeticFunction.moebius n else 0

theorem clockPrimorial_two : clockPrimorial 2 = 2 := by decide
theorem clockPrimorial_three : clockPrimorial 3 = 6 := by decide
theorem clockPrimorial_four : clockPrimorial 4 = 6 := by decide
theorem clockPrimorial_five : clockPrimorial 5 = 30 := by decide

theorem roughCoefficient_three_eq_four (n : ℕ) :
    roughCoefficient 3 n = roughCoefficient 4 n := by
  simp [roughCoefficient, clockPrimorial_three, clockPrimorial_four]

theorem roughCoefficient_two_three : roughCoefficient 2 3 = -1 := by
  norm_num [roughCoefficient, clockPrimorial_two,
    ArithmeticFunction.moebius_apply_prime (by norm_num : Nat.Prime 3)]

theorem roughCoefficient_three_three : roughCoefficient 3 3 = 0 := by
  norm_num [roughCoefficient, clockPrimorial_three]

theorem roughCoefficient_three_five : roughCoefficient 3 5 = -1 := by
  norm_num [roughCoefficient, clockPrimorial_three,
    ArithmeticFunction.moebius_apply_prime (by norm_num : Nat.Prime 5)]

theorem roughCoefficient_five_five : roughCoefficient 5 5 = 0 := by
  norm_num [roughCoefficient, clockPrimorial_five]

/-- Every squared prime has its literal zero Möbius coefficient at every
clock, whether it is excluded by the primorial gcd or retained as rough. -/
theorem roughCoefficient_prime_square_zero (X p : ℕ) (hp : Nat.Prime p) :
    roughCoefficient X (p^2) = 0 := by
  have hm : ArithmeticFunction.moebius (p^2) = 0 := by
    simpa using ArithmeticFunction.moebius_apply_prime_pow hp
      (by norm_num : (2 : ℕ) ≠ 0)
  simp [roughCoefficient, hm]

end
end BuildingBlocks.PostBranchFirstHorizonsFinite

#print axioms BuildingBlocks.PostBranchFirstHorizonsFinite.clockPrimorial_two
#print axioms BuildingBlocks.PostBranchFirstHorizonsFinite.clockPrimorial_three
#print axioms BuildingBlocks.PostBranchFirstHorizonsFinite.clockPrimorial_four
#print axioms BuildingBlocks.PostBranchFirstHorizonsFinite.clockPrimorial_five
#print axioms BuildingBlocks.PostBranchFirstHorizonsFinite.roughCoefficient_three_eq_four
#print axioms BuildingBlocks.PostBranchFirstHorizonsFinite.roughCoefficient_two_three
#print axioms BuildingBlocks.PostBranchFirstHorizonsFinite.roughCoefficient_three_three
#print axioms BuildingBlocks.PostBranchFirstHorizonsFinite.roughCoefficient_three_five
#print axioms BuildingBlocks.PostBranchFirstHorizonsFinite.roughCoefficient_five_five
#print axioms BuildingBlocks.PostBranchFirstHorizonsFinite.roughCoefficient_prime_square_zero
