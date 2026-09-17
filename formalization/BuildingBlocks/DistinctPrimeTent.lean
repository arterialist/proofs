import BuildingBlocks.HyperbolaProduct
import BuildingBlocks.SelbergCenteredPairing
import BuildingBlocks.SelbergDistinctPrimes

open scoped BigOperators

namespace BuildingBlocks

open CoarsePrimitive HyperbolaProduct

/-- The tent-weighted contribution of same-prime multiplicative histories. -/
noncomputable def samePrimeTent (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, ((N : ℝ) - n) * samePrimePairWeight n

/-- The corrected centered area with only same-prime histories removed. -/
noncomputable def distinctPrimeArea (N : ℕ) : ℝ :=
  selbergCenteredArea N - samePrimeTent N

/-- Reindex the actual distinct-prime source, retaining every ordered
coprime factor pair and the original weight at its product. -/
theorem distinctPrimePairWeight_weighted_sum (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N, w n * distinctPrimePairWeight n) =
      ∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 (N / a),
        if a.Coprime b then
          w (a * b) * ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b
        else 0 := by
  have hpoint (n : ℕ) : w n * distinctPrimePairWeight n =
      ∑ d ∈ n.divisors,
        if d.Coprime (n / d) then
          w (d * (n / d)) * ArithmeticFunction.vonMangoldt d *
            ArithmeticFunction.vonMangoldt (n / d)
        else 0 := by
    rw [distinctPrimePairWeight_eq_coprime_sum, Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro d hd
    rw [Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1]
    split_ifs <;> ring
  simp_rw [hpoint]
  exact sum_divisors_eq_sum_factor_pairs N
    (fun a b => if a.Coprime b then
      w (a * b) * ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b else 0)

private theorem vonMangoldt_tent_pair_sum (N : ℕ) :
    (∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 (N / a),
      ((N : ℝ) - (a * b : ℕ)) * ArithmeticFunction.vonMangoldt a *
        ArithmeticFunction.vonMangoldt b) =
      ∑ n ∈ Finset.Icc 1 N, ((N : ℝ) - n) *
        (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n := by
  rw [← sum_divisors_eq_sum_factor_pairs N
    (fun a b => ((N : ℝ) - (a * b : ℕ)) * ArithmeticFunction.vonMangoldt a *
      ArithmeticFunction.vonMangoldt b)]
  apply Finset.sum_congr rfl
  intro n _
  rw [ArithmeticFunction.mul_apply, Nat.sum_divisorsAntidiagonal
    (fun a b => ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b),
    Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro d hd
  rw [Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1]
  ring

theorem vonMangoldt_tent_sub_samePrimeTent (N : ℕ) :
    (∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 (N / a),
      ((N : ℝ) - (a * b : ℕ)) * ArithmeticFunction.vonMangoldt a *
        ArithmeticFunction.vonMangoldt b) - samePrimeTent N =
      ∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 (N / a),
        if a.Coprime b then
          ((N : ℝ) - (a * b : ℕ)) * ArithmeticFunction.vonMangoldt a *
            ArithmeticFunction.vonMangoldt b
        else 0 := by
  rw [vonMangoldt_tent_pair_sum, samePrimeTent, ← Finset.sum_sub_distrib]
  calc
    _ = ∑ n ∈ Finset.Icc 1 N, ((N : ℝ) - n) * distinctPrimePairWeight n := by
      apply Finset.sum_congr rfl
      intro n _
      simp only [distinctPrimePairWeight, mul_sub]
    _ = _ := distinctPrimePairWeight_weighted_sum N (fun n => (N : ℝ) - n)

/-- Exact readout of the corrected distinct-prime area. The first-moment
correction is `+ ∑ n, n Λ(n)`, not the unweighted prime mass. Endpoint products
equal to `N` remain in the factor-pair sum with coefficient zero. -/
theorem distinctPrimeArea_eq_coprime_pairs (N : ℕ) :
    distinctPrimeArea N =
      (∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 (N / a),
        if a.Coprime b then
          ((N : ℝ) - (a * b : ℕ)) * ArithmeticFunction.vonMangoldt a *
            ArithmeticFunction.vonMangoldt b
        else 0) +
      (∑ n ∈ Finset.Icc 1 N, (n : ℝ) * ArithmeticFunction.vonMangoldt n) -
      (N : ℝ) ^ 2 * (∑ n ∈ Finset.Icc 1 N,
        ArithmeticFunction.vonMangoldt n / (n : ℝ)) +
      (N : ℝ) ^ 2 / 2 * Real.log N + (N : ℝ) ^ 2 / 4 - 1 / 4 := by
  have h := vonMangoldt_tent_sub_samePrimeTent N
  unfold distinctPrimeArea selbergCenteredArea
  linarith

theorem samePrimeTent_nonneg (N : ℕ) : 0 ≤ samePrimeTent N := by
  apply Finset.sum_nonneg
  intro n hn
  apply mul_nonneg _ (samePrimePairWeight_nonneg n)
  apply sub_nonneg.mpr
  exact_mod_cast (Finset.mem_Icc.mp hn).2

end BuildingBlocks
