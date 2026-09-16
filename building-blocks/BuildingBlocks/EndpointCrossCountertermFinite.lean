import Mathlib.Tactic
import Mathlib.Analysis.InnerProductSpace.Basic

/-!
# Finite algebra after subtracting the endpoint Abel cross

The analytic size estimates are external.  These identities remove exactly
one specified endpoint cross, retain the four remaining endpoint terms, and
give the unique two-horizon cancellation of a common leading coefficient.
-/

namespace BuildingBlocks.EndpointCrossCountertermFinite

noncomputable section

/-- Subtracting the old-nonendpoint/new-endpoint cross from the full admission
leaves all four other endpoint terms. -/
theorem endpoint_increment_after_cross_counterterm
    {H : Type*} [SeminormedAddCommGroup H] [InnerProductSpace ℝ H]
    (Z D E W : H) :
    ((‖(Z + D) + (E + W)‖ ^ 2 - ‖Z + E‖ ^ 2) -
        (‖Z + D‖ ^ 2 - ‖Z‖ ^ 2)) - 2 * inner ℝ Z W =
      2 * inner ℝ D E + 2 * inner ℝ D W +
        2 * inner ℝ E W + ‖W‖ ^ 2 := by
  simp only [norm_add_sq_real, inner_add_left, inner_add_right]
  ring

/-- Exact quadratic endpoint admission. -/
theorem endpoint_square_admission
    {H : Type*} [SeminormedAddCommGroup H] [InnerProductSpace ℝ H]
    (E W : H) :
    ‖E + W‖ ^ 2 - ‖E‖ ^ 2 = 2 * inner ℝ E W + ‖W‖ ^ 2 := by
  rw [norm_add_sq_real]
  ring

/-- Two-horizon cancellation for a common source `S` with arbitrary nonzero
distinct scale coefficients. -/
theorem two_horizon_common_source_cancel
    (A₁ A₂ E S R₁ R₂ s₁ s₂ : ℝ)
    (hscale : s₁ ≠ s₂)
    (h₁ : A₁ = E + s₁ * S + R₁)
    (h₂ : A₂ = E + s₂ * S + R₂) :
    (s₁ * A₂ - s₂ * A₁) / (s₁ - s₂) =
      E + (s₁ * R₂ - s₂ * R₁) / (s₁ - s₂) := by
  rw [h₁, h₂]
  have hden : s₁ - s₂ ≠ 0 := sub_ne_zero.mpr hscale
  field_simp [hden]
  ring

/-- A terminal interval on which a tail is a single coefficient has the
exact positive square reserve shown here. -/
theorem terminal_square_reserve
    (w : ℕ → ℝ) (a : ℝ) (lo hi : ℕ) :
    (∑ k ∈ Finset.Ioc lo hi, w k * a ^ 2) =
      a ^ 2 * ∑ k ∈ Finset.Ioc lo hi, w k := by
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro k hk
  ring

/-- A positive terminal weight gives a positive reserve when the terminal
coefficient is nonzero. -/
theorem terminal_square_reserve_pos
    (weight a : ℝ) (hweight : 0 < weight) (ha : a ≠ 0) :
    0 < a ^ 2 * weight := by
  positivity

end
end BuildingBlocks.EndpointCrossCountertermFinite

#print axioms BuildingBlocks.EndpointCrossCountertermFinite.endpoint_increment_after_cross_counterterm
#print axioms BuildingBlocks.EndpointCrossCountertermFinite.endpoint_square_admission
#print axioms BuildingBlocks.EndpointCrossCountertermFinite.two_horizon_common_source_cancel
#print axioms BuildingBlocks.EndpointCrossCountertermFinite.terminal_square_reserve
#print axioms BuildingBlocks.EndpointCrossCountertermFinite.terminal_square_reserve_pos
