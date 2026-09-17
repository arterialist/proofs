import BuildingBlocks.LogDerivative

open Filter Set
open scoped Topology

namespace BuildingBlocks

/-- Sloped half-planes provide convex domains avoiding the pole. -/
def tiltedDomain (t : ℝ) : Set ℂ :=
  {s | (1 : ℝ) / 2 < s.re ∧ s.re - t * s.im < 1}

theorem tiltedDomain_convex (t : ℝ) : Convex ℝ (tiltedDomain t) := by
  apply (convex_halfSpace_gt (IsLinearMap.mk Complex.add_re Complex.smul_re)
    ((1 : ℝ) / 2)).inter
  apply convex_halfSpace_lt (𝕜 := ℝ) (f := fun s : ℂ => s.re - t * s.im) (r := 1)
  exact IsLinearMap.mk
    (by intro x y; simp only [Complex.add_re, Complex.add_im]; ring)
    (by intro r x; simp only [Complex.smul_re, Complex.smul_im, smul_eq_mul]; ring)

theorem tiltedDomain_subset (t : ℝ) : tiltedDomain t ⊆ rightDomain := by
  intro s hs
  refine ⟨hs.1, ?_⟩
  intro heq
  subst s
  simpa [tiltedDomain] using hs.2

theorem eq_zero_on_tiltedDomain {F : ℂ → ℂ}
    (hF : AnalyticOnNhd ℂ F rightDomain)
    (hzero : ∀ s : ℂ, 1 < s.re → F s = 0)
    {t : ℝ} {w : ℂ} (hw : w ∈ tiltedDomain t) (hwre : 1 < w.re) :
    EqOn F 0 (tiltedDomain t) := by
  apply (show AnalyticOnNhd ℂ F (tiltedDomain t) from
    fun s hs => hF s (tiltedDomain_subset t hs)).eqOn_zero_of_preconnected_of_eventuallyEq_zero
      (tiltedDomain_convex t).isPreconnected hw
  filter_upwards [(isOpen_lt continuous_const Complex.continuous_re).mem_nhds hwre] with s hs
  exact hzero s hs

/-- Identity continuation covers the entire right half-plane except the pole,
including its real interval between one half and one. -/
theorem identity_on_rightDomain {F : ℂ → ℂ}
    (hF : AnalyticOnNhd ℂ F rightDomain)
    (hzero : ∀ s : ℂ, 1 < s.re → F s = 0) :
    ∀ s ∈ rightDomain, F s = 0 := by
  intro s hs
  by_cases hsr : 1 < s.re
  · exact hzero s hsr
  have hu := eq_zero_on_tiltedDomain hF hzero
    (t := 1) (w := 2 + 2 * Complex.I)
    (by norm_num [tiltedDomain, Complex.mul_re, Complex.mul_im])
    (by norm_num [Complex.mul_re])
  have hl := eq_zero_on_tiltedDomain hF hzero
    (t := -1) (w := 2 - 2 * Complex.I)
    (by norm_num [tiltedDomain, Complex.mul_re, Complex.mul_im])
    (by norm_num [Complex.mul_re])
  by_cases huS : s ∈ tiltedDomain 1
  · exact hu huS
  apply hl
  refine ⟨hs.1, ?_⟩
  have h1 : 1 ≤ s.re - s.im := by
    apply le_of_not_gt
    intro hh
    exact huS ⟨hs.1, by simpa using hh⟩
  by_contra hh
  have h2 : 1 ≤ s.re + s.im := by simpa using le_of_not_gt hh
  have hr : s.re = 1 := by linarith
  have hi : s.im = 0 := by linarith
  exact hs.2 (Complex.ext (by simpa using hr) (by simpa using hi))

/-- Existence is not asserted unconditionally. `PrimeIntegral.lean` constructs
this extension from `PrimeFluctuationBound`. The identity is required only in
the established absolute-convergence region; analyticity is required on the
larger half-plane. The pole's principal part has been subtracted explicitly. -/
def HolomorphicPrimeExtension : Prop :=
  ∃ G : ℂ → ℂ, AnalyticOnNhd ℂ G {s | (1 : ℝ) / 2 < s.re} ∧
    ∀ s : ℂ, 1 < s.re →
      G s = -deriv riemannZeta s / riemannZeta s - s / (s - 1)

theorem target_of_holomorphicPrimeExtension (h : HolomorphicPrimeExtension) : Target := by
  obtain ⟨G, hG, hGeq⟩ := h
  have hcoef : AnalyticOnNhd ℂ (fun s => s / (s - 1) + G s) rightDomain := by
    intro s hs
    exact (analyticAt_id.div (analyticAt_id.sub analyticAt_const)
      (sub_ne_zero.mpr hs.2)).add (hG s hs.1)
  have hres : AnalyticOnNhd ℂ
      (fun s => deriv riemannZeta s + (s / (s - 1) + G s) * riemannZeta s)
      rightDomain := by
    intro s hs
    exact (zeta_analytic_off_pole s hs.2).deriv.add
      ((hcoef s hs).mul (zeta_analytic_off_pole s hs.2))
  have hzero : ∀ s : ℂ, 1 < s.re →
      deriv riemannZeta s + (s / (s - 1) + G s) * riemannZeta s = 0 := by
    intro s hs
    have hz := riemannZeta_ne_zero_of_one_lt_re hs
    rw [hGeq s hs]
    field_simp
    ring
  have hext := identity_on_rightDomain hres hzero
  apply target_of_holomorphicZetaODE
  refine ⟨fun s => -(s / (s - 1) + G s), ?_, ?_⟩
  · intro s hs
    exact (hcoef s hs).neg
  · intro s hs
    have hh := hext s hs
    linear_combination hh

/-- The extension step for the analytic bridge, proved by
`primeExtension_of_bound` in `PrimeIntegral.lean`. Kept as a named proposition
so that the dependency can be inspected; it is never postulated as an axiom. -/
def PrimeExtensionObligation : Prop :=
  PrimeFluctuationBound → HolomorphicPrimeExtension

theorem analyticBridge_of_primeExtension (h : PrimeExtensionObligation) :
    AnalyticBridgeObligation :=
  fun hb => target_of_holomorphicPrimeExtension (h hb)

end BuildingBlocks
