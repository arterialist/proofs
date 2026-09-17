import BuildingBlocks.FinitePNTErrorPropagation
import BuildingBlocks.PrimeEnergy
import BuildingBlocks.SuccessorHighParentPrimeRow
import Mathlib.Tactic

/-!
# Signed Abel comparison for an actual successor-cell prime interval

The coarse-parent part of the successor-cell residual pairs the complete
von Mangoldt source with a continuous density. This file formalizes the
finite arithmetic half of that comparison: an exact, endpoint-sensitive
Abel identity for the actual prime-power source, followed by a signed
local bound under a pointwise prime-error envelope. The remaining
continuous-density comparison and asymptotic PNT input are not here.
-/

namespace BuildingBlocks.SuccessorCoarseParentSignedAbel

open Finset
open scoped BigOperators
open BuildingBlocks.FinitePNTErrorPropagation
open BuildingBlocks.MertensTransfer
open BuildingBlocks.SuccessorHighParentPrimeRow

/-- The increment of the actual Chebyshev error is the complete
von Mangoldt weight minus the unit density, including prime powers. -/
private theorem error_step (n : ℕ) :
    integerError (n + 1) =
      integerError n +
        (ArithmeticFunction.vonMangoldt (n + 1) - 1) := by
  simpa only [BuildingBlocks.primeIncrement] using
    BuildingBlocks.integerError_succ n

/-- Literal closed-interval Abel identity. The lower endpoint is included,
and the preceding Chebyshev error is evaluated at `lo - 1`. -/
theorem actual_prime_discrepancy_abel (w : ℕ → ℝ)
    {lo hi : ℕ} (hlo : 1 ≤ lo) (hhi : lo ≤ hi) :
    (∑ d ∈ Icc lo hi,
      (ArithmeticFunction.vonMangoldt d - 1) * w d) =
      partialSummationError integerError w lo hi := by
  induction hi, hhi using Nat.le_induction with
  | base =>
      have hpred : lo - 1 + 1 = lo := by omega
      have hstep := error_step (lo - 1)
      rw [hpred] at hstep
      simp only [partialSummationError, Icc_self, sum_singleton,
        Ico_self, sum_empty, add_zero]
      rw [hstep]
      ring
  | succ hi hhi ih =>
      have hstep := error_step hi
      rw [sum_Icc_succ_top (by omega : lo ≤ hi + 1), ih]
      simp only [partialSummationError, sum_Ico_succ_top hhi]
      rw [hstep]
      ring

private theorem weight_diff_telescopes (w : ℕ → ℝ)
    {lo hi : ℕ} (hhi : lo ≤ hi) :
    (∑ n ∈ Ico lo hi, (w n - w (n + 1))) = w lo - w hi := by
  induction hi, hhi using Nat.le_induction with
  | base => simp
  | succ hi hhi ih =>
      rw [sum_Ico_succ_top hhi, ih]
      ring

