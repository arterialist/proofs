import Mathlib.MeasureTheory.Integral.IntervalIntegral.IntegrationByParts
import Mathlib.Tactic.Linarith

/-! Local weighted primitive sign certificates. No zeta or RH assumption occurs.
The analytic theorem uses integrable right derivatives, so corners in a forcing
primitive are allowed; it does not claim the full absolutely-continuous version.
The paired-cell theorem verifies the polynomial certificate used by binary forcing,
conditional on its independently established endpoint and harmonic inequalities. -/
open Set MeasureTheory
open scoped Interval

namespace WeightedPrimitiveSign

/-- Integration by parts transfers a nonpositive primitive to every weight with
nonpositive right derivative and positive terminal value. Strictness only needs
the terminal primitive to be negative. -/
theorem weighted_integral_neg
    {a b : ℝ} {w P dw B : ℝ → ℝ} (hab : a ≤ b)
    (hw : ContinuousOn w [[a, b]]) (hP : ContinuousOn P [[a, b]])
    (hdw : ∀ x ∈ Ioo (min a b) (max a b),
      HasDerivWithinAt w (dw x) (Ioi x) x)
    (hdP : ∀ x ∈ Ioo (min a b) (max a b),
      HasDerivWithinAt P (B x) (Ioi x) x)
    (hiw : IntervalIntegrable dw volume a b)
    (hiB : IntervalIntegrable B volume a b)
    (hPa : P a = 0) (hPb : P b < 0) (hwb : 0 < w b)
    (hPneg : ∀ x ∈ Icc a b, P x ≤ 0)
    (hdwneg : ∀ x ∈ Icc a b, dw x ≤ 0) :
    (∫ x in a..b, w x * B x) < 0 := by
  rw [intervalIntegral.integral_mul_deriv_eq_deriv_mul_of_hasDeriv_right
    hw hP hdw hdP hiw hiB, hPa, mul_zero, sub_zero]
  have hint : 0 ≤ ∫ x in a..b, dw x * P x :=
    intervalIntegral.integral_nonneg hab fun x hx =>
      mul_nonneg_of_nonpos_of_nonpos (hdwneg x hx) (hPneg x hx)
  have hend : w b * P b < 0 := mul_neg_of_pos_of_neg hwb hPb
  linarith

/-- First-cell prefix of an affine decreasing forcing cell. -/
theorem first_cell_prefix_neg {e h u : ℝ}
    (he : e < 0) (hh : 0 ≤ h) (hu : 0 < u) :
    e * u - h * u ^ 2 / 2 < 0 := by
  have hprod : e * u < 0 := mul_neg_of_neg_of_pos he hu
  have hquad : 0 ≤ h * u ^ 2 := mul_nonneg hh (sq_nonneg u)
  linarith

/-- Second-cell prefix certificate for actual binary forcing's two affine cells:
`e = B(2k)`, `o = B(2k+1)`, and `h,h'` are the two harmonic slopes.
No sign assumption on the odd endpoint is needed. -/
theorem second_cell_prefix_neg {e o h h' u : ℝ}
    (he : e < 0) (heo : e + o < 0)
    (hh : 0 ≤ h) (hh' : 0 ≤ h') (hu : 0 ≤ u) (hu' : u ≤ 1) :
    e - h / 2 + u * o - h' * u ^ 2 / 2 < 0 := by
  have hquad : 0 ≤ h' * u ^ 2 := mul_nonneg hh' (sq_nonneg u)
  by_cases ho : o ≤ 0
  · have huo : u * o ≤ 0 := mul_nonpos_of_nonneg_of_nonpos hu ho
    linarith
  · have hop : 0 ≤ o := le_of_lt (lt_of_not_ge ho)
    have huo : u * o ≤ o := by nlinarith
    linarith

/-- Primitive in coordinates measured from the even integer endpoint. -/
noncomputable def pairedPrimitive (e o h h' t : ℝ) : ℝ :=
  if t ≤ 1 then e * t - h * t ^ 2 / 2
  else e - h / 2 + (t - 1) * o - h' * (t - 1) ^ 2 / 2

theorem pairedPrimitive_zero (e o h h' : ℝ) :
    pairedPrimitive e o h h' 0 = 0 := by simp [pairedPrimitive]

theorem pairedPrimitive_neg {e o h h' t : ℝ}
    (he : e < 0) (heo : e + o < 0) (hh : 0 ≤ h) (hh' : 0 ≤ h')
    (ht : 0 < t) (ht' : t ≤ 2) : pairedPrimitive e o h h' t < 0 := by
  unfold pairedPrimitive
  split_ifs with hcell
  · exact first_cell_prefix_neg he hh ht
  · exact second_cell_prefix_neg he heo hh hh' (by linarith) (by linarith)

/-- Weighted two-cell specialization: the two endpoint inequalities and
nonnegative slopes discharge all primitive sign hypotheses. The primitive
and forcing are the literal paired affine-cell model, not a zeta criterion. -/
theorem paired_weighted_integral_neg
    {e o h h' T : ℝ} {w dw B : ℝ → ℝ}
    (he : e < 0) (heo : e + o < 0) (hh : 0 ≤ h) (hh' : 0 ≤ h')
    (hT : 0 < T) (hT' : T ≤ 2)
    (hw : ContinuousOn w [[0, T]])
    (hP : ContinuousOn (pairedPrimitive e o h h') [[0, T]])
    (hdw : ∀ x ∈ Ioo (min 0 T) (max 0 T),
      HasDerivWithinAt w (dw x) (Ioi x) x)
    (hdP : ∀ x ∈ Ioo (min 0 T) (max 0 T),
      HasDerivWithinAt (pairedPrimitive e o h h') (B x) (Ioi x) x)
    (hiw : IntervalIntegrable dw volume 0 T)
    (hiB : IntervalIntegrable B volume 0 T)
    (hwT : 0 < w T) (hdwneg : ∀ x ∈ Icc 0 T, dw x ≤ 0) :
    (∫ x in 0..T, w x * B x) < 0 := by
  apply weighted_integral_neg (le_of_lt hT) hw hP hdw hdP hiw hiB
    (pairedPrimitive_zero e o h h')
    (pairedPrimitive_neg he heo hh hh' hT hT') hwT
  · intro x hx
    by_cases hx0 : x = 0
    · simp [hx0, pairedPrimitive_zero]
    · exact le_of_lt (pairedPrimitive_neg he heo hh hh'
        (lt_of_le_of_ne hx.1 (Ne.symm hx0)) (le_trans hx.2 hT'))
  · exact hdwneg

/-- The origin forcing `B(x)=-x` has a strictly negative primitive from 1. -/
theorem origin_prefix_neg {x : ℝ} (hx : 1 < x) :
    -(x ^ 2 - 1) / 2 < 0 := by nlinarith

#print axioms weighted_integral_neg
#print axioms first_cell_prefix_neg
#print axioms second_cell_prefix_neg
#print axioms origin_prefix_neg
#print axioms pairedPrimitive_neg
#print axioms paired_weighted_integral_neg
end WeightedPrimitiveSign
