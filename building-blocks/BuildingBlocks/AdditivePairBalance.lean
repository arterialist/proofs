import Mathlib.Tactic

namespace BuildingBlocks.AdditivePairBalance

noncomputable def physical (x y : ℝ) : ℝ := 1 / max x y
noncomputable def additive (x y : ℝ) : ℝ := 1 / (x + y)
noncomputable def balance (x y : ℝ) : ℝ := |x - y| / (max x y * (x + y))

theorem kernel_identity {x y : ℝ} (hx : 0 < x) (hy : 0 < y) :
    physical x y = 2 * additive x y - balance x y := by
  unfold physical additive balance
  have hs : x + y ≠ 0 := by positivity
  by_cases h : x ≤ y
  · rw [max_eq_right h, abs_of_nonpos (sub_nonpos.mpr h)]
    field_simp
    ring
  · have h' : y ≤ x := (le_of_not_ge h)
    rw [max_eq_left h', abs_of_nonneg (sub_nonneg.mpr h')]
    field_simp
    ring

theorem balance_nonnegative {x y : ℝ} (hx : 0 < x) (hy : 0 < y) :
    0 ≤ balance x y := by
  unfold balance
  exact div_nonneg (abs_nonneg _) (mul_nonneg (le_max_left x y |>.trans' hx.le) (by positivity))

noncomputable def twoPoint (K : ℝ → ℝ → ℝ) (a b : ℝ) : ℝ :=
  a ^ 2 * K 1 1 + a * b * K 1 2 + b * a * K 2 1 + b ^ 2 * K 2 2

theorem positive_balance_value : twoPoint balance 1 1 = 1 / 3 := by
  norm_num [twoPoint, balance]

theorem negative_balance_value : twoPoint balance 1 (-1) = -1 / 3 := by
  norm_num [twoPoint, balance]

theorem balance_not_positive_quadratic :
    ¬ (∀ a b : ℝ, 0 ≤ twoPoint balance a b) := by
  intro h
  have hn := h 1 (-1)
  rw [negative_balance_value] at hn
  norm_num at hn

theorem balance_not_negative_quadratic :
    ¬ (∀ a b : ℝ, twoPoint balance a b ≤ 0) := by
  intro h
  have hp := h 1 1
  rw [positive_balance_value] at hp
  norm_num at hp

noncomputable def finiteGram {ι : Type*} (s : Finset ι) (x c : ι → ℝ)
    (K : ℝ → ℝ → ℝ) : ℝ :=
  ∑ i ∈ s, ∑ j ∈ s, c i * c j * K (x i) (x j)

theorem complete_finite_gram_identity {ι : Type*} (s : Finset ι)
    (x c : ι → ℝ) (hx : ∀ i ∈ s, 0 < x i) :
    finiteGram s x c physical =
      2 * finiteGram s x c additive - finiteGram s x c balance := by
  unfold finiteGram
  rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro j hj
  rw [kernel_identity (hx i hi) (hx j hj)]
  ring

#print axioms complete_finite_gram_identity
#print axioms kernel_identity
#print axioms balance_nonnegative
#print axioms balance_not_positive_quadratic
#print axioms balance_not_negative_quadratic

end BuildingBlocks.AdditivePairBalance
