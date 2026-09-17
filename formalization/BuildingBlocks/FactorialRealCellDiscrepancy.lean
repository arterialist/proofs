import BuildingBlocks.FactorialRealCellSteps

open Real Finset Set MeasureTheory
open scoped BigOperators
namespace BuildingBlocks.FactorialRealCellPhase

/-- Every original Möbius history, evaluated at its literal real quotient floor. -/
noncomputable def actualFloorRow (N : ℕ) (x : ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
    (⌊((N / n : ℕ) : ℝ) / x⌋₊ : ℝ)

noncomputable def actualDiscrepancy (N : ℕ) (x : ℝ) : ℝ := actualFloorRow N x - 1

noncomputable def actualBaseline (N : ℕ) (t : ℝ) : ℝ :=
  1 - exp (-t) + movingInverseTest t N

/-- All complete integer rows vanish after centering, without identifying real cells with them. -/
theorem actualDiscrepancy_integer (N k : ℕ) (hk : 0 < k) (hkN : k ≤ N) :
    actualDiscrepancy N k = 0 := by
  have hh := BuildingBlocks.FactorialQuotientConstraints.quotient_mass_real N k hk hkN
  unfold actualDiscrepancy actualFloorRow
  simp only [Nat.floor_div_eq_div]
  rw [hh, sub_self]

/-- The baseline retains its complete signed inverse-divisor coefficient. -/
theorem actualBaseline_arithmetic (N : ℕ) (t : ℝ) :
    actualBaseline N t =
      (1 - (N : ℝ) * ∑ j ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius j : ℝ) / j) * (1 - exp (-t)) +
      ∑ j ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius j : ℝ) * (1 - exp (-((N : ℝ) / j) * t)) := by
  unfold actualBaseline movingInverseTest
  rw [Nat.floor_natCast]
  unfold finiteInverseTest
  have he : ∀ j : ℕ, (ArithmeticFunction.moebius j : ℝ) * centeredTest t ((N : ℝ) / j) =
      (ArithmeticFunction.moebius j : ℝ) * (1 - exp (-((N : ℝ) / j) * t)) -
      ((ArithmeticFunction.moebius j : ℝ) / j) * ((N : ℝ) * (1 - exp (-t))) := by
    intro j
    unfold centeredTest
    ring
  simp_rw [he]
  rw [Finset.sum_sub_distrib, ← Finset.sum_mul]
  ring

theorem actualFloorRow_phase_intervalIntegrable (N : ℕ) {t : ℝ}
    (ht : 0 < t) (hN : 0 < N) :
    IntervalIntegrable (fun x => actualFloorRow N x * (-inverseTestPhase x t)) volume 1 N := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hs := IntervalIntegrable.sum (Finset.Icc 1 N)
    (fun (n : ℕ) _ => (real_floor_inversePhase_intervalIntegrable (N / n) ht hNr).const_mul
      (ArithmeticFunction.moebius n : ℝ))
  apply hs.congr
  intro x hx
  simp only [Finset.sum_apply, actualFloorRow, Finset.sum_mul, mul_assoc]

theorem actualDiscrepancy_phase_intervalIntegrable (N : ℕ) {t : ℝ}
    (ht : 0 < t) (hN : 0 < N) :
    IntervalIntegrable (fun x => actualDiscrepancy N x * (-inverseTestPhase x t)) volume 1 N := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  apply ((actualFloorRow_phase_intervalIntegrable N ht hN).sub
    (inverseTestPhase_intervalIntegrable ht hNr).neg).congr
  intro x hx
  dsimp only [Pi.sub_apply, Pi.neg_apply]
  unfold actualDiscrepancy
  ring

/-- Signed discrepancy work, with the actual terminal test value retained. -/
theorem actualDiscrepancy_phase_integral (N : ℕ) {t : ℝ} (ht : 0 < t) (hN : 0 < N) :
    (∫ x in (1 : ℝ)..N, actualDiscrepancy N x * (-inverseTestPhase x t)) =
      BuildingBlocks.FactorialBinaryCarry.response N t - actualBaseline N t := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have he : (fun x => actualDiscrepancy N x * (-inverseTestPhase x t)) =
      (fun x => actualFloorRow N x * (-inverseTestPhase x t) - (-inverseTestPhase x t)) := by
    funext x
    unfold actualDiscrepancy
    ring
  rw [he, intervalIntegral.integral_sub (g := fun x => -inverseTestPhase x t)
    (actualFloorRow_phase_intervalIntegrable N ht hN)
    (inverseTestPhase_intervalIntegrable ht hNr).neg, movingInverseTest_integral_from_one ht hNr]
  unfold actualFloorRow actualBaseline
  rw [actual_real_floor_response_integral N ht hN]
  ring

/-- The full response is baseline plus signed real-cell work; no sign is assumed. -/
theorem actual_response_signed_reconstruction (N : ℕ) {t : ℝ} (ht : 0 < t) (hN : 0 < N) :
    BuildingBlocks.FactorialBinaryCarry.response N t = actualBaseline N t +
      ∫ x in (1 : ℝ)..N, actualDiscrepancy N x * (-inverseTestPhase x t) := by
  rw [actualDiscrepancy_phase_integral N ht hN]
  ring

#print axioms actual_response_signed_reconstruction
#print axioms actualBaseline_arithmetic
#print axioms actualDiscrepancy_integer
#print axioms actualDiscrepancy_phase_integral
#print axioms actualDiscrepancy_phase_intervalIntegrable
#print axioms actualFloorRow_phase_intervalIntegrable
end BuildingBlocks.FactorialRealCellPhase
