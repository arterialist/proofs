import BuildingBlocks.HalvingRecovery

open Finset Filter Set MeasureTheory
open scoped Topology BigOperators Interval

namespace BuildingBlocks

open MertensTransfer CoarsePrimitive FloorCorrection HyperbolaProduct

/-- Recovery from differences along any fixed contraction of the index. -/
theorem contraction_recovery_bound (a : ℕ → ℝ) (T : ℕ → ℕ) {r : ℝ}
    (hr1 : r < 1)
    (hT : ∀ N, 0 < N → T N < N)
    (hs : ∀ N, Real.sqrt (T N : ℝ) ≤ r * Real.sqrt (N : ℝ))
    {K : ℕ} (hK : 0 < K) {δ : ℝ} (hδ : 0 ≤ δ)
    (h : ∀ N, K ≤ N → |a N - a (T N)| ≤ δ * Real.sqrt (N : ℝ)) :
    ∃ B : ℝ, 0 ≤ B ∧ ∀ N,
      |a N| ≤ (δ / (1 - r)) * Real.sqrt (N : ℝ) + B := by
  let B : ℝ := ∑ k ∈ Finset.range K, |a k|
  have hB : 0 ≤ B := Finset.sum_nonneg (fun k hk => abs_nonneg _)
  have hden : 0 < 1 - r := sub_pos.mpr hr1
  refine ⟨B, hB, ?_⟩
  intro N
  induction N using Nat.strong_induction_on with
  | h N ih =>
    by_cases hNK : N < K
    · have hh : |a N| ≤ B := Finset.single_le_sum (f := fun k => |a k|)
        (fun k hk => abs_nonneg _) (Finset.mem_range.mpr hNK)
      exact hh.trans (le_add_of_nonneg_left (by positivity))
    · have hn : 0 < N := lt_of_lt_of_le hK (le_of_not_gt hNK)
      have hi := ih (T N) (hT N hn)
      have hd := h N (le_of_not_gt hNK)
      have hc := mul_le_mul_of_nonneg_left (hs N)
        (div_nonneg hδ hden.le)
      have ht : |a N| ≤ |a N - a (T N)| + |a (T N)| := by
        calc
          |a N| = |(a N - a (T N)) + a (T N)| := by congr 1; ring
          _ ≤ _ := abs_add_le _ _
      have he : δ * Real.sqrt (N : ℝ) +
          δ / (1 - r) * (r * Real.sqrt (N : ℝ)) =
          δ / (1 - r) * Real.sqrt (N : ℝ) := by field_simp; ring
      linarith

theorem contraction_recovery_tendsto (a : ℕ → ℝ) (T : ℕ → ℕ) {r : ℝ}
    (hr1 : r < 1)
    (hT : ∀ N, 0 < N → T N < N)
    (hs : ∀ N, Real.sqrt (T N : ℝ) ≤ r * Real.sqrt (N : ℝ))
    (h : Tendsto (fun N : ℕ => (a N - a (T N)) / Real.sqrt (N : ℝ)) atTop (𝓝 0)) :
    Tendsto (fun N : ℕ => a N / Real.sqrt (N : ℝ)) atTop (𝓝 0) := by
  have hden : 0 < 1 - r := sub_pos.mpr hr1
  apply Metric.tendsto_atTop.mpr
  intro ε hε
  let δ := ε * (1 - r) / 2
  have hδ : 0 < δ := by dsimp [δ]; positivity
  obtain ⟨K, hK⟩ := Metric.tendsto_atTop.mp h δ hδ
  have he : ∀ N : ℕ, max K 1 ≤ N →
      |a N - a (T N)| ≤ δ * Real.sqrt (N : ℝ) := by
    intro N hN
    have hn : 0 < N := by have := (le_max_right K 1).trans hN; omega
    have hp : 0 < Real.sqrt (N : ℝ) := Real.sqrt_pos.mpr (by exact_mod_cast hn)
    have hh := hK N ((le_max_left K 1).trans hN)
    simp only [Real.dist_eq, sub_zero, abs_div, abs_of_nonneg (Real.sqrt_nonneg (N : ℝ))] at hh
    exact (div_le_iff₀ hp).mp hh.le
  obtain ⟨B, hB, hbound⟩ := contraction_recovery_bound a T hr1 hT hs
    (show 0 < max K 1 by omega) hδ.le he
  have ht : Tendsto (fun N : ℕ => B / Real.sqrt (N : ℝ)) atTop (𝓝 0) := by
    simpa only [mul_zero, mul_one_div] using tendsto_inv_sqrt_nat.const_mul B
  obtain ⟨L, hL⟩ := Metric.tendsto_atTop.mp ht (ε / 2) (by positivity)
  refine ⟨max (max K 1) L, fun N hN => ?_⟩
  have hn : 0 < N := by have := (le_max_left (max K 1) L).trans hN; omega
  have hp : 0 < Real.sqrt (N : ℝ) := Real.sqrt_pos.mpr (by exact_mod_cast hn)
  have htail := hL N ((le_max_right (max K 1) L).trans hN)
  simp only [Real.dist_eq, sub_zero] at htail
  have htail' := (le_abs_self (B / Real.sqrt (N : ℝ))).trans_lt htail
  have hb := div_le_div_of_nonneg_right (hbound N) hp.le
  have hrew : (δ / (1 - r) * Real.sqrt (N : ℝ) + B) / Real.sqrt (N : ℝ) =
      ε / 2 + B / Real.sqrt (N : ℝ) := by dsimp [δ]; field_simp
  rw [hrew] at hb
  simp only [Real.dist_eq, sub_zero, abs_div, abs_of_nonneg (Real.sqrt_nonneg (N : ℝ))]
  linarith

