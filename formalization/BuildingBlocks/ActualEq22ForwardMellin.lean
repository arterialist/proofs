import BuildingBlocks.ActualFullCenteredMellinInversion
import BuildingBlocks.ActualPrimeErrorBridge

/-! Native forward Mellin support for the Eq22 a = 0 row.

The complete prime-error and origin aggregates give the corrected native row
on the ordinary absolute-convergence half-plane. The separate arithmetic
identity identifies this row with the literal original residual. The existing
contour upper remains written and unformalized; stronger arithmetic estimates
and the eventual RH sign remain open. -/

open MeasureTheory Set Filter
open scoped BigOperators Topology

namespace BuildingBlocks.ActualEq22ForwardMellin

noncomputable def countBaseline (x : ℝ) : ℂ :=
  (((max x 1 : ℝ) : ℂ) ^ 2 - 1) / 2

noncomputable def Acore (x : ℝ) : ℂ :=
  RieszDirichlet.cutoffSum DistinctPrimeRieszMellin.lambda x - countBaseline x

noncomputable def A : ℝ → ℂ := CriticalMultipleMellin.cutoffSum Acore
noncomputable def Zcore : ℝ → ℂ := RieszTentMellin.tent 1
noncomputable def Z : ℝ → ℂ := CriticalMultipleMellin.cutoffSum Zcore
noncomputable def C (x : ℝ) : ℂ :=
  ActualFullCenteredMellin.fullNumerator x + 2 * A x + Z x

theorem countBaseline_eq_step (x : ℝ) : countBaseline x =
    (1 / 2 : ℂ) • ((x : ℂ) ^ (2 : ℂ) • EtaBaselineMellin.step x) -
      (1 / 2 : ℂ) • EtaBaselineMellin.step x := by
  by_cases hx : 1 < x
  · simp [countBaseline, EtaBaselineMellin.step, hx, max_eq_left hx.le,
      Complex.cpow_ofNat, smul_eq_mul]
    ring
  · simp [countBaseline, EtaBaselineMellin.step, hx,
      max_eq_right (le_of_not_gt hx)]

theorem countBaseline_zero {x : ℝ} (hx : x ≤ 1) : countBaseline x = 0 := by
  simp [countBaseline, max_eq_right hx]

theorem countBaseline_eq {x : ℝ} (hx : 1 ≤ x) :
    countBaseline x = ((x : ℂ) ^ 2 - 1) / 2 := by
  simp [countBaseline, max_eq_left hx]

theorem Acore_zero {x : ℝ} (hx : x ≤ 1) : Acore x = 0 := by
  unfold Acore
  rw [countBaseline_zero hx, sub_zero]
  unfold RieszDirichlet.cutoffSum
  apply Finset.sum_eq_zero
  intro n hn
  have hz : x - ((n : ℝ) + 1) ≤ 0 := by linarith [Nat.cast_nonneg (α := ℝ) n]
  simp [RieszTentMellin.tent, max_eq_right hz]

theorem Zcore_zero {x : ℝ} (hx : x ≤ 1) : Zcore x = 0 := by
  simp [Zcore, RieszTentMellin.tent, max_eq_right (sub_nonpos.mpr hx)]

theorem continuous_countBaseline : Continuous countBaseline := by
  unfold countBaseline
  fun_prop

theorem continuous_Acore : Continuous Acore :=
  (ActualFullCenteredMellinInversion.continuous_rieszCutoff
    DistinctPrimeRieszMellin.lambda).sub continuous_countBaseline

theorem continuous_Zcore : Continuous Zcore :=
  ActualFullCenteredMellinInversion.continuous_tent 1

