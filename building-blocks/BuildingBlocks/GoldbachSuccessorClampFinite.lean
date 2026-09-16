import BuildingBlocks.FactorialHOneFinite

/-!
# Finite endpoint control for raw-successor Goldbach pairs

For a pair admitted at the original cutoff, clamping every label below
`j + 1` can remove it only when one label is at most `j` and the other
lies strictly beyond `s - j - 1`. This file formalizes that exact
endpoint statement and its weighted ordered-pair inequality. The weight
can be the actual von Mangoldt function, retaining every prime power.
The continuous transport tails and the PNT estimate are separate.
-/

namespace BuildingBlocks.GoldbachSuccessorClampFinite

open scoped BigOperators ArithmeticFunction

private theorem clamp_removed_endpoint {m n s j : ℕ}
    (hs : 2 * (j + 1) ≤ s) (had : m + n ≤ s)
    (hremoved : s < max m (j + 1) + max n (j + 1)) :
    (m ≤ j ∧ s - j - 1 < n) ∨ (n ≤ j ∧ s - j - 1 < m) := by
  omega

private theorem clamped_admission_implies_original {m n s j : ℕ}
    (h : max m (j + 1) + max n (j + 1) ≤ s) : m + n ≤ s := by
  omega

/-- The weighted loss of an ordered pair is bounded by the two possible
early-label/terminal-strip orientations. -/
theorem pair_loss_le (w : ℕ → ℝ) (hw : ∀ k, 0 ≤ w k)
    {m n s j : ℕ} (hs : 2 * (j + 1) ≤ s) :
    (if m + n ≤ s then w m * w n else 0) -
        (if max m (j + 1) + max n (j + 1) ≤ s then w m * w n else 0) ≤
      (if m ≤ j ∧ s - j - 1 < n then w m * w n else 0) +
        (if n ≤ j ∧ s - j - 1 < m then w m * w n else 0) := by
  have hprod : 0 ≤ w m * w n := mul_nonneg (hw m) (hw n)
  by_cases had : m + n ≤ s
  · by_cases hclamp : max m (j + 1) + max n (j + 1) ≤ s
    · simp [had, hclamp]
      split_ifs <;> positivity
    · have hstrip := clamp_removed_endpoint hs had (by omega :
        s < max m (j + 1) + max n (j + 1))
      rcases hstrip with hleft | hright
      · simp [had, hclamp, hleft]
        split_ifs <;> nlinarith
      · simp [had, hclamp, hright]
        split_ifs <;> nlinarith
  · have hclamp : ¬ max m (j + 1) + max n (j + 1) ≤ s := by
      intro hc
      exact had (clamped_admission_implies_original hc)
    simp [had, hclamp]
    split_ifs <;> positivity

/-- The finite ordered-pair clamping loss is paid by two complete terminal
strip sums. No prime-power coefficient or pair orientation is omitted. -/
theorem finite_clamping_loss_le (w : ℕ → ℝ) (hw : ∀ k, 0 ≤ w k)
    (s j : ℕ) (hs : 2 * (j + 1) ≤ s) :
    (∑ m ∈ Finset.Icc 2 s, ∑ n ∈ Finset.Icc 2 s,
      ((if m + n ≤ s then w m * w n else 0) -
        (if max m (j + 1) + max n (j + 1) ≤ s then w m * w n else 0))) ≤
      ∑ m ∈ Finset.Icc 2 s, ∑ n ∈ Finset.Icc 2 s,
        ((if m ≤ j ∧ s - j - 1 < n then w m * w n else 0) +
          (if n ≤ j ∧ s - j - 1 < m then w m * w n else 0)) := by
  apply Finset.sum_le_sum
  intro m hm
  apply Finset.sum_le_sum
  intro n hn
  exact pair_loss_le w hw hs

