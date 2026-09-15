import BuildingBlocks.GoldbachAbsoluteEnergy
import BuildingBlocks.SummableIntegrals
import Mathlib.Order.Filter.AtTopBot.Prod

/-! The actual infinite centered Goldbach heat identity on s > 2, with
absolute pair summability and Bochner integrability proved before Fubini. -/

open MeasureTheory Real Set Filter
open scoped BigOperators Topology

namespace BuildingBlocks.GoldbachHeat

noncomputable def pairHeat (s : ℝ) (p : ℕ × ℕ) (t : ℝ) : ℝ :=
  centeredCoefficient (p.1 + 1) * centeredCoefficient (p.2 + 1) *
    (t ^ (s - 1) * exp (-((((p.1 + 1 : ℕ) : ℝ) + ((p.2 + 1 : ℕ) : ℝ)) * t)))

theorem pairHeat_integrable {s : ℝ} (hs : 0 < s) (p : ℕ × ℕ) :
    IntegrableOn (pairHeat s p) (Ioi (0 : ℝ)) := by
  have hi := integrableOn_rpow_mul_exp_neg_mul_rpow (p := 1) (s := s - 1)
    (b := (((p.1 + 1 : ℕ) : ℝ) + ((p.2 + 1 : ℕ) : ℝ))) (by linarith) le_rfl (by positivity)
  simp only [rpow_one, neg_mul] at hi
  exact hi.const_mul _

theorem pairHeat_integral {s : ℝ} (hs : 0 < s) (p : ℕ × ℕ) :
    (∫ t in Ioi (0 : ℝ), pairHeat s p t) = Gamma s * centeredPairTerm s p := by
  unfold pairHeat centeredPairTerm
  rw [integral_const_mul, integral_rpow_mul_exp_neg_mul_Ioi hs (by positivity)]
  rw [one_div, inv_rpow (by positivity)]
  ring

theorem pairHeat_norm_integral {s : ℝ} (hs : 0 < s) (p : ℕ × ℕ) :
    (∫ t in Ioi (0 : ℝ), ‖pairHeat s p t‖) = Gamma s * |centeredPairTerm s p| := by
  have he : (∫ t in Ioi (0 : ℝ), ‖pairHeat s p t‖) =
      ∫ t in Ioi (0 : ℝ),
        |centeredCoefficient (p.1 + 1) * centeredCoefficient (p.2 + 1)| *
        (t ^ (s - 1) * exp (-((((p.1 + 1 : ℕ) : ℝ) + ((p.2 + 1 : ℕ) : ℝ)) * t))) := by
    apply integral_congr_ae
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
    unfold pairHeat
    rw [Real.norm_eq_abs, abs_mul, abs_of_nonneg
      (mul_nonneg (rpow_nonneg ht.le _) (exp_nonneg _))]
  rw [he, integral_const_mul, integral_rpow_mul_exp_neg_mul_Ioi hs (by positivity)]
  unfold centeredPairTerm
  rw [abs_div, abs_of_pos (rpow_pos_of_pos (by positivity) _)]
  rw [one_div, inv_rpow (by positivity)]
  ring

theorem pairHeat_norm_integrals_summable {s : ℝ} (hs : 2 < s) :
    Summable (fun p : ℕ × ℕ => ∫ t in Ioi (0 : ℝ), ‖pairHeat s p t‖) := by
  simpa only [pairHeat_norm_integral (show 0 < s by linarith)] using
    (centeredPairTerm_abs_summable hs).mul_left (Gamma s)

