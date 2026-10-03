import BuildingBlocks.ActualProperPrimePowerForcing
import Mathlib.NumberTheory.AbelSummation
import Mathlib.MeasureTheory.Integral.IntervalIntegral.IntegrationByParts

/-!
Exact actual continuous predictable-work balance and ordinary/proper work consumer.
The finite balance and literal source split hold for every real fixed center,
every real sigma and real cutoff Y >= 1. The absorbed consumer additionally
requires sigma >= 1/2 and eta > 0, with no signed or energy upper assumed.
The final target retains all Mangoldt atoms, the initial head and inclusive terminal.
No independent signed arithmetic upper or RH conclusion is asserted.
-/

open Set MeasureTheory
open scoped Interval BigOperators

namespace BuildingBlocks.ActualContinuousWorkBalance

open CoarsePrimitive

noncomputable def squareJump (n : ℕ) : ℝ := psi n ^ 2 - psi (n - 1) ^ 2

theorem psi_zero : psi 0 = 0 := by simp [psi]

theorem psi_one : psi 1 = 0 := by norm_num [psi, Finset.sum_range_succ]

theorem squareJump_zero : squareJump 0 = 0 := by simp [squareJump]

theorem squareJump_one : squareJump 1 = 0 := by simp [squareJump, psi_one, psi_zero]

theorem actual_square_jump {n : ℕ} (hn : 1 ≤ n) :
    squareJump n = 2 * ArithmeticFunction.vonMangoldt n * psi (n - 1) +
      ArithmeticFunction.vonMangoldt n ^ 2 := by
  have hs := psi_succ (n - 1)
  rw [Nat.sub_add_cancel hn] at hs
  rw [squareJump, hs]
  ring

theorem squareJump_prefix (N : ℕ) :
    (∑ n ∈ Finset.Icc 0 N, squareJump n) = psi N ^ 2 := by
  induction N with
  | zero => simp [squareJump_zero, psi_zero]
  | succ N ih =>
    rw [Finset.sum_Icc_succ_top (by omega : 0 ≤ N + 1), ih]
    simp only [squareJump, Nat.add_sub_cancel]
    ring

theorem actual_lambda_prefix (N : ℕ) :
    (∑ n ∈ Finset.Icc 0 N, ArithmeticFunction.vonMangoldt n) = psi N := by
  have hs : Finset.Icc 0 N = Finset.range (N + 1) := by ext n; simp; omega
  rw [hs, psi]

theorem finite_abel_positive {Y : ℝ} (hY : 1 ≤ Y)
    (a : ℕ → ℝ) (ha0 : a 0 = 0) (ha1 : a 1 = 0)
    (F D : ℝ → ℝ) (hD : ContinuousOn D (Icc 1 Y))
    (hd : ∀ t ∈ Icc 1 Y, HasDerivAt F (D t) t) :
    (∑ n ∈ Finset.Icc 2 ⌊Y⌋₊, a n * F n) =
      F Y * (∑ n ∈ Finset.Icc 0 ⌊Y⌋₊, a n) -
        (∫ t in (1 : ℝ)..Y, D t * ∑ n ∈ Finset.Icc 0 ⌊t⌋₊, a n) := by
  have hint : IntegrableOn (deriv F) (Icc 1 Y) :=
    hD.integrableOn_Icc.congr_fun (fun t ht => (hd t ht).deriv.symm) measurableSet_Icc
  have hh := sum_mul_eq_sub_integral_mul₀ a ha0 Y
    (fun t ht => (hd t ht).differentiableAt) hint
  have hsum : (∑ n ∈ Finset.Icc 0 ⌊Y⌋₊, F n * a n) =
      ∑ n ∈ Finset.Icc 2 ⌊Y⌋₊, a n * F n := by
    symm
    calc
      (∑ n ∈ Finset.Icc 2 ⌊Y⌋₊, a n * F n) =
          ∑ n ∈ Finset.Icc 0 ⌊Y⌋₊, a n * F n := by
        apply Finset.sum_subset (Finset.Icc_subset_Icc (by omega) le_rfl)
        intro n hn hnnot
        have hn' := Finset.mem_Icc.mp hn
        have hnsmall : n = 0 ∨ n = 1 := by
          have : ¬(2 ≤ n ∧ n ≤ ⌊Y⌋₊) := by simpa only [Finset.mem_Icc] using hnnot
          omega
        rcases hnsmall with rfl | rfl <;> simp [ha0, ha1]
      _ = _ := by apply Finset.sum_congr rfl; intro n _; ring
  rw [hsum] at hh
  rw [setIntegral_congr_fun measurableSet_Ioc
    (g := fun t => D t * ∑ n ∈ Finset.Icc 0 ⌊t⌋₊, a n)
    (fun t ht => by rw [(hd t ⟨ht.1.le, ht.2⟩).deriv])] at hh
  simpa only [intervalIntegral.integral_of_le hY] using hh

