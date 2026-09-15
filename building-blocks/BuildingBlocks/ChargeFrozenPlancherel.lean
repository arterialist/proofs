import BuildingBlocks.ChargeFrozenFourierNorm
import BuildingBlocks.AngularFourierConvolution

open MeasureTheory
open scoped FourierTransform

namespace BuildingBlocks.ChargeFrozenPlancherel

open ChargeFrozenSource ChargeFrozenLogMoment ChargeFrozenFourierNorm
open AngularFourierConvolution

noncomputable def complexCorrelation (N : ℕ) (h : ℝ) : ℂ := autocorrelation N h

theorem complexCorrelation_eq_convolution (N : ℕ) (h : ℝ) :
    complexCorrelation N h = convolution (complexSource N)
      (fun v : ℝ => complexSource N (-v)) (ContinuousLinearMap.mul ℂ ℂ) volume (-h) := by
  unfold complexCorrelation autocorrelation
  rw [← integral_complex_ofReal]
  apply integral_congr_ae
  filter_upwards [] with v
  simp only [ContinuousLinearMap.mul_apply', complexSource, Complex.ofReal_mul]
  have he : -(-h - v) = v + h := by ring
  rw [he, mul_comm]

/-- Full Fubini identification of the literal autocorrelation transform. -/
theorem transform_complexCorrelation (N : ℕ) (ξ : ℝ) :
    transform (complexCorrelation N) ξ = (density N ξ : ℂ) := by
  have he : complexCorrelation N = fun h : ℝ =>
      convolution (complexSource N) (fun v : ℝ => complexSource N (-v))
        (ContinuousLinearMap.mul ℂ ℂ) volume (-h) := by
    funext h
    exact complexCorrelation_eq_convolution N h
  have ha : Integrable (complexSource N) :=
    (ChargeFrozenIntegrability.integrable_causalSource N).ofReal
  rw [he, transform_reflect, transform_convolution ha ha.comp_neg,
    transform_reflect, neg_neg]
  change transform (fun v : ℝ => (causalSource N v : ℂ)) (-ξ) * hat N ξ = _
  rw [transform_real_conj]
  change starRingEnd ℂ (hat N ξ) * hat N ξ = (‖hat N ξ‖ ^ 2 : ℝ)
  rw [← Complex.normSq_eq_conj_mul_self, Complex.normSq_eq_norm_sq]

theorem mathlib_fourier_complexCorrelation (N : ℕ) (y : ℝ) :
    𝓕 (complexCorrelation N) y = (density N (2 * Real.pi * y) : ℂ) := by
  have he := transform_eq_mathlib (complexCorrelation N) (2 * Real.pi * y)
  have hf : (2 * Real.pi * y) / (2 * Real.pi) = y := by field_simp
  rw [hf] at he
  rw [← he, transform_complexCorrelation]

theorem integrable_fourier_complexCorrelation {N : ℕ} (hN : 2 ≤ N) :
    Integrable (𝓕 (complexCorrelation N)) := by
  have hπ : 2 * Real.pi ≠ 0 := by positivity
  have ho : Integrable (fun ξ : ℝ => (density N ξ : ℂ)) volume :=
    (integrable_density hN).ofReal
  have hi := ho.comp_mul_left' hπ
  have he : 𝓕 (complexCorrelation N) = fun y : ℝ => (density N (2 * Real.pi * y) : ℂ) := by
    funext y
    exact mathlib_fourier_complexCorrelation N y
  rw [he]
  exact hi

theorem integrable_complexCorrelation (N : ℕ) : Integrable (complexCorrelation N) :=
  (integrable_autocorrelation N).ofReal

theorem continuousAt_complexCorrelation_zero {N : ℕ} (hN : 2 ≤ N) :
    ContinuousAt (complexCorrelation N) 0 :=
  Complex.continuous_ofReal.continuousAt.comp (continuousAt_autocorrelation_zero hN)

/-- Real-line Plancherel for the actual finite frozen source, obtained through
the full autocorrelation, inversion at zero and the angular-frequency Jacobian. -/
theorem mass_eq_physical_norm {N : ℕ} (hN : 2 ≤ N) :
    mass N = (2 * Real.pi) * ∫ v : ℝ, (causalSource N v) ^ 2 := by
  have hi := (integrable_complexCorrelation N).fourier_inversion
    (integrable_fourier_complexCorrelation hN) (continuousAt_complexCorrelation_zero hN)
  have hzero : 𝓕⁻ (𝓕 (complexCorrelation N)) (0 : ℝ) =
      ∫ y : ℝ, 𝓕 (complexCorrelation N) y := by
    simp [Real.fourierIntegralInv, VectorFourier.fourierIntegral]
  rw [hzero] at hi
  simp_rw [mathlib_fourier_complexCorrelation] at hi
  rw [integral_complex_ofReal] at hi
  have hreal : (∫ y : ℝ, density N (2 * Real.pi * y)) =
      ∫ v : ℝ, (causalSource N v) ^ 2 := by
    have hh := congrArg Complex.re hi
    simpa only [Complex.ofReal_re, complexCorrelation, autocorrelation_zero] using hh
  rw [Measure.integral_comp_mul_left] at hreal
  have hp : 0 < 2 * Real.pi := by positivity
  rw [abs_of_pos (inv_pos.mpr hp), smul_eq_mul] at hreal
  have he : mass N / (2 * Real.pi) = ∫ v : ℝ, (causalSource N v) ^ 2 := by
    simpa only [mass, div_eq_mul_inv, mul_comm] using hreal
  simpa only [mul_comm] using (div_eq_iff hp.ne').mp he

theorem mass_eq_prefix_terminal {N : ℕ} (hN : 2 ≤ N) :
    mass N = (2 * Real.pi) *
      ((∫ v in Set.Ioc 0 (Real.log (N : ℝ)), (causalSource N v) ^ 2) +
        (CoarsePrimitive.psi N - (N : ℝ)) ^ 2 / (N : ℝ)) := by
  rw [mass_eq_physical_norm hN, square_integral_eq_causal N,
    ChargeFrozenMetric.full_square_integral_split hN]

theorem actual_log_moment_physical {N : ℕ} (hN : 2 ≤ N) :
    Integrable (fun ξ : ℝ => density N ξ * Real.log (2 + |ξ|)) ∧
    (∫ ξ : ℝ, density N ξ * Real.log (2 + |ξ|)) ≤
      ((2 * Real.pi) * ∫ v : ℝ, (causalSource N v) ^ 2) *
        (Real.log 2 + Real.log (1 + envelope N /
          ((2 * Real.pi) * ∫ v : ℝ, (causalSource N v) ^ 2)) + 1) := by
  have hi := actual_log_moment hN
  rw [mass_eq_physical_norm hN] at hi
  exact hi

#print axioms transform_complexCorrelation
#print axioms integrable_fourier_complexCorrelation
#print axioms mass_eq_physical_norm
#print axioms mass_eq_prefix_terminal
#print axioms actual_log_moment_physical

end BuildingBlocks.ChargeFrozenPlancherel
