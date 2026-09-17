import Mathlib.Tactic

/-!
The algebraic core of the two-exponential-rate Weil plane. The analytic
identification of its entries with `ξ'/ξ` and the zero-packet expansion
remain written mathematics in the companion note. No hypothesis here
asserts a zero location or a Weil sign.
-/

namespace BuildingBlocks.TwoRateWeilGramAlgebra

private theorem packet_den_pos {a p q : ℝ} (ha : 0 < a) (hp : 0 < p) :
    0 < a ^ 4 + 2 * p * a ^ 2 + q ^ 2 := by
  have ha4 : 0 < a ^ 4 := pow_pos ha _
  have hmid : 0 ≤ 2 * p * a ^ 2 := by positivity
  have hq : 0 ≤ q ^ 2 := sq_nonneg q
  linarith

/-- The numerator of `(a * g)'` is positive for each admissible
conjugate/reflected zero packet. -/
theorem packet_a_mul_derivative_num_pos {a p q : ℝ}
    (ha : 0 < a) (hp : 0 < p) :
    0 < p * a ^ 4 + 2 * q ^ 2 * a ^ 2 + p * q ^ 2 := by
  have hfirst : 0 < p * a ^ 4 := mul_pos hp (pow_pos ha _)
  have hsecond : 0 ≤ 2 * q ^ 2 * a ^ 2 := by positivity
  have hthird : 0 ≤ p * q ^ 2 := by positivity
  linarith

/-- The numerator of `-(g / a)'` is positive when the zero packet
satisfies `q² ≤ 2p²`. -/
theorem packet_div_derivative_num_pos {a p q : ℝ}
    (ha : 0 < a) (hp : 0 < p) (hqp : q ^ 2 ≤ 2 * p ^ 2) :
    0 < a ^ 4 + 2 * p * a ^ 2 + 2 * p ^ 2 - q ^ 2 := by
  have ha4 : 0 < a ^ 4 := pow_pos ha _
  have hmid : 0 ≤ 2 * p * a ^ 2 := by positivity
  linarith

/-- Both rational derivative expressions in the written zero-packet
proof have strict signs. -/
theorem packet_derivative_fractions_pos {a p q : ℝ}
    (ha : 0 < a) (hp : 0 < p) (hqp : q ^ 2 ≤ 2 * p ^ 2) :
    0 < 4 * a * (p * a ^ 4 + 2 * q ^ 2 * a ^ 2 + p * q ^ 2) /
        (a ^ 4 + 2 * p * a ^ 2 + q ^ 2) ^ 2 ∧
    0 < 4 * a * (a ^ 4 + 2 * p * a ^ 2 + 2 * p ^ 2 - q ^ 2) /
        (a ^ 4 + 2 * p * a ^ 2 + q ^ 2) ^ 2 := by
  have hd := packet_den_pos ha hp (q := q)
  constructor
  · exact div_pos (mul_pos (by positivity : 0 < 4 * a)
        (packet_a_mul_derivative_num_pos ha hp)) (pow_pos hd _)
  · exact div_pos (mul_pos (by positivity : 0 < 4 * a)
        (packet_div_derivative_num_pos ha hp hqp)) (pow_pos hd _)

/-- Factorization of the two-rate Gram determinant numerator. -/
theorem gram_det_factor (a b A B : ℝ) :
    A * B * (a - b) ^ 2 - a * b * (A - B) ^ 2 =
      (b * A - a * B) * (b * B - a * A) := by
  ring

/-- The two opposite ratio bounds make the Gram determinant strict. -/
theorem gram_det_pos {a b A B : ℝ}
    (hdiv : a * B < b * A) (hmul : a * A < b * B) :
    0 < A * B * (a - b) ^ 2 - a * b * (A - B) ^ 2 := by
  rw [gram_det_factor]
  exact mul_pos (sub_pos.mpr hdiv) (sub_pos.mpr hmul)

end BuildingBlocks.TwoRateWeilGramAlgebra

#print axioms BuildingBlocks.TwoRateWeilGramAlgebra.packet_derivative_fractions_pos
#print axioms BuildingBlocks.TwoRateWeilGramAlgebra.gram_det_pos
