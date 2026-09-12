import BuildingBlocks.SuccessorCriticalLift
import BuildingBlocks.SuccessorChargeEnergy

/-! The original charge-compensated successor and its literal L² adjoint. -/

open MeasureTheory Real Set

namespace BuildingBlocks.SuccessorCharge

theorem reference_memLp :
    MemLp (fun v : ℝ => exp (-v / 2)) 2 (volume.restrict (Ioi (0 : ℝ))) := by
  have hm : Measurable (fun v : ℝ => exp (-v / 2)) := by fun_prop
  apply (memLp_two_iff_integrable_sq hm.aestronglyMeasurable).2
  have he (v : ℝ) : exp (-v / 2) ^ 2 = exp (-1 * v) := by
    rw [pow_two, ← exp_add]
    congr 1
    ring
  simp_rw [he]
  exact integrableOn_exp_mul_Ioi (by norm_num : (-1 : ℝ) < 0) 0

theorem kernel_memLp : MemLp kernel 2 (volume.restrict (Ioi (0 : ℝ))) := by
  apply weightedKernel_memLp.of_le measurable_kernel.aestronglyMeasurable
  filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with u hu
  change 0 < u at hu
  have he : 1 ≤ exp (u / 2) := one_le_exp (by linarith)
  simp only [Real.norm_eq_abs, weightedKernel, abs_mul, abs_of_pos (exp_pos _)]
  exact le_mul_of_one_le_left (abs_nonneg _) he

theorem integrable_defect_of_memLp {f : ℝ → ℝ}
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    IntegrableOn (fun u => kernel u * f u) (Ioi (0 : ℝ)) :=
  kernel_memLp.integrable_mul hf

theorem compensated_memLp {f : ℝ → ℝ} (hm : Measurable f)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    MemLp (compensated f) 2 (volume.restrict (Ioi (0 : ℝ))) :=
  (successor_memLp hm hf).sub (reference_memLp.mul_const (defect f))

noncomputable def compensatedAdjoint (f : ℝ → ℝ) (u : ℝ) : ℝ :=
  predecessor f u - ((1 / 2) * ∫ v in Ioi (0 : ℝ), exp (-v / 2) * f v) * kernel u

theorem compensatedAdjoint_memLp {f : ℝ → ℝ} (hm : Measurable f)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    MemLp (compensatedAdjoint f) 2 (volume.restrict (Ioi (0 : ℝ))) :=
  (predecessor_memLp hm hf).sub (kernel_memLp.const_mul _)

/-- The original exponential reference produces this rank-one adjoint term.
No change of reference or omission of the predecessor's initial interval occurs. -/
theorem compensated_adjoint {f g : ℝ → ℝ} (hmf : Measurable f) (hmg : Measurable g)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ))))
    (hg : MemLp g 2 (volume.restrict (Ioi (0 : ℝ)))) :
    (∫ v in Ioi (0 : ℝ), f v * compensated g v) =
      ∫ u in Ioi (0 : ℝ), compensatedAdjoint f u * g u := by
  have hS := hf.integrable_mul (successor_memLp hmg hg)
  have hR := hf.integrable_mul reference_memLp
  have hP := (predecessor_memLp hmf hf).integrable_mul hg
  have hK := kernel_memLp.integrable_mul hg
  simp only [Pi.mul_def] at hS hR hP hK
  have hl : (∫ v in Ioi (0 : ℝ), f v * compensated g v) =
      (∫ v in Ioi (0 : ℝ), f v * successor g v) -
      (∫ v in Ioi (0 : ℝ), f v * exp (-v / 2)) * defect g := by
    simp only [compensated, mul_sub, ← mul_assoc]
    rw [integral_sub hS (hR.mul_const _), integral_mul_const]
  have hr : (∫ u in Ioi (0 : ℝ), compensatedAdjoint f u * g u) =
      (∫ u in Ioi (0 : ℝ), predecessor f u * g u) -
      ((1 / 2) * ∫ v in Ioi (0 : ℝ), exp (-v / 2) * f v) *
        (∫ u in Ioi (0 : ℝ), kernel u * g u) := by
    simp only [compensatedAdjoint, sub_mul, mul_assoc]
    have hRK : IntegrableOn (fun u => (1 / 2 : ℝ) *
        ((∫ v in Ioi (0 : ℝ), exp (-v / 2) * f v) * (kernel u * g u))) (Ioi (0 : ℝ)) :=
      (hK.const_mul _).const_mul _
    rw [integral_sub hP hRK, integral_const_mul, integral_const_mul]
  rw [hl, hr, successor_predecessor_adjoint]
  have he : (∫ v in Ioi (0 : ℝ), f v * exp (-v / 2)) =
      ∫ v in Ioi (0 : ℝ), exp (-v / 2) * f v := by
    apply integral_congr_ae
    exact Filter.Eventually.of_forall (fun v => mul_comm _ _)
  rw [he, defect]
  ring

end BuildingBlocks.SuccessorCharge
