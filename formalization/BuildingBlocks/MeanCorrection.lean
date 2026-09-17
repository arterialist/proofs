import BuildingBlocks.FractionalApproximation

open Finset Filter Set MeasureTheory
open scoped Topology BigOperators Interval

namespace BuildingBlocks

open MertensTransfer CoarsePrimitive FloorCorrection HyperbolaProduct

/-- A correction with zero linear mass and period mean -1/2. -/
noncomputable def boundaryCorrection (y : ℝ) : ℝ :=
  Int.fract (2 * y) - 2 * Int.fract y

theorem boundaryCorrection_intervalIntegrable (a b : ℝ) :
    IntervalIntegrable boundaryCorrection volume a b := by
  have hi : IntervalIntegrable (fun y : ℝ => Int.fract (2 * y)) volume a b := by
    simpa only [mul_div_cancel_left₀ _ (by norm_num : (2 : ℝ) ≠ 0)] using
      (fract_intervalIntegrable (2 * a) (2 * b)).comp_mul_left (c := (2 : ℝ))
  exact hi.sub ((fract_intervalIntegrable a b).const_mul 2)

theorem boundaryCorrection_mean : (∫ y in (0 : ℝ)..1, boundaryCorrection y) = -1 / 2 := by
  have hi : IntervalIntegrable (fun y : ℝ => Int.fract (2 * y)) volume 0 1 := by
    simpa using (fract_intervalIntegrable 0 2).comp_mul_left (c := (2 : ℝ))
  dsimp [boundaryCorrection]
  have htwo : (∫ y in (0 : ℝ)..1, Int.fract (2 * y)) = 1 / 2 := by
    simpa using integral_fract_nat_mul (q := 2) (by omega)
  rw [intervalIntegral.integral_sub hi
    ((fract_intervalIntegrable 0 1).const_mul 2), intervalIntegral.integral_const_mul,
    htwo, integral_fract_unit]
  norm_num

theorem boundaryCorrection_periodic : Function.Periodic boundaryCorrection 1 := by
  intro y
  have hh : 2 * (y + 1) = 2 * y + (2 : ℕ) := by push_cast; ring
  simp only [boundaryCorrection, hh, Int.fract_add_natCast, Int.fract_add_one]

noncomputable def meanCorrectedDual (N : ℕ) (x : ℝ) : ℝ :=
  dualApproximation N x + ((mertens N : ℝ) + 1) * boundaryCorrection (1 / ((N : ℝ) * x))

noncomputable def meanCorrectedError (N : ℕ) (y : ℝ) : ℝ :=
  reciprocalError N y + ((mertens N : ℝ) + 1) * boundaryCorrection y

theorem meanCorrectedDual_reciprocal {N : ℕ} (hN : 0 < N) {y : ℝ} (hy : y ≠ 0) :
    1 + meanCorrectedDual N (1 / ((N : ℝ) * y)) = meanCorrectedError N y := by
  have hn : (N : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hN)
  have he : 1 / ((N : ℝ) * (1 / ((N : ℝ) * y))) = y := by field_simp
  dsimp [meanCorrectedDual, meanCorrectedError]
  rw [he, ← add_assoc, dualApproximation_reciprocal hN hy]

theorem meanCorrectedError_periodic (N : ℕ) : Function.Periodic (meanCorrectedError N) 1 := by
  intro y
  simp only [meanCorrectedError, reciprocalError_periodic N y, boundaryCorrection_periodic y]

theorem meanCorrectedError_intervalIntegrable (N : ℕ) (a b : ℝ) :
    IntervalIntegrable (meanCorrectedError N) volume a b :=
  (reciprocalError_intervalIntegrable N a b).add
    ((boundaryCorrection_intervalIntegrable a b).const_mul _)

/-- The mean obstruction is removed exactly. This gives no convergence bound. -/
theorem meanCorrectedError_mean_zero (N : ℕ) :
    (∫ y in (0 : ℝ)..1, meanCorrectedError N y) = 0 := by
  dsimp [meanCorrectedError]
  rw [intervalIntegral.integral_add (reciprocalError_intervalIntegrable N 0 1)
    ((boundaryCorrection_intervalIntegrable 0 1).const_mul _),
    intervalIntegral.integral_const_mul, reciprocalError_mean_zero_one,
    boundaryCorrection_mean]
  ring

