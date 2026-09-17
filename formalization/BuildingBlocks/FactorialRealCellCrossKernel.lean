import BuildingBlocks.FactorialRealCellMajorant

open Real Finset Set MeasureTheory Filter
open scoped BigOperators
namespace BuildingBlocks.FactorialRealCellPhase

theorem phase_bilinear_row {ι κ : Type*} (s : Finset ι) (r : Finset κ)
    (c a : ι → ℝ) (d b : κ → ℝ) (t : ℝ) :
    (∑ i ∈ s, c i * scalarPhase (a i) t) * (∑ j ∈ r, d j * scalarPhase (b j) t) *
      FactorialBinaryEnergy.weight t =
      ∑ i ∈ s, ∑ j ∈ r, c i * d j * phaseRow (a i) (b j) t := by
  simp only [Finset.sum_mul, Finset.mul_sum]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro i hi
  apply Finset.sum_congr rfl
  intro j hj
  unfold phaseRow
  ring

theorem phase_bilinear_integrable {ι κ : Type*} (s : Finset ι) (r : Finset κ)
    (c a : ι → ℝ) (d b : κ → ℝ) (ha : ∀ i ∈ s, 1 ≤ a i) (hb : ∀ j ∈ r, 1 ≤ b j) :
    IntegrableOn (fun t => (∑ i ∈ s, c i * scalarPhase (a i) t) *
      (∑ j ∈ r, d j * scalarPhase (b j) t) * FactorialBinaryEnergy.weight t) (Ioi 0) := by
  have hi : ∀ i ∈ s, ∀ j ∈ r, IntegrableOn
      (fun t => c i * d j * phaseRow (a i) (b j) t) (Ioi 0) :=
    fun i hi j hj => (phaseRow_integrable (ha i hi) (hb j hj)).const_mul _
  apply (integrable_finset_sum s (fun i h => integrable_finset_sum r (fun j hj => hi i h j hj))).congr
  exact Eventually.of_forall (fun t => (phase_bilinear_row s r c a d b t).symm)

