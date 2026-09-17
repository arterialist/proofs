import BuildingBlocks.CriticalTransformPoles
import BuildingBlocks.FloorMellin

open MeasureTheory Set Filter
open scoped Topology

namespace BuildingBlocks.CriticalTransformRealAxis

/-- Positivity of the fractional-part integral on the positive real axis. -/
theorem floorMellin_re_nonneg {σ : ℝ} (hσ : 0 < σ) :
    0 ≤ (floorMellin (σ : ℂ)).re := by
  rw [floorMellin_eq_integral]
  change 0 ≤ RCLike.re (∫ x : ℝ in Set.Ioi 1,
    ((x : ℂ) - (⌊x⌋₊ : ℂ)) * (x : ℂ) ^ (-((σ : ℂ) + 1)))
  rw [← integral_re (floorRemainder_kernel_integrable (s := (σ : ℂ)) hσ)]
  apply integral_nonneg_of_ae
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
  have hx0 : 0 ≤ x := by change 1 < x at hx; linarith
  rw [show -((σ : ℂ) + 1) = ((-(σ + 1) : ℝ) : ℂ) by push_cast; rfl,
    ← Complex.ofReal_cpow hx0]
  change 0 ≤ (((x : ℂ) - (⌊x⌋₊ : ℂ)) * ((x ^ (-(σ + 1)) : ℝ) : ℂ)).re
  simpa only [Complex.mul_re, Complex.sub_re, Complex.ofReal_re,
    Complex.natCast_re, Complex.sub_im, Complex.ofReal_im, Complex.natCast_im,
    sub_zero, mul_zero] using
    mul_nonneg (sub_nonneg.mpr (Nat.floor_le hx0))
      (Real.rpow_nonneg hx0 (-(σ + 1)))

/-- The existing fractional-part continuation makes the sign in `(0,1)` explicit. -/
theorem riemannZeta_re_neg {σ : ℝ} (hσ0 : 0 < σ) (hσ1 : σ < 1) :
    (riemannZeta (σ : ℂ)).re < 0 := by
  have hne : (σ : ℂ) ≠ 1 := by exact_mod_cast ne_of_lt hσ1
  rw [zeta_eq_floorMellin hσ0 hne]
  have hdiv : (σ : ℂ) / ((σ : ℂ) - 1) = ((σ / (σ - 1) : ℝ) : ℂ) := by
    push_cast
    rfl
  rw [hdiv]
  simp only [Complex.sub_re, Complex.ofReal_re, Complex.mul_re, Complex.ofReal_im,
    zero_mul, sub_zero]
  have hd := div_neg_of_pos_of_neg hσ0 (show σ - 1 < 0 by linarith)
  have hm := mul_nonneg hσ0.le (floorMellin_re_nonneg hσ0)
  linarith

theorem riemannZeta_ne_zero_real {σ : ℝ} (hσ0 : 0 < σ) (hσ1 : σ ≠ 1) :
    riemannZeta (σ : ℂ) ≠ 0 := by
  rcases lt_or_gt_of_ne hσ1 with hlt | hgt
  · intro hz
    have hneg := riemannZeta_re_neg hσ0 hlt
    simp [hz] at hneg
  · exact riemannZeta_ne_zero_of_one_lt_re hgt

/-- Away from the pole and zeros of zeta, the actual expression is analytic. -/
theorem analyticAt_filledTransform_of_ne_zero {s : ℂ}
    (hs : (1 : ℝ) / 2 < s.re) (hs1 : s ≠ 1) (hz : riemannZeta s ≠ 0) :
    AnalyticAt ℂ CriticalTransformPoles.filledTransform s := by
  have hG : AnalyticAt ℂ LogDerivativePole.centeredZetaLogDerivative s :=
    ((LogDerivativePole.analyticAt_logDeriv (zeta_analytic_off_pole s hs1) hz).neg).sub
      (analyticAt_id.div (analyticAt_id.sub analyticAt_const) (sub_ne_zero.mpr hs1))
  have hT : AnalyticAt ℂ CriticalTransformPoles.transform s :=
    (ShiftedZetaMultiplier.analyticAt_M hs).mul
      ((hG.pow 2).sub (SamePrimeDirichlet.H_analyticAt hs))
  exact hT.congr (CriticalTransformPoles.filledTransform_eventuallyEq hs1).symm

/-- Unconditional complex analyticity at every real point to the right of `1/2`.
At `1` this uses the removable filling, not the assigned unfilled value. -/
theorem analyticAt_filledTransform_real {σ : ℝ} (hσ : (1 : ℝ) / 2 < σ) :
    AnalyticAt ℂ CriticalTransformPoles.filledTransform (σ : ℂ) := by
  by_cases hσ1 : σ = 1
  · subst σ
    simpa using CriticalTransformPoles.analyticAt_filledTransform_one
  · exact analyticAt_filledTransform_of_ne_zero hσ (by exact_mod_cast hσ1)
      (riemannZeta_ne_zero_real (by linarith) hσ1)

end BuildingBlocks.CriticalTransformRealAxis
