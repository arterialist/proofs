import BuildingBlocks.Scope
import BuildingBlocks.CriticalTransformPoles
import BuildingBlocks.CriticalTransformRealAxis
import BuildingBlocks.LogDerivative

namespace BuildingBlocks.CriticalTransformRH

/-- Reuse the existing full-scope reflection theorem. The mathematical pole at
one is explicitly excluded; no multiplicity or zero-height restriction is made. -/
theorem noRightZeros_implies_RiemannHypothesis
    (h : ∀ s : ℂ, (1 : ℝ)/2 < s.re → s ≠ 1 → riemannZeta s ≠ 0) :
    RiemannHypothesis :=
  target_iff_rightHalfZeroFree.mpr h

/-- An actual zero of any finite multiplicity would force order -2, which is
incompatible with analyticity of the filled transform at that point. -/
theorem noRightZeros_of_analyticOnNhd_filledTransform
    (h : AnalyticOnNhd ℂ CriticalTransformPoles.filledTransform
      {s : ℂ | (1 : ℝ)/2 < s.re}) :
    ∀ s : ℂ, (1 : ℝ)/2 < s.re → s ≠ 1 → riemannZeta s ≠ 0 := by
  intro s hsr hs hz
  obtain ⟨m, hm, horder, hpole, hcoeff, hcoeff_ne⟩ :=
    CriticalTransformPoles.filled_pole_at_zeta_zero hsr hs hz
  have hnonneg := (h s hsr).meromorphicOrderAt_nonneg
  rw [hpole] at hnonneg
  have himpossible : (0 : ℤ) ≤ -2 := by exact_mod_cast hnonneg
  omega

/-- Analyticity of filledTransform on the right half-plane from absence of right zeros. -/
theorem analyticOnNhd_filledTransform_of_noRightZeros
    (h : ∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → riemannZeta s ≠ 0) :
    AnalyticOnNhd ℂ CriticalTransformPoles.filledTransform
      {s : ℂ | (1 : ℝ) / 2 < s.re} := by
  intro s hs
  by_cases hs1 : s = 1
  · subst hs1
    simpa using CriticalTransformPoles.analyticAt_filledTransform_one
  · exact CriticalTransformRealAxis.analyticAt_filledTransform_of_ne_zero hs hs1 (h s hs hs1)

/-- Unconditional bidirectional equivalence between analyticity of the filled transform
on the right half-plane and absence of non-trivial zeros in that half-plane. -/
theorem analyticOnNhd_filledTransform_iff_rightHalfZeroFree :
    AnalyticOnNhd ℂ CriticalTransformPoles.filledTransform {s : ℂ | (1 : ℝ) / 2 < s.re} ↔
    (∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → riemannZeta s ≠ 0) :=
  ⟨noRightZeros_of_analyticOnNhd_filledTransform, analyticOnNhd_filledTransform_of_noRightZeros⟩

/-- Conditional sufficiency for the full mathlib Riemann hypothesis.
Analyticity on the entire right half-plane is an explicit premise, not a
consequence asserted here of an arithmetic sign or continued integral. -/
theorem RiemannHypothesis_of_analyticOnNhd_filledTransform
    (h : AnalyticOnNhd ℂ CriticalTransformPoles.filledTransform
      {s : ℂ | (1 : ℝ)/2 < s.re}) :
    RiemannHypothesis :=
  noRightZeros_implies_RiemannHypothesis
    (noRightZeros_of_analyticOnNhd_filledTransform h)

/-- Analyticity of filledTransform on {s | 1/2 < s.re} is implied by RiemannHypothesis. -/
theorem analyticOnNhd_filledTransform_of_RiemannHypothesis
    (h : RiemannHypothesis) :
    AnalyticOnNhd ℂ CriticalTransformPoles.filledTransform {s : ℂ | (1 : ℝ) / 2 < s.re} :=
  analyticOnNhd_filledTransform_of_noRightZeros (target_iff_rightHalfZeroFree.mp h)

/-- Unconditional bidirectional equivalence between analyticity of filledTransform
on {s | 1/2 < s.re} and the full Riemann Hypothesis. -/
theorem analyticOnNhd_filledTransform_iff_RiemannHypothesis :
    AnalyticOnNhd ℂ CriticalTransformPoles.filledTransform {s : ℂ | (1 : ℝ) / 2 < s.re} ↔
    RiemannHypothesis :=
  ⟨RiemannHypothesis_of_analyticOnNhd_filledTransform, analyticOnNhd_filledTransform_of_RiemannHypothesis⟩

/-- Unconditional bidirectional equivalence between analyticity of filledTransform
and the holomorphic zeta ODE system. -/
theorem analyticOnNhd_filledTransform_iff_holomorphicZetaODE :
    AnalyticOnNhd ℂ CriticalTransformPoles.filledTransform {s : ℂ | (1 : ℝ) / 2 < s.re} ↔
    HolomorphicZetaODE := by
  rw [analyticOnNhd_filledTransform_iff_RiemannHypothesis]
  exact target_iff_holomorphicZetaODE

#print axioms noRightZeros_implies_RiemannHypothesis
#print axioms noRightZeros_of_analyticOnNhd_filledTransform
#print axioms analyticOnNhd_filledTransform_of_noRightZeros
#print axioms analyticOnNhd_filledTransform_iff_rightHalfZeroFree
#print axioms RiemannHypothesis_of_analyticOnNhd_filledTransform
#print axioms analyticOnNhd_filledTransform_of_RiemannHypothesis
#print axioms analyticOnNhd_filledTransform_iff_RiemannHypothesis
#print axioms analyticOnNhd_filledTransform_iff_holomorphicZetaODE

end BuildingBlocks.CriticalTransformRH
