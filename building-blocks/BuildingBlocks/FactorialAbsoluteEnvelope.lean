import BuildingBlocks.FactorialOriginNeutralization

open Finset
namespace BuildingBlocks.FactorialAbsoluteEnvelope

/-- Every actual finite signed quotient history is retained before taking absolute values. -/
theorem response_abs_min_envelope (N : ℕ) (t : ℝ) (ht : 0 ≤ t) :
    |FactorialBinaryCarry.response N t| ≤
      ∑ n ∈ Icc 1 N, min ((N : ℝ) * t / n) 1 := by
  unfold FactorialBinaryCarry.response
  apply (abs_sum_le_sum_abs _ _).trans
  apply sum_le_sum
  intro n hn
  have he := FactorialBinaryIntegrability.exponential_increment_bounds
    ((N / n : ℕ) : ℝ) t (by positivity) ht
  have hm : |(ArithmeticFunction.moebius n : ℝ)| ≤ 1 := by
    exact_mod_cast (ArithmeticFunction.abs_moebius_le_one (n := n))
  rw [abs_mul, abs_of_nonneg he.1]
  have ha : |(ArithmeticFunction.moebius n : ℝ)| *
      (1 - Real.exp (-((N / n : ℕ) : ℝ) * t)) ≤ 1 - Real.exp (-((N / n : ℕ) : ℝ) * t) := by
    nlinarith
  apply ha.trans
  apply le_min
  · apply he.2.2.trans
    have h := mul_le_mul_of_nonneg_right (Nat.cast_div_le (m := N) (n := n) (α := ℝ)) ht
    simpa only [div_mul_eq_mul_div] using h
  · exact he.2.1

theorem response_abs_le_horizon (N : ℕ) (t : ℝ) (ht : 0 ≤ t) :
    |FactorialBinaryCarry.response N t| ≤ (N : ℝ) := by
  apply (response_abs_min_envelope N t ht).trans
  calc
    _ ≤ ∑ n ∈ Icc 1 N, (1 : ℝ) := sum_le_sum (fun n hn => min_le_right _ _)
    _ = _ := by simp

/-- Full compensated energy density; this tail envelope needs no cancellation estimate. -/
theorem energy_row_inverse_square (N : ℕ) (t : ℝ) (ht : 0 < t) :
    FactorialBinaryEnergy.energyRow N t ≤ (N : ℝ)^2 / t^2 := by
  have hr := response_abs_le_horizon N t ht.le
  have hr2 : (FactorialBinaryCarry.response N t)^2 ≤ (N : ℝ)^2 := by
    simpa only [sq_abs] using pow_le_pow_left₀ (abs_nonneg _) hr 2
  have hw := FactorialBinaryIntegrability.weight_le_inverse_square t ht
  unfold FactorialBinaryEnergy.energyRow
  have h := mul_le_mul_of_nonneg_left hw (sq_nonneg (FactorialBinaryCarry.response N t))
  apply h.trans
  simpa only [mul_one_div] using mul_le_mul_of_nonneg_right hr2 (by positivity : 0 ≤ 1 / t^2)

#print axioms response_abs_min_envelope
#print axioms response_abs_le_horizon
#print axioms energy_row_inverse_square
end BuildingBlocks.FactorialAbsoluteEnvelope
