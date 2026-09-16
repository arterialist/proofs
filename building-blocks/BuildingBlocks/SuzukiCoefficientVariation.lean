import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Tactic
import BuildingBlocks.SelbergIdentity

/-!
# Finite variations of Suzuki's arithmetic coefficient

The divisor-sum form of Suzuki's coefficient has an exact first
variation at zero: twice the actual von Mangoldt function. The
second derivative is the full `4 (Λ * Λ)` convolution. Both
identifications use the finite Möbius divisor sum. The product formula,
completed gamma kernel, and analytic Hankel criterion remain written
statements.
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

private noncomputable def logDer (f : ArithmeticFunction ℝ) : ArithmeticFunction ℝ :=
  f.pmul ArithmeticFunction.log

private theorem logDer_mul (f g : ArithmeticFunction ℝ) :
    logDer (f * g) = logDer f * g + f * logDer g :=
  BuildingBlocks.log_weighted_convolution f g

private theorem logDer_add (f g : ArithmeticFunction ℝ) :
    logDer (f + g) = logDer f + logDer g := by
  ext n
  simp [logDer, ArithmeticFunction.add_apply, add_mul]

private theorem logDer_one : logDer (1 : ArithmeticFunction ℝ) = 0 := by
  ext n
  rcases eq_or_ne n 1 with rfl | hn
  · simp [logDer, ArithmeticFunction.log_apply]
  · simp [logDer, ArithmeticFunction.one_apply_ne hn]

private theorem logDer_zero : logDer (0 : ArithmeticFunction ℝ) = 0 := by
  ext n
  simp [logDer]

private theorem logDer_zeta :
    logDer (ArithmeticFunction.zeta : ArithmeticFunction ℝ) =
      ArithmeticFunction.log := by
  exact ArithmeticFunction.zeta_pmul ArithmeticFunction.log

