import Mathlib.Tactic
import Mathlib.NumberTheory.ArithmeticFunction

/-!
# Finite full-energy cancellation in the admission boundary layer

This module proves the exact weighted quadratic algebra.  Analytic profile
limits and RH-scale estimates remain external statements.
-/

namespace BuildingBlocks.FullBoundaryEnergyFinite

open scoped BigOperators

noncomputable section

/-- Exact finite expansion of endpoint, nonendpoint, and residual packets. -/
theorem weighted_full_energy_expansion
    (S : Finset ℕ) (w K F R : ℕ → ℝ) :
    (∑ j ∈ S, w j * (K j - F j + R j) ^ 2) =
      (∑ j ∈ S, w j * (K j - F j) ^ 2) +
      2 * (∑ j ∈ S, w j * (K j - F j) * R j) +
      ∑ j ∈ S, w j * (R j) ^ 2 := by
  rw [Finset.mul_sum, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro j hj
  ring

/-- The explicit background separates into endpoint, fixed-profile, and the
factor-four cross after applying the sampled-measure factor two. -/
theorem doubled_background_identity (Knorm Fnorm cross : ℝ) :
    2 * (Knorm + Fnorm - 2 * cross) =
      2 * Knorm + 2 * Fnorm - 4 * cross := by ring

/-- Exact cancellation when the coherent endpoint and nonendpoint profiles
agree pointwise on the finite packet. -/
theorem coherent_plateau_cancel
    (S : Finset ℕ) (w K F R : ℕ → ℝ)
    (hKF : ∀ j ∈ S, K j = F j) :
    (∑ j ∈ S, w j * (K j - F j + R j) ^ 2) =
      ∑ j ∈ S, w j * (R j) ^ 2 := by
  apply Finset.sum_congr rfl
  intro j hj
  rw [hKF j hj]
  ring

/-- The density correction to the full profile has the positive endpoint
cross and negative nonendpoint cross with the exact factor four. -/
theorem density_cross_decomposition (KJ FJ : ℝ) (L : ℝ) :
    (4 / L) * (KJ - FJ) = (4 / L) * KJ - (4 / L) * FJ := by ring

/-- A scalar energy difference cannot recover the residual quadratic without
control of the linear cross. -/
theorem residual_from_energy_and_cross
    (full background cross residual : ℝ)
    (h : full = background + 2 * cross + residual) :
    residual = full - background - 2 * cross := by
  rw [h]
  ring

/-- Actual prime powers of exponent at least two have zero Möbius coefficient;
they remain present only as zero coefficients in full admission. -/
theorem nonsquarefree_full_admission_zero {n : ℕ} (hn : ¬ Squarefree n) :
    ArithmeticFunction.moebius n = 0 := by
  exact ArithmeticFunction.moebius_eq_zero_of_not_squarefree hn

/-- Pure scaling identity used to state the original-consumer RH rate. -/
theorem normalized_energy_rate_identity (V X logX : ℝ) :
    (logX ^ 2 / X ^ 2) * V = logX ^ 2 * V / X ^ 2 := by ring


end
end BuildingBlocks.FullBoundaryEnergyFinite

#print axioms BuildingBlocks.FullBoundaryEnergyFinite.weighted_full_energy_expansion
#print axioms BuildingBlocks.FullBoundaryEnergyFinite.doubled_background_identity
#print axioms BuildingBlocks.FullBoundaryEnergyFinite.coherent_plateau_cancel
#print axioms BuildingBlocks.FullBoundaryEnergyFinite.density_cross_decomposition
#print axioms BuildingBlocks.FullBoundaryEnergyFinite.residual_from_energy_and_cross
#print axioms BuildingBlocks.FullBoundaryEnergyFinite.nonsquarefree_full_admission_zero
#print axioms BuildingBlocks.FullBoundaryEnergyFinite.normalized_energy_rate_identity
