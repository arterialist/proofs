import BuildingBlocks.GoldbachCofactorCumulativeFinite
import Mathlib.Tactic

/-!
# The exact linearized cofactor and centered prime-pair remainder

No prime-power leg or endpoint is removed. The linearized term has
an unconditional smoothed explicit formula; the centered pair term
is the still-open pointwise cancellation problem.
-/

namespace BuildingBlocks.GoldbachCofactorLinearSplitFinite

open Finset Classical
open scoped BigOperators
open BuildingBlocks.GoldbachCofactorSuccessorFinite

noncomputable section

abbrev Λ (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n

def linearizedCofactor (s : ℕ) : ℝ :=
  ∑ y ∈ Icc 2 (s - 2), ratioError y

def centeredPairRemainder (s : ℕ) : ℝ :=
  ∑ y ∈ Icc 2 (s - 2), ratioError y * (Λ (s - y) - 1)

/-- Pointwise linear-plus-centered split of the actual cofactor. -/
theorem cofactorConvolution_split (s : ℕ) (hs : 4 ≤ s) :
    cofactorConvolution s =
      linearizedCofactor s + centeredPairRemainder s := by
  rw [BuildingBlocks.GoldbachCofactorCumulativeFinite.cofactorConvolution_reverse s hs]
  unfold linearizedCofactor centeredPairRemainder
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro y hy
  ring

/-- The same split for the literal signed error term used in the
Goldbach successor logarithm. -/
theorem signedCofactorError_split (s : ℕ) (hs : 4 ≤ s) :
    BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError s =
      linearizedCofactor s + centeredPairRemainder s := by
  rw [← cofactorConvolution_eq_signed]
  exact cofactorConvolution_split s hs

#print axioms cofactorConvolution_split
#print axioms signedCofactorError_split

end
end BuildingBlocks.GoldbachCofactorLinearSplitFinite
