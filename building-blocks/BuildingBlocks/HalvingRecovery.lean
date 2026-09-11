import BuildingBlocks.SecondWindow

open Finset Filter Set MeasureTheory
open scoped Topology BigOperators Interval

namespace BuildingBlocks

open MertensTransfer CoarsePrimitive FloorCorrection HyperbolaProduct

theorem sqrt_nat_half_le (N : ℕ) :
    Real.sqrt ((N / 2 : ℕ) : ℝ) ≤ (3 / 4 : ℝ) * Real.sqrt (N : ℝ) := by
  have hh : ((N / 2 : ℕ) : ℝ) ≤ (N : ℝ) / 2 := by
    simpa using (Nat.cast_div_le (α := ℝ) (m := N) (n := 2))
  apply (sq_le_sq₀ (Real.sqrt_nonneg _) (by positivity)).mp
  nlinarith [Real.sq_sqrt (Nat.cast_nonneg N), Real.sq_sqrt (Nat.cast_nonneg (N / 2))]

/-- A small halving sum forces a small sequence, up to a fixed finite prefix. -/
theorem halving_recovery_bound (a : ℕ → ℝ) {K : ℕ} (hK : 0 < K) {δ : ℝ} (hδ : 0 ≤ δ)
    (h : ∀ N : ℕ, K ≤ N → |a N + a (N / 2)| ≤ δ * Real.sqrt (N : ℝ)) :
    ∃ B : ℝ, 0 ≤ B ∧ ∀ N : ℕ, |a N| ≤ 4 * δ * Real.sqrt (N : ℝ) + B := by
  let B : ℝ := ∑ k ∈ Finset.range K, |a k|
  have hB : 0 ≤ B := Finset.sum_nonneg (fun k hk => abs_nonneg _)
  refine ⟨B, hB, ?_⟩
  intro N
  induction N using Nat.strong_induction_on with
  | h N ih =>
    by_cases hNK : N < K
    · have hh : |a N| ≤ B := Finset.single_le_sum (f := fun k => |a k|) (fun k hk => abs_nonneg _)
        (Finset.mem_range.mpr hNK)
      exact hh.trans (le_add_of_nonneg_left (by positivity))
    · have hn : 0 < N := lt_of_lt_of_le hK (le_of_not_gt hNK)
      have hi := ih (N / 2) (Nat.div_lt_self hn (by omega : 1 < 2))
      have hs := h N (le_of_not_gt hNK)
      have hhalf := mul_le_mul_of_nonneg_left (sqrt_nat_half_le N)
        (show 0 ≤ 4 * δ by positivity)
      have ht : |a N| ≤ |a N + a (N / 2)| + |a (N / 2)| := by
        calc
          |a N| = |(a N + a (N / 2)) - a (N / 2)| := by congr 1; ring
          _ ≤ _ := abs_sub _ _
      linarith

theorem tendsto_inv_sqrt_nat :
    Tendsto (fun N : ℕ => 1 / Real.sqrt (N : ℝ)) atTop (𝓝 0) := by
  have hi : Tendsto (fun N : ℕ => (N : ℝ)⁻¹) atTop (𝓝 0) :=
    tendsto_inv_atTop_zero.comp tendsto_natCast_atTop_atTop
  simpa only [Real.sqrt_inv, Real.sqrt_zero, one_div] using hi.sqrt

