import Mathlib

/-!
Finite arithmetic and scalar reduction for the actual isolated prime-power
two-packet Weil calculation. Analytic support geometry, gamma bilinear
identification, and Zhu's inequality are explicitly named inputs.
This file asserts no positivity on the full Weil test space.
-/

namespace BuildingBlocks.ActualWeilIsolatedPrimePowerCone

open ArithmeticFunction

/-- The complete active prime-power row on a finite set of integer bases.
    vonMangoldt is zero at every non-prime-power integer. -/
noncomputable def primeRow (S : Finset ℕ) (corr : ℕ → ℝ) : ℝ :=
  ∑ n ∈ S, -2 * vonMangoldt n / Real.sqrt n * corr n

/-- Exact isolation of the one active prime-power correlation, assuming
    the geometric support facts at all other active integer bases. -/
theorem primeRow_eq_isolated
    (S : Finset ℕ) (q : ℕ) (corr : ℕ → ℝ) (gSq : ℝ)
    (hq : q ∈ S)
    (hother : ∀ n ∈ S, n ≠ q → corr n = 0)
    (hqCorr : corr q = -gSq) :
    primeRow S corr = 2 * vonMangoldt q / Real.sqrt q * gSq := by
  have hsum :
      (∑ n ∈ S, -2 * vonMangoldt n / Real.sqrt n * corr n) =
        -2 * vonMangoldt q / Real.sqrt q * corr q := by
    apply Finset.sum_eq_single q
    · intro n hn hnq
      simp [hother n hn hnq]
    · intro hn
      exact (hn hq).elim
  rw [primeRow, hsum, hqCorr]
  ring

/-- The literal Mangoldt coefficient at every positive prime power. -/
theorem vonMangoldt_prime_pow (p j : ℕ)
    (hp : Nat.Prime p) (hj : 0 < j) :
    vonMangoldt (p ^ j) = Real.log p := by
  have hj0 : j ≠ 0 := by omega
  rw [vonMangoldt_apply_pow hj0]
  exact vonMangoldt_apply_prime hp

/-- Complete finite row for q=p^j, including all other active prime powers
    via their exact support zeros. -/
theorem primeRow_eq_prime_pow
    (S : Finset ℕ) (p j : ℕ) (corr : ℕ → ℝ) (gSq : ℝ)
    (hp : Nat.Prime p) (hj : 0 < j)
    (hq : p ^ j ∈ S)
    (hother : ∀ n ∈ S, n ≠ p ^ j → corr n = 0)
    (hqCorr : corr (p ^ j) = -gSq) :
    primeRow S corr =
      2 * Real.log p / Real.sqrt (p ^ j : ℕ) * gSq := by
  rw [primeRow_eq_isolated S (p ^ j) corr gSq hq hother hqCorr,
    vonMangoldt_prime_pow p j hp hj]

/-- The all-integer support hypothesis can itself be derived from named
    log-spacing and correlation-support implications. -/
theorem primeRow_eq_prime_pow_of_support
    (S : Finset ℕ) (p j : ℕ) (corr : ℕ → ℝ) (gSq w : ℝ)
    (hp : Nat.Prime p) (hj : 0 < j)
    (hq : p ^ j ∈ S)
    (hspacing : ∀ n ∈ S, n ≠ p ^ j →
      w < |Real.log (n : ℝ) - Real.log (p ^ j : ℕ)|)
    (hcorrSupport : ∀ n ∈ S,
      w < |Real.log (n : ℝ) - Real.log (p ^ j : ℕ)| → corr n = 0)
    (hqCorr : corr (p ^ j) = -gSq) :
    primeRow S corr =
      2 * Real.log p / Real.sqrt (p ^ j : ℕ) * gSq := by
  apply primeRow_eq_prime_pow S p j corr gSq hp hj hq
  · intro n hn hnq
    exact hcorrSupport n hn (hspacing n hn hnq)
  · exact hqCorr

