import Mathlib.Tactic

namespace BuildingBlocks.OptimizerMismatch

/-!
Scalar Hermitian algebra behind the exact optimizer-mismatch identity.

The operator/form input is represented by real diagonal values and complex
mixed values. Hermitian symmetry, positivity, and source membership are
analytic hypotheses of a consumer; no theta analytic statement is asserted
here.
-/

/-- Optimizer for a Hermitian affine quadratic whose mixed numerator is
`z + m` and whose diagonal denominator is the real scalar `d`. -/
noncomputable def affineOptimizer (z m : ℂ) (d : ℝ) : ℂ :=
  (z + m) / (d : ℂ)

/-- The part of the affine quadratic that depends on its scalar coefficient.
The convention corresponds to inner products linear in the first argument. -/
noncomputable def affineScalarEnergy (z m c : ℂ) (d : ℝ) : ℝ :=
  d * Complex.normSq c - 2 * (star c * (z + m)).re

/-- Exact completion of the Hermitian affine square. -/
theorem affine_completion_of_square
    (z m c : ℂ) (d : ℝ) (hd : d ≠ 0) :
    affineScalarEnergy z m c d =
      d * Complex.normSq (c - affineOptimizer z m d) -
        Complex.normSq (z + m) / d := by
  simp [affineScalarEnergy, affineOptimizer, Complex.normSq_apply]
  field_simp
  ring

