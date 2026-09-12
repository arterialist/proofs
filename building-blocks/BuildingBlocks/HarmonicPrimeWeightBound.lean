import BuildingBlocks.HarmonicPrimeWeights
import Mathlib.Analysis.SpecificLimits.Normed

namespace ArithmeticDynamics
noncomputable section
open scoped BigOperators

def primePowerReciprocalSum (N p : ℕ) : ℝ :=
  ∑ i ∈ Finset.Ico 1 N, 1 / (p : ℝ) ^ i

def samePrimeReciprocalSum (N p : ℕ) : ℝ :=
  ∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N, 1 / (p : ℝ) ^ max i j

lemma phaseHarmonicMass_mono {M N : ℕ} (h : M ≤ N) :
    phaseHarmonicMass M ≤ phaseHarmonicMass N := by
  apply Finset.sum_le_sum_of_subset_of_nonneg
  · intro n hn
    exact Finset.mem_Icc.mpr ⟨(Finset.mem_Icc.mp hn).1, (Finset.mem_Icc.mp hn).2.trans h⟩
  · intro n hn hnm
    positivity

lemma same_base_lcm_pow (p i j : ℕ) : Nat.lcm (p ^ i) (p ^ j) = p ^ max i j := by
  rcases le_total i j with hij | hji
  · rw [max_eq_right hij, Nat.lcm_eq_right (pow_dvd_pow p hij)]
  · rw [max_eq_left hji, Nat.lcm_eq_left (pow_dvd_pow p hji)]

