import BuildingBlocks.ChargeDensityEvaluation
import BuildingBlocks.CoarsePrimeBounds

open MeasureTheory Set Filter
open scoped BigOperators

namespace BuildingBlocks.ChargeFrozenSource

open CoarsePrimitive

open ChargeOriginalBirth BuildingBlocks.SuccessorCharge

noncomputable def source (N : ℕ) (v : ℝ) : ℝ :=
  Real.exp (-v / 2) * (psi ⌊min (Real.exp v) (N : ℝ)⌋₊ - min (Real.exp v) (N : ℝ))

/-- The full literal frozen source includes the causal lower branch and keeps the origin value. -/
noncomputable def causalSource (N : ℕ) : ℝ → ℝ := (Ici (0 : ℝ)).indicator (source N)

theorem causalSource_of_negative (N : ℕ) {v : ℝ} (hv : v < 0) : causalSource N v = 0 := by
  simp [causalSource, not_le.mpr hv]

theorem causalSource_of_nonnegative (N : ℕ) {v : ℝ} (hv : 0 ≤ v) :
    causalSource N v = source N v := by
  simp [causalSource, hv]

theorem causalSource_at_origin {N : ℕ} (hN : 2 ≤ N) : causalSource N 0 = -1 := by
  have hn : (1 : ℝ) ≤ N := by exact_mod_cast (show 1 ≤ N by omega)
  simp [causalSource, source, min_eq_left hn, psi_eq_sum_Icc]

noncomputable def tail (N : ℕ) (v : ℝ) : ℝ :=
  if (N : ℝ) < Real.exp v then (Real.exp v - N) * Real.exp (-v / 2) else 0

private theorem psi_two (L : ℕ) : psi L = ∑ n ∈ Finset.Icc 2 L, ArithmeticFunction.vonMangoldt n := by
  rw [psi_eq_sum_Icc]
  symm
  apply Finset.sum_subset
  · intro n hn
    simp only [Finset.mem_Icc] at hn ⊢
    omega
  · intro n hn hnot
    simp only [Finset.mem_Icc] at hn hnot
    have h : n = 1 := by omega
    simp [h]

theorem psi_frozen_eq_atoms {N : ℕ} (_hN : 2 ≤ N) (v : ℝ) :
    psi ⌊min (Real.exp v) (N : ℝ)⌋₊ =
      ∑ n ∈ Finset.Icc 2 N, if (n : ℝ) ≤ Real.exp v then ArithmeticFunction.vonMangoldt n else 0 := by
  let L := ⌊min (Real.exp v) (N : ℝ)⌋₊
  have hm : 0 ≤ min (Real.exp v) (N : ℝ) := le_min (Real.exp_pos _).le (Nat.cast_nonneg _)
  have hLN : L ≤ N := by
    have h := (Nat.floor_le hm).trans (min_le_right (Real.exp v) (N : ℝ))
    exact_mod_cast h
  rw [psi_two]
  change (∑ n ∈ Finset.Icc 2 L, ArithmeticFunction.vonMangoldt n) = _
  calc
    _ = ∑ n ∈ Finset.Icc 2 L, if (n : ℝ) ≤ Real.exp v then ArithmeticFunction.vonMangoldt n else 0 := by
      apply Finset.sum_congr rfl
      intro n hn
      have hnL := (Finset.mem_Icc.mp hn).2
      have hnr : (n : ℝ) ≤ min (Real.exp v) (N : ℝ) := (Nat.le_floor_iff hm).mp hnL
      rw [if_pos (hnr.trans (min_le_left _ _))]
    _ = _ := by
      apply Finset.sum_subset
      · intro n hn
        simp only [Finset.mem_Icc] at hn ⊢
        omega
      · intro n hn hnot
        have hn2 := (Finset.mem_Icc.mp hn).1
        have hnN := (Finset.mem_Icc.mp hn).2
        have hnL : ¬n ≤ L := by simp only [Finset.mem_Icc] at hnot; omega
        have hnr : ¬(n : ℝ) ≤ min (Real.exp v) (N : ℝ) := by
          exact fun h => hnL ((Nat.le_floor_iff hm).mpr h)
        have hx : ¬(n : ℝ) ≤ Real.exp v := by
          intro h
          exact hnr (le_min h (by exact_mod_cast hnN))
        rw [if_neg hx]

