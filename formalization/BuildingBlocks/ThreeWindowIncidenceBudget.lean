import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.Data.Real.Sqrt

/-! Scalar budgets for the complete prime-two / power-four three-window graph.
The actual analytic Weil-form comparison is a separate written result. -/
namespace BuildingBlocks.ThreeWindowIncidenceBudget
noncomputable def w2 : ℝ := Real.log 2 / Real.sqrt 2
noncomputable def w4 : ℝ := Real.log 2 / 2

lemma weights_nonnegative : 0 ≤ w2 ∧ 0 ≤ w4 := by
  constructor <;> dsimp [w2, w4] <;> positivity

lemma w4_le_w2 : w4 ≤ w2 := by
  have hs : 0 < Real.sqrt (2 : ℝ) := Real.sqrt_pos.2 (by norm_num)
  have hs2 : Real.sqrt (2 : ℝ) ≤ 2 := by
    nlinarith [Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2)]
  exact div_le_div_of_nonneg_left (Real.log_nonneg (by norm_num)) hs hs2

lemma two_w2_lt_one : 2 * w2 < 1 := by
  have hs : 0 < Real.sqrt (2 : ℝ) := Real.sqrt_pos.2 (by norm_num)
  have hs14 : (1.4 : ℝ) < Real.sqrt 2 := by
    nlinarith [Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2)]
  dsimp [w2]
  rw [← mul_div_assoc, div_lt_one hs]
  linarith [Real.log_two_lt_d9]

lemma graph_budget (a b c : ℝ) :
    2 * w2 * (a*b + b*c) + 2 * w4 * a*c ≤
      2 * w2 * (a^2 + b^2 + c^2) := by
  have hu := weights_nonnegative.1
  have hv := weights_nonnegative.2
  have hab := mul_nonneg hu (sq_nonneg (a-b))
  have hbc := mul_nonneg hu (sq_nonneg (b-c))
  have hac := mul_nonneg hv (sq_nonneg (a-c))
  have hwa := mul_nonneg (sub_nonneg.2 w4_le_w2) (sq_nonneg a)
  have hwc := mul_nonneg (sub_nonneg.2 w4_le_w2) (sq_nonneg c)
  nlinarith

lemma complete_cross_budget {a b c K : ℝ} (hK : 0 ≤ K) :
    2*K*(a*b+b*c+a*c) ≤ 2*K*(a^2+b^2+c^2) := by
  have h1 := mul_nonneg hK (sq_nonneg (a-b))
  have h2 := mul_nonneg hK (sq_nonneg (b-c))
  have h3 := mul_nonneg hK (sq_nonneg (a-c))
  nlinarith

lemma carrier_arithmetic (L r : ℝ) (hr : r^2=2) (hr0 : r ≠ 0) :
    2*(L/r)*(1*(-(r+1/r)) + (-(r+1/r))*1) +
      2*(L/2)*(1*1) = -5*L := by
  field_simp [hr0]
  rw [hr]
  ring

lemma carrier_pole_polynomial {r : ℝ} (hr0 : r ≠ 0) :
    (1-(r+1/r)*r+r^2=0) ∧
    (1-(r+1/r)*(1/r)+(1/r)^2=0) := by
  constructor <;> field_simp [hr0] <;> ring

#print axioms carrier_pole_polynomial
#print axioms weights_nonnegative
#print axioms w4_le_w2
#print axioms two_w2_lt_one
#print axioms graph_budget
#print axioms complete_cross_budget
#print axioms carrier_arithmetic
end BuildingBlocks.ThreeWindowIncidenceBudget
