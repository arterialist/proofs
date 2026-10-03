import BuildingBlocks.ActualPrimePowerWindowGeometry
import BuildingBlocks.ActualPrimeErrorCausalTrace
import BuildingBlocks.PrimeIncrementEnergyAbel
import Mathlib.MeasureTheory.Integral.Bochner.Set
import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.Tactic
import Mathlib.Analysis.SpecialFunctions.Pow.Deriv
import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Mathlib.Algebra.BigOperators.Intervals

/-!
Complete forcing bounds for the actual proper prime powers. The final literal
targets hold for every real fixed center, sigma >= 1/2 and real cutoff Y >= 1.
Young absorption additionally requires only eta > 0. Actual row completeness,
integrability, energy allocation and the finite logarithmic tails are proved
internally. No supplied row list, tail evaluator, remainder or energy upper
is assumed. The full work balance and ordinary-prime signed upper are separate.
-/

open Set MeasureTheory
open scoped Interval BigOperators

namespace BuildingBlocks.ActualProperPowerEnergyAllocation

open CoarsePrimitive ActualPrimePowerWindowGeometry

noncomputable def primeBases (Y : ℝ) (k : ℕ) : Finset ℕ :=
  (Finset.Icc 2 ⌊Y⌋₊).filter (fun p => p.Prime ∧ p ^ k ≤ ⌊Y⌋₊)

noncomputable def energyDensity (c sigma t : ℝ) : ℝ :=
  (ActualPrimeErrorCausalTrace.centeredError c t / t) ^ 2 * t ^ (1 - 2 * sigma)

noncomputable def fullEnergy (c sigma Y : ℝ) : ℝ :=
  ∫ t in (1 : ℝ)..Y, energyDensity c sigma t

noncomputable def gradeCoefficient (sigma Y : ℝ) (k : ℕ) : ℝ :=
  ∑ p ∈ primeBases Y k,
    Real.log (p : ℝ) ^ 2 * ((p ^ k : ℕ) : ℝ) ^ ((1 : ℝ) / 2 - 2 * sigma)