/-- The scalar expression left after exact prime-row isolation. -/
def twoPacketQ (gammaSelf gammaCross coeff gSq : ℝ) : ℝ :=
  2 * gammaSelf - 2 * gammaCross + 2 * coeff * gSq

private theorem log_gap_right_real {q n : ℝ}
    (hq : 8 ≤ q) (hn : q + 1 ≤ n) :
    1 / (4 * q) < Real.log n - Real.log q := by
  have hqpos : 0 < q := by linarith
  have hnpos : 0 < n := by linarith
  have hr : 0 < n / q := div_pos hnpos hqpos
  have hlog := Real.one_sub_inv_le_log_of_pos hr
  rw [Real.log_div hnpos.ne' hqpos.ne'] at hlog
  have hinv : (n / q)⁻¹ = q / n := by field_simp
  rw [hinv] at hlog
  have hcross : n < 4 * q * (n - q) := by
    nlinarith [mul_nonneg
      (show 0 ≤ 4 * q - 1 by linarith)
      (show 0 ≤ n - q - 1 by linarith)]
  have hbound : 1 / (4 * q) < 1 - q / n := by
    field_simp
    nlinarith
  exact lt_of_lt_of_le hbound hlog

private theorem log_gap_left_real {q n : ℝ}
    (hq : 8 ≤ q) (hnpos : 0 < n) (hn : n + 1 ≤ q) :
    1 / (4 * q) < Real.log q - Real.log n := by
  have hqpos : 0 < q := by linarith
  have hr : 0 < q / n := div_pos hqpos hnpos
  have hlog := Real.one_sub_inv_le_log_of_pos hr
  rw [Real.log_div hqpos.ne' hnpos.ne'] at hlog
  have hinv : (q / n)⁻¹ = n / q := by field_simp
  rw [hinv] at hlog
  have hbound : 1 / (4 * q) < 1 - n / q := by
    field_simp
    nlinarith
  exact lt_of_lt_of_le hbound hlog

/-- Nearest-integer spacing for the exact window w=1/(4q).
    The proof applies to every integer base, so no prime powers are omitted. -/
theorem isolated_log_spacing (q n : ℕ)
    (hq : 8 ≤ q) (hn : 2 ≤ n) (hne : n ≠ q) :
    (1 : ℝ) / (4 * q) <
      |Real.log (n : ℝ) - Real.log (q : ℝ)| := by
  rcases lt_or_gt_of_ne hne with hlt | hgt
  · have hnq : n + 1 ≤ q := by omega
    have hnqr : (n : ℝ) + 1 ≤ (q : ℝ) := by exact_mod_cast hnq
    have hnpos : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
    have h := log_gap_left_real (show (8 : ℝ) ≤ q by exact_mod_cast hq)
      hnpos hnqr
    have hlog : Real.log (n : ℝ) - Real.log (q : ℝ) < 0 := by
      have hnlt : (n : ℝ) < q := by exact_mod_cast hlt
      have hpos : (0 : ℝ) < n := hnpos
      linarith [Real.log_lt_log hpos hnlt]
    rw [abs_of_neg hlog]
    linarith
  · have hnq : q + 1 ≤ n := by omega
    have hnqr : (q : ℝ) + 1 ≤ (n : ℝ) := by exact_mod_cast hnq
    have h := log_gap_right_real
      (show (8 : ℝ) ≤ q by exact_mod_cast hq) hnqr
    have hlog : 0 < Real.log (n : ℝ) - Real.log (q : ℝ) := by
      have hqpos : (0 : ℝ) < q := by exact_mod_cast (show 0 < q by omega)
      have hqlt : (q : ℝ) < n := by exact_mod_cast hgt
      linarith [Real.log_lt_log hqpos hqlt]
    rw [abs_of_pos hlog]
    exact h

