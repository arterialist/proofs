import BuildingBlocks.ReciprocalIsometry

open Finset Filter Set MeasureTheory
open scoped Topology BigOperators Interval

namespace BuildingBlocks

open MertensTransfer CoarsePrimitive FloorCorrection HyperbolaProduct

noncomputable def correctedCoefficient (N q : ℕ) : ℝ :=
  (quotientCoefficient N q : ℝ) - (if q = 1 then 2 * (mertens N : ℝ) + 3 else 0) +
    (if q = 2 then (mertens N : ℝ) + 1 else 0)

theorem correctedCoefficient_sum_apply {N : ℕ} (hN : 2 ≤ N) (g : ℕ → ℝ) :
    (∑ q ∈ Finset.Icc 1 N, correctedCoefficient N q * g q) =
      (∑ q ∈ Finset.Icc 1 N, (quotientCoefficient N q : ℝ) * g q) -
        (2 * (mertens N : ℝ) + 3) * g 1 + ((mertens N : ℝ) + 1) * g 2 := by
  have h1 : 1 ∈ Finset.Icc 1 N := Finset.mem_Icc.mpr ⟨le_rfl, by omega⟩
  have h2 : 2 ∈ Finset.Icc 1 N := Finset.mem_Icc.mpr ⟨by omega, hN⟩
  simp only [correctedCoefficient, add_mul, sub_mul, ite_mul, zero_mul,
    Finset.sum_add_distrib, Finset.sum_sub_distrib]
  simp [h1, h2]

theorem correctedCoefficient_sum {N : ℕ} (hN : 2 ≤ N) :
    ∑ q ∈ Finset.Icc 1 N, correctedCoefficient N q = -2 := by
  have hh := correctedCoefficient_sum_apply hN (fun _ => 1)
  simp only [mul_one, quotient_coefficient_sum] at hh
  rw [hh]
  ring

theorem correctedCoefficient_first (N : ℕ) :
    correctedCoefficient N 1 = -((mertens N : ℝ) + (mertens (N / 2) : ℝ) + 3) := by
  rw [correctedCoefficient]
  norm_num only [ite_true, show ¬ (1 : ℕ) = 2 by omega, ite_false, add_zero]
  rw [quotientCoefficient_eq_mertens N (by omega : 0 < 1)]
  simp only [Nat.div_one, Int.cast_sub, one_add_one_eq_two]
  ring

theorem meanCorrectedDual_eq_kernelSum {N : ℕ} (hN : 2 ≤ N) (x : ℝ) :
    meanCorrectedDual N x =
      kernelSum fractionKernel (Finset.Icc 1 N) (correctedCoefficient N)
        (fun q => (q : ℝ) / (N : ℝ)) x := by
  rw [kernelSum, correctedCoefficient_sum_apply hN]
  simp only [fractionKernel, div_div, Nat.cast_one, Nat.cast_ofNat,
    meanCorrectedDual, dualApproximation, boundaryCorrection, mul_one_div]
  ring

noncomputable def correctedImage (N : ℕ) (x : ℝ) : ℝ :=
  kernelSum reciprocalKernel (Finset.Icc 1 N) (correctedCoefficient N)
    (fun q => (q : ℝ) / (N : ℝ)) x

theorem reciprocalKernel_eq_one {θ x : ℝ} (hθ : 0 < θ) (hx : 0 < x) (hxt : x < θ) :
    reciprocalKernel θ x = 1 := by
  dsimp [reciprocalKernel]
  rw [Int.fract_eq_self.mpr ⟨by positivity, (div_lt_one hθ).mpr hxt⟩]
  field_simp