noncomputable def powerWeight (sigma t : ℝ) : ℝ := t ^ (-2 * sigma)

noncomputable def powerWeightDerivative (sigma t : ℝ) : ℝ :=
  (-2 * sigma) * t ^ (-1 - 2 * sigma)

noncomputable def linearWeight (c sigma t : ℝ) : ℝ := (c - t) * powerWeight sigma t

noncomputable def linearWeightDerivative (c sigma t : ℝ) : ℝ :=
  -powerWeight sigma t + (c - t) * powerWeightDerivative sigma t

noncomputable def baselineStorage (c sigma t : ℝ) : ℝ := (c - t) ^ 2 * powerWeight sigma t

noncomputable def baselineStorageDerivative (c sigma t : ℝ) : ℝ :=
  -2 * (c - t) * powerWeight sigma t + (c - t) ^ 2 * powerWeightDerivative sigma t

theorem powerWeight_hasDerivAt (sigma : ℝ) {t : ℝ} (ht : 0 < t) :
    HasDerivAt (powerWeight sigma) (powerWeightDerivative sigma t) t := by
  unfold powerWeight powerWeightDerivative
  have hh := Real.hasDerivAt_rpow_const (x := t) (p := -2 * sigma) (Or.inl (ne_of_gt ht))
  rw [show (-2 * sigma - 1 : ℝ) = -1 - 2 * sigma by ring] at hh
  exact hh

theorem linearWeight_hasDerivAt (c sigma : ℝ) {t : ℝ} (ht : 0 < t) :
    HasDerivAt (linearWeight c sigma) (linearWeightDerivative c sigma t) t := by
  convert ((hasDerivAt_const t c).sub (hasDerivAt_id t)).mul
    (powerWeight_hasDerivAt sigma ht) using 1 <;> simp [linearWeight, linearWeightDerivative]

theorem baselineStorage_hasDerivAt (c sigma : ℝ) {t : ℝ} (ht : 0 < t) :
    HasDerivAt (baselineStorage c sigma) (baselineStorageDerivative c sigma t) t := by
  convert (((hasDerivAt_const t c).sub (hasDerivAt_id t)).pow 2).mul
    (powerWeight_hasDerivAt sigma ht) using 1 <;>
    simp [baselineStorage, baselineStorageDerivative] <;> ring

theorem powerWeight_continuousOn {Y : ℝ} (hY : 1 ≤ Y) (sigma : ℝ) :
    ContinuousOn (powerWeight sigma) (Icc 1 Y) := by
  apply continuousOn_id.rpow_const
  intro t ht
  exact Or.inl (ne_of_gt (by linarith [ht.1] : 0 < t))

theorem powerWeightDerivative_continuousOn {Y : ℝ} (hY : 1 ≤ Y) (sigma : ℝ) :
    ContinuousOn (powerWeightDerivative sigma) (Icc 1 Y) := by
  apply continuousOn_const.mul
  apply continuousOn_id.rpow_const
  intro t ht
  exact Or.inl (ne_of_gt (by linarith [ht.1] : 0 < t))

theorem linearWeightDerivative_continuousOn {Y : ℝ} (hY : 1 ≤ Y) (c sigma : ℝ) :
    ContinuousOn (linearWeightDerivative c sigma) (Icc 1 Y) :=
  (powerWeight_continuousOn hY sigma).neg.add
    ((continuousOn_const.sub continuousOn_id).mul (powerWeightDerivative_continuousOn hY sigma))

theorem baselineStorageDerivative_continuousOn {Y : ℝ} (hY : 1 ≤ Y) (c sigma : ℝ) :
    ContinuousOn (baselineStorageDerivative c sigma) (Icc 1 Y) :=
  ((continuousOn_const.mul (continuousOn_const.sub continuousOn_id)).mul
    (powerWeight_continuousOn hY sigma)).add
    (((continuousOn_const.sub continuousOn_id).pow 2).mul (powerWeightDerivative_continuousOn hY sigma))

theorem actual_square_abel {Y : ℝ} (hY : 1 ≤ Y) (sigma : ℝ) :
    (∑ n ∈ Finset.Icc 2 ⌊Y⌋₊, squareJump n * powerWeight sigma n) =
      powerWeight sigma Y * psi ⌊Y⌋₊ ^ 2 -
        (∫ t in (1 : ℝ)..Y, powerWeightDerivative sigma t * psi ⌊t⌋₊ ^ 2) := by
  simpa only [squareJump_prefix] using finite_abel_positive hY squareJump squareJump_zero squareJump_one
    (powerWeight sigma) (powerWeightDerivative sigma) (powerWeightDerivative_continuousOn hY sigma)
    (fun t ht => powerWeight_hasDerivAt sigma (by linarith [ht.1]))

