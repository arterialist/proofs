import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Tactic
import BuildingBlocks.OddDoublingFiniteMobius
import BuildingBlocks.HyperbolaProduct

/-!
# Exact odd-Möbius factorization of the von Mangoldt source

This finite arithmetic identity keeps the factor-two arrival in the
successor-collar source. It proves no asymptotic bound for that source.
-/

namespace BuildingBlocks.SuccessorCollarOddMobius

open scoped ArithmeticFunction.Moebius

noncomputable section

def atTwo : ArithmeticFunction ℝ :=
  ⟨fun n => if n = 2 then 1 else 0, by simp⟩

def oddMoebius : ArithmeticFunction ℝ :=
  ⟨fun n => if Odd n then (ArithmeticFunction.moebius n : ℝ) else 0, by simp⟩

def oddLogBracket : ArithmeticFunction ℝ :=
  (1 - atTwo) * ArithmeticFunction.log

theorem atTwo_mul_apply (f : ArithmeticFunction ℝ) (n : ℕ) :
    (atTwo * f) n = if 2 ∣ n then f (n / 2) else 0 := by
  rcases eq_or_ne n 0 with rfl | hn
  · simp [atTwo]
  rw [ArithmeticFunction.mul_apply,
    Nat.sum_divisorsAntidiagonal (fun a b => atTwo a * f b)]
  simp only [atTwo]
  by_cases h : 2 ∣ n
  · simp [Finset.sum_ite_eq', Nat.mem_divisors, h, hn]
  · simp [Finset.sum_ite_eq', Nat.mem_divisors, h]

theorem moebius_eq_odd_factor :
    (ArithmeticFunction.moebius : ArithmeticFunction ℝ) =
      oddMoebius * (1 - atTwo) := by
  ext n
  rw [mul_comm, sub_mul, one_mul]
  change (ArithmeticFunction.moebius n : ℝ) =
    oddMoebius n - (atTwo * oddMoebius) n
  rw [atTwo_mul_apply]
  by_cases ho : Odd n
  · have hne : ¬ 2 ∣ n := by
      simpa only [← even_iff_two_dvd] using (Nat.not_even_iff_odd.mpr ho)
    simp [oddMoebius, ho, hne]
  · have he : Even n := Nat.not_odd_iff_even.mp ho
    obtain ⟨m, rfl⟩ := he
    have hμ := OddDoublingFiniteMobius.moebius_two_mul m
    have hnot : ¬ Odd (2 * m) := Nat.not_odd_iff_even.mpr (even_two_mul m)
    simp only [oddMoebius, show m + m = 2 * m by omega]
    simp only [hμ]
    by_cases hm : Odd m <;> simp [hm, hnot]

/-- On an odd cofactor the bracket retains its full logarithm. -/
theorem oddLogBracket_odd {n : ℕ} (hn : Odd n) :
    oddLogBracket n = Real.log n := by
  have hne : ¬ 2 ∣ n := by
    simpa only [← even_iff_two_dvd] using (Nat.not_even_iff_odd.mpr hn)
  rw [oddLogBracket, sub_mul, one_mul]
  change ArithmeticFunction.log n - (atTwo * ArithmeticFunction.log) n = _
  rw [atTwo_mul_apply]
  simp [hne, ArithmeticFunction.log_apply]

/-- Every positive even cofactor contributes exactly `log 2`. -/
theorem oddLogBracket_even {n : ℕ} (hn : Even n) (hn0 : n ≠ 0) :
    oddLogBracket n = Real.log 2 := by
  obtain ⟨m, rfl⟩ := hn
  have hm : m ≠ 0 := by
    intro hz
    subst m
    exact hn0 (by norm_num)
  have hlog : Real.log ((2 * m : ℕ) : ℝ) = Real.log 2 + Real.log m := by
    simpa only [Nat.cast_mul, Nat.cast_ofNat] using
      (Real.log_mul (by norm_num : (2 : ℝ) ≠ 0)
        (by exact_mod_cast hm : (m : ℝ) ≠ 0))
  rw [oddLogBracket, sub_mul, one_mul]
  rw [show m + m = 2 * m by omega]
  change ArithmeticFunction.log (2 * m) -
    (atTwo * ArithmeticFunction.log) (2 * m) = _
  rw [atTwo_mul_apply]
  simp only [ArithmeticFunction.log_apply, show 2 ∣ 2 * m by omega,
    if_true, Nat.mul_div_cancel_left m (by norm_num : 0 < 2)]
  norm_num only [Nat.cast_mul, Nat.cast_ofNat]
  norm_num only [Nat.cast_mul, Nat.cast_ofNat] at hlog
  rw [hlog]
  ring

/-- A zero cofactor contributes nothing; otherwise even and odd cofactors
give respectively `log 2` and their own logarithm. -/
theorem oddLogBracket_apply (n : ℕ) :
    oddLogBracket n =
      if n = 0 then 0 else if Even n then Real.log 2 else Real.log n := by
  rcases eq_or_ne n 0 with rfl | hn0
  · simp [oddLogBracket]
  · by_cases he : Even n
    · simp [hn0, he, oddLogBracket_even he hn0]
    · have ho : Odd n := Nat.not_even_iff_odd.mp he
      simp [hn0, he, oddLogBracket_odd ho]

theorem oddLogBracket_pos {n : ℕ} (hn : 0 < n) :
    oddLogBracket n = if Even n then Real.log 2 else Real.log n := by
  rw [oddLogBracket_apply]
  simp [Nat.ne_of_gt hn]

theorem vonMangoldt_eq_odd_convolution :
    ArithmeticFunction.vonMangoldt = oddMoebius * oddLogBracket := by
  rw [oddLogBracket, ← mul_assoc, ← moebius_eq_odd_factor]
  exact ArithmeticFunction.moebius_mul_log_eq_vonMangoldt.symm

/-- The finite divisor row behind the exact odd/2-adic collar split. -/
theorem vonMangoldt_odd_divisor_formula (n : ℕ) :
    ArithmeticFunction.vonMangoldt n =
      ∑ d ∈ n.divisors, oddMoebius d * oddLogBracket (n / d) := by
  rw [vonMangoldt_eq_odd_convolution, ArithmeticFunction.mul_apply]
  exact Nat.sum_divisorsAntidiagonal
    (fun a b => oddMoebius a * oddLogBracket b)

/-- Expanded coefficient formula, with every proper prime power retained. -/
theorem vonMangoldt_odd_divisor_formula_expanded (n : ℕ) :
    ArithmeticFunction.vonMangoldt n =
      ∑ d ∈ n.divisors,
        (if Odd d then (ArithmeticFunction.moebius d : ℝ) else 0) *
          (if n / d = 0 then 0 else if Even (n / d) then Real.log 2
            else Real.log (n / d : ℕ)) := by
  rw [vonMangoldt_odd_divisor_formula]
  apply Finset.sum_congr rfl
  intro d hd
  rw [oddLogBracket_apply]
  rfl

theorem weighted_vonMangoldt_odd_divisor_formula
    (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n * w n) =
      ∑ n ∈ Finset.Icc 1 N,
        (∑ d ∈ n.divisors,
          (if Odd d then (ArithmeticFunction.moebius d : ℝ) else 0) *
            (if n / d = 0 then 0 else if Even (n / d) then Real.log 2
              else Real.log (n / d : ℕ))) * w n := by
  apply Finset.sum_congr rfl
  intro n hn
  rw [vonMangoldt_odd_divisor_formula_expanded]

/-- The finite weighted version of the odd/2-adic pair row. Every `n ≤ N`
and every divisor and cofactor is present. -/
theorem weighted_vonMangoldt_odd_factor_pairs
    (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n * w n) =
      ∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 (N / a),
        (if Odd a then (ArithmeticFunction.moebius a : ℝ) else 0) *
          (if Even b then Real.log 2 else Real.log b) * w (a * b) := by
  calc
    (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n * w n) =
        ∑ n ∈ Finset.Icc 1 N, ∑ d ∈ n.divisors,
          oddMoebius d * oddLogBracket (n / d) * w (d * (n / d)) := by
      apply Finset.sum_congr rfl
      intro n hn
      rw [vonMangoldt_odd_divisor_formula, Finset.sum_mul]
      apply Finset.sum_congr rfl
      intro d hd
      rw [Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1]
    _ = ∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 (N / a),
          oddMoebius a * oddLogBracket b * w (a * b) := by
      exact HyperbolaProduct.sum_divisors_eq_sum_factor_pairs N
        (fun a b => oddMoebius a * oddLogBracket b * w (a * b))
    _ = _ := by
      apply Finset.sum_congr rfl
      intro a ha
      apply Finset.sum_congr rfl
      intro b hb
      rw [oddLogBracket_pos (lt_of_lt_of_le Nat.zero_lt_one (Finset.mem_Icc.mp hb).1)]
      rfl

#print axioms atTwo_mul_apply
#print axioms moebius_eq_odd_factor
#print axioms oddLogBracket_odd
#print axioms oddLogBracket_even
#print axioms oddLogBracket_apply
#print axioms oddLogBracket_pos
#print axioms vonMangoldt_eq_odd_convolution
#print axioms vonMangoldt_odd_divisor_formula
#print axioms vonMangoldt_odd_divisor_formula_expanded
#print axioms weighted_vonMangoldt_odd_divisor_formula
#print axioms weighted_vonMangoldt_odd_factor_pairs

end

end BuildingBlocks.SuccessorCollarOddMobius
