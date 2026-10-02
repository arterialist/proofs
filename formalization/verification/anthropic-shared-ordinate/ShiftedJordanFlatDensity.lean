import Zeta23.FinalMult
import CommonCount

noncomputable section

namespace ShiftedJordanCommonAudit

/-- The actual dyadic two-thirds source gives one common set of unique
simple-critical ordinates surviving every open-strip left shift. -/
theorem uniform_common_good_flat_two_thirds :
    ∀ ε > 0, ∃ T₀ : ℝ, ∀ T ≥ T₀,
      (1 / 2 - ε) * (Zeta23.Ncount T (2 * T) : ℝ) ≤ (good T (2 * T)).card ∧
      ∀ ρ ∈ good T (2 * T),
        (∀ σ : ℂ, Zeta23.IsNontrivialZero σ → σ.im = ρ.im → σ = ρ) ∧
        (∀ a : ℝ, 0 < a → a < 1 / 2 → riemannZeta (ρ - (a : ℂ)) ≠ 0) := by
  have hcoef : (3 * (2 / 3 : ℝ) - 1) / 2 = (1 / 2 : ℝ) := by norm_num
  simpa only [hcoef] using
    uniform_common_good_of_local_simple_density (2 / 3 : ℝ) Zeta23.thmB₀_mult

#check Zeta23.thmB₀_mult
#print axioms Zeta23.thmB₀_mult
#check uniform_common_good_flat_two_thirds
#print uniform_common_good_flat_two_thirds
#print axioms uniform_common_good_flat_two_thirds

end ShiftedJordanCommonAudit
