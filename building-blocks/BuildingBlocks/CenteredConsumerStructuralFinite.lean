import Mathlib.Tactic
import Mathlib.NumberTheory.VonMangoldt

/-!
# Structural finite identities for the centered complete-admission consumer

The module retains actual Möbius and von Mangoldt coefficients.  It contains
no analytic estimate and no RH implication as an axiom.
-/

namespace BuildingBlocks.CenteredConsumerStructuralFinite

open scoped BigOperators ArithmeticFunction

noncomputable section

/-- Weighted actual Möbius prefix. -/
def centeredPrefix (q : ℝ) (n : ℕ) : ℝ :=
  ∑ k ∈ Finset.Icc 1 n, (ArithmeticFunction.moebius k : ℝ) * q ^ k

/-- Exact successor recursion. -/
theorem centeredPrefix_succ (q : ℝ) (n : ℕ) :
    centeredPrefix q (n + 1) = centeredPrefix q n +
      (ArithmeticFunction.moebius (n + 1) : ℝ) * q ^ (n + 1) := by
  simp only [centeredPrefix]
  rw [Finset.sum_Icc_succ_top (by omega)]

/-- Exact successor recursion for the clock-scaled centered row. -/
theorem scaled_centered_successor (q : ℝ) (n : ℕ) :
    q ^ (n + 1) * centeredPrefix q (n + 1) =
      q * (q ^ n * centeredPrefix q n) +
        (ArithmeticFunction.moebius (n + 1) : ℝ) * q ^ (2 * (n + 1)) := by
  rw [centeredPrefix_succ]
  rw [pow_succ]
  ring

/-- Exact horizon recursion for a finite prefix energy. -/
theorem prefix_energy_horizon_succ
    (q : ℝ) (w : ℕ → ℝ) (N : ℕ) :
    (∑ n ∈ Finset.range (N + 1), w n * (centeredPrefix q n) ^ 2) =
      (∑ n ∈ Finset.range N, w n * (centeredPrefix q n) ^ 2) +
        w N * (centeredPrefix q N) ^ 2 := by
  rw [Finset.sum_range_succ]

/-- Exact dyadic/horizon split, with no independence assertion. -/
theorem prefix_energy_split
    (q : ℝ) (w : ℕ → ℝ) {J N : ℕ} (hJN : J ≤ N) :
    (∑ n ∈ Finset.range N, w n * (centeredPrefix q n) ^ 2) =
      (∑ n ∈ Finset.range J, w n * (centeredPrefix q n) ^ 2) +
        ∑ n ∈ Finset.Ico J N, w n * (centeredPrefix q n) ^ 2 := by
  exact (Finset.sum_range_add_sum_Ico
    (fun n => w n * (centeredPrefix q n) ^ 2) hJN).symm

/-- Complete multiplicative-history coefficient. -/
def completeHistory (n : ℕ) : ℝ :=
  ((ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
    ArithmeticFunction.log) n

/-- The complete multiplicative history is exactly von Mangoldt, including
all prime powers. -/
theorem completeHistory_eq_vonMangoldt (n : ℕ) :
    completeHistory n = ArithmeticFunction.vonMangoldt n := by
  simp [completeHistory, ArithmeticFunction.moebius_mul_log_eq_vonMangoldt]

/-- Exact additive Möbius coupling behind one squared prefix. -/
theorem prefix_square_additive_coupling (q : ℝ) (N : ℕ) :
    (centeredPrefix q N) ^ 2 =
      ∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 N,
        (ArithmeticFunction.moebius a : ℝ) *
          (ArithmeticFunction.moebius b : ℝ) * q ^ (a + b) := by
  simp only [centeredPrefix, pow_two, Finset.sum_mul_sum]
  apply Finset.sum_congr rfl
  intro a ha
  apply Finset.sum_congr rfl
  intro b hb
  rw [pow_add]
  ring

/-- Complete positive Goldbach mass on a finite box. -/
def goldbachMass (N : ℕ) : ℝ :=
  ∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 N,
    ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b

/-- The complete Goldbach mass is the square of the Chebyshev prefix. -/
theorem goldbachMass_eq_square (N : ℕ) :
    goldbachMass N =
      (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n) ^ 2 := by
  simp only [goldbachMass, pow_two, Finset.sum_mul_sum]

/-- Positivity of the complete Goldbach mass. -/
theorem goldbachMass_nonneg (N : ℕ) : 0 ≤ goldbachMass N := by
  rw [goldbachMass_eq_square]
  positivity

/-- Abstract observability consumer: a history domination immediately bounds
the centered prefix energy. -/
theorem history_observability_consumer
    (prefixEnergy historyEnergy scale bound : ℝ)
    (hscale : 0 ≤ scale)
    (hobs : prefixEnergy ≤ scale * historyEnergy)
    (hhist : historyEnergy ≤ bound) :
    prefixEnergy ≤ scale * bound := by
  exact hobs.trans (mul_le_mul_of_nonneg_left hhist hscale)

end
end BuildingBlocks.CenteredConsumerStructuralFinite

#print axioms BuildingBlocks.CenteredConsumerStructuralFinite.centeredPrefix_succ
#print axioms BuildingBlocks.CenteredConsumerStructuralFinite.scaled_centered_successor
#print axioms BuildingBlocks.CenteredConsumerStructuralFinite.prefix_energy_horizon_succ
#print axioms BuildingBlocks.CenteredConsumerStructuralFinite.prefix_energy_split
#print axioms BuildingBlocks.CenteredConsumerStructuralFinite.completeHistory_eq_vonMangoldt
#print axioms BuildingBlocks.CenteredConsumerStructuralFinite.prefix_square_additive_coupling
#print axioms BuildingBlocks.CenteredConsumerStructuralFinite.goldbachMass_eq_square
#print axioms BuildingBlocks.CenteredConsumerStructuralFinite.goldbachMass_nonneg
#print axioms BuildingBlocks.CenteredConsumerStructuralFinite.history_observability_consumer
