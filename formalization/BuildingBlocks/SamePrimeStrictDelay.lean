import BuildingBlocks.SamePrimeFirstSquare
import BuildingBlocks.SamePrimeHistoryProbability

open Finset MeasureTheory
open scoped BigOperators ENNReal

namespace BuildingBlocks.SamePrimeStrictDelay

open SamePrimeAggregationMonotone SamePrimeHistoryResidual SamePrimeFirstSquare
open SamePrimeHistoryProbability

/-- Strict growth across the exact integer activation boundaries. -/
theorem H_strictMonoOn : StrictMonoOn H (Set.Ici 1) := by
  intro x hx y hy hxy
  let k : ℕ := ⌊x⌋₊
  have hk : 1 ≤ k := (Nat.one_le_floor_iff x).mpr hx
  have hkx : (k : ℝ) ≤ x := Nat.floor_le (zero_le_one.trans hx)
  have hxk : x < (k : ℝ) + 1 := Nat.lt_floor_add_one x
  have hxcell : x ∈ Set.Icc (k : ℝ) ((k : ℝ) + 1) := ⟨hkx, hxk.le⟩
  by_cases hyk : y ≤ (k : ℝ) + 1
  · exact H_strictMonoOn_cell hk hxcell ⟨hkx.trans hxy.le, hyk⟩ hxy
  · have hboundary : H x < H ((k : ℝ) + 1) :=
      H_strictMonoOn_cell hk hxcell ⟨by linarith, le_rfl⟩ hxk
    exact hboundary.trans_le (H_monotoneOn
      (show 1 ≤ (k : ℝ) + 1 by exact_mod_cast (by omega : 1 ≤ k + 1))
      hy (le_of_not_ge hyk))

theorem h_strictMonoOn : StrictMonoOn h (Set.Ici 0) := by
  intro u hu v hv huv
  exact H_strictMonoOn (Real.one_le_exp_iff.mpr hu) (Real.one_le_exp_iff.mpr hv)
    (Real.exp_lt_exp.mpr huv)

private theorem log_four : Real.log (4 : ℝ) = 2 * Real.log 2 := by
  have hh := Real.log_pow (2 : ℝ) 2
  norm_num at hh
  exact hh

/-- The first square alone grows strictly once its exact zero birth is reached. -/
theorem first_square_strict {u v : ℝ} (hu : Real.log 4 ≤ u) (huv : u < v) :
    term 2 2 u < term 2 2 v := by
  have hu0 : 0 ≤ u - (2 : ℝ) * Real.log 2 := by rw [log_four] at hu; linarith
  have hv0 : 0 ≤ v - (2 : ℝ) * Real.log 2 := by linarith
  unfold term
  rw [weight_two_two]
  norm_num only [Nat.cast_ofNat]
  exact mul_lt_mul_of_pos_left (h_strictMonoOn hu0 hv0 (sub_lt_sub_right huv _))
    (div_pos (sq_pos_of_pos (Real.log_pos (by norm_num))) (by norm_num))

/-- All other actual histories are retained with their nondecreasing contributions. -/
theorem s_strictMonoOn : StrictMonoOn s (Set.Ici (Real.log 4)) := by
  intro u hu v _ huv
  have hpow : (((2 : ℕ) ^ 2 : ℕ) : ℝ) ≤ Real.exp u := by
    have hh := Real.exp_le_exp.mpr hu
    rw [Real.exp_log (by norm_num : (0 : ℝ) < 4)] at hh
    norm_num only [Nat.reducePow, Nat.cast_ofNat]
    exact hh
  obtain ⟨hpMem, hmMem⟩ := active_history_covered Nat.prime_two (by norm_num : 2 ≤ (2 : ℕ)) hpow
  have hstrict : partialSum ⌊Real.exp u⌋₊ u < partialSum ⌊Real.exp u⌋₊ v := by
    unfold partialSum
    apply Finset.sum_lt_sum
    · intro p _
      split_ifs
      · exact Finset.sum_le_sum (fun m _ => term_monotone p m huv.le)
      · exact le_rfl
    · refine ⟨2, hpMem, ?_⟩
      simp only [Nat.prime_two, if_true]
      exact Finset.sum_lt_sum (fun m _ => term_monotone 2 m huv.le)
        ⟨2, hmMem, first_square_strict hu huv⟩
  exact hstrict.trans_le (partial_monotone_cutoff v
    (Nat.floor_mono (Real.exp_le_exp.mpr huv.le)))

/-- Every strictly positive delay gives strict loss after first-square activation. -/
theorem s_delay_lt {v r : ℝ} (hv : Real.log 4 < v) (hr : 0 < r) :
    s (v - r) < s v := by
  by_cases hage : v - r ≤ Real.log 4
  · rw [s_eq_zero_of_le_log_four hage]
    exact s_pos_of_log_four_lt hv
  · exact s_strictMonoOn (le_of_not_ge hage) hv.le (by linarith)

/-- Positive probability of a positive delay makes the actual signed residual strict. -/
theorem samePrime_residual_neg {μ : Measure ℝ} [IsProbabilityMeasure μ]
    (hcausal : ∀ᵐ r ∂μ, 0 ≤ r) (hpositive : 0 < μ (Set.Ioi 0))
    {v : ℝ} (hv : Real.log 4 < v) :
    (∫ r, s (v - r) ∂μ) - s v < 0 := by
  have hi : Integrable (fun r => s v - s (v - r)) μ :=
    (integrable_const (s v)).sub (delayed_s_integrable hcausal v)
  have hn : 0 ≤ᵐ[μ] (fun r => s v - s (v - r)) := by
    filter_upwards [hcausal] with r hr
    exact sub_nonneg.mpr (s_delay_le v hr)
  have hsupp : Set.Ioi 0 ⊆ Function.support (fun r => s v - s (v - r)) := by
    intro r hr
    exact ne_of_gt (sub_pos.mpr (s_delay_lt hv hr))
  have hpos : 0 < ∫ r, s v - s (v - r) ∂μ :=
    (integral_pos_iff_support_of_nonneg_ae hn hi).mpr
      (hpositive.trans_le (measure_mono hsupp))
  rw [integral_sub (integrable_const (s v)) (delayed_s_integrable hcausal v)] at hpos
  simp only [integral_const] at hpos
  simp at hpos
  linarith

#print axioms H_strictMonoOn
#print axioms s_strictMonoOn
#print axioms s_delay_lt
#print axioms samePrime_residual_neg

end BuildingBlocks.SamePrimeStrictDelay
