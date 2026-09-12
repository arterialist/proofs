import BuildingBlocks.HarmonicPrimePhase

namespace ArithmeticDynamics
noncomputable section
open scoped BigOperators


/-- The exact reciprocal mass of positive multiples, including the last multiple. -/
theorem harmonic_multiples_sum (N l : ℕ) (hl : 0 < l) :
    (∑ n ∈ Finset.Icc 1 N, if l ∣ n then (1 : ℝ) / n else 0) =
      phaseHarmonicMass (N / l) / (l : ℝ) := by
  rw [← Finset.sum_filter]
  have he : (∑ m ∈ Finset.Icc 1 (N / l), (1 : ℝ) / (l * m : ℕ)) =
      ∑ n ∈ (Finset.Icc 1 N).filter (fun n => l ∣ n), (1 : ℝ) / n := by
    apply Finset.sum_bij (fun m _ => l * m)
    · intro m hm
      obtain ⟨hm1, hmN⟩ := Finset.mem_Icc.mp hm
      apply Finset.mem_filter.mpr
      constructor
      · apply Finset.mem_Icc.mpr
        constructor
        · exact Nat.mul_pos hl hm1
        · simpa [Nat.mul_comm] using (Nat.le_div_iff_mul_le hl).mp hmN
      · exact dvd_mul_right l m
    · intro a ha b hb hab
      exact Nat.eq_of_mul_eq_mul_left hl hab
    · intro n hn
      obtain ⟨hnI, hln⟩ := Finset.mem_filter.mp hn
      obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hnI
      refine ⟨n / l, ?_, ?_⟩
      · apply Finset.mem_Icc.mpr
        constructor
        · apply Nat.one_le_iff_ne_zero.mpr
          intro hz
          have hh := Nat.div_mul_cancel hln
          rw [hz, zero_mul] at hh
          omega
        · exact Nat.div_le_div_right hnN
      · simpa [Nat.mul_comm] using Nat.div_mul_cancel hln
    · intro m hm
      rfl
  rw [← he]
  simp only [phaseHarmonicMass, div_eq_mul_inv, Finset.sum_mul, Nat.cast_mul, mul_inv_rev]
  apply Finset.sum_congr rfl
  intro m hm
  ring

/-- Valuations may all be counted at the common outer cutoff. -/
lemma valuation_eq_sum_power_divisors_cutoff {n N p : ℕ}
    (hn : 0 < n) (hnN : n ≤ N) (hp : p.Prime) :
    (n.factorization p : ℝ) =
      ∑ i ∈ Finset.Ico 1 N, if p ^ i ∣ n then (1 : ℝ) else 0 := by
  rw [Nat.factorization_eq_card_pow_dvd_of_lt hp hn
    (hnN.trans_lt (Nat.lt_pow_self hp.one_lt))]
  simp

/-- Common-cutoff valuation overlap retains lcm, including same-prime powers. -/
lemma valuation_overlap_eq_lcm_sum_cutoff {n N p q : ℕ}
    (hn : 0 < n) (hnN : n ≤ N) (hp : p.Prime) (hq : q.Prime) :
    (n.factorization p : ℝ) * (n.factorization q : ℝ) =
      ∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N,
        if Nat.lcm (p ^ i) (q ^ j) ∣ n then (1 : ℝ) else 0 := by
  rw [valuation_eq_sum_power_divisors_cutoff hn hnN hp,
    valuation_eq_sum_power_divisors_cutoff hn hnN hq, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro i hi
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j hj
  by_cases hpi : p ^ i ∣ n <;> by_cases hqj : q ^ j ∣ n <;>
    simp [Nat.lcm_dvd_iff, hpi, hqj]


/-- Harmonic averaging turns valuation overlap into exact finite lcm masses. -/
theorem harmonic_valuation_overlap (N p q : ℕ) (hp : p.Prime) (hq : q.Prime) :
    (∑ n ∈ Finset.Icc 1 N,
      (n.factorization p : ℝ) * (n.factorization q : ℝ) / n) =
    ∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N,
      phaseHarmonicMass (N / Nat.lcm (p ^ i) (q ^ j)) /
        (Nat.lcm (p ^ i) (q ^ j) : ℝ) := by
  calc
    _ = ∑ n ∈ Finset.Icc 1 N, ∑ i ∈ Finset.Ico 1 N,
        ∑ j ∈ Finset.Ico 1 N,
          if Nat.lcm (p ^ i) (q ^ j) ∣ n then (1 : ℝ) / n else 0 := by
      apply Finset.sum_congr rfl
      intro n hn
      rw [valuation_overlap_eq_lcm_sum_cutoff (Finset.mem_Icc.mp hn).1
        (Finset.mem_Icc.mp hn).2 hp hq]
      simp only [div_eq_mul_inv, Finset.sum_mul, ite_mul, zero_mul]
    _ = _ := by
      rw [Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro i hi
      rw [Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro j hj
      exact harmonic_multiples_sum N _ (Nat.lcm_pos (pow_pos hp.pos _) (pow_pos hq.pos _))

lemma primeMultiplicity_eq_sum_admitted {n N : ℕ} (hn : n ≤ N) :
    primeMultiplicity n = ∑ q ∈ admittedPrimes N, (n.factorization q : ℝ) := by
  unfold primeMultiplicity
  apply Finset.sum_subset (primeFactors_subset_admitted hn)
  intro q hq hqn
  have hz : n.factorization q = 0 :=
    Finsupp.notMem_support_iff.mp (by simpa only [Nat.support_factorization] using hqn)
  simp [hz]

/-- The exact harmonic prime coefficient, with every finite lcm overlap retained. -/
theorem harmonicPrimeWeight_eq_lcm_sum (N p : ℕ) (hp : p.Prime) :
    harmonicPrimeWeight N p = (phaseHarmonicMass N)⁻¹ *
      ∑ q ∈ admittedPrimes N, ∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N,
        phaseHarmonicMass (N / Nat.lcm (p ^ i) (q ^ j)) /
          (Nat.lcm (p ^ i) (q ^ j) : ℝ) := by
  unfold harmonicPrimeWeight
  congr 1
  calc
    _ = ∑ n ∈ Finset.Icc 1 N, ∑ q ∈ admittedPrimes N,
        (n.factorization p : ℝ) * (n.factorization q : ℝ) / n := by
      apply Finset.sum_congr rfl
      intro n hn
      rw [primeMultiplicity_eq_sum_admitted (Finset.mem_Icc.mp hn).2]
      simp only [div_eq_mul_inv, Finset.sum_mul]
      apply Finset.sum_congr rfl
      intro q hq
      ring
    _ = _ := by
      rw [Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro q hq
      exact harmonic_valuation_overlap N p q hp (Finset.mem_filter.mp hq).2

end
end ArithmeticDynamics
