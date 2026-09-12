import BuildingBlocks.MixedEnergyAnchoring
import Mathlib.MeasureTheory.Function.L2Space
import Mathlib.Dynamics.Ergodic.MeasurePreserving

/-! The actual additive unit step is controlled by short-increment energy,
without assuming the source itself belongs to unweighted L². -/

open MeasureTheory Real Set
open scoped ENNReal

namespace BuildingBlocks.MixedEnergy

noncomputable def shortEnergy (H : ℝ → ℝ) : ℝ≥0∞ :=
  ∫⁻ h in Ioo (0 : ℝ) 1, increment H h

theorem measurable_increment {H : ℝ → ℝ} (hH : Measurable H) :
    Measurable (increment H) := by
  have hm : Measurable (fun z : ℝ × ℝ =>
      ENNReal.ofReal ((H z.2 - H (z.2 - z.1)) ^ 2)) := by fun_prop
  exact hm.lintegral_prod_right'

theorem increment_split {H : ℝ → ℝ} (hH : Measurable H) (h : ℝ) :
    increment H 1 ≤ 2 * increment H h + 2 * increment H (1 - h) := by
  have hm : Measurable (fun x => ENNReal.ofReal ((H x - H (x - (1 - h))) ^ 2)) := by
    fun_prop
  have ht := (measurePreserving_add_right (volume : Measure ℝ) (-h)).lintegral_comp hm
  have ha (x : ℝ) : x + -h - (1 - h) = x - 1 := by ring
  simp_rw [ha] at ht
  have hshift : (∫⁻ x, ENNReal.ofReal ((H (x - h) - H (x - 1)) ^ 2)) =
      increment H (1 - h) := by simpa only [increment, ← sub_eq_add_neg] using ht
  have hp (x : ℝ) : ENNReal.ofReal ((H x - H (x - 1)) ^ 2) ≤
      2 * ENNReal.ofReal ((H x - H (x - h)) ^ 2) +
        2 * ENNReal.ofReal ((H (x - h) - H (x - 1)) ^ 2) := by
    calc
      _ ≤ ENNReal.ofReal (2 * (H x - H (x - h)) ^ 2 +
          2 * (H (x - h) - H (x - 1)) ^ 2) := by
        apply ENNReal.ofReal_le_ofReal
        nlinarith [sq_nonneg (H x - 2 * H (x - h) + H (x - 1))]
      _ = _ := by
        rw [ENNReal.ofReal_add (by positivity) (by positivity),
          ENNReal.ofReal_mul (by norm_num), ENNReal.ofReal_mul (by norm_num)]
        norm_num
  calc
    increment H 1 ≤ ∫⁻ x, (2 * ENNReal.ofReal ((H x - H (x - h)) ^ 2) +
        2 * ENNReal.ofReal ((H (x - h) - H (x - 1)) ^ 2)) := lintegral_mono hp
    _ = _ := by
      rw [lintegral_add_left (by fun_prop), lintegral_const_mul' _ _ (by norm_num),
        lintegral_const_mul' _ _ (by norm_num), hshift]
      rfl

theorem reflected_shortEnergy {H : ℝ → ℝ} (hH : Measurable H) :
    (∫⁻ h in Ioo (0 : ℝ) 1, increment H (1 - h)) = shortEnergy H := by
  have hp : (fun h : ℝ => 1 - h) ⁻¹' Ioo (0 : ℝ) 1 = Ioo (0 : ℝ) 1 := by
    ext h
    change (0 < 1 - h ∧ 1 - h < 1) ↔ (0 < h ∧ h < 1)
    constructor <;> intro hh <;> constructor <;> linarith [hh.1, hh.2]
  have ht := ((volume : Measure ℝ).measurePreserving_sub_left 1).restrict_preimage
    (s := Ioo (0 : ℝ) 1) measurableSet_Ioo
  rw [hp] at ht
  exact ht.lintegral_comp (measurable_increment hH)

/-- The exact successor clock has energy at most four times the short part. -/
theorem unit_step_le_shortEnergy {H : ℝ → ℝ} (hH : Measurable H) :
    increment H 1 ≤ 4 * shortEnergy H := by
  have hi := lintegral_mono (μ := volume.restrict (Ioo (0 : ℝ) 1)) (increment_split hH)
  rw [lintegral_const, Measure.restrict_apply_univ] at hi
  simp only [Real.volume_Ioo, sub_zero, ENNReal.ofReal_one, mul_one] at hi
  rw [lintegral_add_left ((measurable_increment hH).const_mul 2),
    lintegral_const_mul' _ _ (by norm_num), lintegral_const_mul' _ _ (by norm_num),
    reflected_shortEnergy hH] at hi
  change increment H 1 ≤ 2 * shortEnergy H + 2 * shortEnergy H at hi
  convert hi using 1 <;> ring

theorem unit_step_le_energy {H : ℝ → ℝ} (hH : Measurable H) :
    increment H 1 ≤ 4 * energy H :=
  (unit_step_le_shortEnergy hH).trans (mul_le_mul_left' le_self_add 4)

/-- Finite mixed energy forces the actual unit increment into L², even for
sources with infinite unweighted L² norm. -/
theorem unit_step_memLp {H : ℝ → ℝ} (hH : Measurable H) (hE : energy H < ∞) :
    MemLp (fun x => H x - H (x - 1)) 2 volume := by
  have hm : Measurable (fun x => H x - H (x - 1)) := by fun_prop
  apply (memLp_two_iff_integrable_sq hm.aestronglyMeasurable).2
  constructor
  · exact (hm.pow_const 2).aestronglyMeasurable
  · rw [hasFiniteIntegral_iff_ofReal
      (Filter.Eventually.of_forall (fun x => sq_nonneg (H x - H (x - 1))))]
    exact (unit_step_le_energy hH).trans_lt (ENNReal.mul_lt_top (by norm_num) hE)

end BuildingBlocks.MixedEnergy
