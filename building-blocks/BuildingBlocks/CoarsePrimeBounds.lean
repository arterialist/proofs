import BuildingBlocks.CoarsePrimitive
import BuildingBlocks.FloorCorrection
import BuildingBlocks.HyperbolaProduct
import Mathlib.NumberTheory.LSeries.Dirichlet
import Mathlib.NumberTheory.LSeries.SumCoeff
import Mathlib.Data.Nat.Choose.Bounds
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals

open BuildingBlocks.FloorCorrection BuildingBlocks.HyperbolaProduct
open Filter Set MeasureTheory Asymptotics
open scoped Topology BigOperators Interval

namespace BuildingBlocks.CoarsePrimitive

theorem psi_succ (N : ℕ) :
    psi (N + 1) = psi N + ArithmeticFunction.vonMangoldt (N + 1) := by
  exact Finset.sum_range_succ _ (N + 1)

theorem prime_power_series {s : ℂ} (hs : 1 < s.re) :
    LSeries (fun n => (ArithmeticFunction.vonMangoldt n : ℂ)) s =
      -deriv riemannZeta s / riemannZeta s :=
  ArithmeticFunction.LSeries_vonMangoldt_eq_deriv_riemannZeta_div hs

theorem psi_eq_sum_Icc (N : ℕ) :
    psi N = ∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n := by
  induction N with
  | zero => simp [psi]
  | succ N ih => rw [psi_succ, ih, Finset.sum_Icc_succ_top (by omega)]

theorem logFactorial_eq_weighted_prime_sum (N : ℕ) :
    logFactorial N = ∑ d ∈ Finset.Icc 1 N,
      ((N / d : ℕ) : ℝ) * ArithmeticFunction.vonMangoldt d := by
  unfold logFactorial
  simp_rw [← ArithmeticFunction.vonMangoldt_sum]
  rw [sum_divisors_eq_sum_factor_pairs N (fun d _ => ArithmeticFunction.vonMangoldt d)]
  apply Finset.sum_congr rfl
  intro d hd
  simp

theorem logFactorial_le_mul_log (N : ℕ) :
    logFactorial N ≤ (N : ℝ) * Real.log N := by
  have hh : logFactorial N ≤ ∑ _k ∈ Finset.Icc 1 N, Real.log N := by
    apply Finset.sum_le_sum
    intro k hk
    obtain ⟨hk1, hkN⟩ := Finset.mem_Icc.mp hk
    exact Real.log_le_log (by exact_mod_cast hk1) (by exact_mod_cast hkN)
  simpa only [Finset.sum_const, Nat.card_Icc, Nat.add_sub_cancel,
    nsmul_eq_mul] using hh

theorem psi_nonneg (N : ℕ) : 0 ≤ psi N := by
  rw [psi_eq_sum_Icc]
  exact Finset.sum_nonneg (fun _ _ => ArithmeticFunction.vonMangoldt_nonneg)

theorem psi_le_mul_log (N : ℕ) : psi N ≤ (N : ℝ) * Real.log (N : ℝ) := by
  have hh : psi N ≤ logFactorial N := by
    rw [psi_eq_sum_Icc]
    exact Finset.sum_le_sum (fun _ _ => ArithmeticFunction.vonMangoldt_le_log)
  exact hh.trans (logFactorial_le_mul_log N)

theorem psi_bigO_rpow {r : ℝ} (hr : 1 < r) :
    (fun N : ℕ => psi N) =O[atTop] (fun N => (N : ℝ) ^ r) := by
  apply isBigO_iff.mpr
  refine ⟨1 / (r - 1), ?_⟩
  filter_upwards [eventually_ge_atTop (1 : ℕ)] with N hN
  have hn : (0 : ℝ) < (N : ℝ) := by exact_mod_cast (show 0 < N by omega)
  rw [Real.norm_of_nonneg (psi_nonneg N), Real.norm_of_nonneg (Real.rpow_nonneg hn.le _)]
  calc
    psi N ≤ (N : ℝ) * Real.log (N : ℝ) := psi_le_mul_log N
    _ ≤ (N : ℝ) * ((N : ℝ) ^ (r - 1) / (r - 1)) :=
      mul_le_mul_of_nonneg_left (Real.log_le_rpow_div hn.le (by linarith)) hn.le
    _ = 1 / (r - 1) * (N : ℝ) ^ r := by
      nth_rw 1 [← Real.rpow_one (N : ℝ)]
      rw [← mul_div_assoc, ← Real.rpow_add hn]
      rw [show (1 : ℝ) + (r - 1) = r by ring]
      ring

