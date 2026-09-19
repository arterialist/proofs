/-
Copyright (c) 2026 Andrew. All rights reserved.
Released under the MIT license as described in the file LICENSE.

Exact arithmetic coefficient in the balanced Möbius-tail hard shell.
Written source: ../../building-blocks/weil-and-spectral/actual-mobius-tail-balanced-hard-shell.md.
This file formalizes only the finite Dirichlet-convolution identities and
prime-power values. It contains no analytic energy estimate.
-/
import Mathlib.NumberTheory.ArithmeticFunction
import Mathlib.Tactic.Ring

namespace BuildingBlocks.ActualMobiusConvolution

open scoped ArithmeticFunction

/-- The exact coefficient left in the balanced hard shell: `μ * μ`. -/
noncomputable def balancedMobiusCoefficient : ArithmeticFunction ℤ :=
  ArithmeticFunction.moebius * ArithmeticFunction.moebius

/-- Expanding `b = μ - a` isolates the irreducible `μ * μ` coefficient. -/
theorem tail_difference (a : ArithmeticFunction ℤ) :
    (ArithmeticFunction.moebius - a) * (ArithmeticFunction.moebius - a) - a * a =
      balancedMobiusCoefficient -
        (a * ArithmeticFunction.moebius + a * ArithmeticFunction.moebius) := by
  simp only [balancedMobiusCoefficient]
  ring

/-- The balanced coefficient is multiplicative. -/
theorem balancedMobiusCoefficient_isMultiplicative :
    balancedMobiusCoefficient.IsMultiplicative := by
  exact ArithmeticFunction.isMultiplicative_moebius.mul
    ArithmeticFunction.isMultiplicative_moebius

/-- A prime-power evaluation reduced to a finite sum over exponents. -/
theorem balancedMobiusCoefficient_prime_pow {p k : ℕ} (hp : p.Prime) :
    balancedMobiusCoefficient (p ^ k) =
      ∑ i ∈ Finset.range (k + 1),
        ArithmeticFunction.moebius (p ^ i) *
          ArithmeticFunction.moebius (p ^ (k - i)) := by
  rw [balancedMobiusCoefficient, ArithmeticFunction.mul_apply,
    Nat.sum_divisorsAntidiagonal
      (fun a b => ArithmeticFunction.moebius a * ArithmeticFunction.moebius b),
    Nat.sum_divisors_prime_pow hp]
  apply Finset.sum_congr rfl
  intro i hi
  rw [Nat.pow_div (Nat.le_of_lt_succ (Finset.mem_range.mp hi)) hp.pos]

/-- The balanced coefficient at a prime is `-2`. -/
theorem balancedMobiusCoefficient_apply_prime {p : ℕ} (hp : p.Prime) :
    balancedMobiusCoefficient p = -2 := by
  rw [show p = p ^ 1 by simp, balancedMobiusCoefficient_prime_pow hp]
  norm_num [Finset.sum_range_succ, ArithmeticFunction.moebius_apply_prime_pow hp]
  rw [ArithmeticFunction.moebius_apply_prime hp]
  norm_num

/-- The balanced coefficient at a prime square is `1`. -/
theorem balancedMobiusCoefficient_apply_prime_sq {p : ℕ} (hp : p.Prime) :
    balancedMobiusCoefficient (p ^ 2) = 1 := by
  rw [balancedMobiusCoefficient_prime_pow hp]
  norm_num [Finset.sum_range_succ, ArithmeticFunction.moebius_apply_prime_pow hp]
  rw [ArithmeticFunction.moebius_apply_prime hp]
  norm_num

/-- The balanced coefficient vanishes on every prime power of exponent at least three. -/
theorem balancedMobiusCoefficient_apply_prime_pow_eq_zero {p k : ℕ}
    (hp : p.Prime) (hk : 3 ≤ k) :
    balancedMobiusCoefficient (p ^ k) = 0 := by
  rw [balancedMobiusCoefficient_prime_pow hp]
  apply Finset.sum_eq_zero
  intro i hi
  have hik : i ≤ k := Nat.le_of_lt_succ (Finset.mem_range.mp hi)
  by_cases hi0 : i = 0
  · subst i
    simp only [Nat.sub_zero, pow_zero, ArithmeticFunction.moebius_apply_one, one_mul]
    rw [ArithmeticFunction.moebius_apply_prime_pow hp (by omega), if_neg (by omega)]
  by_cases hi1 : i = 1
  · subst i
    simp only [pow_one]
    rw [ArithmeticFunction.moebius_apply_prime hp,
      ArithmeticFunction.moebius_apply_prime_pow hp (by omega), if_neg (by omega), mul_zero]
  · rw [ArithmeticFunction.moebius_apply_prime_pow hp (by omega), if_neg hi1, zero_mul]

