import BuildingBlocks.CenteredGoldbachSuccessorHeatFinite
import BuildingBlocks.CenteredGoldbachPositiveTransferObstruction
import BuildingBlocks.GoldbachOddCentering

/-!
# Adjacent additive totals at a fixed finite source cutoff

This is a change in the Goldbach total, not a successor shift of both source
indices. The newly admitted `n=1` pair and departing `n=Y` pair are explicit.
-/

namespace BuildingBlocks.CenteredGoldbachAdjacentTotalsFinite

open scoped BigOperators
open Finset Real
open BuildingBlocks.GoldbachHeat
open BuildingBlocks.CenteredGoldbachTruncatedHeat
open BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite
open BuildingBlocks.CenteredGoldbachSuccessorHeatFinite

noncomputable section

private theorem sum_Icc_split_one (K : ℕ) (f : ℕ → ℝ) :
    (∑ n ∈ Icc 1 (K + 1), f n) = f 1 + ∑ n ∈ Icc 1 K, f (n + 1) := by
  have hleft : Icc 1 (K + 1) = Ico 1 (K + 2) := by
    ext n
    simp only [mem_Icc, mem_Ico]
    omega
  have hright : Icc 1 K = Ico 1 (K + 1) := by
    ext n
    simp only [mem_Icc, mem_Ico]
    omega
  rw [hleft, hright, Finset.sum_Ico_eq_sum_range, Finset.sum_Ico_eq_sum_range]
  have hsub1 : K + 2 - 1 = K + 1 := by omega
  have hsub2 : K + 1 - 1 = K := by omega
  rw [hsub1, hsub2, Finset.sum_range_succ']
  simp only [Nat.add_zero]
  rw [add_comm]
  congr 1

def boundedCoefficient (a : ℕ → ℝ) (Y N : ℕ) : ℝ :=
  ∑ m ∈ Icc 1 Y, ∑ n ∈ Icc 1 Y,
    if m + n = N then a m * a n else 0

def adjacentDerivativeCore (a : ℕ → ℝ) (Y N : ℕ) : ℝ :=
  ∑ m ∈ Icc 1 Y, ∑ n ∈ Icc 1 (Y - 1),
    if m + n = N then a m * (a (n + 1) - a n) else 0

def birthFace (a : ℕ → ℝ) (Y N : ℕ) : ℝ :=
  ∑ m ∈ Icc 1 Y, if m = N then a m * a 1 else 0

def departureFace (a : ℕ → ℝ) (Y N : ℕ) : ℝ :=
  ∑ m ∈ Icc 1 Y, if m + Y = N then a m * a Y else 0

theorem birthFace_eq_if (a : ℕ → ℝ) (Y N : ℕ) :
    birthFace a Y N = if N ∈ Icc 1 Y then a N * a 1 else 0 := by
  unfold birthFace
  rw [Finset.sum_ite_eq']

theorem departureFace_eq_if (a : ℕ → ℝ) (Y N : ℕ) :
    departureFace a Y N =
      if N - Y ∈ Icc 1 Y then a (N - Y) * a Y else 0 := by
  by_cases hNY : Y ≤ N
  · unfold departureFace
    have hiff (m : ℕ) : m + Y = N ↔ m = N - Y := by omega
    simp_rw [hiff]
    rw [Finset.sum_ite_eq']
  · have hNsub : N - Y = 0 := Nat.sub_eq_zero_of_le (by omega)
    have hnotmem : N - Y ∉ Icc 1 Y := by simp [hNsub]
    rw [if_neg hnotmem]
    unfold departureFace
    apply Finset.sum_eq_zero
    intro m hm
    rw [if_neg]
    omega

/-- Exact adjacent-total identity for an arbitrary real source. The
summation face `n=1` is born while `n=Y` departs; all other pairs contribute
a discrete derivative. -/
theorem boundedCoefficient_adjacent {Y : ℕ} (hY : 1 ≤ Y) (a : ℕ → ℝ) (N : ℕ) :
    boundedCoefficient a Y (N + 1) - boundedCoefficient a Y N =
      adjacentDerivativeCore a Y N + birthFace a Y N - departureFace a Y N := by
  obtain ⟨K, rfl⟩ : ∃ K, Y = K + 1 := ⟨Y - 1, by omega⟩
  unfold boundedCoefficient adjacentDerivativeCore birthFace departureFace
  simp only [← Finset.sum_add_distrib, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro m hm
  rw [Finset.sum_sub_distrib]
  rw [sum_Icc_split_one K]
  rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ K + 1)]
  have hidx : K + 1 - 1 = K := by omega
  rw [hidx]
  have hshift :
      (∑ n ∈ Icc 1 K,
          if m + (n + 1) = N + 1 then a m * a (n + 1) else 0) =
        ∑ n ∈ Icc 1 K,
          if m + n = N then a m * a (n + 1) else 0 := by
    apply Finset.sum_congr rfl
    intro n hn
    have hiff : m + (n + 1) = N + 1 ↔ m + n = N := by omega
    simp only [hiff]
  rw [hshift]
  have hbirth : m + 1 = N + 1 ↔ m = N := by omega
  simp only [hbirth]
  have hcore :
      (∑ n ∈ Icc 1 K, if m + n = N then a m * a (n + 1) else 0) -
        (∑ n ∈ Icc 1 K, if m + n = N then a m * a n else 0) =
      ∑ n ∈ Icc 1 K, if m + n = N then a m * (a (n + 1) - a n) else 0 := by
    rw [← Finset.sum_sub_distrib]
    apply Finset.sum_congr rfl
    intro n hn
    by_cases h : m + n = N
    · simp [h]
      ring
    · simp [h]
  rw [← hcore]
  ring

theorem centered_adjacent {Y : ℕ} (hY : 1 ≤ Y) (N : ℕ) :
    truncatedCoefficient Y (N + 1) - truncatedCoefficient Y N =
      adjacentDerivativeCore centeredCoefficient Y N +
        birthFace centeredCoefficient Y N - departureFace centeredCoefficient Y N := by
  simpa [boundedCoefficient, truncatedCoefficient] using
    boundedCoefficient_adjacent hY centeredCoefficient N

/-- The interior discrete derivative uses literal prime-power differences;
the centering constants cancel inside the core, not at the two faces. -/
theorem centered_adjacent_derivative_eq_mangoldt (Y N : ℕ) :
    adjacentDerivativeCore centeredCoefficient Y N =
      ∑ m ∈ Icc 1 Y, ∑ n ∈ Icc 1 (Y - 1),
        if m + n = N then centeredCoefficient m *
          (ArithmeticFunction.vonMangoldt (n + 1) -
            ArithmeticFunction.vonMangoldt n) else 0 := by
  unfold adjacentDerivativeCore
  apply Finset.sum_congr rfl
  intro m hm
  apply Finset.sum_congr rfl
  intro n hn
  by_cases h : m + n = N
  · simp [h, centeredCoefficient]
  · simp [h]

/-- At an odd additive total, the even source index carries all of the
even-prime-power contribution. Both source indices remain bounded. -/
def evenPrimeRow (Y N : ℕ) : ℝ :=
  ∑ m ∈ Icc 1 Y, ∑ n ∈ Icc 1 Y,
    if m + n = N ∧ Even m then
      ArithmeticFunction.vonMangoldt m * ArithmeticFunction.vonMangoldt n else 0

theorem odd_primeCoefficient_eq_two_evenPrimeRow {N : ℕ} (hodd : Odd N) (Y : ℕ) :
    BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedPrimeCoefficient Y N =
      2 * evenPrimeRow Y N := by
  let s := Icc 1 Y
  have hsplit :
      BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedPrimeCoefficient Y N =
        evenPrimeRow Y N +
          ∑ m ∈ s, ∑ n ∈ s,
            if m + n = N ∧ Even n then
              ArithmeticFunction.vonMangoldt m * ArithmeticFunction.vonMangoldt n else 0 := by
    unfold BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedPrimeCoefficient
      evenPrimeRow
    rw [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro m hm
    rw [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro n hn
    by_cases hsum : m + n = N
    · have hoddmn : Odd (m + n) := by rwa [hsum]
      have hxor : Even m ↔ ¬Even n := by
        have hne : ¬(Even m ↔ Even n) := by
          intro he
          exact (Nat.not_even_iff_odd.mpr hoddmn) (Nat.even_add.mpr he)
        tauto
      by_cases he : Even m
      · have hne := hxor.mp he
        simp [hsum, he, hne]
      · have hen : Even n := by tauto
        simp [hsum, he, hen]
    · simp [hsum]
  have hright :
      (∑ m ∈ s, ∑ n ∈ s,
          if m + n = N ∧ Even n then
            ArithmeticFunction.vonMangoldt m * ArithmeticFunction.vonMangoldt n else 0) =
        evenPrimeRow Y N := by
    rw [Finset.sum_comm]
    unfold evenPrimeRow
    apply Finset.sum_congr rfl
    intro n hn
    apply Finset.sum_congr rfl
    intro m hm
    have hiff : (m + n = N ∧ Even n) ↔ (n + m = N ∧ Even n) := by
      simp [add_comm]
    simp only [hiff]
    by_cases h : n + m = N ∧ Even n <;> simp [h, mul_comm]
  rw [hsplit, hright]
  ring

/-- A neighboring even/odd coefficient pair, before applying the positive
heat shell kernel. -/
def adjacentPair (Y N : ℕ) : ℝ :=
  truncatedCoefficient Y N + truncatedCoefficient Y (N + 1)

theorem coefficient_two_at_three : truncatedCoefficient 3 2 = 1 := by
  rw [truncatedCoefficient_interior (by omega : 2 ≤ 2) (by omega : 2 ≤ 3 + 1)]
  norm_num

theorem coefficient_three_at_three :
    truncatedCoefficient 3 3 = 2 * (1 - log 2) := by
  rw [truncatedCoefficient_interior (by omega : 2 ≤ 3) (by omega : 3 ≤ 3 + 1)]
  simpa using shiftedGoldbach_one

theorem coefficient_five_at_three :
    truncatedCoefficient 3 5 = 2 * (log 2 - 1) * (log 3 - 1) := by
  have h2 : ArithmeticFunction.vonMangoldt 2 = log 2 :=
    ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two
  have h3 : ArithmeticFunction.vonMangoldt 3 = log 3 :=
    ArithmeticFunction.vonMangoldt_apply_prime (by decide)
  have hI : Icc 1 3 = {1, 2, 3} := by decide
  norm_num [truncatedCoefficient, hI, centeredCoefficient, h2, h3]
  ring

theorem coefficient_three_at_three_pos : 0 < truncatedCoefficient 3 3 := by
  rw [coefficient_three_at_three]
  have h2 : log 2 < 1 := by linarith [Real.log_two_lt_d9]
  linarith

theorem coefficient_five_at_three_neg : truncatedCoefficient 3 5 < 0 := by
  rw [coefficient_five_at_three]
  have h2 : log 2 < 1 := by linarith [Real.log_two_lt_d9]
  have h3 : 1 < log 3 := by
    rw [Real.lt_log_iff_exp_lt (by norm_num : (0 : ℝ) < 3)]
    exact Real.exp_one_lt_d9.trans (by norm_num)
  nlinarith [mul_neg_of_neg_of_pos (sub_neg.mpr h2) (sub_pos.mpr h3)]

/-- The first even/odd pair is positive, while the next is negative at
the same literal cutoff. Thus adjacent pairing has no universal sign. -/
theorem adjacentPair_three_two_pos : 0 < adjacentPair 3 2 := by
  unfold adjacentPair
  rw [coefficient_two_at_three, coefficient_three_at_three]
  have h2 : log 2 < 1 := by linarith [Real.log_two_lt_d9]
  linarith

theorem adjacentPair_three_four_neg : adjacentPair 3 4 < 0 := by
  unfold adjacentPair
  have h4 :=
    BuildingBlocks.CenteredGoldbachPositiveTransferObstruction.centered_coefficient_four_neg
  have h5 := coefficient_five_at_three_neg
  linarith

def weightedAdjacentPair (Y N : ℕ) (T : ℝ) : ℝ :=
  truncatedCoefficient Y N * shellKernel T N +
    truncatedCoefficient Y (N + 1) * shellKernel T (N + 1)

private theorem shellKernel_pos {T : ℝ} (hT : 0 < T)
    {N : ℕ} (hN : 0 < N) : 0 < shellKernel T N := by
  unfold shellKernel
  apply div_pos
  · apply sub_pos.mpr
    apply exp_lt_exp.mpr
    have he : exp (-2 * T) < exp (-T) := exp_lt_exp.mpr (by linarith)
    have hNr : (0 : ℝ) < N := by exact_mod_cast hN
    exact neg_lt_neg (mul_lt_mul_of_pos_left he hNr)
  · exact_mod_cast hN

/-- Even with the actual positive heat-shell kernel, adjacent even/odd
pairs have opposite signs at one fixed cutoff. -/
theorem weightedAdjacentPair_three_two_pos {T : ℝ} (hT : 0 < T) :
    0 < weightedAdjacentPair 3 2 T := by
  unfold weightedAdjacentPair
  have h2 : 0 < truncatedCoefficient 3 2 := by rw [coefficient_two_at_three]; norm_num
  have h3 := coefficient_three_at_three_pos
  have hk2 := shellKernel_pos hT (by omega : 0 < 2)
  have hk3 := shellKernel_pos hT (by omega : 0 < 3)
  exact add_pos (mul_pos h2 hk2) (mul_pos h3 hk3)

theorem weightedAdjacentPair_three_four_neg {T : ℝ} (hT : 0 < T) :
    weightedAdjacentPair 3 4 T < 0 := by
  unfold weightedAdjacentPair
  have h4 :=
    BuildingBlocks.CenteredGoldbachPositiveTransferObstruction.centered_coefficient_four_neg
  have h5 := coefficient_five_at_three_neg
  have hk4 := shellKernel_pos hT (by omega : 0 < 4)
  have hk5 := shellKernel_pos hT (by omega : 0 < 5)
  exact add_neg (mul_neg_of_neg_of_pos h4 hk4) (mul_neg_of_neg_of_pos h5 hk5)

#print axioms boundedCoefficient_adjacent
#print axioms birthFace_eq_if
#print axioms departureFace_eq_if
#print axioms centered_adjacent
#print axioms centered_adjacent_derivative_eq_mangoldt
#print axioms odd_primeCoefficient_eq_two_evenPrimeRow
#print axioms adjacentPair_three_two_pos
#print axioms adjacentPair_three_four_neg
#print axioms weightedAdjacentPair_three_two_pos
#print axioms weightedAdjacentPair_three_four_neg

end
end BuildingBlocks.CenteredGoldbachAdjacentTotalsFinite
