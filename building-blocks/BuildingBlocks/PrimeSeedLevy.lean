import BuildingBlocks.PrimeSeedPrimeSums
import Mathlib.MeasureTheory.Measure.WithDensity

/-! Finite-prime positive jump measures from the literal seed divided by age.
This proves finite activity for every finite prime set. Uniform all-prime
activity bounds require a separate arithmetic tail estimate.
-/

open MeasureTheory Real

namespace BuildingBlocks.PrimeSeedMass

theorem seed_div_age_nonneg {L : ℝ} (hL : 0 < L) (v : ℝ) :
    0 ≤ seed L v / v := by
  by_cases hv : v < L
  · rw [seed_eq_zero hv, zero_div]
  · exact div_nonneg (seed_nonneg L v) (by linarith)

theorem seed_div_age_le {L : ℝ} (hL : 0 < L) (v : ℝ) :
    seed L v / v ≤ seed L v / L := by
  by_cases hv : v < L
  · rw [seed_eq_zero hv]
    simp
  · exact div_le_div_of_nonneg_left (seed_nonneg L v) hL (le_of_not_gt hv)

theorem integrable_seed_div_age {L : ℝ} (hL : 0 < L) :
    Integrable (fun v => seed L v / v) := by
  have hi := (integrable_seed_and_integral hL).1
  have hm : AEStronglyMeasurable (fun v => seed L v / v) volume := by
    simpa only [div_eq_mul_inv] using hi.aestronglyMeasurable.mul
      (measurable_inv : Measurable (fun v : ℝ => v⁻¹)).aestronglyMeasurable
  apply (hi.div_const L).mono' hm
  exact Filter.Eventually.of_forall (fun v => by
    rw [Real.norm_eq_abs, abs_of_nonneg (seed_div_age_nonneg hL v)]
    exact seed_div_age_le hL v)

theorem integral_seed_div_age_le {L : ℝ} (hL : 0 < L) :
    (∫ v, seed L v / v) ≤ 2 * exp (-L) / L := by
  calc
    (∫ v, seed L v / v) ≤ ∫ v, seed L v / L :=
      integral_mono (integrable_seed_div_age hL)
        ((integrable_seed_and_integral hL).1.div_const L) (seed_div_age_le hL)
    _ = 2 * exp (-L) / L := by
      rw [integral_div, (integrable_seed_and_integral hL).2]

/-- All admitted primes and all of their delay histories remain in the density. -/
noncomputable def levyDensity (S : Finset Nat.Primes) (v : ℝ) : ℝ :=
  ∑ p ∈ S, seed (log p) v / v

theorem levyDensity_nonneg (S : Finset Nat.Primes) (v : ℝ) :
    0 ≤ levyDensity S v := by
  apply Finset.sum_nonneg
  intro p _
  apply seed_div_age_nonneg
  apply log_pos
  exact_mod_cast p.property.one_lt

theorem integrable_levyDensity (S : Finset Nat.Primes) : Integrable (levyDensity S) := by
  apply integrable_finset_sum
  intro p _
  apply integrable_seed_div_age
  apply log_pos
  exact_mod_cast p.property.one_lt

/-- The finite-prime jump measure in the positive seed construction. -/
noncomputable def levyMeasure (S : Finset Nat.Primes) : Measure ℝ :=
  volume.withDensity (fun v => ENNReal.ofReal (levyDensity S v))

instance levyMeasure_isFiniteMeasure (S : Finset Nat.Primes) :
    IsFiniteMeasure (levyMeasure S) := by
  apply isFiniteMeasure_withDensity
  rw [← ofReal_integral_eq_lintegral_ofReal (integrable_levyDensity S)
    (Filter.Eventually.of_forall (levyDensity_nonneg S))]
  exact ENNReal.ofReal_ne_top

/-- Multiplying the density by age recovers the complete original prime seed. -/
theorem age_mul_levyDensity (S : Finset Nat.Primes) (v : ℝ) :
    v * levyDensity S v = ∑ p ∈ S, seed (log p) v := by
  rw [levyDensity, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro p _
  by_cases hv : v = 0
  · subst v
    have hp : 0 < log (p : ℝ) := log_pos (by exact_mod_cast p.property.one_lt)
    rw [seed_eq_zero hp]
    ring
  · field_simp

theorem integral_age_mul_levyDensity (S : Finset Nat.Primes) :
    (∫ v, v * levyDensity S v) = ∑ p ∈ S, 2 / (p : ℝ) := by
  simp_rw [age_mul_levyDensity]
  exact integral_finset_prime_seed S

end BuildingBlocks.PrimeSeedMass
