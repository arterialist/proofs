import BuildingBlocks.FactorialRealCellQuadratic
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Topology.Algebra.Order.Floor
import Mathlib.MeasureTheory.Function.Floor
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus

open Real Finset Filter Set MeasureTheory
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

theorem movingInverseTest_continuousAt_entry (N : ℕ) (t : ℝ) :
    ContinuousAt (movingInverseTest t) (N + 1) := by
  have hv : ∀ᶠ y in 𝓝[<] ((N : ℝ) + 1), ⌊y⌋₊ = N := by
    filter_upwards [Ioo_mem_nhdsLT (show (N : ℝ) < N + 1 by linarith)] with y hy
    exact Nat.floor_eq_on_Ico N y ⟨hy.1.le, hy.2⟩
  have he : movingInverseTest t ((N : ℝ) + 1) = finiteInverseTest N t (N + 1) := by
    have hc : (N : ℝ) + 1 = ((N + 1 : ℕ) : ℝ) := by simp
    rw [hc]
    unfold movingInverseTest
    rw [Nat.floor_natCast]
    simpa only [Nat.cast_add, Nat.cast_one] using finiteInverseTest_entry_match N t
  apply continuousAt_iff_continuous_left'_right'.mpr
  constructor
  · apply (finiteInverseTest_hasDerivAt N t (N + 1)).continuousAt.continuousWithinAt.congr_of_eventuallyEq
    · filter_upwards [hv] with y hy
      simp only [movingInverseTest, hy]
    · exact he
  · exact (movingInverseTest_hasDerivWithinAt_right (by have := Nat.cast_nonneg (α := ℝ) N; linarith : (1 : ℝ) ≤ N + 1)).continuousWithinAt

theorem movingInverseTest_continuousOn (t : ℝ) :
    ContinuousOn (movingInverseTest t) (Set.Ici 1) := by
  intro x hx
  by_cases hn : x = (⌊x⌋₊ : ℝ)
  · have hp : 1 ≤ ⌊x⌋₊ := (Nat.le_floor_iff (by linarith : 0 ≤ x)).mpr (by simpa using hx)
    obtain ⟨N, hN⟩ := Nat.exists_eq_succ_of_ne_zero (by omega : ⌊x⌋₊ ≠ 0)
    have he : x = (N : ℝ) + 1 := by simpa [hN] using hn
    rw [he]
    exact (movingInverseTest_continuousAt_entry N t).continuousWithinAt
  · exact (movingInverseTest_continuousAt hx hn).continuousWithinAt

theorem inverseTestPhase_measurable (t : ℝ) : Measurable (fun x => inverseTestPhase x t) := by
  have hm : Measurable (fun p : ℝ × ℕ =>
      ∑ j ∈ Finset.Icc 1 p.2, (ArithmeticFunction.moebius j : ℝ) / j * scalarPhase (p.1 / j) t) := by
    apply measurable_from_prod_countable_left
    intro N
    change Measurable (fun x : ℝ => ∑ j ∈ Finset.Icc 1 N,
      (ArithmeticFunction.moebius j : ℝ) / j * scalarPhase (x / j) t)
    apply Finset.measurable_sum
    intro j hj
    unfold scalarPhase
    exact (measurable_const.sub
      (((measurable_id.div_const (j : ℝ)).neg.mul_const t).exp.const_mul t)).const_mul _
  have hp : Measurable (fun x : ℝ => (x, ⌊x⌋₊)) :=
    measurable_id.prodMk (Nat.measurable_floor (R := ℝ))
  unfold inverseTestPhase
  simpa only [Function.comp_def] using hm.comp hp

