import BuildingBlocks.FactorialRealCellQuadratic
import Mathlib.Analysis.SpecialFunctions.ExpDeriv

open Real Finset
open scoped BigOperators
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

#print axioms centeredTest_one
#print axioms centeredTest_div_hasDerivAt
#print axioms finiteInverseTest_hasDerivAt
#print axioms finiteInverseTest_floor_hasDerivAt
end BuildingBlocks.FactorialRealCellPhase
