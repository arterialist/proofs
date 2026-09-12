import BuildingBlocks.SuccessorFeedbackBoundary
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic

/-! Elementary decay of the actual ordinary successor driver. -/

open MeasureTheory Real Set Filter
open scoped Topology Interval

namespace BuildingBlocks.SuccessorFeedback

noncomputable def decayKernel (J x : ℝ) : ℝ :=
  (x + J) ^ (-(3 / 4 : ℝ)) * x ^ (-(1 / 2 : ℝ))

theorem decayKernel_nonneg {J x : ℝ} (hx : 0 ≤ x) (hJ : 0 ≤ J) :
    0 ≤ decayKernel J x := mul_nonneg (rpow_nonneg (by linarith) _) (rpow_nonneg hx _)

theorem decayKernel_head {J x : ℝ} (hx : 0 < x) (hJ : 0 < J) :
    decayKernel J x ≤ J ^ (-(3 / 4 : ℝ)) * x ^ (-(1 / 2 : ℝ)) := by
  apply mul_le_mul_of_nonneg_right _ (rpow_nonneg hx.le _)
  exact rpow_le_rpow_of_nonpos hJ (by linarith) (by norm_num)

theorem decayKernel_tail {J x : ℝ} (hx : 0 < x) (hJ : 0 ≤ J) :
    decayKernel J x ≤ x ^ (-(5 / 4 : ℝ)) := by
  calc
    _ ≤ x ^ (-(3 / 4 : ℝ)) * x ^ (-(1 / 2 : ℝ)) := by
      apply mul_le_mul_of_nonneg_right _ (rpow_nonneg hx.le _)
      exact rpow_le_rpow_of_nonpos hx (by linarith) (by norm_num)
    _ = _ := by rw [← rpow_add hx]; norm_num

theorem measurable_decayKernel (J : ℝ) : Measurable (decayKernel J) := by
  unfold decayKernel
  fun_prop

theorem decayKernel_integrable {J : ℝ} (hJ : 0 ≤ J) :
    IntegrableOn (decayKernel J) (Ioi (1 : ℝ)) := by
  apply (integrableOn_Ioi_rpow_of_lt (by norm_num : -(5 / 4 : ℝ) < -1)
    (by norm_num : (0 : ℝ) < 1)).mono' (measurable_decayKernel J).aestronglyMeasurable
  filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with x hx
  have hx0 : 0 < x := lt_trans (by norm_num) hx
  rw [Real.norm_eq_abs, abs_of_nonneg (decayKernel_nonneg hx0.le hJ)]
  exact decayKernel_tail hx0 hJ

theorem integral_head_power {J : ℝ} (hJ : 1 ≤ J) :
    (∫ x in Ioc (1 : ℝ) J, x ^ (-(1 / 2 : ℝ))) ≤ 2 * J ^ (1 / 2 : ℝ) := by
  rw [← intervalIntegral.integral_of_le hJ, integral_rpow (Or.inl (by norm_num))]
  norm_num
  linarith

theorem integral_tail_power {J : ℝ} (hJ : 0 < J) :
    (∫ x in Ioi J, x ^ (-(5 / 4 : ℝ))) = 4 * J ^ (-(1 / 4 : ℝ)) := by
  rw [integral_Ioi_rpow_of_lt (by norm_num) hJ]
  norm_num
  ring

/-- A scaling estimate at the actual successor size. -/
theorem decayKernel_integral_bound {J : ℝ} (hJ : 1 ≤ J) :
    (∫ x in Ioi (1 : ℝ), decayKernel J x) ≤ 6 * J ^ (-(1 / 4 : ℝ)) := by
  have hJ0 : 0 < J := lt_of_lt_of_le (by norm_num) hJ
  have hi := decayKernel_integrable hJ0.le
  have hh := hi.mono_set (Ioc_subset_Ioi_self : Ioc (1 : ℝ) J ⊆ Ioi 1)
  have ht := hi.mono_set (Ioi_subset_Ioi hJ)
  have hp : IntegrableOn (fun x : ℝ => x ^ (-(1 / 2 : ℝ))) (Ioc 1 J) := by
    apply (intervalIntegrable_iff_integrableOn_Ioc_of_le hJ).mp
    exact (ContinuousOn.rpow_const (continuousOn_id) (fun x hx => Or.inl (by
      rw [uIcc_of_le hJ] at hx
      exact ne_of_gt (lt_of_lt_of_le (by norm_num) hx.1)))).intervalIntegrable
  have hhead := integral_mono_ae hh (hp.const_mul (J ^ (-(3 / 4 : ℝ))))
    (by filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioc] with x hx
        exact decayKernel_head (by linarith [hx.1]) hJ0)
  rw [integral_const_mul] at hhead
  have hhead' : (∫ x in Ioc (1 : ℝ) J, decayKernel J x) ≤
      2 * J ^ (-(1 / 4 : ℝ)) := by
    calc
      _ ≤ J ^ (-(3 / 4 : ℝ)) * (2 * J ^ (1 / 2 : ℝ)) :=
        hhead.trans (mul_le_mul_of_nonneg_left (integral_head_power hJ) (rpow_nonneg hJ0.le _))
      _ = _ := by rw [mul_left_comm, ← rpow_add hJ0]; norm_num
  have htail := integral_mono_ae ht
    (integrableOn_Ioi_rpow_of_lt (by norm_num : -(5 / 4 : ℝ) < -1) hJ0)
    (by filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with x hx
        exact decayKernel_tail (hJ0.trans hx) hJ0.le)
  rw [integral_tail_power hJ0] at htail
  have he : Ioc (1 : ℝ) J ∪ Ioi J = Ioi (1 : ℝ) := by
    ext x
    simp only [mem_union, mem_Ioc, mem_Ioi]
    constructor
    · rintro (⟨hx, _⟩ | hx)
      · exact hx
      · exact lt_of_le_of_lt hJ hx
    · intro hx
      by_cases hxJ : x ≤ J
      · exact Or.inl ⟨hx, hxJ⟩
      · exact Or.inr (lt_of_not_ge hxJ)
  have hd : Disjoint (Ioc (1 : ℝ) J) (Ioi J) := by
    apply disjoint_left.mpr
    intro x hx hy
    exact (not_lt_of_ge hx.2) hy
  rw [← he, setIntegral_union hd measurableSet_Ioi hh ht]
  linarith