theorem correctedImage_first_window {N : ℕ} (hN : 2 ≤ N) {x : ℝ}
    (hx0 : 0 < x) (hx1 : x < 1 / (N : ℝ)) : correctedImage N x = -2 := by
  have hn : (0 : ℝ) < (N : ℝ) := by exact_mod_cast (show 0 < N by omega)
  rw [correctedImage, kernelSum]
  have hh : (∑ q ∈ Finset.Icc 1 N, correctedCoefficient N q *
      reciprocalKernel ((q : ℝ) / (N : ℝ)) x) = ∑ q ∈ Finset.Icc 1 N, correctedCoefficient N q := by
    apply Finset.sum_congr rfl
    intro q hq
    have hq1 : (1 : ℝ) ≤ (q : ℝ) := by exact_mod_cast (Finset.mem_Icc.mp hq).1
    rw [reciprocalKernel_eq_one (by positivity) hx0
      (hx1.trans_le ((div_le_div_iff_of_pos_right hn).mpr hq1)), mul_one]
  rw [hh, correctedCoefficient_sum hN]

theorem reciprocalKernel_first_second_window {N : ℕ} (hN : 0 < N) {x : ℝ}
    (hx1 : 1 / (N : ℝ) < x) (hx2 : x < 2 / (N : ℝ)) :
    reciprocalKernel (1 / (N : ℝ)) x = 1 - 1 / ((N : ℝ) * x) := by
  have hn : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hN
  have hx0 : 0 < x := lt_trans (by positivity) hx1
  have h1 : (1 : ℝ) < (N : ℝ) * x := by
    have hh := (div_lt_iff₀ hn).mp hx1
    nlinarith
  have h2 : (N : ℝ) * x < 2 := by
    have hh := (lt_div_iff₀ hn).mp hx2
    nlinarith
  have he : x / (1 / (N : ℝ)) = (N : ℝ) * x := by field_simp
  have hf : Int.fract ((N : ℝ) * x) = (N : ℝ) * x - 1 := by
    have hfl : ⌊(N : ℝ) * x⌋ = (1 : ℤ) := Int.floor_eq_iff.mpr ⟨by simpa using h1.le, by norm_num; exact h2⟩
    change (N : ℝ) * x - (⌊(N : ℝ) * x⌋ : ℝ) = _
    rw [hfl]
    norm_num
  dsimp [reciprocalKernel]
  rw [he, hf]
  field_simp

theorem correctedImage_second_window {N : ℕ} (hN : 2 ≤ N) {x : ℝ}
    (hx1 : 1 / (N : ℝ) < x) (hx2 : x < 2 / (N : ℝ)) :
    correctedImage N x = -2 +
      ((mertens N : ℝ) + (mertens (N / 2) : ℝ) + 3) / ((N : ℝ) * x) := by
  have hn : (0 : ℝ) < (N : ℝ) := by exact_mod_cast (show 0 < N by omega)
  have hx0 : 0 < x := lt_trans (by positivity) hx1
  have h1 : 1 ∈ Finset.Icc 1 N := Finset.mem_Icc.mpr ⟨le_rfl, by omega⟩
  have hh : correctedImage N x =
      (∑ q ∈ Finset.Icc 1 N, correctedCoefficient N q) -
        correctedCoefficient N 1 / ((N : ℝ) * x) := by
    rw [correctedImage, kernelSum]
    calc
      _ = ∑ q ∈ Finset.Icc 1 N, (correctedCoefficient N q -
          if q = 1 then correctedCoefficient N 1 / ((N : ℝ) * x) else 0) := by
        apply Finset.sum_congr rfl
        intro q hq
        by_cases hq1 : q = 1
        · subst q
          rw [Nat.cast_one, reciprocalKernel_first_second_window (by omega : 0 < N) hx1 hx2]
          simp only [ite_true]
          ring
        · have hq2 : (2 : ℝ) ≤ (q : ℝ) := by
            exact_mod_cast (show 2 ≤ q by have := (Finset.mem_Icc.mp hq).1; omega)
          rw [reciprocalKernel_eq_one (by positivity) hx0
            (hx2.trans_le ((div_le_div_iff_of_pos_right hn).mpr hq2)), mul_one,
            if_neg hq1, sub_zero]
      _ = _ := by rw [Finset.sum_sub_distrib]; simp [h1]
  rw [hh, correctedCoefficient_sum hN, correctedCoefficient_first N]
  ring

