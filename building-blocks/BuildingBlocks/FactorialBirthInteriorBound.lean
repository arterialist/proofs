import BuildingBlocks.FactorialBirthLcmEnergy
import BuildingBlocks.FactorialAbsoluteEnvelope
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals

open Finset MeasureTheory
namespace BuildingBlocks.FactorialBirthInteriorBound
open FactorialBirthLcmEnergy

noncomputable def beta (t : ℝ) : ℝ := (1 - Real.exp (-t)) / (1 + Real.exp (-t))

theorem beta_bounds (t : ℝ) (ht : 0 ≤ t) : 0 ≤ beta t ∧ beta t ≤ 1 := by
  have he : Real.exp (-t) ≤ 1 := Real.exp_le_one_iff.mpr (by linarith)
  have hp := Real.exp_pos (-t)
  unfold beta
  constructor
  · exact div_nonneg (sub_nonneg.mpr he) (by positivity)
  · apply (div_le_iff₀ (by positivity)).mpr
    linarith

/-- The scalar factor vanishes linearly at the clock origin. -/
theorem beta_le_half (t : ℝ) (ht : 0 ≤ t) : beta t ≤ t / 2 := by
  have hd : ∀ x : ℝ, HasDerivAt
      (fun y : ℝ => y - 2 + (y + 2) * Real.exp (-y))
      (1 - (x + 1) * Real.exp (-x)) x := by
    intro x
    convert ((hasDerivAt_id x).sub (hasDerivAt_const x (2 : ℝ))).add
      (((hasDerivAt_id x).add (hasDerivAt_const x (2 : ℝ))).mul
        ((hasDerivAt_id x).neg.exp)) using 1
    simp only [Pi.add_apply, id_eq, Pi.neg_apply]
    ring
  have hmono := monotone_of_hasDerivAt_nonneg hd (by
    intro x
    change 0 ≤ 1 - (x + 1) * Real.exp (-x)
    have hm := mul_le_mul_of_nonneg_right (Real.add_one_le_exp x) (Real.exp_pos (-x)).le
    simp only [← Real.exp_add, add_neg_cancel, Real.exp_zero] at hm
    linarith)
  have hg := hmono ht
  norm_num at hg
  unfold beta
  apply (div_le_iff₀ (by positivity)).mpr
  nlinarith

/-- Absolute full-clock interior density has an unconditional constant envelope. -/
theorem interior_row_uniform (N : ℕ) (t : ℝ) (ht : 0 < t) :
    |interiorRow N t| ≤ (N : ℝ) / 4 := by
  have hb := beta_bounds t ht.le
  have hr := FactorialAbsoluteEnvelope.response_abs_le_horizon N (2 * t) (by positivity)
  have hw := FactorialBinaryEnergy.weight_pos t ht
  have hw' := FactorialOriginNeutralization.weight_le_half_inverse t ht
  have he : |interiorRow N t| = beta t * |FactorialBinaryCarry.response N (2 * t)| *
      FactorialBinaryEnergy.weight t := by
    unfold interiorRow
    change |beta t * FactorialBinaryCarry.response N (2 * t) *
      FactorialBinaryEnergy.weight t| = _
    rw [abs_mul, abs_mul, abs_of_nonneg hb.1, abs_of_nonneg hw.le]
  rw [he]
  calc
    _ ≤ beta t * (N : ℝ) * FactorialBinaryEnergy.weight t :=
      mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hr hb.1) hw.le
    _ ≤ (t / 2) * (N : ℝ) * (1 / (2 * t)) :=
      mul_le_mul (mul_le_mul_of_nonneg_right (beta_le_half t ht.le) (by positivity)) hw'
        hw.le (by positivity)
    _ = _ := by field_simp; ring

