import BuildingBlocks.PhysicalContinuousArrival
import BuildingBlocks.PhysicalGroundPrimeArrival
import Mathlib.MeasureTheory.Integral.Prod

namespace BuildingBlocks.PhysicalArrivalBoundary
open Real MeasureTheory
open BuildingBlocks.PhysicalContinuousArrival BuildingBlocks.PhysicalGroundPrimeArrival

noncomputable def boundaryLog (d : ℝ) : ℝ := max 0 (-log d)

noncomputable def continuousArrival (R : ℝ) (ψ : ℝ → ℝ) (v : ℝ) : ℝ :=
  ∫ w : ℝ, kernel |v - w| * source R ψ w

theorem source_aestronglyMeasurable (R : ℝ) (ψ : ℝ → ℝ)
    (hψ : AEStronglyMeasurable ψ) : AEStronglyMeasurable (source R ψ) := by
  have hm : MeasurableSet {v : ℝ | R < |v|} :=
    measurableSet_lt measurable_const continuous_abs.measurable
  simpa [source, Set.indicator] using
    (BuildingBlocks.PhysicalThetaUniform.phi_continuous.aestronglyMeasurable.mul hψ).indicator hm

theorem continuous_arrival_aestronglyMeasurable (R : ℝ) (ψ : ℝ → ℝ)
    (hψ : AEStronglyMeasurable ψ) : AEStronglyMeasurable (continuousArrival R ψ) := by
  have hk : Measurable (fun p : ℝ × ℝ => kernel |p.1 - p.2|) := by
    unfold kernel
    fun_prop
  have hi : AEStronglyMeasurable
      (fun p : ℝ × ℝ => kernel |p.1 - p.2| * source R ψ p.2)
      (volume.prod volume) :=
    hk.aestronglyMeasurable.mul (source_aestronglyMeasurable R ψ hψ).comp_snd
  exact hi.integral_prod_right'

theorem log_sq_bound {x : ℝ} (hx : 0 < x) (hx1 : x ≤ 1) :
    (log x) ^ 2 ≤ 16 * x ^ (-1 / 2 : ℝ) := by
  have h := (abs_log_mul_self_rpow_lt x (1 / 4) hx hx1 (by norm_num)).le
  rw [abs_mul, abs_of_pos (rpow_pos_of_pos hx (1 / 4))] at h
  norm_num at h
  have hh := mul_self_le_mul_self
    (mul_nonneg (abs_nonneg (log x)) (rpow_nonneg hx.le (1 / 4))) h
  have hsq : (log x) ^ 2 * (x ^ (1 / 4 : ℝ)) ^ 2 ≤ 16 := by
    nlinarith [sq_abs (log x)]
  have hp : (x ^ (1 / 4 : ℝ)) ^ 2 * x ^ (-1 / 2 : ℝ) = 1 := by
    rw [sq, ← rpow_add hx, ← rpow_add hx]
    norm_num
  calc
    (log x) ^ 2 = ((log x) ^ 2 * (x ^ (1 / 4 : ℝ)) ^ 2) *
        x ^ (-1 / 2 : ℝ) := by rw [mul_assoc, hp, mul_one]
    _ ≤ 16 * x ^ (-1 / 2 : ℝ) :=
      mul_le_mul_of_nonneg_right hsq (rpow_nonneg hx.le _)

theorem log_sq_integrable_near_zero :
    IntegrableOn (fun x : ℝ => (log x) ^ 2) (Set.Ioo 0 1) := by
  have hi : IntegrableOn (fun x : ℝ => 16 * x ^ (-1 / 2 : ℝ)) (Set.Ioo 0 1) :=
    ((intervalIntegral.integrableOn_Ioo_rpow_iff zero_lt_one).mpr
      (by norm_num : (-1 : ℝ) < -1 / 2)).const_mul 16
  have hc : ContinuousOn (fun x : ℝ => (log x) ^ 2) (Set.Ioo 0 1) :=
    (continuousOn_log.mono (fun x hx => by simpa using ne_of_gt hx.1)).pow 2
  apply hi.mono' (hc.aestronglyMeasurable measurableSet_Ioo)
  filter_upwards [ae_restrict_mem measurableSet_Ioo] with x hx
  rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _)]
  exact log_sq_bound hx.1 hx.2.le