theorem quotient_parameter_pos {N : ℕ} (hN : 0 < N) {q : ℕ} (hq : q ∈ Finset.Icc 1 N) :
    (0 : ℝ) < (q : ℝ) / (N : ℝ) := by
  have hq0 : 0 < q := (Finset.mem_Icc.mp hq).1
  positivity

theorem corrected_distance_identity {N M : ℕ} (hN : 2 ≤ N) (hM : 2 ≤ M) :
    (∫ x in Set.Ioi (0 : ℝ), (meanCorrectedDual N x - meanCorrectedDual M x) ^ 2) =
      ∫ x in Set.Ioi (0 : ℝ), (correctedImage N x - correctedImage M x) ^ 2 := by
  simpa only [← meanCorrectedDual_eq_kernelSum hN, ← meanCorrectedDual_eq_kernelSum hM,
    correctedImage] using
    kernelSum_distance_eq (Finset.Icc 1 N) (Finset.Icc 1 M)
      (correctedCoefficient N) (fun q => (q : ℝ) / (N : ℝ))
      (correctedCoefficient M) (fun q => (q : ℝ) / (M : ℝ))
      (fun _ hq => quotient_parameter_pos (by omega : 0 < N) hq)
      (fun _ hq => quotient_parameter_pos (by omega : 0 < M) hq)

theorem correctedImage_product_integrable {N M : ℕ} (hN : 2 ≤ N) (hM : 2 ≤ M) :
    IntegrableOn (fun x => correctedImage N x * correctedImage M x) (Set.Ioi (0 : ℝ)) :=
  kernelSum_product_integrable _ _ _ _ _ _ _ _ (fun i hi j hj =>
    reciprocalKernel_product_integrable
      (quotient_parameter_pos (by omega : 0 < N) hi)
      (quotient_parameter_pos (by omega : 0 < M) hj))

theorem correctedImage_distance_integrable {N M : ℕ} (hN : 2 ≤ N) (hM : 2 ≤ M) :
    IntegrableOn (fun x => (correctedImage N x - correctedImage M x) ^ 2) (Set.Ioi (0 : ℝ)) := by
  have he : (fun x => (correctedImage N x - correctedImage M x) ^ 2) =
      (fun x => correctedImage N x * correctedImage N x -
        2 * (correctedImage N x * correctedImage M x) + correctedImage M x * correctedImage M x) := by
    funext x
    ring
  rw [he]
  exact ((correctedImage_product_integrable hN hN).sub
    ((correctedImage_product_integrable hN hM).const_mul 2)).add
      (correctedImage_product_integrable hM hM)

noncomputable def secondWindowCoefficient (N : ℕ) : ℝ :=
  (mertens N : ℝ) + (mertens (N / 2) : ℝ) + 3

theorem correctedImage_difference_second_window {N M : ℕ} (hM : 2 ≤ M) (hNM : 2 * M ≤ N)
    {x : ℝ} (hx1 : 1 / (N : ℝ) < x) (hx2 : x < 2 / (N : ℝ)) :
    correctedImage N x - correctedImage M x = secondWindowCoefficient N / ((N : ℝ) * x) := by
  have hn : (0 : ℝ) < (N : ℝ) := by exact_mod_cast (show 0 < N by omega)
  have hm : (0 : ℝ) < (M : ℝ) := by exact_mod_cast (show 0 < M by omega)
  have hnm : 2 * (M : ℝ) ≤ (N : ℝ) := by exact_mod_cast hNM
  have hx0 : 0 < x := lt_trans (by positivity) hx1
  have hsmall : x < 1 / (M : ℝ) := by
    apply hx2.trans_le
    apply (div_le_div_iff₀ hn hm).mpr
    simpa only [one_mul] using hnm
  rw [correctedImage_second_window (by omega : 2 ≤ N) hx1 hx2,
    correctedImage_first_window hM hx0 hsmall]
  dsimp [secondWindowCoefficient]
  ring

