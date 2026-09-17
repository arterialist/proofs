import BuildingBlocks.ReflectionEnergy
import Mathlib.Analysis.Convolution
import Mathlib.MeasureTheory.Integral.Prod
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus
import Mathlib.Analysis.SpecialFunctions.ExpDeriv

open MeasureTheory Set
open scoped Interval ENNReal

namespace BuildingBlocks.ReflectionFilter

open ReflectionEnergy

noncomputable def L0 (F : ℝ → ℝ) (s : ℝ) : ℝ :=
  F s - ∫ v in 0..s, Real.exp (-3 * (s - v) / 2) * F v

private theorem interval_eq_Icc (g : ℝ → ℝ) {a b : ℝ} (hab : a ≤ b) :
    (∫ u in a..b, g u) = ∫ u in Icc a b, g u := by
  rw [intervalIntegral.integral_of_le hab, integral_Icc_eq_integral_Ioc]

/-- Fubini on the actual closed integration triangle, from local L1 data. -/
theorem triangle_integral {g k : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hg : IntegrableOn g (Icc 0 s)) (hk : IntegrableOn k (Icc 0 s)) :
    (∫ v in 0..s, k v * ∫ u in 0..v, g u) =
      ∫ u in 0..s, g u * ∫ v in u..s, k v := by
  let μ := volume.restrict (Icc 0 s)
  let Q : ℝ × ℝ → ℝ := {z : ℝ × ℝ | z.2 ≤ z.1}.indicator (fun z => k z.1 * g z.2)
  have hQ : Integrable Q (μ.prod μ) :=
    (hk.mul_prod hg).indicator (measurableSet_le measurable_snd measurable_fst)
  have hleft (v : ℝ) (hv : v ∈ Icc 0 s) :
      (∫ u, Q (v,u) ∂μ) = k v * ∫ u in 0..v, g u := by
    have hfun : (fun u => Q (v,u)) = (Iic v).indicator (fun u => k v * g u) := by
      funext u
      simp [Q, Set.indicator]
    rw [hfun, integral_indicator measurableSet_Iic]
    have hinter : Iic v ∩ Icc 0 s = Icc 0 v := by
      ext u
      simp only [mem_inter_iff, mem_Iic, mem_Icc]
      constructor
      · rintro ⟨huv, hu0, _⟩; exact ⟨hu0, huv⟩
      · rintro ⟨hu0, huv⟩; exact ⟨huv, hu0, huv.trans hv.2⟩
    change (∫ u, k v * g u ∂((volume.restrict (Icc 0 s)).restrict (Iic v))) = _
    rw [Measure.restrict_restrict measurableSet_Iic, hinter, integral_const_mul,
      interval_eq_Icc g hv.1]
  have hright (u : ℝ) (hu : u ∈ Icc 0 s) :
      (∫ v, Q (v,u) ∂μ) = g u * ∫ v in u..s, k v := by
    have hfun : (fun v => Q (v,u)) = (Ici u).indicator (fun v => k v * g u) := by
      funext v
      simp [Q, Set.indicator]
    rw [hfun, integral_indicator measurableSet_Ici]
    have hinter : Ici u ∩ Icc 0 s = Icc u s := by
      ext v
      simp only [mem_inter_iff, mem_Ici, mem_Icc]
      constructor
      · rintro ⟨huv, _, hvs⟩; exact ⟨huv, hvs⟩
      · rintro ⟨huv, hvs⟩; exact ⟨huv, hu.1.trans huv, hvs⟩
    change (∫ v, k v * g u ∂((volume.restrict (Icc 0 s)).restrict (Ici u))) = _
    rw [Measure.restrict_restrict measurableSet_Ici, hinter, integral_mul_const,
      interval_eq_Icc k hu.2, mul_comm]
  rw [interval_eq_Icc _ hs, interval_eq_Icc _ hs]
  calc
    _ = ∫ v, ∫ u, Q (v,u) ∂μ ∂μ := by
      apply setIntegral_congr_fun measurableSet_Icc
      intro v hv
      exact (hleft v hv).symm
    _ = ∫ u, ∫ v, Q (v,u) ∂μ ∂μ := integral_integral_swap hQ
    _ = _ := by
      apply setIntegral_congr_fun measurableSet_Icc
      intro u hu
      exact hright u hu

