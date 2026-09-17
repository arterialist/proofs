import Mathlib.MeasureTheory.Constructions.BorelSpace.Metrizable
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Topology.Algebra.InfiniteSum.Order
import Mathlib.Tactic

/-! The literal physical theta series, without an assumed parity identity.
Index zero contributes exactly zero. -/
namespace BuildingBlocks.PhysicalThetaSeries
open Real

noncomputable def term (n : ℕ) (u : ℝ) : ℝ :=
  (4 * π ^ 2 * (n : ℝ) ^ 4 * exp (9 * u / 2) -
    6 * π * (n : ℝ) ^ 2 * exp (5 * u / 2)) *
      exp (-π * (n : ℝ) ^ 2 * exp (2 * u))

noncomputable def phi (u : ℝ) : ℝ := ∑' n : ℕ, term n u

theorem term_zero (u : ℝ) : term 0 u = 0 := by simp [term]

theorem nat_square_ge (n : ℕ) : (n : ℝ) ≤ (n : ℝ) ^ 2 := by
  by_cases hn : n = 0
  · simp [hn]
  · have h : 1 ≤ (n : ℝ) := by exact_mod_cast Nat.one_le_iff_ne_zero.mpr hn
    nlinarith

theorem nat_fourth_ge_square (n : ℕ) : (n : ℝ) ^ 2 ≤ (n : ℝ) ^ 4 := by
  have h := nat_square_ge n
  have hn : 0 ≤ (n : ℝ) := n.cast_nonneg
  by_cases hz : n = 0
  · simp [hz]
  · have h1 : 1 ≤ (n : ℝ) := by exact_mod_cast Nat.one_le_iff_ne_zero.mpr hz
    nlinarith [sq_nonneg ((n : ℝ) ^ 2 - 1)]

theorem term_abs_bound (n : ℕ) (u : ℝ) :
    |term n u| ≤ (4 * π ^ 2 * exp (9 * u / 2) + 6 * π * exp (5 * u / 2)) *
      ((n : ℝ) ^ 4 * exp (-(π * exp (2 * u)) * n)) := by
  have ha : |4 * π ^ 2 * (n : ℝ) ^ 4 * exp (9 * u / 2) -
      6 * π * (n : ℝ) ^ 2 * exp (5 * u / 2)| ≤
      (4 * π ^ 2 * exp (9 * u / 2) + 6 * π * exp (5 * u / 2)) * (n : ℝ) ^ 4 := by
    have hab := abs_sub_le
      (4 * π ^ 2 * (n : ℝ) ^ 4 * exp (9 * u / 2)) 0
      (6 * π * (n : ℝ) ^ 2 * exp (5 * u / 2))
    have hb := mul_le_mul_of_nonneg_left (nat_fourth_ge_square n)
      (show 0 ≤ 6 * π * exp (5 * u / 2) by positivity)
    have h1 : 0 ≤ 4 * π ^ 2 * (n : ℝ) ^ 4 * exp (9 * u / 2) := by positivity
    have h2 : 0 ≤ 6 * π * (n : ℝ) ^ 2 * exp (5 * u / 2) := by positivity
    simp only [sub_zero, zero_sub, abs_neg, abs_of_nonneg h1, abs_of_nonneg h2] at hab
    nlinarith
  have he : exp (-π * (n : ℝ) ^ 2 * exp (2 * u)) ≤
      exp (-(π * exp (2 * u)) * n) := by
    apply exp_le_exp.mpr
    have h := mul_le_mul_of_nonneg_left (nat_square_ge n)
      (show 0 ≤ π * exp (2 * u) by positivity)
    nlinarith
  unfold term
  rw [abs_mul, abs_of_nonneg (exp_nonneg _)]
  have h := mul_le_mul ha he (exp_nonneg _)
    (show 0 ≤ (4 * π ^ 2 * exp (9 * u / 2) + 6 * π * exp (5 * u / 2)) *
      (n : ℝ) ^ 4 by positivity)
  convert h using 1
  ring

theorem term_summable (u : ℝ) : Summable (fun n => term n u) := by
  apply Summable.of_norm_bounded
    ((summable_pow_mul_exp_neg_nat_mul 4
      (show 0 < π * exp (2 * u) by positivity)).mul_left
        (4 * π ^ 2 * exp (9 * u / 2) + 6 * π * exp (5 * u / 2)))
  intro n
  simpa only [Real.norm_eq_abs] using term_abs_bound n u

theorem phi_eq_positive_index (u : ℝ) : phi u = ∑' n : ℕ, term (n + 1) u := by
  unfold phi
  rw [(term_summable u).tsum_eq_zero_add, term_zero, zero_add]

theorem term_factor (n : ℕ) (u : ℝ) :
    term n u = 2 * π * (n : ℝ) ^ 2 * exp (5 * u / 2) *
      (2 * π * (n : ℝ) ^ 2 * exp (2 * u) - 3) *
        exp (-π * (n : ℝ) ^ 2 * exp (2 * u)) := by
  have he : exp (9 * u / 2) = exp (5 * u / 2) * exp (2 * u) := by
    rw [← exp_add]
    congr 1
    ring
  unfold term
  rw [he]
  ring

theorem term_pos {n : ℕ} (hn : 1 ≤ n) {u : ℝ} (hu : 0 ≤ u) : 0 < term n u := by
  have hn1 : 1 ≤ (n : ℝ) := by exact_mod_cast hn
  have hn2 : 1 ≤ (n : ℝ) ^ 2 := by nlinarith
  have he : 1 ≤ exp (2 * u) := by
    rw [← exp_zero]
    exact exp_le_exp.mpr (by linarith)
  have h1 := mul_le_mul_of_nonneg_left hn2 (show 0 ≤ 2 * π by positivity)
  have h2 := mul_le_mul_of_nonneg_left he (show 0 ≤ 2 * π * (n : ℝ) ^ 2 by positivity)
  have hb : 0 < 2 * π * (n : ℝ) ^ 2 * exp (2 * u) - 3 := by
    nlinarith [pi_gt_three]
  rw [term_factor]
  positivity

theorem phi_pos {u : ℝ} (hu : 0 ≤ u) : 0 < phi u := by
  apply (term_summable u).tsum_pos (i := 1)
  · intro n
    by_cases hn : n = 0
    · simp [hn, term_zero]
    · exact (term_pos (Nat.one_le_iff_ne_zero.mpr hn) hu).le
  · exact term_pos (n := 1) (by norm_num) hu

theorem term_continuous (n : ℕ) : Continuous (term n) := by
  unfold term
  fun_prop

theorem phi_measurable : Measurable phi := by
  apply measurable_of_tendsto_metrizable
    (f := fun k u => ∑ n ∈ Finset.range k, term n u)
  · intro k
    exact (continuous_finset_sum _ (fun n hn => term_continuous n)).measurable
  · apply tendsto_pi_nhds.mpr
    intro u
    exact (term_summable u).hasSum.tendsto_sum_nat

#print axioms term_continuous
#print axioms phi_measurable
#print axioms term_zero
#print axioms nat_square_ge
#print axioms nat_fourth_ge_square
#print axioms term_abs_bound
#print axioms term_summable
#print axioms phi_eq_positive_index
#print axioms term_factor
#print axioms term_pos
#print axioms phi_pos
end BuildingBlocks.PhysicalThetaSeries
