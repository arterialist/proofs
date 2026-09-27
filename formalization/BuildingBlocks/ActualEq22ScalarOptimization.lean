import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic

/-! The finite-dimensional optimization behind the Vinogradov–Korobov
exponent in the actual Eq22 contour estimate. This module proves only a
scalar inequality, not the analytic contour estimate or its asymptotics. -/

namespace BuildingBlocks.ActualEq22ScalarOptimization

/-- Sharp polynomial form of the minimization after writing `u=v³`.
The optimizer relation `2a=3ks⁵` is an algebraic parameter choice,
not an analytic error-bound hypothesis. -/
theorem scalar_cost_ge_at_optimizer {a k v s : ℝ}
    (hk : 0 < k) (hv : 0 < v) (hs : 0 < s)
    (hopt : 2 * a = 3 * k * s ^ 5) :
    (5 / 2 : ℝ) * k * s ^ 3 ≤ a / v ^ 2 + k * v ^ 3 := by
  have hfactor :
      0 ≤ (v - s) ^ 2 *
        (2 * v ^ 3 + 4 * v ^ 2 * s + 6 * v * s ^ 2 + 3 * s ^ 3) := by
    apply mul_nonneg (sq_nonneg _)
    positivity
  have hv2 : 0 < 2 * v ^ 2 := by positivity
  have hid :
      (2 * v ^ 2) * (a / v ^ 2 + k * v ^ 3 - (5 / 2 : ℝ) * k * s ^ 3) =
        k * (v - s) ^ 2 *
          (2 * v ^ 3 + 4 * v ^ 2 * s + 6 * v * s ^ 2 + 3 * s ^ 3) := by
    have hv0 : v ≠ 0 := hv.ne'
    field_simp
    nlinarith [hopt]
  have hnon :
      0 ≤ (2 * v ^ 2) *
        (a / v ^ 2 + k * v ^ 3 - (5 / 2 : ℝ) * k * s ^ 3) := by
    rw [hid]
    calc
      0 ≤ k * ((v - s) ^ 2 *
          (2 * v ^ 3 + 4 * v ^ 2 * s + 6 * v * s ^ 2 + 3 * s ^ 3)) :=
            mul_nonneg hk.le hfactor
      _ = _ := by ring
  have hsub :
      0 ≤ a / v ^ 2 + k * v ^ 3 - (5 / 2 : ℝ) * k * s ^ 3 :=
    nonneg_of_mul_nonneg_left (by simpa [mul_comm] using hnon) hv2
  linarith

/-- The chosen point actually attains the preceding lower bound. -/
theorem scalar_cost_at_optimizer {a k s : ℝ} (hs : 0 < s)
    (hopt : 2 * a = 3 * k * s ^ 5) :
    a / s ^ 2 + k * s ^ 3 = (5 / 2 : ℝ) * k * s ^ 3 := by
  have hs0 : s ≠ 0 := hs.ne'
  field_simp
  nlinarith [hopt]

/-- Exact sharp lower bound for `a u^(-2/3) + k u`.  The optimizer is
`u=s³`, where `2a=3ks⁵`; equality at this value follows below. -/
theorem scalar_rpow_cost_ge {a k u s : ℝ}
    (hk : 0 < k) (hu : 0 < u) (hs : 0 < s)
    (hopt : 2 * a = 3 * k * s ^ 5) :
    (5 / 2 : ℝ) * k * s ^ 3 ≤
      a * u ^ (-(2 / 3 : ℝ)) + k * u := by
  let v : ℝ := u ^ ((1 : ℝ) / 3)
  have hv : 0 < v := Real.rpow_pos_of_pos hu _
  have hv3 : v ^ 3 = u := by
    dsimp [v]
    rw [← Real.rpow_natCast (u ^ ((1 : ℝ) / 3)) 3,
      ← Real.rpow_mul hu.le]
    norm_num
  have hv2 : v ^ 2 = u ^ ((2 : ℝ) / 3) := by
    dsimp [v]
    rw [← Real.rpow_natCast (u ^ ((1 : ℝ) / 3)) 2,
      ← Real.rpow_mul hu.le]
    norm_num
  have hpow : u ^ (-(2 / 3 : ℝ)) = (v ^ 2)⁻¹ := by
    rw [Real.rpow_neg hu.le, ← hv2]
  calc
    _ ≤ a / v ^ 2 + k * v ^ 3 :=
      scalar_cost_ge_at_optimizer hk hv hs hopt
    _ = a * u ^ (-(2 / 3 : ℝ)) + k * u := by
      rw [hpow, ← hv3]
      ring

