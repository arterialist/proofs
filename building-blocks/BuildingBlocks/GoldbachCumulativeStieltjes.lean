import BuildingBlocks.GoldbachCumulativeAbel
import Mathlib.MeasureTheory.Integral.Bochner.Set
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Topology.Algebra.Order.Floor
import Mathlib.Tactic

/-! Exact continuous Laplace integral of the right-continuous cumulative
ordered Goldbach step function. -/

namespace BuildingBlocks.GoldbachCumulativeStieltjes

open Set Finset MeasureTheory Real intervalIntegral
open BuildingBlocks.GoldbachCumulativeFinite BuildingBlocks.GoldbachCumulativeAbel

noncomputable section

private def cell (n : ℕ) : Set ℝ := Ico (n : ℝ) ((n + 1 : ℕ) : ℝ)

private theorem cells_union : (⋃ n : ℕ, cell n) = Ici (0 : ℝ) := by
  ext x
  simp only [mem_iUnion, cell, Set.mem_Ico, Set.mem_Ici]
  constructor
  · rintro ⟨n, h, _⟩
    exact (Nat.cast_nonneg n).trans h
  · intro hx
    refine ⟨⌊x⌋₊, ?_, ?_⟩
    · exact Nat.floor_le hx
    · simpa only [Nat.cast_add, Nat.cast_one] using Nat.lt_floor_add_one x

private theorem cells_disjoint : Pairwise (fun n m : ℕ => Disjoint (cell n) (cell m)) := by
  intro n m hnm
  apply Set.disjoint_left.mpr
  intro x hn hm
  rcases lt_or_gt_of_ne hnm with h | h
  · have h' : (n : ℝ) + 1 ≤ m := by exact_mod_cast h
    simp only [cell, Set.mem_Ico, Nat.cast_add, Nat.cast_one] at hn hm
    nlinarith [hn.2, hm.1]
  · have h' : (m : ℝ) + 1 ≤ n := by exact_mod_cast h
    simp only [cell, Set.mem_Ico, Nat.cast_add, Nat.cast_one] at hn hm
    nlinarith [hm.2, hn.1]

private theorem floor_cell (n : ℕ) (x : ℝ) (hx : x ∈ cell n) : ⌊x⌋₊ = n := by
  exact Nat.floor_eq_on_Ico n x (by simpa [cell, Nat.cast_add] using hx)

private theorem cell_exp_integral {t : ℝ} (ht : 0 < t) (n : ℕ) :
    t * (∫ x in cell n, Real.exp (-t * x)) =
      Real.exp (-t) ^ n * (1 - Real.exp (-t)) := by
  have hn : (n : ℝ) ≤ ((n + 1 : ℕ) : ℝ) := by exact_mod_cast Nat.le_succ n
  have hne : -t ≠ 0 := by linarith
  have hset : (∫ x in cell n, Real.exp (-t * x)) =
      ∫ x in (n : ℝ)..((n + 1 : ℕ) : ℝ), Real.exp (-t * x) := by
    dsimp [cell]
    rw [← integral_Icc_eq_integral_Ico, integral_Icc_eq_integral_Ioc,
      intervalIntegral.integral_of_le hn]
  rw [hset]
  conv_lhs =>
    arg 2
    rw [show (fun x : ℝ => Real.exp (-t * x)) =
      (fun x : ℝ => Real.exp (x * -t)) by funext x; congr 1; ring]
  rw [intervalIntegral.integral_comp_mul_right Real.exp hne,
    integral_exp]
  simp only [smul_eq_mul]
  have he (k : ℕ) : Real.exp ((k : ℝ) * -t) = Real.exp (-t) ^ k := by
    rw [Real.exp_nat_mul]
  rw [he n, he (n + 1)]
  field_simp
  ring

private theorem goldbachAt_nonneg (n : ℕ) : 0 ≤ goldbachAt n := by
  unfold goldbachAt
  apply sum_nonneg
  intro p hp
  exact mul_nonneg ArithmeticFunction.vonMangoldt_nonneg
    ArithmeticFunction.vonMangoldt_nonneg

