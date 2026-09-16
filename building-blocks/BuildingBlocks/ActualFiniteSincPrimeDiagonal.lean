import BuildingBlocks.ActualScatteringMomentSigns
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

namespace BuildingBlocks.ActualFiniteSincPrimeDiagonal

open Finset

noncomputable section

/-- The exact normalized Fourier coefficient of the symmetric arc `[-δ, δ]`. -/
def sincKernel (δ : ℝ) (k : ℤ) : ℝ :=
  if k = 0 then δ / Real.pi
  else Real.sin ((k : ℝ) * δ) / (Real.pi * (k : ℝ))

@[simp] theorem sincKernel_zero (δ : ℝ) : sincKernel δ 0 = δ / Real.pi := by
  simp [sincKernel]

@[simp] theorem sincKernel_neg (δ : ℝ) (k : ℤ) :
    sincKernel δ (-k) = sincKernel δ k := by
  by_cases hk : k = 0
  · simp [hk]
  simp only [sincKernel, neg_eq_zero, hk, ↓reduceIte, Int.cast_neg, neg_mul,
    Real.sin_neg]
  ring

/-- Complete finite sinc form. No off-diagonal birth covariance is removed. -/
def finiteSincForm (S : Finset ℕ) (δ r : ℝ) (cov : ℕ → ℕ → ℝ) : ℝ :=
  ∑ m ∈ S, ∑ n ∈ S,
    r ^ (m + n) * sincKernel δ ((m : ℤ) - (n : ℤ)) * cov m n

/-- Exact diagonal selected by a finite set of primes. -/
def finitePrimeDiagonal (P : Finset ℕ) (δ r : ℝ) (q : ℕ → ℝ) : ℝ :=
  (δ / Real.pi) * ∑ p ∈ P, r ^ (2 * p) * q p

/-- Subtracting the prime diagonal is an exact identity and retains every
prime-prime off-diagonal, prime-composite, and composite-composite term. -/
theorem finite_sinc_prime_diagonal_decomposition
    (S P : Finset ℕ) (δ r : ℝ) (cov : ℕ → ℕ → ℝ) (q : ℕ → ℝ) :
    finiteSincForm S δ r cov =
      finitePrimeDiagonal P δ r q +
        (finiteSincForm S δ r cov - finitePrimeDiagonal P δ r q) := by
  ring

/-- The literal norm-square expression for a prime birth in terms of the
complete collision kernel. -/
def primeBirthNorm (K : ℕ → ℝ) (p : ℕ) : ℝ :=
  K (2 * p) - 2 * K (p + 1) + K 2

/-- Exact finite prime diagonal after inserting the literal prime birth norm. -/
theorem finite_prime_diagonal_literal (P : Finset ℕ) (δ r : ℝ)
    (K : ℕ → ℝ) :
    finitePrimeDiagonal P δ r (primeBirthNorm K) =
      (δ / Real.pi) * ∑ p ∈ P, r ^ (2 * p) *
        (K (2 * p) - 2 * K (p + 1) + K 2) := by
  rfl

/-- A finite prime diagonal is nonnegative under the actual norm-square
condition. -/
theorem finite_prime_diagonal_nonneg {P : Finset ℕ} {δ r : ℝ}
    {q : ℕ → ℝ} (hδ : 0 ≤ δ) (hq : ∀ p ∈ P, 0 ≤ q p) :
    0 ≤ finitePrimeDiagonal P δ r q := by
  unfold finitePrimeDiagonal
  apply mul_nonneg
  · exact div_nonneg hδ Real.pi_pos.le
  · exact sum_nonneg fun p hp => by
      have hr : 0 ≤ r ^ (2 * p) := by
        rw [show 2 * p = p * 2 by omega, pow_mul]
        exact sq_nonneg _
      exact mul_nonneg hr (hq p hp)

/-- Removing a selected prime diagonal costs at most the complete finite
birth diagonal. This is the finite comparison used before any Abel limit. -/
theorem finite_prime_diagonal_le_full {S P : Finset ℕ} {δ r : ℝ}
    {q : ℕ → ℝ} (hδ : 0 ≤ δ) (hPS : P ⊆ S)
    (hq : ∀ n ∈ S, 0 ≤ q n) :
    finitePrimeDiagonal P δ r q ≤
      (δ / Real.pi) * ∑ n ∈ S, r ^ (2 * n) * q n := by
  unfold finitePrimeDiagonal
  apply mul_le_mul_of_nonneg_left _ (div_nonneg hδ Real.pi_pos.le)
  apply sum_le_sum_of_subset_of_nonneg hPS
  intro n hnS hnP
  have hr : 0 ≤ r ^ (2 * n) := by
    rw [show 2 * n = n * 2 by omega, pow_mul]
    exact sq_nonneg _
  exact mul_nonneg hr (hq n hnS)

/-- Consequently, an upper bound for the signed remainder plus the paid full
diagonal is an upper bound for the complete finite sinc form. -/
theorem finite_sinc_le_of_remainder_le {S P : Finset ℕ} {δ r B V : ℝ}
    {cov : ℕ → ℕ → ℝ} {q : ℕ → ℝ}
    (hrem : finiteSincForm S δ r cov - finitePrimeDiagonal P δ r q ≤ B)
    (hdiag : finitePrimeDiagonal P δ r q ≤ V) :
    finiteSincForm S δ r cov ≤ B + V := by
  linarith

#print axioms sincKernel_zero
#print axioms sincKernel_neg
#print axioms finite_sinc_prime_diagonal_decomposition
#print axioms finite_prime_diagonal_literal
#print axioms finite_prime_diagonal_nonneg
#print axioms finite_prime_diagonal_le_full
#print axioms finite_sinc_le_of_remainder_le

end
end BuildingBlocks.ActualFiniteSincPrimeDiagonal
