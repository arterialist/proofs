import BuildingBlocks.SpectralTailMass
import Mathlib.MeasureTheory.Integral.Layercake
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap

/-! Non-circular layer-cake control of the logarithmic spectral moment. -/
noncomputable section
open Set MeasureTheory
open scoped ENNReal
namespace BuildingBlocks.LogarithmicLayercake

lemma reciprocal_intervalIntegrable {t : ℝ} (ht : 0 ≤ t) :
    IntervalIntegrable (fun x : ℝ => 1 / (2+x)) volume 0 t := by
  apply ContinuousOn.intervalIntegrable
  apply ContinuousOn.div continuousOn_const (continuousOn_const.add continuousOn_id)
  intro x hx
  rw [uIcc_of_le ht] at hx
  have hx0 : 0 ≤ x := hx.1
  positivity

lemma reciprocal_primitive {t : ℝ} (ht : 0 ≤ t) :
    (∫ x : ℝ in 0..t, 1 / (2+x)) = Real.log (2+t)-Real.log 2 := by
  rw [intervalIntegral.integral_comp_add_left (fun x : ℝ => 1/x) 2]
  norm_num only [add_zero]
  rw [integral_one_div_of_pos (by norm_num) (by positivity), Real.log_div (by positivity) (by norm_num)]

lemma logarithmic_layercake (μ : Measure ℝ) :
    (∫⁻ x : ℝ, ENNReal.ofReal (Real.log (2+|x|)-Real.log 2) ∂μ) =
      ∫⁻ t in Ioi (0 : ℝ), μ {x : ℝ | t < |x|} * ENNReal.ofReal (1/(2+t)) := by
  have hc := lintegral_comp_eq_lintegral_meas_lt_mul μ
    (Filter.Eventually.of_forall (fun x : ℝ => abs_nonneg x))
    continuous_abs.measurable.aemeasurable
    (fun t ht => reciprocal_intervalIntegrable ht.le)
    (by filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
        have ht0 : 0 < t := ht
        positivity)
  convert hc using 1
  apply lintegral_congr
  intro x
  rw [reciprocal_primitive (abs_nonneg x)]

