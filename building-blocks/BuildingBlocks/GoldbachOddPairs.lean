import BuildingBlocks.GoldbachOddCentering

open scoped BigOperators

namespace BuildingBlocks.GoldbachOddPairs

open GoldbachOddCentering

noncomputable def A (N : ℕ) : ℝ := ∑ a ∈ Finset.Icc 1 (N - 1), o a * o (N - a)

noncomputable def Rodd (N : ℕ) : ℝ := ∑ a ∈ Finset.Icc 1 (N - 1),
  if Odd a ∧ Odd (N - a) then ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt (N - a) else 0

noncomputable def oddWeight (N : ℕ) : ℝ := ∑ a ∈ Finset.Icc 1 (N - 1),
  if Odd a then ArithmeticFunction.vonMangoldt a else 0

noncomputable def oddCount (N : ℕ) : ℝ := ∑ a ∈ Finset.Icc 1 (N - 1), if Odd a then 1 else 0

theorem A_odd {N : ℕ} (hN : Odd N) : A N = 0 := by
  unfold A
  apply Finset.sum_eq_zero
  intro a ha
  have haN : a ≤ N := by have h := (Finset.mem_Icc.mp ha).2; omega
  have hn : ¬(Odd a ∧ Odd (N - a)) := by
    rintro ⟨h1, h2⟩
    have he := h1.add_odd h2
    rw [Nat.add_sub_of_le haN] at he
    exact (Nat.not_even_iff_odd.mpr hN) he
  unfold o
  split_ifs with h1 h2
  · exact False.elim (hn ⟨h1, h2⟩)
  · ring
  · ring
  · ring

theorem A_two : A 2 = 4 := by norm_num [A, o]

theorem oddWeight_reflection (N : ℕ) :
    (∑ a ∈ Finset.Icc 1 (N - 1), if Odd (N - a) then ArithmeticFunction.vonMangoldt (N - a) else 0) = oddWeight N := by
  unfold oddWeight
  apply Finset.sum_bij (fun a _ => N - a)
  · intro a ha
    simp only [Finset.mem_Icc] at ha ⊢
    omega
  · intro a ha b hb hab
    simp only [Finset.mem_Icc] at ha hb
    omega
  · intro b hb
    refine ⟨N - b, ?_, ?_⟩
    · simp only [Finset.mem_Icc] at hb ⊢
      omega
    · have h := (Finset.mem_Icc.mp hb).2
      omega
  · intro a ha
    rfl

theorem even_pair_expansion {N a : ℕ} (hN : Even N) (ha : a ≤ N) :
    o a * o (N - a) =
      (if Odd a ∧ Odd (N - a) then ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt (N - a) else 0) -
      2 * (if Odd a then ArithmeticFunction.vonMangoldt a else 0) -
      2 * (if Odd (N - a) then ArithmeticFunction.vonMangoldt (N - a) else 0) +
      4 * (if Odd a then 1 else 0) := by
  have hp : Odd (N - a) ↔ Odd a := by simpa [hN] using Nat.odd_sub' ha
  by_cases ho : Odd a
  · have hob := hp.mpr ho
    simp [o, ho, hob]
    ring
  · have hob : ¬Odd (N - a) := fun h => ho (hp.mp h)
    simp [o, ho, hob]

/-- Exact ordered-pair expansion; the count remains an explicit finite odd count. -/
theorem A_even {N : ℕ} (hN : Even N) :
    A N = Rodd N - 4 * oddWeight N + 4 * oddCount N := by
  have he : A N = ∑ a ∈ Finset.Icc 1 (N - 1), (
      (if Odd a ∧ Odd (N - a) then ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt (N - a) else 0) -
      2 * (if Odd a then ArithmeticFunction.vonMangoldt a else 0) -
      2 * (if Odd (N - a) then ArithmeticFunction.vonMangoldt (N - a) else 0) +
      4 * (if Odd a then 1 else 0)) := by
    unfold A
    apply Finset.sum_congr rfl
    intro a ha
    have haN : a ≤ N := by have h := (Finset.mem_Icc.mp ha).2; omega
    exact even_pair_expansion hN haN
  rw [he]
  simp only [Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum]
  rw [oddWeight_reflection]
  change Rodd N - 2 * oddWeight N - 2 * oddWeight N + 4 * oddCount N = _
  ring

theorem A_two_mul (m : ℕ) :
    A (2 * m) = Rodd (2 * m) - 4 * oddWeight (2 * m) + 4 * oddCount (2 * m) :=
  A_even (even_two_mul m)

theorem oddCount_two_mul (m : ℕ) : oddCount (2 * m) = (m : ℝ) := by
  induction m with
  | zero => norm_num [oddCount]
  | succ m ih =>
    by_cases hm : m = 0
    · subst m
      norm_num [oddCount]
      rw [Finset.filter_singleton, if_pos (odd_one : Odd (1 : ℕ)), Finset.card_singleton]
    · have h0 : 2 * m - 1 + 1 = 2 * m := by omega
      have h1 : 2 * (m + 1) - 1 = (2 * m - 1) + 1 + 1 := by omega
      unfold oddCount at ih ⊢
      rw [h1, Finset.sum_Icc_succ_top (by omega), Finset.sum_Icc_succ_top (by omega), h0]
      rw [if_neg (Nat.not_odd_iff_even.mpr (even_two_mul m)), if_pos (odd_two_mul_add_one m), ih]
      push_cast
      ring

theorem A_two_mul_evaluated (m : ℕ) :
    A (2 * m) = Rodd (2 * m) - 4 * oddWeight (2 * m) + 4 * (m : ℝ) := by
  rw [A_two_mul, oddCount_two_mul]

#print axioms A_odd
#print axioms A_two
#print axioms A_even
#print axioms oddCount_two_mul
#print axioms A_two_mul_evaluated

end BuildingBlocks.GoldbachOddPairs