/-- The elementary part of the gamma-cross/prime-row comparison:
    a cross coefficient bounded by 1/(q sqrt q) lies strictly below the
    actual prime-power coefficient log p/sqrt q whenever q≥8. -/
theorem prime_coefficient_margin
    (p q : ℕ) (delta : ℝ)
    (hp : Nat.Prime p) (hq : 8 ≤ q)
    (hdelta : delta ≤ 1 / ((q : ℝ) * Real.sqrt q)) :
    delta < Real.log p / Real.sqrt q := by
  have hqreal : (8 : ℝ) ≤ q := by exact_mod_cast hq
  have hqpos : (0 : ℝ) < q := by linarith
  have hlog2 : (1 / 2 : ℝ) < Real.log 2 :=
    lt_trans (by norm_num : (1 / 2 : ℝ) < 0.6931471803)
      Real.log_two_gt_d9
  have hp2 : (2 : ℝ) ≤ p := by exact_mod_cast hp.two_le
  have hlogp : Real.log 2 ≤ Real.log p :=
    Real.log_le_log (by norm_num) hp2
  have hqinv : (1 : ℝ) / q < 1 / 2 := by
    apply (div_lt_iff₀ hqpos).mpr
    nlinarith
  have hsmall : (1 : ℝ) / q < Real.log p :=
    lt_of_lt_of_le (lt_trans hqinv hlog2) hlogp
  have hsqrt : 0 < Real.sqrt (q : ℝ) := Real.sqrt_pos.2 hqpos
  have hcompare :
      ((1 : ℝ) / q) / Real.sqrt q <
        Real.log p / Real.sqrt q :=
    div_lt_div_of_pos_right hsmall hsqrt
  have heq :
      1 / ((q : ℝ) * Real.sqrt q) =
        ((1 : ℝ) / q) / Real.sqrt q := by ring
  rw [heq] at hdelta
  exact lt_of_le_of_lt hdelta hcompare

/-- The full integer range from 2 through q is used, so every prime power
    in that range participates through its actual Mangoldt coefficient. -/
theorem complete_prime_row_qge8
    (p j : ℕ) (corr : ℕ → ℝ) (gSq : ℝ)
    (hp : Nat.Prime p) (hj : 0 < j) (hq8 : 8 ≤ p ^ j)
    (hcorrSupport : ∀ n ∈ Finset.Ico 2 (p ^ j + 1),
      (1 : ℝ) / (4 * (p ^ j : ℕ)) <
        |Real.log (n : ℝ) - Real.log (p ^ j : ℕ)| → corr n = 0)
    (hqCorr : corr (p ^ j) = -gSq) :
    primeRow (Finset.Ico 2 (p ^ j + 1)) corr =
      2 * Real.log p / Real.sqrt (p ^ j : ℕ) * gSq := by
  apply primeRow_eq_prime_pow_of_support
    (Finset.Ico 2 (p ^ j + 1)) p j corr gSq
    ((1 : ℝ) / (4 * (p ^ j : ℕ))) hp hj
  · simp only [Finset.mem_Ico]
    omega
  · intro n hn hnq
    exact isolated_log_spacing (p ^ j) n hq8
      (Finset.mem_Ico.mp hn).1 hnq
  · exact hcorrSupport
  · exact hqCorr

/-- Zhu self-term and a gamma cross bound yield a strict margin once the
    actual isolated prime coefficient exceeds the cross coefficient. -/
theorem twoPacketQ_gt_zhu_norm
    {gammaSelf gammaCross coeff delta cZ gSq : ℝ}
    (hgSq : 0 < gSq) (hZhu : cZ * gSq ≤ gammaSelf)
    (hCross : |gammaCross| ≤ delta * gSq)
    (hMargin : delta < coeff) :
    cZ * (2 * gSq) <
      twoPacketQ gammaSelf gammaCross coeff gSq := by
  have hCrossUpper : gammaCross ≤ delta * gSq := (abs_le.mp hCross).2
  have hGain : 0 < (coeff - delta) * gSq :=
    mul_pos (sub_pos.mpr hMargin) hgSq
  unfold twoPacketQ
  nlinarith

