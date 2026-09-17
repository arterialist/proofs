import BuildingBlocks.FactorialQuotientConstraints

open Finset
namespace BuildingBlocks.FactorialDyadicPhase

/-- Literal centered discrete remainder, with total division at n=0. -/
noncomputable def phase (n N : ℕ) : ℝ :=
  (N % n : ℕ) / (n : ℝ) - ((n : ℝ) - 1) / (2 * n)

noncomputable def inverseMass (Y : ℕ) : ℝ :=
  ∑ n ∈ Icc 1 Y, (ArithmeticFunction.moebius n : ℝ) / n

noncomputable def totalMass (Y : ℕ) : ℝ :=
  ∑ n ∈ Icc 1 Y, (ArithmeticFunction.moebius n : ℝ)

theorem phase_quotient (n N : ℕ) (hn : 0 < n) :
    phase n N = (N : ℝ) / n - (N / n : ℕ) - ((n : ℝ) - 1) / (2 * n) := by
  have he := congrArg (fun a : ℕ => (a : ℝ)) (Nat.mod_add_div N n)
  push_cast at he
  have hnR : (n : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hn)
  unfold phase
  field_simp
  nlinarith

/-- Every unused history n>N remains in the fixed carrier through Y. -/
theorem coherent_phase_affine (N Y : ℕ) (hN : 0 < N) (hNY : N ≤ Y) :
    (∑ n ∈ Icc 1 Y, (ArithmeticFunction.moebius n : ℝ) * phase n N) =
      ((N : ℝ) + 1 / 2) * inverseMass Y - totalMass Y / 2 - 1 := by
  have hm := BuildingBlocks.FactorialBinaryCarry.floor_mass_extend N Y hNY
  rw [BuildingBlocks.MertensTransfer.moebius_floor_mass hN] at hm
  have hmR : (∑ n ∈ Icc 1 Y, (ArithmeticFunction.moebius n : ℝ) * (N / n : ℕ)) = 1 := by
    have hc := congrArg (fun z : ℤ => (z : ℝ)) hm
    simpa only [Int.cast_sum, Int.cast_mul, Int.cast_natCast, Int.cast_one] using hc
  have he : ∀ n ∈ Icc 1 Y, (ArithmeticFunction.moebius n : ℝ) * phase n N =
      ((N : ℝ) + 1 / 2) * ((ArithmeticFunction.moebius n : ℝ) / n) -
      (ArithmeticFunction.moebius n : ℝ) / 2 -
      (ArithmeticFunction.moebius n : ℝ) * (N / n : ℕ) := by
    intro n hn
    rw [phase_quotient n N (mem_Icc.mp hn).1]
    have hnR : (n : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt (mem_Icc.mp hn).1)
    field_simp
    ring
  rw [sum_congr rfl he]
  simp only [sum_sub_distrib, ← mul_sum, sum_div, hmR, inverseMass, totalMass]

#print axioms phase_quotient
#print axioms coherent_phase_affine
end BuildingBlocks.FactorialDyadicPhase
