import Mathlib.Tactic
import Mathlib.NumberTheory.ArithmeticFunction

/-!
# Finite first-branch collapse for mixed endpoint terms

The identities are algebraic.  Analytic estimates for the horizon-dependent
row scalar and for the post-branch residual remain external.
-/

namespace BuildingBlocks.MixedEndpointFirstBranchFinite

open scoped BigOperators

noncomputable section

/-- A zero-mass packet converts `1-z` into the negative Abel polynomial. -/
theorem zero_mass_one_sub_collapse
    (S : Finset ℕ) (c z : ℕ → ℝ)
    (hzero : (∑ n ∈ S, c n) = 0) :
    (∑ n ∈ S, c n * (1 - z n)) = -∑ n ∈ S, c n * z n := by
  calc
    (∑ n ∈ S, c n * (1 - z n)) =
        ∑ n ∈ S, (c n - c n * z n) := by
          apply Finset.sum_congr rfl
          intro n hn
          ring
    _ = (∑ n ∈ S, c n) - ∑ n ∈ S, c n * z n := by
      rw [Finset.sum_sub_distrib]
    _ = -∑ n ∈ S, c n * z n := by rw [hzero]; ring

/-- The prime-face endpoint polynomial is old minus its prime dilation. -/
theorem admitted_endpoint_polynomial
    (D : Finset ℕ) (c z : ℕ → ℝ) (p : ℕ) :
    (∑ e ∈ D, c e * z e) - (∑ e ∈ D, c e * z (p * e)) =
      ∑ e ∈ D, c e * (z e - z (p * e)) := by
  rw [← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro e he
  ring

/-- Exact mixed collapse once the admitted nonendpoint row is a common
first-branch scalar on the whole endpoint support. -/
theorem mixed_first_branch_collapse
    (oldPoly dilatedPoly rowScalar scale : ℝ) :
    2 * rowScalar * scale * (dilatedPoly - oldPoly) =
      -2 * rowScalar * scale * (oldPoly - dilatedPoly) := by
  ring

/-- The first derivative moment of the prime-dilated Abel difference. -/
theorem prime_dilation_first_moment
    (D : Finset ℕ) (c : ℕ → ℝ) (p : ℕ) :
    (∑ e ∈ D, c e * ((p * e : ℕ) : ℝ)) -
        (∑ e ∈ D, c e * (e : ℝ)) =
      ((p : ℝ) - 1) * ∑ e ∈ D, c e * (e : ℝ) := by
  rw [← Finset.sum_sub_distrib, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro e he
  push_cast
  ring

/-- If `D ≤ X`, every endpoint index `n ≤ pD` lies on the first branch of
every newly admitted face `pe`, for `e ≥ 1`. -/
theorem endpoint_support_inside_first_branch
    (p D X e n : ℕ) (he : 1 ≤ e) (hn : n ≤ p * D) (hDX : D ≤ X) :
    n ≤ X * (p * e) := by
  calc
    n ≤ p * D := hn
    _ ≤ p * X := Nat.mul_le_mul_left p hDX
    _ = X * p := Nat.mul_comm _ _
    _ ≤ X * (p * e) := by
      apply Nat.mul_le_mul_left X
      simpa using Nat.mul_le_mul_left p he

/-- Exact common-mode/branch-residual split for a mixed endpoint pairing. -/
theorem mixed_branch_residual_split
    (common residual endpoint : ℝ) :
    2 * (common + residual) * endpoint =
      2 * common * endpoint + 2 * residual * endpoint := by
  ring

end
end BuildingBlocks.MixedEndpointFirstBranchFinite

#print axioms BuildingBlocks.MixedEndpointFirstBranchFinite.zero_mass_one_sub_collapse
#print axioms BuildingBlocks.MixedEndpointFirstBranchFinite.admitted_endpoint_polynomial
#print axioms BuildingBlocks.MixedEndpointFirstBranchFinite.mixed_first_branch_collapse
#print axioms BuildingBlocks.MixedEndpointFirstBranchFinite.prime_dilation_first_moment
#print axioms BuildingBlocks.MixedEndpointFirstBranchFinite.endpoint_support_inside_first_branch
#print axioms BuildingBlocks.MixedEndpointFirstBranchFinite.mixed_branch_residual_split
