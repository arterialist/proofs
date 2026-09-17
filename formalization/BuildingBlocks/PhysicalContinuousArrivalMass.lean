import BuildingBlocks.PhysicalContinuousSourceConvergence
import Mathlib.MeasureTheory.Function.L2Space
import BuildingBlocks.PhysicalPrimeArrivalRegularity

namespace BuildingBlocks.PhysicalContinuousArrivalMass
open Real MeasureTheory
open BuildingBlocks.PhysicalContinuousArrival BuildingBlocks.PhysicalArrivalBoundary
open BuildingBlocks.PhysicalContinuousSourceConvergence
open BuildingBlocks.PhysicalGroundPrimeArrival

theorem exponential_tail_integral (d : ℝ) :
    (∫ s : ℝ in Set.Ioi d, exp (-s / 2) / (1 - exp (-2))) =
      2 * exp (-d / 2) / (1 - exp (-2)) := by
  have heq : (fun s : ℝ => exp (-s / 2)) = (fun s : ℝ => exp ((-1 / 2) * s)) := by
    funext s
    congr 1
    ring
  rw [integral_div, heq, integral_exp_mul_Ioi (by norm_num : (-1 / 2 : ℝ) < 0)]
  rw [show (-1 / 2 : ℝ) * d = -d / 2 by ring]
  ring

theorem far_tail_mass_bound {d : ℝ} (hd : 1 ≤ d) :
    (∫ s : ℝ in Set.Ioi d, kernel s) ≤ 2 / (1 - exp (-2)) := by
  have hi := kernel_integrable_away (lt_of_lt_of_le zero_lt_one hd)
  have he : IntegrableOn (fun s : ℝ => exp (-s / 2) / (1 - exp (-2))) (Set.Ioi d) := by
    have h := (integrableOn_exp_mul_Ioi (by norm_num : (-1 / 2 : ℝ) < 0) d).div_const
      (1 - exp (-2))
    have heq : (fun s : ℝ => exp (-s / 2) / (1 - exp (-2))) =
        (fun s : ℝ => exp ((-1 / 2) * s) / (1 - exp (-2))) := by
      funext s
      congr 2
      ring
    rw [heq]
    exact h
  have hb := setIntegral_mono_on hi he measurableSet_Ioi
    (fun s hs => kernel_far_bound (hd.trans hs.le))
  rw [exponential_tail_integral] at hb
  have hp : 0 < 1 - exp (-2) := by
    simpa only [mul_one] using denominator_pos zero_lt_one
  have hexp : exp (-d / 2) ≤ 1 := exp_le_one_iff.mpr (by linarith)
  exact hb.trans (div_le_div_of_nonneg_right (by linarith) hp.le)

theorem near_tail_mass_bound {d : ℝ} (hd : 0 < d) (hd1 : d ≤ 1) :
    (∫ s : ℝ in Set.Ioi d, kernel s) ≤
      (3 / 2 : ℝ) * boundaryLog d + 2 / (1 - exp (-2)) := by
  have hi := kernel_integrable_away hd
  have hs : Set.Ioi d = Set.Ioc d 1 ∪ Set.Ioi 1 := by
    ext s
    simp only [Set.mem_Ioi, Set.mem_union, Set.mem_Ioc]
    constructor
    · intro h
      by_cases h1 : s ≤ 1
      · exact Or.inl ⟨h, h1⟩
      · exact Or.inr (lt_of_not_ge h1)
    · rintro (h | h)
      · exact h.1
      · exact lt_of_le_of_lt hd1 h
  have hdis : Disjoint (Set.Ioc d 1) (Set.Ioi (1 : ℝ)) :=
    Set.disjoint_left.mpr (fun s hs ht => (not_lt_of_ge hs.2) ht)
  rw [hs, setIntegral_union hdis measurableSet_Ioi
    (hi.mono_set (fun s hs => hs.1)) kernel_far_integrable]
  have hn := truncated_kernel_integral_bound hd hd1
  rw [intervalIntegral.integral_of_le hd1] at hn
  have hl : log d ≤ 0 := log_nonpos hd.le hd1
  have hell : boundaryLog d = -log d := max_eq_right (by linarith)
  rw [hell]
  have hf := far_tail_mass_bound (by norm_num : (1 : ℝ) ≤ 1)
  linarith

theorem tail_mass_bound {d : ℝ} (hd : 0 < d) :
    (∫ s : ℝ in Set.Ioi d, kernel s) ≤
      (3 / 2 : ℝ) * boundaryLog d + 2 / (1 - exp (-2)) := by
  by_cases hd1 : d ≤ 1
  · exact near_tail_mass_bound hd hd1
  · exact (far_tail_mass_bound (le_of_not_ge hd1)).trans
      (le_add_of_nonneg_left (mul_nonneg (by norm_num) (le_max_left _ _)))

