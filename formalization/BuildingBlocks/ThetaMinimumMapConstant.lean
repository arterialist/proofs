import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Tactic

namespace BuildingBlocks.ThetaMinimumMapConstant

/-- The exact constant in the minimum source-normalized interval map. -/
noncomputable def minimumMapK0 : ℝ :=
  2 * Real.pi * (20 - 11 * Real.sqrt 2 - Real.log 64) /
    (3 * Real.log 2)

lemma log_sixty_four : Real.log (64 : ℝ) = 6 * Real.log 2 := by
  rw [show (64 : ℝ) = 2 ^ 6 by norm_num, Real.log_pow]
  norm_num

lemma sqrt_two_lower : (707 / 500 : ℝ) < Real.sqrt 2 := by
  have hs := Real.sq_sqrt (show (0 : ℝ) ≤ 2 by norm_num)
  have hn := Real.sqrt_nonneg 2
  nlinarith

lemma sqrt_two_upper : Real.sqrt 2 < (283 / 200 : ℝ) := by
  have hs := Real.sq_sqrt (show (0 : ℝ) ≤ 2 by norm_num)
  have hn := Real.sqrt_nonneg 2
  nlinarith

lemma minimumMapNumerator_pos :
    0 < 20 - 11 * Real.sqrt 2 - Real.log 64 := by
  rw [log_sixty_four]
  have hs := sqrt_two_upper
  have hl := Real.log_two_lt_d9
  norm_num at hl ⊢
  nlinarith

lemma minimumMapNumerator_lt :
    20 - 11 * Real.sqrt 2 - Real.log 64 < (36 / 125 : ℝ) := by
  rw [log_sixty_four]
  have hs := sqrt_two_lower
  have hl := Real.log_two_gt_d9
  norm_num at hl ⊢
  nlinarith

lemma minimumMap_denominator_pos : 0 < 3 * Real.log 2 := by
  positivity

/-- The exact interval constant is strictly between zero and one. -/
theorem minimumMapK0_pos_lt_one :
    0 < minimumMapK0 ∧ minimumMapK0 < 1 := by
  let A : ℝ := 20 - 11 * Real.sqrt 2 - Real.log 64
  have hA : 0 < A := by
    simpa [A] using minimumMapNumerator_pos
  have hAu : A < (36 / 125 : ℝ) := by
    simpa [A] using minimumMapNumerator_lt
  have hpi : Real.pi < (315 / 100 : ℝ) := by
    have h := Real.pi_lt_d2
    norm_num at h ⊢
    exact h
  have hmul :
      Real.pi * A < (315 / 100 : ℝ) * (36 / 125 : ℝ) := by
    exact mul_lt_mul hpi hAu.le hA (by norm_num)
  have hlog : (6931471803 / 10000000000 : ℝ) < Real.log 2 := by
    have h := Real.log_two_gt_d9
    norm_num at h ⊢
    exact h
  have hnumden : 2 * Real.pi * A < 3 * Real.log 2 := by
    calc
      2 * Real.pi * A = 2 * (Real.pi * A) := by ring
      _ < 2 * ((315 / 100 : ℝ) * (36 / 125 : ℝ)) := by nlinarith
      _ < 3 * (6931471803 / 10000000000 : ℝ) := by norm_num
      _ < 3 * Real.log 2 := by nlinarith
  have hden : 0 < 3 * Real.log 2 := minimumMap_denominator_pos
  constructor
  · rw [minimumMapK0]
    change 0 < 2 * Real.pi * A / (3 * Real.log 2)
    exact div_pos (mul_pos (mul_pos (by norm_num) Real.pi_pos) hA) hden
  · rw [minimumMapK0]
    change 2 * Real.pi * A / (3 * Real.log 2) < 1
    exact (div_lt_one hden).2 hnumden

/-- Both paid allowances are positive; this is the only algebraic consequence
needed before comparing with the theta residual energy. -/
theorem minimumMap_allowances_pos :
    0 < (1 + minimumMapK0) / 4 ∧
    0 < (1 - minimumMapK0) / 4 := by
  rcases minimumMapK0_pos_lt_one with ⟨hk0, hk1⟩
  constructor
  · exact div_pos (by linarith) (by norm_num)
  · exact div_pos (by linarith) (by norm_num)

end BuildingBlocks.ThetaMinimumMapConstant

#print axioms BuildingBlocks.ThetaMinimumMapConstant.minimumMapK0_pos_lt_one
#print axioms BuildingBlocks.ThetaMinimumMapConstant.minimumMap_allowances_pos
