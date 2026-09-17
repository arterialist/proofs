import BuildingBlocks.GoldbachCofactorSuccessorFinite
import Mathlib.Tactic

/-!
# Finite Abel identity for the actual Goldbach cofactor source

At the alternating frequency, the centered ratio source cancels by
successive integer births. The finite identity keeps the initial
two-leg endpoint and the terminal boundary term exactly.
-/

namespace BuildingBlocks.GoldbachCofactorParityFinite

open Finset Real Classical
open scoped BigOperators

noncomputable section

abbrev q (y : ℕ) : ℝ :=
  BuildingBlocks.GoldbachCofactorSuccessorFinite.ratioError y

abbrev Q (s : ℕ) : ℝ :=
  BuildingBlocks.GoldbachSuccessorLogFinite.signedCofactorError s

def stepEnvelope (s : ℕ) : ℝ :=
  Real.log (s : ℝ) *
    (|q 2| +
      (Real.log (s : ℝ) + 4 * Real.log 2 + 2) *
        (1 + Real.log (s : ℝ)))

/-- Finite Abel summation for the actual centered prime-error ratios.
The terminal term must be retained before taking an infinite limit. -/
theorem ratioError_abel_finite (n : ℕ) (hn : 2 ≤ n) (z : ℝ) :
    (1 - z) * (∑ y ∈ Icc 2 n, q y * z ^ y) =
      q 2 * z ^ 2 +
        (∑ y ∈ Icc 3 n, (q y - q (y - 1)) * z ^ y) -
          q n * z ^ (n + 1) := by
  induction n, hn using Nat.le_induction with
  | base =>
      simp
      ring
  | succ n hn ih =>
      have hsum2 :
          (∑ y ∈ Icc 2 (n + 1), q y * z ^ y) =
            (∑ y ∈ Icc 2 n, q y * z ^ y) +
              q (n + 1) * z ^ (n + 1) := by
        rw [Finset.sum_Icc_succ_top (by omega : 2 ≤ n + 1)]
      have hsum3 :
          (∑ y ∈ Icc 3 (n + 1), (q y - q (y - 1)) * z ^ y) =
            (∑ y ∈ Icc 3 n, (q y - q (y - 1)) * z ^ y) +
              (q (n + 1) - q n) * z ^ (n + 1) := by
        rw [Finset.sum_Icc_succ_top (by omega : 3 ≤ n + 1)]
        simp
      rw [hsum2, hsum3]
      calc
        (1 - z) * ((∑ y ∈ Icc 2 n, q y * z ^ y) +
            q (n + 1) * z ^ (n + 1)) =
          (1 - z) * (∑ y ∈ Icc 2 n, q y * z ^ y) +
            (1 - z) * (q (n + 1) * z ^ (n + 1)) := by ring
        _ = q 2 * z ^ 2 +
              (∑ y ∈ Icc 3 n, (q y - q (y - 1)) * z ^ y) -
              q n * z ^ (n + 1) +
              (1 - z) * (q (n + 1) * z ^ (n + 1)) := by rw [ih]
        _ = q 2 * z ^ 2 +
              ((∑ y ∈ Icc 3 n, (q y - q (y - 1)) * z ^ y) +
                (q (n + 1) - q n) * z ^ (n + 1)) -
              q (n + 1) * z ^ (n + 1 + 1) := by
          rw [pow_succ]
          ring

