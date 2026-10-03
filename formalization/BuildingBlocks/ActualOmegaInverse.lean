import BuildingBlocks.HyperbolaProduct
import Mathlib.Algebra.Order.Floor.Semifield
import Mathlib.Data.Finset.Card
import Mathlib.Tactic

/-!
The actual Dirichlet inverse of omega plus the positive-integer constant-one function.
The inverse equation, prime and prime-square coefficients, literal prime indicator,
and complete cofactor identities are proved without a supplied inverse premise.
The factorial weighted bounds, infinite series and auxiliary poles remain written
analysis, separately documented; this file proves no new RH estimate.
-/

open Finset
open scoped BigOperators

namespace BuildingBlocks.ActualOmegaInverse

def primeIndicator : ArithmeticFunction ℤ :=
  ⟨fun n => if n.Prime then 1 else 0, by norm_num⟩

@[simp] theorem primeIndicator_apply (n : ℕ) :
    primeIndicator n = if n.Prime then 1 else 0 := rfl

@[simp] theorem primeIndicator_one : primeIndicator 1 = 0 := by norm_num [primeIndicator]

@[simp] theorem primeIndicator_apply_prime {p : ℕ} (hp : p.Prime) :
    primeIndicator p = 1 := by simp [hp]

/-- Mathlib's zeta is the positive-integer constant-one function, rather than
the Dirichlet-convolution unit. -/
def omegaPlusOne : ArithmeticFunction ℤ :=
  (ArithmeticFunction.cardDistinctFactors : ArithmeticFunction ℤ) +
    (ArithmeticFunction.zeta : ArithmeticFunction ℤ)

@[simp] theorem omegaPlusOne_one : omegaPlusOne 1 = 1 := by
  simp [omegaPlusOne, ArithmeticFunction.zeta_apply]

theorem omegaPlusOne_apply_prime {p : ℕ} (hp : p.Prime) :
    omegaPlusOne p = 2 := by
  simp [omegaPlusOne, ArithmeticFunction.cardDistinctFactors_apply_prime hp,
    ArithmeticFunction.zeta_apply_ne hp.ne_zero]

theorem omegaPlusOne_apply_prime_pow {p k : ℕ} (hp : p.Prime) (hk : k ≠ 0) :
    omegaPlusOne (p ^ k) = 2 := by
  simp [omegaPlusOne, ArithmeticFunction.cardDistinctFactors_apply_prime_pow hp hk,
    ArithmeticFunction.zeta_apply_ne (pow_ne_zero _ hp.ne_zero)]

private noncomputable def inverseStep (n : ℕ) (rec : ∀ m : ℕ, m < n → ℤ) : ℤ :=
  if n = 0 then 0 else if n = 1 then 1 else
    -(∑ d : n.properDivisors,
      rec d.val (Nat.mem_properDivisors.mp d.property).2 * omegaPlusOne (n / d.val))

noncomputable def inverseValue (n : ℕ) : ℤ :=
  Nat.lt_wfRel.wf.fix inverseStep n

theorem inverseValue_eq (n : ℕ) :
    inverseValue n = if n = 0 then 0 else if n = 1 then 1 else
      -(∑ d ∈ n.properDivisors, inverseValue d * omegaPlusOne (n / d)) := by
  have h := WellFounded.fix_eq Nat.lt_wfRel.wf inverseStep n
  change inverseValue n = inverseStep n (fun m _ => inverseValue m) at h
  simp only [inverseStep] at h
  have hs : (∑ d : n.properDivisors, inverseValue d.val * omegaPlusOne (n / d.val)) =
      ∑ d ∈ n.properDivisors, inverseValue d * omegaPlusOne (n / d) :=
    Finset.sum_coe_sort n.properDivisors
      (fun d : ℕ => inverseValue d * omegaPlusOne (n / d))
  simpa only [hs] using h

@[simp] theorem inverseValue_zero : inverseValue 0 = 0 := by
  rw [inverseValue_eq]; simp

@[simp] theorem inverseValue_one : inverseValue 1 = 1 := by
  rw [inverseValue_eq]; simp

noncomputable def actualInverse : ArithmeticFunction ℤ :=
  ⟨inverseValue, inverseValue_zero⟩

@[simp] theorem actualInverse_apply (n : ℕ) : actualInverse n = inverseValue n := rfl