/-- Convolution with two zeta functions gives the identity arithmetic function.
This is the exact arithmetic-function version of the formal Dirichlet-series
identity `(1 / ζ^2) ζ^2 = 1`; it asserts no analytic continuation. -/
theorem balancedMobiusCoefficient_mul_zeta_sq :
    balancedMobiusCoefficient *
        (ArithmeticFunction.zeta : ArithmeticFunction ℤ) * ArithmeticFunction.zeta = 1 := by
  have h : (ArithmeticFunction.moebius : ArithmeticFunction ℤ) *
      (ArithmeticFunction.zeta : ArithmeticFunction ℤ) = 1 :=
    ArithmeticFunction.coe_moebius_mul_coe_zeta
  calc
    balancedMobiusCoefficient *
          (ArithmeticFunction.zeta : ArithmeticFunction ℤ) * ArithmeticFunction.zeta =
        (ArithmeticFunction.moebius * ArithmeticFunction.zeta) *
          (ArithmeticFunction.moebius * ArithmeticFunction.zeta) := by
            simp only [balancedMobiusCoefficient]
            ring
    _ = 1 := by rw [h]; simp

/-- The cross term cancels only after the complete free-factor convolution:
`(a * μ) * ζ = a`. This does not assert cancellation on a fixed slice. -/
theorem mul_moebius_mul_zeta (a : ArithmeticFunction ℤ) :
    (a * ArithmeticFunction.moebius) *
        (ArithmeticFunction.zeta : ArithmeticFunction ℤ) = a := by
  have h : (ArithmeticFunction.moebius : ArithmeticFunction ℤ) *
      ArithmeticFunction.zeta = 1 :=
    ArithmeticFunction.coe_moebius_mul_coe_zeta
  calc
    (a * ArithmeticFunction.moebius) *
        (ArithmeticFunction.zeta : ArithmeticFunction ℤ) =
      a * (ArithmeticFunction.moebius * ArithmeticFunction.zeta) := by ring
    _ = a * 1 := by rw [h]
    _ = a := by simp

/-- After the global free-factor convolution, the balanced coefficient
recovers the actual Möbius function exactly. -/
theorem balancedMobiusCoefficient_mul_zeta :
    balancedMobiusCoefficient *
        (ArithmeticFunction.zeta : ArithmeticFunction ℤ) =
      ArithmeticFunction.moebius := by
  unfold balancedMobiusCoefficient
  exact mul_moebius_mul_zeta ArithmeticFunction.moebius

/-- The long squarefree coefficient in the pruned shell. Pointwise this is
`μ(n)` times the divisor count; nonsquarefree inputs vanish automatically. -/
noncomputable def squarefreeCoreCoefficient : ArithmeticFunction ℤ :=
  (ArithmeticFunction.moebius : ArithmeticFunction ℤ).pmul
    (ArithmeticFunction.sigma 0 : ArithmeticFunction ℤ)

theorem squarefreeCoreCoefficient_apply (n : ℕ) :
    squarefreeCoreCoefficient n =
      ArithmeticFunction.moebius n * (n.divisors.card : ℤ) := by
  simp [squarefreeCoreCoefficient, ArithmeticFunction.pmul_apply,
    ArithmeticFunction.sigma_zero_apply]

theorem squarefreeCoreCoefficient_isMultiplicative :
    squarefreeCoreCoefficient.IsMultiplicative := by
  exact ArithmeticFunction.isMultiplicative_moebius.pmul
    ArithmeticFunction.isMultiplicative_sigma.natCast

/-- The correction coefficient that exposes an unweighted convolution
factor in the squarefree core. -/
noncomputable def typeICorrection : ArithmeticFunction ℤ :=
  ArithmeticFunction.moebius * squarefreeCoreCoefficient

/-- Exact one-factor decomposition used by the truncated Type-I argument. -/
theorem squarefreeCoreCoefficient_eq_zeta_mul_typeICorrection :
    squarefreeCoreCoefficient =
      (ArithmeticFunction.zeta : ArithmeticFunction ℤ) * typeICorrection := by
  have hzmu : (ArithmeticFunction.zeta : ArithmeticFunction ℤ) *
      ArithmeticFunction.moebius = 1 := by
    rw [mul_comm]
    exact ArithmeticFunction.coe_moebius_mul_coe_zeta
  symm
  calc
    (ArithmeticFunction.zeta : ArithmeticFunction ℤ) * typeICorrection =
        (ArithmeticFunction.zeta * ArithmeticFunction.moebius) *
          squarefreeCoreCoefficient := by
            simp only [typeICorrection]
            ring
    _ = squarefreeCoreCoefficient := by rw [hzmu]; simp

