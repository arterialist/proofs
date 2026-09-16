import BuildingBlocks.AdditivePairBalance
import BuildingBlocks.GoldbachHeatConvolution
import Mathlib.Tactic

/-! The complete centered Goldbach row has an exact total/imbalance
decomposition in the original maximum kernel. The finite cutoff keeps both
positive endpoints and every von Mangoldt prime power. -/

namespace BuildingBlocks.GoldbachTotalImbalanceFinite

open Finset BuildingBlocks.AdditivePairBalance BuildingBlocks.GoldbachHeat

noncomputable section

/-- Ordered positive source pairs at total `k`, with both entries at most `N`. -/
def rowIndices (N k : ℕ) : Finset (ℕ × ℕ) :=
  (antidiagonal k).filter fun p => 1 ≤ p.1 ∧ p.1 ≤ N ∧ 1 ≤ p.2 ∧ p.2 ≤ N

/-- The centered additive row, including the atom at one and all prime powers. -/
def rowMass (N k : ℕ) : ℝ :=
  ∑ p ∈ rowIndices N k, centeredCoefficient p.1 * centeredCoefficient p.2

/-- The same row tested by the original physical maximum kernel. -/
def rowPhysical (N k : ℕ) : ℝ :=
  ∑ p ∈ rowIndices N k,
    centeredCoefficient p.1 * centeredCoefficient p.2 * physical p.1 p.2

/-- The same row tested by the additive total kernel. -/
def rowAdditive (N k : ℕ) : ℝ :=
  ∑ p ∈ rowIndices N k,
    centeredCoefficient p.1 * centeredCoefficient p.2 * additive p.1 p.2

/-- The signed imbalance correction; positivity of its pointwise kernel does
not give a sign for this centered row. -/
def rowImbalance (N k : ℕ) : ℝ :=
  ∑ p ∈ rowIndices N k,
    centeredCoefficient p.1 * centeredCoefficient p.2 * balance p.1 p.2

theorem row_physical_decomposition (N k : ℕ) :
    rowPhysical N k = 2 * rowAdditive N k - rowImbalance N k := by
  unfold rowPhysical rowAdditive rowImbalance
  rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro p hp
  have hpos := (Finset.mem_filter.mp hp).2
  have hp1 : (0 : ℝ) < p.1 := by exact_mod_cast hpos.1
  have hp2 : (0 : ℝ) < p.2 := by exact_mod_cast hpos.2.2.1
  rw [kernel_identity hp1 hp2]
  ring

theorem row_additive_eq_mass_div (N k : ℕ) :
    rowAdditive N k = rowMass N k / (k : ℝ) := by
  unfold rowAdditive rowMass
  rw [Finset.sum_div]
  apply Finset.sum_congr rfl
  intro p hp
  have hsum : p.1 + p.2 = k := Finset.mem_antidiagonal.mp (Finset.mem_filter.mp hp).1
  simp [additive, ← Nat.cast_add, hsum, div_eq_mul_inv]

/-- The finite centered Goldbach row in the original metric splits into the
additive total and an exact signed imbalance correction. -/
theorem row_physical_eq_total_sub_imbalance (N k : ℕ) :
    rowPhysical N k = 2 * rowMass N k / (k : ℝ) - rowImbalance N k := by
  rw [row_physical_decomposition, row_additive_eq_mass_div]
  ring

#print axioms row_physical_eq_total_sub_imbalance

end
end BuildingBlocks.GoldbachTotalImbalanceFinite
