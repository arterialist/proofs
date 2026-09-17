import BuildingBlocks.CoarsePrimeBounds

open Finset
open scoped BigOperators ArithmeticFunction

namespace BuildingBlocks

open CoarsePrimitive HyperbolaProduct

/-- Multiplication by log n is a derivation for Dirichlet convolution. -/
theorem log_weighted_convolution (f g : ArithmeticFunction ℝ) :
    (f * g).pmul ArithmeticFunction.log =
      f.pmul ArithmeticFunction.log * g + f * g.pmul ArithmeticFunction.log := by
  ext n
  simp only [ArithmeticFunction.pmul_apply, ArithmeticFunction.mul_apply,
    ArithmeticFunction.add_apply, ArithmeticFunction.log_apply,
    Finset.sum_mul, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro d hd
  obtain ⟨hprod, hn⟩ := Nat.mem_divisorsAntidiagonal.mp hd
  have h1 : d.1 ≠ 0 := by intro hz; simp [hz] at hprod; exact hn hprod.symm
  have h2 : d.2 ≠ 0 := by intro hz; simp [hz] at hprod; exact hn hprod.symm
  rw [← hprod, Nat.cast_mul, Real.log_mul (by exact_mod_cast h1) (by exact_mod_cast h2)]
  ring

/-- The second generalized von Mangoldt weight. Its multiplication is
Dirichlet convolution; it is not the ordered correlation from PrimeEnergy. -/
noncomputable def selbergWeight : ArithmeticFunction ℝ :=
  ArithmeticFunction.vonMangoldt.pmul ArithmeticFunction.log +
    ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt

theorem selbergWeight_eq_moebius_logSquare :
    selbergWeight = (ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
      ArithmeticFunction.log.pmul ArithmeticFunction.log := by
  have hd := log_weighted_convolution ArithmeticFunction.vonMangoldt
    (ArithmeticFunction.zeta : ArithmeticFunction ℝ)
  simp only [ArithmeticFunction.vonMangoldt_mul_zeta, ArithmeticFunction.zeta_pmul] at hd
  rw [hd, mul_add, ← mul_assoc,
    mul_comm (ArithmeticFunction.moebius : ArithmeticFunction ℝ)
      (ArithmeticFunction.vonMangoldt.pmul ArithmeticFunction.log),
    mul_assoc, ArithmeticFunction.coe_moebius_mul_coe_zeta, mul_one, ← mul_assoc,
    mul_comm (ArithmeticFunction.moebius : ArithmeticFunction ℝ) ArithmeticFunction.vonMangoldt,
    mul_assoc, ArithmeticFunction.moebius_mul_log_eq_vonMangoldt]
  rfl

theorem selbergWeight_apply (n : ℕ) :
    selbergWeight n = ArithmeticFunction.vonMangoldt n * Real.log n +
      ∑ d ∈ n.divisors, ArithmeticFunction.vonMangoldt d * ArithmeticFunction.vonMangoldt (n / d) := by
  simp only [selbergWeight, ArithmeticFunction.add_apply, ArithmeticFunction.pmul_apply,
    ArithmeticFunction.log_apply, ArithmeticFunction.mul_apply]
  congr 1
  exact Nat.sum_divisorsAntidiagonal
    (fun a b => ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b)

theorem selbergWeight_nonneg (n : ℕ) : 0 ≤ selbergWeight n := by
  rw [selbergWeight_apply]
  apply add_nonneg
  · exact mul_nonneg ArithmeticFunction.vonMangoldt_nonneg
      (ArithmeticFunction.vonMangoldt_nonneg.trans ArithmeticFunction.vonMangoldt_le_log)
  · exact Finset.sum_nonneg (fun _ _ => mul_nonneg ArithmeticFunction.vonMangoldt_nonneg
      ArithmeticFunction.vonMangoldt_nonneg)

theorem selbergWeight_moebius_formula (n : ℕ) :
    selbergWeight n = ∑ d ∈ n.divisors,
      (ArithmeticFunction.moebius d : ℝ) * Real.log (n / d : ℕ) ^ 2 := by
  rw [selbergWeight_eq_moebius_logSquare, ArithmeticFunction.mul_apply]
  rw [Nat.sum_divisorsAntidiagonal
    (fun a b => (ArithmeticFunction.moebius : ArithmeticFunction ℝ) a *
      ArithmeticFunction.log.pmul ArithmeticFunction.log b)]
  simp only [ArithmeticFunction.intCoe_apply, ArithmeticFunction.pmul_apply,
    ArithmeticFunction.log_apply, pow_two]

theorem selbergWeight_summatory (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, selbergWeight n) =
      (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n * Real.log n) +
        ∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n * psi (N / n) := by
  simp only [selbergWeight_apply, Finset.sum_add_distrib]
  congr 1
  rw [sum_divisors_eq_sum_factor_pairs N
    (fun d k => ArithmeticFunction.vonMangoldt d * ArithmeticFunction.vonMangoldt k)]
  simp only [← Finset.mul_sum, ← psi_eq_sum_Icc]

/-- Exact finite identity underlying the Selberg symmetry formula.
It contains no error-term estimate. -/
theorem selberg_exact_identity (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n * Real.log n) +
      (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n * psi (N / n)) =
        ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
          ∑ k ∈ Finset.Icc 1 (N / d), Real.log k ^ 2 := by
  rw [← selbergWeight_summatory]
  simp_rw [selbergWeight_moebius_formula]
  rw [sum_divisors_eq_sum_factor_pairs N
    (fun d k => (ArithmeticFunction.moebius d : ℝ) * Real.log k ^ 2)]
  simp only [← Finset.mul_sum]


end BuildingBlocks
