import BuildingBlocks.ActualPrimeExponentialMoment
import Mathlib.NumberTheory.VonMangoldt

open BuildingBlocks.ActualPrimeCutoffCovarianceFinite

namespace BuildingBlocks.PrimeScoreDivisorIdentity

noncomputable section

theorem weighted_divisor_prime_score {n : ℕ} (hn : n ≠ 0) :
    (∑ m ∈ n.divisors, Real.sqrt (m : ℝ) * ArithmeticFunction.vonMangoldt m) =
      ∑ p ∈ n.primeFactors, fullPrimeScore p n := by
  classical
  let P := n.primeFactors.sigma (fun p => Finset.Icc 1 (n.factorization p))
  let Q := n.divisors.filter IsPrimePow
  have hbij :
      (∑ a ∈ P, Real.sqrt (((a.1 ^ a.2 : ℕ) : ℝ)) * Real.log (a.1 : ℝ)) =
      ∑ m ∈ Q, Real.sqrt (m : ℝ) * ArithmeticFunction.vonMangoldt m := by
    apply Finset.sum_bij (fun a _ => a.1 ^ a.2)
    · intro a ha
      obtain ⟨hp, hj⟩ := Finset.mem_sigma.mp ha
      obtain ⟨hpp, _, _⟩ := Nat.mem_primeFactors.mp hp
      obtain ⟨hj1, hjle⟩ := Finset.mem_Icc.mp hj
      have hdvd : a.1 ^ a.2 ∣ n :=
        (hpp.pow_dvd_iff_le_factorization hn).mpr hjle
      exact Finset.mem_filter.mpr ⟨Nat.mem_divisors.mpr ⟨hdvd, hn⟩,
        ⟨a.1, a.2, hpp.prime, hj1, rfl⟩⟩
    · intro a ha b hb heq
      obtain ⟨hpa, hja⟩ := Finset.mem_sigma.mp ha
      obtain ⟨hpb, hjb⟩ := Finset.mem_sigma.mp hb
      have hpa' := (Nat.mem_primeFactors.mp hpa).1
      have hpb' := (Nat.mem_primeFactors.mp hpb).1
      have hja' := (Finset.mem_Icc.mp hja).1
      have hjb' := (Finset.mem_Icc.mp hjb).1
      have hpq : a.1 = b.1 := by
        have hpow : a.1 ^ ((a.2 - 1) + 1) = b.1 ^ ((b.2 - 1) + 1) := by
          simpa [Nat.sub_add_cancel hja', Nat.sub_add_cancel hjb'] using heq
        exact (hpa'.pow_inj hpb' hpow).1
      apply Sigma.ext hpq
      apply heq_of_eq
      apply Nat.pow_right_injective hpb'.two_le
      simpa [hpq] using heq
    · intro m hm
      obtain ⟨hmd, hmp⟩ := Finset.mem_filter.mp hm
      obtain ⟨p, j, hp, hj, hpow⟩ := (isPrimePow_nat_iff m).mp hmp
      have hp' : p.Prime := hp
      have hdvd : p ^ j ∣ n := hpow ▸ (Nat.mem_divisors.mp hmd).1
      have hpdiv : p ∣ n := (dvd_pow_self p (by omega : j ≠ 0)).trans hdvd
      have hpmem : p ∈ n.primeFactors := Nat.mem_primeFactors.mpr ⟨hp', hpdiv, hn⟩
      have hjle : j ≤ n.factorization p :=
        (hp'.pow_dvd_iff_le_factorization hn).mp hdvd
      refine ⟨⟨p, j⟩, ?_, hpow⟩
      exact Finset.mem_sigma.mpr ⟨hpmem, Finset.mem_Icc.mpr ⟨hj, hjle⟩⟩
    · intro a ha
      obtain ⟨hp, hj⟩ := Finset.mem_sigma.mp ha
      have hpp := (Nat.mem_primeFactors.mp hp).1
      have hj1 := (Finset.mem_Icc.mp hj).1
      rw [ArithmeticFunction.vonMangoldt_apply_pow (by omega),
        ArithmeticFunction.vonMangoldt_apply_prime hpp]
  have hQ :
      (∑ m ∈ Q, Real.sqrt (m : ℝ) * ArithmeticFunction.vonMangoldt m) =
      ∑ m ∈ n.divisors, Real.sqrt (m : ℝ) * ArithmeticFunction.vonMangoldt m := by
    apply Finset.sum_subset (Finset.filter_subset _ _)
    intro m hm hnot
    have hz : ArithmeticFunction.vonMangoldt m = 0 :=
      ArithmeticFunction.vonMangoldt_eq_zero_iff.mpr
        (fun h => hnot (Finset.mem_filter.mpr ⟨hm, h⟩))
    simp [hz]
  rw [← hQ, ← hbij]
  rw [Finset.sum_sigma]
  unfold fullPrimeScore
  apply Finset.sum_congr rfl
  intro p hp
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j hj
  simp only [Nat.cast_pow]
  ring

#print axioms weighted_divisor_prime_score

end
end BuildingBlocks.PrimeScoreDivisorIdentity
