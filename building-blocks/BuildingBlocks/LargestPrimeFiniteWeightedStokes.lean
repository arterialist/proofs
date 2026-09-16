import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import Mathlib.Tactic

namespace BuildingBlocks.LargestPrimeFiniteWeightedStokes

open Finset Set MeasureTheory Real
open scoped BigOperators

noncomputable section

/-- Exact exponential tail identity used in equation (14). -/
theorem exp_max_eq_tail_integral {A B X : ℝ} (hX : 0 < X) :
    Real.exp (-2 * max A B / X) =
      2 * ∫ y in Ioi (max (A / X) (B / X)), Real.exp (-2 * y) := by
  have hmax : max A B / X = max (A / X) (B / X) := by
    rcases le_total A B with hAB | hBA
    · rw [max_eq_right hAB, max_eq_right]
      exact div_le_div_of_nonneg_right hAB hX.le
    · rw [max_eq_left hBA, max_eq_left]
      exact div_le_div_of_nonneg_right hBA hX.le
  rw [← hmax, integral_exp_mul_Ioi (by norm_num : (-2 : ℝ) < 0)]
  field_simp

/-- Exponential tail supported above `t`. -/
def tailStep (t y : ℝ) : ℝ :=
  Set.indicator (Ici t) (fun z : ℝ => Real.exp (-2 * z)) y

theorem tailStep_integrable (t : ℝ) : Integrable (tailStep t) := by
  unfold tailStep
  rw [integrable_indicator_iff measurableSet_Ici]
  change Integrable (fun z : ℝ => Real.exp (-2 * z)) (volume.restrict (Ici t))
  rw [← restrict_Ioi_eq_restrict_Ici]
  exact integrableOn_exp_mul_Ioi (a := -2) (by norm_num) t

theorem integral_tailStep (t : ℝ) :
    (∫ y : ℝ, tailStep t y) = Real.exp (-2 * t) / 2 := by
  unfold tailStep
  rw [integral_indicator measurableSet_Ici, integral_Ici_eq_integral_Ioi,
    integral_exp_mul_Ioi (by norm_num : (-2 : ℝ) < 0)]
  ring

theorem integral_tailStep_Ioi {t : ℝ} (ht : 0 ≤ t) :
    (∫ y in Ioi (0 : ℝ), tailStep t y) = Real.exp (-2 * t) / 2 := by
  rw [← integral_indicator measurableSet_Ioi]
  calc
    (∫ y : ℝ, (Ioi (0 : ℝ)).indicator (tailStep t) y) =
        ∫ y : ℝ, tailStep t y := by
      apply integral_congr_ae
      filter_upwards [Ioi_ae_eq_Ici (μ := volume) (a := (0 : ℝ))] with y hy
      by_cases hty : t ≤ y
      · have hy0 : 0 ≤ y := ht.trans hty
        have hypos : 0 < y := by
          change Ioi (0 : ℝ) y
          rw [hy]
          exact hy0
        simp [tailStep, hty, hypos]
      · simp [tailStep, hty]
    _ = Real.exp (-2 * t) / 2 := integral_tailStep t

/-- Finite moving-endpoint packet prefix. -/
def packetPrefix {ι : Type*} (s : Finset ι) (coefficient : ι → ℝ)
    (threshold : ι → ℝ) (y : ℝ) : ℝ :=
  ∑ i ∈ s, if threshold i ≤ y then coefficient i else 0

theorem exp_mul_prefix_mul_prefix {ι κ : Type*}
    (s : Finset ι) (t : Finset κ)
    (c : ι → ℝ) (d : κ → ℝ) (u : ι → ℝ) (v : κ → ℝ) (y : ℝ) :
    Real.exp (-2 * y) * packetPrefix s c u y * packetPrefix t d v y =
      ∑ i ∈ s, ∑ j ∈ t, c i * d j * tailStep (max (u i) (v j)) y := by
  classical
  unfold packetPrefix
  calc
    Real.exp (-2 * y) * (∑ i ∈ s, if u i ≤ y then c i else 0) *
        (∑ j ∈ t, if v j ≤ y then d j else 0) =
      ∑ j ∈ t, ∑ i ∈ s, Real.exp (-2 * y) *
        (if u i ≤ y then c i else 0) * (if v j ≤ y then d j else 0) := by
          simp_rw [Finset.mul_sum, Finset.sum_mul]
    _ = ∑ j ∈ t, ∑ i ∈ s,
        c i * d j * tailStep (max (u i) (v j)) y := by
      apply sum_congr rfl
      intro j hj
      apply sum_congr rfl
      intro i hi
      by_cases hui : u i ≤ y <;> by_cases hvj : v j ≤ y
      all_goals simp [hui, hvj, tailStep]
      ring
    _ = ∑ i ∈ s, ∑ j ∈ t,
        c i * d j * tailStep (max (u i) (v j)) y := by
      rw [sum_comm]

