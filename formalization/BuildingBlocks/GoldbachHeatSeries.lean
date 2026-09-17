import BuildingBlocks.GoldbachHeatComparison

/-! Positive-time convergence and the exact discrete and continuous density
corrections for the actual centered von Mangoldt heat series. -/

open MeasureTheory Real Set Filter
open scoped BigOperators Topology

namespace BuildingBlocks.GoldbachHeat

theorem centeredCoefficient_abs_le {n : ℕ} (hn : 1 ≤ n) :
    |centeredCoefficient n| ≤ n := by
  have hn' : 0 < (n : ℝ) := by exact_mod_cast (by omega : 0 < n)
  have hΛ := ArithmeticFunction.vonMangoldt_nonneg (n := n)
  have hlog := ArithmeticFunction.vonMangoldt_le_log (n := n)
  have hl := log_le_sub_one_of_pos hn'
  rw [centeredCoefficient, abs_le]
  constructor <;> nlinarith

theorem heatSeries_summable {a : ℕ → ℝ}
    (ha : ∀ n, 1 ≤ n → |a n| ≤ n) {t : ℝ} (ht : 0 < t) :
    Summable (fun n : ℕ => a (n + 1) * exp (-(((n + 1 : ℕ) : ℝ) * t))) := by
  have h := (summable_nat_add_iff 1).2 (summable_pow_mul_exp_neg_nat_mul 1 ht)
  simp only [pow_one] at h
  apply Summable.of_norm_bounded h
  intro n
  rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_of_pos (exp_pos _)]
  simpa only [neg_mul, mul_comm t] using
    mul_le_mul_of_nonneg_right (ha (n + 1) (by omega)) (exp_nonneg (-(((n + 1 : ℕ) : ℝ) * t)))

theorem centeredHeat_summable {t : ℝ} (ht : 0 < t) :
    Summable (fun n : ℕ => centeredCoefficient (n + 1) * exp (-(((n + 1 : ℕ) : ℝ) * t))) :=
  heatSeries_summable (fun _ hn => centeredCoefficient_abs_le hn) ht

theorem primeHeat_summable {t : ℝ} (ht : 0 < t) :
    Summable (fun n : ℕ => ArithmeticFunction.vonMangoldt (n + 1) *
      exp (-(((n + 1 : ℕ) : ℝ) * t))) := by
  apply heatSeries_summable _ ht
  intro n hn
  rw [abs_of_nonneg ArithmeticFunction.vonMangoldt_nonneg]
  have hn' : 0 < (n : ℝ) := by exact_mod_cast (by omega : 0 < n)
  exact (ArithmeticFunction.vonMangoldt_le_log.trans (log_le_sub_one_of_pos hn')).trans (by linarith)

theorem densityHeat_hasSum {t : ℝ} (ht : 0 < t) :
    HasSum (fun n : ℕ => exp (-(((n + 1 : ℕ) : ℝ) * t)))
      (1 / (exp t - 1)) := by
  have h := (hasSum_geometric_of_lt_one (exp_nonneg (-t))
    (exp_lt_one_iff.mpr (by linarith : -t < 0))).mul_left (exp (-t))
  have he : exp (-t) * (1 - exp (-t))⁻¹ = 1 / (exp t - 1) := by
    rw [exp_neg]
    have hp := exp_pos t
    have hgt := (one_lt_exp_iff.mpr ht)
    field_simp
    <;> ring
  rw [he] at h
  convert h using 1
  funext n
  rw [← exp_nat_mul, ← exp_add]
  congr 1
  push_cast
  ring

noncomputable def primeHeat (t : ℝ) : ℝ :=
  ∑' n : ℕ, ArithmeticFunction.vonMangoldt (n + 1) * exp (-(((n + 1 : ℕ) : ℝ) * t))

noncomputable def centeredHeat (t : ℝ) : ℝ :=
  ∑' n : ℕ, centeredCoefficient (n + 1) * exp (-(((n + 1 : ℕ) : ℝ) * t))

theorem centeredHeat_eq_prime_sub_density {t : ℝ} (ht : 0 < t) :
    centeredHeat t = primeHeat t - 1 / (exp t - 1) := by
  unfold centeredHeat primeHeat
  simp only [centeredCoefficient, sub_mul, one_mul]
  rw [tsum_sub (primeHeat_summable ht) (densityHeat_hasSum ht).summable,
    (densityHeat_hasSum ht).tsum_eq]

theorem finiteHeat_tendsto {a : ℕ → ℝ} {t : ℝ}
    (ha : Summable (fun n : ℕ => a (n + 1) * exp (-(((n + 1 : ℕ) : ℝ) * t)))) :
    Tendsto (fun N => finiteHeat a N t) atTop
      (𝓝 (∑' n : ℕ, a (n + 1) * exp (-(((n + 1 : ℕ) : ℝ) * t)))) := by
  have he (N : ℕ) : Finset.Icc 1 N = Finset.Ico 1 (N + 1) := by
    ext n
    simp only [Finset.mem_Icc, Finset.mem_Ico]
    omega
  simpa only [finiteHeat, he, Finset.sum_Ico_eq_sum_range, Nat.add_sub_cancel,
    Nat.add_comm 1] using ha.hasSum.tendsto_sum_nat

theorem centered_finiteHeat_tendsto {t : ℝ} (ht : 0 < t) :
    Tendsto (fun N => finiteHeat centeredCoefficient N t) atTop (𝓝 (centeredHeat t)) :=
  finiteHeat_tendsto (centeredHeat_summable ht)

/-- The continuous density and initial atom are both retained in this source. -/
noncomputable def mixedCenteredHeat (t : ℝ) : ℝ :=
  primeHeat t - (1 + 1 / t) * exp (-t)

theorem mixedCenteredHeat_eq {t : ℝ} (ht : 0 < t) :
    mixedCenteredHeat t = centeredHeat t +
      (1 / (exp t - 1) - (1 + 1 / t) * exp (-t)) := by
  rw [centeredHeat_eq_prime_sub_density ht, mixedCenteredHeat]
  ring

end BuildingBlocks.GoldbachHeat
