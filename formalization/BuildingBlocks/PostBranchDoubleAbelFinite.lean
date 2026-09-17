import Mathlib.Tactic

/-!
# Finite double Abel algebra for a moving divisor wedge

This module is coefficient-agnostic.  It retains both terminal prefixes in
the one-dimensional identity and removes them in the double identity only
under explicit zero-total hypotheses.
-/

namespace BuildingBlocks.PostBranchDoubleAbelFinite

open scoped BigOperators

noncomputable section

/-- Prefix through indices `1,...,N`. -/
def partialSum (a : ℕ → ℝ) (N : ℕ) : ℝ :=
  ∑ k ∈ Finset.range N, a (k + 1)

lemma partialSum_succ (a : ℕ → ℝ) (N : ℕ) :
    partialSum a (N + 1) = partialSum a N + a (N + 1) := by
  simp [partialSum, Finset.sum_range_succ]

/-- Exact finite Abel summation with the terminal partialSum retained. -/
theorem finite_abel_with_terminal (a f : ℕ → ℝ) (n : ℕ) :
    (∑ k ∈ Finset.range (n + 1), a (k + 1) * f (k + 1)) =
      partialSum a (n + 1) * f (n + 1) +
        ∑ k ∈ Finset.range n,
          partialSum a (k + 1) * (f (k + 1) - f (k + 2)) := by
  induction n with
  | zero => simp [partialSum]
  | succ n ih =>
      rw [Finset.sum_range_succ, ih, Finset.sum_range_succ]
      rw [partialSum_succ, partialSum_succ]
      rw [partialSum_succ a n]
      ring

/-- With zero total coefficient mass, only finite partialSum differences remain. -/
theorem finite_abel_of_total_zero
    (a f : ℕ → ℝ) (n : ℕ) (hzero : partialSum a (n + 1) = 0) :
    (∑ k ∈ Finset.range (n + 1), a (k + 1) * f (k + 1)) =
      ∑ k ∈ Finset.range n,
        partialSum a (k + 1) * (f (k + 1) - f (k + 2)) := by
  rw [finite_abel_with_terminal, hzero]
  ring

/-- Exact two-dimensional Abel summation.  Both coefficient packets must
have zero total mass; the mixed second difference and every finite endpoint
are retained. -/
theorem finite_double_abel_of_totals_zero
    (a b : ℕ → ℝ) (K : ℕ → ℕ → ℝ) (n m : ℕ)
    (ha : partialSum a (n + 1) = 0) (hb : partialSum b (m + 1) = 0) :
    (∑ i ∈ Finset.range (n + 1), ∑ j ∈ Finset.range (m + 1),
      a (i + 1) * b (j + 1) * K (i + 1) (j + 1)) =
      ∑ i ∈ Finset.range n, ∑ j ∈ Finset.range m,
        partialSum a (i + 1) * partialSum b (j + 1) *
          (K (i + 1) (j + 1) - K (i + 2) (j + 1) -
            K (i + 1) (j + 2) + K (i + 2) (j + 2)) := by
  let F : ℕ → ℝ := fun i =>
    ∑ j ∈ Finset.range (m + 1), b (j + 1) * K i (j + 1)
  have hi := finite_abel_of_total_zero a F n ha
  have hlhs :
      (∑ i ∈ Finset.range (n + 1), ∑ j ∈ Finset.range (m + 1),
        a (i + 1) * b (j + 1) * K (i + 1) (j + 1)) =
        ∑ i ∈ Finset.range (n + 1), a (i + 1) * F (i + 1) := by
    apply Finset.sum_congr rfl
    intro i hi_mem
    simp only [F]
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro j hj_mem
    ring
  rw [hlhs, hi]
  apply Finset.sum_congr rfl
  intro i hi_mem
  have hj := finite_abel_of_total_zero b
    (fun j => K (i + 1) j - K (i + 2) j) m hb
  have hdiff : F (i + 1) - F (i + 2) =
      ∑ j ∈ Finset.range (m + 1), b (j + 1) *
        (K (i + 1) (j + 1) - K (i + 2) (j + 1)) := by
    simp only [F]
    rw [← Finset.sum_sub_distrib]
    apply Finset.sum_congr rfl
    intro j hj_mem
    ring
  rw [hdiff, hj, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j hj_mem
  ring

/-- Grouping the old divisor `a` with the new divisor `pa` preserves their
opposite Möbius orientations as a literal kernel difference. -/
theorem prime_orientation_pairing
    (D : Finset ℕ) (c : ℕ → ℝ) (H : ℕ → ℕ → ℝ) (p e : ℕ) :
    (∑ a ∈ D, c a * H e a) - (∑ a ∈ D, c a * H e (p * a)) =
      ∑ a ∈ D, c a * (H e a - H e (p * a)) := by
  rw [← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro a ha
  ring

/-- Algebraic simplification of the post-branch residual after subtracting
the extrapolated first branch. -/
theorem post_branch_residual_algebra
    (qn qm q r : ℝ) :
    qn * (1 - qm + (1 - q) * r) - qm * (1 - qn) =
      qn - qm + qn * (1 - q) * r := by
  ring

/-- The mixed endpoint terms and endpoint quadratic form one exact combined
square difference, without a sign assertion. -/
theorem mixed_plus_endpoint_quadratic
    (delta endpointOld endpointNew : ℝ) :
    2 * delta * endpointNew + endpointNew ^ 2 - endpointOld ^ 2 =
      (delta + endpointNew) ^ 2 - delta ^ 2 - endpointOld ^ 2 := by
  ring

end
end BuildingBlocks.PostBranchDoubleAbelFinite

#print axioms BuildingBlocks.PostBranchDoubleAbelFinite.finite_abel_with_terminal
#print axioms BuildingBlocks.PostBranchDoubleAbelFinite.finite_abel_of_total_zero
#print axioms BuildingBlocks.PostBranchDoubleAbelFinite.finite_double_abel_of_totals_zero
#print axioms BuildingBlocks.PostBranchDoubleAbelFinite.prime_orientation_pairing
#print axioms BuildingBlocks.PostBranchDoubleAbelFinite.post_branch_residual_algebra
#print axioms BuildingBlocks.PostBranchDoubleAbelFinite.mixed_plus_endpoint_quadratic
