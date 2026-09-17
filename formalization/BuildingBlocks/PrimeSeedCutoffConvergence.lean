import BuildingBlocks.PrimeSeedLawComparison

/-! Uniform convergence of the actual finite-prime jump laws. -/

open MeasureTheory Real
open scoped MeasureTheory NNReal ENNReal

namespace BuildingBlocks.PrimeSeedMass

theorem levyMeasure_eq_sum_singleton (S : Finset Nat.Primes) :
    levyMeasure S = Measure.sum (fun p : S => levyMeasure {p.val}) := by
  have hmeas (p : S) : Measurable
      (fun v => ENNReal.ofReal (seed (log p.val) v / v)) :=
    ((measurable_seed _).div measurable_id).ennreal_ofReal
  have hf : (∑' p : S, fun v => ENNReal.ofReal (seed (log p.val) v / v)) =
      (fun v => ENNReal.ofReal (levyDensity S v)) := by
    funext v
    rw [ENNReal.tsum_apply, tsum_fintype]
    change (∑ p : S, ENNReal.ofReal (seed (log p.val) v / v)) = _
    rw [show (∑ p : S, ENNReal.ofReal (seed (log p.val) v / v)) =
      ∑ p ∈ S, ENNReal.ofReal (seed (log p) v / v) from
        Finset.sum_coe_sort S (fun p => ENNReal.ofReal (seed (log p) v / v))]
    exact (ENNReal.ofReal_sum_of_nonneg (fun p _ =>
      seed_div_age_nonneg (log_pos (by exact_mod_cast p.property.one_lt)) v)).symm
  have h := withDensity_tsum (μ := volume) hmeas
  rw [hf] at h
  simpa only [levyMeasure, levyDensity, Finset.sum_singleton] using h

noncomputable def primesBelow (P : ℕ) : Finset Nat.Primes :=
  ((Set.finite_Iio P).preimage
    (fun _ _ _ _ h => Subtype.ext h : Set.InjOn (fun p : Nat.Primes => (p : ℕ))
      ((fun p : Nat.Primes => (p : ℕ)) ⁻¹' Set.Iio P))).toFinset

@[simp] theorem mem_primesBelow (P : ℕ) (p : Nat.Primes) :
    p ∈ primesBelow P ↔ (p : ℕ) < P := by
  simp [primesBelow]

theorem levyMeasure_primesBelow_add_tail (P : ℕ) :
    levyMeasure (primesBelow P) + primeTailLevyMeasure P = allPrimeLevyMeasure := by
  rw [levyMeasure_eq_sum_singleton]
  have he : (↑(primesBelow P) : Set Nat.Primes) = {p : Nat.Primes | (p : ℕ) < P} := by
    ext p
    simp
  change (Measure.sum (fun p : (↑(primesBelow P) : Set Nat.Primes) =>
    levyMeasure {p.val})) + primeTailLevyMeasure P = _
  rw [he]
  exact allPrimeLevyMeasure_cutoff_split P

theorem levyMeasure_primesBelow_le (P : ℕ) :
    levyMeasure (primesBelow P) ≤ allPrimeLevyMeasure := by
  rw [← levyMeasure_primesBelow_add_tail P]
  intro A
  rw [Measure.add_apply]
  exact le_self_add

theorem cutoff_mass_difference (P : ℕ) :
    (measureUnivNNReal allPrimeLevyMeasure : ℝ) -
      (measureUnivNNReal (levyMeasure (primesBelow P)) : ℝ) =
        (primeTailLevyMeasure P Set.univ).toReal := by
  have h := congrArg (fun μ : Measure ℝ => (μ Set.univ).toReal)
    (levyMeasure_primesBelow_add_tail P)
  dsimp only at h
  rw [Measure.add_apply, ENNReal.toReal_add (measure_ne_top _ _) (measure_ne_top _ _)] at h
  change (levyMeasure (primesBelow P) Set.univ).toReal +
    (primeTailLevyMeasure P Set.univ).toReal =
      (allPrimeLevyMeasure Set.univ).toReal at h
  change (allPrimeLevyMeasure Set.univ).toReal -
    (levyMeasure (primesBelow P) Set.univ).toReal = _
  linarith

end BuildingBlocks.PrimeSeedMass

namespace BuildingBlocks.PrimeSeedProcess

open PrimeSeedMass

/-- Uniform over every measurable event, with all omitted prime-power histories
included in the error measure. -/
theorem seedProcess_cutoff_event_bound (P : ℕ) (hP : 8 ≤ P) (u : ℝ≥0)
    {A : Set ℝ} (hA : MeasurableSet A) :
    |(seedProcess (primesBelow P) u).real A - (allPrimeProcess u).real A| ≤
      32 * (u : ℝ) / log (P : ℝ) := by
  have h := finiteJumpLaw_event_bound (levyMeasure_primesBelow_le P) u hA
  change |(seedProcess (primesBelow P) u).real A - (allPrimeProcess u).real A| ≤
    (u : ℝ) * ((measureUnivNNReal allPrimeLevyMeasure : ℝ) -
      (measureUnivNNReal (levyMeasure (primesBelow P)) : ℝ)) at h
  rw [cutoff_mass_difference] at h
  have ht := ENNReal.toReal_mono (by finiteness)
    (primeTailLevyMeasure_mass_le_log P hP)
  rw [ENNReal.toReal_ofReal (by positivity)] at ht
  apply h.trans
  calc
    (u : ℝ) * (primeTailLevyMeasure P Set.univ).toReal ≤
        (u : ℝ) * (32 / log (P : ℝ)) := mul_le_mul_of_nonneg_left ht u.coe_nonneg
    _ = _ := by ring

/-- Convergence is uniform over measurable events and bounded time intervals.
The event-distance convention here has no extra factor of two. -/
theorem seedProcess_cutoff_uniform (U : ℝ≥0) {ε : ℝ} (hε : 0 < ε) :
    ∃ P₀ : ℕ, ∀ P ≥ P₀, ∀ u : ℝ≥0, u ≤ U → ∀ A : Set ℝ,
      MeasurableSet A →
        |(seedProcess (primesBelow P) u).real A - (allPrimeProcess u).real A| < ε := by
  have ht : Filter.Tendsto (fun P : ℕ => 32 * (U : ℝ) / log (P : ℝ))
      Filter.atTop (nhds 0) :=
    tendsto_const_nhds.div_atTop
      (Real.tendsto_log_atTop.comp (tendsto_natCast_atTop_atTop (R := ℝ)))
  obtain ⟨N, hN⟩ := Filter.eventually_atTop.1 (ht.eventually (Iio_mem_nhds hε))
  refine ⟨max N 8, ?_⟩
  intro P hP u hu A hA
  have h8 : 8 ≤ P := (le_max_right N 8).trans hP
  apply (seedProcess_cutoff_event_bound P h8 u hA).trans_lt
  apply lt_of_le_of_lt ?_ (hN P ((le_max_left N 8).trans hP))
  exact div_le_div_of_nonneg_right
    (mul_le_mul_of_nonneg_left (show (u : ℝ) ≤ U from hu) (by norm_num))
    (log_nonneg (by exact_mod_cast (by omega : 1 ≤ P)))

end BuildingBlocks.PrimeSeedProcess
