import BuildingBlocks.ActualCutoffDivisibilityProduct
import BuildingBlocks.ActualCutoffOrthantMoments

namespace BuildingBlocks.ActualPrimeOrthantMoment

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite
open BuildingBlocks.ActualCutoffDivisibilityProduct
open BuildingBlocks.ActualCutoffOrthantMoments

noncomputable section

variable {N : ℕ} {S : Finset ℕ}

private theorem list_map_prod {α M : Type*} [CommMonoid M]
    (s : Finset α) (g : α → M) :
    (s.toList.map g).prod = ∏ a ∈ s, g a := by
  classical
  induction s using Finset.induction with
  | empty => simp
  | @insert a s ha ih =>
      simp [Finset.prod_insert, ha]

private def thresholdProd (S : Finset ℕ)
    (κ : (p : ℕ) → p ∈ S → ℕ) : ℕ :=
  ∏ p ∈ S.attach, p.1 ^ κ p.1 p.2

private theorem thresholdProd_pos (S : Finset ℕ)
    (κ : (p : ℕ) → p ∈ S → ℕ)
    (hS : ∀ p ∈ S, p.Prime) :
    0 < thresholdProd S κ := by
  unfold thresholdProd
  apply Finset.prod_pos
  intro p hp
  exact pow_pos (hS p.1 p.2).pos _

