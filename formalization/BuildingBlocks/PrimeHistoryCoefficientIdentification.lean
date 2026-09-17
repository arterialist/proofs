import BuildingBlocks.PrimeSourceVEvaluation
import BuildingBlocks.DistinctPrimeTent

open Finset
open scoped BigOperators

namespace BuildingBlocks.PrimeHistoryCoefficientIdentification

open PrimeSourceVEvaluation PrimeSourceDistinctFilter

/-- Weighted version of the existing unique-prime-power correspondence in PrimeBlockSource.
The map and its injectivity/surjectivity are unchanged; only the test weight is retained. -/
theorem weighted_prime_power_sum (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N, w n * ArithmeticFunction.vonMangoldt n) = ∑ p ∈ Finset.Icc 2 N, if p.Prime then
      ∑ j ∈ Finset.Icc 1 N, if p ^ j ≤ N then w (p^j) * Real.log p else 0 else 0 := by
  classical
  let P := (Finset.Icc 2 N ×ˢ Finset.Icc 1 N).filter (fun a => a.1.Prime ∧ a.1 ^ a.2 ≤ N)
  let Q := (Finset.Icc 1 N).filter IsPrimePow
  have hbij : (∑ a ∈ P, w (a.1^a.2) * Real.log a.1) = ∑ n ∈ Q, w n * ArithmeticFunction.vonMangoldt n := by
    apply Finset.sum_bij (fun a _ => a.1 ^ a.2)
    · intro a ha
      rcases Finset.mem_filter.mp ha with ⟨ha, hp, hpow⟩
      have hj := (Finset.mem_Icc.mp (Finset.mem_product.mp ha).2).1
      exact Finset.mem_filter.mpr ⟨Finset.mem_Icc.mpr ⟨pow_pos hp.pos _, hpow⟩,
        ⟨a.1, a.2, hp.prime, hj, rfl⟩⟩
    · intro a ha b hb hab
      rcases Finset.mem_filter.mp ha with ⟨ha, hpa, _⟩
      rcases Finset.mem_filter.mp hb with ⟨hb, hpb, _⟩
      have hja := (Finset.mem_Icc.mp (Finset.mem_product.mp ha).2).1
      have hjb := (Finset.mem_Icc.mp (Finset.mem_product.mp hb).2).1
      have hpa' : a.1 = b.1 := by
        have hpow : a.1 ^ ((a.2 - 1) + 1) = b.1 ^ ((b.2 - 1) + 1) := by
          simpa [Nat.sub_add_cancel hja, Nat.sub_add_cancel hjb] using hab
        exact (hpa.pow_inj hpb hpow).1
      apply Prod.ext hpa'
      apply Nat.pow_right_injective hpb.two_le
      simpa [hpa'] using hab
    · intro n hn
      rcases Finset.mem_filter.mp hn with ⟨hn, hpw⟩
      rcases hpw with ⟨p, j, hp, hj, hpow⟩
      have hp' : p.Prime := Nat.prime_iff.mpr hp
      have hnN := (Finset.mem_Icc.mp hn).2
      have hpN : p ≤ N := by
        calc
          p = p ^ 1 := by simp
          _ ≤ p ^ j := pow_le_pow_right₀ hp'.one_lt.le hj
          _ ≤ N := by simpa [hpow] using hnN
      have hjN : j ≤ N := (j.lt_pow_self hp'.one_lt).le.trans (by simpa [hpow] using hnN)
      refine ⟨(p,j), ?_, hpow⟩
      exact Finset.mem_filter.mpr ⟨Finset.mem_product.mpr
        ⟨Finset.mem_Icc.mpr ⟨hp'.two_le, hpN⟩, Finset.mem_Icc.mpr ⟨hj, hjN⟩⟩,
        hp', by simpa [hpow] using hnN⟩
    · intro a ha
      rcases Finset.mem_filter.mp ha with ⟨ha, hp, _⟩
      have hj := (Finset.mem_Icc.mp (Finset.mem_product.mp ha).2).1
      rw [ArithmeticFunction.vonMangoldt_apply_pow (by omega), ArithmeticFunction.vonMangoldt_apply_prime hp]
  have hQ : (∑ n ∈ Q, w n * ArithmeticFunction.vonMangoldt n) = (∑ n ∈ Finset.Icc 1 N, w n * ArithmeticFunction.vonMangoldt n) := by
    apply Finset.sum_subset (Finset.filter_subset _ _)
    intro n hn hnq
    rw [ArithmeticFunction.vonMangoldt_eq_zero_iff.mpr (fun h => hnq (Finset.mem_filter.mpr ⟨hn, h⟩)), mul_zero]
  rw [← hQ, ← hbij]
  dsimp only [P]
  rw [Finset.sum_filter, Finset.sum_product]
  apply Finset.sum_congr rfl
  intro p _
  by_cases hp : p.Prime
  · simp [hp]
  · simp [hp]


/-- The repository DistinctPrimeTent weighted-sum proof, using the existing local
SelbergDistinctPrimes and FloorRecurrence dependencies without redoing divisor regrouping. -/
theorem coefficient_weighted_sum (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N, w n * distinctPrimePairWeight n) =
      ∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 (N / a),
        if a.Coprime b then
          w (a * b) * ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b
        else 0 :=
  distinctPrimePairWeight_weighted_sum N w


private theorem weighted_filtered (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N, w n * ArithmeticFunction.vonMangoldt n) =
    ∑ p ∈ (Finset.Icc 2 N).filter Nat.Prime, ∑ j ∈ Finset.Icc 1 N,
      if p^j ≤ N then w (p^j)*Real.log p else 0 := by
  rw [Finset.sum_filter]
  exact weighted_prime_power_sum N w

/-- The central hyperbola is the full rectangle with the exact product cutoff. -/
private theorem coefficient_rectangle (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N, w n * distinctPrimePairWeight n) =
    ∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 N,
      (if a*b ≤ N ∧ a.Coprime b then w (a*b) else 0) *
        ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b := by
  rw [coefficient_weighted_sum]
  apply Finset.sum_congr rfl
  intro a ha
  have ha0 : 0 < a := (Finset.mem_Icc.mp ha).1
  calc
    _ = ∑ b ∈ Finset.Icc 1 (N/a),
        (if a*b ≤ N ∧ a.Coprime b then w (a*b) else 0) *
          ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b := by
      apply Finset.sum_congr rfl
      intro b hb
      have hab : a*b ≤ N := by
        have hh := (Nat.le_div_iff_mul_le ha0).mp (Finset.mem_Icc.mp hb).2
        simpa [Nat.mul_comm] using hh
      by_cases hc : a.Coprime b <;> simp [hc, hab]
    _ = _ := by
      apply Finset.sum_subset
      · intro b hb
        exact Finset.mem_Icc.mpr ⟨(Finset.mem_Icc.mp hb).1,
          (Finset.mem_Icc.mp hb).2.trans (Nat.div_le_self N a)⟩
      · intro b hb hbnot
        have hab : ¬a*b ≤ N := by
          intro h
          apply hbnot
          exact Finset.mem_Icc.mpr ⟨(Finset.mem_Icc.mp hb).1,
            (Nat.le_div_iff_mul_le ha0).mpr (by simpa [Nat.mul_comm] using h)⟩
        simp [hab]

private theorem double_weighted (N : ℕ) (w : ℕ → ℕ → ℝ) :
    (∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 N,
      w a b * ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b) =
    ∑ p ∈ (Finset.Icc 2 N).filter Nat.Prime, ∑ j ∈ Finset.Icc 1 N,
      ∑ q ∈ (Finset.Icc 2 N).filter Nat.Prime, ∑ k ∈ Finset.Icc 1 N,
        if p^j ≤ N ∧ q^k ≤ N then w (p^j) (q^k)*Real.log p*Real.log q else 0 := by
  have ho : (∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 N,
      w a b * ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b) =
      ∑ a ∈ Finset.Icc 1 N,
        (∑ b ∈ Finset.Icc 1 N, w a b * ArithmeticFunction.vonMangoldt b) *
          ArithmeticFunction.vonMangoldt a := by
    apply Finset.sum_congr rfl
    intro a _
    rw [Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro b _
    ring
  rw [ho, weighted_filtered]
  apply Finset.sum_congr rfl
  intro p hp
  apply Finset.sum_congr rfl
  intro j hj
  rw [weighted_filtered]
  by_cases hpj : p^j ≤ N
  · simp only [if_pos hpj, Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro q hq
    apply Finset.sum_congr rfl
    intro k hk
    by_cases hqk : q^k ≤ N <;> simp [hpj, hqk] <;> ring
  · simp [hpj]

/-- Exact ordered distinct-prime history parametrization of the repository coefficient. -/
theorem coefficient_history_sum (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N, w n * distinctPrimePairWeight n) =
    ∑ p ∈ (Finset.Icc 2 N).filter Nat.Prime,
      ∑ q ∈ ((Finset.Icc 2 N).filter Nat.Prime).erase p,
      ∑ j ∈ Finset.Icc 1 N, ∑ k ∈ Finset.Icc 1 N,
        if p^j*q^k ≤ N then w (p^j*q^k)*Real.log p*Real.log q else 0 := by
  classical
  rw [coefficient_rectangle, double_weighted]
  apply Finset.sum_congr rfl
  intro p hp
  rw [Finset.sum_comm]
  have hpprime := (Finset.mem_filter.mp hp).2
  have he : (∑ q ∈ (Finset.Icc 2 N).filter Nat.Prime,
      ∑ j ∈ Finset.Icc 1 N, ∑ k ∈ Finset.Icc 1 N,
        if p^j ≤ N ∧ q^k ≤ N then
          (if p^j*q^k ≤ N ∧ (p^j).Coprime (q^k) then w (p^j*q^k) else 0)*
            Real.log p*Real.log q else 0) =
      ∑ q ∈ (Finset.Icc 2 N).filter Nat.Prime,
      ∑ j ∈ Finset.Icc 1 N, ∑ k ∈ Finset.Icc 1 N,
        if p ≠ q ∧ p^j*q^k ≤ N then w (p^j*q^k)*Real.log p*Real.log q else 0 := by
    apply Finset.sum_congr rfl
    intro q hq
    have hqprime := (Finset.mem_filter.mp hq).2
    apply Finset.sum_congr rfl
    intro j hj
    apply Finset.sum_congr rfl
    intro k hk
    have hj0 : 0 < j := (Finset.mem_Icc.mp hj).1
    have hk0 : 0 < k := (Finset.mem_Icc.mp hk).1
    have hc : (p^j).Coprime (q^k) ↔ p ≠ q := by
      rw [Nat.coprime_pow_left_iff hj0, Nat.coprime_pow_right_iff hk0,
        Nat.coprime_primes hpprime hqprime]
    by_cases hprod : p^j*q^k ≤ N
    · have hpj : p^j ≤ N :=
        (Nat.le_mul_of_pos_right _ (pow_pos hqprime.pos _)).trans hprod
      have hqk : q^k ≤ N :=
        (Nat.le_mul_of_pos_left _ (pow_pos hpprime.pos _)).trans hprod
      simp only [hc]
      by_cases hpq : p = q <;> simp [hprod, hpj, hqk, hpq]
    · simp [hprod]
  rw [he]
  symm
  calc
    _ = ∑ q ∈ ((Finset.Icc 2 N).filter Nat.Prime).erase p,
        ∑ j ∈ Finset.Icc 1 N, ∑ k ∈ Finset.Icc 1 N,
          if p ≠ q ∧ p^j*q^k ≤ N then w (p^j*q^k)*Real.log p*Real.log q else 0 := by
      apply Finset.sum_congr rfl
      intro q hq
      have hpq : p ≠ q := Ne.symm (Finset.ne_of_mem_erase hq)
      simp [hpq]
    _ = _ := by
      apply Finset.sum_subset (Finset.erase_subset _ _)
      intro q hq hnot
      have heq : q = p := by
        by_contra h
        exact hnot (Finset.mem_erase.mpr ⟨h, hq⟩)
      subst q
      simp

/-- The actual history tent equals the repository's complete distinct-prime coefficient tent. -/
theorem distinct_history_coefficient (s : ℝ) :
    distinctArithmetic s = ∑ n ∈ Finset.Icc 1 ⌊Real.exp s⌋₊,
      (Real.exp s - n)*distinctPrimePairWeight n := by
  rw [coefficient_history_sum]
  unfold distinctArithmetic pairArithmetic primesAt
  apply Finset.sum_congr rfl
  intro p hp
  apply Finset.sum_congr rfl
  intro q hq
  apply Finset.sum_congr rfl
  intro j hj
  apply Finset.sum_congr rfl
  intro k hk
  have hcut : p^j*q^k ≤ ⌊Real.exp s⌋₊ ↔ (p : ℝ)^j*(q : ℝ)^k ≤ Real.exp s := by
    rw [Nat.le_floor_iff (Real.exp_pos s).le, Nat.cast_mul, Nat.cast_pow, Nat.cast_pow]
  simp only [hcut, Nat.cast_mul, Nat.cast_pow]

/-- Coefficient-defined V before causal restriction, using the repository's exact coefficient. -/
noncomputable def coefficientRawV (x : ℝ) : ℝ :=
  (∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (x-n)*distinctPrimePairWeight n) -
  (∑ n ∈ Finset.Icc 1 ⌊x⌋₊,
    ArithmeticFunction.vonMangoldt n*(x^2-(n : ℝ)^2)/n) +
  (x^2*Real.log x/2+x^2/4-1/4)

/-- Original causal coefficient convention, including x=1. -/
noncomputable def coefficientV (x : ℝ) : ℝ := if x ≤ 1 then 0 else coefficientRawV x

theorem rawV_eq_coefficientRawV {x : ℝ} (hx : 0 < x) : rawV x = coefficientRawV x := by
  have hh := distinct_history_coefficient (Real.log x)
  simp only [Real.exp_log hx] at hh
  unfold distinctArithmetic pairArithmetic primesAt at hh
  simp only [Real.exp_log hx] at hh
  unfold rawV coefficientRawV
  rw [hh]

/-- The history and repository-coefficient definitions agree at every real cutoff. -/
theorem V_eq_coefficientV (x : ℝ) : V x = coefficientV x := by
  by_cases hx : x ≤ 1
  · simp [V, coefficientV, hx]
  · simp only [V, coefficientV, if_neg hx]
    exact rawV_eq_coefficientRawV (by linarith)

/-- Final actual-source calibration with the coefficient-defined causal V. -/
theorem actual_source_eq_coefficientV {s : ℝ} (hs : 0 ≤ s) :
    ReflectionFilter.L0 (conv PrimeBlockSource.source PrimeBlockSource.source) s -
      SamePrimeBlockCalibration.tau s = Real.exp (-3*s/2)*coefficientV (Real.exp s) := by
  rw [actual_source_eq_normalized_V hs, V_eq_coefficientV]

#print axioms weighted_prime_power_sum
#print axioms coefficient_history_sum
#print axioms distinct_history_coefficient
#print axioms V_eq_coefficientV
#print axioms actual_source_eq_coefficientV

end BuildingBlocks.PrimeHistoryCoefficientIdentification
