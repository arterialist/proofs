import BuildingBlocks.IntegerCarryPrimitiveBounds
import Mathlib.Analysis.Calculus.ContDiff.Basic

open MeasureTheory Set

namespace BuildingBlocks.IntegerCarryPhase

/-- Local regularity suffices; the weight need not be smooth outside the interval. -/
theorem phase_integrationByParts_local (r a b : ℝ) (hr : 0 < r) (g g' : ℝ → ℝ)
    (hg : ContinuousOn g (uIcc a b)) (hg' : ContinuousOn g' (uIcc a b))
    (hd : ∀ x ∈ Ioo (min a b) (max a b), HasDerivAt g (g' x) x) :
    (∫ x in a..b, phase r x * g x) =
      primitiveFormula r b * g b - primitiveFormula r a * g a -
        ∫ x in a..b, primitiveFormula r x * g' x := by
  have hi := (phase_intervalIntegrable r a b).mul_continuousOn hg
  have hj := ((primitiveFormula_continuous r).continuousOn.mul hg').intervalIntegrable (μ := volume)
  have hs : (∫ x in a..b, phase r x * g x + primitiveFormula r x * g' x) =
      primitiveFormula r b * g b - primitiveFormula r a * g a := by
    apply intervalIntegral.integral_eq_sub_of_hasDeriv_right
      ((primitiveFormula_continuous r).continuousOn.mul hg)
    · intro x hx
      exact (primitiveFormula_hasDerivWithinAt_right r x hr).mul (hd x hx).hasDerivWithinAt
    · exact hi.add hj
  rw [intervalIntegral.integral_add hi hj] at hs
  linarith

/-- Weighted phase integration with both endpoint terms and every corner retained. -/
theorem phase_integrationByParts (r a b : ℝ) (hr : 0 < r) (g : ℝ → ℝ)
    (hg : ContDiff ℝ 1 g) :
    (∫ x in a..b, phase r x * g x) =
      primitiveFormula r b * g b - primitiveFormula r a * g a -
        ∫ x in a..b, primitiveFormula r x * deriv g x :=
  phase_integrationByParts_local r a b hr g (deriv g) hg.continuous.continuousOn
    hg.continuous_deriv_one.continuousOn (fun x _ => (hg.differentiable_one x).hasDerivAt)

theorem primitiveFormula_one (r : ℝ) : primitiveFormula r 1 = -unitPrimitive r / r := by
  unfold primitiveFormula
  have hz : unitPrimitive 1 = 0 := by norm_num [unitPrimitive, Int.fract]
  rw [hz]
  simp only [mul_zero, mul_one, zero_sub]
  ring

/-- Real dilations carry the nonzero initial trace of the phase extension. -/
theorem phase_real_integrationByParts_from_one (r X : ℝ) (hr : 0 < r)
    (g : ℝ → ℝ) (hg : ContDiff ℝ 1 g) :
    (∫ x in (1 : ℝ)..X, phase r x * g x) =
      primitiveFormula r X * g X + unitPrimitive r * g 1 / r -
        ∫ x in (1 : ℝ)..X, primitiveFormula r x * deriv g x := by
  rw [phase_integrationByParts r 1 X hr g hg, primitiveFormula_one]
  ring

/-- Actual integer dilations have zero initial primitive, not an omitted origin term. -/
theorem phase_nat_integrationByParts_from_one (m : ℕ) (X : ℝ) (hm : 0 < m)
    (g : ℝ → ℝ) (hg : ContDiff ℝ 1 g) :
    (∫ x in (1 : ℝ)..X, phase (m : ℝ) x * g x) =
      primitiveFormula (m : ℝ) X * g X -
        ∫ x in (1 : ℝ)..X, primitiveFormula (m : ℝ) x * deriv g x := by
  rw [phase_integrationByParts (m : ℝ) 1 X (by exact_mod_cast hm) g hg]
  have hz : primitiveFormula (m : ℝ) 1 = 0 := by
    simpa only [Nat.cast_one] using primitiveFormula_nat_integer m 1
  rw [hz]
  ring

#print axioms phase_integrationByParts_local
#print axioms phase_integrationByParts
#print axioms primitiveFormula_one
#print axioms phase_real_integrationByParts_from_one
#print axioms phase_nat_integrationByParts_from_one

end BuildingBlocks.IntegerCarryPhase
