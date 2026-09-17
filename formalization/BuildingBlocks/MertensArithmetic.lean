import BuildingBlocks.DivisorForcingBound
import BuildingBlocks.CoarsePrimeBounds

open Finset Filter Set MeasureTheory
open BuildingBlocks.FloorCorrection BuildingBlocks.HyperbolaProduct BuildingBlocks.CoarsePrimitive
open scoped BigOperators Topology Interval

namespace BuildingBlocks.MertensTransfer

theorem logFactorial_eq_sum_psi (N : ℕ) :
    logFactorial N = ∑ k ∈ Finset.Icc 1 N, psi (N / k) := by
  unfold logFactorial
  simp_rw [← ArithmeticFunction.vonMangoldt_sum]
  conv_lhs => arg 2; ext n; rw [← Nat.sum_div_divisors n ArithmeticFunction.vonMangoldt]
  rw [sum_divisors_eq_sum_factor_pairs N (fun _ d => ArithmeticFunction.vonMangoldt d)]
  simp only [psi_eq_sum_Icc]

noncomputable def integerError (N : ℕ) : ℝ := psi N - (N : ℝ)

noncomputable def recurrenceForcing (N : ℕ) : ℝ :=
  logFactorial N - ∑ k ∈ Finset.Icc 1 N, ((N / k : ℕ) : ℝ)

theorem sum_integerError_eq_forcing (N : ℕ) :
    ∑ k ∈ Finset.Icc 1 N, integerError (N / k) = recurrenceForcing N := by
  simp only [integerError, Finset.sum_sub_distrib, recurrenceForcing,
    ← logFactorial_eq_sum_psi]

theorem centeredDivisorForcing_eq_recurrence (N : ℕ) :
    centeredDivisorForcing N = recurrenceForcing N +
      2 * Real.eulerMascheroniConstant * N := rfl

def quotientBlock (N q : ℕ) : Finset ℕ :=
  (Finset.Icc 1 N).filter (fun k => N / k = q)

theorem quotientBlock_eq_Ioc (N : ℕ) {q : ℕ} (hq : 0 < q) :
    quotientBlock N q = Finset.Ioc (N / (q + 1)) (N / q) := by
  ext k
  simp only [quotientBlock, Finset.mem_filter, Finset.mem_Icc, Finset.mem_Ioc]
  constructor
  · rintro ⟨⟨hk1, hkN⟩, heq⟩
    constructor
    · apply (Nat.div_lt_iff_lt_mul (by omega : 0 < q + 1)).mpr
      have hh := (Nat.div_lt_iff_lt_mul hk1).mp (show N / k < q + 1 by omega)
      simpa only [mul_comm] using hh
    · apply (Nat.le_div_iff_mul_le hq).mpr
      have hh := (Nat.le_div_iff_mul_le hk1).mp (show q ≤ N / k by omega)
      simpa only [mul_comm] using hh
  · rintro ⟨hlo, hhi⟩
    have hk1 : 0 < k := lt_of_le_of_lt (Nat.zero_le _) hlo
    have hlow : q ≤ N / k := by
      apply (Nat.le_div_iff_mul_le hk1).mpr
      simpa only [mul_comm] using (Nat.le_div_iff_mul_le hq).mp hhi
    have hhigh : N / k < q + 1 := by
      apply (Nat.div_lt_iff_lt_mul hk1).mpr
      simpa only [mul_comm] using
        (Nat.div_lt_iff_lt_mul (by omega : 0 < q + 1)).mp hlo
    exact ⟨⟨hk1, hhi.trans (Nat.div_le_self _ _)⟩, by omega⟩

