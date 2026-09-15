import BuildingBlocks.FactorialQuotientConstraints
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.Calculus.Deriv.Slope

open Finset Filter
open scoped BigOperators Topology
open BuildingBlocks.FactorialBinaryCarry

namespace BuildingBlocks.FactorialResponseDerivative

theorem response_zero (N : ℕ) : response N 0 = 0 := by
  simp [response]

/-- Differentiate every actual coefficient without altering natural division. -/
theorem response_hasDerivAt (N : ℕ) (t : ℝ) :
    HasDerivAt (response N)
      (∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
        ((N / n : ℕ) : ℝ) * Real.exp (-((N / n : ℕ) : ℝ) * t)) t := by
  unfold response
  apply HasDerivAt.fun_sum
  intro n _
  have he := ((hasDerivAt_id t).const_mul (-((N / n : ℕ) : ℝ))).exp
  have h := (he.const_sub 1).const_mul (ArithmeticFunction.moebius n : ℝ)
  dsimp only [id] at h
  convert h using 1
  ring

/-- The initial slope is exactly one at every positive cutoff. -/
theorem response_hasDerivAt_zero (N : ℕ) (hN : 0 < N) :
    HasDerivAt (response N) 1 0 := by
  have h := response_hasDerivAt N 0
  have hm : (∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
      ((N / n : ℕ) : ℝ)) = 1 := by
    simpa using BuildingBlocks.FactorialQuotientConstraints.quotient_mass_real N 1
      (by omega) (by omega)
  simpa only [mul_zero, Real.exp_zero, mul_one, hm] using h

/-- Each fixed positive cutoff has positive response at sufficiently small positive times. -/
theorem response_eventually_pos (N : ℕ) (hN : 0 < N) :
    ∀ᶠ t in 𝓝[>] (0 : ℝ), 0 < response N t := by
  have hl := (response_hasDerivAt_zero N hN).tendsto_slope_zero_right
  have hp := hl.eventually_const_lt (by norm_num : (0 : ℝ) < 1)
  filter_upwards [hp, self_mem_nhdsWithin] with t ht ht0
  have htpos : 0 < t := ht0
  have hr : 0 < t⁻¹ * response N t := by
    simpa [response_zero, smul_eq_mul] using ht
  exact (mul_pos_iff.mp hr).elim (fun h => h.2)
    (fun h => False.elim ((not_lt_of_ge (le_of_lt (inv_pos.mpr htpos))) h.1))

#print axioms response_zero
#print axioms response_hasDerivAt
#print axioms response_hasDerivAt_zero
#print axioms response_eventually_pos

end BuildingBlocks.FactorialResponseDerivative
