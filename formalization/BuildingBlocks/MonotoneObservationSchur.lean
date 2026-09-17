import Mathlib.Tactic

namespace PaidThetaCompensation

/-! Exact order algebra for the monotone canonical-observation certificate. -/

/-- A finite observation is a positive under-approximation of the complete
observation.  Positivity at one finite stage therefore certifies the complete
form without estimating the observation tail. -/
theorem finite_stage_lifts_to_full
    {base finiteObs fullObs : ℝ}
    (hstage : 0 ≤ base + finiteObs)
    (hmono : finiteObs ≤ fullObs) :
    0 ≤ base + fullObs := by
  linarith

/-- The converse of `finite_stage_lifts_to_full` is false: a positive full
correction may pay a negative base before any chosen finite correction does. -/
theorem full_does_not_force_finite_stage :
    0 ≤ (-1 : ℝ) + 1 ∧ ¬ 0 ≤ (-1 : ℝ) + 0 := by
  norm_num

/-- A strict complete margin and an explicit observation-tail error imply a
finite-stage margin.  This is the quantitative alternative when a tail rate
is available. -/
theorem finite_stage_from_full_margin
    {base finiteObs fullObs margin tail : ℝ}
    (hfull : margin ≤ base + fullObs)
    (htail : fullObs - finiteObs ≤ tail)
    (hmargin : tail ≤ margin) :
    0 ≤ base + finiteObs := by
  linarith

/-- The optimized two-block Young condition used by the exact-rational
runner. -/
theorem product_schur_certificate
    {h gap coupling lowSq highSq cross total : ℝ}
    (hh : 0 < h)
    (hlow : 0 ≤ lowSq) (hhigh : 0 ≤ highSq)
    (hcross : cross ≤ coupling * Real.sqrt lowSq * Real.sqrt highSq)
    (htotal : h * lowSq + gap * highSq - 2 * cross ≤ total)
    (hproduct : coupling ^ 2 ≤ h * gap) :
    0 ≤ total := by
  have hsL : 0 ≤ Real.sqrt lowSq := Real.sqrt_nonneg _
  have hsH : 0 ≤ Real.sqrt highSq := Real.sqrt_nonneg _
  have hsL2 : (Real.sqrt lowSq) ^ 2 = lowSq := Real.sq_sqrt hlow
  have hsH2 : (Real.sqrt highSq) ^ 2 = highSq := Real.sq_sqrt hhigh
  have hid :
      h * (h * (Real.sqrt lowSq) ^ 2 + gap * (Real.sqrt highSq) ^ 2 -
        2 * coupling * Real.sqrt lowSq * Real.sqrt highSq) =
      (h * Real.sqrt lowSq - coupling * Real.sqrt highSq) ^ 2 +
        (h * gap - coupling ^ 2) * (Real.sqrt highSq) ^ 2 := by ring
  have hrhs : 0 ≤
      (h * Real.sqrt lowSq - coupling * Real.sqrt highSq) ^ 2 +
        (h * gap - coupling ^ 2) * (Real.sqrt highSq) ^ 2 := by
    have : 0 ≤ h * gap - coupling ^ 2 := by linarith
    positivity
  have hquad :
      0 ≤ h * (Real.sqrt lowSq) ^ 2 + gap * (Real.sqrt highSq) ^ 2 -
        2 * coupling * Real.sqrt lowSq * Real.sqrt highSq := by
    nlinarith [hid, hrhs]
  rw [hsL2, hsH2] at hquad
  have hcross' :
      -2 * coupling * Real.sqrt lowSq * Real.sqrt highSq ≤ -2 * cross := by
    linarith
  linarith

/-- A complex observation of dimension `d` contributes `2*d` real
coordinate constraints, in addition to the two source-normalization rows. -/
theorem actual_constraint_count (d : ℕ) :
    2 + 2 * d = 2 + d + d := by omega

end PaidThetaCompensation
