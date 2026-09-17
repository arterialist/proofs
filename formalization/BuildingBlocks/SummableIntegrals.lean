import Mathlib.MeasureTheory.Integral.DominatedConvergence

open MeasureTheory Filter ENNReal
open scoped Topology ENNReal

namespace BuildingBlocks.SummableIntegrals

/-- Countable absolute summability in `L¹` makes the actual pointwise `tsum` integrable.
Only almost-everywhere absolute convergence is derived; none is assumed at exceptional points. -/
theorem integrable_tsum_of_summable_integral_norm
    {α ι : Type*} [MeasurableSpace α] [Countable ι]
    {μ : Measure α} {F : ι → α → ℂ}
    (hF : ∀ i, Integrable (F i) μ)
    (hsum : Summable (fun i => ∫ x, ‖F i x‖ ∂μ)) :
    Integrable (fun x => ∑' i, F i x) μ := by
  have hmeas (i : ι) : AEMeasurable (fun x => ‖F i x‖ₑ) μ := (hF i).1.enorm
  have hfinite : (∑' i, ∫⁻ x, ‖F i x‖ₑ ∂μ) ≠ ∞ := by
    have hid (i : ι) : ∫⁻ x, ‖F i x‖ₑ ∂μ = ‖∫ x, ‖F i x‖ ∂μ‖ₑ := by
      rw [← ofReal_integral_norm_eq_lintegral_enorm (hF i)]
      exact (Real.enorm_eq_ofReal (integral_nonneg (fun x => norm_nonneg (F i x)))).symm
    rw [funext hid]
    exact ENNReal.tsum_coe_ne_top_iff_summable.2 (NNReal.summable_coe.1 hsum.abs)
  have hae : ∀ᵐ x ∂μ, Summable (fun i => (‖F i x‖₊ : ℝ)) := by
    have htotal : (∫⁻ x, ∑' i, ‖F i x‖ₑ ∂μ) ≠ ∞ := by
      rwa [lintegral_tsum hmeas]
    refine (ae_lt_top' (AEMeasurable.ennreal_tsum hmeas) htotal).mono ?_
    intro x hx
    rw [← ENNReal.tsum_coe_ne_top_iff_summable_coe]
    exact hx.ne
  have hsum_meas : AEStronglyMeasurable (fun x => ∑' i, F i x) μ := by
    apply aestronglyMeasurable_of_tendsto_ae (atTop : Filter (Finset ι))
      (fun s => s.aestronglyMeasurable_fun_sum (fun i _ => (hF i).1))
    exact hae.mono (fun x hx => hx.of_norm.hasSum)
  refine ⟨hsum_meas, ?_⟩
  change (∫⁻ x, ‖∑' i, F i x‖ₑ ∂μ) < ∞
  calc
    (∫⁻ x, ‖∑' i, F i x‖ₑ ∂μ) ≤ ∫⁻ x, ∑' i, ‖F i x‖ₑ ∂μ :=
      lintegral_mono (fun x => enorm_tsum_le_tsum_enorm)
    _ = ∑' i, ∫⁻ x, ‖F i x‖ₑ ∂μ := lintegral_tsum hmeas
    _ < ∞ := lt_top_iff_ne_top.mpr hfinite

end BuildingBlocks.SummableIntegrals
