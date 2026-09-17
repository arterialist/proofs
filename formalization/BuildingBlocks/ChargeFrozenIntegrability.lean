import BuildingBlocks.ChargeFrozenMetric

open MeasureTheory Set

namespace BuildingBlocks.ChargeFrozenIntegrability

open CoarsePrimitive ChargeFrozenSource ChargeFrozenMetric

/-- The literal frozen source has a finite exponentially decaying majorant. -/
theorem source_abs_le {N : ℕ} (v : ℝ) (hv : 0 ≤ v) :
    |causalSource N v| ≤ (psi N + (N : ℝ)) * Real.exp (-v / 2) := by
  let x := min (Real.exp v) (N : ℝ)
  have hx0 : 0 ≤ x := le_min (Real.exp_pos _).le (Nat.cast_nonneg N)
  have hxN : x ≤ N := min_le_right _ _
  have hfloor : ⌊x⌋₊ ≤ N := by
    exact_mod_cast (Nat.floor_le hx0).trans hxN
  have hp0 := psi_nonneg ⌊x⌋₊
  have hpN := psi_mono hfloor
  have hab : |psi ⌊x⌋₊ - x| ≤ psi N + (N : ℝ) := by
    apply abs_le.mpr
    constructor <;> linarith
  rw [causalSource_of_nonnegative N hv]
  change |Real.exp (-v / 2) * (psi ⌊x⌋₊ - x)| ≤ _
  rw [abs_mul, abs_of_pos (Real.exp_pos _), mul_comm]
  exact mul_le_mul_of_nonneg_right hab (Real.exp_pos _).le

/-- Global L¹ membership keeps the origin, density and complete frozen tail. -/
theorem integrable_causalSource (N : ℕ) : Integrable (causalSource N) := by
  have he : IntegrableOn (fun v : ℝ => Real.exp (-v / 2)) (Ici (0 : ℝ)) := by
    apply Iff.mpr integrableOn_Ici_iff_integrableOn_Ioi
    convert integrableOn_exp_mul_Ioi
      (by norm_num : (- (1 / 2) : ℝ) < 0) (0 : ℝ) using 1
    funext v
    congr 1
    ring
  have hc : IntegrableOn (fun v : ℝ => (psi N + (N : ℝ)) * Real.exp (-v / 2))
      (Ici (0 : ℝ)) := he.const_mul _
  have hi := hc.integrable_indicator measurableSet_Ici
  apply hi.mono' (measurable_causalSource N).aestronglyMeasurable
  filter_upwards [] with v
  by_cases hv : 0 ≤ v
  · simpa only [Real.norm_eq_abs, indicator_of_mem (show v ∈ Ici (0 : ℝ) from hv)]
      using source_abs_le (N := N) v hv
  · rw [causalSource_of_negative N (lt_of_not_ge hv)]
    simp [hv]

/-- Absolute convergence of the actual angular-frequency Fourier integral. -/
theorem integrable_fourier_integrand (N : ℕ) (ξ : ℝ) :
    Integrable (fun v : ℝ => Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) *
      (causalSource N v : ℂ)) := by
  apply (integrable_causalSource N).ofReal.bdd_mul
  · exact (by fun_prop : Continuous (fun v : ℝ =>
      Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)))).aestronglyMeasurable
  · refine ⟨1, fun v => ?_⟩
    simp [Complex.norm_exp, Complex.mul_re, Complex.mul_im]

#print axioms source_abs_le
#print axioms integrable_causalSource
#print axioms integrable_fourier_integrand

end BuildingBlocks.ChargeFrozenIntegrability
