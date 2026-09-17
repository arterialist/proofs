import BuildingBlocks.ActualCenteredMellin
import BuildingBlocks.CriticalMultipleMellin
import BuildingBlocks.CriticalTransformPoles

open scoped BigOperators
open MeasureTheory Set

namespace BuildingBlocks.ActualCriticalMellin

open ActualCenteredMellin

theorem V_zero {x : ℝ} (hx : x ≤ 1) : V x = 0 := by
  have hd : RieszDirichlet.cutoffSum DistinctPrimeRieszMellin.distinctPair x = 0 := by
    apply Finset.sum_eq_zero
    intro j hj
    have h : x - ((j : ℝ)+1) ≤ 0 := by linarith [Nat.cast_nonneg (α := ℝ) j]
    simp [RieszTentMellin.tent, max_eq_right h]
  have he : etaSum x = 0 := by
    apply Finset.sum_eq_zero
    intro j hj
    have h : x ≤ (j : ℝ)+1 := by linarith [Nat.cast_nonneg (α := ℝ) j]
    simp [EtaRieszKernel.kernel_eq_zero h]
  simp [V, hd, he, EtaBaselineMellin.B, not_lt.mpr hx]

theorem V_real (x : ℝ) : (V x).im = 0 := by
  have hk (a t : ℝ) : (EtaRieszKernel.kernel a t).im = 0 := by
    unfold EtaRieszKernel.kernel
    split_ifs <;> rfl
  have hb : (EtaBaselineMellin.B x).im = 0 := by
    simp [EtaBaselineMellin.B, pow_two, Complex.mul_im, apply_ite]
  simp [V, RieszDirichlet.cutoffSum, DistinctPrimeRieszMellin.distinctPair,
    RieszTentMellin.tent, etaSum, hk, hb, Complex.mul_im]

/-- The critical square-root aggregation at the actual real cutoff. -/
noncomputable def W (x : ℝ) : ℂ := CriticalMultipleMellin.cutoffSum V x

/-- Every positive integer multiple is present, including its zero-weight
birth endpoint. There is no infinite-sum convention in this definition. -/
theorem W_eq_Icc (x : ℝ) :
    W x = ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, (Real.sqrt d : ℂ) * V (x/d) := by
  unfold W CriticalMultipleMellin.cutoffSum
  apply Finset.sum_bij (fun j _ => j+1)
  · intro j hj
    simp only [Finset.mem_range] at hj
    simp only [Finset.mem_Icc]
    omega
  · intro i hi j hj hij
    omega
  · intro n hn
    simp only [Finset.mem_Icc] at hn
    exact ⟨n-1, Finset.mem_range.mpr (by omega), by omega⟩
  · intro j hj
    simp [CriticalMultipleMellin.scaled]

theorem W_real (x : ℝ) : (W x).im = 0 := by
  rw [W_eq_Icc]
  simp [Complex.mul_im, V_real]

theorem W_eq_real_sum (x : ℝ) :
    W x = ((∑ d ∈ Finset.Icc 1 ⌊x⌋₊, Real.sqrt d * (V (x/d)).re : ℝ) : ℂ) := by
  apply Complex.ext
  · rw [W_eq_Icc]
    simp [Complex.mul_re]
  · simp [W_real]

theorem W_zero {x : ℝ} (hx : x ≤ 1) : W x = 0 := by
  rw [W_eq_Icc]
  apply Finset.sum_eq_zero
  intro d hd
  have hd1 : (1 : ℝ) ≤ d := by exact_mod_cast (Finset.mem_Icc.mp hd).1
  have hxd : x / d ≤ 1 := (div_le_one (by linarith)).mpr (hx.trans hd1)
  rw [V_zero hxd, mul_zero]

/-- The previously defined critical transform is the Mellin transform of the
actual arithmetic sum, on the ordinary absolute-convergence half-plane. -/
theorem hasMellin_W {s : ℂ} (hs : 1 < s.re) :
    HasMellin W (-s-1) (CriticalTransformPoles.transform s) := by
  have h := CriticalMultipleMellin.hasMellin_cutoffSum
    (show (1 : ℝ)/2 < s.re by linarith)
    (fun x hx => V_zero hx) (ActualCenteredMellin.hasMellin_V hs)
  convert h using 1
  simp only [CriticalTransformPoles.transform, ShiftedZetaMultiplier.M]
  ring

/-- Filling the removable value at one leaves the proved Mellin formula
unchanged on Re(s)>1. No continuation of the integral is assumed. -/
theorem hasMellin_W_filled {s : ℂ} (hs : 1 < s.re) :
    HasMellin W (-s-1) (CriticalTransformPoles.filledTransform s) := by
  have hne : s ≠ 1 := by
    intro he
    simp [he] at hs
  rw [CriticalTransformPoles.filledTransform_eq_of_ne hne]
  exact hasMellin_W hs

/-- Absolute convergence of the written integral from one to infinity. -/
theorem integrableOn_W_Ioi_one {s : ℂ} (hs : 1 < s.re) :
    IntegrableOn (fun x : ℝ => (x : ℂ)^(-s-2) * W x) (Ioi 1) := by
  have hi : IntegrableOn (fun x : ℝ => (x : ℂ)^(-s-2) * W x) (Ioi 0) := by
    simpa only [MellinConvergent, smul_eq_mul,
      show (-s-1)-1 = -s-2 by ring] using (hasMellin_W hs).1
  exact hi.mono_set (Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))

/-- The actual arithmetic Mellin identity in explicit integral form, with
the lower endpoint one justified by the proved support of W. -/
theorem integral_W_Ioi_one {s : ℂ} (hs : 1 < s.re) :
    (∫ x : ℝ in Ioi 1, (x : ℂ)^(-s-2) * W x) =
      CriticalTransformPoles.transform s := by
  have he : (∫ x : ℝ in Ioi 0, (x : ℂ)^(-s-2) * W x) =
      ∫ x : ℝ in Ioi 1, (x : ℂ)^(-s-2) * W x := by
    apply setIntegral_eq_of_subset_of_forall_diff_eq_zero measurableSet_Ioi
      (Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))
    intro x hx
    rw [W_zero (le_of_not_gt hx.2), mul_zero]
  rw [← he]
  simpa only [mellin, smul_eq_mul,
    show (-s-1)-1 = -s-2 by ring] using (hasMellin_W hs).2

end BuildingBlocks.ActualCriticalMellin