theorem boundaryCorrection_zero_of_small {y : ℝ} (hy : 0 ≤ y) (h2 : 2 * y < 1) :
    boundaryCorrection y = 0 := by
  dsimp [boundaryCorrection]
  rw [Int.fract_eq_self.mpr ⟨by positivity, h2⟩,
    Int.fract_eq_self.mpr ⟨hy, by linarith⟩]
  ring

theorem meanCorrectedDual_zero_above_one {N : ℕ} (hN : 2 ≤ N) {x : ℝ} (hx : 1 < x) :
    meanCorrectedDual N x = 0 := by
  have hn : (2 : ℝ) ≤ (N : ℝ) := by exact_mod_cast hN
  have hprod : (0 : ℝ) < (N : ℝ) * x := by positivity
  have hlarge : (2 : ℝ) < (N : ℝ) * x := by nlinarith
  have hs : 2 * (1 / ((N : ℝ) * x)) < 1 := by
    simpa only [mul_one_div] using (div_lt_one hprod).mpr hlarge
  simp only [meanCorrectedDual, dualApproximation_zero_above_one (by omega : 0 < N) hx,
    boundaryCorrection_zero_of_small (by positivity) hs, mul_zero, add_zero]

theorem boundaryCorrection_abs_le (y : ℝ) : |boundaryCorrection y| ≤ 3 := by
  have hh := abs_add_le (Int.fract (2 * y)) (-2 * Int.fract y)
  simp only [abs_mul, abs_neg, abs_of_nonneg (Int.fract_nonneg _)] at hh
  norm_num at hh
  dsimp [boundaryCorrection]
  simp only [← sub_eq_add_neg] at hh
  linarith [Int.fract_lt_one y, Int.fract_lt_one (2 * y)]

theorem meanCorrectedDual_error_abs_bound (N : ℕ) (x : ℝ) :
    |1 + meanCorrectedDual N x| ≤
      (2 + ∑ q ∈ Finset.Icc 1 N, |(quotientCoefficient N q : ℝ)|) +
        3 * |(mertens N : ℝ) + 1| := by
  dsimp [meanCorrectedDual]
  rw [← add_assoc, dualError_eq_reciprocalError]
  apply (abs_add_le _ _).trans
  apply add_le_add (reciprocalError_abs_bound N _) ?_
  rw [abs_mul, mul_comm 3]
  exact mul_le_mul_of_nonneg_left (boundaryCorrection_abs_le _) (abs_nonneg _)

theorem meanCorrectedDual_sq_intervalIntegrable (N : ℕ) (a b : ℝ) :
    IntervalIntegrable (fun x => (1 + meanCorrectedDual N x) ^ 2) volume a b := by
  have hm : Measurable (fun x => 1 + meanCorrectedDual N x) := by
    dsimp [meanCorrectedDual, dualApproximation, boundaryCorrection]
    fun_prop
  apply (intervalIntegrable_const (c := ((2 + ∑ q ∈ Finset.Icc 1 N,
    |(quotientCoefficient N q : ℝ)|) + 3 * |(mertens N : ℝ) + 1|) ^ 2)).mono_fun'
      (hm.pow_const 2).aestronglyMeasurable
  apply Eventually.of_forall
  intro x
  simp only [Real.norm_eq_abs, abs_pow]
  exact pow_le_pow_left₀ (abs_nonneg _) (meanCorrectedDual_error_abs_bound N x) 2

/-- A rejected candidate convergence statement, not an asserted premise.
HalvingRecovery derives its impossibility from an explicit Mertens oscillation
premise. The squared-error integrals are justified by the preceding theorem. -/
def MeanCorrectedConvergence : Prop :=
  Tendsto (fun N : ℕ => ∫ x in (0 : ℝ)..1, (1 + meanCorrectedDual N x) ^ 2) atTop (𝓝 0)

end BuildingBlocks
