import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Tactic

/-!
# Finite variations of Suzuki's arithmetic coefficient

The divisor-sum form of Suzuki's coefficient has an exact first
variation at zero: twice the actual von Mangoldt function. The
second derivative is identified with a finite Möbius divisor sum.
Its identification with the full `Λ * Λ` convolution, the product
formula, completed gamma kernel, and analytic Hankel criterion are
separate written statements.
-/

open Finset
open scoped ArithmeticFunction

namespace BuildingBlocks.SuzukiCoefficientVariation

/-- Divisor-sum form of `n^ω ∏_{p∣n}(1-p^(-2ω))`. -/
noncomputable def coefficient (n : ℕ) (w : ℝ) : ℝ :=
  ∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
    Real.exp (w * (Real.log (n / d : ℕ) - Real.log d))

private theorem divisor_log_quotient (n : ℕ) :
    (∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
      Real.log (n / d : ℕ)) = ArithmeticFunction.vonMangoldt n := by
  have h := congrArg (fun f : ArithmeticFunction ℝ => f n)
    ArithmeticFunction.moebius_mul_log_eq_vonMangoldt
  simpa only [ArithmeticFunction.mul_apply, ArithmeticFunction.intCoe_apply,
    ArithmeticFunction.log_apply,
    Nat.sum_divisorsAntidiagonal (fun i j =>
      (ArithmeticFunction.moebius i : ℝ) * Real.log j)] using h

/-- The complete prime-power coefficient is the infinitesimal
    arrival rate of the positive Suzuki divisor family. -/
theorem coefficient_hasDerivAt_zero (n : ℕ) :
    HasDerivAt (coefficient n)
      (2 * ArithmeticFunction.vonMangoldt n) 0 := by
  have hsum : HasDerivAt (coefficient n)
      (∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
        (Real.log (n / d : ℕ) - Real.log d)) 0 := by
    change HasDerivAt
      (fun w : ℝ => ∑ d ∈ n.divisors,
        (ArithmeticFunction.moebius d : ℝ) *
          Real.exp (w * (Real.log (n / d : ℕ) - Real.log d)))
      (∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
        (Real.log (n / d : ℕ) - Real.log d)) 0
    apply HasDerivAt.fun_sum
    intro d hd
    convert (((hasDerivAt_id (0 : ℝ)).mul_const
      (Real.log (n / d : ℕ) - Real.log d)).exp).const_mul
        (ArithmeticFunction.moebius d : ℝ) using 1;
      simp [mul_comm]
  have hfirst := divisor_log_quotient n
  have hsecond :
      (∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) * Real.log d) =
        -ArithmeticFunction.vonMangoldt n := by
    simpa only [ArithmeticFunction.log_apply] using
      (ArithmeticFunction.sum_moebius_mul_log_eq (n := n))
  have hcoeff :
      (∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
        (Real.log (n / d : ℕ) - Real.log d)) =
        2 * ArithmeticFunction.vonMangoldt n := by
    calc
      (∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
          (Real.log (n / d : ℕ) - Real.log d)) =
        (∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
          Real.log (n / d : ℕ)) -
        (∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
          Real.log d) := by simp_rw [mul_sub]; rw [sum_sub_distrib]
      _ = 2 * ArithmeticFunction.vonMangoldt n := by rw [hfirst, hsecond]; ring
  simpa only [hcoeff] using hsum

/-- The literal finite slope before taking the first variation. -/
noncomputable def coefficientSlope (n : ℕ) (w : ℝ) : ℝ :=
  ∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
    ((Real.log (n / d : ℕ) - Real.log d) *
      Real.exp (w * (Real.log (n / d : ℕ) - Real.log d)))

/-- The finite second-variation coefficient, before its
    identification with the full `Λ * Λ` convolution. -/
noncomputable def coefficientCurvature (n : ℕ) : ℝ :=
  ∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
    (Real.log (n / d : ℕ) - Real.log d) ^ 2

theorem coefficient_hasDerivAt (n : ℕ) (w : ℝ) :
    HasDerivAt (coefficient n) (coefficientSlope n w) w := by
  change HasDerivAt
    (fun x : ℝ => ∑ d ∈ n.divisors,
      (ArithmeticFunction.moebius d : ℝ) *
        Real.exp (x * (Real.log (n / d : ℕ) - Real.log d)))
    (∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
      ((Real.log (n / d : ℕ) - Real.log d) *
        Real.exp (w * (Real.log (n / d : ℕ) - Real.log d)))) w
  apply HasDerivAt.fun_sum
  intro d hd
  convert (((hasDerivAt_id w).mul_const
    (Real.log (n / d : ℕ) - Real.log d)).exp).const_mul
      (ArithmeticFunction.moebius d : ℝ) using 1;
    simp [mul_comm]

theorem coefficientSlope_hasDerivAt_zero (n : ℕ) :
    HasDerivAt (coefficientSlope n) (coefficientCurvature n) 0 := by
  change HasDerivAt
    (fun w : ℝ => ∑ d ∈ n.divisors,
      (ArithmeticFunction.moebius d : ℝ) *
        ((Real.log (n / d : ℕ) - Real.log d) *
          Real.exp (w * (Real.log (n / d : ℕ) - Real.log d))))
    (∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
      (Real.log (n / d : ℕ) - Real.log d) ^ 2) 0
  apply HasDerivAt.fun_sum
  intro d hd
  have h := (((hasDerivAt_id (0 : ℝ)).mul_const
    (Real.log (n / d : ℕ) - Real.log d)).exp).const_mul
      ((ArithmeticFunction.moebius d : ℝ) *
        (Real.log (n / d : ℕ) - Real.log d))
  simpa [pow_two, mul_comm, mul_left_comm, mul_assoc] using h

theorem coefficient_second_deriv_zero (n : ℕ) :
    deriv (deriv (coefficient n)) 0 = coefficientCurvature n := by
  have hfirst : deriv (coefficient n) = coefficientSlope n := by
    funext w
    exact (coefficient_hasDerivAt n w).deriv
  rw [hfirst]
  exact (coefficientSlope_hasDerivAt_zero n).deriv

#print axioms coefficient_hasDerivAt_zero
#print axioms coefficient_second_deriv_zero

end BuildingBlocks.SuzukiCoefficientVariation
