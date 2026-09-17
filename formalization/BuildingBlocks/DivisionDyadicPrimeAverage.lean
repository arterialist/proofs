import BuildingBlocks.MertensArithmetic
import BuildingBlocks.DivisionDyadicFactorial
import Mathlib.NumberTheory.Harmonic.Bounds

open BuildingBlocks.CoarsePrimitive BuildingBlocks.FloorCorrection BuildingBlocks.MertensTransfer
open scoped BigOperators

namespace BuildingBlocks

/-- The actual centered prime-power signal, averaged over all integer division histories. -/
noncomputable def dyadicDivisorPrimeDiscrepancy (N : ℕ) : ℝ :=
  ∑ d ∈ Finset.Icc 1 N,
    (psi (2 * N / d) - psi (N / d) - (N : ℝ) / (d : ℝ))

/-- Extending the dyadic division sum adds only cutoffs zero or one, where psi vanishes. -/
theorem sum_psi_two_mul_div_eq_logFactorial (N : ℕ) :
    (∑ d ∈ Finset.Icc 1 N, psi (2 * N / d)) = logFactorial (2 * N) := by
  rw [logFactorial_eq_sum_psi]
  apply Finset.sum_subset (Finset.Icc_subset_Icc_right (by omega : N ≤ 2 * N))
  intro d hd hnot
  obtain ⟨hd1, hd2⟩ := Finset.mem_Icc.mp hd
  have hdN : N < d := by
    simp only [Finset.mem_Icc] at hnot
    omega
  have hq : 2 * N / d < 2 :=
    (Nat.div_lt_iff_lt_mul hd1).mpr (by omega)
  have hqpos : 1 ≤ 2 * N / d := Nat.div_pos hd2 hd1
  have hone : 2 * N / d = (1 : ℕ) := by omega
  simp [hone, psi, Finset.sum_range_succ]

/-- Exact factorial identification, including d=1 and every upper-endpoint prime power. -/
theorem dyadicDivisorPrimeDiscrepancy_eq_factorial (N : ℕ) :
    dyadicDivisorPrimeDiscrepancy N =
      Real.log (((2 * N).factorial : ℝ) / (N.factorial : ℝ)) -
        (N : ℝ) * (harmonic N : ℝ) := by
  have hrecip : (∑ d ∈ Finset.Icc 1 N, (N : ℝ) / (d : ℝ)) =
      (N : ℝ) * (harmonic N : ℝ) := by
    simp only [harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast,
      Finset.mul_sum, div_eq_mul_inv]
  simp only [dyadicDivisorPrimeDiscrepancy, Finset.sum_sub_distrib]
  rw [sum_psi_two_mul_div_eq_logFactorial, ← logFactorial_eq_sum_psi, hrecip]
  simp only [logFactorial_eq_log]
  rw [Real.log_div (by positivity : ((2 * N).factorial : ℝ) ≠ 0)
    (by positivity : (N.factorial : ℝ) ≠ 0)]

theorem dyadicDivisorPrimeDiscrepancy_eq_neg_deficit (N : ℕ) :
    dyadicDivisorPrimeDiscrepancy N = -dyadicFactorialDeficit N := by
  rw [dyadicDivisorPrimeDiscrepancy_eq_factorial]
  unfold dyadicFactorialDeficit
  ring

/-- A strict uniform negative bound for the actual complete dyadic divisor signal. -/
theorem dyadicDivisorPrimeDiscrepancy_lt {N : ℕ} (hN : 1 ≤ N) :
    dyadicDivisorPrimeDiscrepancy N <
      -(N : ℝ) * (3 / 2 - Real.log 4) := by
  rw [dyadicDivisorPrimeDiscrepancy_eq_neg_deficit]
  have h := neg_lt_neg (dyadicFactorialDeficit_gt hN)
  simpa only [neg_mul] using h

theorem dyadicDivisorPrimeDiscrepancy_neg {N : ℕ} (hN : 1 ≤ N) :
    dyadicDivisorPrimeDiscrepancy N < 0 := by
  have h := dyadicDivisorPrimeDiscrepancy_lt hN
  have hNpos : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  have hp := mul_pos hNpos dyadicFactorial_margin_pos
  nlinarith

/-- The normalized actual arithmetic average has the same fixed negative margin. -/
theorem dyadicDivisorPrimeDiscrepancy_div_lt {N : ℕ} (hN : 1 ≤ N) :
    dyadicDivisorPrimeDiscrepancy N / (N : ℝ) < Real.log 4 - 3 / 2 := by
  have hNpos : (0 : ℝ) < N := by exact_mod_cast (show 0 < N by omega)
  apply (div_lt_iff₀ hNpos).mpr
  have h := dyadicDivisorPrimeDiscrepancy_lt hN
  nlinarith

end BuildingBlocks
