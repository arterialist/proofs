import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# Logarithmic overlap loss

Real-variable inequalities for the gcd/lcm overlap calculation. This module
contains no arithmetic maximal-order estimate or Riemann hypothesis premise.
-/

namespace BuildingBlocks.LogarithmicOverlap

/-- The relative loss in the product of the two logarithmic arguments. -/
noncomputable def overlapFraction (u v : ℝ) : ℝ := u * (u + v) / (1 + v)

theorem denominator_pos {v : ℝ} (hv : 0 ≤ v) : 0 < 1 + v := by
  linarith

theorem overlapFraction_nonneg {u v : ℝ} (hu : 0 ≤ u) (hv : 0 ≤ v) :
    0 ≤ overlapFraction u v := by
  exact div_nonneg (mul_nonneg hu (add_nonneg hu hv)) (denominator_pos hv).le

theorem one_sub_overlapFraction_eq {u v : ℝ} (hv : 0 ≤ v) :
    1 - overlapFraction u v = (1 - u) * (1 + u + v) / (1 + v) := by
  unfold overlapFraction
  field_simp [(denominator_pos hv).ne']
  ring

theorem one_sub_overlapFraction_pos {u v : ℝ}
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v) :
    0 < 1 - overlapFraction u v := by
  rw [one_sub_overlapFraction_eq hv]
  apply div_pos _ (denominator_pos hv)
  exact mul_pos (by linarith) (by linarith)

theorem overlapFraction_lt_one {u v : ℝ}
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v) :
    overlapFraction u v < 1 := by
  have := one_sub_overlapFraction_pos hu hu1 hv
  linarith

theorem log_left_nonpos {u : ℝ} (hu : 0 ≤ u) (hu1 : u < 1) :
    Real.log (1 - u) ≤ 0 := by
  exact Real.log_nonpos (by linarith) (by linarith)

theorem log_right_nonneg {u v : ℝ} (hu : 0 ≤ u) (hv : 0 ≤ v) :
    0 ≤ Real.log (1 + u + v) := by
  exact Real.log_nonneg (by linarith)

theorem log_overlap_eq {u v : ℝ}
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v) :
    Real.log (1 - overlapFraction u v) =
      Real.log (1 - u) + Real.log (1 + u + v) - Real.log (1 + v) := by
  have hleft : 0 < 1 - u := by linarith
  have hright : 0 < 1 + u + v := by linarith
  rw [one_sub_overlapFraction_eq hv,
    Real.log_div (mul_ne_zero hleft.ne' hright.ne') (denominator_pos hv).ne',
    Real.log_mul hleft.ne' hright.ne']

/-- Exact expansion of the product loss, with all logarithm domains justified. -/
theorem overlap_identity (L : ℝ) {u v : ℝ}
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v) :
    (L + Real.log (1 - u)) * (L + Real.log (1 + u + v)) -
        L * (L + Real.log (1 + v)) =
      L * Real.log (1 - overlapFraction u v) +
        Real.log (1 - u) * Real.log (1 + u + v) := by
  rw [log_overlap_eq hu hu1 hv]
  ring

/-- The logarithmic product loses at least the explicit overlap fraction. -/
theorem overlap_loss {L u v : ℝ} (hL : 0 < L)
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v) :
    (L + Real.log (1 - u)) * (L + Real.log (1 + u + v)) -
        L * (L + Real.log (1 + v)) ≤
      -L * u * (u + v) / (1 + v) := by
  have hlog : Real.log (1 - overlapFraction u v) ≤ -overlapFraction u v := by
    have := Real.log_le_sub_one_of_pos (one_sub_overlapFraction_pos hu hu1 hv)
    linarith
  have hmul := mul_le_mul_of_nonneg_left hlog hL.le
  have hcross : Real.log (1 - u) * Real.log (1 + u + v) ≤ 0 :=
    mul_nonpos_of_nonpos_of_nonneg (log_left_nonpos hu hu1) (log_right_nonneg hu hv)
  rw [overlap_identity L hu hu1 hv]
  calc
    _ ≤ -L * overlapFraction u v := by nlinarith
    _ = -L * u * (u + v) / (1 + v) := by unfold overlapFraction; ring

