import Mathlib.Tactic

namespace PaidThetaCompensation

/-! Finite order algebra used by the moving-radius weighted covariance
audit. Ground tails, theta envelopes, and source-carrier estimates remain
explicit analytic inputs. -/

/-- A nonnegative residual gap can only improve a positive denominator. -/
theorem weighted_ratio_le_of_source_bound
    {a eta J bound : ℝ}
    (ha : 0 < a) (heta : 0 ≤ eta)
    (hbound : J ≤ bound * a) (hbound0 : 0 ≤ bound) :
    J / (a + eta) ≤ bound := by
  have hden : 0 < a + eta := by linarith
  apply (div_le_iff₀ hden).2
  calc
    J ≤ bound * a := hbound
    _ ≤ bound * (a + eta) := by
      exact mul_le_mul_of_nonneg_left (by linarith) hbound0

/-- A certified lower proxy for the clock mass may replace the unknown
clock mass in the source estimate. -/
theorem weighted_ratio_le_of_lower_clock
    {aLower a eta J bound : ℝ}
    (haLower : 0 < aLower) (ha : aLower ≤ a)
    (heta : 0 ≤ eta)
    (hbound : J ≤ bound * aLower) (hbound0 : 0 ≤ bound) :
    J / (a + eta) ≤ bound := by
  apply weighted_ratio_le_of_source_bound (lt_of_lt_of_le haLower ha) heta
  · exact hbound.trans (mul_le_mul_of_nonneg_left ha hbound0)
  · exact hbound0

/-- Finite positive collar bounds may be summed before the denominator is
applied. -/
theorem finite_collar_sum_bound
    {ι : Type*} (s : Finset ι) (J bound : ι → ℝ)
    (h : ∀ i ∈ s, J i ≤ bound i) :
    ∑ i ∈ s, J i ≤ ∑ i ∈ s, bound i := by
  exact Finset.sum_le_sum h

/-- Abstract coefficient matching: if every path amplitude is at most
amp, reproducing a coefficient of the displayed size requires this carrier
mass. -/
theorem carrier_mass_lower_bound
    {coefficient mass amp : ℝ}
    (hamp : 0 < amp) (hmatch : coefficient ≤ mass * amp) :
    coefficient / amp ≤ mass := by
  exact (div_le_iff₀ hamp).2 hmatch

end PaidThetaCompensation
