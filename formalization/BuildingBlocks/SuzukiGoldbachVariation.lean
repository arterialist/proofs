import BuildingBlocks.SuzukiCoefficientVariation
import BuildingBlocks.GoldbachCumulativeFinite

/-!
# Additive pairs from Suzuki's arithmetic variation

The ordinary additive square of the *increment* of Suzuki's finite
coefficient has the actual ordered Goldbach convolution as its second
parameter variation. This is different from the multiplicative
`vonMangoldt * vonMangoldt` appearing in the second variation of one
coefficient. All statements are finite and retain indices zero and one.
-/

open Finset

namespace BuildingBlocks.SuzukiGoldbachVariation

open SuzukiCoefficientVariation GoldbachCumulativeFinite

/-- At zero parameter the only surviving multiplicative state is one. -/
theorem coefficient_zero (n : ℕ) :
    coefficient n 0 = if n = 1 then 1 else 0 := by
  have h := congrArg (fun f : ArithmeticFunction ℝ => f n)
    ArithmeticFunction.coe_moebius_mul_coe_zeta
  change ((ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
    ArithmeticFunction.zeta) n = (1 : ArithmeticFunction ℝ) n at h
  rw [ArithmeticFunction.coe_mul_zeta_apply] at h
  simpa [coefficient, ArithmeticFunction.intCoe_apply,
    ArithmeticFunction.one_apply] using h

/-- Subtract the coefficient's exact value at parameter zero. -/
noncomputable def increment (n : ℕ) (w : ℝ) : ℝ :=
  coefficient n w - coefficient n 0

@[simp] theorem increment_zero (n : ℕ) : increment n 0 = 0 := by
  simp [increment]

theorem increment_hasDerivAt (n : ℕ) (w : ℝ) :
    HasDerivAt (increment n) (coefficientSlope n w) w := by
  simpa only [increment] using (coefficient_hasDerivAt n w).sub_const (coefficient n 0)

theorem increment_slope_zero (n : ℕ) :
    coefficientSlope n 0 = 2 * ArithmeticFunction.vonMangoldt n := by
  have h := (increment_hasDerivAt n 0).deriv.symm
  change coefficientSlope n 0 =
    deriv (fun w => coefficient n w - coefficient n 0) 0 at h
  rw [deriv_sub_const] at h
  exact h.trans (coefficient_hasDerivAt_zero n).deriv

/-- Complete ordered additive pairs of the parameter increments. -/
noncomputable def additiveSquare (N : ℕ) (w : ℝ) : ℝ :=
  ∑ p ∈ antidiagonal N, increment p.1 w * increment p.2 w

private noncomputable def additiveSlope (N : ℕ) (w : ℝ) : ℝ :=
  ∑ p ∈ antidiagonal N,
    (coefficientSlope p.1 w * increment p.2 w +
      increment p.1 w * coefficientSlope p.2 w)

private theorem additiveSquare_hasDerivAt (N : ℕ) (w : ℝ) :
    HasDerivAt (additiveSquare N) (additiveSlope N w) w := by
  change HasDerivAt
    (fun x : ℝ => ∑ p ∈ antidiagonal N, increment p.1 x * increment p.2 x)
    (∑ p ∈ antidiagonal N,
      (coefficientSlope p.1 w * increment p.2 w +
        increment p.1 w * coefficientSlope p.2 w)) w
  apply HasDerivAt.fun_sum
  intro p hp
  exact (increment_hasDerivAt p.1 w).mul (increment_hasDerivAt p.2 w)

private theorem additiveSlope_hasDerivAt_zero (N : ℕ) :
    HasDerivAt (additiveSlope N)
      (∑ p ∈ antidiagonal N,
        2 * coefficientSlope p.1 0 * coefficientSlope p.2 0) 0 := by
  change HasDerivAt
    (fun x : ℝ => ∑ p ∈ antidiagonal N,
      (coefficientSlope p.1 x * increment p.2 x +
        increment p.1 x * coefficientSlope p.2 x))
    (∑ p ∈ antidiagonal N,
      2 * coefficientSlope p.1 0 * coefficientSlope p.2 0) 0
  apply HasDerivAt.fun_sum
  intro p hp
  convert ((coefficientSlope_hasDerivAt_zero p.1).mul
    (increment_hasDerivAt p.2 0)).add
    ((increment_hasDerivAt p.1 0).mul
      (coefficientSlope_hasDerivAt_zero p.2)) using 1
  simp [increment_zero]
  ring

/-- The second variation of an ordinary additive square is eight times
the actual ordered von Mangoldt Goldbach coefficient, including every
prime power. -/
theorem additiveSquare_second_deriv (N : ℕ) :
    deriv (deriv (additiveSquare N)) 0 = 8 * goldbachAt N := by
  have hfirst : deriv (additiveSquare N) = additiveSlope N := by
    funext w
    exact (additiveSquare_hasDerivAt N w).deriv
  rw [hfirst]
  rw [(additiveSlope_hasDerivAt_zero N).deriv]
  unfold goldbachAt
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro p hp
  rw [increment_slope_zero p.1, increment_slope_zero p.2]
  ring

#print axioms additiveSquare_second_deriv

end BuildingBlocks.SuzukiGoldbachVariation
