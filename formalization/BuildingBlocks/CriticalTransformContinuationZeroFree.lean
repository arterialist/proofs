import BuildingBlocks.CriticalTransformContinuationRH
import Mathlib.NumberTheory.Harmonic.ZetaAsymp

/-!
# Zero-free regions from a holomorphic continuation of the transform

`CriticalTransformContinuationRH.RiemannHypothesis_of_holomorphic_continuation` says that a
function analytic on `Re s > 1/2` which agrees with the filled transform `M (G² - H)` on
`Re s > 1` excludes every zero of `ζ` with real part `> 1/2`. This module proves the same
statement at an arbitrary level `θ ≥ 1/2`: a continuation to `Re s > θ` excludes every zero
with `Re ρ > θ`.

The identity-theorem step of the original proof used two tilted half-planes to connect
`{Re s > 1/2} \ {1}`. Here the domain `{Re s > θ} \ {1}` is handled with the two convex
quarter-planes `{Re s > θ, Im s > 0}` and `{Re s > θ, Im s < 0}`; this suffices because a
zero with `Re ρ > θ ≥ 1/2` is never real (`riemannZeta_ne_zero_real`, `riemannZeta_one_ne_zero`).
-/

open Filter Set
open scoped Topology

namespace BuildingBlocks.CriticalTransformContinuationZeroFree

open CriticalTransformContinuationRH

/-- The half-plane `Re s > θ` without the point `1`. -/
def upperDomain (θ : ℝ) : Set ℂ := {s : ℂ | θ < s.re ∧ s ≠ 1}

theorem cleared_analytic_of_le {θ : ℝ} (hθ : (1 : ℝ) / 2 ≤ θ) {J : ℂ → ℂ}
    (hJ : AnalyticOnNhd ℂ J {s : ℂ | θ < s.re}) :
    AnalyticOnNhd ℂ (cleared J) (upperDomain θ) := by
  intro s hs
  have hhalf : (1 : ℝ) / 2 < s.re := hθ.trans_lt hs.1
  have hz := zeta_analytic_off_pole s hs.2
  have hM := ShiftedZetaMultiplier.analyticAt_M hhalf
  have hH := SamePrimeDirichlet.H_analyticAt hhalf
  have hr : AnalyticAt ℂ (fun w : ℂ => w / (w - 1)) s :=
    analyticAt_id.div (analyticAt_id.sub analyticAt_const) (sub_ne_zero.mpr hs.2)
  exact (hz.pow 2).mul ((hJ s hs.1).add (hM.mul hH)) |>.sub
    (hM.mul ((hz.deriv.neg.sub (hr.mul hz)).pow 2))

/-- On any convex subset of `{Re s > θ} \ {1}` that reaches into `Re s > 1`, the cleared
difference vanishes identically. -/
theorem cleared_eqOn_zero {θ : ℝ} (hθ : (1 : ℝ) / 2 ≤ θ) {J : ℂ → ℂ}
    (hJ : AnalyticOnNhd ℂ J {s : ℂ | θ < s.re})
    (heq : ∀ s : ℂ, 1 < s.re → J s = CriticalTransformPoles.filledTransform s)
    {U : Set ℂ} (hUc : Convex ℝ U) (hU : U ⊆ upperDomain θ)
    {z₀ : ℂ} (hz₀ : z₀ ∈ U) (hz₀re : 1 < z₀.re) :
    ∀ s ∈ U, cleared J s = 0 := by
  have hA : AnalyticOnNhd ℂ (cleared J) U := (cleared_analytic_of_le hθ hJ).mono hU
  have hnhds : ∀ᶠ s in 𝓝 z₀, 1 < s.re :=
    (isOpen_lt continuous_const Complex.continuous_re).mem_nhds hz₀re
  have hev : cleared J =ᶠ[𝓝 z₀] 0 := by
    filter_upwards [hnhds] with s hs
    have hs1 : s ≠ 1 := by
      intro h
      rw [h] at hs
      norm_num at hs
    show cleared J s = 0
    rw [cleared_eq hs1 (riemannZeta_ne_zero_of_one_lt_re hs), heq s hs, sub_self, mul_zero]
  have hE : EqOn (cleared J) 0 U :=
    hA.eqOn_zero_of_preconnected_of_eventuallyEq_zero hUc.isPreconnected hz₀ hev
  intro s hs
  exact hE hs

