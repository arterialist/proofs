import BuildingBlocks.SamePrimeAggregationMonotone
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Analysis.SpecialFunctions.Log.Basic

open Finset
open scoped BigOperators

namespace BuildingBlocks.SamePrimeHistoryResidual

open SamePrimeAggregationMonotone

/-- Before the first integer activation, the literal log-age aggregation is zero. -/
theorem h_eq_zero_of_nonpos {v : ℝ} (hv : v ≤ 0) : h v = 0 := by
  unfold h
  rw [H_eq_normalized_tent (Real.exp_pos v),
    ChronologicalDivisibility.S_eq_zero_of_le_one (Real.exp_le_one_iff.mpr hv)]
  simp

theorem h_nonneg (v : ℝ) : 0 ≤ h v := by
  by_cases hv : v ≤ 0
  · rw [h_eq_zero_of_nonpos hv]
  · exact H_nonneg (Real.one_le_exp_iff.mpr (le_of_not_ge hv))

/-- Global monotonicity includes the entire zero history at negative ages. -/
theorem h_monotone : Monotone h := by
  intro u v huv
  by_cases hu : u ≤ 0
  · rw [h_eq_zero_of_nonpos hu]
    exact h_nonneg v
  · exact h_monotoneOn (le_of_not_ge hu) ((le_of_not_ge hu).trans huv) huv

/-- The exact ordered same-prime multiplicity and critical square-root weight. -/
noncomputable def weight (p m : ℕ) : ℝ :=
  ((m - 1 : ℕ) : ℝ) * (Real.log p) ^ 2 / Real.sqrt ((p ^ m : ℕ) : ℝ)

noncomputable def term (p m : ℕ) (v : ℝ) : ℝ :=
  weight p m * h (v - (m : ℝ) * Real.log p)

theorem weight_nonneg (p m : ℕ) : 0 ≤ weight p m := by
  unfold weight
  positivity

theorem term_nonneg (p m : ℕ) (v : ℝ) : 0 ≤ term p m v :=
  mul_nonneg (weight_nonneg p m) (h_nonneg _)

theorem term_monotone (p m : ℕ) : Monotone (term p m) := by
  intro u v huv
  exact mul_le_mul_of_nonneg_left (h_monotone (sub_le_sub_right huv _)) (weight_nonneg p m)

/-- Inactivity includes exact birth, where the newly admitted term is zero. -/
theorem term_eq_zero_of_age_le {p m : ℕ} {v : ℝ}
    (hv : v ≤ (m : ℝ) * Real.log p) : term p m v = 0 := by
  unfold term
  rw [h_eq_zero_of_nonpos (sub_nonpos.mpr hv), mul_zero]

@[simp] theorem term_at_birth (p m : ℕ) :
    term p m ((m : ℝ) * Real.log p) = 0 := term_eq_zero_of_age_le le_rfl

theorem term_eq_zero_of_exp_le_power {p m : ℕ} (hp : p.Prime) {v : ℝ}
    (hv : Real.exp v ≤ ((p ^ m : ℕ) : ℝ)) : term p m v = 0 := by
  have hpos : (0 : ℝ) < ((p ^ m : ℕ) : ℝ) := by
    exact_mod_cast (pow_pos hp.pos m)
  have hlog := (Real.le_log_iff_exp_le hpos).mpr hv
  rw [Nat.cast_pow, Real.log_pow] at hlog
  exact term_eq_zero_of_age_le hlog

private theorem base_le_power {p m : ℕ} (hp : p.Prime) (hm : 2 ≤ m) : p ≤ p ^ m := by
  simpa using pow_le_pow_right₀ hp.one_lt.le (show 1 ≤ m by omega)

/-- Every actual admitted power is inside both finite indexing bounds. -/
theorem active_history_covered {p m : ℕ} (hp : p.Prime) (hm : 2 ≤ m) {v : ℝ}
    (hv : ((p ^ m : ℕ) : ℝ) ≤ Real.exp v) :
    p ∈ Finset.Icc 2 ⌊Real.exp v⌋₊ ∧ m ∈ Finset.Icc 2 ⌊Real.exp v⌋₊ := by
  have hpow : p ^ m ≤ ⌊Real.exp v⌋₊ := (Nat.le_floor_iff (Real.exp_pos v).le).mpr hv
  exact ⟨Finset.mem_Icc.mpr ⟨hp.two_le, (base_le_power hp hm).trans hpow⟩,
    Finset.mem_Icc.mpr ⟨hm, (m.lt_pow_self hp.one_lt).le.trans hpow⟩⟩

