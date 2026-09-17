import BuildingBlocks.Continuation
import BuildingBlocks.CriticalTransformRH

open Filter Set
open scoped Topology

namespace BuildingBlocks.CriticalTransformContinuationRH

/-- Clearing ζ² removes the logarithmic-derivative poles without discarding
zeros of any multiplicity. The point one is excluded from this intermediate domain. -/
noncomputable def cleared (J : ℂ → ℂ) (s : ℂ) : ℂ :=
  riemannZeta s ^ 2 * (J s + ShiftedZetaMultiplier.M s * SamePrimeDirichlet.H s) -
    ShiftedZetaMultiplier.M s *
      (-deriv riemannZeta s - s/(s-1)*riemannZeta s)^2

theorem cleared_eq {J : ℂ → ℂ} {s : ℂ} (hs : s ≠ 1)
    (hz : riemannZeta s ≠ 0) :
    cleared J s = riemannZeta s^2 * (J s - CriticalTransformPoles.filledTransform s) := by
  rw [CriticalTransformPoles.filledTransform_eq_of_ne hs]
  simp only [cleared, CriticalTransformPoles.transform,
    LogDerivativePole.centeredZetaLogDerivative, logDeriv_apply]
  have hs0 : s-1 ≠ 0 := sub_ne_zero.mpr hs
  field_simp
  ring

theorem cleared_analytic {J : ℂ → ℂ}
    (hJ : AnalyticOnNhd ℂ J {s : ℂ | (1 : ℝ)/2 < s.re}) :
    AnalyticOnNhd ℂ (cleared J) rightDomain := by
  intro s hs
  have hz := zeta_analytic_off_pole s hs.2
  have hM := ShiftedZetaMultiplier.analyticAt_M hs.1
  have hH := SamePrimeDirichlet.H_analyticAt hs.1
  have hr : AnalyticAt ℂ (fun w : ℂ => w/(w-1)) s :=
    analyticAt_id.div (analyticAt_id.sub analyticAt_const) (sub_ne_zero.mpr hs.2)
  exact (hz.pow 2).mul ((hJ s hs.1).add (hM.mul hH)) |>.sub
    (hM.mul ((hz.deriv.neg.sub (hr.mul hz)).pow 2))

theorem cleared_zero_on_rightDomain {J : ℂ → ℂ}
    (hJ : AnalyticOnNhd ℂ J {s : ℂ | (1 : ℝ)/2 < s.re})
    (heq : ∀ s : ℂ, 1 < s.re → J s = CriticalTransformPoles.filledTransform s) :
    ∀ s ∈ rightDomain, cleared J s = 0 := by
  apply identity_on_rightDomain (cleared_analytic hJ)
  intro s hs
  have hs1 : s ≠ 1 := by intro he; subst s; norm_num at hs
  rw [cleared_eq hs1 (riemannZeta_ne_zero_of_one_lt_re hs), heq s hs,
    sub_self, mul_zero]

/-- Isolated-zero nonvanishing permits division on a punctured neighborhood,
not evaluation at the zero. Thus multiple zeros retain their full pole obstruction. -/
theorem continuation_eventuallyEq_filledTransform {J : ℂ → ℂ}
    (hJ : AnalyticOnNhd ℂ J {s : ℂ | (1 : ℝ)/2 < s.re})
    (heq : ∀ s : ℂ, 1 < s.re → J s = CriticalTransformPoles.filledTransform s)
    {ρ : ℂ} (hρre : (1 : ℝ)/2 < ρ.re) (hρ : ρ ≠ 1) :
    J =ᶠ[𝓝[≠] ρ] CriticalTransformPoles.filledTransform := by
  have hne := (zeta_analytic_off_pole ρ hρ).eventually_eq_zero_or_eventually_ne_zero
    |>.resolve_left (zeta_not_locally_zero hρ)
  have hdom0 : ∀ᶠ s in 𝓝 ρ, s ∈ rightDomain :=
    rightDomain_isOpen.mem_nhds ⟨hρre, hρ⟩
  have hdom : ∀ᶠ s in 𝓝[≠] ρ, s ∈ rightDomain :=
    hdom0.filter_mono nhdsWithin_le_nhds
  have hzero := cleared_zero_on_rightDomain hJ heq
  filter_upwards [hne, hdom] with s hzs hs
  have hp := hzero s hs
  rw [cleared_eq hs.2 hzs] at hp
  exact sub_eq_zero.mp ((mul_eq_zero.mp hp).resolve_left (pow_ne_zero 2 hzs))

/-- A holomorphic continuation agreeing only on the established half-plane
already excludes all right-half-plane zeros. No global analyticity of the
totalized filledTransform is assumed. -/
theorem RiemannHypothesis_of_holomorphic_continuation {J : ℂ → ℂ}
    (hJ : AnalyticOnNhd ℂ J {s : ℂ | (1 : ℝ)/2 < s.re})
    (heq : ∀ s : ℂ, 1 < s.re → J s = CriticalTransformPoles.filledTransform s) :
    RiemannHypothesis := by
  apply CriticalTransformRH.noRightZeros_implies_RiemannHypothesis
  intro ρ hρre hρ hz
  have he := continuation_eventuallyEq_filledTransform hJ heq hρre hρ
  obtain ⟨m, hm, horder, hpole, hcoeff, hcoeff_ne⟩ :=
    CriticalTransformPoles.filled_pole_at_zeta_zero hρre hρ hz
  have hnonneg := (hJ ρ hρre).meromorphicOrderAt_nonneg
  rw [meromorphicOrderAt_congr he, hpole] at hnonneg
  have himpossible : (0 : ℤ) ≤ -2 := by exact_mod_cast hnonneg
  omega

end BuildingBlocks.CriticalTransformContinuationRH
