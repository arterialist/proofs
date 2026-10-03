import BuildingBlocks.ActualFullCenteredMellin
import BuildingBlocks.ActualPrimeErrorBridge
import BuildingBlocks.ActualEq22Residual
import BuildingBlocks.ActualEq22PairDilation
import BuildingBlocks.ActualEq22ForwardMellin

/-! Native arithmetic identification of the original Eq22 residual.

The object is literally Rnum - Tnum. Complete pair dilation, density, baseline,
origin and equality rows are retained. The final original Mellin module uses
this identification for initial-line reconstruction. The existing contour upper
remains written and unformalized; stronger arithmetic estimates and the eventual
RH sign remain open. -/

namespace BuildingBlocks.ActualEq22ArithmeticIdentity

open Finset ActualPrimeCutoffCovarianceFinite DensityPrimeCovarianceFinite
open ActualVolterraIdentity ActualPrimeErrorBridge ActualEq22Residual
open PrimeHistoryDivisorResponse PrimeScoreDivisorIdentity

noncomputable section

def C_literal (x : ℝ) : ℝ := Rnum x - Tnum x

def P (n : ℕ) : ℝ :=
  ∑ m ∈ n.divisors, Real.sqrt m *
    (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) m

theorem cofactor_row (N : ℕ) (x : ℝ) (hNx : (N : ℝ) ≤ x) (c : ℕ → ℝ) :
    (∑ d ∈ Icc 1 N, ∑ m ∈ Icc 1 (N / d),
      Real.sqrt d * (x / d - m) * c m) =
    ∑ n ∈ Icc 1 N, cutoffWeight x n *
      (∑ m ∈ n.divisors, Real.sqrt m * c m) := by
  classical
  rw [← HyperbolaProduct.sum_divisors_eq_sum_factor_pairs N
    (fun d m => Real.sqrt d * (x / d - m) * c m)]
  apply sum_congr rfl
  intro n hn
  obtain ⟨hn1, hnN⟩ := mem_Icc.mp hn
  have hnx : (n : ℝ) ≤ x := (by exact_mod_cast hnN : (n : ℝ) ≤ N).trans hNx
  calc
    _ = ∑ d ∈ n.divisors,
        cutoffWeight x n * Real.sqrt (n / d : ℕ) * c (n / d) := by
      apply sum_congr rfl
      intro d hd
      have hdvd := (Nat.mem_divisors.mp hd).1
      have hd0 := Nat.pos_of_dvd_of_pos hdvd hn1
      have hm0 := Nat.div_pos (Nat.le_of_dvd hn1 hdvd) hd0
      have hmul : d * (n / d) = n := by
        simpa [Nat.mul_comm] using Nat.div_mul_cancel hdvd
      have hcut : (d : ℝ) * (n / d : ℕ) ≤ x := by
        have he : (d : ℝ) * (n / d : ℕ) = n := by exact_mod_cast hmul
        rwa [he]
      simpa [hmul] using cofactor_tent_weight c hd0 hm0 hcut
    _ = _ := by
      simp_rw [mul_assoc]
      rw [← mul_sum]
      congr 1
      exact Nat.sum_div_divisors n (fun m => Real.sqrt (m : ℝ) * c m)