lemma logarithmic_layercake_le {μ : Measure ℝ} {H A R : ℝ}
    (hH : 0 ≤ H) (hA : 0 ≤ A) (hR : 0 < R)
    (hb : ∀ t > 0, μ {x : ℝ | t < |x|} ≤
      min (ENNReal.ofReal H) (ENNReal.ofReal (2*A/t))) :
    (∫⁻ x : ℝ, ENNReal.ofReal (Real.log (2+|x|)-Real.log 2) ∂μ) ≤
      ENNReal.ofReal (H*(Real.log (2+R)-Real.log 2)+2*A/R) := by
  rw [logarithmic_layercake]
  have hs : Ioi (0 : ℝ) = Ioc 0 R ∪ Ioi R := by
    ext t
    simp only [mem_union, mem_Ioi, mem_Ioc]
    constructor
    · intro ht
      by_cases h : t ≤ R
      · exact Or.inl ⟨ht,h⟩
      · exact Or.inr (lt_of_not_ge h)
    · rintro (ht | ht)
      · exact ht.1
      · exact hR.trans ht
  have hd : Disjoint (Ioc (0 : ℝ) R) (Ioi R) := by
    apply disjoint_left.mpr
    intro t ht hu
    exact (not_lt_of_ge ht.2) hu
  rw [hs, lintegral_union measurableSet_Ioi hd]
  have hi0 : IntegrableOn (fun t : ℝ => H*(1/(2+t))) (Ioc 0 R) := by
    have hi := (reciprocal_intervalIntegrable hR.le).1
    simpa [IntegrableOn, intervalIntegral] using hi.const_mul H
  have hinf := (SpectralTailMass.reciprocal_square_integrable hR).const_mul (2*A)
  have hl : (∫⁻ t in Ioc 0 R, μ {x : ℝ | t < |x|} * ENNReal.ofReal (1/(2+t))) ≤
      ENNReal.ofReal (H*(Real.log (2+R)-Real.log 2)) := by
    calc
      _ ≤ ∫⁻ t in Ioc 0 R, ENNReal.ofReal (H*(1/(2+t))) := by
        apply lintegral_mono_ae
        filter_upwards [ae_restrict_mem measurableSet_Ioc] with t ht
        rw [ENNReal.ofReal_mul hH]
        exact mul_le_mul_right' ((hb t ht.1).trans (min_le_left _ _)) _
      _ = _ := by
        rw [← ofReal_integral_eq_lintegral_ofReal hi0]
        · rw [← intervalIntegral.integral_of_le hR.le,
            intervalIntegral.integral_const_mul, reciprocal_primitive hR.le]
        · filter_upwards [ae_restrict_mem measurableSet_Ioc] with t ht
          have ht0 : 0 < t := ht.1
          positivity
  have hu : (∫⁻ t in Ioi R, μ {x : ℝ | t < |x|} * ENNReal.ofReal (1/(2+t))) ≤
      ENNReal.ofReal (2*A/R) := by
    calc
      _ ≤ ∫⁻ t in Ioi R, ENNReal.ofReal ((2*A)*(1/t^2)) := by
        apply lintegral_mono_ae
        filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
        have ht0 : 0 < t := hR.trans ht
        calc
          _ ≤ ENNReal.ofReal (2*A/t) * ENNReal.ofReal (1/(2+t)) :=
            mul_le_mul_right' ((hb t ht0).trans (min_le_right _ _)) _
          _ = ENNReal.ofReal ((2*A/t)*(1/(2+t))) := (ENNReal.ofReal_mul (by positivity)).symm
          _ ≤ _ := by
            apply ENNReal.ofReal_le_ofReal
            have hp : 1/(2+t) ≤ 1/t := one_div_le_one_div_of_le ht0 (by linarith)
            have hm := mul_le_mul_of_nonneg_left hp (show 0 ≤ 2*A/t by positivity)
            convert hm using 1
            ring
      _ = _ := by
        rw [← ofReal_integral_eq_lintegral_ofReal hinf]
        · rw [integral_const_mul, SpectralTailMass.reciprocal_square_integral hR]
          congr 1
          ring
        · filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
          positivity
  calc
    _ ≤ ENNReal.ofReal (H*(Real.log (2+R)-Real.log 2)) + ENNReal.ofReal (2*A/R) :=
      add_le_add hl hu
    _ = _ := by
      rw [← ENNReal.ofReal_add]
      · apply mul_nonneg hH
        apply sub_nonneg.mpr
        exact Real.log_le_log (by norm_num) (by linarith)
      · positivity

lemma log_increment_nonnegative (x : ℝ) :
    0 ≤ Real.log (2+|x|)-Real.log 2 := by
  apply sub_nonneg.mpr
  exact Real.log_le_log (by norm_num) (by linarith [abs_nonneg x])

lemma log_increment_integrable {μ : Measure ℝ} {H A R : ℝ}
    (hH : 0 ≤ H) (hA : 0 ≤ A) (hR : 0 < R)
    (hb : ∀ t > 0, μ {x : ℝ | t < |x|} ≤
      min (ENNReal.ofReal H) (ENNReal.ofReal (2*A/t))) :
    Integrable (fun x : ℝ => Real.log (2+|x|)-Real.log 2) μ := by
  have hm : Measurable (fun x : ℝ => Real.log (2+|x|)-Real.log 2) := by fun_prop
  refine ⟨hm.aestronglyMeasurable, ?_⟩
  rw [hasFiniteIntegral_iff_ofReal (Filter.Eventually.of_forall log_increment_nonnegative)]
  exact lt_of_le_of_lt (logarithmic_layercake_le hH hA hR hb) ENNReal.ofReal_lt_top

lemma log_increment_integral_le {μ : Measure ℝ} {H A R : ℝ}
    (hH : 0 ≤ H) (hA : 0 ≤ A) (hR : 0 < R)
    (hb : ∀ t > 0, μ {x : ℝ | t < |x|} ≤
      min (ENNReal.ofReal H) (ENNReal.ofReal (2*A/t))) :
    (∫ x : ℝ, Real.log (2+|x|)-Real.log 2 ∂μ) ≤
      H*(Real.log (2+R)-Real.log 2)+2*A/R := by
  rw [integral_eq_lintegral_of_nonneg_ae
    (Filter.Eventually.of_forall log_increment_nonnegative)
    (log_increment_integrable hH hA hR hb).aestronglyMeasurable]
  have hl := ENNReal.toReal_mono ENNReal.ofReal_ne_top (logarithmic_layercake_le hH hA hR hb)
  have hp : 0 ≤ H*(Real.log (2+R)-Real.log 2)+2*A/R := by
    have hrlog : 0 ≤ Real.log (2+R)-Real.log 2 := by
      exact sub_nonneg.mpr (Real.log_le_log (by norm_num) (by linarith))
    positivity
  simpa [ENNReal.toReal_ofReal hp] using hl

