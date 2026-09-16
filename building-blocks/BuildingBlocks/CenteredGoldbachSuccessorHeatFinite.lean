import BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite

/-!
# Literal successor shift of the finite centered Goldbach heat

The successor is applied to the source index and keeps both the initial atom
and the newly exposed coefficient at the upper cutoff.
-/

namespace BuildingBlocks.CenteredGoldbachSuccessorHeatFinite

open scoped BigOperators Interval
open Finset Real
open BuildingBlocks.GoldbachHeat
open BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite

noncomputable section

/-- The actual discrete derivative. Centering cancels, but both von Mangoldt
values, including prime powers, stay literal. -/
def successorDifference (n : ℕ) : ℝ :=
  centeredCoefficient (n + 1) - centeredCoefficient n

/-- Same number of terms as the original heat, shifted by one source index. -/
def shiftedFiniteHeat (a : ℕ → ℝ) (Y : ℕ) (t : ℝ) : ℝ :=
  ∑ n ∈ Icc 1 Y, a (n + 1) * exp (-((n : ℝ) * t))

/-- The discrete derivative heat has the original index range. -/
def differenceFiniteHeat (Y : ℕ) (t : ℝ) : ℝ :=
  finiteHeat successorDifference Y t

theorem successorDifference_eq_mangoldt (n : ℕ) :
    successorDifference n =
      ArithmeticFunction.vonMangoldt (n + 1) - ArithmeticFunction.vonMangoldt n := by
  simp [successorDifference, centeredCoefficient]

theorem shiftedFiniteHeat_eq_add (Y : ℕ) (t : ℝ) :
    shiftedFiniteHeat centeredCoefficient Y t =
      finiteHeat centeredCoefficient Y t + differenceFiniteHeat Y t := by
  unfold shiftedFiniteHeat differenceFiniteHeat successorDifference finiteHeat
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  ring

/-- Endpoint identity for an arbitrary source; the upper birth and first atom
are both explicit. -/
theorem shiftedFiniteHeat_endpoint (a : ℕ → ℝ) (Y : ℕ) (t : ℝ) :
    shiftedFiniteHeat a Y t =
      exp t * finiteHeat a Y t - a 1 + a (Y + 1) * exp (-((Y : ℝ) * t)) := by
  induction Y with
  | zero =>
      simp [shiftedFiniteHeat, finiteHeat]
  | succ Y ih =>
      unfold shiftedFiniteHeat at ih ⊢
      unfold finiteHeat at ih ⊢
      rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ Y + 1)]
      rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ Y + 1)]
      rw [ih]
      have he : exp t * exp (-(((Y + 1 : ℕ) : ℝ) * t)) =
          exp (-((Y : ℝ) * t)) := by
        rw [← exp_add]
        congr 1
        push_cast
        ring
      rw [← he]
      ring

/-- Actual centered endpoint identity. In particular `a₁=-1` is not lost. -/
theorem shiftedCenteredHeat_endpoint (Y : ℕ) (t : ℝ) :
    shiftedFiniteHeat centeredCoefficient Y t =
      exp t * finiteHeat centeredCoefficient Y t + 1 +
        centeredCoefficient (Y + 1) * exp (-((Y : ℝ) * t)) := by
  rw [shiftedFiniteHeat_endpoint]
  simp

/-- Additive coefficients of the shifted sequence; the original source
indices are `m+1,n+1`, while the exponential total remains `m+n`. -/
def shiftedCoefficient (Y N : ℕ) : ℝ :=
  ∑ m ∈ Icc 1 Y, ∑ n ∈ Icc 1 Y,
    if m + n = N then centeredCoefficient (m + 1) * centeredCoefficient (n + 1) else 0

/-- The two ordered, signed covariance contributions are both retained. -/
def covarianceCoefficient (Y N : ℕ) : ℝ :=
  ∑ m ∈ Icc 1 Y, ∑ n ∈ Icc 1 Y,
    if m + n = N then
      centeredCoefficient m * successorDifference n +
        successorDifference m * centeredCoefficient n else 0

def variationCoefficient (Y N : ℕ) : ℝ :=
  ∑ m ∈ Icc 1 Y, ∑ n ∈ Icc 1 Y,
    if m + n = N then successorDifference m * successorDifference n else 0

