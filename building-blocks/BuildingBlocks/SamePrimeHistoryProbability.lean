import BuildingBlocks.SamePrimeHistoryResidual
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.MeasureTheory.Constructions.BorelSpace.Order

open MeasureTheory
open scoped ENNReal

namespace BuildingBlocks.SamePrimeHistoryProbability

open SamePrimeHistoryResidual

/-- Measurability comes from the proved monotonicity of the literal same-prime sum. -/
theorem s_measurable : Measurable s := s_monotone.measurable

theorem delayed_s_measurable (v : ℝ) : Measurable (fun r : ℝ => s (v - r)) :=
  s_measurable.comp (measurable_const.sub measurable_id)

/-- A finite causal delay measure gives an integrable actual same-prime sum. -/
theorem delayed_s_integrable {μ : Measure ℝ} [IsFiniteMeasure μ]
    (hcausal : ∀ᵐ r ∂μ, 0 ≤ r) (v : ℝ) :
    Integrable (fun r : ℝ => s (v - r)) μ := by
  apply (integrable_const (s v)).mono' (delayed_s_measurable v).aestronglyMeasurable
  filter_upwards [hcausal] with r hr
  simpa only [Real.norm_eq_abs, abs_of_nonneg (s_nonneg (v - r))] using s_delay_le v hr

/-- Probability averaging cannot increase the same-prime subtraction. -/
theorem delayed_s_integral_bounds {μ : Measure ℝ} [IsProbabilityMeasure μ]
    (hcausal : ∀ᵐ r ∂μ, 0 ≤ r) (v : ℝ) :
    0 ≤ (∫ r, s (v - r) ∂μ) ∧ (∫ r, s (v - r) ∂μ) ≤ s v := by
  constructor
  · exact integral_nonneg (fun r => s_nonneg (v - r))
  · have hle : (∫ r, s (v - r) ∂μ) ≤ ∫ _ : ℝ, s v ∂μ := by
      apply integral_mono_ae (delayed_s_integrable hcausal v) (integrable_const (s v))
      filter_upwards [hcausal] with r hr
      exact s_delay_le v hr
    simpa using hle

/-- The integral difference is the signed residual, with both bounds explicit. -/
theorem samePrime_residual_bounds {μ : Measure ℝ} [IsProbabilityMeasure μ]
    (hcausal : ∀ᵐ r ∂μ, 0 ≤ r) (v : ℝ) :
    -s v ≤ (∫ r, s (v - r) ∂μ) - s v ∧
      (∫ r, s (v - r) ∂μ) - s v ≤ 0 := by
  obtain ⟨hlo, hhi⟩ := delayed_s_integral_bounds hcausal v
  constructor <;> linarith

#print axioms delayed_s_integrable
#print axioms delayed_s_integral_bounds
#print axioms samePrime_residual_bounds

end BuildingBlocks.SamePrimeHistoryProbability
