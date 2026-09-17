import BuildingBlocks.PrimeHistoryFullW
import BuildingBlocks.ActualCriticalMellin

open Finset
open scoped BigOperators

namespace BuildingBlocks.OriginalWIdentification

open PrimeHistoryCoefficientIdentification

/-- The history-calibrated coefficient V is exactly the original finite Mellin-side V,
including the whole causal zero branch and x=1. -/
theorem coefficientV_eq_original (x : ℝ) :
    (coefficientV x : ℂ) = ActualCenteredMellin.V x := by
  by_cases hx : x ≤ 1
  · rw [ActualCriticalMellin.V_zero hx]
    simp [coefficientV, hx]
  · have hx1 : 1 < x := lt_of_not_ge hx
    have hx0 : 0 ≤ x := by linarith
    rw [ActualCenteredMellin.V_eq_real_cutoff hx0]
    have hb : EtaBaselineMellin.B x =
        ((x^2*Real.log x/2+x^2/4-1/4 : ℝ) : ℂ) := by
      simp only [EtaBaselineMellin.B, if_pos hx1]
      push_cast
      ring
    rw [hb]
    simp only [coefficientV, if_neg hx, coefficientRawV, Complex.ofReal_add,
      Complex.ofReal_sub]
    congr 1
    rw [← Complex.ofReal_sub]
    congr 1
    rw [← Finset.sum_sub_distrib]
    apply Finset.sum_congr rfl
    intro n hn
    ring

/-- The literal real every-multiple W is exactly the original complex actual W. -/
theorem W_eq_original (x : ℝ) :
    (PrimeHistoryFullW.W x : ℂ) = ActualCriticalMellin.W x := by
  rw [PrimeHistoryFullW.W_eq_existing_cutoffSum]
  have he : (fun y => (coefficientV y : ℂ)) = ActualCenteredMellin.V := by
    funext y
    exact coefficientV_eq_original y
  rw [he]
  rfl

/-- The complete original actual W has the proved signed-source harmonic readout. -/
theorem normalized_original_W {s : ℝ} (hs : 0 ≤ s) :
    (Real.exp (-3*s/2) : ℂ)*ActualCriticalMellin.W (Real.exp s) =
      ((PrimeHistoryFullW.harmonicAction PrimeHistoryFullW.core s : ℝ) : ℂ) := by
  rw [← W_eq_original, ← Complex.ofReal_mul, PrimeHistoryFullW.normalized_W_eq_harmonicAction hs]

#print axioms coefficientV_eq_original
#print axioms W_eq_original
#print axioms normalized_original_W

end BuildingBlocks.OriginalWIdentification
