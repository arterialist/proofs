import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Tactic

namespace PaidThetaCompensation

/-! Finite Hilbert-space algebra for observed weighted-crossing range
equations. The analytic matrices and Moore--Penrose identities are inputs. -/

/-- A finite observed equation is feasible exactly when its target belongs
to the range of the finite observation map. -/
theorem finite_equation_feasible_iff_range
    {V W : Type*} [AddCommGroup V] [Module ℝ V]
    [AddCommGroup W] [Module ℝ W]
    (L : V →ₗ[ℝ] W) (y : W) :
    (∃ x, L x = y) ↔ y ∈ Set.range L := by
  rfl

/-- A feasible vector orthogonal to the kernel is the minimum-norm
solution. This is the Hilbert-space completion of squares underlying the
weighted Moore--Penrose formula after conjugation by the energy square
root. -/
theorem orthogonal_feasible_is_minimum
    {V W : Type*}
    [NormedAddCommGroup V] [InnerProductSpace ℝ V]
    [AddCommGroup W] [Module ℝ W]
    (L : V →ₗ[ℝ] W) (x₀ : V)
    (horth : ∀ z, L z = 0 → inner ℝ x₀ z = 0) :
    ∀ x, L x = L x₀ → ‖x₀‖ ^ 2 ≤ ‖x‖ ^ 2 := by
  intro x hx
  let z := x - x₀
  have hz : L z = 0 := by
    simp [z, hx]
  have ho : inner ℝ x₀ z = 0 := horth z hz
  have hdecomp : x = x₀ + z := by
    simp [z]
  rw [hdecomp, norm_add_sq_real, ho]
  simp

/-- Once an orthogonal feasible lift is known, existence of any feasible
solution below an energy ceiling is equivalent to the minimum lift meeting
that ceiling. -/
theorem feasible_energy_cap_iff_minimum
    {V W : Type*}
    [NormedAddCommGroup V] [InnerProductSpace ℝ V]
    [AddCommGroup W] [Module ℝ W]
    (L : V →ₗ[ℝ] W) (x₀ : V) (cap : ℝ)
    (horth : ∀ z, L z = 0 → inner ℝ x₀ z = 0) :
    (∃ x, L x = L x₀ ∧ ‖x‖ ^ 2 ≤ cap) ↔ ‖x₀‖ ^ 2 ≤ cap := by
  constructor
  · rintro ⟨x, hx, hcap⟩
    exact le_trans (orthogonal_feasible_is_minimum L x₀ horth x hx) hcap
  · intro hcap
    exact ⟨x₀, rfl, hcap⟩

/-- If a supplied pseudoinverse is a right inverse on the range and its
lift is orthogonal to the kernel, it gives the exact minimum-norm
solution. -/
theorem pseudoinverse_lift_is_minimum
    {V W : Type*}
    [NormedAddCommGroup V] [InnerProductSpace ℝ V]
    [AddCommGroup W] [Module ℝ W]
    (L : V →ₗ[ℝ] W) (pinv : W → V) (y : W)
    (hrange : y ∈ Set.range L)
    (hright : ∀ w ∈ Set.range L, L (pinv w) = w)
    (horth : ∀ w ∈ Set.range L, ∀ z, L z = 0 →
      inner ℝ (pinv w) z = 0) :
    L (pinv y) = y ∧
      ∀ x, L x = y → ‖pinv y‖ ^ 2 ≤ ‖x‖ ^ 2 := by
  refine ⟨hright y hrange, ?_⟩
  intro x hx
  apply orthogonal_feasible_is_minimum L (pinv y) (horth y hrange) x
  rw [hright y hrange]
  exact hx

/-- The coherent difference of two finite observed equations is again
realized before any norm estimate. -/
theorem two_column_difference_feasible
    {V W : Type*} [AddCommGroup V] [Module ℝ V]
    [AddCommGroup W] [Module ℝ W]
    (L : V →ₗ[ℝ] W) (x₁ x₂ : V) (y₁ y₂ : W)
    (h₁ : L x₁ = y₁) (h₂ : L x₂ = y₂) :
    L (x₁ - x₂) = y₁ - y₂ := by
  simp [h₁, h₂]

/-- Exact two-column energy contraction on the coherent difference. -/
theorem coherent_minimum_energy_contraction
    (E11 E12 E22 : ℝ) :
    E11 + 2 * E12 * (-1) + E22 * (-1) ^ 2 =
      E11 - 2 * E12 + E22 := by
  ring

/-- The nonsingular scalar Schur complement: positivity of the complete
two-by-two block is exactly the determinant condition. -/
theorem positive_scalar_schur_iff
    {g cross cap : ℝ} (hg : 0 < g) :
    (∀ x y : ℝ,
      0 ≤ g * x ^ 2 + 2 * cross * x * y + cap * y ^ 2) ↔
      cross ^ 2 ≤ g * cap := by
  constructor
  · intro h
    have ht := h (-cross / g) 1
    have hg0 : g ≠ 0 := ne_of_gt hg
    field_simp [hg0] at ht
    nlinarith
  · intro hdet x y
    have hid :
        g * (g * x ^ 2 + 2 * cross * x * y + cap * y ^ 2) =
          (g * x + cross * y) ^ 2 +
            (g * cap - cross ^ 2) * y ^ 2 := by
      ring
    have hrhs :
        0 ≤ (g * x + cross * y) ^ 2 +
          (g * cap - cross ^ 2) * y ^ 2 := by
      have : 0 ≤ g * cap - cross ^ 2 := by linarith
      positivity
    nlinarith

/-- At a singular zero leading block, positivity forces the off-diagonal
target to vanish. This is the scalar model of the Moore--Penrose range
condition omitted by determinant-only tests. -/
theorem zero_scalar_schur_iff
    {cross cap : ℝ} :
    (∀ x y : ℝ, 0 ≤ 2 * cross * x * y + cap * y ^ 2) ↔
      cross = 0 ∧ 0 ≤ cap := by
  constructor
  · intro h
    have hcap : 0 ≤ cap := by simpa using h 0 1
    have hcross : cross = 0 := by
      by_contra hn
      have h2 : 2 * cross ≠ 0 := mul_ne_zero (by norm_num) hn
      let x := -(cap + 1) / (2 * cross)
      have heq : 2 * cross * x + cap = -1 := by
        dsimp [x]
        field_simp [h2]
        ring
      have ht := h x 1
      have ht' : 0 ≤ 2 * cross * x + cap := by simpa using ht
      rw [heq] at ht'
      norm_num at ht'
    exact ⟨hcross, hcap⟩
  · rintro ⟨rfl, hcap⟩ x y
    simp
    positivity

end PaidThetaCompensation

#print axioms PaidThetaCompensation.finite_equation_feasible_iff_range
#print axioms PaidThetaCompensation.orthogonal_feasible_is_minimum
#print axioms PaidThetaCompensation.feasible_energy_cap_iff_minimum
#print axioms PaidThetaCompensation.pseudoinverse_lift_is_minimum
#print axioms PaidThetaCompensation.two_column_difference_feasible
#print axioms PaidThetaCompensation.coherent_minimum_energy_contraction
#print axioms PaidThetaCompensation.positive_scalar_schur_iff
#print axioms PaidThetaCompensation.zero_scalar_schur_iff
