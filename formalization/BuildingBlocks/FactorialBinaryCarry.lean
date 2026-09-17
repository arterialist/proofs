import BuildingBlocks.MertensArithmetic

open Finset
open scoped BigOperators

namespace BuildingBlocks.FactorialBinaryCarry

/-- The full finite Möbius response, including every integer quotient. -/
noncomputable def response (N : ℕ) (t : ℝ) : ℝ :=
  ∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
    (1 - Real.exp (-(N / n : ℕ) * t))

/-- Binary quotient carry; natural subtraction is justified below. -/
def carry (N b n : ℕ) : ℕ := (2 * N + b) / n - 2 * (N / n)

theorem quotient_binary_bounds (N b n : ℕ) (hb : b ≤ 1) (hn : 0 < n) :
    2 * (N / n) ≤ (2 * N + b) / n ∧
    (2 * N + b) / n < 2 * (N / n) + 2 := by
  have hm := Nat.mod_lt N hn
  have he := Nat.mod_add_div N n
  constructor
  · apply (Nat.le_div_iff_mul_le hn).mpr
    calc
      2 * (N / n) * n = 2 * (n * (N / n)) := by ring
      _ ≤ 2 * N := Nat.mul_le_mul_left 2 (Nat.mul_div_le N n)
      _ ≤ 2 * N + b := by omega
  · apply (Nat.div_lt_iff_lt_mul hn).mpr
    nlinarith

theorem carry_le_one (N b n : ℕ) (hb : b ≤ 1) (hn : 0 < n) :
    carry N b n ≤ 1 := by
  have h := quotient_binary_bounds N b n hb hn
  unfold carry
  omega

theorem quotient_eq_twice_add_carry (N b n : ℕ) (hb : b ≤ 1) (hn : 0 < n) :
    (2 * N + b) / n = 2 * (N / n) + carry N b n := by
  have h := (quotient_binary_bounds N b n hb hn).1
  unfold carry
  omega

theorem response_extend (N R : ℕ) (hNR : N ≤ R) (t : ℝ) :
    response N t = ∑ n ∈ Icc 1 R, (ArithmeticFunction.moebius n : ℝ) *
      (1 - Real.exp (-(N / n : ℕ) * t)) := by
  unfold response
  apply Finset.sum_subset
  · intro n hn
    exact mem_Icc.mpr ⟨(mem_Icc.mp hn).1, (mem_Icc.mp hn).2.trans hNR⟩
  · intro n hn hnot
    have hlarge : N < n := by
      have h1 := (mem_Icc.mp hn).1
      simp only [mem_Icc] at hnot
      omega
    simp [Nat.div_eq_of_lt hlarge]

noncomputable def innovation (N b : ℕ) (t : ℝ) : ℝ :=
  (1 - Real.exp (-t)) * ∑ n ∈ Icc 1 (2 * N + b),
    (ArithmeticFunction.moebius n : ℝ) * (carry N b n : ℝ) *
      Real.exp (-2 * (N / n : ℕ) * t)

theorem response_binary (N b : ℕ) (hb : b ≤ 1) (t : ℝ) :
    response (2 * N + b) t = response N (2 * t) + innovation N b t := by
  rw [response_extend N (2 * N + b) (by omega)]
  unfold response innovation
  rw [Finset.mul_sum, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  have hn0 : 0 < n := (mem_Icc.mp hn).1
  have he := quotient_eq_twice_add_carry N b n hb hn0
  have hc := carry_le_one N b n hb hn0
  have hcases : carry N b n = 0 ∨ carry N b n = 1 := by omega
  rw [he]
  rcases hcases with hzero | hone
  · simp only [hzero, Nat.cast_mul, Nat.cast_ofNat,
      Nat.cast_zero, mul_zero, zero_mul, add_zero]
    rw [show -(2 * ((N / n : ℕ) : ℝ)) * t =
      -((N / n : ℕ) : ℝ) * (2 * t) by ring]
  · simp only [hone, Nat.cast_add, Nat.cast_mul, Nat.cast_ofNat, Nat.cast_one]
    rw [show -(2 * ((N / n : ℕ) : ℝ) + 1) * t =
      -2 * ((N / n : ℕ) : ℝ) * t + -t by ring, Real.exp_add,
      show -((N / n : ℕ) : ℝ) * (2 * t) =
        -2 * ((N / n : ℕ) : ℝ) * t by ring]
    ring

theorem floor_mass_extend (N R : ℕ) (hNR : N ≤ R) :
    (∑ n ∈ Icc 1 R, ArithmeticFunction.moebius n * ((N / n : ℕ) : ℤ)) =
      ∑ n ∈ Icc 1 N, ArithmeticFunction.moebius n * ((N / n : ℕ) : ℤ) := by
  symm
  apply Finset.sum_subset
  · intro n hn
    exact mem_Icc.mpr ⟨(mem_Icc.mp hn).1, (mem_Icc.mp hn).2.trans hNR⟩
  · intro n hn hnot
    have hlarge : N < n := by
      have h1 := (mem_Icc.mp hn).1
      simp only [mem_Icc] at hnot
      omega
    simp [Nat.div_eq_of_lt hlarge]

theorem carry_moebius_mass (N b : ℕ) (hN : 0 < N) (hb : b ≤ 1) :
    (∑ n ∈ Icc 1 (2 * N + b),
      ArithmeticFunction.moebius n * (carry N b n : ℤ)) = -1 := by
  have he : ∀ n ∈ Icc 1 (2 * N + b), (carry N b n : ℤ) =
      (((2 * N + b) / n : ℕ) : ℤ) - 2 * ((N / n : ℕ) : ℤ) := by
    intro n hn
    have hz := congrArg (fun a : ℕ => (a : ℤ))
      (quotient_eq_twice_add_carry N b n hb (mem_Icc.mp hn).1)
    simp only [Nat.cast_add, Nat.cast_mul, Nat.cast_ofNat] at hz
    linarith
  simp_rw [Finset.sum_congr rfl (fun n hn => congrArg
    (fun a : ℤ => ArithmeticFunction.moebius n * a) (he n hn)), mul_sub]
  rw [Finset.sum_sub_distrib]
  have hs : (∑ n ∈ Icc 1 (2 * N + b),
      ArithmeticFunction.moebius n * (2 * ((N / n : ℕ) : ℤ))) =
      2 * ∑ n ∈ Icc 1 (2 * N + b),
        ArithmeticFunction.moebius n * ((N / n : ℕ) : ℤ) := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl (fun _ _ => by ring)
  rw [hs, floor_mass_extend N (2 * N + b) (by omega),
    BuildingBlocks.MertensTransfer.moebius_floor_mass hN,
    BuildingBlocks.MertensTransfer.moebius_floor_mass (by omega : 0 < 2 * N + b)]
  norm_num

#print axioms quotient_binary_bounds
#print axioms carry_le_one
#print axioms quotient_eq_twice_add_carry
#print axioms response_extend
#print axioms response_binary
#print axioms floor_mass_extend
#print axioms carry_moebius_mass

end BuildingBlocks.FactorialBinaryCarry
