import Mathlib.NumberTheory.Harmonic.ZetaAsymp
import Mathlib.Analysis.Complex.RemovableSingularity
import Mathlib.Analysis.Analytic.Constructions
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

open Filter Set
open scoped Topology

namespace BuildingBlocks.RiemannZetaCenteredLogDeriv

/-- The actual normalized zeta function, filled with its residue at the pole. -/
noncomputable def U : ℂ → ℂ := by
  classical
  exact Function.update (fun s => (s - 1) * riemannZeta s) 1 1

@[simp] theorem U_one : U 1 = 1 := by simp [U]

theorem U_eq_of_ne {s : ℂ} (hs : s ≠ 1) : U s = (s - 1) * riemannZeta s := by
  simp [U, hs]

theorem U_eventuallyEq_of_ne {s : ℂ} (hs : s ≠ 1) :
    U =ᶠ[𝓝 s] (fun z => (z - 1) * riemannZeta z) := by
  filter_upwards [eventually_ne_nhds hs] with z hz
  exact U_eq_of_ne hz

theorem hasDerivAt_U_of_ne {s : ℂ} (hs : s ≠ 1) :
    HasDerivAt U (riemannZeta s + (s - 1) * deriv riemannZeta s) s := by
  have h := ((hasDerivAt_id s).sub_const 1).mul
    (differentiableAt_riemannZeta hs).hasDerivAt
  simp only [one_mul] at h
  exact h.congr_of_eventuallyEq (U_eventuallyEq_of_ne hs)

theorem continuousAt_U_one : ContinuousAt U 1 := by
  unfold U
  exact continuousAt_update_same.mpr riemannZeta_residue_one

/-- Removal uses the actual residue-one theorem, not a zeta nonvanishing hypothesis. -/
theorem analyticAt_U_one : AnalyticAt ℂ U 1 := by
  apply Complex.analyticAt_of_differentiable_on_punctured_nhds_of_continuousAt
    _ continuousAt_U_one
  filter_upwards [self_mem_nhdsWithin] with s hs
  exact (hasDerivAt_U_of_ne hs).differentiableAt

theorem differentiable_U : Differentiable ℂ U := by
  intro s
  by_cases hs : s = 1
  · subst s
    exact analyticAt_U_one.differentiableAt
  · exact (hasDerivAt_U_of_ne hs).differentiableAt

theorem analyticAt_U (s : ℂ) : AnalyticAt ℂ U s := differentiable_U.analyticAt s

theorem hasDerivAt_U_one :
    HasDerivAt U (Real.eulerMascheroniConstant : ℂ) 1 := by
  rw [hasDerivAt_iff_tendsto_slope, slope_fun_def_field]
  apply tendsto_riemannZeta_sub_one_div.congr'
  filter_upwards [self_mem_nhdsWithin] with s hs
  rw [U_eq_of_ne hs, U_one]
  field_simp [sub_ne_zero.mpr hs]

theorem eventually_U_ne_zero : ∀ᶠ s in 𝓝 (1 : ℂ), U s ≠ 0 :=
  continuousAt_U_one.eventually_ne (by simp)

/-- The original centered expression; its assigned value at `1` is not the analytic filling. -/
noncomputable def G (s : ℂ) : ℂ :=
  -deriv riemannZeta s / riemannZeta s - s / (s - 1)

/-- The analytic extension near `1`, obtained from the normalized analytic unit. -/
noncomputable def Gext (s : ℂ) : ℂ := -deriv U s / U s - 1

theorem analyticAt_Gext_one : AnalyticAt ℂ Gext 1 := by
  exact ((analyticAt_U_one.deriv.neg).div analyticAt_U_one (by simp)).sub analyticAt_const

theorem G_eq_Gext_of_ne {s : ℂ} (hs : s ≠ 1) (hu : U s ≠ 0) : G s = Gext s := by
  have hz : riemannZeta s ≠ 0 := by
    intro hz
    apply hu
    rw [U_eq_of_ne hs, hz, mul_zero]
  unfold G Gext
  rw [(hasDerivAt_U_of_ne hs).deriv, U_eq_of_ne hs]
  field_simp [hz, sub_ne_zero.mpr hs]
  ring

/-- Exact punctured-neighborhood matching retains the full `s/(s-1)` centering term. -/
theorem G_eventuallyEq_Gext : G =ᶠ[𝓝[≠] (1 : ℂ)] Gext := by
  filter_upwards [self_mem_nhdsWithin, eventually_U_ne_zero.filter_mono nhdsWithin_le_nhds]
    with s hs hu
  exact G_eq_Gext_of_ne hs hu

theorem Gext_one : Gext 1 = -(Real.eulerMascheroniConstant : ℂ) - 1 := by
  simp [Gext, hasDerivAt_U_one.deriv]

theorem exists_analytic_extension :
    ∃ F : ℂ → ℂ, AnalyticAt ℂ F 1 ∧ G =ᶠ[𝓝[≠] (1 : ℂ)] F ∧
      F 1 = -(Real.eulerMascheroniConstant : ℂ) - 1 :=
  ⟨Gext, analyticAt_Gext_one, G_eventuallyEq_Gext, Gext_one⟩

/-- Fill only the actual centered expression's value at `1`; all other values stay unchanged. -/
noncomputable def Gfilled : ℂ → ℂ := by
  classical
  exact Function.update G 1 (-(Real.eulerMascheroniConstant : ℂ) - 1)

@[simp] theorem Gfilled_one : Gfilled 1 = -(Real.eulerMascheroniConstant : ℂ) - 1 := by
  simp [Gfilled]

theorem Gfilled_eq_of_ne {s : ℂ} (hs : s ≠ 1) : Gfilled s = G s := by
  simp [Gfilled, hs]

theorem Gfilled_eventuallyEq_Gext : Gfilled =ᶠ[𝓝 (1 : ℂ)] Gext := by
  have h := eventually_nhdsWithin_iff.mp G_eventuallyEq_Gext
  filter_upwards [h] with s hs
  by_cases h1 : s = 1
  · subst s
    rw [Gfilled_one, Gext_one]
  · rw [Gfilled_eq_of_ne h1]
    exact hs h1

theorem analyticAt_Gfilled_one : AnalyticAt ℂ Gfilled 1 :=
  analyticAt_Gext_one.congr Gfilled_eventuallyEq_Gext.symm

end BuildingBlocks.RiemannZetaCenteredLogDeriv