/-- The cumulative square energy is continuous on its full closed interval. -/
theorem energy_continuousOn {f : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Icc 0 s))) :
    ContinuousOn (energy f) (Icc 0 s) := by
  have hi : IntegrableOn (fun u => f u ^ 2) (uIcc 0 s) := by
    simpa [uIcc_of_le hs] using hf.integrable_sq
  simpa [energy, uIcc_of_le hs] using intervalIntegral.continuousOn_primitive_interval hi

theorem filtered_energy_integrable {f : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Icc 0 s))) :
    IntervalIntegrable (fun v => Real.exp (-3 * (s - v) / 2) * energy f v) volume 0 s := by
  apply (intervalIntegrable_iff_integrableOn_Icc_of_le hs).mpr
  apply ContinuousOn.integrableOn_Icc
  exact (by fun_prop : Continuous (fun v : ℝ => Real.exp (-3 * (s - v) / 2))).continuousOn.mul
    (energy_continuousOn hs hf)

private theorem exp_kernel_integral (s u : ℝ) :
    (∫ v in u..s, Real.exp (-3 * (s - v) / 2)) =
      (2 / 3 : ℝ) * (1 - Real.exp (-3 * (s - u) / 2)) := by
  have hd (v : ℝ) : HasDerivAt (fun v => (2 / 3 : ℝ) * Real.exp (-3 * (s - v) / 2))
      (Real.exp (-3 * (s - v) / 2)) v := by
    have ha := (((hasDerivAt_const v s).sub (hasDerivAt_id v)).const_mul (-3)).div_const 2
    change HasDerivAt (fun v => -3 * (s - v) / 2) (-3 * (0 - 1) / 2) v at ha
    convert ha.exp.const_mul (2 / 3 : ℝ) using 1 <;> ring
  have hi : IntervalIntegrable (fun v => Real.exp (-3 * (s - v) / 2)) volume u s :=
    (by fun_prop : Continuous (fun v : ℝ => Real.exp (-3 * (s - v) / 2))).intervalIntegrable _ _
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt (fun v _ => hd v) hi]
  simp
  ring

/-- The actual exponential filter leaves an explicit positive square-energy weight. -/
theorem filtered_energy_identity {f : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Icc 0 s))) :
    L0 (energy f) s = ∫ u in 0..s,
      ((1 / 3 : ℝ) + (2 / 3 : ℝ) * Real.exp (-3 * (s - u) / 2)) * f u ^ 2 := by
  have hk : IntegrableOn (fun v => Real.exp (-3 * (s - v) / 2)) (Icc 0 s) :=
    (by fun_prop : Continuous (fun v : ℝ => Real.exp (-3 * (s - v) / 2))).integrableOn_Icc
  have htri := triangle_integral hs hf.integrable_sq hk
  change (∫ v in 0..s, Real.exp (-3 * (s - v) / 2) * energy f v) = _ at htri
  simp_rw [exp_kernel_integral] at htri
  have hsq := square_intervalIntegrable hs hf
  have hmul : IntervalIntegrable
      (fun u => f u ^ 2 * ((2 / 3 : ℝ) * (1 - Real.exp (-3 * (s - u) / 2)))) volume 0 s :=
    hsq.mul_continuousOn (by fun_prop)
  unfold L0
  rw [htri]
  unfold energy
  rw [← intervalIntegral.integral_sub hsq hmul]
  apply intervalIntegral.integral_congr
  intro u _
  ring

