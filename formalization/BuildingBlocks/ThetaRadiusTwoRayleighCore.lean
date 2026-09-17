import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Tactic

namespace BuildingBlocks.ThetaRadiusTwoRayleighCore

open MeasureTheory
open scoped Interval

noncomputable section

/-- The polynomial integrand obtained after scaling the triangular bump
convolution to the unit interval. -/
def convolutionIntegrand (x y : ℝ) : ℝ :=
  30 * y * (1 - y) * (x - y) * (1 - (x - y))

/-- The exact piecewise polynomial in the radius-two certificate. -/
def H (x : ℝ) : ℝ :=
  if 0 ≤ x ∧ x ≤ 1 then
    x ^ 3 * (x ^ 2 - 5 * x + 5)
  else if 1 ≤ x ∧ x ≤ 2 then
    -(x - 2) ^ 3 * (x ^ 2 + x - 1)
  else 0

/-- On the first overlap piece, direct polynomial integration gives `H`. -/
theorem convolution_integral_left (x : ℝ) :
    (∫ y in (0 : ℝ)..x, convolutionIntegrand x y) =
      x ^ 3 * (x ^ 2 - 5 * x + 5) := by
  unfold convolutionIntegrand
  have heq : (fun y : ℝ => 30 * y * (1 - y) * (x - y) * (1 - (x - y))) =
      (fun y : ℝ =>
        30 * (x - x ^ 2) * y + 30 * (x ^ 2 + x - 1) * y ^ 2 -
          60 * x * y ^ 3 + 30 * y ^ 4) := by
    funext y
    ring
  rw [heq, intervalIntegral.integral_add,
    intervalIntegral.integral_sub, intervalIntegral.integral_add]
  · rw [intervalIntegral.integral_const_mul, intervalIntegral.integral_const_mul,
      intervalIntegral.integral_const_mul, intervalIntegral.integral_const_mul,
      integral_id, integral_pow, integral_pow, integral_pow]
    norm_num
    ring
  all_goals apply Continuous.intervalIntegrable; fun_prop

/-- On the second overlap piece, direct polynomial integration gives `H`. -/
theorem convolution_integral_right (x : ℝ) :
    (∫ y in (x - 1)..(1 : ℝ), convolutionIntegrand x y) =
      -(x - 2) ^ 3 * (x ^ 2 + x - 1) := by
  unfold convolutionIntegrand
  have heq : (fun y : ℝ => 30 * y * (1 - y) * (x - y) * (1 - (x - y))) =
      (fun y : ℝ =>
        30 * (x - x ^ 2) * y + 30 * (x ^ 2 + x - 1) * y ^ 2 -
          60 * x * y ^ 3 + 30 * y ^ 4) := by
    funext y
    ring
  rw [heq, intervalIntegral.integral_add,
    intervalIntegral.integral_sub, intervalIntegral.integral_add]
  · rw [intervalIntegral.integral_const_mul, intervalIntegral.integral_const_mul,
      intervalIntegral.integral_const_mul, intervalIntegral.integral_const_mul,
      integral_id, integral_pow, integral_pow, integral_pow]
    norm_num
    ring
  all_goals apply Continuous.intervalIntegrable; fun_prop

/-- Exact first branch of the piecewise convolution kernel. -/
theorem H_of_mem_left {x : ℝ} (hx0 : 0 ≤ x) (hx1 : x ≤ 1) :
    H x = ∫ y in (0 : ℝ)..x, convolutionIntegrand x y := by
  rw [H, if_pos ⟨hx0, hx1⟩, convolution_integral_left]

/-- Exact second branch of the piecewise convolution kernel. -/
theorem H_of_mem_right {x : ℝ} (hx1 : 1 ≤ x) (hx2 : x ≤ 2) :
    H x = ∫ y in (x - 1)..(1 : ℝ), convolutionIntegrand x y := by
  have hnleft : ¬(0 ≤ x ∧ x ≤ 1) ∨ x = 1 := by
    by_cases hx : x = 1
    · exact Or.inr hx
    · exact Or.inl (fun h => hx (le_antisymm h.2 hx1))
  rcases hnleft with hnleft | rfl
  · rw [H, if_neg hnleft, if_pos ⟨hx1, hx2⟩, convolution_integral_right]
  · rw [convolution_integral_right]
    norm_num [H]

/-- The exact rational energy payment in the certificate. -/
theorem rational_energy_payment :
    (2 : ℝ) * ((6 : ℝ) / 25 - 6859 / 25600) = -143 / 2560 := by
  norm_num

/-- Abstract strict Rayleigh implication used after the exact form has been
identified with `N / 2 + 2A - 2C - 2P`. -/
theorem rayleigh_gap
    {N J A C P E : ℝ}
    (hN : 0 < N) (hNJ : N ≤ 2 * J)
    (hA : A < 6 / 25) (hC : 0 ≤ C) (hP : 6859 / 25600 < P)
    (hE : E = N / 2 + 2 * A - 2 * C - 2 * P) :
    E / N < 1 / 2 - 143 / (5120 * J) := by
  have hJ : 0 < J := by nlinarith
  have henergy : E < N / 2 - 143 / 2560 := by
    rw [hE]
    norm_num at hA hP ⊢
    nlinarith
  have hpayment : N * (143 / (5120 * J)) ≤ 143 / 2560 := by
    have haux : 143 * N / 5120 ≤ (143 / 2560) * J := by
      nlinarith
    have hdiv := (div_le_iff₀ hJ).2 haux
    convert hdiv using 1 <;> ring
  apply (div_lt_iff₀ hN).2
  calc
    E < N / 2 - 143 / 2560 := henergy
    _ ≤ N / 2 - N * (143 / (5120 * J)) := by linarith
    _ = (1 / 2 - 143 / (5120 * J)) * N := by ring

#print axioms convolution_integral_left
#print axioms convolution_integral_right
#print axioms H_of_mem_left
#print axioms H_of_mem_right
#print axioms rational_energy_payment
#print axioms rayleigh_gap

end
end BuildingBlocks.ThetaRadiusTwoRayleighCore