private theorem cumulative_nonneg (n : ℕ) : 0 ≤ cumulativeGoldbach n := by
  unfold cumulativeGoldbach
  exact sum_nonneg (fun k _ => goldbachAt_nonneg k)

private theorem weighted_cumulative_summable {q : ℝ} (hq : 0 < q) (hq1 : q < 1) :
    Summable (fun n : ℕ => cumulativeGoldbach n * q ^ n) := by
  have ht : 0 < -Real.log q := by
    have hlog := Real.log_neg hq hq1
    linarith
  have hheat := GoldbachHeat.shiftedPrimeGoldbach_heat_abs_summable ht
  have hexp (k : ℕ) :
      Real.exp (-(((k + 2 : ℕ) : ℝ) * (-Real.log q))) = q ^ (k + 2) := by
    rw [show -(((k + 2 : ℕ) : ℝ) * (-Real.log q)) =
      ((k + 2 : ℕ) : ℝ) * Real.log q by ring]
    rw [Real.exp_nat_mul, Real.exp_log hq]
  have hf : Summable (fun n : ℕ => ‖goldbachAt n * q ^ n‖) := by
    have hshift : Summable (fun k : ℕ => |goldbachAt (k + 2) * q ^ (k + 2)|) := by
      simpa only [goldbachAt_shift, hexp] using hheat
    have hfull := (summable_nat_add_iff
      (f := fun n : ℕ => |goldbachAt n * q ^ n|) 2).1 hshift
    simpa only [Real.norm_eq_abs] using hfull
  have hg : Summable (fun n : ℕ => ‖q ^ n‖) := by
    simpa only [Real.norm_eq_abs, abs_of_nonneg (pow_nonneg hq.le _)] using
      summable_geometric_of_lt_one hq.le hq1
  have hc := summable_norm_sum_mul_range_of_summable_norm hf hg
  have hcoeff (n : ℕ) :
      (∑ k ∈ range (n + 1), (goldbachAt k * q ^ k) * q ^ (n - k)) =
        cumulativeGoldbach n * q ^ n := by
    calc
      _ = ∑ k ∈ range (n + 1), goldbachAt k * q ^ n := by
        apply sum_congr rfl
        intro k hk
        have hkn : k ≤ n := by have := mem_range.mp hk; omega
        rw [mul_assoc, ← pow_add, Nat.add_sub_of_le hkn]
      _ = _ := by rw [← sum_mul]; rfl
  have hn : Summable (fun n : ℕ => ‖cumulativeGoldbach n * q ^ n‖) := by
    simpa only [hcoeff] using hc
  exact hn.of_norm


private def cumulativeIntegrand (t x : ℝ) : ℝ :=
  Real.exp (-t * x) * cumulativeGoldbach ⌊x⌋₊

private theorem cumulativeIntegrand_nonneg (t x : ℝ) :
    0 ≤ cumulativeIntegrand t x := by
  exact mul_nonneg (Real.exp_pos _).le (cumulative_nonneg _)

private theorem cumulative_cell_integrable (t : ℝ) (n : ℕ) :
    IntegrableOn (cumulativeIntegrand t) (cell n) := by
  have hn : (n : ℝ) ≤ ((n + 1 : ℕ) : ℝ) := by exact_mod_cast Nat.le_succ n
  have hEq : EqOn (cumulativeIntegrand t)
      (fun x => Real.exp (-t * x) * cumulativeGoldbach n) (cell n) := by
    intro x hx
    simp [cumulativeIntegrand, floor_cell n x hx]
  have hC : IntegrableOn
      (fun x => Real.exp (-t * x) * cumulativeGoldbach n) (cell n) := by
    dsimp only [cell]
    apply (intervalIntegrable_iff_integrableOn_Ico_of_le hn).1
    apply Continuous.intervalIntegrable
    fun_prop
  exact (integrableOn_congr_fun hEq measurableSet_Ico).2 hC