theorem scalar_rpow_cost_at_optimizer {a k s : ℝ} (hs : 0 < s)
    (hopt : 2 * a = 3 * k * s ^ 5) :
    a * (s ^ 3) ^ (-(2 / 3 : ℝ)) + k * s ^ 3 =
      (5 / 2 : ℝ) * k * s ^ 3 := by
  have hs2 : 0 < s ^ 2 := pow_pos hs 2
  have hpow : (s ^ 3) ^ (-(2 / 3 : ℝ)) = (s ^ 2)⁻¹ := by
    rw [Real.rpow_neg (pow_nonneg hs.le _)]
    rw [← Real.rpow_natCast s 3, ← Real.rpow_mul hs.le]
    norm_num
  rw [hpow]
  simpa [div_eq_mul_inv] using scalar_cost_at_optimizer hs hopt

/-- Explicit positive optimizer for a positive scalar cost. -/
noncomputable def optimizerRoot (a k : ℝ) : ℝ :=
  (2 * a / (3 * k)) ^ ((1 : ℝ) / 5)

theorem optimizerRoot_pos {a k : ℝ} (ha : 0 < a) (hk : 0 < k) :
    0 < optimizerRoot a k := by
  unfold optimizerRoot
  apply Real.rpow_pos_of_pos
  positivity

theorem optimizerRoot_pow_five {a k : ℝ} (ha : 0 < a) (hk : 0 < k) :
    optimizerRoot a k ^ 5 = 2 * a / (3 * k) := by
  have hbase : 0 ≤ 2 * a / (3 * k) := by positivity
  unfold optimizerRoot
  rw [← Real.rpow_natCast _ 5, ← Real.rpow_mul hbase]
  norm_num

theorem optimizerRoot_relation {a k : ℝ} (ha : 0 < a) (hk : 0 < k) :
    2 * a = 3 * k * optimizerRoot a k ^ 5 := by
  rw [optimizerRoot_pow_five ha hk]
  field_simp

/-- The global minimum is reached at `u=(optimizerRoot a k)^3`. -/
theorem scalar_rpow_global_minimum {a k u : ℝ}
    (ha : 0 < a) (hk : 0 < k) (hu : 0 < u) :
    (5 / 2 : ℝ) * k * optimizerRoot a k ^ 3 ≤
      a * u ^ (-(2 / 3 : ℝ)) + k * u :=
  scalar_rpow_cost_ge hk hu (optimizerRoot_pos ha hk)
    (optimizerRoot_relation ha hk)

theorem scalar_rpow_global_minimum_attained {a k : ℝ}
    (ha : 0 < a) (hk : 0 < k) :
    a * (optimizerRoot a k ^ 3) ^ (-(2 / 3 : ℝ)) +
      k * optimizerRoot a k ^ 3 =
        (5 / 2 : ℝ) * k * optimizerRoot a k ^ 3 :=
  scalar_rpow_cost_at_optimizer (optimizerRoot_pos ha hk)
    (optimizerRoot_relation ha hk)

/-- Exact fifth-power form of the scalar minimum. -/
theorem scalar_minimum_pow_five {a k : ℝ}
    (ha : 0 < a) (hk : 0 < k) :
    ((5 / 2 : ℝ) * k * optimizerRoot a k ^ 3) ^ 5 =
      (5 ^ 5 * a ^ 3 * k ^ 2) / (2 ^ 2 * 3 ^ 3) := by
  have hs := optimizerRoot_pow_five ha hk
  have hk0 : k ≠ 0 := hk.ne'
  calc
    ((5 / 2 : ℝ) * k * optimizerRoot a k ^ 3) ^ 5 =
      (5 ^ 5 / 2 ^ 5) * k ^ 5 * (optimizerRoot a k ^ 5) ^ 3 := by ring
    _ = (5 ^ 5 * a ^ 3 * k ^ 2) / (2 ^ 2 * 3 ^ 3) := by
      rw [hs]
      field_simp

/-- The Bellotti/Vinogradov–Korobov optimization constant as stated in the
Eq22 note. `A₀` is a positive zero-free-region coefficient. -/
noncomputable def dConstant (A₀ : ℝ) : ℝ :=
  (((5 : ℝ) ^ 6 * A₀ ^ 3) / (2 ^ 2 * 3 ^ 4)) ^ ((1 : ℝ) / 5)

/-- The near-cluster Eq22 constant, conditional only in the *analytic*
application; this definition and the following scalar laws are algebraic. -/
noncomputable def cMConstant (A₀ : ℝ) : ℝ :=
  (2 : ℝ) ^ ((2 : ℝ) / 5) * dConstant A₀

