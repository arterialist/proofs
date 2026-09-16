import Mathlib.Tactic

namespace BuildingBlocks.EvenSectorMargin

/-!
Finite real algebra for the even-sector constrained-margin test.

The existence of the full-space gap, the extension identity, and the gain
bound are operator-analytic hypotheses. This module only verifies their exact
finite implication and the upper cap forced by an equality mode.
-/

/-- A constrained full-space margin pays the complete gain when the gain
coefficient does not exceed that margin. -/
theorem constrained_margin_pays_gain
    {α Γ η extensionSq F gain : ℝ}
    (hext : 0 ≤ extensionSq)
    (hform : (Γ - α) * extensionSq ≤ F)
    (hgain : gain ≤ η * extensionSq)
    (hη : η ≤ Γ - α) :
    0 ≤ F - gain := by
  have hpay : η * extensionSq ≤ (Γ - α) * extensionSq :=
    mul_le_mul_of_nonneg_right hη hext
  linarith

/-- A nonzero equality mode at level `λ` caps every proposed gap by `λ`. -/
theorem equality_mode_caps_gap
    {Γ lam energy normSq : ℝ}
    (hnorm : 0 < normSq)
    (hequality : energy = lam * normSq)
    (hgap : Γ * normSq ≤ energy) :
    Γ ≤ lam := by
  rw [hequality] at hgap
  exact (mul_le_mul_iff_right₀ hnorm).mp (by simpa [mul_comm] using hgap)

/-- Combining an equality-mode cap with a lower enclosure for the killed
ground shows that every global constrained margin is at most the known killed
gap ceiling. -/
theorem constrained_margin_le_gap_ceiling
    {Γ α lam δ : ℝ}
    (hΓ : Γ ≤ lam)
    (hα : lam - δ ≤ α) :
    Γ - α ≤ δ := by
  linarith

/-- If the gain coefficient is larger than the only available upper ceiling
for `Γ-α`, no argument based solely on that scalar ceiling can verify the
payment premise `η ≤ Γ-α`. -/
theorem gain_above_ceiling_blocks_margin_payment
    {Γ α δ η : ℝ}
    (hmargin : Γ - α ≤ δ)
    (hη : δ < η) :
    ¬ η ≤ Γ - α := by
  linarith

/-- A positive killed gap `lam - α = d` and an equality-mode upper cap
`Γ ≤ lam` do not, by themselves, force `α < Γ`: the scalar data admit the
endpoint `Γ = α`.  This is a logical insufficiency statement, not an operator
counterexample. -/
theorem killed_gap_and_cap_do_not_force_positive_margin
    (lam d : ℝ) (hd : 0 < d) :
    let α := lam - d
    ∃ Γ : ℝ, Γ ≤ lam ∧ ¬ α < Γ := by
  dsimp
  refine ⟨lam - d, ?_, by simp⟩
  linarith

/-- Direct restricted-range form of the needed theorem: a lower Rayleigh
margin and an upper gain ratio imply nonnegativity of the signed comparison. -/
theorem restricted_even_range_certificate
    {α Γ gainRatio extensionSq F gain : ℝ}
    (hext : 0 ≤ extensionSq)
    (hRayleigh : Γ * extensionSq ≤ F + α * extensionSq)
    (hgain : gain ≤ gainRatio * extensionSq)
    (hcompare : gainRatio ≤ Γ - α) :
    0 ≤ F - gain := by
  have hform : (Γ - α) * extensionSq ≤ F := by linarith
  exact constrained_margin_pays_gain hext hform hgain hcompare

end BuildingBlocks.EvenSectorMargin

#print axioms BuildingBlocks.EvenSectorMargin.constrained_margin_pays_gain
#print axioms BuildingBlocks.EvenSectorMargin.equality_mode_caps_gap
#print axioms BuildingBlocks.EvenSectorMargin.restricted_even_range_certificate
