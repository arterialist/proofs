import BuildingBlocks.ActualPrimeOrthantMoment

namespace BuildingBlocks.ActualPrimeExponentialMoment

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite
open BuildingBlocks.ActualCutoffOrthantMoments
open BuildingBlocks.ActualPrimeOrthantMoment

noncomputable section

private def scoreAtValuation (p k : ℕ) : ℝ :=
  Real.log p * ∑ j ∈ Finset.Icc 1 k, Real.sqrt ((p : ℝ) ^ j)

private theorem scoreAtValuation_succ (p k : ℕ) :
    scoreAtValuation p (k+1) = scoreAtValuation p k +
      Real.log p * Real.sqrt ((p : ℝ) ^ (k+1)) := by
  unfold scoreAtValuation
  rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ k+1)]
  ring

private theorem scoreAtValuation_mono_succ {p k : ℕ} (hp : p.Prime) :
    scoreAtValuation p k ≤ scoreAtValuation p (k+1) := by
  rw [scoreAtValuation_succ]
  have hlog : 0 ≤ Real.log (p : ℝ) :=
    (Real.log_pos (by exact_mod_cast hp.one_lt)).le
  have hroot : 0 ≤ Real.sqrt ((p : ℝ) ^ (k+1)) := Real.sqrt_nonneg _
  nlinarith [mul_nonneg hlog hroot]

/-- The actual full p-adic score is the valuation-coordinate score; no
prime-power term has been removed. -/
private theorem scoreAtValuation_full (p n : ℕ) :
    scoreAtValuation p (n.factorization p) = fullPrimeScore p n := rfl

/-- Equation (9): a full finite-cutoff exponential moment bound for the
published complete prime-power scores. The finite prime family can be empty. -/
theorem actual_fullPrimeScore_exp_moment
    {N : ℕ} {x : ℝ} (hN : 1 ≤ N) (hx : 1 < x)
    (hxN : x ≤ (N : ℝ)+1)
    (S : Finset ℕ) (hS : ∀ p ∈ S, p.Prime)
    (t : ℕ → ℝ) (ht : ∀ p ∈ S, 0 ≤ t p) :
    expect (cutoffProbMass N x)
      (fun n => Real.exp (∑ p ∈ S, t p * fullPrimeScore p n.1)) ≤
    ∏ p ∈ S,
      expect (cutoffProbMass N x)
        (fun n => Real.exp (t p * fullPrimeScore p n.1)) := by
  let f : ℕ → ℕ → ℝ := fun p k => Real.exp (t p * scoreAtValuation p k)
  have hf0 : ∀ p ∈ S, 0 ≤ f p 0 := by
    intro p hp
    exact (Real.exp_pos _).le
  have hfmono : ∀ p ∈ S, ∀ k < N, f p k ≤ f p (k+1) := by
    intro p hp k hk
    apply Real.exp_le_exp.mpr
    exact mul_le_mul_of_nonneg_left (scoreAtValuation_mono_succ (hS p hp)) (ht p hp)
  have h := actual_prime_monotone_valuation_moment hN hx hxN S hS f hf0 hfmono
  have hleft (n : cutoffSample N) :
      (∏ p ∈ S, f p (n.1.factorization p)) =
      Real.exp (∑ p ∈ S, t p * fullPrimeScore p n.1) := by
    simp only [f, scoreAtValuation_full]
    exact (Real.exp_sum S (fun p => t p * fullPrimeScore p n.1)).symm
  have hright (p : ℕ) (n : cutoffSample N) :
      f p (n.1.factorization p) =
      Real.exp (t p * fullPrimeScore p n.1) := by
    simp only [f, scoreAtValuation_full]
  simp_rw [hleft, hright] at h
  exact h

end
end BuildingBlocks.ActualPrimeExponentialMoment

#print axioms BuildingBlocks.ActualPrimeExponentialMoment.actual_fullPrimeScore_exp_moment