/-- The reflected convolution is locally integrable; no smoothness of f is required. -/
theorem reflected_convolution_integrableOn {f : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Icc 0 s))) :
    IntegrableOn (fun v => ∫ u in 0..v, f u * f (v - u)) (Icc 0 s) := by
  let fc := (Icc 0 s).indicator f
  have hfc : Integrable fc :=
    (integrable_indicator_iff measurableSet_Icc).mpr (hf.integrable (by norm_num))
  have hc := hfc.integrable_convolution (L := ContinuousLinearMap.mul ℝ ℝ) hfc
  apply hc.integrableOn.congr_fun _ measurableSet_Icc
  intro v hv
  dsimp only
  rw [MeasureTheory.convolution_def, interval_eq_Icc _ hv.1, ← integral_indicator measurableSet_Icc]
  apply integral_congr_ae
  filter_upwards [] with u
  change fc u * fc (v - u) = (Icc 0 v).indicator (fun u => f u * f (v - u)) u
  by_cases hu : u ∈ Icc 0 v
  · have huS : u ∈ Icc 0 s := ⟨hu.1, hu.2.trans hv.2⟩
    have hsub : v - u ∈ Icc 0 s := ⟨sub_nonneg.mpr hu.2, by linarith [hv.2, hu.1]⟩
    simp [fc, Set.indicator_of_mem huS, Set.indicator_of_mem hsub, Set.indicator_of_mem hu]
  · rw [Set.indicator_of_notMem hu]
    by_cases hu0 : 0 ≤ u
    · have huv : v < u := lt_of_not_ge (fun hh => hu ⟨hu0, hh⟩)
      have hsub : v - u ∉ Icc 0 s := fun hh => (not_le_of_gt huv) (sub_nonneg.mp hh.1)
      simp [fc, Set.indicator_of_notMem hsub]
    · have huS : u ∉ Icc 0 s := fun hh => hu0 hh.1
      simp [fc, Set.indicator_of_notMem huS]

/-- The defect as a function of age is locally integrable, derived from actual L2 data. -/
theorem defect_integrableOn {f : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Icc 0 s))) :
    IntegrableOn (defect f) (Icc 0 s) := by
  have he : IntegrableOn (energy f) (Icc 0 s) := (energy_continuousOn hs hf).integrableOn_Icc
  have hc := reflected_convolution_integrableOn hs hf
  apply IntegrableOn.congr_fun (he.sub hc) _ measurableSet_Icc
  intro v hv
  have hfv : MemLp f 2 (volume.restrict (Icc 0 v)) :=
    hf.mono_measure (Measure.restrict_mono (Icc_subset_Icc_right hv.2) le_rfl)
  have hh := reflection_identity hv.1 hfv
  dsimp only [Pi.sub_apply]
  linarith

/-- Filtering the actual reflected convolution gives weighted energy minus filtered defect. -/
theorem filtered_reflection_identity {f : ℝ → ℝ} {s : ℝ} (hs : 0 ≤ s)
    (hf : MemLp f 2 (volume.restrict (Icc 0 s))) :
    L0 (fun v => ∫ u in 0..v, f u * f (v - u)) s =
      (∫ u in 0..s, ((1 / 3 : ℝ) + (2 / 3 : ℝ) *
        Real.exp (-3 * (s - u) / 2)) * f u ^ 2) - L0 (defect f) s := by
  have hd : IntervalIntegrable (defect f) volume 0 s :=
    (intervalIntegrable_iff_integrableOn_Icc_of_le hs).mpr (defect_integrableOn hs hf)
  have hkd : IntervalIntegrable (fun v => Real.exp (-3 * (s - v) / 2) * defect f v) volume 0 s :=
    hd.continuousOn_mul (by fun_prop)
  have hke := filtered_energy_integrable hs hf
  have heq : (∫ v in 0..s, Real.exp (-3 * (s - v) / 2) *
      (∫ u in 0..v, f u * f (v - u))) =
      ∫ v in 0..s, (Real.exp (-3 * (s - v) / 2) * energy f v -
        Real.exp (-3 * (s - v) / 2) * defect f v) := by
    apply intervalIntegral.integral_congr
    intro v hv
    have hv' : v ∈ Icc 0 s := by simpa [uIcc_of_le hs] using hv
    have hfv : MemLp f 2 (volume.restrict (Icc 0 v)) :=
      hf.mono_measure (Measure.restrict_mono (Icc_subset_Icc_right hv'.2) le_rfl)
    dsimp only
    rw [reflection_identity hv'.1 hfv]
    ring
  rw [← filtered_energy_identity hs hf]
  unfold L0
  dsimp only
  rw [heq, intervalIntegral.integral_sub hke hkd, reflection_identity hs hf]
  ring

#print axioms triangle_integral
#print axioms filtered_energy_integrable
#print axioms filtered_energy_identity
#print axioms reflected_convolution_integrableOn
#print axioms defect_integrableOn
#print axioms filtered_reflection_identity

end BuildingBlocks.ReflectionFilter
