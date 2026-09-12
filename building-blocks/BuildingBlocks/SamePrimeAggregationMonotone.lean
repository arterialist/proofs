import BuildingBlocks.SamePrimeAggregationKernel
import BuildingBlocks.ChronologicalDivisibility
import Mathlib.Analysis.Calculus.Deriv.MeanValue
import Mathlib.Analysis.Calculus.Deriv.Inv
import Mathlib.Analysis.SpecialFunctions.ExpDeriv

open scoped BigOperators

namespace BuildingBlocks.SamePrimeAggregationMonotone

open SamePrimeAggregationKernel

/-- The literal floor-sum aggregation in the multiplicative coordinate. -/
noncomputable def H (x : ℝ) : ℝ :=
  A ⌊x⌋₊ / Real.sqrt x - B ⌊x⌋₊ / (x * Real.sqrt x)

/-- A fixed actual integer cell, with its endpoint activation left explicit. -/
noncomputable def cell (k : ℕ) (x : ℝ) : ℝ :=
  (x * A k - B k) / (x * Real.sqrt x)

/-- The floor expression equals the normalized actual chronological tent. -/
theorem H_eq_normalized_tent {x : ℝ} (hx : 0 < x) :
    H x = ChronologicalDivisibility.S x / (x * Real.sqrt x) := by
  rw [ChronologicalDivisibility.S_eq_tent, ChronologicalDivisibility.tent_eq_affine]
  dsimp only [H, A, B]
  field_simp

/-- Closed cells include the next integer because its new tent term is zero. -/
theorem H_eq_cell {k : ℕ} (hk : 1 ≤ k) {x : ℝ}
    (hx : x ∈ Set.Icc (k : ℝ) ((k : ℝ) + 1)) : H x = cell k x := by
  have hx0 : 0 < x := lt_of_lt_of_le (by exact_mod_cast hk) hx.1
  rw [H_eq_normalized_tent hx0, ChronologicalDivisibility.S_eq_affine_of_cell hx.1 hx.2]
  rfl

/-- The actual coefficient controls the derivative inside a fixed positive cell. -/
theorem cell_hasDerivAt (k : ℕ) {x : ℝ} (hx : 0 < x) :
    HasDerivAt (cell k) ((3 * B k - x * A k) / (2 * x ^ 2 * Real.sqrt x)) x := by
  have hs : 0 < Real.sqrt x := Real.sqrt_pos.mpr hx
  have hs2 := Real.sq_sqrt hx.le
  have hn := ((hasDerivAt_id x).mul_const (A k)).sub_const (B k)
  have hd := (hasDerivAt_id x).mul (Real.hasDerivAt_sqrt (ne_of_gt hx))
  have hquot := hn.div hd (show x * Real.sqrt x ≠ 0 by positivity)
  have heq : ((1 * A k) * (x * Real.sqrt x) -
      (x * A k - B k) * (1 * Real.sqrt x + x * (1 / (2 * Real.sqrt x)))) /
      (x * Real.sqrt x) ^ 2 =
      (3 * B k - x * A k) / (2 * x ^ 2 * Real.sqrt x) := by
    field_simp
    rw [hs2]
    ring
  change HasDerivAt (cell k)
    (((1 * A k) * (x * Real.sqrt x) - (x * A k - B k) *
      (1 * Real.sqrt x + x * (1 / (2 * Real.sqrt x)))) /
      (x * Real.sqrt x) ^ 2) x at hquot
  rw [heq] at hquot
  exact hquot

/-- Monotonicity on each entire closed cell. -/
theorem cell_monotoneOn {k : ℕ} (hk : 1 ≤ k) :
    MonotoneOn (cell k) (Set.Icc (k : ℝ) ((k : ℝ) + 1)) := by
  have hk0 : (0 : ℝ) < k := by exact_mod_cast hk
  refine monotoneOn_of_deriv_nonneg (convex_Icc _ _) ?_ ?_ ?_
  · intro x hx
    exact (cell_hasDerivAt k (hk0.trans_le hx.1)).continuousAt.continuousWithinAt
  · intro x hx
    have hm := interior_subset hx
    exact (cell_hasDerivAt k (hk0.trans_le hm.1)).differentiableAt.differentiableWithinAt
  · intro x hx
    have hm := interior_subset hx
    rw [(cell_hasDerivAt k (hk0.trans_le hm.1)).deriv]
    exact div_nonneg (cell_kernel_pos hk hm).le (by positivity)

/-- The exact finite floor sum is monotone past its first activation. -/
theorem H_monotoneOn_Ioi : MonotoneOn H (Set.Ioi 1) := by
  apply ChronologicalDivisibility.monotoneOn_Ioi_of_cells
  intro k hk x y _ hlo hxy hhi
  have hx : x ∈ Set.Icc (k : ℝ) ((k : ℝ) + 1) := ⟨hlo, hxy.trans hhi⟩
  have hy : y ∈ Set.Icc (k : ℝ) ((k : ℝ) + 1) := ⟨hlo.trans hxy, hhi⟩
  rw [H_eq_cell hk hx, H_eq_cell hk hy]
  exact cell_monotoneOn hk hx hy hxy

@[simp] theorem H_one : H 1 = 0 := by
  norm_num [H, A, B, ChronologicalPowerRatio.A, ChronologicalPowerRatio.B]

theorem H_nonneg {x : ℝ} (hx : 1 ≤ x) : 0 ≤ H x := by
  have hx0 : 0 < x := by linarith
  rw [H_eq_normalized_tent hx0]
  exact div_nonneg (ChronologicalDivisibility.S_nonneg hx0.le) (by positivity)

/-- Global monotonicity includes the exact initial endpoint x=1. -/
theorem H_monotoneOn : MonotoneOn H (Set.Ici 1) := by
  intro x hx y hy hxy
  by_cases he : x = 1
  · rw [he, H_one]
    exact H_nonneg hy
  · have hx1 : 1 < x := lt_of_le_of_ne hx (Ne.symm he)
    exact H_monotoneOn_Ioi hx1 (hx1.trans_le hxy) hxy

/-- The same literal aggregation in external log age. -/
noncomputable def h (v : ℝ) : ℝ := H (Real.exp v)

theorem h_monotoneOn : MonotoneOn h (Set.Ici 0) := by
  intro u hu v hv huv
  apply H_monotoneOn
  · exact (Real.one_le_exp_iff).mpr hu
  · exact (Real.one_le_exp_iff).mpr hv
  · exact Real.exp_le_exp.mpr huv

#print axioms H_eq_cell
#print axioms H_monotoneOn
#print axioms h_monotoneOn

end BuildingBlocks.SamePrimeAggregationMonotone
