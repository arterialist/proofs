import BuildingBlocks.FactorialRealCellMajorant
import BuildingBlocks.FactorialBinaryIntegrability

open Real Set MeasureTheory Filter
namespace BuildingBlocks.FactorialRealCellPhase

noncomputable def actualResidual (N : ℕ) (t : ℝ) : ℝ :=
  BuildingBlocks.FactorialBinaryCarry.response N t - actualBaseline N t

theorem actualResidual_eq_work (N : ℕ) {t : ℝ} (ht : 0 < t) (hN : 0 < N) :
    actualResidual N t = ∫ x in (1 : ℝ)..N, actualDiscrepancy N x * (-inverseTestPhase x t) :=
  (actualDiscrepancy_phase_integral N ht hN).symm

theorem actualResidual_measurable (N : ℕ) : Measurable (actualResidual N) :=
  (BuildingBlocks.FactorialBinaryEnergy.response_continuous N).measurable.sub (actualBaseline_measurable N)

theorem actualResidual_energy_integrable (N : ℕ) (hN : 0 < N) :
    IntegrableOn (fun t => actualResidual N t ^ 2 * FactorialBinaryEnergy.weight t) (Ioi 0) := by
  have hm : Measurable (fun t => actualResidual N t ^ 2 * FactorialBinaryEnergy.weight t) := by
    have hw : Measurable FactorialBinaryEnergy.weight := by unfold FactorialBinaryEnergy.weight; fun_prop
    exact ((actualResidual_measurable N).pow_const 2).mul hw
  apply (((BuildingBlocks.FactorialBinaryIntegrability.energyRow_integrable N).add
    (actualBaseline_energy_integrable N hN)).const_mul 2).mono' hm.aestronglyMeasurable
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  have hw := (FactorialBinaryEnergy.weight_pos t ht).le
  rw [Real.norm_eq_abs, abs_of_nonneg (mul_nonneg (sq_nonneg _) hw)]
  unfold actualResidual FactorialBinaryEnergy.energyRow
  dsimp only [Pi.add_apply]
  nlinarith [mul_nonneg (sq_nonneg (BuildingBlocks.FactorialBinaryCarry.response N t + actualBaseline N t)) hw]

theorem actualMixed_energy_integrable (N : ℕ) (hN : 0 < N) :
    IntegrableOn (fun t => actualBaseline N t * actualResidual N t * FactorialBinaryEnergy.weight t) (Ioi 0) := by
  have hm : Measurable (fun t => actualBaseline N t * actualResidual N t * FactorialBinaryEnergy.weight t) := by
    have hw : Measurable FactorialBinaryEnergy.weight := by unfold FactorialBinaryEnergy.weight; fun_prop
    exact ((actualBaseline_measurable N).mul (actualResidual_measurable N)).mul hw
  apply ((actualBaseline_energy_integrable N hN).add (actualResidual_energy_integrable N hN)).mono'
    hm.aestronglyMeasurable
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  have hw := (FactorialBinaryEnergy.weight_pos t ht).le
  rw [Real.norm_eq_abs, abs_mul, abs_mul, abs_of_nonneg hw]
  dsimp only [Pi.add_apply]
  nlinarith [mul_nonneg (sq_nonneg (|actualBaseline N t| - |actualResidual N t|)) hw,
    mul_nonneg (mul_nonneg (abs_nonneg (actualBaseline N t)) (abs_nonneg (actualResidual N t))) hw,
    sq_abs (actualBaseline N t), sq_abs (actualResidual N t)]