private theorem cutoff_eq_fixed_sum
    (g : ℕ → ℝ → ℂ)
    (hz : ∀ (n : ℕ) (x : ℝ), x ≤ (n : ℝ) + 1 → g n x = 0)
    {N : ℕ} {x : ℝ} (hx : x ≤ N) :
    (∑ n ∈ Finset.range ⌊x⌋₊, g n x) = ∑ n ∈ Finset.range N, g n x := by
  have hfloor : ⌊x⌋₊ ≤ N := by simpa using Nat.floor_mono hx
  apply Finset.sum_subset (Finset.range_mono hfloor)
  intro n hn hnout
  have hnx : ⌊x⌋₊ ≤ n := by simpa using hnout
  have hlt := Nat.lt_floor_add_one x
  have hnr : (⌊x⌋₊ : ℝ) ≤ n := by exact_mod_cast hnx
  exact hz n x (by linarith)

theorem continuous_criticalCutoff {f : ℝ → ℂ} (hf : Continuous f)
    (hz : ∀ x : ℝ, x ≤ 1 → f x = 0) :
    Continuous (CriticalMultipleMellin.cutoffSum f) := by
  apply continuous_iff_continuousAt.mpr
  intro x
  obtain ⟨N, hN⟩ := exists_nat_gt x
  have hcont : Continuous (fun y => ∑ n ∈ Finset.range N,
      CriticalMultipleMellin.scaled f (n + 1) y) := by
    apply continuous_finset_sum
    intro n hn
    unfold CriticalMultipleMellin.scaled
    exact continuous_const.mul (hf.comp (continuous_id.div_const _))
  apply hcont.continuousAt.congr_of_eventuallyEq
  filter_upwards [eventually_lt_nhds hN] with y hy
  apply cutoff_eq_fixed_sum _ _ hy.le
  intro n z hzn
  have hd : (0 : ℝ) < n + 1 := by positivity
  have hz1 : z / ((n : ℝ) + 1) ≤ 1 := (div_le_one hd).mpr hzn
  simp [CriticalMultipleMellin.scaled, hz _ hz1]

theorem continuous_A : Continuous A :=
  continuous_criticalCutoff continuous_Acore (fun _ hx => Acore_zero hx)

theorem continuous_Z : Continuous Z :=
  continuous_criticalCutoff continuous_Zcore (fun _ hx => Zcore_zero hx)

theorem continuous_C : Continuous C :=
  (ActualFullCenteredMellinInversion.continuous_fullNumerator.add
    (continuous_const.mul continuous_A)).add continuous_Z

theorem hasMellin_countBaseline {s : ℂ} (hs : 1 < s.re) :
    HasMellin countBaseline (-s - 1) (1 / ((s - 1) * (s + 1))) := by
  have hp := EtaBaselineMellin.hasMellin_cpow_step
    (s := -s - 1) (a := 2) (by simp; linarith)
  have hc := EtaBaselineMellin.hasMellin_step (s := -s - 1) (by simp; linarith)
  have hp' := hasMellin_const_smul hp.1 (1 / 2 : ℂ)
  have hc' := hasMellin_const_smul hc.1 (1 / 2 : ℂ)
  have ht := hasMellin_sub hp'.1 hc'.1
  have he : countBaseline = fun x : ℝ =>
      (1 / 2 : ℂ) • ((x : ℂ) ^ (2 : ℂ) • EtaBaselineMellin.step x) -
        (1 / 2 : ℂ) • EtaBaselineMellin.step x := funext countBaseline_eq_step
  rw [he]
  refine ⟨ht.1, ?_⟩
  rw [ht.2, hp'.2, hc'.2, hp.2, hc.2]
  have h1 : s - 1 ≠ 0 := by
    intro h; have hr := congrArg Complex.re h; simp at hr; linarith
  have h2 : s + 1 ≠ 0 := by
    intro h; have hr := congrArg Complex.re h; simp at hr; linarith
  have h3 : -s - 1 + 2 ≠ 0 := by
    intro h; have hr := congrArg Complex.re h; simp at hr; linarith
  have h4 : -s - 1 ≠ 0 := by
    intro h; have hr := congrArg Complex.re h; simp at hr; linarith
  simp only [smul_eq_mul]
  field_simp
  ring