theorem term_eq_zero_of_not_active {p m : ℕ} (hp : p.Prime) {v : ℝ}
    (hv : ¬p ^ m ≤ ⌊Real.exp v⌋₊) : term p m v = 0 := by
  have hlt : Real.exp v < ((p ^ m : ℕ) : ℝ) :=
    (Nat.floor_lt (Real.exp_pos v).le).mp (Nat.lt_of_not_ge hv)
  exact term_eq_zero_of_exp_le_power hp hlt.le

/-- A rectangular index bound, later specialized to the actual clock cutoff. -/
noncomputable def partialSum (N : ℕ) (v : ℝ) : ℝ :=
  ∑ p ∈ Finset.Icc 2 N, if p.Prime then
    ∑ m ∈ Finset.Icc 2 N, term p m v else 0

/-- The literal finite all-prime, all-proper-power residual at the current age. -/
noncomputable def s (v : ℝ) : ℝ := partialSum ⌊Real.exp v⌋₊ v

/-- The same finite expression with the actual prime-power activation displayed. -/
theorem s_eq_active_sum (v : ℝ) :
    s v = ∑ p ∈ Finset.Icc 2 ⌊Real.exp v⌋₊, if p.Prime then
      ∑ m ∈ Finset.Icc 2 ⌊Real.exp v⌋₊,
        if p ^ m ≤ ⌊Real.exp v⌋₊ then term p m v else 0 else 0 := by
  unfold s partialSum
  apply Finset.sum_congr rfl
  intro p _
  by_cases hp : p.Prime
  · simp only [if_pos hp]
    apply Finset.sum_congr rfl
    intro m _
    by_cases hm : p ^ m ≤ ⌊Real.exp v⌋₊
    · simp [hm]
    · simp [hm, term_eq_zero_of_not_active hp hm]
  · simp [hp]

theorem partial_nonneg (N : ℕ) (v : ℝ) : 0 ≤ partialSum N v := by
  unfold partialSum
  apply Finset.sum_nonneg
  intro p _
  split_ifs
  · exact Finset.sum_nonneg (fun m _ => term_nonneg p m v)
  · exact le_rfl

theorem partial_monotone_age (N : ℕ) : Monotone (partialSum N) := by
  intro u v huv
  unfold partialSum
  apply Finset.sum_le_sum
  intro p _
  split_ifs
  · exact Finset.sum_le_sum (fun m _ => term_monotone p m huv)
  · exact le_rfl

theorem partial_monotone_cutoff (v : ℝ) : Monotone (fun N => partialSum N v) := by
  intro M N hMN
  have hsub : Finset.Icc 2 M ⊆ Finset.Icc 2 N := by
    intro n hn
    exact Finset.mem_Icc.mpr ⟨(Finset.mem_Icc.mp hn).1, (Finset.mem_Icc.mp hn).2.trans hMN⟩
  unfold partialSum
  calc
    (∑ p ∈ Finset.Icc 2 M, if p.Prime then ∑ m ∈ Finset.Icc 2 M, term p m v else 0) ≤
        ∑ p ∈ Finset.Icc 2 M, if p.Prime then ∑ m ∈ Finset.Icc 2 N, term p m v else 0 := by
      apply Finset.sum_le_sum
      intro p _
      split_ifs
      · exact Finset.sum_le_sum_of_subset_of_nonneg hsub (fun m _ _ => term_nonneg p m v)
      · exact le_rfl
    _ ≤ ∑ p ∈ Finset.Icc 2 N, if p.Prime then ∑ m ∈ Finset.Icc 2 N, term p m v else 0 := by
      apply Finset.sum_le_sum_of_subset_of_nonneg hsub
      intro p _ _
      split_ifs
      · exact Finset.sum_nonneg (fun m _ => term_nonneg p m v)
      · exact le_rfl

theorem s_nonneg (v : ℝ) : 0 ≤ s v := partial_nonneg _ _

/-- Actual all-prime monotonicity, with both integer indexing bounds allowed to grow. -/
theorem s_monotone : Monotone s := by
  intro u v huv
  have hN : ⌊Real.exp u⌋₊ ≤ ⌊Real.exp v⌋₊ := Nat.floor_mono (Real.exp_le_exp.mpr huv)
  exact (partial_monotone_age ⌊Real.exp u⌋₊ huv).trans (partial_monotone_cutoff v hN)

/-- Every nonnegative delay decreases the literal same-prime history residual. -/
theorem s_delay_le (v : ℝ) {r : ℝ} (hr : 0 ≤ r) : s (v - r) ≤ s v :=
  s_monotone (sub_le_self v hr)

#print axioms active_history_covered
#print axioms s_eq_active_sum
#print axioms s_monotone
#print axioms s_delay_le

end BuildingBlocks.SamePrimeHistoryResidual
