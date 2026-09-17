import BuildingBlocks.DistinctPrimeTent

open scoped BigOperators

namespace BuildingBlocks.DistinctPrimeDynamics

noncomputable def pairMass (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, distinctPrimePairWeight n

noncomputable def mixedMoment (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N,
    (n : ℝ) * (ArithmeticFunction.vonMangoldt n - distinctPrimePairWeight n)

noncomputable def mangoldtMass (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n / (n : ℝ)

/-- The real cell formula whose integer endpoint is the actual corrected area.
The compensator retains both the atom at 1 and Lebesgue measure on `[1,∞)`. -/
noncomputable def cell (N : ℕ) (x : ℝ) : ℝ :=
  x * pairMass N + mixedMoment N - x ^ 2 * mangoldtMass N +
    x ^ 2 / 2 * Real.log x + x ^ 2 / 4 - 1 / 4

noncomputable def slope (N : ℕ) (x : ℝ) : ℝ :=
  pairMass N - x * (2 * mangoldtMass N) + x * Real.log x + x

theorem cell_eq_sum (N : ℕ) (x : ℝ) :
    cell N x =
      (∑ n ∈ Finset.Icc 1 N, (x - n) * distinctPrimePairWeight n) +
      (∑ n ∈ Finset.Icc 1 N, (n : ℝ) * ArithmeticFunction.vonMangoldt n) -
      x ^ 2 * mangoldtMass N + x ^ 2 / 2 * Real.log x + x ^ 2 / 4 - 1 / 4 := by
  have h : x * pairMass N + mixedMoment N =
      (∑ n ∈ Finset.Icc 1 N, (x - n) * distinctPrimePairWeight n) +
      ∑ n ∈ Finset.Icc 1 N, (n : ℝ) * ArithmeticFunction.vonMangoldt n := by
    unfold pairMass mixedMoment
    rw [Finset.mul_sum, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro n _
    ring
  unfold cell
  rw [h]

/-- This is an identification with the existing actual arithmetic readout,
not a free coefficient model. -/
theorem cell_at_integer (N : ℕ) : cell N N = distinctPrimeArea N := by
  rw [cell_eq_sum, distinctPrimePairWeight_weighted_sum,
    distinctPrimeArea_eq_coprime_pairs]
  rfl

theorem pairMass_succ (N : ℕ) :
    pairMass (N + 1) = pairMass N + distinctPrimePairWeight (N + 1) := by
  exact Finset.sum_Icc_succ_top (by omega) _

theorem mixedMoment_succ (N : ℕ) :
    mixedMoment (N + 1) = mixedMoment N +
      (N + 1 : ℕ) * (ArithmeticFunction.vonMangoldt (N + 1) -
        distinctPrimePairWeight (N + 1)) := by
  exact Finset.sum_Icc_succ_top (by omega) _

theorem mangoldtMass_succ (N : ℕ) :
    mangoldtMass (N + 1) = mangoldtMass N +
      ArithmeticFunction.vonMangoldt (N + 1) / (N + 1 : ℕ) := by
  exact Finset.sum_Icc_succ_top (by omega) _

/-- The successor adds precisely the source at its actual integer label. -/
theorem cell_successor_difference (N : ℕ) (x : ℝ) :
    cell (N + 1) x - cell N x =
      (x - (N + 1 : ℕ)) * (distinctPrimePairWeight (N + 1) -
        (x + (N + 1 : ℕ)) * ArithmeticFunction.vonMangoldt (N + 1) /
          (N + 1 : ℕ)) := by
  have hn : ((N + 1 : ℕ) : ℝ) ≠ 0 := by positivity
  unfold cell
  rw [pairMass_succ, mixedMoment_succ, mangoldtMass_succ]
  field_simp
  ring

/-- Adjacent cell formulas meet at the newly revealed integer. -/
theorem cell_join (N : ℕ) :
    cell (N + 1) (N + 1 : ℕ) = cell N (N + 1 : ℕ) := by
  have h := cell_successor_difference N ((N + 1 : ℕ) : ℝ)
  simp only [sub_self, zero_mul] at h
  exact sub_eq_zero.mp h

theorem hasDerivAt_cell (N : ℕ) {x : ℝ} (hx : x ≠ 0) :
    HasDerivAt (cell N) (slope N x) x := by
  have hi := hasDerivAt_id x
  have hp : HasDerivAt (fun u : ℝ => u ^ 2) (2 * x) x := by
    convert hi.pow 2 using 1
    norm_num
  have h := ((((hi.mul_const (pairMass N)).add_const (mixedMoment N)).sub
    (hp.mul_const (mangoldtMass N))).add
      ((hp.div_const 2).mul (Real.hasDerivAt_log hx))).add (hp.div_const 4)
  convert h.sub_const (1 / 4 : ℝ) using 1
  dsimp [cell, slope]
  field_simp
  ring

theorem hasDerivAt_slope (N : ℕ) {x : ℝ} (hx : x ≠ 0) :
    HasDerivAt (slope N) (Real.log x + 2 - 2 * mangoldtMass N) x := by
  have hi := hasDerivAt_id x
  have h := (((hasDerivAt_const x (pairMass N)).sub
    (hi.mul_const (2 * mangoldtMass N))).add
      (hi.mul (Real.hasDerivAt_log hx))).add hi
  convert h using 1
  dsimp [slope]
  field_simp
  ring

/-- Prime powers and distinct-prime interactions give opposite impulse types. -/
theorem slope_jump (N : ℕ) :
    slope (N + 1) (N + 1 : ℕ) - slope N (N + 1 : ℕ) =
      distinctPrimePairWeight (N + 1) -
        2 * ArithmeticFunction.vonMangoldt (N + 1) := by
  have hn : ((N + 1 : ℕ) : ℝ) ≠ 0 := by positivity
  unfold slope
  rw [pairMass_succ, mangoldtMass_succ]
  field_simp
  ring

theorem distinctPrimePairWeight_prime_pow {p k : ℕ}
    (hp : p.Prime) (hk : 1 ≤ k) : distinctPrimePairWeight (p ^ k) = 0 := by
  rw [distinctPrimePairWeight, vonMangoldt_convolution_prime_pow hp hk,
    samePrimePairWeight_prime_pow hp hk, sub_self]

theorem slope_jump_prime_pow {N p k : ℕ} (hp : p.Prime) (hk : 1 ≤ k)
    (hN : N + 1 = p ^ k) :
    slope (N + 1) (N + 1 : ℕ) - slope N (N + 1 : ℕ) =
      -2 * Real.log p := by
  rw [slope_jump, hN, distinctPrimePairWeight_prime_pow hp hk,
    ArithmeticFunction.vonMangoldt_apply_pow (by omega : k ≠ 0),
    ArithmeticFunction.vonMangoldt_apply_prime hp]
  ring

theorem slope_jump_prime_pow_neg {N p k : ℕ} (hp : p.Prime) (hk : 1 ≤ k)
    (hN : N + 1 = p ^ k) :
    slope (N + 1) (N + 1 : ℕ) - slope N (N + 1 : ℕ) < 0 := by
  rw [slope_jump_prime_pow hp hk hN]
  have hlog : 0 < Real.log (p : ℝ) :=
    Real.log_pos (by exact_mod_cast hp.one_lt)
  linarith

theorem slope_jump_nonneg_of_not_prime_pow (N : ℕ)
    (hN : ¬IsPrimePow (N + 1)) :
    0 ≤ slope (N + 1) (N + 1 : ℕ) - slope N (N + 1 : ℕ) := by
  rw [slope_jump, ArithmeticFunction.vonMangoldt_eq_zero_iff.mpr hN]
  simpa only [mul_zero, sub_zero] using distinctPrimePairWeight_nonneg (N + 1)

/-- The compensating atom at 1 contributes the initial slope 1. -/
theorem initial_cell_and_slope : cell 1 1 = 0 ∧ slope 1 1 = 1 := by
  norm_num [cell, slope, pairMass, mixedMoment, mangoldtMass,
    distinctPrimePairWeight, samePrimePairWeight,
    ArithmeticFunction.mul_apply, Nat.divisorsAntidiagonal_one]

theorem curvature_jump (N : ℕ) (x : ℝ) :
    (Real.log x + 2 - 2 * mangoldtMass (N + 1)) -
      (Real.log x + 2 - 2 * mangoldtMass N) =
        -2 * ArithmeticFunction.vonMangoldt (N + 1) / (N + 1 : ℕ) := by
  rw [mangoldtMass_succ]
  ring

end BuildingBlocks.DistinctPrimeDynamics