theorem zeta_logDerivative_eq_prime_integral_unconditional {s : ℂ} (hs : 1 < s.re) :
    -deriv riemannZeta s / riemannZeta s =
      s * ∫ x : ℝ in Set.Ioi 1, (psi ⌊x⌋₊ : ℂ) * (x : ℂ) ^ (-(s + 1)) := by
  rw [← prime_power_series hs]
  simpa only [psi_eq_sum_Icc, Complex.ofReal_sum] using
    LSeries_eq_mul_integral_of_nonneg ArithmeticFunction.vonMangoldt
      (r := (s.re + 1) / 2) (by linarith) (by linarith)
      (by simpa only [← psi_eq_sum_Icc] using psi_bigO_rpow (r := (s.re + 1) / 2) (by linarith))
      (fun _ => ArithmeticFunction.vonMangoldt_nonneg)

theorem logFactorial_eq_extended_prime_sum {N M : ℕ} (h : N ≤ M) :
    logFactorial N = ∑ n ∈ Finset.Icc 1 M,
      ((N / n : ℕ) : ℝ) * ArithmeticFunction.vonMangoldt n := by
  rw [logFactorial_eq_weighted_prime_sum]
  apply Finset.sum_subset (Finset.Icc_subset_Icc_right h)
  intro n hn hnot
  have hgt : N < n := by simp only [Finset.mem_Icc] at hn hnot; omega
  simp [Nat.div_eq_of_lt hgt]

theorem psi_double_le_logFactorial (N : ℕ) :
    psi (2 * N) ≤ psi N + logFactorial (2 * N) - 2 * logFactorial N := by
  have hN : N ≤ 2 * N := by omega
  have hfilter : (Finset.Icc 1 (2 * N)).filter (fun n => n ≤ N) = Finset.Icc 1 N := by
    ext n
    simp only [Finset.mem_filter, Finset.mem_Icc]
    omega
  have hp : psi N = ∑ n ∈ Finset.Icc 1 (2 * N),
      if n ≤ N then ArithmeticFunction.vonMangoldt n else 0 := by
    rw [← Finset.sum_filter, hfilter, psi_eq_sum_Icc]
  have hterm : ∀ n ∈ Finset.Icc 1 (2 * N),
      2 * (((N / n : ℕ) : ℝ) * ArithmeticFunction.vonMangoldt n) +
        ArithmeticFunction.vonMangoldt n ≤
      (if n ≤ N then ArithmeticFunction.vonMangoldt n else 0) +
        ((2 * N / n : ℕ) : ℝ) * ArithmeticFunction.vonMangoldt n := by
    intro n hn
    obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hn
    have hv : 0 ≤ ArithmeticFunction.vonMangoldt n := ArithmeticFunction.vonMangoldt_nonneg
    by_cases hcut : n ≤ N
    · rw [if_pos hcut]
      have hd : 2 * (N / n) ≤ 2 * N / n := by
        apply (Nat.le_div_iff_mul_le hn1).mpr
        calc
          (2 * (N / n)) * n = 2 * ((N / n) * n) := by ring
          _ ≤ 2 * N := Nat.mul_le_mul_left 2 (Nat.div_mul_le_self N n)
      have hdr : (2 : ℝ) * (N / n : ℕ) ≤ (2 * N / n : ℕ) := by exact_mod_cast hd
      nlinarith [mul_le_mul_of_nonneg_right hdr hv]
    · rw [if_neg hcut, Nat.div_eq_of_lt (by omega : N < n)]
      have hd : 1 ≤ 2 * N / n := (Nat.le_div_iff_mul_le hn1).mpr (by simpa using hnN)
      have hdr : (1 : ℝ) ≤ (2 * N / n : ℕ) := by exact_mod_cast hd
      norm_num only [Nat.cast_zero, zero_mul, add_zero, zero_add]
      exact le_mul_of_one_le_left hv hdr
  have hh := Finset.sum_le_sum hterm
  rw [Finset.sum_add_distrib, ← Finset.mul_sum, ← logFactorial_eq_extended_prime_sum hN,
    ← psi_eq_sum_Icc, Finset.sum_add_distrib, ← hp, ← logFactorial_eq_weighted_prime_sum] at hh
  linarith

