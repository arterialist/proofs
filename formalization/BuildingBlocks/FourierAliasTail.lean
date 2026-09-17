import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity

open scoped BigOperators

namespace BuildingBlocks

/-- The finite alias square mass, from its maximum and its total mass. -/
theorem aliasWeight_sq_sum_le {ι : Type*} (s : Finset ι) (w : ι → ℝ)
    {K : ℝ} (hK : 0 < K)
    (hw : ∀ r ∈ s, 0 ≤ w r)
    (hmax : ∀ r ∈ s, w r ≤ 4 / K ^ 2)
    (hmass : ∑ r ∈ s, w r ≤ 2 / K) :
    ∑ r ∈ s, (w r) ^ 2 ≤ 8 / K ^ 3 := by
  calc
    ∑ r ∈ s, (w r) ^ 2 ≤ ∑ r ∈ s, (4 / K ^ 2) * w r := by
      apply Finset.sum_le_sum
      intro r hr
      simpa [pow_two] using mul_le_mul_of_nonneg_right (hmax r hr) (hw r hr)
    _ = (4 / K ^ 2) * ∑ r ∈ s, w r := by rw [Finset.mul_sum]
    _ ≤ (4 / K ^ 2) * (2 / K) := by
      exact mul_le_mul_of_nonneg_left hmass (by positivity)
    _ = 8 / K ^ 3 := by field_simp; ring

/-- Cauchy--Schwarz for the aliased point evaluation, valid for any real normed space. -/
theorem aliasWeightedSum_norm_sq_le {ι E : Type*}
    [NormedAddCommGroup E] [NormedSpace ℝ E]
    (s : Finset ι) (a : ι → E) (w : ι → ℝ)
    {K : ℝ} (hK : 0 < K)
    (hw : ∀ r ∈ s, 0 ≤ w r)
    (hmax : ∀ r ∈ s, w r ≤ 4 / K ^ 2)
    (hmass : ∑ r ∈ s, w r ≤ 2 / K) :
    ‖∑ r ∈ s, w r • a r‖ ^ 2 ≤ (∑ r ∈ s, ‖a r‖ ^ 2) * (8 / K ^ 3) := by
  have hn : ‖∑ r ∈ s, w r • a r‖ ≤ ∑ r ∈ s, ‖a r‖ * w r := by
    calc
      _ ≤ ∑ r ∈ s, ‖w r • a r‖ := norm_sum_le _ _
      _ = _ := by
        apply Finset.sum_congr rfl
        intro r hr
        simp [norm_smul, Real.norm_eq_abs, abs_of_nonneg (hw r hr), mul_comm]
  calc
    _ ≤ (∑ r ∈ s, ‖a r‖ * w r) ^ 2 := by
      exact pow_le_pow_left₀ (norm_nonneg _) hn 2
    _ ≤ (∑ r ∈ s, ‖a r‖ ^ 2) * (∑ r ∈ s, (w r) ^ 2) :=
      Finset.sum_mul_sq_le_sq_mul_sq s (fun r => ‖a r‖) w
    _ ≤ _ := mul_le_mul_of_nonneg_left
      (aliasWeight_sq_sum_le s w hK hw hmax hmass)
      (Finset.sum_nonneg fun r _ => sq_nonneg ‖a r‖)

/-- The exact perturbation estimate used for full and truncated primitive vectors. -/
theorem norm_difference_le_of_tail {E : Type*} [NormedAddCommGroup E]
    (v vlow vtail : E) (hdecomp : v = vlow + vtail)
    {B : ℝ} (htail : ‖vtail‖ ≤ B) : |‖v‖ - ‖vlow‖| ≤ B := by
  calc
    _ ≤ ‖v - vlow‖ := abs_norm_sub_norm_le v vlow
    _ = ‖vtail‖ := by rw [hdecomp]; simp
    _ ≤ B := htail

/-- The energy form of the same comparison; the tail energy bound is explicit. -/
theorem norm_difference_le_sqrt_of_tail_energy {E : Type*} [NormedAddCommGroup E]
    (v vlow vtail : E) (hdecomp : v = vlow + vtail)
    {B : ℝ} (htail : ‖vtail‖ ^ 2 ≤ B) :
    |‖v‖ - ‖vlow‖| ≤ Real.sqrt B :=
  norm_difference_le_of_tail v vlow vtail hdecomp (Real.le_sqrt_of_sq_le htail)

end BuildingBlocks
