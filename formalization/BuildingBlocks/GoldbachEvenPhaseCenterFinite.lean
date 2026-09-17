import BuildingBlocks.GoldbachPrimePhaseCutFinite

/-!
# Even-total Goldbach phase centering

The full von Mangoldt source is paired only across even additive totals.
The reference density is two on odd indices and zero on even indices.
This file certifies the exact finite algebra before the angular-frequency
projection and the prime-power ladder analysis.
-/

namespace BuildingBlocks.GoldbachEvenPhaseCenterFinite

open Finset Real
open BuildingBlocks.GoldbachPrimePhaseCutFinite

def evenPairDomain (N : ℕ) : Finset (ℕ × ℕ) :=
  (pairDomain N).filter (fun q => Even (q.1 + q.2))

noncomputable def oddReference (n : ℕ) : ℝ :=
  if Odd n then 2 else 0

/-- Two units on each odd site have exactly unit mass per ordinary
integer over every complete two-cell block. -/
theorem oddReference_two_cell_prefix (k : ℕ) :
    (∑ n ∈ range (2 * k), oddReference n) = (2 * k : ℝ) := by
  induction k with
  | zero => simp
  | succ k ih =>
      have he : oddReference (2 * k) = 0 := by simp [oddReference]
      have ho : oddReference (2 * k + 1) = 2 := by simp [oddReference]
      rw [show 2 * (k + 1) = (2 * k + 1) + 1 by omega,
        sum_range_succ, sum_range_succ, he, ho, ih]
      push_cast
      ring

/-- At an even terminal total `N = 2k + 6`, the exact number of odd
partners for the generator three is `N - 2` after the density factor. -/
theorem oddReference_three_partner_prefix (k : ℕ) :
    (∑ n ∈ range (2 * k + 4), oddReference n) = (2 * k + 4 : ℝ) := by
  have h := oddReference_two_cell_prefix (k + 2)
  calc
    _ = 2 * (k + 2 : ℝ) := by
      simpa only [show 2 * (k + 2) = 2 * k + 4 by omega,
        Nat.cast_add, Nat.cast_ofNat] using h
    _ = 2 * k + 4 := by ring

noncomputable def evenCenteredGoldbach (N : ℕ) (phase : ℕ → ℝ) : ℝ :=
  ∑ q ∈ evenPairDomain N,
    (weight q.1 * weight q.2 * cos (phase q.1 - phase q.2) -
      weight q.1 * oddReference q.2 * cos (phase q.1) -
      oddReference q.1 * weight q.2 * cos (phase q.2) +
      oddReference q.1 * oddReference q.2)

/-- The complete even-total centered difference retains the odd-lattice
reference in each one-leg row and both active-phase interactions. -/
theorem even_centered_phase_difference (N : ℕ) (phase : ℕ → ℝ) :
    evenCenteredGoldbach N (fun _ => 0) - evenCenteredGoldbach N phase =
      ∑ q ∈ evenPairDomain N,
        (weight q.1 * (1 - cos (phase q.1)) *
            (weight q.2 - oddReference q.2) +
         weight q.2 * (1 - cos (phase q.2)) *
            (weight q.1 - oddReference q.1) -
         weight q.1 * weight q.2 *
           ((1 - cos (phase q.1)) * (1 - cos (phase q.2)) +
             sin (phase q.1) * sin (phase q.2))) := by
  unfold evenCenteredGoldbach
  rw [← sum_sub_distrib]
  apply sum_congr rfl
  intro q hq
  simp only [sub_self, cos_zero]
  rw [cos_sub]
  ring

#print axioms even_centered_phase_difference
#print axioms oddReference_three_partner_prefix

end BuildingBlocks.GoldbachEvenPhaseCenterFinite
