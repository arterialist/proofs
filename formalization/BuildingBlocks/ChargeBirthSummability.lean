import BuildingBlocks.ChargeArcsinBound
import BuildingBlocks.IntegerBirthDiscreteCorrection

namespace BuildingBlocks.ChargeBirthSummability

open IntegerBirthKernel IntegerBirthSourceBound IntegerBirthDiscreteCorrection

noncomputable def correction (y : ℝ) : ℝ := Real.arcsin (1 / Real.sqrt y) - 1 / Real.sqrt y

theorem correction_bounds {y : ℝ} (hy : 2 ≤ y) :
    0 ≤ correction y ∧ correction y ≤ 1 / (3 * y * Real.sqrt y) := by
  have hy0 : 0 < y := by linarith
  have hs : 0 < Real.sqrt y := Real.sqrt_pos.mpr hy0
  have hz2 : (1 / Real.sqrt y) ^ 2 = 1 / y := by
    rw [div_pow, Real.sq_sqrt hy0.le]
    simp
  have hzbound : (1 / Real.sqrt y) ^ 2 ≤ 1 / 2 := by
    rw [hz2]
    exact one_div_le_one_div_of_le (by norm_num) hy
  have hh := ChargeArcsinBound.arcsin_sub_bounds (by positivity : 0 ≤ 1 / Real.sqrt y) hzbound
  have he : (1 / Real.sqrt y) ^ 3 / 3 = 1 / (3 * y * Real.sqrt y) := by
    rw [pow_succ, hz2]
    ring
  exact ⟨hh.1, hh.2.trans_eq he⟩

/-- The sharp correction is the literal initial successor birth coefficient. -/
theorem correction_eq_discrete_difference {n : ℕ} (hn : 2 ≤ n) :
    correction n = discreteBirth n 1 - discreteBirth n 0 := by
  rw [discreteBirth_eq_prebirth hn (by omega : 1 < n),
    discreteBirth_eq_prebirth hn (by omega : 0 < n)]
  norm_num only [Nat.cast_one, Nat.cast_zero]
  rw [q_zero]
  have hn0 : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have he : Real.sqrt (1 / (n : ℝ)) = 1 / Real.sqrt n := by
    rw [Real.sqrt_div (by norm_num : (0 : ℝ) ≤ 1), Real.sqrt_one]
  simp only [q, one_ne_zero, if_false, if_pos (by exact_mod_cast (show 1 ≤ n by omega) : (1 : ℝ) ≤ n),
    Real.sqrt_one, div_one, he, correction]

/-- Every actual prime power has an absolutely summable initial charge correction. -/
theorem weighted_correction_norm_summable :
    Summable (fun n : ℕ => ‖ArithmeticFunction.vonMangoldt (n + 2) * correction ((n + 2 : ℕ) : ℝ)‖) := by
  have hh := summable_birthWeight.mul_left (1 / 3 : ℝ)
  apply hh.of_nonneg_of_le (fun _ => norm_nonneg _)
  intro n
  have hn : (2 : ℝ) ≤ (n + 2 : ℕ) := by exact_mod_cast (show 2 ≤ n + 2 by omega)
  rw [Real.norm_eq_abs, abs_of_nonneg (mul_nonneg (ArithmeticFunction.vonMangoldt_nonneg (n := n + 2)) (correction_bounds hn).1)]
  have hb := mul_le_mul_of_nonneg_left (correction_bounds hn).2
    (ArithmeticFunction.vonMangoldt_nonneg (n := n + 2))
  convert hb using 1
  unfold birthWeight
  ring

theorem weighted_discrete_difference_norm_summable :
    Summable (fun n : ℕ => ‖ArithmeticFunction.vonMangoldt (n + 2) *
      (discreteBirth (n + 2) 1 - discreteBirth (n + 2) 0)‖) := by
  apply weighted_correction_norm_summable.congr
  intro n
  rw [correction_eq_discrete_difference (by omega : 2 ≤ n + 2)]

#print axioms correction_bounds
#print axioms correction_eq_discrete_difference
#print axioms weighted_correction_norm_summable
#print axioms weighted_discrete_difference_norm_summable

end BuildingBlocks.ChargeBirthSummability
