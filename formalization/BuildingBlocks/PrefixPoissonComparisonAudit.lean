import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Data.Finset.Card
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

/-!
A finite translated family disproving a prefix-dominance-to-Poisson-weight
inference. The indices are a logical counting counterexample, not actual
zeta zeros. No theorem about the truth of a zeta paper's conclusion is stated.
-/

namespace BuildingBlocks.PrefixPoissonComparisonAudit

noncomputable section

def selected : Finset ℕ := {1, 2, 3}
def total : Finset ℕ := insert 4 selected

/-- Strict cutoff matches the positive-ordinate convention in the audited paper. -/
def prefixCount (S : Finset ℕ) (A x : ℝ) : ℝ :=
  ∑ k ∈ S, if A + (k : ℝ) < x then 1 else 0

theorem prefix_nonneg (S : Finset ℕ) (A x : ℝ) : 0 ≤ prefixCount S A x := by
  unfold prefixCount
  exact Finset.sum_nonneg fun _ _ => by split_ifs <;> norm_num

theorem total_prefix_eq (A x : ℝ) :
    prefixCount total A x = prefixCount selected A x + (if A + 4 < x then 1 else 0) := by
  unfold prefixCount total
  rw [Finset.sum_insert (by norm_num [selected] : 4 ∉ selected)]
  norm_num only
  ring

/-- Every real cutoff obeys the claimed global proportion, at every translation. -/
theorem all_real_prefix_dominance (A x : ℝ) :
    (3 / 4) * prefixCount total A x ≤ prefixCount selected A x := by
  by_cases h4 : A + 4 < x
  · have h1 : A + 1 < x := by linarith
    have h2 : A + 2 < x := by linarith
    have h3 : A + 3 < x := by linarith
    have hs : prefixCount selected A x = 3 := by
      calc
        _ = ∑ _k ∈ selected, (1 : ℝ) := by
          unfold prefixCount
          apply Finset.sum_congr rfl
          intro k hk
          have hk' : k = 1 ∨ k = 2 ∨ k = 3 := by
            simpa only [selected, Finset.mem_insert, Finset.mem_singleton] using hk
          rcases hk' with rfl | rfl | rfl
          · simp [h1]
          · simp [h2]
          · simp [h3]
        _ = 3 := by norm_num [selected]
    rw [total_prefix_eq, hs]
    simp only [if_pos h4]
    norm_num
  · rw [total_prefix_eq]
    simp only [if_neg h4, add_zero]
    have hp := prefix_nonneg selected A x
    linarith

def poissonWeight (center ordinate : ℝ) : ℝ :=
  1 / (1 + (center - ordinate) ^ 2)

@[simp] theorem poissonWeight_translate (A center ordinate : ℝ) :
    poissonWeight (A + center) (A + ordinate) = poissonWeight center ordinate := by
  unfold poissonWeight
  rw [show A + center - (A + ordinate) = center - ordinate by ring]

def selectedWeight (A : ℝ) : ℝ :=
  ∑ k ∈ selected, poissonWeight (A + 4) (A + (k : ℝ))

def totalWeight (A : ℝ) : ℝ :=
  ∑ k ∈ total, poissonWeight (A + 4) (A + (k : ℝ))

theorem selected_weight_exact (A : ℝ) : selectedWeight A = 4 / 5 := by
  norm_num [selectedWeight, selected, poissonWeight_translate, poissonWeight]

theorem total_weight_exact (A : ℝ) : totalWeight A = 9 / 5 := by
  norm_num [totalWeight, total, selected, poissonWeight_translate, poissonWeight]

theorem exact_weighted_deficit (A : ℝ) :
    (3 / 4) * totalWeight A - selectedWeight A = 11 / 20 := by
  rw [total_weight_exact, selected_weight_exact]
  norm_num

theorem exact_signed_weighted_difference (A : ℝ) :
    selectedWeight A - (3 / 4) * totalWeight A = -(11 : ℝ) / 20 := by
  rw [selected_weight_exact, total_weight_exact]
  norm_num

