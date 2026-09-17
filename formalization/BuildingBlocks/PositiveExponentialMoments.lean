import Mathlib.Analysis.SpecialFunctions.Exponential
import Mathlib.Analysis.SpecificLimits.Basic
import Mathlib.MeasureTheory.Integral.Lebesgue.Add
import Mathlib.MeasureTheory.Function.L1Space.Integrable

open MeasureTheory
open scoped ENNReal NNReal BigOperators

namespace BuildingBlocks.PositiveExponentialMoments

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

/-- Tonelli's exponential-moment identity, allowing either side to be infinite.
No integrability or absolute convergence is assumed in this identity. -/
theorem lintegral_exp_eq_tsum {τ : α → ℝ} {w : α → ℝ≥0∞}
    (hτ : Measurable τ) (hw : Measurable w) (hτ0 : ∀ x, 0 ≤ τ x)
    {t : ℝ} (ht : 0 ≤ t) :
    (∫⁻ x, w x * ENNReal.ofReal (Real.exp (t * τ x)) ∂μ) =
      ∑' k : ℕ, ∫⁻ x, w x * ENNReal.ofReal ((t * τ x)^k / k.factorial) ∂μ := by
  have he (x : α) : ENNReal.ofReal (Real.exp (t * τ x)) =
      ∑' k : ℕ, ENNReal.ofReal ((t * τ x)^k / k.factorial) := by
    have hs := NormedSpace.expSeries_div_hasSum_exp (𝕂 := ℝ) (t * τ x)
    rw [← Real.exp_eq_exp_ℝ] at hs
    rw [← hs.tsum_eq]
    exact ENNReal.ofReal_tsum_of_nonneg (fun k => div_nonneg (pow_nonneg (mul_nonneg ht (hτ0 x)) k) (by positivity)) hs.summable
  simp_rw [he, ← ENNReal.tsum_mul_left]
  exact lintegral_tsum (fun k =>
    (hw.mul (((measurable_const.mul hτ).pow_const k).div_const _).ennreal_ofReal).aemeasurable)

/-- The coefficients are the actual nonnegative moments of the original measure. -/
theorem lintegral_exp_eq_tsum_moments {τ : α → ℝ} {w : α → ℝ≥0∞}
    (hτ : Measurable τ) (hw : Measurable w) (hτ0 : ∀ x, 0 ≤ τ x)
    {t : ℝ} (ht : 0 ≤ t) :
    (∫⁻ x, w x * ENNReal.ofReal (Real.exp (t * τ x)) ∂μ) =
      ∑' k : ℕ, ENNReal.ofReal (t^k / k.factorial) *
        ∫⁻ x, w x * ENNReal.ofReal (τ x)^k ∂μ := by
  rw [lintegral_exp_eq_tsum hτ hw hτ0 ht]
  apply tsum_congr
  intro k
  have he (x : α) : w x * ENNReal.ofReal ((t * τ x)^k / k.factorial) =
      ENNReal.ofReal (t^k / k.factorial) * (w x * ENNReal.ofReal (τ x)^k) := by
    rw [mul_pow, show t^k * τ x^k / (k.factorial : ℝ) =
      (t^k / k.factorial) * τ x^k by ring,
      ENNReal.ofReal_mul (by positivity), ENNReal.ofReal_pow (hτ0 x)]
    ring
  simp_rw [he]
  exact lintegral_const_mul _ (hw.mul (hτ.ennreal_ofReal.pow_const k))

/-- A finite bound on the nonnegative Taylor moment series gives a genuinely
finite exponential integral, not merely an analytic continuation value. -/
theorem exponential_moment_finite_of_tsum_moments_lt_top
    {τ : α → ℝ} {w : α → ℝ≥0∞}
    (hτ : Measurable τ) (hw : Measurable w) (hτ0 : ∀ x, 0 ≤ τ x)
    {t : ℝ} (ht : 0 ≤ t)
    (hbound : (∑' k : ℕ, ENNReal.ofReal (t^k / k.factorial) *
      ∫⁻ x, w x * ENNReal.ofReal (τ x)^k ∂μ) < ∞) :
    (∫⁻ x, w x * ENNReal.ofReal (Real.exp (t * τ x)) ∂μ) < ∞ := by
  rwa [lintegral_exp_eq_tsum_moments hτ hw hτ0 ht]