noncomputable def gradeAbsoluteForce (c sigma Y : ℝ) (k : ℕ) : ℝ :=
  ∑ p ∈ primeBases Y k,
    (Real.log (p : ℝ) * ((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma)) *
      |ActualPrimeErrorCausalTrace.preError c (p ^ k) / ((p ^ k : ℕ) : ℝ)|

noncomputable def gradeRemainder (sigma Y : ℝ) (k : ℕ) : ℝ :=
  ∑ p ∈ primeBases Y k,
    Real.log (p : ℝ) * ((p ^ k : ℕ) : ℝ) ^ ((1 : ℝ) / 2 - 2 * sigma) *
      (1 + Real.log ((p ^ k : ℕ) : ℝ))

noncomputable def primeHarmonicSecondMass (Y : ℝ) : ℝ :=
  ∑ p ∈ primeBases Y 2, Real.log (p : ℝ) ^ 2 / (p : ℝ)

noncomputable def geometricDecay (k : ℕ) : ℝ :=
  (2 : ℝ) ^ (-((k - 2 : ℕ) : ℝ) / 2)

noncomputable def gradeGeometricRatio : ℝ := (2 : ℝ) ^ (-(1 : ℝ) / 4)

noncomputable def fullAbsoluteForce (c sigma Y : ℝ) : ℝ :=
  ∑ k ∈ Finset.Icc 2 ⌊Y⌋₊, gradeAbsoluteForce c sigma Y k

def rowInterval (p k : ℕ) : Set ℝ :=
  Ioc (((p ^ k : ℕ) : ℝ) - Real.sqrt ((p ^ k : ℕ) : ℝ)) ((p ^ k : ℕ) : ℝ)

theorem mem_primeBases {Y : ℝ} {p k : ℕ} :
    p ∈ primeBases Y k ↔ 2 ≤ p ∧ p ≤ ⌊Y⌋₊ ∧ p.Prime ∧ p ^ k ≤ ⌊Y⌋₊ := by
  simp only [primeBases, Finset.mem_filter, Finset.mem_Icc]
  tauto

theorem base_le_power {p k : ℕ} (hp : 2 ≤ p) (hk : 2 ≤ k) : p ≤ p ^ k := by
  calc
    p = p ^ 1 := by simp
    _ ≤ p ^ k := Nat.pow_le_pow_right (by omega : 1 ≤ p) (by omega : 1 ≤ k)

theorem exponent_le_power {p k : ℕ} (hp : 2 ≤ p) : k ≤ p ^ k := by
  exact (Nat.lt_two_pow_self (n := k)).le.trans (Nat.pow_le_pow_left hp k)

theorem mem_primeBases_iff_real_cutoff {Y : ℝ} (hY : 1 ≤ Y)
    {p k : ℕ} (hk : 2 ≤ k) :
    p ∈ primeBases Y k ↔ p.Prime ∧ ((p ^ k : ℕ) : ℝ) ≤ Y := by
  rw [mem_primeBases]
  constructor
  · rintro ⟨_, _, hp, hpow⟩
    exact ⟨hp, (Nat.le_floor_iff (by linarith : 0 ≤ Y)).1 hpow⟩
  · rintro ⟨hp, hpow⟩
    have hfloor : p ^ k ≤ ⌊Y⌋₊ := (Nat.le_floor_iff (by linarith : 0 ≤ Y)).2 hpow
    exact ⟨hp.two_le, (base_le_power hp.two_le hk).trans hfloor, hp, hfloor⟩

theorem actual_exponent_le_cutoff {Y : ℝ} {p k : ℕ}
    (hp : p ∈ primeBases Y k) : k ≤ ⌊Y⌋₊ := by
  have hm := mem_primeBases.mp hp
  exact (exponent_le_power hm.1).trans hm.2.2.2

theorem actual_row_vonMangoldt {Y : ℝ} {p k : ℕ} (hk : 2 ≤ k)
    (hp : p ∈ primeBases Y k) :
    ArithmeticFunction.vonMangoldt (p ^ k) = Real.log (p : ℝ) := by
  rw [ArithmeticFunction.vonMangoldt_apply_pow (by omega : k ≠ 0)]
  exact ArithmeticFunction.vonMangoldt_apply_prime (mem_primeBases.mp hp).2.2.1

theorem primeBases_subset_square (Y : ℝ) {k : ℕ} (hk : 2 ≤ k) :
    primeBases Y k ⊆ primeBases Y 2 := by
  intro p hp
  have hm := mem_primeBases.mp hp
  have hpow : p ^ 2 ≤ p ^ k := Nat.pow_le_pow_right (by omega : 1 ≤ p) hk
  exact mem_primeBases.mpr ⟨hm.1, hm.2.1, hm.2.2.1, hpow.trans hm.2.2.2⟩

theorem primeBases_eq_empty_of_lt_four {Y : ℝ} (hY : 1 ≤ Y) (hY4 : Y < 4)
    {k : ℕ} (hk : 2 ≤ k) : primeBases Y k = ∅ := by
  apply Finset.eq_empty_iff_forall_notMem.mpr
  intro p hp
  have hm := mem_primeBases.mp hp
  have hn4 := four_le_prime_pow hm.2.2.1 hk
  have hfloor : ⌊Y⌋₊ < 4 := (Nat.floor_lt (by linarith : 0 ≤ Y)).2 hY4
  omega

theorem primeBases_eq_empty_of_exponent_gt {Y : ℝ} {k : ℕ} (hk : ⌊Y⌋₊ < k) :
    primeBases Y k = ∅ := by
  apply Finset.eq_empty_iff_forall_notMem.mpr
  intro p hp
  have he := actual_exponent_le_cutoff hp
  omega

theorem actual_full_enumeration_iff {Y : ℝ} (hY : 1 ≤ Y) (n : ℕ) :
    (ActualProperPrimePower n ∧ (n : ℝ) ≤ Y) ↔
      ∃ k ∈ Finset.Icc 2 ⌊Y⌋₊, ∃ p ∈ primeBases Y k, p ^ k = n := by
  constructor
  · rintro ⟨⟨p, k, hp, hk, hn⟩, hcut⟩
    have hpMem : p ∈ primeBases Y k :=
      (mem_primeBases_iff_real_cutoff hY hk).2 ⟨hp, by simpa only [hn] using hcut⟩
    exact ⟨k, Finset.mem_Icc.mpr ⟨hk, actual_exponent_le_cutoff hpMem⟩, p, hpMem, hn⟩
  · rintro ⟨k, hk, p, hp, hn⟩
    have hm := (mem_primeBases_iff_real_cutoff hY (Finset.mem_Icc.mp hk).1).mp hp
    exact ⟨⟨p, k, hm.1, (Finset.mem_Icc.mp hk).1, hn⟩, by simpa only [hn] using hm.2⟩

theorem centeredError_abs_le_full {Y : ℝ} (hY : 1 ≤ Y) (c : ℝ)
    {t : ℝ} (ht : t ∈ Icc (1 : ℝ) Y) :
    |ActualPrimeErrorCausalTrace.centeredError c t| ≤ psi ⌊Y⌋₊ + Y + |c| := by
  have hp := psi_mono (Nat.floor_mono ht.2)
  unfold ActualPrimeErrorCausalTrace.centeredError primeErrorReal
  apply abs_le.mpr
  constructor <;> linarith [psi_nonneg ⌊t⌋₊, psi_nonneg ⌊Y⌋₊,
    le_abs_self c, neg_abs_le c, ht.1, ht.2]

theorem centeredError_sq_full_intervalIntegrable {Y : ℝ} (hY : 1 ≤ Y) (c : ℝ) :
    IntervalIntegrable (fun t => ActualPrimeErrorCausalTrace.centeredError c t ^ 2) volume 1 Y := by
  let B := psi ⌊Y⌋₊ + Y + |c|
  have hB : 0 ≤ B := by dsimp [B]; linarith [psi_nonneg ⌊Y⌋₊, abs_nonneg c]
  have hm : Measurable (fun t => ActualPrimeErrorCausalTrace.centeredError c t ^ 2) := by
    have hc := ActualPrimeErrorCausalTrace.centeredError_measurable c
    fun_prop
  apply (intervalIntegrable_const (c := B ^ 2)).mono_fun'
    hm.stronglyMeasurable.aestronglyMeasurable
  filter_upwards [ae_restrict_mem measurableSet_uIoc] with t ht
  rw [uIoc_of_le hY] at ht
  have hb := centeredError_abs_le_full hY c (show t ∈ Icc (1 : ℝ) Y from ⟨ht.1.le, ht.2⟩)
  rw [Real.norm_of_nonneg (sq_nonneg _)]
  nlinarith [sq_abs (ActualPrimeErrorCausalTrace.centeredError c t), abs_nonneg (ActualPrimeErrorCausalTrace.centeredError c t)]

theorem energyDensity_full_intervalIntegrable {Y : ℝ} (hY : 1 ≤ Y) (c sigma : ℝ) :
    IntervalIntegrable (energyDensity c sigma) volume 1 Y := by
  have hc : ContinuousOn (fun t : ℝ => t ^ (-1 - 2 * sigma)) [[(1 : ℝ), Y]] := by
    apply continuousOn_id.rpow_const
    intro t ht
    rw [uIcc_of_le hY] at ht
    exact Or.inl (ne_of_gt (by linarith [ht.1] : 0 < t))
  have hi := (centeredError_sq_full_intervalIntegrable hY c).mul_continuousOn hc
  apply hi.congr
  intro t ht
  rw [uIoc_of_le hY] at ht
  exact (ActualPrimeErrorCausalTrace.energyDensity_eq c sigma t (by linarith [ht.1])).symm

theorem energyDensity_nonneg {c sigma t : ℝ} (ht : 1 ≤ t) :
    0 ≤ energyDensity c sigma t := by
  exact mul_nonneg (sq_nonneg _) (Real.rpow_nonneg (by linarith : 0 ≤ t) _)

theorem fullEnergy_nonneg {Y : ℝ} (hY : 1 ≤ Y) (c sigma : ℝ) :
    0 ≤ fullEnergy c sigma Y := by
  exact intervalIntegral.integral_nonneg hY (fun t ht => energyDensity_nonneg ht.1)

theorem rowInterval_subset_full {Y : ℝ} (hY : 1 ≤ Y)
    {p k : ℕ} (hk : 2 ≤ k) (hp : p ∈ primeBases Y k) :
    rowInterval p k ⊆ Ioc (1 : ℝ) Y := by
  have hm := (mem_primeBases_iff_real_cutoff hY hk).mp hp
  have hleft := one_le_window_left (four_le_prime_pow hm.1 hk)
  intro t ht
  exact ⟨lt_of_le_of_lt hleft ht.1, ht.2.trans hm.2⟩

theorem rowIntervals_pairwise_disjoint (Y : ℝ) {k : ℕ} (hk : 2 ≤ k) :
    Set.Pairwise (↑(primeBases Y k)) (fun p q => Disjoint (rowInterval p k) (rowInterval q k)) := by
  intro p hp q hq hpq
  have hpP := (mem_primeBases.mp hp).2.2.1
  have hqP := (mem_primeBases.mp hq).2.2.1
  have hpS : rowInterval p k ⊆ leftWindow (p ^ k) := by
    intro t ht; exact ⟨ht.1.le, ht.2⟩
  have hqS : rowInterval q k ⊆ leftWindow (q ^ k) := by
    intro t ht; exact ⟨ht.1.le, ht.2⟩
  exact (prime_closed_windows_disjoint hpP hqP hpq hk).mono
    hpS hqS

theorem windowEnergy_eq_rowIntegral (c sigma : ℝ) (p k : ℕ) :
    ActualPrimeErrorCausalTrace.windowEnergy c sigma (p ^ k) = ∫ t in rowInterval p k, energyDensity c sigma t := by
  unfold ActualPrimeErrorCausalTrace.windowEnergy rowInterval energyDensity
  rw [intervalIntegral.integral_of_le (by linarith [Real.sqrt_nonneg ((p ^ k : ℕ) : ℝ)])]

theorem actual_grade_energy_allocation {Y : ℝ} (hY : 1 ≤ Y)
    (c sigma : ℝ) {k : ℕ} (hk : 2 ≤ k) :
    (∑ p ∈ primeBases Y k, ActualPrimeErrorCausalTrace.windowEnergy c sigma (p ^ k)) ≤
      fullEnergy c sigma Y := by
  have hfi : IntegrableOn (energyDensity c sigma) (Ioc (1 : ℝ) Y) volume :=
    (intervalIntegrable_iff_integrableOn_Ioc_of_le hY).mp
      (energyDensity_full_intervalIntegrable hY c sigma)
  have hrows : ∀ p ∈ primeBases Y k,
      IntegrableOn (energyDensity c sigma) (rowInterval p k) volume :=
    fun p hp => hfi.mono_set (rowInterval_subset_full hY hk hp)
  have hu := integral_biUnion_finset (primeBases Y k)
    (fun _ _ => measurableSet_Ioc) (rowIntervals_pairwise_disjoint Y hk) hrows
  have hsub : (⋃ p ∈ primeBases Y k, rowInterval p k) ⊆ Ioc (1 : ℝ) Y := by
    intro t ht
    rcases Set.mem_iUnion.mp ht with ⟨p, ht⟩
    rcases Set.mem_iUnion.mp ht with ⟨hp, ht⟩
    exact rowInterval_subset_full hY hk hp ht
  have hn : 0 ≤ᵐ[volume.restrict (Ioc (1 : ℝ) Y)] energyDensity c sigma := by
    filter_upwards [ae_restrict_mem measurableSet_Ioc] with t ht
    exact energyDensity_nonneg ht.1.le
  calc
    (∑ p ∈ primeBases Y k, ActualPrimeErrorCausalTrace.windowEnergy c sigma (p ^ k)) =
        ∑ p ∈ primeBases Y k, ∫ t in rowInterval p k, energyDensity c sigma t := by
      apply Finset.sum_congr rfl
      intro p _
      exact windowEnergy_eq_rowIntegral c sigma p k
    _ = ∫ t in ⋃ p ∈ primeBases Y k, rowInterval p k, energyDensity c sigma t := hu.symm
    _ ≤ ∫ t in Ioc (1 : ℝ) Y, energyDensity c sigma t :=
      setIntegral_mono_set hfi hn (Filter.Eventually.of_forall hsub)
    _ = fullEnergy c sigma Y := (intervalIntegral.integral_of_le hY).symm

theorem trace_coefficient_sq {p k : ℕ} (hp : 2 ≤ p) (sigma : ℝ) :
    (Real.log (p : ℝ) * ((p ^ k : ℕ) : ℝ) ^ ((1 : ℝ) / 4 - sigma)) ^ 2 =
      Real.log (p : ℝ) ^ 2 * ((p ^ k : ℕ) : ℝ) ^ ((1 : ℝ) / 2 - 2 * sigma) := by
  have hn : (0 : ℝ) ≤ ((p ^ k : ℕ) : ℝ) := by positivity
  have he : (((p ^ k : ℕ) : ℝ) ^ ((1 : ℝ) / 4 - sigma)) ^ 2 =
      ((p ^ k : ℕ) : ℝ) ^ (((1 : ℝ) / 4 - sigma) * 2) := by
    rw [← Real.rpow_two, ← Real.rpow_mul hn]
  rw [mul_pow, he, show ((1 : ℝ) / 4 - sigma) * 2 = (1 : ℝ) / 2 - 2 * sigma by ring]

theorem actual_grade_trace_cauchy {Y : ℝ} (hY : 1 ≤ Y)
    (c sigma : ℝ) {k : ℕ} (hk : 2 ≤ k) :
    (∑ p ∈ primeBases Y k,
      (Real.log (p : ℝ) * ((p ^ k : ℕ) : ℝ) ^ ((1 : ℝ) / 4 - sigma)) *
        Real.sqrt (ActualPrimeErrorCausalTrace.windowEnergy c sigma (p ^ k))) ≤
      Real.sqrt (gradeCoefficient sigma Y k) * Real.sqrt (fullEnergy c sigma Y) := by
  have hcs := Real.sum_mul_le_sqrt_mul_sqrt (primeBases Y k)
    (fun p => Real.log (p : ℝ) * ((p ^ k : ℕ) : ℝ) ^ ((1 : ℝ) / 4 - sigma))
    (fun p => Real.sqrt (ActualPrimeErrorCausalTrace.windowEnergy c sigma (p ^ k)))
  have hcoeff : (∑ p ∈ primeBases Y k,
      (Real.log (p : ℝ) * ((p ^ k : ℕ) : ℝ) ^ ((1 : ℝ) / 4 - sigma)) ^ 2) =
      gradeCoefficient sigma Y k := by
    apply Finset.sum_congr rfl
    intro p hp
    exact trace_coefficient_sq (mem_primeBases.mp hp).1 sigma
  have hv : (∑ p ∈ primeBases Y k,
      Real.sqrt (ActualPrimeErrorCausalTrace.windowEnergy c sigma (p ^ k)) ^ 2) =
      ∑ p ∈ primeBases Y k, ActualPrimeErrorCausalTrace.windowEnergy c sigma (p ^ k) := by
    apply Finset.sum_congr rfl
    intro p hp
    exact Real.sq_sqrt (ActualPrimeErrorCausalTrace.windowEnergy_nonneg
      (four_le_prime_pow (mem_primeBases.mp hp).2.2.1 hk) c sigma)
  rw [hcoeff, hv] at hcs
  exact hcs.trans (mul_le_mul_of_nonneg_left
    (Real.sqrt_le_sqrt (actual_grade_energy_allocation hY c sigma hk)) (Real.sqrt_nonneg _))

theorem actual_grade_absolute_force_le {Y : ℝ} (hY : 1 ≤ Y)
    (c sigma : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) {k : ℕ} (hk : 2 ≤ k) :
    gradeAbsoluteForce c sigma Y k ≤
      Real.sqrt (gradeCoefficient sigma Y k) * Real.sqrt (fullEnergy c sigma Y) +
      gradeRemainder sigma Y k := by
  have hterm : ∀ p ∈ primeBases Y k,
      (Real.log (p : ℝ) * ((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma)) *
          |ActualPrimeErrorCausalTrace.preError c (p ^ k) / ((p ^ k : ℕ) : ℝ)| ≤
        (Real.log (p : ℝ) * ((p ^ k : ℕ) : ℝ) ^ ((1 : ℝ) / 4 - sigma)) *
          Real.sqrt (ActualPrimeErrorCausalTrace.windowEnergy c sigma (p ^ k)) +
        Real.log (p : ℝ) * ((p ^ k : ℕ) : ℝ) ^ ((1 : ℝ) / 2 - 2 * sigma) *
          (1 + Real.log ((p ^ k : ℕ) : ℝ)) := by
    intro p hp
    have hm := mem_primeBases.mp hp
    have hn4 := four_le_prime_pow hm.2.2.1 hk
    have hn0 : (0 : ℝ) < ((p ^ k : ℕ) : ℝ) := by exact_mod_cast (show 0 < p ^ k by omega)
    have hw : 0 ≤ Real.log (p : ℝ) * ((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma) :=
      mul_nonneg (Real.log_nonneg (by exact_mod_cast (show 1 ≤ p by omega)))
        (Real.rpow_nonneg hn0.le _)
    have ht := mul_le_mul_of_nonneg_left
      (ActualPrimeErrorCausalTrace.actual_causal_trace hn4 c sigma hsigma) hw
    have he1 : ((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma) *
        ((p ^ k : ℕ) : ℝ) ^ (sigma - 3 / 4) =
        ((p ^ k : ℕ) : ℝ) ^ ((1 : ℝ) / 4 - sigma) := by
      rw [← Real.rpow_add hn0]; congr 1; ring
    have he2 : ((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma) *
        ((p ^ k : ℕ) : ℝ) ^ (-(1 : ℝ) / 2) =
        ((p ^ k : ℕ) : ℝ) ^ ((1 : ℝ) / 2 - 2 * sigma) := by
      rw [← Real.rpow_add hn0]; congr 1; ring
    apply ht.trans_eq
    calc
      (Real.log (p : ℝ) * ((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma)) *
          (((p ^ k : ℕ) : ℝ) ^ (sigma - 3 / 4) *
            Real.sqrt (ActualPrimeErrorCausalTrace.windowEnergy c sigma (p ^ k)) +
            ((p ^ k : ℕ) : ℝ) ^ (-(1 : ℝ) / 2) * (1 + Real.log ((p ^ k : ℕ) : ℝ))) =
        Real.log (p : ℝ) * (((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma) *
          ((p ^ k : ℕ) : ℝ) ^ (sigma - 3 / 4)) *
            Real.sqrt (ActualPrimeErrorCausalTrace.windowEnergy c sigma (p ^ k)) +
        Real.log (p : ℝ) * (((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma) *
          ((p ^ k : ℕ) : ℝ) ^ (-(1 : ℝ) / 2)) * (1 + Real.log ((p ^ k : ℕ) : ℝ)) := by ring
      _ = _ := by rw [he1, he2]
  have hsum := Finset.sum_le_sum hterm
  rw [Finset.sum_add_distrib] at hsum
  exact hsum.trans (add_le_add_right (actual_grade_trace_cauchy hY c sigma hk) _)

theorem primeHarmonicSecondMass_nonneg (Y : ℝ) :
    0 ≤ primeHarmonicSecondMass Y := by
  exact Finset.sum_nonneg (fun p _ => div_nonneg (sq_nonneg _) (Nat.cast_nonneg p))

theorem gradeCoefficient_nonneg (sigma Y : ℝ) (k : ℕ) :
    0 ≤ gradeCoefficient sigma Y k := by
  exact Finset.sum_nonneg (fun _ _ => mul_nonneg (sq_nonneg _)
    (Real.rpow_nonneg (by positivity) _))

theorem actual_row_coefficient_decay {p k : ℕ} (hp : 2 ≤ p) (hk : 2 ≤ k)
    (sigma : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) :
    Real.log (p : ℝ) ^ 2 * ((p ^ k : ℕ) : ℝ) ^ ((1 : ℝ) / 2 - 2 * sigma) ≤
      geometricDecay k * (Real.log (p : ℝ) ^ 2 / (p : ℝ)) := by
  have hp0 : (0 : ℝ) < p := by exact_mod_cast (show 0 < p by omega)
  have hp1 : (1 : ℝ) ≤ p := by exact_mod_cast (show 1 ≤ p by omega)
  have hp2 : (2 : ℝ) ≤ p := by exact_mod_cast hp
  have hexp : (k : ℝ) * ((1 : ℝ) / 2 - 2 * sigma) ≤ -(k : ℝ) / 2 := by
    have hh := mul_le_mul_of_nonneg_left
      (show (1 : ℝ) / 2 - 2 * sigma ≤ -(1 : ℝ) / 2 by linarith) (Nat.cast_nonneg k)
    nlinarith
  have hnEq : ((p ^ k : ℕ) : ℝ) ^ ((1 : ℝ) / 2 - 2 * sigma) =
      (p : ℝ) ^ ((k : ℝ) * ((1 : ℝ) / 2 - 2 * sigma)) := by
    rw [Nat.cast_pow, ← Real.rpow_natCast (p : ℝ) k, ← Real.rpow_mul hp0.le]
  have hsplit : -(k : ℝ) / 2 = (-1 : ℝ) + (-((k - 2 : ℕ) : ℝ) / 2) := by
    rw [Nat.cast_sub hk]; push_cast; ring
  have hdecay : (p : ℝ) ^ (-((k - 2 : ℕ) : ℝ) / 2) ≤ geometricDecay k := by
    exact Real.rpow_le_rpow_of_nonpos (by norm_num : (0 : ℝ) < 2) hp2
      (by have := Nat.cast_nonneg (α := ℝ) (k - 2); linarith)
  have hpower : ((p ^ k : ℕ) : ℝ) ^ ((1 : ℝ) / 2 - 2 * sigma) ≤
      geometricDecay k / (p : ℝ) := by
    calc
      _ = (p : ℝ) ^ ((k : ℝ) * ((1 : ℝ) / 2 - 2 * sigma)) := hnEq
      _ ≤ (p : ℝ) ^ (-(k : ℝ) / 2) := Real.rpow_le_rpow_of_exponent_le hp1 hexp
      _ = (p : ℝ)⁻¹ * (p : ℝ) ^ (-((k - 2 : ℕ) : ℝ) / 2) := by
        rw [hsplit, Real.rpow_add hp0, Real.rpow_neg_one]
      _ ≤ (p : ℝ)⁻¹ * geometricDecay k :=
        mul_le_mul_of_nonneg_left hdecay (inv_nonneg.mpr hp0.le)
      _ = geometricDecay k / (p : ℝ) := by ring
  calc
    _ ≤ Real.log (p : ℝ) ^ 2 * (geometricDecay k / (p : ℝ)) :=
      mul_le_mul_of_nonneg_left hpower (sq_nonneg _)
    _ = _ := by ring

theorem actual_grade_coefficient_decay (Y sigma : ℝ)
    (hsigma : (1 : ℝ) / 2 ≤ sigma) {k : ℕ} (hk : 2 ≤ k) :
    gradeCoefficient sigma Y k ≤ geometricDecay k * primeHarmonicSecondMass Y := by
  have hsubset := primeBases_subset_square Y hk
  have hm : (∑ p ∈ primeBases Y k, Real.log (p : ℝ) ^ 2 / (p : ℝ)) ≤
      primeHarmonicSecondMass Y := by
    exact Finset.sum_le_sum_of_subset_of_nonneg hsubset
      (fun p _ _ => div_nonneg (sq_nonneg _) (Nat.cast_nonneg p))
  calc
    gradeCoefficient sigma Y k ≤ ∑ p ∈ primeBases Y k,
        geometricDecay k * (Real.log (p : ℝ) ^ 2 / (p : ℝ)) := by
      apply Finset.sum_le_sum
      intro p hp
      exact actual_row_coefficient_decay (mem_primeBases.mp hp).1 hk sigma hsigma
    _ = geometricDecay k * ∑ p ∈ primeBases Y k, Real.log (p : ℝ) ^ 2 / (p : ℝ) := by
      rw [Finset.mul_sum]
    _ ≤ geometricDecay k * primeHarmonicSecondMass Y :=
      mul_le_mul_of_nonneg_left hm (Real.rpow_nonneg (by norm_num) _)

theorem primeHarmonicSecondMass_le_native {Y : ℝ} :
    primeHarmonicSecondMass Y ≤ logarithmicPrimeSecondMass ⌊Y⌋₊ := by
  have hsubset : primeBases Y 2 ⊆ Finset.Icc 1 ⌊Y⌋₊ := by
    intro p hp
    have hm := mem_primeBases.mp hp
    exact Finset.mem_Icc.mpr ⟨by omega, hm.2.1⟩
  calc
    primeHarmonicSecondMass Y = ∑ p ∈ primeBases Y 2,
        (ArithmeticFunction.vonMangoldt p / (p : ℝ)) * Real.log (p : ℝ) := by
      apply Finset.sum_congr rfl
      intro p hp
      rw [ArithmeticFunction.vonMangoldt_apply_prime (mem_primeBases.mp hp).2.2.1]
      ring
    _ ≤ ∑ p ∈ Finset.Icc 1 ⌊Y⌋₊,
        (ArithmeticFunction.vonMangoldt p / (p : ℝ)) * Real.log (p : ℝ) := by
      exact Finset.sum_le_sum_of_subset_of_nonneg hsubset (fun p hp _ =>
        mul_nonneg (div_nonneg ArithmeticFunction.vonMangoldt_nonneg (Nat.cast_nonneg p))
          (Real.log_nonneg (by exact_mod_cast (Finset.mem_Icc.mp hp).1)))
    _ = logarithmicPrimeSecondMass ⌊Y⌋₊ := rfl

theorem primeHarmonicSecondMass_le_nine_log_sq {Y : ℝ} (hY : 1 ≤ Y) :
    primeHarmonicSecondMass Y ≤ 9 * Real.log (2 * Y) ^ 2 := by
  have hN : 1 ≤ ⌊Y⌋₊ := (Nat.one_le_floor_iff Y).2 hY
  have hY0 : 0 < Y := by linarith
  have hN0 : (0 : ℝ) < (⌊Y⌋₊ : ℝ) := by exact_mod_cast (show 0 < ⌊Y⌋₊ by omega)
  have hlogN : 0 ≤ Real.log (⌊Y⌋₊ : ℝ) := Real.log_nonneg (by exact_mod_cast hN)
  have hlogY : 0 ≤ Real.log Y := Real.log_nonneg hY
  have hlogNY : Real.log (⌊Y⌋₊ : ℝ) ≤ Real.log Y :=
    Real.log_le_log hN0 (Nat.floor_le hY0.le)
  have hlog2lo : (1 : ℝ) / 2 ≤ Real.log 2 := by linarith [Real.log_two_gt_d9]
  have hlog2hi : Real.log 2 ≤ (1 : ℝ) := by linarith [Real.log_two_lt_d9]
  have hell : Real.log (2 * Y) = Real.log 2 + Real.log Y :=
    Real.log_mul (by norm_num) (ne_of_gt hY0)
  have hYell : Real.log Y ≤ Real.log (2 * Y) := by linarith
  have hell0 : 0 ≤ Real.log (2 * Y) := by linarith
  have hlin : Real.log Y ≤ Real.log (2 * Y) ^ 2 := by
    have hc : 0 ≤ (2 * Real.log 2 - 1) * Real.log Y :=
      mul_nonneg (by linarith) hlogY
    nlinarith [sq_nonneg (Real.log 2), sq_nonneg (Real.log Y)]
  have hbound := (primeHarmonicSecondMass_le_native (Y := Y)).trans
    (logarithmicPrimeSecondMass_le hN)
  have hC : 0 ≤ 4 * Real.log 2 + (3 : ℝ) / 2 := by linarith
  have hlogSq : Real.log (⌊Y⌋₊ : ℝ) ^ 2 ≤ Real.log Y ^ 2 := by nlinarith
  have hstep : primeHarmonicSecondMass Y ≤
      Real.log Y ^ 2 / 2 + (4 * Real.log 2 + 3 / 2) * Real.log Y := by
    nlinarith [mul_le_mul_of_nonneg_left hlogNY hC]
  have hsq : Real.log Y ^ 2 ≤ Real.log (2 * Y) ^ 2 := by nlinarith
  have hcY : (4 * Real.log 2 + (3 : ℝ) / 2) * Real.log Y ≤
      (11 : ℝ) / 2 * Real.log (2 * Y) ^ 2 := by
    calc
      _ ≤ (11 : ℝ) / 2 * Real.log Y :=
        mul_le_mul_of_nonneg_right (by linarith) hlogY
      _ ≤ _ := mul_le_mul_of_nonneg_left hlin (by norm_num)
  nlinarith [sq_nonneg (Real.log (2 * Y))]

theorem sqrt_primeHarmonicSecondMass_le_three_log {Y : ℝ} (hY : 1 ≤ Y) :
    Real.sqrt (primeHarmonicSecondMass Y) ≤ 3 * Real.log (2 * Y) := by
  apply Real.sqrt_le_iff.mpr
  constructor
  · exact mul_nonneg (by norm_num) (Real.log_nonneg (by linarith : 1 ≤ 2 * Y))
  · nlinarith [primeHarmonicSecondMass_le_nine_log_sq hY]

theorem gradeGeometricRatio_nonneg : 0 ≤ gradeGeometricRatio :=
  Real.rpow_nonneg (by norm_num) _

theorem gradeGeometricRatio_fourth : gradeGeometricRatio ^ 4 = (1 : ℝ) / 2 := by
  unfold gradeGeometricRatio
  rw [← Real.rpow_natCast ((2 : ℝ) ^ (-(1 : ℝ) / 4)) 4,
    ← Real.rpow_mul (by norm_num : (0 : ℝ) ≤ 2)]
  norm_num [show (-(1 : ℝ) / 4) * (4 : ℝ) = -1 by ring, Real.rpow_neg_one]

theorem gradeGeometricRatio_le_seven_eighths : gradeGeometricRatio ≤ (7 : ℝ) / 8 := by
  by_contra h
  have hle : (7 : ℝ) / 8 ≤ gradeGeometricRatio := le_of_not_ge h
  have hp : ((7 : ℝ) / 8) ^ 4 ≤ gradeGeometricRatio ^ 4 := by gcongr
  rw [gradeGeometricRatio_fourth] at hp
  norm_num at hp

theorem finite_geometric_grade_identity (r : ℝ) {N : ℕ} (hN : 1 ≤ N) :
    (1 - r) * (∑ k ∈ Finset.Icc 2 N, r ^ (k - 2)) = 1 - r ^ (N - 1) := by
  induction N, hN using Nat.le_induction with
  | base => simp
  | succ N hN ih =>
    rw [Finset.sum_Icc_succ_top (by omega)]
    rw [show N + 1 - 2 = N - 1 by omega, show N + 1 - 1 = N by omega,
      mul_add, ih]
    have hp : r ^ N = r ^ (N - 1) * r := by
      calc
        r ^ N = r ^ ((N - 1) + 1) := by congr 1; omega
        _ = r ^ (N - 1) * r := pow_succ r (N - 1)
    rw [hp]
    ring

theorem finite_geometric_grade_le_eight (N : ℕ) {r : ℝ}
    (hr : 0 ≤ r) (hr8 : r ≤ (7 : ℝ) / 8) :
    (∑ k ∈ Finset.Icc 2 N, r ^ (k - 2)) ≤ 8 := by
  by_cases hN : 1 ≤ N
  · have hi := finite_geometric_grade_identity r hN
    have hs : 0 ≤ ∑ k ∈ Finset.Icc 2 N, r ^ (k - 2) :=
      Finset.sum_nonneg (fun _ _ => pow_nonneg hr _)
    have hp : 0 ≤ r ^ (N - 1) := pow_nonneg hr _
    have hm : 0 ≤ (∑ k ∈ Finset.Icc 2 N, r ^ (k - 2)) * (1 - r - 1 / 8) :=
      mul_nonneg hs (by linarith)
    nlinarith
  · have hN0 : N = 0 := by omega
    subst N
    simp

theorem sqrt_geometricDecay_eq (k : ℕ) :
    Real.sqrt (geometricDecay k) = gradeGeometricRatio ^ (k - 2) := by
  unfold geometricDecay gradeGeometricRatio
  rw [Real.sqrt_eq_rpow, ← Real.rpow_mul (by norm_num : (0 : ℝ) ≤ 2),
    ← Real.rpow_natCast ((2 : ℝ) ^ (-(1 : ℝ) / 4)) (k - 2),
    ← Real.rpow_mul (by norm_num : (0 : ℝ) ≤ 2)]
  congr 1
  ring

theorem actual_all_grade_coefficients_le_twenty_four_log {Y : ℝ} (hY : 1 ≤ Y)
    (sigma : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) :
    (∑ k ∈ Finset.Icc 2 ⌊Y⌋₊, Real.sqrt (gradeCoefficient sigma Y k)) ≤
      24 * Real.log (2 * Y) := by
  have hterm : ∀ k ∈ Finset.Icc 2 ⌊Y⌋₊,
      Real.sqrt (gradeCoefficient sigma Y k) ≤
        gradeGeometricRatio ^ (k - 2) * Real.sqrt (primeHarmonicSecondMass Y) := by
    intro k hk
    have hd := Real.sqrt_le_sqrt (actual_grade_coefficient_decay Y sigma hsigma
      (Finset.mem_Icc.mp hk).1)
    have hD : 0 ≤ geometricDecay k := Real.rpow_nonneg (by norm_num) _
    rw [Real.sqrt_mul hD, sqrt_geometricDecay_eq] at hd
    exact hd
  calc
    _ ≤ ∑ k ∈ Finset.Icc 2 ⌊Y⌋₊,
        gradeGeometricRatio ^ (k - 2) * Real.sqrt (primeHarmonicSecondMass Y) :=
      Finset.sum_le_sum hterm
    _ = (∑ k ∈ Finset.Icc 2 ⌊Y⌋₊, gradeGeometricRatio ^ (k - 2)) *
        Real.sqrt (primeHarmonicSecondMass Y) := by rw [Finset.sum_mul]
    _ ≤ 8 * Real.sqrt (primeHarmonicSecondMass Y) :=
      mul_le_mul_of_nonneg_right
        (finite_geometric_grade_le_eight ⌊Y⌋₊ gradeGeometricRatio_nonneg
          gradeGeometricRatio_le_seven_eighths) (Real.sqrt_nonneg _)
    _ ≤ 24 * Real.log (2 * Y) := by
      nlinarith [sqrt_primeHarmonicSecondMass_le_three_log hY]

theorem actual_full_absolute_force_le_with_remainder {Y : ℝ} (hY : 1 ≤ Y)
    (c sigma : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) :
    fullAbsoluteForce c sigma Y ≤
      24 * Real.log (2 * Y) * Real.sqrt (fullEnergy c sigma Y) +
      ∑ k ∈ Finset.Icc 2 ⌊Y⌋₊, gradeRemainder sigma Y k := by
  have hterm : ∀ k ∈ Finset.Icc 2 ⌊Y⌋₊,
      gradeAbsoluteForce c sigma Y k ≤
        Real.sqrt (gradeCoefficient sigma Y k) * Real.sqrt (fullEnergy c sigma Y) +
          gradeRemainder sigma Y k := by
    intro k hk
    exact actual_grade_absolute_force_le hY c sigma hsigma (Finset.mem_Icc.mp hk).1
  have hsum := Finset.sum_le_sum hterm
  rw [Finset.sum_add_distrib, ← Finset.sum_mul] at hsum
  exact hsum.trans (add_le_add_right (mul_le_mul_of_nonneg_right
    (actual_all_grade_coefficients_le_twenty_four_log hY sigma hsigma) (Real.sqrt_nonneg _)) _)

end BuildingBlocks.ActualProperPowerEnergyAllocation

/-!
Finite logarithmic-tail coverage. Every comparison and integrability
obligation is proved here; no tail estimate or evaluator is a caller premise.
This is support for the already written proper-power bound, not a new signed
ordinary-prime estimate or an RH result.
-/

open scoped BigOperators
open Set MeasureTheory

namespace BuildingBlocks.ActualLogarithmicTailBounds

noncomputable def envelope (j : ℕ) (t : ℝ) : ℝ :=
  t ^ (-(3 : ℝ) / 2) * (Real.log t + 1) ^ j

noncomputable def tailWeight (j : ℕ) (n : ℕ) : ℝ :=
  Real.log (n : ℝ) ^ j / (n : ℝ) ^ ((3 : ℝ) / 2)

noncomputable def potentialOne (t : ℝ) : ℝ :=
  -2 * t ^ (-(1 : ℝ) / 2) * (Real.log t + 3)

noncomputable def potentialTwo (t : ℝ) : ℝ :=
  -2 * t ^ (-(1 : ℝ) / 2) * (Real.log t ^ 2 + 6 * Real.log t + 13)

theorem log_comparison {n t : ℝ} (hn : 2 ≤ n) (ht : t ∈ Icc (n - 1) n) :
    Real.log n ≤ Real.log t + 1 := by
  have ht1 : 1 ≤ t := by linarith [ht.1]
  have ht0 : 0 < t := by linarith
  have hn0 : 0 < n := by linarith
  have hn2t : n ≤ 2 * t := by linarith [ht.1]
  have hlog2 : Real.log 2 ≤ 1 := by
    have h := Real.log_le_sub_one_of_pos (show (0 : ℝ) < 2 by norm_num)
    norm_num at h
    exact h
  calc
    Real.log n ≤ Real.log (2 * t) := Real.log_le_log hn0 hn2t
    _ = Real.log 2 + Real.log t := Real.log_mul (by norm_num) ht0.ne'
    _ ≤ Real.log t + 1 := by linarith

theorem weight_le_envelope (j n : ℕ) (hn : 2 ≤ n) {t : ℝ}
    (ht : t ∈ Icc ((n : ℝ) - 1) (n : ℝ)) : tailWeight j n ≤ envelope j t := by
  have hn2 : (2 : ℝ) ≤ n := by exact_mod_cast hn
  have hn0 : (0 : ℝ) < n := by linarith
  have ht1 : 1 ≤ t := by linarith [ht.1]
  have ht0 : 0 < t := by linarith
  have hlogn : 0 ≤ Real.log (n : ℝ) := Real.log_nonneg (by linarith)
  have hlog : Real.log (n : ℝ) ≤ Real.log t + 1 := log_comparison hn2 ht
  have hpowlog : Real.log (n : ℝ) ^ j ≤ (Real.log t + 1) ^ j := by
    gcongr
  have hpow : (n : ℝ) ^ (-(3 : ℝ) / 2) ≤ t ^ (-(3 : ℝ) / 2) :=
    Real.rpow_le_rpow_of_nonpos ht0 ht.2 (by norm_num)
  have hprod := mul_le_mul hpow hpowlog (pow_nonneg hlogn j)
    (Real.rpow_nonneg ht0.le _)
  have hneg : (n : ℝ) ^ (-(3 : ℝ) / 2) = ((n : ℝ) ^ ((3 : ℝ) / 2))⁻¹ := by
    rw [show -(3 : ℝ) / 2 = -((3 : ℝ) / 2) by ring, Real.rpow_neg hn0.le]
  rw [hneg] at hprod
  unfold tailWeight envelope
  simpa only [div_eq_mul_inv, mul_comm] using hprod

theorem envelope_intervalIntegrable (j : ℕ) {a b : ℝ} (ha : 1 ≤ a) (hab : a ≤ b) :
    IntervalIntegrable (envelope j) volume a b := by
  apply ContinuousOn.intervalIntegrable_of_Icc hab
  intro t ht
  have ht0 : 0 < t := by linarith [ht.1]
  unfold envelope
  exact ((continuousAt_id.rpow_const (Or.inl ht0.ne')).mul
    (((Real.continuousAt_log ht0.ne').add continuousAt_const).pow j)).continuousWithinAt

theorem rpow_half_div {t : ℝ} (ht : 0 < t) :
    t ^ (-(1 : ℝ) / 2) / t = t ^ (-(3 : ℝ) / 2) := by
  convert (Real.rpow_sub_one ht.ne' (-(1 : ℝ) / 2)).symm using 1
  norm_num

theorem potentialOne_hasDerivAt {t : ℝ} (ht : 0 < t) :
    HasDerivAt potentialOne (envelope 1 t) t := by
  have hr := Real.hasDerivAt_rpow_const (x := t) (p := -(1 : ℝ) / 2) (Or.inl ht.ne')
  have hl := (Real.hasDerivAt_log ht.ne').add_const 3
  convert (hr.const_mul (-2)).mul hl using 1
  unfold envelope
  norm_num only [pow_one]
  have hrel : t ^ (-(1 : ℝ) / 2) * t⁻¹ = t ^ (-(3 : ℝ) / 2) := by
    simpa only [div_eq_mul_inv] using rpow_half_div ht
  norm_num only at hrel
  linear_combination 2 * hrel

theorem potentialTwo_hasDerivAt {t : ℝ} (ht : 0 < t) :
    HasDerivAt potentialTwo (envelope 2 t) t := by
  have hr := Real.hasDerivAt_rpow_const (x := t) (p := -(1 : ℝ) / 2) (Or.inl ht.ne')
  have hl := Real.hasDerivAt_log ht.ne'
  have hpoly := ((hl.pow 2).add (hl.const_mul 6)).add_const 13
  convert (hr.const_mul (-2)).mul hpoly using 1
  unfold envelope
  norm_num only [Pi.add_apply, Pi.pow_apply, Nat.cast_ofNat, Nat.reduceSub, pow_one]
  have hrel : t ^ (-(1 : ℝ) / 2) * t⁻¹ = t ^ (-(3 : ℝ) / 2) := by
    simpa only [div_eq_mul_inv] using rpow_half_div ht
  norm_num only at hrel
  linear_combination 4 * Real.log t * hrel + 12 * hrel

theorem envelopeOne_integral {a b : ℝ} (ha : 1 ≤ a) (hab : a ≤ b) :
    (∫ t in a..b, envelope 1 t) = potentialOne b - potentialOne a := by
  apply intervalIntegral.integral_eq_sub_of_hasDerivAt
  · intro t ht
    rw [uIcc_of_le hab] at ht
    exact potentialOne_hasDerivAt (by linarith [ht.1])
  · exact envelope_intervalIntegrable 1 ha hab

theorem envelopeTwo_integral {a b : ℝ} (ha : 1 ≤ a) (hab : a ≤ b) :
    (∫ t in a..b, envelope 2 t) = potentialTwo b - potentialTwo a := by
  apply intervalIntegral.integral_eq_sub_of_hasDerivAt
  · intro t ht
    rw [uIcc_of_le hab] at ht
    exact potentialTwo_hasDerivAt (by linarith [ht.1])
  · exact envelope_intervalIntegrable 2 ha hab

theorem weight_le_intervalIntegral (j n : ℕ) (hn : 2 ≤ n) :
    tailWeight j n ≤ ∫ t in ((n : ℝ) - 1)..(n : ℝ), envelope j t := by
  have hn2 : (2 : ℝ) ≤ n := by exact_mod_cast hn
  have hab : (n : ℝ) - 1 ≤ n := by linarith
  have hi := intervalIntegral.integral_mono_on hab
    (intervalIntegrable_const : IntervalIntegrable (fun _ : ℝ => tailWeight j n) volume ((n : ℝ) - 1) (n : ℝ))
    (envelope_intervalIntegrable j (by linarith) hab)
    (fun t ht => weight_le_envelope j n hn ht)
  simpa only [intervalIntegral.integral_const, sub_sub_cancel, one_smul] using hi

theorem finite_telescoping_bound (w : ℕ → ℝ) (P : ℝ → ℝ)
    (hstep : ∀ n : ℕ, 2 ≤ n → w n ≤ P (n : ℝ) - P ((n : ℝ) - 1))
    {N : ℕ} (hN : 1 ≤ N) :
    (∑ n ∈ Finset.Icc 2 N, w n) ≤ P (N : ℝ) - P 1 := by
  induction N, hN using Nat.le_induction with
  | base => simp
  | succ N hN ih =>
    rw [Finset.sum_Icc_succ_top (by omega) w]
    have hs := hstep (N + 1) (by omega)
    norm_num only [Nat.cast_add, Nat.cast_one, add_sub_cancel_right] at hs ⊢
    linarith

theorem potentialOne_nonpos {t : ℝ} (ht : 1 ≤ t) : potentialOne t ≤ 0 := by
  unfold potentialOne
  have hl : 0 ≤ Real.log t := Real.log_nonneg ht
  have hr := Real.rpow_nonneg (show 0 ≤ t by linarith) (-(1 : ℝ) / 2)
  nlinarith

theorem potentialTwo_nonpos {t : ℝ} (ht : 1 ≤ t) : potentialTwo t ≤ 0 := by
  unfold potentialTwo
  have hl : 0 ≤ Real.log t := Real.log_nonneg ht
  have hr := Real.rpow_nonneg (show 0 ≤ t by linarith) (-(1 : ℝ) / 2)
  have hp : 0 ≤ Real.log t ^ 2 + 6 * Real.log t + 13 := by positivity
  exact mul_nonpos_of_nonpos_of_nonneg (mul_nonpos_of_nonpos_of_nonneg (by norm_num) hr) hp

theorem finite_log_tail_le_six (N : ℕ) :
    (∑ n ∈ Finset.Icc 2 N, Real.log (n : ℝ) / (n : ℝ) ^ ((3 : ℝ) / 2)) ≤ 6 := by
  by_cases hN : 1 ≤ N
  · have hsum := finite_telescoping_bound (tailWeight 1) potentialOne (fun n hn => by
      have hi := weight_le_intervalIntegral 1 n hn
      have hn2 : (2 : ℝ) ≤ n := by exact_mod_cast hn
      rw [envelopeOne_integral (by linarith) (by linarith)] at hi
      exact hi) hN
    have hp := potentialOne_nonpos (show (1 : ℝ) ≤ N by exact_mod_cast hN)
    unfold potentialOne at hp
    norm_num [potentialOne, tailWeight] at hsum
    linarith
  · have h0 : N = 0 := by omega
    subst N
    simp

theorem finite_log_sq_tail_le_twenty_six (N : ℕ) :
    (∑ n ∈ Finset.Icc 2 N, Real.log (n : ℝ) ^ 2 / (n : ℝ) ^ ((3 : ℝ) / 2)) ≤ 26 := by
  by_cases hN : 1 ≤ N
  · have hsum := finite_telescoping_bound (tailWeight 2) potentialTwo (fun n hn => by
      have hi := weight_le_intervalIntegral 2 n hn
      have hn2 : (2 : ℝ) ≤ n := by exact_mod_cast hn
      rw [envelopeTwo_integral (by linarith) (by linarith)] at hi
      exact hi) hN
    have hp := potentialTwo_nonpos (show (1 : ℝ) ≤ N by exact_mod_cast hN)
    unfold potentialTwo at hp
    norm_num [potentialTwo, tailWeight] at hsum
    linarith
  · have h0 : N = 0 := by omega
    subst N
    simp

theorem finite_geometric_tail_remainder {r : ℝ} (hr : 0 ≤ r) (hr4 : r ≤ 3 / 4)
    {K : ℕ} (hK : 2 ≤ K) :
    (∑ k ∈ Finset.Icc 3 K, r ^ k) ≤ 4 * r ^ 3 - 4 * r ^ (K + 1) := by
  induction K, hK using Nat.le_induction with
  | base => simp
  | succ K hK ih =>
    rw [Finset.sum_Icc_succ_top (by omega)]
    have hq : 0 ≤ r ^ (K + 1) := pow_nonneg hr _
    have hc : 0 ≤ 3 - 4 * r := by linarith
    have hm := mul_nonneg hq hc
    rw [pow_succ r (K + 1)]
    nlinarith

theorem finite_weighted_geometric_tail_remainder {r : ℝ} (hr : 0 ≤ r)
    (hr4 : r ≤ 3 / 4) {K : ℕ} (hK : 2 ≤ K) :
    (∑ k ∈ Finset.Icc 3 K, (k : ℝ) * r ^ k) ≤
      24 * r ^ 3 - (4 * ((K : ℝ) + 1) + 12) * r ^ (K + 1) := by
  induction K, hK using Nat.le_induction with
  | base => norm_num
  | succ K hK ih =>
    rw [Finset.sum_Icc_succ_top (by omega)]
    have hq : 0 ≤ r ^ (K + 1) := pow_nonneg hr _
    have hc : 0 ≤ (3 * (K : ℝ) + 15) - (4 * (K : ℝ) + 20) * r := by
      have hkp : 0 ≤ 4 * (K : ℝ) + 20 := by positivity
      have hm := mul_le_mul_of_nonneg_left hr4 hkp
      nlinarith
    have hm := mul_nonneg hq hc
    rw [pow_succ r (K + 1)]
    push_cast
    nlinarith

theorem finite_geometric_tail_le_four (K : ℕ) {r : ℝ} (hr : 0 ≤ r) (hr4 : r ≤ 3 / 4) :
    (∑ k ∈ Finset.Icc 3 K, r ^ k) ≤ 4 * r ^ 3 := by
  by_cases hK : 2 ≤ K
  · have hs := finite_geometric_tail_remainder hr hr4 hK
    have hp : 0 ≤ r ^ (K + 1) := pow_nonneg hr _
    linarith
  · rw [Finset.Icc_eq_empty_of_lt (by omega)]
    simpa using mul_nonneg (show (0 : ℝ) ≤ 4 by norm_num) (pow_nonneg hr 3)

theorem finite_weighted_geometric_tail_le_twenty_four (K : ℕ) {r : ℝ}
    (hr : 0 ≤ r) (hr4 : r ≤ 3 / 4) :
    (∑ k ∈ Finset.Icc 3 K, (k : ℝ) * r ^ k) ≤ 24 * r ^ 3 := by
  by_cases hK : 2 ≤ K
  · have hs := finite_weighted_geometric_tail_remainder hr hr4 hK
    have hp : 0 ≤ (4 * ((K : ℝ) + 1) + 12) * r ^ (K + 1) := by positivity
    linarith
  · rw [Finset.Icc_eq_empty_of_lt (by omega)]
    simpa using mul_nonneg (show (0 : ℝ) ≤ 24 by norm_num) (pow_nonneg hr 3)

end BuildingBlocks.ActualLogarithmicTailBounds

/-!
Complete proper-power remainder and Young assembly. No ordinary-prime signed
upper or RH result is asserted.
-/

namespace BuildingBlocks.ActualProperPrimePowerForcing

open ActualProperPowerEnergyAllocation ActualLogarithmicTailBounds CoarsePrimitive
open Set MeasureTheory
open scoped Interval BigOperators

noncomputable def rawRemainderRow (p k : ℕ) : ℝ :=
  Real.log (p : ℝ) * (p : ℝ) ^ (-(k : ℝ) / 2) * (1 + (k : ℝ) * Real.log (p : ℝ))

noncomputable def primeBaseRatio (p : ℕ) : ℝ := (p : ℝ) ^ (-(1 : ℝ) / 2)

noncomputable def signedProperPowerForce (c sigma Y : ℝ) : ℝ :=
  ∑ k ∈ Finset.Icc 2 ⌊Y⌋₊, ∑ p ∈ primeBases Y k,
    (Real.log (p : ℝ) * ((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma)) *
      (ActualPrimeErrorCausalTrace.preError c (p ^ k) / ((p ^ k : ℕ) : ℝ))

theorem rawRemainderRow_nonneg {p k : ℕ} (hp : 2 ≤ p) :
    0 ≤ rawRemainderRow p k := by
  have hl : 0 ≤ Real.log (p : ℝ) := Real.log_nonneg (by exact_mod_cast (show 1 ≤ p by omega))
  exact mul_nonneg (mul_nonneg hl (Real.rpow_nonneg (Nat.cast_nonneg p) _))
    (by positivity)

theorem gradeRemainder_nonneg (sigma Y : ℝ) (k : ℕ) :
    0 ≤ gradeRemainder sigma Y k := by
  apply Finset.sum_nonneg
  intro p hp
  have hm := mem_primeBases.mp hp
  have hp0 : 0 < p := by omega
  have hn1 : 1 ≤ p ^ k := Nat.one_le_pow k p hp0
  have hlp : 0 ≤ Real.log (p : ℝ) := Real.log_nonneg (by exact_mod_cast (show 1 ≤ p by omega))
  have hln : 0 ≤ Real.log ((p ^ k : ℕ) : ℝ) := Real.log_nonneg (by exact_mod_cast hn1)
  exact mul_nonneg (mul_nonneg hlp (Real.rpow_nonneg (by positivity) _)) (by linarith)

theorem power_rpow_half {p k : ℕ} (_hp : 2 ≤ p) :
    ((p ^ k : ℕ) : ℝ) ^ (-(1 : ℝ) / 2) = (p : ℝ) ^ (-(k : ℝ) / 2) := by
  rw [Nat.cast_pow, ← Real.rpow_natCast (p : ℝ) k,
    ← Real.rpow_mul (Nat.cast_nonneg p)]
  congr 1
  ring

theorem actual_remainder_row_le {p k : ℕ} (hp : 2 ≤ p) (_hk : 2 ≤ k)
    (sigma : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) :
    Real.log (p : ℝ) * ((p ^ k : ℕ) : ℝ) ^ ((1 : ℝ) / 2 - 2 * sigma) *
      (1 + Real.log ((p ^ k : ℕ) : ℝ)) ≤ rawRemainderRow p k := by
  have hp0 : 0 < p := by omega
  have hn1 : (1 : ℝ) ≤ ((p ^ k : ℕ) : ℝ) := by exact_mod_cast Nat.one_le_pow k p hp0
  have hlog : 0 ≤ Real.log (p : ℝ) := Real.log_nonneg (by exact_mod_cast (show 1 ≤ p by omega))
  have hweight := Real.rpow_le_rpow_of_exponent_le hn1
    (show (1 : ℝ) / 2 - 2 * sigma ≤ -(1 : ℝ) / 2 by linarith)
  have hln : 0 ≤ 1 + Real.log ((p ^ k : ℕ) : ℝ) :=
    by linarith [Real.log_nonneg hn1]
  have h := mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hweight hlog) hln
  rw [power_rpow_half hp, Nat.cast_pow, Real.log_pow] at h
  simpa only [Nat.cast_pow, Real.log_pow, rawRemainderRow] using h

theorem actual_grade_remainder_le_integer_sum (sigma Y : ℝ)
    (hsigma : (1 : ℝ) / 2 ≤ sigma) {k : ℕ} (hk : 2 ≤ k) :
    gradeRemainder sigma Y k ≤ ∑ p ∈ Finset.Icc 2 ⌊Y⌋₊, rawRemainderRow p k := by
  have hrow : gradeRemainder sigma Y k ≤
      ∑ p ∈ primeBases Y k, rawRemainderRow p k := by
    apply Finset.sum_le_sum
    intro p hp
    exact actual_remainder_row_le (mem_primeBases.mp hp).1 hk sigma hsigma
  have hsubset : primeBases Y k ⊆ Finset.Icc 2 ⌊Y⌋₊ := by
    intro p hp
    exact Finset.mem_Icc.mpr ⟨(mem_primeBases.mp hp).1, (mem_primeBases.mp hp).2.1⟩
  exact hrow.trans (Finset.sum_le_sum_of_subset_of_nonneg hsubset
    (fun p hp _ => rawRemainderRow_nonneg (Finset.mem_Icc.mp hp).1))

theorem primeBaseRatio_nonneg (p : ℕ) : 0 ≤ primeBaseRatio p :=
  Real.rpow_nonneg (Nat.cast_nonneg p) _

theorem primeBaseRatio_sq {p : ℕ} (_hp : 2 ≤ p) :
    primeBaseRatio p ^ 2 = (p : ℝ)⁻¹ := by
  unfold primeBaseRatio
  rw [← Real.rpow_natCast ((p : ℝ) ^ (-(1 : ℝ) / 2)) 2,
    ← Real.rpow_mul (Nat.cast_nonneg p)]
  norm_num [show (-(1 : ℝ) / 2) * (2 : ℝ) = -1 by ring, Real.rpow_neg_one]

theorem primeBaseRatio_le_three_quarters {p : ℕ} (hp : 2 ≤ p) :
    primeBaseRatio p ≤ (3 : ℝ) / 4 := by
  have hp2 : (2 : ℝ) ≤ p := by exact_mod_cast hp
  have hinv : (p : ℝ)⁻¹ ≤ (1 : ℝ) / 2 := by
    simpa only [one_div] using one_div_le_one_div_of_le (by norm_num : (0 : ℝ) < 2) hp2
  have hs := primeBaseRatio_sq hp
  nlinarith [sq_nonneg (primeBaseRatio p - 3 / 4)]

theorem primeBaseRatio_pow {p k : ℕ} (_hp : 2 ≤ p) :
    primeBaseRatio p ^ k = (p : ℝ) ^ (-(k : ℝ) / 2) := by
  unfold primeBaseRatio
  rw [← Real.rpow_natCast ((p : ℝ) ^ (-(1 : ℝ) / 2)) k,
    ← Real.rpow_mul (Nat.cast_nonneg p)]
  congr 1
  ring

theorem primeBaseRatio_cube {p : ℕ} (hp : 2 ≤ p) :
    primeBaseRatio p ^ 3 = 1 / (p : ℝ) ^ ((3 : ℝ) / 2) := by
  rw [primeBaseRatio_pow hp]
  norm_num only [Nat.cast_ofNat]
  rw [Real.rpow_neg (Nat.cast_nonneg p), one_div]

noncomputable def harmonicBaseMass (Y : ℝ) : ℝ :=
  ∑ p ∈ primeBases Y 2, Real.log (p : ℝ) / (p : ℝ)

theorem harmonicBaseMass_le_native (Y : ℝ) :
    harmonicBaseMass Y ≤ logarithmicPrimeMass ⌊Y⌋₊ := by
  have hsubset : primeBases Y 2 ⊆ Finset.Icc 1 ⌊Y⌋₊ := by
    intro p hp
    have hm := mem_primeBases.mp hp
    exact Finset.mem_Icc.mpr ⟨by omega, hm.2.1⟩
  calc
    harmonicBaseMass Y = ∑ p ∈ primeBases Y 2,
        ArithmeticFunction.vonMangoldt p / (p : ℝ) := by
      apply Finset.sum_congr rfl
      intro p hp
      rw [ArithmeticFunction.vonMangoldt_apply_prime (mem_primeBases.mp hp).2.2.1]
    _ ≤ ∑ p ∈ Finset.Icc 1 ⌊Y⌋₊, ArithmeticFunction.vonMangoldt p / (p : ℝ) :=
      Finset.sum_le_sum_of_subset_of_nonneg hsubset (fun p _ _ =>
        div_nonneg ArithmeticFunction.vonMangoldt_nonneg (Nat.cast_nonneg p))
    _ = logarithmicPrimeMass ⌊Y⌋₊ := rfl

theorem native_harmonicMass_le_seventeen_log_sq {Y : ℝ} (hY : 1 ≤ Y) :
    logarithmicPrimeMass ⌊Y⌋₊ ≤ 17 * Real.log (2 * Y) ^ 2 := by
  have hN : 1 ≤ ⌊Y⌋₊ := (Nat.one_le_floor_iff Y).2 hY
  have hY0 : 0 < Y := by linarith
  have hN0 : (0 : ℝ) < (⌊Y⌋₊ : ℝ) := by exact_mod_cast (show 0 < ⌊Y⌋₊ by omega)
  have hlogNY : Real.log (⌊Y⌋₊ : ℝ) ≤ Real.log Y :=
    Real.log_le_log hN0 (Nat.floor_le hY0.le)
  have hlogY : 0 ≤ Real.log Y := Real.log_nonneg hY
  have hlog2lo : (1 : ℝ) / 2 ≤ Real.log 2 := by linarith [Real.log_two_gt_d9]
  have hlog2hi : Real.log 2 ≤ (1 : ℝ) := by linarith [Real.log_two_lt_d9]
  have hell : Real.log (2 * Y) = Real.log 2 + Real.log Y :=
    Real.log_mul (by norm_num) (ne_of_gt hY0)
  have hlin : Real.log Y ≤ Real.log (2 * Y) ^ 2 := by
    have hc : 0 ≤ (2 * Real.log 2 - 1) * Real.log Y := mul_nonneg (by linarith) hlogY
    nlinarith [sq_nonneg (Real.log 2), sq_nonneg (Real.log Y)]
  have hell2 : (1 : ℝ) / 4 ≤ Real.log (2 * Y) ^ 2 := by
    nlinarith [sq_nonneg (Real.log (2 * Y) - 1 / 2)]
  have hm := (logarithmicPrimeMass_bounds hN).2
  nlinarith

theorem rawRemainderRow_two (p : ℕ) :
    rawRemainderRow p 2 = Real.log (p : ℝ) / (p : ℝ) +
      2 * (Real.log (p : ℝ) ^ 2 / (p : ℝ)) := by
  norm_num [rawRemainderRow, Real.rpow_neg_one, div_eq_mul_inv]
  ring

theorem actual_square_grade_remainder_le_masses (sigma Y : ℝ)
    (hsigma : (1 : ℝ) / 2 ≤ sigma) :
    gradeRemainder sigma Y 2 ≤ harmonicBaseMass Y + 2 * primeHarmonicSecondMass Y := by
  calc
    gradeRemainder sigma Y 2 ≤ ∑ p ∈ primeBases Y 2, rawRemainderRow p 2 := by
      apply Finset.sum_le_sum
      intro p hp
      exact actual_remainder_row_le (mem_primeBases.mp hp).1 (by decide) sigma hsigma
    _ = harmonicBaseMass Y + 2 * primeHarmonicSecondMass Y := by
      simp_rw [rawRemainderRow_two]
      rw [Finset.sum_add_distrib, ← Finset.mul_sum]
      rfl

theorem actual_square_grade_remainder_le_thirty_five_log_sq {Y : ℝ} (hY : 1 ≤ Y)
    (sigma : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) :
    gradeRemainder sigma Y 2 ≤ 35 * Real.log (2 * Y) ^ 2 := by
  have hg := actual_square_grade_remainder_le_masses sigma Y hsigma
  have hfirst := (harmonicBaseMass_le_native Y).trans (native_harmonicMass_le_seventeen_log_sq hY)
  have hsecond := primeHarmonicSecondMass_le_nine_log_sq hY
  linarith

theorem rawRemainderRow_eq_geometric {p k : ℕ} (hp : 2 ≤ p) :
    rawRemainderRow p k = Real.log (p : ℝ) * primeBaseRatio p ^ k +
      Real.log (p : ℝ) ^ 2 * ((k : ℝ) * primeBaseRatio p ^ k) := by
  rw [primeBaseRatio_pow hp]
  unfold rawRemainderRow
  ring

theorem finite_rawRemainder_high_degrees {p : ℕ} (hp : 2 ≤ p) (K : ℕ) :
    (∑ k ∈ Finset.Icc 3 K, rawRemainderRow p k) ≤
      4 * (Real.log (p : ℝ) / (p : ℝ) ^ ((3 : ℝ) / 2)) +
        24 * (Real.log (p : ℝ) ^ 2 / (p : ℝ) ^ ((3 : ℝ) / 2)) := by
  have hl : 0 ≤ Real.log (p : ℝ) := Real.log_nonneg (by exact_mod_cast (show 1 ≤ p by omega))
  have hg := finite_geometric_tail_le_four K (primeBaseRatio_nonneg p)
    (primeBaseRatio_le_three_quarters hp)
  have hw := finite_weighted_geometric_tail_le_twenty_four K (primeBaseRatio_nonneg p)
    (primeBaseRatio_le_three_quarters hp)
  have hi := add_le_add (mul_le_mul_of_nonneg_left hg hl)
    (mul_le_mul_of_nonneg_left hw (sq_nonneg (Real.log (p : ℝ))))
  rw [primeBaseRatio_cube hp] at hi
  calc
    (∑ k ∈ Finset.Icc 3 K, rawRemainderRow p k) =
        Real.log (p : ℝ) * (∑ k ∈ Finset.Icc 3 K, primeBaseRatio p ^ k) +
          Real.log (p : ℝ) ^ 2 * (∑ k ∈ Finset.Icc 3 K, (k : ℝ) * primeBaseRatio p ^ k) := by
      simp_rw [rawRemainderRow_eq_geometric hp]
      rw [Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.mul_sum]
    _ ≤ _ := by convert hi using 1; ring

theorem actual_high_grade_remainder_le_648 (sigma Y : ℝ)
    (hsigma : (1 : ℝ) / 2 ≤ sigma) :
    (∑ k ∈ Finset.Icc 3 ⌊Y⌋₊, gradeRemainder sigma Y k) ≤ 648 := by
  calc
    _ ≤ ∑ k ∈ Finset.Icc 3 ⌊Y⌋₊, ∑ p ∈ Finset.Icc 2 ⌊Y⌋₊, rawRemainderRow p k := by
      apply Finset.sum_le_sum
      intro k hk
      exact actual_grade_remainder_le_integer_sum sigma Y hsigma
        (by have := (Finset.mem_Icc.mp hk).1; omega)
    _ = ∑ p ∈ Finset.Icc 2 ⌊Y⌋₊, ∑ k ∈ Finset.Icc 3 ⌊Y⌋₊, rawRemainderRow p k :=
      Finset.sum_comm
    _ ≤ ∑ p ∈ Finset.Icc 2 ⌊Y⌋₊,
        (4 * (Real.log (p : ℝ) / (p : ℝ) ^ ((3 : ℝ) / 2)) +
          24 * (Real.log (p : ℝ) ^ 2 / (p : ℝ) ^ ((3 : ℝ) / 2))) := by
      apply Finset.sum_le_sum
      intro p hp
      exact finite_rawRemainder_high_degrees (Finset.mem_Icc.mp hp).1 ⌊Y⌋₊
    _ = 4 * (∑ p ∈ Finset.Icc 2 ⌊Y⌋₊, Real.log (p : ℝ) / (p : ℝ) ^ ((3 : ℝ) / 2)) +
        24 * (∑ p ∈ Finset.Icc 2 ⌊Y⌋₊, Real.log (p : ℝ) ^ 2 / (p : ℝ) ^ ((3 : ℝ) / 2)) := by
      rw [Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.mul_sum]
    _ ≤ 648 := by
      linarith [finite_log_tail_le_six ⌊Y⌋₊, finite_log_sq_tail_le_twenty_six ⌊Y⌋₊]

theorem all_grade_remainders_le_square_add_high (sigma Y : ℝ) :
    (∑ k ∈ Finset.Icc 2 ⌊Y⌋₊, gradeRemainder sigma Y k) ≤
      gradeRemainder sigma Y 2 + ∑ k ∈ Finset.Icc 3 ⌊Y⌋₊, gradeRemainder sigma Y k := by
  have hsubset : Finset.Icc 2 ⌊Y⌋₊ ⊆ insert 2 (Finset.Icc 3 ⌊Y⌋₊) := by
    intro k hk
    have hm := Finset.mem_Icc.mp hk
    by_cases he : k = 2
    · exact Finset.mem_insert.mpr (Or.inl he)
    · exact Finset.mem_insert.mpr (Or.inr (Finset.mem_Icc.mpr ⟨by omega, hm.2⟩))
  have hsum := Finset.sum_le_sum_of_subset_of_nonneg hsubset
    (fun k _ _ => gradeRemainder_nonneg sigma Y k)
  simpa only [Finset.sum_insert (show 2 ∉ Finset.Icc 3 ⌊Y⌋₊ by simp)] using hsum

theorem actual_all_grade_remainders_le_three_thousand_log_sq {Y : ℝ} (hY : 1 ≤ Y)
    (sigma : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) :
    (∑ k ∈ Finset.Icc 2 ⌊Y⌋₊, gradeRemainder sigma Y k) ≤
      3000 * Real.log (2 * Y) ^ 2 := by
  have hsplit := all_grade_remainders_le_square_add_high sigma Y
  have htwo := actual_square_grade_remainder_le_thirty_five_log_sq hY sigma hsigma
  have hhigh := actual_high_grade_remainder_le_648 sigma Y hsigma
  have hY0 : 0 < Y := by linarith
  have hlogY : 0 ≤ Real.log Y := Real.log_nonneg hY
  have hlog2 : (1 : ℝ) / 2 ≤ Real.log 2 := by linarith [Real.log_two_gt_d9]
  have hell : Real.log (2 * Y) = Real.log 2 + Real.log Y :=
    Real.log_mul (by norm_num) (ne_of_gt hY0)
  have hell2 : (1 : ℝ) / 4 ≤ Real.log (2 * Y) ^ 2 := by
    nlinarith [sq_nonneg (Real.log (2 * Y) - 1 / 2)]
  nlinarith [sq_nonneg (Real.log (2 * Y))]

theorem actual_full_absolute_force_bound {Y : ℝ} (hY : 1 ≤ Y)
    (c sigma : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) :
    fullAbsoluteForce c sigma Y ≤
      24 * Real.log (2 * Y) * Real.sqrt (fullEnergy c sigma Y) +
        3000 * Real.log (2 * Y) ^ 2 := by
  exact (actual_full_absolute_force_le_with_remainder hY c sigma hsigma).trans
    (add_le_add_left (actual_all_grade_remainders_le_three_thousand_log_sq hY sigma hsigma) _)

theorem abs_signedProperPowerForce_le_fullAbsoluteForce (c sigma Y : ℝ) :
    |signedProperPowerForce c sigma Y| ≤ fullAbsoluteForce c sigma Y := by
  unfold signedProperPowerForce fullAbsoluteForce
  apply (Finset.abs_sum_le_sum_abs _ _).trans
  apply Finset.sum_le_sum
  intro k _
  unfold gradeAbsoluteForce
  apply (Finset.abs_sum_le_sum_abs _ _).trans_eq
  apply Finset.sum_congr rfl
  intro p hp
  have hw : 0 ≤ Real.log (p : ℝ) * ((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma) :=
    mul_nonneg (Real.log_nonneg (by exact_mod_cast (show 1 ≤ p by have := (mem_primeBases.mp hp).1; omega)))
      (Real.rpow_nonneg (by positivity) _)
  rw [abs_mul, abs_of_nonneg hw]

theorem actual_signed_proper_power_force_bound {Y : ℝ} (hY : 1 ≤ Y)
    (c sigma : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) :
    |signedProperPowerForce c sigma Y| ≤
      24 * Real.log (2 * Y) * Real.sqrt (fullEnergy c sigma Y) +
        3000 * Real.log (2 * Y) ^ 2 :=
  (abs_signedProperPowerForce_le_fullAbsoluteForce c sigma Y).trans
    (actual_full_absolute_force_bound hY c sigma hsigma)

theorem finite_energy_young (E ell eta : ℝ) (hE : 0 ≤ E) (heta : 0 < eta) :
    24 * ell * Real.sqrt E ≤ eta * E + 144 * ell ^ 2 / eta := by
  have hsq := sq_nonneg (eta * Real.sqrt E - 12 * ell)
  have hroot := Real.sq_sqrt hE
  have hm : (24 * ell * Real.sqrt E) * eta ≤ eta ^ 2 * E + 144 * ell ^ 2 := by
    nlinarith
  calc
    24 * ell * Real.sqrt E ≤ (eta ^ 2 * E + 144 * ell ^ 2) / eta :=
      (le_div_iff₀ heta).2 hm
    _ = eta * E + 144 * ell ^ 2 / eta := by
      field_simp

theorem actual_full_absolute_force_young {Y : ℝ} (hY : 1 ≤ Y)
    (c sigma eta : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) (heta : 0 < eta) :
    fullAbsoluteForce c sigma Y ≤
      eta * fullEnergy c sigma Y + (3000 + 144 / eta) * Real.log (2 * Y) ^ 2 := by
  have hb := actual_full_absolute_force_bound hY c sigma hsigma
  have hy := finite_energy_young (fullEnergy c sigma Y) (Real.log (2 * Y)) eta
    (fullEnergy_nonneg hY c sigma) heta
  have h := hb.trans (add_le_add_right hy (3000 * Real.log (2 * Y) ^ 2))
  convert h using 1; ring

theorem actual_signed_proper_power_force_young {Y : ℝ} (hY : 1 ≤ Y)
    (c sigma eta : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) (heta : 0 < eta) :
    |signedProperPowerForce c sigma Y| ≤
      eta * fullEnergy c sigma Y + (3000 + 144 / eta) * Real.log (2 * Y) ^ 2 :=
  (abs_signedProperPowerForce_le_fullAbsoluteForce c sigma Y).trans
    (actual_full_absolute_force_young hY c sigma eta hsigma heta)

theorem signedProperPowerForce_eq_actualLambda_sum (c sigma Y : ℝ) :
    signedProperPowerForce c sigma Y =
      ∑ k ∈ Finset.Icc 2 ⌊Y⌋₊, ∑ p ∈ primeBases Y k,
        (ArithmeticFunction.vonMangoldt (p ^ k) * ((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma)) *
          ((psi (p ^ k - 1) - ((p ^ k : ℕ) : ℝ) + c) / ((p ^ k : ℕ) : ℝ)) := by
  unfold signedProperPowerForce
  apply Finset.sum_congr rfl
  intro k hk
  apply Finset.sum_congr rfl
  intro p hp
  rw [actual_row_vonMangoldt (Finset.mem_Icc.mp hk).1 hp]
  rfl

theorem actual_lambda_proper_power_force_bound {Y : ℝ} (hY : 1 ≤ Y)
    (c sigma : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) :
    |∑ k ∈ Finset.Icc 2 ⌊Y⌋₊, ∑ p ∈ primeBases Y k,
      (ArithmeticFunction.vonMangoldt (p ^ k) * ((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma)) *
        ((psi (p ^ k - 1) - ((p ^ k : ℕ) : ℝ) + c) / ((p ^ k : ℕ) : ℝ))| ≤
      24 * Real.log (2 * Y) *
        Real.sqrt (∫ t in (1 : ℝ)..Y, ((psi ⌊t⌋₊ - t + c) / t) ^ 2 * t ^ (1 - 2 * sigma)) +
        3000 * Real.log (2 * Y) ^ 2 := by
  rw [← signedProperPowerForce_eq_actualLambda_sum]
  simpa only [fullEnergy, energyDensity, ActualPrimeErrorCausalTrace.centeredError, primeErrorReal] using
    actual_signed_proper_power_force_bound hY c sigma hsigma

theorem actual_lambda_proper_power_force_young {Y : ℝ} (hY : 1 ≤ Y)
    (c sigma eta : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) (heta : 0 < eta) :
    |∑ k ∈ Finset.Icc 2 ⌊Y⌋₊, ∑ p ∈ primeBases Y k,
      (ArithmeticFunction.vonMangoldt (p ^ k) * ((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma)) *
        ((psi (p ^ k - 1) - ((p ^ k : ℕ) : ℝ) + c) / ((p ^ k : ℕ) : ℝ))| ≤
      eta * (∫ t in (1 : ℝ)..Y, ((psi ⌊t⌋₊ - t + c) / t) ^ 2 * t ^ (1 - 2 * sigma)) +
        (3000 + 144 / eta) * Real.log (2 * Y) ^ 2 := by
  rw [← signedProperPowerForce_eq_actualLambda_sum]
  simpa only [fullEnergy, energyDensity, ActualPrimeErrorCausalTrace.centeredError, primeErrorReal] using
    actual_signed_proper_power_force_young hY c sigma eta hsigma heta

theorem fullAbsoluteForce_eq_actualLambda_abs_sum (c sigma Y : ℝ) :
    fullAbsoluteForce c sigma Y =
      ∑ k ∈ Finset.Icc 2 ⌊Y⌋₊, ∑ p ∈ primeBases Y k,
        |(ArithmeticFunction.vonMangoldt (p ^ k) * ((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma)) *
          ((psi (p ^ k - 1) - ((p ^ k : ℕ) : ℝ) + c) / ((p ^ k : ℕ) : ℝ))| := by
  unfold fullAbsoluteForce
  apply Finset.sum_congr rfl
  intro k hk
  unfold gradeAbsoluteForce
  apply Finset.sum_congr rfl
  intro p hp
  have hw : 0 ≤ Real.log (p : ℝ) * ((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma) :=
    mul_nonneg (Real.log_nonneg (by exact_mod_cast (show 1 ≤ p by have := (mem_primeBases.mp hp).1; omega)))
      (Real.rpow_nonneg (by positivity) _)
  rw [actual_row_vonMangoldt (Finset.mem_Icc.mp hk).1 hp, abs_mul, abs_of_nonneg hw]
  rfl

theorem actual_lambda_absolute_rows_bound {Y : ℝ} (hY : 1 ≤ Y)
    (c sigma : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) :
    (∑ k ∈ Finset.Icc 2 ⌊Y⌋₊, ∑ p ∈ primeBases Y k,
      |(ArithmeticFunction.vonMangoldt (p ^ k) * ((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma)) *
        ((psi (p ^ k - 1) - ((p ^ k : ℕ) : ℝ) + c) / ((p ^ k : ℕ) : ℝ))|) ≤
      24 * Real.log (2 * Y) *
        Real.sqrt (∫ t in (1 : ℝ)..Y, ((psi ⌊t⌋₊ - t + c) / t) ^ 2 * t ^ (1 - 2 * sigma)) +
        3000 * Real.log (2 * Y) ^ 2 := by
  rw [← fullAbsoluteForce_eq_actualLambda_abs_sum]
  simpa only [fullEnergy, energyDensity, ActualPrimeErrorCausalTrace.centeredError, primeErrorReal] using
    actual_full_absolute_force_bound hY c sigma hsigma

theorem actual_lambda_absolute_rows_young {Y : ℝ} (hY : 1 ≤ Y)
    (c sigma eta : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) (heta : 0 < eta) :
    (∑ k ∈ Finset.Icc 2 ⌊Y⌋₊, ∑ p ∈ primeBases Y k,
      |(ArithmeticFunction.vonMangoldt (p ^ k) * ((p ^ k : ℕ) : ℝ) ^ (1 - 2 * sigma)) *
        ((psi (p ^ k - 1) - ((p ^ k : ℕ) : ℝ) + c) / ((p ^ k : ℕ) : ℝ))|) ≤
      eta * (∫ t in (1 : ℝ)..Y, ((psi ⌊t⌋₊ - t + c) / t) ^ 2 * t ^ (1 - 2 * sigma)) +
        (3000 + 144 / eta) * Real.log (2 * Y) ^ 2 := by
  rw [← fullAbsoluteForce_eq_actualLambda_abs_sum]
  simpa only [fullEnergy, energyDensity, ActualPrimeErrorCausalTrace.centeredError, primeErrorReal] using
    actual_full_absolute_force_young hY c sigma eta hsigma heta

end BuildingBlocks.ActualProperPrimePowerForcing