theorem sum_grouped_by_quotient (N : ℕ) (a g : ℕ → ℝ) :
    ∑ k ∈ Finset.Icc 1 N, a k * g (N / k) =
      ∑ q ∈ Finset.Icc 1 N, (∑ k ∈ quotientBlock N q, a k) * g q := by
  have hm : ∀ k ∈ Finset.Icc 1 N, N / k ∈ Finset.Icc 1 N := by
    intro k hk
    obtain ⟨hk1, hkN⟩ := Finset.mem_Icc.mp hk
    exact Finset.mem_Icc.mpr ⟨Nat.div_pos hkN hk1, Nat.div_le_self _ _⟩
  rw [← Finset.sum_fiberwise_of_maps_to hm (fun k => a k * g (N / k))]
  apply Finset.sum_congr rfl
  intro q hq
  rw [Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro k hk
  rw [(Finset.mem_filter.mp hk).2]

def mertens (N : ℕ) : ℤ :=
  ∑ k ∈ Finset.range (N + 1), ArithmeticFunction.moebius k

def quotientCoefficient (N q : ℕ) : ℤ :=
  ∑ k ∈ quotientBlock N q, ArithmeticFunction.moebius k

theorem quotientCoefficient_eq_mertens (N : ℕ) {q : ℕ} (hq : 0 < q) :
    quotientCoefficient N q = mertens (N / q) - mertens (N / (q + 1)) := by
  rw [quotientCoefficient, quotientBlock_eq_Ioc N hq]
  have hi : Finset.Ioc (N / (q + 1)) (N / q) =
      Finset.Ico (N / (q + 1) + 1) (N / q + 1) := by
    ext k
    simp only [Finset.mem_Ioc, Finset.mem_Ico]
    omega
  rw [hi, Finset.sum_Ico_eq_sub ArithmeticFunction.moebius
    (Nat.add_le_add_right (Nat.div_le_div_left (by omega : q ≤ q + 1) hq) 1)]
  rfl

theorem moebius_floor_mass {N : ℕ} (hN : 0 < N) :
    ∑ k ∈ Finset.Icc 1 N,
      ArithmeticFunction.moebius k * ((N / k : ℕ) : ℤ) = 1 := by
  have hh := sum_divisors_eq_sum_factor_pairs N (fun k _ => ArithmeticFunction.moebius k)
  simp only [moebius_divisor_sum, Finset.sum_const, Nat.card_Icc,
    Nat.add_sub_cancel, nsmul_eq_mul] at hh
  have hm : 1 ∈ Finset.Icc 1 N := Finset.mem_Icc.mpr ⟨le_rfl, hN⟩
  simpa [hm, mul_comm] using hh.symm

theorem moebius_floor_inversion (f : ℕ → ℝ) {N : ℕ} (hN : 1 ≤ N) :
    (∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
      ∑ k ∈ Finset.Icc 1 (N / d), f (N / d / k)) = f N := by
  simp_rw [Finset.mul_sum, Nat.div_div_eq_div_mul]
  rw [← sum_divisors_eq_sum_factor_pairs N
    (fun d k => (ArithmeticFunction.moebius d : ℝ) * f (N / (d * k)))]
  have he : ∀ n ∈ Finset.Icc 1 N,
      (∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
        f (N / (d * (n / d)))) = (if n = 1 then 1 else 0) * f (N / n) := by
    intro n hn
    have hh : (∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ)) =
        if n = 1 then 1 else 0 := by
      exact_mod_cast moebius_divisor_sum n
    calc
      _ = (∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) * f (N / n)) := by
        apply Finset.sum_congr rfl
        intro d hd
        rw [Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1]
      _ = _ := by rw [← Finset.sum_mul, hh]
  rw [Finset.sum_congr rfl he]
  simp [Finset.mem_Icc.mpr ⟨le_rfl, hN⟩]

theorem integerError_eq_moebius_recurrenceForcing {N : ℕ} (hN : 1 ≤ N) :
    integerError N = ∑ d ∈ Finset.Icc 1 N,
      (ArithmeticFunction.moebius d : ℝ) * recurrenceForcing (N / d) := by
  simp_rw [← sum_integerError_eq_forcing]
  exact (moebius_floor_inversion integerError hN).symm

theorem centeredDivisorForcing_inverse {N : ℕ} (hN : 1 ≤ N) :
    (∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
      centeredDivisorForcing (N / d)) =
        integerError N + 2 * Real.eulerMascheroniConstant := by
  simp_rw [centeredDivisorForcing_eq_recurrence, mul_add, Finset.sum_add_distrib]
  rw [← integerError_eq_moebius_recurrenceForcing hN]
  have hh : (∑ d ∈ Finset.Icc 1 N,
      (ArithmeticFunction.moebius d : ℝ) * ((N / d : ℕ) : ℝ)) = 1 := by
    have hc := congrArg (fun z : ℤ => (z : ℝ)) (moebius_floor_mass hN)
    simpa only [Int.cast_sum, Int.cast_mul, Int.cast_natCast, Int.cast_one] using hc
  congr 1
  calc
    _ = (2 * Real.eulerMascheroniConstant) *
        ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) * ((N / d : ℕ) : ℝ) := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro d _
      ring
    _ = _ := by rw [hh, mul_one]

noncomputable def centeredDivisorCoefficient (n : ℕ) : ℝ :=
  Real.log n - (n.divisors.card : ℝ) + 2 * Real.eulerMascheroniConstant

theorem divisorSum_eq_sum_divisor_card (N : ℕ) :
    divisorSum N = ∑ n ∈ Finset.Icc 1 N, (n.divisors.card : ℝ) := by
  have hh := sum_divisors_eq_sum_factor_pairs N (fun _ _ => (1 : ℝ))
  simpa [divisorSum] using hh.symm

theorem centeredDivisorForcing_eq_sum_coefficients (N : ℕ) :
    centeredDivisorForcing N = ∑ n ∈ Finset.Icc 1 N, centeredDivisorCoefficient n := by
  simp only [centeredDivisorCoefficient, Finset.sum_add_distrib, Finset.sum_sub_distrib,
    ← divisorSum_eq_sum_divisor_card, Finset.sum_const, Nat.card_Icc,
    Nat.add_sub_cancel, nsmul_eq_mul, centeredDivisorForcing, logFactorial]
  ring

theorem centeredDivisorForcing_succ (n : ℕ) :
    centeredDivisorForcing (n + 1) = centeredDivisorForcing n + centeredDivisorCoefficient (n + 1) := by
  rw [centeredDivisorForcing_eq_sum_coefficients,
    Finset.sum_Icc_succ_top (by omega : 1 ≤ n + 1),
    ← centeredDivisorForcing_eq_sum_coefficients]

theorem mertens_eq_sum_Icc (N : ℕ) :
    (mertens N : ℝ) = ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) := by
  rw [mertens, Int.cast_sum]
  have he : Finset.Icc 1 N = Finset.Ico 1 (N + 1) := by
    ext k
    simp only [Finset.mem_Icc, Finset.mem_Ico]
    omega
  rw [he, Finset.sum_Ico_eq_sub _ (by omega : 1 ≤ N + 1)]
  simp

end BuildingBlocks.MertensTransfer
