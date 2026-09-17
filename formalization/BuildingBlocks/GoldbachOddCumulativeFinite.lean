import BuildingBlocks.GoldbachOddPowerBoundFinite
import BuildingBlocks.GoldbachCumulativeFinite
import BuildingBlocks.CoarsePrimeBounds
import Mathlib.Tactic

/-! Exact cumulative odd Goldbach reindexing by the even power-of-two source. -/

namespace BuildingBlocks.GoldbachOddCumulativeFinite

open Finset Real
open BuildingBlocks.GoldbachOddPowerBoundFinite
open BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite

noncomputable section

abbrev Λ (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n

def oddPartner (Y : ℕ) : ℝ :=
  ∑ m ∈ Icc 1 Y, if Odd m then Λ m else 0

/-- The odd partner keeps every odd prime power and removes exactly
the even powers of two from the complete Chebyshev sum. -/
theorem oddPartner_eq_psi_sub_pow2 (Y : ℕ) :
    oddPartner Y =
      BuildingBlocks.CoarsePrimitive.psi Y -
        (Nat.log 2 Y : ℝ) * Real.log 2 := by
  rw [BuildingBlocks.CoarsePrimitive.psi_eq_sum_Icc]
  have hsplit :
      (∑ m ∈ Icc 1 Y, Λ m) =
        oddPartner Y +
          ∑ m ∈ Icc 1 Y, if Even m then Λ m else 0 := by
    unfold oddPartner
    rw [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro m hm
    rcases Nat.even_or_odd m with he | ho
    · have hnot : ¬Odd m := Nat.not_odd_iff_even.mpr he
      simp [he, hnot]
    · have hnot : ¬Even m := Nat.not_even_iff_odd.mpr ho
      simp [ho, hnot]
  rw [hsplit, BuildingBlocks.GoldbachOddPowerBoundFinite.even_vonMangoldt_sum]
  ring

def cumulativeOdd (X : ℕ) : ℝ :=
  ∑ N ∈ Icc 1 X, if Odd N then truncatedPrimeCoefficient X N else 0

private theorem truncated_eq_complete (X N : ℕ) (hNX : N ≤ X) :
    truncatedPrimeCoefficient X N =
      BuildingBlocks.GoldbachCumulativeFinite.goldbachAt N := by
  have hfirst :
      truncatedPrimeCoefficient X N =
        ∑ p ∈ ((Icc 1 X).product (Icc 1 X)).filter
          (fun p : ℕ × ℕ => p.1 + p.2 = N), Λ p.1 * Λ p.2 := by
    simp [truncatedPrimeCoefficient, Finset.sum_product, Finset.sum_filter, Λ]
  have hset :
      ((Icc 1 X).product (Icc 1 X)).filter
          (fun p : ℕ × ℕ => p.1 + p.2 = N) =
        (antidiagonal N).filter (fun p => 0 < p.1 ∧ 0 < p.2) := by
    ext p
    simp only [mem_filter, mem_antidiagonal]
    constructor
    · rintro ⟨hp, hsum⟩
      obtain ⟨h1, h2⟩ := mem_product.mp hp
      have hp1 : 0 < p.1 := by
        have := (mem_Icc.mp h1).1
        omega
      have hp2 : 0 < p.2 := by
        have := (mem_Icc.mp h2).1
        omega
      exact ⟨hsum, hp1, hp2⟩
    · rintro ⟨hsum, hp1, hp2⟩
      have h1 : p.1 ∈ Icc 1 X := mem_Icc.mpr (by omega)
      have h2 : p.2 ∈ Icc 1 X := mem_Icc.mpr (by omega)
      exact ⟨mem_product.mpr ⟨h1, h2⟩, hsum⟩
  rw [hfirst, hset]
  unfold BuildingBlocks.GoldbachCumulativeFinite.goldbachAt
  rw [Finset.sum_filter]
  apply Finset.sum_congr rfl
  intro p hp
  by_cases hpos : 0 < p.1 ∧ 0 < p.2
  · simp [hpos, Λ]
  · have hz : p.1 = 0 ∨ p.2 = 0 := by omega
    rcases hz with h | h
    · simp [h]
    · simp [h]

private theorem shifted_odd_row (X k : ℕ) (hk : 1 ≤ k) :
    (∑ N ∈ Icc 1 X,
      if Odd N ∧ 2 ^ k ≤ N ∧ N - 2 ^ k ∈ Icc 1 X then Λ (N - 2 ^ k)
      else 0) = oddPartner (X - 2 ^ k) := by
  let s := (Icc 1 X).filter
    (fun N => Odd N ∧ 2 ^ k ≤ N ∧ N - 2 ^ k ∈ Icc 1 X)
  let t := (Icc 1 (X - 2 ^ k)).filter (fun m => Odd m)
  have hs :
      (∑ N ∈ Icc 1 X,
        if Odd N ∧ 2 ^ k ≤ N ∧ N - 2 ^ k ∈ Icc 1 X then Λ (N - 2 ^ k)
        else 0) = ∑ N ∈ s, Λ (N - 2 ^ k) := by
    simp [s, Finset.sum_filter]
  have ht : oddPartner (X - 2 ^ k) = ∑ m ∈ t, Λ m := by
    simp [oddPartner, t, Finset.sum_filter]
  rw [hs, ht]
  have heven : Even (2 ^ k) := even_two.pow_of_ne_zero (by omega)
  apply Finset.sum_bij (fun N _ => N - 2 ^ k)
  · intro N hN
    have hNX : N ≤ X := (mem_Icc.mp (mem_filter.mp hN).1).2
    have hOdd : Odd N := (mem_filter.mp hN).2.1
    have hPow : 2 ^ k ≤ N := (mem_filter.mp hN).2.2.1
    have hPart : N - 2 ^ k ∈ Icc 1 X := (mem_filter.mp hN).2.2.2
    have hOddPart : Odd (N - 2 ^ k) := by
      obtain ⟨a, ha⟩ := hOdd
      obtain ⟨b, hb⟩ := heven
      refine ⟨a - b, ?_⟩
      omega
    have hSubLe : N - 2 ^ k ≤ X - 2 ^ k := Nat.sub_le_sub_right hNX _
    exact mem_filter.mpr ⟨mem_Icc.mpr ⟨(mem_Icc.mp hPart).1, hSubLe⟩, hOddPart⟩
  · intro N hN M hM hEq
    have hPowN : 2 ^ k ≤ N := (mem_filter.mp hN).2.2.1
    have hPowM : 2 ^ k ≤ M := (mem_filter.mp hM).2.2.1
    omega
  · intro m hm
    have hmI : m ∈ Icc 1 (X - 2 ^ k) := (mem_filter.mp hm).1
    have hmOdd : Odd m := (mem_filter.mp hm).2
    have hmBounds := mem_Icc.mp hmI
    have hPowX : 2 ^ k ≤ X := by omega
    have hSumLe : m + 2 ^ k ≤ X := by
      calc
        m + 2 ^ k ≤ (X - 2 ^ k) + 2 ^ k :=
          Nat.add_le_add_right hmBounds.2 _
        _ = X := Nat.sub_add_cancel hPowX
    have hNBounds : m + 2 ^ k ∈ Icc 1 X :=
      mem_Icc.mpr ⟨hmBounds.1.trans (Nat.le_add_right m _), hSumLe⟩
    have hPartX : (m + 2 ^ k) - 2 ^ k ∈ Icc 1 X := by
      simpa using (mem_Icc.mpr
        (show 1 ≤ m ∧ m ≤ X from ⟨hmBounds.1, hmBounds.2.trans (Nat.sub_le X _)⟩))
    have hOddSum : Odd (m + 2 ^ k) := by
      obtain ⟨a, ha⟩ := hmOdd
      obtain ⟨b, hb⟩ := heven
      refine ⟨a + b, ?_⟩
      omega
    refine ⟨m + 2 ^ k, ?_, ?_⟩
    · exact mem_filter.mpr ⟨hNBounds, hOddSum, by omega, hPartX⟩
    · omega
  · intro N hN
    rfl

/-- Every ordered odd-total pair is recovered from exactly one even
power-of-two source and its odd partner, including the upper endpoint. -/
theorem cumulativeOdd_eq_power_sum (X : ℕ) :
    cumulativeOdd X =
      2 * Real.log 2 *
        ∑ k ∈ Icc 1 (Nat.log 2 X), oddPartner (X - 2 ^ k) := by
  unfold cumulativeOdd
  have hrow (N : ℕ) (hN : N ∈ Icc 1 X) :
      (if Odd N then truncatedPrimeCoefficient X N else 0) =
      2 * Real.log 2 *
        ∑ k ∈ Icc 1 (Nat.log 2 X),
          if Odd N ∧ 2 ^ k ≤ N ∧ N - 2 ^ k ∈ Icc 1 X then
            Λ (N - 2 ^ k) else 0 := by
    by_cases hOdd : Odd N
    · rw [if_pos hOdd, odd_primeCoefficient_power_sum hOdd X]
      congr 1
      apply Finset.sum_congr rfl
      intro k hk
      simp [hOdd]
    · simp [hOdd]
  calc
    _ = ∑ N ∈ Icc 1 X,
        2 * Real.log 2 *
          ∑ k ∈ Icc 1 (Nat.log 2 X),
            if Odd N ∧ 2 ^ k ≤ N ∧ N - 2 ^ k ∈ Icc 1 X then
              Λ (N - 2 ^ k) else 0 := by
          apply Finset.sum_congr rfl
          intro N hN
          exact hrow N hN
    _ = 2 * Real.log 2 *
          ∑ k ∈ Icc 1 (Nat.log 2 X),
            ∑ N ∈ Icc 1 X,
              if Odd N ∧ 2 ^ k ≤ N ∧ N - 2 ^ k ∈ Icc 1 X then
                Λ (N - 2 ^ k) else 0 := by
          rw [← Finset.mul_sum, Finset.sum_comm]
    _ = _ := by
          congr 1
          apply Finset.sum_congr rfl
          intro k hk
          exact shifted_odd_row X k (mem_Icc.mp hk).1

/-- The bounded source cutoff agrees with the actual complete ordered
Goldbach coefficient at every total included in the cumulative horizon. -/
theorem cumulativeOdd_eq_complete (X : ℕ) :
    cumulativeOdd X =
      ∑ N ∈ Icc 1 X,
        if Odd N then BuildingBlocks.GoldbachCumulativeFinite.goldbachAt N else 0 := by
  unfold cumulativeOdd
  apply Finset.sum_congr rfl
  intro N hN
  rw [truncated_eq_complete X N (mem_Icc.mp hN).2]

def integerPrimeError (N : ℕ) : ℝ :=
  BuildingBlocks.CoarsePrimitive.psi N - (N : ℝ)

/-- The baseline keeps the full ordinary-counting triangle and removes
exactly the even prime powers from the odd partner. -/
def oddBaseline (X : ℕ) : ℝ :=
  2 * Real.log 2 *
    ∑ k ∈ Icc 1 (Nat.log 2 X),
      (((X - 2 ^ k : ℕ) : ℝ) -
        (Nat.log 2 (X - 2 ^ k) : ℝ) * Real.log 2)

def oddResidual (X : ℕ) : ℝ := cumulativeOdd X - oddBaseline X

/-- The actual centered odd Goldbach cumulative count is a lacunary
sum of the complete Chebyshev error, with every endpoint retained. -/
theorem oddResidual_eq_error_convolution (X : ℕ) :
    oddResidual X =
      2 * Real.log 2 *
        ∑ k ∈ Icc 1 (Nat.log 2 X), integerPrimeError (X - 2 ^ k) := by
  rw [oddResidual, oddBaseline, cumulativeOdd_eq_power_sum]
  calc
    2 * Real.log 2 * (∑ k ∈ Icc 1 (Nat.log 2 X), oddPartner (X - 2 ^ k)) -
        2 * Real.log 2 *
          (∑ k ∈ Icc 1 (Nat.log 2 X),
            (((X - 2 ^ k : ℕ) : ℝ) -
              (Nat.log 2 (X - 2 ^ k) : ℝ) * Real.log 2)) =
      2 * Real.log 2 *
        ∑ k ∈ Icc 1 (Nat.log 2 X),
          (oddPartner (X - 2 ^ k) -
            (((X - 2 ^ k : ℕ) : ℝ) -
              (Nat.log 2 (X - 2 ^ k) : ℝ) * Real.log 2)) := by
                simp only [Finset.sum_sub_distrib]
                ring
    _ = _ := by
          congr 1
          apply Finset.sum_congr rfl
          intro k hk
          rw [oddPartner_eq_psi_sub_pow2]
          unfold integerPrimeError
          ring

#print axioms cumulativeOdd_eq_power_sum
#print axioms cumulativeOdd_eq_complete
#print axioms oddPartner_eq_psi_sub_pow2
#print axioms oddResidual_eq_error_convolution

end
end BuildingBlocks.GoldbachOddCumulativeFinite
