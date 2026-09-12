import BuildingBlocks.PrimePhaseFactorization
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Tactic.NormNum

namespace ArithmeticDynamics

noncomputable section
open scoped BigOperators

/-- The total number of prime factors, counted with multiplicity, as a real number. -/
def primeMultiplicity (n : ℕ) : ℝ :=
  ∑ p ∈ n.primeFactors, (n.factorization p : ℝ)

/-- The actual admitted prime set at the integer cutoff. -/
def admittedPrimes (N : ℕ) : Finset ℕ :=
  (Finset.Icc 1 N).filter Nat.Prime

/-- The finite harmonic mass on the positive integers through the cutoff. -/
def phaseHarmonicMass (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, 1 / (n : ℝ)

/-- The harmonic average of the actual integer phase deficit. -/
def harmonicPhaseDefect (N : ℕ) (t : ℝ) : ℝ :=
  (phaseHarmonicMass N)⁻¹ *
    ∑ n ∈ Finset.Icc 1 N, ‖1 - logarithmicPrimePhase t n‖ ^ 2 / (n : ℝ)

/-- The exact prime coefficient, including Ω(n) and every valuation. -/
def harmonicPrimeWeight (N p : ℕ) : ℝ :=
  (phaseHarmonicMass N)⁻¹ *
    ∑ n ∈ Finset.Icc 1 N, primeMultiplicity n * (n.factorization p : ℝ) / (n : ℝ)

lemma phaseHarmonicMass_pos {N : ℕ} (hN : 1 ≤ N) : 0 < phaseHarmonicMass N := by
  apply Finset.sum_pos'
  · intro n hn
    positivity
  · exact ⟨1, Finset.mem_Icc.mpr ⟨le_rfl, hN⟩, by norm_num⟩

lemma primeMultiplicity_nonneg (n : ℕ) : 0 ≤ primeMultiplicity n :=
  Finset.sum_nonneg (fun p _ => Nat.cast_nonneg _)

lemma harmonicPrimeWeight_nonneg (N p : ℕ) : 0 ≤ harmonicPrimeWeight N p := by
  unfold harmonicPrimeWeight phaseHarmonicMass
  apply mul_nonneg
  · positivity
  · apply Finset.sum_nonneg
    intro n hn
    exact div_nonneg (mul_nonneg (primeMultiplicity_nonneg n) (Nat.cast_nonneg _))
      (Nat.cast_nonneg _)

lemma primeFactors_subset_admitted {n N : ℕ} (hn : n ≤ N) :
    n.primeFactors ⊆ admittedPrimes N := by
  intro p hp
  exact Finset.mem_filter.mpr ⟨Finset.mem_Icc.mpr
    ⟨(Nat.prime_of_mem_primeFactors hp).pos,
      (Nat.le_of_mem_primeFactors hp).trans hn⟩,
    Nat.prime_of_mem_primeFactors hp⟩

lemma phase_prime_sum_admitted (t : ℝ) {n N : ℕ} (hn : n ≤ N) :
    (∑ p ∈ n.primeFactors, (n.factorization p : ℝ) *
      ‖1 - logarithmicPrimePhase t p‖ ^ 2) =
    ∑ p ∈ admittedPrimes N, (n.factorization p : ℝ) *
      ‖1 - logarithmicPrimePhase t p‖ ^ 2 := by
  apply Finset.sum_subset (primeFactors_subset_admitted hn)
  intro p hp hpn
  have hz : n.factorization p = 0 :=
    Finsupp.notMem_support_iff.mp (by simpa only [Nat.support_factorization] using hpn)
  simp [hz]

/-- Exact finite harmonic averaging of the actual factorization inequality.
No spectral gap is assumed. -/
theorem harmonicPhaseDefect_le_prime_sum (N : ℕ) (hN : 1 ≤ N) (t : ℝ) :
    harmonicPhaseDefect N t ≤
      ∑ p ∈ admittedPrimes N, harmonicPrimeWeight N p *
        ‖1 - logarithmicPrimePhase t p‖ ^ 2 := by
  have hsum :
      (∑ n ∈ Finset.Icc 1 N, ‖1 - logarithmicPrimePhase t n‖ ^ 2 / (n : ℝ)) ≤
      ∑ n ∈ Finset.Icc 1 N, (primeMultiplicity n *
        ∑ p ∈ admittedPrimes N, (n.factorization p : ℝ) *
          ‖1 - logarithmicPrimePhase t p‖ ^ 2) / (n : ℝ) := by
    apply Finset.sum_le_sum
    intro n hn
    apply div_le_div_of_nonneg_right _ (Nat.cast_nonneg n)
    have h := logarithmicPrimePhase_bound t n
    rw [phase_prime_sum_admitted t (Finset.mem_Icc.mp hn).2] at h
    exact h
  unfold harmonicPhaseDefect
  calc
    _ ≤ (phaseHarmonicMass N)⁻¹ *
        ∑ n ∈ Finset.Icc 1 N, (primeMultiplicity n *
          ∑ p ∈ admittedPrimes N, (n.factorization p : ℝ) *
            ‖1 - logarithmicPrimePhase t p‖ ^ 2) / (n : ℝ) :=
      mul_le_mul_of_nonneg_left hsum (inv_nonneg.mpr (phaseHarmonicMass_pos hN).le)
    _ = _ := by
      simp only [harmonicPrimeWeight, div_eq_mul_inv, Finset.mul_sum,
        Finset.sum_mul, mul_assoc]
      rw [Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro p hp
      apply Finset.sum_congr rfl
      intro n hn
      ring

/-- A valuation is the exact finite count of its positive prime-power divisors. -/
private lemma valuation_eq_sum_power_divisors (n p : ℕ) (hp : p.Prime) :
    (n.factorization p : ℝ) =
      ∑ i ∈ Finset.Ico 1 n, if p ^ i ∣ n then (1 : ℝ) else 0 := by
  rw [Nat.factorization_eq_card_pow_dvd n hp]
  simp

/-- Actual valuation overlap counts common prime-power divisibility via lcm. -/
theorem valuation_overlap_eq_lcm_sum (n p q : ℕ) (hp : p.Prime) (hq : q.Prime) :
    (n.factorization p : ℝ) * (n.factorization q : ℝ) =
      ∑ i ∈ Finset.Ico 1 n, ∑ j ∈ Finset.Ico 1 n,
        if Nat.lcm (p ^ i) (q ^ j) ∣ n then (1 : ℝ) else 0 := by
  rw [valuation_eq_sum_power_divisors n p hp, valuation_eq_sum_power_divisors n q hq,
    Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro i hi
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j hj
  by_cases hpi : p ^ i ∣ n <;> by_cases hqj : q ^ j ∣ n <;>
    simp [Nat.lcm_dvd_iff, hpi, hqj]

/-- On the same prime, the lcm overlap uses max(i,j), not i+j. -/
theorem same_prime_valuation_sq_eq_max_sum (n p : ℕ) (hn : n ≠ 0) (hp : p.Prime) :
    (n.factorization p : ℝ) ^ 2 =
      ∑ i ∈ Finset.Ico 1 n, ∑ j ∈ Finset.Ico 1 n,
        if p ^ max i j ∣ n then (1 : ℝ) else 0 := by
  rw [pow_two, valuation_overlap_eq_lcm_sum n p p hp hp]
  apply Finset.sum_congr rfl
  intro i hi
  apply Finset.sum_congr rfl
  intro j hj
  simp only [Nat.lcm_dvd_iff, hp.pow_dvd_iff_le_factorization hn, max_le_iff]

end
end ArithmeticDynamics
