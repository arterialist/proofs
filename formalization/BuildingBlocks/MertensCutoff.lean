import BuildingBlocks.MertensArithmetic

open Finset Filter Set MeasureTheory
open BuildingBlocks.FloorCorrection BuildingBlocks.HyperbolaProduct BuildingBlocks.CoarsePrimitive
open scoped BigOperators Topology Interval

namespace BuildingBlocks.MertensTransfer

theorem reciprocal_sqrt_sum_bound (K : ℕ) :
    (∑ d ∈ Finset.Icc 1 K, 1 / Real.sqrt (d : ℝ)) ≤ 2 * Real.sqrt K := by
  induction K with
  | zero => simp
  | succ K ih =>
    have hb : 0 < Real.sqrt ((K + 1 : ℕ) : ℝ) := by positivity
    have hs0 := Real.sq_sqrt (Nat.cast_nonneg K)
    have hs1 := Real.sq_sqrt (Nat.cast_nonneg (K + 1))
    have hstep : 1 / Real.sqrt ((K + 1 : ℕ) : ℝ) ≤
        2 * Real.sqrt ((K + 1 : ℕ) : ℝ) - 2 * Real.sqrt K := by
      apply (div_le_iff₀ hb).mpr
      have hd := sq_nonneg (Real.sqrt ((K + 1 : ℕ) : ℝ) - Real.sqrt K)
      norm_num only [Nat.cast_add, Nat.cast_one] at hs1 ⊢
      norm_num only [Nat.cast_add, Nat.cast_one] at hd
      nlinarith
    rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ K + 1)]
    linarith

theorem floor_sqrt_sum_bound (N K : ℕ) :
    (∑ d ∈ Finset.Icc 1 K, Real.sqrt ((N / d : ℕ) : ℝ)) ≤
      2 * Real.sqrt N * Real.sqrt K := by
  have hh : (∑ d ∈ Finset.Icc 1 K, Real.sqrt ((N / d : ℕ) : ℝ)) ≤
      ∑ d ∈ Finset.Icc 1 K, Real.sqrt (N : ℝ) / Real.sqrt (d : ℝ) := by
    apply Finset.sum_le_sum
    intro d _
    simpa [Real.sqrt_div (Nat.cast_nonneg N)] using
      Real.sqrt_le_sqrt (Nat.cast_div_le (m := N) (n := d) (α := ℝ))
  have hs := mul_le_mul_of_nonneg_left (reciprocal_sqrt_sum_bound K) (Real.sqrt_nonneg (N : ℝ))
  have he : (∑ d ∈ Finset.Icc 1 K, Real.sqrt (N : ℝ) / Real.sqrt (d : ℝ)) =
      Real.sqrt N * (∑ d ∈ Finset.Icc 1 K, 1 / Real.sqrt (d : ℝ)) := by
    simp only [Finset.mul_sum, div_eq_mul_inv, one_mul]
  rw [he] at hh
  nlinarith

noncomputable def largeQuotientAbsolute (N K : ℕ) : ℝ :=
  ∑ d ∈ Finset.Icc 1 (N / K), |(ArithmeticFunction.moebius d : ℝ) *
    centeredDivisorForcing (N / d)|