@[simp] theorem actualInverse_one : actualInverse 1 = 1 := by simp

theorem actualInverse_recurrence {n : ℕ} (hn : 1 < n) :
    actualInverse n =
      -(∑ d ∈ n.properDivisors, actualInverse d * omegaPlusOne (n / d)) := by
  have hn0 : n ≠ 0 := by omega
  have hn1 : n ≠ 1 := by omega
  simpa only [actualInverse_apply, if_neg hn0, if_neg hn1] using inverseValue_eq n

theorem actualInverse_mul_omegaPlusOne : actualInverse * omegaPlusOne = 1 := by
  ext n
  by_cases hn0 : n = 0
  · subst n; simp
  by_cases hn1 : n = 1
  · subst n
    rw [ArithmeticFunction.mul_apply_one]
    simp
  have hn : 1 < n := by omega
  rw [ArithmeticFunction.mul_apply,
    Nat.sum_divisorsAntidiagonal (fun d q => actualInverse d * omegaPlusOne q),
    ← Nat.cons_self_properDivisors hn0, Finset.sum_cons,
    Nat.div_self (Nat.pos_of_ne_zero hn0), omegaPlusOne_one, mul_one,
    actualInverse_recurrence hn, ArithmeticFunction.one_apply, if_neg hn1]
  ring

theorem omegaPlusOne_mul_actualInverse : omegaPlusOne * actualInverse = 1 := by
  rw [mul_comm, actualInverse_mul_omegaPlusOne]

theorem actualInverse_unique (h : ArithmeticFunction ℤ)
    (hh : h * omegaPlusOne = 1) : h = actualInverse := by
  calc
    h = h * (omegaPlusOne * actualInverse) := by rw [omegaPlusOne_mul_actualInverse]; simp
    _ = (h * omegaPlusOne) * actualInverse := by rw [mul_assoc]
    _ = actualInverse := by rw [hh]; simp

theorem actualInverse_apply_prime {p : ℕ} (hp : p.Prime) :
    actualInverse p = -2 := by
  rw [actualInverse_recurrence hp.one_lt, hp.properDivisors]
  simp [omegaPlusOne_apply_prime hp]

theorem actualInverse_apply_prime_sq {p : ℕ} (hp : p.Prime) :
    actualInverse (p ^ 2) = 2 := by
  have hsq : 1 < p ^ 2 := by nlinarith [hp.two_le]
  rw [actualInverse_recurrence hsq, Nat.properDivisors_prime_pow hp 2,
    Finset.sum_map]
  simp only [Function.Embedding.coeFn_mk, Finset.sum_range_succ, Finset.sum_range_zero,
    pow_zero, pow_one, Nat.div_one, zero_add, actualInverse_one]
  have hdiv : p ^ 2 / p = p := by
    simpa using Nat.pow_div (by decide : 1 ≤ 2) hp.pos
  rw [hdiv, actualInverse_apply_prime hp, omegaPlusOne_apply_prime hp,
    omegaPlusOne_apply_prime_pow hp (by decide : 2 ≠ 0)]
  norm_num

theorem omega_eq_zeta_mul_primeIndicator :
    (ArithmeticFunction.cardDistinctFactors : ArithmeticFunction ℤ) =
      (ArithmeticFunction.zeta : ArithmeticFunction ℤ) * primeIndicator := by
  ext n
  rw [ArithmeticFunction.coe_zeta_mul_apply]
  simp only [primeIndicator_apply]
  rw [← Finset.sum_filter]
  simp only [Finset.sum_const, nsmul_eq_mul, mul_one]
  rw [← Nat.primeFactors_eq_to_filter_divisors_prime]
  simp only [ArithmeticFunction.natCoe_apply, ArithmeticFunction.cardDistinctFactors_apply,
    ← Nat.toFinset_factors, List.card_toFinset]

theorem omegaPlusOne_eq_zeta_mul_unit_add_primeIndicator :
    omegaPlusOne = (ArithmeticFunction.zeta : ArithmeticFunction ℤ) *
      (1 + primeIndicator) := by
  rw [omegaPlusOne, omega_eq_zeta_mul_primeIndicator]
  ring

