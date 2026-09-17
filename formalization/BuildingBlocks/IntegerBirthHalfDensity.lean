import BuildingBlocks.IntegerBirthDiscreteCorrection
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics

open MeasureTheory Set Filter
open scoped Topology BigOperators

namespace BuildingBlocks.IntegerBirthHalfDensity

open IntegerBirthDiscreteCorrection

noncomputable def halfDensity (j : ℕ) (x : ℝ) : ℝ :=
  1 / (2 * (x+j) * Real.sqrt x)

/-- The literal birth indicator, on the original physical half-line x>=1. -/
noncomputable def birthDensity (n j : ℕ) (x : ℝ) : ℝ :=
  if (n : ℝ) ≤ x+j then halfDensity j x else 0

private theorem sqrt_atTop : Tendsto Real.sqrt atTop atTop := by
  change Tendsto (fun x : ℝ => Real.sqrt x) atTop atTop
  simpa only [Real.sqrt_eq_rpow] using tendsto_rpow_atTop (by norm_num : (0:ℝ)<1/2)

private theorem positive_primitive_deriv {j : ℕ} (hj : 0 < j) {x : ℝ} (hx : 0 < x) :
    HasDerivAt (fun x : ℝ => Real.arctan (Real.sqrt x / Real.sqrt j) / Real.sqrt j)
      (halfDensity j x) x := by
  have hjr : 0 < (j : ℝ) := by exact_mod_cast hj
  have hsj : Real.sqrt (j : ℝ) ≠ 0 := (Real.sqrt_pos.mpr hjr).ne'
  have hsx : Real.sqrt x ≠ 0 := (Real.sqrt_pos.mpr hx).ne'
  have hh := (((Real.hasDerivAt_arctan (Real.sqrt x / Real.sqrt j)).comp x
    ((Real.hasDerivAt_sqrt hx.ne').div_const (Real.sqrt j))).div_const (Real.sqrt j))
  convert hh using 1
  unfold halfDensity
  rw [div_pow, Real.sq_sqrt hx.le, Real.sq_sqrt hjr.le]
  field_simp
  rw [Real.sq_sqrt hjr.le]
  ring

private theorem zero_primitive_deriv {x : ℝ} (hx : 0 < x) :
    HasDerivAt (fun x : ℝ => -(1 / Real.sqrt x)) (halfDensity 0 x) x := by
  have hsx : Real.sqrt x ≠ 0 := (Real.sqrt_pos.mpr hx).ne'
  have hh := ((Real.hasDerivAt_sqrt hx.ne').inv hsx).neg
  simp only [one_div]
  convert hh using 1
  unfold halfDensity
  simp only [Nat.cast_zero, add_zero]
  field_simp
  nlinarith [Real.sq_sqrt hx.le]

private theorem halfDensity_nonnegative (j : ℕ) {x : ℝ} (hx : 0 < x) : 0 ≤ halfDensity j x := by
  unfold halfDensity
  positivity

/-- Absolute integrability of each half-density tail, derived from its nonnegative primitive. -/
theorem halfDensity_integrable (j : ℕ) {a : ℝ} (ha : 0 < a) :
    IntegrableOn (halfDensity j) (Ioi a) := by
  rcases Nat.eq_zero_or_pos j with rfl | hj
  · apply integrableOn_Ioi_deriv_of_nonneg'
      (fun x hx => zero_primitive_deriv (ha.trans_le hx))
      (fun x hx => halfDensity_nonnegative 0 (ha.trans hx))
    simpa only [one_div, neg_zero] using sqrt_atTop.inv_tendsto_atTop.neg
  · apply integrableOn_Ioi_deriv_of_nonneg'
      (fun x hx => positive_primitive_deriv hj (ha.trans_le hx))
      (fun x hx => halfDensity_nonnegative j (ha.trans hx))
    exact (Real.tendsto_arctan_atTop.mono_right inf_le_left |>.comp
      (sqrt_atTop.atTop_div_const (Real.sqrt_pos.mpr (by exact_mod_cast hj)))).div_const _

/-- The zero-clock half-density tail keeps its exact initial value. -/
theorem halfDensity_integral_zero {a : ℝ} (ha : 0 < a) :
    (∫ x in Ioi a, halfDensity 0 x) = 1/Real.sqrt a := by
  have hh := integral_Ioi_of_hasDerivAt_of_nonneg'
    (fun x hx => zero_primitive_deriv (ha.trans_le hx))
    (fun x hx => halfDensity_nonnegative 0 (ha.trans hx))
    (show Tendsto (fun x : ℝ => -(1/Real.sqrt x)) atTop (𝓝 0) from
      by simpa only [one_div, neg_zero] using sqrt_atTop.inv_tendsto_atTop.neg)
  simpa using hh

/-- Evaluation of the actual positive-clock half-density tail. -/
theorem halfDensity_integral_pos {j : ℕ} (hj : 0 < j) {a : ℝ} (ha : 0 < a) :
    (∫ x in Ioi a, halfDensity j x) =
      Real.arctan (Real.sqrt ((j : ℝ)/a))/Real.sqrt j := by
  have hjr : 0 < (j : ℝ) := by exact_mod_cast hj
  have hlim := (Real.tendsto_arctan_atTop.mono_right inf_le_left |>.comp
    (sqrt_atTop.atTop_div_const (Real.sqrt_pos.mpr hjr))).div_const (Real.sqrt (j : ℝ))
  have hh := integral_Ioi_of_hasDerivAt_of_nonneg'
    (fun x hx => positive_primitive_deriv hj (ha.trans_le hx))
    (fun x hx => halfDensity_nonnegative j (ha.trans hx)) hlim
  rw [hh]
  have hp : 0 < Real.sqrt a / Real.sqrt (j : ℝ) := div_pos (Real.sqrt_pos.mpr ha) (Real.sqrt_pos.mpr hjr)
  have he := Real.arctan_inv_of_pos hp
  rw [inv_div, ←Real.sqrt_div hjr.le] at he
  rw [he]
  ring

private theorem birthDensity_eq_indicator (n j : ℕ) :
    birthDensity n j = (Ici ((n : ℝ)-j)).indicator (halfDensity j) := by
  funext x
  simp only [birthDensity, indicator, mem_Ici, sub_le_iff_le_add]

/-- Every active birth is integrable on the original x>1 domain. -/
theorem birthDensity_integrable (n j : ℕ) : IntegrableOn (birthDensity n j) (Ioi 1) := by
  rw [birthDensity_eq_indicator]
  exact (halfDensity_integrable j (by norm_num : (0:ℝ)<1)).indicator measurableSet_Ici

private theorem birthDensity_integral_tail (n j : ℕ) :
    (∫ x in Ioi (1 : ℝ), birthDensity n j x) =
      ∫ x in Ioi (max (1 : ℝ) ((n : ℝ)-j)), halfDensity j x := by
  rw [birthDensity_eq_indicator, ←integral_Ici_eq_integral_Ioi,
    setIntegral_indicator measurableSet_Ici, Ici_inter_Ici, integral_Ici_eq_integral_Ioi]

/-- The literal half-density birth integral equals the clipped arctangent mass. -/
theorem birthDensity_integral {n : ℕ} (hn : 2 ≤ n) (j : ℕ) :
    (∫ x in Ioi (1 : ℝ), birthDensity n j x) = discreteBirth n j := by
  rw [birthDensity_integral_tail]
  have ha : 0 < max (1 : ℝ) ((n : ℝ)-j) := lt_of_lt_of_le (by norm_num) (le_max_left _ _)
  rcases Nat.eq_zero_or_pos j with rfl | hj
  · rw [halfDensity_integral_zero ha, discreteBirth, if_pos rfl]
    simp only [Nat.cast_zero, sub_zero]
    rw [max_eq_right (by exact_mod_cast (show 1 ≤ n by omega))]
  · rw [halfDensity_integral_pos hj ha, discreteBirth, if_neg (Nat.ne_of_gt hj)]

#print axioms birthDensity_integrable
#print axioms birthDensity_integral

end BuildingBlocks.IntegerBirthHalfDensity
