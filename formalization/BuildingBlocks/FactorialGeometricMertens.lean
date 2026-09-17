import BuildingBlocks.FactorialBinaryCarry
import Mathlib.Tactic

open Finset
open scoped BigOperators

namespace BuildingBlocks.FactorialGeometricMertens

/-- The exact finite quotient triangle, including the first and final cells. -/
theorem quotient_triangle (N : ℕ) (a : ℕ → ℝ) (q : ℝ) :
    (∑ n ∈ Icc 1 N, a n * ∑ j ∈ range (N / n), q ^ j) =
      ∑ j ∈ range N, q ^ j * ∑ n ∈ Icc 1 (N / (j + 1)), a n := by
  have htriangle (n j : ℕ) (hn : 0 < n) :
      j + 1 ≤ N / n ↔ n ≤ N / (j + 1) := by
    rw [Nat.le_div_iff_mul_le hn, Nat.le_div_iff_mul_le (by omega : 0 < j + 1)]
    simp only [mul_comm]
  calc
    (∑ n ∈ Icc 1 N, a n * ∑ j ∈ range (N / n), q ^ j) =
        ∑ n ∈ Icc 1 N, ∑ j ∈ range N,
          if j + 1 ≤ N / n then a n * q ^ j else 0 := by
      apply sum_congr rfl
      intro n hn
      have hn0 : 0 < n := (mem_Icc.mp hn).1
      have hset : range (N / n) =
          (range N).filter (fun j => j + 1 ≤ N / n) := by
        ext j
        simp only [mem_range, mem_filter]
        constructor
        · intro hj
          exact ⟨lt_of_lt_of_le hj (Nat.div_le_self N n), by omega⟩
        · intro hj
          omega
      rw [hset, sum_filter]
      simp only [mul_sum]
      apply sum_congr rfl
      intro j hj
      by_cases h : j + 1 ≤ N / n <;> simp [h]
    _ = ∑ j ∈ range N, ∑ n ∈ Icc 1 N,
          if n ≤ N / (j + 1) then a n * q ^ j else 0 := by
      rw [sum_comm]
      apply sum_congr rfl
      intro j hj
      apply sum_congr rfl
      intro n hn
      simp only [htriangle n j (mem_Icc.mp hn).1]
    _ = ∑ j ∈ range N, q ^ j * ∑ n ∈ Icc 1 (N / (j + 1)), a n := by
      apply sum_congr rfl
      intro j hj
      have hset : Icc 1 (N / (j + 1)) =
          (Icc 1 N).filter (fun n => n ≤ N / (j + 1)) := by
        ext n
        simp only [mem_Icc, mem_filter]
        constructor
        · intro hn
          exact ⟨⟨hn.1, hn.2.trans (Nat.div_le_self N (j + 1))⟩, hn.2⟩
        · intro hn
          exact ⟨hn.1.1, hn.2⟩
      rw [hset, sum_filter]
      simp only [mul_sum]
      apply sum_congr rfl
      intro n hn
      by_cases h : n ≤ N / (j + 1) <;> simp [h, mul_comm]

/-- A quotient-floor history can repeat at most `j` times in one finite
clock horizon. This is the precise squared-norm cost used by the hard-clock
comparison. -/
theorem quotient_floor_square_bound (X j : ℕ) (hj : 0 < j) (f : ℕ → ℝ) :
    (∑ N ∈ Icc 1 X, f (N / j) ^ 2) ≤
      (j : ℝ) * ∑ m ∈ range (X + 1), f m ^ 2 := by
  have hmaps : ∀ N ∈ Icc 1 X, N / j ∈ range (X + 1) := by
    intro N hN
    simp only [mem_range]
    have hNX : N ≤ X := (mem_Icc.mp hN).2
    have hle := Nat.div_le_self N j
    omega
  have hgroup :
      (∑ N ∈ Icc 1 X, f (N / j) ^ 2) =
        ∑ m ∈ range (X + 1),
          (((Icc 1 X).filter (fun N => N / j = m)).card : ℝ) * f m ^ 2 := by
    rw [← sum_fiberwise_of_maps_to hmaps (fun N => f (N / j) ^ 2)]
    apply sum_congr rfl
    intro m hm
    have he : ∀ N ∈ (Icc 1 X).filter (fun N => N / j = m),
        f (N / j) ^ 2 = f m ^ 2 := by
      intro N hN
      rw [(mem_filter.mp hN).2]
    rw [sum_congr rfl he]
    simp only [sum_const, nsmul_eq_mul]
  rw [hgroup, mul_sum]
  apply sum_le_sum
  intro m hm
  have hsub : (Icc 1 X).filter (fun N => N / j = m) ⊆
      Ico (m * j) ((m + 1) * j) := by
    intro N hN
    have hq : N / j = m := (mem_filter.mp hN).2
    have hb := (Nat.div_eq_iff hj).mp hq
    apply mem_Ico.mpr
    constructor
    · exact hb.1
    · rw [show (m + 1) * j = m * j + j by ring]
      omega
  have hcard : ((Icc 1 X).filter (fun N => N / j = m)).card ≤ j := by
    calc
      _ ≤ (Ico (m * j) ((m + 1) * j)).card := card_le_card hsub
      _ = j := by rw [Nat.card_Ico]; simp [Nat.add_mul]
  have hnonneg : 0 ≤ f m ^ 2 := sq_nonneg _
  exact mul_le_mul_of_nonneg_right (by exact_mod_cast hcard :
    (((Icc 1 X).filter (fun N => N / j = m)).card : ℝ) ≤ j) hnonneg

/-- The complete original factorial response is a geometric average of all
Mertens quotient histories. No analytic limit or RH bound enters. -/
theorem response_geometric (N : ℕ) (t : ℝ) :
    FactorialBinaryCarry.response N t =
      (1 - Real.exp (-t)) * ∑ j ∈ range N,
        Real.exp (-t) ^ j * (BuildingBlocks.MertensTransfer.mertens (N / (j + 1)) : ℝ) := by
  let q : ℝ := Real.exp (-t)
  have hgeom (m : ℕ) :
      1 - Real.exp (-(m : ℝ) * t) =
        (1 - q) * ∑ j ∈ range m, q ^ j := by
    have hp : Real.exp (-(m : ℝ) * t) = q ^ m := by
      dsimp [q]
      rw [← Real.exp_nat_mul]
      congr 1
      ring
    rw [hp]
    simpa only [mul_comm] using (geom_sum_mul_neg q m).symm
  unfold FactorialBinaryCarry.response
  simp_rw [hgeom]
  calc
    (∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
        ((1 - q) * ∑ j ∈ range (N / n), q ^ j)) =
        (1 - q) * ∑ n ∈ Icc 1 N,
          (ArithmeticFunction.moebius n : ℝ) * ∑ j ∈ range (N / n), q ^ j := by
      rw [mul_sum]
      apply sum_congr rfl
      intro n hn
      ring
    _ = (1 - q) * ∑ j ∈ range N, q ^ j *
        ∑ n ∈ Icc 1 (N / (j + 1)), (ArithmeticFunction.moebius n : ℝ) := by
      rw [quotient_triangle]
    _ = _ := by
      dsimp [q]
      congr 1
      apply sum_congr rfl
      intro j hj
      rw [BuildingBlocks.MertensTransfer.mertens_eq_sum_Icc]

#print axioms quotient_triangle
#print axioms quotient_floor_square_bound
#print axioms response_geometric

end BuildingBlocks.FactorialGeometricMertens
