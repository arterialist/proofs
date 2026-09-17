import BuildingBlocks.CenteredGoldbachAdjacentTotalsFinite

/-! The actual bounded odd Goldbach row reindexed by its power-of-two source. -/

namespace BuildingBlocks.GoldbachOddPowerBoundFinite

open scoped BigOperators
open Finset Real
open BuildingBlocks.CenteredGoldbachAdjacentTotalsFinite

noncomputable section

private def powerSupport (Y : ℕ) : Finset ℕ :=
  (Icc 1 Y).filter (fun m => Even m ∧ ArithmeticFunction.vonMangoldt m ≠ 0)

private theorem powerSupport_eq_image (Y : ℕ) :
    powerSupport Y = (Icc 1 (Nat.log 2 Y)).image (fun k => 2 ^ k) := by
  ext m
  simp only [powerSupport, mem_filter, mem_Icc, mem_image]
  constructor
  · rintro ⟨⟨hm1, hmY⟩, he, hn⟩
    obtain ⟨k, hk, hpow, _⟩ :=
      BuildingBlocks.GoldbachOddCentering.even_nonzero_vonMangoldt he hn
    refine ⟨k, ⟨hk, ?_⟩, hpow.symm⟩
    exact Nat.le_log_of_pow_le (by omega) (hpow ▸ hmY)
  · rintro ⟨k, ⟨hk, hklog⟩, rfl⟩
    have hY : Y ≠ 0 := by
      intro h
      subst Y
      simp at hklog
      omega
    have hpow : 2 ^ k ≤ Y := (Nat.le_log_iff_pow_le (by omega) hY).1 hklog
    have hpos : 1 ≤ 2 ^ k := pow_pos (by omega : 0 < (2 : ℕ)) k
    have he : Even (2 ^ k) := even_two.pow_of_ne_zero (by omega)
    have hn : ArithmeticFunction.vonMangoldt (2 ^ k) ≠ 0 :=
      (BuildingBlocks.GoldbachOddCentering.even_vonMangoldt_support he).2
        ⟨k, hk, rfl⟩
    exact ⟨⟨hpos, hpow⟩, he, hn⟩

/-- The entire even von Mangoldt row through Y consists of the powers
of two, each with its literal weight log 2. -/
theorem even_vonMangoldt_sum (Y : ℕ) :
    (∑ m ∈ Icc 1 Y,
      if Even m then ArithmeticFunction.vonMangoldt m else 0) =
      (Nat.log 2 Y : ℝ) * Real.log 2 := by
  have hsupport :
      (∑ m ∈ Icc 1 Y,
        if Even m then ArithmeticFunction.vonMangoldt m else 0) =
        ∑ m ∈ powerSupport Y, ArithmeticFunction.vonMangoldt m := by
    unfold powerSupport
    rw [Finset.sum_filter]
    apply Finset.sum_congr rfl
    intro m hm
    by_cases he : Even m
    · by_cases hn : ArithmeticFunction.vonMangoldt m = 0
      · simp [he, hn]
      · simp [he, hn]
    · simp [he]
  rw [hsupport, powerSupport_eq_image]
  rw [Finset.sum_image (fun _ _ _ _ h => Nat.pow_right_injective (by omega) h)]
  have hpow (k : ℕ) (hk : k ∈ Icc 1 (Nat.log 2 Y)) :
      ArithmeticFunction.vonMangoldt (2 ^ k) = Real.log 2 := by
    have hk1 : 1 ≤ k := (Finset.mem_Icc.mp hk).1
    rw [ArithmeticFunction.vonMangoldt_apply_pow (by omega),
      ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two]
    norm_num
  calc
    (∑ k ∈ Icc 1 (Nat.log 2 Y),
      ArithmeticFunction.vonMangoldt (2 ^ k)) =
        ∑ k ∈ Icc 1 (Nat.log 2 Y), Real.log 2 := by
          apply Finset.sum_congr rfl
          intro k hk
          exact hpow k hk
    _ = _ := by simp [nsmul_eq_mul]

