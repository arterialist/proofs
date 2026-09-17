import BuildingBlocks.GoldbachCofactorOddStepFinite
import Mathlib.Tactic

/-!
# Exact finite windows for the signed Goldbach cofactor

The window identity sums the complete one-step source without dropping
the newly admitted endpoint. The coefficient telescope is the finite
arithmetic cancellation used in the mesoscopic analytic theorem.
-/

namespace BuildingBlocks.GoldbachCofactorWindowFinite

open Finset Real Classical
open scoped BigOperators

noncomputable section

abbrev Λ (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n
abbrev ψ (n : ℕ) : ℝ := BuildingBlocks.CoarsePrimitive.psi n
abbrev q (n : ℕ) : ℝ := BuildingBlocks.GoldbachCofactorSuccessorFinite.ratioError n
abbrev Q (n : ℕ) : ℝ := BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError n
abbrev ageCoefficient (h : ℕ) : ℝ :=
  Λ h / (h : ℝ) - ψ (h - 1) / (((h - 1 : ℕ) : ℝ) * (h : ℝ))

/-- The prime birth and its full preceding Chebyshev history are
exactly one increment of the centered prime-error ratio. -/
theorem ageCoefficient_eq_ratioError_step (h : ℕ) (hh : 2 ≤ h) :
    ageCoefficient h = q h - q (h - 1) := by
  exact (BuildingBlocks.GoldbachCofactorOddStepFinite.ratioError_step_exact h hh).symm

/-- Reindex the exact successor source by the age of its new leg.
The moving upper endpoint is `s-1`, and the newly admitted `q 2`
term remains separate. -/
theorem step_age_exact (s : ℕ) (hs : 4 ≤ s) :
    Q (s + 1) - Q s = Λ (s - 1) * q 2 +
      ∑ h ∈ Icc 3 (s - 1), Λ (s + 1 - h) * ageCoefficient h := by
  rw [BuildingBlocks.GoldbachCofactorOddStepFinite.signedCofactorError_step_exact s hs]
  congr 1
  apply Finset.sum_bij (fun m _ => s + 1 - m)
  · intro m hm
    simp only [mem_Icc] at hm ⊢
    omega
  · intro m hm n hn hmn
    simp only [mem_Icc] at hm hn
    omega
  · intro h hh
    simp only [mem_Icc] at hh
    refine ⟨s + 1 - h, ?_, ?_⟩
    · simp only [mem_Icc]
      omega
    · omega
  · intro m hm
    have hmle : m ≤ s - 2 := (mem_Icc.mp hm).2
    have hreturn : s + 1 - (s + 1 - m) = m := by omega
    have hpred : s + 1 - m - 1 = s - m := by omega
    simp [ageCoefficient, hreturn, hpred]

/-- The actual cofactor change across a finite clock window is the
sum of its exact successor steps, including every prime-power source
and the `q 2` endpoint. -/
theorem window_step_exact (X H : ℕ) (hX : 4 ≤ X) :
    Q (X + H) - Q X =
      ∑ s ∈ Ico X (X + H),
        (Λ (s - 1) * q 2 +
          ∑ m ∈ Icc 2 (s - 2), Λ m *
            (Λ (s + 1 - m) / ((s + 1 - m : ℕ) : ℝ) -
              ψ (s - m) /
                (((s - m : ℕ) : ℝ) * ((s + 1 - m : ℕ) : ℝ)))) := by
  calc
    Q (X + H) - Q X =
        ∑ s ∈ Ico X (X + H), (Q (s + 1) - Q s) := by
          symm
          exact sum_Ico_sub Q (by omega)
    _ = _ := by
      apply Finset.sum_congr rfl
      intro s hs
      have hsX : X ≤ s := (Finset.mem_Ico.mp hs).1
      exact BuildingBlocks.GoldbachCofactorOddStepFinite.signedCofactorError_step_exact
        s (by omega)

/-- Exact finite window in age coordinates. Its moving upper edge is
retained, so the analytic argument may split complete windows from
newly born boundary rows without an endpoint convention. -/
theorem window_step_age_exact (X H : ℕ) (hX : 4 ≤ X) :
    Q (X + H) - Q X =
      ∑ s ∈ Ico X (X + H),
        (Λ (s - 1) * q 2 +
          ∑ h ∈ Icc 3 (s - 1), Λ (s + 1 - h) * ageCoefficient h) := by
  calc
    Q (X + H) - Q X =
        ∑ s ∈ Ico X (X + H), (Q (s + 1) - Q s) := by
          symm
          exact sum_Ico_sub Q (by omega)
    _ = _ := by
      apply Finset.sum_congr rfl
      intro s hs
      have hsX : X ≤ s := (Finset.mem_Ico.mp hs).1
      exact step_age_exact s (by omega)

/-- The prefix coefficients cancel exactly, before any prime theorem
is applied. The right endpoint `q (Y+2)` and the initial `q 2`
are both retained. -/
theorem ratioError_prefix_telescope (Y : ℕ) :
    (∑ j ∈ Ico 2 (Y + 2), (q (j + 1) - q j)) = q (Y + 2) - q 2 := by
  exact sum_Ico_sub q (by omega)

/-- The age-indexed source coefficients telescope with both endpoints
visible. This is the exact finite cancellation used before estimating
each shifted Mangoldt window. -/
theorem ageCoefficient_prefix_telescope (Y : ℕ) (hY : 2 ≤ Y) :
    (∑ h ∈ Icc 3 Y, ageCoefficient h) = q Y - q 2 := by
  calc
    (∑ h ∈ Icc 3 Y, ageCoefficient h) =
        ∑ j ∈ Ico 2 Y, ageCoefficient (j + 1) := by
          symm
          apply Finset.sum_bij (fun j _ => j + 1)
          · intro j hj
            simp only [mem_Ico, mem_Icc] at hj ⊢
            omega
          · intro j hj k hk hjk
            omega
          · intro h hh
            simp only [mem_Icc] at hh
            refine ⟨h - 1, ?_, ?_⟩
            · simp only [mem_Ico]
              omega
            · omega
          · intro j hj
            rfl
    _ = ∑ j ∈ Ico 2 Y, (q (j + 1) - q j) := by
      apply Finset.sum_congr rfl
      intro j hj
      have hj2 : 2 ≤ j := (Finset.mem_Ico.mp hj).1
      exact ageCoefficient_eq_ratioError_step (j + 1) (by omega)
    _ = q Y - q 2 := sum_Ico_sub q hY

#print axioms window_step_exact
#print axioms ageCoefficient_eq_ratioError_step
#print axioms step_age_exact
#print axioms window_step_age_exact
#print axioms ratioError_prefix_telescope
#print axioms ageCoefficient_prefix_telescope

end
end BuildingBlocks.GoldbachCofactorWindowFinite
