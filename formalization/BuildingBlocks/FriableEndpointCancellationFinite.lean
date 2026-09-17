import Mathlib.Tactic
import Mathlib.NumberTheory.ArithmeticFunction
import BuildingBlocks.SimultaneousAdmissionEndpointFinite

/-!
# Finite cancellation algebra for the friable endpoint

The analytic Mertens and PNT estimates are not asserted here.  These exact
finite identities isolate the constant Mellin mode which must be cancelled
before applying absolute values.
-/

namespace BuildingBlocks.FriableEndpointCancellationFinite

open scoped BigOperators

noncomputable section

/-- Extract a constant mode from an actual finite Möbius-weighted sum. -/
theorem mobius_constant_mode_extraction
    (S : Finset ℕ) (h : ℕ → ℝ) (c : ℝ) :
    (∑ n ∈ S, (ArithmeticFunction.moebius n : ℝ) * h n) =
      c * (∑ n ∈ S, (ArithmeticFunction.moebius n : ℝ)) +
        ∑ n ∈ S, (ArithmeticFunction.moebius n : ℝ) * (h n - c) := by
  rw [Finset.mul_sum, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  ring

/-- If the finite Möbius packet has zero scalar mean, only variation of the
weight remains.  This is the finite algebra behind the second Abel step. -/
theorem mobius_constant_mode_cancel
    (S : Finset ℕ) (h : ℕ → ℝ) (c : ℝ)
    (hzero : (∑ n ∈ S, (ArithmeticFunction.moebius n : ℝ)) = 0) :
    (∑ n ∈ S, (ArithmeticFunction.moebius n : ℝ) * h n) =
      ∑ n ∈ S, (ArithmeticFunction.moebius n : ℝ) * (h n - c) := by
  rw [mobius_constant_mode_extraction S h c, hzero]
  simp

/-- Exact finite dyadic split.  Squaring separate block bounds would discard
the cross term displayed here. -/
theorem square_two_blocks (a b : ℝ) :
    (a + b) ^ 2 = a ^ 2 + 2 * a * b + b ^ 2 := by ring

/-- Exact split of a finite endpoint energy at an integer index. -/
theorem endpoint_energy_split
    (w E : ℕ → ℝ) {J N : ℕ} (hJN : J ≤ N) :
    (∑ j ∈ Finset.range N, w j * (E j) ^ 2) =
      (∑ j ∈ Finset.range J, w j * (E j) ^ 2) +
        ∑ j ∈ Finset.Ico J N, w j * (E j) ^ 2 := by
  exact (Finset.sum_range_add_sum_Ico (fun j => w j * (E j) ^ 2) hJN).symm

/-- The literal one-face endpoint geometry used by the consumer. -/
theorem literal_endpoint_face_geometry (d : ℕ) (q : ℝ) :
    BuildingBlocks.SimultaneousAdmissionEndpointFinite.endpointNormSq d q =
      q ^ d - q ^ (2 * d) := by
  exact BuildingBlocks.SimultaneousAdmissionEndpointFinite.endpointNormSq_eq d q

/-- Absolute-value propagation after, rather than before, constant-mode
extraction. -/
theorem extracted_mode_abs_le
    (S : Finset ℕ) (h : ℕ → ℝ) (c B : ℝ)
    (hmu : |∑ n ∈ S, (ArithmeticFunction.moebius n : ℝ)| ≤ B) :
    |∑ n ∈ S, (ArithmeticFunction.moebius n : ℝ) * h n| ≤
      |c| * B + ∑ n ∈ S, |h n - c| := by
  rw [mobius_constant_mode_extraction S h c]
  calc
    |c * (∑ n ∈ S, (ArithmeticFunction.moebius n : ℝ)) +
        ∑ n ∈ S, (ArithmeticFunction.moebius n : ℝ) * (h n - c)| ≤
        |c * (∑ n ∈ S, (ArithmeticFunction.moebius n : ℝ))| +
          |∑ n ∈ S, (ArithmeticFunction.moebius n : ℝ) * (h n - c)| :=
      abs_add_le _ _
    _ ≤ |c| * B + ∑ n ∈ S, |h n - c| := by
      apply add_le_add
      · rw [abs_mul]
        exact mul_le_mul_of_nonneg_left hmu (abs_nonneg c)
      · calc
          |∑ n ∈ S, (ArithmeticFunction.moebius n : ℝ) * (h n - c)| ≤
              ∑ n ∈ S, |(ArithmeticFunction.moebius n : ℝ) * (h n - c)| :=
            Finset.abs_sum_le_sum_abs _ _
          _ ≤ ∑ n ∈ S, |h n - c| := by
            apply Finset.sum_le_sum
            intro n hn
            rw [abs_mul]
            exact mul_le_of_le_one_left (abs_nonneg _) <| by
              exact_mod_cast ArithmeticFunction.abs_moebius_le_one (n := n)

end
end BuildingBlocks.FriableEndpointCancellationFinite

#print axioms BuildingBlocks.FriableEndpointCancellationFinite.mobius_constant_mode_extraction
#print axioms BuildingBlocks.FriableEndpointCancellationFinite.mobius_constant_mode_cancel
#print axioms BuildingBlocks.FriableEndpointCancellationFinite.square_two_blocks
#print axioms BuildingBlocks.FriableEndpointCancellationFinite.endpoint_energy_split
#print axioms BuildingBlocks.FriableEndpointCancellationFinite.literal_endpoint_face_geometry
#print axioms BuildingBlocks.FriableEndpointCancellationFinite.extracted_mode_abs_le
