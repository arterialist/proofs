import BuildingBlocks.ActualCriticalLaplace
import BuildingBlocks.CriticalTransformRealAxis
import BuildingBlocks.LandauSingularity
import BuildingBlocks.LaplaceConvergenceAnalytic
import BuildingBlocks.RealAxisAnalyticContinuation

open MeasureTheory Set Filter
open scoped Topology

namespace BuildingBlocks.ActualCriticalConvergence

/-- The continuation candidate for the positive negative-tail measure. The
compact initial contribution is retained throughout the Landau argument. -/
noncomputable def tailTransform (A : ℝ) (s : ℂ) : ℂ :=
  mellin (MellinCompactCorrection.initialPart ActualCriticalMellin.W A) (-s - 1) -
    CriticalTransformPoles.filledTransform s

theorem tailTransform_analyticAt_real (A : ℝ) {σ : ℝ} (hσ : (1 : ℝ) / 2 < σ) :
    AnalyticAt ℂ (tailTransform A) (σ : ℂ) :=
  ((MellinCompactCorrection.differentiable_W_initialPart A).analyticAt (σ : ℂ)).sub
    (CriticalTransformRealAxis.analyticAt_filledTransform_real hσ)

theorem tailTransform_eq_laplace {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {s : ℂ} (hs : 1 < s.re) :
    tailTransform A s = LaplaceMomentDerivatives.moment
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time 0 s :=
  (ActualCriticalLaplace.moment_eq_initial_sub_filledTransform hA hsign hs).symm

theorem cutoff_of_eventually_nonpos
    (hsign : ∀ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re ≤ 0) :
    ∃ A : ℝ, 1 ≤ A ∧ ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0 := by
  obtain ⟨B, hB⟩ := eventually_atTop.1 hsign
  refine ⟨max 1 B, le_max_left _ _, ?_⟩
  intro x hx
  exact hB x ((le_max_right 1 B).trans hx.le)

/-- The finite abscissa cannot lie to the right of one half. The proof uses
real-axis compatibility and the positive-measure Landau theorem, not an
identification of analytic continuation with a convergent integral. -/
theorem finite_abscissa_le_half {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    (hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time)) :
    sInf (LaplaceConvergenceAbscissa.convergenceSet
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time) ≤ (1 : ℝ) / 2 := by
  by_contra hle
  have hhalf := lt_of_not_ge hle
  have hne := ActualCriticalMeasure.convergenceSet_nonempty hA hsign
  have ht : ∀ᵐ x ∂ActualCriticalMeasure.tailMeasure A, 0 ≤ ActualCriticalMeasure.time x :=
    Eventually.of_forall ActualCriticalMeasure.time_nonneg
  have hL := LaplaceConvergenceAnalytic.analyticOnNhd_above_inf
    ActualCriticalMeasure.measurable_time ht hne hbdd
  obtain ⟨R, hR, hF, heq⟩ := RealAxisAnalyticContinuation.exists_right_disk_agreement
    (F := tailTransform A) (β := (1 : ℝ) / 2) (B := 1)
    (fun σ hσ => tailTransform_analyticAt_real A hσ) hL
    (fun σ hσ => tailTransform_eq_laplace hA hsign (s := (σ : ℂ)) hσ) hhalf
  exact LandauSingularity.finite_abscissa_singular ActualCriticalMeasure.measurable_time
    ht hne hbdd hR hF heq

/-- The sign assumption implies actual Laplace integrability at every real
parameter above one half, including the unbounded-below-abscissa case. -/
theorem laplace_integrable_above_half {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {σ : ℝ} (hσ : (1 : ℝ) / 2 < σ) :
    Integrable (fun x => Real.exp (-σ * ActualCriticalMeasure.time x))
      (ActualCriticalMeasure.tailMeasure A) := by
  have ht : ∀ᵐ x ∂ActualCriticalMeasure.tailMeasure A, 0 ≤ ActualCriticalMeasure.time x :=
    Eventually.of_forall ActualCriticalMeasure.time_nonneg
  by_cases hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time)
  · exact LaplaceConvergenceAbscissa.integrable_above_inf _ _
      ActualCriticalMeasure.measurable_time ht
      (ActualCriticalMeasure.convergenceSet_nonempty hA hsign) hbdd
      ((finite_abscissa_le_half hA hsign hbdd).trans_lt hσ)
  · apply (LaplaceConvergenceAbscissa.integrable_iff_mem _ _
      ActualCriticalMeasure.measurable_time σ).2
    rw [LaplaceConvergenceAbscissa.convergenceSet_eq_univ_of_not_bddBelow _ _ ht hbdd]
    exact mem_univ _

/-- Holomorphy of the integral follows from the newly proved convergence. -/
theorem laplace_analyticOnNhd_above_half {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) :
    AnalyticOnNhd ℂ (LaplaceMomentDerivatives.moment
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time 0)
      {s : ℂ | (1 : ℝ) / 2 < s.re} := by
  have ht : ∀ᵐ x ∂ActualCriticalMeasure.tailMeasure A, 0 ≤ ActualCriticalMeasure.time x :=
    Eventually.of_forall ActualCriticalMeasure.time_nonneg
  by_cases hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time)
  · apply (LaplaceConvergenceAnalytic.analyticOnNhd_above_inf
      ActualCriticalMeasure.measurable_time ht
      (ActualCriticalMeasure.convergenceSet_nonempty hA hsign) hbdd).mono
    intro s hs
    exact (finite_abscissa_le_half hA hsign hbdd).trans_lt hs
  · exact (LaplaceConvergenceAnalytic.analyticOnNhd_of_not_bddBelow
      ActualCriticalMeasure.measurable_time ht hbdd).mono (subset_univ _)

noncomputable def continuation (A : ℝ) (s : ℂ) : ℂ :=
  mellin (MellinCompactCorrection.initialPart ActualCriticalMellin.W A) (-s - 1) -
    LaplaceMomentDerivatives.moment
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time 0 s

theorem continuation_analyticOnNhd {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) :
    AnalyticOnNhd ℂ (continuation A) {s : ℂ | (1 : ℝ) / 2 < s.re} := by
  intro s hs
  exact ((MellinCompactCorrection.differentiable_W_initialPart A).analyticAt s).sub
    (laplace_analyticOnNhd_above_half hA hsign s hs)

theorem continuation_eq_filledTransform {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {s : ℂ} (hs : 1 < s.re) :
    continuation A s = CriticalTransformPoles.filledTransform s := by
  unfold continuation
  rw [ActualCriticalLaplace.moment_eq_initial_sub_filledTransform hA hsign hs]
  ring

end BuildingBlocks.ActualCriticalConvergence
