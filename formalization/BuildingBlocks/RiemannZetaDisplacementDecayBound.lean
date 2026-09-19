import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Complex
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Mul
import Mathlib.Analysis.Calculus.Deriv.Add
import BuildingBlocks.RiemannZetaKernelPositivity
import BuildingBlocks.RiemannZetaDisplacementFourierEnvelope
import BuildingBlocks.RiemannZetaThetaEnvelopeMonotonicity
import BuildingBlocks.RiemannZetaTransverseCauchyRiemannMatching
import BuildingBlocks.RiemannZetaDisplacementZeroExclusion

/-!
# A Quartic Upper Bound for a Scalar Residual

This module defines the real expression `denomSq d t`, proves the one-sided bound
`t^4 < denomSq d t`, and derives an upper bound for `displacementResidualVal` with that
denominator.  Its final theorems show that an arbitrary real number `D_theta` differs from the
residual when `D_theta` lies in either of two stated ranges.  The file does not define a Fourier
transform, prove displacement-envelope decay, identify `D_theta` with a theta integral, or derive
nonvanishing of `riemannZeta`.
-/

namespace BuildingBlocks.RiemannZetaDisplacementDecayBound

open Real
open BuildingBlocks.RiemannZetaKernelPositivity
open BuildingBlocks.RiemannZetaDisplacementFourierEnvelope
open BuildingBlocks.RiemannZetaThetaEnvelopeMonotonicity
open BuildingBlocks.RiemannZetaTransverseCauchyRiemannMatching
open BuildingBlocks.RiemannZetaDisplacementZeroExclusion

noncomputable section

/-! ### Section 1: Denominator Bounds -/

/-- The scalar denominator expression used below:
$$\operatorname{denom}(d, t) := (t^2 + 1/4 - d^2)^2 + 4d^2 t^2.$$ -/
def denomSq (d t : ℝ) : ℝ :=
  (t ^ 2 + 1 / 4 - d ^ 2) ^ 2 + 4 * d ^ 2 * t ^ 2

/-- For $0 < d < 1/2$ and $t > 0$, the denominator strictly exceeds $t^4$:
$$\operatorname{denom}(d, t) > t^4.$$ -/
theorem denomSq_gt_t4 {d t : ℝ} (hd_pos : 0 < d) (hd_lt : d < 1 / 2) (ht : 0 < t) :
    t ^ 4 < denomSq d t := by
  unfold denomSq
  have h_sq : d ^ 2 < (1 / 2 : ℝ) ^ 2 := sq_lt_sq.mpr (by
    rw [abs_of_pos hd_pos, abs_of_pos (by norm_num)]
    exact hd_lt)
  have h_half_sq : (1 / 2 : ℝ) ^ 2 = 1 / 4 := by ring
  rw [h_half_sq] at h_sq
  have h_diff : 0 < 1 / 4 - d ^ 2 := by linarith
  have ht2_pos : 0 < t ^ 2 := sq_pos_of_ne_zero (ne_of_gt ht)
  have h_base : t ^ 2 < t ^ 2 + (1 / 4 - d ^ 2) := by linarith
  have h_base_pos : 0 < t ^ 2 + 1 / 4 - d ^ 2 := by linarith
  have h_sq_lt : (t ^ 2) ^ 2 < (t ^ 2 + 1 / 4 - d ^ 2) ^ 2 := by
    nlinarith
  have h_t4 : (t ^ 2) ^ 2 = t ^ 4 := by ring
  rw [h_t4] at h_sq_lt
  have h_extra : 0 ≤ 4 * d ^ 2 * t ^ 2 := by positivity
  linarith

/-- For $0 < d < 1/2$ and $t > 0$, the denominator is strictly positive:
$$\operatorname{denom}(d, t) > 0.$$ -/
theorem denomSq_pos {d t : ℝ} (hd_pos : 0 < d) (hd_lt : d < 1 / 2) (ht : 0 < t) :
    0 < denomSq d t := by
  have ht4_pos : 0 < t ^ 4 := by positivity
  have h_gt := denomSq_gt_t4 hd_pos hd_lt ht
  linarith

/-! ### Section 2: A Strict Residual Upper Bound -/

/-- Strict upper bound on the displacement residual:
$$R(d, s) < \frac{2d(1/4 - d^2)}{t^4}.$$ -/
theorem displacementResidual_lt_quartic {d t : ℝ}
    (hd_pos : 0 < d) (hd_lt : d < 1 / 2) (ht : 0 < t) :
    displacementResidualVal d (denomSq d t) < 2 * d * (1 / 4 - d ^ 2) / t ^ 4 := by
  unfold displacementResidualVal
  have h_2d : 0 < 2 * d := mul_pos two_pos hd_pos
  have h_sq : d ^ 2 < (1 / 2 : ℝ) ^ 2 := sq_lt_sq.mpr (by
    rw [abs_of_pos hd_pos, abs_of_pos (by norm_num)]
    exact hd_lt)
  have h_half_sq : (1 / 2 : ℝ) ^ 2 = 1 / 4 := by ring
  rw [h_half_sq] at h_sq
  have h_diff : 0 < 1 / 4 - d ^ 2 := by linarith
  have h_num : 0 < 2 * d * (1 / 4 - d ^ 2) := mul_pos h_2d h_diff
  have ht4_pos : 0 < t ^ 4 := by positivity
  have h_denom_gt := denomSq_gt_t4 hd_pos hd_lt ht
  exact div_lt_div_of_pos_left h_num ht4_pos h_denom_gt

/-! ### Section 3: Scalar Mismatch Criteria -/

/-- If an arbitrary `D_theta` is at least the quartic upper bound, it differs from the residual. -/
theorem zero_exclusion_of_quartic_excess {d t D_theta : ℝ}
    (hd_pos : 0 < d) (hd_lt : d < 1 / 2) (ht : 0 < t)
    (h_excess : 2 * d * (1 / 4 - d ^ 2) / t ^ 4 ≤ D_theta) :
    D_theta ≠ displacementResidualVal d (denomSq d t) := by
  have h_lt := displacementResidual_lt_quartic hd_pos hd_lt ht
  intro h_eq
  rw [h_eq] at h_excess
  linarith

/-- An arbitrary `D_theta` differs from the positive residual if it is nonpositive or at least
the quartic upper bound. -/
theorem offline_zero_free_of_bounds {d t D_theta : ℝ}
    (hd_pos : 0 < d) (hd_lt : d < 1 / 2) (ht : 0 < t)
    (h_outside : D_theta ≤ 0 ∨ 2 * d * (1 / 4 - d ^ 2) / t ^ 4 ≤ D_theta) :
    D_theta ≠ displacementResidualVal d (denomSq d t) := by
  rcases h_outside with h_le | h_ge
  · have h_pos := displacementResidualVal_pos hd_pos hd_lt (denomSq_pos hd_pos hd_lt ht)
    exact zero_exclusion_of_nonpos h_le h_pos
  · exact zero_exclusion_of_quartic_excess hd_pos hd_lt ht h_ge

/-! ### Section 4: Axiom Verification -/

#print axioms denomSq_gt_t4
#print axioms denomSq_pos
#print axioms displacementResidual_lt_quartic
#print axioms zero_exclusion_of_quartic_excess
#print axioms offline_zero_free_of_bounds

end

end BuildingBlocks.RiemannZetaDisplacementDecayBound