private theorem logDer_mu_mul_zeta :
    logDer (ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
      ArithmeticFunction.zeta = -ArithmeticFunction.vonMangoldt := by
  have h := logDer_mul (ArithmeticFunction.moebius : ArithmeticFunction ℝ)
    ArithmeticFunction.zeta
  rw [ArithmeticFunction.coe_moebius_mul_coe_zeta,
    logDer_one, logDer_zeta] at h
  rw [ArithmeticFunction.moebius_mul_log_eq_vonMangoldt] at h
  -- The differentiated inverse relation has zero total.
  exact eq_neg_of_add_eq_zero_left h.symm

private theorem logDer_mu_mul_log :
    logDer (ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
      ArithmeticFunction.log =
        -(ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) := by
  rw [← ArithmeticFunction.zeta_mul_vonMangoldt, ← mul_assoc,
    logDer_mu_mul_zeta]
  ring

/-- The second-order algebra of the exact finite inverse, before
evaluating any divisor sum. -/
private theorem secondVariation_algebra :
    (ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
        logDer ArithmeticFunction.log -
      2 * (logDer (ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
        ArithmeticFunction.log) +
      logDer (logDer (ArithmeticFunction.moebius : ArithmeticFunction ℝ)) *
        ArithmeticFunction.zeta =
      4 * (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) := by
  let muAF : ArithmeticFunction ℝ := ArithmeticFunction.moebius
  let zetaAF : ArithmeticFunction ℝ := ArithmeticFunction.zeta
  let logAF : ArithmeticFunction ℝ := ArithmeticFunction.log
  have hunit : muAF * zetaAF = 1 := ArithmeticFunction.coe_moebius_mul_coe_zeta
  have htwice :
      logDer (logDer muAF) * zetaAF + 2 * (logDer muAF * logAF) +
        muAF * logDer logAF = 0 := by
    have h := congrArg logDer (congrArg logDer hunit)
    rw [logDer_mul, logDer_add, logDer_mul, logDer_mul,
      logDer_zeta, logDer_one, logDer_zero] at h
    -- Both product-rule cross terms are the same.
    linear_combination h
  have hcross : logDer muAF * logAF = -(ArithmeticFunction.vonMangoldt *
      ArithmeticFunction.vonMangoldt) := logDer_mu_mul_log
  change muAF * logDer logAF - 2 * (logDer muAF * logAF) +
      logDer (logDer muAF) * zetaAF = _
  rw [hcross] at htwice ⊢
  linear_combination htwice

#print axioms secondVariation_algebra

/-- Every multiplicative two-history, including repeated prime bases,
appears in the second parameter variation. -/
theorem coefficientCurvature_eq (n : ℕ) :
    coefficientCurvature n =
      4 * (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n := by
  let muAF : ArithmeticFunction ℝ := ArithmeticFunction.moebius
  let zetaAF : ArithmeticFunction ℝ := ArithmeticFunction.zeta
  let logAF : ArithmeticFunction ℝ := ArithmeticFunction.log
  have hA : (muAF * logDer logAF) n =
      ∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
        Real.log (n / d : ℕ) ^ 2 := by
    rw [ArithmeticFunction.mul_apply,
      Nat.sum_divisorsAntidiagonal
        (fun a b => muAF a * logDer logAF b)]
    simp only [muAF, logAF, logDer, ArithmeticFunction.intCoe_apply,
      ArithmeticFunction.pmul_apply, ArithmeticFunction.log_apply, pow_two]
  have hB : (logDer muAF * logAF) n =
      ∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
        Real.log d * Real.log (n / d : ℕ) := by
    rw [ArithmeticFunction.mul_apply,
      Nat.sum_divisorsAntidiagonal
        (fun a b => logDer muAF a * logAF b)]
    simp only [muAF, logAF, logDer, ArithmeticFunction.intCoe_apply,
      ArithmeticFunction.pmul_apply, ArithmeticFunction.log_apply]
  have hC : (logDer (logDer muAF) * zetaAF) n =
      ∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
        Real.log d ^ 2 := by
    rw [mul_comm (logDer (logDer muAF)) zetaAF,
      ArithmeticFunction.coe_zeta_mul_apply]
    simp only [muAF, logDer, ArithmeticFunction.intCoe_apply,
      ArithmeticFunction.pmul_apply, ArithmeticFunction.log_apply, pow_two]
    apply Finset.sum_congr rfl
    intro d hd
    ring
  have h := congrArg (fun f : ArithmeticFunction ℝ => f n) secondVariation_algebra
  change (muAF * logDer logAF - 2 * (logDer muAF * logAF) +
      logDer (logDer muAF) * zetaAF) n =
    (4 * (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt)) n at h
  have hfour (f : ArithmeticFunction ℝ) : (4 * f) n = 4 * f n := by
    have hf : (4 : ArithmeticFunction ℝ) = 1 + 1 + 1 + 1 := by norm_num
    rw [hf]
    simp only [add_mul, one_mul, ArithmeticFunction.add_apply]
    ring
  have hpoint : (muAF * logDer logAF) n -
      2 * (logDer muAF * logAF) n +
      (logDer (logDer muAF) * zetaAF) n =
        4 * (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n := by
    rw [two_mul] at h
    change (muAF * logDer logAF) n -
      ((logDer muAF * logAF) n + (logDer muAF * logAF) n) +
      (logDer (logDer muAF) * zetaAF) n =
        (4 * (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt)) n at h
    rw [hfour] at h
    convert h using 1; ring
  calc
    coefficientCurvature n =
        (∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
          Real.log (n / d : ℕ) ^ 2) -
        2 * (∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
          Real.log d * Real.log (n / d : ℕ)) +
        (∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
          Real.log d ^ 2) := by
      unfold coefficientCurvature
      rw [Finset.mul_sum, ← Finset.sum_sub_distrib, ← Finset.sum_add_distrib]
      apply Finset.sum_congr rfl
      intro d hd
      ring
    _ = _ := by rw [← hA, ← hB, ← hC]; exact hpoint

/-- Both actual parameter derivatives identify the complete multiplicative
prime-power pair row. -/
theorem coefficient_second_deriv_eq (n : ℕ) :
    deriv (deriv (coefficient n)) 0 =
      4 * (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n := by
  rw [coefficient_second_deriv_zero, coefficientCurvature_eq]

#print axioms coefficientCurvature_eq
#print axioms coefficient_second_deriv_eq

#print axioms coefficient_hasDerivAt_zero
#print axioms coefficient_second_deriv_zero

end BuildingBlocks.SuzukiCoefficientVariation
