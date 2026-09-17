import BuildingBlocks.PrimeSeedDerivativeVariation
import BuildingBlocks.PrimeSeedMemory

/-! The exact derivative variation of complete finite-prime histories.
Prime births cannot coincide with any proper-prime-power decay atom. -/

open MeasureTheory Real Set
open scoped ENNReal MeasureTheory

namespace BuildingBlocks.PrimeSeedMass

theorem prime_birth_ne_proper_power (p q : Nat.Primes) (j : ℕ) :
    (j + 2 : ℝ) * log (q : ℝ) ≠ log (p : ℝ) := by
  intro he
  have hlog : log ((q : ℝ) ^ (j + 2)) = log (p : ℝ) := by
    rw [log_pow]
    simpa only [Nat.cast_add, Nat.cast_ofNat] using he
  have hr := log_injOn_pos
    (show (q : ℝ) ^ (j + 2) ∈ Ioi 0 by
      change (0 : ℝ) < (q : ℝ) ^ (j + 2)
      exact pow_pos (by exact_mod_cast q.property.pos) _)
    (show (p : ℝ) ∈ Ioi 0 from (by exact_mod_cast p.property.pos : (0 : ℝ) < p)) hlog
  have hn : (q : ℕ) ^ (j + 2) = (p : ℕ) := by exact_mod_cast hr
  have hp : Nat.Prime ((q : ℕ) ^ (j + 2)) := hn ▸ p.property
  exact Nat.Prime.not_prime_pow (by omega : 2 ≤ j + 2) hp

