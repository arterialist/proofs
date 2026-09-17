import BuildingBlocks.PrimeSeedActivityBound
import BuildingBlocks.PrimeSeedSemigroup

/-! The actual all-prime positive jump measure and its probability semigroup.
Finite activity follows from the proved Chebyshev shell bound. No PNT, RH,
or presumed summability of the arithmetic coefficients is an input.
-/

open MeasureTheory Real
open scoped MeasureTheory NNReal ENNReal

namespace BuildingBlocks.PrimeSeedMass

private theorem prime_log_pos (p : Nat.Primes) : 0 < log (p : ℝ) :=
  log_pos (by exact_mod_cast p.property.one_lt)

theorem prime_levy_mass_le (p : Nat.Primes) :
    (∫ v, seed (log p) v / v) ≤ 2 * (1 / ((p : ℝ) * log p)) := by
  calc
    (∫ v, seed (log p) v / v) ≤ 2 * exp (-log (p : ℝ)) / log p :=
      integral_seed_div_age_le (prime_log_pos p)
    _ = 2 * (1 / ((p : ℝ) * log p)) := by
      rw [exp_neg, exp_log (by exact_mod_cast p.property.pos)]
      ring

theorem summable_prime_levy_masses :
    Summable (fun p : Nat.Primes => ∫ v, seed (log p) v / v) := by
  apply (summable_prime_reciprocal_mul_log.mul_left 2).of_norm_bounded
  intro p
  rw [Real.norm_eq_abs, abs_of_nonneg
    (integral_nonneg (seed_div_age_nonneg (prime_log_pos p)))]
  exact prime_levy_mass_le p

theorem singleton_levyMeasure_mass (p : Nat.Primes) :
    levyMeasure {p} Set.univ = ENNReal.ofReal (∫ v, seed (log p) v / v) := by
  simp only [levyMeasure, levyDensity, Finset.sum_singleton]
  rw [withDensity_apply _ MeasurableSet.univ, Measure.restrict_univ,
    ← ofReal_integral_eq_lintegral_ofReal (integrable_seed_div_age (prime_log_pos p))
      (Filter.Eventually.of_forall (seed_div_age_nonneg (prime_log_pos p)))]

/-- Sum of the actual complete-history measures over all primes. -/
noncomputable def allPrimeLevyMeasure : Measure ℝ :=
  Measure.sum (fun p : Nat.Primes => levyMeasure {p})

