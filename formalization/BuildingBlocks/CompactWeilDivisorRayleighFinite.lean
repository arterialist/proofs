import BuildingBlocks.CoarsePrimeBounds
import Mathlib.Tactic

/-!
# Finite divisor-packet Rayleigh numerator

The exact finite arithmetic collapse behind the divisor-matrix
Rayleigh quotient. The spectral asymptotic and the complete Weil
form are separate analytic statements.
-/

namespace BuildingBlocks.CompactWeilDivisorRayleighFinite

open scoped BigOperators

noncomputable section

/-- Every von Mangoldt prime-power edge of the resolved divisor packet
is retained. The `d = 1` term vanishes automatically. -/
theorem complete_divisor_edge_sum (N : ℕ) :
    (∑ d ∈ Finset.Icc 1 N,
      ∑ r ∈ Finset.Icc 1 (N / d),
        ArithmeticFunction.vonMangoldt d / ((d : ℝ) * r)) =
      ∑ m ∈ Finset.Icc 1 N, Real.log m / (m : ℝ) := by
  rw [← BuildingBlocks.HyperbolaProduct.sum_divisors_eq_sum_factor_pairs N
    (fun d r => ArithmeticFunction.vonMangoldt d / ((d : ℝ) * r))]
  apply Finset.sum_congr rfl
  intro m hm
  calc
    (∑ d ∈ m.divisors,
        ArithmeticFunction.vonMangoldt d / ((d : ℝ) * (m / d : ℕ))) =
      ∑ d ∈ m.divisors,
        ArithmeticFunction.vonMangoldt d / (m : ℝ) := by
          apply Finset.sum_congr rfl
          intro d hd
          have hprod : d * (m / d) = m :=
            Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1
          rw [← Nat.cast_mul, hprod]
    _ = (∑ d ∈ m.divisors, ArithmeticFunction.vonMangoldt d) / (m : ℝ) := by
          rw [Finset.sum_div]
    _ = Real.log m / (m : ℝ) := by
          rw [ArithmeticFunction.vonMangoldt_sum]

/-- The ordered-pair numerator of the packet divisor matrix is twice
the full logarithmic harmonic sum. -/
theorem ordered_divisor_rayleigh_numerator (N : ℕ) :
    2 * (∑ d ∈ Finset.Icc 1 N,
      ∑ r ∈ Finset.Icc 1 (N / d),
        ArithmeticFunction.vonMangoldt d / ((d : ℝ) * r)) =
      2 * ∑ m ∈ Finset.Icc 1 N, Real.log m / (m : ℝ) := by
  rw [complete_divisor_edge_sum]

#print axioms complete_divisor_edge_sum
#print axioms ordered_divisor_rayleigh_numerator

end

end BuildingBlocks.CompactWeilDivisorRayleighFinite