/-- Absolute interior density has a summable inverse-square tail. -/
theorem interior_row_tail (N : ℕ) (t : ℝ) (ht : 0 < t) :
    |interiorRow N t| ≤ (N : ℝ) / t ^ 2 := by
  have hb := beta_bounds t ht.le
  have hr := FactorialAbsoluteEnvelope.response_abs_le_horizon N (2 * t) (by positivity)
  have hw := FactorialBinaryEnergy.weight_pos t ht
  have hw' := FactorialBinaryIntegrability.weight_le_inverse_square t ht
  have he : |interiorRow N t| = beta t * |FactorialBinaryCarry.response N (2 * t)| *
      FactorialBinaryEnergy.weight t := by
    unfold interiorRow
    change |beta t * FactorialBinaryCarry.response N (2 * t) *
      FactorialBinaryEnergy.weight t| = _
    rw [abs_mul, abs_mul, abs_of_nonneg hb.1, abs_of_nonneg hw.le]
  rw [he]
  calc
    _ ≤ beta t * (N : ℝ) * FactorialBinaryEnergy.weight t :=
      mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_left hr hb.1) hw.le
    _ ≤ 1 * (N : ℝ) * (1 / t ^ 2) :=
      mul_le_mul (mul_le_mul_of_nonneg_right hb.2 (by positivity)) hw'
        hw.le (by positivity)
    _ = _ := by ring