theorem weighted_comparison_fails (A : ℝ) :
    selectedWeight A < (3 / 4) * totalWeight A := by
  rw [selected_weight_exact, total_weight_exact]
  norm_num

theorem prefix_dominance_of_fraction {c : ℝ} (hc : c ≤ 3 / 4) (A x : ℝ) :
    c * prefixCount total A x ≤ prefixCount selected A x := by
  exact (mul_le_mul_of_nonneg_right hc (prefix_nonneg total A x)).trans
    (all_real_prefix_dominance A x)

theorem weighted_failure_of_fraction {c : ℝ} (hc : 4 / 9 < c) (A : ℝ) :
    selectedWeight A < c * totalWeight A := by
  rw [selected_weight_exact, total_weight_exact]
  nlinarith

theorem normalized_failure_of_fraction {c A : ℝ} (hc : 4 / 9 < c) (hA : 0 ≤ A) :
    selectedWeight A / Real.log (A + 4) <
      c * (totalWeight A / Real.log (A + 4)) := by
  have hlog : 0 < Real.log (A + 4) := Real.log_pos (by linarith)
  rw [← mul_div_assoc]
  exact div_lt_div_of_pos_right (weighted_failure_of_fraction hc A) hlog

/-- The positive common factor `1/log(center)` does not repair the comparison. -/
theorem normalized_comparison_fails {A : ℝ} (hA : 0 ≤ A) :
    selectedWeight A / Real.log (A + 4) <
      (3 / 4) * (totalWeight A / Real.log (A + 4)) := by
  have hlog : 0 < Real.log (A + 4) := Real.log_pos (by linarith)
  rw [← mul_div_assoc]
  exact div_lt_div_of_pos_right (weighted_comparison_fails A) hlog

theorem arbitrarily_late_normalized_failure (T : ℝ) :
    ∃ A : ℝ, 0 ≤ A ∧ T < A + 4 ∧
      (∀ x : ℝ, (3 / 4) * prefixCount total A x ≤ prefixCount selected A x) ∧
      selectedWeight A / Real.log (A + 4) <
        (3 / 4) * (totalWeight A / Real.log (A + 4)) := by
  let A := max 0 T
  have hA : 0 ≤ A := le_max_left _ _
  have hT : T ≤ A := le_max_right _ _
  exact ⟨A, hA, by linarith, all_real_prefix_dominance A,
    normalized_comparison_fails hA⟩

theorem arbitrarily_late_failure_of_fraction {c : ℝ}
    (hc0 : 4 / 9 < c) (hc1 : c ≤ 3 / 4) (T : ℝ) :
    ∃ A : ℝ, 0 ≤ A ∧ T < A + 4 ∧
      (∀ x : ℝ, c * prefixCount total A x ≤ prefixCount selected A x) ∧
      selectedWeight A / Real.log (A + 4) <
        c * (totalWeight A / Real.log (A + 4)) := by
  let A := max 0 T
  have hA : 0 ≤ A := le_max_left _ _
  have hT : T ≤ A := le_max_right _ _
  exact ⟨A, hA, by linarith, prefix_dominance_of_fraction hc1 A,
    normalized_failure_of_fraction hc0 hA⟩

#print axioms prefix_nonneg
#print axioms total_prefix_eq
#print axioms all_real_prefix_dominance
#print axioms poissonWeight_translate
#print axioms selected_weight_exact
#print axioms total_weight_exact
#print axioms exact_weighted_deficit
#print axioms exact_signed_weighted_difference
#print axioms weighted_comparison_fails
#print axioms prefix_dominance_of_fraction
#print axioms weighted_failure_of_fraction
#print axioms normalized_failure_of_fraction
#print axioms normalized_comparison_fails
#print axioms arbitrarily_late_normalized_failure
#print axioms arbitrarily_late_failure_of_fraction

end
end BuildingBlocks.PrefixPoissonComparisonAudit
