import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Data.Real.Sqrt
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FieldSimp

/-!
A finite unconditional bound for the literal full-prime-history coefficient.
All divisors, proper prime powers and the origin `1` are retained.
Identification of this coefficient with a derivative jump of the complete
continuum numerator is a written analytic step, not a theorem of this file.
-/

namespace BuildingBlocks.FullPrimeHistoryJumpBound

open Finset

noncomputable section

def convolution (n : ℕ) : ℝ :=
  (ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) n

def fullJump (n : ℕ) : ℝ :=
  (1 + ∑ a ∈ n.divisors, Real.sqrt (a : ℝ) *
    (convolution a - 2 * ArithmeticFunction.vonMangoldt a)) / Real.sqrt (n : ℝ)

theorem convolution_nonneg (n : ℕ) : 0 ≤ convolution n := by
  rw [convolution, ArithmeticFunction.mul_apply]
  exact Finset.sum_nonneg fun _ _ =>
    mul_nonneg ArithmeticFunction.vonMangoldt_nonneg ArithmeticFunction.vonMangoldt_nonneg

/-- Complete divisor convolution; no proper-power subtraction occurs. -/
theorem sum_convolution_divisors (n : ℕ) :
    (∑ a ∈ n.divisors, convolution a) =
      ∑ d ∈ n.divisors, ArithmeticFunction.vonMangoldt d * Real.log (n / d : ℕ) := by
  calc
    _ = ((ArithmeticFunction.vonMangoldt * ArithmeticFunction.vonMangoldt) *
        (ArithmeticFunction.zeta : ArithmeticFunction ℝ)) n := by
      simp only [ArithmeticFunction.coe_mul_zeta_apply, convolution]
    _ = (ArithmeticFunction.vonMangoldt * ArithmeticFunction.log) n := by
      rw [mul_assoc, ArithmeticFunction.vonMangoldt_mul_zeta]
    _ = _ := by
      rw [ArithmeticFunction.mul_apply]
      rw [Nat.sum_divisorsAntidiagonal (fun a b =>
        ArithmeticFunction.vonMangoldt a * ArithmeticFunction.log b)]
      simp only [ArithmeticFunction.log_apply]

theorem sum_convolution_divisors_le_log_sq {n : ℕ} (hn : 1 ≤ n) :
    (∑ a ∈ n.divisors, convolution a) ≤ Real.log (n : ℝ) ^ 2 := by
  rw [sum_convolution_divisors]
  calc
    _ ≤ ∑ d ∈ n.divisors, ArithmeticFunction.vonMangoldt d * Real.log (n : ℝ) := by
      apply Finset.sum_le_sum
      intro d hd
      have hdn : d ∣ n := (Nat.mem_divisors.mp hd).1
      have hdpos : 0 < d := Nat.pos_of_dvd_of_pos hdn hn
      have hqpos : 0 < n / d := Nat.div_pos (Nat.le_of_dvd hn hdn) hdpos
      have hlog : Real.log (n / d : ℕ) ≤ Real.log (n : ℝ) :=
        Real.log_le_log (by exact_mod_cast hqpos)
          (by exact_mod_cast Nat.div_le_self n d)
      exact mul_le_mul_of_nonneg_left hlog ArithmeticFunction.vonMangoldt_nonneg
    _ = Real.log (n : ℝ) ^ 2 := by
      rw [← Finset.sum_mul, ArithmeticFunction.vonMangoldt_sum]
      ring

theorem weighted_convolution_divisors_bound {n : ℕ} (hn : 1 ≤ n) :
    (∑ a ∈ n.divisors, Real.sqrt (a : ℝ) * convolution a) ≤
      Real.sqrt (n : ℝ) * Real.log (n : ℝ) ^ 2 := by
  calc
    _ ≤ ∑ a ∈ n.divisors, Real.sqrt (n : ℝ) * convolution a := by
      apply Finset.sum_le_sum
      intro a ha
      have han : a ≤ n := Nat.le_of_dvd hn (Nat.mem_divisors.mp ha).1
      exact mul_le_mul_of_nonneg_right
        (Real.sqrt_le_sqrt (by exact_mod_cast han)) (convolution_nonneg a)
    _ = Real.sqrt (n : ℝ) * ∑ a ∈ n.divisors, convolution a := by
      rw [Finset.mul_sum]
    _ ≤ _ := mul_le_mul_of_nonneg_left (sum_convolution_divisors_le_log_sq hn)
      (Real.sqrt_nonneg _)

theorem weighted_vonMangoldt_divisors_bound {n : ℕ} (hn : 1 ≤ n) :
    (∑ a ∈ n.divisors, Real.sqrt (a : ℝ) * ArithmeticFunction.vonMangoldt a) ≤
      Real.sqrt (n : ℝ) * Real.log (n : ℝ) := by
  calc
    _ ≤ ∑ a ∈ n.divisors, Real.sqrt (n : ℝ) * ArithmeticFunction.vonMangoldt a := by
      apply Finset.sum_le_sum
      intro a ha
      have han : a ≤ n := Nat.le_of_dvd hn (Nat.mem_divisors.mp ha).1
      exact mul_le_mul_of_nonneg_right
        (Real.sqrt_le_sqrt (by exact_mod_cast han)) ArithmeticFunction.vonMangoldt_nonneg
    _ = _ := by
      rw [← Finset.mul_sum, ArithmeticFunction.vonMangoldt_sum]

