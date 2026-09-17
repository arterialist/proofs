import BuildingBlocks.CriticalCoordinatePairing
import BuildingBlocks.SuccessorChargeEnergy
import BuildingBlocks.CoarsePrimeBounds
import Mathlib.Analysis.SpecificLimits.Normed

/-! The ordinary successor iterates of the actual prime error and their relative
charges. Chebyshev's bound suffices; no unweighted source integral is assumed. -/

open MeasureTheory Real Set Filter
open scoped Topology

namespace BuildingBlocks.SuccessorCharge

theorem successor_iterate_physicalLift (H : ℝ → ℝ) (j : ℕ) (v : ℝ) :
    successor^[j] (MixedEnergy.physicalLift H) v =
      exp (v / 2) * H (exp v + j) := by
  induction j generalizing v with
  | zero => simp [MixedEnergy.physicalLift]
  | succ j ih =>
    rw [Function.iterate_succ_apply', successor, ih, amplitude_eq_exp,
      ← mul_assoc, ← exp_add]
    rw [show (v - sigma v) / 2 + sigma v / 2 = v / 2 by ring]
    rw [sigma, exp_log (by positivity), Nat.cast_succ]
    congr 2
    ring

theorem successor_iterate_congr_nonneg {f g : ℝ → ℝ}
    (heq : ∀ v, 0 ≤ v → f v = g v) (j : ℕ) {v : ℝ} (hv : 0 ≤ v) :
    successor^[j] f v = successor^[j] g v := by
  induction j generalizing v with
  | zero => exact heq v hv
  | succ j ih =>
    rw [Function.iterate_succ_apply', Function.iterate_succ_apply', successor, successor]
    congr 1
    exact ih (show 0 ≤ sigma v from
      (log_pos (by have := exp_pos v; linarith : 1 < 1 + exp v)).le)

/-- A bounded physical source has an absolutely defined relative charge at
every ordinary successor iterate, even if the source itself is not integrable. -/
theorem iterate_charge_integrable {H : ℝ → ℝ} (hH : Measurable H)
    {M : ℝ} (hM : 0 ≤ M) (hb : ∀ x, 0 < x → |H x| ≤ M) (j : ℕ) :
    IntegrableOn (fun v => kernel v * successor^[j] (MixedEnergy.physicalLift H) v)
      (Ioi (0 : ℝ)) := by
  have hm : Measurable (fun v : ℝ => H (exp v + j)) :=
    hH.comp (measurable_exp.add_const _)
  have hd := reference_integrable.const_mul (2 * M)
  simp_rw [successor_iterate_physicalLift]
  apply hd.mono'
    (measurable_kernel.mul ((by fun_prop : Measurable (fun v : ℝ => exp (v / 2))).mul hm)).aestronglyMeasurable
  exact Eventually.of_forall (fun v => by
    rw [norm_mul, Real.norm_eq_abs]
    change |kernel v| * |exp (v / 2) * H (exp v + j)| ≤ 2 * M * exp (-v / 2)
    rw [abs_mul, abs_of_pos (exp_pos _)]
    calc
      _ ≤ (2 * exp (-v)) * (exp (v / 2) * M) :=
        mul_le_mul (kernel_abs_le_exp v)
          (mul_le_mul_of_nonneg_left (hb _ (by positivity)) (exp_pos _).le)
          (by positivity) (by positivity)
      _ = _ := by
        calc
          _ = 2 * M * (exp (-v) * exp (v / 2)) := by ring
          _ = _ := by rw [← exp_add]; congr 2; ring)

theorem iterate_defect_bound {H : ℝ → ℝ} (hH : Measurable H)
    {M : ℝ} (hM : 0 ≤ M) (hb : ∀ x, 0 < x → |H x| ≤ M) (j : ℕ) :
    |defect (successor^[j] (MixedEnergy.physicalLift H))| ≤ 2 * M := by
  have hi := iterate_charge_integrable hH hM hb j
  have hp (v : ℝ) : |kernel v * successor^[j] (MixedEnergy.physicalLift H) v| ≤
      2 * M * exp (-v / 2) := by
    rw [successor_iterate_physicalLift, abs_mul, abs_mul, abs_of_pos (exp_pos _)]
    calc
      _ ≤ (2 * exp (-v)) * (exp (v / 2) * M) :=
        mul_le_mul (kernel_abs_le_exp v)
          (mul_le_mul_of_nonneg_left (hb _ (by positivity)) (exp_pos _).le)
          (by positivity) (by positivity)
      _ = _ := by
        calc
          _ = 2 * M * (exp (-v) * exp (v / 2)) := by ring
          _ = _ := by rw [← exp_add]; congr 2; ring
  have he := integral_mono hi.abs (reference_integrable.const_mul (2 * M)) hp
  rw [integral_const_mul, reference_integral] at he
  have hn := norm_integral_le_integral_norm
    (f := fun v => kernel v * successor^[j] (MixedEnergy.physicalLift H) v)
    (μ := volume.restrict (Ioi (0 : ℝ)))
  simp only [Real.norm_eq_abs] at hn
  unfold defect
  rw [abs_mul, abs_of_nonneg (by norm_num : (0 : ℝ) ≤ 1 / 2)]
  linarith

