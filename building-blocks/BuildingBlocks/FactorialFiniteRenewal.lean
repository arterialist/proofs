import BuildingBlocks.FactorialQuotientConstraints

open Finset
open BuildingBlocks.HyperbolaProduct
open scoped BigOperators

namespace BuildingBlocks.FactorialFiniteRenewal

/-- Complete division histories cancel by the actual Möbius divisor identity. -/
theorem division_renewal (f : ℕ → ℝ) (N : ℕ) (hN : 0 < N) :
    (∑ k ∈ Icc 1 N, ∑ n ∈ Icc 1 (N / k),
      (ArithmeticFunction.moebius n : ℝ) * f (N / k / n)) = f N := by
  simp_rw [Nat.div_div_eq_div_mul]
  rw [← sum_divisors_eq_sum_factor_pairs N
    (fun k n => (ArithmeticFunction.moebius n : ℝ) * f (N / (k * n)))]
  have he : ∀ m ∈ Icc 1 N,
      (∑ k ∈ m.divisors, (ArithmeticFunction.moebius (m / k) : ℝ) *
        f (N / (k * (m / k)))) = (if m = 1 then 1 else 0) * f (N / m) := by
    intro m hm
    have hh : (∑ k ∈ m.divisors, (ArithmeticFunction.moebius k : ℝ)) =
        if m = 1 then 1 else 0 := by
      exact_mod_cast BuildingBlocks.HyperbolaProduct.moebius_divisor_sum m
    calc
      _ = ∑ k ∈ m.divisors, (ArithmeticFunction.moebius (m / k) : ℝ) *
          f (N / m) := by
        apply Finset.sum_congr rfl
        intro k hk
        rw [Nat.mul_div_cancel' (Nat.mem_divisors.mp hk).1]
      _ = (∑ k ∈ m.divisors, (ArithmeticFunction.moebius (m / k) : ℝ)) *
          f (N / m) := by rw [Finset.sum_mul]
      _ = _ := by
        rw [Nat.sum_div_divisors m (fun q => (ArithmeticFunction.moebius q : ℝ)), hh]
  rw [Finset.sum_congr rfl he]
  simp [Finset.mem_Icc.mpr ⟨le_rfl, (by omega : 1 ≤ N)⟩]

/-- Literal finite response renewal for every real time, with the endpoint retained. -/
theorem response_renewal (N : ℕ) (t : ℝ) :
    (∑ k ∈ Icc 1 N, BuildingBlocks.FactorialBinaryCarry.response (N / k) t) =
      1 - Real.exp (-(N : ℝ) * t) := by
  rcases Nat.eq_zero_or_pos N with rfl | hN
  · simp [BuildingBlocks.FactorialBinaryCarry.response]
  · exact division_renewal (fun q => 1 - Real.exp (-(q : ℝ) * t)) N hN

#print axioms division_renewal
#print axioms response_renewal

end BuildingBlocks.FactorialFiniteRenewal
