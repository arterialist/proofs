import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

open scoped BigOperators

namespace BuildingBlocks.AncestryFlow

variable {ι : Type*} [DecidableEq ι]

/-- Finite occupation balance telescopes against any real potential.
No positivity, acyclicity, or arithmetic identification is assumed. -/
theorem finite_flow_potential (s : Finset ι) (b M V : ι → ℝ)
    (T : ι → ι → ℝ)
    (hflow : ∀ i ∈ s, M i = b i + ∑ j ∈ s, M j * T j i) :
    (∑ i ∈ s, M i * (V i - ∑ j ∈ s, T i j * V j)) =
      ∑ i ∈ s, b i * V i := by
  have hbalance : (∑ i ∈ s, M i * V i) =
      (∑ i ∈ s, b i * V i) + ∑ j ∈ s, ∑ i ∈ s, M j * T j i * V i := by
    calc
      _ = ∑ i ∈ s, (b i + ∑ j ∈ s, M j * T j i) * V i := by
        apply Finset.sum_congr rfl
        intro i hi
        rw [hflow i hi]
      _ = _ := by
        simp_rw [add_mul, Finset.sum_mul]
        rw [Finset.sum_add_distrib, Finset.sum_comm]
  calc
    _ = (∑ i ∈ s, M i * V i) - ∑ i ∈ s, ∑ j ∈ s, M i * T i j * V j := by
      simp_rw [mul_sub, Finset.mul_sum, ← mul_assoc]
      rw [Finset.sum_sub_distrib]
    _ = _ := by rw [hbalance]; ring

/-- All root mass is absorbed when the finite occupation equations and
the transition-plus-absorption row identities hold. -/
theorem finite_flow_absorption (s : Finset ι) (b M r : ι → ℝ)
    (T : ι → ι → ℝ)
    (hflow : ∀ i ∈ s, M i = b i + ∑ j ∈ s, M j * T j i)
    (hrow : ∀ i ∈ s, r i + ∑ j ∈ s, T i j = 1) :
    (∑ i ∈ s, M i * r i) = ∑ i ∈ s, b i := by
  have hp := finite_flow_potential s b M (fun _ => 1) T hflow
  simp only [mul_one] at hp
  calc
    _ = ∑ i ∈ s, M i * (1 - ∑ j ∈ s, T i j) := by
      apply Finset.sum_congr rfl
      intro i hi
      have hr := hrow i hi
      congr 1
      linarith
    _ = _ := hp

/-- A positive drift on one part of the state space controls occupation there.
The drift on the remaining states is assumed nonnegative. -/
theorem finite_flow_drift_bound (s o : Finset ι) (b M V : ι → ℝ)
    (T : ι → ι → ℝ) (c : ℝ)
    (hos : o ⊆ s)
    (hflow : ∀ i ∈ s, M i = b i + ∑ j ∈ s, M j * T j i)
    (hM : ∀ i ∈ s, 0 ≤ M i)
    (hdelta : ∀ i ∈ s, 0 ≤ V i - ∑ j ∈ s, T i j * V j)
    (hodrift : ∀ i ∈ o, c ≤ V i - ∑ j ∈ s, T i j * V j) :
    c * (∑ i ∈ o, M i) ≤ ∑ i ∈ s, b i * V i := by
  calc
    _ = ∑ i ∈ o, M i * c := by rw [Finset.mul_sum]; simp_rw [mul_comm c]
    _ ≤ ∑ i ∈ o, M i * (V i - ∑ j ∈ s, T i j * V j) := by
      apply Finset.sum_le_sum
      intro i hi
      exact mul_le_mul_of_nonneg_left (hodrift i hi) (hM i (hos hi))
    _ ≤ ∑ i ∈ s, M i * (V i - ∑ j ∈ s, T i j * V j) := by
      apply Finset.sum_le_sum_of_subset_of_nonneg hos
      intro i hi _
      exact mul_nonneg (hM i hi) (hdelta i hi)
    _ = _ := finite_flow_potential s b M V T hflow

/-- If complementary occupation is bounded by occupation on the drifting
states plus root mass `B`, the total traffic has this explicit bound.
The complementary-occupation inequality is a premise, not an arithmetic claim. -/
theorem finite_flow_traffic_bound (s o : Finset ι) (b M V : ι → ℝ)
    (T : ι → ι → ℝ) (c B : ℝ)
    (hos : o ⊆ s) (hc : 0 < c)
    (hflow : ∀ i ∈ s, M i = b i + ∑ j ∈ s, M j * T j i)
    (hM : ∀ i ∈ s, 0 ≤ M i)
    (hdelta : ∀ i ∈ s, 0 ≤ V i - ∑ j ∈ s, T i j * V j)
    (hodrift : ∀ i ∈ o, c ≤ V i - ∑ j ∈ s, T i j * V j)
    (hcomp : (∑ i ∈ s \ o, M i) ≤ (∑ i ∈ o, M i) + B) :
    (∑ i ∈ s, M i) ≤ 2 * (∑ i ∈ s, b i * V i) / c + B := by
  have hd := finite_flow_drift_bound s o b M V T c hos hflow hM hdelta hodrift
  have hp : (∑ i ∈ o, M i) ≤ (∑ i ∈ s, b i * V i) / c := by
    apply (le_div_iff₀ hc).2
    simpa only [mul_comm] using hd
  have hsplit : (∑ i ∈ s, M i) = (∑ i ∈ o, M i) + ∑ i ∈ s \ o, M i := by
    simpa only [add_comm] using (Finset.sum_sdiff (f := M) hos).symm
  rw [hsplit]
  calc
    _ ≤ 2 * (∑ i ∈ o, M i) + B := by linarith
    _ ≤ 2 * ((∑ i ∈ s, b i * V i) / c) + B := by linarith
    _ = _ := by ring

end BuildingBlocks.AncestryFlow
