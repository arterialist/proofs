import BuildingBlocks.FactorialResponseDerivative
import Mathlib.Tactic

open Finset
open scoped BigOperators
open BuildingBlocks.FactorialBinaryCarry

namespace BuildingBlocks.FactorialResponseCounterexample

theorem moebius_thirteen_table :
    (List.range 14).map ArithmeticFunction.moebius =
      [0, 1, -1, -1, 0, -1, 1, -1, 0, 0, 1, -1, 0, -1] := by
  have h2 := ArithmeticFunction.moebius_apply_prime (by norm_num : Nat.Prime 2)
  have h3 := ArithmeticFunction.moebius_apply_prime (by norm_num : Nat.Prime 3)
  have h5 := ArithmeticFunction.moebius_apply_prime (by norm_num : Nat.Prime 5)
  have h7 := ArithmeticFunction.moebius_apply_prime (by norm_num : Nat.Prime 7)
  have h11 := ArithmeticFunction.moebius_apply_prime (by norm_num : Nat.Prime 11)
  have h13 := ArithmeticFunction.moebius_apply_prime (by norm_num : Nat.Prime 13)
  have h4 : ArithmeticFunction.moebius 4 = 0 := by
    simpa using ArithmeticFunction.moebius_apply_prime_pow
      (by norm_num : Nat.Prime 2) (by norm_num : (2 : ℕ) ≠ 0)
  have h8 : ArithmeticFunction.moebius 8 = 0 := by
    simpa using ArithmeticFunction.moebius_apply_prime_pow
      (by norm_num : Nat.Prime 2) (by norm_num : (3 : ℕ) ≠ 0)
  have h9 : ArithmeticFunction.moebius 9 = 0 := by
    simpa using ArithmeticFunction.moebius_apply_prime_pow
      (by norm_num : Nat.Prime 3) (by norm_num : (2 : ℕ) ≠ 0)
  have h6 : ArithmeticFunction.moebius 6 = 1 := by
    have h := ArithmeticFunction.isMultiplicative_moebius.map_mul_of_coprime
      (by norm_num : Nat.Coprime 2 3)
    simpa [h2, h3] using h
  have h10 : ArithmeticFunction.moebius 10 = 1 := by
    have h := ArithmeticFunction.isMultiplicative_moebius.map_mul_of_coprime
      (by norm_num : Nat.Coprime 2 5)
    simpa [h2, h5] using h
  have h12 : ArithmeticFunction.moebius 12 = 0 := by
    have h := ArithmeticFunction.isMultiplicative_moebius.map_mul_of_coprime
      (by norm_num : Nat.Coprime 4 3)
    simpa [h4, h3] using h
  norm_num [List.range_succ, List.map_cons, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, h12, h13]

theorem response_thirteen_polynomial (t : ℝ) :
    response 13 t = -3 + 2 * Real.exp (-t) + Real.exp (-t) ^ 4 +
      Real.exp (-t) ^ 6 - Real.exp (-t) ^ 13 := by
  have hm := moebius_thirteen_table
  norm_num [List.range_succ, List.map_cons] at hm
  rcases hm with ⟨h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, h12, h13⟩
  unfold response
  norm_num [Finset.sum_Icc_succ_top, h2, h3, h4, h5, h6, h7, h8, h9,
    h10, h11, h12, h13]
  have he (q : ℕ) : Real.exp (-((q : ℝ) * t)) = Real.exp (-t) ^ q := by
    rw [show -((q : ℝ) * t) = (q : ℝ) * (-t) by ring, Real.exp_nat_mul]
  have he6 := he 6
  have he13 := he 13
  have he4 := he 4
  norm_num at he6 he13 he4
  rw [he6, he13, he4]
  ring

/-- Exact negative value, certified in the real field by rational arithmetic. -/
theorem response_thirteen_log_two :
    response 13 (Real.log 2) = -(15745 : ℝ) / 8192 := by
  have he : Real.exp (-Real.log 2) = (1 / 2 : ℝ) := by
    rw [Real.exp_neg, Real.exp_log (by norm_num : (0 : ℝ) < 2)]
    norm_num
  rw [response_thirteen_polynomial, he]
  norm_num

theorem response_thirteen_negative : response 13 (Real.log 2) < 0 := by
  rw [response_thirteen_log_two]
  norm_num

/-- The actual response is not nonnegative at all positive cutoffs and times. -/
theorem not_universal_response_nonneg :
    ¬ (∀ N : ℕ, 0 < N → ∀ t : ℝ, 0 < t → 0 ≤ response N t) := by
  intro h
  have hp := h 13 (by norm_num) (Real.log 2) (Real.log_pos (by norm_num))
  exact (not_le_of_gt response_thirteen_negative) hp

#print axioms response_thirteen_log_two
#print axioms response_thirteen_negative
#print axioms not_universal_response_nonneg
#print axioms moebius_thirteen_table
#print axioms response_thirteen_polynomial

end BuildingBlocks.FactorialResponseCounterexample
