import BuildingBlocks.FactorialResponseBilinear
import BuildingBlocks.FactorialPairedExamples

open MeasureTheory
namespace BuildingBlocks.FactorialBinaryCarry

private theorem log_4 : Real.log 4 = 2 * Real.log 2 := by
  rw [show (4 : ℝ) = 2^2 by norm_num, Real.log_pow]
  norm_num

private theorem log_6 : Real.log 6 = Real.log 2 + Real.log 3 := by
  rw [show (6 : ℝ) = 2 * 3 by norm_num, Real.log_mul (by norm_num) (by norm_num)]

private theorem log_10 : Real.log 10 = Real.log 2 + Real.log 5 := by
  rw [show (10 : ℝ) = 2 * 5 by norm_num, Real.log_mul (by norm_num) (by norm_num)]

private theorem log_12 : Real.log 12 = 2 * Real.log 2 + Real.log 3 := by
  rw [show (12 : ℝ) = 4 * 3 by norm_num, Real.log_mul (by norm_num) (by norm_num)]
  rw [log_4]

private theorem log_28 : Real.log 28 = 2 * Real.log 2 + Real.log 7 := by
  rw [show (28 : ℝ) = 4 * 7 by norm_num, Real.log_mul (by norm_num) (by norm_num)]
  rw [log_4]

private theorem log_84 : Real.log 84 = 2 * Real.log 2 + Real.log 3 + Real.log 7 := by
  rw [show (84 : ℝ) = 12 * 7 by norm_num, Real.log_mul (by norm_num) (by norm_num)]
  rw [log_12]

private theorem log_8 : Real.log 8 = 3 * Real.log 2 := by
  rw [show (8 : ℝ) = 2^3 by norm_num, Real.log_pow]
  norm_num

private theorem log_9 : Real.log 9 = 2 * Real.log 3 := by
  rw [show (9 : ℝ) = 3^2 by norm_num, Real.log_pow]
  norm_num

/-- Actual full compensated N=3 mixed clock work, with every signed quotient pair. -/
theorem paired_three_old_correlation_linear :
    (∫ t in Set.Ioi 0, response 3 (2 * t) * pairedPort 3 1 t * FactorialBinaryEnergy.weight t) =
      10 * Real.log 2 + 8 * Real.log 5 - 18 * Real.log 3 := by
  rw [actual_old_innovation_kernel]
  have hm := FactorialResponseCounterexample.moebius_thirteen_table
  norm_num [List.range_succ, List.map_cons] at hm
  rcases hm with ⟨h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, h12, h13⟩
  norm_num [Finset.sum_Icc_succ_top, h2, h3, h4, h5, h6, FactorialKernelDictionary.kernel, Nat.choose]
  simp only [log_4, log_6, log_8, log_9, log_10, log_12, log_28, log_84]
  ring

/-- Exact logarithmic value of the complete actual N=3 old-response correlation. -/
theorem paired_three_old_correlation :
    (∫ t in Set.Ioi 0, response 3 (2 * t) * pairedPort 3 1 t * FactorialBinaryEnergy.weight t) =
      Real.log (400000000 / 387420489 : ℝ) := by
  rw [paired_three_old_correlation_linear, Real.log_div (by norm_num) (by norm_num)]
  have hn : Real.log 400000000 = 10 * Real.log 2 + 8 * Real.log 5 := by
    rw [show (400000000 : ℝ) = 2^10 * 5^8 by norm_num]
    rw [Real.log_mul (by norm_num) (by norm_num), Real.log_pow, Real.log_pow]
    norm_num
  have hd : Real.log 387420489 = 18 * Real.log 3 := by
    rw [show (387420489 : ℝ) = 3^18 by norm_num, Real.log_pow]
    norm_num
  rw [hn, hd]

/-- Strict positivity refutes the selected old-response damping sign on actual arithmetic. -/
theorem paired_three_old_correlation_positive :
    0 < (∫ t in Set.Ioi 0, response 3 (2 * t) * pairedPort 3 1 t * FactorialBinaryEnergy.weight t) := by
  rw [paired_three_old_correlation]
  exact Real.log_pos (by norm_num)

theorem not_universal_old_response_damping :
    ¬ (∀ N : ℕ, 0 < N → (∫ t in Set.Ioi 0, response N (2 * t) * pairedPort N 1 t *
      FactorialBinaryEnergy.weight t) ≤ 0) := by
  intro h
  exact (not_le_of_gt paired_three_old_correlation_positive) (h 3 (by norm_num))

#print axioms paired_three_old_correlation_linear
#print axioms paired_three_old_correlation
#print axioms paired_three_old_correlation_positive
#print axioms not_universal_old_response_damping
end BuildingBlocks.FactorialBinaryCarry