theorem source_integrand_majorant {R v P d : ℝ} (ψ : ℝ → ℝ) (hP : 0 ≤ P)
    (hd : 0 < d) (hsep : d ≤ R - |v|) (w : ℝ)
    (hw : |source R ψ w| ≤ P * tailConstant) :
    ‖kernel |v - w| * source R ψ w‖ ≤
      (P * tailConstant) * (positiveKernel d (v - w) + positiveKernel d (w - v)) := by
  by_cases hwO : R < |w|
  · have ht : |w| ≤ |v| + |v - w| := by
      have h := abs_sub_le w v 0
      simpa [abs_sub_comm, add_comm] using h
    have hdist : d < |v - w| := by linarith
    have hkn := kernel_nonneg (lt_trans hd hdist)
    have hks : kernel |v - w| ≤ positiveKernel d (v - w) + positiveKernel d (w - v) := by
      by_cases hsign : 0 ≤ v - w
      · have hs : d < v - w := by rwa [abs_of_nonneg hsign] at hdist
        rw [abs_of_nonneg hsign, positiveKernel,
          Set.indicator_of_mem (show v - w ∈ Set.Ioi d from hs)]
        exact le_add_of_nonneg_right (positive_kernel_nonneg hd _)
      · have hs : d < w - v := by rw [abs_of_neg (lt_of_not_ge hsign)] at hdist; linarith
        have habs : |v - w| = w - v := by rw [abs_of_neg (lt_of_not_ge hsign)]; ring
        rw [habs, show positiveKernel d (w - v) = kernel (w - v) from
          Set.indicator_of_mem (show w - v ∈ Set.Ioi d from hs) kernel]
        exact le_add_of_nonneg_left (positive_kernel_nonneg hd _)
    rw [Real.norm_eq_abs, abs_mul, abs_of_nonneg hkn]
    exact (mul_le_mul_of_nonneg_left hw hkn).trans
      (by simpa [mul_comm] using (mul_le_mul_of_nonneg_right hks
        (mul_nonneg hP tailConstant_nonneg)))
  · simp only [source, if_neg hwO, mul_zero, norm_zero]
    exact mul_nonneg (mul_nonneg hP tailConstant_nonneg)
      (add_nonneg (positive_kernel_nonneg hd _) (positive_kernel_nonneg hd _))

