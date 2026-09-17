import BuildingBlocks.ChargeBirthSummability
import BuildingBlocks.IntegerBirthHalfDensity
import BuildingBlocks.SuccessorCharge
import BuildingBlocks.CriticalCoordinatePairing

open MeasureTheory Set Filter

namespace BuildingBlocks.ChargeOriginalBirth

open IntegerBirthHalfDensity IntegerBirthDiscreteCorrection ChargeBirthSummability

noncomputable def beta (n : ℕ) (v : ℝ) : ℝ :=
  if (n : ℝ) ≤ Real.exp v then Real.exp (-v / 2) else 0

noncomputable def birthPull (n j : ℕ) (v : ℝ) : ℝ :=
  Real.exp v * (2 * birthDensity n j (Real.exp v))

theorem beta_eq_birthPull (n : ℕ) (v : ℝ) : beta n v = birthPull n 0 v := by
  have hs : Real.sqrt (Real.exp v) ≠ 0 := (Real.sqrt_pos.mpr (Real.exp_pos v)).ne'
  have he : Real.exp (-v / 2) = 1 / Real.sqrt (Real.exp v) := by
    rw [← Real.exp_half, one_div, ← Real.exp_neg]
    congr 1
    ring
  unfold beta birthPull birthDensity halfDensity
  simp only [Nat.cast_zero, add_zero]
  split_ifs
  · rw [he]
    field_simp
  · simp

theorem successor_beta_eq_birthPull (n : ℕ) (v : ℝ) :
    BuildingBlocks.SuccessorCharge.successor (beta n) v = birthPull n 1 v := by
  have hx : 0 < Real.exp v := Real.exp_pos v
  have hy : 0 < 1 + Real.exp v := by positivity
  have hs : Real.sqrt (1 + Real.exp v) ≠ 0 := (Real.sqrt_pos.mpr hy).ne'
  have he : Real.exp (-Real.log (1 + Real.exp v) / 2) = 1 / Real.sqrt (1 + Real.exp v) := by
    have hh : Real.sqrt (1 + Real.exp v) = Real.exp (Real.log (1 + Real.exp v) / 2) := by
      rw [Real.exp_half, Real.exp_log hy]
    rw [hh, one_div, ← Real.exp_neg]
    congr 1
    ring
  unfold BuildingBlocks.SuccessorCharge.successor BuildingBlocks.SuccessorCharge.amplitude
    BuildingBlocks.SuccessorCharge.jacobian BuildingBlocks.SuccessorCharge.sigma beta birthPull birthDensity halfDensity
  rw [Real.exp_log hy, Real.sqrt_div hx.le]
  simp only [Nat.cast_one]
  rw [add_comm (Real.exp v) 1]
  split_ifs
  · rw [he]
    have hex : Real.exp v ≠ 0 := hx.ne'
    have hsx : Real.sqrt (Real.exp v) ≠ 0 := (Real.sqrt_pos.mpr hx).ne'
    field_simp
    nlinarith [Real.sq_sqrt hx.le, Real.sq_sqrt hy.le]
  · simp

theorem birthPull_integrable (n j : ℕ) : IntegrableOn (birthPull n j) (Ioi (0 : ℝ)) := by
  have h := integrableOn_image_iff_integrableOn_abs_deriv_smul (s := Ioi (0 : ℝ))
    measurableSet_Ioi (fun v _ => (Real.hasDerivAt_exp v).hasDerivWithinAt)
    Real.exp_injective.injOn (fun x => 2 * birthDensity n j x)
  rw [BuildingBlocks.MixedEnergy.exp_image_Ioi, Real.exp_zero] at h
  apply (h.mp ((birthDensity_integrable n j).const_mul 2)).congr
  exact Eventually.of_forall (fun v => by simp [birthPull, smul_eq_mul, abs_of_pos (Real.exp_pos v)])

theorem birthPull_integral_eq_physical (n j : ℕ) :
    (∫ v in Ioi (0 : ℝ), birthPull n j v) =
      2 * ∫ x in Ioi (1 : ℝ), birthDensity n j x := by
  have h := integral_image_eq_integral_abs_deriv_smul (s := Ioi (0 : ℝ))
    measurableSet_Ioi (fun v _ => (Real.hasDerivAt_exp v).hasDerivWithinAt)
    Real.exp_injective.injOn (fun x => 2 * birthDensity n j x)
  rw [BuildingBlocks.MixedEnergy.exp_image_Ioi, Real.exp_zero] at h
  calc
    _ = ∫ v in Ioi (0 : ℝ), |Real.exp v| • (2 * birthDensity n j (Real.exp v)) := by
      apply integral_congr_ae
      exact Eventually.of_forall (fun v => by simp [birthPull, smul_eq_mul, abs_of_pos (Real.exp_pos v)])
    _ = ∫ x in Ioi (1 : ℝ), 2 * birthDensity n j x := h.symm
    _ = _ := by
      rw [integral_const_mul]

