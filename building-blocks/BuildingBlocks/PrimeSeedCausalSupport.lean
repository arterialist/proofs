import BuildingBlocks.PrimeSeedLawComparison

/-! Causal support and the exact initial gap of the complete prime jump laws. -/

open MeasureTheory Real
open scoped MeasureTheory NNReal ENNReal

namespace BuildingBlocks.PrimeSeedMass

theorem seed_prime_eq_zero_before_log_two (p : Nat.Primes) {v : ℝ}
    (hv : v < log 2) : seed (log p) v = 0 := by
  apply seed_eq_zero
  exact hv.trans_le (log_le_log (by norm_num) (by exact_mod_cast p.property.two_le))

theorem levyMeasure_initial_gap (S : Finset Nat.Primes) :
    levyMeasure S (Set.Iio (log 2)) = 0 := by
  rw [levyMeasure, withDensity_apply _ measurableSet_Iio]
  apply lintegral_eq_zero_of_ae_eq_zero
  filter_upwards [ae_restrict_mem measurableSet_Iio] with v hv
  have hz : levyDensity S v = 0 := by
    apply Finset.sum_eq_zero
    intro p _
    rw [seed_prime_eq_zero_before_log_two p hv, zero_div]
  simp only [hz, ENNReal.ofReal_zero, Pi.zero_apply]

theorem allPrimeLevyMeasure_initial_gap :
    allPrimeLevyMeasure (Set.Iio (log 2)) = 0 := by
  rw [allPrimeLevyMeasure, Measure.sum_apply _ measurableSet_Iio]
  simp only [levyMeasure_initial_gap, tsum_zero]

theorem allPrimeLevyMeasure_ae_nonneg :
    ∀ᵐ v ∂allPrimeLevyMeasure, (0 : ℝ) ≤ v := by
  rw [ae_iff]
  simp only [not_le]
  change allPrimeLevyMeasure (Set.Iio 0) = 0
  apply le_antisymm ?_ (zero_le _)
  exact (measure_mono (Set.Iio_subset_Iio (log_pos (by norm_num)).le)).trans_eq
    allPrimeLevyMeasure_initial_gap

end BuildingBlocks.PrimeSeedMass

namespace BuildingBlocks.PrimeSeedProcess