/-- Coefficient-level signed successor identity at every bounded additive
total, including both cutoff edges. -/
theorem shiftedCoefficient_sub_original (Y N : ℕ) :
    shiftedCoefficient Y N - BuildingBlocks.CenteredGoldbachTruncatedHeat.truncatedCoefficient Y N =
      covarianceCoefficient Y N + variationCoefficient Y N := by
  unfold shiftedCoefficient BuildingBlocks.CenteredGoldbachTruncatedHeat.truncatedCoefficient
    covarianceCoefficient variationCoefficient
  simp only [← Finset.sum_sub_distrib, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro m hm
  apply Finset.sum_congr rfl
  intro n hn
  by_cases h : m + n = N
  · simp [h, successorDifference]
    ring
  · simp [h]

/-- The first additive total falls under the successor shift. -/
theorem successor_coefficient_two_exact :
    shiftedCoefficient 1 2 -
      BuildingBlocks.CenteredGoldbachTruncatedHeat.truncatedCoefficient 1 2 =
        (log 2) ^ 2 - 2 * log 2 := by
  have h2 : ArithmeticFunction.vonMangoldt 2 = log 2 :=
    ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two
  norm_num [shiftedCoefficient,
    BuildingBlocks.CenteredGoldbachTruncatedHeat.truncatedCoefficient,
    centeredCoefficient, h2]
  ring

theorem successor_coefficient_two_neg :
    shiftedCoefficient 1 2 -
      BuildingBlocks.CenteredGoldbachTruncatedHeat.truncatedCoefficient 1 2 < 0 := by
  rw [successor_coefficient_two_exact]
  have hp : 0 < log 2 := log_pos (by norm_num)
  have hl : log 2 < 2 := by linarith [Real.log_two_lt_d9]
  nlinarith [mul_pos hp (sub_pos.mpr hl)]

/-- The total-four coefficient changes sign in the opposite direction.
The terms include the prime power `4=2^2` and both ordered endpoints. -/
theorem successor_coefficient_four_exact :
    shiftedCoefficient 3 4 -
      BuildingBlocks.CenteredGoldbachTruncatedHeat.truncatedCoefficient 3 4 =
        (log 2 - 1) ^ 2 + (log 3) ^ 2 - 1 := by
  have h2 : ArithmeticFunction.vonMangoldt 2 = log 2 :=
    ArithmeticFunction.vonMangoldt_apply_prime Nat.prime_two
  have h3 : ArithmeticFunction.vonMangoldt 3 = log 3 :=
    ArithmeticFunction.vonMangoldt_apply_prime (by decide)
  have h4 : ArithmeticFunction.vonMangoldt 4 = log 2 := by
    change ArithmeticFunction.vonMangoldt (2 ^ 2) = _
    rw [ArithmeticFunction.vonMangoldt_apply_pow (by norm_num), h2]
  norm_num [shiftedCoefficient,
    BuildingBlocks.CenteredGoldbachTruncatedHeat.truncatedCoefficient,
    centeredCoefficient, h2, h3, h4, Finset.sum_Icc_succ_top]
  ring

theorem successor_coefficient_four_pos :
    0 < shiftedCoefficient 3 4 -
      BuildingBlocks.CenteredGoldbachTruncatedHeat.truncatedCoefficient 3 4 := by
  rw [successor_coefficient_four_exact]
  have h3 : 1 < log 3 := by
    rw [Real.lt_log_iff_exp_lt (by norm_num : (0 : ℝ) < 3)]
    exact Real.exp_one_lt_d9.trans (by norm_num)
  nlinarith [sq_nonneg (log 2 - 1)]

def shiftedShell (Y : ℕ) (T : ℝ) : ℝ :=
  ∫ t in exp (-2 * T)..exp (-T),
    (shiftedFiniteHeat centeredCoefficient Y t) ^ 2

def crossShell (Y : ℕ) (T : ℝ) : ℝ :=
  ∫ t in exp (-2 * T)..exp (-T),
    finiteHeat centeredCoefficient Y t * differenceFiniteHeat Y t

def variationShell (Y : ℕ) (T : ℝ) : ℝ :=
  ∫ t in exp (-2 * T)..exp (-T),
    (differenceFiniteHeat Y t) ^ 2

private theorem continuous_finiteHeat (a : ℕ → ℝ) (Y : ℕ) :
    Continuous (fun t : ℝ => finiteHeat a Y t) := by
  unfold finiteHeat
  fun_prop

/-- Exact signed covariance identity for the successor-shifted shell. The
variation square is positive; the mixed term has no prescribed sign. -/
theorem shiftedShell_sub_original (Y : ℕ) (T : ℝ) :
    shiftedShell Y T - finiteHeatScaleIncrement Y T =
      2 * crossShell Y T + variationShell Y T := by
  rw [finiteHeatScaleIncrement_eq_integral]
  unfold shiftedShell crossShell variationShell
  have hD := continuous_finiteHeat centeredCoefficient Y
  have hV := continuous_finiteHeat successorDifference Y
  have hS : Continuous (fun t : ℝ =>
      (shiftedFiniteHeat centeredCoefficient Y t) ^ 2) := by
    have heq : (fun t : ℝ => (shiftedFiniteHeat centeredCoefficient Y t) ^ 2) =
        fun t : ℝ => (finiteHeat centeredCoefficient Y t + differenceFiniteHeat Y t) ^ 2 := by
      funext t
      rw [shiftedFiniteHeat_eq_add]
    rw [heq]
    exact (hD.add hV).pow 2
  rw [← intervalIntegral.integral_sub (hS.intervalIntegrable _ _)
    ((hD.pow 2).intervalIntegrable _ _)]
  rw [← intervalIntegral.integral_const_mul]
  dsimp only [differenceFiniteHeat]
  rw [← intervalIntegral.integral_add
    ((continuous_const.mul (hD.mul hV)).intervalIntegrable _ _)
    ((hV.pow 2).intervalIntegrable _ _)]
  congr 1
  funext t
  rw [shiftedFiniteHeat_eq_add]
  dsimp only [differenceFiniteHeat]
  ring

#print axioms successorDifference_eq_mangoldt
#print axioms shiftedFiniteHeat_eq_add
#print axioms shiftedFiniteHeat_endpoint
#print axioms shiftedCenteredHeat_endpoint
#print axioms shiftedCoefficient_sub_original
#print axioms successor_coefficient_two_neg
#print axioms successor_coefficient_four_pos
#print axioms shiftedShell_sub_original

end
end BuildingBlocks.CenteredGoldbachSuccessorHeatFinite