/-- The complete actual Weil row is coercive on the named two-packet
    subspace, conditional only on explicit analytic identifications and
    estimates. The finite prime-power row is reduced exactly above. -/
theorem actual_two_packet_coercive
    (S : Finset ℕ) (p j : ℕ) (corr : ℕ → ℝ)
    (gSq normSq gammaSelf gammaCross delta cZ Q : ℝ)
    (hp : Nat.Prime p) (hj : 0 < j)
    (hq : p ^ j ∈ S)
    (hother : ∀ n ∈ S, n ≠ p ^ j → corr n = 0)
    (hqCorr : corr (p ^ j) = -gSq)
    (hgSq : 0 < gSq)
    (hPacketNorm : normSq = 2 * gSq)
    (hWeilIdentification :
      Q = 2 * gammaSelf - 2 * gammaCross + primeRow S corr)
    (hZhu : cZ * gSq ≤ gammaSelf)
    (hGammaCross : |gammaCross| ≤ delta * gSq)
    (hPrimeMargin :
      delta < Real.log p / Real.sqrt (p ^ j : ℕ)) :
    cZ * normSq < Q := by
  rw [hPacketNorm, hWeilIdentification,
    primeRow_eq_prime_pow S p j corr gSq hp hj hq hother hqCorr]
  have h := twoPacketQ_gt_zhu_norm
    (gammaSelf := gammaSelf) (gammaCross := gammaCross)
    (coeff := Real.log p / Real.sqrt (p ^ j : ℕ))
    hgSq hZhu hGammaCross hPrimeMargin
  unfold twoPacketQ at h
  convert h using 1; ring

/-- Same conclusion with the non-q correlation zeros obtained from explicit
    log-spacing and support implications rather than stipulated separately. -/
theorem actual_two_packet_coercive_of_support
    (S : Finset ℕ) (p j : ℕ) (corr : ℕ → ℝ)
    (gSq normSq gammaSelf gammaCross delta cZ Q w : ℝ)
    (hp : Nat.Prime p) (hj : 0 < j)
    (hq : p ^ j ∈ S)
    (hspacing : ∀ n ∈ S, n ≠ p ^ j →
      w < |Real.log (n : ℝ) - Real.log (p ^ j : ℕ)|)
    (hcorrSupport : ∀ n ∈ S,
      w < |Real.log (n : ℝ) - Real.log (p ^ j : ℕ)| → corr n = 0)
    (hqCorr : corr (p ^ j) = -gSq)
    (hgSq : 0 < gSq)
    (hPacketNorm : normSq = 2 * gSq)
    (hWeilIdentification :
      Q = 2 * gammaSelf - 2 * gammaCross + primeRow S corr)
    (hZhu : cZ * gSq ≤ gammaSelf)
    (hGammaCross : |gammaCross| ≤ delta * gSq)
    (hPrimeMargin :
      delta < Real.log p / Real.sqrt (p ^ j : ℕ)) :
    cZ * normSq < Q := by
  apply actual_two_packet_coercive S p j corr gSq normSq gammaSelf
    gammaCross delta cZ Q hp hj hq
  · intro n hn hnq
    exact hcorrSupport n hn (hspacing n hn hnq)
  · exact hqCorr
  · exact hgSq
  · exact hPacketNorm
  · exact hWeilIdentification
  · exact hZhu
  · exact hGammaCross
  · exact hPrimeMargin

/-- Exact nearest-integer spacing is now discharged for every q=p^j≥8.
    The remaining correlation-support implication is the analytic packet
    geometry, not a number-theoretic spacing assumption. -/