/-- Finite Stokes identity for one pair of successor indices. -/
theorem finite_packet_stokes {ι κ : Type*}
    (s : Finset ι) (t : Finset κ)
    (c : ι → ℝ) (d : κ → ℝ) (u : ι → ℝ) (v : κ → ℝ)
    (hu : ∀ i ∈ s, 0 ≤ u i) (hv : ∀ j ∈ t, 0 ≤ v j) :
    (∑ i ∈ s, ∑ j ∈ t,
      c i * d j * Real.exp (-2 * max (u i) (v j))) =
      2 * ∫ y in Ioi (0 : ℝ),
        Real.exp (-2 * y) * packetPrefix s c u y * packetPrefix t d v y := by
  classical
  rw [integral_congr_ae (Filter.Eventually.of_forall fun y =>
    exp_mul_prefix_mul_prefix s t c d u v y)]
  rw [integral_finset_sum s (fun i hi =>
    integrable_finset_sum t fun j hj =>
      ((tailStep_integrable (max (u i) (v j))).const_mul _).integrableOn)]
  rw [Finset.mul_sum]
  apply sum_congr rfl
  intro i hi
  rw [integral_finset_sum t (fun j hj =>
    ((tailStep_integrable (max (u i) (v j))).const_mul _).integrableOn)]
  rw [Finset.mul_sum]
  apply sum_congr rfl
  intro j hj
  have hmax : 0 ≤ max (u i) (v j) := by
    have hsum : 0 ≤ u i + v j := add_nonneg (hu i hi) (hv j hj)
    nlinarith [hsum, le_max_left (u i) (v j), le_max_right (u i) (v j)]
  rw [integral_const_mul, integral_tailStep_Ioi hmax]
  ring

/-- Complete finite weighted Stokes/Gram identity. The finite sets `A` and `B`
are the allowed truncations of the successor histories; packet coefficients may
have arbitrary signs. -/
theorem finite_weighted_stokes_gram
    {α β ι κ : Type*}
    (A : Finset α) (B : Finset β) (s : Finset ι) (t : Finset κ)
    (weight : α → β → ℝ) (c : ι → ℝ) (d : κ → ℝ)
    (u : α → ι → ℝ) (v : β → κ → ℝ)
    (hu : ∀ a ∈ A, ∀ i ∈ s, 0 ≤ u a i)
    (hv : ∀ b ∈ B, ∀ j ∈ t, 0 ≤ v b j) :
    (∑ a ∈ A, ∑ b ∈ B, weight a b *
      (∑ i ∈ s, ∑ j ∈ t,
        c i * d j * Real.exp (-2 * max (u a i) (v b j)))) =
      2 * ∑ a ∈ A, ∑ b ∈ B, weight a b *
        ∫ y in Ioi (0 : ℝ), Real.exp (-2 * y) *
          packetPrefix s c (u a) y * packetPrefix t d (v b) y := by
  classical
  rw [Finset.mul_sum]
  apply sum_congr rfl
  intro a ha
  rw [Finset.mul_sum]
  apply sum_congr rfl
  intro b hb
  rw [finite_packet_stokes s t c d (u a) (v b) (hu a ha) (hv b hb)]
  ring

/-- The same identity specialized to explicitly nonnegative finite weights.
Nonnegativity is recorded for later analytic estimates but is not needed for
the exact algebraic equality. -/
theorem finite_nonnegative_weighted_stokes_gram
    {α β ι κ : Type*}
    (A : Finset α) (B : Finset β) (s : Finset ι) (t : Finset κ)
    (weight : α → β → ℝ) (_hweight : ∀ a ∈ A, ∀ b ∈ B, 0 ≤ weight a b)
    (c : ι → ℝ) (d : κ → ℝ)
    (u : α → ι → ℝ) (v : β → κ → ℝ)
    (hu : ∀ a ∈ A, ∀ i ∈ s, 0 ≤ u a i)
    (hv : ∀ b ∈ B, ∀ j ∈ t, 0 ≤ v b j) :
    (∑ a ∈ A, ∑ b ∈ B, weight a b *
      (∑ i ∈ s, ∑ j ∈ t,
        c i * d j * Real.exp (-2 * max (u a i) (v b j)))) =
      2 * ∑ a ∈ A, ∑ b ∈ B, weight a b *
        ∫ y in Ioi (0 : ℝ), Real.exp (-2 * y) *
          packetPrefix s c (u a) y * packetPrefix t d (v b) y :=
  finite_weighted_stokes_gram A B s t weight c d u v hu hv

#print axioms exp_max_eq_tail_integral
#print axioms tailStep_integrable
#print axioms integral_tailStep
#print axioms integral_tailStep_Ioi
#print axioms exp_mul_prefix_mul_prefix
#print axioms finite_packet_stokes
#print axioms finite_weighted_stokes_gram
#print axioms finite_nonnegative_weighted_stokes_gram

end
end BuildingBlocks.LargestPrimeFiniteWeightedStokes
