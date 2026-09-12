import BuildingBlocks.MixedEnergySuccessorStep

/-! The actual gradient realization and bilinear form of mixed additive energy. -/

open MeasureTheory Real Set
open scoped ENNReal

namespace BuildingBlocks.MixedEnergy

noncomputable def lagMeasure : Measure ℝ :=
  volume.restrict (Ioo (0 : ℝ) 1) +
    (volume.restrict (Ioi (1 : ℝ))).withDensity (fun h => ENNReal.ofReal (1 / h ^ 2))

theorem lagMeasure_mass : lagMeasure univ = 2 := by
  rw [lagMeasure, Measure.add_apply, Measure.restrict_apply_univ,
    withDensity_apply _ MeasurableSet.univ, Measure.restrict_univ,
    inverse_square_tail (by norm_num : (0 : ℝ) < 1)]
  norm_num

instance lagMeasure_isFiniteMeasure : IsFiniteMeasure lagMeasure := by
  constructor
  rw [lagMeasure_mass]
  norm_num

noncomputable def gradientMeasure : Measure (ℝ × ℝ) := lagMeasure.prod volume

instance gradientMeasure_sfinite : SFinite gradientMeasure := by
  unfold gradientMeasure
  infer_instance

def gradient (H : ℝ → ℝ) (z : ℝ × ℝ) : ℝ := H z.2 - H (z.2 - z.1)

theorem measurable_gradient {H : ℝ → ℝ} (hH : Measurable H) : Measurable (gradient H) := by
  unfold gradient
  fun_prop

/-- The product measure includes both exact lag weights; no Fourier or
unweighted-L² representation is assumed. -/
theorem energy_eq_gradient {H : ℝ → ℝ} (hH : Measurable H) :
    energy H = ∫⁻ z, ENNReal.ofReal (gradient H z ^ 2) ∂gradientMeasure := by
  have hm : Measurable (fun z => ENNReal.ofReal (gradient H z ^ 2)) :=
    ((measurable_gradient hH).pow_const 2).ennreal_ofReal
  rw [gradientMeasure, lintegral_prod _ hm.aemeasurable]
  change energy H = ∫⁻ h, increment H h ∂lagMeasure
  rw [lagMeasure, lintegral_add_measure,
    lintegral_withDensity_eq_lintegral_mul _ (by fun_prop) (measurable_increment hH)]
  change energy H = shortEnergy H +
    ∫⁻ h in Ioi (1 : ℝ), ENNReal.ofReal (1 / h ^ 2) * increment H h
  rw [← longEnergy_eq]
  rfl

theorem gradient_memLp {H : ℝ → ℝ} (hH : Measurable H) (hE : energy H < ∞) :
    MemLp (gradient H) 2 gradientMeasure := by
  apply (memLp_two_iff_integrable_sq (measurable_gradient hH).aestronglyMeasurable).2
  constructor
  · exact ((measurable_gradient hH).pow_const 2).aestronglyMeasurable
  · rw [hasFiniteIntegral_iff_ofReal
      (Filter.Eventually.of_forall (fun z => sq_nonneg (gradient H z))), ← energy_eq_gradient hH]
    exact hE

theorem integral_gradient_square {H : ℝ → ℝ} (hH : Measurable H) (hE : energy H < ∞) :
    (∫ z, gradient H z ^ 2 ∂gradientMeasure) = (energy H).toReal := by
  rw [energy_eq_gradient hH, ← ofReal_integral_eq_lintegral_ofReal
    (gradient_memLp hH hE).integrable_sq
    (Filter.Eventually.of_forall (fun z => sq_nonneg (gradient H z))),
    ENNReal.toReal_ofReal (integral_nonneg (fun z => sq_nonneg (gradient H z)))]

noncomputable def bilinear (H G : ℝ → ℝ) : ℝ :=
  ∫ z, gradient H z * gradient G z ∂gradientMeasure

theorem bilinear_self {H : ℝ → ℝ} (hH : Measurable H) (hE : energy H < ∞) :
    bilinear H H = (energy H).toReal := by
  simpa only [bilinear, pow_two] using integral_gradient_square hH hE

theorem integral_mul_abs_le_sqrt {α : Type*} [MeasurableSpace α] {μ : Measure α}
    {f g : α → ℝ} (hf : MemLp f 2 μ) (hg : MemLp g 2 μ) :
    |∫ x, f x * g x ∂μ| ≤ sqrt (∫ x, f x ^ 2 ∂μ) * sqrt (∫ x, g x ^ 2 ∂μ) := by
  have h := integral_mul_norm_le_Lp_mul_Lq Real.HolderConjugate.two_two
    (by simpa using hf) (by simpa using hg)
  calc
    _ ≤ ∫ x, |f x| * |g x| ∂μ := by
      simpa only [Real.norm_eq_abs, abs_mul] using
        norm_integral_le_integral_norm (fun x => f x * g x)
    _ ≤ _ := by
      simpa only [Real.norm_eq_abs, Real.rpow_two, sq_abs, ← sqrt_eq_rpow] using h

