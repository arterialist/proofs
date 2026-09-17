import BuildingBlocks.GoldbachCofactorVolterraFinite
import Mathlib.Tactic

/-!
# One-step law for the signed Goldbach cofactor

The new endpoint and every centered prime-power birth remain explicit.
No estimate on the actual signed sum is assumed.
-/

namespace BuildingBlocks.GoldbachCofactorSuccessorFinite

open Finset Real Classical
open scoped BigOperators
open BuildingBlocks.GoldbachCofactorVolterraFinite

noncomputable section

abbrev Λ (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n

def ratioError (y : ℕ) : ℝ := primeError y / (y : ℝ)

def cofactorConvolution (s : ℕ) : ℝ :=
  ∑ m ∈ Icc 2 (s - 2), Λ m * ratioError (s - m)

theorem cofactorConvolution_eq_signed (s : ℕ) :
    cofactorConvolution s =
      BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError s := by
  unfold cofactorConvolution
  rw [BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError]
  apply Finset.sum_congr rfl
  intro m hm
  unfold ratioError primeError
  ring

/-- The complete integer prime error changes by the actual
von Mangoldt birth minus one. -/
theorem primeError_succ (y : ℕ) :
    primeError (y + 1) - primeError y = Λ (y + 1) - 1 := by
  unfold primeError
  rw [BuildingBlocks.CoarsePrimitive.psi_succ]
  push_cast
  ring

/-- Exact rational one-step change, including the derivative of the
cofactor denominator. -/
theorem ratioError_succ (y : ℕ) (hy : 1 ≤ y) :
    ratioError (y + 1) - ratioError y =
      (Λ (y + 1) - 1) / ((y + 1 : ℕ) : ℝ) -
        primeError y / ((y : ℝ) * ((y + 1 : ℕ) : ℝ)) := by
  have hy0 : (y : ℝ) ≠ 0 := by
    exact_mod_cast (show y ≠ 0 by omega)
  have hy10 : (((y + 1 : ℕ) : ℝ)) ≠ 0 := by positivity
  have hstep : primeError (y + 1) =
      primeError y + (Λ (y + 1) - 1) := by
    linarith [primeError_succ y]
  unfold ratioError
  rw [hstep]
  push_cast
  field_simp
  ring

/-- Advancing the additive horizon appends the pair with second leg
two, then advances each old complementary error ratio by one. -/
theorem cofactorConvolution_succ (s : ℕ) (hs : 4 ≤ s) :
    cofactorConvolution (s + 1) - cofactorConvolution s =
      Λ (s - 1) * ratioError 2 +
        ∑ m ∈ Icc 2 (s - 2),
          Λ m * (ratioError (s + 1 - m) - ratioError (s - m)) := by
  have hupper : s + 1 - 2 = (s - 2) + 1 := by omega
  have hend : (s - 2) + 1 = s - 1 := by omega
  have hsecond : s + 1 - (s - 1) = 2 := by omega
  unfold cofactorConvolution
  rw [hupper, Finset.sum_Icc_succ_top (by omega : 2 ≤ (s - 2) + 1)]
  rw [hend, hsecond]
  have hrow :
      (∑ m ∈ Icc 2 (s - 2),
        (Λ m * ratioError (s + 1 - m) - Λ m * ratioError (s - m))) =
      ∑ m ∈ Icc 2 (s - 2),
        Λ m * (ratioError (s + 1 - m) - ratioError (s - m)) := by
    apply Finset.sum_congr rfl
    intro m hm
    ring
  calc
    (∑ m ∈ Icc 2 (s - 2), Λ m * ratioError (s + 1 - m)) +
          Λ (s - 1) * ratioError 2 -
          ∑ m ∈ Icc 2 (s - 2), Λ m * ratioError (s - m) =
        Λ (s - 1) * ratioError 2 +
          ((∑ m ∈ Icc 2 (s - 2), Λ m * ratioError (s + 1 - m)) -
            ∑ m ∈ Icc 2 (s - 2), Λ m * ratioError (s - m)) := by ring
    _ = Λ (s - 1) * ratioError 2 +
          ∑ m ∈ Icc 2 (s - 2),
            (Λ m * ratioError (s + 1 - m) - Λ m * ratioError (s - m)) := by
          rw [← Finset.sum_sub_distrib]
    _ = _ := by rw [hrow]

/-- The one-step source law for the literal signed correction. -/
theorem signedCofactorError_succ (s : ℕ) (hs : 4 ≤ s) :
    BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError (s + 1) -
      BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError s =
      Λ (s - 1) * ratioError 2 +
        ∑ m ∈ Icc 2 (s - 2),
          Λ m * (ratioError (s + 1 - m) - ratioError (s - m)) := by
  rw [← cofactorConvolution_eq_signed (s + 1),
    ← cofactorConvolution_eq_signed s]
  exact cofactorConvolution_succ s hs

/-- The expanded one-step source law keeps the new two-leg endpoint,
each actual new von Mangoldt birth, and the changing denominator. -/
theorem signedCofactorError_succ_expanded (s : ℕ) (hs : 4 ≤ s) :
    BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError (s + 1) -
      BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError s =
      Λ (s - 1) * ratioError 2 +
        ∑ m ∈ Icc 2 (s - 2),
          Λ m * ((Λ (s + 1 - m) - 1) / ((s + 1 - m : ℕ) : ℝ) -
            primeError (s - m) /
              (((s - m : ℕ) : ℝ) * ((s + 1 - m : ℕ) : ℝ))) := by
  rw [signedCofactorError_succ s hs]
  congr 1
  apply Finset.sum_congr rfl
  intro m hm
  have hmle : m ≤ s - 2 := (mem_Icc.mp hm).2
  have hy : 1 ≤ s - m := by omega
  have hstep : s + 1 - m = (s - m) + 1 := by omega
  rw [hstep, ratioError_succ (s - m) hy]

#print axioms cofactorConvolution_eq_signed
#print axioms primeError_succ
#print axioms ratioError_succ
#print axioms cofactorConvolution_succ
#print axioms signedCofactorError_succ
#print axioms signedCofactorError_succ_expanded

end
end BuildingBlocks.GoldbachCofactorSuccessorFinite
