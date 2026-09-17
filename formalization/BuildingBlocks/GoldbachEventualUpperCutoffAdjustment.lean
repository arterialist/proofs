import BuildingBlocks.GoldbachCumulativeFinite
import Mathlib.Tactic

namespace BuildingBlocks.GoldbachEventualUpperCutoffAdjustment

open BuildingBlocks.GoldbachCumulativeFinite

noncomputable section

private theorem goldbachAt_nonneg (n : ℕ) : 0 ≤ goldbachAt n := by
  unfold goldbachAt
  exact Finset.sum_nonneg (fun _ _ => mul_nonneg
    ArithmeticFunction.vonMangoldt_nonneg ArithmeticFunction.vonMangoldt_nonneg)

private theorem cumulative_nonneg (n : ℕ) : 0 ≤ cumulativeGoldbach n := by
  unfold cumulativeGoldbach
  exact Finset.sum_nonneg (fun k _ => goldbachAt_nonneg k)

private theorem cumulative_mono : Monotone cumulativeGoldbach := by
  intro a b hab
  unfold cumulativeGoldbach
  apply Finset.sum_le_sum_of_subset_of_nonneg
  · exact Finset.range_mono (by omega)
  · intro k _ _
    exact goldbachAt_nonneg k

/-- An eventual upper estimate for the actual cumulative ordered von Mangoldt
convolution extends to all positive cutoffs. The initial interval contributes
the exact finite value at the floor of its endpoint. -/
theorem eventual_upper_to_all_cutoffs {ε C X₀ : ℝ}
    (hε : 0 < ε) (hε' : ε < 1 / 2) (hC : 0 ≤ C) (hX₀ : 1 ≤ X₀)
    (hS : ∀ X : ℝ, X₀ ≤ X →
      cumulativeGoldbach ⌊X⌋₊ ≤ X ^ 2 / 2 + C * X ^ (3 / 2 + ε : ℝ)) :
    ∃ C' : ℝ, 0 ≤ C' ∧ ∀ X : ℝ, 0 < X →
      cumulativeGoldbach ⌊X⌋₊ ≤ X ^ 2 / 2 + C' * X ^ (3 / 2 + ε : ℝ) := by
  let p : ℝ := 3 / 2 + ε
  let B : ℝ := cumulativeGoldbach ⌊X₀⌋₊
  let C' : ℝ := C + B
  have hB : 0 ≤ B := cumulative_nonneg _
  have hC' : 0 ≤ C' := by dsimp [C']; linarith
  have hC'ge : C ≤ C' := by dsimp [C']; linarith
  refine ⟨C', hC', ?_⟩
  intro X hX
  by_cases hlarge : X₀ ≤ X
  · have hp : 0 ≤ X ^ p := Real.rpow_nonneg (by linarith [hX₀, hlarge]) _
    have hterm : C * X ^ p ≤ C' * X ^ p :=
      mul_le_mul_of_nonneg_right hC'ge hp
    linarith [hS X hlarge]
  · have hsmall : X < X₀ := lt_of_not_ge hlarge
    by_cases hunit : X < 1
    · have hfloor : ⌊X⌋₊ = 0 := Nat.floor_eq_zero.mpr hunit
      have hzero : cumulativeGoldbach ⌊X⌋₊ = 0 := by
        rw [hfloor]
        simp [cumulativeGoldbach]
      rw [hzero]
      positivity
    · have hunit' : 1 ≤ X := le_of_not_gt hunit
      have hfloor : ⌊X⌋₊ ≤ ⌊X₀⌋₊ := Nat.floor_mono hsmall.le
      have hcount : cumulativeGoldbach ⌊X⌋₊ ≤ B := cumulative_mono hfloor
      have hpone : 1 ≤ X ^ p :=
        Real.one_le_rpow hunit' (by dsimp [p]; linarith)
      have hBsmall : B ≤ C' := by dsimp [C']; linarith
      have hmul : C' ≤ C' * X ^ p := by
        simpa only [mul_one] using mul_le_mul_of_nonneg_left hpone hC'
      have hsq : 0 ≤ X ^ 2 / 2 := by positivity
      linarith

#print axioms eventual_upper_to_all_cutoffs

end
end BuildingBlocks.GoldbachEventualUpperCutoffAdjustment
