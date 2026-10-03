import BuildingBlocks.ActualEq22Residual
import Mathlib.Tactic

/-! Native full-pair dilation for the original Eq22 residual.

The finite identities retain every ordered Mangoldt pair, proper prime power,
cofactor and real cutoff. They support the original arithmetic identification
and initial-line Mellin inversion. The existing contour upper remains written
and unformalized; stronger arithmetic estimates and the eventual RH sign remain open. -/

open Finset
open scoped BigOperators

namespace BuildingBlocks.ActualEq22PairDilation

open ActualPrimeCutoffCovarianceFinite ActualVolterraIdentity ActualEq22Residual

noncomputable section

def weightedLambda : ArithmeticFunction ℝ :=
  ⟨fun n => Real.sqrt (n : ℝ) * ArithmeticFunction.vonMangoldt n, by simp⟩

theorem weightedLambda_mul (n : ℕ) :
    (weightedLambda * weightedLambda) n = Real.sqrt (n : ℝ) *
      (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n := by
  simp only [ArithmeticFunction.mul_apply, weightedLambda, ArithmeticFunction.coe_mk]
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro p hp
  obtain ⟨hprod, hn⟩ := Nat.mem_divisorsAntidiagonal.mp hp
  have hroot : Real.sqrt (n : ℝ) = Real.sqrt (p.1 : ℝ) * Real.sqrt (p.2 : ℝ) := by
    rw [← hprod, Nat.cast_mul, Real.sqrt_mul (Nat.cast_nonneg p.1)]
  rw [hroot]
  ring

theorem weightedLambda_zeta (n : ℕ) :
    (weightedLambda * (ArithmeticFunction.zeta : ArithmeticFunction ℝ)) n =
      completeScore n := by
  rw [ArithmeticFunction.coe_mul_zeta_apply]
  change (∑ q ∈ n.divisors, Real.sqrt (q : ℝ) * ArithmeticFunction.vonMangoldt q) = _
  by_cases hn : n = 0
  · subst n
    simp [completeScore]
  · exact PrimeScoreDivisorIdentity.weighted_divisor_prime_score hn

theorem pair_divisor_assoc (n : ℕ) :
    (∑ q ∈ n.divisors, Real.sqrt (q : ℝ) * ArithmeticFunction.vonMangoldt q *
      completeScore (n / q)) =
    ∑ m ∈ n.divisors, Real.sqrt (m : ℝ) *
      (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) m := by
  have hleft : (weightedLambda *
      (weightedLambda * (ArithmeticFunction.zeta : ArithmeticFunction ℝ))) n =
      ∑ q ∈ n.divisors, Real.sqrt (q : ℝ) * ArithmeticFunction.vonMangoldt q *
        completeScore (n / q) := by
    rw [ArithmeticFunction.mul_apply]
    rw [Nat.sum_divisorsAntidiagonal
      (fun a b => weightedLambda a *
        (weightedLambda * (ArithmeticFunction.zeta : ArithmeticFunction ℝ)) b)]
    apply Finset.sum_congr rfl
    intro q hq
    rw [weightedLambda_zeta]
    rfl
  rw [← hleft, ← mul_assoc, ArithmeticFunction.coe_mul_zeta_apply]
  apply Finset.sum_congr rfl
  intro m hm
  exact weightedLambda_mul m

theorem scoreMass_stable {M N : ℕ} {x : ℝ}
    (hMN : M ≤ N) (hx : x ≤ (M : ℝ) + 1) :
    scoreMassOn N x = scoreMassOn M x := by
  unfold scoreMassOn
  symm
  apply Finset.sum_subset
  · intro n hn
    exact Finset.mem_Icc.mpr ⟨(Finset.mem_Icc.mp hn).1,
      (Finset.mem_Icc.mp hn).2.trans hMN⟩
  · intro n hnN hnM
    have hnlarge : M < n := by
      have hnlo := (Finset.mem_Icc.mp hnN).1
      have hnot : ¬ n ≤ M := by
        intro hnle
        exact hnM (Finset.mem_Icc.mpr ⟨hnlo, hnle⟩)
      omega
    have hxn : ¬ (n : ℝ) < x := by
      have : (M : ℝ) + 1 ≤ (n : ℝ) := by exact_mod_cast hnlarge
      exact not_lt.mpr (hx.trans this)
    simp [cutoffWeight, hxn]

theorem cutoff_score_dilation {N a : ℕ} {x : ℝ}
    (ha : 0 < a) (hx : x ≤ (N : ℝ) + 1) :
    (∑ n ∈ Finset.Icc 1 N, cutoffWeight x n *
      (if a ∣ n then Real.sqrt (a : ℝ) * completeScore (n / a) else 0)) =
      (a : ℝ) * scoreMassOn N (x / a) := by
  calc
    _ = Real.sqrt (a : ℝ) *
      (∑ n ∈ Finset.Icc 1 N,
        if a ∣ n then cutoffWeight x n * completeScore (n / a) else 0) := by
          rw [Finset.mul_sum]
          apply Finset.sum_congr rfl
          intro n hn
          split_ifs <;> ring
    _ = Real.sqrt (a : ℝ) * (Real.sqrt (a : ℝ) *
      ∑ d ∈ Finset.Icc 1 (N / a), cutoffWeight (x / a) d * completeScore d) := by
          rw [cutoff_multiples_sum_weighted N a x (fun n => completeScore (n / a)) ha]
          simp only [Nat.mul_div_cancel_left _ ha]
    _ = (a : ℝ) * scoreMassOn N (x / a) := by
          have hs := scoreMass_stable (Nat.div_le_self N a) (cutoff_dilated_endpoint ha hx)
          change Real.sqrt (a : ℝ) * (Real.sqrt (a : ℝ) * scoreMassOn (N/a) (x/a)) = _
          rw [← mul_assoc, Real.mul_self_sqrt (Nat.cast_nonneg a), ← hs]

theorem divisor_sum_eq_cutoff (N n : ℕ) (hn : n ∈ Finset.Icc 1 N) (f : ℕ → ℝ) :
    (∑ q ∈ n.divisors, f q) =
      ∑ q ∈ Finset.Icc 1 N, if q ∣ n then f q else 0 := by
  obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hn
  have hn0 : n ≠ 0 := by omega
  have hsub : n.divisors ⊆ Finset.Icc 1 N := by
    intro q hq
    obtain ⟨hdiv, _⟩ := Nat.mem_divisors.mp hq
    exact Finset.mem_Icc.mpr
      ⟨Nat.pos_of_dvd_of_pos hdiv hn1, (Nat.le_of_dvd hn1 hdiv).trans hnN⟩
  calc
    _ = ∑ q ∈ n.divisors, if q ∣ n then f q else 0 := by
      apply Finset.sum_congr rfl
      intro q hq
      simp [(Nat.mem_divisors.mp hq).1]
    _ = _ := by
      apply Finset.sum_subset hsub
      intro q hq hnot
      have hnd : ¬q ∣ n := by
        intro hd
        exact hnot (Nat.mem_divisors.mpr ⟨hd, hn0⟩)
      simp [hnd]

theorem score_dilation_eq_full_pair {N : ℕ} {x : ℝ}
    (hx : x ≤ (N : ℝ) + 1) :
    (∑ q ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt q *
      (q : ℝ) * scoreMassOn N (x / q)) =
    ∑ n ∈ Finset.Icc 1 N, cutoffWeight x n *
      (∑ m ∈ n.divisors, Real.sqrt (m : ℝ) *
        (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) m) := by
  symm
  calc
    _ = ∑ n ∈ Finset.Icc 1 N, cutoffWeight x n *
      (∑ q ∈ Finset.Icc 1 N, if q ∣ n then
        Real.sqrt (q : ℝ) * ArithmeticFunction.vonMangoldt q * completeScore (n/q)
        else 0) := by
          apply Finset.sum_congr rfl
          intro n hn
          rw [← pair_divisor_assoc n, divisor_sum_eq_cutoff N n hn]
    _ = ∑ q ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt q *
      (∑ n ∈ Finset.Icc 1 N, cutoffWeight x n *
        (if q ∣ n then Real.sqrt (q : ℝ) * completeScore (n/q) else 0)) := by
          simp_rw [Finset.mul_sum]
          rw [Finset.sum_comm]
          apply Finset.sum_congr rfl
          intro q hq
          apply Finset.sum_congr rfl
          intro n hn
          split_ifs <;> ring
    _ = _ := by
          apply Finset.sum_congr rfl
          intro q hq
          rw [cutoff_score_dilation (Finset.mem_Icc.mp hq).1 hx]
          ring

theorem TnumOn_eq_DnumOn_sub_full_pair {N : ℕ} {x : ℝ}
    (hx : x ≤ (N : ℝ) + 1) :
    TnumOn N x = DnumOn N x -
      ∑ n ∈ Finset.Icc 1 N, cutoffWeight x n *
        (∑ m ∈ n.divisors, Real.sqrt (m : ℝ) *
          (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) m) := by
  unfold TnumOn
  simp_rw [mul_sub]
  rw [Finset.sum_sub_distrib, score_dilation_eq_full_pair hx,
    DnumOn_eq_prime_dilation hx]
  simp only [mul_assoc]

theorem Tnum_eq_Dnum_sub_full_pair (x : ℝ) :
    Tnum x = Dnum x -
      ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, cutoffWeight x n *
        (∑ m ∈ n.divisors, Real.sqrt (m : ℝ) *
          (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) m) := by
  have hx : x ≤ (⌊x⌋₊ : ℝ) + 1 := (Nat.lt_floor_add_one x).le
  simpa only [Tnum, Dnum] using TnumOn_eq_DnumOn_sub_full_pair hx

end
end BuildingBlocks.ActualEq22PairDilation
