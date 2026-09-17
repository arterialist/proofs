import BuildingBlocks.FullComplexHistoryMellin
import BuildingBlocks.ActualPhysicalResidues
import Mathlib.Analysis.Calculus.ParametricIntegral
import Mathlib.Analysis.Complex.CauchyIntegral
import Mathlib.MeasureTheory.Integral.Bochner.Set

open MeasureTheory
open BuildingBlocks.FullComplexHistoryMellin

namespace BuildingBlocks.CompactPhysicalMellinAnalytic

theorem physical_mellin_hasDerivAt {f : ℝ → ℂ} (hf : Continuous f)
    (hfc : HasCompactSupport f) (z : ℂ) :
    HasDerivAt (BuildingBlocks.FullComplexHistoryMellin.mellin f)
      (BuildingBlocks.FullComplexHistoryMellin.mellin (fun v => (v : ℂ) * f v) z) z := by
  let F : ℂ → ℝ → ℂ := fun w v => f v * Complex.exp (w * (v : ℂ))
  let F' : ℂ → ℝ → ℂ := fun w v => f v * (Complex.exp (w * (v : ℂ)) * (v : ℂ))
  have hd : ∀ w v, HasDerivAt (fun u => F u v) (F' w v) w := by
    intro w v
    dsimp [F, F']
    simpa only [one_mul] using ((hasDerivAt_id w).mul_const (v : ℂ)).cexp.const_mul (f v)
  have hc : Continuous (fun p : ℂ × ℝ => ‖F' p.1 p.2‖) := by
    dsimp [F']
    fun_prop
  obtain ⟨C, hC⟩ := ((isCompact_closedBall z 1).prod hfc).bddAbove_image hc.continuousOn
  have hm : ∀ᶠ w in nhds z, AEStronglyMeasurable (F w) (volume.restrict (tsupport f)) := by
    apply Filter.Eventually.of_forall
    intro w
    have hcont : Continuous (F w) := by dsimp [F]; fun_prop
    exact hcont.aestronglyMeasurable
  have hmi : Integrable (F z) (volume.restrict (tsupport f)) :=
    (weighted_integrable hf hfc z).integrableOn
  have hm' : AEStronglyMeasurable (F' z) (volume.restrict (tsupport f)) := by
    have hcont : Continuous (F' z) := by dsimp [F']; fun_prop
    exact hcont.aestronglyMeasurable
  have hb : ∀ᵐ v ∂volume.restrict (tsupport f),
      ∀ w ∈ Metric.ball z 1, ‖F' w v‖ ≤ C := by
    filter_upwards [ae_restrict_mem hfc.measurableSet] with v hv
    intro w hw
    have hp : (w, v) ∈ Metric.closedBall z 1 ×ˢ tsupport f :=
      ⟨Metric.ball_subset_closedBall hw, hv⟩
    exact hC ⟨(w, v), hp, rfl⟩
  have hbi : Integrable (fun _ : ℝ => C) (volume.restrict (tsupport f)) :=
    integrableOn_const hfc.measure_ne_top
  have hdi : ∀ᵐ v ∂volume.restrict (tsupport f),
      ∀ w ∈ Metric.ball z 1, HasDerivAt (fun u => F u v) (F' w v) w :=
    Filter.Eventually.of_forall (fun v w _ => hd w v)
  have main := hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (μ := volume.restrict (tsupport f)) (F := F) (F' := F') (bound := fun _ => C)
    (x₀ := z) (ε := 1) zero_lt_one hm hmi hm' hb hbi hdi
  have he : (fun w => ∫ v : ℝ in tsupport f, F w v) =
      BuildingBlocks.FullComplexHistoryMellin.mellin f := by
    funext w
    unfold BuildingBlocks.FullComplexHistoryMellin.mellin
    exact setIntegral_eq_integral_of_forall_compl_eq_zero (fun v hv => by
      dsimp [F]
      rw [image_eq_zero_of_notMem_tsupport hv, zero_mul])
  have he' : (∫ v : ℝ in tsupport f, F' z v) =
      BuildingBlocks.FullComplexHistoryMellin.mellin (fun v => (v : ℂ) * f v) z := by
    rw [setIntegral_eq_integral_of_forall_compl_eq_zero (fun v hv => by
      dsimp [F']
      rw [image_eq_zero_of_notMem_tsupport hv, zero_mul])]
    unfold BuildingBlocks.FullComplexHistoryMellin.mellin
    apply integral_congr_ae
    filter_upwards [] with v
    dsimp [F']
    ring
  have hmain := main.2
  rw [he, he'] at hmain
  exact hmain

theorem physical_mellin_entire {f : ℝ → ℂ} (hf : Continuous f)
    (hfc : HasCompactSupport f) :
    Differentiable ℂ (BuildingBlocks.FullComplexHistoryMellin.mellin f) :=
  fun z => (physical_mellin_hasDerivAt hf hfc z).differentiableAt

theorem physical_mellin_analytic {f : ℝ → ℂ} (hf : Continuous f)
    (hfc : HasCompactSupport f) (z : ℂ) :
    AnalyticAt ℂ (BuildingBlocks.FullComplexHistoryMellin.mellin f) z :=
  (physical_mellin_entire hf hfc).analyticAt z

theorem conjugate_mellin_dictionary (g : ℝ → ℂ) (z : ℂ) :
    (starRingEnd ℂ) (BuildingBlocks.FullComplexHistoryMellin.mellin g (-((starRingEnd ℂ) z))) =
      BuildingBlocks.FullComplexHistoryMellin.mellin (fun v => (starRingEnd ℂ) (g v)) (-z) := by
  unfold BuildingBlocks.FullComplexHistoryMellin.mellin
  rw [← integral_conj]
  apply integral_congr_ae
  filter_upwards [] with v
  simp only [map_mul, ← Complex.exp_conj, map_neg, Complex.conj_conj, Complex.conj_ofReal]

theorem paired_weight_entire {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) : Differentiable ℂ (pairedWeight f g) := by
  have hgc' : HasCompactSupport (fun v => (starRingEnd ℂ) (g v)) :=
    hgc.mono (fun v hv he => hv (by simp [he]))
  have hg' : Continuous (fun v => (starRingEnd ℂ) (g v)) := by fun_prop
  have hmf := physical_mellin_entire hf hfc
  have hmg := physical_mellin_entire hg' hgc'
  have he : pairedWeight f g = (fun z =>
      BuildingBlocks.FullComplexHistoryMellin.mellin f z *
        BuildingBlocks.FullComplexHistoryMellin.mellin (fun v => (starRingEnd ℂ) (g v)) (-z)) := by
    funext z
    exact congrArg (fun w => BuildingBlocks.FullComplexHistoryMellin.mellin f z * w)
      (conjugate_mellin_dictionary g z)
  rw [he]
  exact hmf.mul (hmg.comp differentiable_id.neg)

theorem paired_weight_analytic {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (z : ℂ) : AnalyticAt ℂ (pairedWeight f g) z :=
  (paired_weight_entire hf hg hfc hgc).analyticAt z

theorem centered_weight_entire {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) :
    Differentiable ℂ (fun s : ℂ => pairedWeight f g (s - 1 / 2)) :=
  (paired_weight_entire hf hg hfc hgc).comp (differentiable_id.sub_const (1 / 2))

theorem centered_weight_analytic {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : ℂ) :
    AnalyticAt ℂ (fun w : ℂ => pairedWeight f g (w - 1 / 2)) s :=
  (centered_weight_entire hf hg hfc hgc).analyticAt s

theorem finite_block_centered_weight_entire {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (ps : List ℕ) (M : ℕ) :
    Differentiable ℂ (fun s : ℂ => pairedWeight (blockPhysical ps M f)
      (blockPhysical ps M g) (s - 1 / 2)) := by
  obtain ⟨hbf, hbfc⟩ := block_regular hf hfc ps M
  obtain ⟨hbg, hbgc⟩ := block_regular hg hgc ps M
  exact centered_weight_entire hbf hbg hbfc hbgc

theorem finite_block_centered_weight_analytic {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (ps : List ℕ) (M : ℕ) (s : ℂ) :
    AnalyticAt ℂ (fun w : ℂ => pairedWeight (blockPhysical ps M f)
      (blockPhysical ps M g) (w - 1 / 2)) s :=
  (finite_block_centered_weight_entire hf hg hfc hgc ps M).analyticAt s

theorem entire_weight_circle_coefficient (F : ℂ → ℂ) (hF : Differentiable ℂ F)
    (c s : ℂ) (R : ℝ) (hs : s ∈ Metric.ball c R) :
    (∮ w in C(c, R), F w / (w - s)) = (2 * Real.pi * Complex.I) * F s := by
  have h := Complex.circleIntegral_sub_inv_smul_of_differentiable_on_off_countable
    (f := F) (s := ∅) Set.countable_empty hs hF.continuous.continuousOn
    (fun w _ => hF w)
  simpa only [smul_eq_mul, div_eq_mul_inv, mul_comm] using h

theorem pole_null_circle_corrections {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g)
    (hm : BuildingBlocks.FullComplexHistoryMellin.mellin f (-1 / 2) = 0)
    (hp : BuildingBlocks.FullComplexHistoryMellin.mellin f (1 / 2) = 0)
    (c : ℂ) (R : ℝ) (h0 : (0 : ℂ) ∈ Metric.ball c R) (h1 : (1 : ℂ) ∈ Metric.ball c R) :
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight f g w / w) = 0 ∧
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight f g w / (w - 1)) = 0 := by
  have hF : Differentiable ℂ (BuildingBlocks.ActualPhysicalResidues.centeredWeight f g) :=
    centered_weight_entire hf hg hfc hgc
  obtain ⟨hz0, hz1⟩ := BuildingBlocks.ActualPhysicalResidues.centered_weight_pole_null (g := g) hm hp
  constructor
  · simpa only [sub_zero, hz0, mul_zero] using
      entire_weight_circle_coefficient _ hF c 0 R h0
  · simpa only [hz1, mul_zero] using
      entire_weight_circle_coefficient _ hF c 1 R h1

theorem finite_block_pole_null_circle_corrections {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (primes : Finset ℕ)
    (hp : ∀ p ∈ primes, 2 ≤ p) (M : ℕ)
    (hm : BuildingBlocks.FullComplexHistoryMellin.mellin f (-1 / 2) = 0)
    (hplus : BuildingBlocks.FullComplexHistoryMellin.mellin f (1 / 2) = 0)
    (c : ℂ) (R : ℝ) (h0 : (0 : ℂ) ∈ Metric.ball c R) (h1 : (1 : ℂ) ∈ Metric.ball c R) :
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w / w) = 0 ∧
    (∮ w in C(c, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w / (w - 1)) = 0 := by
  have hF : Differentiable ℂ (BuildingBlocks.ActualPhysicalResidues.centeredWeight
      (blockPhysical primes.toList M f) (blockPhysical primes.toList M g)) :=
    finite_block_centered_weight_entire hf hg hfc hgc primes.toList M
  obtain ⟨hz0, hz1⟩ := BuildingBlocks.ActualPhysicalResidues.finite_block_pole_null
    (g := g) hf hfc primes hp M hm hplus
  constructor
  · simpa only [sub_zero, hz0, mul_zero] using
      entire_weight_circle_coefficient _ hF c 0 R h0
  · simpa only [hz1, mul_zero] using
      entire_weight_circle_coefficient _ hF c 1 R h1

#print axioms physical_mellin_hasDerivAt
#print axioms physical_mellin_entire
#print axioms physical_mellin_analytic
#print axioms conjugate_mellin_dictionary
#print axioms paired_weight_entire
#print axioms paired_weight_analytic
#print axioms centered_weight_entire
#print axioms centered_weight_analytic
#print axioms finite_block_centered_weight_entire
#print axioms finite_block_centered_weight_analytic
#print axioms entire_weight_circle_coefficient
#print axioms pole_null_circle_corrections
#print axioms finite_block_pole_null_circle_corrections
end BuildingBlocks.CompactPhysicalMellinAnalytic