theorem continuous_arrival_mass_bound {R v P : ℝ} (ψ : ℝ → ℝ)
    (hv : |v| < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    ‖continuousArrival R ψ v‖ ≤
      2 * (P * tailConstant) * ((3 / 2 : ℝ) * boundaryLog ((R - |v|) / 2) +
        2 / (1 - exp (-2))) := by
  let d := (R - |v|) / 2
  have hd : 0 < d := by dsimp [d]; linarith
  have hsep : d ≤ R - |v| := by dsimp [d]; linarith
  have hi := positive_kernel_integrable hd
  have hleft : Integrable (fun w : ℝ => positiveKernel d (v - w)) := by
    simpa [sub_eq_add_neg] using (hi.comp_add_left v).comp_neg
  have hright : Integrable (fun w : ℝ => positiveKernel d (w - v)) := by
    simpa [sub_eq_add_neg] using hi.comp_add_right (-v)
  have hm := (hleft.add hright).const_mul (P * tailConstant)
  have hmaj : ∀ᵐ w, ‖kernel |v - w| * source R ψ w‖ ≤
      (P * tailConstant) * (positiveKernel d (v - w) + positiveKernel d (w - v)) := by
    filter_upwards [source_uniform_bound_ae R P ψ hP hbound] with w hw
    exact source_integrand_majorant ψ hP hd hsep w hw
  have hle := integral_mono_ae (continuous_arrival_integrable_at ψ hv hP hψ hbound).norm hm hmaj
  simp only [Pi.add_apply] at hle
  rw [integral_const_mul, integral_add hleft hright,
    integral_sub_left_eq_self (positiveKernel d) volume v,
    integral_sub_right_eq_self (positiveKernel d) v] at hle
  simp only [positiveKernel, integral_indicator measurableSet_Ioi] at hle
  have hn := (norm_integral_le_integral_norm
    (fun w : ℝ => kernel |v - w| * source R ψ w)).trans hle
  have ht := mul_le_mul_of_nonneg_left (tail_mass_bound hd)
    (mul_nonneg (by norm_num : (0 : ℝ) ≤ 2) (mul_nonneg hP tailConstant_nonneg))
  exact hn.trans (by convert ht using 1; ring)

theorem boundary_log_half_bound {d : ℝ} (hd : 0 < d) :
    boundaryLog (d / 2) ≤ boundaryLog d + log 2 := by
  have hl : 0 ≤ log (2 : ℝ) := log_nonneg (by norm_num)
  unfold boundaryLog
  rw [log_div hd.ne' (by norm_num : (2 : ℝ) ≠ 0)]
  apply max_le
  · exact add_nonneg (le_max_left _ _) hl
  · have h := le_max_right (0 : ℝ) (-log d)
    linarith

theorem core_half_distance_log_bound {R v : ℝ} (hv : |v| < R) :
    boundaryLog ((R - |v|) / 2) ≤
      boundaryLog (R - v) + boundaryLog (R + v) + log 2 := by
  have hm : boundaryLog (R - |v|) ≤ boundaryLog (R - v) + boundaryLog (R + v) := by
    by_cases hsign : 0 ≤ v
    · rw [abs_of_nonneg hsign]
      exact le_add_of_nonneg_right (le_max_left _ _)
    · rw [abs_of_neg (lt_of_not_ge hsign), sub_neg_eq_add]
      exact le_add_of_nonneg_left (le_max_left _ _)
  exact (boundary_log_half_bound (by linarith : 0 < R - |v|)).trans (by linarith)

theorem continuous_arrival_core_bound {R v P : ℝ} (ψ : ℝ → ℝ)
    (hv : |v| < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    ‖continuousArrival R ψ v‖ ≤ coreMajorant R (2 * (P * tailConstant))
      ((3 / 2 : ℝ) * log 2 + 2 / (1 - exp (-2))) v := by
  have h := mul_le_mul_of_nonneg_left (core_half_distance_log_bound hv)
    (by norm_num : (0 : ℝ) ≤ 3 / 2)
  have h2 := mul_le_mul_of_nonneg_left (add_le_add_right h (2 / (1 - exp (-2))))
    (mul_nonneg (by norm_num : (0 : ℝ) ≤ 2) (mul_nonneg hP tailConstant_nonneg))
  exact (continuous_arrival_mass_bound ψ hv hP hψ hbound).trans
    (by convert h2 using 1; unfold coreMajorant; ring)

theorem continuous_arrival_core_square_integrable {R P : ℝ} (ψ : ℝ → ℝ)
    (hR : 0 < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    IntegrableOn (fun v => continuousArrival R ψ v ^ 2) (Set.Ioo (-R) R) := by
  have hi := core_majorant_square_integrable hR (2 * (P * tailConstant))
    ((3 / 2 : ℝ) * log 2 + 2 / (1 - exp (-2)))
  have hm := (continuous_arrival_aestronglyMeasurable R ψ hψ).pow 2
  apply hi.mono' hm.restrict
  filter_upwards [ae_restrict_mem measurableSet_Ioo] with v hv
  have hb := continuous_arrival_core_bound ψ (abs_lt.mpr hv) hP hψ hbound
  simp only [Pi.pow_apply]
  rw [Real.norm_eq_abs] at hb
  rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _)]
  have hs := mul_self_le_mul_self (abs_nonneg (continuousArrival R ψ v)) hb
  simpa only [← pow_two, sq_abs] using hs

theorem continuous_arrival_core_memLp_two {R P : ℝ} (ψ : ℝ → ℝ)
    (hR : 0 < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    MemLp (continuousArrival R ψ) 2 (volume.restrict (Set.Ioo (-R) R)) :=
  (memLp_two_iff_integrable_sq
    (continuous_arrival_aestronglyMeasurable R ψ hψ).restrict).mpr
    (continuous_arrival_core_square_integrable ψ hR hP hψ hbound)

theorem continuous_arrival_closed_core_memLp_two {R P : ℝ} (ψ : ℝ → ℝ)
    (hR : 0 < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    MemLp (continuousArrival R ψ) 2 (volume.restrict (Set.Icc (-R) R)) := by
  rw [← Measure.restrict_congr_set (Ioo_ae_eq_Icc :
    Set.Ioo (-R) R =ᵐ[volume] Set.Icc (-R) R)]
  exact continuous_arrival_core_memLp_two ψ hR hP hψ hbound

noncomputable def completeCoreArrival (R : ℝ) (ψ : ℝ → ℝ) (v : ℝ) : ℝ :=
  continuousArrival R ψ v + primeArrival R ψ v

theorem complete_core_arrival_memLp_two {R P : ℝ} (ψ : ℝ → ℝ)
    (hR : 0 < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    MemLp (completeCoreArrival R ψ) 2 (volume.restrict (Set.Icc (-R) R)) :=
  (continuous_arrival_closed_core_memLp_two ψ hR hP hψ hbound).add
    (BuildingBlocks.PhysicalPrimeArrivalRegularity.prime_arrival_memLp_core R P ψ hP hψ hbound)

theorem complete_core_arrival_square_integrable {R P : ℝ} (ψ : ℝ → ℝ)
    (hR : 0 < R) (hP : 0 ≤ P) (hψ : AEStronglyMeasurable ψ)
    (hbound : ∀ᵐ w, |ψ w| ≤ P) :
    IntegrableOn (fun v => completeCoreArrival R ψ v ^ 2) (Set.Icc (-R) R) :=
  (complete_core_arrival_memLp_two ψ hR hP hψ hbound).integrable_sq

#print axioms exponential_tail_integral
#print axioms far_tail_mass_bound
#print axioms near_tail_mass_bound
#print axioms tail_mass_bound
#print axioms source_integrand_majorant
#print axioms continuous_arrival_mass_bound
#print axioms boundary_log_half_bound
#print axioms core_half_distance_log_bound
#print axioms continuous_arrival_core_bound
#print axioms continuous_arrival_core_square_integrable
#print axioms continuous_arrival_core_memLp_two
#print axioms continuous_arrival_closed_core_memLp_two
#print axioms complete_core_arrival_memLp_two
#print axioms complete_core_arrival_square_integrable
end BuildingBlocks.PhysicalContinuousArrivalMass
