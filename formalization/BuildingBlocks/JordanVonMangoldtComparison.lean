/- Uniform actual real-order Jordan/von Mangoldt comparisons.

The coefficients, all real cutoffs and the literal prime-error integral are
proved here. These declarations do not bound the centered terminal itself
or establish the coarse-energy RH premise.
-/

import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import BuildingBlocks.PrimePrimitiveFormula

open Finset Nat Real
open scoped BigOperators ArithmeticFunction
open scoped Interval

namespace BuildingBlocks.JordanVonMangoldtComparison

/-- Literal actual Möbius-rpow coefficients, including the unit. -/
noncomputable def jordan (a : ℝ) (n : ℕ) : ℝ :=
  ∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
    ((n / d : ℕ) : ℝ) ^ a

noncomputable def powerAF (a : ℝ) : ArithmeticFunction ℝ :=
  ⟨fun n => if n = 0 then 0 else (n : ℝ) ^ a, by simp⟩

noncomputable def jordanAF (a : ℝ) : ArithmeticFunction ℝ :=
  (ArithmeticFunction.moebius : ArithmeticFunction ℝ) * powerAF a

theorem powerAF_one (a : ℝ) : powerAF a 1 = 1 := by
  simp [powerAF]

theorem powerAF_apply (a : ℝ) {n : ℕ} (hn : n ≠ 0) :
    powerAF a n = (n : ℝ) ^ a := by
  simp [powerAF, hn]

theorem powerAF_multiplicative (a : ℝ) : (powerAF a).IsMultiplicative := by
  rw [ArithmeticFunction.IsMultiplicative.iff_ne_zero]
  refine ⟨powerAF_one a, ?_⟩
  intro m n hm hn _
  simp only [powerAF_apply a hm, powerAF_apply a hn,
    powerAF_apply a (mul_ne_zero hm hn), Nat.cast_mul]
  exact Real.mul_rpow (Nat.cast_nonneg m) (Nat.cast_nonneg n)

theorem jordanAF_multiplicative (a : ℝ) : (jordanAF a).IsMultiplicative :=
  ArithmeticFunction.isMultiplicative_moebius.intCast.mul (powerAF_multiplicative a)

theorem jordan_eq_AF (a : ℝ) (n : ℕ) : jordan a n = jordanAF a n := by
  rw [jordanAF, ArithmeticFunction.mul_apply]
  change jordan a n = ∑ x ∈ n.divisorsAntidiagonal,
    (ArithmeticFunction.moebius x.1 : ℝ) * powerAF a x.2
  rw [Nat.sum_divisorsAntidiagonal
    (fun i j => (ArithmeticFunction.moebius i : ℝ) * powerAF a j)]
  unfold jordan
  apply Finset.sum_congr rfl
  intro d hd
  have hn : n ≠ 0 := (Nat.mem_divisors.mp hd).2
  have hdvd : d ∣ n := (Nat.mem_divisors.mp hd).1
  have hquot : n / d ≠ 0 := Nat.ne_of_gt (Nat.div_pos (Nat.le_of_dvd (Nat.pos_of_ne_zero hn) hdvd)
    (Nat.pos_of_mem_divisors hd))
  simp [powerAF_apply a hquot]

theorem jordan_one (a : ℝ) : jordan a 1 = 1 := by simp [jordan]

theorem jordan_zero (a : ℝ) : jordan a 0 = 0 := by simp [jordan]

theorem jordan_mul {a : ℝ} {m n : ℕ} (h : m.Coprime n) :
    jordan a (m * n) = jordan a m * jordan a n := by
  simp_rw [jordan_eq_AF]
  exact (jordanAF_multiplicative a).map_mul_of_coprime h