theorem actual_two_packet_coercive_of_window
    (S : Finset ℕ) (p j : ℕ) (corr : ℕ → ℝ)
    (gSq normSq gammaSelf gammaCross delta cZ Q : ℝ)
    (hp : Nat.Prime p) (hj : 0 < j)
    (hq8 : 8 ≤ p ^ j) (hq : p ^ j ∈ S)
    (hS : ∀ n ∈ S, 2 ≤ n)
    (hcorrSupport : ∀ n ∈ S,
      (1 : ℝ) / (4 * (p ^ j : ℕ)) <
        |Real.log (n : ℝ) - Real.log (p ^ j : ℕ)| → corr n = 0)
    (hqCorr : corr (p ^ j) = -gSq)
    (hgSq : 0 < gSq)
    (hPacketNorm : normSq = 2 * gSq)
    (hWeilIdentification :
      Q = 2 * gammaSelf - 2 * gammaCross + primeRow S corr)
    (hZhu : cZ * gSq ≤ gammaSelf)
    (hGammaCross : |gammaCross| ≤ delta * gSq)
    (hPrimeMargin :
      delta < Real.log p / Real.sqrt (p ^ j : ℕ)) :
    cZ * normSq < Q := by
  apply actual_two_packet_coercive_of_support S p j corr
    gSq normSq gammaSelf gammaCross delta cZ Q
    ((1 : ℝ) / (4 * (p ^ j : ℕ))) hp hj hq
  · intro n hn hnq
    exact isolated_log_spacing (p ^ j) n hq8 (hS n hn) hnq
  · exact hcorrSupport
  · exact hqCorr
  · exact hgSq
  · exact hPacketNorm
  · exact hWeilIdentification
  · exact hZhu
  · exact hGammaCross
  · exact hPrimeMargin

/-- Uniform q≥8 reduction with both integer spacing and the elementary
    prime coefficient margin discharged in Lean. -/
theorem actual_two_packet_coercive_qge8
    (S : Finset ℕ) (p j : ℕ) (corr : ℕ → ℝ)
    (gSq normSq gammaSelf gammaCross delta cZ Q : ℝ)
    (hp : Nat.Prime p) (hj : 0 < j)
    (hq8 : 8 ≤ p ^ j) (hq : p ^ j ∈ S)
    (hS : ∀ n ∈ S, 2 ≤ n)
    (hcorrSupport : ∀ n ∈ S,
      (1 : ℝ) / (4 * (p ^ j : ℕ)) <
        |Real.log (n : ℝ) - Real.log (p ^ j : ℕ)| → corr n = 0)
    (hqCorr : corr (p ^ j) = -gSq)
    (hgSq : 0 < gSq)
    (hPacketNorm : normSq = 2 * gSq)
    (hWeilIdentification :
      Q = 2 * gammaSelf - 2 * gammaCross + primeRow S corr)
    (hZhu : cZ * gSq ≤ gammaSelf)
    (hGammaCross : |gammaCross| ≤ delta * gSq)
    (hCrossCoefficient :
      delta ≤ 1 / ((p ^ j : ℕ) * Real.sqrt (p ^ j : ℕ))) :
    cZ * normSq < Q := by
  exact actual_two_packet_coercive_of_window S p j corr
    gSq normSq gammaSelf gammaCross delta cZ Q hp hj hq8 hq hS
    hcorrSupport hqCorr hgSq hPacketNorm hWeilIdentification hZhu
    hGammaCross (prime_coefficient_margin p (p ^ j) delta hp hq8
      hCrossCoefficient)

#print axioms primeRow_eq_isolated
#print axioms vonMangoldt_prime_pow
#print axioms primeRow_eq_prime_pow_of_support
#print axioms isolated_log_spacing
#print axioms prime_coefficient_margin
#print axioms complete_prime_row_qge8
#print axioms actual_two_packet_coercive
#print axioms actual_two_packet_coercive_of_support
#print axioms actual_two_packet_coercive_of_window
#print axioms actual_two_packet_coercive_qge8

end BuildingBlocks.ActualWeilIsolatedPrimePowerCone
