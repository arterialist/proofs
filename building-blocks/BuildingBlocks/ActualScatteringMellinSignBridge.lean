import BuildingBlocks.ActualScatteringMomentSigns
import BuildingBlocks.FullComplexHistoryMellin

namespace BuildingBlocks.ActualScatteringMellinSignBridge

open BuildingBlocks.ActualScatteringMomentSigns
open BuildingBlocks.GrowingPrimeScatteringBounds
open BuildingBlocks.FullComplexHistoryMellin

theorem positive_history_dictionary (p : ℝ) (h M : ℕ) :
    originalHistory p ((h : ℂ) + 1 / 2) M =
      (positiveMultiplier p h M : ℂ) := by
  unfold originalHistory positiveMultiplier
  rw [show ((h : ℂ) + 1 / 2) - 1 / 2 = h by ring,
    Complex.cpow_natCast]
  push_cast
  congr 2
  apply Finset.sum_congr rfl
  intro j _
  rw [show -(j : ℂ) * (((h : ℂ) + 1 / 2) + 1 / 2) =
    (j : ℂ) * (-((h + 1 : ℕ) : ℂ)) by push_cast; ring,
    Complex.cpow_nat_mul, Complex.cpow_neg, Complex.cpow_natCast]

theorem negative_history_dictionary (p : ℝ) (h M : ℕ) :
    originalHistory p (-((h : ℂ) + 1 / 2)) M =
      (negativeMultiplier p h M : ℂ) := by
  unfold originalHistory negativeMultiplier
  rw [show -((h : ℂ) + 1 / 2) - 1 / 2 =
    -((h + 1 : ℕ) : ℂ) by push_cast; ring,
    Complex.cpow_neg, Complex.cpow_natCast]
  push_cast
  congr 2
  apply Finset.sum_congr rfl
  intro j _
  rw [show -(j : ℂ) * (-((h : ℂ) + 1 / 2) + 1 / 2) =
    (j : ℂ) * (h : ℂ) by ring,
    Complex.cpow_nat_mul, Complex.cpow_natCast]

/-- The coefficient signs now refer to the actual compact physical history. -/
theorem actual_physical_two_sided_mellin (p h M : ℕ) (hp : p.Prime)
    {f : ℝ → ℂ} (hf : Continuous f) (hc : HasCompactSupport f) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (BuildingBlocks.CompactScatteringOperator.historyPhysical
      (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ)) f) ((h : ℂ) + 1 / 2) *
    BuildingBlocks.FullComplexHistoryMellin.mellin (BuildingBlocks.CompactScatteringOperator.historyPhysical
      (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ)) f) (-((h : ℂ) + 1 / 2)) =
    ((positiveMultiplier (p : ℝ) h M * negativeMultiplier (p : ℝ) h M : ℝ) : ℂ) *
      (BuildingBlocks.FullComplexHistoryMellin.mellin f ((h : ℂ) + 1 / 2) * BuildingBlocks.FullComplexHistoryMellin.mellin f (-((h : ℂ) + 1 / 2))) := by
  rw [actual_history_mellin p hp.two_le hf hc,
    actual_history_mellin p hp.two_le hf hc,
    positive_history_dictionary, negative_history_dictionary]
  push_cast
  ring

#print axioms positive_history_dictionary
#print axioms negative_history_dictionary
#print axioms actual_physical_two_sided_mellin

end BuildingBlocks.ActualScatteringMellinSignBridge