lemma optimized_increment_bound {μ : Measure ℝ} {H A : ℝ}
    (hH : 0 < H) (hA : 0 < A)
    (hb : ∀ t > 0, μ {x : ℝ | t < |x|} ≤
      min (ENNReal.ofReal H) (ENNReal.ofReal (2*A/t))) :
    (∫ x : ℝ, Real.log (2+|x|)-Real.log 2 ∂μ) ≤
      H*(Real.log (1+A/H)+1) := by
  have hi := log_increment_integral_le hH.le hA.le (show 0 < 2*A/H by positivity) hb
  have hlog : Real.log (2+2*A/H)-Real.log 2 = Real.log (1+A/H) := by
    rw [show 2+2*A/H=2*(1+A/H) by ring,
      Real.log_mul (by norm_num) (by positivity)]
    ring
  have hdiv : 2*A/(2*A/H)=H := by field_simp
  simpa [hlog,hdiv,mul_add] using hi

lemma log_moment_integrable {μ : Measure ℝ} [IsFiniteMeasure μ] {H A R : ℝ}
    (hH : 0 ≤ H) (hA : 0 ≤ A) (hR : 0 < R)
    (hb : ∀ t > 0, μ {x : ℝ | t < |x|} ≤
      min (ENNReal.ofReal H) (ENNReal.ofReal (2*A/t))) :
    Integrable (fun x : ℝ => Real.log (2+|x|)) μ := by
  have hi := (log_increment_integrable hH hA hR hb).add (integrable_const (Real.log 2))
  convert hi using 1
  funext x
  simp only [Pi.add_apply]
  ring

lemma log_moment_le {μ : Measure ℝ} [IsFiniteMeasure μ] {H A : ℝ}
    (hH : 0 < H) (hA : 0 < A) (hμ : μ.real univ=H)
    (hb : ∀ t > 0, μ {x : ℝ | t < |x|} ≤
      min (ENNReal.ofReal H) (ENNReal.ofReal (2*A/t))) :
    (∫ x : ℝ, Real.log (2+|x|) ∂μ) ≤ H*(Real.log 2+Real.log (1+A/H)+1) := by
  have hi := log_increment_integrable hH.le hA.le (show 0 < 2*A/H by positivity) hb
  have he : (∫ x : ℝ, Real.log (2+|x|) ∂μ) =
      (∫ x : ℝ, Real.log (2+|x|)-Real.log 2 ∂μ)+H*Real.log 2 := by
    have hc : (∫ _x : ℝ, Real.log 2 ∂μ)=H*Real.log 2 := by
      simp [integral_const, hμ, smul_eq_mul]
    rw [← hc, ← integral_add hi (integrable_const (Real.log 2))]
    congr 1
    funext x
    ring
  rw [he]
  have hb' := optimized_increment_bound hH hA hb
  nlinarith