theorem pairHeat_tsum {t : ℝ} (ht : 0 < t) (s : ℝ) :
    (∑' p : ℕ × ℕ, pairHeat s p t) = t ^ (s - 1) * centeredHeat t ^ 2 := by
  have hh := centeredHeat_summable ht
  rw [pow_two, centeredHeat, tsum_mul_tsum_of_summable_norm hh.norm hh.norm, ← tsum_mul_left]
  apply tsum_congr
  intro p
  unfold pairHeat
  rw [show -((((p.1 + 1 : ℕ) : ℝ) + ((p.2 + 1 : ℕ) : ℝ)) * t) =
    -(((p.1 + 1 : ℕ) : ℝ) * t) + -(((p.2 + 1 : ℕ) : ℝ) * t) by ring, exp_add]
  ring

theorem centeredHeat_weighted_square_integrable {s : ℝ} (hs : 2 < s) :
    IntegrableOn (fun t => t ^ (s - 1) * centeredHeat t ^ 2) (Ioi (0 : ℝ)) := by
  have hF (p : ℕ × ℕ) : IntegrableOn (fun t => (pairHeat s p t : ℂ)) (Ioi (0 : ℝ)) :=
    (pairHeat_integrable (by linarith) p).ofReal
  have hnorm : Summable (fun p : ℕ × ℕ => ∫ t in Ioi (0 : ℝ), ‖(pairHeat s p t : ℂ)‖) := by
    simpa only [Complex.norm_real] using pairHeat_norm_integrals_summable hs
  have hint := (SummableIntegrals.integrable_tsum_of_summable_integral_norm hF hnorm).re
  simp only [← Complex.ofReal_tsum, Complex.ofReal_re] at hint
  apply hint.congr
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  exact pairHeat_tsum ht s

noncomputable def centeredEnergy (s : ℝ) : ℝ := ∑' p : ℕ × ℕ, centeredPairTerm s p

/-- This infinite identity is asserted only in the proved absolute range. -/
theorem centeredEnergy_eq_heat_integral {s : ℝ} (hs : 2 < s) :
    Gamma s * centeredEnergy s =
      ∫ t in Ioi (0 : ℝ), t ^ (s - 1) * centeredHeat t ^ 2 := by
  have hswap := integral_tsum_of_summable_integral_norm
    (fun p => pairHeat_integrable (show 0 < s by linarith) p)
    (pairHeat_norm_integrals_summable hs)
  simp only [pairHeat_integral (show 0 < s by linarith), tsum_mul_left] at hswap
  change Gamma s * centeredEnergy s = _ at hswap
  rw [hswap]
  apply integral_congr_ae
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  exact pairHeat_tsum ht s

theorem centeredEnergy_nonneg {s : ℝ} (hs : 2 < s) : 0 ≤ centeredEnergy s := by
  have hi : 0 ≤ Gamma s * centeredEnergy s := by
    rw [centeredEnergy_eq_heat_integral hs]
    apply integral_nonneg_of_ae
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
    exact mul_nonneg (rpow_nonneg ht.le _) (sq_nonneg _)
  exact nonneg_of_mul_nonneg_right hi (Gamma_pos_of_pos (by linarith))

theorem finiteEnergy_centered_eq_pair_sum (N : ℕ) (s : ℝ) :
    finiteEnergy centeredCoefficient N s =
      ∑ p ∈ Finset.range N ×ˢ Finset.range N, centeredPairTerm s p := by
  have he : Finset.Icc 1 N = Finset.Ico 1 (N + 1) := by
    ext n
    simp only [Finset.mem_Icc, Finset.mem_Ico]
    omega
  simp only [finiteEnergy, he, Finset.sum_Ico_eq_sum_range, Nat.add_sub_cancel,
    Nat.add_comm 1, Finset.sum_product, centeredPairTerm]
  apply Finset.sum_congr rfl
  intro m hm
  apply Finset.sum_congr rfl
  intro n hn
  rw [one_div, inv_rpow (by positivity)]
  ring

/-- The infinite energy is the limit of the literal square arithmetic cutoffs. -/
theorem finiteEnergy_centered_tendsto {s : ℝ} (hs : 2 < s) :
    Tendsto (fun N => finiteEnergy centeredCoefficient N s) atTop (𝓝 (centeredEnergy s)) := by
  have hp : Tendsto (fun N => (Finset.range N, Finset.range N)) atTop atTop := by
    rw [← prod_atTop_atTop_eq]
    exact tendsto_finset_range.prodMk tendsto_finset_range
  have hr := tendsto_finset_prod_atTop.comp hp
  have hh : Tendsto (fun b : Finset (ℕ × ℕ) => ∑ p ∈ b, centeredPairTerm s p)
      atTop (𝓝 (centeredEnergy s)) := (centeredPairTerm_summable hs).hasSum
  simpa only [Function.comp_def, ← finiteEnergy_centered_eq_pair_sum] using hh.comp hr

end BuildingBlocks.GoldbachHeat
