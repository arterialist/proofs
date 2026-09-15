import BuildingBlocks.PhysicalArrivalBoundary
import Mathlib.MeasureTheory.Function.LpSeminorm.Basic

open MeasureTheory Real
namespace BuildingBlocks.PhysicalPrimeArrivalRegularity
open BuildingBlocks.PhysicalGroundPrimeArrival BuildingBlocks.PhysicalArrivalBoundary
open BuildingBlocks.WeakGroundPrimeTail

theorem shifted_source_aestronglyMeasurable (R : ℝ) (ψ : ℝ → ℝ)
    (hψ : AEStronglyMeasurable ψ) (side : Bool) (n : {n : ℕ // 2 ≤ n}) :
    AEStronglyMeasurable (fun v => source R ψ (shift side n.val v)) := by
  have hs := source_aestronglyMeasurable R ψ hψ
  cases side
  · simpa [shift, sub_eq_add_neg] using
      hs.comp_quasiMeasurePreserving
        (measurePreserving_add_right (volume : Measure ℝ) (-log n.val)).quasiMeasurePreserving
  · simpa [shift] using hs.comp_quasiMeasurePreserving
      (measurePreserving_add_right (volume : Measure ℝ) (log n.val)).quasiMeasurePreserving

theorem arrival_term_aestronglyMeasurable (R : ℝ) (ψ : ℝ → ℝ)
    (hψ : AEStronglyMeasurable ψ) (n : {n : ℕ // 2 ≤ n}) :
    AEStronglyMeasurable (fun v => arrivalTerm R ψ v n) :=
  ((shifted_source_aestronglyMeasurable R ψ hψ true n).add
    (shifted_source_aestronglyMeasurable R ψ hψ false n)).const_mul _

theorem prime_arrival_aestronglyMeasurable (R P : ℝ) (ψ : ℝ → ℝ)
    (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ) (hbound : ∀ᵐ v, |ψ v| ≤ P) :
    AEStronglyMeasurable (primeArrival R ψ) := by
  classical
  apply aestronglyMeasurable_of_tendsto_ae
    (Filter.atTop : Filter (Finset {n : ℕ // 2 ≤ n}))
  · intro s
    exact Finset.aestronglyMeasurable_sum s
      (fun n _ => arrival_term_aestronglyMeasurable R ψ hψ n)
  · filter_upwards [prime_arrival_absolutely_summable_ae R P ψ hP hbound] with v hv
    simpa only [primeArrival, Finset.sum_apply] using hv.of_norm.hasSum

theorem prime_mass_nonneg : 0 ≤ primeMass := by
  apply tsum_nonneg
  intro n
  exact div_nonneg ArithmeticFunction.vonMangoldt_nonneg (rpow_nonneg (Nat.cast_nonneg _) _)

theorem prime_arrival_memLp_core (R P : ℝ) (ψ : ℝ → ℝ)
    (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ) (hbound : ∀ᵐ v, |ψ v| ≤ P) :
    MemLp (primeArrival R ψ) 2 (volume.restrict (Set.Icc (-R) R)) := by
  have hm := (prime_arrival_aestronglyMeasurable R P ψ hP hψ hbound).restrict (s := Set.Icc (-R) R)
  apply MemLp.of_bound hm (2 * P * tailConstant * exp R * primeMass)
  have hb := (prime_arrival_bound_ae R P ψ hP hbound).filter_mono
    (ae_restrict_le (μ := volume) (s := Set.Icc (-R) R))
  filter_upwards [hb, ae_restrict_mem measurableSet_Icc] with v hv hc
  have ha : |v| ≤ R := abs_le.mpr hc
  have he := exp_le_exp.mpr ha
  have hcoef : 0 ≤ 2 * P * tailConstant * primeMass := by
    exact mul_nonneg (mul_nonneg (mul_nonneg (by norm_num : (0 : ℝ) ≤ 2) hP) tailConstant_nonneg) prime_mass_nonneg
  have h := mul_le_mul_of_nonneg_left he hcoef
  apply hv.trans
  simpa only [mul_assoc, mul_left_comm, mul_comm] using h

#print axioms shifted_source_aestronglyMeasurable
#print axioms arrival_term_aestronglyMeasurable
#print axioms prime_arrival_aestronglyMeasurable
#print axioms prime_mass_nonneg
#print axioms prime_arrival_memLp_core
end BuildingBlocks.PhysicalPrimeArrivalRegularity
