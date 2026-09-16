import BuildingBlocks.FixedProfileGreenAdmissionFinite

namespace BuildingBlocks.FinitePNTErrorPropagation

open Finset
open scoped BigOperators

/-- Finite boundary-plus-interior expression produced by partial summation. -/
def partialSummationError (E w : ℕ → ℝ) (lo hi : ℕ) : ℝ :=
  -w lo * E (lo - 1) + w hi * E hi +
    ∑ n ∈ Finset.Ico lo hi, E n * (w n - w (n + 1))

/-- A common pointwise counting-function envelope propagates through finite
partial summation without any sign assumption. -/
theorem abs_partialSummationError_le
    (E w B : ℕ → ℝ) (lo hi : ℕ)
    (hE : ∀ n, |E n| ≤ B n) :
    |partialSummationError E w lo hi| ≤
      |w lo| * B (lo - 1) + |w hi| * B hi +
        ∑ n ∈ Finset.Ico lo hi, B n * |w n - w (n + 1)| := by
  unfold partialSummationError
  calc
    |-w lo * E (lo - 1) + w hi * E hi +
        ∑ n ∈ Ico lo hi, E n * (w n - w (n + 1))| ≤
      |-w lo * E (lo - 1)| + |w hi * E hi| +
        |∑ n ∈ Ico lo hi, E n * (w n - w (n + 1))| := by
      rw [add_assoc]
      calc
        |(-w lo * E (lo - 1)) + (w hi * E hi +
            ∑ n ∈ Ico lo hi, E n * (w n - w (n + 1)))| ≤
            |-w lo * E (lo - 1)| +
              |w hi * E hi + ∑ n ∈ Ico lo hi, E n * (w n - w (n + 1))| := abs_add_le _ _
        _ ≤ |-w lo * E (lo - 1)| +
              (|w hi * E hi| + |∑ n ∈ Ico lo hi, E n * (w n - w (n + 1))|) :=
            add_le_add_left (abs_add_le _ _) _
        _ = _ := by ring
    _ ≤ |w lo| * B (lo - 1) + |w hi| * B hi +
        ∑ n ∈ Ico lo hi, B n * |w n - w (n + 1)| := by
      have hlo : |-w lo * E (lo - 1)| ≤ |w lo| * B (lo - 1) := by
        rw [abs_mul, abs_neg]
        exact mul_le_mul_of_nonneg_left (hE _) (abs_nonneg _)
      have hhi : |w hi * E hi| ≤ |w hi| * B hi := by
        rw [abs_mul]
        exact mul_le_mul_of_nonneg_left (hE _) (abs_nonneg _)
      have hsum : |∑ n ∈ Ico lo hi, E n * (w n - w (n + 1))| ≤
          ∑ n ∈ Ico lo hi, B n * |w n - w (n + 1)| := by
        calc
          |∑ n ∈ Ico lo hi, E n * (w n - w (n + 1))| ≤
              ∑ n ∈ Ico lo hi, |E n * (w n - w (n + 1))| :=
            Finset.abs_sum_le_sum_abs _ _
          _ ≤ _ := by
            apply Finset.sum_le_sum
            intro n hn
            rw [abs_mul]
            exact mul_le_mul_of_nonneg_right (hE _) (abs_nonneg _)
      linarith

/-- Finite linearity needed to subtract the logarithmic-integral main counting
function from the actual prime counting function before applying the bound. -/
theorem partialSummationError_sub
    (A M w : ℕ → ℝ) (lo hi : ℕ) :
    partialSummationError (fun n => A n - M n) w lo hi =
      partialSummationError A w lo hi - partialSummationError M w lo hi := by
  unfold partialSummationError
  have hsum : (∑ n ∈ Ico lo hi, (A n - M n) * (w n - w (n + 1))) =
      (∑ n ∈ Ico lo hi, A n * (w n - w (n + 1))) -
      (∑ n ∈ Ico lo hi, M n * (w n - w (n + 1))) := by
    rw [← Finset.sum_sub_distrib]
    apply Finset.sum_congr rfl
    intro n hn
    ring
  rw [hsum]
  ring

#print axioms abs_partialSummationError_le
#print axioms partialSummationError_sub

end BuildingBlocks.FinitePNTErrorPropagation
