import BuildingBlocks.FactorialRealCellCrossKernel

open Real Finset Set MeasureTheory Filter
open scoped BigOperators
namespace BuildingBlocks.FactorialRealCellPhase

noncomputable def actualFloorBudget (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, |(ArithmeticFunction.moebius n : ℝ)| * ((N / n : ℕ) : ℝ)

theorem actualFloorRow_measurable (N : ℕ) : Measurable (actualFloorRow N) := by
  unfold actualFloorRow
  apply Finset.measurable_sum
  intro n hn
  have hc : Measurable (fun q : ℕ => (q : ℝ)) := measurable_of_countable _
  have hf : Measurable (fun x : ℝ => ⌊((N / n : ℕ) : ℝ) / x⌋₊) :=
    (measurable_const.div measurable_id).nat_floor
  exact (hc.comp hf).const_mul _

theorem actualDiscrepancy_measurable (N : ℕ) : Measurable (actualDiscrepancy N) :=
  (actualFloorRow_measurable N).sub_const 1

theorem actualFloorRow_norm_le (N : ℕ) {x : ℝ} (hx : 1 ≤ x) :
    ‖actualFloorRow N x‖ ≤ actualFloorBudget N := by
  unfold actualFloorRow actualFloorBudget
  apply (norm_sum_le _ _).trans
  apply Finset.sum_le_sum
  intro n hn
  have hxp : 0 < x := by linarith
  have hq : (0 : ℝ) ≤ ((N / n : ℕ) : ℝ) := Nat.cast_nonneg _
  have hle : ((N / n : ℕ) : ℝ) / x ≤ ((N / n : ℕ) : ℝ) :=
    (div_le_iff₀ hxp).mpr (by nlinarith)
  have hf : ⌊((N / n : ℕ) : ℝ) / x⌋₊ ≤ N / n := by
    simpa only [Nat.floor_natCast] using Nat.floor_mono hle
  have hfr : (⌊((N / n : ℕ) : ℝ) / x⌋₊ : ℝ) ≤ ((N / n : ℕ) : ℝ) := by exact_mod_cast hf
  rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs,
    abs_of_nonneg (Nat.cast_nonneg (α := ℝ) ⌊((N / n : ℕ) : ℝ) / x⌋₊)]
  exact mul_le_mul_of_nonneg_left hfr (abs_nonneg _)

theorem actualDiscrepancy_norm_le (N : ℕ) {x : ℝ} (hx : 1 ≤ x) :
    ‖actualDiscrepancy N x‖ ≤ actualFloorBudget N + 1 := by
  unfold actualDiscrepancy
  calc
    _ ≤ ‖actualFloorRow N x‖ + ‖(1 : ℝ)‖ := norm_sub_le _ _
    _ ≤ actualFloorBudget N + 1 := by simpa using add_le_add_right (actualFloorRow_norm_le N hx) 1

theorem actualDiscrepancy_intervalIntegrable (N : ℕ) {X : ℝ} (hX : 1 ≤ X) :
    IntervalIntegrable (actualDiscrepancy N) volume 1 X := by
  apply (intervalIntegrable_const (c := actualFloorBudget N + 1)).mono_fun'
    (actualDiscrepancy_measurable N).aestronglyMeasurable
  filter_upwards [ae_restrict_mem measurableSet_uIoc] with x hx
  have hh : 1 < x ∧ x ≤ X := by simpa only [Set.uIoc_of_le hX, Set.mem_Ioc] using hx
  exact actualDiscrepancy_norm_le N hh.1.le

theorem actualDiscrepancy_square_intervalIntegrable (N : ℕ) {X : ℝ} (hX : 1 ≤ X) :
    IntervalIntegrable (fun x => actualDiscrepancy N x ^ 2) volume 1 X := by
  apply (intervalIntegrable_const (c := (actualFloorBudget N + 1) ^ 2)).mono_fun'
    ((actualDiscrepancy_measurable N).pow_const 2).aestronglyMeasurable
  filter_upwards [ae_restrict_mem measurableSet_uIoc] with x hx
  have hh : 1 < x ∧ x ≤ X := by simpa only [Set.uIoc_of_le hX, Set.mem_Ioc] using hx
  have hb := actualDiscrepancy_norm_le N hh.1.le
  have hs := mul_self_le_mul_self (norm_nonneg (actualDiscrepancy N x)) hb
  rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _)]
  simpa only [Real.norm_eq_abs, ← pow_two, sq_abs] using hs

theorem inverseTestPhase_joint_measurable :
    Measurable (fun p : ℝ × ℝ => inverseTestPhase p.1 p.2) := by
  have hm : Measurable (fun p : (ℝ × ℝ) × ℕ =>
      ∑ j ∈ Finset.Icc 1 p.2, (ArithmeticFunction.moebius j : ℝ) / j *
        scalarPhase (p.1.1 / j) p.1.2) := by
    apply measurable_from_prod_countable_left
    intro N
    change Measurable (fun p : ℝ × ℝ => ∑ j ∈ Finset.Icc 1 N,
      (ArithmeticFunction.moebius j : ℝ) / j * scalarPhase (p.1 / j) p.2)
    apply Finset.measurable_sum
    intro j hj
    unfold scalarPhase
    exact ((measurable_const.sub measurable_snd.neg.exp).sub
      (measurable_snd.mul (((measurable_fst.div_const (j : ℝ)).neg.mul measurable_snd).exp))).const_mul _
  have hp : Measurable (fun p : ℝ × ℝ => (p, ⌊p.1⌋₊)) :=
    measurable_id.prodMk ((Nat.measurable_floor (R := ℝ)).comp measurable_fst)
  simpa only [inverseTestPhase, Function.comp_def] using hm.comp hp

#print axioms inverseTestPhase_joint_measurable
#print axioms actualDiscrepancy_square_intervalIntegrable
#print axioms actualDiscrepancy_intervalIntegrable
#print axioms actualDiscrepancy_norm_le
#print axioms actualFloorRow_norm_le
#print axioms actualDiscrepancy_measurable
#print axioms actualFloorRow_measurable
end BuildingBlocks.FactorialRealCellPhase