/-- Algebraic expansion of the two reciprocal correction terms. -/
theorem corrected_product_identity {A B : ℝ} (κ : ℝ)
    (hA : 0 < A) (hB : 0 < B) :
    (A + κ / A) * (B + κ / B) =
      A * B + κ * (A / B + B / A) + κ ^ 2 / (A * B) := by
  field_simp [hA.ne', hB.ne']
  ring

/-- A corrected upper product must pay for the logarithmic overlap loss.

The implication holds for every real `κ`, so in particular for `κ ≥ 0`.
-/
theorem correction_bound {L u v κ : ℝ} (hL : 0 < L)
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v)
    (hA : 0 < L + Real.log (1 - u))
    (hB : 0 < L + Real.log (1 + u + v))
    (hcorrected : L * (L + Real.log (1 + v)) ≤
      (L + Real.log (1 - u) + κ / (L + Real.log (1 - u))) *
        (L + Real.log (1 + u + v) + κ / (L + Real.log (1 + u + v)))) :
    L * u * (u + v) / (1 + v) ≤
      κ * ((L + Real.log (1 - u)) / (L + Real.log (1 + u + v)) +
        (L + Real.log (1 + u + v)) / (L + Real.log (1 - u))) +
      κ ^ 2 / ((L + Real.log (1 - u)) * (L + Real.log (1 + u + v))) := by
  have hloss := overlap_loss hL hu hu1 hv
  rw [corrected_product_identity κ hA hB] at hcorrected
  have hsign : -L * u * (u + v) / (1 + v) =
      -(L * u * (u + v) / (1 + v)) := by ring
  rw [hsign] at hloss
  linarith

/-- The sum of the two logarithmic arguments retains the exact second endpoint. -/
theorem log_argument_sum_le {L u v : ℝ}
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v) :
    (L + Real.log (1 - u)) + (L + Real.log (1 + u + v)) ≤
      2 * L + Real.log (1 + v) := by
  have hlog : Real.log (1 - overlapFraction u v) ≤ 0 :=
    Real.log_nonpos (one_sub_overlapFraction_pos hu hu1 hv).le
      (by have := overlapFraction_nonneg hu hv; linarith)
  rw [log_overlap_eq hu hu1 hv] at hlog
  linarith

/-- A uniform nonnegative additive error pays for the full overlap loss.

This uses the exact threshold at the second endpoint. No separate error from
replacing that endpoint by the first one is introduced.
-/
theorem uniform_error_bound {L u v η : ℝ} (hL : 0 < L)
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v) (hη : 0 ≤ η)
    (hcorrected : L * (L + Real.log (1 + v)) ≤
      (L + Real.log (1 - u) + η) * (L + Real.log (1 + u + v) + η)) :
    L * u * (u + v) / (1 + v) ≤
      (2 * L + Real.log (1 + v)) * η + η ^ 2 := by
  have hloss := overlap_loss hL hu hu1 hv
  have hsum := log_argument_sum_le (L := L) hu hu1 hv
  have herr := mul_le_mul_of_nonneg_right hsum hη
  have hsign : -L * u * (u + v) / (1 + v) =
      -(L * u * (u + v) / (1 + v)) := by ring
  rw [hsign] at hloss
  nlinarith

/-- Normalized form of the uniform error bound, for the gcd spacing estimate. -/
theorem uniform_error_fraction_bound {L u v η : ℝ} (hL : 0 < L)
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v) (hη : 0 ≤ η)
    (hcorrected : L * (L + Real.log (1 + v)) ≤
      (L + Real.log (1 - u) + η) * (L + Real.log (1 + u + v) + η)) :
    u * (u + v) / (1 + v) ≤
      (2 + Real.log (1 + v) / L) * η + η ^ 2 / L := by
  have hbound := uniform_error_bound hL hu hu1 hv hη hcorrected
  have hdiv := div_le_div_of_nonneg_right hbound hL.le
  have hleft : (L * u * (u + v) / (1 + v)) / L =
      u * (u + v) / (1 + v) := by
    field_simp [hL.ne', (denominator_pos hv).ne']
  have hright : ((2 * L + Real.log (1 + v)) * η + η ^ 2) / L =
      (2 + Real.log (1 + v) / L) * η + η ^ 2 / L := by
    field_simp [hL.ne']
  rwa [hleft, hright] at hdiv

end BuildingBlocks.LogarithmicOverlap