theorem hasMellin_Acore {s : ℂ} (hs : 1 < s.re) :
    HasMellin Acore (-s - 1)
      (LogDerivativePole.centeredZetaLogDerivative s / (s * (s + 1))) := by
  have hl : LSeriesHasSum DistinctPrimeRieszMellin.lambda s
      (-deriv riemannZeta s / riemannZeta s) :=
    LSeriesHasSum_iff.mpr ⟨ArithmeticFunction.LSeriesSummable_vonMangoldt hs,
      ArithmeticFunction.LSeries_vonMangoldt_eq_deriv_riemannZeta_div hs⟩
  have hp := DistinctPrimeRieszMellin.hasMellin_cutoffSum_of_LSeriesHasSum
    (by linarith : 0 < s.re) hl
  have hb := hasMellin_countBaseline hs
  have ht := hasMellin_sub hp.1 hb.1
  refine ⟨ht.1, ?_⟩
  change mellin (fun x => RieszDirichlet.cutoffSum DistinctPrimeRieszMellin.lambda x -
    countBaseline x) (-s - 1) = _
  rw [ht.2, hp.2, hb.2]
  have h0 : s ≠ 0 := by intro h; simp [h] at hs; linarith
  have h1 : s - 1 ≠ 0 := by
    intro h; have hr := congrArg Complex.re h; simp at hr; linarith
  have h2 : s + 1 ≠ 0 := by
    intro h; have hr := congrArg Complex.re h; simp at hr; linarith
  unfold LogDerivativePole.centeredZetaLogDerivative
  rw [logDeriv_apply]
  field_simp

theorem hasMellin_A {s : ℂ} (hs : 1 < s.re) :
    HasMellin A (-s - 1)
      (riemannZeta (s + 1 / 2) * LogDerivativePole.centeredZetaLogDerivative s /
        (s * (s + 1))) := by
  have h := CriticalMultipleMellin.hasMellin_cutoffSum
    (by linarith : (1 : ℝ) / 2 < s.re)
    (fun x hx => Acore_zero hx) (hasMellin_Acore hs)
  convert h using 1
  ring

theorem hasMellin_Zcore {s : ℂ} (hs : 0 < s.re) :
    HasMellin Zcore (-s - 1) (1 / (s * (s + 1))) := by
  simpa [Zcore] using RieszTentMellin.hasMellin_tent (a := 1) (by norm_num) hs

theorem hasMellin_Z {s : ℂ} (hs : (1 : ℝ) / 2 < s.re) :
    HasMellin Z (-s - 1) (riemannZeta (s + 1 / 2) / (s * (s + 1))) := by
  have h := CriticalMultipleMellin.hasMellin_cutoffSum hs
    (fun x hx => Zcore_zero hx) (hasMellin_Zcore (by linarith : 0 < s.re))
  convert h using 1
  ring

theorem hasMellin_C {s : ℂ} (hs : 1 < s.re) :
    HasMellin C (-s - 1)
      (riemannZeta (s + 1 / 2) * (LogDerivativePole.centeredZetaLogDerivative s + 1) ^ 2 /
        (s * (s + 1))) := by
  have hn := ActualFullCenteredMellin.hasMellin_fullNumerator hs
  have ha := hasMellin_A hs
  have hz := hasMellin_Z (by linarith : (1 : ℝ) / 2 < s.re)
  have ha2 := hasMellin_const_smul ha.1 (2 : ℂ)
  have hsum := hasMellin_add hn.1 ha2.1
  have ht := hasMellin_add hsum.1 hz.1
  refine ⟨ht.1, ?_⟩
  change mellin (fun x => ActualFullCenteredMellin.fullNumerator x +
    (2 : ℂ) • A x + Z x) (-s - 1) = _
  rw [ht.2, hsum.2, hn.2, ha2.2, ha.2, hz.2]
  simp only [smul_eq_mul]
  ring

theorem centered_add_one_eq {s : ℂ} (hs : s ≠ 1) :
    LogDerivativePole.centeredZetaLogDerivative s + 1 =
      -(1 / (s - 1) + logDeriv riemannZeta s) := by
  unfold LogDerivativePole.centeredZetaLogDerivative
  field_simp [sub_ne_zero.mpr hs]
  ring