theorem iterate_charge_physical_integral (H : ℝ → ℝ) (j : ℕ) :
    (∫ v in Ioi (0 : ℝ), kernel v * successor^[j] (MixedEnergy.physicalLift H) v) =
      ∫ x in Ioi (1 : ℝ), kernel (log x) * H (x + j) / sqrt x := by
  have h := integral_image_eq_integral_abs_deriv_smul (s := Ioi (0 : ℝ))
    measurableSet_Ioi (fun v _ => (hasDerivAt_exp v).hasDerivWithinAt)
    exp_injective.injOn (fun x => kernel (log x) * H (x + j) / sqrt x)
  rw [MixedEnergy.exp_image_Ioi, exp_zero] at h
  rw [h]
  apply integral_congr_ae
  exact Eventually.of_forall (fun v => by
    dsimp only
    rw [smul_eq_mul, abs_of_pos (exp_pos v), log_exp, successor_iterate_physicalLift]
    have he : exp v = exp (v / 2) ^ 2 := by
      rw [pow_two, ← exp_add, add_halves]
    have hs : sqrt (exp v) = exp (v / 2) := by
      rw [he, sqrt_sq (exp_pos _).le]
    rw [hs, he]
    field_simp)

theorem iterate_charge_physical_integrable {H : ℝ → ℝ} (hH : Measurable H)
    {M : ℝ} (hM : 0 ≤ M) (hb : ∀ x, 0 < x → |H x| ≤ M) (j : ℕ) :
    IntegrableOn (fun x => kernel (log x) * H (x + j) / sqrt x) (Ioi (1 : ℝ)) := by
  have h := integrableOn_image_iff_integrableOn_abs_deriv_smul (s := Ioi (0 : ℝ))
    measurableSet_Ioi (fun v _ => (hasDerivAt_exp v).hasDerivWithinAt)
    exp_injective.injOn (fun x => kernel (log x) * H (x + j) / sqrt x)
  rw [MixedEnergy.exp_image_Ioi, exp_zero] at h
  apply h.mpr
  apply (iterate_charge_integrable hH hM hb j).congr
  exact Eventually.of_forall (fun v => by
    dsimp only
    rw [smul_eq_mul, abs_of_pos (exp_pos v), log_exp, successor_iterate_physicalLift]
    have he : exp v = exp (v / 2) ^ 2 := by
      rw [pow_two, ← exp_add, add_halves]
    have hs : sqrt (exp v) = exp (v / 2) := by
      rw [he, sqrt_sq (exp_pos _).le]
    rw [hs, he]
    field_simp)

end BuildingBlocks.SuccessorCharge

namespace BuildingBlocks.SuccessorFeedback

/-- Literal prime-power error at the original counting clock. -/
noncomputable def physicalError (x : ℝ) : ℝ :=
  CoarsePrimitive.psi ⌊x⌋₊ / x - 1

noncomputable def source : ℝ → ℝ :=
  (Ici (0 : ℝ)).indicator (MixedEnergy.physicalLift physicalError)

noncomputable def driver (j : ℕ) : ℝ :=
  SuccessorCharge.defect (SuccessorCharge.successor^[j] source)

noncomputable def generatingFunction (r : ℝ) : ℝ := ∑' j : ℕ, driver j * r ^ j

theorem measurable_physicalError : Measurable physicalError := by
  have hp : Measurable CoarsePrimitive.psi := measurable_of_countable _
  unfold physicalError
  fun_prop

theorem physicalError_abs_le {x : ℝ} (hx : 0 < x) :
    |physicalError x| ≤ 4 * log 2 + 1 := by
  have h0 : 0 ≤ CoarsePrimitive.psi ⌊x⌋₊ :=
    Finset.sum_nonneg (fun _ _ => ArithmeticFunction.vonMangoldt_nonneg)
  have h1 := CoarsePrimitive.psi_le_linear ⌊x⌋₊
  have hf := Nat.floor_le hx.le
  have hc : 0 ≤ 4 * log (2 : ℝ) := by positivity
  have h2 : CoarsePrimitive.psi ⌊x⌋₊ / x ≤ 4 * log 2 :=
    (div_le_iff₀ hx).2 (h1.trans (mul_le_mul_of_nonneg_left hf hc))
  have h3 : 0 ≤ CoarsePrimitive.psi ⌊x⌋₊ / x := div_nonneg h0 hx.le
  unfold physicalError
  exact abs_le.mpr ⟨by linarith, by linarith⟩