theorem upperQuarter_subset (θ : ℝ) :
    ({s : ℂ | θ < s.re} ∩ {s : ℂ | 0 < s.im}) ⊆ upperDomain θ := by
  rintro s ⟨h1, h2⟩
  refine ⟨h1, ?_⟩
  rintro rfl
  simp at h2

theorem lowerQuarter_subset (θ : ℝ) :
    ({s : ℂ | θ < s.re} ∩ {s : ℂ | s.im < 0}) ⊆ upperDomain θ := by
  rintro s ⟨h1, h2⟩
  refine ⟨h1, ?_⟩
  rintro rfl
  simp at h2

/-- Near a non-real point of `Re s > θ`, the continuation agrees with the transform on a
punctured neighbourhood. -/
theorem continuation_eventuallyEq_filledTransform_of_le {θ : ℝ} (hθ : (1 : ℝ) / 2 ≤ θ)
    {J : ℂ → ℂ} (hJ : AnalyticOnNhd ℂ J {s : ℂ | θ < s.re})
    (heq : ∀ s : ℂ, 1 < s.re → J s = CriticalTransformPoles.filledTransform s)
    {ρ : ℂ} (hρre : θ < ρ.re) (hρim : ρ.im ≠ 0) :
    J =ᶠ[𝓝[≠] ρ] CriticalTransformPoles.filledTransform := by
  obtain ⟨U, hUc, hUo, hU, hρU, z₀, hz₀, hz₀re⟩ : ∃ U : Set ℂ, Convex ℝ U ∧ IsOpen U ∧
      U ⊆ upperDomain θ ∧ ρ ∈ U ∧ ∃ z₀ ∈ U, 1 < z₀.re := by
    rcases lt_or_gt_of_ne hρim with hneg | hpos
    · refine ⟨{s : ℂ | θ < s.re} ∩ {s : ℂ | s.im < 0},
        (convex_halfSpace_re_gt θ).inter (convex_halfSpace_im_lt 0),
        (isOpen_lt continuous_const Complex.continuous_re).inter
          (isOpen_lt Complex.continuous_im continuous_const),
        lowerQuarter_subset θ, ⟨hρre, hneg⟩, ((θ + 2 : ℝ) : ℂ) - Complex.I, ⟨?_, ?_⟩, ?_⟩
      · show θ < (((θ + 2 : ℝ) : ℂ) - Complex.I).re
        rw [Complex.sub_re, Complex.ofReal_re, Complex.I_re]
        linarith
      · show (((θ + 2 : ℝ) : ℂ) - Complex.I).im < 0
        rw [Complex.sub_im, Complex.ofReal_im, Complex.I_im]
        norm_num
      · show 1 < (((θ + 2 : ℝ) : ℂ) - Complex.I).re
        rw [Complex.sub_re, Complex.ofReal_re, Complex.I_re]
        linarith
    · refine ⟨{s : ℂ | θ < s.re} ∩ {s : ℂ | 0 < s.im},
        (convex_halfSpace_re_gt θ).inter (convex_halfSpace_im_gt 0),
        (isOpen_lt continuous_const Complex.continuous_re).inter
          (isOpen_lt continuous_const Complex.continuous_im),
        upperQuarter_subset θ, ⟨hρre, hpos⟩, ((θ + 2 : ℝ) : ℂ) + Complex.I, ⟨?_, ?_⟩, ?_⟩
      · show θ < (((θ + 2 : ℝ) : ℂ) + Complex.I).re
        rw [Complex.add_re, Complex.ofReal_re, Complex.I_re]
        linarith
      · show 0 < (((θ + 2 : ℝ) : ℂ) + Complex.I).im
        rw [Complex.add_im, Complex.ofReal_im, Complex.I_im]
        norm_num
      · show 1 < (((θ + 2 : ℝ) : ℂ) + Complex.I).re
        rw [Complex.add_re, Complex.ofReal_re, Complex.I_re]
        linarith
  have hρ1 : ρ ≠ 1 := fun h => hρim (by rw [h]; simp)
  have hne := (zeta_analytic_off_pole ρ hρ1).eventually_eq_zero_or_eventually_ne_zero
    |>.resolve_left (zeta_not_locally_zero hρ1)
  have hdom0 : ∀ᶠ s in 𝓝 ρ, s ∈ U := hUo.mem_nhds hρU
  have hdom : ∀ᶠ s in 𝓝[≠] ρ, s ∈ U := hdom0.filter_mono nhdsWithin_le_nhds
  have hzero := cleared_eqOn_zero hθ hJ heq hUc hU hz₀ hz₀re
  filter_upwards [hne, hdom] with s hzs hs
  have hp := hzero s hs
  rw [cleared_eq (hU hs).2 hzs] at hp
  exact sub_eq_zero.mp ((mul_eq_zero.mp hp).resolve_left (pow_ne_zero 2 hzs))

