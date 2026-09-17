import BuildingBlocks.GoldbachScrewRemainderThresholdFinite

/-!
# The equally spaced three-point screw minor

This file records the determinant on `t, 2t, 3t`, its exact substitution by
the three finite weighted Goldbach prefixes, and a concrete low-coefficient
obstruction to replacing screw positivity by positivity of the raw Goldbach
Hankel matrix.
-/

namespace BuildingBlocks.GoldbachScrewThreeMinorFinite

open scoped Matrix
open BuildingBlocks.GoldbachHeat
open BuildingBlocks.GoldbachScrewMinorFinite

noncomputable section

/-- With `a=g(t)-g(0)`, `b=g(2t)-g(0)`, and `c=g(3t)-g(0)`, this is the
screw-kernel matrix on the equally spaced positive times `t,2t,3t`. -/
def screwTripleMatrix (a b c : ℝ) : Matrix (Fin 3) (Fin 3) ℝ :=
  !![-2 * a, -b, b - a - c;
     -b, -2 * b, a - b - c;
     b - a - c, a - b - c, -2 * c]

/-- Factored polynomial for the three-point determinant. -/
def screwTripleDet (a b c : ℝ) : ℝ :=
  2 * (-4 * a * b * c + a * (a - b - c) ^ 2 + b ^ 2 * c -
    b * (a - b - c) * (b - a - c) + b * (b - a - c) ^ 2)

/-- Exact determinant of the screw matrix on `t,2t,3t`. -/
theorem screwTripleMatrix_det (a b c : ℝ) :
    (screwTripleMatrix a b c).det = screwTripleDet a b c := by
  rw [Matrix.det_fin_three]
  simp [screwTripleMatrix, screwTripleDet]
  ring

/-- The complete weighted Goldbach-prefix residual at one integer scale. -/
def prefixResidual (N : ℕ) (constant err : ℝ) : ℝ :=
  inverseSquareGoldbachPrefix N - Real.log N - constant - err

/-- A shifted `H₁` value reconstructed from a weighted prefix.  The scale is
`sqrt N`, `N`, or `N sqrt N` at the three inputs below. -/
def reconstructedShift (scale : ℝ) (N : ℕ)
    (constant err origin : ℝ) : ℝ :=
  scale / 2 * prefixResidual N constant err - origin

/-- Literal substitution of the three weighted-prefix formulas into the
three-point determinant.  All three remainders and the common constant are
retained. -/
theorem three_minor_goldbach_translation (N : ℕ)
    (constant errN errN2 errN3 origin : ℝ) :
    (screwTripleMatrix
      (reconstructedShift (Real.sqrt N) N constant errN origin)
      (reconstructedShift N (N ^ 2) constant errN2 origin)
      (reconstructedShift (N * Real.sqrt N) (N ^ 3)
        constant errN3 origin)).det =
    screwTripleDet
      (Real.sqrt N / 2 *
        (inverseSquareGoldbachPrefix N - Real.log N - constant - errN) - origin)
      ((N : ℝ) / 2 *
        (inverseSquareGoldbachPrefix (N ^ 2) - Real.log (N ^ 2) -
          constant - errN2) - origin)
      (((N : ℝ) * Real.sqrt N) / 2 *
        (inverseSquareGoldbachPrefix (N ^ 3) - Real.log (N ^ 3) -
          constant - errN3) - origin) := by
  rw [screwTripleMatrix_det]
  simp only [reconstructedShift, prefixResidual, Nat.cast_pow]

/-- There is no automatic first-order cancellation of the third-scale
error in the cubic determinant. -/
theorem screwTripleDet_third_scale_sensitivity (e : ℝ) :
    screwTripleDet (-1) (-1) (-1 + e) = 4 - 2 * e - 2 * e ^ 2 := by
  simp [screwTripleDet]
  ring

/-- The raw Goldbach `3×3` Hankel matrix already has a negative quadratic
form.  The witness has third coordinate zero, so this is exactly the
previous first nonzero `2×2` obstruction embedded in the larger minor. -/
theorem raw_goldbach_three_by_three_witness_neg :
    let r4 := shiftedPrimeGoldbach 2
    let r5 := shiftedPrimeGoldbach 3
    let r6 := shiftedPrimeGoldbach 4
    r4 * r5 ^ 2 + 2 * r5 * r5 * (-r4) + r6 * (-r4) ^ 2 < 0 := by
  dsimp only
  have h4 : 0 < shiftedPrimeGoldbach 2 := by
    rw [prime_goldbach_four]
    exact sq_pos_of_pos (Real.log_pos (by norm_num))
  have hdet := first_nonzero_goldbach_hankel_minor_neg
  have heq :
      shiftedPrimeGoldbach 2 * shiftedPrimeGoldbach 3 ^ 2 +
          2 * shiftedPrimeGoldbach 3 * shiftedPrimeGoldbach 3 *
            (-shiftedPrimeGoldbach 2) +
          shiftedPrimeGoldbach 4 * (-shiftedPrimeGoldbach 2) ^ 2 =
        shiftedPrimeGoldbach 2 *
          (shiftedPrimeGoldbach 2 * shiftedPrimeGoldbach 4 -
            shiftedPrimeGoldbach 3 ^ 2) := by ring
  rw [heq]
  exact mul_neg_of_pos_of_neg h4 hdet

end
end BuildingBlocks.GoldbachScrewThreeMinorFinite

#print axioms BuildingBlocks.GoldbachScrewThreeMinorFinite.screwTripleMatrix_det
#print axioms BuildingBlocks.GoldbachScrewThreeMinorFinite.three_minor_goldbach_translation
#print axioms BuildingBlocks.GoldbachScrewThreeMinorFinite.screwTripleDet_third_scale_sensitivity
#print axioms BuildingBlocks.GoldbachScrewThreeMinorFinite.raw_goldbach_three_by_three_witness_neg