theorem harmonicPrimeWeight_le_reciprocal_lcm (N p : ℕ) (hN : 1 ≤ N) (hp : p.Prime) :
    harmonicPrimeWeight N p ≤
      ∑ q ∈ admittedPrimes N, ∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N,
        1 / (Nat.lcm (p ^ i) (q ^ j) : ℝ) := by
  rw [harmonicPrimeWeight_eq_lcm_sum N p hp]
  have hH := phaseHarmonicMass_pos hN
  calc
    _ ≤ (phaseHarmonicMass N)⁻¹ *
        ∑ q ∈ admittedPrimes N, ∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N,
          phaseHarmonicMass N / (Nat.lcm (p ^ i) (q ^ j) : ℝ) := by
      apply mul_le_mul_of_nonneg_left _ (inv_nonneg.mpr hH.le)
      apply Finset.sum_le_sum
      intro q hq
      apply Finset.sum_le_sum
      intro i hi
      apply Finset.sum_le_sum
      intro j hj
      exact div_le_div_of_nonneg_right (phaseHarmonicMass_mono (Nat.div_le_self _ _))
        (Nat.cast_nonneg _)
    _ = _ := by
      simp only [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro q hq
      apply Finset.sum_congr rfl
      intro i hi
      apply Finset.sum_congr rfl
      intro j hj
      rw [div_eq_mul_inv, ← mul_assoc, inv_mul_cancel₀ hH.ne', one_mul, one_div]

lemma reciprocal_lcm_sum_eq (N p q : ℕ) (hp : p.Prime) (hq : q.Prime) :
    (∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N,
      1 / (Nat.lcm (p ^ i) (q ^ j) : ℝ)) =
    if q = p then samePrimeReciprocalSum N p
    else primePowerReciprocalSum N p * primePowerReciprocalSum N q := by
  split_ifs with heq
  · subst q
    simp only [samePrimeReciprocalSum, same_base_lcm_pow, Nat.cast_pow]
  · have hc := ((Nat.coprime_primes hp hq).mpr (Ne.symm heq))
    unfold primePowerReciprocalSum
    rw [Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro i hi
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro j hj
    rw [(hc.pow i j).lcm_eq_mul, Nat.cast_mul, Nat.cast_pow, Nat.cast_pow]
    simp [div_eq_mul_inv, mul_comm]

theorem harmonicPrimeWeight_le_finite_geometric (N p : ℕ) (hN : 1 ≤ N) (hp : p.Prime) :
    harmonicPrimeWeight N p ≤ samePrimeReciprocalSum N p +
      primePowerReciprocalSum N p *
        ∑ q ∈ (admittedPrimes N).filter (fun q => q ≠ p), primePowerReciprocalSum N q := by
  apply (harmonicPrimeWeight_le_reciprocal_lcm N p hN hp).trans
  have he : (∑ q ∈ admittedPrimes N, ∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N,
      1 / (Nat.lcm (p ^ i) (q ^ j) : ℝ)) =
      ∑ q ∈ admittedPrimes N, if q = p then samePrimeReciprocalSum N p
      else primePowerReciprocalSum N p * primePowerReciprocalSum N q := by
    apply Finset.sum_congr rfl
    intro q hq
    exact reciprocal_lcm_sum_eq N p q hp (Finset.mem_filter.mp hq).2
  rw [he]
  have hs : 0 ≤ samePrimeReciprocalSum N p := by
    unfold samePrimeReciprocalSum
    positivity
  calc
    _ = (if p ∈ admittedPrimes N then samePrimeReciprocalSum N p else 0) +
        primePowerReciprocalSum N p *
          ∑ q ∈ (admittedPrimes N).filter (fun q => q ≠ p), primePowerReciprocalSum N q := by
      rw [Finset.mul_sum, Finset.sum_filter]
      have hi : ∀ q, (if q = p then samePrimeReciprocalSum N p
          else primePowerReciprocalSum N p * primePowerReciprocalSum N q) =
          (if q = p then samePrimeReciprocalSum N p else 0) +
          (if q ≠ p then primePowerReciprocalSum N p * primePowerReciprocalSum N q else 0) := by
        intro q
        by_cases hq : q = p <;> simp [hq]
      simp_rw [hi]
      rw [Finset.sum_add_distrib, Finset.sum_ite_eq']
    _ ≤ _ := by
      gcongr
      split_ifs <;> simp_all


/-- The exact square-shell count for the same-prime maximum. -/
lemma sum_pow_max_Ico (N : ℕ) (r : ℝ) :
    (∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N, r ^ max i j) =
      ∑ j ∈ Finset.Ico 1 N, (2 * (j : ℝ) - 1) * r ^ j := by
  induction N with
  | zero => simp
  | succ N ih =>
    by_cases hN : 1 ≤ N
    · have hcol : (∑ i ∈ Finset.Ico 1 N, r ^ max i N) = (N - 1 : ℕ) * r ^ N := by
        calc
          _ = ∑ i ∈ Finset.Ico 1 N, r ^ N := by
            apply Finset.sum_congr rfl
            intro i hi
            rw [max_eq_right (Finset.mem_Ico.mp hi).2.le]
          _ = _ := by simp
      have hrow : (∑ j ∈ Finset.Ico 1 N, r ^ max N j) = (N - 1 : ℕ) * r ^ N := by
        simpa only [max_comm N] using hcol
      rw [Finset.sum_Ico_succ_top hN, Finset.sum_Ico_succ_top hN]
      simp_rw [Finset.sum_Ico_succ_top hN]
      rw [Finset.sum_add_distrib, ih, hcol, hrow]
      simp only [max_self, Nat.cast_sub hN, Nat.cast_one]
      ring
    · have : N = 0 := by omega
      subst N
      simp

lemma positive_geometric_sum_le (N : ℕ) {r : ℝ} (hr0 : 0 ≤ r) (hr1 : r < 1) :
    (∑ i ∈ Finset.Ico 1 N, r ^ i) ≤ r / (1-r) := by
  have hg := (hasSum_geometric_of_lt_one hr0 hr1).mul_left r
  have hg' : HasSum (fun i : ℕ => r ^ (1+i)) (r / (1-r)) := by
    convert hg using 1
    simp [pow_succ, pow_add, mul_comm]
  rw [Finset.sum_Ico_eq_sum_range]
  exact (hg'.summable.sum_le_tsum _ (fun i hi => pow_nonneg hr0 _)).trans_eq hg'.tsum_eq

lemma same_geometric_sum_le (N : ℕ) {r : ℝ} (hr0 : 0 ≤ r) (hr1 : r < 1) :
    (∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N, r ^ max i j) ≤
      r * (1+r) / (1-r)^2 := by
  have hnorm : ‖r‖ < 1 := by rwa [Real.norm_eq_abs, abs_of_nonneg hr0]
  have hg := hasSum_geometric_of_lt_one hr0 hr1
  have hw := hasSum_coe_mul_geometric_of_norm_lt_one hnorm
  have ht := ((hw.mul_left 2).add hg).mul_left r
  have ht' : HasSum (fun i : ℕ => (2 * ((1+i : ℕ) : ℝ) - 1) * r ^ (1+i))
      (r * (1+r) / (1-r)^2) := by
    convert ht using 1
    · ext i
      simp only [Nat.cast_add, Nat.cast_one, pow_add, pow_one]
      ring
    · have hne : 1-r ≠ 0 := by linarith
      field_simp
      ring
  rw [sum_pow_max_Ico, Finset.sum_Ico_eq_sum_range]
  apply (ht'.summable.sum_le_tsum _ ?_).trans_eq ht'.tsum_eq
  intro i hi
  apply mul_nonneg _ (pow_nonneg hr0 _)
  have hi0 : 0 ≤ (i : ℝ) := Nat.cast_nonneg i
  push_cast
  linarith


lemma primePowerReciprocalSum_le (N p : ℕ) (hp : p.Prime) :
    primePowerReciprocalSum N p ≤ 1 / ((p : ℝ) - 1) := by
  have hp1 : 1 < (p : ℝ) := by exact_mod_cast hp.one_lt
  have hp0 : (0 : ℝ) < p := by linarith
  have hr1 : (p : ℝ)⁻¹ < 1 := (inv_lt_one₀ hp0).mpr hp1
  have hg := positive_geometric_sum_le N (inv_nonneg.mpr hp0.le) hr1
  have he : primePowerReciprocalSum N p =
      ∑ i ∈ Finset.Ico 1 N, (p : ℝ)⁻¹ ^ i := by
    simp [primePowerReciprocalSum, one_div, inv_pow]
  rw [he]
  apply hg.trans_eq
  have hpne : (p : ℝ) ≠ 0 := hp0.ne'
  have hmne : (p : ℝ) - 1 ≠ 0 := by linarith
  field_simp

lemma samePrimeReciprocalSum_le (N p : ℕ) (hp : p.Prime) :
    samePrimeReciprocalSum N p ≤ ((p : ℝ) + 1) / ((p : ℝ) - 1)^2 := by
  have hp1 : 1 < (p : ℝ) := by exact_mod_cast hp.one_lt
  have hp0 : (0 : ℝ) < p := by linarith
  have hr1 : (p : ℝ)⁻¹ < 1 := (inv_lt_one₀ hp0).mpr hp1
  have hg := same_geometric_sum_le N (inv_nonneg.mpr hp0.le) hr1
  have he : samePrimeReciprocalSum N p =
      ∑ i ∈ Finset.Ico 1 N, ∑ j ∈ Finset.Ico 1 N, (p : ℝ)⁻¹ ^ max i j := by
    simp [samePrimeReciprocalSum, one_div, inv_pow]
  rw [he]
  apply hg.trans_eq
  have hpne : (p : ℝ) ≠ 0 := hp0.ne'
  have hmne : (p : ℝ) - 1 ≠ 0 := by linarith
  field_simp

/-- The closed arithmetic coefficient bound, with the exact same-prime overlap. -/
theorem harmonicPrimeWeight_le_closed (N p : ℕ) (hN : 1 ≤ N) (hp : p.Prime) :
    harmonicPrimeWeight N p ≤ ((p : ℝ) + 1) / ((p : ℝ) - 1)^2 +
      (1 / ((p : ℝ) - 1)) *
        ∑ q ∈ (admittedPrimes N).filter (fun q => q ≠ p), 1 / ((q : ℝ) - 1) := by
  apply (harmonicPrimeWeight_le_finite_geometric N p hN hp).trans
  apply add_le_add (samePrimeReciprocalSum_le N p hp)
  apply mul_le_mul (primePowerReciprocalSum_le N p hp)
  · apply Finset.sum_le_sum
    intro q hq
    exact primePowerReciprocalSum_le N q (Finset.mem_filter.mp (Finset.mem_filter.mp hq).1).2
  · unfold primePowerReciprocalSum
    positivity
  · have hp1 : 1 < (p : ℝ) := by exact_mod_cast hp.one_lt
    exact div_nonneg zero_le_one (sub_nonneg.mpr hp1.le)

end
end ArithmeticDynamics
