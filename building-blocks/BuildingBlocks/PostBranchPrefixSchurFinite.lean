import Mathlib.Tactic

/-!
# Finite Schur bound and cutoff-tail obstruction

The first theorem is the finite absolute-row/column Schur estimate for a
quadratic kernel.  The second records why a quadratic form with a nonzero
tail diagonal cannot be bounded by an energy that sees only an initial
cutoff.
-/

namespace BuildingBlocks.PostBranchPrefixSchurFinite

open scoped BigOperators

noncomputable section

variable {ι : Type*} [Fintype ι]

def quadratic (K : ι → ι → ℝ) (x : ι → ℝ) : ℝ :=
  ∑ i, ∑ j, x i * x j * K i j

/-- Finite Schur estimate.  For a symmetric kernel the row and column
hypotheses coincide. -/
theorem quadratic_abs_le_of_row_col
    (K : ι → ι → ℝ) (x : ι → ℝ) (C : ℝ)
    (hrow : ∀ i, ∑ j, |K i j| ≤ C)
    (hcol : ∀ j, ∑ i, |K i j| ≤ C) :
    |quadratic K x| ≤ C * ∑ i, (x i) ^ 2 := by
  have hyoung (a b : ℝ) : 2 * |a * b| ≤ a ^ 2 + b ^ 2 := by
    rw [abs_mul]
    nlinarith [sq_nonneg (|a| - |b|), sq_abs a, sq_abs b]
  have htriangle :
      |quadratic K x| ≤ ∑ i, ∑ j, |K i j| * |x i * x j| := by
    calc
      |quadratic K x| ≤ ∑ i, ∑ j, |x i * x j * K i j| := by
        simp only [quadratic]
        exact (Finset.abs_sum_le_sum_abs _ _).trans
          (Finset.sum_le_sum fun i _ => Finset.abs_sum_le_sum_abs _ _)
      _ = ∑ i, ∑ j, |K i j| * |x i * x j| := by
        apply Finset.sum_congr rfl
        intro i hi
        apply Finset.sum_congr rfl
        intro j hj
        rw [abs_mul]
        ring
  have hdouble :
      2 * |quadratic K x| ≤
        ∑ i, ∑ j, |K i j| * ((x i) ^ 2 + (x j) ^ 2) := by
    calc
      2 * |quadratic K x| ≤
          2 * (∑ i, ∑ j, |K i j| * |x i * x j|) :=
        mul_le_mul_of_nonneg_left htriangle (by norm_num)
      _ = ∑ i, ∑ j, 2 * (|K i j| * |x i * x j|) := by
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro i hi
        rw [Finset.mul_sum]
      _ ≤ ∑ i, ∑ j, |K i j| * ((x i) ^ 2 + (x j) ^ 2) := by
        apply Finset.sum_le_sum
        intro i hi
        apply Finset.sum_le_sum
        intro j hj
        have hm := mul_le_mul_of_nonneg_left
          (hyoung (x i) (x j)) (abs_nonneg (K i j))
        nlinarith
  have hsplit :
      (∑ i, ∑ j, |K i j| * ((x i) ^ 2 + (x j) ^ 2)) =
        (∑ i, (x i) ^ 2 * ∑ j, |K i j|) +
        (∑ j, (x j) ^ 2 * ∑ i, |K i j|) := by
    simp_rw [mul_add, Finset.sum_add_distrib]
    congr 1
    · apply Finset.sum_congr rfl
      intro i hi
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro j hj
      ring
    · rw [Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro j hj
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro i hi
      ring
  have hrows :
      (∑ i, (x i) ^ 2 * ∑ j, |K i j|) ≤ C * ∑ i, (x i) ^ 2 := by
    calc
      _ ≤ ∑ i, (x i) ^ 2 * C := by
        apply Finset.sum_le_sum
        intro i hi
        exact mul_le_mul_of_nonneg_left (hrow i) (sq_nonneg _)
      _ = _ := by
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro i hi
        ring
  have hcols :
      (∑ j, (x j) ^ 2 * ∑ i, |K i j|) ≤ C * ∑ j, (x j) ^ 2 := by
    calc
      _ ≤ ∑ j, (x j) ^ 2 * C := by
        apply Finset.sum_le_sum
        intro j hj
        exact mul_le_mul_of_nonneg_left (hcol j) (sq_nonneg _)
      _ = _ := by
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro j hj
        ring
  rw [hsplit] at hdouble
  nlinarith

variable [DecidableEq ι]

def coordinate (j : ι) (t : ℝ) : ι → ℝ := fun i => if i = j then t else 0

theorem quadratic_coordinate (K : ι → ι → ℝ) (j : ι) (t : ℝ) :
    quadratic K (coordinate j t) = t ^ 2 * K j j := by
  classical
  simp only [quadratic, coordinate]
  rw [Finset.sum_eq_single j]
  · rw [Finset.sum_eq_single j]
    · have hjj : j = j := rfl
      rw [if_pos hjj]
      ring
    · intro b hb hbj
      simp [hbj]
    · simp
  · intro b hb hbj
    simp [hbj]
  · simp

/-- A nonzero diagonal outside the observed cutoff rules out every finite
bound by the cutoff energy. -/
theorem no_cutoff_bound_of_tail_diagonal
    (K : ι → ι → ℝ) (active : Finset ι) (j : ι)
    (hj : j ∉ active) (hdiag : K j j ≠ 0) :
    ¬ ∃ C : ℝ, ∀ x : ι → ℝ,
      |quadratic K x| ≤ C * ∑ i ∈ active, (x i) ^ 2 := by
  rintro ⟨C, hC⟩
  have h := hC (coordinate j 1)
  have henergy : (∑ i ∈ active, (coordinate j 1 i) ^ 2) = 0 := by
    apply Finset.sum_eq_zero
    intro i hi
    simp [coordinate, ne_of_mem_of_not_mem hi hj]
  rw [quadratic_coordinate, henergy, mul_zero] at h
  have hz : |K j j| = 0 := le_antisymm (by simpa using h) (abs_nonneg _)
  exact hdiag (abs_eq_zero.mp hz)

end
end BuildingBlocks.PostBranchPrefixSchurFinite

#print axioms BuildingBlocks.PostBranchPrefixSchurFinite.quadratic_abs_le_of_row_col
#print axioms BuildingBlocks.PostBranchPrefixSchurFinite.quadratic_coordinate
#print axioms BuildingBlocks.PostBranchPrefixSchurFinite.no_cutoff_bound_of_tail_diagonal
