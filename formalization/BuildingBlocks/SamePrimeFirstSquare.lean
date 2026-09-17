import BuildingBlocks.SamePrimeHistoryResidual

open Finset
open scoped BigOperators

namespace BuildingBlocks.SamePrimeFirstSquare

open SamePrimeHistoryResidual SamePrimeAggregationMonotone

/-- The literal normalized tent is positive at every positive log-age. -/
theorem h_pos {v : ℝ} (hv : 0 < v) : 0 < h v := by
  unfold h
  rw [H_eq_normalized_tent (Real.exp_pos v)]
  exact div_pos (ChronologicalDivisibility.S_pos (Real.one_lt_exp_iff.mpr hv))
    (mul_pos (Real.exp_pos v) (Real.sqrt_pos.2 (Real.exp_pos v)))

/-- Every proper prime power is at least the first square, four. -/
theorem four_le_prime_power {p m : ℕ} (hp : p.Prime) (hm : 2 ≤ m) : 4 ≤ p ^ m := by
  calc
    4 = (2 : ℕ) ^ 2 := by norm_num
    _ ≤ p ^ 2 := Nat.pow_le_pow_left hp.two_le 2
    _ ≤ p ^ m := pow_le_pow_right₀ hp.one_lt.le hm

/-- Exact inactivity through and including the first square's birth. -/
theorem s_eq_zero_of_le_log_four {v : ℝ} (hv : v ≤ Real.log 4) : s v = 0 := by
  have hev : Real.exp v ≤ (4 : ℝ) := by
    have hh := Real.exp_le_exp.mpr hv
    rw [Real.exp_log (by norm_num : (0 : ℝ) < 4)] at hh
    exact hh
  unfold s partialSum
  apply Finset.sum_eq_zero
  intro p hpMem
  split_ifs with hp
  · apply Finset.sum_eq_zero
    intro m hmMem
    apply term_eq_zero_of_exp_le_power hp
    exact hev.trans (by exact_mod_cast four_le_prime_power hp (Finset.mem_Icc.mp hmMem).1)
  · rfl

/-- The first square keeps its exact multiplicity one and denominator two. -/
theorem weight_two_two : weight 2 2 = (Real.log 2) ^ 2 / 2 := by
  have hs : Real.sqrt (4 : ℝ) = 2 := (Real.sqrt_eq_iff_eq_sq (by norm_num) (by norm_num)).mpr (by norm_num)
  norm_num [weight, hs]

private theorem log_four : Real.log (4 : ℝ) = 2 * Real.log 2 := by
  have hh := Real.log_pow (2 : ℝ) 2
  norm_num at hh
  exact hh

theorem first_square_term_pos {v : ℝ} (hv : Real.log 4 < v) : 0 < term 2 2 v := by
  unfold term
  rw [weight_two_two]
  apply mul_pos
  · exact div_pos (sq_pos_of_pos (Real.log_pos (by norm_num))) (by norm_num)
  · apply h_pos
    rw [log_four] at hv
    norm_num
    linarith

/-- The actual first square is a summand of the complete finite all-prime sum. -/
theorem first_square_term_le {v : ℝ} (hv : Real.log 4 ≤ v) : term 2 2 v ≤ s v := by
  have hev : (((2 : ℕ) ^ 2 : ℕ) : ℝ) ≤ Real.exp v := by
    have hh := Real.exp_le_exp.mpr hv
    rw [Real.exp_log (by norm_num : (0 : ℝ) < 4)] at hh
    norm_num only [Nat.reducePow, Nat.cast_ofNat]
    exact hh
  obtain ⟨hpMem, hmMem⟩ := active_history_covered Nat.prime_two (by norm_num : 2 ≤ (2 : ℕ)) hev
  unfold s partialSum
  calc
    term 2 2 v ≤ ∑ m ∈ Finset.Icc 2 ⌊Real.exp v⌋₊, term 2 m v :=
      Finset.single_le_sum (fun m _ => term_nonneg 2 m v) hmMem
    _ ≤ ∑ p ∈ Finset.Icc 2 ⌊Real.exp v⌋₊,
        if p.Prime then ∑ m ∈ Finset.Icc 2 ⌊Real.exp v⌋₊, term p m v else 0 := by
      have hh := Finset.single_le_sum
        (s := Finset.Icc 2 ⌊Real.exp v⌋₊)
        (f := fun p => if p.Prime then ∑ m ∈ Finset.Icc 2 ⌊Real.exp v⌋₊, term p m v else 0)
        (a := 2) (fun p _ => by
          dsimp only
          split_ifs
          · exact Finset.sum_nonneg (fun m _ => term_nonneg p m v)
          · exact le_rfl) hpMem
      simpa using hh

/-- Strict activation occurs immediately after log four. -/
theorem s_pos_of_log_four_lt {v : ℝ} (hv : Real.log 4 < v) : 0 < s v :=
  (first_square_term_pos hv).trans_le (first_square_term_le hv.le)

theorem s_pos_iff (v : ℝ) : 0 < s v ↔ Real.log 4 < v := by
  constructor
  · intro hs
    by_contra hh
    rw [s_eq_zero_of_le_log_four (le_of_not_gt hh)] at hs
    exact (lt_irrefl 0) hs
  · exact s_pos_of_log_four_lt

/-- Strict growth on each positive cell, including both integer endpoints. -/
theorem cell_strictMonoOn {k : ℕ} (hk : 1 ≤ k) :
    StrictMonoOn (cell k) (Set.Icc (k : ℝ) ((k : ℝ) + 1)) := by
  have hk0 : (0 : ℝ) < k := by exact_mod_cast hk
  apply strictMonoOn_of_deriv_pos (convex_Icc _ _)
  · intro x hx
    exact (cell_hasDerivAt k (hk0.trans_le hx.1)).continuousAt.continuousWithinAt
  · intro x hx
    have hm := interior_subset hx
    have hx0 : 0 < x := hk0.trans_le hm.1
    rw [(cell_hasDerivAt k (hk0.trans_le hm.1)).deriv]
    exact div_pos (SamePrimeAggregationKernel.cell_kernel_pos hk hm) (by positivity)

theorem H_strictMonoOn_cell {k : ℕ} (hk : 1 ≤ k) :
    StrictMonoOn H (Set.Icc (k : ℝ) ((k : ℝ) + 1)) := by
  intro x hx y hy hxy
  rw [H_eq_cell hk hx, H_eq_cell hk hy]
  exact cell_strictMonoOn hk hx hy hxy

#print axioms H_strictMonoOn_cell
#print axioms s_eq_zero_of_le_log_four
#print axioms first_square_term_le
#print axioms s_pos_iff

end BuildingBlocks.SamePrimeFirstSquare