theorem hasMellin_C_a0 {s : ℂ} (hs : 1 < s.re) :
    HasMellin C (-s - 1)
      (riemannZeta (s + 1 / 2) *
        (1 / (s - 1) + deriv riemannZeta s / riemannZeta s) ^ 2 /
        (s * (s + 1))) := by
  have h := hasMellin_C hs
  have hs1 : s ≠ 1 := by intro he; simp [he] at hs
  rw [centered_add_one_eq hs1, neg_sq, logDeriv_apply] at h
  exact h

private theorem rieszCutoff_eq_Icc (c : ℕ → ℂ) {x : ℝ} (hx : 0 ≤ x) :
    RieszDirichlet.cutoffSum c x =
      ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, ((x - n : ℝ) : ℂ) * c n := by
  unfold RieszDirichlet.cutoffSum
  apply Finset.sum_bij (fun j _ => j + 1)
  · intro j hj
    simp only [Finset.mem_range] at hj
    simp only [Finset.mem_Icc]
    omega
  · intro i hi j hj hij
    omega
  · intro n hn
    simp only [Finset.mem_Icc] at hn
    exact ⟨n - 1, Finset.mem_range.mpr (by omega), by omega⟩
  · intro j hj
    have hjn : j + 1 ≤ ⌊x⌋₊ := by simpa only [Finset.mem_range] using hj
    have hjx : (j : ℝ) + 1 ≤ x := by
      have hcast : (j : ℝ) + 1 ≤ (⌊x⌋₊ : ℝ) := by exact_mod_cast hjn
      exact hcast.trans (Nat.floor_le hx)
    simp only [RieszTentMellin.tent, Nat.cast_add, Nat.cast_one,
      max_eq_left (sub_nonneg.mpr hjx)]
    ring

theorem Acore_eq_Jfinite {x : ℝ} (hx : 1 ≤ x) :
    Acore x = (ActualPrimeErrorBridge.Jfinite x : ℂ) := by
  unfold Acore ActualPrimeErrorBridge.Jfinite
  rw [rieszCutoff_eq_Icc _ (by linarith), countBaseline_eq hx]
  simp only [DistinctPrimeRieszMellin.lambda]
  push_cast
  congr 1
  apply Finset.sum_congr rfl
  intro n hn
  ring

theorem criticalCutoff_eq_Icc (f : ℝ → ℂ) (x : ℝ) :
    CriticalMultipleMellin.cutoffSum f x =
      ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, (Real.sqrt d : ℂ) * f (x / d) := by
  unfold CriticalMultipleMellin.cutoffSum
  apply Finset.sum_bij (fun j _ => j + 1)
  · intro j hj
    simp only [Finset.mem_range] at hj
    simp only [Finset.mem_Icc]
    omega
  · intro i hi j hj hij
    omega
  · intro n hn
    simp only [Finset.mem_Icc] at hn
    exact ⟨n - 1, Finset.mem_range.mpr (by omega), by omega⟩
  · intro j hj
    simp [CriticalMultipleMellin.scaled]

theorem A_eq_actual_Aold {x : ℝ} (hx : 0 ≤ x) :
    A x = (ActualPrimeErrorBridge.Aold x : ℂ) := by
  rw [A, criticalCutoff_eq_Icc, ActualPrimeErrorBridge.Aold_eq_Jfinite]
  push_cast
  apply Finset.sum_congr rfl
  intro d hd
  obtain ⟨hd1, hdfloor⟩ := Finset.mem_Icc.mp hd
  have hdR : (0 : ℝ) < d := by exact_mod_cast hd1
  have hdx : (d : ℝ) ≤ x := by
    have hreal : (d : ℝ) ≤ ⌊x⌋₊ := by exact_mod_cast hdfloor
    exact hreal.trans (Nat.floor_le hx)
  rw [Acore_eq_Jfinite ((one_le_div hdR).mpr hdx)]