/-- A positive denominator makes the completed value a lower bound. -/
theorem affine_minimum_lower_bound
    (z m c : ℂ) (d : ℝ) (hd : 0 < d) :
    -Complex.normSq (z + m) / d ≤ affineScalarEnergy z m c d := by
  rw [affine_completion_of_square z m c d hd.ne']
  have hn : 0 ≤ Complex.normSq (c - affineOptimizer z m d) :=
    Complex.normSq_nonneg _
  have hmul : 0 ≤ d * Complex.normSq (c - affineOptimizer z m d) :=
    mul_nonneg hd.le hn
  convert add_le_add_right hmul (-Complex.normSq (z + m) / d) using 1 <;> ring

/-- The optimizer attains the completed minimum. -/
theorem affine_optimizer_value
    (z m : ℂ) (d : ℝ) (hd : d ≠ 0) :
    affineScalarEnergy z m (affineOptimizer z m d) d =
      -Complex.normSq (z + m) / d := by
  rw [affine_completion_of_square z m _ d hd]
  simp only [sub_self, Complex.normSq_zero, mul_zero, zero_sub]
  ring

/-- Under a positive denominator, equality in the lower bound uniquely fixes
the affine coefficient. -/
theorem affine_minimum_eq_iff
    (z m c : ℂ) (d : ℝ) (hd : 0 < d) :
    affineScalarEnergy z m c d = -Complex.normSq (z + m) / d ↔
      c = affineOptimizer z m d := by
  rw [affine_completion_of_square z m c d hd.ne']
  constructor
  · intro h
    have hz : Complex.normSq (c - affineOptimizer z m d) = 0 := by
      have : d * Complex.normSq (c - affineOptimizer z m d) = 0 := by
        linear_combination h
      exact (mul_eq_zero.mp this).resolve_left hd.ne'
    have : c - affineOptimizer z m d = 0 := by
      simpa [Complex.normSq_eq_zero] using hz
    exact sub_eq_zero.mp this
  · intro h
    simp only [h, sub_self, Complex.normSq_zero, mul_zero, zero_sub]
    ring

/-- Optimized value after including a real baseline and the diagonal form
value `ff`. -/
noncomputable def affineOptimizedValue
    (base ff d : ℝ) (z m : ℂ) : ℝ :=
  base - ff + Complex.normSq (z + m) / d

/-- Value of the difference form on the residual `f-cq`. -/
noncomputable def residualQuadratic
    (ff d : ℝ) (z c : ℂ) : ℝ :=
  ff - 2 * (star c * z).re + d * Complex.normSq c

/-- Exact optimizer-mismatch identity for two Hermitian quadratic forms.
`Q-C` has diagonal data `qff-cff`, `dQ-dC`, and `zQ-zC`. -/
theorem optimizer_mismatch_identity
    (base qff cff dQ dC : ℝ) (zQ zC m : ℂ)
    (hdQ : dQ ≠ 0) (hdC : dC ≠ 0) :
    affineOptimizedValue base cff dC zC m -
        affineOptimizedValue base qff dQ zQ m =
      residualQuadratic (qff - cff) (dQ - dC) (zQ - zC)
          (affineOptimizer zQ m dQ) +
        dC * Complex.normSq
          (affineOptimizer zQ m dQ - affineOptimizer zC m dC) := by
  simp [affineOptimizedValue, residualQuadratic, affineOptimizer,
    Complex.normSq_apply]
  field_simp
  ring

/-- Adding an observation to the old optimized value gives the exact form of
the signed lower comparison: true optimized value minus unobserved residual
gain and optimizer mismatch. -/
theorem observed_optimizer_mismatch_identity
    (base qff cff dQ dC obs : ℝ) (zQ zC m : ℂ)
    (hdQ : dQ ≠ 0) (hdC : dC ≠ 0) :
    affineOptimizedValue base qff dQ zQ m + obs =
      affineOptimizedValue base cff dC zC m -
        (residualQuadratic (qff - cff) (dQ - dC) (zQ - zC)
            (affineOptimizer zQ m dQ) - obs +
          dC * Complex.normSq
            (affineOptimizer zQ m dQ - affineOptimizer zC m dC)) := by
  have h := optimizer_mismatch_identity base qff cff dQ dC zQ zC m hdQ hdC
  linarith

/-- Explicit hypotheses under which the quantity subtracted from the true
optimized value is nonnegative. `hobs` is precisely the analytic statement
that the finite observation is dominated by the complete residual gain. -/
theorem unobserved_gain_nonnegative
    (qff cff dQ dC obs : ℝ) (zQ zC m : ℂ)
    (hdC : 0 ≤ dC)
    (hobs : obs ≤ residualQuadratic (qff - cff) (dQ - dC) (zQ - zC)
      (affineOptimizer zQ m dQ)) :
    0 ≤ residualQuadratic (qff - cff) (dQ - dC) (zQ - zC)
          (affineOptimizer zQ m dQ) - obs +
        dC * Complex.normSq
          (affineOptimizer zQ m dQ - affineOptimizer zC m dC) := by
  have hn : 0 ≤ Complex.normSq
      (affineOptimizer zQ m dQ - affineOptimizer zC m dC) :=
    Complex.normSq_nonneg _
  nlinarith

/-- The common-nullspace condition `zQ + m = 0` makes the old optimizer
exactly zero. -/
theorem affineOptimizer_eq_zero_of_joint_null
    (zQ m : ℂ) (dQ : ℝ) (hnull : zQ + m = 0) :
    affineOptimizer zQ m dQ = 0 := by
  simp [affineOptimizer, hnull]

/-- On the common nullspace, the true optimizer is the *negative* difference
mixed coefficient divided by the true denominator. -/
theorem affineOptimizer_of_joint_null
    (zQ zC m : ℂ) (dC : ℝ) (hnull : zQ + m = 0) :
    affineOptimizer zC m dC = -(zQ - zC) / (dC : ℂ) := by
  have hm : m = -zQ := by linear_combination hnull
  simp [affineOptimizer, hm]
  ring

/-- The optimizer mismatch square on the common nullspace has a positive
absolute-square numerator.  The sign in the optimizer itself disappears. -/
theorem joint_null_mismatch_square
    (zQ zC m : ℂ) (dQ dC : ℝ)
    (hdC : dC ≠ 0) (hnull : zQ + m = 0) :
    dC * Complex.normSq
        (affineOptimizer zQ m dQ - affineOptimizer zC m dC) =
      Complex.normSq (zQ - zC) / dC := by
  simp [affineOptimizer_eq_zero_of_joint_null zQ m dQ hnull,
    affineOptimizer_of_joint_null zQ zC m dC hnull,
    Complex.normSq_apply]
  field_simp
  ring

/-- Joint-nullspace specialization of the observed mismatch identity. -/
theorem observed_optimizer_mismatch_joint_null
    (base qff cff dQ dC obs : ℝ) (zQ zC m : ℂ)
    (hdQ : dQ ≠ 0) (hdC : dC ≠ 0) (hnull : zQ + m = 0) :
    affineOptimizedValue base qff dQ zQ m + obs =
      affineOptimizedValue base cff dC zC m -
        ((qff - cff) - obs + Complex.normSq (zQ - zC) / dC) := by
  rw [observed_optimizer_mismatch_identity base qff cff dQ dC obs zQ zC m
    hdQ hdC]
  have hsq := joint_null_mismatch_square zQ zC m dQ dC hdC hnull
  rw [affineOptimizer_eq_zero_of_joint_null zQ m dQ hnull]
  simp [residualQuadratic]
  simp [affineOptimizer_eq_zero_of_joint_null zQ m dQ hnull] at hsq
  rw [hsq]

end BuildingBlocks.OptimizerMismatch

#print axioms BuildingBlocks.OptimizerMismatch.affine_completion_of_square
#print axioms BuildingBlocks.OptimizerMismatch.optimizer_mismatch_identity
#print axioms BuildingBlocks.OptimizerMismatch.observed_optimizer_mismatch_joint_null
