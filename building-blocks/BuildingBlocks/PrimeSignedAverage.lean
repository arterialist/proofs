import BuildingBlocks.PrimeEnergy

open Finset
open scoped BigOperators

namespace BuildingBlocks

open MertensTransfer CoarsePrimitive FloorCorrection HyperbolaProduct

private theorem natCast_div_lower (M q : ℕ) (hq : 0 < q) :
    (M : ℝ) / q - 1 ≤ ((M / q : ℕ) : ℝ) := by
  have hqr : (0 : ℝ) < q := by exact_mod_cast hq
  have hn : M < (M / q + 1) * q :=
    (Nat.div_lt_iff_lt_mul hq).mp (Nat.lt_succ_self (M / q))
  have hnr : (M : ℝ) < (((M / q : ℕ) : ℝ) + 1) * q := by exact_mod_cast hn
  have hh := (div_lt_iff₀ hqr).mpr hnr
  linarith

noncomputable def logarithmicPrimeMass (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n / (n : ℝ)

theorem logarithmicPrimeMass_floor_remainder (N : ℕ) :
    (N : ℝ) * logarithmicPrimeMass N - logFactorial N =
      ∑ n ∈ Finset.Icc 1 N,
        ((N : ℝ) / n - ((N / n : ℕ) : ℝ)) * ArithmeticFunction.vonMangoldt n := by
  rw [logarithmicPrimeMass, Finset.mul_sum, logFactorial_eq_weighted_prime_sum,
    ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro n _
  ring

theorem logarithmicPrimeMass_floor_bounds (N : ℕ) :
    0 ≤ (N : ℝ) * logarithmicPrimeMass N - logFactorial N ∧
    (N : ℝ) * logarithmicPrimeMass N - logFactorial N ≤ psi N := by
  rw [logarithmicPrimeMass_floor_remainder]
  have hterm : ∀ n ∈ Finset.Icc 1 N,
      0 ≤ ((N : ℝ) / n - ((N / n : ℕ) : ℝ)) * ArithmeticFunction.vonMangoldt n ∧
      ((N : ℝ) / n - ((N / n : ℕ) : ℝ)) * ArithmeticFunction.vonMangoldt n ≤
        ArithmeticFunction.vonMangoldt n := by
    intro n hn
    have hn0 : 0 < n := (Finset.mem_Icc.mp hn).1
    have hlo : ((N / n : ℕ) : ℝ) ≤ (N : ℝ) / n := Nat.cast_div_le
    have hhi := natCast_div_lower N n hn0
    have hv : 0 ≤ ArithmeticFunction.vonMangoldt n := ArithmeticFunction.vonMangoldt_nonneg
    constructor
    · exact mul_nonneg (sub_nonneg.mpr hlo) hv
    · nlinarith [mul_le_mul_of_nonneg_right (show (N : ℝ) / n - ((N / n : ℕ) : ℝ) ≤ 1
        by linarith) hv]
  constructor
  · exact Finset.sum_nonneg (fun n hn => (hterm n hn).1)
  · rw [psi_eq_sum_Icc]
    exact Finset.sum_le_sum (fun n hn => (hterm n hn).2)

/-- The elementary logarithmically weighted prime-power estimate. -/
theorem logarithmicPrimeMass_bounds {N : ℕ} (hN : 1 ≤ N) :
    Real.log N - 1 ≤ logarithmicPrimeMass N ∧
    logarithmicPrimeMass N ≤ Real.log N + 4 * Real.log 2 := by
  have hn : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  obtain ⟨hlo, hhi⟩ := logarithmicPrimeMass_floor_bounds N
  obtain ⟨hLlo, hLhi⟩ := logFactorial_integral_bounds hN
  have hlog := Real.log_le_sub_one_of_pos hn
  have hpsi := psi_le_linear N
  constructor
  · apply (mul_le_mul_iff_right₀ hn).mp
    nlinarith
  · apply (mul_le_mul_iff_right₀ hn).mp
    nlinarith

/-- Chebyshev's linear bound for the full prime-power source lowers the
leading logarithmic-square coefficient in the diagonal energy estimate. -/
theorem primeIncrementEnergy_le_chebyshev {N : ℕ} (hN : 1 ≤ N) :
    primeIncrementEnergy N ≤ Real.log (N : ℝ) ^ 2 +
      (4 * Real.log 2 + 1) * Real.log (N : ℝ) + 1 := by
  have hNreal : (1 : ℝ) ≤ (N : ℝ) := by exact_mod_cast hN
  have hlog : 0 ≤ Real.log (N : ℝ) := Real.log_nonneg hNreal
  have hmass := (logarithmicPrimeMass_bounds hN).2
  have henergy := primeIncrementEnergy_le_reciprocal hN
  dsimp only [logarithmicPrimeMass] at hmass
  have hscaled := mul_le_mul_of_nonneg_left hmass hlog
  nlinarith

theorem prime_energy_upper_chebyshev {N : ℕ} (hN : 1 ≤ N) :
    discretePrimeErrorEnergy N ≤ 2 * primeErrorDrift N +
      (Real.log (N : ℝ) ^ 2 + (4 * Real.log 2 + 1) * Real.log (N : ℝ) + 1) :=
  (prime_energy_upper N).trans
    (add_le_add_left (primeIncrementEnergy_le_chebyshev hN) _)

theorem logarithmicPrimeMass_sub_harmonic_bounds {N : ℕ} (hN : 1 ≤ N) :
    -2 ≤ logarithmicPrimeMass N - (harmonic N : ℝ) ∧
    logarithmicPrimeMass N - (harmonic N : ℝ) ≤ 4 * Real.log 2 := by
  have hb := logarithmicPrimeMass_bounds hN
  have hupper := harmonic_le_one_add_log N
  have hlower : Real.log (N : ℝ) ≤ (harmonic N : ℝ) := by
    simpa using log_le_harmonic_floor (N : ℝ) (Nat.cast_nonneg N)
  constructor <;> linarith

theorem integerError_partial_summation (v : ℕ → ℝ) (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, integerError n * (v n - v (n + 1))) =
      (∑ n ∈ Finset.Icc 1 N, primeIncrement n * v n) - integerError N * v (N + 1) := by
  induction N with
  | zero => simp [integerError_zero]
  | succ N ih =>
    simp only [Finset.sum_Icc_succ_top (by omega : 1 ≤ N + 1), ih, integerError_succ]
    ring

noncomputable def signedPrimeErrorAverage (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, integerError n / ((n : ℝ) * ((n : ℝ) + 1))

theorem signedPrimeErrorAverage_eq (N : ℕ) :
    signedPrimeErrorAverage N = logarithmicPrimeMass N - (harmonic N : ℝ) -
      integerError N / ((N : ℝ) + 1) := by
  have hh := integerError_partial_summation (fun n => 1 / (n : ℝ)) N
  have he : ∀ n ∈ Finset.Icc 1 N,
      integerError n * ((1 : ℝ) / n - 1 / (n + 1 : ℕ)) =
        integerError n / ((n : ℝ) * ((n : ℝ) + 1)) := by
    intro n hn
    have hn0 : (0 : ℝ) < n := by exact_mod_cast (Finset.mem_Icc.mp hn).1
    push_cast
    field_simp
    ring
  rw [Finset.sum_congr rfl he] at hh
  change signedPrimeErrorAverage N = _ at hh
  rw [show (∑ n ∈ Finset.Icc 1 N, primeIncrement n * ((1 : ℝ) / n)) =
      logarithmicPrimeMass N - (harmonic N : ℝ) by
    unfold primeIncrement logarithmicPrimeMass
    simp_rw [sub_mul, one_mul, ← div_eq_mul_one_div]
    rw [Finset.sum_sub_distrib]
    congr 1
    simp [harmonic_eq_sum_Icc]] at hh
  simpa only [Nat.cast_add, Nat.cast_one, mul_one_div] using hh

theorem integerError_normalized_bounds (N : ℕ) :
    -1 ≤ integerError N / ((N : ℝ) + 1) ∧
    integerError N / ((N : ℝ) + 1) ≤ 4 * Real.log 2 := by
  have hn : (0 : ℝ) < (N : ℝ) + 1 := by positivity
  have hc : 0 ≤ 4 * Real.log (2 : ℝ) := by positivity
  have hpsi0 : 0 ≤ psi N := by
    rw [psi_eq_sum_Icc]
    exact Finset.sum_nonneg (fun _ _ => ArithmeticFunction.vonMangoldt_nonneg)
  have hpsi := psi_le_linear N
  unfold integerError
  constructor
  · apply (le_div_iff₀ hn).mpr
    nlinarith
  · apply (div_le_iff₀ hn).mpr
    nlinarith [Nat.cast_nonneg (α := ℝ) N]

/-- An unconditional bounded signed first moment of the actual prime error.
It does not bound the squared error or imply RH. -/
theorem signedPrimeErrorAverage_abs_le (N : ℕ) :
    |signedPrimeErrorAverage N| ≤ 2 + 4 * Real.log 2 := by
  by_cases hN : 1 ≤ N
  · rw [signedPrimeErrorAverage_eq, abs_le]
    have ha := logarithmicPrimeMass_sub_harmonic_bounds hN
    have hb := integerError_normalized_bounds N
    constructor <;> linarith
  · have hzero : N = 0 := by omega
    subst N
    simp [signedPrimeErrorAverage]
    positivity

end BuildingBlocks
