import BuildingBlocks.PrimeSeedWeakDerivative
import BuildingBlocks.PrimeSeedAllPrimeLevy
import Mathlib.MeasureTheory.VectorMeasure.Basic

/-! The finite positive and negative measures of the literal seed derivative. -/

open MeasureTheory Real Set
open scoped ENNReal

namespace BuildingBlocks.PrimeSeedMass

noncomputable def seedDerivativePositive (L : ℝ) : Measure ℝ :=
  volume.withDensity (fun v => ENNReal.ofReal (seed L v / 2)) +
    ENNReal.ofReal (exp (-3 * L / 2)) • Measure.dirac L

noncomputable def seedDerivativeNegative (L : ℝ) : Measure ℝ :=
  Measure.sum (fun j : ℕ =>
    ENNReal.ofReal ((1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2)) •
      Measure.dirac ((j + 2 : ℝ) * L))

theorem seed_negative_jump_nonneg {L : ℝ} (hL : 0 < L) (j : ℕ) :
    0 ≤ (1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2) := by
  have he : exp (-L) < 1 := exp_lt_one_iff.2 (neg_neg_of_pos hL)
  exact mul_nonneg (sub_nonneg.2 he.le) (exp_pos _).le

theorem seedDerivativePositive_mass {L : ℝ} (hL : 0 < L) :
    seedDerivativePositive L univ = ENNReal.ofReal (exp (-L) + exp (-3 * L / 2)) := by
  have hi := (integrable_seed_and_integral hL).1.div_const 2
  unfold seedDerivativePositive
  rw [Measure.add_apply, withDensity_apply _ MeasurableSet.univ]
  simp only [setLIntegral_univ, Measure.smul_apply, Measure.dirac_apply_of_mem (mem_univ _),
    smul_eq_mul, mul_one]
  rw [← ofReal_integral_eq_lintegral_ofReal hi
    (Filter.Eventually.of_forall (fun v => div_nonneg (seed_nonneg L v) (by norm_num))),
    integral_div, (integrable_seed_and_integral hL).2]
  rw [show 2 * exp (-L) / 2 = exp (-L) by ring,
    ← ENNReal.ofReal_add (exp_pos _).le (exp_pos _).le]

theorem seedDerivativeNegative_mass {L : ℝ} (hL : 0 < L) :
    seedDerivativeNegative L univ = ENNReal.ofReal (exp (-L) + exp (-3 * L / 2)) := by
  unfold seedDerivativeNegative
  rw [Measure.sum_apply _ MeasurableSet.univ]
  simp only [Measure.smul_apply, Measure.dirac_apply_of_mem (mem_univ _), smul_eq_mul, mul_one]
  rw [← ENNReal.ofReal_tsum_of_nonneg (seed_negative_jump_nonneg hL)
    (hasSum_seed_negative_jumps hL).summable, (hasSum_seed_negative_jumps hL).tsum_eq]

theorem seedDerivativePositive_finite {L : ℝ} (hL : 0 < L) :
    IsFiniteMeasure (seedDerivativePositive L) := by
  constructor
  rw [seedDerivativePositive_mass hL]
  exact ENNReal.ofReal_lt_top

theorem seedDerivativeNegative_finite {L : ℝ} (hL : 0 < L) :
    IsFiniteMeasure (seedDerivativeNegative L) := by
  constructor
  rw [seedDerivativeNegative_mass hL]
  exact ENNReal.ofReal_lt_top

noncomputable def seedDerivative (L : ℝ) (hL : 0 < L) : SignedMeasure ℝ :=
  letI := seedDerivativePositive_finite hL
  letI := seedDerivativeNegative_finite hL
  (seedDerivativePositive L).toSignedMeasure - (seedDerivativeNegative L).toSignedMeasure

