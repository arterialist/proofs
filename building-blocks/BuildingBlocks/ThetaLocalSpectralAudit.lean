import Mathlib.Tactic

namespace PaidThetaCompensation

/-! Focused direction checks for the monotone observation and local spectral
mass arguments.  Operator/form-domain inputs remain explicit hypotheses. -/

theorem finite_observation_direction
    {base finiteObs fullObs : ℝ}
    (hfinite : 0 ≤ base + finiteObs)
    (horder : finiteObs ≤ fullObs) :
    0 ≤ base + fullObs := by
  linarith

/-- The reverse implication is false already for a one-dimensional
quadratic form: the full correction pays the negative base and the finite
correction does not. -/
theorem reverse_finite_observation_direction_fails :
    0 ≤ (-1 : ℝ) + 1 ∧ ¬ 0 ≤ (-1 : ℝ) + 0 := by
  norm_num

/-- Pointwise algebra behind the transformed source `S=f/rho` and the clock
density `rho*psi`. -/
theorem ground_source_pairing_pointwise
    {f rho psi : ℝ} (hrho : rho ≠ 0) :
    (f / rho) * (rho * psi) = f * psi := by
  field_simp

/-- Finite spectral version of the local-measure estimate.  `mass i` is a
spectral mass and `gap i` its positive denominator. -/
theorem finite_local_spectral_mass_bound
    {ι : Type*} (s : Finset ι) (mass gap : ι → ℝ)
    {gapMax covarianceBound : ℝ}
    (hmass : ∀ i ∈ s, 0 ≤ mass i)
    (hgap : ∀ i ∈ s, 0 < gap i)
    (hmax0 : 0 ≤ gapMax)
    (hgapMax : ∀ i ∈ s, gap i ≤ gapMax)
    (hcov : ∑ i ∈ s, mass i / gap i ≤ covarianceBound) :
    ∑ i ∈ s, mass i ≤ gapMax * covarianceBound := by
  calc
    ∑ i ∈ s, mass i ≤ ∑ i ∈ s, gapMax * (mass i / gap i) := by
      apply Finset.sum_le_sum
      intro i hi
      have hdiv : 0 ≤ mass i / gap i := div_nonneg (hmass i hi) (le_of_lt (hgap i hi))
      calc
        mass i = gap i * (mass i / gap i) := by
          field_simp [ne_of_gt (hgap i hi)]
        _ ≤ gapMax * (mass i / gap i) :=
          mul_le_mul_of_nonneg_right (hgapMax i hi) hdiv
    _ = gapMax * (∑ i ∈ s, mass i / gap i) := by
      rw [Finset.mul_sum]
    _ ≤ gapMax * covarianceBound := mul_le_mul_of_nonneg_left hcov hmax0

end PaidThetaCompensation
