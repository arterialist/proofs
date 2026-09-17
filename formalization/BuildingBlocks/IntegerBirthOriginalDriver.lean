import BuildingBlocks.IntegerBirthDifferenceL1
import BuildingBlocks.IntegerBirthDiscreteAbel
import BuildingBlocks.SuccessorFeedbackBoundary

open MeasureTheory Set Filter
open scoped Topology BigOperators

namespace BuildingBlocks.IntegerBirthOriginalDriver

open IntegerBirthHalfDensity IntegerBirthDifferenceL1
open BuildingBlocks

noncomputable def fullBirthSeries (j : ℕ) (x : ℝ) : ℝ :=
  ∑' n : ℕ, ArithmeticFunction.vonMangoldt n * birthDensity n j x

private theorem shiftedBirthSeries_summable {x : ℝ} (hx : 1 < x) (j : ℕ) :
    Summable (fun n : ℕ =>
      ArithmeticFunction.vonMangoldt (n + 2) * birthDensity (n + 2) j x) := by
  let N := ⌊x + j⌋₊
  apply summable_of_ne_finset_zero (s := Finset.range (N + 1))
  intro n hn
  simp only [Finset.mem_range, not_lt] at hn
  have hxfloor : x + (j : ℝ) < (N : ℝ) + 1 := by
    dsimp [N]
    exact Nat.lt_floor_add_one _
  have hncast : (N : ℝ) + 1 ≤ (n : ℝ) := by exact_mod_cast hn
  have hxn0 : x + (j : ℝ) < (n : ℝ) := hxfloor.trans_le hncast
  have hxn : x + (j : ℝ) < ((n + 2 : ℕ) : ℝ) := by push_cast; linarith
  have hnot : ¬(n : ℝ) + 2 ≤ x + (j : ℝ) := by push_cast at hxn; exact not_le.mpr hxn
  simp only [birthDensity, Nat.cast_add, Nat.cast_ofNat, if_neg hnot, mul_zero]

