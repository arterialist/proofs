import BuildingBlocks.GoldbachHeatCarryWork

open Real Set MeasureTheory
namespace BuildingBlocks.GoldbachHeat
open BuildingBlocks.IntegerCarryPhase

theorem common_heat_phase_integral (X : ℝ) (hX : 1 ≤ X) :
    (∫ x in (1 : ℝ)..X, bernoulliOne x * heatEnergyWeight x) =
      unitPrimitive X * heatEnergyWeight X -
        ∫ x in (1 : ℝ)..X, unitPrimitive x * heatEnergyWeightDerivative x := by
  have hs : uIcc (1 : ℝ) X ⊆ Ioi 0 := by
    rw [uIcc_of_le hX]
    intro x hx
    exact lt_of_lt_of_le zero_lt_one hx.1
  have hb : IntervalIntegrable bernoulliOne volume 1 X := by
    have hm : Measurable bernoulliOne := by unfold bernoulliOne; fun_prop
    apply (intervalIntegrable_const (c := (1 / 2 : ℝ))).mono_fun' hm.aestronglyMeasurable
    exact Filter.Eventually.of_forall (fun x => by simpa [Real.norm_eq_abs] using bernoulliOne_abs_le x)
  have hi := hb.mul_continuousOn (heatEnergyWeight_continuousOn.mono hs)
  have hj := (unitPrimitive_continuous.continuousOn.mul
    (heatEnergyWeightDerivative_continuousOn.mono hs)).intervalIntegrable (μ := volume)
  have he : (∫ x in (1 : ℝ)..X, bernoulliOne x * heatEnergyWeight x +
      unitPrimitive x * heatEnergyWeightDerivative x) = unitPrimitive X * heatEnergyWeight X -
      unitPrimitive 1 * heatEnergyWeight 1 := by
    apply intervalIntegral.integral_eq_sub_of_hasDeriv_right
      (unitPrimitive_continuous.continuousOn.mul (heatEnergyWeight_continuousOn.mono hs))
    · intro x hx
      have hp : 0 < x := by
        have hh : 1 < x := by simpa [min_eq_left hX] using hx.1
        linarith
      exact (unitPrimitive_hasDerivWithinAt_right x).mul
        (heatEnergyWeight_hasDerivAt hp).hasDerivWithinAt
    · exact hi.add hj
  rw [intervalIntegral.integral_add hi hj] at he
  have hz : unitPrimitive 1 = 0 := by norm_num [unitPrimitive, Int.fract]
  rw [hz, zero_mul, sub_zero] at he
  linarith

theorem heat_carry_compensation (r X : ℝ) (hr : 0 < r) (hX : 1 ≤ X) :
    (∫ x in (1 : ℝ)..X, phase r x * heatEnergyWeight x) -
      r * (∫ x in (1 : ℝ)..X, bernoulliOne x * heatEnergyWeight x) =
      -unitPrimitive (r * X) * heatEnergyWeight X / r +
        unitPrimitive r * heatEnergyWeight 1 / r +
          (∫ x in (1 : ℝ)..X, unitPrimitive (r * x) * heatEnergyWeightDerivative x) / r := by
  have hs : uIcc (1 : ℝ) X ⊆ Ioi 0 := by
    rw [uIcc_of_le hX]
    intro x hx
    exact lt_of_lt_of_le zero_lt_one hx.1
  have hg := (unitPrimitive_continuous.continuousOn.mul
    (heatEnergyWeightDerivative_continuousOn.mono hs)).intervalIntegrable (μ := volume)
  have hh := ((unitPrimitive_continuous.comp ((continuous_const (y := r)).mul continuous_id)).continuousOn.mul
    (heatEnergyWeightDerivative_continuousOn.mono hs)).intervalIntegrable (μ := volume)
  change IntervalIntegrable (fun x => unitPrimitive (r * x) * heatEnergyWeightDerivative x)
    volume 1 X at hh
  have he : (∫ x in (1 : ℝ)..X, primitiveFormula r x * heatEnergyWeightDerivative x) =
      r * (∫ x in (1 : ℝ)..X, unitPrimitive x * heatEnergyWeightDerivative x) -
        (∫ x in (1 : ℝ)..X, unitPrimitive (r * x) * heatEnergyWeightDerivative x) / r := by
    have hf : (fun x => primitiveFormula r x * heatEnergyWeightDerivative x) =
        (fun x => r * (unitPrimitive x * heatEnergyWeightDerivative x) -
          (unitPrimitive (r * x) * heatEnergyWeightDerivative x) / r) := by
      funext x
      unfold primitiveFormula
      ring
    rw [hf, intervalIntegral.integral_sub (hg.const_mul r) (hh.div_const r),
      intervalIntegral.integral_const_mul, intervalIntegral.integral_div]
  rw [heat_phase_integrationByParts r X hr hX, common_heat_phase_integral X hX, he]
  unfold primitiveFormula
  ring

#print axioms heat_carry_compensation
#print axioms common_heat_phase_integral
end BuildingBlocks.GoldbachHeat
