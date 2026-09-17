import Mathlib.MeasureTheory.Function.L2Space
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic

open MeasureTheory
open scoped Interval ENNReal

namespace BuildingBlocks.ReflectionEnergy

noncomputable def energy (f : ℝ → ℝ) (s : ℝ) : ℝ := ∫ u in 0..s, f u ^ 2

noncomputable def defect (f : ℝ → ℝ) (s : ℝ) : ℝ :=
  (1 / 2 : ℝ) * ∫ u in 0..s, (f u - f (s - u)) ^ 2

/-- Reflection preserves the actual local square-integrability hypothesis. -/
theorem reflected_memLp {f : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Set.Icc 0 s))) :
    MemLp (fun u => f (s - u)) 2 (volume.restrict (Set.Icc 0 s)) := by
  have h1 : IntervalIntegrable f volume 0 s :=
    (intervalIntegrable_iff_integrableOn_Icc_of_le hs).mpr (hf.integrable (by norm_num))
  have h2 : IntervalIntegrable (fun u => f u ^ 2) volume 0 s :=
    (intervalIntegrable_iff_integrableOn_Icc_of_le hs).mpr hf.integrable_sq
  have hr1 : IntervalIntegrable (fun u => f (s - u)) volume 0 s := by
    simpa using (h1.comp_sub_left s).symm
  have hr2 : IntervalIntegrable (fun u => f (s - u) ^ 2) volume 0 s := by
    simpa using (h2.comp_sub_left s).symm
  have hir1 := (intervalIntegrable_iff_integrableOn_Icc_of_le hs).mp hr1
  exact (memLp_two_iff_integrable_sq hir1.aestronglyMeasurable).mpr
    ((intervalIntegrable_iff_integrableOn_Icc_of_le hs).mp hr2)

theorem reflected_square_integral (f : ℝ → ℝ) (s : ℝ) :
    (∫ u in 0..s, f (s - u) ^ 2) = energy f s := by
  simpa [energy] using intervalIntegral.integral_comp_sub_left (fun u => f u ^ 2) s (a := 0) (b := s)

theorem square_intervalIntegrable {f : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Set.Icc 0 s))) :
    IntervalIntegrable (fun u => f u ^ 2) volume 0 s :=
  (intervalIntegrable_iff_integrableOn_Icc_of_le hs).mpr hf.integrable_sq

theorem cross_intervalIntegrable {f g : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Set.Icc 0 s)))
    (hg : MemLp g 2 (volume.restrict (Set.Icc 0 s))) :
    IntervalIntegrable (fun u => f u * g u) volume 0 s :=
  (intervalIntegrable_iff_integrableOn_Icc_of_le hs).mpr (hf.integrable_mul hg)

theorem reflected_cross_intervalIntegrable {f : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Set.Icc 0 s))) :
    IntervalIntegrable (fun u => f u * f (s - u)) volume 0 s :=
  cross_intervalIntegrable hs hf (reflected_memLp hs hf)

theorem difference_square_intervalIntegrable {f : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Set.Icc 0 s))) :
    IntervalIntegrable (fun u => (f u - f (s - u)) ^ 2) volume 0 s :=
  square_intervalIntegrable hs (hf.sub (reflected_memLp hs hf))

/-- The exact reflection-energy splitting, with every cross term retained. -/
theorem reflection_identity {f : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Set.Icc 0 s))) :
    (∫ u in 0..s, f u * f (s - u)) = energy f s - defect f s := by
  have hsq := square_intervalIntegrable hs hf
  have hrsq := square_intervalIntegrable hs (reflected_memLp hs hf)
  have hcross := reflected_cross_intervalIntegrable hs hf
  have heq : (fun u => (f u - f (s - u)) ^ 2) =
      (fun u => (f u ^ 2 + f (s - u) ^ 2) - 2 * (f u * f (s - u))) := by
    funext u
    ring
  unfold defect
  rw [heq, intervalIntegral.integral_sub (hsq.add hrsq) (hcross.const_mul 2),
    intervalIntegral.integral_add hsq hrsq, intervalIntegral.integral_const_mul,
    reflected_square_integral]
  unfold energy
  ring

theorem energy_nonneg (f : ℝ → ℝ) {s : ℝ} (hs : 0 ≤ s) : 0 ≤ energy f s :=
  intervalIntegral.integral_nonneg_of_forall hs (fun u => sq_nonneg (f u))

theorem defect_nonneg (f : ℝ → ℝ) {s : ℝ} (hs : 0 ≤ s) : 0 ≤ defect f s := by
  exact mul_nonneg (by norm_num) (intervalIntegral.integral_nonneg_of_forall hs
    (fun u => sq_nonneg (f u - f (s - u))))

theorem defect_le_two_energy {f : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Set.Icc 0 s))) : defect f s ≤ 2 * energy f s := by
  have hsq := square_intervalIntegrable hs hf
  have hrsq := square_intervalIntegrable hs (reflected_memLp hs hf)
  have hbound : (∫ u in 0..s, (f u - f (s - u)) ^ 2) ≤
      ∫ u in 0..s, 2 * (f u ^ 2 + f (s - u) ^ 2) := by
    apply intervalIntegral.integral_mono_on hs (difference_square_intervalIntegrable hs hf)
      ((hsq.add hrsq).const_mul 2)
    intro u _
    nlinarith [sq_nonneg (f u + f (s - u))]
  rw [intervalIntegral.integral_const_mul, intervalIntegral.integral_add hsq hrsq,
    reflected_square_integral] at hbound
  unfold energy at *
  unfold defect
  linarith

/-- The perturbation formula includes the mixed reflection difference and its square. -/
theorem defect_add_sub {f g : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Set.Icc 0 s)))
    (hg : MemLp g 2 (volume.restrict (Set.Icc 0 s))) :
    defect (fun u => f u + g u) s - defect f s = defect g s +
      ∫ u in 0..s, (f u - f (s - u)) * (g u - g (s - u)) := by
  have hdf := difference_square_intervalIntegrable hs hf
  have hdg := difference_square_intervalIntegrable hs hg
  have hc := cross_intervalIntegrable hs (hf.sub (reflected_memLp hs hf))
    (hg.sub (reflected_memLp hs hg))
  change IntervalIntegrable (fun u => (f u - f (s - u)) * (g u - g (s - u))) volume 0 s at hc
  have heq : (fun u => (f u + g u - (f (s - u) + g (s - u))) ^ 2) =
      (fun u => ((f u - f (s - u)) ^ 2 + (g u - g (s - u)) ^ 2) +
        2 * ((f u - f (s - u)) * (g u - g (s - u)))) := by
    funext u
    ring
  unfold defect
  rw [heq, intervalIntegral.integral_add (hdf.add hdg) (hc.const_mul 2),
    intervalIntegral.integral_add hdf hdg, intervalIntegral.integral_const_mul]
  ring

#print axioms reflected_memLp
#print axioms reflection_identity
#print axioms defect_le_two_energy
#print axioms defect_add_sub

end BuildingBlocks.ReflectionEnergy
