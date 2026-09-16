import BuildingBlocks.FactorialPairedRenewal

open Finset MeasureTheory
namespace BuildingBlocks.FactorialBinaryCarry

noncomputable def pairedPort (N k : ℕ) (t : ℝ) : ℝ :=
  response ((2 * N) / k) t - response (N / k) (2 * t)

/-- Complete ordered offdiagonal products of a zero-sum finite real family. -/
theorem ordered_cross_of_sum_zero {ι : Type*} [DecidableEq ι] (s : Finset ι) (a : ι → ℝ)
    (ha : ∑ k ∈ s, a k = 0) :
    (∑ k ∈ s, ∑ l ∈ s, if k = l then 0 else a k * a l) = -(∑ k ∈ s, (a k)^2) := by
  have he : ∀ k ∈ s, (∑ l ∈ s, if k = l then 0 else a k * a l) = a k * (∑ l ∈ s, a l) - (a k)^2 := by
    intro k hk
    calc
      _ = ∑ l ∈ s, (a k * a l - if k = l then (a k)^2 else 0) := by
        apply Finset.sum_congr rfl
        intro l hl
        by_cases h : k = l
        · subst l; simp [pow_two]
        · simp [h]
      _ = _ := by rw [Finset.sum_sub_distrib, ← Finset.mul_sum]; simp [hk]
  rw [Finset.sum_congr rfl he]
  simp [ha, Finset.sum_neg_distrib]

/-- Actual complete paired quotient covariance, including all terminal copies and orders. -/
theorem paired_ordered_cross (N : ℕ) (t : ℝ) :
    (∑ k ∈ Icc 1 (2 * N), ∑ l ∈ Icc 1 (2 * N),
      if k = l then 0 else pairedPort N k t * pairedPort N l t) =
      -(∑ k ∈ Icc 1 (2 * N), (pairedPort N k t)^2) := by
  apply ordered_cross_of_sum_zero
  exact paired_quotient_response_sum_zero N t

/-- Entire positive-clock covariance of the complete summed rows with original density. -/
theorem paired_ordered_cross_clock (N : ℕ) :
    (∫ t in Set.Ioi 0, (∑ k ∈ Icc 1 (2 * N), ∑ l ∈ Icc 1 (2 * N),
      if k = l then 0 else pairedPort N k t * pairedPort N l t) * FactorialBinaryEnergy.weight t) =
      -(∫ t in Set.Ioi 0, (∑ k ∈ Icc 1 (2 * N), (pairedPort N k t)^2) * FactorialBinaryEnergy.weight t) := by
  simp_rw [paired_ordered_cross, neg_mul]
  exact integral_neg _

#print axioms ordered_cross_of_sum_zero
#print axioms paired_ordered_cross
#print axioms paired_ordered_cross_clock
end BuildingBlocks.FactorialBinaryCarry