/-- Every prime power and the integer cutoff are retained in the iterate. -/
theorem source_iterate (j : ℕ) {v : ℝ} (hv : 0 ≤ v) :
    SuccessorCharge.successor^[j] source v = exp (v / 2) *
      (CoarsePrimitive.psi ⌊exp v + j⌋₊ / (exp v + j) - 1) :=
  (SuccessorCharge.successor_iterate_congr_nonneg
    (fun v hv => indicator_of_mem (s := Ici (0 : ℝ)) hv _) j hv).trans
    (SuccessorCharge.successor_iterate_physicalLift physicalError j v)

theorem source_causal {v : ℝ} (hv : v < 0) : source v = 0 :=
  indicator_of_notMem (s := Ici (0 : ℝ)) (not_le.mpr hv) _

theorem source_initial : source 0 = -1 := by
  norm_num [source, MixedEnergy.physicalLift, physicalError, CoarsePrimitive.psi,
    Finset.sum_range_succ]

theorem source_iterate_eq_ae (j : ℕ) :
    SuccessorCharge.successor^[j] source =ᵐ[volume.restrict (Ioi (0 : ℝ))]
      SuccessorCharge.successor^[j] (MixedEnergy.physicalLift physicalError) := by
  filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with v hv
  exact SuccessorCharge.successor_iterate_congr_nonneg
    (fun v hv => indicator_of_mem (s := Ici (0 : ℝ)) hv _) j hv.le

theorem driver_integrable (j : ℕ) :
    IntegrableOn (fun v => SuccessorCharge.kernel v *
      SuccessorCharge.successor^[j] source v) (Ioi (0 : ℝ)) := by
  apply (SuccessorCharge.iterate_charge_integrable measurable_physicalError
    (by positivity : 0 ≤ 4 * log (2 : ℝ) + 1)
    (fun _ hx => physicalError_abs_le hx) j).congr
  filter_upwards [source_iterate_eq_ae j] with v hv
  rw [hv]

theorem driver_eq_profile_defect (j : ℕ) : driver j =
    SuccessorCharge.defect (SuccessorCharge.successor^[j]
      (MixedEnergy.physicalLift physicalError)) := by
  unfold driver SuccessorCharge.defect
  congr 1
  apply integral_congr_ae
  filter_upwards [source_iterate_eq_ae j] with v hv
  rw [hv]

/-- Physical-coordinate charge kernel, including the discarded first interval.
This is not yet the successor-difference or Abel-transform identity. -/
theorem driver_physical_integral (j : ℕ) :
    driver j = (1 / 2 : ℝ) * ∫ x in Ioi (1 : ℝ),
      SuccessorCharge.kernel (log x) * physicalError (x + j) / sqrt x := by
  rw [driver_eq_profile_defect, SuccessorCharge.defect,
    SuccessorCharge.iterate_charge_physical_integral]

theorem driver_physical_integrable (j : ℕ) :
    IntegrableOn (fun x => SuccessorCharge.kernel (log x) *
      physicalError (x + j) / sqrt x) (Ioi (1 : ℝ)) :=
  SuccessorCharge.iterate_charge_physical_integrable measurable_physicalError
    (by positivity : 0 ≤ 4 * log (2 : ℝ) + 1)
    (fun _ hx => physicalError_abs_le hx) j

theorem driver_abs_le (j : ℕ) : |driver j| ≤ 2 * (4 * log 2 + 1) := by
  rw [driver_eq_profile_defect]
  exact SuccessorCharge.iterate_defect_bound measurable_physicalError
    (by positivity : 0 ≤ 4 * log (2 : ℝ) + 1)
    (fun _ hx => physicalError_abs_le hx) j

theorem driver_series_summable {r : ℝ} (hr : |r| < 1) :
    Summable (fun j : ℕ => driver j * r ^ j) := by
  apply Summable.of_norm_bounded
    ((summable_geometric_of_lt_one (abs_nonneg r) hr).mul_left (2 * (4 * log 2 + 1)))
  intro j
  rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_pow]
  exact mul_le_mul_of_nonneg_right (driver_abs_le j) (by positivity)

end BuildingBlocks.SuccessorFeedback
