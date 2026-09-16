import BuildingBlocks.FactorialResidueFinite

/-!
# Complete additive square of factorial-residue curvature

The discrete curvature of the residue loading is the difference of a
weighted prime-power arrival and an ordinary logarithmic arrival.
This file keeps all three pieces in its finite additive square.
-/

namespace BuildingBlocks.FactorialCurvatureGoldbachFinite

open scoped BigOperators ArithmeticFunction

/-- The weighted prime-power arrival, including prime powers. The lower
branch is zero so that an unfiltered antidiagonal has the exact endpoints. -/
noncomputable def primeWeight (n : ℕ) : ℝ :=
  if 2 ≤ n then ArithmeticFunction.vonMangoldt n / (n : ℝ) else 0

/-- The ordinary successor density, with the same lower branch. -/
noncomputable def densityWeight (n : ℕ) : ℝ :=
  if 2 ≤ n then Real.log (((n : ℝ) + 1) / n) else 0

noncomputable def curvature (n : ℕ) : ℝ :=
  primeWeight n - densityWeight n

/-- The additive source is exactly the negative second difference of the
actual factorial residue loading at every positive integer. -/
theorem curvature_eq_neg_loading_second_difference (N : ℕ) (hN : 1 ≤ N) :
    curvature (N + 1) =
      -(ResidueLoadingSuccessor.loading (N + 2) -
          2 * ResidueLoadingSuccessor.loading (N + 1) +
          ResidueLoadingSuccessor.loading N) := by
  rw [ResidueLoadingSuccessor.loading_second_difference]
  simp only [curvature, primeWeight, densityWeight,
    if_pos (show 2 ≤ N + 1 by omega)]
  push_cast
  ring_nf

/-- Every ordered Goldbach pair, both centering crosses, and the density
square survive in the exact additive curvature coefficient. -/
theorem curvature_square (k : ℕ) :
    (∑ p ∈ Finset.antidiagonal k, curvature p.1 * curvature p.2) =
      (∑ p ∈ Finset.antidiagonal k, primeWeight p.1 * primeWeight p.2) -
      2 * (∑ p ∈ Finset.antidiagonal k, primeWeight p.1 * densityWeight p.2) +
      (∑ p ∈ Finset.antidiagonal k, densityWeight p.1 * densityWeight p.2) := by
  have hswap :
      (∑ p ∈ Finset.antidiagonal k, densityWeight p.1 * primeWeight p.2) =
        (∑ p ∈ Finset.antidiagonal k, primeWeight p.1 * densityWeight p.2) := by
    simpa only [Prod.fst_swap, Prod.snd_swap, mul_comm] using
      (Finset.Nat.sum_antidiagonal_swap (n := k)
        (f := fun p => densityWeight p.1 * primeWeight p.2)).symm
  simp only [curvature, sub_mul, mul_sub, Finset.sum_sub_distrib]
  rw [hswap]
  ring

/-- The first nontrivial odd additive curvature coefficient is negative.
Thus the centered Goldbach convolution is not coefficientwise positive. -/
theorem curvature_square_five_negative :
    (∑ p ∈ Finset.antidiagonal 5, curvature p.1 * curvature p.2) < 0 := by
  have h2 : curvature 2 = (3 / 2 : ℝ) * Real.log 2 - Real.log 3 := by
    simp [curvature, primeWeight, densityWeight,
      ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two]
    rw [show (2 : ℝ) + 1 = 3 by norm_num,
      Real.log_div (by norm_num : (3 : ℝ) ≠ 0) (by norm_num : (2 : ℝ) ≠ 0)]
    ring
  have h3 : curvature 3 = (4 / 3 : ℝ) * Real.log 3 - Real.log 4 := by
    simp [curvature, primeWeight, densityWeight,
      ArithmeticFunction.vonMangoldt_apply_prime (by decide : Nat.Prime 3)]
    rw [show (3 : ℝ) + 1 = 4 by norm_num,
      Real.log_div (by norm_num : (4 : ℝ) ≠ 0) (by norm_num : (3 : ℝ) ≠ 0)]
    ring
  have h8 : 3 * Real.log (2 : ℝ) < 2 * Real.log (3 : ℝ) := by
    have h := Real.log_lt_log (by norm_num : (0 : ℝ) < 8) (by norm_num : (8 : ℝ) < 9)
    have hlog8 : Real.log (8 : ℝ) = 3 * Real.log 2 := by
      calc
        Real.log (8 : ℝ) = Real.log ((2 : ℝ) ^ 3) := by norm_num
        _ = 3 * Real.log 2 := by rw [Real.log_pow]; ring
    have hlog9 : Real.log (9 : ℝ) = 2 * Real.log 3 := by
      calc
        Real.log (9 : ℝ) = Real.log ((3 : ℝ) ^ 2) := by norm_num
        _ = 2 * Real.log 3 := by rw [Real.log_pow]; ring
    simpa only [hlog8, hlog9] using h
  have h81 : 3 * Real.log (4 : ℝ) < 4 * Real.log (3 : ℝ) := by
    have h := Real.log_lt_log (by norm_num : (0 : ℝ) < 64) (by norm_num : (64 : ℝ) < 81)
    have hlog64 : Real.log (64 : ℝ) = 3 * Real.log 4 := by
      calc
        Real.log (64 : ℝ) = Real.log ((4 : ℝ) ^ 3) := by norm_num
        _ = 3 * Real.log 4 := by rw [Real.log_pow]; ring
    have hlog81 : Real.log (81 : ℝ) = 4 * Real.log 3 := by
      calc
        Real.log (81 : ℝ) = Real.log ((3 : ℝ) ^ 4) := by norm_num
        _ = 4 * Real.log 3 := by rw [Real.log_pow]; ring
    simpa only [hlog64, hlog81] using h
  have hn2 : curvature 2 < 0 := by rw [h2]; linarith
  have hp3 : 0 < curvature 3 := by rw [h3]; linarith
  have hsum : (∑ p ∈ Finset.antidiagonal 5, curvature p.1 * curvature p.2) =
      2 * curvature 2 * curvature 3 := by
    have hs : Finset.antidiagonal 5 =
        {(0, 5), (1, 4), (2, 3), (3, 2), (4, 1), (5, 0)} := by decide
    rw [hs]
    simp [curvature, primeWeight, densityWeight]
    ring
  rw [hsum]
  have hprod : curvature 2 * curvature 3 < 0 := mul_neg_of_neg_of_pos hn2 hp3
  simpa only [mul_assoc] using
    (mul_neg_of_pos_of_neg (by norm_num : (0 : ℝ) < 2) hprod)

end BuildingBlocks.FactorialCurvatureGoldbachFinite
