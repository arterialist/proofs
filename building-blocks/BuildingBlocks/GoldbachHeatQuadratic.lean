import BuildingBlocks.SuccessorFeedbackGamma

/-! Finite signed additive Goldbach energy as a positive heat integral.
The coefficients are unrestricted real numbers; their cross terms are retained. -/

open MeasureTheory Real Set
open scoped BigOperators

namespace BuildingBlocks.GoldbachHeat

noncomputable def finiteHeat (a : ℕ → ℝ) (N : ℕ) (t : ℝ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, a n * exp (-((n : ℝ) * t))

noncomputable def finiteEnergy (a : ℕ → ℝ) (N : ℕ) (s : ℝ) : ℝ :=
  ∑ m ∈ Finset.Icc 1 N, ∑ n ∈ Finset.Icc 1 N,
    a m * a n * (1 / ((m : ℝ) + n)) ^ s

private theorem heatPair_integrable {s : ℝ} (hs : 0 < s) {m n : ℕ}
    (hm : 1 ≤ m) (hn : 1 ≤ n) (a : ℕ → ℝ) :
    IntegrableOn (fun t : ℝ => a m * a n *
      (t ^ (s - 1) * exp (-(((m : ℝ) + n) * t)))) (Ioi 0) := by
  have hr : 0 < (m : ℝ) + n := by exact_mod_cast (by omega : 0 < m + n)
  have hi : IntegrableOn (fun t : ℝ => t ^ (s - 1) * exp (-(((m : ℝ) + n) * t))) (Ioi 0) := by
    simpa only [rpow_one, neg_mul] using
      (integrableOn_rpow_mul_exp_neg_mul_rpow (p := 1) (s := s - 1) (by linarith) le_rfl hr)
  exact hi.const_mul (a m * a n)

theorem finiteHeat_square_expansion (a : ℕ → ℝ) (N : ℕ) (s t : ℝ) :
    t ^ (s - 1) * (finiteHeat a N t) ^ 2 =
      ∑ m ∈ Finset.Icc 1 N, ∑ n ∈ Finset.Icc 1 N,
        a m * a n * (t ^ (s - 1) * exp (-(((m : ℝ) + n) * t))) := by
  rw [pow_two, finiteHeat, Finset.sum_mul_sum]
  simp_rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro m hm
  apply Finset.sum_congr rfl
  intro n hn
  rw [show -(((m : ℝ) + n) * t) = -((m : ℝ) * t) + -((n : ℝ) * t) by ring, exp_add]
  ring

theorem finiteHeat_square_integrable (a : ℕ → ℝ) (N : ℕ) {s : ℝ} (hs : 0 < s) :
    IntegrableOn (fun t : ℝ => t ^ (s - 1) * (finiteHeat a N t) ^ 2) (Ioi 0) := by
  simp_rw [finiteHeat_square_expansion]
  apply integrable_finset_sum
  intro m hm
  apply integrable_finset_sum
  intro n hn
  exact heatPair_integrable hs (Finset.mem_Icc.mp hm).1 (Finset.mem_Icc.mp hn).1 a

/-- Exact positive integral representation on every positive exponent line,
for a literal finite arithmetic cutoff. -/
theorem finiteEnergy_eq_heat_integral (a : ℕ → ℝ) (N : ℕ) {s : ℝ} (hs : 0 < s) :
    Gamma s * finiteEnergy a N s =
      ∫ t in Ioi (0 : ℝ), t ^ (s - 1) * (finiteHeat a N t) ^ 2 := by
  simp_rw [finiteHeat_square_expansion]
  rw [integral_finset_sum]
  · unfold finiteEnergy
    simp_rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro m hm
    rw [integral_finset_sum]
    · apply Finset.sum_congr rfl
      intro n hn
      have hr : 0 < (m : ℝ) + n := by
        have hm' := (Finset.mem_Icc.mp hm).1
        have hn' := (Finset.mem_Icc.mp hn).1
        exact_mod_cast (by omega : 0 < m + n)
      rw [integral_const_mul, integral_rpow_mul_exp_neg_mul_Ioi hs hr]
      ring
    · intro n hn
      exact heatPair_integrable hs (Finset.mem_Icc.mp hm).1 (Finset.mem_Icc.mp hn).1 a
  · intro m hm
    apply integrable_finset_sum
    intro n hn
    exact heatPair_integrable hs (Finset.mem_Icc.mp hm).1 (Finset.mem_Icc.mp hn).1 a

theorem finiteEnergy_nonneg (a : ℕ → ℝ) (N : ℕ) {s : ℝ} (hs : 0 < s) :
    0 ≤ finiteEnergy a N s := by
  have hi : 0 ≤ Gamma s * finiteEnergy a N s := by
    rw [finiteEnergy_eq_heat_integral a N hs]
    apply integral_nonneg_of_ae
    filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
    exact mul_nonneg (rpow_nonneg ht.le _) (sq_nonneg _)
  exact nonneg_of_mul_nonneg_right hi (Gamma_pos_of_pos hs)

noncomputable def centeredCoefficient (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n - 1

@[simp] theorem centeredCoefficient_one : centeredCoefficient 1 = -1 := by
  simp [centeredCoefficient]

theorem centered_finiteEnergy_nonneg (N : ℕ) {s : ℝ} (hs : 0 < s) :
    0 ≤ finiteEnergy centeredCoefficient N s := finiteEnergy_nonneg _ _ hs

/-- The centered arrival at n=1 is retained. -/
theorem centered_finiteHeat_one (t : ℝ) : finiteHeat centeredCoefficient 1 t = -exp (-t) := by
  simp [finiteHeat]

/-- The discrete centering has this exact sum-three coefficient. It differs
from the mixed atomic/continuous source, whose atom at three is −2 log 2. -/
theorem centered_pair_three :
    centeredCoefficient 1 * centeredCoefficient 2 +
      centeredCoefficient 2 * centeredCoefficient 1 = 2 * (1 - log 2) := by
  have h2 : ArithmeticFunction.vonMangoldt 2 = log 2 := ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two
  simp only [centeredCoefficient, ArithmeticFunction.vonMangoldt_apply_one, h2]
  ring

end BuildingBlocks.GoldbachHeat
