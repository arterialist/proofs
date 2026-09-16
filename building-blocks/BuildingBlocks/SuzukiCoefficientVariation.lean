import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Tactic

/-!
# First variation of Suzuki's arithmetic coefficient

The divisor-sum form of Suzuki's coefficient has an exact first
variation at zero: twice the actual von Mangoldt function. This
module proves the finite coefficient identity only. The product
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

#print axioms coefficient_hasDerivAt_zero

end BuildingBlocks.SuzukiCoefficientVariation
