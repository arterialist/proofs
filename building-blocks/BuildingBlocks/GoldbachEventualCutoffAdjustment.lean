import BuildingBlocks.GoldbachCumulativeFinite
import Mathlib.Tactic

namespace BuildingBlocks.GoldbachEventualCutoffAdjustment

open BuildingBlocks.GoldbachCumulativeFinite

noncomputable section

private theorem goldbachAt_nonneg (n : ℕ) : 0 ≤ goldbachAt n := by
  unfold goldbachAt
  exact Finset.sum_nonneg (fun _ _ => mul_nonneg
    ArithmeticFunction.vonMangoldt_nonneg ArithmeticFunction.vonMangoldt_nonneg)

private theorem cumulative_nonneg (n : ℕ) : 0 ≤ cumulativeGoldbach n := by
  unfold cumulativeGoldbach
  exact Finset.sum_nonneg (fun k _ => goldbachAt_nonneg k)

/-- An eventual lower estimate for the actual cumulative ordered von Mangoldt
convolution extends to all positive real cutoffs after enlarging its constant.
The enlargement is explicit and the initial interval uses positivity of the
actual cumulative count. -/
theorem eventual_lower_to_all_cutoffs {ε C X₀ : ℝ}
    (hε : 0 < ε) (hε' : ε < 1 / 2) (hC : 0 ≤ C) (hX₀ : 1 ≤ X₀)
    (hS : ∀ X : ℝ, X₀ ≤ X →
      X ^ 2 / 2 - C * X ^ (3 / 2 + ε : ℝ) ≤ cumulativeGoldbach ⌊X⌋₊) :
    ∃ C' : ℝ, 0 ≤ C' ∧ ∀ X : ℝ, 0 < X →
      X ^ 2 / 2 - C' * X ^ (3 / 2 + ε : ℝ) ≤ cumulativeGoldbach ⌊X⌋₊ := by
  let p : ℝ := 3 / 2 + ε
  let C' : ℝ := C + X₀ ^ 2 / 2 + 1
  have hC' : 0 ≤ C' := by dsimp [C']; positivity
  have hC'ge : C ≤ C' := by dsimp [C']; nlinarith [sq_nonneg X₀]
  refine ⟨C', hC', ?_⟩
  intro X hX
  have hp : 0 ≤ X ^ p := Real.rpow_nonneg hX.le _
  by_cases hlarge : X₀ ≤ X
  · have hterm : C * X ^ p ≤ C' * X ^ p :=
      mul_le_mul_of_nonneg_right hC'ge hp
    linarith [hS X hlarge]
  · have hsmall : X < X₀ := lt_of_not_ge hlarge
    have hnonneg : 0 ≤ cumulativeGoldbach ⌊X⌋₊ := cumulative_nonneg _
    have hCp : X ^ 2 / 2 ≤ C' * X ^ p := by
      by_cases hunit : X ≤ 1
      · have hpow : X ^ 2 ≤ X ^ p := by
          rw [← Real.rpow_natCast X 2]
          exact Real.rpow_le_rpow_of_exponent_ge hX hunit
            (show p ≤ (2 : ℝ) by dsimp [p]; linarith)
        have hcoef : (1 / 2 : ℝ) ≤ C' := by
          dsimp [C']
          nlinarith [sq_nonneg X₀]
        nlinarith [mul_nonneg (sub_nonneg.mpr hcoef) hp]
      · have hunit' : 1 ≤ X := le_of_not_ge hunit
        have hsquare : X ^ 2 ≤ X₀ ^ 2 :=
          (sq_le_sq₀ hX.le (by linarith : 0 ≤ X₀)).2 hsmall.le
        have hcoef : X₀ ^ 2 / 2 ≤ C' := by dsimp [C']; linarith
        have hpone : 1 ≤ X ^ p :=
          Real.one_le_rpow hunit' (by dsimp [p]; linarith)
        have hmul : C' ≤ C' * X ^ p := by
          simpa only [mul_one] using mul_le_mul_of_nonneg_left hpone hC'
        linarith
    linarith

#print axioms eventual_lower_to_all_cutoffs

end
end BuildingBlocks.GoldbachEventualCutoffAdjustment
