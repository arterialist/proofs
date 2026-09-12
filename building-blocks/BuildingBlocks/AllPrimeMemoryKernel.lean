import BuildingBlocks.PrimeSeedAllPrimeSquare
import BuildingBlocks.MemoryChargeFubini

/-! Literal all-prime corrected memory, using the proved square-integrable
collective seed and the original exponential charge reference. -/

open MeasureTheory Real Set

namespace BuildingBlocks.PrimeSeedMass

theorem allPrimeSeed_eq_zero_nonpos {v : ℝ} (hv : v ≤ 0) : allPrimeSeed v = 0 := by
  rw [allPrimeSeed_eq_finite_support_sum]
  exact finitePrimeSeed_eq_zero_nonpos _ hv

theorem allPrimeSeed_memory_defect_integrable {f : ℝ → ℝ}
    (hmf : Measurable f) (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    IntegrableOn (fun v => SuccessorCharge.kernel v *
      SuccessorCharge.causalMemory allPrimeSeed f v) (Ioi (0 : ℝ)) :=
  SuccessorCharge.integrable_memory_defect measurable_allPrimeSeed hmf allPrimeSeed_memLp_two hf

theorem allPrimeSeed_defect_causalMemory {f : ℝ → ℝ}
    (hmf : Measurable f) (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    SuccessorCharge.defect (SuccessorCharge.causalMemory allPrimeSeed f) =
      ∫ u in Ioi (0 : ℝ), SuccessorCharge.memoryDefectKernel allPrimeSeed u * f u :=
  SuccessorCharge.defect_causalMemory measurable_allPrimeSeed hmf allPrimeSeed_memLp_two hf

theorem allPrimeSeed_defectKernel_causal {u : ℝ} (hu : 0 ≤ u) :
    SuccessorCharge.memoryDefectKernel allPrimeSeed u =
      (1 / 2) * ∫ w in Ioi (0 : ℝ), SuccessorCharge.kernel (u + w) * allPrimeSeed w :=
  SuccessorCharge.memoryDefectKernel_causal
    (Filter.Eventually.of_forall (fun _ hw => allPrimeSeed_eq_zero_nonpos hw.le)) hu

theorem allPrimeSeed_corrected_kernel_identity {f : ℝ → ℝ}
    (hmf : Measurable f) (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    SuccessorCharge.compensated (SuccessorCharge.causalMemory allPrimeSeed f) v -
      SuccessorCharge.causalMemory allPrimeSeed (SuccessorCharge.compensated f) v =
      ∫ u in Ioi (0 : ℝ), SuccessorCharge.correctedMemoryKernel allPrimeSeed v u * f u :=
  SuccessorCharge.corrected_memory_kernel_identity measurable_allPrimeSeed hmf allPrimeSeed_memLp_two hf v

end BuildingBlocks.PrimeSeedMass
