import BuildingBlocks.PrimeHistoryDivisorResponse
import BuildingBlocks.PrimePairDivisorIdentity
import BuildingBlocks.OriginalWIdentification
import BuildingBlocks.ActualCriticalSignCriterion

open Filter
open scoped Topology

namespace BuildingBlocks.PrimeColorSignBridge

open ActualPrimeCutoffCovarianceFinite
open ActualCutoffOrthantMoments
open PrimeHistoryDivisorResponse
open PrimeScoreDivisorIdentity

noncomputable section

def primeColorResponse (x : ℝ) (n : ℕ) : ℝ :=
  let S := ∑ p ∈ n.primeFactors, fullPrimeScore p n
  (S - 1)^2 - (∑ p ∈ n.primeFactors, (fullPrimeScore p n)^2) -
    (x/n-1)*(S-1) + R (x/n-1)

/-- Pointwise complete divisor response as the exact prime-color quadratic.
Every prime power and the same-prime subtraction are retained. -/
theorem divisorResponse_eq_primeColorResponse (x : ℝ) {n : ℕ} (hn : n ≠ 0) :
    divisorResponse x n = primeColorResponse x n := by
  unfold divisorResponse primeColorResponse
  rw [BuildingBlocks.distinctPrimePairWeight_divisor_eq_score_square hn,
    weighted_divisor_prime_score hn]
  ring

theorem W_normalized_eq_primeColor_expectation (x : ℝ) (hx : 1 < x) :
    PrimeHistoryFullW.W x / cutoffMass ⌊x⌋₊ x =
      expect (cutoffProbMass ⌊x⌋₊ x)
        (fun n : cutoffSample ⌊x⌋₊ => primeColorResponse x n.1) := by
  rw [W_normalized_eq_actual_expectation hx]
  unfold expect
  apply Finset.sum_congr rfl
  intro n hn
  have hn0 : n.1 ≠ 0 := Nat.ne_of_gt (Finset.mem_Icc.mp n.2).1
  change cutoffProbMass ⌊x⌋₊ x n * divisorResponse x n.1 =
    cutoffProbMass ⌊x⌋₊ x n * primeColorResponse x n.1
  rw [divisorResponse_eq_primeColorResponse x hn0]

/-- This is only the exact reduction from an eventual sign for the complete
actual cutoff divisor response to RH. The eventual sign is an open premise. -/
theorem RH_of_eventual_divisor_response_nonpos
    (h : ∀ᶠ x : ℝ in atTop,
      BuildingBlocks.ActualCutoffOrthantMoments.expect
        (cutoffProbMass ⌊x⌋₊ x)
        (fun n : cutoffSample ⌊x⌋₊ => divisorResponse x n.1) ≤ 0) :
    RiemannHypothesis := by
  apply ActualCriticalSignCriterion.RiemannHypothesis_of_eventually_nonpos
  filter_upwards [h, eventually_gt_atTop (1 : ℝ)] with x hx hx1
  have hN : 1 ≤ ⌊x⌋₊ := (Nat.one_le_floor_iff x).mpr hx1.le
  have hmass : 0 < cutoffMass ⌊x⌋₊ x := cutoffMass_pos hN hx1
  have hW : PrimeHistoryFullW.W x ≤ 0 := by
    have hdiv : PrimeHistoryFullW.W x / cutoffMass ⌊x⌋₊ x ≤ 0 := by
      rw [W_normalized_eq_actual_expectation hx1]
      exact hx
    exact (div_le_iff₀ hmass).mp hdiv |>.trans (by simp)
  rw [← OriginalWIdentification.W_eq_original]
  simpa using hW

theorem RH_of_eventual_primeColor_response_nonpos
    (h : ∀ᶠ x : ℝ in atTop,
      expect (cutoffProbMass ⌊x⌋₊ x)
        (fun n : cutoffSample ⌊x⌋₊ => primeColorResponse x n.1) ≤ 0) :
    RiemannHypothesis := by
  apply RH_of_eventual_divisor_response_nonpos
  filter_upwards [h, eventually_gt_atTop (1 : ℝ)] with x hx hx1
  rw [← W_normalized_eq_actual_expectation hx1]
  rw [W_normalized_eq_primeColor_expectation x hx1]
  exact hx

#print axioms RH_of_eventual_divisor_response_nonpos
#print axioms divisorResponse_eq_primeColorResponse
#print axioms W_normalized_eq_primeColor_expectation
#print axioms RH_of_eventual_primeColor_response_nonpos

end
end BuildingBlocks.PrimeColorSignBridge