theorem fullJump_bound {n : ℕ} (hn : 1 ≤ n) :
    |fullJump n| ≤ 1 / Real.sqrt (n : ℝ) + Real.log (n : ℝ) ^ 2 +
      2 * Real.log (n : ℝ) := by
  let A := ∑ a ∈ n.divisors, Real.sqrt (a : ℝ) * convolution a
  let B := ∑ a ∈ n.divisors, Real.sqrt (a : ℝ) * ArithmeticFunction.vonMangoldt a
  have hA0 : 0 ≤ A := Finset.sum_nonneg fun a _ =>
    mul_nonneg (Real.sqrt_nonneg _) (convolution_nonneg a)
  have hB0 : 0 ≤ B := Finset.sum_nonneg fun a _ =>
    mul_nonneg (Real.sqrt_nonneg _) ArithmeticFunction.vonMangoldt_nonneg
  have hA := weighted_convolution_divisors_bound hn
  have hB := weighted_vonMangoldt_divisors_bound hn
  change A ≤ Real.sqrt (n : ℝ) * Real.log (n : ℝ) ^ 2 at hA
  change B ≤ Real.sqrt (n : ℝ) * Real.log (n : ℝ) at hB
  have hs : 0 < Real.sqrt (n : ℝ) := Real.sqrt_pos.mpr (by exact_mod_cast hn)
  have he : fullJump n = (1 + A - 2 * B) / Real.sqrt (n : ℝ) := by
    simp only [fullJump, A, B, mul_sub, Finset.sum_sub_distrib, mul_left_comm,
      ← Finset.mul_sum]
    ring
  rw [he, abs_div, abs_of_pos hs]
  apply (div_le_iff₀ hs).mpr
  have hnum : |1 + A - 2 * B| ≤
      1 + Real.sqrt (n : ℝ) * (Real.log (n : ℝ) ^ 2 + 2 * Real.log (n : ℝ)) := by
    apply abs_le.mpr
    constructor <;> nlinarith
  have halg :
      (1 / Real.sqrt (n : ℝ) + Real.log (n : ℝ) ^ 2 + 2 * Real.log (n : ℝ)) *
        Real.sqrt (n : ℝ) =
      1 + Real.sqrt (n : ℝ) * (Real.log (n : ℝ) ^ 2 + 2 * Real.log (n : ℝ)) := by
    rw [add_mul, add_mul, div_mul_cancel₀ _ hs.ne']
    ring
  rw [halg]
  exact hnum

theorem fullJump_one : fullJump 1 = 1 := by
  simp [fullJump, convolution]

theorem fullJump_lower {n : ℕ} (hn : 1 ≤ n) :
    1 / Real.sqrt (n : ℝ) - 2 * Real.log (n : ℝ) ≤ fullJump n := by
  let A := ∑ a ∈ n.divisors, Real.sqrt (a : ℝ) * convolution a
  let B := ∑ a ∈ n.divisors, Real.sqrt (a : ℝ) * ArithmeticFunction.vonMangoldt a
  have hA0 : 0 ≤ A := Finset.sum_nonneg fun a _ =>
    mul_nonneg (Real.sqrt_nonneg _) (convolution_nonneg a)
  have hB := weighted_vonMangoldt_divisors_bound hn
  change B ≤ Real.sqrt (n : ℝ) * Real.log (n : ℝ) at hB
  have hs : 0 < Real.sqrt (n : ℝ) := Real.sqrt_pos.mpr (by exact_mod_cast hn)
  have he : fullJump n = (1 + A - 2 * B) / Real.sqrt (n : ℝ) := by
    simp only [fullJump, A, B, mul_sub, Finset.sum_sub_distrib, mul_left_comm,
      ← Finset.mul_sum]
    ring
  rw [he]
  apply (le_div_iff₀ hs).mpr
  rw [sub_mul, div_mul_cancel₀ _ hs.ne']
  nlinarith

theorem convolution_prime {p : ℕ} (hp : p.Prime) : convolution p = 0 := by
  rw [convolution, ArithmeticFunction.mul_apply]
  rw [Nat.sum_divisorsAntidiagonal (fun a b =>
    ArithmeticFunction.vonMangoldt a * ArithmeticFunction.vonMangoldt b)]
  rw [hp.divisors]
  simp [Nat.div_self hp.pos]

theorem fullJump_prime {p : ℕ} (hp : p.Prime) :
    fullJump p = 1 / Real.sqrt (p : ℝ) - 2 * Real.log (p : ℝ) := by
  have hs : Real.sqrt (p : ℝ) ≠ 0 :=
    (Real.sqrt_pos.mpr (by exact_mod_cast hp.pos)).ne'
  have hc1 : convolution 1 = 0 := by simp [convolution]
  simp only [fullJump, hp.divisors]
  simp [hc1, convolution_prime hp,
    ArithmeticFunction.vonMangoldt_apply_prime hp]
  field_simp
  ring

#print axioms convolution_nonneg
#print axioms sum_convolution_divisors
#print axioms sum_convolution_divisors_le_log_sq
#print axioms weighted_convolution_divisors_bound
#print axioms weighted_vonMangoldt_divisors_bound
#print axioms fullJump_bound
#print axioms fullJump_one
#print axioms fullJump_lower
#print axioms convolution_prime
#print axioms fullJump_prime

end
end BuildingBlocks.FullPrimeHistoryJumpBound
