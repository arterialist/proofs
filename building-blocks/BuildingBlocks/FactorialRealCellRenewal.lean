import BuildingBlocks.FactorialRealCellTest
import BuildingBlocks.FactorialFiniteRenewal
import Mathlib.Algebra.Order.Floor.Semifield

open Real Finset
open scoped BigOperators
open BuildingBlocks.HyperbolaProduct

namespace BuildingBlocks.FactorialRealCellPhase

/-- The moving real test cancels complete divisor histories at every rational jump. -/
theorem movingInverseTest_rational_renewal (q : ℕ) (t : ℝ) (hq : 0 < q) :
    (∑ k ∈ Finset.Icc 1 q, movingInverseTest t ((q : ℝ) / k)) = centeredTest t q := by
  simp only [movingInverseTest, finiteInverseTest, Nat.floor_div_eq_div]
  simp_rw [div_div, ← Nat.cast_mul]
  rw [← sum_divisors_eq_sum_factor_pairs q
    (fun k n => (ArithmeticFunction.moebius n : ℝ) * centeredTest t ((q : ℝ) / ((k * n : ℕ) : ℝ)))]
  have he : ∀ m ∈ Finset.Icc 1 q,
      (∑ k ∈ m.divisors, (ArithmeticFunction.moebius (m / k) : ℝ) *
        centeredTest t ((q : ℝ) / ((k * (m / k) : ℕ) : ℝ))) =
      (if m = 1 then 1 else 0) * centeredTest t ((q : ℝ) / m) := by
    intro m hm
    have hh : (∑ k ∈ m.divisors, (ArithmeticFunction.moebius k : ℝ)) =
        if m = 1 then 1 else 0 := by
      exact_mod_cast moebius_divisor_sum m
    calc
      _ = ∑ k ∈ m.divisors, (ArithmeticFunction.moebius (m / k) : ℝ) *
          centeredTest t ((q : ℝ) / m) := by
        apply Finset.sum_congr rfl
        intro k hk
        rw [Nat.mul_div_cancel' (Nat.mem_divisors.mp hk).1]
      _ = (∑ k ∈ m.divisors, (ArithmeticFunction.moebius (m / k) : ℝ)) *
          centeredTest t ((q : ℝ) / m) := by rw [Finset.sum_mul]
      _ = _ := by rw [Nat.sum_div_divisors m (fun k => (ArithmeticFunction.moebius k : ℝ)), hh]
  rw [Finset.sum_congr rfl he]
  simp [Finset.mem_Icc.mpr ⟨le_rfl, (by omega : 1 ≤ q)⟩]

/-- The actual signed rational jump pairing equals the full response minus its first row. -/
theorem actual_rational_jump_pairing (N : ℕ) (t : ℝ) (hN : 0 < N) :
    (∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
      ∑ k ∈ Finset.Icc 1 (N / n), movingInverseTest t (((N / n : ℕ) : ℝ) / k)) =
      BuildingBlocks.FactorialBinaryCarry.response N t - (1 - exp (-t)) := by
  have he : (∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
      ∑ k ∈ Finset.Icc 1 (N / n), movingInverseTest t (((N / n : ℕ) : ℝ) / k)) =
      ∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius n : ℝ) * centeredTest t ((N / n : ℕ) : ℝ) := by
    apply Finset.sum_congr rfl
    intro n hn
    rw [movingInverseTest_rational_renewal (N / n) t
      (Nat.div_pos (Finset.mem_Icc.mp hn).2 (Finset.mem_Icc.mp hn).1)]
  rw [he]
  have halg : ∀ n : ℕ, (ArithmeticFunction.moebius n : ℝ) * centeredTest t ((N / n : ℕ) : ℝ) =
      (ArithmeticFunction.moebius n : ℝ) * (1 - exp (-((N / n : ℕ) : ℝ) * t)) -
      ((ArithmeticFunction.moebius n : ℝ) * ((N / n : ℕ) : ℝ)) * (1 - exp (-t)) := by
    intro n
    unfold centeredTest
    ring
  simp_rw [halg]
  unfold BuildingBlocks.FactorialBinaryCarry.response
  rw [Finset.sum_sub_distrib, ← Finset.sum_mul]
  have hh := BuildingBlocks.FactorialQuotientConstraints.quotient_mass_real N 1
    (by omega) (by omega)
  simp only [Nat.div_one] at hh
  rw [hh, one_mul]

#print axioms actual_rational_jump_pairing
#print axioms movingInverseTest_rational_renewal
end BuildingBlocks.FactorialRealCellPhase
