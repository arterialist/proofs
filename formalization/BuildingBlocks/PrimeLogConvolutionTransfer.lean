import BuildingBlocks.HyperbolaProduct
import BuildingBlocks.PrimeLogFilter
import BuildingBlocks.ReflectedConvolutionTransfer

open MeasureTheory Set
open scoped Interval

namespace BuildingBlocks

open CoarsePrimitive HyperbolaProduct

theorem primeLogError_measurable : Measurable primeLogError := by
  unfold primeLogError
  exact (Real.continuous_exp.comp (continuous_const.mul continuous_id)).measurable.mul
    (primeErrorReal_measurable.comp Real.continuous_exp.measurable)

theorem primeLogError_complex_measurable :
    Measurable (fun t => (primeLogError t : ℂ)) :=
  Complex.continuous_ofReal.measurable.comp primeLogError_measurable

theorem primeLogFilteredError_complex_measurable :
    Measurable (fun t => ((primeLogError t - primeLogResponse t : ℝ) : ℂ)) :=
  Complex.continuous_ofReal.measurable.comp
    (primeLogError_measurable.sub primeLogResponse_continuous.measurable)

/-- Local square integrability of the actual logarithmic prime error,
including its prime-power jumps. No RH hypothesis is used. -/
theorem primeLogError_complex_memLp_two (u v : ℝ) :
    MemLp (fun t => (primeLogError t : ℂ)) 2 (volume.restrict (Ioc u v)) := by
  apply (memLp_two_iff_integrable_sq_norm
    primeLogError_complex_measurable.aestronglyMeasurable).mpr
  simpa only [Complex.norm_real, Real.norm_eq_abs, sq_abs] using
    (primeLogError_sq_intervalIntegrable u v).1

/-- The actual continuous response is locally square integrable after
complexification. -/
theorem primeLogResponse_complex_memLp_two (u v : ℝ) :
    MemLp (fun t => (primeLogResponse t : ℂ)) 2 (volume.restrict (Ioc u v)) := by
  have hc : Continuous (fun t => (primeLogResponse t : ℂ)) :=
    Complex.continuous_ofReal.comp primeLogResponse_continuous
  apply (memLp_two_iff_integrable_sq_norm hc.measurable.aestronglyMeasurable).mpr
  exact ((hc.norm.pow 2).intervalIntegrable u v).1

theorem primeLogFilteredError_complex_memLp_two (u v : ℝ) :
    MemLp (fun t => ((primeLogError t - primeLogResponse t : ℝ) : ℂ)) 2
      (volume.restrict (Ioc u v)) := by
  have h := (primeLogError_complex_memLp_two u v).sub
    (primeLogResponse_complex_memLp_two u v)
  change MemLp (fun t => (primeLogError t : ℂ) - (primeLogResponse t : ℂ)) 2
    (volume.restrict (Ioc u v)) at h
  simpa only [← Complex.ofReal_sub] using h

/-- The finite reflected-convolution approximation bound for the actual
arithmetic input and its filtered response. All arithmetic measurability and
L² obligations are discharged; only the approximants have hypotheses. -/
theorem primeLog_reflected_convolution_transfer {T : ℝ} (hT : 0 ≤ T)
    {p q : ℝ → ℂ} (hqmeas : Measurable q)
    (hp : MemLp p 2 (volume.restrict (Ioc 0 T)))
    (hq : MemLp q 2 (volume.restrict (Ioc 0 T))) :
    ‖(∫ t in (0 : ℝ)..T,
        (primeLogError t : ℂ) *
          ((primeLogError (T - t) - primeLogResponse (T - t) : ℝ) : ℂ)) -
        (∫ t in (0 : ℝ)..T, p t * q (T - t))‖ ≤
      Real.sqrt (∫ t in (0 : ℝ)..T, ‖(primeLogError t : ℂ) - p t‖ ^ 2) *
        Real.sqrt (∫ t in (0 : ℝ)..T, (primeLogError t - primeLogResponse t) ^ 2) +
      Real.sqrt (∫ t in (0 : ℝ)..T, ‖p t‖ ^ 2) *
        Real.sqrt (∫ t in (0 : ℝ)..T,
          ‖((primeLogError t - primeLogResponse t : ℝ) : ℂ) - q t‖ ^ 2) := by
  have h := reflected_convolution_transfer_memLp hT
    primeLogFilteredError_complex_measurable hqmeas
    (primeLogError_complex_memLp_two 0 T)
    (primeLogFilteredError_complex_memLp_two 0 T) hp hq
  simpa only [Complex.norm_real, Real.norm_eq_abs, sq_abs] using h

end BuildingBlocks
