import BuildingBlocks.IntegerBirthExponentialHats
import BuildingBlocks.CoarsePrimitive
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Arctan

open MeasureTheory Set
open scoped BigOperators

namespace BuildingBlocks.IntegerBirthDiscreteCorrection

open CoarsePrimitive IntegerBirthKernel IntegerBirthSourceBound

/-- The literal successor birth mass. The physical lower endpoint remains one. -/
noncomputable def discreteBirth (n j : ℕ) : ℝ :=
  if j = 0 then 1 / Real.sqrt n else
    Real.arctan (Real.sqrt ((j : ℝ) / max 1 ((n : ℝ) - j))) / Real.sqrt j

/-- The exact lower-boundary return at successor age j. -/
noncomputable def endpoint (j : ℕ) : ℝ :=
  Real.arctan (1 / Real.sqrt j) / Real.sqrt j

private theorem arcsin_root_eq_arctan {n u : ℝ} (hu : 0 < u) (hun : u < n) :
    Real.arcsin (Real.sqrt (u/n)) = Real.arctan (Real.sqrt (u/(n-u))) := by
  have hn : 0 < n := lt_trans hu hun
  have hp : 0 ≤ u/n := (div_pos hu hn).le
  have hq : Real.sqrt (u/n) < 1 := by
    simpa using Real.sqrt_lt_sqrt hp ((div_lt_one hn).mpr hun)
  rw [Real.arcsin_eq_arctan ⟨by have := Real.sqrt_nonneg (u/n); linarith, hq⟩,
    Real.sq_sqrt hp, ← Real.sqrt_div hp]
  congr 2
  field_simp
  <;> ring

/-- Before an integer birth, the clipped and continuous masses agree exactly. -/
theorem discreteBirth_eq_prebirth {n j : ℕ} (hn : 2 ≤ n) (hj : j < n) :
    discreteBirth n j = q n j := by
  by_cases hj0 : j = 0
  · simp [discreteBirth, hj0, q]
  have hjp : 0 < (j : ℝ) := by exact_mod_cast Nat.pos_of_ne_zero hj0
  have hjn : (j : ℝ) < n := by exact_mod_cast hj
  have hd : 1 ≤ (n : ℝ)-j := by
    have h : (j : ℝ)+1 ≤ n := by exact_mod_cast (show j+1 ≤ n from hj)
    linarith
  rw [discreteBirth, if_neg hj0, max_eq_right hd, q, if_neg hjp.ne', if_pos hjn.le,
    arcsin_root_eq_arctan hjp hjn]

/-- At and after birth, the full physical endpoint subtracts exactly the arctangent return. -/
theorem discreteBirth_eq_postbirth {n j : ℕ} (hn : 2 ≤ n) (hj : n ≤ j) :
    discreteBirth n j = q n j - endpoint j := by
  have hn0 : 0 < (n : ℝ) := by exact_mod_cast (show 0 < n by omega)
  have hj0 : j ≠ 0 := by omega
  have hjp : 0 < (j : ℝ) := by exact_mod_cast (show 0 < j by omega)
  have hnj : (n : ℝ) ≤ j := by exact_mod_cast hj
  have hs : 0 < Real.sqrt (j : ℝ) := Real.sqrt_pos.mpr hjp
  have ha := Real.arctan_inv_of_pos hs
  rw [discreteBirth, if_neg hj0, max_eq_left (by linarith : (n : ℝ)-j ≤ 1), div_one,
    q_eq_postbirth hn0 hnj, endpoint]
  rw [one_div] 
  rw [ha]
  ring

/-- Exact integer-age correction, including the initial age zero and the birth endpoint. -/
theorem discreteBirth_correction {n : ℕ} (hn : 2 ≤ n) (j : ℕ) :
    discreteBirth n j = q n j - if n ≤ j then endpoint j else 0 := by
  by_cases hj : n ≤ j
  · rw [if_pos hj]
    exact discreteBirth_eq_postbirth hn hj
  · rw [if_neg hj, sub_zero]
    exact discreteBirth_eq_prebirth hn (Nat.lt_of_not_ge hj)

/-- The subtraction of the original birth value is retained before summing in n. -/
theorem centered_discreteBirth {n : ℕ} (hn : 2 ≤ n) (j : ℕ) :
    discreteBirth n j - 1 / Real.sqrt n =
      U n j - if n ≤ j then endpoint j else 0 := by
  rw [discreteBirth_correction hn, U]
  ring