/-- The alternating-frequency partial sum is controlled by actual
successive prime-error births and its finite terminal term. -/
theorem ratioError_alternating_abs_le (n : ℕ) (hn : 2 ≤ n)
    (r : ℝ) (hr0 : 0 ≤ r) (hr1 : r ≤ 1) :
    |∑ y ∈ Icc 2 n, q y * (-r) ^ y| ≤
      |q 2| +
        (∑ y ∈ Icc 3 n, |q y - q (y - 1)| * r ^ y) +
          |q n| * r ^ (n + 1) := by
  let A : ℝ := ∑ y ∈ Icc 2 n, q y * (-r) ^ y
  let D : ℝ := ∑ y ∈ Icc 3 n, (q y - q (y - 1)) * (-r) ^ y
  have habel : (1 + r) * A = q 2 * (-r) ^ 2 + D - q n * (-r) ^ (n + 1) := by
    simpa only [sub_neg_eq_add] using ratioError_abel_finite n hn (-r)
  have hfactor : |A| ≤ |(1 + r) * A| := by
    rw [abs_mul, abs_of_nonneg (by positivity : 0 ≤ 1 + r)]
    nlinarith [abs_nonneg A]
  have hsum : |D| ≤ ∑ y ∈ Icc 3 n, |q y - q (y - 1)| * r ^ y := by
    calc
      |D| ≤ ∑ y ∈ Icc 3 n,
          |(q y - q (y - 1)) * (-r) ^ y| :=
        Finset.abs_sum_le_sum_abs _ _
      _ = ∑ y ∈ Icc 3 n, |q y - q (y - 1)| * r ^ y := by
        apply Finset.sum_congr rfl
        intro y hy
        simp [abs_mul, abs_pow, abs_of_nonneg hr0]
  have htwo : |q 2 * (-r) ^ 2| ≤ |q 2| := by
    rw [abs_mul, abs_pow, abs_neg, abs_of_nonneg hr0]
    have hrpow : r ^ 2 ≤ 1 := pow_le_one₀ hr0 hr1
    nlinarith [abs_nonneg (q 2)]
  have hterminal : |q n * (-r) ^ (n + 1)| = |q n| * r ^ (n + 1) := by
    simp [abs_mul, abs_pow, abs_of_nonneg hr0]
  change |A| ≤ _
  calc
    |A| ≤ |(1 + r) * A| := hfactor
    _ = |q 2 * (-r) ^ 2 + D - q n * (-r) ^ (n + 1)| := by rw [habel]
    _ ≤ |q 2 * (-r) ^ 2| + |D| + |q n * (-r) ^ (n + 1)| := by
      calc
        _ ≤ |q 2 * (-r) ^ 2 + D| + |q n * (-r) ^ (n + 1)| :=
          abs_sub _ _
        _ ≤ _ := by linarith [abs_add_le (q 2 * (-r) ^ 2) D]
    _ ≤ _ := by rw [hterminal]; linarith

/-- A complete prime-error ratio is uniformly bounded by the
compiled Chebyshev constant. -/
theorem abs_ratioError_le (y : ℕ) (hy : 1 ≤ y) :
    |q y| ≤ 4 * Real.log 2 + 1 := by
  have hypos : 0 < (y : ℝ) := by exact_mod_cast (show 0 < y by omega)
  have hE :=
    BuildingBlocks.GoldbachCofactorSuccessorFinite.abs_primeError_le_linear y
  dsimp [q, BuildingBlocks.GoldbachCofactorSuccessorFinite.ratioError]
  rw [abs_div, abs_of_pos hypos]
  exact (div_le_iff₀ hypos).2 (by simpa [mul_comm] using hE)

/-- The alternating source has only a harmonic logarithmic cost;
no sign or RH-strength estimate on the original cofactor is used. -/
theorem ratioError_alternating_log_bound (n : ℕ) (hn : 2 ≤ n)
    (r : ℝ) (hr0 : 0 ≤ r) (hr1 : r ≤ 1) :
    |∑ y ∈ Icc 2 n, q y * (-r) ^ y| ≤
      |q 2| +
        (∑ y ∈ Icc 3 n,
          ((Real.log (y : ℝ) + 4 * Real.log 2 + 2) / (y : ℝ)) * r ^ y) +
          (4 * Real.log 2 + 1) * r ^ (n + 1) := by
  have hderiv : ∀ y ∈ Icc 3 n,
      |q y - q (y - 1)| * r ^ y ≤
        ((Real.log (y : ℝ) + 4 * Real.log 2 + 2) / (y : ℝ)) * r ^ y := by
    intro y hyIcc
    have hy3 : 3 ≤ y := (mem_Icc.mp hyIcc).1
    have hy' : 1 ≤ y - 1 := by omega
    have hsucc : (y - 1) + 1 ≤ y := by omega
    have hstep :=
      BuildingBlocks.GoldbachCofactorSuccessorFinite.ratioError_step_abs_le
        (y - 1) y hy' hsucc
    have hyeq : y - 1 + 1 = y := by omega
    have hbound : |q y - q (y - 1)| ≤
        (Real.log (y : ℝ) + 4 * Real.log 2 + 2) / (y : ℝ) := by
      simpa only [hyeq, q] using hstep
    exact mul_le_mul_of_nonneg_right hbound (pow_nonneg hr0 _)
  have hsum := Finset.sum_le_sum hderiv
  have hlast := abs_ratioError_le n (by omega)
  have hlastmul := mul_le_mul_of_nonneg_right hlast (pow_nonneg hr0 (n + 1))
  have hbase := ratioError_alternating_abs_le n hn r hr0 hr1
  linarith

