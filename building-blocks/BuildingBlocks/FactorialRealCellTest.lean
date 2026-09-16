import BuildingBlocks.FactorialRealCellQuadratic
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Topology.Algebra.Order.Floor

open Real Finset Filter Set
open scoped BigOperators Topology
namespace BuildingBlocks.FactorialRealCellPhase

noncomputable def centeredTest (t x : ℝ) : ℝ :=
  1 - exp (-x * t) - x * (1 - exp (-t))
noncomputable def finiteInverseTest (N : ℕ) (t x : ℝ) : ℝ :=
  ∑ j ∈ Icc 1 N, (ArithmeticFunction.moebius j : ℝ) * centeredTest t (x / j)

theorem centeredTest_one (t : ℝ) : centeredTest t 1 = 0 := by simp [centeredTest]

theorem centeredTest_div_hasDerivAt (j : ℕ) (t x : ℝ) :
    HasDerivAt (fun y => centeredTest t (y / j)) (-scalarPhase (x / j) t / j) x := by
  have hd := (hasDerivAt_id x).div_const (j : ℝ)
  have he := (hd.const_mul (-t)).exp
  have hh := (he.const_sub 1).sub (hd.mul_const (1 - exp (-t)))
  convert hh using 1
  · funext y
    unfold centeredTest
    congr 2
    simp only [id_eq]
    congr 1
    ring
  · unfold scalarPhase
    simp only [id_eq]
    rw [show -t * (x / (j : ℝ)) = -(x / j) * t by ring]
    ring

theorem finiteInverseTest_hasDerivAt (N : ℕ) (t x : ℝ) :
    HasDerivAt (finiteInverseTest N t)
      (∑ j ∈ Icc 1 N, (ArithmeticFunction.moebius j : ℝ) * (-scalarPhase (x / j) t / j)) x := by
  unfold finiteInverseTest
  exact HasDerivAt.fun_sum (fun j _ => (centeredTest_div_hasDerivAt j t x).const_mul _)

theorem finiteInverseTest_floor_hasDerivAt (t x : ℝ) :
    HasDerivAt (finiteInverseTest ⌊x⌋₊ t) (-inverseTestPhase x t) x := by
  convert finiteInverseTest_hasDerivAt ⌊x⌋₊ t x using 1
  unfold inverseTestPhase
  rw [← sum_neg_distrib]
  apply sum_congr rfl
  intro j hj
  ring

noncomputable def movingInverseTest (t x : ℝ) : ℝ := finiteInverseTest ⌊x⌋₊ t x

theorem movingInverseTest_hasDerivAt {t x : ℝ} (hx : 1 ≤ x) (hn : x ≠ (⌊x⌋₊ : ℝ)) :
    HasDerivAt (movingInverseTest t) (-inverseTestPhase x t) x := by
  have hl : (⌊x⌋₊ : ℝ) < x :=
    lt_of_le_of_ne (Nat.floor_le (by linarith : 0 ≤ x)) hn.symm
  have hv : ∀ᶠ y in 𝓝 x, ⌊y⌋₊ = ⌊x⌋₊ := by
    filter_upwards [Ioo_mem_nhds hl (Nat.lt_floor_add_one x)] with y hy
    exact Nat.floor_eq_on_Ico ⌊x⌋₊ y ⟨hy.1.le, hy.2⟩
  apply (finiteInverseTest_floor_hasDerivAt t x).congr_of_eventuallyEq
  filter_upwards [hv] with y hy
  simp only [movingInverseTest, hy]

theorem movingInverseTest_continuousAt {t x : ℝ} (hx : 1 ≤ x) (hn : x ≠ (⌊x⌋₊ : ℝ)) :
    ContinuousAt (movingInverseTest t) x := (movingInverseTest_hasDerivAt hx hn).continuousAt

theorem movingInverseTest_hasDerivWithinAt_right {t x : ℝ} (hx : 1 ≤ x) :
    HasDerivWithinAt (movingInverseTest t) (-inverseTestPhase x t) (Ioi x) x := by
  have hv : ∀ᶠ y in 𝓝[≥] x, ⌊y⌋₊ = ⌊x⌋₊ := by
    filter_upwards [Ico_mem_nhdsGE (Nat.lt_floor_add_one x)] with y hy
    exact Nat.floor_eq_on_Ico ⌊x⌋₊ y
      ⟨(Nat.floor_le (by linarith : 0 ≤ x)).trans hy.1, hy.2⟩
  apply (finiteInverseTest_floor_hasDerivAt t x).hasDerivWithinAt.congr_of_eventuallyEq
  · filter_upwards [hv.filter_mono (nhdsWithin_mono x Ioi_subset_Ici_self)] with y hy
    simp only [movingInverseTest, hy]
  · rfl

theorem finiteInverseTest_entry_match (N : ℕ) (t : ℝ) :
    finiteInverseTest (N + 1) t (N + 1) = finiteInverseTest N t (N + 1) := by
  unfold finiteInverseTest
  symm
  apply sum_subset
  · intro j hj
    have hh := Finset.mem_Icc.mp hj
    exact Finset.mem_Icc.mpr ⟨hh.1, hh.2.trans (Nat.le_succ N)⟩
  · intro j hj hn
    have hh := Finset.mem_Icc.mp hj
    have he : j = N + 1 := by
      have hnot : ¬ j ≤ N := by
        intro h
        exact hn (Finset.mem_Icc.mpr ⟨hh.1, h⟩)
      omega
    subst j
    have hp : (N : ℝ) + 1 ≠ 0 := by positivity
    simp only [Nat.cast_add, Nat.cast_one, div_self hp, centeredTest_one, mul_zero]

#print axioms finiteInverseTest_entry_match
#print axioms movingInverseTest_hasDerivWithinAt_right
#print axioms movingInverseTest_hasDerivAt
#print axioms movingInverseTest_continuousAt
#print axioms centeredTest_one
#print axioms centeredTest_div_hasDerivAt
#print axioms finiteInverseTest_hasDerivAt
#print axioms finiteInverseTest_floor_hasDerivAt
end BuildingBlocks.FactorialRealCellPhase
