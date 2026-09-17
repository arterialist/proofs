import BuildingBlocks.Scope
import BuildingBlocks.CriticalTransformPoles

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

/-- Conditional sufficiency for the full mathlib Riemann hypothesis.
Analyticity on the entire right half-plane is an explicit premise, not a
consequence asserted here of an arithmetic sign or continued integral. -/
theorem RiemannHypothesis_of_analyticOnNhd_filledTransform
    (h : AnalyticOnNhd ℂ CriticalTransformPoles.filledTransform
      {s : ℂ | (1 : ℝ)/2 < s.re}) :
    RiemannHypothesis :=
  noRightZeros_implies_RiemannHypothesis
    (noRightZeros_of_analyticOnNhd_filledTransform h)

end BuildingBlocks.CriticalTransformRH
