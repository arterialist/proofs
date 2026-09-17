import BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite
import BuildingBlocks.DirichletFutureObservationFinite

/-!
# Complete Möbius histories inside the finite additive Goldbach shell

The two source indices, divisor pairs, additive total, and cutoff remain
literal. Matching divisor labels are separated from distinct labels.
-/

namespace BuildingBlocks.CenteredGoldbachHistoryShellFinite

open scoped BigOperators ArithmeticFunction
open Finset Real
open BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite
open BuildingBlocks.DirichletFutureObservationFinite

noncomputable section

def historyWeight (de : ℕ × ℕ) : ℝ :=
  (ArithmeticFunction.moebius de.1 : ℝ) * log de.2

def pairHistory (m n : ℕ) : ℝ :=
  ∑ de ∈ m.divisorsAntidiagonal, ∑ fg ∈ n.divisorsAntidiagonal,
    historyWeight de * historyWeight fg

def diagonalHistory (m n : ℕ) : ℝ :=
  ∑ de ∈ m.divisorsAntidiagonal, ∑ fg ∈ n.divisorsAntidiagonal,
    if de.1 = fg.1 then historyWeight de * historyWeight fg else 0

def offDiagonalHistory (m n : ℕ) : ℝ :=
  ∑ de ∈ m.divisorsAntidiagonal, ∑ fg ∈ n.divisorsAntidiagonal,
    if de.1 ≠ fg.1 then historyWeight de * historyWeight fg else 0

theorem pairHistory_eq_prime_pair (m n : ℕ) :
    pairHistory m n =
      ArithmeticFunction.vonMangoldt m * ArithmeticFunction.vonMangoldt n := by
  rw [← divisorLogHistory_eq_vonMangoldt, ← divisorLogHistory_eq_vonMangoldt]
  unfold pairHistory divisorLogHistory
  rw [Finset.sum_mul_sum]
  apply Finset.sum_congr rfl
  intro de hde
  apply Finset.sum_congr rfl
  intro fg hfg
  rfl

theorem pairHistory_split (m n : ℕ) :
    pairHistory m n = diagonalHistory m n + offDiagonalHistory m n := by
  unfold pairHistory diagonalHistory offDiagonalHistory
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro de hde
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro fg hfg
  by_cases h : de.1 = fg.1 <;> simp [h]

def diagonalCoefficient (Y N : ℕ) : ℝ :=
  ∑ m ∈ Icc 1 Y, ∑ n ∈ Icc 1 Y,
    if m + n = N then diagonalHistory m n else 0

def offDiagonalCoefficient (Y N : ℕ) : ℝ :=
  ∑ m ∈ Icc 1 Y, ∑ n ∈ Icc 1 Y,
    if m + n = N then offDiagonalHistory m n else 0

/-- Literal reindexing from the ordered additive pair into its two complete
Möbius divisor histories, split by equality of the two divisor labels. -/
theorem primeCoefficient_history_split (Y N : ℕ) :
    truncatedPrimeCoefficient Y N =
      diagonalCoefficient Y N + offDiagonalCoefficient Y N := by
  unfold truncatedPrimeCoefficient diagonalCoefficient offDiagonalCoefficient
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro m hm
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  by_cases h : m + n = N
  · simp [h, ← pairHistory_eq_prime_pair, pairHistory_split]
  · simp [h]

/-- Equal divisor labels force the common label to divide the additive
sum, and hence to be odd when the additive total is odd. -/
theorem diagonal_label_dvd_total {m n N d e f : ℕ}
    (hm : m = d * e) (hn : n = d * f) (hN : m + n = N) : d ∣ N := by
  refine ⟨e + f, ?_⟩
  calc
    N = m + n := hN.symm
    _ = d * e + d * f := by rw [hm, hn]
    _ = d * (e + f) := by ring

theorem diagonal_label_odd_of_odd_total {m n N d e f : ℕ}
    (hm : m = d * e) (hn : n = d * f) (hN : m + n = N)
    (hodd : Odd N) : Odd d :=
  Odd.of_dvd_nat hodd (diagonal_label_dvd_total hm hn hN)

