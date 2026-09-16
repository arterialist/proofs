import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Tactic

namespace PaidThetaCompensation

/-! Exact finite algebra for the first two collective source columns.
All source-range and theta-form assertions remain analytic inputs. -/

/-- If two columns have actual preimages, their coherent signed
combination has the corresponding signed preimage. -/
theorem signed_source_preimage
    {V W : Type*} [AddCommGroup V] [Module ℝ V]
    [AddCommGroup W] [Module ℝ W]
    (T : V →ₗ[ℝ] W) (x₁ x₂ : V) (y₁ y₂ : W) (s : ℝ)
    (h₁ : T x₁ = y₁) (h₂ : T x₂ = y₂) :
    T (x₁ - s • x₂) = y₁ - s • y₂ := by
  simp [h₁, h₂]

/-- Any linear centering or projection preserves the coherent difference
before a norm or positive estimate is taken. -/
theorem linear_map_preserves_difference
    {V W : Type*} [AddCommGroup V] [Module ℝ V]
    [AddCommGroup W] [Module ℝ W]
    (P : V →ₗ[ℝ] W) (y₁ y₂ : V) :
    P (y₁ - y₂) = P y₁ - P y₂ := by
  simp

/-- The signed two-column contraction of a covariance matrix. -/
theorem coherent_covariance_contraction
    (A B C : ℝ) :
    A + 2 * B * (-1) + C * (-1) ^ 2 = A - 2 * B + C := by
  ring

/-- Splitting each covariance entry into mass, continuous, and complete
prime parts commutes exactly with the coherent signed contraction. -/
theorem signed_three_part_contraction
    (Am Ac Ap Bm Bc Bp Cm Cc Cp : ℝ) :
    (Am + Ac + Ap) - 2 * (Bm + Bc + Bp) + (Cm + Cc + Cp) =
      (Am - 2 * Bm + Cm) +
      (Ac - 2 * Bc + Cc) +
      (Ap - 2 * Bp + Cp) := by
  ring

/-- A Hermitian covariance evaluated on the difference is exactly the
three-entry contraction.  This prevents replacing the mixed entry by an
absolute-value bound before cancellation. -/
theorem inner_difference_identity
    {V : Type*} [SeminormedAddCommGroup V] [InnerProductSpace ℝ V]
    (x y : V) :
    ‖x - y‖ ^ 2 =
      ‖x‖ ^ 2 - 2 * inner ℝ x y + ‖y‖ ^ 2 := by
  rw [norm_sub_sq_real]

end PaidThetaCompensation