private theorem innerPair (Y m N : ℕ) :
    (∑ n ∈ Icc 1 Y,
      if m + n = N then ArithmeticFunction.vonMangoldt m *
        ArithmeticFunction.vonMangoldt n else 0) =
      if m ≤ N ∧ N - m ∈ Icc 1 Y then
        ArithmeticFunction.vonMangoldt m * ArithmeticFunction.vonMangoldt (N - m)
      else 0 := by
  by_cases hm : m ≤ N
  · have hiff (n : ℕ) : m + n = N ↔ n = N - m := by omega
    simp_rw [hiff]
    rw [Finset.sum_ite_eq']
    simp [hm]
  · have hzero : ∀ n ∈ Icc 1 Y, m + n ≠ N := by
      intro n hn
      omega
    rw [if_neg (by simp [hm])]
    apply Finset.sum_eq_zero
    intro n hn
    simp [hzero n hn]

private theorem evenPrimeRow_eq_sum (Y N : ℕ) :
    evenPrimeRow Y N =
      ∑ m ∈ Icc 1 Y,
        if Even m ∧ m ≤ N ∧ N - m ∈ Icc 1 Y then
          ArithmeticFunction.vonMangoldt m * ArithmeticFunction.vonMangoldt (N - m)
        else 0 := by
  unfold evenPrimeRow
  apply Finset.sum_congr rfl
  intro m hm
  by_cases he : Even m
  · simp only [he, and_true, true_and]
    simpa only [ite_and, if_true] using innerPair Y m N
  · simp [he]

private theorem evenPrimeRow_eq_support (Y N : ℕ) :
    evenPrimeRow Y N =
      ∑ m ∈ powerSupport Y,
        if m ≤ N ∧ N - m ∈ Icc 1 Y then
          ArithmeticFunction.vonMangoldt m * ArithmeticFunction.vonMangoldt (N - m)
        else 0 := by
  rw [evenPrimeRow_eq_sum]
  unfold powerSupport
  rw [Finset.sum_filter]
  apply Finset.sum_congr rfl
  intro m hm
  by_cases he : Even m
  · by_cases hn : ArithmeticFunction.vonMangoldt m = 0
    · simp [he, hn]
    · simp [he, hn]
  · simp [he]

/-- Exact odd raw Goldbach coefficient at source cutoff `Y`. The second
index is `N-2^k`, so all odd prime powers and both moving source endpoints
are retained. -/
theorem odd_primeCoefficient_power_sum {N : ℕ} (hodd : Odd N) (Y : ℕ) :
    BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedPrimeCoefficient Y N =
      2 * Real.log 2 *
        ∑ k ∈ Icc 1 (Nat.log 2 Y),
          if 2 ^ k ≤ N ∧ N - 2 ^ k ∈ Icc 1 Y then
            ArithmeticFunction.vonMangoldt (N - 2 ^ k) else 0 := by
  rw [odd_primeCoefficient_eq_two_evenPrimeRow hodd,
    evenPrimeRow_eq_support, powerSupport_eq_image]
  rw [Finset.sum_image (fun _ _ _ _ h => Nat.pow_right_injective (by omega) h)]
  have hpow (k : ℕ) (hk : k ∈ Icc 1 (Nat.log 2 Y)) :
      ArithmeticFunction.vonMangoldt (2 ^ k) = Real.log 2 := by
    have hk1 : 1 ≤ k := (Finset.mem_Icc.mp hk).1
    rw [ArithmeticFunction.vonMangoldt_apply_pow (by omega),
      ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two]
    norm_num
  change 2 * (∑ k ∈ Icc 1 (Nat.log 2 Y),
      if 2 ^ k ≤ N ∧ N - 2 ^ k ∈ Icc 1 Y then
        ArithmeticFunction.vonMangoldt (2 ^ k) *
          ArithmeticFunction.vonMangoldt (N - 2 ^ k) else 0) = _
  calc
    _ = 2 * (∑ k ∈ Icc 1 (Nat.log 2 Y),
        Real.log 2 * (if 2 ^ k ≤ N ∧ N - 2 ^ k ∈ Icc 1 Y then
          ArithmeticFunction.vonMangoldt (N - 2 ^ k) else 0)) := by
      congr 1
      apply Finset.sum_congr rfl
      intro k hk
      rw [hpow k hk]
      split_ifs <;> ring
    _ = _ := by rw [← Finset.mul_sum]; ring

private def admissible (Y N : ℕ) : Finset ℕ :=
  (Icc 1 (Nat.log 2 Y)).filter
    (fun k => 2 ^ k ≤ N ∧ N - 2 ^ k ∈ Icc 1 Y)

private theorem admissible_subset (Y N : ℕ) :
    admissible Y N ⊆ Icc 1 (Nat.log 2 N) := by
  intro k hk
  obtain ⟨hkI, hkcond⟩ := Finset.mem_filter.mp hk
  have hk1 := (Finset.mem_Icc.mp hkI).1
  have hkN : k ≤ Nat.log 2 N := Nat.le_log_of_pow_le (by omega) hkcond.1
  exact Finset.mem_Icc.mpr ⟨hk1, hkN⟩

private theorem admissible_card_le (Y N : ℕ) :
    (admissible Y N).card ≤ Nat.log 2 N := by
  have h := Finset.card_le_card (admissible_subset Y N)
  simpa using h

/-- A uniform finite-cutoff bound retaining the logarithmic count of
possible powers of two, before the real-log comparison. -/
theorem odd_primeCoefficient_le_log_count {N : ℕ} (hodd : Odd N) (Y : ℕ) :
    BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedPrimeCoefficient Y N ≤
      2 * Real.log 2 * (Nat.log 2 N : ℝ) * Real.log (N : ℝ) := by
  rw [odd_primeCoefficient_power_sum hodd]
  have hsum :
      (∑ k ∈ Icc 1 (Nat.log 2 Y),
          if 2 ^ k ≤ N ∧ N - 2 ^ k ∈ Icc 1 Y then
            ArithmeticFunction.vonMangoldt (N - 2 ^ k) else 0) =
        ∑ k ∈ admissible Y N, ArithmeticFunction.vonMangoldt (N - 2 ^ k) := by
    simp [admissible, Finset.sum_filter]
  rw [hsum]
  have hterm : ∀ k ∈ admissible Y N,
      ArithmeticFunction.vonMangoldt (N - 2 ^ k) ≤ Real.log (N : ℝ) := by
    intro k hk
    have hle : N - 2 ^ k ≤ N := Nat.sub_le N _
    have hpos : 1 ≤ N - 2 ^ k :=
      (Finset.mem_Icc.mp (Finset.mem_filter.mp hk).2.2).1
    exact (ArithmeticFunction.vonMangoldt_le_log).trans
      (Real.log_le_log (by exact_mod_cast hpos) (by exact_mod_cast hle))
  have hsumle :
      (∑ k ∈ admissible Y N, ArithmeticFunction.vonMangoldt (N - 2 ^ k)) ≤
        (admissible Y N).card * Real.log (N : ℝ) := by
    calc
      _ ≤ ∑ k ∈ admissible Y N, Real.log (N : ℝ) :=
        Finset.sum_le_sum hterm
      _ = _ := by simp [nsmul_eq_mul]
  have hlog_nonneg : 0 ≤ Real.log (N : ℝ) := by
    have hN : 1 ≤ N := by
      by_contra h
      interval_cases N; simp_all
    exact Real.log_nonneg (by exact_mod_cast hN)
  have hcard := admissible_card_le Y N
  have hcount : (admissible Y N).card * Real.log (N : ℝ) ≤
      (Nat.log 2 N : ℝ) * Real.log (N : ℝ) := by
    exact mul_le_mul_of_nonneg_right (by exact_mod_cast hcard) hlog_nonneg
  have hfactor : 0 ≤ 2 * Real.log 2 := by positivity
  nlinarith [mul_le_mul_of_nonneg_left (hsumle.trans hcount) hfactor]

private theorem log_count_le_log {N : ℕ} (hN : N ≠ 0) :
    (Nat.log 2 N : ℝ) * Real.log 2 ≤ Real.log (N : ℝ) := by
  have hpow : (2 : ℝ) ^ Nat.log 2 N ≤ (N : ℝ) := by
    exact_mod_cast Nat.pow_log_le_self 2 hN
  have hlog := Real.log_le_log (by positivity : 0 < (2 : ℝ) ^ Nat.log 2 N) hpow
  simpa [Real.log_pow] using hlog

/-- The complete logarithmic odd-total bound is uniform in the source
cutoff and retains all admissible prime powers. -/
theorem odd_primeCoefficient_le_two_log_sq {N : ℕ} (hodd : Odd N) (Y : ℕ) :
    BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedPrimeCoefficient Y N ≤
      2 * (Real.log (N : ℝ)) ^ 2 := by
  have hN : N ≠ 0 := by
    rcases hodd with ⟨k, hk⟩
    omega
  have hlog := log_count_le_log hN
  have hbound := odd_primeCoefficient_le_log_count hodd Y
  have hnonneg : 0 ≤ Real.log (N : ℝ) := by
    apply Real.log_nonneg
    exact_mod_cast Nat.one_le_iff_ne_zero.mpr hN
  have hmul := mul_le_mul_of_nonneg_right hlog hnonneg
  nlinarith [hmul]

#print axioms odd_primeCoefficient_power_sum
#print axioms even_vonMangoldt_sum
#print axioms odd_primeCoefficient_le_log_count
#print axioms odd_primeCoefficient_le_two_log_sq

end
end BuildingBlocks.GoldbachOddPowerBoundFinite