theorem dConstant_pow_five {A₀ : ℝ} (hA : 0 ≤ A₀) :
    dConstant A₀ ^ 5 =
      ((5 : ℝ) ^ 6 * A₀ ^ 3) / (2 ^ 2 * 3 ^ 4) := by
  have hbase :
      0 ≤ ((5 : ℝ) ^ 6 * A₀ ^ 3) / (2 ^ 2 * 3 ^ 4) := by
    positivity
  unfold dConstant
  rw [← Real.rpow_natCast _ 5, ← Real.rpow_mul hbase]
  norm_num

theorem cMConstant_pow_five (A₀ : ℝ) :
    cMConstant A₀ ^ 5 = 4 * dConstant A₀ ^ 5 := by
  unfold cMConstant
  rw [mul_pow]
  have htwo : ((2 : ℝ) ^ ((2 : ℝ) / 5)) ^ 5 = 4 := by
    rw [← Real.rpow_natCast _ 5, ← Real.rpow_mul (by norm_num : (0 : ℝ) ≤ 2)]
    norm_num
  rw [htwo]

theorem cMConstant_gt_dConstant {A₀ : ℝ} (hA : 0 < A₀) :
    dConstant A₀ < cMConstant A₀ := by
  have hd : 0 < dConstant A₀ := by
    unfold dConstant
    apply Real.rpow_pos_of_pos
    positivity
  have htwo : (1 : ℝ) < 2 ^ ((2 : ℝ) / 5) :=
    Real.one_lt_rpow (by norm_num) (by norm_num)
  unfold cMConstant
  nlinarith [mul_lt_mul_of_pos_right htwo hd]

/-- Freezing the asymptotic `loglog T / loglog x → 3/5` produces this
coefficient in the leading scalar cost. This definition does not prove
that asymptotic replacement. -/
noncomputable def effectiveCoefficient (A₀ : ℝ) : ℝ :=
  A₀ * ((5 : ℝ) / 3) ^ ((1 : ℝ) / 3)

theorem effectiveCoefficient_pos {A₀ : ℝ} (hA : 0 < A₀) :
    0 < effectiveCoefficient A₀ := by
  unfold effectiveCoefficient
  positivity

theorem effectiveCoefficient_cube (A₀ : ℝ) :
    effectiveCoefficient A₀ ^ 3 = A₀ ^ 3 * (5 / 3 : ℝ) := by
  unfold effectiveCoefficient
  rw [mul_pow]
  have hpow : (((5 : ℝ) / 3) ^ ((1 : ℝ) / 3)) ^ 3 = 5 / 3 := by
    rw [← Real.rpow_natCast _ 3,
      ← Real.rpow_mul (by norm_num : (0 : ℝ) ≤ 5 / 3)]
    norm_num
  rw [hpow]

/-- The near-cluster choice `(a,k)=(1,2)` has exactly the published
`c_M` fifth power after the explicit effective-coefficient substitution. -/
theorem near_scalar_minimum_pow_five {A₀ : ℝ} (hA : 0 < A₀) :
    ((5 / 2 : ℝ) * 2 * optimizerRoot (effectiveCoefficient A₀) 2 ^ 3) ^ 5 =
      cMConstant A₀ ^ 5 := by
  rw [scalar_minimum_pow_five (effectiveCoefficient_pos hA)
        (by norm_num : (0 : ℝ) < 2)]
  rw [effectiveCoefficient_cube, cMConstant_pow_five,
      dConstant_pow_five hA.le]
  ring

theorem near_scalar_minimum_eq_cM {A₀ : ℝ} (hA : 0 < A₀) :
    (5 / 2 : ℝ) * 2 * optimizerRoot (effectiveCoefficient A₀) 2 ^ 3 =
      cMConstant A₀ := by
  have hroot : 0 < optimizerRoot (effectiveCoefficient A₀) 2 :=
    optimizerRoot_pos (effectiveCoefficient_pos hA) (by norm_num)
  have hm : 0 < (5 / 2 : ℝ) * 2 *
      optimizerRoot (effectiveCoefficient A₀) 2 ^ 3 := by positivity
  have hd : 0 < dConstant A₀ := by
    unfold dConstant
    apply Real.rpow_pos_of_pos
    positivity
  have hc : 0 < cMConstant A₀ := by
    unfold cMConstant
    exact mul_pos (Real.rpow_pos_of_pos (by norm_num) _) hd
  exact (pow_left_inj₀ hm.le hc.le (by norm_num : (5 : ℕ) ≠ 0)).mp
    (near_scalar_minimum_pow_five hA)

