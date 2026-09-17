import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Ring

namespace BuildingBlocks.MeanZeroKernelGauge

theorem finite_gauge_invariance {ι : Type*} (s : Finset ι) (c : ι → ℝ)
    (hc : ∑ i ∈ s, c i = 0) (k : ι → ι → ℝ) (f g : ι → ℝ) (d : ℝ) :
    (∑ i ∈ s, ∑ j ∈ s, c i * c j * (k i j + f i + g j + d)) =
      ∑ i ∈ s, ∑ j ∈ s, c i * c j * k i j := by
  have he (i j : ι) : c i * c j * (k i j + f i + g j + d) =
      c i * c j * k i j + (c i * f i) * c j + c i * (c j * g j) +
      (c i * d) * c j := by ring
  simp_rw [he, Finset.sum_add_distrib]
  simp only [← Finset.mul_sum, hc, mul_zero, Finset.sum_const_zero,
    ← Finset.sum_mul, zero_mul, add_zero]

noncomputable def neumannKernel (a x y : ℝ) : ℝ :=
  (x ^ 2 + y ^ 2) / (4 * a) - |x - y| / 2 + a / 6

noncomputable def primitiveKernel (a x y : ℝ) : ℝ := a - max x y

theorem neumann_primitive_difference (a x y : ℝ) :
    neumannKernel a x y = primitiveKernel a x y +
      (x ^ 2 / (4 * a) + x / 2) + (y ^ 2 / (4 * a) + y / 2) - 5 * a / 6 := by
  unfold neumannKernel primitiveKernel
  by_cases h : x ≤ y
  · rw [max_eq_right h, abs_of_nonpos (sub_nonpos.mpr h)]
    ring
  · have h' : y ≤ x := le_of_not_ge h
    rw [max_eq_left h', abs_of_nonneg (sub_nonneg.mpr h')]
    ring

theorem finite_neumann_primitive_identity {ι : Type*} (s : Finset ι)
    (c x : ι → ℝ) (hc : ∑ i ∈ s, c i = 0) (a : ℝ) :
    (∑ i ∈ s, ∑ j ∈ s, c i * c j * neumannKernel a (x i) (x j)) =
      ∑ i ∈ s, ∑ j ∈ s, c i * c j * primitiveKernel a (x i) (x j) := by
  simp_rw [neumann_primitive_difference, sub_eq_add_neg]
  exact finite_gauge_invariance s c hc _ _ _ _

#print axioms finite_gauge_invariance
#print axioms neumann_primitive_difference
#print axioms finite_neumann_primitive_identity
end BuildingBlocks.MeanZeroKernelGauge