theorem bilinear_bound {H G : ℝ → ℝ} (hH : Measurable H) (hG : Measurable G)
    (hE : energy H < ∞) (hF : energy G < ∞) :
    |bilinear H G| ≤ sqrt ((energy H).toReal) * sqrt ((energy G).toReal) := by
  have h := integral_mul_abs_le_sqrt (gradient_memLp hH hE) (gradient_memLp hG hF)
  rwa [integral_gradient_square hH hE, integral_gradient_square hG hF] at h

noncomputable def unitPair (H G : ℝ → ℝ) : ℝ :=
  ∫ x, (H x - H (x - 1)) * (G x - G (x - 1))

theorem integral_unit_square {H : ℝ → ℝ} (hH : Measurable H) (hE : energy H < ∞) :
    (∫ x, (H x - H (x - 1)) ^ 2) = (increment H 1).toReal := by
  rw [increment, ← ofReal_integral_eq_lintegral_ofReal
    (unit_step_memLp hH hE).integrable_sq
    (Filter.Eventually.of_forall (fun x => sq_nonneg (H x - H (x - 1)))),
    ENNReal.toReal_ofReal (integral_nonneg (fun x => sq_nonneg (H x - H (x - 1))))]

theorem integral_unit_square_le {H : ℝ → ℝ} (hH : Measurable H)
    (hE : energy H < ∞) :
    (∫ x, (H x - H (x - 1)) ^ 2) ≤ 4 * (energy H).toReal := by
  rw [integral_unit_square hH hE]
  have h := ENNReal.toReal_mono (by finiteness : (4 : ℝ≥0∞) * energy H ≠ ∞)
    (unit_step_le_energy hH)
  simpa using h

theorem unitPair_bound {H G : ℝ → ℝ} (hH : Measurable H) (hG : Measurable G)
    (hE : energy H < ∞) (hF : energy G < ∞) :
    |unitPair H G| ≤ 4 * sqrt ((energy H).toReal) * sqrt ((energy G).toReal) := by
  have hs (F : ℝ → ℝ) (hm : Measurable F) (he : energy F < ∞) :
      sqrt (∫ x, (F x - F (x - 1)) ^ 2) ≤ 2 * sqrt ((energy F).toReal) := by
    calc
      _ ≤ sqrt (4 * (energy F).toReal) := sqrt_le_sqrt (integral_unit_square_le hm he)
      _ = _ := by
        rw [sqrt_mul (by norm_num : (0 : ℝ) ≤ 4),
          show sqrt (4 : ℝ) = 2 by
            rw [show (4 : ℝ) = 2 ^ 2 by norm_num, sqrt_sq (by norm_num : (0 : ℝ) ≤ 2)]]
  calc
    _ ≤ sqrt (∫ x, (H x - H (x - 1)) ^ 2) *
        sqrt (∫ x, (G x - G (x - 1)) ^ 2) :=
      integral_mul_abs_le_sqrt (unit_step_memLp hH hE) (unit_step_memLp hG hF)
    _ ≤ (2 * sqrt ((energy H).toReal)) * (2 * sqrt ((energy G).toReal)) :=
      mul_le_mul (hs H hH hE) (hs G hG hF) (sqrt_nonneg _) (by positivity)
    _ = _ := by ring

/-- The contact form on the energy domain. Identifying it with the original
conjugated kernel operator requires a separate operator identity. -/
noncomputable def contactForm (H G : ℝ → ℝ) : ℝ := bilinear H G - 2 * unitPair H G

theorem contactForm_bound {H G : ℝ → ℝ} (hH : Measurable H) (hG : Measurable G)
    (hE : energy H < ∞) (hF : energy G < ∞) :
    |contactForm H G| ≤ 9 * sqrt ((energy H).toReal) * sqrt ((energy G).toReal) := by
  have hb := bilinear_bound hH hG hE hF
  have hu := unitPair_bound hH hG hE hF
  calc
    _ ≤ |bilinear H G| + 2 * |unitPair H G| := by
      simpa only [contactForm, abs_mul, abs_of_pos (by norm_num : (0 : ℝ) < 2)] using
        abs_sub (bilinear H G) (2 * unitPair H G)
    _ ≤ _ := by nlinarith

end BuildingBlocks.MixedEnergy
