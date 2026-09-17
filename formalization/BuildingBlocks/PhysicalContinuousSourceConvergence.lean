import BuildingBlocks.PhysicalArrivalBoundary
import Mathlib.MeasureTheory.Group.Integral

namespace BuildingBlocks.PhysicalContinuousSourceConvergence
open Real MeasureTheory
open BuildingBlocks.PhysicalContinuousArrival BuildingBlocks.PhysicalGroundPrimeArrival
open BuildingBlocks.PhysicalArrivalBoundary

noncomputable def positiveKernel (d s : ℝ) : ℝ :=
  (Set.Ioi d).indicator kernel s

theorem kernel_integrable_away {d : ℝ} (hd : 0 < d) :
    IntegrableOn kernel (Set.Ioi d) := by
  by_cases hd1 : d ≤ 1
  · have hc : IntegrableOn kernel (Set.Icc d 1) :=
      (kernel_continuousOn.mono
        (fun s hs => lt_of_lt_of_le hd hs.1)).integrableOn_Icc
    apply (hc.union kernel_far_integrable).mono_set
    intro s hs
    by_cases hs1 : s ≤ 1
    · exact Or.inl ⟨hs.le, hs1⟩
    · exact Or.inr (lt_of_not_ge hs1)
  · exact kernel_far_integrable.mono_set (fun s hs => lt_trans (lt_of_not_ge hd1) hs)

theorem positive_kernel_integrable {d : ℝ} (hd : 0 < d) :
    Integrable (positiveKernel d) :=
  (kernel_integrable_away hd).integrable_indicator measurableSet_Ioi

theorem positive_kernel_nonneg {d : ℝ} (hd : 0 < d) (s : ℝ) :
    0 ≤ positiveKernel d s := by
  unfold positiveKernel
  by_cases hs : d < s
  · rw [Set.indicator_of_mem (show s ∈ Set.Ioi d from hs)]
    exact kernel_nonneg (lt_trans hd hs)
  · rw [Set.indicator_of_notMem (show s ∉ Set.Ioi d from hs)]

theorem source_uniform_bound_ae (R P : ℝ) (ψ : ℝ → ℝ) (hP : 0 ≤ P)
    (hψ : ∀ᵐ w, |ψ w| ≤ P) : ∀ᵐ w, |source R ψ w| ≤ P * tailConstant := by
  filter_upwards [hψ] with w hw
  have he : exp (-|w|) ≤ 1 := exp_le_one_iff.mpr (neg_nonpos.mpr (abs_nonneg w))
  exact (source_bound_at R w P ψ hP hw).trans
    (by simpa using mul_le_mul_of_nonneg_left he (mul_nonneg hP tailConstant_nonneg))

theorem continuous_arrival_integrable_at {R v P : ℝ} (ψ : ℝ → ℝ)
    (hv : |v| < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    Integrable (fun w : ℝ => kernel |v - w| * source R ψ w) := by
  let d := (R - |v|) / 2
  have hd : 0 < d := by dsimp [d]; linarith
  have hi := positive_kernel_integrable hd
  have hleft : Integrable (fun w : ℝ => positiveKernel d (v - w)) := by
    simpa [sub_eq_add_neg] using (hi.comp_add_left v).comp_neg
  have hright : Integrable (fun w : ℝ => positiveKernel d (w - v)) := by
    simpa [sub_eq_add_neg] using hi.comp_add_right (-v)
  have hm := (hleft.add hright).const_mul (P * tailConstant)
  have hk : Measurable (fun w : ℝ => kernel |v - w|) := by unfold kernel; fun_prop
  apply hm.mono' (hk.aestronglyMeasurable.mul (source_aestronglyMeasurable R ψ hψ))
  filter_upwards [source_uniform_bound_ae R P ψ hP hbound] with w hw
  simp only [Pi.mul_apply, Pi.add_apply]
  by_cases hwO : R < |w|
  · have ht : |w| ≤ |v| + |v - w| := by
      have h := abs_sub_le w v 0
      simpa [abs_sub_comm, add_comm] using h
    have hdist : d < |v - w| := by dsimp [d]; linarith
    have hkn : 0 ≤ kernel |v - w| := kernel_nonneg (lt_trans hd hdist)
    have hks : kernel |v - w| ≤
        positiveKernel d (v - w) + positiveKernel d (w - v) := by
      by_cases hsign : 0 ≤ v - w
      · have hs : d < v - w := by rwa [abs_of_nonneg hsign] at hdist
        rw [abs_of_nonneg hsign, positiveKernel,
          Set.indicator_of_mem (show v - w ∈ Set.Ioi d from hs)]
        exact le_add_of_nonneg_right (positive_kernel_nonneg hd _)
      · have hs : d < w - v := by rw [abs_of_neg (lt_of_not_ge hsign)] at hdist; linarith
        have habs : |v - w| = w - v := by rw [abs_of_neg (lt_of_not_ge hsign)]; ring
        rw [habs, show positiveKernel d (w - v) = kernel (w - v) from
          Set.indicator_of_mem hs kernel]
        exact le_add_of_nonneg_left (positive_kernel_nonneg hd _)
    rw [Real.norm_eq_abs, abs_mul, abs_of_nonneg hkn]
    calc
      _ ≤ kernel |v - w| * (P * tailConstant) := mul_le_mul_of_nonneg_left hw hkn
      _ ≤ _ := by
        simpa [mul_comm] using mul_le_mul_of_nonneg_right hks
          (mul_nonneg hP tailConstant_nonneg)
  · simp only [source, if_neg hwO, mul_zero, norm_zero]
    exact mul_nonneg (mul_nonneg hP tailConstant_nonneg)
      (add_nonneg (positive_kernel_nonneg hd _) (positive_kernel_nonneg hd _))

#print axioms kernel_integrable_away
#print axioms positive_kernel_integrable
#print axioms positive_kernel_nonneg
#print axioms source_uniform_bound_ae
#print axioms continuous_arrival_integrable_at
end BuildingBlocks.PhysicalContinuousSourceConvergence