/-- **Zero-free criterion at level `θ`.** A function analytic on `Re s > θ` (with
`θ ≥ 1/2`) that agrees with the filled transform on `Re s > 1` excludes every zero of `ζ`
with `Re ρ > θ`. -/
theorem zeroFree_of_holomorphic_continuation {θ : ℝ} (hθ : (1 : ℝ) / 2 ≤ θ) {J : ℂ → ℂ}
    (hJ : AnalyticOnNhd ℂ J {s : ℂ | θ < s.re})
    (heq : ∀ s : ℂ, 1 < s.re → J s = CriticalTransformPoles.filledTransform s) :
    ∀ ρ : ℂ, θ < ρ.re → riemannZeta ρ ≠ 0 := by
  intro ρ hρre hz
  by_cases hρim : ρ.im = 0
  · have hρ : ρ = (ρ.re : ℂ) := Complex.ext (by simp) (by simp [hρim])
    by_cases h1 : ρ = 1
    · exact riemannZeta_one_ne_zero (h1 ▸ hz)
    · have hσ1 : ρ.re ≠ 1 := by
        intro h
        apply h1
        rw [hρ, h]
        simp
      have hz' : riemannZeta (ρ.re : ℂ) = 0 := by
        rw [← hρ]
        exact hz
      exact CriticalTransformRealAxis.riemannZeta_ne_zero_real (σ := ρ.re)
        (by linarith [hθ.trans_lt hρre]) hσ1 hz'
  · have hρ1 : ρ ≠ 1 := fun h => hρim (by rw [h]; simp)
    have he := continuation_eventuallyEq_filledTransform_of_le hθ hJ heq hρre hρim
    obtain ⟨m, -, -, hpole, -, -⟩ :=
      CriticalTransformPoles.filled_pole_at_zeta_zero (hθ.trans_lt hρre) hρ1 hz
    have hnonneg := (hJ ρ hρre).meromorphicOrderAt_nonneg
    rw [meromorphicOrderAt_congr he, hpole] at hnonneg
    have himpossible : (0 : ℤ) ≤ -2 := by exact_mod_cast hnonneg
    omega

/-- The level `θ = 1/2` recovers the Riemann hypothesis. -/
theorem RiemannHypothesis_of_holomorphic_continuation' {J : ℂ → ℂ}
    (hJ : AnalyticOnNhd ℂ J {s : ℂ | (1 : ℝ) / 2 < s.re})
    (heq : ∀ s : ℂ, 1 < s.re → J s = CriticalTransformPoles.filledTransform s) :
    RiemannHypothesis :=
  CriticalTransformRH.noRightZeros_implies_RiemannHypothesis
    (fun s hs _ => zeroFree_of_holomorphic_continuation le_rfl hJ heq s hs)

end BuildingBlocks.CriticalTransformContinuationZeroFree