/-- The exact signed arithmetic interval error is bounded by twice the
uniform Chebyshev error envelope times the left weight. The estimate uses
only positivity and monotonicity of the weight on the admitted interval. -/
theorem actual_prime_discrepancy_uniform_bound (w : ℕ → ℝ)
    {lo hi : ℕ} (hlo : 1 ≤ lo) (hhi : lo ≤ hi)
    {B : ℝ} (hB : 0 ≤ B)
    (hE : ∀ n ∈ Icc (lo - 1) hi, |integerError n| ≤ B)
    (hw_nonneg : ∀ n ∈ Icc lo hi, 0 ≤ w n)
    (hw_anti : ∀ n ∈ Ico lo hi, w (n + 1) ≤ w n) :
    |∑ d ∈ Icc lo hi,
      (ArithmeticFunction.vonMangoldt d - 1) * w d| ≤
      2 * B * w lo := by
  rw [actual_prime_discrepancy_abel w hlo hhi]
  have hleft : |integerError (lo - 1)| ≤ B := by
    apply hE (lo - 1)
    simp only [mem_Icc]
    omega
  have hright : |integerError hi| ≤ B := by
    apply hE hi
    simp only [mem_Icc]
    omega
  have hinterior : ∀ n ∈ Ico lo hi, |integerError n| ≤ B := by
    intro n hn
    apply hE n
    have h := mem_Ico.mp hn
    simp only [mem_Icc]
    omega
  have hwlo : 0 ≤ w lo := hw_nonneg lo (mem_Icc.mpr ⟨le_refl _, hhi⟩)
  have hwhi : 0 ≤ w hi := hw_nonneg hi (mem_Icc.mpr ⟨hhi, le_refl _⟩)
  have hdiff : ∀ n ∈ Ico lo hi, 0 ≤ w n - w (n + 1) := by
    intro n hn
    exact sub_nonneg.mpr (hw_anti n hn)
  have htel := weight_diff_telescopes w hhi
  have hraw := abs_partialSummationError_le
    integerError w
    (fun n => |integerError n|) lo hi (fun _ => le_refl _)
  have hsum :
      (∑ n ∈ Ico lo hi,
        |integerError n| * |w n - w (n + 1)|) ≤
      ∑ n ∈ Ico lo hi, B * (w n - w (n + 1)) := by
    apply sum_le_sum
    intro n hn
    rw [abs_of_nonneg (hdiff n hn)]
    exact mul_le_mul_of_nonneg_right (hinterior n hn) (hdiff n hn)
  have hsum' :
      (∑ n ∈ Ico lo hi, B * (w n - w (n + 1))) =
        B * (w lo - w hi) := by
    rw [← mul_sum, htel]
  rw [abs_of_nonneg hwlo, abs_of_nonneg hwhi] at hraw
  rw [hsum'] at hsum
  nlinarith [hB, mul_le_mul_of_nonneg_left hleft hwlo,
    mul_le_mul_of_nonneg_left hright hwhi]

/-- The reciprocal-square-root weight appearing in each prime cell row.
This is the finite signed input for the coarse-parent comparison; a PNT
envelope can be substituted for `B` without changing the prime-power sum. -/
theorem actual_prime_discrepancy_inv_sqrt_bound
    {lo hi : ℕ} (hlo : 1 ≤ lo) (hhi : lo ≤ hi)
    {B : ℝ} (hB : 0 ≤ B)
    (hE : ∀ n ∈ Icc (lo - 1) hi, |integerError n| ≤ B) :
    |∑ d ∈ Icc lo hi,
      (ArithmeticFunction.vonMangoldt d - 1) / Real.sqrt d| ≤
      2 * B / Real.sqrt lo := by
  have hw_nonneg : ∀ n ∈ Icc lo hi,
      0 ≤ (1 : ℝ) / Real.sqrt n := by
    intro n _
    exact div_nonneg (by norm_num) (Real.sqrt_nonneg _)
  have hw_anti : ∀ n ∈ Ico lo hi,
      (1 : ℝ) / Real.sqrt ((n + 1 : ℕ) : ℝ) ≤ 1 / Real.sqrt n := by
    intro n hn
    have hnpos : (0 : ℝ) < n := by
      exact_mod_cast (show 0 < n by have := (mem_Ico.mp hn).1; omega)
    have hle : ((n : ℝ)) ≤ (n + 1 : ℕ) := by exact_mod_cast Nat.le_succ n
    exact one_div_le_one_div_of_le (Real.sqrt_pos.2 hnpos) (Real.sqrt_le_sqrt hle)
  have h := actual_prime_discrepancy_uniform_bound
    (fun n => (1 : ℝ) / Real.sqrt n) hlo hhi hB hE hw_nonneg hw_anti
  simpa only [div_eq_mul_inv, one_mul, mul_assoc] using h

/-- Strict lower and closed upper dilation endpoints, exactly as in a
successor-cell child interval. The previous error value is at `a`. -/
theorem actual_prime_discrepancy_Ioc_inv_sqrt_bound
    {a b : ℕ} (hab : a < b) {B : ℝ} (hB : 0 ≤ B)
    (hE : ∀ n ∈ Icc a b, |integerError n| ≤ B) :
    |∑ d ∈ Ioc a b,
      (ArithmeticFunction.vonMangoldt d - 1) / Real.sqrt d| ≤
      2 * B / Real.sqrt (a + 1 : ℕ) := by
  have h := actual_prime_discrepancy_inv_sqrt_bound
    (lo := a + 1) (hi := b) (by omega) (by omega) hB
    (by simpa only [Nat.add_sub_cancel_left] using hE)
  simpa only [Icc_add_one_left_eq_Ioc] using h

/-- Once the cutoff lies below the strict child threshold, the actual
successor-cell dilation labels form exactly this half-open quotient interval.
No prime-power atom or boundary label is discarded. -/
theorem child_dilations_eq_quotient_Ioc
    {r n D : ℕ} (hn : 0 < n) (hD : D ≤ r / (n + 1)) :
    highParentChildren r n D = Ioc (r / (n + 1)) (r / n) := by
  ext d
  simp only [highParentChildren, mem_filter, mem_Ioc]
  constructor
  · intro hd
    rcases hd with ⟨_, hdlo, hdhi⟩
    constructor
    · exact (Nat.div_lt_iff_lt_mul (by omega : 0 < n + 1)).2 hdhi
    · exact (Nat.le_div_iff_mul_le hn).2 hdlo
  · intro hd
    have hdlo : d * n ≤ r := (Nat.le_div_iff_mul_le hn).1 hd.2
    have hdhi : r < d * (n + 1) :=
      (Nat.div_lt_iff_lt_mul (by omega : 0 < n + 1)).1 hd.1
    have hdD : D < d := lt_of_le_of_lt hD hd.1
    have hdr : d ≤ r := by nlinarith
    exact ⟨⟨hdD, hdr⟩, hdlo, hdhi⟩

/-- A complete coarse-parent child interval inherits the signed local
prime-error bound. The cutoffs, strict lower endpoint, and prime powers are
those of the exact successor-cell matrix. -/
theorem child_dilation_signed_inv_sqrt_bound
    {r n D : ℕ} (hn : 0 < n) (hD : D ≤ r / (n + 1))
    (hinterval : r / (n + 1) < r / n)
    {B : ℝ} (hB : 0 ≤ B)
    (hE : ∀ k ∈ Icc (r / (n + 1)) (r / n), |integerError k| ≤ B) :
    |∑ d ∈ highParentChildren r n D,
      (ArithmeticFunction.vonMangoldt d - 1) / Real.sqrt d| ≤
      2 * B / Real.sqrt (r / (n + 1) + 1 : ℕ) := by
  rw [child_dilations_eq_quotient_Ioc hn hD]
  exact actual_prime_discrepancy_Ioc_inv_sqrt_bound hinterval hB hE

#print axioms actual_prime_discrepancy_abel
#print axioms actual_prime_discrepancy_uniform_bound
#print axioms actual_prime_discrepancy_inv_sqrt_bound
#print axioms actual_prime_discrepancy_Ioc_inv_sqrt_bound
#print axioms child_dilations_eq_quotient_Ioc
#print axioms child_dilation_signed_inv_sqrt_bound

end BuildingBlocks.SuccessorCoarseParentSignedAbel
