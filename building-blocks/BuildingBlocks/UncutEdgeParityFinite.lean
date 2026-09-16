import Mathlib.Tactic

/-!
Finite algebra for an uncut symmetric edge observation. The actual
theta edge measure, marginal inequality, and target positivity are
analytic inputs, not assertions of this module.
-/

namespace PaidThetaCompensation.UncutEdgeParityFinite

private theorem norm_sub_sq_le_two (x y : ℂ) :
    ‖x - y‖ ^ 2 ≤ 2 * (‖x‖ ^ 2 + ‖y‖ ^ 2) := by
  have htri : ‖x - y‖ ≤ ‖x‖ + ‖y‖ := norm_sub_le x y
  have hx : 0 ≤ ‖x‖ := norm_nonneg _
  have hy : 0 ≤ ‖y‖ := norm_nonneg _
  have hmul := mul_nonneg
    (sub_nonneg.mpr htri)
    (by positivity : 0 ≤ ‖x‖ + ‖y‖ + ‖x - y‖)
  nlinarith [sq_nonneg (‖x‖ - ‖y‖)]

/-- Symmetric endpoint energies and a one-endpoint marginal bound give
the factor-four edge-gradient estimate. -/
theorem finite_symmetric_edge_bound
    {V E : Type*} (s : Finset E)
    (src dst : E → V) (weight : E → ℝ) (F : V → ℂ)
    (a vertexEnergy : ℝ) (ha : 0 ≤ a)
    (hw : ∀ e ∈ s, 0 ≤ weight e)
    (hsym :
      (∑ e ∈ s, weight e * ‖F (dst e)‖ ^ 2) =
      ∑ e ∈ s, weight e * ‖F (src e)‖ ^ 2)
    (hmarg :
      a * (∑ e ∈ s, weight e * ‖F (src e)‖ ^ 2) ≤ vertexEnergy) :
    a * (∑ e ∈ s, weight e * ‖F (dst e) - F (src e)‖ ^ 2)
      ≤ 4 * vertexEnergy := by
  have hpoint (e : E) (he : e ∈ s) :
      weight e * ‖F (dst e) - F (src e)‖ ^ 2 ≤
      2 * (weight e * ‖F (dst e)‖ ^ 2 +
        weight e * ‖F (src e)‖ ^ 2) := by
    have h := mul_le_mul_of_nonneg_left
      (norm_sub_sq_le_two (F (dst e)) (F (src e))) (hw e he)
    nlinarith
  have hsum :
      (∑ e ∈ s, weight e * ‖F (dst e) - F (src e)‖ ^ 2) ≤
      2 * ((∑ e ∈ s, weight e * ‖F (dst e)‖ ^ 2) +
        (∑ e ∈ s, weight e * ‖F (src e)‖ ^ 2)) := by
    calc
      _ ≤ ∑ e ∈ s, 2 * (weight e * ‖F (dst e)‖ ^ 2 +
        weight e * ‖F (src e)‖ ^ 2) :=
          Finset.sum_le_sum (fun e he => hpoint e he)
      _ = _ := by
        simp_rw [mul_add]
        rw [Finset.sum_add_distrib]
        simp [Finset.mul_sum]
  rw [hsym] at hsum
  nlinarith

/-- A target with distinct reflected coordinates cannot be in the
span of even-hat columns whose reflected coordinates agree. -/
theorem odd_target_not_in_even_hat_span
    (action : Fin 5 → Fin 16 → ℂ) (target : Fin 16 → ℂ)
    (heven : ∀ j, action j 9 = action j 10)
    (hodd : target 9 ≠ target 10) :
    ¬ ∃ c : Fin 5 → ℂ,
      ∀ i, target i = ∑ j : Fin 5, c j * action j i := by
  rintro ⟨c, hc⟩
  apply hodd
  calc
    target 9 = ∑ j : Fin 5, c j * action j 9 := hc 9
    _ = ∑ j : Fin 5, c j * action j 10 := by
      apply Finset.sum_congr rfl
      intro j _
      rw [heven j]
    _ = target 10 := (hc 10).symm

/-- Monotone-convergence approximation of a positive full cell mass
eventually yields a positive canonical restricted mass. The analytic
approximation is an explicit hypothesis. -/
theorem positive_canonical_stage
    (fullMass : ℝ) (stageMass : ℕ → ℝ)
    (hfull : 0 < fullMass)
    (happrox : ∀ ε : ℝ, 0 < ε →
      ∃ M : ℕ, 4 ≤ M ∧ fullMass - ε < stageMass M) :
    ∃ M : ℕ, 4 ≤ M ∧ 0 < stageMass M := by
  obtain ⟨M, hM, hclose⟩ :=
    happrox (fullMass / 2) (by positivity)
  refine ⟨M, hM, ?_⟩
  linarith

/-- The two radius-two test cells at stage M and grid level zero are
valid indices among the 2M unit cells. -/
theorem reflected_unit_cell_indices (M : ℕ) (hM : 4 ≤ M) :
    M + 2 < 2 * M ∧ M - 3 < 2 * M := by
  omega

#print axioms finite_symmetric_edge_bound
#print axioms odd_target_not_in_even_hat_span
#print axioms positive_canonical_stage
#print axioms reflected_unit_cell_indices

end PaidThetaCompensation.UncutEdgeParityFinite
