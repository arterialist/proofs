import BuildingBlocks.PositiveTaylorMoments
import BuildingBlocks.PositiveExponentialMoments
import BuildingBlocks.LaplaceMomentDerivatives
import Mathlib.Analysis.Calculus.IteratedDeriv.Lemmas

open MeasureTheory Filter
open scoped Topology ENNReal BigOperators

namespace BuildingBlocks.LocalLandauExtension

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

/-- The real integral and the nonnegative moment used by Tonelli are identical.
The integrability hypothesis rules out any use of the totalized Bochner
integral at a divergent moment. -/
theorem lintegral_weighted_power_eq {τ : α → ℝ}
    (hτ0 : ∀ᵐ x ∂μ, 0 ≤ τ x) (k : ℕ) (c : ℝ)
    (hi : Integrable (fun x => (τ x)^k * Real.exp (-c * τ x)) μ) :
    (∫⁻ x, ENNReal.ofReal (Real.exp (-c * τ x)) *
      ENNReal.ofReal (τ x)^k ∂μ) =
      ENNReal.ofReal (∫ x, (τ x)^k * Real.exp (-c * τ x) ∂μ) := by
  have he : (∫⁻ x, ENNReal.ofReal (Real.exp (-c * τ x)) *
      ENNReal.ofReal (τ x)^k ∂μ) =
      ∫⁻ x, ENNReal.ofReal ((τ x)^k * Real.exp (-c * τ x)) ∂μ := by
    apply lintegral_congr_ae
    filter_upwards [hτ0] with x hx
    rw [← ENNReal.ofReal_pow hx, ← ENNReal.ofReal_mul (Real.exp_nonneg _)]
    congr 1
    ring
  rw [he]
  symm
  apply ofReal_integral_eq_lintegral_ofReal hi
  filter_upwards [hτ0] with x hx
  exact mul_nonneg (pow_nonneg hx _) (Real.exp_nonneg _)

/-- Local Landau extension for a genuine positive Laplace measure. A
holomorphic germ agreeing with the actual transform forces integrability
at each real point c-t inside the disk. The moments are derived from that
germ and a previously convergent parameter b<c, not assumed separately. -/
theorem integrable_of_analytic_germ {τ : α → ℝ} {F : ℂ → ℂ}
    {b c R t : ℝ} (hτ : Measurable τ) (hτ0 : ∀ᵐ x ∂μ, 0 ≤ τ x)
    (hb : Integrable (fun x => Real.exp (-b * τ x)) μ) (hc : b < c)
    (hF : DifferentiableOn ℂ F (Metric.ball (c : ℂ) R))
    (hgerm : F =ᶠ[𝓝 (c : ℂ)] LaplaceMomentDerivatives.moment μ τ 0)
    (ht : 0 ≤ t) (htR : t < R) :
    Integrable (fun x => Real.exp (-(c-t) * τ x)) μ := by
  let m : ℕ → ℝ := fun k => ∫ x, (τ x)^k * Real.exp (-c * τ x) ∂μ
  have hderiv (k : ℕ) :
      iteratedDeriv k F (c : ℂ) = (-1 : ℂ)^k * (m k : ℂ) := by
    rw [hgerm.iteratedDeriv_eq k]
    exact LaplaceMomentDerivatives.iteratedDeriv_moment_zero_ofReal hτ hτ0 hb hc k
  have htaylor := PositiveTaylorMoments.tsum_ofReal_lt_top hF hderiv ht htR
  have hmi (k : ℕ) : Integrable (fun x => (τ x)^k * Real.exp (-c * τ x)) μ :=
    LaplaceMomentDerivatives.integrable_real_moment hτ hτ0 hb hc k
  have hw : Measurable (fun x => ENNReal.ofReal (Real.exp (-c * τ x))) :=
    (Real.measurable_exp.comp (measurable_const.mul hτ)).ennreal_ofReal
  have htonelli := PositiveExponentialMoments.lintegral_exp_eq_tsum_moments_ae
    hτ hw hτ0 ht
  have hm (k : ℕ) :
      (∫⁻ x, ENNReal.ofReal (Real.exp (-c * τ x)) *
        ENNReal.ofReal (τ x)^k ∂μ) = ENNReal.ofReal (m k) :=
    lintegral_weighted_power_eq hτ0 k c (hmi k)
  have hterm (k : ℕ) :
      ENNReal.ofReal (t^k / k.factorial) * ENNReal.ofReal (m k) =
        ENNReal.ofReal (PositiveTaylorMoments.momentTerm m t k) := by
    rw [← ENNReal.ofReal_mul (div_nonneg (pow_nonneg ht _) (Nat.cast_nonneg _))]
    congr 1
    unfold PositiveTaylorMoments.momentTerm
    ring
  have hshift (x : α) : ENNReal.ofReal (Real.exp (-(c-t) * τ x)) =
      ENNReal.ofReal (Real.exp (-c * τ x)) *
        ENNReal.ofReal (Real.exp (t * τ x)) := by
    rw [← ENNReal.ofReal_mul (Real.exp_nonneg _), ← Real.exp_add]
    congr 2
    ring
  have hfinite : (∫⁻ x, ENNReal.ofReal (Real.exp (-(c-t) * τ x)) ∂μ) < ∞ := by
    simp_rw [hshift]
    rw [htonelli]
    simp_rw [hm, hterm]
    exact htaylor
  refine ⟨(Real.measurable_exp.comp (measurable_const.mul hτ)).aestronglyMeasurable, ?_⟩
  exact (hasFiniteIntegral_iff_ofReal
    (Filter.Eventually.of_forall fun x => Real.exp_nonneg _)).mpr hfinite

end BuildingBlocks.LocalLandauExtension
