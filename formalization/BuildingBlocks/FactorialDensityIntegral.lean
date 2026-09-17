import BuildingBlocks.FrullaniIntegral

open Set MeasureTheory Finset
open scoped BigOperators

namespace BuildingBlocks.FactorialDensityIntegral
open FrullaniIntegral

noncomputable def integrand (n m : ℕ) (t : ℝ) : ℝ :=
  (1 - Real.exp (-(n : ℝ) * t)) * (1 - Real.exp (-(m : ℝ) * t)) /
    (t * (Real.exp t - 1))

theorem integrand_step (n m : ℕ) (t : ℝ) (ht : 0 < t) :
    integrand (n + 1) m t = integrand n m t +
      (Real.exp (-((n + 1 : ℕ) : ℝ) * t) -
        Real.exp (-((n + m + 1 : ℕ) : ℝ) * t)) / t := by
  have ht0 : t ≠ 0 := ne_of_gt ht
  have he0 : Real.exp t - 1 ≠ 0 :=
    sub_ne_zero.mpr (ne_of_gt (Real.one_lt_exp_iff.mpr ht))
  have hA : Real.exp (-((n + 1 : ℕ) : ℝ) * t) =
      Real.exp (-(n : ℝ) * t) * Real.exp (-t) := by
    push_cast
    rw [show -((n : ℝ) + 1) * t = -(n : ℝ) * t + -t by ring, Real.exp_add]
  have hAB : Real.exp (-((n + m + 1 : ℕ) : ℝ) * t) =
      Real.exp (-((n + 1 : ℕ) : ℝ) * t) * Real.exp (-(m : ℝ) * t) := by
    push_cast
    rw [show -((n : ℝ) + (m : ℝ) + 1) * t =
      -((n : ℝ) + 1) * t + -(m : ℝ) * t by ring, Real.exp_add]
  unfold integrand
  rw [hAB, hA, Real.exp_neg]
  field_simp
  ring

theorem factorial_density_integrable (n m : ℕ) : IntegrableOn (integrand n m) (Ioi 0) := by
  induction n with
  | zero =>
    have hz : integrand 0 m = (fun _ : ℝ => (0 : ℝ)) := by
      funext t
      simp [integrand]
    rw [hz]
    exact integrable_zero _ _ _
  | succ n ih =>
    have hf := frullani_integrable ((n + 1 : ℕ) : ℝ) ((n + m + 1 : ℕ) : ℝ)
      (by positivity) (by positivity)
    apply (ih.add hf).congr
    filter_upwards [self_mem_ae_restrict measurableSet_Ioi] with t ht
    exact (integrand_step n m t ht).symm

theorem factorial_density_integral (n m : ℕ) :
    (∫ t in Ioi 0, integrand n m t) =
      ∑ k ∈ range n, Real.log (((k + m + 1 : ℕ) : ℝ) / ((k + 1 : ℕ) : ℝ)) := by
  induction n with
  | zero => simp [integrand]
  | succ n ih =>
    have hf := frullani_integrable ((n + 1 : ℕ) : ℝ) ((n + m + 1 : ℕ) : ℝ)
      (by positivity) (by positivity)
    have he : (∫ t in Ioi 0, integrand (n + 1) m t) =
        ∫ t in Ioi 0, integrand n m t +
          (Real.exp (-((n + 1 : ℕ) : ℝ) * t) -
            Real.exp (-((n + m + 1 : ℕ) : ℝ) * t)) / t := by
      apply integral_congr_ae
      filter_upwards [self_mem_ae_restrict measurableSet_Ioi] with t ht
      exact integrand_step n m t ht
    rw [he, integral_add (factorial_density_integrable n m) hf, ih,
      frullani _ _ (by positivity) (by positivity), sum_range_succ]

theorem log_sum_factorials (n m : ℕ) :
    (∑ k ∈ range n, Real.log (((k + m + 1 : ℕ) : ℝ) / ((k + 1 : ℕ) : ℝ))) =
      Real.log ((n + m).factorial : ℝ) - Real.log (n.factorial : ℝ) - Real.log (m.factorial : ℝ) := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [sum_range_succ, ih,
      Real.log_div (by positivity) (by positivity),
      show n + 1 + m = n + m + 1 by omega,
      Nat.factorial_succ (n + m), Nat.factorial_succ n]
    push_cast
    rw [Real.log_mul (by positivity) (by exact_mod_cast Nat.factorial_ne_zero (n + m)),
      Real.log_mul (by positivity) (by exact_mod_cast Nat.factorial_ne_zero n)]
    ring

theorem factorial_density_log_choose (n m : ℕ) :
    (∫ t in Ioi 0, integrand n m t) = Real.log ((n + m).choose n : ℝ) := by
  rw [factorial_density_integral, log_sum_factorials]
  have hn : (n.factorial : ℝ) ≠ 0 := by exact_mod_cast Nat.factorial_ne_zero n
  have hm : (m.factorial : ℝ) ≠ 0 := by exact_mod_cast Nat.factorial_ne_zero m
  have hc : ((n + m).choose n : ℝ) ≠ 0 := by
    exact_mod_cast (Nat.ne_of_gt (Nat.choose_pos (by omega : n ≤ n + m)))
  have hnat : (n + m).choose n * m.factorial * n.factorial = (n + m).factorial := by
    simpa only [Nat.add_comm] using Nat.add_choose_mul_factorial_mul_factorial m n
  have he := congrArg (fun a : ℕ => (a : ℝ)) hnat
  push_cast at he
  have hl := congrArg Real.log he
  rw [Real.log_mul (mul_ne_zero hc hm) hn, Real.log_mul hc hm] at hl
  linarith

#print axioms integrand_step
#print axioms factorial_density_integrable
#print axioms factorial_density_integral
#print axioms log_sum_factorials
#print axioms factorial_density_log_choose

end BuildingBlocks.FactorialDensityIntegral
