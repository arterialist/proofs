import BuildingBlocks.SelbergIdentity

open scoped BigOperators

namespace BuildingBlocks

open CoarsePrimitive HyperbolaProduct

/-- The actual weighted second von Mangoldt identity, reindexed by all
positive factor pairs with product at most `N`. -/
theorem selbergWeight_weighted_moebius (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N, w n * selbergWeight n) =
      ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
        ∑ q ∈ Finset.Icc 1 (N / d), w (d * q) * Real.log (q : ℝ) ^ 2 := by
  have hpoint (n : ℕ) : w n * selbergWeight n =
      ∑ d ∈ n.divisors, (ArithmeticFunction.moebius d : ℝ) *
        (w (d * (n / d)) * Real.log (n / d : ℕ) ^ 2) := by
    rw [selbergWeight_moebius_formula, Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro d hd
    rw [Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1]
    ring
  simp_rw [hpoint]
  rw [sum_divisors_eq_sum_factor_pairs N
    (fun d q => (ArithmeticFunction.moebius d : ℝ) *
      (w (d * q) * Real.log (q : ℝ) ^ 2))]
  simp only [Finset.mul_sum]

/-- The same actual weighted source, with its prime-power logarithmic term
and its complete ordered divisor-convolution term both retained. -/
theorem selbergWeight_weighted_vonMangoldt (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N, w n * selbergWeight n) =
      (∑ n ∈ Finset.Icc 1 N,
        w n * ArithmeticFunction.vonMangoldt n * Real.log (n : ℝ)) +
      ∑ a ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt a *
        ∑ b ∈ Finset.Icc 1 (N / a), w (a * b) * ArithmeticFunction.vonMangoldt b := by
  have hpoint (n : ℕ) : w n * selbergWeight n =
      w n * ArithmeticFunction.vonMangoldt n * Real.log (n : ℝ) +
      ∑ d ∈ n.divisors, ArithmeticFunction.vonMangoldt d *
        (w (d * (n / d)) * ArithmeticFunction.vonMangoldt (n / d)) := by
    rw [selbergWeight_apply, mul_add]
    congr 1
    · ring
    · rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro d hd
      rw [Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1]
      ring
  simp_rw [hpoint]
  rw [Finset.sum_add_distrib, sum_divisors_eq_sum_factor_pairs N
    (fun a b => ArithmeticFunction.vonMangoldt a *
      (w (a * b) * ArithmeticFunction.vonMangoldt b))]
  simp only [Finset.mul_sum]

/-- Exact finite Selberg readout for an arbitrary real weight. -/
theorem selberg_weighted_identity (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N,
      w n * ArithmeticFunction.vonMangoldt n * Real.log (n : ℝ)) +
      (∑ a ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt a *
        ∑ b ∈ Finset.Icc 1 (N / a), w (a * b) * ArithmeticFunction.vonMangoldt b) =
      ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
        ∑ q ∈ Finset.Icc 1 (N / d), w (d * q) * Real.log (q : ℝ) ^ 2 := by
  rw [← selbergWeight_weighted_vonMangoldt, selbergWeight_weighted_moebius]

/-- Integer tent specialization. Every factor pair with product `N` is
included and has coefficient zero, rather than being removed from the range. -/
theorem selberg_tent_identity (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N,
      ((N : ℝ) - n) * ArithmeticFunction.vonMangoldt n * Real.log (n : ℝ)) +
      (∑ a ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt a *
        ∑ b ∈ Finset.Icc 1 (N / a),
          ((N : ℝ) - (a * b : ℕ)) * ArithmeticFunction.vonMangoldt b) =
      ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
        ∑ q ∈ Finset.Icc 1 (N / d),
          ((N : ℝ) - (d * q : ℕ)) * Real.log (q : ℝ) ^ 2 :=
  selberg_weighted_identity N (fun n => (N : ℝ) - n)

/-- The signed Möbius tent sum is nonnegative by its exact arithmetic readout. -/
theorem selberg_moebius_tent_nonneg (N : ℕ) :
    0 ≤ ∑ d ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius d : ℝ) *
      ∑ q ∈ Finset.Icc 1 (N / d),
        ((N : ℝ) - (d * q : ℕ)) * Real.log (q : ℝ) ^ 2 := by
  rw [← selbergWeight_weighted_moebius N (fun n => (N : ℝ) - n)]
  apply Finset.sum_nonneg
  intro n hn
  apply mul_nonneg _ (selbergWeight_nonneg n)
  apply sub_nonneg.mpr
  exact_mod_cast (Finset.mem_Icc.mp hn).2

end BuildingBlocks
