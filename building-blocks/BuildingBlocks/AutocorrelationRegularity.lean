import BuildingBlocks.LogarithmicPrimeWindow
import Mathlib.Analysis.Convolution
import Mathlib.Analysis.Calculus.Deriv.Support

open MeasureTheory Function
open scoped ContDiff

namespace BuildingBlocks.AutocorrelationRegularity

theorem seed_compact_support {f : ℝ → ℝ} {r : ℝ}
    (hz : ∀ v : ℝ, r ≤ |v| → f v = 0) : HasCompactSupport f := by
  apply IsCompact.of_isClosed_subset (s := Set.Icc (-r) r) isCompact_Icc isClosed_closure
  apply closure_minimal _ isClosed_Icc
  intro x hx
  have hxlt : |x| < r := lt_of_not_ge (fun h => hx (hz x h))
  exact ⟨(abs_lt.mp hxlt).1.le, (abs_lt.mp hxlt).2.le⟩

theorem autocorrelation_eq_convolution (f : ℝ → ℝ) :
    LogarithmicPrimeWindow.autocorrelation f =
      convolution (fun v => f (-v)) f (ContinuousLinearMap.mul ℝ ℝ) volume := by
  funext x
  unfold LogarithmicPrimeWindow.autocorrelation
  rw [convolution_def]
  simp only [ContinuousLinearMap.mul_apply']
  calc
    _ = ∫ v : ℝ, f (-v + x) * f (-v) :=
      (integral_neg_eq_self _ volume).symm
    _ = _ := by
      apply integral_congr_ae
      filter_upwards [] with v
      rw [show -v + x = x - v by ring]
      exact mul_comm _ _

theorem autocorrelation_contDiff {f : ℝ → ℝ}
    (hf : ContDiff ℝ ∞ f) (hfc : HasCompactSupport f) :
    ContDiff ℝ ∞ (LogarithmicPrimeWindow.autocorrelation f) := by
  rw [autocorrelation_eq_convolution]
  exact hfc.contDiff_convolution_right (ContinuousLinearMap.mul ℝ ℝ)
    (hf.continuous.comp continuous_neg).locallyIntegrable hf

theorem autocorrelation_zero_of_abs_ge {f : ℝ → ℝ} {r x : ℝ}
    (hz : ∀ v : ℝ, r ≤ |v| → f v = 0) (hx : 2 * r ≤ |x|) :
    LogarithmicPrimeWindow.autocorrelation f x = 0 := by
  unfold LogarithmicPrimeWindow.autocorrelation
  apply integral_eq_zero_of_ae
  filter_upwards [] with v
  by_cases hv : f v = 0
  · simp [hv]
  by_cases hvx : f (v + x) = 0
  · simp [hvx]
  have hvr : |v| < r := lt_of_not_ge (fun h => hv (hz v h))
  have hvxr : |v + x| < r := lt_of_not_ge (fun h => hvx (hz (v + x) h))
  have hb : |x| < 2 * r := by
    have ht : |x| ≤ |v + x| + |v| := by
      have ht := abs_sub_le (v + x) (0 : ℝ) v
      simp only [sub_zero, zero_sub, abs_neg] at ht
      rw [show v + x - v = x by ring] at ht
      exact ht
    linarith
  exact False.elim (not_lt_of_ge hx hb)

theorem autocorrelation_tsupport_subset {f : ℝ → ℝ} {r : ℝ}
    (hz : ∀ v : ℝ, r ≤ |v| → f v = 0) :
    tsupport (LogarithmicPrimeWindow.autocorrelation f) ⊆ Set.Icc (-2*r) (2*r) := by
  apply closure_minimal _ isClosed_Icc
  intro x hx
  have hlt : |x| < 2*r := by
    by_contra h
    exact hx (autocorrelation_zero_of_abs_ge hz (le_of_not_gt h))
  exact ⟨by have := (abs_lt.mp hlt).1; linarith, (abs_lt.mp hlt).2.le⟩

theorem autocorrelation_deriv_zero_of_abs_ge {f : ℝ → ℝ} {r d x : ℝ}
    (hz : ∀ v : ℝ, r ≤ |v| → f v = 0) (hd : 2*r < d) (hx : d ≤ |x|) :
    deriv (LogarithmicPrimeWindow.autocorrelation f) x = 0 := by
  by_contra h
  have hs := autocorrelation_tsupport_subset hz (support_deriv_subset h)
  have habs : |x| ≤ 2*r := abs_le.mpr ⟨by linarith [hs.1], hs.2⟩
  linarith

theorem source_packet_regular {f : ℝ → ℝ} {r d : ℝ}
    (hf : ContDiff ℝ ∞ f) (hfc : HasCompactSupport f)
    (hz : ∀ v : ℝ, r ≤ |v| → f v = 0) (hd : 2*r < d) :
    Continuous (LogarithmicPrimeWindow.autocorrelation f) ∧
    Continuous (deriv (LogarithmicPrimeWindow.autocorrelation f)) ∧
    (∀ y, HasDerivAt (LogarithmicPrimeWindow.autocorrelation f)
      (deriv (LogarithmicPrimeWindow.autocorrelation f) y) y) ∧
    (∀ y, d ≤ |y| → LogarithmicPrimeWindow.autocorrelation f y = 0) ∧
    (∀ y, d ≤ |y| → deriv (LogarithmicPrimeWindow.autocorrelation f) y = 0) := by
  have hc := autocorrelation_contDiff hf hfc
  refine ⟨hc.continuous, hc.continuous_deriv (by simp), ?_, ?_, ?_⟩
  · intro y
    exact (hc.differentiable (by simp) y).hasDerivAt
  · intro y hy
    exact autocorrelation_zero_of_abs_ge hz (hd.le.trans hy)
  · intro y hy
    exact autocorrelation_deriv_zero_of_abs_ge hz hd hy

open scoped BigOperators

theorem actual_packet_signed_windows {ι : Type*} (T : Finset ι) (c s : ι → ℝ)
    {f : ℝ → ℝ} {r d : ℝ} {N C : ℕ}
    (hf : ContDiff ℝ ∞ f)
    (hz : ∀ v : ℝ, r ≤ |v| → f v = 0) (hrd : 2*r < d)
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d)
    (hs : ∀ i ∈ T, d ≤ s i) (hcut : ∀ i ∈ T, s i + d ≤ Real.log N) :
    (∑ i ∈ T, c i * ((∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n *
      LogarithmicPrimeWindow.window (LogarithmicPrimeWindow.autocorrelation f) (s i) n) -
      Real.exp (s i / 2) *
        (LogarithmicPrimeWindow.physicalMoment f (1/2) *
         LogarithmicPrimeWindow.physicalMoment f (-(1/2))))) =
      -(∫ v : ℝ, BuildingBlocks.ChargeFrozenSource.causalSource C v *
        (∑ i ∈ T, c i * LogarithmicPrimeWindow.sourceKernel
          (LogarithmicPrimeWindow.autocorrelation f)
          (deriv (LogarithmicPrimeWindow.autocorrelation f)) (v - s i))) := by
  have hfc := seed_compact_support hz
  obtain ⟨hR, hD, hderiv, hRs, hDs⟩ := source_packet_regular hf hfc hz hrd
  have h := LogarithmicPrimeWindow.signed_windows_frozen_source T c s
    hN hNC hd hs hR hD hRs hDs hderiv hcut
  rw [LogarithmicPrimeWindow.densityMoment_autocorrelation hf.continuous hfc] at h
  simpa only [neg_div] using h

#print axioms seed_compact_support
#print axioms autocorrelation_eq_convolution
#print axioms autocorrelation_contDiff
#print axioms autocorrelation_zero_of_abs_ge
#print axioms autocorrelation_tsupport_subset
#print axioms autocorrelation_deriv_zero_of_abs_ge
#print axioms source_packet_regular
#print axioms actual_packet_signed_windows

end BuildingBlocks.AutocorrelationRegularity