theorem scaled_inverse_square_integral {N : ℕ} (hN : 0 < N) (C : ℝ) :
    (∫ x in (1 / (N : ℝ))..(2 / (N : ℝ)), (C / ((N : ℝ) * x)) ^ 2) =
      C ^ 2 / (2 * (N : ℝ)) := by
  have hn : (0 : ℝ) < (N : ℝ) := by exact_mod_cast hN
  have he : (fun x : ℝ => (C / ((N : ℝ) * x)) ^ 2) =
      (fun x => C ^ 2 / (N : ℝ) ^ 2 * x ^ (-2 : ℤ)) := by
    funext x
    simp only [zpow_neg, zpow_ofNat]
    ring
  have hends : 1 / (N : ℝ) ≤ 2 / (N : ℝ) := by gcongr; norm_num
  have hz : (0 : ℝ) ∉ Set.uIcc (1 / (N : ℝ)) (2 / (N : ℝ)) := by
    rw [uIcc_of_le hends]
    intro h
    have hpos : (0 : ℝ) < 1 / (N : ℝ) := by positivity
    linarith [h.1]
  rw [he, intervalIntegral.integral_const_mul, integral_zpow (Or.inr ⟨by norm_num, hz⟩)]
  norm_num
  field_simp
  ring

theorem corrected_second_window_distance_lower {N M : ℕ} (hM : 2 ≤ M) (hNM : 2 * M ≤ N) :
    secondWindowCoefficient N ^ 2 / (2 * (N : ℝ)) ≤
      ∫ x in Set.Ioi (0 : ℝ), (correctedImage N x - correctedImage M x) ^ 2 := by
  have hn : (0 : ℝ) < (N : ℝ) := by exact_mod_cast (show 0 < N by omega)
  have hends : 1 / (N : ℝ) ≤ 2 / (N : ℝ) := by gcongr; norm_num
  have hw : (∫ x in (1 / (N : ℝ))..(2 / (N : ℝ)),
      (correctedImage N x - correctedImage M x) ^ 2) = secondWindowCoefficient N ^ 2 / (2 * (N : ℝ)) := by
    rw [← scaled_inverse_square_integral (by omega : 0 < N) (secondWindowCoefficient N)]
    apply intervalIntegral.integral_congr_ae
    filter_upwards [(Set.countable_singleton (2 / (N : ℝ))).ae_notMem volume] with x hx hmem
    rw [uIoc_of_le hends] at hmem
    have hx' : x ≠ 2 / (N : ℝ) := hx
    rw [correctedImage_difference_second_window hM hNM hmem.1
      (lt_of_le_of_ne hmem.2 hx')]
  rw [← hw, intervalIntegral.integral_of_le hends]
  apply setIntegral_mono_set (correctedImage_distance_integrable (by omega) hM)
    (Eventually.of_forall fun x => sq_nonneg _) ?_
  apply Eventually.of_forall
  intro x hx
  exact lt_trans (by positivity : (0 : ℝ) < 1 / (N : ℝ)) hx.1

noncomputable def correctedTotalError (N : ℕ) : ℝ :=
  ∫ x in (0 : ℝ)..1, (1 + meanCorrectedDual N x) ^ 2

theorem corrected_distance_upper {N M : ℕ} (hN : 2 ≤ N) (hM : 2 ≤ M) :
    (∫ x in Set.Ioi (0 : ℝ), (meanCorrectedDual N x - meanCorrectedDual M x) ^ 2) ≤
      2 * correctedTotalError N + 2 * correctedTotalError M := by
  have he : (∫ x in Set.Ioi (0 : ℝ), (meanCorrectedDual N x - meanCorrectedDual M x) ^ 2) =
      ∫ x in Set.Ioc (0 : ℝ) 1, (meanCorrectedDual N x - meanCorrectedDual M x) ^ 2 := by
    apply setIntegral_eq_of_subset_of_forall_diff_eq_zero measurableSet_Ioi
      (fun _ hx => hx.1)
    intro x hx
    have hx1 : 1 < x := by
      have hx0 : 0 < x := hx.1
      by_contra hh
      exact hx.2 ⟨hx0, le_of_not_gt hh⟩
    simp only [meanCorrectedDual_zero_above_one hN hx1,
      meanCorrectedDual_zero_above_one hM hx1, sub_self, ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true,
      zero_pow]
  rw [he, ← intervalIntegral.integral_of_le (by norm_num : (0 : ℝ) ≤ 1)]
  have hR : IntervalIntegrable (fun x => 2 * (1 + meanCorrectedDual N x) ^ 2 +
      2 * (1 + meanCorrectedDual M x) ^ 2) volume 0 1 :=
    ((meanCorrectedDual_sq_intervalIntegrable N 0 1).const_mul 2).add
      ((meanCorrectedDual_sq_intervalIntegrable M 0 1).const_mul 2)
  have hb (x : ℝ) : (meanCorrectedDual N x - meanCorrectedDual M x) ^ 2 ≤
      2 * (1 + meanCorrectedDual N x) ^ 2 + 2 * (1 + meanCorrectedDual M x) ^ 2 := by
    nlinarith [sq_nonneg (2 + meanCorrectedDual N x + meanCorrectedDual M x)]
  have hL : IntervalIntegrable (fun x => (meanCorrectedDual N x - meanCorrectedDual M x) ^ 2) volume 0 1 := by
    apply hR.mono_fun'
    · apply Measurable.aestronglyMeasurable
      dsimp [meanCorrectedDual, dualApproximation, boundaryCorrection]
      fun_prop
    · exact Eventually.of_forall (fun x => by
        simpa only [Real.norm_eq_abs,
          abs_of_nonneg (sq_nonneg (meanCorrectedDual N x - meanCorrectedDual M x))] using hb x)
  have hh := intervalIntegral.integral_mono_on (by norm_num : (0 : ℝ) ≤ 1) hL hR
    (fun x _ => hb x)
  rw [intervalIntegral.integral_add
      ((meanCorrectedDual_sq_intervalIntegrable N 0 1).const_mul 2)
      ((meanCorrectedDual_sq_intervalIntegrable M 0 1).const_mul 2),
    intervalIntegral.integral_const_mul, intervalIntegral.integral_const_mul] at hh
  exact hh

/-- The next interval supplies an arithmetic obstruction even after the
period mean has been removed. -/
theorem corrected_second_window_cauchy_bound {N M : ℕ} (hM : 2 ≤ M) (hNM : 2 * M ≤ N) :
    secondWindowCoefficient N ^ 2 / (N : ℝ) ≤
      4 * correctedTotalError N + 4 * correctedTotalError M := by
  have hh := corrected_second_window_distance_lower hM hNM
  rw [← corrected_distance_identity (by omega : 2 ≤ N) hM] at hh
  have hh' := hh.trans (corrected_distance_upper (by omega : 2 ≤ N) hM)
  have he : secondWindowCoefficient N ^ 2 / (N : ℝ) =
      2 * (secondWindowCoefficient N ^ 2 / (2 * (N : ℝ))) := by ring
  rw [he]
  linarith

theorem secondWindowCoefficient_sq_tendsto_of_corrected_convergence
    (h : MeanCorrectedConvergence) :
    Tendsto (fun N : ℕ => secondWindowCoefficient N ^ 2 / (N : ℝ)) atTop (𝓝 0) := by
  have ht : Tendsto correctedTotalError atTop (𝓝 0) := h
  rw [Metric.tendsto_atTop] at ht ⊢
  intro ε hε
  obtain ⟨K, hK⟩ := ht (ε / 8) (by positivity)
  let M := max K 2
  refine ⟨2 * M, fun N hN => ?_⟩
  have hKM : K ≤ M := le_max_left _ _
  have hM : 2 ≤ M := le_max_right _ _
  have heM := hK M hKM
  have heN := hK N (by omega : K ≤ N)
  have hh := corrected_second_window_cauchy_bound hM hN
  have hnonneg : 0 ≤ secondWindowCoefficient N ^ 2 / (N : ℝ) := by positivity
  simp only [Real.dist_eq, sub_zero, abs_of_nonneg hnonneg] at ⊢
  simp only [Real.dist_eq, sub_zero] at heM heN
  have heM' := (le_abs_self (correctedTotalError M)).trans_lt heM
  have heN' := (le_abs_self (correctedTotalError N)).trans_lt heN
  linarith

end BuildingBlocks