/-- The literal frozen psi source keeps its terminal tail in the finite atom decomposition. -/
theorem source_decomposition {N : ℕ} (hN : 2 ≤ N) {v : ℝ} (_hv : 0 < v) :
    source N v = (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * beta n v) -
      Real.exp (v / 2) + tail N v := by
  have he : Real.exp v * Real.exp (-v / 2) = Real.exp (v / 2) := by
    rw [← Real.exp_add]
    congr 1
    ring
  have ha : (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * beta n v) =
      Real.exp (-v / 2) * psi ⌊min (Real.exp v) (N : ℝ)⌋₊ := by
    rw [psi_frozen_eq_atoms hN, Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro n _
    unfold beta
    split_ifs <;> ring
  rw [ha]
  unfold source tail
  split_ifs with h
  · rw [min_eq_right h.le]
    rw [← he]
    ring
  · rw [min_eq_left (le_of_not_gt h)]
    rw [← he]
    ring

theorem tail_nonnegative (N : ℕ) (v : ℝ) : 0 ≤ tail N v := by
  unfold tail
  split_ifs with h
  · exact mul_nonneg (sub_nonneg.mpr h.le) (Real.exp_pos _).le
  · exact le_rfl

theorem tail_le_growth (N : ℕ) (v : ℝ) : tail N v ≤ Real.exp (v / 2) := by
  have he : Real.exp v * Real.exp (-v / 2) = Real.exp (v / 2) := by
    rw [← Real.exp_add]; congr 1; ring
  unfold tail
  split_ifs
  · rw [← he]
    exact mul_le_mul_of_nonneg_right (sub_le_self _ (Nat.cast_nonneg N)) (Real.exp_pos _).le
  · positivity

theorem kernel_tail_integrable (N : ℕ) :
    IntegrableOn (fun v => kernel v * tail N v) (Ioi (0 : ℝ)) := by
  apply ChargeDensityEvaluation.kernel_growth_integrable.norm.mono'
  · have hm : Measurable (tail N) := by
      unfold tail
      exact Measurable.ite (measurableSet_lt measurable_const Real.measurable_exp)
        (by fun_prop) measurable_const
    exact (measurable_kernel.mul hm).aestronglyMeasurable
  · filter_upwards [] with v
    simp only [Real.norm_eq_abs, abs_mul, abs_of_nonneg (tail_nonnegative N v),
      abs_of_pos (Real.exp_pos (v / 2))]
    exact mul_le_mul_of_nonneg_left (tail_le_growth N v) (abs_nonneg _)

theorem kernel_tail_nonnegative {N : ℕ} (hN : 2 ≤ N) (v : ℝ) :
    0 ≤ kernel v * tail N v := by
  unfold tail
  split_ifs with h
  · have h2 : (2 : ℝ) < Real.exp v := lt_of_le_of_lt (by exact_mod_cast hN) h
    have hv : Real.log 2 < v := by
      simpa only [Real.log_exp] using Real.log_lt_log (by norm_num : (0 : ℝ) < 2) h2
    have hx : Real.exp (-v) < 1 := by
      have hp : 0 < v := lt_trans (Real.log_pos (by norm_num)) hv
      simpa using Real.exp_lt_exp.mpr (neg_neg_of_pos hp)
    have hs : 0 < Real.sqrt (1 - Real.exp (-v)) := Real.sqrt_pos.2 (by linarith)
    have hs1 : Real.sqrt (1 - Real.exp (-v)) ≤ 1 := by
      apply (Real.sqrt_le_iff).2
      constructor <;> nlinarith [Real.exp_pos (-v)]
    have hk : 0 ≤ kernel v := by
      simp only [kernel, if_neg (not_lt_of_ge hv.le), weight]
      have hi : 1 ≤ (Real.sqrt (1 - Real.exp (-v)))⁻¹ := (one_le_inv₀ hs).2 hs1
      linarith
    exact mul_nonneg hk (mul_nonneg (sub_nonneg.mpr h.le) (Real.exp_pos _).le)
  · simp

theorem original_defect_source {N : ℕ} (hN : 2 ≤ N) :
    defect (source N) =
      (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * ChargeBirthSummability.correction n) +
        defect (tail N) := by
  have hi (n : ℕ) : IntegrableOn (fun v => kernel v * (ArithmeticFunction.vonMangoldt n * beta n v))
      (Ioi (0 : ℝ)) := by
    have hb := integrable_kernel_mul (birthPull_integrable n 0)
    simp_rw [← beta_eq_birthPull n] at hb
    simpa only [mul_left_comm] using hb.const_mul (ArithmeticFunction.vonMangoldt n)
  have hs : IntegrableOn (fun v => ∑ n ∈ Finset.Icc 2 N,
      kernel v * (ArithmeticFunction.vonMangoldt n * beta n v)) (Ioi (0 : ℝ)) :=
    integrable_finset_sum _ (fun n _ => hi n)
  have he : (∫ v in Ioi (0 : ℝ), kernel v * source N v) =
      ∫ v in Ioi (0 : ℝ), ((∑ n ∈ Finset.Icc 2 N,
        kernel v * (ArithmeticFunction.vonMangoldt n * beta n v)) -
          kernel v * Real.exp (v / 2)) + kernel v * tail N v := by
    apply integral_congr_ae
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with v hv
    rw [source_decomposition hN hv, mul_add, mul_sub, Finset.mul_sum]
  unfold defect
  have hsub : IntegrableOn (fun v => (∑ n ∈ Finset.Icc 2 N,
      kernel v * (ArithmeticFunction.vonMangoldt n * beta n v)) - kernel v * Real.exp (v / 2))
      (Ioi (0 : ℝ)) := hs.sub ChargeDensityEvaluation.kernel_growth_integrable
  rw [he, integral_add hsub
    (kernel_tail_integrable N), integral_sub hs ChargeDensityEvaluation.kernel_growth_integrable,
    integral_finset_sum _ (fun n _ => hi n)]
  have hg : (1 / 2 : ℝ) * (∫ v in Ioi (0 : ℝ), kernel v * Real.exp (v / 2)) = 0 :=
    ChargeDensityEvaluation.original_defect_growth
  rw [mul_add, mul_sub, Finset.mul_sum, hg, sub_zero]
  congr 1
  apply Finset.sum_congr rfl
  intro n hn
  have hn2 := (Finset.mem_Icc.mp hn).1
  have hb := original_defect_beta hn2
  unfold defect at hb
  simp_rw [mul_left_comm (kernel _) (ArithmeticFunction.vonMangoldt n), integral_const_mul]
  rw [← mul_assoc, mul_comm (1 / 2 : ℝ), mul_assoc, hb]

theorem original_defect_source_nonnegative {N : ℕ} (hN : 2 ≤ N) :
    0 ≤ defect (source N) := by
  rw [original_defect_source hN]
  apply add_nonneg
  · apply Finset.sum_nonneg
    intro n hn
    have hn2 : (2 : ℝ) ≤ n := by exact_mod_cast (Finset.mem_Icc.mp hn).1
    exact mul_nonneg (ArithmeticFunction.vonMangoldt_nonneg (n := n))
      (ChargeBirthSummability.correction_bounds hn2).1
  · unfold defect
    apply mul_nonneg (by norm_num)
    apply integral_nonneg
    intro v
    exact kernel_tail_nonnegative hN v

theorem original_defect_causalSource (N : ℕ) : defect (causalSource N) = defect (source N) := by
  unfold defect
  congr 1
  apply integral_congr_ae
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with v hv
  rw [causalSource_of_nonnegative N hv.le]

theorem original_defect_causalSource_nonnegative {N : ℕ} (hN : 2 ≤ N) :
    0 ≤ defect (causalSource N) := by
  rw [original_defect_causalSource]
  exact original_defect_source_nonnegative hN

#print axioms source_decomposition
#print axioms kernel_tail_integrable
#print axioms kernel_tail_nonnegative
#print axioms original_defect_source
#print axioms original_defect_source_nonnegative
#print axioms causalSource_at_origin
#print axioms original_defect_causalSource
#print axioms original_defect_causalSource_nonnegative

end BuildingBlocks.ChargeFrozenSource