lemma density_log_moment {r : ℝ → ℝ} {A H : ℝ}
    (hm : Measurable r) (hr : Integrable r) (hn : ∀ x, 0 ≤ r x)
    (hA : 0 < A) (hH : 0 < H) (hMass : (∫ x, r x)=H)
    (hb : ∀ x, r x ≤ A/(1+x^2)) :
    Integrable (fun x : ℝ => r x * Real.log (2+|x|)) ∧
    (∫ x : ℝ, r x * Real.log (2+|x|)) ≤
      H*(Real.log 2+Real.log (1+A/H)+1) := by
  let μ : Measure ℝ := volume.withDensity (fun x => ENNReal.ofReal (r x))
  have he : (∫⁻ x, ENNReal.ofReal (r x))=ENNReal.ofReal H := by
    rw [← ofReal_integral_eq_lintegral_ofReal hr (Filter.Eventually.of_forall hn), hMass]
  haveI : IsFiniteMeasure μ := isFiniteMeasure_withDensity (by rw [he]; exact ENNReal.ofReal_ne_top)
  have hμ : μ.real univ=H := by
    simp only [Measure.real, μ, withDensity_apply _ MeasurableSet.univ, Measure.restrict_univ, he]
    exact ENNReal.toReal_ofReal hH.le
  have htail : ∀ t : ℝ, μ {x : ℝ | t < |x|} =
      ENNReal.ofReal (∫ x in {x : ℝ | t < |x|}, r x) := by
    intro t
    have hs : MeasurableSet {x : ℝ | t < |x|} := (isOpen_lt continuous_const continuous_abs).measurableSet
    dsimp only [μ]
    rw [withDensity_apply _ hs, ← ofReal_integral_eq_lintegral_ofReal hr.integrableOn
      (Filter.Eventually.of_forall hn)]
  have ht : ∀ t > 0, μ {x : ℝ | t < |x|} ≤
      min (ENNReal.ofReal H) (ENNReal.ofReal (2*A/t)) := by
    intro t ht
    rw [htail t]
    apply le_min
    · apply ENNReal.ofReal_le_ofReal
      rw [← hMass]
      exact SpectralTailMass.tail_le_mass hr hn t
    · exact ENNReal.ofReal_le_ofReal (SpectralTailMass.two_sided_tail_le hA.le ht hr hb)
  have hi := log_moment_integrable hH.le hA.le (show (0 : ℝ) < 1 by norm_num) ht
  have hg : (∫ x : ℝ, Real.log (2+|x|) ∂μ) =
      ∫ x : ℝ, r x * Real.log (2+|x|) := by
    dsimp only [μ]
    rw [integral_withDensity_eq_integral_toReal_smul hm.ennreal_ofReal]
    · congr 1
      funext x
      simp [ENNReal.toReal_ofReal (hn x), smul_eq_mul]
    · exact Filter.Eventually.of_forall (fun x => ENNReal.ofReal_lt_top)
  constructor
  · have hi' := (integrable_withDensity_iff_integrable_smul' hm.ennreal_ofReal
      (Filter.Eventually.of_forall (fun x => ENNReal.ofReal_lt_top))).1 hi
    simpa [ENNReal.toReal_ofReal (hn _), smul_eq_mul] using hi'
  · rw [← hg]
    exact log_moment_le hH hA hμ ht

lemma density_log_moment_zero {r : ℝ → ℝ} (hr : Integrable r)
    (hn : ∀ x, 0 ≤ r x) (hMass : (∫ x, r x)=0) :
    Integrable (fun x : ℝ => r x * Real.log (2+|x|)) ∧
    (∫ x : ℝ, r x * Real.log (2+|x|))=0 := by
  have hz := (integral_eq_zero_iff_of_nonneg hn hr).1 hMass
  have hg : (fun x : ℝ => r x * Real.log (2+|x|)) =ᵐ[volume] 0 := by
    filter_upwards [hz] with x hx
    simp [hx]
  exact ⟨(integrable_zero ℝ ℝ volume).congr hg.symm, by rw [integral_congr_ae hg]; simp⟩

lemma density_log_moment_nonnegative_mass {r : ℝ → ℝ} {A H : ℝ}
    (hm : Measurable r) (hr : Integrable r) (hn : ∀ x, 0 ≤ r x)
    (hA : 0 < A) (hH : 0 ≤ H) (hMass : (∫ x, r x)=H)
    (hb : ∀ x, r x ≤ A/(1+x^2)) :
    Integrable (fun x : ℝ => r x * Real.log (2+|x|)) ∧
    (∫ x : ℝ, r x * Real.log (2+|x|)) ≤
      H*(Real.log 2+Real.log (1+A/H)+1) := by
  by_cases hz : H=0
  · rw [hz] at hMass ⊢
    have hi := density_log_moment_zero hr hn hMass
    exact ⟨hi.1, by simp [hi.2]⟩
  · exact density_log_moment hm hr hn hA (lt_of_le_of_ne hH (Ne.symm hz)) hMass hb

#print axioms density_log_moment_zero
#print axioms density_log_moment_nonnegative_mass
#print axioms density_log_moment
#print axioms log_moment_integrable
#print axioms log_moment_le
#print axioms log_increment_nonnegative
#print axioms log_increment_integrable
#print axioms log_increment_integral_le
#print axioms optimized_increment_bound
#print axioms reciprocal_intervalIntegrable
#print axioms reciprocal_primitive
#print axioms logarithmic_layercake
#print axioms logarithmic_layercake_le
end BuildingBlocks.LogarithmicLayercake
