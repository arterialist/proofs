import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Order.Filter.Basic
import Mathlib.Topology.Order.Basic
import BuildingBlocks.ActualWeilZeroPairAlgebra

open Filter
open scoped Topology

namespace BuildingBlocks.ActualWeilSignObstruction

/-- The off-line zero growth rate exponent α = c * ε is strictly positive
for any positive span scaling c > 0 and off-critical shift ε > 0. -/
theorem offline_growth_exponent_pos {c ε : ℝ} (hc : 0 < c) (hε : 0 < ε) :
    0 < c * ε :=
  mul_pos hc hε

/-- The off-line zero growth factor 2 * b * T^α tends to +∞ as T → ∞
for any positive coefficient b > 0 and positive exponent α > 0. -/
theorem offline_growth_divergence {b α : ℝ} (hb : 0 < b) (hα : 0 < α) :
    Tendsto (fun T : ℝ => 2 * b * T^α) atTop atTop := by
  have h2b : 0 < 2 * b := by linarith
  have ht : Tendsto (fun T : ℝ => T^α) atTop atTop :=
    tendsto_rpow_atTop hα
  exact ht.const_mul_atTop h2b

/-- The negative drift - (2 * b * T^α) tends to -∞ as T → ∞. -/
theorem offline_negative_drift_divergence {b α : ℝ} (hb : 0 < b) (hα : 0 < α) :
    Tendsto (fun T : ℝ => - (2 * b * T^α)) atTop atBot := by
  have hd := offline_growth_divergence hb hα
  exact tendsto_neg_atTop_atBot.comp hd

/-- For any constant bound K and base bound M, the paired off-line upper bound
6 * M - 2 * b * T^α eventually drops strictly below K. -/
theorem offline_paired_deficit_eventual (K M : ℝ) {b α : ℝ} (hb : 0 < b) (hα : 0 < α) :
    ∀ᶠ (T : ℝ) in atTop, 6 * M - 2 * b * T^α < K := by
  have hd := (offline_growth_divergence hb hα).eventually (eventually_gt_atTop (6 * M - K))
  filter_upwards [hd] with T hT
  linarith

/-- Power dominance of the off-line zero over a sub-power proper-cofactor remainder:
for any α > ν and b > 0, C_tail > 0, whenever T > (C_tail / b)^(1 / (α - ν)) and T > 1,
the proper-cofactor remainder C_tail * T^ν is strictly dominated by b * T^α. -/
theorem subpower_dominance {α ν b C_tail : ℝ} (hαν : ν < α) (hb : 0 < b) (hC : 0 < C_tail)
    {T : ℝ} (hT1 : 1 < T) (hT : (C_tail / b) ^ (1 / (α - ν)) < T) :
    C_tail * T^ν < b * T^α := by
  have hdiff : 0 < α - ν := sub_pos.mpr hαν
  have hCdiv : 0 < C_tail / b := div_pos hC hb
  have hTpos : 0 < T := by linarith
  have hTpow : (C_tail / b) < T ^ (α - ν) := by
    have h1 : ((C_tail / b) ^ (1 / (α - ν))) ^ (α - ν) < T ^ (α - ν) := by
      apply Real.rpow_lt_rpow (by positivity) hT hdiff
    have hid : ((C_tail / b) ^ (1 / (α - ν))) ^ (α - ν) = C_tail / b := by
      rw [← Real.rpow_mul (le_of_lt hCdiv)]
      have hinv : (1 / (α - ν)) * (α - ν) = 1 := by
        rw [one_div, inv_mul_cancel₀ (ne_of_gt hdiff)]
      rw [hinv, Real.rpow_one]
    rwa [hid] at h1
  have hmul : (C_tail / b) * T^ν < T ^ (α - ν) * T^ν := by
    apply mul_lt_mul_of_pos_right hTpow (Real.rpow_pos_of_pos hTpos ν)
  rw [← Real.rpow_add hTpos] at hmul
  have hcancel : α - ν + ν = α := by ring
  rw [hcancel] at hmul
  have hfinal : b * ((C_tail / b) * T^ν) < b * T^α := by
    apply mul_lt_mul_of_pos_left hmul hb
  have hleft : b * ((C_tail / b) * T^ν) = C_tail * T^ν := by
    rw [← mul_assoc, mul_div_cancel₀ _ (ne_of_gt hb)]
  rwa [hleft] at hfinal

/-- The off-line zero net negative contribution strictly dominates the proper-cofactor
remainder, leaving an uncompensated negative drift of magnitude at least b * T^α. -/
theorem offline_net_negativity_with_remainder {α ν b C_tail : ℝ} (hαν : ν < α)
    (hb : 0 < b) (hC : 0 < C_tail) {T : ℝ} (hT1 : 1 < T)
    (hT : (C_tail / b) ^ (1 / (α - ν)) < T) :
    - (2 * b * T^α) + C_tail * T^ν < - (b * T^α) := by
  have hdom := subpower_dominance hαν hb hC hT1 hT
  linarith

/-- The Weil Sign Incompatibility Theorem:
Suppose an arithmetic quadratic form satisfies a positive lower bound Q(T) ≥ M_arith.
If an uncompensated off-line zero forces an upper bound Q(T) ≤ C_bound - 2 * b * T^α,
then Q(T) eventually falls strictly below M_arith, producing a direct contradiction. -/
theorem weil_sign_incompatibility {M_arith C_bound b α : ℝ}
    (hb : 0 < b) (hα : 0 < α) :
    ∀ᶠ (T : ℝ) in atTop, C_bound - 2 * b * T^α < M_arith := by
  have he := offline_paired_deficit_eventual M_arith (C_bound / 6) hb hα
  filter_upwards [he] with T hT
  have heq : 6 * (C_bound / 6) = C_bound := by ring
  rwa [heq] at hT

end BuildingBlocks.ActualWeilSignObstruction

#print axioms BuildingBlocks.ActualWeilSignObstruction.offline_growth_exponent_pos
#print axioms BuildingBlocks.ActualWeilSignObstruction.offline_growth_divergence
#print axioms BuildingBlocks.ActualWeilSignObstruction.offline_negative_drift_divergence
#print axioms BuildingBlocks.ActualWeilSignObstruction.offline_paired_deficit_eventual
#print axioms BuildingBlocks.ActualWeilSignObstruction.subpower_dominance
#print axioms BuildingBlocks.ActualWeilSignObstruction.offline_net_negativity_with_remainder
#print axioms BuildingBlocks.ActualWeilSignObstruction.weil_sign_incompatibility