theorem birthPull_integral {n : ℕ} (hn : 2 ≤ n) (j : ℕ) :
    (∫ v in Ioi (0 : ℝ), birthPull n j v) = 2 * discreteBirth n j := by
  rw [birthPull_integral_eq_physical, birthDensity_integral hn]

/-- The central original relative-charge operator has the literal birth coefficient. -/
theorem original_defect_beta {n : ℕ} (hn : 2 ≤ n) :
    BuildingBlocks.SuccessorCharge.defect (beta n) = correction n := by
  have hi : IntegrableOn (beta n) (Ioi (0 : ℝ)) := by
    simpa only [funext (beta_eq_birthPull n)] using birthPull_integrable n 0
  rw [BuildingBlocks.SuccessorCharge.defect_eq_charge_difference hi]
  unfold BuildingBlocks.SuccessorCharge.charge
  simp_rw [successor_beta_eq_birthPull, beta_eq_birthPull]
  rw [birthPull_integral hn 1, birthPull_integral hn 0, correction_eq_discrete_difference hn]
  ring

#print axioms original_defect_beta

/-- Every original prime-power atom charge is absolutely summable. -/
theorem original_weighted_atom_charge_summable :
    Summable (fun n : ℕ => |ArithmeticFunction.vonMangoldt (n + 2) *
      BuildingBlocks.SuccessorCharge.defect (beta (n + 2))|) := by
  apply weighted_correction_norm_summable.congr
  intro n
  rw [original_defect_beta (by omega : 2 ≤ n + 2), Real.norm_eq_abs]

#print axioms original_weighted_atom_charge_summable

/-- The initial reference uses the original central kernel on its causal half-line. -/
theorem original_defect_reference :
    BuildingBlocks.SuccessorCharge.defect (fun v : ℝ => Real.exp (-v / 2)) = Real.pi / 4 - 1 := by
  have he : BuildingBlocks.SuccessorCharge.successor (fun v : ℝ => Real.exp (-v / 2)) = birthPull 1 1 := by
    funext v
    rw [← successor_beta_eq_birthPull]
    unfold BuildingBlocks.SuccessorCharge.successor
    congr 1
    unfold beta BuildingBlocks.SuccessorCharge.sigma
    rw [Real.exp_log (by positivity : 0 < 1 + Real.exp v)]
    simp only [Nat.cast_one, if_pos (by linarith [Real.exp_pos v] : (1 : ℝ) ≤ 1 + Real.exp v)]
  have hp : (∫ x in Ioi (1 : ℝ), birthDensity 1 1 x) = Real.pi / 4 := by
    calc
      _ = ∫ x in Ioi (1 : ℝ), halfDensity 1 x := by
        apply integral_congr_ae
        filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with x hx
        change (1 : ℝ) < x at hx
        simp only [birthDensity, Nat.cast_one, if_pos (by linarith : (1 : ℝ) ≤ x + 1)]
      _ = _ := by
        rw [halfDensity_integral_pos (by norm_num : 0 < (1 : ℕ)) (by norm_num : (0 : ℝ) < 1)]
        norm_num [Real.arctan_one]
  rw [BuildingBlocks.SuccessorCharge.defect_eq_charge_difference BuildingBlocks.SuccessorCharge.reference_integrable]
  unfold BuildingBlocks.SuccessorCharge.charge
  rw [he, birthPull_integral_eq_physical, hp, BuildingBlocks.SuccessorCharge.reference_integral]
  ring

/-- The full first cutoff birth is minus the causal reference, including its origin. -/
theorem original_defect_first_birth :
    BuildingBlocks.SuccessorCharge.defect (fun v : ℝ => -Real.exp (-v / 2)) = 1 - Real.pi / 4 := by
  have h : BuildingBlocks.SuccessorCharge.defect (fun v : ℝ => -Real.exp (-v / 2)) =
      -BuildingBlocks.SuccessorCharge.defect (fun v : ℝ => Real.exp (-v / 2)) := by
    unfold BuildingBlocks.SuccessorCharge.defect
    simp only [mul_neg, integral_neg]
  rw [h, original_defect_reference]
  ring

#print axioms original_defect_reference
#print axioms original_defect_first_birth

end BuildingBlocks.ChargeOriginalBirth