theorem physicalDifference_scaled_bound {x : ℝ} (hx : 0 < x) (j : ℕ) :
    |physicalDifference j x / sqrt x| ≤
      (log (j + 1 : ℝ) + 4 * log 2 + 4) * (j + 1 : ℝ) ^ (-(1 / 4 : ℝ)) *
        decayKernel (j + 1) x := by
  let J : ℝ := j + 1
  have hJ : 1 ≤ J := by dsimp [J]; have := Nat.cast_nonneg (α := ℝ) j; linarith
  have hJ0 : 0 < J := lt_of_lt_of_le (by norm_num) hJ
  have ht : 0 < x + J := by positivity
  have hlogJ : 0 ≤ log J := log_nonneg hJ
  have hratio : 1 ≤ (x + J) / J := (le_div_iff₀ hJ0).2 (by linarith)
  have hp : 1 ≤ ((x + J) / J) ^ (1 / 4 : ℝ) := one_le_rpow hratio (by norm_num)
  have hl := log_le_rpow_div (show 0 ≤ (x + J) / J by positivity)
    (by norm_num : 0 < (1 / 4 : ℝ))
  rw [log_div (ne_of_gt ht) (ne_of_gt hJ0)] at hl
  have hn : log (x + J) + 4 * log 2 ≤
      (log J + 4 * log 2 + 4) * ((x + J) / J) ^ (1 / 4 : ℝ) := by
    have hh := mul_le_mul_of_nonneg_left hp (show 0 ≤ log J + 4 * log 2 by positivity)
    nlinarith
  have hb : |physicalDifference j x| ≤ (log (x + J) + 4 * log 2) / (x + J) := by
    simpa only [J, add_assoc] using physicalDifference_abs_le hx j
  rw [abs_div, abs_of_pos (sqrt_pos.mpr hx)]
  apply (div_le_div_of_nonneg_right
    (hb.trans (div_le_div_of_nonneg_right hn ht.le)) (sqrt_nonneg x)).trans_eq
  change ((log J + 4 * log 2 + 4) * ((x + J) / J) ^ (1 / 4 : ℝ) / (x + J)) /
      sqrt x = (log J + 4 * log 2 + 4) * J ^ (-(1 / 4 : ℝ)) * decayKernel J x
  have ht' : (x + J) ^ (-(3 / 4 : ℝ)) = (x + J) ^ (1 / 4 : ℝ) / (x + J) := by
    convert rpow_sub ht (1 / 4 : ℝ) 1 using 1 <;> norm_num
  rw [decayKernel, ht', div_rpow (by positivity) hJ0.le,
    rpow_neg hJ0.le, rpow_neg hx.le, sqrt_eq_rpow]
  ring

/-- Explicit square-root decay with a logarithmic factor. -/
theorem driver_decay_bound (j : ℕ) :
    |driver j| ≤ 3 * (log (j + 1 : ℝ) + 4 * log 2 + 4) *
      (j + 1 : ℝ) ^ (-(1 / 2 : ℝ)) := by
  let J : ℝ := j + 1
  let A : ℝ := log J + 4 * log 2 + 4
  have hJ : 1 ≤ J := by dsimp [J]; have := Nat.cast_nonneg (α := ℝ) j; linarith
  have hJ0 : 0 < J := lt_of_lt_of_le (by norm_num) hJ
  have hA : 0 ≤ A := by dsimp [A]; have := log_nonneg hJ; positivity
  have hm := (decayKernel_integrable hJ0.le).const_mul (A * J ^ (-(1 / 4 : ℝ)))
  have hh := integral_mono_ae (physicalDifference_integrable j).abs hm
    (by filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with x hx
        exact physicalDifference_scaled_bound (lt_trans (by norm_num) hx) j)
  rw [integral_const_mul] at hh
  have hb := hh.trans (mul_le_mul_of_nonneg_left (decayKernel_integral_bound hJ)
    (show 0 ≤ A * J ^ (-(1 / 4 : ℝ)) by positivity))
  have hn := norm_integral_le_integral_norm (fun x => physicalDifference j x / sqrt x)
    (μ := volume.restrict (Ioi (1 : ℝ)))
  simp only [Real.norm_eq_abs] at hn
  rw [driver_eq_difference_integral]
  change |(1 / 2 : ℝ) * ∫ x in Ioi (1 : ℝ), physicalDifference j x / sqrt x| ≤ _
  rw [abs_mul, abs_of_nonneg (by norm_num : (0 : ℝ) ≤ 1 / 2)]
  calc
    _ ≤ (1 / 2 : ℝ) * (A * J ^ (-(1 / 4 : ℝ)) * (6 * J ^ (-(1 / 4 : ℝ)))) :=
      mul_le_mul_of_nonneg_left (hn.trans hb) (by norm_num)
    _ = _ := by
      change _ = 3 * A * J ^ (-(1 / 2 : ℝ))
      calc
        _ = 3 * A * (J ^ (-(1 / 4 : ℝ)) * J ^ (-(1 / 4 : ℝ))) := by ring
        _ = _ := by rw [← rpow_add hJ0]; norm_num

end BuildingBlocks.SuccessorFeedback
