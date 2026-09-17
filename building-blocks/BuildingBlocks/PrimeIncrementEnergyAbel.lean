import BuildingBlocks.PrimeSignedAverage

open Finset
open scoped BigOperators

namespace BuildingBlocks

noncomputable def logarithmicPrimeSecondMass (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N,
    (ArithmeticFunction.vonMangoldt n / (n : ℝ)) * Real.log (n : ℝ)

noncomputable def logStep (k : ℕ) : ℝ :=
  Real.log ((k + 1 : ℕ) : ℝ) - Real.log (k : ℝ)

private theorem logarithmicPrimeMass_succ (N : ℕ) :
    logarithmicPrimeMass (N + 1) = logarithmicPrimeMass N +
      ArithmeticFunction.vonMangoldt (N + 1) / ((N + 1 : ℕ) : ℝ) := by
  simp only [logarithmicPrimeMass, Finset.sum_Icc_succ_top (by omega : 1 ≤ N + 1)]

private theorem logarithmicPrimeSecondMass_succ (N : ℕ) :
    logarithmicPrimeSecondMass (N + 1) = logarithmicPrimeSecondMass N +
      (ArithmeticFunction.vonMangoldt (N + 1) / ((N + 1 : ℕ) : ℝ)) *
        Real.log ((N + 1 : ℕ) : ℝ) := by
  simp only [logarithmicPrimeSecondMass,
    Finset.sum_Icc_succ_top (by omega : 1 ≤ N + 1)]

private theorem logStep_nonneg {k : ℕ} (hk : 1 ≤ k) : 0 ≤ logStep k := by
  unfold logStep
  apply sub_nonneg.mpr
  exact Real.log_le_log (by exact_mod_cast (show 0 < k by omega))
    (by exact_mod_cast (Nat.le_succ k))

private theorem logStep_le_one {k : ℕ} (hk : 1 ≤ k) : logStep k ≤ 1 := by
  have hkpos : (0 : ℝ) < (k : ℝ) := by exact_mod_cast (show 0 < k by omega)
  have hkone : (1 : ℝ) ≤ (k : ℝ) := by exact_mod_cast hk
  have hkp : (0 : ℝ) < ((k + 1 : ℕ) : ℝ) := by positivity
  have hlog := Real.log_le_sub_one_of_pos (div_pos hkp hkpos)
  have hfrac : (((k + 1 : ℕ) : ℝ) / (k : ℝ)) - 1 = 1 / (k : ℝ) := by
    push_cast
    field_simp
    ring
  have hrecip : 1 / (k : ℝ) ≤ 1 := by
    apply (div_le_iff₀ hkpos).mpr
    nlinarith
  unfold logStep
  rw [Real.log_div hkp.ne' hkpos.ne'] at hlog
  linarith

private theorem logStep_sum (N : ℕ) :
    (∑ k ∈ Finset.Ico 1 N, logStep k) = Real.log (N : ℝ) := by
  induction N with
  | zero => simp
  | succ N ih =>
    by_cases hN : N = 0
    · subst N
      simp
    · have hN1 : 1 ≤ N := by omega
      rw [Finset.sum_Ico_succ_top hN1, ih]
      unfold logStep
      ring

private theorem logStep_square_identity (N : ℕ) :
    2 * (∑ k ∈ Finset.Ico 1 N, Real.log (k : ℝ) * logStep k) +
      (∑ k ∈ Finset.Ico 1 N, logStep k ^ 2) = Real.log (N : ℝ) ^ 2 := by
  induction N with
  | zero => simp
  | succ N ih =>
    by_cases hN : N = 0
    · subst N
      simp
    · have hN1 : 1 ≤ N := by omega
      rw [Finset.sum_Ico_succ_top hN1, Finset.sum_Ico_succ_top hN1]
      have hstep : logStep N = Real.log ((N + 1 : ℕ) : ℝ) - Real.log (N : ℝ) := rfl
      rw [hstep]
      nlinarith [ih]

private theorem logStep_square_sum_le (N : ℕ) :
    (∑ k ∈ Finset.Ico 1 N, logStep k ^ 2) ≤ Real.log (N : ℝ) := by
  calc
    _ ≤ ∑ k ∈ Finset.Ico 1 N, logStep k := by
      apply Finset.sum_le_sum
      intro k hk
      have hk1 := (Finset.mem_Ico.mp hk).1
      nlinarith [logStep_nonneg hk1, logStep_le_one hk1]
    _ = _ := logStep_sum N

/-- Finite Abel summation with the terminal prime-power mass retained. -/
theorem logarithmicPrimeSecondMass_abel (N : ℕ) :
    logarithmicPrimeSecondMass N +
      (∑ k ∈ Finset.Ico 1 N, logarithmicPrimeMass k * logStep k) =
        logarithmicPrimeMass N * Real.log (N : ℝ) := by
  induction N with
  | zero => simp [logarithmicPrimeSecondMass, logarithmicPrimeMass]
  | succ N ih =>
    by_cases hN : N = 0
    · subst N
      simp [logarithmicPrimeSecondMass, logarithmicPrimeMass]
    · have hN1 : 1 ≤ N := by omega
      rw [logarithmicPrimeSecondMass_succ, logarithmicPrimeMass_succ,
        Finset.sum_Ico_succ_top hN1]
      have hstep : logStep N = Real.log ((N + 1 : ℕ) : ℝ) - Real.log (N : ℝ) := rfl
      rw [hstep]
      nlinarith [ih]

private theorem logarithmicPrimeMass_logStep_lower (N : ℕ) :
    Real.log (N : ℝ) ^ 2 / 2 - 3 * Real.log (N : ℝ) / 2 ≤
      ∑ k ∈ Finset.Ico 1 N, logarithmicPrimeMass k * logStep k := by
  have hterm : ∀ k ∈ Finset.Ico 1 N,
      (Real.log (k : ℝ) - 1) * logStep k ≤
        logarithmicPrimeMass k * logStep k := by
    intro k hk
    have hk1 := (Finset.mem_Ico.mp hk).1
    have hh := (logarithmicPrimeMass_bounds hk1).1
    exact mul_le_mul_of_nonneg_right hh (logStep_nonneg hk1)
  have hsum := Finset.sum_le_sum hterm
  simp_rw [sub_mul, one_mul] at hsum
  rw [Finset.sum_sub_distrib, logStep_sum] at hsum
  have hsq := logStep_square_identity N
  have hsqle := logStep_square_sum_le N
  nlinarith

theorem logarithmicPrimeSecondMass_le {N : ℕ} (hN : 1 ≤ N) :
    logarithmicPrimeSecondMass N ≤ Real.log (N : ℝ) ^ 2 / 2 +
      (4 * Real.log 2 + 3 / 2) * Real.log (N : ℝ) := by
  have hNreal : (1 : ℝ) ≤ (N : ℝ) := by exact_mod_cast hN
  have hlog : 0 ≤ Real.log (N : ℝ) := Real.log_nonneg hNreal
  have hmass := (logarithmicPrimeMass_bounds hN).2
  have hscaled := mul_le_mul_of_nonneg_right hmass hlog
  have habel := logarithmicPrimeSecondMass_abel N
  have hlower := logarithmicPrimeMass_logStep_lower N
  nlinarith

/-- Elementary two-sided reciprocal mass control gives a one-half
leading coefficient for the actual diagonal increment energy.
It supplies no bound on `primeErrorDrift`. -/
theorem primeIncrementEnergy_le_abel {N : ℕ} (hN : 1 ≤ N) :
    primeIncrementEnergy N ≤ Real.log (N : ℝ) ^ 2 / 2 +
      (4 * Real.log 2 + 1 / 2) * Real.log (N : ℝ) + 3 := by
  have hterm : ∀ n ∈ Finset.Icc 1 N,
      primeIncrement n ^ 2 / (n : ℝ) ≤
        (ArithmeticFunction.vonMangoldt n / (n : ℝ)) * Real.log (n : ℝ) -
          2 * (ArithmeticFunction.vonMangoldt n / (n : ℝ)) + (n : ℝ)⁻¹ := by
    intro n hn
    have hnpos : (0 : ℝ) < (n : ℝ) := by
      exact_mod_cast (Finset.mem_Icc.mp hn).1
    have hv0 : 0 ≤ ArithmeticFunction.vonMangoldt n :=
      ArithmeticFunction.vonMangoldt_nonneg
    have hv := ArithmeticFunction.vonMangoldt_le_log (n := n)
    have hsq : ArithmeticFunction.vonMangoldt n ^ 2 ≤
        ArithmeticFunction.vonMangoldt n * Real.log (n : ℝ) := by
      nlinarith [mul_le_mul_of_nonneg_left hv hv0]
    unfold primeIncrement
    calc
      _ ≤ (ArithmeticFunction.vonMangoldt n * Real.log (n : ℝ) -
          2 * ArithmeticFunction.vonMangoldt n + 1) / (n : ℝ) :=
        div_le_div_of_nonneg_right (by nlinarith) hnpos.le
      _ = _ := by ring
  have hsum : primeIncrementEnergy N ≤
      logarithmicPrimeSecondMass N - 2 * logarithmicPrimeMass N +
        (harmonic N : ℝ) := by
    calc
      primeIncrementEnergy N ≤ ∑ n ∈ Finset.Icc 1 N,
          ((ArithmeticFunction.vonMangoldt n / (n : ℝ)) * Real.log (n : ℝ) -
            2 * (ArithmeticFunction.vonMangoldt n / (n : ℝ)) + (n : ℝ)⁻¹) :=
        Finset.sum_le_sum hterm
      _ = _ := by
        rw [Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum]
        simp only [logarithmicPrimeSecondMass, logarithmicPrimeMass,
          harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast]
  have hmoment := logarithmicPrimeSecondMass_le hN
  have hmass := (logarithmicPrimeMass_bounds hN).1
  have hharmonic := harmonic_le_one_add_log N
  nlinarith

theorem prime_energy_upper_abel {N : ℕ} (hN : 1 ≤ N) :
    discretePrimeErrorEnergy N ≤ 2 * primeErrorDrift N +
      (Real.log (N : ℝ) ^ 2 / 2 +
        (4 * Real.log 2 + 1 / 2) * Real.log (N : ℝ) + 3) :=
  (prime_energy_upper N).trans
    (add_le_add_left (primeIncrementEnergy_le_abel hN) _)

end BuildingBlocks