private theorem cumulative_cell_integral {t : ℝ} (ht : 0 < t) (n : ℕ) :
    t * (∫ x in cell n, cumulativeIntegrand t x) =
      (1 - Real.exp (-t)) *
        (cumulativeGoldbach n * Real.exp (-t) ^ n) := by
  have hcongr :
      (∫ x in cell n, cumulativeIntegrand t x) =
        ∫ x in cell n, Real.exp (-t * x) * cumulativeGoldbach n := by
    apply setIntegral_congr_fun measurableSet_Ico
    intro x hx
    simp [cumulativeIntegrand, floor_cell n x hx]
  rw [hcongr, MeasureTheory.integral_mul_const]
  have he := cell_exp_integral ht n
  calc
    t * ((∫ x in cell n, Real.exp (-t * x)) * cumulativeGoldbach n) =
      (t * (∫ x in cell n, Real.exp (-t * x))) * cumulativeGoldbach n := by ring
    _ = _ := by rw [he]; ring

/-- The literal Stieltjes-step Laplace integral of the complete ordered
Goldbach cumulative count equals the square of the positive prime heat sum.
The value at integer jumps is immaterial to Lebesgue integration. -/
theorem cumulative_stieltjes_heat_square {t : ℝ} (ht : 0 < t) :
    t * (∫ X in Ioi (0 : ℝ),
      Real.exp (-t * X) * cumulativeGoldbach ⌊X⌋₊) =
        GoldbachHeat.primeHeat t ^ 2 := by
  let f := cumulativeIntegrand t
  have hq : 0 < Real.exp (-t) := Real.exp_pos _
  have hq1 : Real.exp (-t) < 1 := Real.exp_lt_one_iff.mpr (by linarith)
  have hnorm : Summable (fun n : ℕ => ∫ x in cell n, ‖f x‖) := by
    have hcell (n : ℕ) :
        (∫ x in cell n, ‖f x‖) =
          ((1 - Real.exp (-t)) / t) *
            (cumulativeGoldbach n * Real.exp (-t) ^ n) := by
      have hfn (x : ℝ) : ‖f x‖ = f x :=
        Real.norm_of_nonneg (cumulativeIntegrand_nonneg t x)
      simp_rw [hfn]
      have h := cumulative_cell_integral ht n
      dsimp only [f]
      calc
        (∫ x in cell n, cumulativeIntegrand t x) =
            ((1 - Real.exp (-t)) *
              (cumulativeGoldbach n * Real.exp (-t) ^ n)) / t :=
          (eq_div_iff (ne_of_gt ht)).2 (by simpa [mul_comm] using h)
        _ = _ := by ring
    simp_rw [hcell]
    exact (weighted_cumulative_summable hq hq1).mul_left _
  have hi : IntegrableOn f (⋃ n : ℕ, cell n) :=
    integrableOn_iUnion_of_summable_integral_norm
      (fun n => cumulative_cell_integrable t n) hnorm
  have hI : (∫ x in Ici (0 : ℝ), f x) =
      ∑' n : ℕ, ∫ x in cell n, f x := by
    rw [← cells_union]
    exact integral_iUnion (fun _ => measurableSet_Ico) cells_disjoint hi
  change t * (∫ X in Ioi (0 : ℝ), f X) = GoldbachHeat.primeHeat t ^ 2
  calc
    t * (∫ X in Ioi (0 : ℝ), f X) =
        t * ∑' n : ℕ, ∫ x in cell n, f x := by
          rw [← integral_Ici_eq_integral_Ioi, hI]
    _ = ∑' n : ℕ, t * (∫ x in cell n, f x) := by rw [tsum_mul_left]
    _ = ∑' n : ℕ, (1 - Real.exp (-t)) *
          (cumulativeGoldbach n * Real.exp (-t) ^ n) := by
            apply tsum_congr
            intro n
            exact cumulative_cell_integral ht n
    _ = (1 - Real.exp (-t)) *
          (∑' n : ℕ, cumulativeGoldbach n * Real.exp (-t) ^ n) := by
            rw [tsum_mul_left]
    _ = GoldbachHeat.primeHeat t ^ 2 := primeHeat_square_eq_cumulative_abel ht

#print axioms cumulative_stieltjes_heat_square

end
end BuildingBlocks.GoldbachCumulativeStieltjes