theorem actualInverse_mul_unit_add_primeIndicator :
    actualInverse * (1 + primeIndicator) = ArithmeticFunction.moebius := by
  have hz : (ArithmeticFunction.zeta : ArithmeticFunction ℤ) *
      ArithmeticFunction.moebius = 1 := by
    rw [mul_comm]
    exact ArithmeticFunction.coe_moebius_mul_coe_zeta
  calc
    actualInverse * (1 + primeIndicator) =
        actualInverse * omegaPlusOne * ArithmeticFunction.moebius := by
          rw [omegaPlusOne_eq_zeta_mul_unit_add_primeIndicator]
          calc
            actualInverse * (1 + primeIndicator) =
                actualInverse * (1 + primeIndicator) *
                  (ArithmeticFunction.zeta * ArithmeticFunction.moebius) := by rw [hz]; simp
            _ = _ := by ring
    _ = ArithmeticFunction.moebius := by rw [actualInverse_mul_omegaPlusOne]; simp

noncomputable def inverseSummatory (N : ℕ) : ℤ :=
  ∑ n ∈ Finset.Icc 1 N, actualInverse n

noncomputable def mertens (N : ℕ) : ℤ :=
  ∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.moebius n

def primesUpTo (N : ℕ) : Finset ℕ := (Finset.Icc 1 N).filter Nat.Prime

@[simp] theorem inverseSummatory_zero : inverseSummatory 0 = 0 := by
  simp [inverseSummatory]

@[simp] theorem inverseSummatory_one : inverseSummatory 1 = 1 := by
  simp [inverseSummatory]

@[simp] theorem mertens_zero : mertens 0 = 0 := by simp [mertens]

theorem mertens_eq_inverseSummatory_add_primeCofactors (N : ℕ) :
    mertens N = inverseSummatory N +
      ∑ p ∈ primesUpTo N, inverseSummatory (N / p) := by
  have hcoeff := actualInverse_mul_unit_add_primeIndicator
  have hsum : (∑ n ∈ Finset.Icc 1 N,
      (actualInverse * primeIndicator) n) =
      ∑ p ∈ primesUpTo N, inverseSummatory (N / p) := by
    simp only [ArithmeticFunction.mul_apply]
    simp_rw [Nat.sum_divisorsAntidiagonal'
      (fun d q => actualInverse d * primeIndicator q)]
    rw [BuildingBlocks.HyperbolaProduct.sum_divisors_eq_sum_factor_pairs N
      (fun p d => actualInverse d * primeIndicator p)]
    simp_rw [← Finset.sum_mul]
    simp only [primeIndicator_apply, mul_ite, mul_one, mul_zero]
    rw [← Finset.sum_filter]
    rfl
  calc
    mertens N = ∑ n ∈ Finset.Icc 1 N,
        (actualInverse + actualInverse * primeIndicator) n := by
          simp only [mertens]
          rw [← hcoeff, mul_add, mul_one]
    _ = inverseSummatory N +
        ∑ n ∈ Finset.Icc 1 N, (actualInverse * primeIndicator) n := by
          simp only [ArithmeticFunction.add_apply, Finset.sum_add_distrib, inverseSummatory]
    _ = _ := by rw [hsum]

noncomputable def G (x : ℝ) : ℤ := inverseSummatory ⌊x⌋₊

noncomputable def M (x : ℝ) : ℤ := mertens ⌊x⌋₊

theorem G_div_natCast (x : ℝ) (p : ℕ) :
    G (x / (p : ℝ)) = inverseSummatory (⌊x⌋₊ / p) := by
  rw [G, Nat.floor_div_natCast]

theorem M_eq_G_add_primeCofactors (x : ℝ) :
    M x = G x + ∑ p ∈ primesUpTo ⌊x⌋₊, G (x / (p : ℝ)) := by
  change mertens ⌊x⌋₊ = inverseSummatory ⌊x⌋₊ +
    ∑ p ∈ primesUpTo ⌊x⌋₊, G (x / (p : ℝ))
  simp_rw [G_div_natCast]
  exact mertens_eq_inverseSummatory_add_primeCofactors ⌊x⌋₊

theorem G_eq_zero_of_lt_one {x : ℝ} (hx : x < 1) : G x = 0 := by
  rw [G, Nat.floor_eq_zero.mpr hx]
  exact inverseSummatory_zero

theorem M_eq_zero_of_lt_one {x : ℝ} (hx : x < 1) : M x = 0 := by
  rw [M, Nat.floor_eq_zero.mpr hx]
  exact mertens_zero

end BuildingBlocks.ActualOmegaInverse
