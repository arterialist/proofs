import BuildingBlocks.GoldbachHeatSeries
import Mathlib.NumberTheory.LSeries.Dirichlet
import Mathlib.Analysis.Normed.Ring.InfiniteSum

/-! Unconditional absolute convergence of the complete centered additive
energy on its classical half-plane s > 2. -/

open Real
open scoped BigOperators

namespace BuildingBlocks.GoldbachHeat

theorem mangoldt_dirichlet_summable {c : ℝ} (hc : 1 < c) :
    Summable (fun n : ℕ => ArithmeticFunction.vonMangoldt n / (n : ℝ) ^ c) := by
  have hh := (ArithmeticFunction.LSeriesSummable_vonMangoldt (s := (c : ℂ))
    (by simpa using hc)).norm
  apply hh.congr
  intro n
  rw [LSeries.norm_term_eq]
  by_cases hn : n = 0
  · simp [hn]
  · rw [if_neg hn]
    simp only [Complex.ofReal_re, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg ArithmeticFunction.vonMangoldt_nonneg]

theorem centered_dirichlet_abs_summable {c : ℝ} (hc : 1 < c) :
    Summable (fun n : ℕ => |centeredCoefficient (n + 1)| /
      ((n + 1 : ℕ) : ℝ) ^ c) := by
  have hm := (summable_nat_add_iff 1).2 (mangoldt_dirichlet_summable hc)
  have hd := (summable_nat_add_iff 1).2 (summable_one_div_nat_rpow.mpr hc)
  apply (hm.add hd).of_nonneg_of_le (fun n => by positivity)
  intro n
  rw [← add_div]
  apply div_le_div_of_nonneg_right _ (by positivity)
  unfold centeredCoefficient
  calc
    _ ≤ |ArithmeticFunction.vonMangoldt (n + 1)| + |(1 : ℝ)| := abs_sub _ _
    _ = _ := by rw [abs_of_nonneg ArithmeticFunction.vonMangoldt_nonneg]; norm_num

/-- A product majorant retains all pairs. It requires no sign for either coefficient. -/
theorem additive_pair_abs_le {m n : ℝ} (hm : 0 < m) (hn : 0 < n)
    {c : ℝ} (hc : 0 ≤ c) (a b : ℝ) :
    |a * b / (m + n) ^ (2 * c)| ≤ (|a| / m ^ c) * (|b| / n ^ c) := by
  have hmn : 0 < m + n := add_pos hm hn
  have hp : m ^ c * n ^ c ≤ (m + n) ^ (2 * c) := by
    rw [← mul_rpow hm.le hn.le, rpow_mul hmn.le, rpow_two]
    exact rpow_le_rpow (mul_nonneg hm.le hn.le) (by nlinarith [sq_nonneg m, sq_nonneg n]) hc
  rw [abs_div, abs_mul, abs_of_pos (rpow_pos_of_pos hmn _), div_mul_div_comm]
  exact div_le_div_of_nonneg_left (mul_nonneg (abs_nonneg a) (abs_nonneg b))
    (mul_pos (rpow_pos_of_pos hm _) (rpow_pos_of_pos hn _)) hp

noncomputable def centeredPairTerm (s : ℝ) (p : ℕ × ℕ) : ℝ :=
  centeredCoefficient (p.1 + 1) * centeredCoefficient (p.2 + 1) /
    (((p.1 + 1 : ℕ) : ℝ) + ((p.2 + 1 : ℕ) : ℝ)) ^ s

theorem centeredPairTerm_abs_summable {s : ℝ} (hs : 2 < s) :
    Summable (fun p : ℕ × ℕ => |centeredPairTerm s p|) := by
  have hc : 1 < s / 2 := by linarith
  have hh := centered_dirichlet_abs_summable hc
  apply (hh.mul_of_nonneg hh (fun n => by positivity) (fun n => by positivity)).of_nonneg_of_le
    (fun p => abs_nonneg _)
  intro p
  unfold centeredPairTerm
  simpa only [show 2 * (s / 2) = s by ring] using
    additive_pair_abs_le (m := ((p.1 + 1 : ℕ) : ℝ)) (n := ((p.2 + 1 : ℕ) : ℝ))
      (by positivity) (by positivity) (show 0 ≤ s / 2 by linarith)
      (centeredCoefficient (p.1 + 1)) (centeredCoefficient (p.2 + 1))

theorem centeredPairTerm_summable {s : ℝ} (hs : 2 < s) :
    Summable (centeredPairTerm s) := by
  apply Summable.of_norm
  simpa only [Real.norm_eq_abs] using centeredPairTerm_abs_summable hs

end BuildingBlocks.GoldbachHeat
