import BuildingBlocks.ChargeFrozenSource
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import BuildingBlocks.CoarsePrimeBounds
import Mathlib.MeasureTheory.Function.Floor

open MeasureTheory Set

namespace BuildingBlocks.ChargeFrozenMetric

open CoarsePrimitive

open ChargeFrozenSource

theorem causalSource_terminal {N : ℕ} (hN : 2 ≤ N) {v : ℝ}
    (hv : Real.log (N : ℝ) < v) :
    causalSource N v = (psi N - (N : ℝ)) * Real.exp (-v / 2) := by
  have hNp : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hNl : 0 ≤ Real.log (N : ℝ) := Real.log_nonneg (by exact_mod_cast (show 1 ≤ N by omega))
  have he : (N : ℝ) < Real.exp v := by
    simpa only [Real.exp_log hNp] using Real.exp_lt_exp.mpr hv
  rw [causalSource_of_nonnegative N (hNl.trans hv.le)]
  unfold source
  rw [min_eq_right he.le, Nat.floor_natCast]
  ring

theorem causalSource_terminal_square {N : ℕ} (hN : 2 ≤ N) {v : ℝ}
    (hv : Real.log (N : ℝ) < v) :
    (causalSource N v)^2 = (psi N - (N : ℝ))^2 * Real.exp (-v) := by
  rw [causalSource_terminal hN hv, mul_pow, ← Real.exp_nat_mul]
  congr 2
  ring

theorem terminal_square_integrable {N : ℕ} (hN : 2 ≤ N) :
    IntegrableOn (fun v => (causalSource N v)^2) (Ioi (Real.log (N : ℝ))) := by
  have hi : IntegrableOn (fun v : ℝ => Real.exp (-v)) (Ioi (Real.log (N : ℝ))) := by
    simpa using integrableOn_exp_mul_Ioi (by norm_num : (-1 : ℝ) < 0) (Real.log (N : ℝ))
  apply (hi.const_mul ((psi N - (N : ℝ))^2)).congr
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with v hv
  exact (causalSource_terminal_square hN hv).symm

/-- The exact terminal contribution in the objective's original dv metric. -/
theorem terminal_square_integral {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (Real.log (N : ℝ)), (causalSource N v)^2) =
      (psi N - (N : ℝ))^2 / (N : ℝ) := by
  have he : (∫ v in Ioi (Real.log (N : ℝ)), (causalSource N v)^2) =
      ∫ v in Ioi (Real.log (N : ℝ)), (psi N - (N : ℝ))^2 * Real.exp (-v) := by
    apply integral_congr_ae
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with v hv
    exact causalSource_terminal_square hN hv
  rw [he, integral_const_mul]
  have hi : (∫ v in Ioi (Real.log (N : ℝ)), Real.exp (-v)) = Real.exp (-Real.log (N : ℝ)) := by
    simpa using integral_exp_mul_Ioi (by norm_num : (-1 : ℝ) < 0) (Real.log (N : ℝ))
  rw [hi, Real.exp_neg, Real.exp_log (by exact_mod_cast (show 0 < N by omega)), div_eq_mul_inv]

theorem measurable_causalSource (N : ℕ) : Measurable (causalSource N) := by
  have hp : Measurable psi := measurable_of_countable psi
  have hm : Measurable (fun v : ℝ => min (Real.exp v) (N : ℝ)) := by fun_prop
  have hs : Measurable (source N) := by
    unfold source
    exact (by fun_prop : Measurable (fun v : ℝ => Real.exp (-v / 2))).mul
      ((hp.comp (Nat.measurable_floor.comp hm)).sub hm)
  exact hs.indicator measurableSet_Ici