theorem logFactorial_double_sub_le (N : ℕ) :
    logFactorial (2 * N) - 2 * logFactorial N ≤ (2 * N : ℕ) * Real.log 2 := by
  have hfac := Nat.choose_mul_factorial_mul_factorial (show N ≤ 2 * N by omega)
  rw [show 2 * N - N = N by omega] at hfac
  have hchoose : (0 : ℝ) < ((2 * N).choose N : ℝ) :=
    by exact_mod_cast Nat.choose_pos (show N ≤ 2 * N by omega)
  have hlog : logFactorial (2 * N) =
      Real.log ((2 * N).choose N : ℝ) + 2 * logFactorial N := by
    rw [logFactorial_eq_log, ← hfac, Nat.cast_mul, Nat.cast_mul,
      Real.log_mul (by positivity) (by positivity),
      Real.log_mul hchoose.ne' (by positivity), logFactorial_eq_log]
    ring
  have hh : Real.log ((2 * N).choose N : ℝ) ≤ Real.log ((2 : ℝ) ^ (2 * N)) :=
    Real.log_le_log hchoose (by exact_mod_cast Nat.choose_le_two_pow (2 * N) N)
  rw [Real.log_pow] at hh
  linarith

theorem psi_double_le (N : ℕ) : psi (2 * N) ≤ psi N + (2 * N : ℕ) * Real.log 2 := by
  have h1 := psi_double_le_logFactorial N
  have h2 := logFactorial_double_sub_le N
  linarith

theorem psi_le_linear (N : ℕ) : psi N ≤ (4 * Real.log 2) * (N : ℝ) := by
  have hlog : 0 < Real.log 2 := Real.log_pos (by norm_num)
  induction N using Nat.strong_induction_on with
  | h N ih =>
    by_cases hsmall : N ≤ 2
    · interval_cases N <;>
        norm_num [psi, Finset.sum_range_succ,
          ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two] <;> linarith
    · let m := (N + 1) / 2
      have hm : m < N := by dsimp only [m]; omega
      have hcover : N ≤ 2 * m := by dsimp only [m]; omega
      have hsize : 6 * m ≤ 4 * N := by dsimp only [m]; omega
      have hp := (psi_mono hcover).trans (psi_double_le m)
      have hi := ih m hm
      have hsize' : (6 : ℝ) * (m : ℝ) ≤ 4 * (N : ℝ) := by exact_mod_cast hsize
      push_cast at hp
      nlinarith [mul_le_mul_of_nonneg_right hsize' hlog.le]

theorem linear_kernel_eq {s : ℂ} {x : ℝ} (hx : 0 < x) :
    (x : ℂ) * (x : ℂ) ^ (-(s + 1)) = (x : ℂ) ^ (-s) := by
  calc
    (x : ℂ) * (x : ℂ) ^ (-(s + 1)) = (x : ℂ) ^ (1 : ℂ) * (x : ℂ) ^ (-(s + 1)) := by
      rw [Complex.cpow_one]
    _ = (x : ℂ) ^ (1 + -(s + 1)) :=
      (Complex.cpow_add _ _ (Complex.ofReal_ne_zero.mpr hx.ne')).symm
    _ = (x : ℂ) ^ (-s) := by congr 1; ring

end BuildingBlocks.CoarsePrimitive
