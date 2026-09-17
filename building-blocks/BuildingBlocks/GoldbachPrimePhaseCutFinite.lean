import Mathlib.Tactic
import Mathlib.NumberTheory.VonMangoldt

/-!
# The finite Hermitian Goldbach phase cut

The phase is allowed to be any real function of the integer index.  In the
arithmetic application it is the completely multiplicative prime-generator
phase, so its value at `p ^ k` is `k * θ` for primes below the cutoff.
The finite identities below retain all von Mangoldt weights and both ordered
orientations of every additive pair.
-/

namespace BuildingBlocks.GoldbachPrimePhaseCutFinite

open Finset Real

def pairDomain (X : ℕ) : Finset (ℕ × ℕ) :=
  ((Icc 1 X).product (Icc 1 X)).filter (fun q => q.1 + q.2 ≤ X)

noncomputable def weight (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n

noncomputable def ordinaryGoldbach (X : ℕ) : ℝ :=
  ∑ q ∈ pairDomain X, weight q.1 * weight q.2

noncomputable def hermitianGoldbach (X : ℕ) (phase : ℕ → ℝ) : ℝ :=
  ∑ q ∈ pairDomain X,
    weight q.1 * weight q.2 * cos (phase q.1 - phase q.2)

noncomputable def cutEnergy (X : ℕ) (phase : ℕ → ℝ) : ℝ :=
  ∑ q ∈ pairDomain X,
    weight q.1 * weight q.2 *
      (((cos (phase q.1) - cos (phase q.2)) ^ 2 +
        (sin (phase q.1) - sin (phase q.2)) ^ 2) / 2)

private theorem phase_distance (a b : ℝ) :
    1 - cos (a - b) =
      ((cos a - cos b) ^ 2 + (sin a - sin b) ^ 2) / 2 := by
  rw [cos_sub]
  nlinarith [sin_sq_add_cos_sq a, sin_sq_add_cos_sq b]

/-- The complete Goldbach Hermitian phase difference is an exact graph
Dirichlet energy, including every prime power and additive endpoint. -/
theorem ordinary_sub_hermitian_eq_cutEnergy (X : ℕ) (phase : ℕ → ℝ) :
    ordinaryGoldbach X - hermitianGoldbach X phase = cutEnergy X phase := by
  unfold ordinaryGoldbach hermitianGoldbach cutEnergy
  rw [← sum_sub_distrib]
  apply sum_congr rfl
  intro q hq
  calc
    _ = (weight q.1 * weight q.2) *
        (1 - cos (phase q.1 - phase q.2)) := by ring
    _ = _ := by rw [phase_distance (phase q.1) (phase q.2)]

/-- The actual von Mangoldt Goldbach cut is nonnegative for every phase. -/
theorem cutEnergy_nonneg (X : ℕ) (phase : ℕ → ℝ) :
    0 ≤ cutEnergy X phase := by
  unfold cutEnergy
  apply sum_nonneg
  intro q hq
  apply mul_nonneg
  · exact mul_nonneg ArithmeticFunction.vonMangoldt_nonneg
      ArithmeticFunction.vonMangoldt_nonneg
  · exact div_nonneg
      (add_nonneg (sq_nonneg _) (sq_nonneg _)) (by norm_num)

theorem hermitianGoldbach_le_ordinary (X : ℕ) (phase : ℕ → ℝ) :
    hermitianGoldbach X phase ≤ ordinaryGoldbach X := by
  have h := cutEnergy_nonneg X phase
  rw [← ordinary_sub_hermitian_eq_cutEnergy] at h
  linarith

/-- This algebraic decomposition is the exact starting point for isolating
the one-active-prime-power rows; the final two terms retain their signed
interaction rather than being silently discarded. -/
theorem phase_pair_decomposition (a b : ℝ) :
    1 - cos (a - b) =
      (1 - cos a) + (1 - cos b) -
        ((1 - cos a) * (1 - cos b) + sin a * sin b) := by
  rw [cos_sub]
  ring

#print axioms ordinary_sub_hermitian_eq_cutEnergy
#print axioms cutEnergy_nonneg
#print axioms hermitianGoldbach_le_ordinary
#print axioms phase_pair_decomposition

end BuildingBlocks.GoldbachPrimePhaseCutFinite
