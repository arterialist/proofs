import BuildingBlocks.FactorialPairedCovariance
import BuildingBlocks.FactorialResponseCounterexample

namespace BuildingBlocks.FactorialBinaryCarry

/-- Exact natural exponent conversion, preserving the actual real clock. -/
theorem response_exp_nat (q : ℕ) (t : ℝ) : Real.exp (-((q : ℝ) * t)) = Real.exp (-t)^q := by
  rw [show -((q : ℝ) * t) = (q : ℝ) * (-t) by ring, Real.exp_nat_mul]

theorem response_3_polynomial (t : ℝ) : response 3 t = -1 + 2 * Real.exp (-t) - Real.exp (-t)^3 := by
  have hm := FactorialResponseCounterexample.moebius_thirteen_table
  norm_num [List.range_succ, List.map_cons] at hm
  rcases hm with ⟨h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, h12, h13⟩
  unfold response
  norm_num [Finset.sum_Icc_succ_top, h2, h3, h4, h5, h6, h7, h8, h9, h10]
  have he3 := response_exp_nat 3 t
  norm_num at he3
  rw [he3]
  ring

theorem response_6_polynomial (t : ℝ) : response 6 t = -1 + Real.exp (-t)^2 + Real.exp (-t)^3 - Real.exp (-t)^6 := by
  have hm := FactorialResponseCounterexample.moebius_thirteen_table
  norm_num [List.range_succ, List.map_cons] at hm
  rcases hm with ⟨h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, h12, h13⟩
  unfold response
  norm_num [Finset.sum_Icc_succ_top, h2, h3, h4, h5, h6, h7, h8, h9, h10]
  have he2 := response_exp_nat 2 t
  norm_num at he2
  have he3 := response_exp_nat 3 t
  norm_num at he3
  have he6 := response_exp_nat 6 t
  norm_num at he6
  rw [he2, he3, he6]
  ring

theorem response_5_polynomial (t : ℝ) : response 5 t = -2 + 2 * Real.exp (-t) + Real.exp (-t)^2 - Real.exp (-t)^5 := by
  have hm := FactorialResponseCounterexample.moebius_thirteen_table
  norm_num [List.range_succ, List.map_cons] at hm
  rcases hm with ⟨h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, h12, h13⟩
  unfold response
  norm_num [Finset.sum_Icc_succ_top, h2, h3, h4, h5, h6, h7, h8, h9, h10]
  have he2 := response_exp_nat 2 t
  norm_num at he2
  have he5 := response_exp_nat 5 t
  norm_num at he5
  rw [he2, he5]
  ring

theorem response_10_polynomial (t : ℝ) : response 10 t = -1 - Real.exp (-t) + Real.exp (-t)^2 + Real.exp (-t)^3 + Real.exp (-t)^5 - Real.exp (-t)^10 := by
  have hm := FactorialResponseCounterexample.moebius_thirteen_table
  norm_num [List.range_succ, List.map_cons] at hm
  rcases hm with ⟨h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, h12, h13⟩
  unfold response
  norm_num [Finset.sum_Icc_succ_top, h2, h3, h4, h5, h6, h7, h8, h9, h10]
  have he2 := response_exp_nat 2 t
  norm_num at he2
  have he3 := response_exp_nat 3 t
  norm_num at he3
  have he5 := response_exp_nat 5 t
  norm_num at he5
  have he10 := response_exp_nat 10 t
  norm_num at he10
  rw [he2, he3, he5, he10]
  ring

/-- The complete actual N=3 innovation, including the cancellation of new admissions. -/
theorem paired_three_polynomial (t : ℝ) : pairedPort 3 1 t = Real.exp (-t)^3 - Real.exp (-t)^2 := by
  unfold pairedPort
  norm_num only [Nat.mul_div_cancel, Nat.div_one]
  rw [response_6_polynomial, response_3_polynomial]
  have he : Real.exp (-(2 * t)) = Real.exp (-t)^2 := by
    simpa using response_exp_nat 2 t
  rw [he]
  ring

/-- The complete actual N=5 innovation with its retained terminal value. -/
theorem paired_five_polynomial (t : ℝ) : pairedPort 5 1 t =
    1 - Real.exp (-t) - Real.exp (-t)^2 + Real.exp (-t)^3 - Real.exp (-t)^4 + Real.exp (-t)^5 := by
  unfold pairedPort
  norm_num only [Nat.mul_div_cancel, Nat.div_one]
  rw [response_10_polynomial, response_5_polynomial]
  have he : Real.exp (-(2 * t)) = Real.exp (-t)^2 := by
    simpa using response_exp_nat 2 t
  rw [he]
  ring

theorem paired_three_negative (t : ℝ) (ht : 0 < t) : pairedPort 3 1 t < 0 := by
  rw [paired_three_polynomial]
  have hz := Real.exp_pos (-t)
  have h1 : Real.exp (-t) < 1 := Real.exp_lt_one_iff.mpr (by linarith)
  have hp : 0 < Real.exp (-t)^2 := pow_pos hz 2
  nlinarith

theorem paired_five_log_two : pairedPort 5 1 (Real.log 2) = (11 : ℝ) / 32 := by
  rw [paired_five_polynomial]
  have he : Real.exp (-Real.log 2) = (1 / 2 : ℝ) := by
    rw [Real.exp_neg, Real.exp_log (by norm_num : (0 : ℝ) < 2)]
    norm_num
  rw [he]
  norm_num

#print axioms paired_three_negative
#print axioms paired_five_log_two
#print axioms response_exp_nat
#print axioms response_3_polynomial
#print axioms response_6_polynomial
#print axioms response_5_polynomial
#print axioms response_10_polynomial
#print axioms paired_three_polynomial
#print axioms paired_five_polynomial
end BuildingBlocks.FactorialBinaryCarry
