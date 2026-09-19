/-
Copyright (c) 2026 Andrew. All rights reserved.
Released under the MIT license as described in the file LICENSE.

Scale and exponent algebra for center averaging of the exact reciprocal
Möbius packet.

Written source:
../../building-blocks/weil-and-spectral/actual-mobius-reciprocal-center-average-saving.md.

This file does not formalize oscillatory integration, bounded variation,
Poisson summation, or an analytic mean-square estimate.
-/
import BuildingBlocks.ActualMobiusFreeFactorPruning
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace BuildingBlocks.ActualMobiusReciprocalCenterAverage

/-- Exponent of the diagonal term `sqrt(D / X)` when
`D = T^d` and `X = T^lambda`. -/
noncomputable def firstExponent (lambda d : ℝ) : ℝ :=
  (d - lambda) / 2

/-- Exponent of the reciprocal-spacing row term `D / sqrt(TX)`. -/
noncomputable def secondExponent (lambda d : ℝ) : ℝ :=
  d - (lambda + 1) / 2

/-- The strict center-averaged prefix endpoint. -/
noncomputable def centerEndpoint (lambda : ℝ) : ℝ :=
  (lambda + 1) / 2

/-- With physical mode length `K = DT / X`, the off-diagonal reciprocal
row scale `D² / (XK)` is exactly `D/T`. -/
theorem physicalRowScale {D T X : ℝ} (hD : D ≠ 0) (hT : T ≠ 0) (hX : X ≠ 0) :
    D ^ 2 / (X * (D * T / X)) = D / T := by
  field_simp

/-- Exact reciprocal gap; the analytic note combines this identity with
`m,n in [D,2D]` to get the lower bound by `|m-n|/(4D²)`. -/
theorem reciprocalGap {m n : ℝ} (hm : m ≠ 0) (hn : n ≠ 0) :
    1 / m - 1 / n = (n - m) / (m * n) := by
  field_simp

/-- At a fixed margin below the endpoint, the second mean-square exponent
is exactly the negative margin. -/
theorem secondExponent_below_endpoint (lambda eta : ℝ) :
    secondExponent lambda (centerEndpoint lambda - eta) = -eta := by
  unfold secondExponent centerEndpoint
  ring

/-- The diagonal exponent has a larger fixed margin when `lambda > 1`. -/
theorem firstExponent_below_endpoint (lambda eta : ℝ) :
    firstExponent lambda (centerEndpoint lambda - eta) =
      -(lambda - 1) / 4 - eta / 2 := by
  unfold firstExponent centerEndpoint
  ring

/-- Both center-averaged powers are negative below the new endpoint. -/
theorem both_exponents_negative {lambda d : ℝ}
    (hlambda : 1 < lambda) (hd : d < centerEndpoint lambda) :
    firstExponent lambda d < 0 ∧ secondExponent lambda d < 0 := by
  constructor
  · unfold firstExponent centerEndpoint at *
    linarith
  · unfold secondExponent centerEndpoint at *
    linarith

/-- Center averaging moves the strict dyadic endpoint beyond the previous
Robert--Sargos--Bordellès endpoint by `(lambda+1)/10`. -/
theorem endpoint_gain (lambda : ℝ) :
    centerEndpoint lambda -
        BuildingBlocks.ActualMobiusFreeFactorPruning.endpoint lambda =
      (lambda + 1) / 10 := by
  unfold centerEndpoint BuildingBlocks.ActualMobiusFreeFactorPruning.endpoint
  ring

/-- The critical geometry has center-averaged endpoint `3/2`. -/
theorem critical_centerEndpoint : centerEndpoint 2 = 3 / 2 := by
  norm_num [centerEndpoint]

/-- The preceding pointwise endpoint at the critical geometry is `6/5`. -/
theorem critical_oldEndpoint :
    BuildingBlocks.ActualMobiusFreeFactorPruning.endpoint 2 = 6 / 5 := by
  norm_num [BuildingBlocks.ActualMobiusFreeFactorPruning.endpoint]

/-- The exact exponent gap at the critical geometry is `3/10`. -/
theorem critical_endpoint_gain :
    centerEndpoint 2 -
        BuildingBlocks.ActualMobiusFreeFactorPruning.endpoint 2 = 3 / 10 := by
  norm_num [centerEndpoint, BuildingBlocks.ActualMobiusFreeFactorPruning.endpoint]

/-- At the critical endpoint, the support-swapped outer-variable exponent
is `1/2`, exactly the limiting short-interval threshold. Strict margins on
the two estimates therefore point in opposite directions. -/
theorem critical_swapped_boundary : 2 - centerEndpoint 2 = 1 / 2 := by
  norm_num [centerEndpoint]

end BuildingBlocks.ActualMobiusReciprocalCenterAverage
