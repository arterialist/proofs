import BuildingBlocks.GoldbachScrewMinorFinite

/-!
# Two-scale remainder budget for the dyadic Goldbach screw consumer

The analytic input enters the dyadic minor through one signed combination.
This file records its exact finite algebra and the critical `N⁻¹/²`
constant budget.
-/

namespace BuildingBlocks.GoldbachScrewRemainderThresholdFinite

noncomputable section

/-- The signed error introduced when the weighted Goldbach formula is used
at `N` and `N²`. -/
def dyadicRemainderContribution (x err errSq : ℝ) : ℝ :=
  2 * Real.sqrt x * err - x / 2 * errSq

/-- Absolute-value propagation with no assumption on the signs or
correlation of the two errors. -/
theorem dyadic_remainder_budget {x err errSq b bSq : ℝ}
    (hx : 0 ≤ x)
    (herr : |err| ≤ b) (herrSq : |errSq| ≤ bSq) :
    |dyadicRemainderContribution x err errSq| ≤
      2 * Real.sqrt x * b + x / 2 * bSq := by
  rw [dyadicRemainderContribution]
  calc
    |2 * Real.sqrt x * err - x / 2 * errSq| ≤
        |2 * Real.sqrt x * err| + |x / 2 * errSq| := abs_sub _ _
    _ = 2 * Real.sqrt x * |err| + x / 2 * |errSq| := by
      simp only [abs_mul, abs_div, abs_of_nonneg hx,
        abs_of_nonneg (Real.sqrt_nonneg x)]
      norm_num
    _ ≤ 2 * Real.sqrt x * b + x / 2 * bSq := by
      gcongr

/-- If a Fujii remainder of size `C X^(3/2)` is converted by the exact
partial-summation formula, the resulting weighted errors have bounds
`5C/sqrt(N)` and `5C/N`.  At this critical exponent the dyadic budget is the
non-vanishing constant `25C/2`. -/
theorem critical_three_halves_budget {x C err errSq : ℝ}
    (hx : 0 < x)
    (herr : |err| ≤ 5 * C / Real.sqrt x)
    (herrSq : |errSq| ≤ 5 * C / x) :
    |dyadicRemainderContribution x err errSq| ≤ 25 * C / 2 := by
  have hsqrt : 0 < Real.sqrt x := Real.sqrt_pos.2 hx
  have hbudget := dyadic_remainder_budget hx.le herr herrSq
  calc
    |dyadicRemainderContribution x err errSq| ≤
        2 * Real.sqrt x * (5 * C / Real.sqrt x) +
          x / 2 * (5 * C / x) := hbudget
    _ = 25 * C / 2 := by field_simp; ring

/-- A raw finite Goldbach inequality with a full error margin implies the
corresponding corrected inequality. -/
theorem robust_dyadic_of_margin {raw origin contribution budget : ℝ}
    (habs : |contribution| ≤ budget)
    (hraw : raw + budget ≤ 3 * origin) :
    raw - contribution ≤ 3 * origin := by
  have hlo : -budget ≤ contribution := by
    exact (abs_le.mp habs).1
  linarith

/-- Conversely, a corrected one-sided inequality and an unsigned error
budget yield only the enlarged raw inequality. -/
theorem raw_dyadic_of_corrected {raw origin contribution budget : ℝ}
    (habs : |contribution| ≤ budget)
    (hcorr : raw - contribution ≤ 3 * origin) :
    raw ≤ 3 * origin + budget := by
  have hhi : contribution ≤ budget := (abs_le.mp habs).2
  linarith

end
end BuildingBlocks.GoldbachScrewRemainderThresholdFinite

#print axioms BuildingBlocks.GoldbachScrewRemainderThresholdFinite.dyadic_remainder_budget
#print axioms BuildingBlocks.GoldbachScrewRemainderThresholdFinite.critical_three_halves_budget
#print axioms BuildingBlocks.GoldbachScrewRemainderThresholdFinite.robust_dyadic_of_margin
#print axioms BuildingBlocks.GoldbachScrewRemainderThresholdFinite.raw_dyadic_of_corrected
