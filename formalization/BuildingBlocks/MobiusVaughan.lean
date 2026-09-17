import BuildingBlocks.HyperbolaProduct
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.NormNum
import Lean.Elab.Tactic.Omega

open Finset
open scoped BigOperators ArithmeticFunction

namespace BuildingBlocks

open HyperbolaProduct

/-- The actual Möbius function restricted to the small factors. -/
noncomputable def moebiusSmall (U : ℕ) : ArithmeticFunction ℝ :=
  ⟨fun n => if n ≤ U then (ArithmeticFunction.moebius n : ℝ) else 0, by simp⟩

noncomputable def moebiusLarge (U : ℕ) : ArithmeticFunction ℝ :=
  (ArithmeticFunction.moebius : ArithmeticFunction ℝ) - moebiusSmall U

noncomputable def vaughanSmallCoefficient (U : ℕ) : ArithmeticFunction ℝ :=
  moebiusSmall U * moebiusSmall U

noncomputable def vaughanLargeCoefficient (U : ℕ) : ArithmeticFunction ℝ :=
  moebiusLarge U * (ArithmeticFunction.zeta : ArithmeticFunction ℝ)

theorem moebiusSmall_apply (U n : ℕ) :
    moebiusSmall U n = if n ≤ U then (ArithmeticFunction.moebius n : ℝ) else 0 := rfl

theorem moebiusLarge_apply (U n : ℕ) :
    moebiusLarge U n = if U < n then (ArithmeticFunction.moebius n : ℝ) else 0 := by
  change (ArithmeticFunction.moebius n : ℝ) -
    (if n ≤ U then (ArithmeticFunction.moebius n : ℝ) else 0) = _
  by_cases hn : n ≤ U
  · simp [hn, Nat.not_lt.mpr hn]
  · simp [hn, Nat.lt_of_not_ge hn]

theorem moebiusSmall_abs_le_one (U n : ℕ) : |moebiusSmall U n| ≤ 1 := by
  rw [moebiusSmall_apply]
  split_ifs
  · exact_mod_cast (ArithmeticFunction.abs_moebius_le_one (n := n))
  · norm_num

theorem moebiusLarge_abs_le_one (U n : ℕ) : |moebiusLarge U n| ≤ 1 := by
  rw [moebiusLarge_apply]
  split_ifs
  · exact_mod_cast (ArithmeticFunction.abs_moebius_le_one (n := n))
  · norm_num