theorem actual_linear_abel {Y : ℝ} (hY : 1 ≤ Y) (c sigma : ℝ) :
    (∑ n ∈ Finset.Icc 2 ⌊Y⌋₊, ArithmeticFunction.vonMangoldt n * linearWeight c sigma n) =
      linearWeight c sigma Y * psi ⌊Y⌋₊ -
        (∫ t in (1 : ℝ)..Y, linearWeightDerivative c sigma t * psi ⌊t⌋₊) := by
  simpa only [actual_lambda_prefix] using finite_abel_positive hY ArithmeticFunction.vonMangoldt
    (by simp) (by simp) (linearWeight c sigma) (linearWeightDerivative c sigma)
    (linearWeightDerivative_continuousOn hY c sigma)
    (fun t ht => linearWeight_hasDerivAt c sigma (by linarith [ht.1]))

theorem actual_baseline_ftc {Y : ℝ} (hY : 1 ≤ Y) (c sigma : ℝ) :
    (∫ t in (1 : ℝ)..Y, baselineStorageDerivative c sigma t) =
      baselineStorage c sigma Y - (c - 1) ^ 2 := by
  have hi : IntervalIntegrable (baselineStorageDerivative c sigma) volume 1 Y := by
    rw [intervalIntegrable_iff_integrableOn_Icc_of_le hY]
    exact (baselineStorageDerivative_continuousOn hY c sigma).integrableOn_Icc
  have hh := intervalIntegral.integral_eq_sub_of_hasDerivAt
    (f := baselineStorage c sigma)
    (fun t ht => baselineStorage_hasDerivAt c sigma (by
      rw [uIcc_of_le hY] at ht; linarith [ht.1])) hi
  simpa only [baselineStorage, powerWeight, Real.one_rpow, mul_one] using hh

theorem actual_density_work_intervalIntegrable {Y : ℝ} (hY : 1 ≤ Y) (c sigma : ℝ) :
    IntervalIntegrable (fun t => (psi ⌊t⌋₊ - t + c) * t ^ (-2 * sigma)) volume 1 Y := by
  have hc : ContinuousOn (powerWeight sigma) (uIcc 1 Y) := by
    rw [uIcc_of_le hY]; exact powerWeight_continuousOn hY sigma
  simpa only [powerWeight, ActualPrimeErrorCausalTrace.centeredError, primeErrorReal] using
    (ActualPrimeErrorCausalTrace.centeredError_intervalIntegrable c 1 Y).mul_continuousOn hc

theorem actual_unnormalized_energy_intervalIntegrable {Y : ℝ} (hY : 1 ≤ Y) (c sigma : ℝ) :
    IntervalIntegrable (fun t => (psi ⌊t⌋₊ - t + c) ^ 2 * t ^ (-1 - 2 * sigma)) volume 1 Y := by
  apply (ActualProperPowerEnergyAllocation.energyDensity_full_intervalIntegrable hY c sigma).congr
  intro t ht
  rw [uIoc_of_le hY] at ht
  exact ActualPrimeErrorCausalTrace.energyDensity_eq c sigma t (by linarith [ht.1])

theorem derivative_combination (c sigma t : ℝ) :
    powerWeightDerivative sigma t * psi ⌊t⌋₊ ^ 2 +
      2 * (linearWeightDerivative c sigma t * psi ⌊t⌋₊) +
      baselineStorageDerivative c sigma t =
    -2 * ((psi ⌊t⌋₊ - t + c) * t ^ (-2 * sigma)) -
      2 * sigma * ((psi ⌊t⌋₊ - t + c) ^ 2 * t ^ (-1 - 2 * sigma)) := by
  simp only [linearWeightDerivative, baselineStorageDerivative, powerWeightDerivative, powerWeight]
  ring

