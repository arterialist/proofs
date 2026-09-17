import BuildingBlocks.FactorialRealCellKernel

open Real Set MeasureTheory Finset
open scoped BigOperators
namespace BuildingBlocks.FactorialRealCellPhase

theorem phase_quadratic_row {ι : Type*} (s : Finset ι) (c a : ι → ℝ) (t : ℝ) :
    (∑ i ∈ s, c i * scalarPhase (a i) t) ^ 2 * FactorialBinaryEnergy.weight t =
      ∑ i ∈ s, ∑ j ∈ s, c i * c j * phaseRow (a i) (a j) t := by
  simp only [pow_two, sum_mul, mul_sum]
  apply sum_congr rfl
  intro i hi
  apply sum_congr rfl
  intro j hj
  unfold phaseRow
  ring

theorem phase_quadratic_integral {ι : Type*} (s : Finset ι) (c a : ι → ℝ)
    (ha : ∀ i ∈ s, 1 ≤ a i) :
    (∫ t in Ioi 0, (∑ i ∈ s, c i * scalarPhase (a i) t) ^ 2 * FactorialBinaryEnergy.weight t) =
      ∑ i ∈ s, ∑ j ∈ s, c i * c j * phaseKernel (a i) (a j) := by
  simp_rw [phase_quadratic_row]
  have hi : ∀ i ∈ s, ∀ j ∈ s, IntegrableOn
      (fun t => c i * c j * phaseRow (a i) (a j) t) (Ioi 0) :=
    fun i hi j hj => (phaseRow_integrable (ha i hi) (ha j hj)).const_mul _
  rw [integral_finset_sum s (fun i h => integrable_finset_sum s (fun j hj => hi i h j hj))]
  apply sum_congr rfl
  intro i h
  rw [integral_finset_sum s (fun j hj => hi i h j hj)]
  apply sum_congr rfl
  intro j hj
  rw [integral_const_mul]
  rfl

theorem phase_quadratic_nonneg {ι : Type*} (s : Finset ι) (c a : ι → ℝ)
    (ha : ∀ i ∈ s, 1 ≤ a i) :
    0 ≤ ∑ i ∈ s, ∑ j ∈ s, c i * c j * phaseKernel (a i) (a j) := by
  rw [← phase_quadratic_integral s c a ha]
  apply integral_nonneg_of_ae
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  exact mul_nonneg (sq_nonneg _) (FactorialBinaryEnergy.weight_pos t ht).le

noncomputable def inverseTestPhase (x t : ℝ) : ℝ :=
  ∑ j ∈ Icc 1 ⌊x⌋₊, (ArithmeticFunction.moebius j : ℝ) / j * scalarPhase (x / j) t

theorem inverseTestPhase_energy {x : ℝ} (hx : 1 ≤ x) :
    (∫ t in Set.Ioi 0, inverseTestPhase x t ^ 2 * FactorialBinaryEnergy.weight t) =
      ∑ i ∈ Icc 1 ⌊x⌋₊, ∑ j ∈ Icc 1 ⌊x⌋₊,
        ((ArithmeticFunction.moebius i : ℝ) / i) * ((ArithmeticFunction.moebius j : ℝ) / j) *
          phaseKernel (x / i) (x / j) := by
  unfold inverseTestPhase
  apply phase_quadratic_integral
  intro j hj
  have hmem := mem_Icc.mp hj
  have hp : 0 < (j : ℝ) := by exact_mod_cast (by omega : 0 < j)
  apply (le_div_iff₀ hp).mpr
  have hjx : (j : ℝ) ≤ (⌊x⌋₊ : ℝ) := by exact_mod_cast hmem.2
  simpa only [one_mul] using hjx.trans (Nat.floor_le (by linarith : 0 ≤ x))

#print axioms inverseTestPhase_energy
#print axioms phase_quadratic_row
#print axioms phase_quadratic_integral
#print axioms phase_quadratic_nonneg
end BuildingBlocks.FactorialRealCellPhase