theorem conv_initial_gap {μ ν : Measure ℝ} [IsFiniteMeasure μ] [IsFiniteMeasure ν]
    {a b : ℝ} (hμ : μ (Set.Iio a) = 0) (hν : ν (Set.Iio b) = 0) :
    (μ ∗ ν) (Set.Iio (a + b)) = 0 := by
  rw [Measure.conv, Measure.map_apply (by fun_prop) measurableSet_Iio]
  apply le_antisymm ?_ (zero_le _)
  calc
    (μ.prod ν) ((fun z : ℝ × ℝ => z.1 + z.2) ⁻¹' Set.Iio (a + b)) ≤
        (μ.prod ν) ((Set.Iio a ×ˢ Set.univ) ∪ (Set.univ ×ˢ Set.Iio b)) := by
      apply measure_mono
      intro z hz
      by_cases hx : z.1 < a
      · exact Or.inl ⟨hx, Set.mem_univ _⟩
      · exact Or.inr ⟨Set.mem_univ _, by change z.1 + z.2 < a + b at hz; change z.2 < b; linarith⟩
    _ ≤ (μ.prod ν) (Set.Iio a ×ˢ Set.univ) +
        (μ.prod ν) (Set.univ ×ˢ Set.Iio b) := measure_union_le _ _
    _ = 0 := by simp [Measure.prod_prod, hμ, hν]

theorem jumpPower_initial_gap {μ : Measure ℝ} [IsFiniteMeasure μ] {L : ℝ}
    (hμ : μ (Set.Iio L) = 0) (n : ℕ) : jumpPower μ n (Set.Iio ((n : ℝ) * L)) = 0 := by
  induction n with
  | zero => simp [jumpPower]
  | succ n ih =>
    have h := conv_initial_gap hμ ih
    change (μ ∗ jumpPower μ n) (Set.Iio (((n + 1 : ℕ) : ℝ) * L)) = 0
    rw [show (((n + 1 : ℕ) : ℝ) * L) = L + (n : ℝ) * L by push_cast; ring]
    exact h

/-- Below the first possible jump, every measurable region receives exactly
the zero-jump contribution. -/
theorem finiteJumpLaw_initial_region {μ : Measure ℝ} [IsFiniteMeasure μ] {L : ℝ}
    (hL : 0 < L) (hμ : μ (Set.Iio L) = 0) (u : ℝ≥0) {A : Set ℝ}
    (hA : MeasurableSet A) (hAL : A ⊆ Set.Iio L) :
    finiteJumpLaw μ u A =
      ENNReal.ofReal (exp (-(u : ℝ) * (measureUnivNNReal μ : ℝ))) *
        Measure.dirac (0 : ℝ) A := by
  rw [finiteJumpLaw, poissonLaw_original_series, Measure.sum_apply _ hA]
  rw [tsum_eq_single 0]
  · simp [Measure.smul_apply, jumpPower]
  · intro n hn
    have hge : L ≤ (n : ℝ) * L := by
      have hn' : (1 : ℝ) ≤ n := by exact_mod_cast (Nat.one_le_iff_ne_zero.mpr hn)
      nlinarith
    have hz : jumpPower μ n A = 0 := by
      apply le_antisymm ?_ (zero_le _)
      exact (measure_mono (hAL.trans (Set.Iio_subset_Iio hge))).trans_eq
        (jumpPower_initial_gap hμ n)
    simp [Measure.smul_apply, hz]

theorem finiteJumpLaw_initial_cell {μ : Measure ℝ} [IsFiniteMeasure μ] {L : ℝ}
    (hL : 0 < L) (hμ : μ (Set.Iio L) = 0) (u : ℝ≥0) :
    finiteJumpLaw μ u (Set.Iio L) =
      ENNReal.ofReal (exp (-(u : ℝ) * (measureUnivNNReal μ : ℝ))) := by
  simpa [hL] using finiteJumpLaw_initial_region hL hμ u measurableSet_Iio Set.Subset.rfl

theorem finiteJumpLaw_zero_atom {μ : Measure ℝ} [IsFiniteMeasure μ] {L : ℝ}
    (hL : 0 < L) (hμ : μ (Set.Iio L) = 0) (u : ℝ≥0) :
    finiteJumpLaw μ u {0} =
      ENNReal.ofReal (exp (-(u : ℝ) * (measureUnivNNReal μ : ℝ))) := by
  simpa using finiteJumpLaw_initial_region hL hμ u (measurableSet_singleton 0)
    (Set.singleton_subset_iff.mpr hL)

theorem finiteJumpLaw_no_negative_age {μ : Measure ℝ} [IsFiniteMeasure μ] {L : ℝ}
    (hL : 0 < L) (hμ : μ (Set.Iio L) = 0) (u : ℝ≥0) :
    finiteJumpLaw μ u (Set.Iio 0) = 0 := by
  simpa using finiteJumpLaw_initial_region hL hμ u measurableSet_Iio
    (Set.Iio_subset_Iio hL.le)

theorem allPrimeProcess_initial_cell (u : ℝ≥0) :
    allPrimeProcess u (Set.Iio (log 2)) =
      ENNReal.ofReal (exp (-(u : ℝ) *
        (measureUnivNNReal PrimeSeedMass.allPrimeLevyMeasure : ℝ))) :=
  finiteJumpLaw_initial_cell (log_pos (by norm_num))
    PrimeSeedMass.allPrimeLevyMeasure_initial_gap u

theorem allPrimeProcess_zero_atom (u : ℝ≥0) :
    allPrimeProcess u {0} =
      ENNReal.ofReal (exp (-(u : ℝ) *
        (measureUnivNNReal PrimeSeedMass.allPrimeLevyMeasure : ℝ))) :=
  finiteJumpLaw_zero_atom (log_pos (by norm_num))
    PrimeSeedMass.allPrimeLevyMeasure_initial_gap u

theorem allPrimeProcess_no_negative_age (u : ℝ≥0) :
    allPrimeProcess u (Set.Iio 0) = 0 :=
  finiteJumpLaw_no_negative_age (log_pos (by norm_num))
    PrimeSeedMass.allPrimeLevyMeasure_initial_gap u

end BuildingBlocks.PrimeSeedProcess