/-- Exact finite projection onto even additive totals. -/
theorem even_projection_finite (N : ℕ) (r : ℝ) (f : ℕ → ℝ) :
    2 * (∑ s ∈ (Icc 4 N).filter Even, f s * r ^ s) =
      (∑ s ∈ Icc 4 N, f s * r ^ s) +
        (∑ s ∈ Icc 4 N, f s * (-r) ^ s) := by
  calc
    2 * (∑ s ∈ (Icc 4 N).filter Even, f s * r ^ s) =
        ∑ s ∈ Icc 4 N, if Even s then 2 * (f s * r ^ s) else 0 := by
      rw [Finset.mul_sum, Finset.sum_filter]
    _ = ∑ s ∈ Icc 4 N, (f s * r ^ s + f s * (-r) ^ s) := by
      apply Finset.sum_congr rfl
      intro s hs
      by_cases he : Even s
      · simp [he, he.neg_pow]
        ring
      · have ho : Odd s := Nat.not_even_iff_odd.mp he
        simp [he, ho.neg_pow]
    _ = (∑ s ∈ Icc 4 N, f s * r ^ s) +
          (∑ s ∈ Icc 4 N, f s * (-r) ^ s) := by
      rw [Finset.sum_add_distrib]

/-- Exact finite projection onto odd additive totals. -/
theorem odd_projection_finite (N : ℕ) (r : ℝ) (f : ℕ → ℝ) :
    2 * (∑ s ∈ (Icc 4 N).filter Odd, f s * r ^ s) =
      (∑ s ∈ Icc 4 N, f s * r ^ s) -
        (∑ s ∈ Icc 4 N, f s * (-r) ^ s) := by
  calc
    2 * (∑ s ∈ (Icc 4 N).filter Odd, f s * r ^ s) =
        ∑ s ∈ Icc 4 N, if Odd s then 2 * (f s * r ^ s) else 0 := by
      rw [Finset.mul_sum, Finset.sum_filter]
    _ = ∑ s ∈ Icc 4 N, (f s * r ^ s - f s * (-r) ^ s) := by
      apply Finset.sum_congr rfl
      intro s hs
      by_cases ho : Odd s
      · simp [ho, ho.neg_pow]
        ring
      · have he : Even s := Nat.not_odd_iff_even.mp ho
        simp [ho, he.neg_pow]
    _ = (∑ s ∈ Icc 4 N, f s * r ^ s) -
          (∑ s ∈ Icc 4 N, f s * (-r) ^ s) := by
      rw [Finset.sum_sub_distrib]

/-- The parity-lattice successor keeps both ordinary integer steps
and therefore pays their full explicit envelopes. -/
theorem signedCofactorError_two_step_abs_le (s : ℕ) (hs : 4 ≤ s) :
    |Q (s + 2) - Q s| ≤ stepEnvelope s + stepEnvelope (s + 1) := by
  have hfirst : |Q (s + 1) - Q s| ≤ stepEnvelope s := by
    simpa only [Q, q, stepEnvelope] using
      BuildingBlocks.GoldbachCofactorSuccessorFinite.signedCofactorError_step_abs_le s hs
  have hsecond : |Q (s + 2) - Q (s + 1)| ≤ stepEnvelope (s + 1) := by
    simpa only [Q, q, stepEnvelope, Nat.add_assoc] using
      BuildingBlocks.GoldbachCofactorSuccessorFinite.signedCofactorError_step_abs_le
        (s + 1) (by omega)
  have htri := abs_add_le (Q (s + 2) - Q (s + 1)) (Q (s + 1) - Q s)
  have hid : Q (s + 2) - Q s =
      (Q (s + 2) - Q (s + 1)) + (Q (s + 1) - Q s) := by ring
  rw [hid]
  linarith

#print axioms ratioError_abel_finite
#print axioms ratioError_alternating_abs_le
#print axioms abs_ratioError_le
#print axioms ratioError_alternating_log_bound
#print axioms even_projection_finite
#print axioms odd_projection_finite
#print axioms signedCofactorError_two_step_abs_le

end
end BuildingBlocks.GoldbachCofactorParityFinite
