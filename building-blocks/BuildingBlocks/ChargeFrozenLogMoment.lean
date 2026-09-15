import BuildingBlocks.ChargeFrozenSpectralBound
import BuildingBlocks.LogarithmicLayercake
import Mathlib.MeasureTheory.Integral.Prod

open MeasureTheory Set

namespace BuildingBlocks.ChargeFrozenLogMoment

open ChargeFrozenSource ChargeFrozenSpectralBound

noncomputable def hat (N : ℕ) (ξ : ℝ) : ℂ :=
  ∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (causalSource N v : ℂ)

noncomputable def density (N : ℕ) (ξ : ℝ) : ℝ := ‖hat N ξ‖ ^ 2

noncomputable def envelope (N : ℕ) : ℝ := 4 * (8 * Real.log 2 + 2) ^ 2 * (N : ℝ)

noncomputable def mass (N : ℕ) : ℝ := ∫ ξ : ℝ, density N ξ

theorem measurable_hat (N : ℕ) : Measurable (hat N) := by
  have hs : Measurable (fun p : ℝ × ℝ => (causalSource N p.2 : ℂ)) :=
    Complex.continuous_ofReal.measurable.comp
      ((ChargeFrozenMetric.measurable_causalSource N).comp measurable_snd)
  have hp : Measurable (fun p : ℝ × ℝ =>
      Complex.exp (-Complex.I * (p.1 : ℂ) * (p.2 : ℂ))) := by fun_prop
  exact ((hp.mul hs).stronglyMeasurable.integral_prod_right').measurable

theorem measurable_density (N : ℕ) : Measurable (density N) :=
  (measurable_hat N).norm.pow_const 2

theorem density_nonnegative (N : ℕ) (ξ : ℝ) : 0 ≤ density N ξ := sq_nonneg _

theorem density_le_envelope {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    density N ξ ≤ envelope N / (1 + ξ ^ 2) := fourier_norm_sq_le hN ξ

theorem integrable_density {N : ℕ} (hN : 2 ≤ N) : Integrable (density N) := by
  apply (integrable_inv_one_add_sq.const_mul (envelope N)).mono'
    (measurable_density N).aestronglyMeasurable
  filter_upwards [] with ξ
  simpa only [Real.norm_eq_abs, abs_of_nonneg (density_nonnegative N ξ), div_eq_mul_inv]
    using density_le_envelope hN ξ

/-- The logarithmic-moment theorem applied to the actual whole-frequency
frozen-source density. Zero mass is covered without a positive-denominator premise. -/
theorem actual_log_moment {N : ℕ} (hN : 2 ≤ N) :
    Integrable (fun ξ : ℝ => density N ξ * Real.log (2 + |ξ|)) ∧
    (∫ ξ : ℝ, density N ξ * Real.log (2 + |ξ|)) ≤
      mass N * (Real.log 2 + Real.log (1 + envelope N / mass N) + 1) := by
  have hE : 0 < envelope N := by
    unfold envelope
    have hNp : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
    positivity
  exact LogarithmicLayercake.density_log_moment_nonnegative_mass
    (measurable_density N) (integrable_density hN) (density_nonnegative N) hE
    (integral_nonneg (density_nonnegative N)) rfl (density_le_envelope hN)

#print axioms measurable_hat
#print axioms measurable_density
#print axioms density_le_envelope
#print axioms integrable_density
#print axioms actual_log_moment

end BuildingBlocks.ChargeFrozenLogMoment