theorem prime_derivative_cross_mutuallySingular (p q : Nat.Primes) :
    seedDerivativePositive (log p) ⟂ₘ seedDerivativeNegative (log q) := by
  let A : Set ℝ := range (fun j : ℕ => (j + 2 : ℝ) * log (q : ℝ))
  have hcount : A.Countable := countable_range _
  have hm : MeasurableSet A := hcount.measurableSet
  have hp : log (p : ℝ) ∉ A := by
    rintro ⟨j, hj⟩
    exact prime_birth_ne_proper_power p q j hj
  refine ⟨A, hm, ?_, ?_⟩
  · unfold seedDerivativePositive
    rw [Measure.add_apply]
    have hz : (volume.withDensity (fun v => ENNReal.ofReal (seed (log p) v / 2))) A = 0 :=
      withDensity_absolutelyContinuous _ _ (hcount.measure_zero volume)
    rw [hz, Measure.smul_apply, Measure.dirac_apply' _ hm]
    simp [hp]
  · unfold seedDerivativeNegative
    rw [Measure.sum_apply _ hm.compl]
    have hz (j : ℕ) :
        (ENNReal.ofReal ((1 - exp (-log (q : ℝ))) * exp (-((j + 2 : ℝ) * log (q : ℝ)) / 2)) •
          Measure.dirac ((j + 2 : ℝ) * log (q : ℝ))) Aᶜ = 0 := by
      rw [Measure.smul_apply, Measure.dirac_apply' _ hm.compl]
      have hj : (j + 2 : ℝ) * log (q : ℝ) ∈ A := ⟨j, rfl⟩
      simp [hj]
    simp_rw [hz, tsum_zero]

noncomputable def finiteSeedDerivativePositive (S : Finset Nat.Primes) : Measure ℝ :=
  Measure.sum (fun p : S => seedDerivativePositive (log (p.val : ℝ)))

noncomputable def finiteSeedDerivativeNegative (S : Finset Nat.Primes) : Measure ℝ :=
  Measure.sum (fun p : S => seedDerivativeNegative (log (p.val : ℝ)))

instance finiteSeedDerivativePositive_finite (S : Finset Nat.Primes) :
    IsFiniteMeasure (finiteSeedDerivativePositive S) := by
  letI (p : S) : IsFiniteMeasure (seedDerivativePositive (log (p.val : ℝ))) :=
    seedDerivativePositive_finite (log_pos (by exact_mod_cast p.val.property.one_lt))
  unfold finiteSeedDerivativePositive
  infer_instance

instance finiteSeedDerivativeNegative_finite (S : Finset Nat.Primes) :
    IsFiniteMeasure (finiteSeedDerivativeNegative S) := by
  letI (p : S) : IsFiniteMeasure (seedDerivativeNegative (log (p.val : ℝ))) :=
    seedDerivativeNegative_finite (log_pos (by exact_mod_cast p.val.property.one_lt))
  unfold finiteSeedDerivativeNegative
  infer_instance

theorem finiteSeedDerivative_mutuallySingular (S : Finset Nat.Primes) :
    finiteSeedDerivativePositive S ⟂ₘ finiteSeedDerivativeNegative S := by
  unfold finiteSeedDerivativePositive finiteSeedDerivativeNegative
  apply Measure.MutuallySingular.sum_left.2
  intro p
  apply Measure.MutuallySingular.sum_right.2
  intro q
  exact prime_derivative_cross_mutuallySingular p.val q.val

noncomputable def finiteSeedDerivativeJordan (S : Finset Nat.Primes) : JordanDecomposition ℝ where
  posPart := finiteSeedDerivativePositive S
  negPart := finiteSeedDerivativeNegative S
  mutuallySingular := finiteSeedDerivative_mutuallySingular S

noncomputable def finiteSeedDerivative (S : Finset Nat.Primes) : SignedMeasure ℝ :=
  (finiteSeedDerivativePositive S).toSignedMeasure - (finiteSeedDerivativeNegative S).toSignedMeasure

theorem finiteSeedDerivative_totalVariation (S : Finset Nat.Primes) :
    (finiteSeedDerivative S).totalVariation = finiteSeedDerivativePositive S + finiteSeedDerivativeNegative S := by
  change (finiteSeedDerivativeJordan S).toSignedMeasure.totalVariation = _
  rw [SignedMeasure.totalVariation, JordanDecomposition.toJordanDecomposition_toSignedMeasure]
  rfl

theorem finiteSeedDerivative_totalVariation_mass (S : Finset Nat.Primes) :
    (finiteSeedDerivative S).totalVariation univ =
      ENNReal.ofReal (∑ p ∈ S, (2 * exp (-log (p : ℝ)) + 2 * exp (-3 * log (p : ℝ) / 2))) := by
  rw [finiteSeedDerivative_totalVariation, Measure.add_apply]
  unfold finiteSeedDerivativePositive finiteSeedDerivativeNegative
  rw [Measure.sum_apply _ MeasurableSet.univ, Measure.sum_apply _ MeasurableSet.univ]
  have hp (p : S) : 0 < log (p.val : ℝ) := log_pos (by exact_mod_cast p.val.property.one_lt)
  have hpos (p : S) := seedDerivativePositive_mass (hp p)
  have hneg (p : S) := seedDerivativeNegative_mass (hp p)
  simp_rw [hpos, hneg]
  rw [tsum_fintype, ← Finset.sum_add_distrib]
  have hn (p : S) : 0 ≤ exp (-log (p.val : ℝ)) + exp (-3 * log (p.val : ℝ) / 2) := by positivity
  simp_rw [← ENNReal.ofReal_add (hn _) (hn _)]
  rw [← ENNReal.ofReal_sum_of_nonneg (fun p _ => by positivity)]
  congr 1
  rw [Finset.sum_coe_sort S (fun p : Nat.Primes =>
    (exp (-log (p : ℝ)) + exp (-3 * log (p : ℝ) / 2)) +
      (exp (-log (p : ℝ)) + exp (-3 * log (p : ℝ) / 2)))]
  apply Finset.sum_congr rfl
  intro p hp
  ring

theorem finiteSeedDerivativePositive_integral (S : Finset Nat.Primes) {φ : ℝ → ℝ}
    (hm : Measurable φ) (hb : ∃ M, ∀ v, |φ v| ≤ M) :
    (∫ v, φ v ∂finiteSeedDerivativePositive S) =
      ∑ p ∈ S, ∫ v, φ v ∂seedDerivativePositive (log (p : ℝ)) := by
  obtain ⟨M, hM⟩ := hb
  have hi : Integrable φ (finiteSeedDerivativePositive S) := by
    apply (integrable_const M).mono' hm.aestronglyMeasurable
    exact Filter.Eventually.of_forall (fun v => by simpa only [Real.norm_eq_abs] using hM v)
  unfold finiteSeedDerivativePositive at hi ⊢
  rw [integral_sum_measure hi, tsum_fintype]
  exact Finset.sum_coe_sort S (fun p : Nat.Primes => ∫ v : ℝ, φ v ∂seedDerivativePositive (log (p : ℝ)))

theorem finiteSeedDerivativeNegative_integral (S : Finset Nat.Primes) {φ : ℝ → ℝ}
    (hm : Measurable φ) (hb : ∃ M, ∀ v, |φ v| ≤ M) :
    (∫ v, φ v ∂finiteSeedDerivativeNegative S) =
      ∑ p ∈ S, ∫ v, φ v ∂seedDerivativeNegative (log (p : ℝ)) := by
  obtain ⟨M, hM⟩ := hb
  have hi : Integrable φ (finiteSeedDerivativeNegative S) := by
    apply (integrable_const M).mono' hm.aestronglyMeasurable
    exact Filter.Eventually.of_forall (fun v => by simpa only [Real.norm_eq_abs] using hM v)
  unfold finiteSeedDerivativeNegative at hi ⊢
  rw [integral_sum_measure hi, tsum_fintype]
  exact Finset.sum_coe_sort S (fun p : Nat.Primes => ∫ v : ℝ, φ v ∂seedDerivativeNegative (log (p : ℝ)))

/-- The Jordan decomposition above belongs to the literal finite-prime seed,
not merely to an unrelated sum of abstract measures. -/
theorem finiteSeedDerivative_represents_weak_derivative (S : Finset Nat.Primes)
    {φ φ' : ℝ → ℝ} (hφ : ∀ v, HasDerivAt φ (φ' v) v) (hc : Continuous φ')
    (hb : ∃ M, ∀ v, |φ v| ≤ M) (hb' : ∃ M, ∀ v, |φ' v| ≤ M) :
    (∫ v, finitePrimeSeed S v * φ' v) =
      (∫ v, φ v ∂finiteSeedDerivativeNegative S) - ∫ v, φ v ∂finiteSeedDerivativePositive S := by
  have hm : Measurable φ :=
    (continuous_iff_continuousAt.2 (fun v => (hφ v).continuousAt)).measurable
  rw [finiteSeedDerivativeNegative_integral S hm hb, finiteSeedDerivativePositive_integral S hm hb]
  simp only [finitePrimeSeed, Finset.sum_mul]
  rw [integral_finset_sum _ (fun p _ => seed_test_product_integrable
    (log_pos (by exact_mod_cast p.property.one_lt)) hc.aestronglyMeasurable hb'), ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro p hp
  exact seedDerivative_represents_weak_derivative
    (log_pos (by exact_mod_cast p.property.one_lt)) hφ hc hb hb'

end BuildingBlocks.PrimeSeedMass
