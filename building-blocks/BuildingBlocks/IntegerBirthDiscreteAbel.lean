import BuildingBlocks.IntegerBirthDiscreteCorrection

open MeasureTheory Set
open scoped BigOperators

namespace BuildingBlocks.IntegerBirthDiscreteAbel

open CoarsePrimitive IntegerBirthKernel IntegerBirthSourceBound IntegerBirthDiscreteCorrection

private theorem endpoint_nonnegative (j : ℕ) : 0 ≤ endpoint j := by
  exact div_nonneg (Real.arctan_nonneg.mpr (by positivity)) (Real.sqrt_nonneg _)

private theorem endpoint_bound {n j : ℕ} (hn : 2 ≤ n) (hnj : n ≤ j) :
    endpoint j ≤ boundConstant*(j : ℝ)/((n : ℝ)*Real.sqrt n) := by
  have hn0 : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hnj' : (n : ℝ) ≤ j := by exact_mod_cast hnj
  have hsn : 0 < Real.sqrt (n : ℝ) := Real.sqrt_pos.mpr hn0
  have hsj : 0 < Real.sqrt (j : ℝ) := hsn.trans_le (Real.sqrt_le_sqrt hnj')
  have hinv := one_div_le_one_div_of_le hsn (Real.sqrt_le_sqrt hnj')
  have ha : endpoint j ≤ (Real.pi/2)/Real.sqrt n := by
    unfold endpoint
    calc
      _ ≤ (Real.pi/2)/Real.sqrt j := div_le_div_of_nonneg_right
        (Real.arctan_lt_pi_div_two _).le hsj.le
      _ ≤ _ := by
        convert mul_le_mul_of_nonneg_left hinv (show 0 ≤ Real.pi/2 by positivity) using 1 <;> ring
  apply ha.trans
  apply (le_div_iff₀ (mul_pos hn0 hsn)).mpr
  have he : (Real.pi/2)/Real.sqrt n*((n : ℝ)*Real.sqrt n)=(Real.pi/2)*n := by field_simp
  rw [he]
  apply (mul_le_mul_of_nonneg_left hnj' (show 0 ≤ Real.pi/2 by positivity)).trans
  apply mul_le_mul_of_nonneg_right _ (Nat.cast_nonneg j)
  unfold boundConstant
  linarith [Real.pi_pos]

noncomputable def endpointTerm (n j : ℕ) : ℝ :=
  ArithmeticFunction.vonMangoldt (n+2)*(if n+2 ≤ j then endpoint j else 0)

private theorem endpointTerm_nonnegative (n j : ℕ) : 0 ≤ endpointTerm n j := by
  unfold endpointTerm
  split_ifs
  · exact mul_nonneg ArithmeticFunction.vonMangoldt_nonneg (endpoint_nonnegative j)
  · simp

private theorem endpointTerm_bound (n j : ℕ) :
    ‖endpointTerm n j‖ ≤ boundConstant*(j : ℝ)*birthWeight n := by
  rw [Real.norm_eq_abs, abs_of_nonneg (endpointTerm_nonnegative n j)]
  by_cases hj : n+2 ≤ j
  · rw [endpointTerm, if_pos hj]
    have hh := mul_le_mul_of_nonneg_left (endpoint_bound (by omega) hj)
      (ArithmeticFunction.vonMangoldt_nonneg (n := n+2))
    convert hh using 1
    unfold birthWeight
    ring
  · simp only [endpointTerm, if_neg hj, mul_zero]
    exact mul_nonneg (mul_nonneg (by unfold boundConstant; positivity) (Nat.cast_nonneg j))
      (birthWeight_nonnegative n)

/-- Full prime-power return histories are absolutely summable with the geometric clock. -/
theorem geometric_endpoint_absolute {r : ℝ} (hr0 : 0 ≤ r) (hr1 : r < 1) :
    Summable (fun z : ℕ × ℕ => ‖r^z.2*endpointTerm z.1 z.2‖) := by
  have hr : ‖r‖ < 1 := by simpa [Real.norm_eq_abs, abs_of_nonneg hr0] using hr1
  have hj : Summable (fun j : ℕ => boundConstant*(j : ℝ)*r^j) := by
    simpa only [pow_one, mul_assoc] using
      (summable_pow_mul_geometric_of_norm_lt_one (R := ℝ) 1 hr).mul_left boundConstant
  have hp := summable_birthWeight.mul_of_nonneg hj birthWeight_nonnegative
    (fun j => mul_nonneg (mul_nonneg (by unfold boundConstant; positivity) (Nat.cast_nonneg j))
      (pow_nonneg hr0 j))
  apply hp.of_nonneg_of_le (fun _ => norm_nonneg _)
  intro z
  rw [norm_mul, Real.norm_eq_abs, abs_of_nonneg (pow_nonneg hr0 _)]
  have hh := mul_le_mul_of_nonneg_left (endpointTerm_bound z.1 z.2) (pow_nonneg hr0 z.2)
  convert hh using 1 <;> ring

private theorem centered_eq_sub (n j : ℕ) :
    centeredDiscreteTerm n j = sourceTerm n j - endpointTerm n j := by
  rw [centeredDiscreteTerm, centered_discreteBirth (by omega)]
  simp only [sourceTerm, endpointTerm]
  ring

/-- Absolute convergence of the literal clipped birth/clock source. -/
theorem geometric_discrete_absolute {r : ℝ} (hr0 : 0 ≤ r) (hr1 : r < 1) :
    Summable (fun z : ℕ × ℕ => ‖r^z.2*centeredDiscreteTerm z.1 z.2‖) := by
  have hs := geometric_source_absolute hr0 hr1
  have he := geometric_endpoint_absolute hr0 hr1
  apply (hs.add he).of_nonneg_of_le (fun _ => norm_nonneg _)
  intro z
  rw [centered_eq_sub, mul_sub]
  exact norm_sub_le _ _

/-- The correction uses psi(j), not an asymptotic density, and is absolutely summable. -/
theorem geometric_correction_summable {r : ℝ} (hr0 : 0 ≤ r) (hr1 : r < 1) :
    Summable (fun j : ℕ => r^j*endpoint j*psi j) := by
  have hh := (geometric_endpoint_absolute hr0 hr1).of_norm.prod_symm.prod
  change Summable (fun j : ℕ => ∑' n : ℕ, r^j*endpointTerm n j) at hh
  convert hh using 1
  funext j
  rw [tsum_mul_left]
  change r^j*endpoint j*psi j = r^j*(∑' n, endpointTerm n j)
  rw [show (∑' n, endpointTerm n j)=endpoint j*psi j from (endpoint_all_births j).2]
  ring

set_option maxHeartbeats 800000 in
/-- Exact geometric all-birth correction; no original-driver identification is assumed. -/
theorem geometric_actual_source_identity {r : ℝ} (hr0 : 0 ≤ r) (hr1 : r < 1) :
    (∑' j : ℕ, r^j*(∑' n : ℕ, centeredDiscreteTerm n j)) +
      (∑' j : ℕ, r^j*endpoint j*psi j) =
      ∑' n : ℕ, ∑' j : ℕ, r^j*sourceTerm n j := by
  have hd := (geometric_discrete_absolute hr0 hr1).of_norm
  have hs := (geometric_source_absolute hr0 hr1).of_norm
  have hdj : Summable (fun j : ℕ => r^j*(∑' n : ℕ, centeredDiscreteTerm n j)) := by
    have hh := hd.prod_symm.prod
    change Summable (fun j : ℕ => ∑' n : ℕ, r^j*centeredDiscreteTerm n j) at hh
    simpa only [tsum_mul_left] using hh
  rw [← hdj.tsum_add (geometric_correction_summable hr0 hr1)]
  calc
    _ = ∑' j : ℕ, ∑' n : ℕ, r^j*sourceTerm n j := by
      apply tsum_congr
      intro j
      rw [tsum_mul_left]
      have hh := congrArg (fun z : ℝ => r^j*z) (actual_fixed_age_identity j)
      nlinarith only [hh]
    _ = _ := Summable.tsum_comm (f := fun n j : ℕ => r^j*sourceTerm n j) hs

#print axioms geometric_endpoint_absolute
#print axioms geometric_discrete_absolute
#print axioms geometric_actual_source_identity

end BuildingBlocks.IntegerBirthDiscreteAbel
