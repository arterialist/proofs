import BuildingBlocks.GoldbachHeatIntegral
import BuildingBlocks.CoarsePrimitive

/-! The actual additive Goldbach readout. The index k below denotes the
additive total k+2, so both positive source indices and the initial atom remain. -/

open Real
open scoped BigOperators

namespace BuildingBlocks.GoldbachHeat

noncomputable def shiftedGoldbach (k : ℕ) : ℝ :=
  ∑ p ∈ Finset.antidiagonal k,
    centeredCoefficient (p.1 + 1) * centeredCoefficient (p.2 + 1)

noncomputable def shiftedPrimeGoldbach (k : ℕ) : ℝ :=
  ∑ p ∈ Finset.antidiagonal k,
    ArithmeticFunction.vonMangoldt (p.1 + 1) * ArithmeticFunction.vonMangoldt (p.2 + 1)

/-- Both complete prime-power marginals and the full density count survive centering. -/
theorem shiftedGoldbach_eq_prime_psi (k : ℕ) :
    shiftedGoldbach k = shiftedPrimeGoldbach k - 2 * CoarsePrimitive.psi (k + 1) + (k + 1 : ℕ) := by
  have hfst : (∑ p ∈ Finset.antidiagonal k, ArithmeticFunction.vonMangoldt (p.1 + 1)) =
      CoarsePrimitive.psi (k + 1) := by
    rw [Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk]
    simp only
    symm
    rw [CoarsePrimitive.psi, Finset.sum_range_succ']
    simp
  have hsnd : (∑ p ∈ Finset.antidiagonal k, ArithmeticFunction.vonMangoldt (p.2 + 1)) =
      CoarsePrimitive.psi (k + 1) := by
    simpa only [Prod.fst_swap] using
      (Finset.Nat.sum_antidiagonal_swap (n := k)
        (f := fun p => ArithmeticFunction.vonMangoldt (p.1 + 1))).trans hfst
  unfold shiftedGoldbach shiftedPrimeGoldbach
  simp only [centeredCoefficient, sub_mul, mul_sub, one_mul, mul_one, Finset.sum_sub_distrib]
  rw [hfst, hsnd]
  simp
  ring

theorem heat_antidiagonal (k : ℕ) (t : ℝ) :
    (∑ p ∈ Finset.antidiagonal k,
      (centeredCoefficient (p.1 + 1) * exp (-(((p.1 + 1 : ℕ) : ℝ) * t))) *
      (centeredCoefficient (p.2 + 1) * exp (-(((p.2 + 1 : ℕ) : ℝ) * t)))) =
      shiftedGoldbach k * exp (-(((k + 2 : ℕ) : ℝ) * t)) := by
  rw [shiftedGoldbach, Finset.sum_mul]
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
    _ = (centeredCoefficient (p.1 + 1) * centeredCoefficient (p.2 + 1)) *
      (exp (-(((p.1 + 1 : ℕ) : ℝ) * t)) * exp (-(((p.2 + 1 : ℕ) : ℝ) * t))) := by ring
    _ = _ := by rw [he]

theorem shiftedGoldbach_heat_abs_summable {t : ℝ} (ht : 0 < t) :
    Summable (fun k : ℕ => |shiftedGoldbach k * exp (-(((k + 2 : ℕ) : ℝ) * t))|) := by
  have hh := (centeredHeat_summable ht).norm
  simpa only [heat_antidiagonal, Real.norm_eq_abs] using
    summable_norm_sum_mul_antidiagonal_of_summable_norm hh hh

/-- Full signed additive convolution, justified by absolute positive-time convergence. -/
theorem centeredHeat_square_eq_goldbach {t : ℝ} (ht : 0 < t) :
    centeredHeat t ^ 2 =
      ∑' k : ℕ, shiftedGoldbach k * exp (-(((k + 2 : ℕ) : ℝ) * t)) := by
  have hh := (centeredHeat_summable ht).norm
  rw [pow_two, centeredHeat, tsum_mul_tsum_eq_tsum_sum_antidiagonal_of_summable_norm hh hh]
  simp only [heat_antidiagonal]

@[simp] theorem shiftedGoldbach_zero : shiftedGoldbach 0 = 1 := by
  simp [shiftedGoldbach]

theorem shiftedGoldbach_one : shiftedGoldbach 1 = 2 * (1 - log 2) := by
  have ha : Finset.antidiagonal 1 = {(0, 1), (1, 0)} := by decide
  simpa [shiftedGoldbach, ha, add_comm] using centered_pair_three

end BuildingBlocks.GoldbachHeat