theorem largeQuotientAbsolute_bound (N K : ℕ) :
    largeQuotientAbsolute N K ≤ 26 * (N : ℝ) / Real.sqrt K := by
  have ht : ∀ d ∈ Finset.Icc 1 (N / K),
      |(ArithmeticFunction.moebius d : ℝ) * centeredDivisorForcing (N / d)| ≤
        13 * Real.sqrt ((N / d : ℕ) : ℝ) := by
    intro d hd
    obtain ⟨hd1, hdN⟩ := Finset.mem_Icc.mp hd
    have hq1 : 1 ≤ N / d := Nat.div_pos (hdN.trans (Nat.div_le_self N K)) hd1
    have hmu : |(ArithmeticFunction.moebius d : ℝ)| ≤ 1 := by
      exact_mod_cast (ArithmeticFunction.abs_moebius_le_one (n := d))
    rw [abs_mul]
    calc
      _ ≤ 1 * |centeredDivisorForcing (N / d)| :=
        mul_le_mul_of_nonneg_right hmu (abs_nonneg _)
      _ ≤ _ := by simpa using centeredDivisorForcing_sqrt_bound hq1
  have hs := Finset.sum_le_sum ht
  rw [← Finset.mul_sum] at hs
  have hr := floor_sqrt_sum_bound N (N / K)
  have hfloor : Real.sqrt ((N / K : ℕ) : ℝ) ≤ Real.sqrt N / Real.sqrt K := by
    simpa [Real.sqrt_div (Nat.cast_nonneg N)] using
      Real.sqrt_le_sqrt (Nat.cast_div_le (m := N) (n := K) (α := ℝ))
  calc
    largeQuotientAbsolute N K ≤ 13 *
        ∑ d ∈ Finset.Icc 1 (N / K), Real.sqrt ((N / d : ℕ) : ℝ) := hs
    _ ≤ 26 * Real.sqrt N * Real.sqrt ((N / K : ℕ) : ℝ) := by nlinarith
    _ ≤ 26 * Real.sqrt N * (Real.sqrt N / Real.sqrt K) :=
      mul_le_mul_of_nonneg_left hfloor (by positivity)
    _ = 26 * (N : ℝ) / Real.sqrt K := by
      rw [show 26 * Real.sqrt N * (Real.sqrt N / Real.sqrt K) =
        26 * (Real.sqrt N * Real.sqrt N) / Real.sqrt K by ring,
        Real.mul_self_sqrt (Nat.cast_nonneg N)]

noncomputable def smallQuotientSigned (N K : ℕ) : ℝ :=
  ∑ d ∈ Finset.Ioc (N / K) N, (ArithmeticFunction.moebius d : ℝ) *
    centeredDivisorForcing (N / d)

theorem centered_inverse_cutoff_decomposition {N K : ℕ} (hN : 1 ≤ N) :
    integerError N + 2 * Real.eulerMascheroniConstant =
      (∑ d ∈ Finset.Icc 1 (N / K), (ArithmeticFunction.moebius d : ℝ) *
        centeredDivisorForcing (N / d)) + smallQuotientSigned N K := by
  rw [← centeredDivisorForcing_inverse hN]
  have he : Finset.Icc 1 N = Finset.Icc 1 (N / K) ∪ Finset.Ioc (N / K) N := by
    ext d
    simp only [Finset.mem_Icc, Finset.mem_union, Finset.mem_Ioc]
    have hh := Nat.div_le_self N K
    have hzero : 0 ≤ N / K := Nat.zero_le _
    omega
  have hd : Disjoint (Finset.Icc 1 (N / K)) (Finset.Ioc (N / K) N) := by
    rw [Finset.disjoint_left]
    intro d h1 h2
    have ha := (Finset.mem_Icc.mp h1).2
    have hb := (Finset.mem_Ioc.mp h2).1
    omega
  rw [he, Finset.sum_union hd]
  rfl

theorem primeError_cutoff_remainder_bound {N K : ℕ} (hN : 1 ≤ N) :
    |integerError N + 2 * Real.eulerMascheroniConstant - smallQuotientSigned N K| ≤
      26 * (N : ℝ) / Real.sqrt K := by
  rw [centered_inverse_cutoff_decomposition hN, add_sub_cancel_right]
  exact (Finset.abs_sum_le_sum_abs _ _).trans (largeQuotientAbsolute_bound N K)

theorem smallQuotient_indices_iff {N K d : ℕ} (hK : 0 < K) :
    d ∈ Finset.Ioc (N / K) N ↔ d ∈ Finset.Icc 1 N ∧ N / d < K := by
  constructor
  · intro hd
    obtain ⟨hlo, hhi⟩ := Finset.mem_Ioc.mp hd
    have hd0 : 0 < d := lt_of_le_of_lt (Nat.zero_le _) hlo
    refine ⟨Finset.mem_Icc.mpr ⟨hd0, hhi⟩, ?_⟩
    apply (Nat.div_lt_iff_lt_mul hd0).mpr
    simpa [mul_comm] using (Nat.div_lt_iff_lt_mul hK).mp hlo
  · rintro ⟨hd, hdiv⟩
    obtain ⟨hd1, hdN⟩ := Finset.mem_Icc.mp hd
    apply Finset.mem_Ioc.mpr
    refine ⟨?_, hdN⟩
    apply (Nat.div_lt_iff_lt_mul hK).mpr
    simpa [mul_comm] using (Nat.div_lt_iff_lt_mul hd1).mp hdiv

end BuildingBlocks.MertensTransfer
