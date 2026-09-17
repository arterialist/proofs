import BuildingBlocks.CenteredGoldbachTruncatedHeat

/-!
# Exact finite centered-heat scale increment

The cutoff `Y` is literal.  Totals near `2Y` are not replaced by an
untruncated Goldbach coefficient, and the even and odd classes remain
separate.
-/

namespace BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite

open scoped BigOperators Interval
open Finset Real
open BuildingBlocks.GoldbachHeat
open BuildingBlocks.CenteredGoldbachTruncatedHeat

noncomputable section

def truncatedPrimeCoefficient (Y N : ℕ) : ℝ :=
  ∑ m ∈ Icc 1 Y, ∑ n ∈ Icc 1 Y,
    if m + n = N then
      ArithmeticFunction.vonMangoldt m * ArithmeticFunction.vonMangoldt n else 0

def truncatedLeftMarginal (Y N : ℕ) : ℝ :=
  ∑ m ∈ Icc 1 Y, ∑ n ∈ Icc 1 Y,
    if m + n = N then ArithmeticFunction.vonMangoldt m else 0

def truncatedRightMarginal (Y N : ℕ) : ℝ :=
  ∑ m ∈ Icc 1 Y, ∑ n ∈ Icc 1 Y,
    if m + n = N then ArithmeticFunction.vonMangoldt n else 0

def truncatedPairCount (Y N : ℕ) : ℝ :=
  ∑ m ∈ Icc 1 Y, ∑ n ∈ Icc 1 Y,
    if m + n = N then 1 else 0

