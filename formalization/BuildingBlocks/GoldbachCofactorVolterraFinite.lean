import BuildingBlocks.GoldbachSuccessorLogFinite
import Mathlib.Tactic

/-!
# The signed Goldbach cofactor keeps the centered prime source

The finite Abel identity retains its terminal prime-error atom.  It is the
discrete source equation behind the Volterra heat transform of the signed
cofactor in the literal successor loss.
-/

namespace BuildingBlocks.GoldbachCofactorVolterraFinite

open Finset Real Classical
open scoped BigOperators

noncomputable section

abbrev Λ (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n

def centeredBirth (n : ℕ) : ℝ := Λ n - 1

def birthPrefix (a : ℕ → ℝ) (N : ℕ) : ℝ :=
  ∑ n ∈ Icc 1 N, a n

def sourcePolynomial (a : ℕ → ℝ) (N : ℕ) (z : ℝ) : ℝ :=
  ∑ n ∈ Icc 1 N, a n * z ^ n

def prefixPolynomial (a : ℕ → ℝ) (N : ℕ) (z : ℝ) : ℝ :=
  ∑ n ∈ Icc 1 N, birthPrefix a n * z ^ n

theorem birthPrefix_succ (a : ℕ → ℝ) (N : ℕ) :
    birthPrefix a (N + 1) = birthPrefix a N + a (N + 1) := by
  unfold birthPrefix
  rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ N + 1)]

/-- Exact finite Abel transform.  The endpoint term cannot be removed
before the cutoff tends to infinity. -/
theorem finite_prefix_abel (a : ℕ → ℝ) (N : ℕ) (z : ℝ) :
    (1 - z) * prefixPolynomial a N z =
      sourcePolynomial a N z - birthPrefix a N * z ^ (N + 1) := by
  induction N with
  | zero => simp [prefixPolynomial, sourcePolynomial, birthPrefix]
  | succ N ih =>
      have hp : prefixPolynomial a (N + 1) z =
          prefixPolynomial a N z + birthPrefix a (N + 1) * z ^ (N + 1) := by
        unfold prefixPolynomial
        rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ N + 1)]
      have hs : sourcePolynomial a (N + 1) z =
          sourcePolynomial a N z + a (N + 1) * z ^ (N + 1) := by
        unfold sourcePolynomial
        rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ N + 1)]
      calc
        (1 - z) * prefixPolynomial a (N + 1) z =
            (1 - z) * prefixPolynomial a N z +
              (1 - z) * birthPrefix a (N + 1) * z ^ (N + 1) := by rw [hp]; ring
        _ = sourcePolynomial a N z - birthPrefix a N * z ^ (N + 1) +
              (1 - z) * birthPrefix a (N + 1) * z ^ (N + 1) := by rw [ih]
        _ = sourcePolynomial a (N + 1) z -
              birthPrefix a (N + 1) * z ^ ((N + 1) + 1) := by
                rw [hs, birthPrefix_succ, pow_succ]
                ring

def primeError (N : ℕ) : ℝ :=
  BuildingBlocks.CoarsePrimitive.psi N - (N : ℝ)

/-- The complete prime error is the prefix of actual von Mangoldt
births minus the full integer reference, including the coefficient at one. -/
theorem primeError_eq_prefix (N : ℕ) :
    primeError N = birthPrefix centeredBirth N := by
  induction N with
  | zero => simp [primeError, birthPrefix, BuildingBlocks.CoarsePrimitive.psi]
  | succ N ih =>
      rw [primeError, BuildingBlocks.CoarsePrimitive.psi_succ]
      have hp := birthPrefix_succ centeredBirth N
      rw [← ih] at hp
      rw [hp]
      unfold primeError centeredBirth
      push_cast
      ring

/-- The finite arithmetic Volterra equation has a literal terminal
error.  It is valid for every real `z`, including `z = 1`. -/
theorem prime_error_finite_abel (N : ℕ) (z : ℝ) :
    (1 - z) * (∑ y ∈ Icc 1 N, primeError y * z ^ y) =
      (∑ n ∈ Icc 1 N, centeredBirth n * z ^ n) -
        primeError N * z ^ (N + 1) := by
  rw [show (∑ y ∈ Icc 1 N, primeError y * z ^ y) =
      prefixPolynomial centeredBirth N z by
        unfold prefixPolynomial
        apply Finset.sum_congr rfl
        intro y hy
        rw [primeError_eq_prefix]]
  rw [show (∑ n ∈ Icc 1 N, centeredBirth n * z ^ n) =
      sourcePolynomial centeredBirth N z by rfl]
  rw [primeError_eq_prefix]
  exact finite_prefix_abel centeredBirth N z

/-- The signed rational cofactor in the successor loss is a complete
additive convolution with the actual centered prime prefix. -/
theorem signedCofactorError_eq_centered_prefix (s : ℕ) :
    BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError s =
      ∑ m ∈ Icc 2 (s - 2),
        Λ m * birthPrefix centeredBirth (s - m) /
          ((s - m : ℕ) : ℝ) := by
  unfold BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError
  apply Finset.sum_congr rfl
  intro m hm
  rw [← primeError_eq_prefix]
  rfl

#print axioms finite_prefix_abel
#print axioms primeError_eq_prefix
#print axioms prime_error_finite_abel
#print axioms signedCofactorError_eq_centered_prefix

end
end BuildingBlocks.GoldbachCofactorVolterraFinite