theorem sqrt_quotient_contraction (q N : ℕ) :
    Real.sqrt ((q * N / (q + 1) : ℕ) : ℝ) ≤
      Real.sqrt ((q : ℝ) / ((q : ℝ) + 1)) * Real.sqrt (N : ℝ) := by
  rw [← Real.sqrt_mul (by positivity : 0 ≤ (q : ℝ) / ((q : ℝ) + 1))]
  apply Real.sqrt_le_sqrt
  have hh := Nat.cast_div_le (α := ℝ) (m := q * N) (n := q + 1)
  push_cast at hh
  convert hh using 1
  ring

theorem quotient_difference_recovery (a : ℕ → ℝ) (q : ℕ)
    (h : Tendsto (fun N : ℕ => (a N - a (q * N / (q + 1))) /
      Real.sqrt (N : ℝ)) atTop (𝓝 0)) :
    Tendsto (fun N : ℕ => a N / Real.sqrt (N : ℝ)) atTop (𝓝 0) := by
  apply contraction_recovery_tendsto a (fun N => q * N / (q + 1))
    ?_ ?_ (sqrt_quotient_contraction q) h
  · apply (Real.sqrt_lt' (by norm_num : (0 : ℝ) < 1)).mpr
    norm_num only [one_pow]
    apply (div_lt_one (by positivity : (0 : ℝ) < (q : ℝ) + 1)).mpr
    linarith
  · intro N hN
    apply (Nat.div_lt_iff_lt_mul (by omega : 0 < q + 1)).mpr
    nlinarith

/-- A single fixed quotient coefficient being little-o of sqrt N already
forces the same smallness for the entire Mertens sequence. -/
theorem mertens_ratio_tendsto_of_fixed_quotient {q : ℕ} (hq : 0 < q)
    (h : Tendsto (fun N : ℕ => (quotientCoefficient N q : ℝ) /
      Real.sqrt (N : ℝ)) atTop (𝓝 0)) :
    Tendsto (fun N : ℕ => (mertens N : ℝ) / Real.sqrt (N : ℝ)) atTop (𝓝 0) := by
  have hmul : Tendsto (fun N : ℕ => q * N) atTop atTop := by
    apply tendsto_atTop_mono (fun N => ?_) tendsto_id
    change N ≤ q * N
    nlinarith
  have ht := (h.comp hmul).const_mul (Real.sqrt (q : ℝ))
  have hqR : (0 : ℝ) < (q : ℝ) := by exact_mod_cast hq
  have he (N : ℕ) : Real.sqrt (q : ℝ) *
      ((quotientCoefficient (q * N) q : ℝ) / Real.sqrt ((q * N : ℕ) : ℝ)) =
      ((mertens N : ℝ) - (mertens (q * N / (q + 1)) : ℝ)) /
        Real.sqrt (N : ℝ) := by
    rw [quotientCoefficient_eq_mertens (q * N) hq, Int.cast_sub,
      Nat.mul_div_right N hq, Nat.cast_mul, Real.sqrt_mul (Nat.cast_nonneg q)]
    have hsq : Real.sqrt (q : ℝ) ≠ 0 := (Real.sqrt_pos.mpr hqR).ne'
    field_simp
  apply quotient_difference_recovery (fun N => (mertens N : ℝ)) q
  simpa only [Function.comp_apply, he, mul_zero] using ht

theorem fixed_quotient_not_small_of_mertens_oscillation {q : ℕ} (hq : 0 < q)
    (hM : ¬ Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0)) :
    ¬ Tendsto (fun N : ℕ => (quotientCoefficient N q : ℝ) /
      Real.sqrt (N : ℝ)) atTop (𝓝 0) := by
  intro h
  exact hM (normalized_square_tendsto_of_ratio _ (mertens_ratio_tendsto_of_fixed_quotient hq h))

end BuildingBlocks