private theorem diagonal_summand_nonneg {m n : ℕ}
    {de fg : ℕ × ℕ} (hde : de ∈ m.divisorsAntidiagonal)
    (hfg : fg ∈ n.divisorsAntidiagonal) (h : de.1 = fg.1) :
    0 ≤ historyWeight de * historyWeight fg := by
  have he : (1 : ℝ) ≤ de.2 := by
    exact_mod_cast Nat.one_le_iff_ne_zero.mpr
      (Nat.ne_zero_of_mem_divisorsAntidiagonal hde).2
  have hf : (1 : ℝ) ≤ fg.2 := by
    exact_mod_cast Nat.one_le_iff_ne_zero.mpr
      (Nat.ne_zero_of_mem_divisorsAntidiagonal hfg).2
  have hlog := mul_nonneg (log_nonneg he) (log_nonneg hf)
  unfold historyWeight
  rw [h]
  convert mul_nonneg (sq_nonneg (ArithmeticFunction.moebius fg.1 : ℝ)) hlog using 1
  ring

theorem diagonalHistory_nonneg (m n : ℕ) : 0 ≤ diagonalHistory m n := by
  unfold diagonalHistory
  apply Finset.sum_nonneg
  intro de hde
  apply Finset.sum_nonneg
  intro fg hfg
  split_ifs with h
  · exact diagonal_summand_nonneg hde hfg h
  · exact le_rfl

theorem diagonalCoefficient_nonneg (Y N : ℕ) :
    0 ≤ diagonalCoefficient Y N := by
  unfold diagonalCoefficient
  apply Finset.sum_nonneg
  intro m hm
  apply Finset.sum_nonneg
  intro n hn
  split_ifs
  · exact diagonalHistory_nonneg m n
  · exact le_rfl

