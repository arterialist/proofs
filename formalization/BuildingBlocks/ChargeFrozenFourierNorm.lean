import BuildingBlocks.ChargeFrozenLogMoment
import Mathlib.Analysis.Fourier.Inversion
import Mathlib.MeasureTheory.Function.L2Space
import Mathlib.Topology.Algebra.Indicator
import Mathlib.Analysis.Convolution

open MeasureTheory Set
open scoped FourierTransform

namespace BuildingBlocks.ChargeFrozenFourierNorm

open ChargeFrozenSource ChargeFrozenMetric ChargeFrozenLogMoment

noncomputable def complexSource (N : ℕ) (v : ℝ) : ℂ := causalSource N v

theorem square_eq_indicator (N : ℕ) :
    (fun v : ℝ => (causalSource N v) ^ 2) =
      (Ici (0 : ℝ)).indicator (fun v : ℝ => (causalSource N v) ^ 2) := by
  funext v
  by_cases hv : 0 ≤ v
  · simp [hv]
  · rw [causalSource_of_negative N (lt_of_not_ge hv)]
    simp [hv]

theorem integrable_square {N : ℕ} (hN : 2 ≤ N) :
    Integrable (fun v : ℝ => (causalSource N v) ^ 2) := by
  have hi : IntegrableOn (fun v : ℝ => (causalSource N v) ^ 2) (Ici (0 : ℝ)) :=
    Iff.mpr integrableOn_Ici_iff_integrableOn_Ioi (full_square_integrable hN)
  rw [square_eq_indicator N]
  exact hi.integrable_indicator measurableSet_Ici

theorem memLp_complexSource {N : ℕ} (hN : 2 ≤ N) :
    MemLp (complexSource N) 2 volume := by
  have hm : AEStronglyMeasurable (complexSource N) :=
    (Complex.continuous_ofReal.measurable.comp (measurable_causalSource N)).aestronglyMeasurable
  apply (memLp_two_iff_integrable_sq_norm hm).mpr
  convert integrable_square hN using 1
  funext v
  simp [complexSource, Complex.norm_real, Real.norm_eq_abs, sq_abs]

/-- Mathlib uses exp(-2π i v y); the existing literal hat uses exp(-i ξ v). -/
theorem hat_eq_mathlib_fourier (N : ℕ) (ξ : ℝ) :
    hat N ξ = 𝓕 (complexSource N) (ξ / (2 * Real.pi)) := by
  rw [Real.fourierIntegral_real_eq_integral_exp_smul]
  apply integral_congr_ae
  filter_upwards [] with v
  simp only [complexSource, smul_eq_mul]
  congr 1
  congr 1
  push_cast
  have hp : (Real.pi : ℂ) ≠ 0 := by exact_mod_cast Real.pi_ne_zero
  field_simp

theorem square_integral_eq_causal (N : ℕ) :
    (∫ v : ℝ, (causalSource N v) ^ 2) =
      ∫ v in Ioi (0 : ℝ), (causalSource N v) ^ 2 := by
  calc
    _ = ∫ v : ℝ, (Ici (0 : ℝ)).indicator
        (fun v : ℝ => (causalSource N v) ^ 2) v :=
      congrArg (fun f : ℝ → ℝ => ∫ v : ℝ, f v) (square_eq_indicator N)
    _ = ∫ v in Ici (0 : ℝ), (causalSource N v) ^ 2 :=
      integral_indicator measurableSet_Ici
    _ = _ := integral_Ici_eq_integral_Ioi

/-- The physical whole-line norm retains the exact frozen endpoint square. -/
theorem physical_norm_sq_split {N : ℕ} (hN : 2 ≤ N) :
    (∫ v : ℝ, ‖complexSource N v‖ ^ 2) =
      (∫ v in Ioc 0 (Real.log (N : ℝ)), (causalSource N v) ^ 2) +
        (CoarsePrimitive.psi N - (N : ℝ)) ^ 2 / (N : ℝ) := by
  simp only [complexSource, Complex.norm_real, Real.norm_eq_abs, sq_abs]
  rw [square_integral_eq_causal N, full_square_integral_split hN]

theorem ae_continuous_indicator_Ici {f : ℝ → ℝ} (hf : Continuous f) (c : ℝ) :
    ∀ᵐ v : ℝ, ContinuousAt ((Ici c).indicator f) v := by
  filter_upwards [compl_mem_ae_iff.mpr (measure_singleton c)] with v hv
  apply hf.continuousOn.continuousAt_indicator
  simpa only [frontier_Ici] using hv

