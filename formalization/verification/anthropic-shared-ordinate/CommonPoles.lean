import CommonCount
import ShiftedJordanPole

open Complex ShiftedJordanAudit

noncomputable section

namespace ShiftedJordanCommonAudit

/-- Each member of the shift-independent good set gives a simple pole for every
real shift in the open interval (0, 1/2). -/
theorem good_all_shifts_simple_poles {T₁ T₂ : ℝ} {ρ : ℂ}
    (hρ : ρ ∈ good T₁ T₂) :
    deriv riemannZeta ρ ≠ 0 ∧
      ∀ a : ℝ, 0 < a → a < 1 / 2 →
        meromorphicOrderAt
          (fun s : ℂ => riemannZeta (s - (a : ℂ)) / riemannZeta s - 1) ρ =
            (-1 : ℤ) := by
  classical
  obtain ⟨hw, hre, hm⟩ := mem_simple.mp (Finset.mem_filter.mp hρ).1
  have hz := (mem_window.mp hw).1
  refine ⟨ShiftedJordanPoleAudit.retained_simple_derivative_ne_zero hz hm, ?_⟩
  intro a ha ha₂
  exact ShiftedJordanPoleAudit.shifted_ratio_order_on_critical_line ha hz hre hm
    (good_all_shifts_nonzero hρ a ha ha₂)

/-- The density input is explicit. One onset and one good set precede all shifts. -/
theorem uniform_common_simple_poles_of_local_simple_density (κ : ℝ)
    (hκ : ∀ ε > 0, ∃ T₀ : ℝ, ∀ T ≥ T₀,
      (κ - ε) * (Zeta23.Ncount T (2 * T) : ℝ) ≤ Zeta23.N0simple T (2 * T)) :
    ∀ ε > 0, ∃ T₀ : ℝ, ∀ T ≥ T₀,
      ((3 * κ - 1) / 2 - ε) * (Zeta23.Ncount T (2 * T) : ℝ) ≤
        (good T (2 * T)).card ∧
      ∀ ρ ∈ good T (2 * T),
        (∀ σ : ℂ, Zeta23.IsNontrivialZero σ → σ.im = ρ.im → σ = ρ) ∧
        deriv riemannZeta ρ ≠ 0 ∧
        (∀ a : ℝ, 0 < a → a < 1 / 2 →
          riemannZeta (ρ - (a : ℂ)) ≠ 0 ∧
          meromorphicOrderAt
            (fun s : ℂ => riemannZeta (s - (a : ℂ)) / riemannZeta s - 1) ρ =
              (-1 : ℤ)) := by
  intro ε hε
  obtain ⟨T₀, hT₀⟩ := uniform_common_good_of_local_simple_density κ hκ ε hε
  refine ⟨T₀, fun T hT => ?_⟩
  obtain ⟨hcount, hgood⟩ := hT₀ T hT
  refine ⟨hcount, fun ρ hρ => ?_⟩
  obtain ⟨hunique, hnonzero⟩ := hgood ρ hρ
  obtain ⟨hderiv, hpole⟩ := good_all_shifts_simple_poles hρ
  exact ⟨hunique, hderiv, fun a ha ha₂ => ⟨hnonzero a ha ha₂, hpole a ha ha₂⟩⟩

#print axioms good_all_shifts_simple_poles
#print axioms uniform_common_simple_poles_of_local_simple_density

end ShiftedJordanCommonAudit
