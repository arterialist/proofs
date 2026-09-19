import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic

open Real

/-!
# Exponent algebra for a modeled dual Dirichlet bound

This module proves algebraic facts about the exponent obtained by combining the modeled powers
`T^(1/2 - β)` and `T^(δ*β)`. It does not define a complex Dirichlet polynomial, estimate its
absolute value, or prove a bound for the analytic scattering multiplier. Under those external
bounds, the combined model has negative exponent:

  `|χ(ρ) S_y(ρ)| ≪ T^(1/2 - β(1 - δ)) = T^(δ/2 - ε(1 - δ))`

Whenever the cofactor cutoff parameter satisfies the critical threshold

  `δ < δ_crit(β) := (β - 1/2) / β = ε / β`,

the combined exponent is strictly negative. Applying this exponent calculation to an analytic
dual sum requires separate hypotheses controlling that sum and its constants.
-/

namespace BuildingBlocks.DualDirichletOfflineDecay

/-- The combined exponent of the scattering multiplier and the dual Dirichlet polynomial. -/
noncomputable def dualExponent (β δ : ℝ) : ℝ := 1/2 - β * (1 - δ)

/-- Exact algebraic rearrangement of the dual exponent in terms of the off-line displacement `ε`. -/
theorem dual_exponent_identity (β δ ε : ℝ) (hβ : β = 1/2 + ε) :
    dualExponent β δ = δ / 2 - ε * (1 - δ) := by
  unfold dualExponent
  subst hβ
  ring

/-- The critical upper threshold on the cofactor parameter `δ`. -/
noncomputable def criticalDelta (β ε : ℝ) : ℝ := ε / β

/-- For any off-line zero with `β > 1/2` (`ε > 0`), any cofactor parameter
strictly below `criticalDelta` forces the dual exponent to be strictly negative. -/
theorem dual_exponent_neg (β δ ε : ℝ) (hβ : β = 1/2 + ε) (hε : 0 < ε)
    (hδ : δ < criticalDelta β ε) : dualExponent β δ < 0 := by
  have h_id := dual_exponent_identity β δ ε hβ
  rw [h_id]
  have hβpos : 0 < β := by subst hβ; linarith
  unfold criticalDelta at hδ
  have h1 : δ * β < ε := (lt_div_iff₀ hβpos).mp hδ
  subst hβ
  nlinarith

/-- The quantitative decay rate `- dualExponent β δ` is strictly positive. -/
theorem dual_exponent_decay_rate (β δ ε : ℝ) (hβ : β = 1/2 + ε) (hε : 0 < ε)
    (hδ : δ < criticalDelta β ε) : 0 < - (dualExponent β δ) := by
  have hneg := dual_exponent_neg β δ ε hβ hε hδ
  linarith

/-- On the critical line `β = 1/2`, the dual exponent reduces to `δ / 2`. -/
theorem dual_exponent_critical_line (δ : ℝ) :
    dualExponent (1/2) δ = δ / 2 := by
  unfold dualExponent
  ring

/-- The sum of the multiplier exponent and polynomial exponent reproduces `dualExponent`. -/
theorem dual_product_exponent (β δ : ℝ) :
    (1/2 - β) + δ * β = dualExponent β δ := by
  unfold dualExponent
  ring

/-- For `T > 1`, the abstract power model is smaller than its positive coefficient. -/
theorem offline_power_decay (T C β δ ε : ℝ) (hT : 1 < T) (hC : 0 < C)
    (hβ : β = 1/2 + ε) (hε : 0 < ε) (hδ : δ < criticalDelta β ε) :
    C * T ^ (dualExponent β δ) < C := by
  have hneg := dual_exponent_neg β δ ε hβ hε hδ
  have hpow : T ^ (dualExponent β δ) < 1 := by
    rw [← Real.rpow_zero T]
    exact Real.rpow_lt_rpow_of_exponent_lt hT hneg
  nlinarith

/-- Strict asymptotic monotonicity: larger ordinates `T₂ > T₁` yield strictly
smaller dual amplitudes at off-line zeros. -/
theorem offline_power_strict_monotonicity {T1 T2 C β δ ε : ℝ}
    (hT1 : 0 < T1) (hT12 : T1 < T2) (hC : 0 < C)
    (hβ : β = 1/2 + ε) (hε : 0 < ε) (hδ : δ < criticalDelta β ε) :
    C * T2 ^ (dualExponent β δ) < C * T1 ^ (dualExponent β δ) := by
  have hneg := dual_exponent_neg β δ ε hβ hε hδ
  have hpow : T2 ^ (dualExponent β δ) < T1 ^ (dualExponent β δ) :=
    Real.rpow_lt_rpow_of_neg hT1 hT12 hneg
  exact mul_lt_mul_of_pos_left hpow hC

/-- Product identity for two modeled powers and arbitrary coefficients. -/
theorem offline_dual_product_bound {T C_chi C_poly β δ : ℝ}
    (hT : 0 < T) :
    (C_chi * T ^ (1/2 - β)) * (C_poly * T ^ (δ * β)) =
      (C_chi * C_poly) * T ^ (dualExponent β δ) := by
  have hpow := (Real.rpow_add hT (1/2 - β) (δ * β)).symm
  rw [dual_product_exponent β δ] at hpow
  calc
    (C_chi * T ^ (1/2 - β)) * (C_poly * T ^ (δ * β)) =
      (C_chi * C_poly) * (T ^ (1/2 - β) * T ^ (δ * β)) := by ring
    _ = (C_chi * C_poly) * T ^ (dualExponent β δ) := by rw [hpow]

#print axioms dual_exponent_identity
#print axioms dual_exponent_neg
#print axioms dual_exponent_decay_rate
#print axioms dual_exponent_critical_line
#print axioms dual_product_exponent
#print axioms offline_power_decay
#print axioms offline_power_strict_monotonicity
#print axioms offline_dual_product_bound

end BuildingBlocks.DualDirichletOfflineDecay
