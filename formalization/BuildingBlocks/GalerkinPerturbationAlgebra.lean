import Mathlib.Tactic

namespace BuildingBlocks.GalerkinPerturbationAlgebra

/-- Scalar resolvent bound after analytic coercivity has supplied m ≤ a. -/
theorem reciprocal_le_of_coercive
    {a m : ℝ} (hm : 0 < m) (ha : m ≤ a) :
    1 / a ≤ 1 / m := by
  exact one_div_le_one_div_of_le hm ha

/-- Scalar model of the resolvent identity estimate.
The operator norm and coercivity statements remain analytic hypotheses. -/
theorem reciprocal_perturbation_bound
    {a ah m δ : ℝ}
    (hm : 0 < m) (hδ0 : 0 ≤ δ) (hδm : δ < m)
    (ha : m - δ ≤ a) (hah : m ≤ ah)
    (hdiff : |a - ah| ≤ δ) :
    |1 / a - 1 / ah| ≤ δ / (m * (m - δ)) := by
  have hmd : 0 < m - δ := sub_pos.mpr hδm
  have ha0 : 0 < a := lt_of_lt_of_le hmd ha
  have hah0 : 0 < ah := lt_of_lt_of_le hm hah
  rw [one_div, one_div, inv_sub_inv ha0.ne' hah0.ne']
  rw [abs_div, abs_mul, abs_of_pos ha0, abs_of_pos hah0]
  have hden : m * (m - δ) ≤ ah * a := by
    nlinarith
  have hden0 : 0 < m * (m - δ) := mul_pos hm hmd
  have haa0 : 0 < ah * a := mul_pos hah0 ha0
  have hrecip : 1 / (ah * a) ≤ 1 / (m * (m - δ)) :=
    one_div_le_one_div_of_le hden0 hden
  have habs : |ah - a| ≤ δ := by
    simpa [abs_sub_comm] using hdiff
  calc
    |ah - a| / (a * ah) = |ah - a| / (ah * a) := by rw [mul_comm]
    _ ≤ δ / (ah * a) := by
      exact div_le_div_of_nonneg_right habs haa0.le
    _ ≤ δ / (m * (m - δ)) := by
      exact mul_le_mul_of_nonneg_left (by simpa [one_div] using hrecip) hδ0

/-- Lower bound for a symmetric two-by-two determinant from outward entry
bounds. -/
theorem two_by_two_det_lower
    {acc acp app lcc lpp ucp : ℝ}
    (hlcc : 0 ≤ lcc) (hlpp : 0 ≤ lpp)
    (hacc : lcc ≤ acc) (happ : lpp ≤ app)
    (hacp : |acp| ≤ ucp) :
    lcc * lpp - ucp ^ 2 ≤ acc * app - acp ^ 2 := by
  have hacc0 : 0 ≤ acc := le_trans hlcc hacc
  have hprod : lcc * lpp ≤ acc * app :=
    mul_le_mul hacc happ hlpp hacc0
  have hsq : acp ^ 2 ≤ ucp ^ 2 := by
    have hu : 0 ≤ ucp := le_trans (abs_nonneg acp) hacp
    exact (sq_le_sq).2 (by simpa [abs_of_nonneg hu] using hacp)
  linarith

/-- A positive interval determinant lower endpoint proves invertibility. -/
theorem two_by_two_det_pos
    {acc acp app lcc lpp ucp : ℝ}
    (hlcc : 0 ≤ lcc) (hlpp : 0 ≤ lpp)
    (hacc : lcc ≤ acc) (happ : lpp ≤ app)
    (hacp : |acp| ≤ ucp)
    (hdet : 0 < lcc * lpp - ucp ^ 2) :
    0 < acc * app - acp ^ 2 := by
  exact lt_of_lt_of_le hdet
    (two_by_two_det_lower hlcc hlpp hacc happ hacp)

/-- Absolute numerator enclosure for the prime Woodbury coefficient. -/
theorem etaNumerator_abs_bound
    {acc acp bc bp Ucc Ucp Ubc Ubp : ℝ}
    (hacc : |acc| ≤ Ucc) (hacp : |acp| ≤ Ucp)
    (hbc : |bc| ≤ Ubc) (hbp : |bp| ≤ Ubp)
    (hUcc : 0 ≤ Ucc) (hUcp : 0 ≤ Ucp)
    :
    |acc * bp - acp * bc| ≤ Ucc * Ubp + Ucp * Ubc := by
  calc
    |acc * bp - acp * bc| ≤ |acc * bp| + |acp * bc| := abs_sub _ _
    _ = |acc| * |bp| + |acp| * |bc| := by rw [abs_mul, abs_mul]
    _ ≤ Ucc * Ubp + Ucp * Ubc := by
      gcongr

/-- Quotient bound once a denominator lower endpoint is positive. -/
theorem quotient_abs_bound
    {num den N d0 : ℝ}
    (hnum : |num| ≤ N) (hden : d0 ≤ den)
    (hd0 : 0 < d0) (hN : 0 ≤ N) :
    |num / den| ≤ N / d0 := by
  have hden0 : 0 < den := lt_of_lt_of_le hd0 hden
  rw [abs_div, abs_of_pos hden0]
  have hrecip : 1 / den ≤ 1 / d0 :=
    one_div_le_one_div_of_le hd0 hden
  rw [div_eq_mul_inv, div_eq_mul_inv]
  exact mul_le_mul hnum (by simpa [one_div] using hrecip) (by positivity) hN

/-- Quotient bound for the score coefficient. -/
theorem scoreCoefficient_abs_bound
    {j Dy Uj D0 : ℝ}
    (hj : |j| ≤ Uj) (hD : D0 ≤ Dy)
    (hD0 : 0 < D0) (hUj : 0 ≤ Uj) :
    |j / Dy| ≤ Uj / D0 :=
  quotient_abs_bound hj hD hD0 hUj

/-- Sum of lower endpoints for the score denominator. -/
theorem scoreDenominator_lower
    {dy hy ldy lhy : ℝ}
    (hdy : ldy ≤ dy) (hhy : lhy ≤ hy) :
    ldy + lhy ≤ dy + hy := by
  linarith

/-- Final interval assembly for one inverse Gram entry. -/
theorem gramEntry_error_assemble
    {G Gh e : ℝ} (h : |G - Gh| ≤ e) :
    Gh - e ≤ G ∧ G ≤ Gh + e := by
  constructor <;> linarith [le_abs_self (G - Gh), neg_abs_le (G - Gh)]

#print axioms reciprocal_le_of_coercive
#print axioms reciprocal_perturbation_bound
#print axioms two_by_two_det_lower
#print axioms two_by_two_det_pos
#print axioms etaNumerator_abs_bound
#print axioms quotient_abs_bound
#print axioms scoreCoefficient_abs_bound
#print axioms scoreDenominator_lower
#print axioms gramEntry_error_assemble

end BuildingBlocks.GalerkinPerturbationAlgebra
