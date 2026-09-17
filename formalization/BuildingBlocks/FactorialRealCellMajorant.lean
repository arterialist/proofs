import BuildingBlocks.FactorialRealCellDiscrepancy

open Real Finset Set MeasureTheory Filter
open scoped BigOperators
namespace BuildingBlocks.FactorialRealCellPhase

noncomputable def inverseCoefficientBudget (N : ℕ) : ℝ :=
  ∑ j ∈ Finset.Icc 1 N, |(ArithmeticFunction.moebius j : ℝ) / j|

theorem inverseTestPhase_norm_le_unit {t x : ℝ} (ht : 0 < t) (hx : 1 ≤ x) :
    ‖inverseTestPhase x t‖ ≤ inverseCoefficientBudget ⌊x⌋₊ * (1 - exp (-t)) := by
  unfold inverseTestPhase inverseCoefficientBudget
  rw [Finset.sum_mul]
  apply (norm_sum_le _ _).trans
  apply Finset.sum_le_sum
  intro j hj
  have hh := Finset.mem_Icc.mp hj
  have hjp : (0 : ℝ) < j := by exact_mod_cast hh.1
  have hjf : (j : ℝ) ≤ (⌊x⌋₊ : ℝ) := by exact_mod_cast hh.2
  have hjx := hjf.trans (Nat.floor_le (by linarith : 0 ≤ x))
  have ha : 1 ≤ x / j := (le_div_iff₀ hjp).mpr (by simpa using hjx)
  rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_of_pos (scalarPhase_pos ha ht)]
  exact mul_le_mul_of_nonneg_left (scalarPhase_lt_unit ht).le (abs_nonneg _)

theorem inverseCoefficientBudget_mono {M N : ℕ} (hMN : M ≤ N) :
    inverseCoefficientBudget M ≤ inverseCoefficientBudget N := by
  apply Finset.sum_le_sum_of_subset_of_nonneg
  · intro j hj
    exact Finset.mem_Icc.mpr ⟨(Finset.mem_Icc.mp hj).1, (Finset.mem_Icc.mp hj).2.trans hMN⟩
  · intro j _ _
    exact abs_nonneg _

theorem movingInverseTest_norm_le_unit (N : ℕ) {t : ℝ} (ht : 0 < t) (hN : 0 < N) :
    ‖movingInverseTest t N‖ ≤
      inverseCoefficientBudget N * (1 - exp (-t)) * ((N : ℝ) - 1) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hu : 0 ≤ 1 - exp (-t) := sub_nonneg.mpr (exp_le_one_iff.mpr (by linarith))
  have hb : ∀ x ∈ Set.uIoc 1 (N : ℝ),
      ‖-inverseTestPhase x t‖ ≤ inverseCoefficientBudget N * (1 - exp (-t)) := by
    intro x hx
    have hh : 1 < x ∧ x ≤ N := by simpa only [Set.uIoc_of_le hNr, Set.mem_Ioc] using hx
    rw [norm_neg]
    apply (inverseTestPhase_norm_le_unit ht hh.1.le).trans
    apply mul_le_mul_of_nonneg_right _ hu
    apply inverseCoefficientBudget_mono
    simpa only [Nat.floor_natCast] using Nat.floor_mono hh.2
  have hi := intervalIntegral.norm_integral_le_of_norm_le_const hb
  rw [movingInverseTest_integral_from_one ht hNr] at hi
  simpa only [abs_of_nonneg (by linarith : (0 : ℝ) ≤ N - 1)] using hi

theorem actualBaseline_norm_le_unit (N : ℕ) {t : ℝ} (ht : 0 < t) (hN : 0 < N) :
    ‖actualBaseline N t‖ ≤
      (1 + inverseCoefficientBudget N * ((N : ℝ) - 1)) * (1 - exp (-t)) := by
  have hu : 0 ≤ 1 - exp (-t) := sub_nonneg.mpr (exp_le_one_iff.mpr (by linarith))
  unfold actualBaseline
  calc
    _ ≤ ‖1 - exp (-t)‖ + ‖movingInverseTest t N‖ := norm_add_le _ _
    _ ≤ (1 - exp (-t)) + inverseCoefficientBudget N * (1 - exp (-t)) * ((N : ℝ) - 1) := by
      rw [Real.norm_eq_abs, abs_of_nonneg hu]
      exact add_le_add_left (movingInverseTest_norm_le_unit N ht hN) _
    _ = _ := by ring

theorem centeredTest_measurable_clock (x : ℝ) : Measurable (fun t => centeredTest t x) := by
  unfold centeredTest
  fun_prop

theorem actualBaseline_measurable (N : ℕ) : Measurable (actualBaseline N) := by
  unfold actualBaseline movingInverseTest
  simp only [Nat.floor_natCast]
  unfold finiteInverseTest
  apply (measurable_const.sub measurable_id.neg.exp).add
  apply Finset.measurable_sum
  intro j hj
  exact (centeredTest_measurable_clock ((N : ℝ) / j)).const_mul _

theorem actualBaseline_energy_integrable (N : ℕ) (hN : 0 < N) :
    IntegrableOn (fun t => actualBaseline N t ^ 2 * FactorialBinaryEnergy.weight t) (Set.Ioi 0) := by
  let C : ℝ := 1 + inverseCoefficientBudget N * ((N : ℝ) - 1)
  have hm : Measurable (fun t => actualBaseline N t ^ 2 * FactorialBinaryEnergy.weight t) := by
    have hw : Measurable FactorialBinaryEnergy.weight := by
      unfold FactorialBinaryEnergy.weight
      fun_prop
    exact ((actualBaseline_measurable N).pow_const 2).mul hw
  apply ((FactorialKernelDictionary.kernelRow_integrable 1 1).const_mul (C ^ 2)).mono'
    hm.aestronglyMeasurable
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  have hw := (FactorialBinaryEnergy.weight_pos t ht).le
  have hb := actualBaseline_norm_le_unit N ht hN
  change ‖actualBaseline N t‖ ≤ C * (1 - exp (-t)) at hb
  have hs := mul_self_le_mul_self (norm_nonneg (actualBaseline N t)) hb
  have hsq : actualBaseline N t ^ 2 ≤ C ^ 2 * (1 - exp (-t)) ^ 2 := by
    simpa only [Real.norm_eq_abs, ← pow_two, sq_abs, mul_pow] using hs
  rw [Real.norm_eq_abs, abs_of_nonneg (mul_nonneg (sq_nonneg _) hw)]
  have hk : FactorialKernelDictionary.kernelRow 1 1 t =
      (1 - exp (-t)) ^ 2 * FactorialBinaryEnergy.weight t := by
    unfold FactorialKernelDictionary.kernelRow FactorialEntropyIntegral.numerator
    simp [pow_two]
  rw [hk]
  nlinarith [mul_le_mul_of_nonneg_right hsq hw]

#print axioms actualBaseline_energy_integrable
#print axioms actualBaseline_measurable
#print axioms centeredTest_measurable_clock
#print axioms actualBaseline_norm_le_unit
#print axioms movingInverseTest_norm_le_unit
#print axioms inverseCoefficientBudget_mono
#print axioms inverseTestPhase_norm_le_unit
end BuildingBlocks.FactorialRealCellPhase
