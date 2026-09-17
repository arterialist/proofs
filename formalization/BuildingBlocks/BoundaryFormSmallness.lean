import Mathlib.Tactic

namespace PaidThetaCompensation

/-!
Finite scalar and two-block algebra for boundary form-smallness. The analytic
consumer supplies the Carleman/prime port ceiling and the logarithmic tail
confinement.
-/

/-- A bounded port becomes small relative to a tail supply whose coercivity
constant grows with the logarithmic cutoff. -/
theorem tail_port_relative_bound
    {port supply normSq P c S : ℝ}
    (hP : 0 ≤ P) (hc : 0 < c) (hS : 0 < S)
    (hport : port ≤ P * normSq)
    (hsupply : c * S * normSq ≤ supply) :
    port ≤ (P / (c * S)) * supply := by
  have hcs : 0 < c * S := mul_pos hc hS
  have hratio : P * normSq ≤ (P / (c * S)) * supply := by
    calc
      P * normSq = (P / (c * S)) * (c * S * normSq) := by field_simp
      _ ≤ (P / (c * S)) * supply :=
        mul_le_mul_of_nonneg_left hsupply (div_nonneg hP hcs.le)
  linarith

/-- An explicit logarithmic cutoff pays any prescribed relative coefficient. -/
theorem cutoff_for_relative_bound
    {P c eta S : ℝ}
    (hP : 0 ≤ P) (hc : 0 < c) (heta : 0 < eta)
    (hS : P / (c * eta) ≤ S) :
    P / (c * S) ≤ eta := by
  by_cases hP0 : P = 0
  · simp [hP0, heta.le]
  · have hPpos : 0 < P := lt_of_le_of_ne hP (Ne.symm hP0)
    have hSpos : 0 < S := lt_of_lt_of_le (div_pos hPpos (mul_pos hc heta)) hS
    apply (div_le_iff₀ (mul_pos hc hSpos)).2
    have := mul_le_mul_of_nonneg_left hS heta.le
    field_simp [hc.ne', heta.ne'] at this ⊢
    nlinarith

/-- Cauchy control of the off-diagonal block gives the standard two-block
upper estimate with an adjustable Young parameter. -/
theorem two_block_port_upper
    {core tail mixed total eps : ℝ}
    (hmixed : 2 * mixed ≤ eps * core + (1 / eps) * tail)
    (htotal : total = core + tail + 2 * mixed) :
    total ≤ (1 + eps) * core + (1 + 1 / eps) * tail := by
  rw [htotal]
  linarith

/-- Restricting a valid form-smallness estimate to a finite joint kernel does
not change its constants. -/
theorem restrict_form_smallness
    {V : Type*} (port supply normSq : V → ℝ) (K : V → Prop)
    (eta C : ℝ)
    (h : ∀ x, port x ≤ eta * supply x + C * normSq x) :
    ∀ x, K x → port x ≤ eta * supply x + C * normSq x := by
  intro x _
  exact h x

end PaidThetaCompensation

#print axioms PaidThetaCompensation.tail_port_relative_bound
#print axioms PaidThetaCompensation.cutoff_for_relative_bound
#print axioms PaidThetaCompensation.two_block_port_upper
#print axioms PaidThetaCompensation.restrict_form_smallness
