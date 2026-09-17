import BuildingBlocks.LogDerivativePole
import BuildingBlocks.SamePrimeDirichlet
import BuildingBlocks.RiemannZetaCenteredLogDeriv

open Filter
open scoped Topology

namespace BuildingBlocks.CriticalTransformPoles

/-- The fully specified candidate analytic transform. No identification with
an infinite Mellin integral is asserted in this module. -/
noncomputable def transform (s : ℂ) : ℂ :=
  ShiftedZetaMultiplier.M s *
    (LogDerivativePole.centeredZetaLogDerivative s ^ 2 - SamePrimeDirichlet.H s)

/-- Correct only the removable value at `1`; retain the candidate at all other points. -/
noncomputable def filledTransform : ℂ → ℂ := by
  classical
  exact Function.update transform 1
    (ShiftedZetaMultiplier.M 1 *
      ((-(Real.eulerMascheroniConstant : ℂ) - 1) ^ 2 - SamePrimeDirichlet.H 1))

@[simp] theorem filledTransform_one :
    filledTransform 1 = ShiftedZetaMultiplier.M 1 *
      ((-(Real.eulerMascheroniConstant : ℂ) - 1) ^ 2 - SamePrimeDirichlet.H 1) := by
  simp [filledTransform]

theorem filledTransform_eq_of_ne {s : ℂ} (hs : s ≠ 1) : filledTransform s = transform s := by
  simp [filledTransform, hs]

theorem filledTransform_eq : filledTransform = fun s => ShiftedZetaMultiplier.M s *
    (RiemannZetaCenteredLogDeriv.Gfilled s ^ 2 - SamePrimeDirichlet.H s) := by
  funext s
  by_cases hs : s = 1
  · subst s
    rw [filledTransform_one, RiemannZetaCenteredLogDeriv.Gfilled_one]
  · rw [filledTransform_eq_of_ne hs, RiemannZetaCenteredLogDeriv.Gfilled_eq_of_ne hs]
    simp only [transform, LogDerivativePole.centeredZetaLogDerivative,
      RiemannZetaCenteredLogDeriv.G, logDeriv_apply, neg_div]

theorem analyticAt_filledTransform_one : AnalyticAt ℂ filledTransform 1 := by
  rw [filledTransform_eq]
  exact (ShiftedZetaMultiplier.analyticAt_M (s := 1) (by
    norm_num [ShiftedZetaMultiplier.domain])).mul
      ((RiemannZetaCenteredLogDeriv.analyticAt_Gfilled_one.pow 2).sub
        (SamePrimeDirichlet.H_analyticAt (s := 1) (by norm_num)))

theorem filledTransform_eventuallyEq {ρ : ℂ} (hρ : ρ ≠ 1) :
    filledTransform =ᶠ[𝓝 ρ] transform := by
  filter_upwards [eventually_ne_nhds hρ] with s hs
  exact filledTransform_eq_of_ne hs

/-- The actual same-prime series is analytic at the zero, so it cannot remove
the double pole. All zero multiplicities and the shifted multiplier survive. -/
theorem pole_at_zeta_zero {ρ : ℂ} (hρre : (1 : ℝ) / 2 < ρ.re)
    (hρ : ρ ≠ 1) (hz : riemannZeta ρ = 0) :
    ∃ m : ℕ, 1 ≤ m ∧ analyticOrderAt riemannZeta ρ = m ∧
      meromorphicOrderAt transform ρ = (-2 : ℤ) ∧
      meromorphicTrailingCoeffAt transform ρ = ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2 ∧
      ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2 ≠ 0 := by
  exact LogDerivativePole.actual_zeta_zero_double_pole hρre hρ hz
    (SamePrimeDirichlet.H_analyticAt hρre)

theorem not_analyticAt_zeta_zero {ρ : ℂ} (hρre : (1 : ℝ) / 2 < ρ.re)
    (hρ : ρ ≠ 1) (hz : riemannZeta ρ = 0) : ¬ AnalyticAt ℂ transform ρ := by
  intro ha
  obtain ⟨m, hm, horder, hpole, hcoeff, hnonzero⟩ := pole_at_zeta_zero hρre hρ hz
  have hnonneg := ha.meromorphicOrderAt_nonneg
  rw [hpole] at hnonneg
  have himpossible : (0 : ℤ) ≤ -2 := by exact_mod_cast hnonneg
  omega

/-- Filling the value at `1` changes neither the pole order nor its leading
coefficient at any actual off-line zero. -/
theorem filled_pole_at_zeta_zero {ρ : ℂ} (hρre : (1 : ℝ) / 2 < ρ.re)
    (hρ : ρ ≠ 1) (hz : riemannZeta ρ = 0) :
    ∃ m : ℕ, 1 ≤ m ∧ analyticOrderAt riemannZeta ρ = m ∧
      meromorphicOrderAt filledTransform ρ = (-2 : ℤ) ∧
      meromorphicTrailingCoeffAt filledTransform ρ = ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2 ∧
      ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2 ≠ 0 := by
  have heq : filledTransform =ᶠ[𝓝[≠] ρ] transform :=
    (filledTransform_eventuallyEq hρ).filter_mono nhdsWithin_le_nhds
  rw [meromorphicOrderAt_congr heq, meromorphicTrailingCoeffAt_congr_nhdsNE heq]
  exact pole_at_zeta_zero hρre hρ hz

end BuildingBlocks.CriticalTransformPoles