/-- The identity is an equality of actual arithmetic functions under
Dirichlet convolution. The small correction makes it valid even at n ≤ U. -/
theorem moebius_vaughan_identity (U : ℕ) :
    (ArithmeticFunction.moebius : ArithmeticFunction ℝ) =
      2 • moebiusSmall U -
        vaughanSmallCoefficient U * (ArithmeticFunction.zeta : ArithmeticFunction ℝ) +
        moebiusLarge U * vaughanLargeCoefficient U := by
  have hμζ := ArithmeticFunction.coe_moebius_mul_coe_zeta (R := ℝ)
  dsimp [vaughanSmallCoefficient, vaughanLargeCoefficient, moebiusLarge]
  rw [two_smul]
  calc
    _ = (ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
        ((ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
          (ArithmeticFunction.zeta : ArithmeticFunction ℝ)) := by rw [hμζ, mul_one]
    _ = _ := by
      have hA : moebiusSmall U *
          ((ArithmeticFunction.moebius : ArithmeticFunction ℝ) *
            (ArithmeticFunction.zeta : ArithmeticFunction ℝ)) = moebiusSmall U := by
        rw [hμζ, mul_one]
      linear_combination 2 * hA

theorem vaughanSmallCoefficient_eq_zero_of_lt {U n : ℕ} (hn : U * U < n) :
    vaughanSmallCoefficient U n = 0 := by
  rw [vaughanSmallCoefficient, ArithmeticFunction.mul_apply]
  apply Finset.sum_eq_zero
  intro d hd
  obtain ⟨hprod, _⟩ := Nat.mem_divisorsAntidiagonal.mp hd
  simp only [moebiusSmall_apply]
  split_ifs with h1 h2
  · have h := Nat.mul_le_mul h1 h2
    omega
  all_goals simp

theorem vaughanSmallCoefficient_abs_le (U n : ℕ) :
    |vaughanSmallCoefficient U n| ≤ (n.divisors.card : ℝ) := by
  rw [vaughanSmallCoefficient, ArithmeticFunction.mul_apply,
    Nat.sum_divisorsAntidiagonal
      (fun a b => moebiusSmall U a * moebiusSmall U b)]
  calc
    _ ≤ ∑ d ∈ n.divisors, |moebiusSmall U d * moebiusSmall U (n / d)| :=
      Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ _d ∈ n.divisors, (1 : ℝ) := by
      apply Finset.sum_le_sum
      intro d _
      rw [abs_mul]
      exact (mul_le_mul (moebiusSmall_abs_le_one U d)
        (moebiusSmall_abs_le_one U (n / d)) (abs_nonneg _) (by norm_num)).trans_eq
          (by norm_num)
    _ = _ := by simp

theorem vaughanLargeCoefficient_apply (U n : ℕ) :
    vaughanLargeCoefficient U n =
      ∑ d ∈ n.divisors, if U < d then (ArithmeticFunction.moebius d : ℝ) else 0 := by
  rw [vaughanLargeCoefficient, ArithmeticFunction.coe_mul_zeta_apply]
  simp only [moebiusLarge_apply]

theorem vaughanLargeCoefficient_eq_zero_of_le {U n : ℕ} (hn : n ≤ U) :
    vaughanLargeCoefficient U n = 0 := by
  rw [vaughanLargeCoefficient_apply]
  apply Finset.sum_eq_zero
  intro d hd
  have hdle : d ≤ n := Nat.le_of_dvd (Nat.pos_of_ne_zero (Nat.mem_divisors.mp hd).2)
    (Nat.mem_divisors.mp hd).1
  simp [show ¬ U < d by omega]

theorem vaughanLargeCoefficient_abs_le (U n : ℕ) :
    |vaughanLargeCoefficient U n| ≤ (n.divisors.card : ℝ) := by
  rw [vaughanLargeCoefficient, ArithmeticFunction.coe_mul_zeta_apply]
  calc
    _ ≤ ∑ d ∈ n.divisors, |moebiusLarge U d| := Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ _d ∈ n.divisors, (1 : ℝ) :=
      Finset.sum_le_sum (fun d _ => moebiusLarge_abs_le_one U d)
    _ = _ := by simp

theorem moebius_vaughan_apply_of_lt {U n : ℕ} (hn : U < n) :
    (ArithmeticFunction.moebius n : ℝ) =
      -(∑ d ∈ n.divisors, vaughanSmallCoefficient U d) +
        ∑ d ∈ n.divisors, moebiusLarge U d * vaughanLargeCoefficient U (n / d) := by
  have h := congrArg (fun f : ArithmeticFunction ℝ => f n) (moebius_vaughan_identity U)
  change (ArithmeticFunction.moebius n : ℝ) =
    (2 : ℕ) • moebiusSmall U n -
      (vaughanSmallCoefficient U * (ArithmeticFunction.zeta : ArithmeticFunction ℝ)) n +
      (moebiusLarge U * vaughanLargeCoefficient U) n at h
  simp only [
    ArithmeticFunction.coe_mul_zeta_apply, moebiusSmall_apply,
    if_neg (Nat.not_le.mpr hn), smul_zero, zero_sub] at h
  rw [ArithmeticFunction.mul_apply,
    Nat.sum_divisorsAntidiagonal
      (fun a b => moebiusLarge U a * vaughanLargeCoefficient U b)] at h
  exact h

theorem weighted_convolution_sum (f g : ArithmeticFunction ℝ) (w : ℕ → ℝ) (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, (f * g) n * w n) =
      ∑ a ∈ Finset.Icc 1 N, f a *
        ∑ b ∈ Finset.Icc 1 (N / a), g b * w (a * b) := by
  have hpoint : ∀ n : ℕ, (f * g) n * w n =
      ∑ d ∈ n.divisors, f d * (g (n / d) * w (d * (n / d))) := by
    intro n
    rw [ArithmeticFunction.mul_apply,
      Nat.sum_divisorsAntidiagonal (fun a b => f a * g b), Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro d hd
    rw [Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1, mul_assoc]
  simp_rw [hpoint]
  rw [sum_divisors_eq_sum_factor_pairs N (fun a b => f a * (g b * w (a * b)))]
  simp only [Finset.mul_sum]

theorem moebius_vaughan_weighted_sum (U N : ℕ) (w : ℕ → ℝ)
    (hw : ∀ n, n ≤ U → w n = 0) :
    (∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius n : ℝ) * w n) =
      -(∑ a ∈ Finset.Icc 1 N, vaughanSmallCoefficient U a *
        ∑ b ∈ Finset.Icc 1 (N / a),
          (ArithmeticFunction.zeta : ArithmeticFunction ℝ) b * w (a * b)) +
      ∑ a ∈ Finset.Icc 1 N, moebiusLarge U a *
        ∑ b ∈ Finset.Icc 1 (N / a), vaughanLargeCoefficient U b * w (a * b) := by
  rw [← weighted_convolution_sum, ← weighted_convolution_sum]
  rw [← Finset.sum_neg_distrib, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n _
  by_cases hn : n ≤ U
  · simp [hw n hn]
  · have h := congrArg (fun f : ArithmeticFunction ℝ => f n) (moebius_vaughan_identity U)
    change (ArithmeticFunction.moebius n : ℝ) =
      (2 : ℕ) • moebiusSmall U n -
        (vaughanSmallCoefficient U * (ArithmeticFunction.zeta : ArithmeticFunction ℝ)) n +
        (moebiusLarge U * vaughanLargeCoefficient U) n at h
    simp only [moebiusSmall_apply, if_neg hn, smul_zero, zero_sub] at h
    rw [h]
    ring

end BuildingBlocks
