import BuildingBlocks.FactorialPairedRenewal

open Finset
namespace BuildingBlocks.FactorialBinaryCarry

/-- Complete floor row of the actual dyadic response difference in its paired-size basis. -/
noncomputable def innovationFloorRow (N j : ℕ) : ℝ :=
  ∑ n ∈ Icc 1 (2 * N), (ArithmeticFunction.moebius n : ℝ) *
    ((((2 * N) / n / j : ℕ) : ℝ) - (((2 * (N / n)) / j : ℕ) : ℝ))

/-- The exact single-entry floor increment retains its divisibility condition. -/
theorem paired_floor_increment (q j : ℕ) :
    (((2 * q + 1) / j : ℕ) : ℝ) - (((2 * q) / j : ℕ) : ℝ) =
      if j ∣ 2 * q + 1 then 1 else 0 := by
  have he : (2 * q + 1) / j = (2 * q) / j + (if j ∣ 2 * q + 1 then 1 else 0) := Nat.succ_div
  rw [he]
  split_ifs <;> simp

/-- All actual odd divisibility loads, including newly admitted quotient histories. -/
theorem innovationFloorRow_eq (N j : ℕ) :
    innovationFloorRow N j = ∑ n ∈ Icc 1 (2 * N), (ArithmeticFunction.moebius n : ℝ) *
      (carry N 0 n : ℝ) * (if j ∣ 2 * (N / n) + 1 then 1 else 0) := by
  unfold innovationFloorRow
  apply Finset.sum_congr rfl
  intro n hn
  have hn0 : 0 < n := (mem_Icc.mp hn).1
  have hc := carry_le_one N 0 n (by omega) hn0
  have hq := quotient_eq_twice_add_carry N 0 n (by omega) hn0
  simp only [add_zero] at hq
  have hcases : carry N 0 n = 0 ∨ carry N 0 n = 1 := by omega
  rw [hq]
  rcases hcases with hzero | hone
  · simp [hzero]
  · rw [hone, paired_floor_increment]
    simp

/-- Every even floor row vanishes for the complete actual dyadic innovation. -/
theorem innovationFloorRow_even (N l : ℕ) : innovationFloorRow N (2 * l) = 0 := by
  rw [innovationFloorRow_eq]
  apply Finset.sum_eq_zero
  intro n hn
  have hnot : ¬ 2 * l ∣ 2 * (N / n) + 1 := by
    intro h
    have h2 : 2 ∣ 2 * (N / n) + 1 := dvd_trans (by simp) h
    have hm := Nat.mod_eq_zero_of_dvd h2
    omega
  simp [hnot]

/-- The full actual first floor row has the exact signed mass minus one. -/
theorem innovationFloorRow_one (N : ℕ) (hN : 0 < N) : innovationFloorRow N 1 = -1 := by
  rw [innovationFloorRow_eq]
  simp only [one_dvd, ite_true, mul_one]
  have hm := carry_moebius_mass N 0 hN (by omega)
  simp only [add_zero] at hm
  exact_mod_cast hm

#print axioms innovationFloorRow_one
#print axioms paired_floor_increment
#print axioms innovationFloorRow_eq
#print axioms innovationFloorRow_even
end BuildingBlocks.FactorialBinaryCarry
