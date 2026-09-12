import BuildingBlocks.PrimeSeedFiniteDerivative
import BuildingBlocks.PrimeSeedSquareConvergence

/-! Local finiteness and infinite total mass of the full-prime derivative
components. No globally finite signed derivative is assumed. -/

open MeasureTheory Real Set
open scoped ENNReal NNReal MeasureTheory

namespace BuildingBlocks.PrimeSeedMass

noncomputable def allPrimeDerivativePositive : Measure ℝ :=
  Measure.sum (fun p : Nat.Primes => seedDerivativePositive (log p))

noncomputable def allPrimeDerivativeNegative : Measure ℝ :=
  Measure.sum (fun p : Nat.Primes => seedDerivativeNegative (log p))

theorem allPrimeDerivative_mutuallySingular : allPrimeDerivativePositive ⟂ₘ allPrimeDerivativeNegative := by
  apply Measure.MutuallySingular.sum_left.2
  intro p
  apply Measure.MutuallySingular.sum_right.2
  exact prime_derivative_cross_mutuallySingular p

theorem not_summable_prime_derivative_mass :
    ¬ Summable (fun p : Nat.Primes => exp (-log (p : ℝ)) + exp (-3 * log (p : ℝ) / 2)) := by
  intro h
  apply Nat.Primes.not_summable_one_div
  apply Summable.of_nonneg_of_le (fun p => by positivity) _ h
  intro p
  rw [exp_neg, exp_log (by exact_mod_cast p.property.pos)]
  simpa only [one_div] using le_add_of_nonneg_right (exp_pos (-3 * log (p : ℝ) / 2)).le

