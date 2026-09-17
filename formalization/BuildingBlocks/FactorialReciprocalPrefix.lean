import BuildingBlocks.FactorialCompensatedEnvelope

open Finset
namespace BuildingBlocks.FactorialReciprocalPrefix

noncomputable def reciprocal (N : ℕ) : ℝ :=
  ∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℝ) / n

noncomputable def floorError (N n : ℕ) : ℝ := (N : ℝ) / n - ((N / n : ℕ) : ℝ)

/-- Literal division rounding error, with the positive divisor domain explicit. -/
theorem floor_error_bounds (N n : ℕ) (hn : 0 < n) :
    0 ≤ floorError N n ∧ floorError N n < 1 := by
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  constructor
  · exact sub_nonneg.mpr Nat.cast_div_le
  · have h := Nat.lt_mul_div_succ N hn
    have hl : (N : ℝ) < (n : ℝ) * (((N / n : ℕ) : ℝ) + 1) := by exact_mod_cast h
    unfold floorError
    have hd := (div_lt_iff₀ hnR).mpr (by nlinarith : (N : ℝ) <
      (((N / n : ℕ) : ℝ) + 1) * n)
    linarith

/-- Exact full floor mass identifies every signed reciprocal prefix. -/
theorem reciprocal_floor_identity (N : ℕ) (hN : 0 < N) :
    (N : ℝ) * reciprocal N = 1 +
      ∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℝ) * floorError N n := by
  have hm := congrArg (fun z : ℤ => (z : ℝ)) (MertensTransfer.moebius_floor_mass hN)
  simp only [Int.cast_sum, Int.cast_mul, Int.cast_natCast, Int.cast_one] at hm
  calc
    _ = ∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
        (((N / n : ℕ) : ℝ) + floorError N n) := by
      unfold reciprocal floorError
      rw [mul_sum]
      apply sum_congr rfl
      intro n hn
      rw [div_eq_mul_inv, div_eq_mul_inv]
      ring
    _ = _ := by simp_rw [mul_add]; rw [sum_add_distrib, hm]

/-- The terminal unit divisor has zero phase; only N-1 phase rows need payment. -/
theorem floor_phase_sum_bound (N : ℕ) (hN : 0 < N) :
    |∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℝ) * floorError N n| ≤ (N : ℝ) - 1 := by
  have h1 : 1 ∈ Icc 1 N := mem_Icc.mpr ⟨le_rfl, hN⟩
  rw [← sum_erase_add (Icc 1 N) _ h1]
  simp only [floorError, Nat.div_one, Nat.cast_one, div_one, sub_self, mul_zero, add_zero]
  apply (abs_sum_le_sum_abs _ _).trans
  calc
    _ ≤ ∑ n ∈ (Icc 1 N).erase 1, (1 : ℝ) := by
      apply sum_le_sum
      intro n hn
      have hnI := (mem_erase.mp hn).2
      have hne := (mem_erase.mp hn).1
      have he := floor_error_bounds N n (mem_Icc.mp hnI).1
      have hm : |(ArithmeticFunction.moebius n : ℝ)| ≤ 1 := by
        exact_mod_cast (ArithmeticFunction.abs_moebius_le_one (n := n))
      change |(ArithmeticFunction.moebius n : ℝ) * floorError N n| ≤ 1
      rw [abs_mul, abs_of_nonneg he.1]
      nlinarith [abs_nonneg (ArithmeticFunction.moebius n : ℝ)]
    _ = _ := by
      simp only [sum_const, nsmul_eq_mul, mul_one, card_erase_of_mem h1, Nat.card_Icc]
      have hn : 1 ≤ N := hN
      norm_num
      rw [Nat.cast_sub hn]
      simp

/-- Classical elementary signed reciprocal-prefix bound, without any decay assumption. -/
theorem reciprocal_abs_le_one (N : ℕ) : |reciprocal N| ≤ 1 := by
  rcases Nat.eq_zero_or_pos N with rfl | hN
  · simp [reciprocal]
  · have he := reciprocal_floor_identity N hN
    have hp := floor_phase_sum_bound N hN
    have ha : |(N : ℝ) * reciprocal N| ≤ (N : ℝ) := by
      rw [he]
      apply (abs_add_le _ _).trans
      norm_num
      linarith
    rw [abs_mul, abs_of_nonneg (Nat.cast_nonneg N)] at ha
    have hnR : (0 : ℝ) < N := by exact_mod_cast hN
    nlinarith

end BuildingBlocks.FactorialReciprocalPrefix
#print axioms BuildingBlocks.FactorialReciprocalPrefix.floor_error_bounds
#print axioms BuildingBlocks.FactorialReciprocalPrefix.reciprocal_floor_identity
#print axioms BuildingBlocks.FactorialReciprocalPrefix.floor_phase_sum_bound
#print axioms BuildingBlocks.FactorialReciprocalPrefix.reciprocal_abs_le_one