theorem inverseTestPhase_norm_le {t x : ℝ} (ht : 0 < t) (hx : 1 ≤ x) :
    ‖inverseTestPhase x t‖ ≤
      ∑ j ∈ Finset.Icc 1 ⌊x⌋₊, |(ArithmeticFunction.moebius j : ℝ) / j| := by
  unfold inverseTestPhase
  apply (norm_sum_le _ _).trans
  apply sum_le_sum
  intro j hj
  have hh := Finset.mem_Icc.mp hj
  have hjp : (0 : ℝ) < j := by exact_mod_cast (by omega : 0 < j)
  have hjf : (j : ℝ) ≤ (⌊x⌋₊ : ℝ) := by exact_mod_cast hh.2
  have hjx : (j : ℝ) ≤ x := hjf.trans (Nat.floor_le (by linarith : 0 ≤ x))
  have ha : 1 ≤ x / j := (le_div_iff₀ hjp).mpr (by simpa using hjx)
  have hp := scalarPhase_pos ha ht
  have hu : scalarPhase (x / j) t ≤ 1 := by linarith [scalarPhase_lt_unit (a := x / j) ht, exp_pos (-t)]
  rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_of_pos hp]
  exact mul_le_of_le_one_right (abs_nonneg _) hu

theorem inverseTestPhase_intervalIntegrable {t X : ℝ} (ht : 0 < t) (hX : 1 ≤ X) :
    IntervalIntegrable (fun x => inverseTestPhase x t) volume 1 X := by
  apply (intervalIntegrable_const (c :=
    ∑ j ∈ Finset.Icc 1 ⌊X⌋₊, |(ArithmeticFunction.moebius j : ℝ) / j|)).mono_fun'
    (inverseTestPhase_measurable t).aestronglyMeasurable
  filter_upwards [ae_restrict_mem measurableSet_uIoc] with x hx
  have hh : 1 < x ∧ x ≤ X := by simpa [uIoc_of_le hX] using hx
  apply (inverseTestPhase_norm_le ht hh.1.le).trans
  apply sum_le_sum_of_subset_of_nonneg
  · intro j hj
    have hjj := Finset.mem_Icc.mp hj
    exact Finset.mem_Icc.mpr ⟨hjj.1, hjj.2.trans (Nat.floor_mono hh.2)⟩
  · intro j _ _
    exact abs_nonneg _

theorem movingInverseTest_integral {t X : ℝ} (ht : 0 < t) (hX : 1 ≤ X) :
    (∫ x in (1 : ℝ)..X, -inverseTestPhase x t) = movingInverseTest t X - movingInverseTest t 1 := by
  apply intervalIntegral.integral_eq_sub_of_hasDeriv_right_of_le hX
    ((movingInverseTest_continuousOn t).mono (fun x hx => hx.1))
  · intro x hx
    exact movingInverseTest_hasDerivWithinAt_right hx.1.le
  · exact (inverseTestPhase_intervalIntegrable ht hX).neg

theorem movingInverseTest_one (t : ℝ) : movingInverseTest t 1 = 0 := by
  simp [movingInverseTest, finiteInverseTest, centeredTest_one]

theorem movingInverseTest_integral_from_one {t X : ℝ} (ht : 0 < t) (hX : 1 ≤ X) :
    (∫ x in (1 : ℝ)..X, -inverseTestPhase x t) = movingInverseTest t X := by
  rw [movingInverseTest_integral ht hX, movingInverseTest_one, sub_zero]

#print axioms movingInverseTest_integral_from_one
#print axioms movingInverseTest_one
#print axioms movingInverseTest_integral
#print axioms inverseTestPhase_intervalIntegrable
#print axioms inverseTestPhase_norm_le
#print axioms inverseTestPhase_measurable
#print axioms movingInverseTest_continuousOn
#print axioms movingInverseTest_continuousAt_entry
#print axioms finiteInverseTest_entry_match
#print axioms movingInverseTest_hasDerivWithinAt_right
#print axioms movingInverseTest_hasDerivAt
#print axioms movingInverseTest_continuousAt
#print axioms centeredTest_one
#print axioms centeredTest_div_hasDerivAt
#print axioms finiteInverseTest_hasDerivAt
#print axioms finiteInverseTest_floor_hasDerivAt
end BuildingBlocks.FactorialRealCellPhase
