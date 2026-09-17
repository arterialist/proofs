import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import Mathlib.MeasureTheory.Measure.Prod
import Mathlib.MeasureTheory.Function.JacobianOneDim

/-! Causal anchoring for the actual mixed additive-clock energy.
The nonnegative integral formulation permits a source outside unweighted L². -/

open MeasureTheory Real Set
open scoped ENNReal

namespace BuildingBlocks.MixedEnergy

noncomputable def increment (H : ℝ → ℝ) (h : ℝ) : ℝ≥0∞ :=
  ∫⁻ x, ENNReal.ofReal ((H x - H (x - h)) ^ 2)

noncomputable def longEnergy (H : ℝ → ℝ) : ℝ≥0∞ :=
  ∫⁻ h in Ioi (1 : ℝ), ∫⁻ x,
    ENNReal.ofReal (1 / h ^ (2 : ℕ)) * ENNReal.ofReal ((H x - H (x - h)) ^ 2)

noncomputable def energy (H : ℝ → ℝ) : ℝ≥0∞ :=
  (∫⁻ h in Ioo (0 : ℝ) 1, increment H h) + longEnergy H

theorem increment_eq_forward {H : ℝ → ℝ} (hH : Measurable H) (h : ℝ) :
    increment H h = ∫⁻ x, ENNReal.ofReal ((H (x + h) - H x) ^ 2) := by
  have hm : Measurable (fun x => ENNReal.ofReal ((H x - H (x - h)) ^ 2)) := by fun_prop
  have he := (measurePreserving_add_right (volume : Measure ℝ) h).lintegral_comp hm
  simpa only [increment, add_sub_cancel_right] using he.symm

theorem longEnergy_eq (H : ℝ → ℝ) :
    longEnergy H = ∫⁻ h in Ioi (1 : ℝ), ENNReal.ofReal (1 / h ^ (2 : ℕ)) * increment H h := by
  apply lintegral_congr
  intro h
  exact lintegral_const_mul' _ _ ENNReal.ofReal_ne_top

theorem inverse_square_tail {a : ℝ} (ha : 0 < a) :
    (∫⁻ h in Ioi a, ENNReal.ofReal (1 / h ^ (2 : ℕ))) = ENNReal.ofReal (1 / a) := by
  have he : (fun h : ℝ => 1 / h ^ (2 : ℕ)) = (fun h : ℝ => h ^ (-2 : ℝ)) := by
    funext h
    rw [show (-2 : ℝ) = -(2 : ℕ) by norm_num, Real.rpow_neg_natCast]
    simp only [zpow_neg, zpow_natCast, one_div]
  have hi : IntegrableOn (fun h : ℝ => 1 / h ^ (2 : ℕ)) (Ioi a) := by
    rw [he]
    exact integrableOn_Ioi_rpow_of_lt (by norm_num) ha
  rw [← ofReal_integral_eq_lintegral_ofReal hi
    (Filter.Eventually.of_forall (fun h => by positivity))]
  congr 1
  rw [he, integral_Ioi_rpow_of_lt (by norm_num) ha]
  norm_num [Real.rpow_neg_one, one_div]

