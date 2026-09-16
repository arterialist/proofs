import BuildingBlocks.FactorialResidueFinite
import Mathlib.Data.Nat.Factorization.Basic

/-!
# Euler divisor defect for reweighted residue loading

For arbitrary weights the factorial residue identity has an extra
finite divisor defect. The actual von Mangoldt weights make it vanish
at every integer, which is the arithmetic property lost in positive
prime-supported reweightings.
-/

namespace BuildingBlocks.EulerResidueDefectFinite

open scoped BigOperators ArithmeticFunction

noncomputable def psiWeight (w : ℕ → ℝ) (N : ℕ) : ℝ :=
  ∑ d ∈ Finset.Ioc 0 N, w d

noncomputable def logPrimeWeight (w : ℕ → ℝ) (N : ℕ) : ℝ :=
  ∑ d ∈ Finset.Ioc 0 N, w d / (d : ℝ)

noncomputable def groundWeight (w : ℕ → ℝ) (N : ℕ) : ℝ :=
  Real.log N - logPrimeWeight w N + psiWeight w N / N

noncomputable def residueWeight (w : ℕ → ℝ) (N : ℕ) : ℝ :=
  ∑ d ∈ Finset.Ioc 0 N,
    w d * (1 - Int.fract ((N : ℝ) / d))

/-- Failure of the complete Euler divisor relation at the integer
histories `1,...,N`. -/
noncomputable def eulerDefect (w : ℕ → ℝ) (N : ℕ) : ℝ :=
  ∑ m ∈ Finset.Ioc 0 N,
    (Real.log (m : ℝ) - ∑ d ∈ m.divisors, w d)

private theorem divisor_prefix (w : ℕ → ℝ) (N : ℕ) :
    (∑ m ∈ Finset.Ioc 0 N, ∑ d ∈ m.divisors, w d) =
      ∑ d ∈ Finset.Ioc 0 N, w d * ((N / d : ℕ) : ℝ) := by
  calc
    _ = ∑ m ∈ Finset.Ioc 0 N,
          ∑ d ∈ Finset.Ioc 0 N, if d ∣ m then w d else 0 := by
          apply Finset.sum_congr rfl
          intro m hm
          have hm' : 0 < m ∧ m ≤ N := Finset.mem_Ioc.mp hm
          rw [← Finset.sum_filter]
          congr 1
          ext d
          simp only [Finset.mem_filter, Finset.mem_Ioc, Nat.mem_divisors]
          constructor
          · intro hd
            exact ⟨⟨Nat.pos_of_dvd_of_pos hd.1 hm'.1,
              (Nat.le_of_dvd hm'.1 hd.1).trans hm'.2⟩, hd.1⟩
          · intro hd
            exact ⟨hd.2, hm'.1.ne'⟩
    _ = ∑ d ∈ Finset.Ioc 0 N,
          ∑ m ∈ Finset.Ioc 0 N, if d ∣ m then w d else 0 := by
          rw [Finset.sum_comm]
    _ = ∑ d ∈ Finset.Ioc 0 N, w d * ((N / d : ℕ) : ℝ) := by
          apply Finset.sum_congr rfl
          intro d hd
          rw [← Finset.sum_filter]
          simp [Nat.Ioc_filter_dvd_card_eq_div, nsmul_eq_mul, mul_comm]

private theorem Ioc_zero_eq_Icc_one (N : ℕ) :
    Finset.Ioc 0 N = Finset.Icc 1 N := by
  ext d
  simp only [Finset.mem_Ioc, Finset.mem_Icc]
  omega

/-- The defect is exactly the correction to the weighted factorial
divisor count. -/
theorem defect_eq_factorial_sub_floor (w : ℕ → ℝ) (N : ℕ) :
    eulerDefect w N = Real.log (N.factorial : ℝ) -
      ∑ d ∈ Finset.Ioc 0 N, w d * ((N / d : ℕ) : ℝ) := by
  rw [eulerDefect, Finset.sum_sub_distrib, divisor_prefix]
  rw [← FloorCorrection.logFactorial_eq_log, FloorCorrection.logFactorial,
    ← Ioc_zero_eq_Icc_one]

/-- The arbitrary-weight residue retains the weighted divisor floor,
not automatically `log N!`. -/
theorem residueWeight_eq (w : ℕ → ℝ) (N : ℕ) :
    residueWeight w N = psiWeight w N -
      (N : ℝ) * logPrimeWeight w N +
      ∑ d ∈ Finset.Ioc 0 N, w d * ((N / d : ℕ) : ℝ) := by
  simp only [residueWeight, psiWeight, logPrimeWeight,
    ResidueLoadingSuccessor.fract_quotient]
  rw [Finset.mul_sum, ← Finset.sum_sub_distrib, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro d hd
  ring

/-- The general factorial-residue formula includes the exact Euler
defect. In the actual von Mangoldt case this defect is zero. -/
theorem ground_eq_residue_add_defect (w : ℕ → ℝ) (N : ℕ) (hN : 0 < N) :
    (N : ℝ) * groundWeight w N =
      (N : ℝ) * Real.log N - Real.log (N.factorial : ℝ) +
        residueWeight w N + eulerDefect w N := by
  have hNr : (N : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hN)
  rw [residueWeight_eq, defect_eq_factorial_sub_floor]
  simp only [groundWeight]
  field_simp
  ring

/-- The actual von Mangoldt source has zero Euler divisor defect at
every finite horizon. -/
theorem actual_eulerDefect_zero (N : ℕ) :
    eulerDefect ArithmeticFunction.vonMangoldt N = 0 := by
  unfold eulerDefect
  apply Finset.sum_eq_zero
  intro m hm
  exact sub_eq_zero.mpr ArithmeticFunction.vonMangoldt_sum.symm

end BuildingBlocks.EulerResidueDefectFinite
