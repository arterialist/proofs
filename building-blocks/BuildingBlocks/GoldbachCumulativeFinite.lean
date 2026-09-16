import BuildingBlocks.GoldbachPrimeHeatConvolution
import BuildingBlocks.CoarsePrimitive
import Mathlib.Tactic

/-! Exact finite ordered Goldbach cumulative identities, with all prime powers. -/

namespace BuildingBlocks.GoldbachCumulativeFinite

open Finset BuildingBlocks.GoldbachHeat

noncomputable section

abbrev Λ (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n

/-- The ordered von Mangoldt convolution at the unshifted total `n`. -/
def goldbachAt (n : ℕ) : ℝ :=
  ∑ p ∈ antidiagonal n, Λ p.1 * Λ p.2

/-- The right-continuous cumulative ordered convolution through integer `X`. -/
def cumulativeGoldbach (X : ℕ) : ℝ :=
  ∑ n ∈ range (X + 1), goldbachAt n

private theorem Λ_zero : Λ 0 = 0 := by
  simp [Λ]

private theorem Λ_one : Λ 1 = 0 := by
  exact ArithmeticFunction.vonMangoldt_apply_one

private theorem fiber_eq_antidiagonal (X n : ℕ) (hn : n ≤ X) :
    ((range (X + 1)).product (range (X + 1))).filter
      (fun p : ℕ × ℕ => p.1 + p.2 = n) = antidiagonal n := by
  ext p
  simp only [mem_filter, Finset.mem_antidiagonal]
  constructor
  · intro h
    exact h.2
  · intro h
    exact ⟨Finset.mem_product.mpr ⟨by simp; omega, by simp; omega⟩, h⟩

private theorem inner_filter_eq_range (X a : ℕ) (ha : a ≤ X) :
    (range (X + 1)).filter (fun b => a + b ≤ X) = range (X - a + 1) := by
  ext b
  simp only [mem_filter, mem_range]
  omega

/-- The repository's shifted heat coefficient is exactly the unshifted
ordered convolution at total `k + 2`. -/
theorem goldbachAt_shift (k : ℕ) :
    goldbachAt (k + 2) = shiftedPrimeGoldbach k := by
  unfold goldbachAt shiftedPrimeGoldbach
  rw [Finset.Nat.antidiagonal_succ_succ']
  simp [Finset.sum_map, Λ]

@[simp] theorem goldbachAt_zero : goldbachAt 0 = 0 := by
  simp [goldbachAt]

@[simp] theorem goldbachAt_one : goldbachAt 1 = 0 := by
  have h : antidiagonal 1 = {(0, 1), (1, 0)} := by decide
  simp [goldbachAt, h, Λ]

private theorem cumulative_step (X : ℕ) :
    cumulativeGoldbach (X + 1) = cumulativeGoldbach X + goldbachAt (X + 1) := by
  unfold cumulativeGoldbach
  rw [show X + 1 + 1 = (X + 1) + 1 by omega, sum_range_succ]

/-- Summing the shifted heat coefficients through total `K + 2` gives the
same ordered cumulative convolution. -/
theorem cumulative_eq_shifted (K : ℕ) :
    cumulativeGoldbach (K + 2) =
      ∑ k ∈ range (K + 1), shiftedPrimeGoldbach k := by
  induction K with
  | zero =>
    simp [cumulativeGoldbach, sum_range_succ, goldbachAt_shift]
  | succ K ih =>
    calc
      cumulativeGoldbach (K + 1 + 2) = cumulativeGoldbach (K + 2 + 1) := by congr 1
      _ = cumulativeGoldbach (K + 2) + goldbachAt (K + 2 + 1) := cumulative_step (K + 2)
      _ = (∑ k ∈ range (K + 1), shiftedPrimeGoldbach k) +
          shiftedPrimeGoldbach (K + 1) := by
            rw [ih, show K + 2 + 1 = (K + 1) + 2 by omega, goldbachAt_shift]
      _ = ∑ k ∈ range (K + 1 + 1), shiftedPrimeGoldbach k := by
            conv_rhs => rw [sum_range_succ]

/-- Every ordered pair of positive or prime-power indices appears once,
including pairs on the cutoff boundary. -/
theorem cumulative_eq_prime_psi (X : ℕ) :
    cumulativeGoldbach X =
      ∑ a ∈ range (X + 1), Λ a * CoarsePrimitive.psi (X - a) := by
  let s := (range (X + 1)).product (range (X + 1))
  have h := Finset.sum_fiberwise_eq_sum_filter s (range (X + 1))
    (fun p : ℕ × ℕ => p.1 + p.2) (fun p => Λ p.1 * Λ p.2)
  have hl : (∑ n ∈ range (X + 1), ∑ p ∈ s with p.1 + p.2 = n,
      Λ p.1 * Λ p.2) = cumulativeGoldbach X := by
    apply sum_congr rfl
    intro n hn
    rw [fiber_eq_antidiagonal X n (by have : n < X + 1 := mem_range.mp hn; omega)]
    rfl
  rw [hl] at h
  rw [h]
  rw [Finset.sum_filter]
  dsimp only [s]
  change (∑ p ∈ (range (X + 1) ×ˢ range (X + 1)),
      if p.1 + p.2 ∈ range (X + 1) then Λ p.1 * Λ p.2 else 0) =
    ∑ a ∈ range (X + 1), Λ a * CoarsePrimitive.psi (X - a)
  rw [Finset.sum_product]
  apply sum_congr rfl
  intro a ha
  have haX : a ≤ X := by have := mem_range.mp ha; omega
  simp only [mem_range]
  have hpred (b : ℕ) : (a + b < X + 1) ↔ (a + b ≤ X) := by omega
  simp_rw [hpred]
  rw [← Finset.sum_filter, inner_filter_eq_range X a haX]
  rw [← Finset.mul_sum]
  rfl

/-- The exact discrete integral of `ψ` equals the weighted linear kernel.
The `a = X` endpoint contributes zero to the kernel. -/
theorem prime_linear_eq_discrete_psi (X : ℕ) :
    (∑ a ∈ range (X + 1), Λ a * ((X - a : ℕ) : ℝ)) =
      ∑ u ∈ range X, CoarsePrimitive.psi u := by
  induction X with
  | zero => simp [Λ, CoarsePrimitive.psi]
  | succ X ih =>
    have hleft :
        (∑ a ∈ range (X + 1 + 1), Λ a * ((X + 1 - a : ℕ) : ℝ)) =
          (∑ a ∈ range (X + 1), Λ a * ((X - a : ℕ) : ℝ)) +
            CoarsePrimitive.psi X := by
      rw [sum_range_succ]
      have hterm : Λ (X + 1) * ((X + 1 - (X + 1) : ℕ) : ℝ) = 0 := by simp
      rw [hterm, add_zero]
      have hinner :
          (∑ a ∈ range (X + 1), Λ a * ((X + 1 - a : ℕ) : ℝ)) =
            (∑ a ∈ range (X + 1), (Λ a * ((X - a : ℕ) : ℝ) + Λ a)) := by
        apply sum_congr rfl
        intro a ha
        have haX : a ≤ X := by have := mem_range.mp ha; omega
        rw [show X + 1 - a = X - a + 1 by omega]
        push_cast
        ring
      rw [hinner, sum_add_distrib]
      rfl
    rw [hleft, ih, sum_range_succ]

/-- Finite version of the decomposition in Eq. (3): its main term is a
discrete integral, and the remainder uses the actual finite Chebyshev error. -/
theorem cumulative_eq_discrete_main_remainder (X : ℕ) :
    cumulativeGoldbach X =
      (∑ u ∈ range X, CoarsePrimitive.psi u) +
        ∑ a ∈ range (X + 1),
          Λ a * (CoarsePrimitive.psi (X - a) - ((X - a : ℕ) : ℝ)) := by
  rw [cumulative_eq_prime_psi]
  rw [← prime_linear_eq_discrete_psi X]
  rw [← sum_add_distrib]
  apply sum_congr rfl
  intro a ha
  ring

#print axioms goldbachAt_shift
#print axioms cumulative_eq_shifted
#print axioms cumulative_eq_prime_psi
#print axioms prime_linear_eq_discrete_psi
#print axioms cumulative_eq_discrete_main_remainder

end
end BuildingBlocks.GoldbachCumulativeFinite