/-- The label-one term is the full logarithmic pair. All other matching
label terms are nonnegative. -/
theorem log_pair_le_diagonalHistory {m n : ℕ} (hm : 0 < m) (hn : 0 < n) :
    log m * log n ≤ diagonalHistory m n := by
  have hmemm : (1, m) ∈ m.divisorsAntidiagonal := by
    rw [Nat.mem_divisorsAntidiagonal]
    simp [hm.ne']
  have hmemn : (1, n) ∈ n.divisorsAntidiagonal := by
    rw [Nat.mem_divisorsAntidiagonal]
    simp [hn.ne']
  have hterm (de : ℕ × ℕ) (hde : de ∈ m.divisorsAntidiagonal)
      (fg : ℕ × ℕ) (hfg : fg ∈ n.divisorsAntidiagonal) :
      0 ≤ if de.1 = fg.1 then historyWeight de * historyWeight fg else 0 := by
    split_ifs with h
    · exact diagonal_summand_nonneg hde hfg h
    · exact le_rfl
  have hinner :
      (if (1 : ℕ) = 1 then historyWeight (1, m) * historyWeight (1, n) else 0) ≤
        ∑ fg ∈ n.divisorsAntidiagonal,
          if (1 : ℕ) = fg.1 then historyWeight (1, m) * historyWeight fg else 0 := by
    exact Finset.single_le_sum (hterm (1, m) hmemm) hmemn
  have houter :
      (∑ fg ∈ n.divisorsAntidiagonal,
          if (1 : ℕ) = fg.1 then historyWeight (1, m) * historyWeight fg else 0) ≤
        diagonalHistory m n := by
    unfold diagonalHistory
    apply Finset.single_le_sum (s := m.divisorsAntidiagonal) (a := (1, m))
      (f := fun de => ∑ fg ∈ n.divisorsAntidiagonal,
        if de.1 = fg.1 then historyWeight de * historyWeight fg else 0)
    · intro de hde
      exact Finset.sum_nonneg (hterm de hde)
    · exact hmemm
  calc
    log m * log n = historyWeight (1, m) * historyWeight (1, n) := by
      simp [historyWeight]
    _ ≤ _ := by simpa using hinner
    _ ≤ _ := houter

/-- Distinct divisor labels supply a nonpositive correction to the
matching-label block, already for each ordered source pair. -/
theorem offDiagonalHistory_nonpos {m n : ℕ} (hm : 0 < m) (hn : 0 < n) :
    offDiagonalHistory m n ≤ 0 := by
  have hprime := pairHistory_eq_prime_pair m n
  have hsplit := pairHistory_split m n
  have hbound := log_pair_le_diagonalHistory hm hn
  have hm0 := ArithmeticFunction.vonMangoldt_nonneg (n := m)
  have hn0 := ArithmeticFunction.vonMangoldt_nonneg (n := n)
  have hmle := ArithmeticFunction.vonMangoldt_le_log (n := m)
  have hnle := ArithmeticFunction.vonMangoldt_le_log (n := n)
  have hmul : ArithmeticFunction.vonMangoldt m * ArithmeticFunction.vonMangoldt n ≤
      log m * log n := by
    calc
      _ ≤ log m * ArithmeticFunction.vonMangoldt n :=
        mul_le_mul_of_nonneg_right hmle hn0
      _ ≤ log m * log n :=
        mul_le_mul_of_nonneg_left hnle (hm0.trans hmle)
  linarith

theorem offDiagonalCoefficient_nonpos (Y N : ℕ) :
    offDiagonalCoefficient Y N ≤ 0 := by
  unfold offDiagonalCoefficient
  apply Finset.sum_nonpos
  intro m hm
  apply Finset.sum_nonpos
  intro n hn
  split_ifs
  · exact offDiagonalHistory_nonpos (mem_Icc.mp hm).1 (mem_Icc.mp hn).1
  · exact le_rfl

/-- First nonzero distinct-label correction: `(2,4)` uses the genuine
prime-power history `4=2^2`. -/
theorem offDiagonalHistory_two_four :
    offDiagonalHistory 2 4 = -(log 2) ^ 2 := by
  have h2 : (2 : ℕ).divisorsAntidiagonal = {(1,2),(2,1)} := by decide
  have h4 : (4 : ℕ).divisorsAntidiagonal = {(1,4),(2,2),(4,1)} := by decide
  rw [offDiagonalHistory, h2, h4]
  norm_num [historyWeight, ArithmeticFunction.moebius_apply_prime Nat.prime_two]
  ring

theorem offDiagonalCoefficient_four_six :
    offDiagonalCoefficient 4 6 = -2 * (log 2) ^ 2 := by
  have h2 : (2 : ℕ).divisorsAntidiagonal = {(1,2),(2,1)} := by decide
  have h3 : (3 : ℕ).divisorsAntidiagonal = {(1,3),(3,1)} := by decide
  have h4 : (4 : ℕ).divisorsAntidiagonal = {(1,4),(2,2),(4,1)} := by decide
  have hI : Finset.Icc 1 4 = {1,2,3,4} := by decide
  rw [offDiagonalCoefficient, hI]
  norm_num [offDiagonalHistory, historyWeight, h2, h3, h4,
    ArithmeticFunction.moebius_apply_prime Nat.prime_two,
    ArithmeticFunction.moebius_apply_prime (show Nat.Prime 3 by decide)]
  ring

theorem offDiagonalCoefficient_four_six_neg :
    offDiagonalCoefficient 4 6 < 0 := by
  rw [offDiagonalCoefficient_four_six]
  have h2 : 0 < log 2 := log_pos (by norm_num)
  nlinarith [sq_pos_of_pos h2]

#print axioms pairHistory_eq_prime_pair
#print axioms pairHistory_split
#print axioms primeCoefficient_history_split
#print axioms diagonal_label_odd_of_odd_total
#print axioms diagonalCoefficient_nonneg
#print axioms log_pair_le_diagonalHistory
#print axioms offDiagonalCoefficient_nonpos
#print axioms offDiagonalCoefficient_four_six_neg

end
end BuildingBlocks.CenteredGoldbachHistoryShellFinite
