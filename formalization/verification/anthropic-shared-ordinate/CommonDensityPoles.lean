import ShiftedJordanOptimizedDensity
import CoprimePoles

noncomputable section

namespace ShiftedJordanCommonAudit

/-- One actual common set and one onset precede every shift and finite prime set.
The source density endpoint is applied directly, with no density hypothesis. -/
theorem uniform_common_optimized_all_poles :
    ∀ ε > 0, ∃ T₀ : ℝ, ∀ T ≥ T₀,
      ((3 * Zeta23.ThmD.HD 1 - 1) / 2 - ε) * (Zeta23.Ncount T (2 * T) : ℝ) ≤
        (good T (2 * T)).card ∧
      ∀ ρ ∈ good T (2 * T),
        (∀ σ : ℂ, Zeta23.IsNontrivialZero σ → σ.im = ρ.im → σ = ρ) ∧
        deriv riemannZeta ρ ≠ 0 ∧
        (∀ a : ℝ, 0 < a → a < 1 / 2 →
          riemannZeta (ρ - (a : ℂ)) ≠ 0 ∧
          meromorphicOrderAt
            (fun s : ℂ => riemannZeta (s - (a : ℂ)) / riemannZeta s - 1) ρ =
              (-1 : ℤ) ∧
          ∀ P : Finset ℕ, (∀ p ∈ P, p.Prime) →
            meromorphicOrderAt
              (fun s : ℂ => eulerDeletion a P s *
                (riemannZeta (s - (a : ℂ)) / riemannZeta s)) ρ = (-1 : ℤ)) := by
  intro ε hε
  obtain ⟨T₀, hT₀⟩ :=
    uniform_common_simple_poles_of_local_simple_density
      (Zeta23.ThmD.HD 1) Zeta23.ThmD.thmD₀_simple_mult ε hε
  refine ⟨T₀, fun T hT => ?_⟩
  obtain ⟨hcount, hgood⟩ := hT₀ T hT
  refine ⟨hcount, fun ρ hρ => ?_⟩
  obtain ⟨hunique, hderiv, hshift⟩ := hgood ρ hρ
  refine ⟨hunique, hderiv, fun a ha ha₂ => ?_⟩
  obtain ⟨hnonzero, hpole⟩ := hshift a ha ha₂
  exact ⟨hnonzero, hpole,
    good_all_shifts_all_finite_deletions_simple_poles hρ a ha ha₂⟩

#check Zeta23.ThmD.HD_one
#print axioms Zeta23.ThmD.HD_one
#print axioms Zeta23.ThmD.thmD₀_simple_mult
#print axioms uniform_common_optimized_all_poles

end ShiftedJordanCommonAudit
