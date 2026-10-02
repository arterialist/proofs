import Zeta23.ThmD.Mult
import CommonCount

noncomputable section

namespace ShiftedJordanCommonAudit

/-- The optimized source uses native `HD 1` and one common good set.
No decimal constant or comparator theorem is substituted. -/
theorem uniform_common_good_optimized_HD_one :
    ∀ ε > 0, ∃ T₀ : ℝ, ∀ T ≥ T₀,
      ((3 * Zeta23.ThmD.HD 1 - 1) / 2 - ε) * (Zeta23.Ncount T (2 * T) : ℝ) ≤
        (good T (2 * T)).card ∧
      ∀ ρ ∈ good T (2 * T),
        (∀ σ : ℂ, Zeta23.IsNontrivialZero σ → σ.im = ρ.im → σ = ρ) ∧
        (∀ a : ℝ, 0 < a → a < 1 / 2 → riemannZeta (ρ - (a : ℂ)) ≠ 0) :=
  uniform_common_good_of_local_simple_density
    (Zeta23.ThmD.HD 1) Zeta23.ThmD.thmD₀_simple_mult

#check Zeta23.ThmD.thmD₀_simple_mult
#print axioms Zeta23.ThmD.thmD₀_simple_mult
#check uniform_common_good_optimized_HD_one
#print uniform_common_good_optimized_HD_one
#print axioms uniform_common_good_optimized_HD_one

end ShiftedJordanCommonAudit
