import BuildingBlocks.GoldbachHeatConvolution
import Mathlib.Tactic

open scoped BigOperators

namespace BuildingBlocks.CenteredGoldbachTruncatedHeat

open Finset
open BuildingBlocks.GoldbachHeat

noncomputable def truncatedHeat (Y : ℕ) (z : ℝ) : ℝ :=
  ∑ n ∈ Icc 1 Y, centeredCoefficient n * z ^ n

noncomputable def truncatedCoefficient (Y N : ℕ) : ℝ :=
  ∑ m ∈ Icc 1 Y, ∑ n ∈ Icc 1 Y,
    if m + n = N then centeredCoefficient m * centeredCoefficient n else 0

/-- Finite Cauchy product, grouped by the ordinary additive total. -/
theorem truncatedHeat_square (Y : ℕ) (z : ℝ) :
    truncatedHeat Y z ^ 2 =
      ∑ N ∈ Icc 2 (2 * Y), truncatedCoefficient Y N * z ^ N := by
  rw [pow_two, truncatedHeat, Finset.sum_mul_sum]
  simp only [truncatedCoefficient, Finset.sum_mul]
  rw [Finset.sum_comm]
  simp_rw [Finset.sum_comm (s := Icc 2 (2 * Y))]
  apply Finset.sum_congr rfl
  intro m hm
  apply Finset.sum_congr rfl
  intro n hn
  have hmn : m + n ∈ Icc 2 (2 * Y) := by
    simp only [mem_Icc] at hm hn ⊢
    omega
  simp_rw [ite_mul, zero_mul]
  rw [Finset.sum_ite_eq, if_pos hmn]
  rw [pow_add]
  ring

private theorem finiteHeat_eq_truncatedHeat (Y : ℕ) (t : ℝ) :
    finiteHeat centeredCoefficient Y t = truncatedHeat Y (Real.exp (-t)) := by
  unfold finiteHeat truncatedHeat
  apply Finset.sum_congr rfl
  intro n hn
  congr 1
  rw [← Real.exp_nat_mul]
  congr 1
  ring

/-- The actual truncated centered heat square has coefficients supported
on additive totals from `2` through `2Y`. -/
theorem centered_finiteHeat_square (Y : ℕ) (t : ℝ) :
    finiteHeat centeredCoefficient Y t ^ 2 =
      ∑ N ∈ Icc 2 (2 * Y), truncatedCoefficient Y N *
        Real.exp (-((N : ℝ) * t)) := by
  rw [finiteHeat_eq_truncatedHeat, truncatedHeat_square]
  apply Finset.sum_congr rfl
  intro N hN
  congr 1
  rw [← Real.exp_nat_mul]
  congr 1
  ring

theorem truncatedCoefficient_eq_zero_of_two_mul_lt {Y N : ℕ} (hN : 2 * Y < N) :
    truncatedCoefficient Y N = 0 := by
  unfold truncatedCoefficient
  apply Finset.sum_eq_zero
  intro m hm
  apply Finset.sum_eq_zero
  intro n hn
  rw [if_neg]
  simp only [mem_Icc] at hm hn
  omega

