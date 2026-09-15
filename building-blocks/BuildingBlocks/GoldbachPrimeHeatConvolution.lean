import BuildingBlocks.GoldbachHeatConvolution

open Real
open scoped BigOperators

namespace BuildingBlocks.GoldbachHeat

theorem prime_heat_antidiagonal (k : ℕ) (t : ℝ) :
    (∑ p ∈ Finset.antidiagonal k,
      (ArithmeticFunction.vonMangoldt (p.1 + 1) * exp (-(((p.1 + 1 : ℕ) : ℝ) * t))) *
      (ArithmeticFunction.vonMangoldt (p.2 + 1) * exp (-(((p.2 + 1 : ℕ) : ℝ) * t)))) =
      shiftedPrimeGoldbach k * exp (-(((k + 2 : ℕ) : ℝ) * t)) := by
  rw [shiftedPrimeGoldbach, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro p hp
  have hk : p.1 + p.2 = k := Finset.mem_antidiagonal.mp hp
  have he : exp (-(((p.1 + 1 : ℕ) : ℝ) * t)) * exp (-(((p.2 + 1 : ℕ) : ℝ) * t)) =
      exp (-(((k + 2 : ℕ) : ℝ) * t)) := by
    rw [← exp_add]
    congr 1
    rw [← hk]
    push_cast
    ring
  calc
    _ = (ArithmeticFunction.vonMangoldt (p.1 + 1) * ArithmeticFunction.vonMangoldt (p.2 + 1)) *
      (exp (-(((p.1 + 1 : ℕ) : ℝ) * t)) * exp (-(((p.2 + 1 : ℕ) : ℝ) * t))) := by ring
    _ = _ := by rw [he]

theorem shiftedPrimeGoldbach_heat_abs_summable {t : ℝ} (ht : 0 < t) :
    Summable (fun k : ℕ => |shiftedPrimeGoldbach k * exp (-(((k + 2 : ℕ) : ℝ) * t))|) := by
  have hh := (primeHeat_summable ht).norm
  simpa only [prime_heat_antidiagonal, Real.norm_eq_abs] using
    summable_norm_sum_mul_antidiagonal_of_summable_norm hh hh

theorem primeHeat_square_eq_goldbach {t : ℝ} (ht : 0 < t) :
    primeHeat t ^ 2 =
      ∑' k : ℕ, shiftedPrimeGoldbach k * exp (-(((k + 2 : ℕ) : ℝ) * t)) := by
  have hh := (primeHeat_summable ht).norm
  rw [pow_two, primeHeat, tsum_mul_tsum_eq_tsum_sum_antidiagonal_of_summable_norm hh hh]
  simp only [prime_heat_antidiagonal]

#print axioms prime_heat_antidiagonal
#print axioms shiftedPrimeGoldbach_heat_abs_summable
#print axioms primeHeat_square_eq_goldbach

end BuildingBlocks.GoldbachHeat
