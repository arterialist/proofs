import Mathlib.Tactic
import Mathlib.Algebra.BigOperators.Module

/-!
# Finite Abel/Stieltjes algebra for the friable endpoint

The analytic estimates for the prefix are hypotheses.  This module proves
the exact finite partial-summation identity and propagation of two-region
pointwise bounds into a finite weighted square bound.
-/

namespace BuildingBlocks.FriableEndpointStieltjesFinite

open scoped BigOperators

noncomputable section

/-- Exact finite discrete Stieltjes identity on the literal interval
`j ≤ n ≤ N`.  `∑ k < j, a k` is the left-limit prefix at `j`. -/
theorem finite_stieltjes_tail
    (a : ℕ → ℝ) (r : ℝ) {j N : ℕ} (hjN : j ≤ N) :
    (∑ n ∈ Finset.Ico j (N + 1), r ^ n * a n) =
      r ^ N * (∑ k ∈ Finset.range (N + 1), a k) -
        r ^ j * (∑ k ∈ Finset.range j, a k) +
        (1 - r) *
          ∑ n ∈ Finset.Ico j N,
            r ^ n * (∑ k ∈ Finset.range (n + 1), a k) := by
  have hj : j < N + 1 := by omega
  have h := Finset.sum_Ico_by_parts
    (f := fun n : ℕ => r ^ n) (g := a) hj
  simp only [smul_eq_mul, Nat.add_sub_cancel] at h
  rw [h]
  have hsum :
      (∑ n ∈ Finset.Ico j N,
        (r ^ (n + 1) - r ^ n) *
          (∑ k ∈ Finset.range (n + 1), a k)) =
        (r - 1) * ∑ n ∈ Finset.Ico j N,
          r ^ n * (∑ k ∈ Finset.range (n + 1), a k) := by
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro n hn
    rw [pow_succ]
    ring
  rw [hsum]
  ring

/-- When the complete prefix is zero, only the left endpoint and integrated
prefix increments remain. -/
theorem finite_stieltjes_tail_of_total_zero
    (a : ℕ → ℝ) (r : ℝ) {j N : ℕ} (hjN : j ≤ N)
    (htotal : (∑ k ∈ Finset.range (N + 1), a k) = 0) :
    (∑ n ∈ Finset.Ico j (N + 1), r ^ n * a n) =
      -r ^ j * (∑ k ∈ Finset.range j, a k) +
        (1 - r) *
          ∑ n ∈ Finset.Ico j N,
            r ^ n * (∑ k ∈ Finset.range (n + 1), a k) := by
  rw [finite_stieltjes_tail a r hjN, htotal]
  ring

/-- Two-region propagation of pointwise bounds into a finite weighted
square estimate. -/
theorem weighted_square_split_bound
    (f w B : ℕ → ℝ) (B0 : ℝ) {J N : ℕ} (hJN : J ≤ N)
    (hw : ∀ n < N, 0 ≤ w n)
    (hB0 : 0 ≤ B0)
    (hearly : ∀ n < J, |f n| ≤ B0)
    (hlate : ∀ n ∈ Finset.Ico J N, |f n| ≤ B n) :
    (∑ n ∈ Finset.range N, w n * (f n) ^ 2) ≤
      B0 ^ 2 * (∑ n ∈ Finset.range J, w n) +
        ∑ n ∈ Finset.Ico J N, w n * (B n) ^ 2 := by
  rw [← Finset.sum_range_add_sum_Ico
    (fun n => w n * (f n) ^ 2) hJN]
  apply add_le_add
  · calc
      (∑ n ∈ Finset.range J, w n * (f n) ^ 2) ≤
          ∑ n ∈ Finset.range J, w n * B0 ^ 2 := by
        apply Finset.sum_le_sum
        intro n hn
        have hnJ : n < J := Finset.mem_range.mp hn
        have habs := hearly n hnJ
        have hsq : (f n) ^ 2 ≤ B0 ^ 2 := by
          rw [← sq_abs]
          exact (sq_le_sq₀ (abs_nonneg _) hB0).2 habs
        exact mul_le_mul_of_nonneg_left hsq (hw n (lt_of_lt_of_le hnJ hJN))
      _ = B0 ^ 2 * (∑ n ∈ Finset.range J, w n) := by
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro n hn
        ring
  · apply Finset.sum_le_sum
    intro n hn
    have hnN : n < N := (Finset.mem_Ico.mp hn).2
    have habs := hlate n hn
    have hB : 0 ≤ B n := le_trans (abs_nonneg _) habs
    have hsq : (f n) ^ 2 ≤ (B n) ^ 2 := by
      rw [← sq_abs]
      exact (sq_le_sq₀ (abs_nonneg _) hB).2 habs
    exact mul_le_mul_of_nonneg_left hsq (hw n hnN)

/-- Multiplying a finite square bound by a nonnegative external energy
normalization preserves it with the exact factor. -/
theorem scale_weighted_square_bound
    (scale lhs rhs : ℝ) (hscale : 0 ≤ scale) (h : lhs ≤ rhs) :
    scale * lhs ≤ scale * rhs := mul_le_mul_of_nonneg_left h hscale

end
end BuildingBlocks.FriableEndpointStieltjesFinite

#print axioms BuildingBlocks.FriableEndpointStieltjesFinite.finite_stieltjes_tail
#print axioms BuildingBlocks.FriableEndpointStieltjesFinite.finite_stieltjes_tail_of_total_zero
#print axioms BuildingBlocks.FriableEndpointStieltjesFinite.weighted_square_split_bound
#print axioms BuildingBlocks.FriableEndpointStieltjesFinite.scale_weighted_square_bound
