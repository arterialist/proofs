import BuildingBlocks.GoldbachScrewThreeMinorFinite

/-!
# Finite Bessel-product moment and cumulant algebra

For independent uniform circle phases, a component `a cos θ` has second
moment `a²/2` and fourth moment `3a⁴/8`.  The recursive definitions below
encode the exact finite convolution algebra, without asserting any
zeta-zero equidistribution or limiting theorem.
-/

namespace BuildingBlocks.GoldbachMFunctionCumulantFinite

noncomputable section

/-- Second moment of a finite independent cosine packet. -/
def finiteSecondMoment : List ℝ → ℝ
  | [] => 0
  | a :: tail => finiteSecondMoment tail + a ^ 2 / 2

/-- Fourth moment under adjoining an independent centered cosine
component. -/
def finiteFourthMoment : List ℝ → ℝ
  | [] => 0
  | a :: tail =>
      finiteFourthMoment tail +
        3 * finiteSecondMoment tail * a ^ 2 + 3 * a ^ 4 / 8

/-- Fourth power sum of the Bessel amplitudes. -/
def fourthPowerSum : List ℝ → ℝ
  | [] => 0
  | a :: tail => fourthPowerSum tail + a ^ 4

/-- The exact fourth cumulant of a finite Bessel product. -/
theorem fourth_cumulant_exact (weights : List ℝ) :
    finiteFourthMoment weights - 3 * finiteSecondMoment weights ^ 2 =
      -(3 / 8 : ℝ) * fourthPowerSum weights := by
  induction weights with
  | nil => norm_num [finiteSecondMoment, finiteFourthMoment, fourthPowerSum]
  | cons a tail ih =>
      simp only [finiteSecondMoment, finiteFourthMoment, fourthPowerSum]
      nlinarith [ih]

theorem fourthPowerSum_nonneg (weights : List ℝ) :
    0 ≤ fourthPowerSum weights := by
  induction weights with
  | nil => simp [fourthPowerSum]
  | cons a tail ih =>
      simp only [fourthPowerSum]
      positivity

/-- The first non-Gaussian cumulant is nonpositive. -/
theorem finiteFourthMoment_le_three_second_sq (weights : List ℝ) :
    finiteFourthMoment weights ≤ 3 * finiteSecondMoment weights ^ 2 := by
  have hc := fourth_cumulant_exact weights
  have hs := fourthPowerSum_nonneg weights
  nlinarith

/-- It is strictly negative whenever at least one amplitude is nonzero,
expressed by the exact positive fourth-power mass hypothesis. -/
theorem finiteFourthMoment_lt_three_second_sq (weights : List ℝ)
    (hpos : 0 < fourthPowerSum weights) :
    finiteFourthMoment weights < 3 * finiteSecondMoment weights ^ 2 := by
  have hc := fourth_cumulant_exact weights
  nlinarith

/-- The amplitude attached to a distinct positive zeta ordinate under RH;
the zero multiplicity is retained rather than assumed to be one. -/
def hOneZeroWeight (multiplicity : ℕ) (ordinate : ℝ) : ℝ :=
  2 * multiplicity / (1 / 4 + ordinate ^ 2)

/-- A single ordinate contributes exactly
`-6 m⁴/(1/4+γ²)⁴` to the fourth cumulant. -/
theorem hOne_zero_fourth_cumulant_term (multiplicity : ℕ) (ordinate : ℝ) :
    -(3 / 8 : ℝ) * hOneZeroWeight multiplicity ordinate ^ 4 =
      -6 * (multiplicity : ℝ) ^ 4 / (1 / 4 + ordinate ^ 2) ^ 4 := by
  have hden : (1 / 4 : ℝ) + ordinate ^ 2 ≠ 0 := by positivity
  simp only [hOneZeroWeight]
  field_simp
  ring

/-- Exact finite zeta-amplitude specialization.  This is algebra only: the
interpretation as moments of `H₁(eᵗ)` additionally needs RH and rational
linear independence of the distinct positive ordinates. -/
theorem finite_hOne_packet_cumulant
    (zeros : List (ℕ × ℝ)) :
    finiteFourthMoment (zeros.map fun z => hOneZeroWeight z.1 z.2) -
        3 * finiteSecondMoment (zeros.map fun z => hOneZeroWeight z.1 z.2) ^ 2 =
      -(3 / 8 : ℝ) *
        fourthPowerSum (zeros.map fun z => hOneZeroWeight z.1 z.2) :=
  fourth_cumulant_exact _

end
end BuildingBlocks.GoldbachMFunctionCumulantFinite

#print axioms BuildingBlocks.GoldbachMFunctionCumulantFinite.fourth_cumulant_exact
#print axioms BuildingBlocks.GoldbachMFunctionCumulantFinite.fourthPowerSum_nonneg
#print axioms BuildingBlocks.GoldbachMFunctionCumulantFinite.finiteFourthMoment_le_three_second_sq
#print axioms BuildingBlocks.GoldbachMFunctionCumulantFinite.finiteFourthMoment_lt_three_second_sq
#print axioms BuildingBlocks.GoldbachMFunctionCumulantFinite.hOne_zero_fourth_cumulant_term
#print axioms BuildingBlocks.GoldbachMFunctionCumulantFinite.finite_hOne_packet_cumulant