/-- Entire positive-clock energy with the complete signed mixed term retained. -/
theorem actual_energy_split (N : ℕ) (hN : 0 < N) :
    (∫ t in Ioi 0, BuildingBlocks.FactorialBinaryCarry.response N t ^ 2 * FactorialBinaryEnergy.weight t) =
      (∫ t in Ioi 0, actualBaseline N t ^ 2 * FactorialBinaryEnergy.weight t) +
      2 * (∫ t in Ioi 0, actualBaseline N t * actualResidual N t * FactorialBinaryEnergy.weight t) +
      (∫ t in Ioi 0, actualResidual N t ^ 2 * FactorialBinaryEnergy.weight t) := by
  have he : (fun t => BuildingBlocks.FactorialBinaryCarry.response N t ^ 2 * FactorialBinaryEnergy.weight t) =
      (fun t => (actualBaseline N t ^ 2 * FactorialBinaryEnergy.weight t +
        2 * (actualBaseline N t * actualResidual N t * FactorialBinaryEnergy.weight t)) +
        actualResidual N t ^ 2 * FactorialBinaryEnergy.weight t) := by
    funext t
    unfold actualResidual
    ring
  have h1 := integral_add ((actualBaseline_energy_integrable N hN).add
    ((actualMixed_energy_integrable N hN).const_mul 2)) (actualResidual_energy_integrable N hN)
  have h2 := integral_add (actualBaseline_energy_integrable N hN)
    ((actualMixed_energy_integrable N hN).const_mul 2)
  simp only [Pi.add_apply] at h1 h2
  rw [he, h1, h2, integral_const_mul]

noncomputable def actualWork (N : ℕ) (t : ℝ) : ℝ :=
  ∫ x in (1 : ℝ)..N, actualDiscrepancy N x * (-inverseTestPhase x t)

theorem actualWork_energy_integrable (N : ℕ) (hN : 0 < N) :
    IntegrableOn (fun t => actualWork N t ^ 2 * FactorialBinaryEnergy.weight t) (Ioi 0) := by
  apply (actualResidual_energy_integrable N hN).congr
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  rw [actualResidual_eq_work N ht hN]
  rfl

theorem actualWork_mixed_integrable (N : ℕ) (hN : 0 < N) :
    IntegrableOn (fun t => actualBaseline N t * actualWork N t * FactorialBinaryEnergy.weight t) (Ioi 0) := by
  apply (actualMixed_energy_integrable N hN).congr
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  rw [actualResidual_eq_work N ht hN]
  rfl

/-- The entire positive-axis energy expressed through the actual signed interval work. -/
theorem actualWork_energy_split (N : ℕ) (hN : 0 < N) :
    (∫ t in Ioi 0, BuildingBlocks.FactorialBinaryCarry.response N t ^ 2 * FactorialBinaryEnergy.weight t) =
      (∫ t in Ioi 0, actualBaseline N t ^ 2 * FactorialBinaryEnergy.weight t) +
      2 * (∫ t in Ioi 0, actualBaseline N t * actualWork N t * FactorialBinaryEnergy.weight t) +
      (∫ t in Ioi 0, actualWork N t ^ 2 * FactorialBinaryEnergy.weight t) := by
  have hM : (∫ t in Ioi 0, actualBaseline N t * actualResidual N t * FactorialBinaryEnergy.weight t) =
      ∫ t in Ioi 0, actualBaseline N t * actualWork N t * FactorialBinaryEnergy.weight t := by
    apply integral_congr_ae
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
    rw [actualResidual_eq_work N ht hN]
    rfl
  have hR : (∫ t in Ioi 0, actualResidual N t ^ 2 * FactorialBinaryEnergy.weight t) =
      ∫ t in Ioi 0, actualWork N t ^ 2 * FactorialBinaryEnergy.weight t := by
    apply integral_congr_ae
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
    rw [actualResidual_eq_work N ht hN]
    rfl
  rw [actual_energy_split N hN, hM, hR]

#print axioms actualWork_energy_split
#print axioms actualWork_mixed_integrable
#print axioms actualWork_energy_integrable
#print axioms actual_energy_split
#print axioms actualMixed_energy_integrable
#print axioms actualResidual_energy_integrable
#print axioms actualResidual_measurable
#print axioms actualResidual_eq_work
end BuildingBlocks.FactorialRealCellPhase