theorem phase_bilinear_integral {ι κ : Type*} (s : Finset ι) (r : Finset κ)
    (c a : ι → ℝ) (d b : κ → ℝ) (ha : ∀ i ∈ s, 1 ≤ a i) (hb : ∀ j ∈ r, 1 ≤ b j) :
    (∫ t in Ioi 0, (∑ i ∈ s, c i * scalarPhase (a i) t) *
      (∑ j ∈ r, d j * scalarPhase (b j) t) * FactorialBinaryEnergy.weight t) =
      ∑ i ∈ s, ∑ j ∈ r, c i * d j * phaseKernel (a i) (b j) := by
  simp_rw [phase_bilinear_row]
  have hi : ∀ i ∈ s, ∀ j ∈ r, IntegrableOn
      (fun t => c i * d j * phaseRow (a i) (b j) t) (Ioi 0) :=
    fun i hi j hj => (phaseRow_integrable (ha i hi) (hb j hj)).const_mul _
  rw [integral_finset_sum s (fun i h => integrable_finset_sum r (fun j hj => hi i h j hj))]
  apply Finset.sum_congr rfl
  intro i hi'
  rw [integral_finset_sum r (fun j hj => hi i hi' j hj)]
  apply Finset.sum_congr rfl
  intro j hj
  rw [integral_const_mul]
  rfl

noncomputable def actualCrossKernel (x y : ℝ) : ℝ :=
  ∑ j ∈ Finset.Icc 1 ⌊x⌋₊, ∑ l ∈ Finset.Icc 1 ⌊y⌋₊,
    ((ArithmeticFunction.moebius j : ℝ) / j) * ((ArithmeticFunction.moebius l : ℝ) / l) *
      phaseKernel (x / j) (y / l)

theorem real_quotient_ge_one {x : ℝ} (hx : 1 ≤ x) {j : ℕ} (hj : j ∈ Finset.Icc 1 ⌊x⌋₊) :
    1 ≤ x / j := by
  have hh := Finset.mem_Icc.mp hj
  have hp : (0 : ℝ) < j := by exact_mod_cast hh.1
  have hf : (j : ℝ) ≤ (⌊x⌋₊ : ℝ) := by exact_mod_cast hh.2
  exact (le_div_iff₀ hp).mpr (by simpa using hf.trans (Nat.floor_le (by linarith : 0 ≤ x)))

theorem inverseTestPhase_cross_integrable {x y : ℝ} (hx : 1 ≤ x) (hy : 1 ≤ y) :
    IntegrableOn (fun t => inverseTestPhase x t * inverseTestPhase y t * FactorialBinaryEnergy.weight t) (Ioi 0) := by
  exact phase_bilinear_integrable (Finset.Icc 1 ⌊x⌋₊) (Finset.Icc 1 ⌊y⌋₊)
    (fun j => (ArithmeticFunction.moebius j : ℝ) / j) (fun j => x / j)
    (fun l => (ArithmeticFunction.moebius l : ℝ) / l) (fun l => y / l)
    (fun _ hj => real_quotient_ge_one hx hj) (fun _ hl => real_quotient_ge_one hy hl)

/-- Full signed kernel identity with independent literal floor cutoffs. -/
theorem inverseTestPhase_cross_integral {x y : ℝ} (hx : 1 ≤ x) (hy : 1 ≤ y) :
    (∫ t in Ioi 0, inverseTestPhase x t * inverseTestPhase y t * FactorialBinaryEnergy.weight t) =
      actualCrossKernel x y := by
  exact phase_bilinear_integral (Finset.Icc 1 ⌊x⌋₊) (Finset.Icc 1 ⌊y⌋₊)
    (fun j => (ArithmeticFunction.moebius j : ℝ) / j) (fun j => x / j)
    (fun l => (ArithmeticFunction.moebius l : ℝ) / l) (fun l => y / l)
    (fun _ hj => real_quotient_ge_one hx hj) (fun _ hl => real_quotient_ge_one hy hl)

theorem actualCrossKernel_norm_le {x y : ℝ} (hx : 1 ≤ x) (hy : 1 ≤ y) :
    ‖actualCrossKernel x y‖ ≤ log 2 * inverseCoefficientBudget ⌊x⌋₊ * inverseCoefficientBudget ⌊y⌋₊ := by
  have hB : log 2 * inverseCoefficientBudget ⌊x⌋₊ * inverseCoefficientBudget ⌊y⌋₊ =
      ∑ j ∈ Finset.Icc 1 ⌊x⌋₊, ∑ l ∈ Finset.Icc 1 ⌊y⌋₊,
        |(ArithmeticFunction.moebius j : ℝ) / j| * |(ArithmeticFunction.moebius l : ℝ) / l| * log 2 := by
    unfold inverseCoefficientBudget
    simp only [Finset.sum_mul, Finset.mul_sum]
    rw [Finset.sum_comm]
    apply Finset.sum_congr rfl
    intro j hj
    apply Finset.sum_congr rfl
    intro l hl
    ring
  rw [hB]
  unfold actualCrossKernel
  apply (norm_sum_le _ _).trans
  apply Finset.sum_le_sum
  intro j hj
  apply (norm_sum_le _ _).trans
  apply Finset.sum_le_sum
  intro l hl
  have hp := phaseKernel_bounds (real_quotient_ge_one hx hj) (real_quotient_ge_one hy hl)
  simp only [norm_mul, Real.norm_eq_abs]
  rw [abs_of_nonneg hp.1]
  exact mul_le_mul_of_nonneg_left hp.2 (mul_nonneg (abs_nonneg _) (abs_nonneg _))

theorem actualCrossKernel_symm (x y : ℝ) : actualCrossKernel x y = actualCrossKernel y x := by
  unfold actualCrossKernel
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro l hl
  apply Finset.sum_congr rfl
  intro j hj
  rw [phaseKernel_symm]
  ring

#print axioms actualCrossKernel_symm
#print axioms actualCrossKernel_norm_le
#print axioms inverseTestPhase_cross_integral
#print axioms inverseTestPhase_cross_integrable
#print axioms real_quotient_ge_one
#print axioms phase_bilinear_integral
#print axioms phase_bilinear_integrable
#print axioms phase_bilinear_row
end BuildingBlocks.FactorialRealCellPhase
