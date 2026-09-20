import BuildingBlocks.DirichletFutureObservationFinite

/-!
# Ordered cross sums of localized complete Möbius histories

The complete real divisor-log history before transformation may be split into
finitely many labelled pieces. This file records its exact ordered
off-diagonal cross-sum identity.
-/

namespace BuildingBlocks.ActualMobiusHistoryCrossSum

open scoped BigOperators ArithmeticFunction

noncomputable section

open DirichletFutureObservationFinite

variable {ι : Type*} [DecidableEq ι]

/-- The real pre-transform part of the literal divisor-log history carrying a
prescribed label. -/
def historyPiece (n : ℕ) (label : ℕ × ℕ → ι) (i : ι) : ℝ :=
  ∑ de ∈ n.divisorsAntidiagonal,
    if label de = i then
      (ArithmeticFunction.moebius de.1 : ℝ) * Real.log de.2
    else 0

/-- A finite label set covering every divisor pair reconstructs the complete
Möbius-log history exactly. -/
theorem sum_historyPiece_eq_divisorLogHistory
    (n : ℕ) (S : Finset ι) (label : ℕ × ℕ → ι)
    (hcover : ∀ de ∈ n.divisorsAntidiagonal, label de ∈ S) :
    (∑ i ∈ S, historyPiece n label i) = divisorLogHistory n := by
  unfold historyPiece divisorLogHistory
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro de hde
  simp [hcover de hde]

/-- The labelled pieces sum to the actual von Mangoldt coefficient, retaining
all prime powers. -/
theorem sum_historyPiece_eq_vonMangoldt
    (n : ℕ) (S : Finset ι) (label : ℕ × ℕ → ι)
    (hcover : ∀ de ∈ n.divisorsAntidiagonal, label de ∈ S) :
    (∑ i ∈ S, historyPiece n label i) =
      ArithmeticFunction.vonMangoldt n := by
  rw [sum_historyPiece_eq_divisorLogHistory n S label hcover,
    divisorLogHistory_eq_vonMangoldt]

/-- Ordered off-diagonal cross sum for an arbitrary finite real family. Both
orientations of every unordered pair occur. -/
theorem ordered_cross_eq_total_sq_sub_sq
    (S : Finset ι) (a : ι → ℝ) :
    (∑ i ∈ S, ∑ j ∈ S, if i = j then 0 else a i * a j) =
      (∑ i ∈ S, a i) ^ 2 - ∑ i ∈ S, (a i) ^ 2 := by
  have hrow : ∀ i ∈ S,
      (∑ j ∈ S, if i = j then 0 else a i * a j) =
        a i * (∑ j ∈ S, a j) - (a i) ^ 2 := by
    intro i hi
    calc
      _ = ∑ j ∈ S, (a i * a j - if i = j then (a i) ^ 2 else 0) := by
        apply Finset.sum_congr rfl
        intro j hj
        by_cases h : i = j
        · subst j
          simp [pow_two]
        · simp [h]
      _ = _ := by
        rw [Finset.sum_sub_distrib, ← Finset.mul_sum]
        simp [hi]
  rw [Finset.sum_congr rfl hrow, Finset.sum_sub_distrib,
    ← Finset.sum_mul]
  ring

/-- The complete localized real history cross sum equals the square of the
actual von Mangoldt coefficient minus the sum of the localized energies. -/
theorem ordered_history_cross_sum
    (n : ℕ) (S : Finset ι) (label : ℕ × ℕ → ι)
    (hcover : ∀ de ∈ n.divisorsAntidiagonal, label de ∈ S) :
    (∑ i ∈ S, ∑ j ∈ S,
      if i = j then 0 else historyPiece n label i * historyPiece n label j) =
      (ArithmeticFunction.vonMangoldt n) ^ 2 -
        ∑ i ∈ S, (historyPiece n label i) ^ 2 := by
  rw [ordered_cross_eq_total_sq_sub_sq,
    sum_historyPiece_eq_vonMangoldt n S label hcover]

/-- Where von Mangoldt vanishes, the aggregate complete ordered cross-history
sum is exactly the negative localized square energy. This does not sign the
individual cross terms. -/
theorem ordered_history_cross_sum_of_vonMangoldt_eq_zero
    (n : ℕ) (S : Finset ι) (label : ℕ × ℕ → ι)
    (hcover : ∀ de ∈ n.divisorsAntidiagonal, label de ∈ S)
    (hzero : ArithmeticFunction.vonMangoldt n = 0) :
    (∑ i ∈ S, ∑ j ∈ S,
      if i = j then 0 else historyPiece n label i * historyPiece n label j) =
      -(∑ i ∈ S, (historyPiece n label i) ^ 2) := by
  rw [ordered_history_cross_sum n S label hcover, hzero]
  ring

end

end BuildingBlocks.ActualMobiusHistoryCrossSum

#print axioms BuildingBlocks.ActualMobiusHistoryCrossSum.sum_historyPiece_eq_divisorLogHistory
#print axioms BuildingBlocks.ActualMobiusHistoryCrossSum.sum_historyPiece_eq_vonMangoldt
#print axioms BuildingBlocks.ActualMobiusHistoryCrossSum.ordered_cross_eq_total_sq_sub_sq
#print axioms BuildingBlocks.ActualMobiusHistoryCrossSum.ordered_history_cross_sum
#print axioms BuildingBlocks.ActualMobiusHistoryCrossSum.ordered_history_cross_sum_of_vonMangoldt_eq_zero
