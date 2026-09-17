import Mathlib.Tactic
import Mathlib.NumberTheory.VonMangoldt

/-!
# The moving Goldbach cutoff on one successor cell

On the open cell `(N,N+1)`, the max-threshold pair count sees indices
at most `N`, while the additive-total threshold also sees pairs with
one new index `N+1`. This file proves their exact finite difference
for arbitrary weights. The actual `vonMangoldt` specialization keeps
every prime power. The analytic `F`-ground cell integrals are supplied
as the two real parameters `a` and `b`.
-/

namespace BuildingBlocks.GoldbachUnitCellCutFinite

open Finset

noncomputable def cellKernel (N m n : ℕ) (a b : ℝ) : ℝ :=
  if m + n ≤ 2 * N then a else if m + n = 2 * N + 1 then b else 0

noncomputable def maxPair (N : ℕ) (weight : ℕ → ℝ) (a : ℝ) : ℝ :=
  ∑ m ∈ Icc 1 N, ∑ n ∈ Icc 1 N, weight m * weight n * a

noncomputable def totalPair (N : ℕ) (weight : ℕ → ℝ) (a b : ℝ) : ℝ :=
  ∑ m ∈ Icc 1 (N + 1), ∑ n ∈ Icc 1 (N + 1),
    weight m * weight n * cellKernel N m n a b

private theorem kernel_old {N m n : ℕ} (hm : m ∈ Icc 1 N)
    (hn : n ∈ Icc 1 N) (a b : ℝ) : cellKernel N m n a b = a := by
  unfold cellKernel
  rw [if_pos]
  simp only [mem_Icc] at hm hn
  omega

private theorem kernel_arrival_old {N n : ℕ} (hn : n ∈ Icc 1 (N - 1))
    (a b : ℝ) : cellKernel N (N + 1) n a b = a := by
  unfold cellKernel
  rw [if_pos]
  simp only [mem_Icc] at hn
  omega

private theorem kernel_arrival_last (N : ℕ) (a b : ℝ) :
    cellKernel N (N + 1) N a b = b := by
  unfold cellKernel
  rw [if_neg (by omega), if_pos (by omega)]

private theorem kernel_arrival_both (N : ℕ) (a b : ℝ) :
    cellKernel N (N + 1) (N + 1) a b = 0 := by
  simp [cellKernel, show ¬ N + 1 + (N + 1) ≤ 2 * N by omega,
    show N + 1 + (N + 1) ≠ 2 * N + 1 by omega]

private theorem kernel_swap (N m n : ℕ) (a b : ℝ) :
    cellKernel N m n a b = cellKernel N n m a b := by
  simp [cellKernel, add_comm]

/-- The exact new-pair payment. The adjacent `(N,N+1)` pair enters
halfway through the cell, while every smaller partner enters for the
full cell. -/
theorem totalPair_sub_maxPair (N : ℕ) (hN : 2 ≤ N)
    (weight : ℕ → ℝ) (a b : ℝ) :
    totalPair N weight a b - maxPair N weight a =
      2 * weight (N + 1) *
        (a * (∑ n ∈ Icc 1 (N - 1), weight n) + b * weight N) := by
  classical
  let S := Icc 1 N
  let Sprev := Icc 1 (N - 1)
  have hplus : Icc 1 (N + 1) = insert (N + 1) S := by
    ext j
    simp only [S, mem_Icc, mem_insert]
    omega
  have hlast : S = insert N Sprev := by
    ext j
    simp only [S, Sprev, mem_Icc, mem_insert]
    omega
  have hnotplus : N + 1 ∉ S := by
    simp only [S, mem_Icc]
    omega
  have hnotlast : N ∉ Sprev := by
    simp only [Sprev, mem_Icc]
    omega
  have hbase :
      (∑ m ∈ S, ∑ n ∈ S,
        weight m * weight n * cellKernel N m n a b) =
        maxPair N weight a := by
    unfold maxPair
    change (∑ m ∈ S, ∑ n ∈ S,
        weight m * weight n * cellKernel N m n a b) =
      ∑ m ∈ S, ∑ n ∈ S, weight m * weight n * a
    apply sum_congr rfl
    intro m hm
    apply sum_congr rfl
    intro n hn
    rw [kernel_old hm hn]
  have harrival :
      (∑ n ∈ S, weight (N + 1) * weight n *
        cellKernel N (N + 1) n a b) =
        weight (N + 1) *
          (a * (∑ n ∈ Sprev, weight n) + b * weight N) := by
    rw [hlast, sum_insert hnotlast]
    have hprev :
        (∑ n ∈ Sprev, weight (N + 1) * weight n *
          cellKernel N (N + 1) n a b) =
          weight (N + 1) * a * (∑ n ∈ Sprev, weight n) := by
      rw [mul_sum]
      apply sum_congr rfl
      intro n hn
      rw [kernel_arrival_old hn]
      ring
    rw [kernel_arrival_last, hprev]
    ring
  have hswap :
      (∑ m ∈ S, weight m * weight (N + 1) *
        cellKernel N m (N + 1) a b) =
      (∑ n ∈ S, weight (N + 1) * weight n *
        cellKernel N (N + 1) n a b) := by
    apply sum_congr rfl
    intro n hn
    rw [kernel_swap]
    ring
  unfold totalPair
  rw [hplus, sum_insert hnotplus]
  simp_rw [sum_insert hnotplus]
  rw [kernel_arrival_both]
  simp only [mul_zero]
  rw [sum_add_distrib, hbase, hswap, harrival]
  ring

noncomputable def actualWeight (n : ℕ) : ℝ :=
  ArithmeticFunction.vonMangoldt n

/-- The full-prime-power specialization of the moving-cutoff identity. -/
theorem actual_totalPair_sub_maxPair (N : ℕ) (hN : 2 ≤ N)
    (a b : ℝ) :
    totalPair N actualWeight a b - maxPair N actualWeight a =
      2 * ArithmeticFunction.vonMangoldt (N + 1) *
        (a * (∑ n ∈ Icc 1 (N - 1),
          ArithmeticFunction.vonMangoldt n) +
        b * ArithmeticFunction.vonMangoldt N) := by
  exact totalPair_sub_maxPair N hN actualWeight a b

/-- Nonnegative cell integrals make the actual moving-cutoff gap
nonnegative without any Goldbach existence assumption. -/
theorem actual_gap_nonneg (N : ℕ) (hN : 2 ≤ N)
    (a b : ℝ) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    0 ≤ totalPair N actualWeight a b - maxPair N actualWeight a := by
  rw [actual_totalPair_sub_maxPair N hN]
  have hsum : 0 ≤ ∑ n ∈ Icc 1 (N - 1),
      ArithmeticFunction.vonMangoldt n := by
    apply sum_nonneg
    intro n hn
    exact ArithmeticFunction.vonMangoldt_nonneg
  have hinner : 0 ≤ a * (∑ n ∈ Icc 1 (N - 1),
      ArithmeticFunction.vonMangoldt n) +
      b * ArithmeticFunction.vonMangoldt N :=
    add_nonneg (mul_nonneg ha hsum)
      (mul_nonneg hb ArithmeticFunction.vonMangoldt_nonneg)
  exact mul_nonneg (mul_nonneg (by norm_num : (0 : ℝ) ≤ 2)
    ArithmeticFunction.vonMangoldt_nonneg) hinner

#print axioms actual_totalPair_sub_maxPair
#print axioms actual_gap_nonneg

end BuildingBlocks.GoldbachUnitCellCutFinite
