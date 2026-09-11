import BuildingBlocks.MertensCutoff

open Finset Filter Set MeasureTheory
open BuildingBlocks.FloorCorrection BuildingBlocks.HyperbolaProduct BuildingBlocks.CoarsePrimitive
open scoped BigOperators Topology Interval

namespace BuildingBlocks.MertensTransfer

theorem mertens_abs_le (N : ℕ) : |(mertens N : ℝ)| ≤ N := by
  rw [mertens_eq_sum_Icc]
  have hh : (∑ d ∈ Finset.Icc 1 N, |(ArithmeticFunction.moebius d : ℝ)|) ≤
      ∑ _d ∈ Finset.Icc 1 N, (1 : ℝ) := by
    apply Finset.sum_le_sum
    intro d _
    exact_mod_cast (ArithmeticFunction.abs_moebius_le_one (n := d))
  exact (Finset.abs_sum_le_sum_abs _ _).trans (by simpa using hh)

theorem centeredDivisorForcing_sqrt_bound_all (N : ℕ) :
    |centeredDivisorForcing N| ≤ 13 * Real.sqrt N := by
  by_cases hN : N = 0
  · subst N
    simp [centeredDivisorForcing, logFactorial, divisorSum]
  · exact centeredDivisorForcing_sqrt_bound (by omega)

theorem centered_partial_summation (v : ℕ → ℝ) (K : ℕ) :
    (∑ q ∈ Finset.Icc 1 K, centeredDivisorForcing q * (v q - v (q + 1))) =
      (∑ k ∈ Finset.Icc 1 K, centeredDivisorCoefficient k * v k) -
        centeredDivisorForcing K * v (K + 1) := by
  induction K with
  | zero => simp [centeredDivisorForcing, logFactorial, divisorSum]
  | succ K ih =>
    simp only [Finset.sum_Icc_succ_top (by omega : 1 ≤ K + 1), ih,
      centeredDivisorForcing_succ]
    ring

noncomputable def centeredMertensPrefix (N K : ℕ) : ℝ :=
  ∑ k ∈ Finset.Icc 1 K, centeredDivisorCoefficient k * (mertens (N / k) : ℝ)

theorem smallQuotientSigned_grouped {N K : ℕ} (hKN : K ≤ N) :
    smallQuotientSigned N (K + 1) =
      ∑ q ∈ Finset.Icc 1 K, (quotientCoefficient N q : ℝ) * centeredDivisorForcing q := by
  have hd : (Finset.Icc 1 N).filter (fun d => N / d ≤ K) = Finset.Ioc (N / (K + 1)) N := by
    ext d
    rw [Finset.mem_filter, smallQuotient_indices_iff (Nat.succ_pos K)]
    simp only [Nat.lt_succ_iff]
  have hq : (Finset.Icc 1 N).filter (fun q => q ≤ K) = Finset.Icc 1 K := by
    ext q
    simp only [Finset.mem_filter, Finset.mem_Icc]
    omega
  have hg := sum_grouped_by_quotient N (fun d => (ArithmeticFunction.moebius d : ℝ))
    (fun q => if q ≤ K then centeredDivisorForcing q else 0)
  calc
    smallQuotientSigned N (K + 1) =
        ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
          (if N / d ≤ K then centeredDivisorForcing (N / d) else 0) := by
      rw [smallQuotientSigned, ← hd]
      simp only [Finset.sum_filter, mul_ite, mul_zero]
    _ = _ := hg
    _ = ∑ q ∈ (Finset.Icc 1 N).filter (fun q => q ≤ K),
        (quotientCoefficient N q : ℝ) * centeredDivisorForcing q := by
      simp only [Finset.sum_filter, quotientCoefficient, Int.cast_sum, mul_ite, mul_zero]
    _ = _ := by rw [hq]

theorem smallQuotientSigned_partial_summation {N K : ℕ} (hKN : K ≤ N) :
    smallQuotientSigned N (K + 1) = centeredMertensPrefix N K -
      centeredDivisorForcing K * (mertens (N / (K + 1)) : ℝ) := by
  rw [smallQuotientSigned_grouped hKN]
  have he : (∑ q ∈ Finset.Icc 1 K, (quotientCoefficient N q : ℝ) * centeredDivisorForcing q) =
      ∑ q ∈ Finset.Icc 1 K, centeredDivisorForcing q *
        ((mertens (N / q) : ℝ) - (mertens (N / (q + 1)) : ℝ)) := by
    apply Finset.sum_congr rfl
    intro q hq
    rw [quotientCoefficient_eq_mertens N (Finset.mem_Icc.mp hq).1, Int.cast_sub, mul_comm]
  rw [he, centered_partial_summation]
  rfl

theorem centeredMertens_boundary_bound (N K : ℕ) :
    |centeredDivisorForcing K * (mertens (N / (K + 1)) : ℝ)| ≤
      13 * (N : ℝ) / Real.sqrt ((K + 1 : ℕ) : ℝ) := by
  have hH : |centeredDivisorForcing K| ≤ 13 * Real.sqrt ((K + 1 : ℕ) : ℝ) :=
    (centeredDivisorForcing_sqrt_bound_all K).trans
      (mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt (by exact_mod_cast Nat.le_succ K))
        (by norm_num))
  have hM : |(mertens (N / (K + 1)) : ℝ)| ≤ (N : ℝ) / ((K + 1 : ℕ) : ℝ) :=
    (mertens_abs_le _).trans Nat.cast_div_le
  rw [abs_mul]
  calc
    _ ≤ (13 * Real.sqrt ((K + 1 : ℕ) : ℝ)) * ((N : ℝ) / ((K + 1 : ℕ) : ℝ)) :=
      mul_le_mul hH hM (abs_nonneg _) (by positivity)
    _ = 13 * (N : ℝ) *
        (Real.sqrt ((K + 1 : ℕ) : ℝ) / ((K + 1 : ℕ) : ℝ)) := by ring
    _ = _ := by rw [Real.sqrt_div_self']; ring

theorem primeError_Mertens_prefix_remainder {N K : ℕ} (hN : 1 ≤ N) (hKN : K ≤ N) :
    |integerError N + 2 * Real.eulerMascheroniConstant - centeredMertensPrefix N K| ≤
      39 * (N : ℝ) / Real.sqrt ((K + 1 : ℕ) : ℝ) := by
  calc
    _ = |(integerError N + 2 * Real.eulerMascheroniConstant - smallQuotientSigned N (K + 1)) -
        centeredDivisorForcing K * (mertens (N / (K + 1)) : ℝ)| := by
      rw [smallQuotientSigned_partial_summation hKN]
      congr 1
      ring
    _ ≤ |integerError N + 2 * Real.eulerMascheroniConstant - smallQuotientSigned N (K + 1)| +
        |centeredDivisorForcing K * (mertens (N / (K + 1)) : ℝ)| := abs_sub _ _
    _ ≤ 26 * (N : ℝ) / Real.sqrt ((K + 1 : ℕ) : ℝ) +
        13 * (N : ℝ) / Real.sqrt ((K + 1 : ℕ) : ℝ) :=
      add_le_add (primeError_cutoff_remainder_bound hN) (centeredMertens_boundary_bound N K)
    _ = _ := by ring

end BuildingBlocks.MertensTransfer