theorem jordan_prime_pow_succ (a : ℝ) {p : ℕ} (hp : p.Prime) (k : ℕ) :
    jordan a (p ^ (k + 1)) = ((p ^ (k + 1) : ℕ) : ℝ) ^ a -
      ((p ^ k : ℕ) : ℝ) ^ a := by
  rw [jordan, Nat.sum_divisors_prime_pow hp, Finset.sum_range_succ']
  simp only [Nat.pow_zero, ArithmeticFunction.moebius_apply_one, Int.cast_one,
    one_mul, Nat.div_one]
  simp_rw [ArithmeticFunction.moebius_apply_prime_pow hp (Nat.succ_ne_zero _)]
  simp only [Nat.succ_eq_add_one, Nat.add_eq_right, Int.cast_ite,
    Int.cast_neg, Int.cast_one, Int.cast_zero, ite_mul, zero_mul]
  rw [Finset.sum_ite_eq']
  simp [Nat.pow_succ, Nat.mul_div_cancel _ hp.pos, Nat.cast_pow]
  ring

theorem exp_sub_one_le_mul {t : ℝ} (_ht : 0 ≤ t) :
    Real.exp t - 1 ≤ t * Real.exp t := by
  have h := mul_le_mul_of_nonneg_right (Real.add_one_le_exp (-t)) (Real.exp_pos t).le
  rw [← Real.exp_add] at h
  simp only [neg_add_cancel, Real.exp_zero] at h
  nlinarith

theorem exp_remainder_le {v : ℝ} (hv : 0 ≤ v) :
    Real.exp v - 1 - v ≤ (v ^ 2 / 2) * Real.exp v := by
  have hleft : (∫ t in (0 : ℝ)..v, Real.exp t - 1) = Real.exp v - 1 - v := by
    rw [intervalIntegral.integral_sub (Real.continuous_exp.intervalIntegrable _ _)
      (continuous_const.intervalIntegrable _ _), integral_exp]
    simp
  have hright : (∫ t in (0 : ℝ)..v, t * Real.exp v) = (v ^ 2 / 2) * Real.exp v := by
    rw [intervalIntegral.integral_mul_const, integral_id]
    ring
  rw [← hleft, ← hright]
  apply intervalIntegral.integral_mono_on hv
    ((Real.continuous_exp.sub continuous_const).intervalIntegrable _ _)
    ((continuous_id.mul continuous_const).intervalIntegrable _ _)
  intro t ht
  exact (exp_sub_one_le_mul ht.1).trans
    (mul_le_mul_of_nonneg_left (Real.exp_le_exp.mpr ht.2) ht.1)

theorem exp_increment_bounds {u z : ℝ} (hu : 0 ≤ u) (hz : 0 ≤ z) :
    0 ≤ Real.exp (u + z) - Real.exp u ∧
    Real.exp (u + z) - Real.exp u ≤ Real.exp (u + z) ∧
    Real.exp (u + z) - Real.exp u ≤ (u + z) * Real.exp (u + z) ∧
    z ≤ Real.exp (u + z) - Real.exp u ∧
    Real.exp (u + z) - Real.exp u - z ≤ ((u + z) ^ 2 / 2) * Real.exp (u + z) := by
  have hv : 0 ≤ u + z := add_nonneg hu hz
  have heu : 1 ≤ Real.exp u := Real.one_le_exp_iff.mpr hu
  have hmono : Real.exp u ≤ Real.exp (u + z) := Real.exp_le_exp.mpr (by linarith)
  have hexp : 0 ≤ Real.exp (u + z) := (Real.exp_pos _).le
  have hlinu := Real.add_one_le_exp u
  have hlinz := Real.add_one_le_exp z
  have hprod := mul_le_mul_of_nonneg_right (show z ≤ Real.exp z - 1 by linarith)
    (Real.exp_pos u).le
  have hzprod : z ≤ z * Real.exp u := by nlinarith
  rw [sub_mul, ← Real.exp_add, one_mul, add_comm z u] at hprod
  refine ⟨sub_nonneg.mpr hmono, by linarith [(Real.exp_pos u).le], ?_,
    hzprod.trans hprod, ?_⟩
  · exact (show Real.exp (u + z) - Real.exp u ≤ Real.exp (u + z) - 1 by linarith).trans
      (exp_sub_one_le_mul hv)
  · have hrem := exp_remainder_le hv
    linarith

theorem prime_power_bounds {a : ℝ} (ha : 0 < a) {p : ℕ}
    (hp : p.Prime) (k : ℕ) :
    0 ≤ jordan a (p ^ (k + 1)) ∧
    jordan a (p ^ (k + 1)) ≤ ((p ^ (k + 1) : ℕ) : ℝ) ^ a ∧
    jordan a (p ^ (k + 1)) ≤ a * Real.log (p ^ (k + 1) : ℕ) *
      ((p ^ (k + 1) : ℕ) : ℝ) ^ a ∧
    a * ArithmeticFunction.vonMangoldt (p ^ (k + 1)) ≤ jordan a (p ^ (k + 1)) ∧
    jordan a (p ^ (k + 1)) - a * ArithmeticFunction.vonMangoldt (p ^ (k + 1)) ≤
      (a ^ 2 / 2) * ((p ^ (k + 1) : ℕ) : ℝ) ^ a *
      Real.log (p ^ (k + 1) : ℕ) ^ 2 := by
  have hl : 0 ≤ Real.log (p : ℝ) := Real.log_nonneg (by exact_mod_cast hp.one_lt.le)
  have hz : 0 ≤ a * Real.log (p : ℝ) := mul_nonneg ha.le hl
  have hu : 0 ≤ a * (k : ℝ) * Real.log (p : ℝ) := by positivity
  have h := exp_increment_bounds hu hz
  rw [jordan_prime_pow_succ a hp k,
    ArithmeticFunction.vonMangoldt_apply_pow (Nat.succ_ne_zero k),
    ArithmeticFunction.vonMangoldt_apply_prime hp]
  simp only [Nat.cast_pow, Real.log_pow]
  rw [Real.rpow_def_of_pos (pow_pos (by exact_mod_cast hp.pos) _),
    Real.rpow_def_of_pos (pow_pos (by exact_mod_cast hp.pos) _)]
  simp only [Real.log_pow, Nat.cast_add, Nat.cast_one]
  have heq : (k + 1 : ℝ) * Real.log (p : ℝ) * a =
      a * (k : ℝ) * Real.log (p : ℝ) + a * Real.log (p : ℝ) := by ring
  have heq' : (k : ℝ) * Real.log (p : ℝ) * a = a * (k : ℝ) * Real.log (p : ℝ) := by ring
  rw [heq, heq']
  obtain ⟨h0, h1, h2, h3, h4⟩ := h
  refine ⟨h0, h1, ?_, h3, ?_⟩
  · convert h2 using 1
    ring
  · convert h4 using 1
    ring

theorem not_prime_power_coprime_mul {m n : ℕ} (hm : 1 < m) (hn : 1 < n)
    (hcop : m.Coprime n) : ¬ IsPrimePow (m * n) := by
  intro hp
  have hdiv := (hcop.isPrimePow_dvd_mul hp).mp (dvd_refl (m * n))
  rcases hdiv with hdiv | hdiv
  · have hle := Nat.le_of_dvd (by omega : 0 < m) hdiv
    have hlt : m < m * n := by
      simpa using Nat.mul_lt_mul_of_pos_left hn (by omega : 0 < m)
    omega
  · have hle := Nat.le_of_dvd (by omega : 0 < n) hdiv
    have hlt : n < m * n := by
      simpa using Nat.mul_lt_mul_of_pos_right hm (by omega : 0 < n)
    omega

theorem jordan_all_bounds {a : ℝ} (ha : 0 < a) (n : ℕ) :
    0 ≤ jordan a n ∧ jordan a n ≤ (n : ℝ) ^ a ∧
    (1 < n → jordan a n ≤ a * Real.log n * (n : ℝ) ^ a) ∧
    (1 < n → a * ArithmeticFunction.vonMangoldt n ≤ jordan a n ∧
      jordan a n - a * ArithmeticFunction.vonMangoldt n ≤
        (a ^ 2 / 2) * (n : ℝ) ^ a * Real.log n ^ 2) := by
  induction n using Nat.recOnPrimeCoprime with
  | zero => simp [jordan_zero, Real.zero_rpow ha.ne']
  | prime_pow p k hp =>
      cases k with
      | zero => simp [jordan_one]
      | succ k =>
        obtain ⟨h0, h1, h2, h3, h4⟩ := prime_power_bounds ha hp k
        exact ⟨h0, h1, fun _ => h2, fun _ => ⟨h3, h4⟩⟩
  | coprime m n hm hn hcop ihM ihN =>
      have hm0 : 0 < (m : ℝ) := by exact_mod_cast (show 0 < m by omega)
      have hn0 : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
      have hlm : 0 ≤ Real.log (m : ℝ) := Real.log_nonneg (by exact_mod_cast hm.le)
      have hln : 0 ≤ Real.log (n : ℝ) := Real.log_nonneg (by exact_mod_cast hn.le)
      have hpowm : 0 ≤ (m : ℝ) ^ a := (Real.rpow_pos_of_pos hm0 a).le
      have hpown : 0 ≤ (n : ℝ) ^ a := (Real.rpow_pos_of_pos hn0 a).le
      have hlog : Real.log (m * n : ℕ) = Real.log (m : ℝ) + Real.log (n : ℝ) := by
        rw [Nat.cast_mul, Real.log_mul hm0.ne' hn0.ne']
      have hpow : ((m * n : ℕ) : ℝ) ^ a = (m : ℝ) ^ a * (n : ℝ) ^ a := by
        rw [Nat.cast_mul, Real.mul_rpow hm0.le hn0.le]
      have hvm : ArithmeticFunction.vonMangoldt (m * n) = 0 :=
        ArithmeticFunction.vonMangoldt_eq_zero_iff.mpr (not_prime_power_coprime_mul hm hn hcop)
      rw [jordan_mul hcop, hpow]
      refine ⟨mul_nonneg ihM.1 ihN.1,
        mul_le_mul ihM.2.1 ihN.2.1 ihN.1 hpowm, ?_, ?_⟩
      · intro _
        have hbound := mul_le_mul (ihM.2.2.1 hm) ihN.2.1 ihN.1
          (by positivity : 0 ≤ a * Real.log (m : ℝ) * (m : ℝ) ^ a)
        rw [hlog]
        calc
          jordan a m * jordan a n ≤ (a * Real.log m * (m : ℝ) ^ a) * (n : ℝ) ^ a := hbound
          _ ≤ a * (Real.log m + Real.log n) * ((m : ℝ) ^ a * (n : ℝ) ^ a) := by
            nlinarith [mul_nonneg (mul_nonneg ha.le hln) (mul_nonneg hpowm hpown)]
      · intro _
        rw [hvm, mul_zero, sub_zero, hlog]
        refine ⟨mul_nonneg ihM.1 ihN.1, ?_⟩
        have hbound := mul_le_mul (ihM.2.2.1 hm) (ihN.2.2.1 hn) ihN.1
          (by positivity : 0 ≤ a * Real.log (m : ℝ) * (m : ℝ) ^ a)
        have hlogs : Real.log (m : ℝ) * Real.log (n : ℝ) ≤
            (Real.log (m : ℝ) + Real.log (n : ℝ)) ^ 2 / 2 := by
          nlinarith [sq_nonneg (Real.log (m : ℝ)), sq_nonneg (Real.log (n : ℝ))]
        have hscale := mul_le_mul_of_nonneg_left hlogs
          (by positivity : 0 ≤ a ^ 2 * ((m : ℝ) ^ a * (n : ℝ) ^ a))
        nlinarith [hbound, hscale]

theorem actual_pointwise_comparison {a : ℝ} (ha : 0 < a) {n : ℕ} (hn : 2 ≤ n) :
    0 ≤ jordan a n / a - ArithmeticFunction.vonMangoldt n ∧
    jordan a n / a - ArithmeticFunction.vonMangoldt n ≤
      (a / 2) * (n : ℝ) ^ a * Real.log n ^ 2 := by
  obtain ⟨hl, hu⟩ := (jordan_all_bounds ha n).2.2.2 (by omega)
  have heq : jordan a n / a - ArithmeticFunction.vonMangoldt n =
      (jordan a n - a * ArithmeticFunction.vonMangoldt n) / a := by
    field_simp
  rw [heq]
  constructor
  · exact div_nonneg (sub_nonneg.mpr hl) ha.le
  · apply (div_le_iff₀ ha).mpr
    convert hu using 1
    ring

#print axioms actual_pointwise_comparison

theorem actual_finite_weighted_comparison {a : ℝ} (ha : 0 < a)
    (s : Finset ℕ) (w : ℕ → ℝ) (hn : ∀ n ∈ s, 2 ≤ n)
    (hw : ∀ n ∈ s, 0 ≤ w n) :
    0 ≤ ∑ n ∈ s, w n * (jordan a n / a - ArithmeticFunction.vonMangoldt n) ∧
    (∑ n ∈ s, w n * (jordan a n / a - ArithmeticFunction.vonMangoldt n)) ≤
      ∑ n ∈ s, w n * ((a / 2) * (n : ℝ) ^ a * Real.log n ^ 2) := by
  constructor
  · apply Finset.sum_nonneg
    intro n hns
    exact mul_nonneg (hw n hns) (actual_pointwise_comparison ha (hn n hns)).1
  · apply Finset.sum_le_sum
    intro n hns
    exact mul_le_mul_of_nonneg_left (actual_pointwise_comparison ha (hn n hns)).2 (hw n hns)

noncomputable def terminalWeight (X : ℝ) (n : ℕ) : ℝ :=
  max (2 * X - n) 0 - max (X - n) 0

theorem terminalWeight_nonneg {X : ℝ} (hX : 0 ≤ X) (n : ℕ) :
    0 ≤ terminalWeight X n := by
  exact sub_nonneg.mpr (max_le_max (by linarith) le_rfl)

theorem terminalWeight_le {X : ℝ} (hX : 0 ≤ X) (n : ℕ) :
    terminalWeight X n ≤ X := by
  unfold terminalWeight
  by_cases h : (n : ℝ) ≤ X
  · rw [max_eq_left (by linarith : 0 ≤ 2 * X - n),
      max_eq_left (by linarith : 0 ≤ X - n)]
    linarith
  · rw [max_eq_right (by linarith : X - n ≤ 0), sub_zero]
    exact max_le (by linarith) hX

noncomputable def lambdaTerminal (X : ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 2 ⌊2 * X⌋₊, terminalWeight X n * ArithmeticFunction.vonMangoldt n) -
    3 * X ^ 2 / 2

noncomputable def jordanTerminal (a X : ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 2 ⌊2 * X⌋₊, terminalWeight X n * (jordan a n / a)) -
    3 * X ^ 2 / 2

theorem actual_terminal_comparison {a X : ℝ} (ha : 0 < a) (hX : 1 ≤ X) :
    0 ≤ jordanTerminal a X - lambdaTerminal X ∧
    jordanTerminal a X - lambdaTerminal X ≤ a * X ^ 2 * (2 * X) ^ a * Real.log (2 * X) ^ 2 := by
  have hX0 : 0 ≤ X := by linarith
  have hR0 : 0 < 2 * X := by linarith
  have hR1 : 1 ≤ 2 * X := by linarith
  have hlnR : 0 ≤ Real.log (2 * X) := Real.log_nonneg hR1
  have hpowR : 0 ≤ (2 * X) ^ a := (Real.rpow_pos_of_pos hR0 a).le
  have hcoeff : 0 ≤ (a / 2) * (2 * X) ^ a * Real.log (2 * X) ^ 2 := by positivity
  have hdiff : jordanTerminal a X - lambdaTerminal X =
      ∑ n ∈ Finset.Icc 2 ⌊2 * X⌋₊,
        terminalWeight X n * (jordan a n / a - ArithmeticFunction.vonMangoldt n) := by
    simp only [jordanTerminal, lambdaTerminal, mul_sub, Finset.sum_sub_distrib]
    ring
  rw [hdiff]
  refine ⟨?_, ?_⟩
  · exact (actual_finite_weighted_comparison ha _ _
      (fun n hn => (Finset.mem_Icc.mp hn).1)
      (fun n _ => terminalWeight_nonneg hX0 n)).1
  · have hsum : (∑ n ∈ Finset.Icc 2 ⌊2 * X⌋₊,
        terminalWeight X n * (jordan a n / a - ArithmeticFunction.vonMangoldt n)) ≤
        ((a / 2) * (2 * X) ^ a * Real.log (2 * X) ^ 2) *
          ∑ n ∈ Finset.Icc 2 ⌊2 * X⌋₊, terminalWeight X n := by
      rw [Finset.mul_sum]
      apply Finset.sum_le_sum
      intro n hn
      have hn2 := (Finset.mem_Icc.mp hn).1
      have hnf := (Finset.mem_Icc.mp hn).2
      have hn0 : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
      have hn1 : 1 ≤ (n : ℝ) := by exact_mod_cast (show 1 ≤ n by omega)
      have hnR : (n : ℝ) ≤ 2 * X :=
        (Nat.cast_le.mpr hnf).trans (Nat.floor_le hR0.le)
      have hlnn : 0 ≤ Real.log (n : ℝ) := Real.log_nonneg hn1
      have hlogs : Real.log (n : ℝ) ≤ Real.log (2 * X) := Real.log_le_log hn0 hnR
      have hpows : (n : ℝ) ^ a ≤ (2 * X) ^ a := Real.rpow_le_rpow hn0.le hnR ha.le
      have hsq : Real.log (n : ℝ) ^ 2 ≤ Real.log (2 * X) ^ 2 := by nlinarith
      have hbound : (a / 2) * (n : ℝ) ^ a * Real.log (n : ℝ) ^ 2 ≤
          (a / 2) * (2 * X) ^ a * Real.log (2 * X) ^ 2 :=
        mul_le_mul (mul_le_mul_of_nonneg_left hpows (by positivity)) hsq
          (sq_nonneg _) (by positivity)
      simpa [mul_comm] using mul_le_mul_of_nonneg_left
        ((actual_pointwise_comparison ha hn2).2.trans hbound) (terminalWeight_nonneg hX0 n)
    have hcard : (Finset.Icc 2 ⌊2 * X⌋₊).card ≤ ⌊2 * X⌋₊ := by
      rw [Nat.card_Icc]
      omega
    have hwSum : (∑ n ∈ Finset.Icc 2 ⌊2 * X⌋₊, terminalWeight X n) ≤ 2 * X ^ 2 := by
      calc
        _ ≤ ∑ n ∈ Finset.Icc 2 ⌊2 * X⌋₊, X :=
          Finset.sum_le_sum (fun n _ => terminalWeight_le hX0 n)
        _ = ((Finset.Icc 2 ⌊2 * X⌋₊).card : ℝ) * X := by simp
        _ ≤ (⌊2 * X⌋₊ : ℝ) * X := mul_le_mul_of_nonneg_right (by exact_mod_cast hcard) hX0
        _ ≤ (2 * X) * X := mul_le_mul_of_nonneg_right (Nat.floor_le hR0.le) hX0
        _ = 2 * X ^ 2 := by ring
    have hfinal := mul_le_mul_of_nonneg_left hwSum hcoeff
    convert hsum.trans hfinal using 1
    ring

#print axioms actual_finite_weighted_comparison
#print axioms actual_terminal_comparison

theorem actual_weighted_tent_sum {y : ℝ} (hy : 0 ≤ y) (N : ℕ) (hN : ⌊y⌋₊ ≤ N) :
    (∑ n ∈ Finset.Icc 2 N, max (y - n) 0 * ArithmeticFunction.vonMangoldt n) =
      ∑ n ∈ Finset.Icc 1 ⌊y⌋₊, (y - n) * ArithmeticFunction.vonMangoldt n := by
  have hremove : (∑ n ∈ Finset.Icc 2 N, max (y - n) 0 * ArithmeticFunction.vonMangoldt n) =
      ∑ n ∈ Finset.Icc 1 N, max (y - n) 0 * ArithmeticFunction.vonMangoldt n := by
    apply Finset.sum_subset (Finset.Icc_subset_Icc_left (by omega))
    intro n hn hnnot
    have hn1 : n = 1 := by
      simp only [Finset.mem_Icc] at hn hnnot
      omega
    simp [hn1]
  rw [hremove]
  calc
    _ = ∑ n ∈ Finset.Icc 1 ⌊y⌋₊, max (y - n) 0 * ArithmeticFunction.vonMangoldt n := by
      symm
      apply Finset.sum_subset (Finset.Icc_subset_Icc_right hN)
      intro n hn hnnot
      have hnf : ⌊y⌋₊ < n := by
        simp only [Finset.mem_Icc] at hn hnnot
        omega
      have hyn : y < (n : ℝ) := Nat.lt_of_floor_lt hnf
      rw [max_eq_right (by linarith : y - n ≤ 0), zero_mul]
    _ = _ := by
      apply Finset.sum_congr rfl
      intro n hn
      have hny : (n : ℝ) ≤ y :=
        (Nat.cast_le.mpr (Finset.mem_Icc.mp hn).2).trans (Nat.floor_le hy)
      rw [max_eq_left (by linarith : 0 ≤ y - n)]

theorem lambdaTerminal_eq_coarsePrefix {X : ℝ} (hX : 1 ≤ X) :
    lambdaTerminal X = BuildingBlocks.CoarsePrimitive.coarsePrefix X (2 * X) := by
  have hX0 : 0 ≤ X := by linarith
  have h2X : 1 ≤ 2 * X := by linarith
  rw [BuildingBlocks.coarsePrefix_eq_area_sub hX h2X,
    BuildingBlocks.primePrimitiveArea_eq_weighted_sum,
    BuildingBlocks.primePrimitiveArea_eq_weighted_sum]
  simp only [lambdaTerminal, terminalWeight, sub_mul, Finset.sum_sub_distrib]
  rw [actual_weighted_tent_sum (by linarith : 0 ≤ 2 * X) ⌊2 * X⌋₊ le_rfl,
    actual_weighted_tent_sum hX0 ⌊2 * X⌋₊ (Nat.floor_mono (by linarith))]
  simp_rw [sub_mul, Finset.sum_sub_distrib]
  ring

theorem actual_continuum_terminal_comparison {a X : ℝ} (ha : 0 < a) (hX : 1 ≤ X) :
    0 ≤ jordanTerminal a X - BuildingBlocks.CoarsePrimitive.coarsePrefix X (2 * X) ∧
    jordanTerminal a X - BuildingBlocks.CoarsePrimitive.coarsePrefix X (2 * X) ≤
      a * X ^ 2 * (2 * X) ^ a * Real.log (2 * X) ^ 2 := by
  rw [← lambdaTerminal_eq_coarsePrefix hX]
  exact actual_terminal_comparison ha hX

#print axioms lambdaTerminal_eq_coarsePrefix
#print axioms actual_continuum_terminal_comparison

end BuildingBlocks.JordanVonMangoldtComparison
