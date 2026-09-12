import BuildingBlocks.PrimeSeedAllPrimeLevy

/-! Finite jump activity does not imply a finite mean age. -/

open MeasureTheory Real
open scoped MeasureTheory NNReal ENNReal

namespace BuildingBlocks.PrimeSeedMass

theorem singleton_levyMeasure_firstMoment (p : Nat.Primes) :
    (∫⁻ v, ENNReal.ofReal v ∂levyMeasure {p}) =
      ENNReal.ofReal (∫ v, seed (log p) v) := by
  have hp : 0 < log (p : ℝ) := log_pos (by exact_mod_cast p.property.one_lt)
  simp only [levyMeasure, levyDensity, Finset.sum_singleton]
  have hmeas : Measurable (fun v => ENNReal.ofReal (seed (log p) v / v)) :=
    ((measurable_seed (log p)).div measurable_id).ennreal_ofReal
  have hid : Measurable (fun v : ℝ => ENNReal.ofReal v) := measurable_id.ennreal_ofReal
  rw [lintegral_withDensity_eq_lintegral_mul volume hmeas hid]
  have hf : (fun v => ENNReal.ofReal (seed (log p) v / v) * ENNReal.ofReal v) =
      (fun v => ENNReal.ofReal (seed (log p) v)) := by
    funext v
    rw [← ENNReal.ofReal_mul (seed_div_age_nonneg hp v)]
    congr 1
    by_cases hv : v = 0
    · subst v
      simp [seed_eq_zero hp]
    · exact div_mul_cancel₀ _ hv
  change (∫⁻ v, ENNReal.ofReal (seed (log p) v / v) * ENNReal.ofReal v) = _
  rw [hf]
  exact (ofReal_integral_eq_lintegral_ofReal
    (integrable_seed_and_integral hp).1
    (Filter.Eventually.of_forall (seed_nonneg _))).symm

/-- The literal all-prime age moment diverges, although its total activity is finite. -/
theorem allPrimeLevyMeasure_firstMoment :
    (∫⁻ v, ENNReal.ofReal v ∂allPrimeLevyMeasure) = ∞ := by
  rw [allPrimeLevyMeasure, lintegral_sum_measure]
  simp_rw [singleton_levyMeasure_firstMoment]
  let f : Nat.Primes → ℝ≥0 := fun p =>
    ⟨∫ v, seed (log p) v, integral_nonneg (seed_nonneg _)⟩
  change (∑' p : Nat.Primes, ENNReal.ofReal (f p : ℝ)) = ∞
  simpa only [ENNReal.ofReal_coe_nnreal] using
    (ENNReal.tsum_coe_eq_top_iff_not_summable_coe.mpr
      (show ¬ Summable (fun p : Nat.Primes => (f p : ℝ)) from
        not_summable_prime_seed_integrals))

end BuildingBlocks.PrimeSeedMass

namespace BuildingBlocks.PrimeSeedProcess

open PrimeSeedMass

/-- The one-jump term already forces an infinite positive age moment at every
strictly positive time. No first-moment continuity is inferred from event convergence. -/
theorem allPrimeProcess_firstMoment (u : ℝ≥0) (hu : 0 < u) :
    (∫⁻ v, ENNReal.ofReal v ∂allPrimeProcess u) = ∞ := by
  have hle : ENNReal.ofReal (exp (-(u : ℝ) *
      (measureUnivNNReal allPrimeLevyMeasure : ℝ)) * (u : ℝ)) •
      allPrimeLevyMeasure ≤ allPrimeProcess u := by
    rw [allPrimeProcess_original_series]
    have h := Measure.le_sum (fun n : ℕ =>
      ENNReal.ofReal (exp (-(u : ℝ) *
        (measureUnivNNReal allPrimeLevyMeasure : ℝ)) * (u : ℝ)^n / n.factorial) •
          jumpPower allPrimeLevyMeasure n) 1
    simpa only [pow_one, Nat.factorial_one, Nat.cast_one, div_one, jumpPower,
      Measure.conv_dirac_zero] using h
  have hi := lintegral_mono' hle (f := fun v => ENNReal.ofReal v) (g := fun v => ENNReal.ofReal v) le_rfl
  rw [lintegral_smul_measure, allPrimeLevyMeasure_firstMoment, smul_eq_mul,
    ENNReal.mul_top (ne_of_gt (ENNReal.ofReal_pos.mpr
      (mul_pos (exp_pos _) (show (0 : ℝ) < u from hu))))] at hi
  exact top_unique hi

theorem not_integrable_allPrimeProcess_age (u : ℝ≥0) (hu : 0 < u) :
    ¬ Integrable (fun v : ℝ => v) (allPrimeProcess u) := by
  intro h
  have hf := (hasFiniteIntegral_iff_ofReal
    (Filter.Eventually.of_forall (fun v : ℝ => norm_nonneg v))).1 h.norm.hasFiniteIntegral
  have hm : (∫⁻ v, ENNReal.ofReal v ∂allPrimeProcess u) ≤
      ∫⁻ v, ENNReal.ofReal ‖v‖ ∂allPrimeProcess u :=
    lintegral_mono (fun v => ENNReal.ofReal_le_ofReal (le_abs_self v))
  rw [allPrimeProcess_firstMoment u hu] at hm
  exact not_lt_of_ge hm hf

end BuildingBlocks.PrimeSeedProcess
