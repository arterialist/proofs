import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Data.Real.Sqrt

open Finset
open scoped BigOperators

namespace BuildingBlocks.CarryWindow

theorem pairwise_sq_identity (n : ℕ) (f : ℕ → ℝ) :
    (∑ i ∈ range n, ∑ j ∈ range n, (f i - f j)^2) =
      2 * (n : ℝ) * (∑ i ∈ range n, (f i)^2) -
        2 * (∑ i ∈ range n, f i)^2 := by
  simp only [sub_sq, sum_add_distrib, sum_sub_distrib]
  simp only [← mul_sum, ← sum_mul, sum_const, card_range, nsmul_eq_mul]
  ring

theorem sum_range_cast (n : ℕ) :
    (∑ i ∈ range n, (i : ℝ)) = (n : ℝ) * ((n : ℝ) - 1) / 2 := by
  induction n with
  | zero => simp
  | succ n ih => rw [sum_range_succ, ih]; push_cast; ring

theorem sum_range_cast_sq (n : ℕ) :
    (∑ i ∈ range n, (i : ℝ)^2) =
      (n : ℝ) * ((n : ℝ) - 1) * (2 * (n : ℝ) - 1) / 6 := by
  induction n with
  | zero => simp
  | succ n ih => rw [sum_range_succ, ih]; push_cast; ring

theorem pairwise_index_sq (n : ℕ) :
    (∑ i ∈ range n, ∑ j ∈ range n, ((i : ℝ) - j)^2) =
      (n : ℝ)^2 * ((n : ℝ)^2 - 1) / 6 := by
  rw [pairwise_sq_identity, sum_range_cast, sum_range_cast_sq]
  ring

theorem sq_separated_variance_lower_bound (n : ℕ) (hn : 0 < n)
    (f : ℕ → ℝ) (L c : ℝ)
    (hsep : ∀ i ∈ range n, ∀ j ∈ range n,
      L^2 * ((i : ℝ) - j)^2 ≤ (f i - f j)^2) :
    L^2 * (n : ℝ) * ((n : ℝ)^2 - 1) / 12 ≤
      ∑ i ∈ range n, (f i - c)^2 := by
  have hlo : L^2 * (n : ℝ)^2 * ((n : ℝ)^2 - 1) / 6 ≤
      ∑ i ∈ range n, ∑ j ∈ range n, (f i - f j)^2 := by
    calc
      _ = L^2 * (∑ i ∈ range n, ∑ j ∈ range n, ((i : ℝ) - j)^2) := by
        rw [pairwise_index_sq]; ring
      _ = ∑ i ∈ range n, ∑ j ∈ range n, L^2 * ((i : ℝ) - j)^2 := by
        simp_rw [mul_sum]
      _ ≤ _ := sum_le_sum (fun i hi => sum_le_sum (fun j hj => hsep i hi j hj))
  have hhi : (∑ i ∈ range n, ∑ j ∈ range n, (f i - f j)^2) ≤
      2 * (n : ℝ) * (∑ i ∈ range n, (f i - c)^2) := by
    have heq := pairwise_sq_identity n (fun i => f i - c)
    simp only [sub_sub_sub_cancel_right] at heq
    nlinarith [sq_nonneg (∑ i ∈ range n, f i - c)]
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  apply (mul_le_mul_iff_right₀ (show (0 : ℝ) < 2 * n by positivity)).mp
  nlinarith [hlo.trans hhi]

theorem separated_variance_lower_bound (n : ℕ) (hn : 0 < n)
    (f : ℕ → ℝ) (L c : ℝ) (hL : 0 ≤ L)
    (hsep : ∀ i ∈ range n, ∀ j ∈ range n, i ≤ j →
      L * ((j : ℝ) - i) ≤ f j - f i) :
    L^2 * (n : ℝ) * ((n : ℝ)^2 - 1) / 12 ≤
      ∑ i ∈ range n, (f i - c)^2 := by
  have forward (i j : ℕ) (hi : i ∈ range n) (hj : j ∈ range n)
      (hij : i ≤ j) : L^2 * ((i : ℝ) - j)^2 ≤ (f i - f j)^2 := by
    have hd : (0 : ℝ) ≤ (j : ℝ) - i := by
      exact sub_nonneg.mpr (by exact_mod_cast hij)
    have h := hsep i hi j hj hij
    have hs := (sq_le_sq₀ (mul_nonneg hL hd) ((mul_nonneg hL hd).trans h)).2 h
    convert hs using 1 <;> ring
  apply sq_separated_variance_lower_bound n hn f L c
  intro i hi j hj
  rcases le_total i j with hij | hji
  · exact forward i j hi hj hij
  · have h := forward j i hj hi hji
    convert h using 1 <;> ring

end BuildingBlocks.CarryWindow