/-- Exact near-cluster scalar optimization. The analytic argument still
must justify replacing its `loglog T` denominator by the effective
coefficient and control the contour errors. -/
theorem cM_le_near_scalar_cost {A₀ u : ℝ}
    (hA : 0 < A₀) (hu : 0 < u) :
    cMConstant A₀ ≤
      effectiveCoefficient A₀ * u ^ (-(2 / 3 : ℝ)) + 2 * u := by
  rw [← near_scalar_minimum_eq_cM hA]
  exact scalar_rpow_global_minimum (effectiveCoefficient_pos hA)
    (by norm_num) hu

theorem cM_near_scalar_cost_attained {A₀ : ℝ} (hA : 0 < A₀) :
    effectiveCoefficient A₀ *
        (optimizerRoot (effectiveCoefficient A₀) 2 ^ 3) ^ (-(2 / 3 : ℝ)) +
      2 * optimizerRoot (effectiveCoefficient A₀) 2 ^ 3 =
      cMConstant A₀ := by
  rw [scalar_rpow_global_minimum_attained (effectiveCoefficient_pos hA)
      (by norm_num : (0 : ℝ) < 2)]
  exact near_scalar_minimum_eq_cM hA

/-- The other cluster exponent, from `(a,k)=(2,1)` in the Eq22 note. -/
noncomputable def farConstant (A₀ : ℝ) : ℝ :=
  (2 : ℝ) ^ ((3 : ℝ) / 5) * dConstant A₀

theorem farConstant_pow_five (A₀ : ℝ) :
    farConstant A₀ ^ 5 = 8 * dConstant A₀ ^ 5 := by
  unfold farConstant
  rw [mul_pow]
  have htwo : ((2 : ℝ) ^ ((3 : ℝ) / 5)) ^ 5 = 8 := by
    rw [← Real.rpow_natCast _ 5, ← Real.rpow_mul (by norm_num : (0 : ℝ) ≤ 2)]
    norm_num
  rw [htwo]

theorem far_scalar_minimum_pow_five {A₀ : ℝ} (hA : 0 < A₀) :
    ((5 / 2 : ℝ) * optimizerRoot (2 * effectiveCoefficient A₀) 1 ^ 3) ^ 5 =
      farConstant A₀ ^ 5 := by
  have hmin :
      ((5 / 2 : ℝ) * optimizerRoot (2 * effectiveCoefficient A₀) 1 ^ 3) ^ 5 =
        (5 ^ 5 * (2 * effectiveCoefficient A₀) ^ 3) / (2 ^ 2 * 3 ^ 3) := by
    simpa only [mul_one, one_pow] using
      (scalar_minimum_pow_five
        (mul_pos (by norm_num : (0 : ℝ) < 2) (effectiveCoefficient_pos hA))
        (by norm_num : (0 : ℝ) < 1))
  rw [hmin]
  rw [farConstant_pow_five, dConstant_pow_five hA.le]
  rw [show (2 * effectiveCoefficient A₀) ^ 3 =
      8 * effectiveCoefficient A₀ ^ 3 by ring]
  rw [effectiveCoefficient_cube]
  ring

theorem farConstant_gt_cMConstant {A₀ : ℝ} (hA : 0 < A₀) :
    cMConstant A₀ < farConstant A₀ := by
  have hd : 0 < dConstant A₀ := by
    unfold dConstant
    apply Real.rpow_pos_of_pos
    positivity
  have hp : (2 : ℝ) ^ ((2 : ℝ) / 5) <
      2 ^ ((3 : ℝ) / 5) :=
    Real.rpow_lt_rpow_of_exponent_lt (by norm_num) (by norm_num)
  unfold cMConstant farConstant
  exact mul_lt_mul_of_pos_right hp hd

#print axioms scalar_cost_ge_at_optimizer
#print axioms scalar_cost_at_optimizer
#print axioms scalar_rpow_cost_ge
#print axioms scalar_rpow_cost_at_optimizer
#print axioms scalar_rpow_global_minimum
#print axioms scalar_rpow_global_minimum_attained
#print axioms scalar_minimum_pow_five
#print axioms dConstant_pow_five
#print axioms cMConstant_pow_five
#print axioms cMConstant_gt_dConstant
#print axioms near_scalar_minimum_pow_five
#print axioms near_scalar_minimum_eq_cM
#print axioms cM_le_near_scalar_cost
#print axioms cM_near_scalar_cost_attained
#print axioms far_scalar_minimum_pow_five
#print axioms farConstant_gt_cMConstant

end BuildingBlocks.ActualEq22ScalarOptimization