theorem ae_continuous_causalSource {N : ℕ} (hN : 2 ≤ N) :
    ∀ᵐ v : ℝ, ContinuousAt (causalSource N) v := by
  have hb : ∀ᵐ v : ℝ, ∀ n : ℕ, ContinuousAt (ChargeOriginalBirth.beta n) v := by
    apply ae_all_iff.mpr
    intro n
    by_cases hn : n = 0
    · subst n
      have he : ChargeOriginalBirth.beta 0 = fun v : ℝ => Real.exp (-v / 2) := by
        funext v
        simp [ChargeOriginalBirth.beta, (Real.exp_pos v).le]
      rw [he]
      exact Filter.Eventually.of_forall (fun v => by fun_prop)
    · rw [ChargeFrozenFourier.beta_eq_indicator (by omega)]
      exact ae_continuous_indicator_Ici (by fun_prop) _
  have hc : ∀ᵐ v : ℝ, ContinuousAt (ChargeFrozenFourier.centering N) v :=
    ae_continuous_indicator_Ici (by fun_prop) _
  filter_upwards [hb, hc] with v hv hvc
  have he : causalSource N = fun u : ℝ =>
      (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * ChargeOriginalBirth.beta n u) -
      ChargeFrozenFourier.centering N u := by
    funext u
    exact ChargeFrozenFourier.causalSource_eq_atoms_sub_centering hN u
  rw [he]
  have hsum : ∀ s : Finset ℕ, ContinuousAt (fun u : ℝ =>
      ∑ n ∈ s, ArithmeticFunction.vonMangoldt n * ChargeOriginalBirth.beta n u) v := by
    intro s
    induction s using Finset.induction_on with
    | empty => simpa using (continuousAt_const : ContinuousAt (fun _ : ℝ => (0 : ℝ)) v)
    | @insert n s hn ih =>
      simpa only [Finset.sum_insert hn] using
        (continuousAt_const.mul (hv n)).add ih
  exact (hsum _).sub hvc

theorem source_abs_le_constant (N : ℕ) (v : ℝ) :
    |causalSource N v| ≤ CoarsePrimitive.psi N + (N : ℝ) := by
  by_cases hv : 0 ≤ v
  · have he : Real.exp (-v / 2) ≤ 1 := by
      simpa using Real.exp_le_exp.mpr (show -v / 2 ≤ 0 by linarith)
    exact (ChargeFrozenIntegrability.source_abs_le v hv).trans (by
      have hh := mul_le_mul_of_nonneg_left he
        (add_nonneg (CoarsePrimitive.psi_nonneg N) (Nat.cast_nonneg N))
      simpa using hh)
  · rw [causalSource_of_negative N (lt_of_not_ge hv)]
    simpa using add_nonneg (CoarsePrimitive.psi_nonneg N) (Nat.cast_nonneg N)

noncomputable def autocorrelation (N : ℕ) (h : ℝ) : ℝ :=
  ∫ v : ℝ, causalSource N (v + h) * causalSource N v

/-- Continuity at the inversion point follows from the literal source's
almost-everywhere continuity and an integrable constant-times-source majorant. -/
theorem continuousAt_autocorrelation_zero {N : ℕ} (hN : 2 ≤ N) :
    ContinuousAt (autocorrelation N) 0 := by
  apply continuousAt_of_dominated
    (bound := fun v : ℝ => (CoarsePrimitive.psi N + (N : ℝ)) * |causalSource N v|)
  · exact Filter.Eventually.of_forall (fun h =>
      (((measurable_causalSource N).comp (by fun_prop)).mul
        (measurable_causalSource N)).aestronglyMeasurable)
  · apply Filter.Eventually.of_forall
    intro h
    exact Filter.Eventually.of_forall (fun v => by
      rw [Real.norm_eq_abs, abs_mul]
      exact mul_le_mul_of_nonneg_right (source_abs_le_constant N (v + h)) (abs_nonneg _))
  · exact (ChargeFrozenIntegrability.integrable_causalSource N).abs.const_mul _
  · filter_upwards [ae_continuous_causalSource hN] with v hv
    have hh : ContinuousAt (fun h : ℝ => causalSource N (v + h)) 0 := by
      have hvs : ContinuousAt (causalSource N) (v + 0) := by simpa using hv
      exact hvs.comp (continuousAt_const.add continuousAt_id)
    exact hh.mul continuousAt_const

theorem autocorrelation_eq_convolution (N : ℕ) (h : ℝ) :
    autocorrelation N h = convolution (causalSource N)
      (fun v : ℝ => causalSource N (-v)) (ContinuousLinearMap.mul ℝ ℝ) volume (-h) := by
  apply integral_congr_ae
  filter_upwards [] with v
  simp only [ContinuousLinearMap.mul_apply']
  have he : -(-h - v) = v + h := by ring
  rw [he, mul_comm]

theorem integrable_autocorrelation (N : ℕ) : Integrable (autocorrelation N) := by
  have ha := ChargeFrozenIntegrability.integrable_causalSource N
  have hc := ha.integrable_convolution (ContinuousLinearMap.mul ℝ ℝ) ha.comp_neg
  apply hc.comp_neg.congr
  exact Filter.Eventually.of_forall (fun h => (autocorrelation_eq_convolution N h).symm)

theorem autocorrelation_zero (N : ℕ) :
    autocorrelation N 0 = ∫ v : ℝ, (causalSource N v) ^ 2 := by
  simp [autocorrelation, pow_two]

#print axioms integrable_square
#print axioms memLp_complexSource
#print axioms hat_eq_mathlib_fourier
#print axioms physical_norm_sq_split
#print axioms ae_continuous_causalSource
#print axioms continuousAt_autocorrelation_zero
#print axioms integrable_autocorrelation
#print axioms autocorrelation_zero

end BuildingBlocks.ChargeFrozenFourierNorm