theorem boundary_log_sq_integrable (L : ℝ) :
    IntegrableOn (fun x : ℝ => (boundaryLog x) ^ 2) (Set.Ioo 0 L) := by
  have hi := log_sq_integrable_near_zero.integrable_indicator measurableSet_Ioo
  apply hi.integrableOn.congr_fun _ measurableSet_Ioo
  intro x hx
  by_cases hx1 : x < 1
  · rw [Set.indicator_of_mem (show x ∈ Set.Ioo (0 : ℝ) 1 from ⟨hx.1, hx1⟩)]
    have hl : log x ≤ 0 := log_nonpos hx.1.le hx1.le
    simp [boundaryLog, max_eq_right (by linarith : 0 ≤ -log x)]
  · rw [Set.indicator_of_notMem (show x ∉ Set.Ioo (0 : ℝ) 1 from fun h => hx1 h.2)]
    have hl : 0 ≤ log x := log_nonneg (le_of_not_gt hx1)
    simp [boundaryLog, max_eq_left (by linarith : -log x ≤ 0)]

theorem core_boundary_log_sq_integrable {R : ℝ} (hR : 0 < R) :
    IntegrableOn (fun v : ℝ => (boundaryLog (R - v)) ^ 2) (Set.Ioo (-R) R) ∧
    IntegrableOn (fun v : ℝ => (boundaryLog (R + v)) ^ 2) (Set.Ioo (-R) R) := by
  have hi : IntervalIntegrable (fun x : ℝ => (boundaryLog x) ^ 2) volume 0 (2 * R) :=
    (intervalIntegrable_iff_integrableOn_Ioo_of_le (by linarith : (0 : ℝ) ≤ 2 * R)).mpr
      (boundary_log_sq_integrable (2 * R))
  have ha : IntervalIntegrable (fun v : ℝ => (boundaryLog (R - v)) ^ 2)
      volume (-R) R := by
    convert hi.symm.comp_sub_left R using 1 <;> ring
  have hb : IntervalIntegrable (fun v : ℝ => (boundaryLog (R + v)) ^ 2)
      volume (-R) R := by
    convert hi.comp_add_left R using 1 <;> ring
  exact ⟨(intervalIntegrable_iff_integrableOn_Ioo_of_le (by linarith)).mp ha,
    (intervalIntegrable_iff_integrableOn_Ioo_of_le (by linarith)).mp hb⟩

noncomputable def coreMajorant (R M c v : ℝ) : ℝ :=
  M * ((3 / 2 : ℝ) * boundaryLog (R - v) + (3 / 2 : ℝ) * boundaryLog (R + v) + c)

theorem core_majorant_square_integrable {R : ℝ} (hR : 0 < R) (M c : ℝ) :
    IntegrableOn (fun v => coreMajorant R M c v ^ 2) (Set.Ioo (-R) R) := by
  obtain ⟨ha, hb⟩ := core_boundary_log_sq_integrable hR
  have hc : IntegrableOn (fun _ : ℝ => c ^ 2) (Set.Ioo (-R) R) :=
    integrableOn_const (by simp [Real.volume_Ioo])
  have hi := ((ha.add hb).add hc).const_mul (9 * M ^ 2)
  have hm : Measurable (fun v => coreMajorant R M c v ^ 2) := by
    unfold coreMajorant boundaryLog
    fun_prop
  apply hi.mono' hm.aestronglyMeasurable
  filter_upwards [] with v
  rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _)]
  let a := boundaryLog (R - v)
  let b := boundaryLog (R + v)
  have h1 : ((3 / 2 : ℝ) * a + (3 / 2 : ℝ) * b + c) ^ 2 ≤
      3 * (((3 / 2 : ℝ) * a) ^ 2 + ((3 / 2 : ℝ) * b) ^ 2 + c ^ 2) := by
    nlinarith [sq_nonneg ((3 / 2 : ℝ) * a - (3 / 2 : ℝ) * b),
      sq_nonneg ((3 / 2 : ℝ) * a - c), sq_nonneg ((3 / 2 : ℝ) * b - c)]
  have h2 : ((3 / 2 : ℝ) * a + (3 / 2 : ℝ) * b + c) ^ 2 ≤
      9 * (a ^ 2 + b ^ 2 + c ^ 2) := by
    nlinarith [sq_nonneg a, sq_nonneg b, sq_nonneg c]
  have h := mul_le_mul_of_nonneg_left h2 (sq_nonneg M)
  simpa only [coreMajorant, pow_two, mul_assoc, mul_left_comm, mul_comm] using h

#print axioms core_majorant_square_integrable

#print axioms source_aestronglyMeasurable
#print axioms continuous_arrival_aestronglyMeasurable
#print axioms log_sq_bound
#print axioms log_sq_integrable_near_zero
#print axioms boundary_log_sq_integrable
#print axioms core_boundary_log_sq_integrable
end BuildingBlocks.PhysicalArrivalBoundary