theorem Z_eq_actual_Z {x : ℝ} (hx : 0 ≤ x) :
    Z x = (ActualVolterraIdentity.Z x : ℂ) := by
  rw [Z, criticalCutoff_eq_Icc]
  unfold ActualVolterraIdentity.Z ActualPrimeCutoffCovarianceFinite.cutoffMass
  push_cast
  apply Finset.sum_congr rfl
  intro d hd
  obtain ⟨hd1, hdfloor⟩ := Finset.mem_Icc.mp hd
  have hdR : (0 : ℝ) < d := by exact_mod_cast hd1
  have hdx : (d : ℝ) ≤ x := by
    have hreal : (d : ℝ) ≤ ⌊x⌋₊ := by exact_mod_cast hdfloor
    exact hreal.trans (Nat.floor_le hx)
  have hquot : 1 ≤ x / d := (one_le_div hdR).mpr hdx
  have ht := PrimeHistoryDivisorResponse.cofactor_tent_weight
    (fun _ : ℕ => (1 : ℝ)) (by omega : 0 < d) (by norm_num : 0 < (1 : ℕ))
    (by simpa using hdx)
  simp only [Nat.cast_one, Real.sqrt_one, mul_one] at ht
  simp only [Zcore, RieszTentMellin.tent,
    max_eq_left (sub_nonneg.mpr hquot)]
  exact_mod_cast ht

theorem C_eq_corrected_actual_row {x : ℝ} (hx : 0 ≤ x) :
    C x = ActualFullCenteredMellin.fullNumerator x +
      2 * (ActualPrimeErrorBridge.Aold x : ℂ) + (ActualVolterraIdentity.Z x : ℂ) := by
  simp only [C, A_eq_actual_Aold hx, Z_eq_actual_Z hx]

theorem criticalCutoff_zero {f : ℝ → ℂ}
    (hf : ∀ y : ℝ, y ≤ 1 → f y = 0) {x : ℝ} (hx : x ≤ 1) :
    CriticalMultipleMellin.cutoffSum f x = 0 := by
  rw [criticalCutoff_eq_Icc]
  apply Finset.sum_eq_zero
  intro d hd
  have hd1 : (1 : ℝ) ≤ d := by exact_mod_cast (Finset.mem_Icc.mp hd).1
  have hxd : x / d ≤ 1 := (div_le_one (by linarith)).mpr (hx.trans hd1)
  rw [hf _ hxd, mul_zero]

theorem A_zero {x : ℝ} (hx : x ≤ 1) : A x = 0 :=
  criticalCutoff_zero (fun y hy => Acore_zero hy) hx

theorem Z_zero {x : ℝ} (hx : x ≤ 1) : Z x = 0 :=
  criticalCutoff_zero (fun y hy => Zcore_zero hy) hx

theorem C_zero {x : ℝ} (hx : x ≤ 1) : C x = 0 := by
  simp [C, ActualFullCenteredMellin.fullNumerator_zero hx, A_zero hx, Z_zero hx]

theorem Acore_real (x : ℝ) : (Acore x).im = 0 := by
  simp [Acore, RieszDirichlet.cutoffSum, DistinctPrimeRieszMellin.lambda,
    RieszTentMellin.tent, countBaseline, pow_two, Complex.mul_im]

theorem A_real (x : ℝ) : (A x).im = 0 := by
  rw [A, criticalCutoff_eq_Icc]
  simp [Complex.mul_im, Acore_real]

theorem Z_real (x : ℝ) : (Z x).im = 0 := by
  simp [Z, CriticalMultipleMellin.cutoffSum, CriticalMultipleMellin.scaled,
    Zcore, RieszTentMellin.tent, Complex.mul_im]

theorem C_real (x : ℝ) : (C x).im = 0 := by
  simp [C, ActualFullCenteredMellin.fullNumerator_real, A_real, Z_real, Complex.mul_im]

end BuildingBlocks.ActualEq22ForwardMellin
