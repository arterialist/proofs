import BuildingBlocks.PrimeSeedDerivativeMeasure
import Mathlib.MeasureTheory.VectorMeasure.Decomposition.Jordan

/-! Exact Jordan decomposition and total variation of the full seed derivative.
The birth and continuous part are disjoint from all proper-power atoms. -/

open MeasureTheory Real Set
open scoped ENNReal MeasureTheory

namespace BuildingBlocks.PrimeSeedMass

theorem seedDerivative_mutuallySingular {L : ℝ} (hL : 0 < L) :
    seedDerivativePositive L ⟂ₘ seedDerivativeNegative L := by
  let A : Set ℝ := range (fun j : ℕ => (j + 2 : ℝ) * L)
  have hcount : A.Countable := countable_range _
  have hm : MeasurableSet A := hcount.measurableSet
  have hbirth : L ∉ A := by
    rintro ⟨j, hj⟩
    have hj0 : (0 : ℝ) ≤ j := Nat.cast_nonneg _
    nlinarith
  refine ⟨A, hm, ?_, ?_⟩
  · unfold seedDerivativePositive
    rw [Measure.add_apply]
    have hv : (volume.withDensity (fun v => ENNReal.ofReal (seed L v / 2))) A = 0 :=
      withDensity_absolutelyContinuous _ _ (hcount.measure_zero volume)
    rw [hv, Measure.smul_apply, Measure.dirac_apply' _ hm]
    simp [hbirth]
  · unfold seedDerivativeNegative
    rw [Measure.sum_apply _ hm.compl]
    have hz (j : ℕ) :
        (ENNReal.ofReal ((1 - exp (-L)) * exp (-((j + 2 : ℝ) * L) / 2)) •
          Measure.dirac ((j + 2 : ℝ) * L)) Aᶜ = 0 := by
      rw [Measure.smul_apply, Measure.dirac_apply' _ hm.compl]
      have hj : (j + 2 : ℝ) * L ∈ A := ⟨j, rfl⟩
      simp [hj]
    simp_rw [hz, tsum_zero]

noncomputable def seedDerivativeJordan (L : ℝ) (hL : 0 < L) : JordanDecomposition ℝ where
  posPart := seedDerivativePositive L
  negPart := seedDerivativeNegative L
  posPart_finite := seedDerivativePositive_finite hL
  negPart_finite := seedDerivativeNegative_finite hL
  mutuallySingular := seedDerivative_mutuallySingular hL

theorem seedDerivativeJordan_toSigned {L : ℝ} (hL : 0 < L) :
    (seedDerivativeJordan L hL).toSignedMeasure = seedDerivative L hL := rfl

theorem seedDerivative_totalVariation {L : ℝ} (hL : 0 < L) :
    (seedDerivative L hL).totalVariation = seedDerivativePositive L + seedDerivativeNegative L := by
  rw [← seedDerivativeJordan_toSigned hL, SignedMeasure.totalVariation,
    JordanDecomposition.toJordanDecomposition_toSignedMeasure]
  rfl

/-- Exact variation of the finite measure representing the weak derivative. -/
theorem seedDerivative_totalVariation_mass {L : ℝ} (hL : 0 < L) :
    (seedDerivative L hL).totalVariation univ =
      ENNReal.ofReal (2 * exp (-L) + 2 * exp (-3 * L / 2)) := by
  rw [seedDerivative_totalVariation hL, Measure.add_apply,
    seedDerivativePositive_mass hL, seedDerivativeNegative_mass hL,
    ← ENNReal.ofReal_add (by positivity) (by positivity)]
  congr 1
  ring

end BuildingBlocks.PrimeSeedMass