theorem source_square_le_majorant {N : ℕ} (_hN : 2 ≤ N) {v : ℝ} (hv : 0 < v) :
    (causalSource N v)^2 ≤ (psi N + (N : ℝ))^2 * Real.exp (-v) := by
  let x := min (Real.exp v) (N : ℝ)
  have hx0 : 0 ≤ x := le_min (Real.exp_pos _).le (Nat.cast_nonneg N)
  have hxN : x ≤ N := min_le_right _ _
  have hfloor : ⌊x⌋₊ ≤ N := by
    exact_mod_cast (Nat.floor_le hx0).trans hxN
  have hp0 := psi_nonneg ⌊x⌋₊
  have hpN := psi_mono hfloor
  have hC : 0 ≤ psi N + (N : ℝ) := add_nonneg (psi_nonneg N) (Nat.cast_nonneg N)
  have hab : |psi ⌊x⌋₊ - x| ≤ psi N + (N : ℝ) := by
    apply abs_le.mpr
    constructor <;> linarith
  have hsq : (psi ⌊x⌋₊ - x)^2 ≤ (psi N + (N : ℝ))^2 := by
    nlinarith [sq_abs (psi ⌊x⌋₊ - x), abs_nonneg (psi ⌊x⌋₊ - x)]
  rw [causalSource_of_nonnegative N hv.le]
  unfold source
  rw [mul_pow, ← Real.exp_nat_mul]
  norm_num only [Nat.cast_ofNat]
  have he : (2 : ℝ) * (-v / 2) = -v := by ring
  rw [he, mul_comm]
  exact mul_le_mul_of_nonneg_right hsq (Real.exp_pos _).le

theorem full_square_integrable {N : ℕ} (hN : 2 ≤ N) :
    IntegrableOn (fun v => (causalSource N v)^2) (Ioi (0 : ℝ)) := by
  have hi : IntegrableOn (fun v : ℝ => Real.exp (-v)) (Ioi (0 : ℝ)) := by
    simpa using integrableOn_exp_mul_Ioi (by norm_num : (-1 : ℝ) < 0) (0 : ℝ)
  apply (hi.const_mul ((psi N + (N : ℝ))^2)).mono'
  · exact ((measurable_causalSource N).pow_const 2).aestronglyMeasurable
  · filter_upwards [ae_restrict_mem measurableSet_Ioi] with v hv
    simpa only [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg (causalSource N v))] using source_square_le_majorant hN hv

theorem prefix_square_integrable {N : ℕ} (hN : 2 ≤ N) :
    IntegrableOn (fun v => (causalSource N v)^2) (Ioc 0 (Real.log (N : ℝ))) :=
  (full_square_integrable hN).mono_set (fun _ hv => hv.1)

theorem full_square_integral_split {N : ℕ} (hN : 2 ≤ N) :
    (∫ v in Ioi (0 : ℝ), (causalSource N v)^2) =
      (∫ v in Ioc 0 (Real.log (N : ℝ)), (causalSource N v)^2) +
        (psi N - (N : ℝ))^2 / (N : ℝ) := by
  have hlog : 0 ≤ Real.log (N : ℝ) := Real.log_nonneg (by exact_mod_cast (show 1 ≤ N by omega))
  have hu : Ioc (0 : ℝ) (Real.log (N : ℝ)) ∪ Ioi (Real.log (N : ℝ)) = Ioi (0 : ℝ) := by
    ext v
    simp only [mem_union, mem_Ioc, mem_Ioi]
    constructor
    · rintro (h | h) <;> linarith
    · intro hv
      by_cases hh : v ≤ Real.log (N : ℝ)
      · exact Or.inl ⟨hv, hh⟩
      · exact Or.inr (lt_of_not_ge hh)
  have hd : Disjoint (Ioc (0 : ℝ) (Real.log (N : ℝ))) (Ioi (Real.log (N : ℝ))) := by
    apply Set.disjoint_left.mpr
    intro v hv hw
    exact not_lt_of_ge hv.2 hw
  rw [← hu, setIntegral_union hd measurableSet_Ioi (prefix_square_integrable hN)
    (terminal_square_integrable hN), terminal_square_integral hN]

theorem full_square_integral_lower_bound {N : ℕ} (hN : 2 ≤ N) :
    (psi N - (N : ℝ))^2 / (N : ℝ) ≤ ∫ v in Ioi (0 : ℝ), (causalSource N v)^2 := by
  rw [full_square_integral_split hN]
  exact le_add_of_nonneg_left (integral_nonneg (fun v => sq_nonneg (causalSource N v)))

#print axioms causalSource_terminal
#print axioms terminal_square_integrable
#print axioms terminal_square_integral
#print axioms full_square_integrable
#print axioms full_square_integral_split
#print axioms full_square_integral_lower_bound

end BuildingBlocks.ChargeFrozenMetric
