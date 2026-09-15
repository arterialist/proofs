import BuildingBlocks.TiltedPrimeCumulative

open Finset
open scoped BigOperators

namespace BuildingBlocks.ResidueLoadingSuccessor

open CoarsePrimitive FloorCorrection

/-- The actual residue loading, with all von Mangoldt masses retained. -/
noncomputable def loading (N : ℕ) : ℝ :=
  ∑ n ∈ Icc 1 N, ArithmeticFunction.vonMangoldt n *
    (1 - Int.fract ((N : ℝ) / n))

theorem fract_quotient (N n : ℕ) :
    Int.fract ((N : ℝ) / n) = (N : ℝ) / n - ((N / n : ℕ) : ℝ) := by
  have h : (⌊(N : ℝ) / n⌋₊ : ℝ) = (⌊(N : ℝ) / n⌋ : ℝ) :=
    natCast_floor_eq_intCast_floor (by positivity)
  rw [Int.fract, ← h, Nat.floor_div_natCast, Nat.floor_natCast]

theorem loading_eq_factorial (N : ℕ) :
    loading N = psi N + logFactorial N - (N : ℝ) * logarithmicPrimeMass N := by
  rw [loading, psi_eq_sum_Icc, logFactorial_eq_weighted_prime_sum,
    logarithmicPrimeMass, Finset.mul_sum, ← Finset.sum_add_distrib,
    ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro n _
  rw [fract_quotient]
  ring

theorem loading_nonneg (N : ℕ) : 0 ≤ loading N := by
  apply Finset.sum_nonneg
  intro n _
  exact mul_nonneg ArithmeticFunction.vonMangoldt_nonneg
    (sub_nonneg.mpr (Int.fract_lt_one _).le)

theorem loading_succ (N : ℕ) :
    loading (N + 1) - loading N =
      Real.log ((N : ℝ) + 1) - logarithmicPrimeMass N := by
  have hp : psi (N + 1) = psi N + ArithmeticFunction.vonMangoldt (N + 1) := by
    rw [psi_eq_sum_Icc, Finset.sum_Icc_succ_top (by omega : 1 ≤ N + 1),
      ← psi_eq_sum_Icc]
  have hf : logFactorial (N + 1) = logFactorial N + Real.log ((N : ℝ) + 1) := by
    simp only [logFactorial, Finset.sum_Icc_succ_top (by omega : 1 ≤ N + 1),
      Nat.cast_add, Nat.cast_one]
  have hm : logarithmicPrimeMass (N + 1) = logarithmicPrimeMass N +
      ArithmeticFunction.vonMangoldt (N + 1) / ((N : ℝ) + 1) := by
    simp only [logarithmicPrimeMass,
      Finset.sum_Icc_succ_top (by omega : 1 ≤ N + 1), Nat.cast_add, Nat.cast_one]
  rw [loading_eq_factorial, loading_eq_factorial, hp, hf, hm]
  push_cast
  have hden : (N : ℝ) + 1 ≠ 0 := by positivity
  field_simp
  ring

theorem loading_second_difference (N : ℕ) :
    loading (N + 2) - 2 * loading (N + 1) + loading N =
      Real.log (((N : ℝ) + 2) / ((N : ℝ) + 1)) -
        ArithmeticFunction.vonMangoldt (N + 1) / ((N : ℝ) + 1) := by
  have h1 := loading_succ N
  have h2 := loading_succ (N + 1)
  have hm : logarithmicPrimeMass (N + 1) = logarithmicPrimeMass N +
      ArithmeticFunction.vonMangoldt (N + 1) / ((N : ℝ) + 1) := by
    simp only [logarithmicPrimeMass,
      Finset.sum_Icc_succ_top (by omega : 1 ≤ N + 1), Nat.cast_add, Nat.cast_one]
  rw [hm] at h2
  norm_num only [Nat.cast_add, Nat.cast_one] at h2
  rw [Real.log_div (by positivity : (N : ℝ) + 2 ≠ 0)
    (by positivity : (N : ℝ) + 1 ≠ 0)]
  have hn : N + 1 + 1 = N + 2 := by omega
  rw [hn] at h2
  have harg : (N : ℝ) + 1 + 1 = (N : ℝ) + 2 := by ring
  rw [harg] at h2
  linarith

#print axioms fract_quotient
#print axioms loading_eq_factorial
#print axioms loading_nonneg
#print axioms loading_succ
#print axioms loading_second_difference

end BuildingBlocks.ResidueLoadingSuccessor
