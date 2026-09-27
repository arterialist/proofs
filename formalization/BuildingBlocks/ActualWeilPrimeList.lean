import Mathlib

/-!
Finite arithmetic audit for the complete radius-one prime-power row.
No analytic identification of the Weil quadratic form is asserted here.
-/

namespace ActualWeilPrimeList

open ArithmeticFunction

theorem exp_two_between : (7 : ℝ) < Real.exp 2 ∧ Real.exp 2 < 8 := by
  have hlo := Real.exp_one_gt_d9
  have hhi := Real.exp_one_lt_d9
  have he : Real.exp 2 = Real.exp 1 * Real.exp 1 := by
    calc
      Real.exp 2 = Real.exp (1 + 1) := by norm_num
      _ = Real.exp 1 * Real.exp 1 := Real.exp_add 1 1
  rw [he]
  constructor <;> nlinarith

theorem nat_below_exp_two_iff_lt_eight (n : ℕ) :
    (n : ℝ) < Real.exp 2 ↔ n < 8 := by
  obtain ⟨h7, h8⟩ := exp_two_between
  constructor
  · intro hn
    by_contra h
    have hn8 : 8 ≤ n := by omega
    have hn8r : (8 : ℝ) ≤ n := by exact_mod_cast hn8
    linarith
  · intro hn
    have hn7 : n ≤ 7 := by omega
    have hn7r : (n : ℝ) ≤ 7 := by exact_mod_cast hn7
    linarith

theorem mem_radius_one_prime_range (n : ℕ) :
    n ∈ Finset.Ico 2 8 ↔ 2 ≤ n ∧ (n : ℝ) < Real.exp 2 := by
  simp only [Finset.mem_Ico, nat_below_exp_two_iff_lt_eight]

theorem mem_radius_one_log_range (n : ℕ) :
    n ∈ Finset.Ico 2 8 ↔ 2 ≤ n ∧ Real.log (n : ℝ) < 2 := by
  rw [mem_radius_one_prime_range]
  constructor
  · rintro ⟨hn, hlt⟩
    have hnpos : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
    exact ⟨hn, (Real.log_lt_iff_lt_exp hnpos).2 hlt⟩
  · rintro ⟨hn, hlt⟩
    have hnpos : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
    exact ⟨hn, (Real.log_lt_iff_lt_exp hnpos).1 hlt⟩

theorem prime_power_list_below_exp_two :
    (Finset.Ico 2 8).filter (fun n : ℕ => IsPrimePow n) = {2, 3, 4, 5, 7} := by
  have hs : Finset.Ico 2 8 = {2, 3, 4, 5, 6, 7} := by decide
  have h4 : IsPrimePow 4 := by
    rw [isPrimePow_nat_iff_bounded_log_minFac]
    have hlog4 : Nat.log 2 4 = 2 :=
      (Nat.log_eq_iff (Or.inl (by decide))).2 (by norm_num)
    exact ⟨2, by rw [hlog4], by decide, by decide⟩
  have h6 : ¬IsPrimePow 6 := by
    rw [isPrimePow_nat_iff_bounded_log_minFac]
    rintro ⟨k, hk, hkp, heq⟩
    have hlog6 : Nat.log 2 6 = 2 :=
      (Nat.log_eq_iff (Or.inl (by decide))).2 (by norm_num)
    have hk' : k ≤ 2 := by simpa [hlog6] using hk
    have heq' : 6 = 2 ^ k := by simpa [show Nat.minFac 6 = 2 by decide] using heq
    interval_cases k <;> norm_num at *
  have h2 : IsPrimePow 2 := Nat.Prime.isPrimePow (by norm_num)
  have h3 : IsPrimePow 3 := Nat.Prime.isPrimePow (by norm_num)
  have h5 : IsPrimePow 5 := Nat.Prime.isPrimePow (by norm_num)
  have h7 : IsPrimePow 7 := Nat.Prime.isPrimePow (by norm_num)
  rw [hs]
  ext n
  simp only [Finset.mem_filter, Finset.mem_insert, Finset.mem_singleton]
  constructor
  · rintro ⟨h, hn⟩
    rcases h with h | h | h | h | h | h <;> subst n <;> simp_all
  · intro h
    rcases h with h | h | h | h | h <;> subst n <;> simp_all

theorem vonMangoldt_four :
    vonMangoldt 4 = Real.log 2 := by
  rw [show 4 = 2 ^ 2 by norm_num, vonMangoldt_apply_pow (by decide)]
  exact vonMangoldt_apply_prime (by norm_num)

theorem vonMangoldt_six :
    vonMangoldt 6 = 0 := by
  rw [vonMangoldt_apply]
  have h6 : ¬IsPrimePow 6 := by
    rw [isPrimePow_nat_iff_bounded_log_minFac]
    rintro ⟨k, hk, hkp, heq⟩
    have hlog6 : Nat.log 2 6 = 2 :=
      (Nat.log_eq_iff (Or.inl (by decide))).2 (by norm_num)
    have hk' : k ≤ 2 := by simpa [hlog6] using hk
    have heq' : 6 = 2 ^ k := by simpa [show Nat.minFac 6 = 2 by decide] using heq
    interval_cases k <;> norm_num at *
  simp [h6]

theorem exact_five_power_row :
    ∑ n ∈ Finset.Ico 2 8, vonMangoldt n =
      Real.log 2 + Real.log 3 + Real.log 2 + Real.log 5 + Real.log 7 := by
  have hs : Finset.Ico 2 8 = {2, 3, 4, 5, 6, 7} := by decide
  rw [hs]
  simp [vonMangoldt_four, vonMangoldt_six, vonMangoldt_apply_prime,
    show Nat.Prime 2 by norm_num, show Nat.Prime 3 by norm_num,
    show Nat.Prime 5 by norm_num, show Nat.Prime 7 by norm_num]
  ring

theorem exact_five_power_weighted_row (w : ℕ → ℝ) :
    ∑ n ∈ Finset.Ico 2 8, vonMangoldt n * w n =
      Real.log 2 * w 2 + Real.log 3 * w 3 + Real.log 2 * w 4 +
        Real.log 5 * w 5 + Real.log 7 * w 7 := by
  have hs : Finset.Ico 2 8 = {2, 3, 4, 5, 6, 7} := by decide
  rw [hs]
  simp [vonMangoldt_four, vonMangoldt_six, vonMangoldt_apply_prime,
    show Nat.Prime 2 by norm_num, show Nat.Prime 3 by norm_num,
    show Nat.Prime 5 by norm_num, show Nat.Prime 7 by norm_num]
  ring

#print axioms nat_below_exp_two_iff_lt_eight
#print axioms prime_power_list_below_exp_two
#print axioms exact_five_power_weighted_row

end ActualWeilPrimeList
