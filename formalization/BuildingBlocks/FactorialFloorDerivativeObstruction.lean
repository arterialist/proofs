import Mathlib.Tactic

/-!
# Finite factorial floor-derivative obstruction

This module certifies the actual `N = 13` grouped Möbius counterexample to
integer floor-derivative contraction and the finite algebra behind the real
first-cell Mertens trace.  It asserts no analytic energy bound or RH result.
-/

namespace BuildingBlocks.FactorialFloorDerivativeObstruction

open scoped BigOperators

/-- Actual nonzero grouped Möbius coefficients at cutoff thirteen. -/
def coeff13 (q : ℕ) : ℤ :=
  if q = 13 then 1 else if q = 6 then -1 else
  if q = 4 then -1 else if q = 1 then -2 else 0

/-- Literal grouped integer floor row. -/
def floorRow13 (k : ℕ) : ℤ :=
  ∑ q ∈ Finset.Icc 1 13, coeff13 q * (q / k : ℕ)

/-- Every actual quotient row through the cutoff equals one. -/
theorem floorRow13_eq_one {k : ℕ} (hk1 : 1 ≤ k) (hk13 : k ≤ 13) :
    floorRow13 k = 1 := by
  interval_cases k <;> decide

/-- The complete grouped coefficient sum is the actual value `M(13)=-3`. -/
theorem coeff13_sum : (∑ q ∈ Finset.Icc 1 13, coeff13 q) = -3 := by
  decide

/-- The first complete floor moment is one. -/
theorem coeff13_firstMoment :
    (∑ q ∈ Finset.Icc 1 13, coeff13 q * q) = 1 := by
  decide

/-- Adjacent sampled derivatives vanish at every strict interior row. -/
theorem floorRow13_difference_interior {k : ℕ} (hk1 : 1 ≤ k) (hk13 : k < 13) :
    floorRow13 k - floorRow13 (k + 1) = 0 := by
  rw [floorRow13_eq_one hk1 (by omega), floorRow13_eq_one (by omega) (by omega)]
  norm_num

/-- The terminal sampled derivative is retained and equals one. -/
theorem floorRow13_difference_terminal : floorRow13 13 - floorRow13 14 = 1 := by
  decide

/-- Numerator and denominator of the exact exponential energy ratio. -/
def certificateNumerator : ℕ := 5 ^ 35 * 13 ^ 104
def certificateDenominator : ℕ :=
  2 ^ 61 * 3 ^ 25 * 7 ^ 28 * 11 * 17 ^ 30 * 19 ^ 36

/-- Exact integer certificate underlying the failed contraction. -/
theorem certificateDenominator_lt_numerator :
    certificateDenominator < certificateNumerator := by
  norm_num [certificateDenominator, certificateNumerator]

/-- The corresponding exact logarithmic energy difference is positive. -/
theorem certificate_log_ratio_pos :
    0 < Real.log ((certificateNumerator : ℝ) / certificateDenominator) := by
  apply Real.log_pos
  have hdenNat : 0 < certificateDenominator := by
    norm_num [certificateDenominator]
  have hden : (0 : ℝ) < certificateDenominator := by exact_mod_cast hdenNat
  rw [one_lt_div hden]
  exact_mod_cast certificateDenominator_lt_numerator

/-- Generic first-cell algebra: replacing every integer `q` by `q-1`
exposes the complete coefficient sum. -/
theorem firstCell_sum_sub_one
    (S : Finset ℕ) (A : ℕ → ℝ) (M : ℝ)
    (hfirst : (∑ q ∈ S, A q * q) = 1)
    (hmass : (∑ q ∈ S, A q) = M) :
    (∑ q ∈ S, A q * ((q : ℝ) - 1)) = 1 - M := by
  calc
    (∑ q ∈ S, A q * ((q : ℝ) - 1)) =
        (∑ q ∈ S, A q * q) - ∑ q ∈ S, A q := by
      rw [← Finset.sum_sub_distrib]
      apply Finset.sum_congr rfl
      intro q hq
      ring
    _ = 1 - M := by rw [hfirst, hmass]

/-- Exact scalar normalization of the first real cell. -/
theorem firstCell_length_normalization (N M : ℝ) (hN : 1 < N) :
    (N - 1) * (N / (N - 1) - 1) * M ^ 2 = M ^ 2 := by
  have hne : N - 1 ≠ 0 := by linarith
  field_simp
  ring

/-- Two-dimensional boundary-of-boundary telescope.  It shows that interior
double differences do not determine a positive boundary cost. -/
theorem rectangle_double_telescope (F : ℕ → ℕ → ℤ) (N : ℕ) :
    (∑ k ∈ Finset.range N, ∑ l ∈ Finset.range N,
      (F k l - F (k + 1) l - F k (l + 1) + F (k + 1) (l + 1))) =
      F 0 0 - F N 0 - F 0 N + F N N := by
  have hinner : ∀ k,
      (∑ l ∈ Finset.range N,
        (F k l - F (k + 1) l - F k (l + 1) + F (k + 1) (l + 1))) =
        (F k 0 - F (k + 1) 0) - (F k N - F (k + 1) N) := by
    intro k
    convert Finset.sum_range_sub'
      (fun l => F k l - F (k + 1) l) N using 1
    all_goals ring_nf
  simp_rw [hinner]
  rw [Finset.sum_sub_distrib]
  rw [Finset.sum_range_sub' (fun k => F k 0) N]
  rw [Finset.sum_range_sub' (fun k => F k N) N]
  ring

end BuildingBlocks.FactorialFloorDerivativeObstruction

#print axioms BuildingBlocks.FactorialFloorDerivativeObstruction.floorRow13_eq_one
#print axioms BuildingBlocks.FactorialFloorDerivativeObstruction.coeff13_sum
#print axioms BuildingBlocks.FactorialFloorDerivativeObstruction.coeff13_firstMoment
#print axioms BuildingBlocks.FactorialFloorDerivativeObstruction.floorRow13_difference_interior
#print axioms BuildingBlocks.FactorialFloorDerivativeObstruction.floorRow13_difference_terminal
#print axioms BuildingBlocks.FactorialFloorDerivativeObstruction.certificateDenominator_lt_numerator
#print axioms BuildingBlocks.FactorialFloorDerivativeObstruction.certificate_log_ratio_pos
#print axioms BuildingBlocks.FactorialFloorDerivativeObstruction.firstCell_sum_sub_one
#print axioms BuildingBlocks.FactorialFloorDerivativeObstruction.firstCell_length_normalization
#print axioms BuildingBlocks.FactorialFloorDerivativeObstruction.rectangle_double_telescope
