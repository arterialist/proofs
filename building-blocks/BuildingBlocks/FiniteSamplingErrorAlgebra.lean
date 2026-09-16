import BuildingBlocks.FixedProfileGreenAdmissionFinite

namespace BuildingBlocks.FiniteSamplingErrorAlgebra

open Finset
open scoped BigOperators

/-- Finite rectangle-rule consumer: once every cell error is paid by a
nonnegative variation budget, the full sampled error is paid by their sum. -/
theorem abs_sum_sample_error_le
    (sample cellIntegral variation : ℕ → ℝ) (h : ℝ) (N : ℕ)
    (hcell : ∀ j < N,
      |h * sample (j + 1) - cellIntegral j| ≤ h * variation j) :
    |(∑ j ∈ Finset.range N, h * sample (j + 1)) -
      ∑ j ∈ Finset.range N, cellIntegral j| ≤
      h * ∑ j ∈ Finset.range N, variation j := by
  rw [← Finset.sum_sub_distrib]
  calc
    |∑ j ∈ Finset.range N, (h * sample (j + 1) - cellIntegral j)| ≤
        ∑ j ∈ Finset.range N, |h * sample (j + 1) - cellIntegral j| :=
      Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ j ∈ Finset.range N, h * variation j := by
      apply Finset.sum_le_sum
      intro j hj
      exact hcell j (Finset.mem_range.mp hj)
    _ = h * ∑ j ∈ Finset.range N, variation j := by rw [Finset.mul_sum]

/-- The same estimate for a signed finite packet after bounding each packet
cell separately. -/
theorem abs_packet_sampling_error_le
    {ι : Type*} [DecidableEq ι] (s : Finset ι)
    (err budget : ι → ℝ) (h : ℝ)
    (herr : ∀ i ∈ s, |err i| ≤ h * budget i) :
    |∑ i ∈ s, err i| ≤ h * ∑ i ∈ s, budget i := by
  calc
    |∑ i ∈ s, err i| ≤ ∑ i ∈ s, |err i| := Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ i ∈ s, h * budget i := Finset.sum_le_sum herr
    _ = h * ∑ i ∈ s, budget i := by rw [Finset.mul_sum]

#print axioms abs_sum_sample_error_le
#print axioms abs_packet_sampling_error_le

end BuildingBlocks.FiniteSamplingErrorAlgebra