theorem squarefreeCoreCoefficient_apply_one :
    squarefreeCoreCoefficient 1 = 1 := by
  simp [squarefreeCoreCoefficient, ArithmeticFunction.pmul_apply]

theorem squarefreeCoreCoefficient_apply_prime {p : ℕ} (hp : p.Prime) :
    squarefreeCoreCoefficient p = -2 := by
  have ht : (ArithmeticFunction.sigma 0) p = 2 := by
    rw [show p = p ^ 1 by simp,
      ArithmeticFunction.sigma_zero_apply_prime_pow hp]
  simp [squarefreeCoreCoefficient, ArithmeticFunction.pmul_apply,
    ArithmeticFunction.moebius_apply_prime hp, ht]

theorem squarefreeCoreCoefficient_apply_prime_pow_eq_zero {p k : ℕ}
    (hp : p.Prime) (hk : 2 ≤ k) :
    squarefreeCoreCoefficient (p ^ k) = 0 := by
  have hmu : ArithmeticFunction.moebius (p ^ k) = 0 := by
    rw [ArithmeticFunction.moebius_apply_prime_pow hp (by omega),
      if_neg (by omega)]
  simp [squarefreeCoreCoefficient, ArithmeticFunction.pmul_apply, hmu]

theorem typeICorrection_isMultiplicative :
    typeICorrection.IsMultiplicative := by
  exact ArithmeticFunction.isMultiplicative_moebius.mul
    squarefreeCoreCoefficient_isMultiplicative

theorem typeICorrection_prime_pow {p k : ℕ} (hp : p.Prime) :
    typeICorrection (p ^ k) =
      ∑ i ∈ Finset.range (k + 1),
        ArithmeticFunction.moebius (p ^ i) *
          squarefreeCoreCoefficient (p ^ (k - i)) := by
  rw [typeICorrection, ArithmeticFunction.mul_apply,
    Nat.sum_divisorsAntidiagonal
      (fun a b => ArithmeticFunction.moebius a * squarefreeCoreCoefficient b),
    Nat.sum_divisors_prime_pow hp]
  apply Finset.sum_congr rfl
  intro i hi
  rw [Nat.pow_div (Nat.le_of_lt_succ (Finset.mem_range.mp hi)) hp.pos]

theorem typeICorrection_apply_prime {p : ℕ} (hp : p.Prime) :
    typeICorrection p = -3 := by
  rw [show p = p ^ 1 by simp, typeICorrection_prime_pow hp]
  norm_num [Finset.sum_range_succ, squarefreeCoreCoefficient_apply_one,
    squarefreeCoreCoefficient_apply_prime hp,
    ArithmeticFunction.moebius_apply_prime hp]

theorem typeICorrection_apply_prime_sq {p : ℕ} (hp : p.Prime) :
    typeICorrection (p ^ 2) = 2 := by
  rw [typeICorrection_prime_pow hp]
  norm_num [Finset.sum_range_succ, squarefreeCoreCoefficient_apply_one,
    squarefreeCoreCoefficient_apply_prime hp,
    squarefreeCoreCoefficient_apply_prime_pow_eq_zero hp,
    ArithmeticFunction.moebius_apply_prime hp,
    ArithmeticFunction.moebius_apply_prime_pow hp]

theorem typeICorrection_apply_prime_pow_eq_zero {p k : ℕ}
    (hp : p.Prime) (hk : 3 ≤ k) :
    typeICorrection (p ^ k) = 0 := by
  rw [typeICorrection_prime_pow hp]
  apply Finset.sum_eq_zero
  intro i hi
  have hik : i ≤ k := Nat.le_of_lt_succ (Finset.mem_range.mp hi)
  by_cases hi0 : i = 0
  · subst i
    simp only [Nat.sub_zero, pow_zero, ArithmeticFunction.moebius_apply_one, one_mul]
    rw [squarefreeCoreCoefficient_apply_prime_pow_eq_zero hp (by omega)]
  by_cases hi1 : i = 1
  · subst i
    simp only [pow_one]
    rw [ArithmeticFunction.moebius_apply_prime hp,
      squarefreeCoreCoefficient_apply_prime_pow_eq_zero hp (by omega), mul_zero]
  · rw [ArithmeticFunction.moebius_apply_prime_pow hp (by omega), if_neg hi1, zero_mul]

end BuildingBlocks.ActualMobiusConvolution
