import Mathlib.Tactic

namespace BuildingBlocks.CenteredGoldbachFiniteAlgebra

open Finset

noncomputable section

variable {𝕜 : Type*} [CommRing 𝕜]

/-- First backward difference, with the natural-number endpoint convention. -/
def firstDifference (B : ℕ → 𝕜) (N : ℕ) : 𝕜 := B N - B (N - 1)

/-- Second backward difference. -/
def secondDifference (B : ℕ → 𝕜) (N : ℕ) : 𝕜 :=
  firstDifference B N - firstDifference B (N - 1)

/-- The centered coefficient is the literal second difference of its
prefix autocorrelation. -/
theorem secondDifference_eq (B : ℕ → 𝕜) (N : ℕ) (hN : 2 ≤ N) :
    secondDifference B N = B N - 2 * B (N - 1) + B (N - 2) := by
  unfold secondDifference firstDifference
  rw [show N - 1 - 1 = N - 2 by omega]
  ring

/-- Prefix telescope for the second difference, retaining its lower endpoint. -/
theorem secondDifference_prefix (B : ℕ → 𝕜) (X : ℕ) (hX : 2 ≤ X) :
    ∑ N ∈ Icc 2 X, secondDifference B N =
      firstDifference B X - firstDifference B 1 := by
  induction X, hX using Nat.le_induction with
  | base => simp [firstDifference, secondDifference]
  | succ X hX ih =>
      rw [sum_Icc_succ_top (by omega), ih]
      unfold secondDifference
      rw [show X + 1 - 1 = X by omega]
      ring

/-- With `B₀=B₁=0`, the centered prefix is exactly `B_X-B_{X-1}`. -/
theorem centered_prefix_telescope (B : ℕ → 𝕜) (hB0 : B 0 = 0) (hB1 : B 1 = 0)
    (X : ℕ) (hX : 2 ≤ X) :
    ∑ N ∈ Icc 2 X, secondDifference B N = B X - B (X - 1) := by
  rw [secondDifference_prefix B X hX]
  simp [firstDifference, hB0, hB1]

/-- Finite Abel identity with both terminal terms. The interior interval is
empty automatically for `X=2` and `X=3`. -/
theorem two_terminal_finite_abel (B : ℕ → 𝕜) (hB0 : B 0 = 0) (hB1 : B 1 = 0)
    (X : ℕ) (hX : 2 ≤ X) (z : 𝕜) :
    ∑ N ∈ Icc 2 X, secondDifference B N * z ^ N =
      (1 - z) ^ 2 * ∑ N ∈ Icc 2 (X - 2), B N * z ^ N +
      (1 - 2 * z) * B (X - 1) * z ^ (X - 1) + B X * z ^ X := by
  induction X, hX using Nat.le_induction with
  | base => simp [secondDifference, firstDifference, hB0, hB1]
  | succ X hX ih =>
      rw [sum_Icc_succ_top (by omega), ih]
      by_cases h2 : X = 2
      · subst X
        simp [secondDifference, firstDifference, hB0, hB1]
        ring
      · have hX3 : 3 ≤ X := by omega
        rw [show X + 1 - 2 = (X - 2) + 1 by omega,
          sum_Icc_succ_top (by omega)]
        rw [secondDifference_eq B (X + 1) (by omega)]
        rw [show X + 1 - 1 = X by omega, show X + 1 - 2 = X - 1 by omega,
          pow_succ]
        have hpX : z ^ X = z ^ (X - 1) * z := by
          calc
            z ^ X = z ^ ((X - 1) + 1) := by congr 1 <;> omega
            _ = z ^ (X - 1) * z := by rw [pow_succ]
        have hpPrev : z ^ (X - 1) = z ^ (X - 2) * z := by
          calc
            z ^ (X - 1) = z ^ ((X - 2) + 1) := by congr 1 <;> omega
            _ = z ^ (X - 2) * z := by rw [pow_succ]
        have hpSucc : z ^ (X + 1) = z ^ (X - 2) * z ^ 3 := by
          calc
            z ^ (X + 1) = z ^ ((X - 2) + 3) := by congr 1 <;> omega
            _ = z ^ (X - 2) * z ^ 3 := by rw [pow_add]
        rw [hpX, hpSucc]
        simp only [show X - 2 + 1 = X - 1 by omega]
        repeat' rw [hpPrev]
        ring

/-- Equivalent endpoint form using the exact prefix `C_X=B_X-B_{X-1}`. -/
theorem two_terminal_finite_abel_prefix (B : ℕ → 𝕜)
    (hB0 : B 0 = 0) (hB1 : B 1 = 0) (X : ℕ) (hX : 2 ≤ X) (z : 𝕜) :
    ∑ N ∈ Icc 2 X, secondDifference B N * z ^ N =
      (1 - z) ^ 2 * ∑ N ∈ Icc 2 (X - 2), B N * z ^ N +
      (1 - z) * B (X - 1) * z ^ (X - 1) +
      (B X - B (X - 1)) * z ^ X := by
  rw [two_terminal_finite_abel B hB0 hB1 X hX z]
  have hp : z ^ X = z ^ (X - 1) * z := by
    calc
      z ^ X = z ^ ((X - 1) + 1) := by congr 1 <;> omega
      _ = z ^ (X - 1) * z := by rw [pow_succ]
  rw [hp]
  ring

/-- Discrete energy summation by parts. It retains both endpoint terms. -/
theorem discrete_energy_summation_by_parts (d c : ℕ → ℝ)
    (hc : ∀ N, 2 ≤ N → c N = d N - d (N - 1))
    (X : ℕ) (hX : 2 ≤ X) :
    ∑ N ∈ Icc 2 X, (c N) ^ 2 =
      c X * d X - c 2 * d 1 -
        ∑ N ∈ Icc 2 (X - 1), d N * (c (N + 1) - c N) := by
  induction X, hX using Nat.le_induction with
  | base =>
      simp
      rw [hc 2 (by omega)]
      ring
  | succ X hX ih =>
      rw [sum_Icc_succ_top (by omega), ih]
      rw [show X + 1 - 1 = X by omega]
      have hsum : (∑ N ∈ Icc 2 X, d N * (c (N + 1) - c N)) =
          (∑ N ∈ Icc 2 (X - 1), d N * (c (N + 1) - c N)) +
            d X * (c (X + 1) - c X) := by
        rw [show X = (X - 1) + 1 by omega, sum_Icc_succ_top (by omega)]
        simp only [Nat.sub_add_cancel (by omega : 1 ≤ X)]
      rw [hsum, hc (X + 1) (by omega)]
      rw [show X + 1 - 1 = X by omega]
      ring

#print axioms secondDifference_eq
#print axioms secondDifference_prefix
#print axioms centered_prefix_telescope
#print axioms two_terminal_finite_abel
#print axioms two_terminal_finite_abel_prefix
#print axioms discrete_energy_summation_by_parts

end
end BuildingBlocks.CenteredGoldbachFiniteAlgebra