/-- The two terminal-strip orientations factor into the same prefix
and tail masses, so the finite clamping loss has an exact product
majorant. -/
theorem finite_clamping_loss_le_product (w : ℕ → ℝ) (hw : ∀ k, 0 ≤ w k)
    (s j : ℕ) (hs : 2 * (j + 1) ≤ s) :
    (∑ m ∈ Finset.Icc 2 s, ∑ n ∈ Finset.Icc 2 s,
      ((if m + n ≤ s then w m * w n else 0) -
        (if max m (j + 1) + max n (j + 1) ≤ s then w m * w n else 0))) ≤
      2 * (∑ m ∈ Finset.Icc 2 s, if m ≤ j then w m else 0) *
        (∑ n ∈ Finset.Icc 2 s, if s - j - 1 < n then w n else 0) := by
  have hfactor (left : ℕ → Prop) [DecidablePred left]
      (right : ℕ → Prop) [DecidablePred right] :
      (∑ m ∈ Finset.Icc 2 s, ∑ n ∈ Finset.Icc 2 s,
        if left m ∧ right n then w m * w n else 0) =
        (∑ m ∈ Finset.Icc 2 s, if left m then w m else 0) *
          (∑ n ∈ Finset.Icc 2 s, if right n then w n else 0) := by
    rw [Finset.sum_mul_sum]
    apply Finset.sum_congr rfl
    intro m hm
    apply Finset.sum_congr rfl
    intro n hn
    by_cases hl : left m <;> by_cases hr : right n <;> simp [hl, hr]
  calc
    (∑ m ∈ Finset.Icc 2 s, ∑ n ∈ Finset.Icc 2 s,
      ((if m + n ≤ s then w m * w n else 0) -
        (if max m (j + 1) + max n (j + 1) ≤ s then w m * w n else 0))) ≤
      ∑ m ∈ Finset.Icc 2 s, ∑ n ∈ Finset.Icc 2 s,
        ((if m ≤ j ∧ s - j - 1 < n then w m * w n else 0) +
          (if n ≤ j ∧ s - j - 1 < m then w m * w n else 0)) :=
            finite_clamping_loss_le w hw s j hs
    _ = 2 * (∑ m ∈ Finset.Icc 2 s, if m ≤ j then w m else 0) *
          (∑ n ∈ Finset.Icc 2 s, if s - j - 1 < n then w n else 0) := by
        simp only [Finset.sum_add_distrib]
        rw [hfactor (· ≤ j) (s - j - 1 < ·)]
        have hswap :
            (∑ m ∈ Finset.Icc 2 s, ∑ n ∈ Finset.Icc 2 s,
              if n ≤ j ∧ s - j - 1 < m then w m * w n else 0) =
              (∑ m ∈ Finset.Icc 2 s, if m ≤ j then w m else 0) *
                (∑ n ∈ Finset.Icc 2 s, if s - j - 1 < n then w n else 0) := by
          have hcomm :
              (∑ m ∈ Finset.Icc 2 s, ∑ n ∈ Finset.Icc 2 s,
                if n ≤ j ∧ s - j - 1 < m then w m * w n else 0) =
                ∑ m ∈ Finset.Icc 2 s, ∑ n ∈ Finset.Icc 2 s,
                  if s - j - 1 < m ∧ n ≤ j then w m * w n else 0 := by
            apply Finset.sum_congr rfl
            intro m hm
            apply Finset.sum_congr rfl
            intro n hn
            by_cases h1 : n ≤ j <;> by_cases h2 : s - j - 1 < m <;> simp [h1, h2]
          rw [hcomm, hfactor (s - j - 1 < ·) (· ≤ j)]
          ring
        rw [hswap]
        ring

/-- The preceding finite inequality for the actual complete von Mangoldt
weights. -/
theorem actual_mangoldt_clamping_loss_le (s j : ℕ)
    (hs : 2 * (j + 1) ≤ s) :
    (∑ m ∈ Finset.Icc 2 s, ∑ n ∈ Finset.Icc 2 s,
      ((if m + n ≤ s then ArithmeticFunction.vonMangoldt m *
          ArithmeticFunction.vonMangoldt n else 0) -
        (if max m (j + 1) + max n (j + 1) ≤ s then
          ArithmeticFunction.vonMangoldt m * ArithmeticFunction.vonMangoldt n else 0))) ≤
      2 * (∑ m ∈ Finset.Icc 2 s,
        if m ≤ j then ArithmeticFunction.vonMangoldt m else 0) *
        (∑ n ∈ Finset.Icc 2 s,
          if s - j - 1 < n then ArithmeticFunction.vonMangoldt n else 0) := by
  exact finite_clamping_loss_le_product ArithmeticFunction.vonMangoldt
    (fun _ => ArithmeticFunction.vonMangoldt_nonneg) s j hs

end BuildingBlocks.GoldbachSuccessorClampFinite
