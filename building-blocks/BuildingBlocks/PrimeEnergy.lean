import BuildingBlocks.MertensArithmetic
import Mathlib.NumberTheory.Harmonic.Bounds

open Finset Filter Set MeasureTheory
open scoped Topology BigOperators Interval

namespace BuildingBlocks

open MertensTransfer CoarsePrimitive FloorCorrection HyperbolaProduct

noncomputable def primeIncrement (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n - 1

noncomputable def discretePrimeErrorEnergy (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, integerError n ^ 2 / ((n : ℝ) * ((n : ℝ) + 1))

noncomputable def primeIncrementEnergy (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, primeIncrement n ^ 2 / (n : ℝ)

/-- The signed correlation between the preceding error and the next increment.
No sign or asymptotic bound is asserted in this definition. -/
noncomputable def primeErrorDrift (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, integerError (n - 1) * primeIncrement n / (n : ℝ)

theorem integerError_zero : integerError 0 = 0 := by simp [integerError, psi]

theorem integerError_succ (n : ℕ) :
    integerError (n + 1) = integerError n + primeIncrement (n + 1) := by
  simp only [integerError, primeIncrement, psi_succ, Nat.cast_add, Nat.cast_one]
  ring

theorem integerError_eq_sum_increment (N : ℕ) :
    integerError N = ∑ n ∈ Finset.Icc 1 N, primeIncrement n := by
  simp [integerError, psi_eq_sum_Icc, primeIncrement, Finset.sum_sub_distrib]

theorem primeErrorDrift_eq_ordered_pair_sum (N : ℕ) :
    primeErrorDrift N = ∑ n ∈ Finset.Icc 1 N,
      ∑ m ∈ Finset.Icc 1 (n - 1), primeIncrement m * primeIncrement n / (n : ℝ) := by
  simp only [primeErrorDrift, integerError_eq_sum_increment, Finset.sum_mul, Finset.sum_div]

/-- A weighted discrete integration-by-parts identity for any real trajectory.
It alone imposes no cancellation on that trajectory. -/
theorem weighted_energy_balance (e : ℕ → ℝ) (h0 : e 0 = 0) (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, e n ^ 2 / ((n : ℝ) * ((n : ℝ) + 1))) =
      (∑ n ∈ Finset.Icc 1 N, (e n ^ 2 - e (n - 1) ^ 2) / (n : ℝ)) -
        e N ^ 2 / ((N : ℝ) + 1) := by
  induction N with
  | zero => simp [h0]
  | succ N ih =>
    rw [Finset.sum_Icc_succ_top (by omega), Finset.sum_Icc_succ_top (by omega), ih]
    simp only [Nat.add_sub_cancel, Nat.cast_add, Nat.cast_one]
    have h1 : (N : ℝ) + 1 ≠ 0 := by positivity
    have h2 : (N : ℝ) + 1 + 1 ≠ 0 := by positivity
    field_simp
    ring

theorem prime_energy_balance (N : ℕ) :
    discretePrimeErrorEnergy N = 2 * primeErrorDrift N + primeIncrementEnergy N -
      integerError N ^ 2 / ((N : ℝ) + 1) := by
  rw [discretePrimeErrorEnergy, weighted_energy_balance integerError integerError_zero]
  congr 1
  rw [primeErrorDrift, primeIncrementEnergy, Finset.mul_sum, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  have hn1 := (Finset.mem_Icc.mp hn).1
  have he : integerError n = integerError (n - 1) + primeIncrement n := by
    simpa only [Nat.sub_add_cancel hn1] using integerError_succ (n - 1)
  rw [he]
  ring

theorem discretePrimeErrorEnergy_nonneg (N : ℕ) : 0 ≤ discretePrimeErrorEnergy N := by
  exact Finset.sum_nonneg (fun n _ => div_nonneg (sq_nonneg _) (by positivity))

theorem primeIncrementEnergy_nonneg (N : ℕ) : 0 ≤ primeIncrementEnergy N := by
  exact Finset.sum_nonneg (fun n _ => div_nonneg (sq_nonneg _) (Nat.cast_nonneg n))

theorem discretePrimeErrorEnergy_mono {M N : ℕ} (h : M ≤ N) :
    discretePrimeErrorEnergy M ≤ discretePrimeErrorEnergy N := by
  apply Finset.sum_le_sum_of_subset_of_nonneg (Finset.Icc_subset_Icc_right h)
  intro n _ _
  positivity

theorem prime_energy_upper (N : ℕ) :
    discretePrimeErrorEnergy N ≤ 2 * primeErrorDrift N + primeIncrementEnergy N := by
  rw [prime_energy_balance]
  exact sub_le_self _ (div_nonneg (sq_nonneg _) (by positivity))

/-- The exact factorization identity controls the reciprocal prime-power mass. -/
theorem reciprocal_vonMangoldt_sum_le {N : ℕ} (hN : 1 ≤ N) :
    (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n / (n : ℝ)) ≤
      2 * Real.log (N : ℝ) := by
  have hN0 : (0 : ℝ) < (N : ℝ) := by exact_mod_cast (show 0 < N by omega)
  have hsum : (N : ℝ) *
      (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n / (n : ℝ)) ≤
        logFactorial N + psi N := by
    rw [Finset.mul_sum, logFactorial_eq_weighted_prime_sum, psi_eq_sum_Icc,
      ← Finset.sum_add_distrib]
    apply Finset.sum_le_sum
    intro n hn
    have hn0 : 0 < n := (Finset.mem_Icc.mp hn).1
    have hnreal : (0 : ℝ) < (n : ℝ) := by exact_mod_cast hn0
    have hdiv : (N : ℝ) / (n : ℝ) ≤ (N / n : ℕ) + 1 := by
      apply (div_le_iff₀ hnreal).mpr
      have hh := (Nat.lt_mul_div_succ N hn0).le
      rw [mul_comm] at hh
      exact_mod_cast hh
    have hh := mul_le_mul_of_nonneg_right hdiv (ArithmeticFunction.vonMangoldt_nonneg (n := n))
    convert hh using 1 <;> ring
  have hbound := add_le_add (logFactorial_le_mul_log N) (psi_le_mul_log N)
  apply (mul_le_mul_iff_right₀ hN0).mp
  nlinarith

/-- The diagonal energy is controlled by the reciprocal mass of the complete
prime-power source. This does not control the signed drift in
`prime_energy_balance`. -/
theorem primeIncrementEnergy_le_reciprocal {N : ℕ} (hN : 1 ≤ N) :
    primeIncrementEnergy N ≤ Real.log (N : ℝ) *
      (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n / (n : ℝ)) +
      (1 + Real.log (N : ℝ)) := by
  have hNreal : (1 : ℝ) ≤ (N : ℝ) := by exact_mod_cast hN
  have hterm : ∀ n ∈ Finset.Icc 1 N,
      primeIncrement n ^ 2 / (n : ℝ) ≤
        Real.log (N : ℝ) * (ArithmeticFunction.vonMangoldt n / (n : ℝ)) + (n : ℝ)⁻¹ := by
    intro n hn
    obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hn
    have hnreal : (0 : ℝ) < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
    have hv0 : 0 ≤ ArithmeticFunction.vonMangoldt n := ArithmeticFunction.vonMangoldt_nonneg
    have hv : ArithmeticFunction.vonMangoldt n ≤ Real.log (N : ℝ) :=
      ArithmeticFunction.vonMangoldt_le_log.trans
        (Real.log_le_log hnreal (by exact_mod_cast hnN))
    have hh : primeIncrement n ^ 2 ≤ Real.log (N : ℝ) * ArithmeticFunction.vonMangoldt n + 1 := by
      unfold primeIncrement
      nlinarith [mul_le_mul_of_nonneg_right hv hv0]
    calc
      _ ≤ (Real.log (N : ℝ) * ArithmeticFunction.vonMangoldt n + 1) / (n : ℝ) :=
        div_le_div_of_nonneg_right hh hnreal.le
      _ = _ := by ring
  calc
    primeIncrementEnergy N ≤ ∑ n ∈ Finset.Icc 1 N,
        (Real.log (N : ℝ) * (ArithmeticFunction.vonMangoldt n / (n : ℝ)) + (n : ℝ)⁻¹) :=
      Finset.sum_le_sum hterm
    _ = Real.log (N : ℝ) * (∑ n ∈ Finset.Icc 1 N,
        ArithmeticFunction.vonMangoldt n / (n : ℝ)) + (harmonic N : ℝ) := by
      simp only [Finset.sum_add_distrib, ← Finset.mul_sum, harmonic_eq_sum_Icc,
        Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast]
    _ ≤ _ := add_le_add_left (harmonic_le_one_add_log N) _

/-- An elementary bound for the diagonal term. The signed drift remains
uncontrolled. -/
theorem primeIncrementEnergy_le_log_square {N : ℕ} (hN : 1 ≤ N) :
    primeIncrementEnergy N ≤ 2 * Real.log (N : ℝ) ^ 2 + 1 + Real.log (N : ℝ) := by
  have hNreal : (1 : ℝ) ≤ (N : ℝ) := by exact_mod_cast hN
  have hlog : 0 ≤ Real.log (N : ℝ) := Real.log_nonneg hNreal
  have hh := primeIncrementEnergy_le_reciprocal hN
  have hb := mul_le_mul_of_nonneg_left (reciprocal_vonMangoldt_sum_le hN) hlog
  nlinarith

theorem prime_energy_upper_log_square {N : ℕ} (hN : 1 ≤ N) :
    discretePrimeErrorEnergy N ≤
      2 * primeErrorDrift N + (2 * Real.log (N : ℝ) ^ 2 + 1 + Real.log (N : ℝ)) :=
  (prime_energy_upper N).trans (add_le_add_left (primeIncrementEnergy_le_log_square hN) _)

theorem prime_error_boundary_upper (N : ℕ) :
    integerError N ^ 2 / ((N : ℝ) + 1) ≤ 2 * primeErrorDrift N + primeIncrementEnergy N := by
  have hh := prime_energy_balance N
  have hu := discretePrimeErrorEnergy_nonneg N
  linarith

theorem prime_error_square_upper_of_drift_nonpos {N : ℕ} (hN : 1 ≤ N)
    (hD : primeErrorDrift N ≤ 0) :
    integerError N ^ 2 ≤ ((N : ℝ) + 1) *
      (2 * Real.log (N : ℝ) ^ 2 + 1 + Real.log (N : ℝ)) := by
  have hh := prime_error_boundary_upper N
  have hb := primeIncrementEnergy_le_log_square hN
  have hn : (0 : ℝ) < (N : ℝ) + 1 := by positivity
  have hf : integerError N ^ 2 / ((N : ℝ) + 1) ≤
      2 * Real.log (N : ℝ) ^ 2 + 1 + Real.log (N : ℝ) := by linarith
  simpa only [mul_comm] using (div_le_iff₀ hn).mp hf

theorem primeErrorDrift_two : primeErrorDrift 2 = (1 - Real.log 2) / 2 := by
  norm_num [primeErrorDrift, integerError, primeIncrement, psi,
    Finset.sum_Icc_succ_top, Finset.sum_range_succ,
    ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two]

/-- Even the cumulative signed drift is not always nonpositive. -/
theorem primeErrorDrift_two_pos : 0 < primeErrorDrift 2 := by
  rw [primeErrorDrift_two]
  have hh := Real.log_lt_sub_one_of_pos (by norm_num : (0 : ℝ) < 2)
    (by norm_num : (2 : ℝ) ≠ 1)
  linarith

/-- A general trajectory may have a small diagonal increment energy and large
error energy. This example is not the arithmetic prime-power trajectory. -/
theorem linear_trajectory_increment_energy (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, ((n : ℝ) - ((n - 1 : ℕ) : ℝ)) ^ 2 / (n : ℝ)) =
      (harmonic N : ℝ) := by
  rw [harmonic_eq_sum_Icc]
  simp only [Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast]
  apply Finset.sum_congr rfl
  intro n hn
  rw [Nat.cast_sub (Finset.mem_Icc.mp hn).1]
  simp

theorem linear_trajectory_error_energy_lower (N : ℕ) :
    (N : ℝ) / 2 ≤ ∑ n ∈ Finset.Icc 1 N, (n : ℝ) ^ 2 / ((n : ℝ) * ((n : ℝ) + 1)) := by
  calc
    (N : ℝ) / 2 = ∑ _n ∈ Finset.Icc 1 N, (1 : ℝ) / 2 := by simp [div_eq_mul_inv]
    _ ≤ _ := by
      apply Finset.sum_le_sum
      intro n hn
      have hn1 : (1 : ℝ) ≤ (n : ℝ) := by exact_mod_cast (Finset.mem_Icc.mp hn).1
      have hd : 0 < (n : ℝ) * ((n : ℝ) + 1) := by positivity
      apply (le_div_iff₀ hd).mpr
      nlinarith

end BuildingBlocks
