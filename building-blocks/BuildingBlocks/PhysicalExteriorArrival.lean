import BuildingBlocks.PhysicalThetaMeasure
import BuildingBlocks.PhysicalContinuousArrivalMass

namespace BuildingBlocks.PhysicalExteriorArrival
open MeasureTheory
open BuildingBlocks.PhysicalThetaMeasure
open BuildingBlocks.PhysicalGroundPrimeArrival
open BuildingBlocks.PhysicalArrivalBoundary
open BuildingBlocks.PhysicalContinuousArrivalMass

noncomputable def zeroExterior (R : ℝ) (ψ : ℝ → ℝ) : ℝ → ℝ :=
  {v : ℝ | R < |v|}.indicator ψ

theorem exterior_measurable (R : ℝ) : MeasurableSet {v : ℝ | R < |v|} :=
  isOpen_lt continuous_const continuous_abs |>.measurableSet

theorem zero_exterior_aestronglyMeasurable (R : ℝ) (ψ : ℝ → ℝ)
    (hψ : AEStronglyMeasurable ψ (exteriorNu R)) :
    AEStronglyMeasurable (zeroExterior R ψ) volume := by
  apply (aestronglyMeasurable_dictionary _).mp
  exact (aestronglyMeasurable_indicator_iff (exterior_measurable R)).mpr hψ

theorem zero_exterior_bound {R P : ℝ} (ψ : ℝ → ℝ) (hP : 0 ≤ P)
    (hbound : ∀ᵐ v ∂exteriorNu R, |ψ v| ≤ P) :
    ∀ᵐ v, |zeroExterior R ψ v| ≤ P := by
  apply (ae_dictionary _).mp
  have hb : ∀ᵐ v ∂nu, v ∈ {v : ℝ | R < |v|} → |ψ v| ≤ P :=
    (ae_restrict_iff' (exterior_measurable R)).mp hbound
  filter_upwards [hb] with v hv
  by_cases he : v ∈ {v : ℝ | R < |v|}
  · simpa only [zeroExterior, Set.indicator_of_mem he] using hv he
  · simpa only [zeroExterior, Set.indicator_of_notMem he, abs_zero] using hP

theorem source_zero_exterior (R : ℝ) (ψ : ℝ → ℝ) (v : ℝ) :
    source R (zeroExterior R ψ) v = source R ψ v := by
  by_cases hv : R < |v|
  · simp [source, zeroExterior, hv]
  · simp [source, hv]

theorem complete_arrival_zero_exterior (R : ℝ) (ψ : ℝ → ℝ) :
    completeCoreArrival R (zeroExterior R ψ) = completeCoreArrival R ψ := by
  funext v
  unfold completeCoreArrival continuousArrival primeArrival arrivalTerm
  simp only [source_zero_exterior]

theorem exterior_complete_arrival_memLp_two {R P : ℝ} (ψ : ℝ → ℝ)
    (hR : 0 < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ (exteriorNu R))
    (hbound : ∀ᵐ v ∂exteriorNu R, |ψ v| ≤ P) :
    MemLp (completeCoreArrival R ψ) 2 (volume.restrict (Set.Icc (-R) R)) := by
  rw [← complete_arrival_zero_exterior R ψ]
  exact complete_core_arrival_memLp_two (zeroExterior R ψ) hR hP
    (zero_exterior_aestronglyMeasurable R ψ hψ) (zero_exterior_bound ψ hP hbound)

#print axioms exterior_measurable
#print axioms zero_exterior_aestronglyMeasurable
#print axioms zero_exterior_bound
#print axioms source_zero_exterior
#print axioms complete_arrival_zero_exterior
#print axioms exterior_complete_arrival_memLp_two
end BuildingBlocks.PhysicalExteriorArrival
