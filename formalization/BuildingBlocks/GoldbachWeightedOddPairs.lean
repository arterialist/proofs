import BuildingBlocks.GoldbachOddPairs

open scoped BigOperators

namespace BuildingBlocks.GoldbachWeightedOddPairs

open GoldbachOddCentering

noncomputable def A (N : ℕ) (w : ℕ → ℝ) : ℝ :=
  ∑ a ∈ Finset.Icc 1 (N - 1), o a * o (N - a) * w a

noncomputable def Rodd (N : ℕ) (w : ℕ → ℝ) : ℝ :=
  ∑ a ∈ Finset.Icc 1 (N - 1),
    (if Odd a ∧ Odd (N - a) then
      ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt (N - a)
    else 0) * w a

noncomputable def oddWeight (N : ℕ) (w : ℕ → ℝ) : ℝ :=
  ∑ a ∈ Finset.Icc 1 (N - 1),
    (if Odd a then ArithmeticFunction.vonMangoldt a else 0) * w a

noncomputable def oddCount (N : ℕ) (w : ℕ → ℝ) : ℝ :=
  ∑ a ∈ Finset.Icc 1 (N - 1), (if Odd a then 1 else 0) * w a

theorem weighted_reflection (N : ℕ) (w : ℕ → ℝ)
    (hw : ∀ a ∈ Finset.Icc 1 (N - 1), w (N - a) = w a) :
    (∑ a ∈ Finset.Icc 1 (N - 1),
      (if Odd (N - a) then ArithmeticFunction.vonMangoldt (N - a) else 0) * w a)
      = oddWeight N w := by
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
    rw [hw a ha]

/-- Literal ordered positive-pair expansion for any symmetric finite weight. -/
theorem A_even {N : ℕ} (hN : Even N) (w : ℕ → ℝ)
    (hw : ∀ a ∈ Finset.Icc 1 (N - 1), w (N - a) = w a) :
    A N w = Rodd N w - 4 * oddWeight N w + 4 * oddCount N w := by
  have he : A N w = ∑ a ∈ Finset.Icc 1 (N - 1), (
      (if Odd a ∧ Odd (N - a) then
        ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt (N - a) else 0) * w a -
      2 * ((if Odd a then ArithmeticFunction.vonMangoldt a else 0) * w a) -
      2 * ((if Odd (N - a) then ArithmeticFunction.vonMangoldt (N - a) else 0) * w a) +
      4 * ((if Odd a then 1 else 0) * w a)) := by
    unfold A
    apply Finset.sum_congr rfl
    intro a ha
    have haN : a ≤ N := by have h := (Finset.mem_Icc.mp ha).2; omega
    rw [GoldbachOddPairs.even_pair_expansion hN haN]
    ring
  rw [he]
  simp only [Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum]
  rw [weighted_reflection N w hw]
  change Rodd N w - 2 * oddWeight N w - 2 * oddWeight N w +
    4 * oddCount N w = _
  ring

#print axioms A_even

end BuildingBlocks.GoldbachWeightedOddPairs