private theorem thresholdProd_dvd_iff
    (S : Finset ℕ) (κ : (p : ℕ) → p ∈ S → ℕ)
    (hS : ∀ p ∈ S, p.Prime) {n : ℕ} (hn : n ≠ 0) :
    thresholdProd S κ ∣ n ↔
      ∀ p ∈ S.attach, κ p.1 p.2 ≤ n.factorization p.1 := by
  constructor
  · intro h p hp
    have hpow : p.1 ^ κ p.1 p.2 ∣ thresholdProd S κ := by
      unfold thresholdProd
      exact Finset.dvd_prod_of_mem _ hp
    exact ((hS p.1 p.2).pow_dvd_iff_le_factorization hn).mp (hpow.trans h)
  · intro h
    have hpair : (↑S.attach : Set {p : ℕ // p ∈ S}).Pairwise
        (Function.onFun IsCoprime
          (fun p => ((p.1 ^ κ p.1 p.2 : ℕ) : ℤ))) := by
      intro p hp q hq hpq
      have hpq' : p.1 ≠ q.1 := by
        intro heq
        exact hpq (Subtype.ext heq)
      have hc : p.1.Coprime q.1 :=
        (Nat.coprime_primes (hS p.1 p.2) (hS q.1 q.2)).2 hpq'
      exact Nat.Coprime.isCoprime (hc.pow (κ p.1 p.2) (κ q.1 q.2))
    have hdvd : (∏ p ∈ S.attach,
        ((p.1 ^ κ p.1 p.2 : ℕ) : ℤ)) ∣ (n : ℤ) := by
      apply Finset.prod_dvd_of_coprime hpair
      intro p hp
      have hpow : p.1 ^ κ p.1 p.2 ∣ n :=
        ((hS p.1 p.2).pow_dvd_iff_le_factorization hn).mpr (h p hp)
      exact_mod_cast hpow
    have hdvdNat : thresholdProd S κ ∣ n := by
      exact_mod_cast hdvd
    exact hdvdNat

private theorem threshold_event_eq {S : Finset ℕ}
    (κ : (p : ℕ) → p ∈ S → ℕ)
    (hS : ∀ p ∈ S, p.Prime) {n : ℕ} (hn : n ≠ 0) :
    (∏ p ∈ S.attach,
      if κ p.1 p.2 ≤ n.factorization p.1 then (1 : ℝ) else 0) =
    if thresholdProd S κ ∣ n then (1 : ℝ) else 0 := by
  classical
  by_cases hall : ∀ p ∈ S.attach, κ p.1 p.2 ≤ n.factorization p.1
  · have hdvd := (thresholdProd_dvd_iff S κ hS hn).2 hall
    rw [if_pos hdvd]
    apply Finset.prod_eq_one
    intro p hp
    exact if_pos (hall p hp)
  · have hnot : ¬ thresholdProd S κ ∣ n := by
      exact fun hdvd => hall ((thresholdProd_dvd_iff S κ hS hn).1 hdvd)
    rw [if_neg hnot]
    push_neg at hall
    obtain ⟨p, hp, hfail⟩ := hall
    apply Finset.prod_eq_zero hp
    exact if_neg (not_le.mpr hfail)

private theorem expect_divisibility_eq_probability {N a : ℕ} {x : ℝ} :
    expect (cutoffProbMass N x)
      (fun n : cutoffSample N => if a ∣ n.1 then (1 : ℝ) else 0) =
    originalProbability N a x := by
  classical
  unfold expect cutoffProbMass originalProbability
  change (∑ n ∈ (Finset.Icc 1 N).attach,
      cutoffWeight x n.1 / cutoffMass N x *
        (if a ∣ n.1 then (1 : ℝ) else 0)) = _
  simp_rw [mul_ite, mul_one, mul_zero]
  calc
    (∑ n ∈ (Finset.Icc 1 N).attach,
        if a ∣ n.1 then cutoffWeight x n.1 / cutoffMass N x else 0) =
      ∑ n ∈ Finset.Icc 1 N,
        if a ∣ n then cutoffWeight x n / cutoffMass N x else 0 :=
          Finset.sum_attach (Finset.Icc 1 N)
            (fun n : ℕ => if a ∣ n then cutoffWeight x n / cutoffMass N x else 0)
    _ = (∑ n ∈ Finset.Icc 1 N,
          if a ∣ n then cutoffWeight x n else 0) / cutoffMass N x := by
      rw [Finset.sum_div]
      apply Finset.sum_congr rfl
      intro n hn
      split_ifs <;> simp

/-- The exact prime-threshold upper-orthant inequality, including threshold
zero and the empty coordinate set, derived from the full divisibility-product
bound rather than taken as a premise. -/
theorem actual_prime_orthant_bound {N : ℕ} {x : ℝ}
    (hN : 1 ≤ N) (hx : 1 < x) (hxN : x ≤ (N : ℝ)+1)
    (S : Finset ℕ) (hS : ∀ p ∈ S, p.Prime)
    (κ : (p : ℕ) → p ∈ S → ℕ) :
    expect (cutoffProbMass N x)
      (fun n => ∏ p ∈ S.attach,
        if κ p.1 p.2 ≤ n.1.factorization p.1 then (1 : ℝ) else 0) ≤
    ∏ p ∈ S.attach,
      expect (cutoffProbMass N x)
        (fun n => if κ p.1 p.2 ≤ n.1.factorization p.1 then (1 : ℝ) else 0) := by
  classical
  let g : {p : ℕ // p ∈ S} → ℕ := fun p => p.1 ^ κ p.1 p.2
  let as : List ℕ := S.attach.toList.map g
  have hall : ∀ a ∈ as, 1 ≤ a := by
    intro a ha
    obtain ⟨p, hp, rfl⟩ := List.mem_map.mp ha
    exact Nat.one_le_iff_ne_zero.mpr (pow_ne_zero _ (hS p.1 p.2).ne_zero)
  have hprod : as.prod = thresholdProd S κ := by
    simpa only [as, g, thresholdProd] using list_map_prod S.attach g
  have hprobs :
      (as.map (fun a => originalProbability N a x)).prod =
      ∏ p ∈ S.attach, originalProbability N (g p) x := by
    simpa only [as, List.map_map, Function.comp_def] using
      (list_map_prod S.attach (fun p => originalProbability N (g p) x))
  have hleft :
      expect (cutoffProbMass N x)
        (fun n => ∏ p ∈ S.attach,
          if κ p.1 p.2 ≤ n.1.factorization p.1 then (1 : ℝ) else 0) =
      originalProbability N (thresholdProd S κ) x := by
    have hfun : (fun n : cutoffSample N =>
        ∏ p ∈ S.attach,
          if κ p.1 p.2 ≤ n.1.factorization p.1 then (1 : ℝ) else 0) =
        (fun n : cutoffSample N =>
          if thresholdProd S κ ∣ n.1 then (1 : ℝ) else 0) := by
      funext n
      have hn : n.1 ≠ 0 := by
        have := (Finset.mem_Icc.mp n.2).1
        omega
      exact threshold_event_eq κ hS hn
    rw [hfun]
    exact expect_divisibility_eq_probability
  have hsingle (p : {p : ℕ // p ∈ S}) :
      expect (cutoffProbMass N x)
        (fun n => if κ p.1 p.2 ≤ n.1.factorization p.1 then (1 : ℝ) else 0) =
      originalProbability N (g p) x := by
    have hfun : (fun n : cutoffSample N =>
        if κ p.1 p.2 ≤ n.1.factorization p.1 then (1 : ℝ) else 0) =
        (fun n : cutoffSample N => if g p ∣ n.1 then (1 : ℝ) else 0) := by
      funext n
      have hn : n.1 ≠ 0 := by
        have := (Finset.mem_Icc.mp n.2).1
        omega
      simp only [g, (hS p.1 p.2).pow_dvd_iff_le_factorization hn]
    rw [hfun]
    exact expect_divisibility_eq_probability
  rw [hleft]
  simp_rw [hsingle]
  rw [← hprobs, ← hprod]
  exact originalProbability_list_prod_le hN hx hxN as hall

/-- Equation (8) for the actual finite cutoff law, now with the prime-power
upper-orthant inequality discharged by equation (7). -/
theorem actual_prime_monotone_valuation_moment
    {N : ℕ} {x : ℝ} (hN : 1 ≤ N) (hx : 1 < x)
    (hxN : x ≤ (N : ℝ)+1)
    (S : Finset ℕ) (hS : ∀ p ∈ S, p.Prime)
    (f : ℕ → ℕ → ℝ)
    (hf0 : ∀ p ∈ S, 0 ≤ f p 0)
    (hfmono : ∀ p ∈ S, ∀ k < N, f p k ≤ f p (k+1)) :
    expect (cutoffProbMass N x)
      (fun n => ∏ p ∈ S, f p (n.1.factorization p)) ≤
    ∏ p ∈ S,
      expect (cutoffProbMass N x) (fun n => f p (n.1.factorization p)) := by
  apply actual_cutoff_moment_of_orthant hN hx hxN S hS f hf0 hfmono
  intro κ hκ
  exact actual_prime_orthant_bound hN hx hxN S hS κ

#print axioms actual_prime_orthant_bound
#print axioms actual_prime_monotone_valuation_moment

end
end BuildingBlocks.ActualPrimeOrthantMoment