theorem baseline_scalar {x : ℝ} {n : ℕ} (hn : 0 < n) (hnx : (n : ℝ) ≤ x) :
    Real.sqrt n * (EtaBaselineMellin.B (x / n)).re =
      cutoffWeight x n * (1 + (x / n - 1) + R (x / n - 1)) := by
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  have hroot : Real.sqrt (n : ℝ) ≠ 0 := (Real.sqrt_pos.2 hnR).ne'
  have hsq : (Real.sqrt (n : ℝ)) ^ 2 = n := Real.sq_sqrt hnR.le
  rcases hnx.lt_or_eq with hlt | heq
  · have hratio : 1 < x / (n : ℝ) := (one_lt_div hnR).mpr hlt
    have hgap : x / n - 1 ≠ 0 := ne_of_gt (sub_pos.mpr hratio)
    have hxn0 : x - (n : ℝ) ≠ 0 := ne_of_gt (sub_pos.mpr hlt)
    have hh : 1 + (x / n - 1) = x / n := by ring
    have hb : (EtaBaselineMellin.B (x / n)).re =
        (x / n) ^ 2 / 2 * Real.log (x / n) + (x / n) ^ 2 / 4 - 1 / 4 := by
      have hbc : EtaBaselineMellin.B (x / n) =
          (((x / n) ^ 2 / 2 * Real.log (x / n) + (x / n) ^ 2 / 4 - 1 / 4 : ℝ) : ℂ) := by
        simp only [EtaBaselineMellin.B, if_pos hratio]
        push_cast
        ring
      simpa only [Complex.ofReal_re] using congrArg Complex.re hbc
    rw [hb]
    rw [cutoffWeight, if_pos hlt]
    unfold R
    rw [hh]
    field_simp [hgap, hxn0, hroot, hnR.ne']
    rw [hsq]
    ring
  · rw [← heq]
    simp [EtaBaselineMellin.B, cutoffWeight, hnR.ne']

theorem fullNumerator_eq_sample {x : ℝ} (hx : 1 ≤ x) :
    (ActualFullCenteredMellin.fullNumerator x).re =
      ∑ n ∈ Icc 1 ⌊x⌋₊, cutoffWeight x n *
        (P n - (1 + x / n) * completeScore n +
          (1 + (x / n - 1) + R (x / n - 1))) := by
  have hNx : (⌊x⌋₊ : ℝ) ≤ x := Nat.floor_le (by linarith)
  rw [ActualFullCenteredMellin.fullNumerator_eq_real_sum]
  simp only [Complex.ofReal_re]
  have hcore : ∀ d ∈ Icc 1 ⌊x⌋₊,
      (ActualCenteredMellin.N (x / d)).re =
        (∑ m ∈ Icc 1 (⌊x⌋₊ / d),
          ((x / d - m) * (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) m -
            ArithmeticFunction.vonMangoldt m * (((x / d) ^ 2 - (m : ℝ) ^ 2) / m))) +
          (EtaBaselineMellin.B (x / d)).re := by
    intro d hd
    have hd0 : (0 : ℝ) < d := by exact_mod_cast (mem_Icc.mp hd).1
    have hh := congrArg Complex.re
      (ActualFullCenteredMellin.N_eq_real_cutoff (x := x / d) (by positivity))
    simpa only [Complex.add_re, Complex.ofReal_re, Nat.floor_div_natCast] using hh
  have hdecomp :
      (∑ d ∈ Icc 1 ⌊x⌋₊, Real.sqrt d * (ActualCenteredMellin.N (x / d)).re) =
      (∑ d ∈ Icc 1 ⌊x⌋₊, ∑ m ∈ Icc 1 (⌊x⌋₊ / d),
        Real.sqrt d * (x / d - m) *
          (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) m) -
      (∑ d ∈ Icc 1 ⌊x⌋₊, ∑ m ∈ Icc 1 (⌊x⌋₊ / d),
        Real.sqrt d * ArithmeticFunction.vonMangoldt m *
          ((x / d) ^ 2 - (m : ℝ) ^ 2) / m) +
      (∑ d ∈ Icc 1 ⌊x⌋₊, Real.sqrt d * (EtaBaselineMellin.B (x / d)).re) := by
    rw [← sum_sub_distrib, ← sum_add_distrib]
    apply sum_congr rfl
    intro d hd
    rw [hcore d hd, mul_add, mul_sum, ← sum_sub_distrib]
    congr 1
    apply sum_congr rfl
    intro m hm
    ring
  rw [hdecomp]
  rw [cofactor_row ⌊x⌋₊ x hNx,
    mixed_row_reindex ⌊x⌋₊ x hNx]
  have hbase : (∑ d ∈ Icc 1 ⌊x⌋₊,
      Real.sqrt d * (EtaBaselineMellin.B (x / d)).re) =
      ∑ d ∈ Icc 1 ⌊x⌋₊,
        cutoffWeight x d * (1 + (x / d - 1) + R (x / d - 1)) := by
    apply sum_congr rfl
    intro d hd
    exact baseline_scalar (mem_Icc.mp hd).1
      ((by exact_mod_cast (mem_Icc.mp hd).2 : (d : ℝ) ≤ ⌊x⌋₊).trans hNx)
  rw [hbase, ← sum_sub_distrib, ← sum_add_distrib]
  apply sum_congr rfl
  intro n hn
  rw [weighted_divisor_prime_score (Nat.ne_of_gt (mem_Icc.mp hn).1)]
  unfold P completeScore
  ring

theorem Aold_eq_score_sub_mass {x : ℝ} (hx : 1 ≤ x) :
    Aold x = scoreMassOn ⌊x⌋₊ x - Z x - densityMass ⌊x⌋₊ x / 2 := by
  have h := Araw_eq_neg_Z_sub_Aold hx
  change densityMass ⌊x⌋₊ x / 2 - scoreMassOn ⌊x⌋₊ x = -Z x - Aold x at h
  linarith

theorem fullNumerator_eq_six_rows {x : ℝ} (hx : 1 ≤ x) :
    (ActualFullCenteredMellin.fullNumerator x).re =
      (∑ n ∈ Icc 1 ⌊x⌋₊, cutoffWeight x n * P n) - Dnum x -
        2 * scoreMassOn ⌊x⌋₊ x + Z x + densityMass ⌊x⌋₊ x + Rnum x := by
  rw [fullNumerator_eq_sample hx]
  unfold Dnum DnumOn Z cutoffMass densityMass Rnum RnumOn scoreMassOn
  rw [mul_sum]
  simp only [← sum_sub_distrib, ← sum_add_distrib]
  apply sum_congr rfl
  intro n hn
  unfold densityScore
  ring

theorem literal_identity_of_native_pair_row {x : ℝ} (hx : 1 ≤ x)
    (hpair : Tnum x = Dnum x -
      ∑ n ∈ Icc 1 ⌊x⌋₊, cutoffWeight x n * P n) :
    C_literal x = (ActualFullCenteredMellin.fullNumerator x).re + 2 * Aold x + Z x := by
  rw [C_literal, hpair, fullNumerator_eq_six_rows hx, Aold_eq_score_sub_mass hx]
  ring

theorem literal_identity_with_pair_defect {x : ℝ} (hx : 1 ≤ x) :
    C_literal x = (ActualFullCenteredMellin.fullNumerator x).re + 2 * Aold x + Z x +
      (Dnum x - Tnum x - ∑ n ∈ Icc 1 ⌊x⌋₊, cutoffWeight x n * P n) := by
  rw [C_literal, fullNumerator_eq_six_rows hx, Aold_eq_score_sub_mass hx]
  ring

theorem literal_identity {x : ℝ} (hx : 1 ≤ x) :
    C_literal x = (ActualFullCenteredMellin.fullNumerator x).re + 2 * Aold x + Z x := by
  apply literal_identity_of_native_pair_row hx
  simpa only [P] using ActualEq22PairDilation.Tnum_eq_Dnum_sub_full_pair x

theorem literal_normalized_identity {x : ℝ} (hx : 1 ≤ x) :
    Rnum x - Tnormalized x =
      (ActualFullCenteredMellin.fullNumerator x).re + 2 * Aold x + Z x := by
  rw [← Tnum_eq_Tnormalized hx]
  exact literal_identity hx

theorem complex_literal_identity {x : ℝ} (hx : 1 ≤ x) :
    (C_literal x : ℂ) = ActualFullCenteredMellin.fullNumerator x +
      ((2 * Aold x + Z x : ℝ) : ℂ) := by
  apply Complex.ext
  · simpa only [Complex.ofReal_re, Complex.add_re, add_assoc] using literal_identity hx
  · simp only [Complex.ofReal_im, Complex.add_im,
      ActualFullCenteredMellin.fullNumerator_real, zero_add]

theorem literal_eq_forwardC {x : ℝ} (hx : 1 ≤ x) :
    (C_literal x : ℂ) = ActualEq22ForwardMellin.C x := by
  rw [complex_literal_identity hx, ActualEq22ForwardMellin.C_eq_corrected_actual_row (by linarith)]
  push_cast
  ring

end
end BuildingBlocks.ActualEq22ArithmeticIdentity
