import Mathlib

/-!
# Exact centering of a finite product-divisor kernel

The fourfold completion of the canonical high Möbius Gram block produces a
finite product-indexed kernel.  When that kernel has zero row and column
sums, subtracting arbitrary constants from both coefficient families leaves
the bilinear pairing unchanged.  This file records only that finite algebra.
-/

namespace BuildingBlocks.ActualMobiusProductDivisorCentering

open scoped BigOperators

variable {ι κ R : Type*} [CommRing R]

/-- A finite bilinear pairing against a two-variable kernel. -/
def kernelPairing (S : Finset ι) (T : Finset κ)
    (K : ι → κ → R) (a : ι → R) (b : κ → R) : R :=
  ∑ i ∈ S, ∑ j ∈ T, a i * b j * K i j

/-- A zero-row kernel kills every constant right coefficient. -/
theorem kernelPairing_const_right_eq_zero
    (S : Finset ι) (T : Finset κ) (K : ι → κ → R)
    (a : ι → R) (c : R)
    (hrow : ∀ i ∈ S, ∑ j ∈ T, K i j = 0) :
    kernelPairing S T K a (fun _ => c) = 0 := by
  unfold kernelPairing
  apply Finset.sum_eq_zero
  intro i hi
  rw [← Finset.mul_sum]
  simp [hrow i hi]

/-- A zero-column kernel kills every constant left coefficient. -/
theorem kernelPairing_const_left_eq_zero
    (S : Finset ι) (T : Finset κ) (K : ι → κ → R)
    (b : κ → R) (c : R)
    (hcol : ∀ j ∈ T, ∑ i ∈ S, K i j = 0) :
    kernelPairing S T K (fun _ => c) b = 0 := by
  unfold kernelPairing
  rw [Finset.sum_comm]
  apply Finset.sum_eq_zero
  intro j hj
  rw [← Finset.mul_sum]
  simp [hcol j hj]

/-- If every row and column sum of a finite kernel vanishes, subtracting
arbitrary constants from both coefficient families preserves its pairing. -/
theorem kernelPairing_centered
    (S : Finset ι) (T : Finset κ) (K : ι → κ → R)
    (a : ι → R) (b : κ → R) (ca cb : R)
    (hrow : ∀ i ∈ S, ∑ j ∈ T, K i j = 0)
    (hcol : ∀ j ∈ T, ∑ i ∈ S, K i j = 0) :
    kernelPairing S T K a b =
      kernelPairing S T K (fun i => a i - ca) (fun j => b j - cb) := by
  unfold kernelPairing
  have hr :
      (∑ i ∈ S, ∑ j ∈ T, a i * cb * K i j) = 0 := by
    apply Finset.sum_eq_zero
    intro i hi
    rw [← Finset.mul_sum]
    simp [hrow i hi]
  have hc :
      (∑ i ∈ S, ∑ j ∈ T, ca * b j * K i j) = 0 := by
    rw [Finset.sum_comm]
    apply Finset.sum_eq_zero
    intro j hj
    rw [← Finset.mul_sum]
    simp [hcol j hj]
  have hrc :
      (∑ i ∈ S, ∑ j ∈ T, ca * cb * K i j) = 0 := by
    apply Finset.sum_eq_zero
    intro i hi
    rw [← Finset.mul_sum]
    simp [hrow i hi]
  simp_rw [sub_mul, mul_sub, Finset.sum_sub_distrib]
  simp_rw [sub_mul, Finset.sum_sub_distrib]
  linear_combination hr + hc - hrc

end BuildingBlocks.ActualMobiusProductDivisorCentering

#print axioms BuildingBlocks.ActualMobiusProductDivisorCentering.kernelPairing_const_right_eq_zero
#print axioms BuildingBlocks.ActualMobiusProductDivisorCentering.kernelPairing_const_left_eq_zero
#print axioms BuildingBlocks.ActualMobiusProductDivisorCentering.kernelPairing_centered
