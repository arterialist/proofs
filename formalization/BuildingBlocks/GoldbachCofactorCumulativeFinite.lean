import BuildingBlocks.GoldbachCofactorSuccessorFinite
import BuildingBlocks.CoarsePrimeBounds
import Mathlib.Tactic

/-!
# Exact cumulative signed Goldbach cofactor

The finite triangle can be summed in either order.  This keeps the
complementary leg at least two and the complete von Mangoldt prefix.
-/

namespace BuildingBlocks.GoldbachCofactorCumulativeFinite

open Finset Classical
open scoped BigOperators
open BuildingBlocks.GoldbachCofactorSuccessorFinite

noncomputable section

abbrev Λ (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n
abbrev ψ (n : ℕ) : ℝ := BuildingBlocks.CoarsePrimitive.psi n

private theorem psi_two : ψ 2 = Λ 2 := by
  simp [ψ, BuildingBlocks.CoarsePrimitive.psi, Λ, Finset.sum_range_succ]

/-- Reverse the finite complementary horizon, retaining both legs at least two. -/
theorem cofactorConvolution_reverse (s : ℕ) (hs : 4 ≤ s) :
    cofactorConvolution s =
      ∑ y ∈ Icc 2 (s - 2), ratioError y * Λ (s - y) := by
  unfold cofactorConvolution
  apply Finset.sum_bij (fun m _ => s - m)
  · intro m hm
    simp only [mem_Icc] at hm ⊢
    omega
  · intro m hm n hn hmn
    simp only [mem_Icc] at hm hn
    omega
  · intro y hy
    simp only [mem_Icc] at hy
    refine ⟨s - y, ?_, ?_⟩
    · simp only [mem_Icc]
      omega
    · omega
  · intro m hm
    have hm' : m ≤ s := by
      simp only [mem_Icc] at hm
      omega
    rw [Nat.sub_sub_self hm']
    ring

/-- Summing the actual cofactor over totals gives the centered
complementary source against the complete prime-power prefix. -/
theorem cumulative_cofactor_shift (k : ℕ) :
    (∑ s ∈ Icc 4 (k + 3), cofactorConvolution s) =
      ∑ y ∈ Icc 2 (k + 1), ratioError y * ψ (k + 3 - y) := by
  induction k with
  | zero => simp
  | succ k ih =>
      have hleft : k + 1 + 3 = (k + 3) + 1 := by omega
      have hright : k + 1 + 1 = (k + 1) + 1 := by omega
      rw [hleft, Finset.sum_Icc_succ_top (by omega : 4 ≤ (k + 3) + 1)]
      rw [hright, Finset.sum_Icc_succ_top (by omega : 2 ≤ (k + 1) + 1)]
      rw [ih]
      have hnew :
          cofactorConvolution (k + 3 + 1) =
            (∑ y ∈ Icc 2 (k + 1), ratioError y * Λ (k + 4 - y)) +
              ratioError (k + 2) * Λ 2 := by
        rw [cofactorConvolution_reverse _ (by omega)]
        have htop : k + 3 + 1 - 2 = (k + 1) + 1 := by omega
        rw [htop, Finset.sum_Icc_succ_top (by omega : 2 ≤ (k + 1) + 1)]
        have hlast : k + 3 + 1 - (k + 1 + 1) = 2 := by omega
        rw [hlast]
      have hstep :
          (∑ y ∈ Icc 2 (k + 1), ratioError y * ψ (k + 3 - y)) +
            (∑ y ∈ Icc 2 (k + 1), ratioError y * Λ (k + 4 - y)) =
          ∑ y ∈ Icc 2 (k + 1), ratioError y * ψ (k + 4 - y) := by
        rw [← Finset.sum_add_distrib]
        apply Finset.sum_congr rfl
        intro y hy
        have hy' : y ≤ k + 1 := (mem_Icc.mp hy).2
        have harg : k + 4 - y = (k + 3 - y) + 1 := by omega
        dsimp only [ψ]
        rw [harg, BuildingBlocks.CoarsePrimitive.psi_succ]
        ring
      rw [hnew]
      have hend : k + 1 + 3 - (k + 1 + 1) = 2 := by omega
      rw [hend, psi_two]
      calc
        (∑ y ∈ Icc 2 (k + 1), ratioError y * ψ (k + 3 - y)) +
          ((∑ y ∈ Icc 2 (k + 1), ratioError y * Λ (k + 4 - y)) +
            ratioError (k + 2) * Λ 2) =
          (∑ y ∈ Icc 2 (k + 1), ratioError y * ψ (k + 4 - y)) +
            ratioError (k + 2) * Λ 2 := by rw [← hstep]; ring
        _ = _ := by ring

/-- The literal signed cofactor accumulated through an integer cutoff.
The terminal two-leg endpoint is included in the complete prime prefix. -/
theorem signedCofactorError_cumulative (X : ℕ) (hX : 3 ≤ X) :
    (∑ s ∈ Icc 4 X,
      BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError s) =
      ∑ y ∈ Icc 2 (X - 2), ratioError y * ψ (X - y) := by
  have hXeq : X - 3 + 3 = X := by omega
  have htop : X - 3 + 1 = X - 2 := by omega
  calc
    (∑ s ∈ Icc 4 X,
      BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError s) =
        ∑ s ∈ Icc 4 X, cofactorConvolution s := by
          apply Finset.sum_congr rfl
          intro s hs
          exact (cofactorConvolution_eq_signed s).symm
    _ = ∑ y ∈ Icc 2 (X - 2), ratioError y * ψ (X - y) := by
      simpa only [hXeq, htop] using cumulative_cofactor_shift (X - 3)

#print axioms cofactorConvolution_reverse
#print axioms cumulative_cofactor_shift
#print axioms signedCofactorError_cumulative

end
end BuildingBlocks.GoldbachCofactorCumulativeFinite
