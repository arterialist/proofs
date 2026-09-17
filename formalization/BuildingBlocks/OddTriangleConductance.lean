import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic

namespace BuildingBlocks.OddTriangleConductance

theorem triangle_cycle_decomposition (x y z : ℝ) :
    (z - x)^2 + (x + y)^2 + (z - y)^2 =
      (4 / 3 : ℝ) * z^2 + (1 / 3 : ℝ) *
        (((z - x) - (x + y))^2 + ((z - x) - (z - y))^2 +
          ((x + y) - (z - y))^2) := by
  ring

theorem weighted_route_decomposition (w₁ w₂ A B Z : ℝ) :
    (w₁ + w₂) * (w₁ * (A - Z)^2 + w₂ * (Z + B)^2) =
      w₁ * w₂ * (A + B)^2 + ((w₁ + w₂) * Z - w₁ * A + w₂ * B)^2 := by
  ring

theorem weighted_route_lower_bound {w₁ w₂ : ℝ} (h₁ : 0 < w₁) (h₂ : 0 < w₂)
    (A B Z : ℝ) :
    w₁ * w₂ / (w₁ + w₂) * (A + B)^2 ≤ w₁ * (A - Z)^2 + w₂ * (Z + B)^2 := by
  have hs : 0 < w₁ + w₂ := add_pos h₁ h₂
  apply (mul_le_mul_iff_right₀ hs).mp
  have hc : (w₁ + w₂) * (w₁ * w₂ / (w₁ + w₂) * (A + B)^2) =
      w₁ * w₂ * (A + B)^2 := by
    field_simp
  rw [hc, weighted_route_decomposition]
  exact le_add_of_nonneg_right (sq_nonneg _)

#print axioms triangle_cycle_decomposition
#print axioms weighted_route_decomposition
#print axioms weighted_route_lower_bound
end BuildingBlocks.OddTriangleConductance
