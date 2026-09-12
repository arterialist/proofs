import Mathlib.NumberTheory.Harmonic.EulerMascheroni
import Mathlib.Tactic.IntervalCases
import Mathlib.Tactic.Ring

namespace BuildingBlocks

/-- The complete factorial deficit in the integer dyadic divisor average. -/
noncomputable def dyadicFactorialDeficit (n : ℕ) : ℝ :=
  (n : ℝ) * (harmonic n : ℝ) -
    Real.log (((2 * n).factorial : ℝ) / (n.factorial : ℝ))

theorem harmonic_gt_log_half_shift {n : ℕ} (hn : 1 ≤ n) :
    (1 : ℝ) / 2 + Real.log ((n : ℝ) + 1 / 2) < (harmonic n : ℝ) := by
  by_cases h6 : 6 ≤ n
  · have h := Real.one_half_lt_eulerMascheroniSeq_six.trans_le
      (Real.strictMono_eulerMascheroniSeq.monotone h6)
    have hl : Real.log ((n : ℝ) + 1 / 2) < Real.log ((n : ℝ) + 1) :=
      Real.strictMonoOn_log (by change (0 : ℝ) < _; positivity)
        (by change (0 : ℝ) < _; positivity) (by linarith)
    simp only [Real.eulerMascheroniSeq] at h
    linarith
  · have hn5 : n ≤ 5 := by omega
    interval_cases n <;> norm_num at hn ⊢
    all_goals
      rw [← lt_sub_iff_add_lt', Real.log_lt_iff_lt_exp (by positivity)]
      apply lt_of_lt_of_le _ (Real.sum_le_exp_of_nonneg (by norm_num) 7)
      simp_rw [Finset.sum_range_succ, Nat.factorial_succ]
      norm_num

private theorem log_factorial_succ (n : ℕ) :
    Real.log ((n + 1).factorial : ℝ) =
      Real.log (n.factorial : ℝ) + Real.log ((n : ℝ) + 1) := by
  rw [Nat.factorial_succ, Nat.cast_mul, Real.log_mul (by positivity) (by positivity)]
  push_cast
  ring

/-- The exact increment of the complete integer dyadic factorial deficit. -/
theorem dyadicFactorialDeficit_succ (n : ℕ) :
    dyadicFactorialDeficit (n + 1) - dyadicFactorialDeficit n =
      (harmonic n : ℝ) + 1 - Real.log (4 * (n : ℝ) + 2) := by
  have hfac : Real.log ((2 * (n + 1)).factorial : ℝ) =
      Real.log ((2 * n).factorial : ℝ) +
        Real.log (2 * (n : ℝ) + 1) + Real.log (2 * (n : ℝ) + 2) := by
    rw [show 2 * (n + 1) = (2 * n + 1) + 1 by omega,
      log_factorial_succ, log_factorial_succ]
    push_cast
    ring
  have hl2 : Real.log (2 * (n : ℝ) + 2) =
      Real.log 2 + Real.log ((n : ℝ) + 1) := by
    rw [show 2 * (n : ℝ) + 2 = 2 * ((n : ℝ) + 1) by ring,
      Real.log_mul (by norm_num) (by positivity)]
  have hl4 : Real.log (4 * (n : ℝ) + 2) =
      Real.log 2 + Real.log (2 * (n : ℝ) + 1) := by
    rw [show 4 * (n : ℝ) + 2 = 2 * (2 * (n : ℝ) + 1) by ring,
      Real.log_mul (by norm_num) (by positivity)]
  simp only [dyadicFactorialDeficit,
    Real.log_div (by positivity : ((2 * (n + 1)).factorial : ℝ) ≠ 0)
      (by positivity : ((n + 1).factorial : ℝ) ≠ 0),
    Real.log_div (by positivity : ((2 * n).factorial : ℝ) ≠ 0)
      (by positivity : (n.factorial : ℝ) ≠ 0),
    hfac, log_factorial_succ, hl2, hl4, harmonic_succ]
  push_cast
  field_simp
  ring

theorem dyadicFactorialDeficit_increment_gt {n : ℕ} (hn : 1 ≤ n) :
    (3 : ℝ) / 2 - Real.log 4 <
      dyadicFactorialDeficit (n + 1) - dyadicFactorialDeficit n := by
  rw [dyadicFactorialDeficit_succ]
  have h := harmonic_gt_log_half_shift hn
  have hl : Real.log (4 * (n : ℝ) + 2) =
      Real.log 4 + Real.log ((n : ℝ) + 1 / 2) := by
    rw [show 4 * (n : ℝ) + 2 = 4 * ((n : ℝ) + 1 / 2) by ring,
      Real.log_mul (by norm_num) (by positivity)]
  rw [hl]
  linarith

/-- The strict finite factorial inequality giving the negative dyadic divisor average. -/
theorem dyadicFactorialDeficit_gt {n : ℕ} (hn : 1 ≤ n) :
    (n : ℝ) * (3 / 2 - Real.log 4) < dyadicFactorialDeficit n := by
  induction n, hn using Nat.le_induction with
  | base =>
      have hl4 : Real.log (4 : ℝ) = 2 * Real.log 2 := by
        rw [show (4 : ℝ) = 2 * 2 by norm_num,
          Real.log_mul (by norm_num) (by norm_num)]
        ring
      have hlog := Real.log_two_gt_d9
      norm_num [dyadicFactorialDeficit, hl4]
      linarith
  | succ n hn ih =>
      have h := dyadicFactorialDeficit_increment_gt hn
      push_cast
      nlinarith

theorem dyadicFactorial_margin_pos : (0 : ℝ) < 3 / 2 - Real.log 4 := by
  have hlog := Real.log_two_lt_d9
  have hl4 : Real.log (4 : ℝ) = 2 * Real.log 2 := by
    rw [show (4 : ℝ) = 2 * 2 by norm_num,
      Real.log_mul (by norm_num) (by norm_num)]
    ring
  rw [hl4]
  linarith

/-- The uniformly negative normalized factorial expression from the actual divisor average. -/
theorem dyadicFactorial_average_lt {n : ℕ} (hn : 1 ≤ n) :
    Real.log (((2 * n).factorial : ℝ) / (n.factorial : ℝ)) / (n : ℝ) -
      (harmonic n : ℝ) < Real.log 4 - 3 / 2 := by
  have h := dyadicFactorialDeficit_gt hn
  have hnpos : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  unfold dyadicFactorialDeficit at h
  apply (mul_lt_mul_right hnpos).mp
  rw [sub_mul, div_mul_cancel₀ _ (ne_of_gt hnpos)]
  nlinarith

theorem dyadicFactorial_average_neg {n : ℕ} (hn : 1 ≤ n) :
    Real.log (((2 * n).factorial : ℝ) / (n.factorial : ℝ)) / (n : ℝ) -
      (harmonic n : ℝ) < 0 := by
  have h := dyadicFactorial_average_lt hn
  have hmargin := dyadicFactorial_margin_pos
  linarith

end BuildingBlocks
