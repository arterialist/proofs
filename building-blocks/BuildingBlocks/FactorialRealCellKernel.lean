import BuildingBlocks.FactorialRealCellPhase

open Real Set MeasureTheory
namespace BuildingBlocks.FactorialRealCellPhase

noncomputable def phaseRow (a b t : ℝ) : ℝ :=
  scalarPhase a t * scalarPhase b t * FactorialBinaryEnergy.weight t
noncomputable def phaseKernel (a b : ℝ) : ℝ := ∫ t in Ioi 0, phaseRow a b t

theorem phaseRow_integrable {a b : ℝ} (ha : 1 ≤ a) (hb : 1 ≤ b) :
    IntegrableOn (phaseRow a b) (Ioi 0) := by
  have hm : Measurable (phaseRow a b) := by
    unfold phaseRow scalarPhase FactorialBinaryEnergy.weight
    fun_prop
  apply (FactorialKernelDictionary.kernelRow_integrable 1 1).mono' hm.aestronglyMeasurable
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  have hh := scalarPhase_weighted_bounds ha hb ht
  unfold phaseRow
  rw [Real.norm_eq_abs, abs_of_pos hh.1]
  exact hh.2.le

theorem phaseKernel_bounds {a b : ℝ} (ha : 1 ≤ a) (hb : 1 ≤ b) :
    0 ≤ phaseKernel a b ∧ phaseKernel a b ≤ log 2 := by
  constructor
  · apply integral_nonneg_of_ae
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
    exact (scalarPhase_weighted_bounds ha hb ht).1.le
  · have hh : phaseKernel a b ≤ FactorialKernelDictionary.kernel 1 1 := by
      rw [← FactorialKernelDictionary.kernel_integral]
      apply integral_mono_ae (phaseRow_integrable ha hb)
        (FactorialKernelDictionary.kernelRow_integrable 1 1)
      filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
      exact (scalarPhase_weighted_bounds ha hb ht).2.le
    have he : FactorialKernelDictionary.kernel 1 1 = log 2 := by
      norm_num [FactorialKernelDictionary.kernel, Real.log_one]
      ring
    rwa [he] at hh

theorem phaseKernel_mono_left {a c b : ℝ} (ha : 1 ≤ a) (hac : a ≤ c) (hb : 1 ≤ b) :
    phaseKernel a b ≤ phaseKernel c b := by
  apply integral_mono_ae (phaseRow_integrable ha hb) (phaseRow_integrable (ha.trans hac) hb)
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  unfold phaseRow
  exact mul_le_mul_of_nonneg_right
    (mul_le_mul_of_nonneg_right ((scalarPhase_strictMono ht).monotone hac)
      (scalarPhase_pos hb ht).le) (FactorialBinaryEnergy.weight_pos t ht).le

theorem phaseKernel_symm (a b : ℝ) : phaseKernel a b = phaseKernel b a := by
  unfold phaseKernel
  congr 1
  funext t
  unfold phaseRow
  ring

theorem phaseKernel_mono_right {a b c : ℝ} (ha : 1 ≤ a) (hb : 1 ≤ b) (hbc : b ≤ c) :
    phaseKernel a b ≤ phaseKernel a c := by
  rw [phaseKernel_symm a b, phaseKernel_symm a c]
  exact phaseKernel_mono_left hb hbc ha

private theorem positive_integral_Ioi {f : ℝ → ℝ} (hi : IntegrableOn f (Ioi 0))
    (hp : ∀ t, 0 < t → 0 < f t) : 0 < ∫ t in Ioi 0, f t := by
  have hn : 0 ≤ᵐ[volume.restrict (Ioi 0)] f := by
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
    exact (hp t ht).le
  apply (integral_pos_iff_support_of_nonneg_ae hn hi).mpr
  have hs : Ioi (0 : ℝ) ⊆ Function.support f := by
    intro t ht
    exact ne_of_gt (hp t ht)
  have hh : 0 < (volume.restrict (Ioi (0 : ℝ))) (Ioi 0) := by simp
  exact hh.trans_le (measure_mono hs)

theorem phaseKernel_strict_bounds {a b : ℝ} (ha : 1 ≤ a) (hb : 1 ≤ b) :
    0 < phaseKernel a b ∧ phaseKernel a b < log 2 := by
  constructor
  · exact positive_integral_Ioi (phaseRow_integrable ha hb)
      (fun t ht => (scalarPhase_weighted_bounds ha hb ht).1)
  · have hp := positive_integral_Ioi
      ((FactorialKernelDictionary.kernelRow_integrable 1 1).sub (phaseRow_integrable ha hb))
      (fun t ht => sub_pos.mpr (scalarPhase_weighted_bounds ha hb ht).2)
    simp only [Pi.sub_apply] at hp
    rw [integral_sub (FactorialKernelDictionary.kernelRow_integrable 1 1)
      (phaseRow_integrable ha hb), FactorialKernelDictionary.kernel_integral] at hp
    have he : FactorialKernelDictionary.kernel 1 1 = log 2 := by
      norm_num [FactorialKernelDictionary.kernel, Real.log_one]
      ring
    rw [he] at hp
    exact sub_pos.mp hp

theorem phaseKernel_strictMono_left {a c b : ℝ} (ha : 1 ≤ a) (hac : a < c) (hb : 1 ≤ b) :
    phaseKernel a b < phaseKernel c b := by
  have hp := positive_integral_Ioi
    ((phaseRow_integrable (ha.trans hac.le) hb).sub (phaseRow_integrable ha hb))
    (fun t ht => by
      apply sub_pos.mpr
      unfold phaseRow
      exact mul_lt_mul_of_pos_right
        (mul_lt_mul_of_pos_right ((scalarPhase_strictMono ht) hac) (scalarPhase_pos hb ht))
        (FactorialBinaryEnergy.weight_pos t ht))
  simp only [Pi.sub_apply] at hp
  rw [integral_sub (phaseRow_integrable (ha.trans hac.le) hb) (phaseRow_integrable ha hb)] at hp
  exact sub_pos.mp hp

theorem phaseKernel_strictMono_right {a b c : ℝ} (ha : 1 ≤ a) (hb : 1 ≤ b) (hbc : b < c) :
    phaseKernel a b < phaseKernel a c := by
  rw [phaseKernel_symm a b, phaseKernel_symm a c]
  exact phaseKernel_strictMono_left hb hbc ha

#print axioms phaseKernel_strictMono_left
#print axioms phaseKernel_strictMono_right
#print axioms phaseKernel_strict_bounds
#print axioms phaseKernel_symm
#print axioms phaseKernel_mono_right
#print axioms phaseRow_integrable
#print axioms phaseKernel_bounds
#print axioms phaseKernel_mono_left
end BuildingBlocks.FactorialRealCellPhase