/-- The remaining analytic input can be supplied as a geometric Cauchy bound
on the actual Taylor coefficients. This theorem turns that bound into a finite
integral with its explicit majorant. -/
theorem exponential_moment_le_of_geometric_bound
    {τ : α → ℝ} {w : α → ℝ≥0∞}
    (hτ : Measurable τ) (hw : Measurable w) (hτ0 : ∀ x, 0 ≤ τ x)
    {t : ℝ} (ht : 0 ≤ t) {C r : ℝ≥0∞}
    (hbound : ∀ k : ℕ, ENNReal.ofReal (t^k / k.factorial) *
      (∫⁻ x, w x * ENNReal.ofReal (τ x)^k ∂μ) ≤ C * r^k) :
    (∫⁻ x, w x * ENNReal.ofReal (Real.exp (t * τ x)) ∂μ) ≤
      C * (1-r)⁻¹ := by
  rw [lintegral_exp_eq_tsum_moments hτ hw hτ0 ht]
  calc
    _ ≤ ∑' k : ℕ, C * r^k := ENNReal.tsum_le_tsum hbound
    _ = C * (1-r)⁻¹ := by rw [ENNReal.tsum_mul_left, ENNReal.tsum_geometric]

theorem exponential_moment_lt_top_of_geometric_bound
    {τ : α → ℝ} {w : α → ℝ≥0∞}
    (hτ : Measurable τ) (hw : Measurable w) (hτ0 : ∀ x, 0 ≤ τ x)
    {t : ℝ} (ht : 0 ≤ t) {C r : ℝ≥0∞} (hC : C < ∞) (hr : r < 1)
    (hbound : ∀ k : ℕ, ENNReal.ofReal (t^k / k.factorial) *
      (∫⁻ x, w x * ENNReal.ofReal (τ x)^k ∂μ) ≤ C * r^k) :
    (∫⁻ x, w x * ENNReal.ofReal (Real.exp (t * τ x)) ∂μ) < ∞ := by
  apply lt_of_le_of_lt (exponential_moment_le_of_geometric_bound hτ hw hτ0 ht hbound)
  exact ENNReal.mul_lt_top hC (by simpa using hr)

/-- The support condition need only hold almost everywhere. -/
theorem lintegral_exp_eq_tsum_moments_ae {τ : α → ℝ} {w : α → ℝ≥0∞}
    (hτ : Measurable τ) (hw : Measurable w) (hτ0 : ∀ᵐ x ∂μ, 0 ≤ τ x)
    {t : ℝ} (ht : 0 ≤ t) :
    (∫⁻ x, w x * ENNReal.ofReal (Real.exp (t * τ x)) ∂μ) =
      ∑' k : ℕ, ENNReal.ofReal (t^k / k.factorial) *
        ∫⁻ x, w x * ENNReal.ofReal (τ x)^k ∂μ := by
  have he : (fun x => max (τ x) 0) =ᵐ[μ] τ := by
    filter_upwards [hτ0] with x hx
    exact max_eq_left hx
  calc
    _ = ∫⁻ x, w x * ENNReal.ofReal (Real.exp (t * max (τ x) 0)) ∂μ := by
      apply lintegral_congr_ae
      filter_upwards [he] with x hx
      rw [hx]
    _ = ∑' k : ℕ, ENNReal.ofReal (t^k / k.factorial) *
        ∫⁻ x, w x * ENNReal.ofReal (max (τ x) 0)^k ∂μ :=
      lintegral_exp_eq_tsum_moments (hτ.max measurable_const) hw
        (fun x => le_max_right _ _) ht
    _ = _ := by
      apply tsum_congr
      intro k
      congr 1
      apply lintegral_congr_ae
      filter_upwards [he] with x hx
      rw [hx]

end BuildingBlocks.PositiveExponentialMoments
