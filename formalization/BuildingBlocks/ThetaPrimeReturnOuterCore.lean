import Mathlib.Tactic

/-!
Elementary core of the effective full-Chebyshev prime-return tail.

The Stieltjes decomposition, Trudgian estimate, and bounded-variation bound
enter only through explicit hypotheses. This file proves their algebraic
consequences and the fixed integer comparisons.
-/

namespace BuildingBlocks.ThetaPrimeReturnOuterCore

open scoped BigOperators

/-- A main term plus a signed BV remainder, divided by a positive
normalization, gives the expected lower bound. -/
theorem primeReturn_lower_of_main_bv
    {primeReturn main remainder mainMass bv den : ℝ}
    (hden : 0 < den)
    (hdecomp : primeReturn = (main + remainder) / den)
    (hmain : main = mainMass)
    (hrem : -bv ≤ remainder) :
    (mainMass - bv) / den ≤ primeReturn := by
  rw [hdecomp, hmain]
  exact div_le_div_of_nonneg_right (by linarith) hden.le

/-- Coarsening the exact factor 1/(1+r). The nonnegative main mass and BV
budget are explicit hypotheses. -/
theorem normalized_return_coarse
    {mainMass bv r primeReturn : ℝ}
    (hmain : 0 ≤ mainMass) (hbv : 0 ≤ bv) (hr : 0 ≤ r)
    (hreturn : (mainMass - bv) / (1 + r) ≤ primeReturn) :
    mainMass - (mainMass * r + bv) ≤ primeReturn := by
  apply le_trans ?_ hreturn
  have hden : 0 < 1 + r := by linarith
  apply (le_div_iff₀ hden).2
  nlinarith [mul_nonneg hmain (sq_nonneg r), mul_nonneg hbv hr]

/-- The outer coercivity conclusion. Analytic work is isolated in hlower:
it is where the prime-return formula, continuous nonnegativity, and BV
remainder estimate enter. -/
theorem outer_coercivity
    {outer d d0 M m error : ℝ}
    (hM : 0 < M) (hd : d0 < d)
    (hm : m < d * M)
    (herror : error < d0 * M / 4)
    (hlower : d * M - m / 2 - error ≤ outer) :
    d * M / 4 < outer := by
  have hgap : d0 * M < d * M :=
    mul_lt_mul_of_pos_right hd hM
  nlinarith

theorem outer_coercivity_le
    {outer d d0 M m error : ℝ}
    (hM : 0 < M) (hd : d0 < d)
    (hm : m < d * M)
    (herror : error < d0 * M / 4)
    (hlower : d * M - m / 2 - error ≤ outer) :
    d * M / 4 ≤ outer :=
  (outer_coercivity hM hd hm herror hlower).le

/-- End-to-end algebraic form with the main mass and BV budget still named.
The two lower-bound hypotheses are the exact interfaces for the Stieltjes/BV
calculation and the nonnegative continuous part. -/
theorem outer_coercivity_from_main_bv
    {outer d d0 M m mainMass r bv : ℝ}
    (hM : 0 < M) (hd : d0 < d) (hm : m < d * M)
    (hmain : mainMass = (M - m) / 2)
    (herror : mainMass * r + bv < d0 * M / 4)
    (hlower : d * M - m / 2 - (mainMass * r + bv) ≤ outer) :
    d * M / 4 < outer := by
  subst mainMass
  exact outer_coercivity hM hd hm herror hlower

/-- The fixed outer endpoint from the written calculation. -/
def outerU : ℕ := 25820006

theorem outerU_exact : outerU = 25820006 := rfl

/-- Exact decimal reading of 6 + 6.455 * 2000^2. -/
theorem outerU_parameter_identity :
    (outerU : ℝ) = 6 + (6455 : ℝ) / 1000 * (2000 : ℝ) ^ 2 := by
  norm_num [outerU]

theorem sqrt_2000_lt_45 : Real.sqrt 2000 < 45 := by
  have hs := Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2000)
  have hs0 := Real.sqrt_nonneg (2000 : ℝ)
  nlinarith

theorem two_pow_ten_gt_thousand : (1000 : ℕ) < 2 ^ 10 := by norm_num

set_option exponentiation.threshold 3000 in
theorem integer_fortyfive_tail : 45 * 10 ^ 598 < 2 ^ 2000 := by norm_num

set_option maxRecDepth 10000

/-- Exact rational comparison behind 45 * 2^(-2000) < 10^(-598). -/
theorem fortyfive_two_pow_tail :
    (45 : ℝ) / 2 ^ 2000 < 1 / 10 ^ 598 := by
  set_option exponentiation.threshold 3000 in
    norm_num

set_option exponentiation.threshold 1000 in
theorem integer_coarse_gap : 8 * 10 ^ 546 < 10 ^ 593 := by norm_num

/-- The final coarse error is far below one quarter of d0=10^(-546). -/
theorem coarse_error_below_gap_quarter :
    (2 : ℝ) / 10 ^ 593 < (1 / 10 ^ 546) / 4 := by
  set_option exponentiation.threshold 1000 in
    norm_num

theorem thirty_thousand_lt_hundred_thousand :
    (30000 : ℕ) < 10 ^ 5 := by norm_num

/-- Multiplicative version of the fixed BV comparison. -/
theorem bv_scale_coarse {M : ℝ} (hM : 0 < M) :
    30000 * M < 10 ^ 5 * M :=
  mul_lt_mul_of_pos_right (by norm_num) hM

/-- Combining C_F < 10^5 M and epsilon < 10^(-598). -/
theorem bv_error_scale
    {C eps M : ℝ} (hM : 0 < M) (hC : C < 10 ^ 5 * M)
    (heps : 0 ≤ eps) (heps' : eps < 1 / 10 ^ 598) :
    C * eps < (1 / 10 ^ 593) * M := by
  have hscale : 0 < (10 : ℝ) ^ 5 * M := mul_pos (by positivity) hM
  have h1 : C * eps < (10 ^ 5 * M) * (1 / 10 ^ 598) := by
    calc
      C * eps ≤ (10 ^ 5 * M) * eps := mul_le_mul_of_nonneg_right hC.le heps
      _ < (10 ^ 5 * M) * (1 / 10 ^ 598) := mul_lt_mul_of_pos_left heps' hscale
  have hpow : (10 : ℝ) ^ 598 = 10 ^ 5 * 10 ^ 593 := by
    rw [← pow_add]
  calc
    C * eps < (10 ^ 5 * M) * (1 / 10 ^ 598) := h1
    _ = (1 / 10 ^ 593) * M := by
      rw [hpow]
      field_simp

#print axioms primeReturn_lower_of_main_bv
#print axioms normalized_return_coarse
#print axioms outer_coercivity
#print axioms outer_coercivity_le
#print axioms outer_coercivity_from_main_bv
#print axioms outerU_parameter_identity
#print axioms sqrt_2000_lt_45
#print axioms two_pow_ten_gt_thousand
#print axioms integer_fortyfive_tail
#print axioms fortyfive_two_pow_tail
#print axioms integer_coarse_gap
#print axioms coarse_error_below_gap_quarter
#print axioms thirty_thousand_lt_hundred_thousand
#print axioms bv_scale_coarse
#print axioms bv_error_scale

end BuildingBlocks.ThetaPrimeReturnOuterCore