/-- Complete finite centering expansion.  The two ordered marginals and
the pair-count term are retained separately. -/
theorem truncatedCoefficient_decomposition (Y N : ℕ) :
    truncatedCoefficient Y N =
      truncatedPrimeCoefficient Y N - truncatedLeftMarginal Y N -
        truncatedRightMarginal Y N + truncatedPairCount Y N := by
  unfold truncatedCoefficient truncatedPrimeCoefficient truncatedLeftMarginal
    truncatedRightMarginal truncatedPairCount
  simp only [← Finset.sum_add_distrib, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro m hm
  apply Finset.sum_congr rfl
  intro n hn
  by_cases h : m + n = N
  · simp [h, centeredCoefficient]
    ring
  · simp [h]

/-- Kernel for the newly exposed shell when the logarithmic horizon doubles. -/
def shellKernel (T : ℝ) (N : ℕ) : ℝ :=
  (exp (-((N : ℝ) * exp (-2 * T))) -
    exp (-((N : ℝ) * exp (-T)))) / N

def finiteHeatHorizon (Y : ℕ) (T : ℝ) : ℝ :=
  1 + ∑ N ∈ Icc 2 (2 * Y), truncatedCoefficient Y N *
    (exp (-((N : ℝ) * exp (-T))) - exp (-(N : ℝ))) / N

def finiteHeatScaleIncrement (Y : ℕ) (T : ℝ) : ℝ :=
  ∑ N ∈ Icc 2 (2 * Y), truncatedCoefficient Y N * shellKernel T N

/-- Exact finite `T -> 2T` coefficient identity. -/
theorem finiteHeatHorizon_double_sub (Y : ℕ) (T : ℝ) :
    finiteHeatHorizon Y (2 * T) - finiteHeatHorizon Y T =
      finiteHeatScaleIncrement Y T := by
  unfold finiteHeatHorizon finiteHeatScaleIncrement shellKernel
  rw [add_sub_add_left_eq_sub]
  rw [← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro N hN
  have hNpos : 0 < N := lt_of_lt_of_le (by omega) (mem_Icc.mp hN).1
  have hN0 : (N : ℝ) ≠ 0 := by
    exact_mod_cast hNpos.ne'
  field_simp
  ring

private theorem integral_exp_neg_nat {N : ℕ} (hN : 0 < N) (a b : ℝ) :
    (∫ t in a..b, exp (-((N : ℝ) * t))) =
      (exp (-((N : ℝ) * a)) - exp (-((N : ℝ) * b))) / N := by
  let c : ℝ := -(N : ℝ)
  have hc : c ≠ 0 := by dsimp [c]; exact neg_ne_zero.mpr (by exact_mod_cast hN.ne')
  have hd : ∀ t : ℝ,
      HasDerivAt (fun u : ℝ => exp (c * u) / c) (exp (c * t)) t := by
    intro t
    convert (((hasDerivAt_id t).const_mul c).exp.div_const c) using 1
    all_goals simp [hc]
  have hfun : (fun t : ℝ => exp (-((N : ℝ) * t))) =
      fun t : ℝ => exp (c * t) := by
    funext t
    congr 1
    dsimp [c]
    ring
  rw [hfun]
  rw [intervalIntegral.integral_eq_sub_of_hasDerivAt
    (fun t _ => hd t)
    ((continuous_exp.comp (continuous_const.mul continuous_id)).intervalIntegrable _ _)]
  dsimp [c]
  field_simp
  ring

/-- Integral form of the same finite shell. -/
theorem finiteHeatScaleIncrement_eq_integral (Y : ℕ) (T : ℝ) :
    finiteHeatScaleIncrement Y T =
      ∫ t in exp (-2 * T)..exp (-T),
        (finiteHeat centeredCoefficient Y t) ^ 2 := by
  simp_rw [centered_finiteHeat_square]
  rw [intervalIntegral.integral_finset_sum]
  · unfold finiteHeatScaleIncrement shellKernel
    apply Finset.sum_congr rfl
    intro N hN
    have hNpos : 0 < N := lt_of_lt_of_le (by omega) (mem_Icc.mp hN).1
    rw [intervalIntegral.integral_const_mul]
    rw [integral_exp_neg_nat hNpos]
  · intro N hN
    exact (continuous_const.mul (continuous_exp.comp
      (continuous_const.mul continuous_id).neg)).intervalIntegrable _ _

def evenScaleIncrement (Y : ℕ) (T : ℝ) : ℝ :=
  ∑ N ∈ (Icc 2 (2 * Y)).filter Even,
    truncatedCoefficient Y N * shellKernel T N

def oddScaleIncrement (Y : ℕ) (T : ℝ) : ℝ :=
  ∑ N ∈ (Icc 2 (2 * Y)).filter Odd,
    truncatedCoefficient Y N * shellKernel T N

def primeScaleIncrement (Y : ℕ) (T : ℝ) : ℝ :=
  ∑ N ∈ Icc 2 (2 * Y), truncatedPrimeCoefficient Y N * shellKernel T N

def leftMarginalScaleIncrement (Y : ℕ) (T : ℝ) : ℝ :=
  ∑ N ∈ Icc 2 (2 * Y), truncatedLeftMarginal Y N * shellKernel T N

def rightMarginalScaleIncrement (Y : ℕ) (T : ℝ) : ℝ :=
  ∑ N ∈ Icc 2 (2 * Y), truncatedRightMarginal Y N * shellKernel T N

def pairCountScaleIncrement (Y : ℕ) (T : ℝ) : ℝ :=
  ∑ N ∈ Icc 2 (2 * Y), truncatedPairCount Y N * shellKernel T N

/-- Exact shell decomposition into the positive prime-prime packet and the
two signed centering marginals plus the density pair count. -/
theorem finiteHeatScaleIncrement_decomposition (Y : ℕ) (T : ℝ) :
    finiteHeatScaleIncrement Y T =
      primeScaleIncrement Y T - leftMarginalScaleIncrement Y T -
        rightMarginalScaleIncrement Y T + pairCountScaleIncrement Y T := by
  unfold finiteHeatScaleIncrement primeScaleIncrement leftMarginalScaleIncrement
    rightMarginalScaleIncrement pairCountScaleIncrement
  simp_rw [truncatedCoefficient_decomposition]
  simp only [sub_mul, add_mul, Finset.sum_sub_distrib, Finset.sum_add_distrib]

/-- Exact parity split of the full finite shell. -/
theorem finiteHeatScaleIncrement_parity (Y : ℕ) (T : ℝ) :
    finiteHeatScaleIncrement Y T =
      evenScaleIncrement Y T + oddScaleIncrement Y T := by
  unfold finiteHeatScaleIncrement evenScaleIncrement oddScaleIncrement
  rw [← Finset.sum_filter_add_sum_filter_not (Icc 2 (2 * Y)) Even]
  congr 1
  apply Finset.sum_congr
  · ext N
    simp [Nat.not_even_iff_odd]
  · intro N hN
    rfl

theorem truncatedPrimeCoefficient_nonneg (Y N : ℕ) :
    0 ≤ truncatedPrimeCoefficient Y N := by
  unfold truncatedPrimeCoefficient
  apply Finset.sum_nonneg
  intro m hm
  apply Finset.sum_nonneg
  intro n hn
  split_ifs
  · exact mul_nonneg ArithmeticFunction.vonMangoldt_nonneg
      ArithmeticFunction.vonMangoldt_nonneg
  · exact le_rfl

theorem truncatedLeftMarginal_nonneg (Y N : ℕ) :
    0 ≤ truncatedLeftMarginal Y N := by
  unfold truncatedLeftMarginal
  apply Finset.sum_nonneg
  intro m hm
  apply Finset.sum_nonneg
  intro n hn
  split_ifs
  · exact ArithmeticFunction.vonMangoldt_nonneg
  · exact le_rfl

theorem truncatedRightMarginal_nonneg (Y N : ℕ) :
    0 ≤ truncatedRightMarginal Y N := by
  unfold truncatedRightMarginal
  apply Finset.sum_nonneg
  intro m hm
  apply Finset.sum_nonneg
  intro n hn
  split_ifs
  · exact ArithmeticFunction.vonMangoldt_nonneg
  · exact le_rfl

theorem truncatedPairCount_nonneg (Y N : ℕ) :
    0 ≤ truncatedPairCount Y N := by
  unfold truncatedPairCount
  apply Finset.sum_nonneg
  intro m hm
  apply Finset.sum_nonneg
  intro n hn
  split_ifs <;> norm_num

/-- Ordinary Goldbach positivity controls only the prime-prime summand.
The two centered marginals remain the signed compensation. -/
theorem truncatedCoefficient_le_prime_add_count (Y N : ℕ) :
    truncatedCoefficient Y N ≤
      truncatedPrimeCoefficient Y N + truncatedPairCount Y N := by
  rw [truncatedCoefficient_decomposition]
  have hl := truncatedLeftMarginal_nonneg Y N
  have hr := truncatedRightMarginal_nonneg Y N
  linarith

theorem shellKernel_nonneg {T : ℝ} (hT : 0 ≤ T) {N : ℕ} (hN : 0 < N) :
    0 ≤ shellKernel T N := by
  unfold shellKernel
  apply div_nonneg
  · apply sub_nonneg.mpr
    apply exp_le_exp.mpr
    have he : exp (-2 * T) ≤ exp (-T) := by
      apply exp_le_exp.mpr
      linarith
    exact neg_le_neg (mul_le_mul_of_nonneg_left he (by positivity))
  · exact_mod_cast hN.le

theorem primeScaleIncrement_nonneg (Y : ℕ) {T : ℝ} (hT : 0 ≤ T) :
    0 ≤ primeScaleIncrement Y T := by
  unfold primeScaleIncrement
  apply Finset.sum_nonneg
  intro N hN
  apply mul_nonneg (truncatedPrimeCoefficient_nonneg Y N)
  exact shellKernel_nonneg hT (lt_of_lt_of_le (by omega) (mem_Icc.mp hN).1)

theorem leftMarginalScaleIncrement_nonneg (Y : ℕ) {T : ℝ} (hT : 0 ≤ T) :
    0 ≤ leftMarginalScaleIncrement Y T := by
  unfold leftMarginalScaleIncrement
  apply Finset.sum_nonneg
  intro N hN
  apply mul_nonneg (truncatedLeftMarginal_nonneg Y N)
  exact shellKernel_nonneg hT (lt_of_lt_of_le (by omega) (mem_Icc.mp hN).1)

theorem rightMarginalScaleIncrement_nonneg (Y : ℕ) {T : ℝ} (hT : 0 ≤ T) :
    0 ≤ rightMarginalScaleIncrement Y T := by
  unfold rightMarginalScaleIncrement
  apply Finset.sum_nonneg
  intro N hN
  apply mul_nonneg (truncatedRightMarginal_nonneg Y N)
  exact shellKernel_nonneg hT (lt_of_lt_of_le (by omega) (mem_Icc.mp hN).1)

theorem pairCountScaleIncrement_nonneg (Y : ℕ) {T : ℝ} (hT : 0 ≤ T) :
    0 ≤ pairCountScaleIncrement Y T := by
  unfold pairCountScaleIncrement
  apply Finset.sum_nonneg
  intro N hN
  apply mul_nonneg (truncatedPairCount_nonneg Y N)
  exact shellKernel_nonneg hT (lt_of_lt_of_le (by omega) (mem_Icc.mp hN).1)

end
end BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite

#print axioms BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedCoefficient_decomposition
#print axioms BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.finiteHeatHorizon_double_sub
#print axioms BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.finiteHeatScaleIncrement_eq_integral
#print axioms BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.finiteHeatScaleIncrement_parity
#print axioms BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.finiteHeatScaleIncrement_decomposition
#print axioms BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedPrimeCoefficient_nonneg
#print axioms BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedCoefficient_le_prime_add_count
#print axioms BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.shellKernel_nonneg
#print axioms BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.primeScaleIncrement_nonneg
#print axioms BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.leftMarginalScaleIncrement_nonneg
#print axioms BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.rightMarginalScaleIncrement_nonneg
#print axioms BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.pairCountScaleIncrement_nonneg