private theorem inner_coefficient_sum {Y N m : ℕ} (hN : N ≤ Y + 1) (hm1 : 1 ≤ m) :
    (∑ n ∈ Icc 1 Y,
      if m + n = N then centeredCoefficient m * centeredCoefficient n else 0) =
      if m < N then centeredCoefficient m * centeredCoefficient (N - m) else 0 := by
  by_cases hmN : m < N
  · have hmem : N - m ∈ Icc 1 Y := by
      simp only [mem_Icc]
      omega
    calc
      (∑ n ∈ Icc 1 Y,
          if m + n = N then centeredCoefficient m * centeredCoefficient n else 0) =
          ∑ n ∈ Icc 1 Y,
            if n = N - m then centeredCoefficient m * centeredCoefficient n else 0 := by
              apply Finset.sum_congr rfl
              intro n hn
              by_cases h : m + n = N
              · have hn' : n = N - m := by omega
                rw [if_pos h, if_pos hn']
              · have hn' : n ≠ N - m := by omega
                simp [h, hn']
      _ = centeredCoefficient m * centeredCoefficient (N - m) := by
        rw [Finset.sum_ite_eq', if_pos hmem]
      _ = _ := by simp [hmN]
  · have hmN' : N ≤ m := by omega
    have hz : ∀ n ∈ Icc 1 Y, m + n ≠ N := by
      intro n hn
      simp only [mem_Icc] at hn
      omega
    rw [if_neg hmN]
    apply Finset.sum_eq_zero
    intro n hn
    rw [if_neg (hz n hn)]

private theorem truncatedCoefficient_eq_Icc {Y N : ℕ} (hN : N ≤ Y + 1) :
    truncatedCoefficient Y N =
      ∑ m ∈ Icc 1 (N - 1), centeredCoefficient m * centeredCoefficient (N - m) := by
  calc
    truncatedCoefficient Y N =
        ∑ m ∈ Icc 1 Y,
          if m < N then centeredCoefficient m * centeredCoefficient (N - m) else 0 := by
      unfold truncatedCoefficient
      apply Finset.sum_congr rfl
      intro m hm
      rw [inner_coefficient_sum hN (Finset.mem_Icc.mp hm).1]
    _ = ∑ m ∈ Icc 1 (N - 1),
          centeredCoefficient m * centeredCoefficient (N - m) := by
      have hsub : Icc 1 (N - 1) ⊆ Icc 1 Y := by
        intro m hm
        simp only [mem_Icc] at hm ⊢
        omega
      rw [← Finset.sum_subset hsub]
      · apply Finset.sum_congr rfl
        intro m hm
        simp only [mem_Icc] at hm
        simp [show m < N by omega]
      · intro m hmY hmnot
        simp only [mem_Icc] at hmY
        have hmge : N ≤ m := by
          by_contra h
          apply hmnot
          simp only [mem_Icc]
          omega
        simp [show ¬m < N by omega]

private theorem Icc_centered_eq_shiftedGoldbach {N : ℕ} (hN : 2 ≤ N) :
    (∑ m ∈ Icc 1 (N - 1), centeredCoefficient m * centeredCoefficient (N - m)) =
      shiftedGoldbach (N - 2) := by
  have hI : Icc 1 (N - 1) = Ico 1 N := by
    ext m
    simp only [mem_Icc, mem_Ico]
    omega
  rw [hI, Finset.sum_Ico_eq_sum_range]
  unfold shiftedGoldbach
  rw [Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk]
  have hr : N - 1 = (N - 2).succ := by omega
  rw [hr]
  apply Finset.sum_congr rfl
  intro k hk
  simp only [mem_range] at hk
  have hs : N - (1 + k) = N - 2 - k + 1 := by omega
  rw [hs]
  congr 2 <;> omega

theorem truncatedCoefficient_interior {Y N : ℕ} (hN2 : 2 ≤ N) (hNY : N ≤ Y + 1) :
    truncatedCoefficient Y N = shiftedGoldbach (N - 2) := by
  rw [truncatedCoefficient_eq_Icc hNY, Icc_centered_eq_shiftedGoldbach hN2]

theorem truncatedCoefficient_interior_prime_psi {Y N : ℕ}
    (hN2 : 2 ≤ N) (hNY : N ≤ Y + 1) :
    truncatedCoefficient Y N =
      shiftedPrimeGoldbach (N - 2) - 2 * BuildingBlocks.CoarsePrimitive.psi (N - 1) +
        (N - 1 : ℕ) := by
  rw [truncatedCoefficient_interior hN2 hNY,
    shiftedGoldbach_eq_prime_psi]
  have hidx : N - 2 + 1 = N - 1 := by omega
  rw [hidx]

private theorem Icc_prime_eq_shiftedPrimeGoldbach {N : ℕ} (hN : 2 ≤ N) :
    (∑ m ∈ Icc 1 (N - 1), ArithmeticFunction.vonMangoldt m *
      ArithmeticFunction.vonMangoldt (N - m)) = shiftedPrimeGoldbach (N - 2) := by
  have hI : Icc 1 (N - 1) = Ico 1 N := by
    ext m
    simp only [mem_Icc, mem_Ico]
    omega
  rw [hI, Finset.sum_Ico_eq_sum_range]
  unfold shiftedPrimeGoldbach
  rw [Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk]
  have hr : N - 1 = (N - 2).succ := by omega
  rw [hr]
  apply Finset.sum_congr rfl
  intro k hk
  simp only [mem_range] at hk
  have hs : N - (1 + k) = N - 2 - k + 1 := by omega
  rw [hs]
  congr 2 <;> omega

private theorem shiftedPrimeGoldbach_successor {N : ℕ} (hN : 2 ≤ N) :
    shiftedPrimeGoldbach (N - 1) - shiftedPrimeGoldbach (N - 2) =
      ∑ m ∈ Icc 1 (N - 1), ArithmeticFunction.vonMangoldt m *
        (ArithmeticFunction.vonMangoldt (N + 1 - m) -
          ArithmeticFunction.vonMangoldt (N - m)) := by
  rw [← Icc_prime_eq_shiftedPrimeGoldbach (N := N) hN]
  have hNp : 2 ≤ N + 1 := by omega
  have hnext := (Icc_prime_eq_shiftedPrimeGoldbach (N := N + 1) hNp).symm
  simp only [show N + 1 - 1 = N by omega, show N + 1 - 2 = N - 1 by omega] at hnext
  rw [hnext]
  have hsub : Icc 1 (N - 1) ⊆ Icc 1 N := by
    intro m hm
    simp only [mem_Icc] at hm ⊢
    omega
  have hfirst :
      (∑ m ∈ Icc 1 N, ArithmeticFunction.vonMangoldt m *
        ArithmeticFunction.vonMangoldt (N + 1 - m)) =
      ∑ m ∈ Icc 1 (N - 1), ArithmeticFunction.vonMangoldt m *
        ArithmeticFunction.vonMangoldt (N + 1 - m) := by
    symm
    apply Finset.sum_subset hsub
    intro m hmN hmnot
    simp only [mem_Icc] at hmN
    have hm : m = N := by
      by_contra h
      apply hmnot
      simp only [mem_Icc]
      omega
    subst m
    simp
  rw [hfirst, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro m hm
  ring

/-- Exact ordinary additive successor difference for the full centered
coefficient. Every ordered prime-power history and the endpoint birth remain. -/
theorem centeredGoldbach_successor {N : ℕ} (hN : 2 ≤ N) :
    shiftedGoldbach (N - 1) - shiftedGoldbach (N - 2) =
      (∑ m ∈ Icc 1 (N - 1), ArithmeticFunction.vonMangoldt m *
        (ArithmeticFunction.vonMangoldt (N + 1 - m) -
          ArithmeticFunction.vonMangoldt (N - m))) -
        2 * ArithmeticFunction.vonMangoldt N + 1 := by
  rw [shiftedGoldbach_eq_prime_psi, shiftedGoldbach_eq_prime_psi]
  have hidx : N - 2 + 1 = N - 1 := by omega
  have hidx' : N - 1 + 1 = N := by omega
  rw [hidx, hidx']
  have hprime := shiftedPrimeGoldbach_successor hN
  have hpsi : BuildingBlocks.CoarsePrimitive.psi N =
      BuildingBlocks.CoarsePrimitive.psi (N - 1) + ArithmeticFunction.vonMangoldt N := by
    have h := BuildingBlocks.CoarsePrimitive.psi_succ (N - 1)
    rw [show N - 1 + 1 = N by omega] at h
    exact h
  rw [hpsi]
  have hcast : ((N - 1 : ℕ) : ℝ) = (N : ℝ) - 1 := by
    rw [Nat.cast_sub (by omega : 1 ≤ N)]
    norm_num
  rw [hcast]
  linear_combination hprime

#print axioms truncatedHeat_square
#print axioms centered_finiteHeat_square
#print axioms truncatedCoefficient_eq_zero_of_two_mul_lt
#print axioms truncatedCoefficient_interior
#print axioms truncatedCoefficient_interior_prime_psi
#print axioms centeredGoldbach_successor

end BuildingBlocks.CenteredGoldbachTruncatedHeat