theorem seedDerivative_total_mass {L : ℝ} (hL : 0 < L) : seedDerivative L hL univ = 0 := by
  letI := seedDerivativePositive_finite hL
  letI := seedDerivativeNegative_finite hL
  simp only [seedDerivative, VectorMeasure.sub_apply, Measure.toSignedMeasure_apply_measurable MeasurableSet.univ,
    measureReal_def, seedDerivativePositive_mass hL, seedDerivativeNegative_mass hL, sub_self]

theorem seedDerivativeNegative_integral {L : ℝ} (hL : 0 < L) {φ : ℝ → ℝ}
    (hm : Measurable φ) (hb : ∃ M, ∀ v, |φ v| ≤ M) :
    (∫ v, φ v ∂seedDerivativeNegative L) =
      ∑' j : ℕ, (1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2) * φ ((j + 2 : ℝ) * L) := by
  letI := seedDerivativeNegative_finite hL
  obtain ⟨M, hM⟩ := hb
  have hi : Integrable φ (seedDerivativeNegative L) := by
    apply (integrable_const M).mono' hm.aestronglyMeasurable
    exact Filter.Eventually.of_forall (fun v => by simpa only [Real.norm_eq_abs] using hM v)
  unfold seedDerivativeNegative at hi ⊢
  rw [integral_sum_measure hi]
  congr 1
  funext j
  rw [integral_smul_measure, integral_dirac, ENNReal.toReal_ofReal (seed_negative_jump_nonneg hL j)]
  rfl

theorem seedDerivativePositive_integral {L : ℝ} (hL : 0 < L) {φ : ℝ → ℝ}
    (hm : Measurable φ) (hb : ∃ M, ∀ v, |φ v| ≤ M) :
    (∫ v, φ v ∂seedDerivativePositive L) =
      (1 / 2) * (∫ v, seed L v * φ v) + exp (-3 * L / 2) * φ L := by
  letI := seedDerivativePositive_finite hL
  obtain ⟨M, hM⟩ := hb
  have hi : Integrable φ (seedDerivativePositive L) := by
    apply (integrable_const M).mono' hm.aestronglyMeasurable
    exact Filter.Eventually.of_forall (fun v => by simpa only [Real.norm_eq_abs] using hM v)
  unfold seedDerivativePositive at hi ⊢
  rw [integrable_add_measure] at hi
  rw [integral_add_measure hi.1 hi.2, integral_smul_measure, integral_dirac,
    ENNReal.toReal_ofReal (exp_pos _).le,
    integral_withDensity_eq_integral_toReal_smul
      ((measurable_seed L).div_const 2).ennreal_ofReal
      (Filter.Eventually.of_forall (fun _ => ENNReal.ofReal_lt_top))]
  have hnn (v : ℝ) : 0 ≤ seed L v / 2 := div_nonneg (seed_nonneg L v) (by norm_num)
  simp_rw [ENNReal.toReal_ofReal (hnn _), smul_eq_mul]
  congr 1
  rw [← integral_const_mul]
  congr 1
  funext v
  ring

/-- The constructed finite measures represent the complete weak derivative,
with positive continuous/birth part and negative proper-power part. -/
theorem seedDerivative_represents_weak_derivative {L : ℝ} (hL : 0 < L) {φ φ' : ℝ → ℝ}
    (hφ : ∀ v, HasDerivAt φ (φ' v) v) (hc : Continuous φ')
    (hb : ∃ M, ∀ v, |φ v| ≤ M) (hb' : ∃ M, ∀ v, |φ' v| ≤ M) :
    (∫ v, seed L v * φ' v) =
      (∫ v, φ v ∂seedDerivativeNegative L) - ∫ v, φ v ∂seedDerivativePositive L := by
  have hm : Measurable φ :=
    (continuous_iff_continuousAt.2 (fun v => (hφ v).continuousAt)).measurable
  rw [seedDerivativeNegative_integral hL hm hb, seedDerivativePositive_integral hL hm hb,
    seed_weak_derivative hL hφ hc hb hb']
  ring

end BuildingBlocks.PrimeSeedMass
