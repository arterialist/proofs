import BuildingBlocks.PhysicalThetaSeries
import Mathlib.Analysis.SpecialFunctions.ExpDeriv

/-! Literal Gaussian summand derivatives for the actual theta parity mechanism.
No interchange of infinite sums and derivatives is assumed. -/
namespace BuildingBlocks.PhysicalThetaSeed
open Real
open BuildingBlocks.PhysicalThetaSeries

noncomputable def argument (n : ℕ) (u : ℝ) : ℝ := π * (n : ℝ) ^ 2 * exp (2 * u)
noncomputable def seed (n : ℕ) (u : ℝ) : ℝ := exp (u / 2) * exp (-argument n u)
noncomputable def slope (n : ℕ) (u : ℝ) : ℝ := (1 / 2 - 2 * argument n u) * seed n u
noncomputable def curvature (n : ℕ) (u : ℝ) : ℝ :=
  (1 / 4 - 6 * argument n u + 4 * argument n u ^ 2) * seed n u

theorem argument_hasDerivAt (n : ℕ) (u : ℝ) :
    HasDerivAt (argument n) (2 * argument n u) u := by
  have h := (((hasDerivAt_id u).const_mul (2 : ℝ)).exp).const_mul (π * (n : ℝ) ^ 2)
  convert h using 1
  dsimp [argument]
  ring

theorem seed_hasDerivAt (n : ℕ) (u : ℝ) : HasDerivAt (seed n) (slope n u) u := by
  have h1 := ((hasDerivAt_id u).div_const (2 : ℝ)).exp
  have h2 := (argument_hasDerivAt n u).neg.exp
  convert h1.mul h2 using 1
  dsimp [seed, slope]
  ring

theorem slope_hasDerivAt (n : ℕ) (u : ℝ) :
    HasDerivAt (slope n) (curvature n u) u := by
  have h1 := (hasDerivAt_const u (1 / 2 : ℝ)).sub
    ((argument_hasDerivAt n u).const_mul (2 : ℝ))
  have h2 := seed_hasDerivAt n u
  convert h1.mul h2 using 1
  dsimp [slope, curvature]
  ring

theorem seed_deriv (n : ℕ) : deriv (seed n) = slope n := by
  funext u
  exact (seed_hasDerivAt n u).deriv

theorem seed_second_deriv (n : ℕ) : deriv (deriv (seed n)) = curvature n := by
  rw [seed_deriv]
  funext u
  exact (slope_hasDerivAt n u).deriv

theorem curvature_minus_quarter_seed (n : ℕ) (u : ℝ) :
    curvature n u - seed n u / 4 = term n u := by
  have h5 : exp (5 * u / 2) = exp (u / 2) * exp (2 * u) := by
    rw [← exp_add]
    congr 1
    ring
  have h9 : exp (9 * u / 2) = exp (u / 2) * exp (2 * u) ^ 2 := by
    rw [pow_two, ← exp_add, ← exp_add]
    congr 1
    ring
  unfold curvature seed argument term
  rw [h5, h9]
  ring

theorem differential_identity (n : ℕ) (u : ℝ) :
    deriv (deriv (seed n)) u - seed n u / 4 = term n u := by
  rw [seed_second_deriv]
  exact curvature_minus_quarter_seed n u

theorem seed_abs_bound (n : ℕ) (u : ℝ) :
    |seed n u| ≤ exp (u / 2) * exp (-(π * exp (2 * u)) * n) := by
  have he : exp (-argument n u) ≤ exp (-(π * exp (2 * u)) * n) := by
    apply exp_le_exp.mpr
    have h := mul_le_mul_of_nonneg_left (nat_square_ge n)
      (show 0 ≤ π * exp (2 * u) by positivity)
    dsimp [argument]
    nlinarith
  unfold seed
  rw [abs_of_nonneg (mul_nonneg (exp_nonneg _) (exp_nonneg _))]
  exact mul_le_mul_of_nonneg_left he (exp_nonneg _)

theorem seed_summable (u : ℝ) : Summable (fun n => seed n u) := by
  have h : Summable (fun n : ℕ => exp (-(π * exp (2 * u)) * n)) := by
    simpa using summable_pow_mul_exp_neg_nat_mul 0
      (show 0 < π * exp (2 * u) by positivity)
  apply (h.mul_left (exp (u / 2))).of_norm_bounded
  intro n
  simpa only [Real.norm_eq_abs] using seed_abs_bound n u

theorem curvature_summable (u : ℝ) : Summable (fun n => curvature n u) := by
  apply ((term_summable u).add ((seed_summable u).div_const 4)).congr
  intro n
  linarith [curvature_minus_quarter_seed n u]

theorem curvature_tsum_minus_quarter_seed (u : ℝ) :
    (∑' n : ℕ, curvature n u) - (∑' n : ℕ, seed n u) / 4 = phi u := by
  have h := (curvature_summable u).tsum_sub ((seed_summable u).div_const 4)
  rw [tsum_div_const] at h
  rw [← h]
  exact tsum_congr (fun n => curvature_minus_quarter_seed n u)

#print axioms argument_hasDerivAt
#print axioms seed_hasDerivAt
#print axioms slope_hasDerivAt
#print axioms seed_deriv
#print axioms seed_second_deriv
#print axioms curvature_minus_quarter_seed
#print axioms differential_identity
#print axioms seed_abs_bound
#print axioms seed_summable
#print axioms curvature_summable
#print axioms curvature_tsum_minus_quarter_seed
end BuildingBlocks.PhysicalThetaSeed