/-- The entire tail of increments that cross the zero region contributes the
exact weight `1 / max 1 (x-1)`. -/
theorem point_anchor {H : ℝ → ℝ}
    (hzero : ∀ᵐ x : ℝ, x < 1 → H x = 0) (x : ℝ) :
    ENNReal.ofReal (H x ^ 2) * ENNReal.ofReal (1 / max 1 (x - 1)) ≤
      ∫⁻ h in Ioi (1 : ℝ),
        ENNReal.ofReal (1 / h ^ (2 : ℕ)) * ENNReal.ofReal ((H x - H (x - h)) ^ 2) := by
  have hM : 0 < max (1 : ℝ) (x - 1) := lt_of_lt_of_le (by norm_num) (le_max_left _ _)
  calc
    ENNReal.ofReal (H x ^ 2) * ENNReal.ofReal (1 / max 1 (x - 1)) =
        ∫⁻ h in Ioi (max 1 (x - 1)),
          ENNReal.ofReal (1 / h ^ (2 : ℕ)) * ENNReal.ofReal (H x ^ 2) := by
      rw [lintegral_mul_const' _ _ ENNReal.ofReal_ne_top, inverse_square_tail hM, mul_comm]
    _ = ∫⁻ h in Ioi (max 1 (x - 1)),
        ENNReal.ofReal (1 / h ^ (2 : ℕ)) * ENNReal.ofReal ((H x - H (x - h)) ^ 2) := by
      apply lintegral_congr_ae
      have ht : ∀ᵐ h : ℝ, x - h < 1 → H (x - h) = 0 :=
        ((volume : Measure ℝ).measurePreserving_sub_left x).quasiMeasurePreserving.tendsto_ae.eventually hzero
      filter_upwards [ae_restrict_mem measurableSet_Ioi, ae_restrict_of_ae ht] with h hh hz
      have hh' : x - h < 1 := by
        have hm := le_max_right (1 : ℝ) (x - 1)
        change max 1 (x - 1) < h at hh
        linarith
      rw [hz hh', sub_zero]
    _ ≤ _ := lintegral_mono_set (Ioi_subset_Ioi (le_max_left _ _))

/-- Stronger than the published `1/x` anchor, with the exact tail weight.
The zero region is imposed only almost everywhere. -/
theorem causal_anchor {H : ℝ → ℝ} (hH : Measurable H)
    (hzero : ∀ᵐ x : ℝ, x < 1 → H x = 0) :
    (∫⁻ x in Ioi (1 : ℝ), ENNReal.ofReal (H x ^ 2) *
      ENNReal.ofReal (1 / max 1 (x - 1))) ≤ energy H := by
  have hmeas : Measurable (fun z : ℝ × ℝ =>
      ENNReal.ofReal (1 / z.2 ^ 2) *
        ENNReal.ofReal ((H z.1 - H (z.1 - z.2)) ^ 2)) := by fun_prop
  have hs : (∫⁻ x, ∫⁻ h in Ioi (1 : ℝ),
      ENNReal.ofReal (1 / h ^ (2 : ℕ)) * ENNReal.ofReal ((H x - H (x - h)) ^ 2)) =
        longEnergy H := lintegral_lintegral_swap hmeas.aemeasurable
  calc
    _ ≤ ∫⁻ x in Ioi (1 : ℝ), ∫⁻ h in Ioi (1 : ℝ),
        ENNReal.ofReal (1 / h ^ (2 : ℕ)) * ENNReal.ofReal ((H x - H (x - h)) ^ 2) :=
      lintegral_mono (point_anchor hzero)
    _ ≤ ∫⁻ x, ∫⁻ h in Ioi (1 : ℝ),
        ENNReal.ofReal (1 / h ^ (2 : ℕ)) * ENNReal.ofReal ((H x - H (x - h)) ^ 2) :=
      lintegral_mono' Measure.restrict_le_self le_rfl
    _ = longEnergy H := hs
    _ ≤ energy H := le_add_self

/-- The published physical-domain anchor, as a nonnegative-integral statement. -/
theorem causal_anchor_one_div {H : ℝ → ℝ} (hH : Measurable H)
    (hzero : ∀ᵐ x : ℝ, x < 1 → H x = 0) :
    (∫⁻ x in Ioi (1 : ℝ), ENNReal.ofReal (H x ^ 2) * ENNReal.ofReal (1 / x)) ≤
      energy H := by
  apply le_trans ?_ (causal_anchor hH hzero)
  apply lintegral_mono_ae
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
  have hM : 0 < max (1 : ℝ) (x - 1) := lt_of_lt_of_le (by norm_num) (le_max_left _ _)
  have hMx : max (1 : ℝ) (x - 1) ≤ x := max_le hx.le (by linarith)
  apply mul_le_mul_left'
  apply ENNReal.ofReal_le_ofReal
  exact one_div_le_one_div_of_le hM hMx

/-- The exact logarithmic change of variable in the physical weighted domain. -/
theorem logarithmic_anchor_identity (H : ℝ → ℝ) :
    (∫⁻ u in Ioi (0 : ℝ), ENNReal.ofReal (H (exp u) ^ 2)) =
      ∫⁻ x in Ioi (1 : ℝ), ENNReal.ofReal (H x ^ 2) * ENNReal.ofReal (1 / x) := by
  have he : exp '' Ioi (0 : ℝ) = Ioi (1 : ℝ) := by
    ext x
    constructor
    · rintro ⟨u, hu, rfl⟩
      simpa using exp_lt_exp.mpr hu
    · intro hx
      exact ⟨log x, log_pos hx, exp_log (lt_trans (by norm_num) hx)⟩
  have h := lintegral_image_eq_lintegral_abs_deriv_mul (s := Ioi (0 : ℝ)) measurableSet_Ioi
    (fun u _ => (hasDerivAt_exp u).hasDerivWithinAt)
    exp_injective.injOn
    (fun x => ENNReal.ofReal (H x ^ 2) * ENNReal.ofReal (1 / x))
  rw [he] at h
  rw [h]
  apply lintegral_congr
  intro u
  rw [abs_of_pos (exp_pos u), ← ENNReal.ofReal_mul (sq_nonneg _),
    ← ENNReal.ofReal_mul (exp_pos u).le]
  congr 1
  field_simp

noncomputable def physicalLift (H : ℝ → ℝ) (u : ℝ) : ℝ :=
  exp (u / 2) * H (exp u)

/-- The actual critical change of coordinates produces the precise weighted
physical L² input used by the memory response theorem. -/
theorem weighted_physical_square_le_energy {H : ℝ → ℝ} (hH : Measurable H)
    (hzero : ∀ᵐ x : ℝ, x < 1 → H x = 0) :
    (∫⁻ u in Ioi (0 : ℝ),
      ENNReal.ofReal ((exp (-u / 2) * physicalLift H u) ^ 2)) ≤ energy H := by
  have he (u : ℝ) : exp (-u / 2) * physicalLift H u = H (exp u) := by
    unfold physicalLift
    rw [← mul_assoc, ← exp_add]
    rw [show -u / 2 + u / 2 = 0 by ring, exp_zero, one_mul]
  simp_rw [he]
  rw [logarithmic_anchor_identity]
  exact causal_anchor_one_div hH hzero

end BuildingBlocks.MixedEnergy