theorem halving_recovery_tendsto (a : ℕ → ℝ)
    (h : Tendsto (fun N : ℕ => (a N + a (N / 2)) / Real.sqrt (N : ℝ)) atTop (𝓝 0)) :
    Tendsto (fun N : ℕ => a N / Real.sqrt (N : ℝ)) atTop (𝓝 0) := by
  apply Metric.tendsto_atTop.mpr
  intro ε hε
  obtain ⟨K, hK⟩ := Metric.tendsto_atTop.mp h (ε / 8) (by positivity)
  have he : ∀ N : ℕ, max K 1 ≤ N →
      |a N + a (N / 2)| ≤ (ε / 8) * Real.sqrt (N : ℝ) := by
    intro N hN
    have hn : 0 < N := by have := (le_max_right K 1).trans hN; omega
    have hp : 0 < Real.sqrt (N : ℝ) := Real.sqrt_pos.mpr (by exact_mod_cast hn)
    have hh := hK N ((le_max_left K 1).trans hN)
    simp only [Real.dist_eq, sub_zero, abs_div, abs_of_nonneg (Real.sqrt_nonneg (N : ℝ))] at hh
    exact (div_le_iff₀ hp).mp hh.le
  obtain ⟨B, hB, hbound⟩ := halving_recovery_bound a
    (show 0 < max K 1 by omega) (show 0 ≤ ε / 8 by positivity) he
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
  have hrew : (4 * (ε / 8) * Real.sqrt (N : ℝ) + B) / Real.sqrt (N : ℝ) =
      ε / 2 + B / Real.sqrt (N : ℝ) := by field_simp; ring
  rw [hrew] at hb
  simp only [Real.dist_eq, sub_zero, abs_div, abs_of_nonneg (Real.sqrt_nonneg (N : ℝ))]
  linarith

theorem normalized_ratio_tendsto_of_square (a : ℕ → ℝ)
    (h : Tendsto (fun N : ℕ => a N ^ 2 / (N : ℝ)) atTop (𝓝 0)) :
    Tendsto (fun N : ℕ => a N / Real.sqrt (N : ℝ)) atTop (𝓝 0) := by
  have hs := h.sqrt
  simp_rw [Real.sqrt_div (sq_nonneg _), Real.sqrt_sq_eq_abs, Real.sqrt_zero] at hs
  apply tendsto_zero_iff_norm_tendsto_zero.mpr
  simpa only [Real.norm_eq_abs, abs_div, abs_of_nonneg (Real.sqrt_nonneg (↑_))] using hs

theorem normalized_square_tendsto_of_ratio (a : ℕ → ℝ)
    (h : Tendsto (fun N : ℕ => a N / Real.sqrt (N : ℝ)) atTop (𝓝 0)) :
    Tendsto (fun N : ℕ => a N ^ 2 / (N : ℝ)) atTop (𝓝 0) := by
  have hs := h.pow 2
  simpa only [div_pow, Real.sq_sqrt (Nat.cast_nonneg _), ne_eq, OfNat.ofNat_ne_zero,
    not_false_eq_true, zero_pow] using hs

theorem mertens_sq_tendsto_of_meanCorrectedConvergence (h : MeanCorrectedConvergence) :
    Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0) := by
  have hc := normalized_ratio_tendsto_of_square secondWindowCoefficient
    (secondWindowCoefficient_sq_tendsto_of_corrected_convergence h)
  have hd : Tendsto (fun N : ℕ => ((mertens N : ℝ) + (mertens (N / 2) : ℝ)) /
      Real.sqrt (N : ℝ)) atTop (𝓝 0) := by
    have hh := hc.sub (tendsto_inv_sqrt_nat.const_mul 3)
    have he (N : ℕ) : secondWindowCoefficient N / Real.sqrt (N : ℝ) -
        3 * (1 / Real.sqrt (N : ℝ)) =
          ((mertens N : ℝ) + (mertens (N / 2) : ℝ)) / Real.sqrt (N : ℝ) := by
      dsimp [secondWindowCoefficient]
      ring
    simpa only [he, mul_zero, sub_self] using hh
  exact normalized_square_tendsto_of_ratio _ (halving_recovery_tendsto _ hd)

/-- The correction still fails under the same explicit, established Mertens
oscillation premise used for the original approximation. -/
theorem meanCorrectedConvergence_false_of_mertens_oscillation
    (hM : ¬ Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0)) :
    ¬ MeanCorrectedConvergence :=
  fun h => hM (mertens_sq_tendsto_of_meanCorrectedConvergence h)

end BuildingBlocks