theorem actual_predictable_work_balance_unrestricted (c sigma Y : ℝ) (hY : 1 ≤ Y) :
    ((1 : ℝ) / 2) * Y ^ (-2 * sigma) * (psi ⌊Y⌋₊ - Y + c) ^ 2 +
      sigma * (∫ t in (1 : ℝ)..Y,
        ((psi ⌊t⌋₊ - t + c) / t) ^ 2 * t ^ (1 - 2 * sigma)) =
    (c - 1) ^ 2 / 2 +
      ((∑ n ∈ Finset.Icc 2 ⌊Y⌋₊,
          ArithmeticFunction.vonMangoldt n * (n : ℝ) ^ (-2 * sigma) *
            (psi (n - 1) - (n : ℝ) + c)) -
        (∫ t in (1 : ℝ)..Y, (psi ⌊t⌋₊ - t + c) * t ^ (-2 * sigma))) +
      ((1 : ℝ) / 2) * (∑ n ∈ Finset.Icc 2 ⌊Y⌋₊,
        ArithmeticFunction.vonMangoldt n ^ 2 * (n : ℝ) ^ (-2 * sigma)) := by
  have hq := actual_square_abel hY sigma
  have hl := actual_linear_abel hY c sigma
  have hb := actual_baseline_ftc hY c sigma
  have hqi : IntervalIntegrable (fun t => powerWeightDerivative sigma t * psi ⌊t⌋₊ ^ 2)
      volume 1 Y := by
    rw [intervalIntegrable_iff_integrableOn_Icc_of_le hY]
    have hi := integrableOn_mul_sum_Icc squareJump (m := 0) (by norm_num : (0 : ℝ) ≤ 1)
      (powerWeightDerivative_continuousOn hY sigma).integrableOn_Icc
    simpa only [squareJump_prefix] using hi
  have hli : IntervalIntegrable (fun t => linearWeightDerivative c sigma t * psi ⌊t⌋₊)
      volume 1 Y := by
    rw [intervalIntegrable_iff_integrableOn_Icc_of_le hY]
    have hi := integrableOn_mul_sum_Icc ArithmeticFunction.vonMangoldt (m := 0) (by norm_num : (0 : ℝ) ≤ 1)
      (linearWeightDerivative_continuousOn hY c sigma).integrableOn_Icc
    simpa only [actual_lambda_prefix] using hi
  have hbi : IntervalIntegrable (baselineStorageDerivative c sigma) volume 1 Y := by
    rw [intervalIntegrable_iff_integrableOn_Icc_of_le hY]
    exact (baselineStorageDerivative_continuousOn hY c sigma).integrableOn_Icc
  have hint : (∫ t in (1 : ℝ)..Y,
      powerWeightDerivative sigma t * psi ⌊t⌋₊ ^ 2 +
        2 * (linearWeightDerivative c sigma t * psi ⌊t⌋₊) + baselineStorageDerivative c sigma t) =
      -2 * (∫ t in (1 : ℝ)..Y, (psi ⌊t⌋₊ - t + c) * t ^ (-2 * sigma)) -
        2 * sigma * (∫ t in (1 : ℝ)..Y,
          (psi ⌊t⌋₊ - t + c) ^ 2 * t ^ (-1 - 2 * sigma)) := by
    simp_rw [derivative_combination]
    rw [intervalIntegral.integral_sub
      ((actual_density_work_intervalIntegrable hY c sigma).const_mul (-2))
      ((actual_unnormalized_energy_intervalIntegrable hY c sigma).const_mul (2 * sigma)),
      intervalIntegral.integral_const_mul, intervalIntegral.integral_const_mul]
  rw [intervalIntegral.integral_add (hqi.add (hli.const_mul 2)) hbi,
    intervalIntegral.integral_add hqi (hli.const_mul 2),
    intervalIntegral.integral_const_mul] at hint
  have hnorm : (∫ t in (1 : ℝ)..Y,
      ((psi ⌊t⌋₊ - t + c) / t) ^ 2 * t ^ (1 - 2 * sigma)) =
      ∫ t in (1 : ℝ)..Y, (psi ⌊t⌋₊ - t + c) ^ 2 * t ^ (-1 - 2 * sigma) := by
    apply intervalIntegral.integral_congr
    intro t ht
    rw [uIcc_of_le hY] at ht
    exact ActualPrimeErrorCausalTrace.energyDensity_eq c sigma t (by linarith [ht.1])
  have hjump : (∑ n ∈ Finset.Icc 2 ⌊Y⌋₊, squareJump n * powerWeight sigma n) +
      2 * (∑ n ∈ Finset.Icc 2 ⌊Y⌋₊, ArithmeticFunction.vonMangoldt n * linearWeight c sigma n) =
      2 * (∑ n ∈ Finset.Icc 2 ⌊Y⌋₊,
        ArithmeticFunction.vonMangoldt n * (n : ℝ) ^ (-2 * sigma) *
          (psi (n - 1) - (n : ℝ) + c)) +
        (∑ n ∈ Finset.Icc 2 ⌊Y⌋₊,
          ArithmeticFunction.vonMangoldt n ^ 2 * (n : ℝ) ^ (-2 * sigma)) := by
    rw [Finset.mul_sum, ← Finset.sum_add_distrib, Finset.mul_sum, ← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro n hn
    rw [actual_square_jump (by have := (Finset.mem_Icc.mp hn).1; omega)]
    unfold linearWeight powerWeight
    ring
  rw [hnorm]
  simp only [linearWeight, baselineStorage, powerWeight] at hq hl hb hjump
  nlinarith [hq, hl, hb, hint, hjump]

theorem actual_predictable_work_balance (c sigma Y : ℝ)
    (hsigma : (1 : ℝ) / 2 ≤ sigma) (hY : 1 ≤ Y) :
    ((1 : ℝ) / 2) * Y ^ (-2 * sigma) * (psi ⌊Y⌋₊ - Y + c) ^ 2 +
      sigma * (∫ t in (1 : ℝ)..Y,
        ((psi ⌊t⌋₊ - t + c) / t) ^ 2 * t ^ (1 - 2 * sigma)) =
    (c - 1) ^ 2 / 2 +
      ((∑ n ∈ Finset.Icc 2 ⌊Y⌋₊,
          ArithmeticFunction.vonMangoldt n * (n : ℝ) ^ (-2 * sigma) *
            (psi (n - 1) - (n : ℝ) + c)) -
        (∫ t in (1 : ℝ)..Y, (psi ⌊t⌋₊ - t + c) * t ^ (-2 * sigma))) +
      ((1 : ℝ) / 2) * (∑ n ∈ Finset.Icc 2 ⌊Y⌋₊,
        ArithmeticFunction.vonMangoldt n ^ 2 * (n : ℝ) ^ (-2 * sigma)) :=
  actual_predictable_work_balance_unrestricted c sigma Y hY

end BuildingBlocks.ActualContinuousWorkBalance

/-!
Literal ordinary-prime/proper-power splitting and finite Young consumer.
The complete ordinary work is explicitly defined from actual primes and full psi.
It is retained on the right; no independent upper or RH estimate is asserted.
-/

namespace BuildingBlocks.ActualOrdinaryPrimeWorkConsumer

open CoarsePrimitive ActualPrimePowerWindowGeometry ActualProperPowerEnergyAllocation
open ActualProperPrimePowerForcing

noncomputable def ordinaryPrimes (Y : ℝ) : Finset ℕ :=
  (Finset.Icc 2 ⌊Y⌋₊).filter Nat.Prime

noncomputable def properIntegers (Y : ℝ) : Finset ℕ := by
  classical
  exact (Finset.Icc 2 ⌊Y⌋₊).filter ActualProperPrimePower

noncomputable def properRows (Y : ℝ) : Finset (Σ _ : ℕ, ℕ) :=
  (Finset.Icc 2 ⌊Y⌋₊).sigma (fun k => primeBases Y k)

noncomputable def workRow (c sigma : ℝ) (n : ℕ) : ℝ :=
  ArithmeticFunction.vonMangoldt n * (n : ℝ) ^ (-2 * sigma) *
    (psi (n - 1) - (n : ℝ) + c)

noncomputable def densityWork (c sigma Y : ℝ) : ℝ :=
  ∫ t in (1 : ℝ)..Y, (psi ⌊t⌋₊ - t + c) * t ^ (-2 * sigma)

noncomputable def predictableWork (c sigma Y : ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 2 ⌊Y⌋₊, workRow c sigma n) - densityWork c sigma Y

noncomputable def ordinaryWork (c sigma Y : ℝ) : ℝ :=
  (∑ n ∈ ordinaryPrimes Y, workRow c sigma n) - densityWork c sigma Y

noncomputable def diagonal (sigma Y : ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 2 ⌊Y⌋₊,
    ArithmeticFunction.vonMangoldt n ^ 2 * (n : ℝ) ^ (-2 * sigma)

noncomputable def terminalStorage (c sigma Y : ℝ) : ℝ :=
  ((1 : ℝ) / 2) * Y ^ (-2 * sigma) * (psi ⌊Y⌋₊ - Y + c) ^ 2

theorem mem_ordinaryPrimes {Y : ℝ} {n : ℕ} :
    n ∈ ordinaryPrimes Y ↔ 2 ≤ n ∧ n ≤ ⌊Y⌋₊ ∧ n.Prime := by
  simp only [ordinaryPrimes, Finset.mem_filter, Finset.mem_Icc]
  tauto

theorem mem_properIntegers {Y : ℝ} {n : ℕ} :
    n ∈ properIntegers Y ↔ 2 ≤ n ∧ n ≤ ⌊Y⌋₊ ∧ ActualProperPrimePower n := by
  classical
  simp only [properIntegers, Finset.mem_filter, Finset.mem_Icc]
  tauto

theorem proper_iff_primePow_nonprime (n : ℕ) :
    ActualProperPrimePower n ↔ IsPrimePow n ∧ ¬n.Prime := by
  constructor
  · rintro ⟨p, k, hp, hk, rfl⟩
    exact ⟨(isPrimePow_nat_iff _).2 ⟨p, k, hp, by omega, rfl⟩,
      Nat.Prime.not_prime_pow hk⟩
  · rintro ⟨hn, hnot⟩
    obtain ⟨p, k, hp, hk, hn⟩ := (isPrimePow_nat_iff n).1 hn
    have hk1 : k ≠ 1 := by
      intro he
      rw [he, pow_one] at hn
      exact hnot (hn ▸ hp)
    exact ⟨p, k, hp, by omega, hn⟩

theorem actual_lambda_zero_outside_prime_or_proper {n : ℕ}
    (hprime : ¬n.Prime) (hproper : ¬ActualProperPrimePower n) :
    ArithmeticFunction.vonMangoldt n = 0 := by
  apply ArithmeticFunction.vonMangoldt_eq_zero_iff.mpr
  intro hn
  exact hproper ((proper_iff_primePow_nonprime n).2 ⟨hn, hprime⟩)

theorem actual_lambda_prime_proper_split (Y : ℝ) (f : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 2 ⌊Y⌋₊, ArithmeticFunction.vonMangoldt n * f n) =
      (∑ n ∈ ordinaryPrimes Y, ArithmeticFunction.vonMangoldt n * f n) +
        (∑ n ∈ properIntegers Y, ArithmeticFunction.vonMangoldt n * f n) := by
  classical
  have he := Finset.sum_filter_add_sum_filter_not (Finset.Icc 2 ⌊Y⌋₊) Nat.Prime
    (fun n => ArithmeticFunction.vonMangoldt n * f n)
  have hp : (∑ n ∈ (Finset.Icc 2 ⌊Y⌋₊).filter (fun n => ¬n.Prime),
      ArithmeticFunction.vonMangoldt n * f n) =
      ∑ n ∈ properIntegers Y, ArithmeticFunction.vonMangoldt n * f n := by
    symm
    apply Finset.sum_subset
    · intro n hn
      obtain ⟨hnI, hnP⟩ := Finset.mem_filter.mp hn
      exact Finset.mem_filter.mpr ⟨hnI, ((proper_iff_primePow_nonprime n).1 hnP).2⟩
    · intro n hn hnnot
      have hnnotP : ¬ActualProperPrimePower n := by
        intro h
        exact hnnot (Finset.mem_filter.mpr ⟨(Finset.mem_filter.mp hn).1, h⟩)
      rw [actual_lambda_zero_outside_prime_or_proper (Finset.mem_filter.mp hn).2 hnnotP, zero_mul]
  simpa only [ordinaryPrimes, hp] using he.symm

theorem actual_proper_weighted_reindex {Y : ℝ} (hY : 1 ≤ Y) (f : ℕ → ℝ) :
    (∑ n ∈ properIntegers Y, f n) =
      ∑ k ∈ Finset.Icc 2 ⌊Y⌋₊, ∑ p ∈ primeBases Y k, f (p ^ k) := by
  classical
  have he : (∑ row ∈ properRows Y, f (row.2 ^ row.1)) =
      ∑ n ∈ properIntegers Y, f n := by
    apply Finset.sum_bij (fun row _ => row.2 ^ row.1)
    · intro row hr
      obtain ⟨hk, hp⟩ := Finset.mem_sigma.mp hr
      have hm := mem_primeBases.mp hp
      have hn4 := four_le_prime_pow hm.2.2.1 (Finset.mem_Icc.mp hk).1
      exact mem_properIntegers.mpr ⟨by omega, hm.2.2.2,
        ⟨row.2, row.1, hm.2.2.1, (Finset.mem_Icc.mp hk).1, rfl⟩⟩
    · intro row hr other ho hpow
      obtain ⟨hk, hp⟩ := Finset.mem_sigma.mp hr
      obtain ⟨hl, hq⟩ := Finset.mem_sigma.mp ho
      obtain ⟨hpq, hkl⟩ := prime_power_representation_unique (mem_primeBases.mp hp).2.2.1
        (mem_primeBases.mp hq).2.2.1 (Finset.mem_Icc.mp hk).1 (Finset.mem_Icc.mp hl).1 hpow
      rcases row with ⟨k, p⟩
      rcases other with ⟨l, q⟩
      dsimp only at hpq hkl
      subst l
      subst q
      rfl
    · intro n hn
      have hm := mem_properIntegers.mp hn
      have hnY : (n : ℝ) ≤ Y := (Nat.le_floor_iff (by linarith : 0 ≤ Y)).mp hm.2.1
      obtain ⟨k, hk, p, hp, hpow⟩ := (actual_full_enumeration_iff hY n).1 ⟨hm.2.2, hnY⟩
      exact ⟨⟨k, p⟩, Finset.mem_sigma.mpr ⟨hk, hp⟩, hpow⟩
    · intro row _
      rfl
  rw [← he]
  exact Finset.sum_sigma _ _ _

theorem work_atom_normalization (mass e sigma n : ℝ) (hn : 0 < n) :
    (mass * n ^ (1 - 2 * sigma)) * (e / n) = mass * n ^ (-2 * sigma) * e := by
  rw [show (1 - 2 * sigma : ℝ) = (-2 * sigma) + 1 by ring,
    Real.rpow_add hn, Real.rpow_one]
  field_simp

theorem actual_proper_rows_eq_existing_force {Y : ℝ} (hY : 1 ≤ Y) (c sigma : ℝ) :
    (∑ n ∈ properIntegers Y, workRow c sigma n) = signedProperPowerForce c sigma Y := by
  rw [actual_proper_weighted_reindex hY (workRow c sigma),
    signedProperPowerForce_eq_actualLambda_sum]
  apply Finset.sum_congr rfl
  intro k hk
  apply Finset.sum_congr rfl
  intro p hp
  have hn0 : (0 : ℝ) < ((p ^ k : ℕ) : ℝ) := by
    have hp0 : 0 < p := (mem_primeBases.mp hp).2.2.1.pos
    exact_mod_cast (Nat.pow_pos hp0 : 0 < p ^ k)
  unfold workRow
  exact (work_atom_normalization (ArithmeticFunction.vonMangoldt (p ^ k))
    (psi (p ^ k - 1) - ((p ^ k : ℕ) : ℝ) + c) sigma ((p ^ k : ℕ) : ℝ) hn0).symm

theorem actual_all_work_rows_eq_prime_plus_proper {Y : ℝ} (hY : 1 ≤ Y) (c sigma : ℝ) :
    (∑ n ∈ Finset.Icc 2 ⌊Y⌋₊, workRow c sigma n) =
      (∑ n ∈ ordinaryPrimes Y, workRow c sigma n) + signedProperPowerForce c sigma Y := by
  have hs := actual_lambda_prime_proper_split Y
    (fun n => (n : ℝ) ^ (-2 * sigma) * (psi (n - 1) - (n : ℝ) + c))
  have hs' : (∑ n ∈ Finset.Icc 2 ⌊Y⌋₊, workRow c sigma n) =
      (∑ n ∈ ordinaryPrimes Y, workRow c sigma n) +
        (∑ n ∈ properIntegers Y, workRow c sigma n) := by
    simpa only [workRow, mul_assoc] using hs
  rw [actual_proper_rows_eq_existing_force hY c sigma] at hs'
  exact hs'

theorem actual_complete_work_split {Y : ℝ} (hY : 1 ≤ Y) (c sigma : ℝ) :
    predictableWork c sigma Y - ordinaryWork c sigma Y = signedProperPowerForce c sigma Y := by
  unfold predictableWork ordinaryWork
  rw [actual_all_work_rows_eq_prime_plus_proper hY c sigma]
  ring

theorem actual_complete_work_split_literal {Y : ℝ} (hY : 1 ≤ Y) (c sigma : ℝ) :
    ((∑ n ∈ Finset.Icc 2 ⌊Y⌋₊,
        ArithmeticFunction.vonMangoldt n * (n : ℝ) ^ (-2 * sigma) *
          (psi (n - 1) - (n : ℝ) + c)) -
      (∫ t in (1 : ℝ)..Y, (psi ⌊t⌋₊ - t + c) * t ^ (-2 * sigma))) -
      ((∑ n ∈ (Finset.Icc 2 ⌊Y⌋₊).filter Nat.Prime,
        ArithmeticFunction.vonMangoldt n * (n : ℝ) ^ (-2 * sigma) *
          (psi (n - 1) - (n : ℝ) + c)) -
        (∫ t in (1 : ℝ)..Y, (psi ⌊t⌋₊ - t + c) * t ^ (-2 * sigma))) =
      signedProperPowerForce c sigma Y :=
  actual_complete_work_split hY c sigma

theorem actual_balance_in_work_notation {Y : ℝ} (hY : 1 ≤ Y) (c sigma : ℝ) :
    terminalStorage c sigma Y + sigma * fullEnergy c sigma Y =
      (c - 1) ^ 2 / 2 + predictableWork c sigma Y + diagonal sigma Y / 2 := by
  simpa only [terminalStorage, fullEnergy, energyDensity,
    ActualPrimeErrorCausalTrace.centeredError, primeErrorReal, predictableWork,
    workRow, densityWork, diagonal, div_eq_mul_inv, one_mul, mul_comm (2 : ℝ)⁻¹] using
    ActualContinuousWorkBalance.actual_predictable_work_balance_unrestricted c sigma Y hY

theorem actual_ordinary_prime_energy_consumer {Y : ℝ} (hY : 1 ≤ Y)
    (c sigma eta : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) (heta : 0 < eta) :
    terminalStorage c sigma Y + (sigma - eta) * fullEnergy c sigma Y ≤
      (c - 1) ^ 2 / 2 + ordinaryWork c sigma Y +
        (3000 + 144 / eta) * Real.log (2 * Y) ^ 2 + diagonal sigma Y / 2 := by
  have hb := actual_balance_in_work_notation hY c sigma
  have hs := actual_complete_work_split hY c sigma
  have hp := (le_abs_self (signedProperPowerForce c sigma Y)).trans
    (actual_signed_proper_power_force_young hY c sigma eta hsigma heta)
  linarith

theorem actual_ordinary_prime_energy_consumer_literal {Y : ℝ} (hY : 1 ≤ Y)
    (c sigma eta : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) (heta : 0 < eta) :
    ((1 : ℝ) / 2) * Y ^ (-2 * sigma) * (psi ⌊Y⌋₊ - Y + c) ^ 2 +
      (sigma - eta) * (∫ t in (1 : ℝ)..Y,
        ((psi ⌊t⌋₊ - t + c) / t) ^ 2 * t ^ (1 - 2 * sigma)) ≤
    (c - 1) ^ 2 / 2 +
      ((∑ n ∈ (Finset.Icc 2 ⌊Y⌋₊).filter Nat.Prime,
        ArithmeticFunction.vonMangoldt n * (n : ℝ) ^ (-2 * sigma) *
          (psi (n - 1) - (n : ℝ) + c)) -
        (∫ t in (1 : ℝ)..Y, (psi ⌊t⌋₊ - t + c) * t ^ (-2 * sigma))) +
      (3000 + 144 / eta) * Real.log (2 * Y) ^ 2 +
      ((1 : ℝ) / 2) * (∑ n ∈ Finset.Icc 2 ⌊Y⌋₊,
        ArithmeticFunction.vonMangoldt n ^ 2 * (n : ℝ) ^ (-2 * sigma)) := by
  simpa only [terminalStorage, fullEnergy, energyDensity,
    ActualPrimeErrorCausalTrace.centeredError, primeErrorReal, ordinaryWork,
    ordinaryPrimes, workRow, densityWork, diagonal, div_eq_mul_inv, one_mul, mul_comm (2 : ℝ)⁻¹] using
    actual_ordinary_prime_energy_consumer hY c sigma eta hsigma heta

end BuildingBlocks.ActualOrdinaryPrimeWorkConsumer

/-! Exact log-prime dictionary and displayed finite work consumer only. -/

namespace BuildingBlocks.ActualOrdinaryPrimeWorkConsumer

open CoarsePrimitive ActualProperPowerEnergyAllocation

theorem ordinaryWork_eq_log_prime_sum (c sigma Y : ℝ) :
    ordinaryWork c sigma Y =
      (∑ p ∈ ordinaryPrimes Y,
        (Real.log (p : ℝ) * (p : ℝ) ^ (1 - 2 * sigma)) *
          ((psi (p - 1) - (p : ℝ) + c) / (p : ℝ))) - densityWork c sigma Y := by
  unfold ordinaryWork
  congr 1
  apply Finset.sum_congr rfl
  intro p hp
  have hpPrime := (mem_ordinaryPrimes.mp hp).2.2
  rw [workRow, ArithmeticFunction.vonMangoldt_apply_prime hpPrime]
  exact (work_atom_normalization (Real.log (p : ℝ))
    (psi (p - 1) - (p : ℝ) + c) sigma (p : ℝ) (by exact_mod_cast hpPrime.pos)).symm

theorem actual_ordinary_prime_energy_consumer_log_literal {Y : ℝ} (hY : 1 ≤ Y)
    (c sigma eta : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) (heta : 0 < eta) :
    ((1 : ℝ) / 2) * Y ^ (-2 * sigma) * (psi ⌊Y⌋₊ - Y + c) ^ 2 +
      (sigma - eta) * (∫ t in (1 : ℝ)..Y,
        ((psi ⌊t⌋₊ - t + c) / t) ^ 2 * t ^ (1 - 2 * sigma)) ≤
    (c - 1) ^ 2 / 2 +
      ((∑ p ∈ (Finset.Icc 2 ⌊Y⌋₊).filter Nat.Prime,
        (Real.log (p : ℝ) * (p : ℝ) ^ (1 - 2 * sigma)) *
          ((psi (p - 1) - (p : ℝ) + c) / (p : ℝ))) -
        (∫ t in (1 : ℝ)..Y, (psi ⌊t⌋₊ - t + c) * t ^ (-2 * sigma))) +
      (3000 + 144 / eta) * Real.log (2 * Y) ^ 2 +
      ((1 : ℝ) / 2) * (∑ n ∈ Finset.Icc 2 ⌊Y⌋₊,
        ArithmeticFunction.vonMangoldt n ^ 2 * (n : ℝ) ^ (-2 * sigma)) := by
  have hh := actual_ordinary_prime_energy_consumer hY c sigma eta hsigma heta
  rw [ordinaryWork_eq_log_prime_sum] at hh
  simpa only [terminalStorage, fullEnergy, energyDensity,
    ActualPrimeErrorCausalTrace.centeredError, primeErrorReal, ordinaryPrimes,
    densityWork, diagonal, div_eq_mul_inv, one_mul, mul_comm (2 : ℝ)⁻¹] using hh

end BuildingBlocks.ActualOrdinaryPrimeWorkConsumer
