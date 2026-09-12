import BuildingBlocks.SuccessorCompensatedL2
import BuildingBlocks.PrimeSeedMemory

/-! The original reference and relative charge in the causal memory response. -/

open MeasureTheory Real Set

namespace BuildingBlocks.SuccessorCharge

theorem causalMemory_bound {F f : ℝ → ℝ} (hF : MemLp F 2 volume)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    |causalMemory F f v| ≤ sqrt (∫ x, F x ^ 2) * sqrt (∫ u in Ioi (0 : ℝ), f u ^ 2) := by
  have hfull := hF.comp_measurePreserving ((volume : Measure ℝ).measurePreserving_sub_left v)
  have hi := setIntegral_le_integral (s := Ioi (0 : ℝ)) hfull.integrable_sq
    (Filter.Eventually.of_forall (fun u => sq_nonneg (F (v - u))))
  have he : (∫ u, F (v - u) ^ 2) = ∫ u, F u ^ 2 :=
    integral_sub_left_eq_self (fun u => F u ^ 2) volume v
  change (∫ u in Ioi (0 : ℝ), F (v - u) ^ 2) ≤ ∫ u, F (v - u) ^ 2 at hi
  rw [he] at hi
  exact (MixedEnergy.integral_mul_abs_le_sqrt (reflected_halfline_memLp hF v) hf).trans
    (mul_le_mul_of_nonneg_right (sqrt_le_sqrt hi) (sqrt_nonneg _))

theorem kernel_integrable : IntegrableOn kernel (Ioi (0 : ℝ)) := by
  have hd := (integrableOn_exp_mul_Ioi (a := -1) (by norm_num) 0).const_mul 2
  apply hd.mono' measurable_kernel.aestronglyMeasurable
  exact Filter.Eventually.of_forall (fun u => by
    simpa only [Real.norm_eq_abs, neg_one_mul] using kernel_abs_le_exp u)

theorem aestronglyMeasurable_causalMemory {F f : ℝ → ℝ}
    (hF : Measurable F) (hf : Measurable f) :
    AEStronglyMeasurable (causalMemory F f) (volume.restrict (Ioi (0 : ℝ))) := by
  have hm : Measurable (fun z : ℝ × ℝ => F (z.1 - z.2) * f z.2) := by fun_prop
  exact hm.aestronglyMeasurable.integral_prod_right'

/-- The relative charge of the memory output is a genuine absolutely
convergent integral, even though a total output charge is not assumed. -/
theorem integrable_memory_defect {F f : ℝ → ℝ} (hmF : Measurable F) (hmf : Measurable f)
    (hF : MemLp F 2 volume) (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) :
    IntegrableOn (fun v => kernel v * causalMemory F f v) (Ioi (0 : ℝ)) := by
  let M := sqrt (∫ x, F x ^ 2) * sqrt (∫ u in Ioi (0 : ℝ), f u ^ 2)
  apply (kernel_integrable.norm.mul_const M).mono'
    (measurable_kernel.aestronglyMeasurable.mul (aestronglyMeasurable_causalMemory hmF hmf))
  apply Filter.Eventually.of_forall
  intro v
  rw [Pi.mul_apply, norm_mul]
  exact mul_le_mul_of_nonneg_left (causalMemory_bound hF hf v) (norm_nonneg _)

theorem causalMemory_compensated {F f : ℝ → ℝ} (hmf : Measurable f)
    (hF : MemLp F 2 volume) (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    causalMemory F (compensated f) v = causalMemory F (successor f) v -
      causalMemory F (fun u => exp (-u / 2)) v * defect f := by
  have hS := (reflected_halfline_memLp hF v).integrable_mul (successor_memLp hmf hf)
  have hR := (reflected_halfline_memLp hF v).integrable_mul reference_memLp
  simp only [Pi.mul_def] at hS hR
  simp only [causalMemory, compensated, mul_sub, ← mul_assoc]
  rw [integral_sub hS (hR.mul_const _), integral_mul_const]

/-- Exact original-reference response. The last term is retained with its
actual relative charge; identifying its transposed kernel is a later Fubini step. -/
theorem compensated_memory_commutator {F f : ℝ → ℝ}
    (hmF : Measurable F) (hmf : Measurable f) (hF : MemLp F 2 volume)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    compensated (causalMemory F f) v - causalMemory F (compensated f) v =
      (∫ u in Ioi (0 : ℝ), memoryKernel F v u * f u) +
      causalMemory F (fun u => exp (-u / 2)) v * defect f -
      exp (-v / 2) * defect (causalMemory F f) := by
  rw [compensated, causalMemory_compensated hmf hF hf]
  have h := successor_memory_commutator hmF hF hf v
  linarith

end BuildingBlocks.SuccessorCharge

namespace BuildingBlocks.PrimeSeedMass

theorem finitePrimeSeed_compensated_memory_commutator (S : Finset Nat.Primes)
    {f : ℝ → ℝ} (hmf : Measurable f)
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    SuccessorCharge.compensated (SuccessorCharge.causalMemory (finitePrimeSeed S) f) v -
      SuccessorCharge.causalMemory (finitePrimeSeed S) (SuccessorCharge.compensated f) v =
      (∫ u in Ioi (0 : ℝ), SuccessorCharge.memoryKernel (finitePrimeSeed S) v u * f u) +
      SuccessorCharge.causalMemory (finitePrimeSeed S) (fun u => exp (-u / 2)) v *
        SuccessorCharge.defect f - exp (-v / 2) *
        SuccessorCharge.defect (SuccessorCharge.causalMemory (finitePrimeSeed S) f) :=
  SuccessorCharge.compensated_memory_commutator (measurable_finitePrimeSeed S) hmf
    (finitePrimeSeed_memLp_two S) hf v

end BuildingBlocks.PrimeSeedMass