/-- Exact elementary tail moment in the original clock. -/
theorem inverse_square_tail (N : ℕ) :
    (∫ t : ℝ in Set.Ioi 1, (N : ℝ) / t ^ 2) = N := by
  have hm := integral_Ioi_rpow_of_lt (a := (-2 : ℝ)) (c := 1) (by norm_num) (by norm_num)
  norm_num at hm
  have hm' : (∫ t : ℝ in Set.Ioi 1, (t ^ (2 : ℕ))⁻¹) = 1 := by
    simpa only [Real.rpow_two] using hm
  simp_rw [div_eq_mul_inv]
  rw [integral_const_mul, hm', mul_one]

/-- The full complete-LCM interior has a linear absolute budget, unconditionally. -/
theorem interior_energy_linear (N : ℕ) : |interiorEnergy N| ≤ 5 * (N : ℝ) / 4 := by
  have hi := interior_integrable N
  have hi0 : IntegrableOn (interiorRow N) (Set.Ioc 0 1) :=
    hi.mono_set Set.Ioc_subset_Ioi_self
  have hi1 : IntegrableOn (interiorRow N) (Set.Ioi 1) :=
    hi.mono_set (Set.Ioi_subset_Ioi (by norm_num : (0 : ℝ) ≤ 1))
  have hlow : |∫ t : ℝ in Set.Ioc 0 1, interiorRow N t| ≤ (N : ℝ) / 4 := by
    have h := norm_integral_le_of_norm_le_const
      (μ := volume.restrict (Set.Ioc (0 : ℝ) 1)) (f := interiorRow N) (C := (N : ℝ) / 4) (by
        filter_upwards [ae_restrict_mem measurableSet_Ioc] with t ht
        simpa only [Real.norm_eq_abs] using interior_row_uniform N t ht.1)
    simpa [measureReal_def] using h
  have hir : IntegrableOn (fun t : ℝ => (N : ℝ) / t ^ 2) (Set.Ioi 1) := by
    have h := integrableOn_Ioi_rpow_of_lt (a := (-2 : ℝ)) (c := 1) (by norm_num) (by norm_num)
    simpa [Real.rpow_neg, Real.rpow_two, div_eq_mul_inv] using h.const_mul (N : ℝ)
  have htail : |∫ t : ℝ in Set.Ioi 1, interiorRow N t| ≤ (N : ℝ) := by
    have hnorm := norm_integral_le_integral_norm (μ := volume.restrict (Set.Ioi (1 : ℝ)))
      (interiorRow N)
    have hmono := integral_mono_ae hi1.norm hir (by
      filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
      simpa only [Real.norm_eq_abs] using interior_row_tail N t (lt_trans zero_lt_one (Set.mem_Ioi.mp ht)))
    simpa only [Real.norm_eq_abs, inverse_square_tail] using hnorm.trans hmono
  have hsplit : interiorEnergy N =
      (∫ t : ℝ in Set.Ioc 0 1, interiorRow N t) +
        (∫ t : ℝ in Set.Ioi 1, interiorRow N t) := by
    unfold interiorEnergy
    rw [← Set.Ioc_union_Ioi_eq_Ioi (by norm_num : (0 : ℝ) ≤ 1)]
    exact setIntegral_union Set.Ioc_disjoint_Ioi_same measurableSet_Ioi hi0 hi1
  rw [hsplit]
  apply (abs_add_le _ _).trans
  linarith

/-- A real-valued triangular sum, including the empty horizon. -/
theorem real_range_sum (N : ℕ) :
    (∑ n ∈ range N, (n : ℝ)) = (N : ℝ) * ((N : ℝ) - 1) / 2 := by
  induction N with
  | zero => simp
  | succ N ih =>
    rw [sum_range_succ, ih, Nat.cast_add, Nat.cast_one]
    ring

/-- Exact integer dyadic horizon mass. -/
theorem real_dyadic_sum (X : ℕ) :
    (∑ n ∈ Ico X (2 * X), (n : ℝ)) = (X : ℝ) * (3 * (X : ℝ) - 1) / 2 := by
  rw [sum_Ico_eq_sub (fun n : ℕ => (n : ℝ)) (by omega : X ≤ 2 * X),
    real_range_sum, real_range_sum, Nat.cast_mul, Nat.cast_ofNat]
  ring

/-- Exact linear interior budget on the complete integer dyad. -/
theorem dyadic_interior_budget (X : ℕ) :
    |∑ N ∈ Ico X (2 * X), interiorEnergy N| ≤ 5 * (X : ℝ) * (3 * (X : ℝ) - 1) / 8 := by
  apply (abs_sum_le_sum_abs _ _).trans
  calc
    _ ≤ ∑ N ∈ Ico X (2 * X), 5 * (N : ℝ) / 4 :=
      sum_le_sum (fun N hN => interior_energy_linear N)
    _ = _ := by
      simp_rw [div_eq_mul_inv, mul_assoc]
      rw [← mul_sum, ← sum_mul, real_dyadic_sum]
      ring

/-- A one-sided boundary upper bound transfers to the original energy. -/
theorem actual_energy_upper (N : ℕ) :
    FactorialBinaryIntegrability.integratedEnergy N ≤ boundaryEnergy N + 5 * (N : ℝ) / 4 := by
  have h := interior_energy_linear N
  have he := actual_energy_boundary N
  linarith [le_abs_self (interiorEnergy N)]

/-- The reverse comparison retains the same unconditional linear allowance. -/
theorem actual_boundary_upper (N : ℕ) :
    boundaryEnergy N ≤ FactorialBinaryIntegrability.integratedEnergy N + 5 * (N : ℝ) / 4 := by
  have h := interior_energy_linear N
  have he := actual_energy_boundary N
  linarith [neg_le_abs (interiorEnergy N)]

/-- Exact dyadic transfer of a signed boundary upper estimate to the original energy. -/
theorem actual_dyadic_energy_upper (X : ℕ) :
    (∑ N ∈ Ico X (2 * X), FactorialBinaryIntegrability.integratedEnergy N) ≤
      (∑ N ∈ Ico X (2 * X), boundaryEnergy N) +
        5 * (X : ℝ) * (3 * (X : ℝ) - 1) / 8 := by
  have he : (∑ N ∈ Ico X (2 * X), FactorialBinaryIntegrability.integratedEnergy N) =
      (∑ N ∈ Ico X (2 * X), interiorEnergy N) +
        (∑ N ∈ Ico X (2 * X), boundaryEnergy N) := by
    simp_rw [actual_energy_boundary]
    rw [sum_add_distrib]
  have h := dyadic_interior_budget X
  linarith [le_abs_self (∑ N ∈ Ico X (2 * X), interiorEnergy N)]

/-- Dyadic reverse transfer; both formulations differ by at most a quadratic allowance. -/
theorem actual_dyadic_boundary_upper (X : ℕ) :
    (∑ N ∈ Ico X (2 * X), boundaryEnergy N) ≤
      (∑ N ∈ Ico X (2 * X), FactorialBinaryIntegrability.integratedEnergy N) +
        5 * (X : ℝ) * (3 * (X : ℝ) - 1) / 8 := by
  have he : (∑ N ∈ Ico X (2 * X), FactorialBinaryIntegrability.integratedEnergy N) =
      (∑ N ∈ Ico X (2 * X), interiorEnergy N) +
        (∑ N ∈ Ico X (2 * X), boundaryEnergy N) := by
    simp_rw [actual_energy_boundary]
    rw [sum_add_distrib]
  have h := dyadic_interior_budget X
  linarith [neg_le_abs (∑ N ∈ Ico X (2 * X), interiorEnergy N)]

/-- Absolute interior allowance on any common finite positive clock band. -/
theorem interior_band_budget (N : ℕ) (T : ℝ) (hT : 0 ≤ T) :
    |∫ t : ℝ in Set.Ioc 0 T, interiorRow N t| ≤ (N : ℝ) * T / 4 := by
  have h := norm_integral_le_of_norm_le_const
    (μ := volume.restrict (Set.Ioc (0 : ℝ) T)) (f := interiorRow N) (C := (N : ℝ) / 4) (by
      filter_upwards [ae_restrict_mem measurableSet_Ioc] with t ht
      simpa only [Real.norm_eq_abs] using interior_row_uniform N t ht.1)
  have h' : |∫ t : ℝ in Set.Ioc 0 T, interiorRow N t| ≤ (N : ℝ) / 4 * T := by
    simpa [measureReal_def, hT] using h
  nlinarith

/-- Signed escaping-boundary upper transfer on the same finite clock band. -/
theorem actual_boundary_band_upper (N : ℕ) (T : ℝ) (hT : 0 ≤ T) :
    (∫ t : ℝ in Set.Ioc 0 T, boundaryRow N t) ≤
      (∫ t : ℝ in Set.Ioc 0 T, FactorialBinaryEnergy.energyRow N t) + (N : ℝ) * T / 4 := by
  have hi : IntegrableOn (interiorRow N) (Set.Ioc 0 T) :=
    (interior_integrable N).mono_set Set.Ioc_subset_Ioi_self
  have hb : IntegrableOn (boundaryRow N) (Set.Ioc 0 T) :=
    (boundary_integrable N).mono_set Set.Ioc_subset_Ioi_self
  have he : (∫ t : ℝ in Set.Ioc 0 T, FactorialBinaryEnergy.energyRow N t) =
      (∫ t : ℝ in Set.Ioc 0 T, interiorRow N t) +
        (∫ t : ℝ in Set.Ioc 0 T, boundaryRow N t) := by
    have hrow : ∀ t : ℝ, FactorialBinaryEnergy.energyRow N t = interiorRow N t + boundaryRow N t := by
      intro t
      unfold FactorialBinaryEnergy.energyRow interiorRow boundaryRow
      rw [FactorialBirthLcmGhost.actual_boundary_decomposition, add_mul]
    simp_rw [hrow]
    exact integral_add hi hb
  have h := interior_band_budget N T hT
  linarith [neg_le_abs (∫ t : ℝ in Set.Ioc 0 T, interiorRow N t)]

end BuildingBlocks.FactorialBirthInteriorBound
#print axioms BuildingBlocks.FactorialBirthInteriorBound.beta_bounds
#print axioms BuildingBlocks.FactorialBirthInteriorBound.beta_le_half
#print axioms BuildingBlocks.FactorialBirthInteriorBound.interior_row_uniform
#print axioms BuildingBlocks.FactorialBirthInteriorBound.interior_row_tail

#print axioms BuildingBlocks.FactorialBirthInteriorBound.inverse_square_tail
#print axioms BuildingBlocks.FactorialBirthInteriorBound.interior_energy_linear

#print axioms BuildingBlocks.FactorialBirthInteriorBound.real_range_sum
#print axioms BuildingBlocks.FactorialBirthInteriorBound.real_dyadic_sum
#print axioms BuildingBlocks.FactorialBirthInteriorBound.dyadic_interior_budget
#print axioms BuildingBlocks.FactorialBirthInteriorBound.actual_energy_upper
#print axioms BuildingBlocks.FactorialBirthInteriorBound.actual_boundary_upper
#print axioms BuildingBlocks.FactorialBirthInteriorBound.actual_dyadic_energy_upper
#print axioms BuildingBlocks.FactorialBirthInteriorBound.actual_dyadic_boundary_upper

#print axioms BuildingBlocks.FactorialBirthInteriorBound.interior_band_budget
#print axioms BuildingBlocks.FactorialBirthInteriorBound.actual_boundary_band_upper