theorem prime_derivative_mass_tsum_top :
    (∑' p : Nat.Primes, ENNReal.ofReal (exp (-log (p : ℝ)) + exp (-3 * log (p : ℝ) / 2))) = ∞ := by
  let f : Nat.Primes → ℝ≥0 := fun p =>
    ⟨exp (-log (p : ℝ)) + exp (-3 * log (p : ℝ) / 2), by positivity⟩
  change (∑' p : Nat.Primes, ENNReal.ofReal (f p : ℝ)) = ∞
  simpa only [ENNReal.ofReal_coe_nnreal] using
    (ENNReal.tsum_coe_eq_top_iff_not_summable_coe.mpr
      (show ¬ Summable (fun p : Nat.Primes => (f p : ℝ)) from not_summable_prime_derivative_mass))

theorem allPrimeDerivativePositive_mass : allPrimeDerivativePositive univ = ∞ := by
  unfold allPrimeDerivativePositive
  rw [Measure.sum_apply _ MeasurableSet.univ]
  have h (p : Nat.Primes) := seedDerivativePositive_mass
    (log_pos (show (1 : ℝ) < (p : ℝ) by exact_mod_cast p.property.one_lt))
  simp_rw [h]
  exact prime_derivative_mass_tsum_top

theorem allPrimeDerivativeNegative_mass : allPrimeDerivativeNegative univ = ∞ := by
  unfold allPrimeDerivativeNegative
  rw [Measure.sum_apply _ MeasurableSet.univ]
  have h (p : Nat.Primes) := seedDerivativeNegative_mass
    (log_pos (show (1 : ℝ) < (p : ℝ) by exact_mod_cast p.property.one_lt))
  simp_rw [h]
  exact prime_derivative_mass_tsum_top

theorem seedDerivativePositive_Iic_zero {L A : ℝ} (hA : A < L) :
    seedDerivativePositive L (Iic A) = 0 := by
  unfold seedDerivativePositive
  rw [Measure.add_apply, withDensity_apply _ measurableSet_Iic, Measure.smul_apply,
    Measure.dirac_apply' _ measurableSet_Iic]
  have hi : (∫⁻ v in Iic A, ENNReal.ofReal (seed L v / 2)) = 0 := by
    apply (lintegral_eq_zero_iff ((measurable_seed L).div_const 2).ennreal_ofReal).2
    filter_upwards [ae_restrict_mem measurableSet_Iic] with v hv
    rw [seed_eq_zero (hv.trans_lt hA)]
    simp
  rw [hi]
  simp [not_le.mpr hA]

theorem seedDerivativeNegative_Iic_zero {L A : ℝ} (hL : 0 < L) (hA : A < L) :
    seedDerivativeNegative L (Iic A) = 0 := by
  unfold seedDerivativeNegative
  rw [Measure.sum_apply _ measurableSet_Iic]
  have hz (j : ℕ) :
      (ENNReal.ofReal ((1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2)) •
        Measure.dirac ((j + 2 : ℝ) * L)) (Iic A) = 0 := by
    rw [Measure.smul_apply, Measure.dirac_apply' _ measurableSet_Iic]
    have hja : A < (j + 2 : ℝ) * L := by
      have hj : (0 : ℝ) ≤ j := Nat.cast_nonneg _
      nlinarith
    simp [not_le.mpr hja]
  simp_rw [hz, tsum_zero]

theorem prime_clock_gt_of_cutoff {A : ℝ} {p : Nat.Primes}
    (hp : ⌊exp A⌋₊ + 1 ≤ (p : ℕ)) : A < log (p : ℝ) := by
  apply (lt_log_iff_exp_lt (by exact_mod_cast p.property.pos)).2
  exact (Nat.lt_floor_add_one (exp A)).trans_le (by exact_mod_cast hp)

theorem allPrimeDerivativePositive_Iic_cutoff (A : ℝ) :
    allPrimeDerivativePositive (Iic A) =
      finiteSeedDerivativePositive (primesBelow (⌊exp A⌋₊ + 1)) (Iic A) := by
  unfold allPrimeDerivativePositive finiteSeedDerivativePositive
  rw [Measure.sum_apply _ measurableSet_Iic, Measure.sum_apply _ measurableSet_Iic]
  rw [tsum_fintype (f := fun p : primesBelow (⌊exp A⌋₊ + 1) =>
    seedDerivativePositive (log (p.val : ℝ)) (Iic A))]
  rw [Finset.sum_coe_sort (primesBelow (⌊exp A⌋₊ + 1))
    (fun p : Nat.Primes => seedDerivativePositive (log p) (Iic A))]
  apply tsum_eq_sum
  intro p hp
  apply seedDerivativePositive_Iic_zero
  exact prime_clock_gt_of_cutoff (Nat.le_of_not_gt (by simpa using hp))

theorem allPrimeDerivativeNegative_Iic_cutoff (A : ℝ) :
    allPrimeDerivativeNegative (Iic A) =
      finiteSeedDerivativeNegative (primesBelow (⌊exp A⌋₊ + 1)) (Iic A) := by
  unfold allPrimeDerivativeNegative finiteSeedDerivativeNegative
  rw [Measure.sum_apply _ measurableSet_Iic, Measure.sum_apply _ measurableSet_Iic]
  rw [tsum_fintype (f := fun p : primesBelow (⌊exp A⌋₊ + 1) =>
    seedDerivativeNegative (log (p.val : ℝ)) (Iic A))]
  rw [Finset.sum_coe_sort (primesBelow (⌊exp A⌋₊ + 1))
    (fun p : Nat.Primes => seedDerivativeNegative (log p) (Iic A))]
  apply tsum_eq_sum
  intro p hp
  apply seedDerivativeNegative_Iic_zero (log_pos (show (1 : ℝ) < (p : ℝ) by exact_mod_cast p.property.one_lt))
  exact prime_clock_gt_of_cutoff (Nat.le_of_not_gt (by simpa using hp))

theorem allPrimeDerivativePositive_Iic_finite (A : ℝ) : allPrimeDerivativePositive (Iic A) < ∞ := by
  rw [allPrimeDerivativePositive_Iic_cutoff]
  exact measure_lt_top _ _

theorem allPrimeDerivativeNegative_Iic_finite (A : ℝ) : allPrimeDerivativeNegative (Iic A) < ∞ := by
  rw [allPrimeDerivativeNegative_Iic_cutoff]
  exact measure_lt_top _ _

theorem prime_measure_restrict_cutoff (ν : Nat.Primes → Measure ℝ) (S : Finset Nat.Primes)
    (A : ℝ) (hz : ∀ p ∉ S, ν p (Iic A) = 0) :
    (Measure.sum ν).restrict (Iic A) = (Measure.sum (fun p : S => ν p.val)).restrict (Iic A) := by
  ext E hE
  simp only [Measure.restrict_apply hE]
  rw [Measure.sum_apply _ (hE.inter measurableSet_Iic), Measure.sum_apply _ (hE.inter measurableSet_Iic),
    tsum_fintype (f := fun p : S => ν p.val (E ∩ Iic A)),
    Finset.sum_coe_sort S (fun p => ν p (E ∩ Iic A))]
  apply tsum_eq_sum
  intro p hp
  exact measure_mono_null inter_subset_right (hz p hp)

theorem allPrimeDerivativePositive_restrict_Iic (A : ℝ) :
    allPrimeDerivativePositive.restrict (Iic A) =
      (finiteSeedDerivativePositive (primesBelow (⌊exp A⌋₊ + 1))).restrict (Iic A) := by
  apply prime_measure_restrict_cutoff
  intro p hp
  exact seedDerivativePositive_Iic_zero
    (prime_clock_gt_of_cutoff (Nat.le_of_not_gt (by simpa using hp)))

theorem allPrimeDerivativeNegative_restrict_Iic (A : ℝ) :
    allPrimeDerivativeNegative.restrict (Iic A) =
      (finiteSeedDerivativeNegative (primesBelow (⌊exp A⌋₊ + 1))).restrict (Iic A) := by
  apply prime_measure_restrict_cutoff
  intro p hp
  exact seedDerivativeNegative_Iic_zero (log_pos (by exact_mod_cast p.property.one_lt))
    (prime_clock_gt_of_cutoff (Nat.le_of_not_gt (by simpa using hp)))

theorem allPrimeSeed_eq_age_cutoff (A : ℝ) {v : ℝ} (hv : v ≤ A) :
    allPrimeSeed v = finitePrimeSeed (primesBelow (⌊exp A⌋₊ + 1)) v := by
  unfold allPrimeSeed finitePrimeSeed
  apply tsum_eq_sum
  intro p hp
  exact seed_eq_zero (hv.trans_lt
    (prime_clock_gt_of_cutoff (Nat.le_of_not_gt (by simpa using hp))))

theorem integrable_bounded_age_test {μ : Measure ℝ} {A : ℝ}
    (hfin : μ (Iic A) < ∞) {φ : ℝ → ℝ} (hm : Measurable φ)
    (hb : ∃ M, ∀ v, |φ v| ≤ M) (hz : ∀ v, A < v → φ v = 0) : Integrable φ μ := by
  letI : IsFiniteMeasure (μ.restrict (Iic A)) := ⟨by simpa using hfin⟩
  obtain ⟨M, hM⟩ := hb
  have hi : Integrable φ (μ.restrict (Iic A)) := by
    apply (integrable_const M).mono' hm.aestronglyMeasurable
    exact Filter.Eventually.of_forall (fun v => by simpa only [Real.norm_eq_abs] using hM v)
  have hind : (Iic A).indicator φ = φ := by
    funext v
    by_cases hv : v ≤ A
    · simp [hv]
    · simp [hv, hz v (lt_of_not_ge hv)]
  rw [← hind]
  exact (integrable_indicator_iff measurableSet_Iic).2 hi

theorem allPrimeSeed_weak_derivative {A : ℝ} {φ φ' : ℝ → ℝ}
    (hφ : ∀ v, HasDerivAt φ (φ' v) v) (hc : Continuous φ')
    (hb : ∃ M, ∀ v, |φ v| ≤ M) (hb' : ∃ M, ∀ v, |φ' v| ≤ M)
    (hz : ∀ v, A < v → φ v = 0) (hz' : ∀ v, A < v → φ' v = 0) :
    Integrable φ allPrimeDerivativePositive ∧ Integrable φ allPrimeDerivativeNegative ∧
      Integrable (fun v => allPrimeSeed v * φ' v) ∧
      (∫ v, allPrimeSeed v * φ' v) =
        (∫ v, φ v ∂allPrimeDerivativeNegative) - ∫ v, φ v ∂allPrimeDerivativePositive := by
  have hm : Measurable φ :=
    (continuous_iff_continuousAt.2 (fun v => (hφ v).continuousAt)).measurable
  have he (v : ℝ) : allPrimeSeed v * φ' v =
      finitePrimeSeed (primesBelow (⌊exp A⌋₊ + 1)) v * φ' v := by
    by_cases hv : v ≤ A
    · rw [allPrimeSeed_eq_age_cutoff A hv]
    · simp [hz' v (lt_of_not_ge hv)]
  have hif : Integrable (fun v => finitePrimeSeed (primesBelow (⌊exp A⌋₊ + 1)) v * φ' v) := by
    simp only [finitePrimeSeed, Finset.sum_mul]
    apply integrable_finset_sum
    intro p hp
    exact seed_test_product_integrable (log_pos (by exact_mod_cast p.property.one_lt))
      hc.aestronglyMeasurable hb'
  have hiB : Integrable (fun v => allPrimeSeed v * φ' v) :=
    hif.congr (Filter.Eventually.of_forall (fun v => (he v).symm))
  refine ⟨integrable_bounded_age_test (allPrimeDerivativePositive_Iic_finite A) hm hb hz,
    integrable_bounded_age_test (allPrimeDerivativeNegative_Iic_finite A) hm hb hz, hiB, ?_⟩
  simp_rw [he]
  have hi (μ : Measure ℝ) : (∫ v in Iic A, φ v ∂μ) = ∫ v, φ v ∂μ :=
    setIntegral_eq_integral_of_forall_compl_eq_zero (fun v hv => hz v (lt_of_not_ge hv))
  rw [← hi allPrimeDerivativeNegative, ← hi allPrimeDerivativePositive,
    allPrimeDerivativeNegative_restrict_Iic, allPrimeDerivativePositive_restrict_Iic,
    hi, hi]
  exact finiteSeedDerivative_represents_weak_derivative _ hφ hc hb hb'

end BuildingBlocks.PrimeSeedMass
