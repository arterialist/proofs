import BuildingBlocks.FactorialKernelDictionary

open Real Set MeasureTheory
namespace BuildingBlocks.FactorialRealCellPhase

noncomputable def scalarPhase (a t : ℝ) : ℝ := 1 - exp (-t) - t * exp (-a * t)

theorem scalarPhase_pos {a t : ℝ} (ha : 1 ≤ a) (ht : 0 < t) : 0 < scalarPhase a t := by
  have he := mul_lt_mul_of_pos_right (add_one_lt_exp (ne_of_gt ht)) (exp_pos (-t))
  have hp : exp t * exp (-t) = 1 := by rw [← exp_add]; simp
  have hm : exp (-a * t) ≤ exp (-t) := exp_le_exp.mpr (by nlinarith)
  have hh := mul_le_mul_of_nonneg_left hm ht.le
  unfold scalarPhase
  nlinarith

theorem scalarPhase_lt_unit {a t : ℝ} (ht : 0 < t) : scalarPhase a t < 1 - exp (-t) := by
  unfold scalarPhase
  linarith [mul_pos ht (exp_pos (-a * t))]

theorem scalarPhase_strictMono {t : ℝ} (ht : 0 < t) : StrictMono (fun a => scalarPhase a t) := by
  intro a b hab
  have he : exp (-b * t) < exp (-a * t) := exp_lt_exp.mpr (by nlinarith)
  have hh := mul_lt_mul_of_pos_left he ht
  unfold scalarPhase
  linarith

theorem scalarPhase_product_bounds {a b t : ℝ} (ha : 1 ≤ a) (hb : 1 ≤ b) (ht : 0 < t) :
    0 < scalarPhase a t * scalarPhase b t ∧
      scalarPhase a t * scalarPhase b t < (1 - exp (-t)) ^ 2 := by
  have hp := scalarPhase_pos ha ht
  have hq := scalarPhase_pos hb ht
  have hu : 0 < 1 - exp (-t) := lt_trans hp (scalarPhase_lt_unit ht)
  constructor
  · exact mul_pos hp hq
  · calc
      _ < (1 - exp (-t)) * scalarPhase b t :=
        mul_lt_mul_of_pos_right (scalarPhase_lt_unit ht) hq
      _ ≤ (1 - exp (-t)) * (1 - exp (-t)) :=
        mul_le_mul_of_nonneg_left (scalarPhase_lt_unit ht).le hu.le
      _ = _ := (pow_two _).symm

theorem scalarPhase_weighted_bounds {a b t : ℝ} (ha : 1 ≤ a) (hb : 1 ≤ b) (ht : 0 < t) :
    0 < scalarPhase a t * scalarPhase b t * FactorialBinaryEnergy.weight t ∧
      scalarPhase a t * scalarPhase b t * FactorialBinaryEnergy.weight t <
        FactorialKernelDictionary.kernelRow 1 1 t := by
  have hw := FactorialBinaryEnergy.weight_pos t ht
  have hh := scalarPhase_product_bounds ha hb ht
  constructor
  · exact mul_pos hh.1 hw
  · have he : FactorialKernelDictionary.kernelRow 1 1 t =
        (1 - exp (-t)) ^ 2 * FactorialBinaryEnergy.weight t := by
      unfold FactorialKernelDictionary.kernelRow FactorialEntropyIntegral.numerator
      simp [pow_two]
    rw [he]
    exact mul_lt_mul_of_pos_right hh.2 hw

#print axioms scalarPhase_weighted_bounds
#print axioms scalarPhase_pos
#print axioms scalarPhase_lt_unit
#print axioms scalarPhase_strictMono
#print axioms scalarPhase_product_bounds
end BuildingBlocks.FactorialRealCellPhase
