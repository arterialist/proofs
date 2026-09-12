import BuildingBlocks.TiltedPrimeCumulative
import Mathlib.NumberTheory.AbelSummation
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic

open Finset Set MeasureTheory
open BuildingBlocks.MertensTransfer BuildingBlocks.CoarsePrimitive BuildingBlocks.FloorCorrection BuildingBlocks.HyperbolaProduct
open scoped BigOperators Interval

namespace BuildingBlocks
namespace TiltedPrimeIntegral

/-- The actual all-prime-power integrand on an arbitrary real finite interval. -/
theorem psi_div_sq_intervalIntegrable {x : ℝ} (hx : 1 ≤ x) :
    IntervalIntegrable (fun t : ℝ => psi ⌊t⌋₊ / t ^ 2) volume 1 x := by
  rw [intervalIntegrable_iff_integrableOn_Icc_of_le hx]
  simp_rw [psi_eq_sum_Icc, div_eq_mul_inv, mul_comm]
  apply integrableOn_mul_sum_Icc ArithmeticFunction.vonMangoldt zero_le_one
  apply ContinuousOn.integrableOn_Icc
  exact (continuousOn_id.pow 2).inv₀
    (fun t ht => pow_ne_zero 2 (by change t ≠ 0; linarith [ht.1]))

/-- Abel summation at a real endpoint; every von Mangoldt term is retained. -/
theorem psi_div_sq_integral {x : ℝ} (hx : 1 ≤ x) :
    (∫ t : ℝ in (1 : ℝ)..x, psi ⌊t⌋₊ / t ^ 2) =
      logarithmicPrimeMass ⌊x⌋₊ - psi ⌊x⌋₊ / x := by
  have hdi : IntegrableOn (deriv (fun t : ℝ => t⁻¹)) (Icc 1 x) := by
    simp only [deriv_inv']
    apply ContinuousOn.integrableOn_Icc
    exact ((continuousOn_id.pow 2).inv₀
      (fun t ht => pow_ne_zero 2 (by change t ≠ 0; linarith [ht.1]))).neg
  have hh := sum_mul_eq_sub_integral_mul₀ ArithmeticFunction.vonMangoldt (by simp) x
    (fun t ht => (hasDerivAt_inv (by linarith [ht.1] : t ≠ 0)).differentiableAt) hdi
  have hs : ∀ M : ℕ, (∑ n ∈ Finset.Icc 0 M, ArithmeticFunction.vonMangoldt n) = psi M := by
    intro M
    have hi : Finset.Icc 0 M = Finset.range (M + 1) := by ext n; simp; omega
    rw [hi, psi]
  simp only [hs] at hh
  rw [Finset.Icc_eq_cons_Ioc (Nat.zero_le ⌊x⌋₊), Finset.sum_cons] at hh
  simp only [Nat.cast_zero, ArithmeticFunction.map_zero, mul_zero, zero_add,
    ← Finset.Icc_add_one_left_eq_Ioc] at hh
  have hsum : (∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
      (n : ℝ)⁻¹ * ArithmeticFunction.vonMangoldt n) = logarithmicPrimeMass ⌊x⌋₊ := by
    simp [logarithmicPrimeMass, div_eq_mul_inv, mul_comm]
  rw [hsum] at hh
  rw [setIntegral_congr_fun measurableSet_Ioc
    (g := fun t : ℝ => -(psi ⌊t⌋₊ / t ^ 2)) (fun t _ => by
      simp only [deriv_inv]
      ring), integral_neg] at hh
  rw [intervalIntegral.integral_of_le hx]
  simp only [sub_neg_eq_add] at hh
  rw [div_eq_mul_inv, mul_comm (psi ⌊x⌋₊)]
  linarith

/-- The literal prime-error integrand is integrable on every finite
real interval used below, including intervals containing prime-power jumps. -/
theorem prime_error_intervalIntegrable {x : ℝ} (hx : 1 ≤ x) :
    IntervalIntegrable (fun t : ℝ => (psi ⌊t⌋₊ - t) / t ^ 2) volume 1 x := by
  have hinv : IntervalIntegrable (fun t : ℝ => t⁻¹) volume 1 x := by
    apply ContinuousOn.intervalIntegrable
    rw [uIcc_of_le hx]
    exact continuousOn_id.inv₀ (fun t ht => by change t ≠ 0; linarith [ht.1])
  apply ((psi_div_sq_intervalIntegrable hx).sub hinv).congr
  intro t ht
  have ht0 : t ≠ 0 := by
    rw [uIoc_of_le hx] at ht
    linarith [ht.1]
  field_simp

/-- The literal finite prime-error integral equals the closed cumulative
used in the signed W comparison; there is no PNT or RH hypothesis. -/
theorem prime_error_integral_eq {x : ℝ} (hx : 1 ≤ x) :
    (∫ t : ℝ in (1 : ℝ)..x, (psi ⌊t⌋₊ - t) / t ^ 2) =
      logarithmicPrimeMass ⌊x⌋₊ - psi ⌊x⌋₊ / x - Real.log x := by
  have hinv : IntervalIntegrable (fun t : ℝ => t⁻¹) volume 1 x := by
    apply ContinuousOn.intervalIntegrable
    rw [uIcc_of_le hx]
    exact continuousOn_id.inv₀ (fun t ht => by change t ≠ 0; linarith [ht.1])
  have heq : (∫ t : ℝ in (1 : ℝ)..x, (psi ⌊t⌋₊ - t) / t ^ 2) =
      ∫ t : ℝ in (1 : ℝ)..x, psi ⌊t⌋₊ / t ^ 2 - t⁻¹ := by
    apply intervalIntegral.integral_congr
    intro t ht
    have ht0 : t ≠ 0 := by
      rw [uIcc_of_le hx] at ht
      linarith [ht.1]
    field_simp
  rw [heq, intervalIntegral.integral_sub (psi_div_sq_intervalIntegrable hx) hinv,
    psi_div_sq_integral hx, integral_inv_of_pos zero_lt_one (by linarith), div_one]

/-- The actual prime-error integral is strictly negative at every real
cutoff greater than one. This is a first-moment sign, not an RH bound. -/
theorem prime_error_integral_neg {x : ℝ} (hx : 1 < x) :
    (∫ t : ℝ in (1 : ℝ)..x, (psi ⌊t⌋₊ - t) / t ^ 2) < 0 := by
  rw [prime_error_integral_eq hx.le]
  exact TiltedPrimeCumulative.cumulative_neg hx

/-- The exact signed integral has a uniform negative bound past two. -/
theorem prime_error_integral_le_neg_log_two_half {x : ℝ} (hx : 2 ≤ x) :
    (∫ t : ℝ in (1 : ℝ)..x, (psi ⌊t⌋₊ - t) / t ^ 2) ≤ -Real.log 2 / 2 := by
  rw [prime_error_integral_eq (by linarith)]
  exact TiltedPrimeCumulative.cumulative_le_neg_log_two_half hx

#print axioms prime_error_integral_eq
#print axioms prime_error_intervalIntegrable
#print axioms prime_error_integral_neg
#print axioms prime_error_integral_le_neg_log_two_half

end TiltedPrimeIntegral
end BuildingBlocks
