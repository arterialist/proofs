import BuildingBlocks.ChronologicalPowerRatio

open scoped BigOperators

namespace BuildingBlocks.SamePrimeAggregationKernel

/-- The actual reciprocal-root sum over positive integers through `k`. -/
noncomputable abbrev A := ChronologicalPowerRatio.A

/-- The actual root sum over positive integers through `k`. -/
noncomputable abbrev B := ChronologicalPowerRatio.B

/-- The right-endpoint coefficient of the same-prime aggregation cell. -/
noncomputable def F (k : ℕ) : ℝ := 3 * B k - ((k : ℝ) + 1) * A k

/-- Reuse the established telescoping reciprocal-root estimate. -/
theorem A_le (k : ℕ) (hk : 1 ≤ k) : A k ≤ 2 * Real.sqrt k - 1 :=
  ChronologicalPowerRatio.A_bound k hk

/-- The exact next-integer coefficient increment. -/
theorem F_succ_sub (k : ℕ) :
    F (k + 1) - F k = (2 * (k : ℝ) + 1) / Real.sqrt (k + 1) - A k := by
  dsimp only [F, A, B]
  rw [ChronologicalPowerRatio.A_succ, ChronologicalPowerRatio.B_succ]
  have hs : 0 < Real.sqrt ((k : ℝ) + 1) := by positivity
  have hs2 := Real.sq_sqrt (show (0 : ℝ) ≤ k + 1 by positivity)
  push_cast
  field_simp
  nlinarith

/-- The quotient lower bound follows from the nonnegative square of adjacent roots. -/
theorem quotient_ge (k : ℕ) :
    2 * Real.sqrt k ≤ (2 * (k : ℝ) + 1) / Real.sqrt (k + 1) := by
  have ht : 0 < Real.sqrt ((k : ℝ) + 1) := by positivity
  have ht2 := Real.sq_sqrt (show (0 : ℝ) ≤ k + 1 by positivity)
  have hs2 := Real.sq_sqrt (show (0 : ℝ) ≤ k by positivity)
  have hsq := sq_nonneg (Real.sqrt ((k : ℝ) + 1) - Real.sqrt k)
  apply (le_div_iff₀ ht).mpr
  nlinarith

/-- Every coefficient increment after the first state is at least one. -/
theorem F_succ_sub_ge_one {k : ℕ} (hk : 1 ≤ k) :
    1 ≤ F (k + 1) - F k := by
  rw [F_succ_sub]
  have ha := A_le k hk
  have hq := quotient_ge k
  linarith

@[simp] theorem F_one : F 1 = 1 := by
  norm_num [F, A, B, ChronologicalPowerRatio.A, ChronologicalPowerRatio.B]

/-- The actual all-integer coefficient is bounded below by its cutoff. -/
theorem F_ge {k : ℕ} (hk : 1 ≤ k) : (k : ℝ) ≤ F k := by
  induction k, hk using Nat.le_induction with
  | base => simp
  | succ k hk ih =>
    have hs := F_succ_sub_ge_one hk
    push_cast
    linarith

theorem F_pos {k : ℕ} (hk : 1 ≤ k) : 0 < F k := by
  have hp : (0 : ℝ) < k := by exact_mod_cast hk
  exact hp.trans_le (F_ge hk)

/-- The right endpoint gives a lower bound throughout the whole real cell. -/
theorem cell_kernel_ge_F {k : ℕ} {x : ℝ} (hx : x ≤ (k : ℝ) + 1) :
    F k ≤ 3 * B k - x * A k := by
  have ha := ChronologicalPowerRatio.A_nonneg k
  have hm := mul_le_mul_of_nonneg_right hx ha
  unfold F
  linarith

/-- A finite coefficient inequality on the closed cell, including both endpoints. -/
theorem cell_kernel_ge {k : ℕ} (hk : 1 ≤ k) {x : ℝ}
    (hx : x ∈ Set.Icc (k : ℝ) ((k : ℝ) + 1)) :
    (k : ℝ) ≤ 3 * B k - x * A k :=
  (F_ge hk).trans (cell_kernel_ge_F hx.2)

theorem cell_kernel_pos {k : ℕ} (hk : 1 ≤ k) {x : ℝ}
    (hx : x ∈ Set.Icc (k : ℝ) ((k : ℝ) + 1)) :
    0 < 3 * B k - x * A k :=
  (F_pos hk).trans_le (cell_kernel_ge_F hx.2)

#print axioms A_le
#print axioms F_ge
#print axioms cell_kernel_pos

end BuildingBlocks.SamePrimeAggregationKernel