set_option maxHeartbeats 800000 in
/-- Exact all-power cutoff, with the vanishing n=0 and n=1 terms removed. -/
private theorem mangoldt_tail_cutoff (j : ℕ) :
    Summable (fun n : ℕ => if n+2 ≤ j then ArithmeticFunction.vonMangoldt (n+2) else 0) ∧
    (∑' n : ℕ, if n+2 ≤ j then ArithmeticFunction.vonMangoldt (n+2) else 0) = psi j := by
  let f : ℕ → ℝ := fun n => if n ≤ j then ArithmeticFunction.vonMangoldt n else 0
  have hf : Summable f := summable_of_ne_finset_zero (f := f) (s := Finset.range (j+1)) (by
    intro n hn
    simp only [Finset.mem_range, not_lt] at hn
    simp [f, show ¬n ≤ j by omega])
  have he : (∑' n, f n) = psi j := by
    rw [tsum_eq_sum (f := f) (s := Finset.range (j+1)) (by
      intro n hn
      simp only [Finset.mem_range, not_lt] at hn
      simp [f, show ¬n ≤ j by omega])]
    unfold psi
    apply Finset.sum_congr rfl
    intro n hn
    simp [f, show n ≤ j by simpa only [Finset.mem_range, Nat.lt_succ_iff] using hn]
  have hh := hf.sum_add_tsum_nat_add 2
  have hzero : (∑ n ∈ Finset.range 2, f n) = 0 := by simp [f, Finset.sum_range_succ]
  rw [hzero, zero_add, he] at hh
  exact ⟨(summable_nat_add_iff 2).mpr hf, hh⟩

/-- Every returning prime power contributes to the original finite psi cutoff. -/
theorem endpoint_all_births (j : ℕ) :
    Summable (fun n : ℕ => ArithmeticFunction.vonMangoldt (n+2) *
      (if n+2 ≤ j then endpoint j else 0)) ∧
    (∑' n : ℕ, ArithmeticFunction.vonMangoldt (n+2) *
      (if n+2 ≤ j then endpoint j else 0)) = endpoint j * psi j := by
  have hh := mangoldt_tail_cutoff j
  have he : (fun n : ℕ => ArithmeticFunction.vonMangoldt (n+2) *
      (if n+2 ≤ j then endpoint j else 0)) =
      (fun n : ℕ => endpoint j * (if n+2 ≤ j then ArithmeticFunction.vonMangoldt (n+2) else 0)) := by
    funext n
    split_ifs <;> ring
  rw [he]
  exact ⟨hh.1.mul_left _, by rw [tsum_mul_left, hh.2]⟩

noncomputable def centeredDiscreteTerm (n j : ℕ) : ℝ :=
  ArithmeticFunction.vonMangoldt (n+2) *
    (discreteBirth (n+2) j - 1 / Real.sqrt ((n+2 : ℕ) : ℝ))

/-- The literal clipped all-birth source is absolutely summable at each successor age. -/
theorem centeredDiscreteTerm_summable (j : ℕ) : Summable (fun n => centeredDiscreteTerm n j) := by
  have hs := sourceTerm_summable (u := (j : ℝ)) (Nat.cast_nonneg j)
  have he := (endpoint_all_births j).1
  convert hs.sub he using 1
  funext n
  rw [centeredDiscreteTerm, centered_discreteBirth (by omega)]
  simp only [sourceTerm]
  ring

/-- Fixed-age source identity: the correction is the complete actual psi(j), with no density replacement. -/
theorem actual_fixed_age_identity (j : ℕ) :
    (∑' n : ℕ, centeredDiscreteTerm n j) + endpoint j * psi j =
      ∑' n : ℕ, sourceTerm n j := by
  have hs := sourceTerm_summable (u := (j : ℝ)) (Nat.cast_nonneg j)
  have he := endpoint_all_births j
  have ht : (fun n => centeredDiscreteTerm n j) =
      (fun n : ℕ => sourceTerm n j - ArithmeticFunction.vonMangoldt (n+2) *
        (if n+2 ≤ j then endpoint j else 0)) := by
    funext n
    rw [centeredDiscreteTerm, centered_discreteBirth (by omega)]
    simp only [sourceTerm]
    ring
  rw [ht, hs.tsum_sub he.1, he.2]
  ring

#print axioms discreteBirth_correction
#print axioms centered_discreteBirth
#print axioms endpoint_all_births
#print axioms centeredDiscreteTerm_summable
#print axioms actual_fixed_age_identity

end BuildingBlocks.IntegerBirthDiscreteCorrection