/-- At a fixed physical point only the births already exposed by the additive
clock contribute; their complete weight is the literal Chebyshev function. -/
theorem fullBirthSeries_eq {x : ℝ} (hx : 1 < x) (j : ℕ) :
    fullBirthSeries j x = BuildingBlocks.CoarsePrimitive.psi ⌊x + j⌋₊ * halfDensity j x := by
  let N := ⌊x + j⌋₊
  rw [fullBirthSeries, tsum_eq_sum (s := Finset.range (N + 1))]
  · unfold BuildingBlocks.CoarsePrimitive.psi
    change (∑ n ∈ Finset.range (N + 1),
      ArithmeticFunction.vonMangoldt n * birthDensity n j x) =
      (∑ n ∈ Finset.range (N + 1), ArithmeticFunction.vonMangoldt n) * halfDensity j x
    rw [Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro n hn
    have hnN : n ≤ N := by simpa only [Finset.mem_range, Nat.lt_succ_iff] using hn
    have hfloor : (N : ℝ) ≤ x + j := by
      dsimp [N]
      exact_mod_cast Nat.floor_le (by positivity : 0 ≤ x + (j : ℝ))
    have hnNr : (n : ℝ) ≤ N := by exact_mod_cast hnN
    have hactive : (n : ℝ) ≤ x + j := hnNr.trans hfloor
    rw [birthDensity, if_pos hactive]
  · intro n hn
    simp only [Finset.mem_range, not_lt] at hn
    have hxfloor : x + (j : ℝ) < (N : ℝ) + 1 := by
      dsimp [N]
      exact Nat.lt_floor_add_one _
    have hxn : x + (j : ℝ) < n := hxfloor.trans_le (by exact_mod_cast hn)
    rw [birthDensity, if_neg (not_le.mpr hxn), mul_zero]

/-- Removing the zero von Mangoldt coefficients at zero and one leaves the
`n + 2` indexing used by the literal integer-birth construction. -/
theorem shiftedBirthSeries_eq {x : ℝ} (hx : 1 < x) (j : ℕ) :
    (∑' n : ℕ, ArithmeticFunction.vonMangoldt (n + 2) * birthDensity (n + 2) j x) =
      BuildingBlocks.CoarsePrimitive.psi ⌊x + j⌋₊ * halfDensity j x := by
  let N := ⌊x + j⌋₊
  let F : ℕ → ℝ := fun n => ArithmeticFunction.vonMangoldt n * birthDensity n j x
  have hF : Summable F := summable_of_ne_finset_zero (s := Finset.range (N + 1)) (by
    intro n hn
    simp only [Finset.mem_range, not_lt] at hn
    have hxfloor : x + (j : ℝ) < (N : ℝ) + 1 := by
      dsimp [N]
      exact Nat.lt_floor_add_one _
    have hxn : x + (j : ℝ) < n := hxfloor.trans_le (by exact_mod_cast hn)
    dsimp [F]
    rw [birthDensity, if_neg (not_le.mpr hxn), mul_zero])
  have hshift := hF.sum_add_tsum_nat_add 2
  have hzero : (∑ n ∈ Finset.range 2, F n) = 0 := by
    simp [F, Finset.sum_range_succ]
  rw [hzero, zero_add] at hshift
  change (∑' n : ℕ, F (n + 2)) = _
  rw [hshift]
  exact fullBirthSeries_eq hx j

/-- Pointwise, the complete birth-series difference is exactly half the
ordinary successor increment of the original prime-power error. -/
theorem birthDifferenceSeries_eq {x : ℝ} (hx : 1 < x) (j : ℕ) :
    (∑' n : ℕ, ArithmeticFunction.vonMangoldt (n + 2) *
      (birthDensity (n + 2) (j + 1) x - birthDensity (n + 2) j x)) =
      (BuildingBlocks.SuccessorFeedback.physicalError (x + j + 1) -
        BuildingBlocks.SuccessorFeedback.physicalError (x + j)) / (2 * Real.sqrt x) := by
  simp_rw [mul_sub]
  rw [(shiftedBirthSeries_summable hx (j + 1)).tsum_sub (shiftedBirthSeries_summable hx j),
    shiftedBirthSeries_eq hx (j + 1), shiftedBirthSeries_eq hx j]
  unfold BuildingBlocks.SuccessorFeedback.physicalError halfDensity
  push_cast
  have hs : Real.sqrt x ≠ 0 := (Real.sqrt_pos.mpr (by linarith)).ne'
  have hxj : x + (j : ℝ) ≠ 0 := ne_of_gt (by positivity)
  have hxj1 : 1 + x + (j : ℝ) ≠ 0 := ne_of_gt (by positivity)
  field_simp
  ring

/-- The literal relative-charge driver is the complete integer-birth
difference.  This identifies the already formalized discrete birth series
with the original `E` coefficient; it does not introduce a replacement
definition of the driver. -/
theorem original_driver_eq_discrete_birth_difference (j : ℕ) :
    BuildingBlocks.SuccessorFeedback.driver j =
      ∑' n : ℕ, ArithmeticFunction.vonMangoldt (n + 2) *
        (IntegerBirthDiscreteCorrection.discreteBirth (n + 2) (j + 1) -
          IntegerBirthDiscreteCorrection.discreteBirth (n + 2) j) := by
  rw [BuildingBlocks.SuccessorFeedback.driver_eq_difference_integral]
  rw [← BuildingBlocks.IntegerBirthDifferenceL1.all_birth_difference_integral j]
  rw [← integral_const_mul]
  apply integral_congr_ae
  filter_upwards [ae_restrict_mem (μ := volume) measurableSet_Ioi] with x hx
  rw [birthDifferenceSeries_eq hx j]
  ring

noncomputable def centeredAge (j : ℕ) : ℝ :=
  ∑' n : ℕ, IntegerBirthDiscreteCorrection.centeredDiscreteTerm n j

theorem centeredAge_zero : centeredAge 0 = 0 := by
  simp [centeredAge, IntegerBirthDiscreteCorrection.centeredDiscreteTerm,
    IntegerBirthDiscreteCorrection.discreteBirth]

theorem original_driver_eq_centeredAge_difference (j : ℕ) :
    BuildingBlocks.SuccessorFeedback.driver j = centeredAge (j + 1) - centeredAge j := by
  rw [original_driver_eq_discrete_birth_difference, centeredAge, centeredAge,
    ← (IntegerBirthDiscreteCorrection.centeredDiscreteTerm_summable (j + 1)).tsum_sub
      (IntegerBirthDiscreteCorrection.centeredDiscreteTerm_summable j)]
  apply tsum_congr
  intro n
  unfold IntegerBirthDiscreteCorrection.centeredDiscreteTerm
  ring

private theorem centeredAge_geometric_summable {r : ℝ} (hr0 : 0 ≤ r) (hr1 : r < 1) :
    Summable (fun j : ℕ => r ^ j * centeredAge j) := by
  have hh := (IntegerBirthDiscreteAbel.geometric_discrete_absolute hr0 hr1).of_norm.prod_symm.prod
  change Summable (fun j : ℕ => ∑' n : ℕ,
    r ^ j * IntegerBirthDiscreteCorrection.centeredDiscreteTerm n j) at hh
  simpa only [tsum_mul_left, centeredAge] using hh

private theorem centeredAge_geometric_shift {r : ℝ} (hr : r ≠ 0)
    (hc : Summable (fun j : ℕ => r ^ j * centeredAge j)) :
    Summable (fun j : ℕ => r ^ j * centeredAge (j + 1)) ∧
      (∑' j : ℕ, r ^ j * centeredAge (j + 1)) =
        (∑' j : ℕ, r ^ j * centeredAge j) / r := by
  have hh := (summable_nat_add_iff 1).mpr hc
  have hg : Summable (fun j : ℕ => r ^ j * centeredAge (j + 1)) := by
    convert hh.div_const r using 1
    funext j
    rw [pow_succ]
    field_simp
  refine ⟨hg, ?_⟩
  have he := hc.tsum_eq_zero_add
  simp only [pow_zero, centeredAge_zero, mul_zero, zero_add] at he
  have hp : (fun j : ℕ => r ^ (j + 1) * centeredAge (j + 1)) =
      (fun j : ℕ => r * (r ^ j * centeredAge (j + 1))) := by
    funext j
    rw [pow_succ]
    ring
  rw [hp, tsum_mul_left] at he
  rw [he]
  field_simp

/-- Abel summation of the literal driver. The left side is the original
generating function; the initial centered birth mass is exactly zero. -/
theorem original_generatingFunction_Abel {r : ℝ} (hr0 : 0 < r) (hr1 : r < 1) :
    r * BuildingBlocks.SuccessorFeedback.generatingFunction r =
      (1 - r) * ∑' j : ℕ, r ^ j * centeredAge j := by
  have hc := centeredAge_geometric_summable hr0.le hr1
  have hs := centeredAge_geometric_shift hr0.ne' hc
  unfold BuildingBlocks.SuccessorFeedback.generatingFunction
  have ht : (fun j : ℕ => BuildingBlocks.SuccessorFeedback.driver j * r ^ j) =
      (fun j : ℕ => r ^ j * centeredAge (j + 1) - r ^ j * centeredAge j) := by
    funext j
    rw [original_driver_eq_centeredAge_difference]
    ring
  rw [ht, hs.1.tsum_sub hc, hs.2]
  field_simp

/-- Exact original `E` plus complete return correction. Every prime power and
the clipped endpoint correction `endpoint(j) * psi(j)` are retained. -/
theorem original_feedback_complete_return_identity {r : ℝ}
    (hr0 : 0 < r) (hr1 : r < 1) :
    r * BuildingBlocks.SuccessorFeedback.generatingFunction r +
      (1 - r) * (∑' j : ℕ, r ^ j * IntegerBirthDiscreteCorrection.endpoint j *
        BuildingBlocks.CoarsePrimitive.psi j) =
      (1 - r) * ∑' n : ℕ, ∑' j : ℕ, r ^ j * IntegerBirthSourceBound.sourceTerm n j := by
  rw [original_generatingFunction_Abel hr0 hr1]
  have h := IntegerBirthDiscreteAbel.geometric_actual_source_identity hr0.le hr1
  change (∑' j : ℕ, r ^ j * centeredAge j) +
    (∑' j : ℕ, r ^ j * IntegerBirthDiscreteCorrection.endpoint j *
      BuildingBlocks.CoarsePrimitive.psi j) = _ at h
  rw [← mul_add, h]

#print axioms fullBirthSeries_eq
#print axioms shiftedBirthSeries_eq
#print axioms birthDifferenceSeries_eq
#print axioms original_driver_eq_discrete_birth_difference
#print axioms original_generatingFunction_Abel
#print axioms original_feedback_complete_return_identity

end BuildingBlocks.IntegerBirthOriginalDriver
