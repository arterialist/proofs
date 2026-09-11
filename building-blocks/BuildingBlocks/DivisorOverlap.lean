import Mathlib.NumberTheory.ArithmeticFunction
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Positivity

/-! Exact divisor overlap for abundancy. These identities use the usual natural
divisor sum and do not assert an analytic bound or the Riemann hypothesis. -/

namespace BuildingBlocks

noncomputable def abundancy (n : ℕ) : ℝ :=
  (ArithmeticFunction.sigma 1 n : ℝ) / (n : ℝ)

theorem abundancy_eq_sum_reciprocal_divisors (n : ℕ) :
    abundancy n = ∑ d ∈ n.divisors, 1 / (d : ℝ) := by
  by_cases hn : n = 0
  · subst n
    simp [abundancy]
  unfold abundancy
  rw [ArithmeticFunction.sigma_eq_sum_div]
  simp only [pow_one, Nat.cast_sum, div_eq_mul_inv, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro d hd
  have hdvd : d ∣ n := (Nat.mem_divisors.mp hd).1
  have hd0 : d ≠ 0 := (Nat.pos_of_mem_divisors hd).ne'
  have hnR : (n : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hn
  have hdR : (d : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hd0
  change ((n / d : ℕ) : ℝ) / (n : ℝ) = 1 / (d : ℝ)
  apply (div_eq_div_iff hnR hdR).mpr
  simpa only [one_mul] using
    (show ((n / d : ℕ) : ℝ) * (d : ℝ) = (n : ℝ) by
      exact_mod_cast Nat.div_mul_cancel hdvd)

theorem abundancy_nonneg (n : ℕ) : 0 ≤ abundancy n := by
  unfold abundancy
  positivity

theorem abundancy_mono_of_dvd {m n : ℕ} (hmn : m ∣ n) (hn : 0 < n) :
    abundancy m ≤ abundancy n := by
  rw [abundancy_eq_sum_reciprocal_divisors, abundancy_eq_sum_reciprocal_divisors]
  exact Finset.sum_le_sum_of_subset_of_nonneg
    (Nat.divisors_subset_of_dvd hn.ne' hmn) (by intros; positivity)

theorem abundancy_mul_eq_gcd_mul_lcm (n m : ℕ) :
    abundancy n * abundancy m = abundancy (Nat.gcd n m) * abundancy (Nat.lcm n m) := by
  have hs : (ArithmeticFunction.sigma 1 n : ℝ) * ArithmeticFunction.sigma 1 m =
      (ArithmeticFunction.sigma 1 (Nat.gcd n m) : ℝ) *
        ArithmeticFunction.sigma 1 (Nat.lcm n m) := by
    exact_mod_cast (show ArithmeticFunction.sigma 1 n * ArithmeticFunction.sigma 1 m =
      ArithmeticFunction.sigma 1 (Nat.gcd n m) *
        ArithmeticFunction.sigma 1 (Nat.lcm n m) by
      rw [mul_comm (ArithmeticFunction.sigma 1 (Nat.gcd n m)),
        ArithmeticFunction.IsMultiplicative.lcm_apply_mul_gcd_apply
          ArithmeticFunction.isMultiplicative_sigma])
  have hd : (n : ℝ) * m = (Nat.gcd n m : ℝ) * Nat.lcm n m := by
    exact_mod_cast (Nat.gcd_mul_lcm n m).symm
  unfold abundancy
  rw [div_mul_div_comm, div_mul_div_comm, hs, hd]

theorem abundancy_successor_overlap_le {n h : ℕ} (_hn : 0 < n) (hh : 0 < h) :
    abundancy n * abundancy (n + h) ≤
      abundancy h * abundancy (Nat.lcm n (n + h)) := by
  rw [abundancy_mul_eq_gcd_mul_lcm]
  apply mul_le_mul_of_nonneg_right _ (abundancy_nonneg _)
  apply abundancy_mono_of_dvd _ hh
  simpa using Nat.gcd_dvd_right n h

end BuildingBlocks


