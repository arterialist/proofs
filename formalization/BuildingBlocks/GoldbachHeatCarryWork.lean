import BuildingBlocks.GoldbachHeatProfileDerivative
import BuildingBlocks.IntegerCarryIntegrationByParts

open Real Set MeasureTheory

namespace BuildingBlocks.GoldbachHeat
open BuildingBlocks.IntegerCarryPhase

noncomputable def heatEnergyWeight (x : ℝ) : ℝ := criticalHeatProfile (log x) ^ 2 / x
noncomputable def heatEnergyWeightDerivative (x : ℝ) : ℝ :=
  (2 * criticalHeatProfile (log x) * criticalHeatProfileDerivative (log x) -
    criticalHeatProfile (log x) ^ 2) / x ^ 2

theorem heatEnergyWeight_hasDerivAt {x : ℝ} (hx : 0 < x) :
    HasDerivAt heatEnergyWeight (heatEnergyWeightDerivative x) x := by
  have hh := (criticalHeatProfile_hasDerivAt (log x)).comp x (hasDerivAt_log (ne_of_gt hx))
  convert (hh.pow 2).div (hasDerivAt_id x) (ne_of_gt hx) using 1
  unfold heatEnergyWeightDerivative
  simp only [id_eq, Function.comp_apply, Pi.pow_apply]
  field_simp
  ring

theorem heatEnergyWeight_continuousOn : ContinuousOn heatEnergyWeight (Ioi 0) := by
  intro x hx
  exact (heatEnergyWeight_hasDerivAt hx).continuousAt.continuousWithinAt

theorem heatEnergyWeightDerivative_continuousOn :
    ContinuousOn heatEnergyWeightDerivative (Ioi 0) := by
  have hb : Continuous criticalHeatProfile := continuous_iff_continuousAt.mpr criticalHeatProfile_continuous
  have hl : ContinuousOn log (Ioi 0) := continuousOn_log.mono (fun x hx => ne_of_gt hx)
  unfold heatEnergyWeightDerivative
  exact ((continuousOn_const.mul (hb.comp_continuousOn hl)).mul
    (criticalHeatProfileDerivative_continuous.comp_continuousOn hl) |>.sub
      ((hb.comp_continuousOn hl).pow 2)).div (continuousOn_id.pow 2)
        (fun x hx => pow_ne_zero 2 (ne_of_gt hx))

theorem heat_phase_integrationByParts (r X : ℝ) (hr : 0 < r) (hX : 1 ≤ X) :
    (∫ x in (1 : ℝ)..X, phase r x * heatEnergyWeight x) =
      primitiveFormula r X * heatEnergyWeight X + unitPrimitive r * heatEnergyWeight 1 / r -
        ∫ x in (1 : ℝ)..X, primitiveFormula r x * heatEnergyWeightDerivative x := by
  have hs : uIcc (1 : ℝ) X ⊆ Ioi 0 := by
    rw [uIcc_of_le hX]
    intro x hx
    exact lt_of_lt_of_le zero_lt_one hx.1
  rw [phase_integrationByParts_local r 1 X hr heatEnergyWeight heatEnergyWeightDerivative
    (heatEnergyWeight_continuousOn.mono hs) (heatEnergyWeightDerivative_continuousOn.mono hs)
    (fun x hx => heatEnergyWeight_hasDerivAt (by
      have hh : 1 < x := by simpa [min_eq_left hX] using hx.1
      linarith)), primitiveFormula_one]
  ring

theorem heat_nat_phase_integrationByParts (m : ℕ) (X : ℝ) (hm : 0 < m) (hX : 1 ≤ X) :
    (∫ x in (1 : ℝ)..X, phase (m : ℝ) x * heatEnergyWeight x) =
      primitiveFormula (m : ℝ) X * heatEnergyWeight X -
        ∫ x in (1 : ℝ)..X, primitiveFormula (m : ℝ) x * heatEnergyWeightDerivative x := by
  have hz : unitPrimitive (m : ℝ) = 0 := by simp [unitPrimitive, Int.fract]
  rw [heat_phase_integrationByParts (m : ℝ) X (by exact_mod_cast hm) hX, hz]
  ring

#print axioms heat_nat_phase_integrationByParts
#print axioms heatEnergyWeight_hasDerivAt
#print axioms heatEnergyWeight_continuousOn
#print axioms heatEnergyWeightDerivative_continuousOn
#print axioms heat_phase_integrationByParts
end BuildingBlocks.GoldbachHeat