theorem allPrimeLevyMeasure_mass :
    allPrimeLevyMeasure Set.univ =
      ENNReal.ofReal (∑' p : Nat.Primes, ∫ v, seed (log p) v / v) := by
  rw [allPrimeLevyMeasure, Measure.sum_apply _ MeasurableSet.univ]
  simp_rw [singleton_levyMeasure_mass]
  exact (ENNReal.ofReal_tsum_of_nonneg
    (fun p => integral_nonneg (seed_div_age_nonneg (prime_log_pos p)))
    summable_prime_levy_masses).symm

instance allPrimeLevyMeasure_isFiniteMeasure : IsFiniteMeasure allPrimeLevyMeasure := by
  constructor
  rw [allPrimeLevyMeasure_mass]
  exact ENNReal.ofReal_lt_top

theorem measurable_seed (L : ℝ) : Measurable (seed L) := by
  unfold seed
  apply Measurable.ite (measurableSet_le measurable_const measurable_id)
  · fun_prop
  · exact measurable_const

/-- At each finite age, only finitely many actual primes have been activated. -/
theorem seed_prime_finite_support (v : ℝ) :
    (Function.support (fun p : Nat.Primes => seed (log p) v)).Finite := by
  have hb : ((fun p : Nat.Primes => (p : ℕ)) ⁻¹'
      Set.Iic ⌊exp v⌋₊).Finite :=
    (Set.finite_Iic _).preimage (fun _ _ _ _ h => Subtype.ext h)
  apply hb.subset
  intro p hp
  have hv : log (p : ℝ) ≤ v := by
    by_contra h
    exact hp (seed_eq_zero (lt_of_not_ge h))
  have hp0 : (0 : ℝ) < p := by exact_mod_cast p.property.pos
  have hpe : (p : ℝ) ≤ exp v := (log_le_iff_le_exp hp0).1 hv
  exact Nat.le_floor hpe

/-- The literal collective seed as a pointwise finite sum. -/
noncomputable def allPrimeSeed (v : ℝ) : ℝ := ∑' p : Nat.Primes, seed (log p) v

theorem allPrimeSeed_div_age (v : ℝ) :
    allPrimeSeed v / v = ∑' p : Nat.Primes, seed (log p) v / v := by
  rw [allPrimeSeed, tsum_div_const]

/-- Identification with the published density `B(v)/v`, with the actual floor
endpoints and all primes retained. -/
theorem allPrimeLevyMeasure_eq_withDensity :
    allPrimeLevyMeasure = volume.withDensity
      (fun v => ENNReal.ofReal (allPrimeSeed v / v)) := by
  have hsum (v : ℝ) : Summable (fun p : Nat.Primes => seed (log p) v / v) :=
    (summable_of_finite_support (seed_prime_finite_support v)).div_const v
  have heq : (fun v => ENNReal.ofReal (allPrimeSeed v / v)) =
      (fun v => ∑' p : Nat.Primes, ENNReal.ofReal (seed (log p) v / v)) := by
    funext v
    rw [allPrimeSeed_div_age, ENNReal.ofReal_tsum_of_nonneg
      (fun p => seed_div_age_nonneg (prime_log_pos p) v) (hsum v)]
  rw [heq]
  have hmeas (p : Nat.Primes) : Measurable
      (fun v => ENNReal.ofReal (seed (log p) v / v)) :=
    ((measurable_seed (log p)).div measurable_id).ennreal_ofReal
  have hfun : (∑' p : Nat.Primes, fun v => ENNReal.ofReal (seed (log p) v / v)) =
      (fun v => ∑' p : Nat.Primes, ENNReal.ofReal (seed (log p) v / v)) := by
    funext v
    exact ENNReal.tsum_apply
  have h := (withDensity_tsum (μ := volume) hmeas).symm
  rw [hfun] at h
  simpa only [allPrimeLevyMeasure, levyMeasure, levyDensity, Finset.sum_singleton] using h

/-- The collective seed itself is not integrable. Finite activity concerns
`B(v)/v`; removing that denominator would erase the infinite mean age. -/
theorem not_integrable_allPrimeSeed : ¬ Integrable allPrimeSeed := by
  intro hi
  apply no_integrable_majorant_prime_seeds
  refine ⟨allPrimeSeed, hi, ?_⟩
  intro S v
  exact (summable_of_finite_support (seed_prime_finite_support v)).sum_le_tsum S
    (fun p _ => seed_nonneg (log p) v)

end BuildingBlocks.PrimeSeedMass

namespace BuildingBlocks.PrimeSeedProcess

noncomputable def allPrimeProcess (u : ℝ≥0) : Measure ℝ :=
  poissonLaw (normalizedJump PrimeSeedMass.allPrimeLevyMeasure)
    (u * measureUnivNNReal PrimeSeedMass.allPrimeLevyMeasure)

instance allPrimeProcess_isProbability (u : ℝ≥0) : IsProbabilityMeasure (allPrimeProcess u) := by
  unfold allPrimeProcess
  infer_instance

theorem allPrimeProcess_zero : allPrimeProcess 0 = Measure.dirac 0 := by
  simp [allPrimeProcess, poissonLaw_zero]

theorem allPrimeProcess_add (u v : ℝ≥0) :
    allPrimeProcess u ∗ allPrimeProcess v = allPrimeProcess (u + v) := by
  simp only [allPrimeProcess, add_mul, poissonLaw_add]

theorem allPrimeProcess_original_series (u : ℝ≥0) :
    allPrimeProcess u = Measure.sum (fun n : ℕ =>
      ENNReal.ofReal (exp (-(u : ℝ) *
        (measureUnivNNReal PrimeSeedMass.allPrimeLevyMeasure : ℝ)) *
          (u : ℝ) ^ n / n.factorial) • jumpPower PrimeSeedMass.allPrimeLevyMeasure n) :=
  poissonLaw_original_series _ _

end BuildingBlocks.PrimeSeedProcess
