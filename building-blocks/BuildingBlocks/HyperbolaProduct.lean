import Mathlib.NumberTheory.ArithmeticFunction
import Mathlib.Data.Nat.Sqrt
import Mathlib.Data.Real.Basic
import Mathlib.Order.Interval.Finset.Nat
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
Finite Möbius identities for grouping a hyperbola sum by the product.
The written analytic estimate and sources are in ../hyperbola-product.md.
-/

open Finset
open scoped BigOperators

namespace BuildingBlocks.HyperbolaProduct

theorem sum_divisors_eq_sum_factor_pairs {R : Type*} [AddCommMonoid R]
    (N : ℕ) (f : ℕ → ℕ → R) :
    ∑ n ∈ Finset.Icc 1 N, ∑ d ∈ n.divisors, f d (n / d) =
      ∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 (N / a), f a b := by
  classical
  rw [Finset.sum_sigma', Finset.sum_sigma']
  apply Finset.sum_bij (fun x _ => ⟨x.2, x.1 / x.2⟩)
  · intro x hx
    obtain ⟨hn, hd⟩ := Finset.mem_sigma.mp hx
    obtain ⟨hn1, hnN⟩ := Finset.mem_Icc.mp hn
    obtain ⟨hdn, hn0⟩ := Nat.mem_divisors.mp hd
    have hd0 : 0 < x.2 := Nat.pos_of_dvd_of_pos hdn hn1
    have hdnle : x.2 ≤ x.1 := Nat.le_of_dvd hn1 hdn
    exact Finset.mem_sigma.mpr ⟨Finset.mem_Icc.mpr ⟨hd0, hdnle.trans hnN⟩,
      Finset.mem_Icc.mpr ⟨Nat.div_pos hdnle hd0, Nat.div_le_div_right hnN⟩⟩
  · intro x hx y hy hxy
    obtain ⟨_, hd⟩ := Finset.mem_sigma.mp hx
    obtain ⟨_, he⟩ := Finset.mem_sigma.mp hy
    have hdq := Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1
    have heq := Nat.mul_div_cancel' (Nat.mem_divisors.mp he).1
    have hfirst : x.2 = y.2 := congrArg Sigma.fst hxy
    have hsecond : x.1 / x.2 = y.1 / y.2 := by
      simpa using congrArg (fun z : Σ _ : ℕ, ℕ => z.2) hxy
    have hn : x.1 = y.1 := by rw [← hdq, ← heq, hsecond, hfirst]
    cases x
    cases y
    simp_all
  · intro y hy
    obtain ⟨ha, hb⟩ := Finset.mem_sigma.mp hy
    obtain ⟨ha1, haN⟩ := Finset.mem_Icc.mp ha
    obtain ⟨hb1, hbN⟩ := Finset.mem_Icc.mp hb
    have hab : y.1 * y.2 ≤ N := by
      simpa only [mul_comm] using (Nat.le_div_iff_mul_le ha1).mp hbN
    have hab1 : 1 ≤ y.1 * y.2 := Nat.mul_pos ha1 hb1
    refine ⟨⟨y.1 * y.2, y.1⟩, Finset.mem_sigma.mpr
      ⟨Finset.mem_Icc.mpr ⟨hab1, hab⟩,
        Nat.mem_divisors.mpr ⟨dvd_mul_right _ _, Nat.ne_of_gt hab1⟩⟩, ?_⟩
    simp only [Nat.mul_div_cancel_left _ ha1, Sigma.eta]
  · intro x hx
    rfl

theorem moebius_divisor_sum (n : ℕ) :
    ∑ d ∈ n.divisors, ArithmeticFunction.moebius d = if n = 1 then 1 else 0 := by
  rw [← ArithmeticFunction.coe_mul_zeta_apply,
    ArithmeticFunction.moebius_mul_coe_zeta, ArithmeticFunction.one_apply]

/-- The actual Möbius coefficient after grouping by the product in the hyperbola sum. -/
noncomputable def hyperbolaProductCoefficient (N k : ℕ) : ℤ :=
  ∑ d ∈ k.divisors, if k * k ≤ N * d then ArithmeticFunction.moebius d else 0

theorem hyperbolaProductCoefficient_small {N k : ℕ} (hk : k * k ≤ N) :
    hyperbolaProductCoefficient N k = if k = 1 then 1 else 0 := by
  classical
  rw [hyperbolaProductCoefficient]
  calc
    _ = ∑ d ∈ k.divisors, ArithmeticFunction.moebius d := by
      apply Finset.sum_congr rfl
      intro d hd
      have hd1 := Nat.pos_of_mem_divisors hd
      exact if_pos (hk.trans (Nat.le_mul_of_pos_right N hd1))
    _ = _ := moebius_divisor_sum k

/-- The complementary cutoff is strict, retaining square-boundary equality. -/
theorem hyperbolaProductCoefficient_complement {N k : ℕ} (hk : k ≠ 1) :
    hyperbolaProductCoefficient N k =
      -(∑ d ∈ k.divisors, if N * d < k * k then ArithmeticFunction.moebius d else 0) := by
  classical
  have he : hyperbolaProductCoefficient N k +
      (∑ d ∈ k.divisors, if N * d < k * k then ArithmeticFunction.moebius d else 0) =
      ∑ d ∈ k.divisors, ArithmeticFunction.moebius d := by
    rw [hyperbolaProductCoefficient, ← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro d _
    by_cases h : k * k ≤ N * d
    · simp [h, Nat.not_lt.mpr h]
    · simp [h, Nat.lt_of_not_ge h]
  rw [moebius_divisor_sum k, if_neg hk] at he
  linarith

theorem hyperbolaProductCoefficient_weighted_sum (N : ℕ) (w : ℕ → ℝ) :
    (∑ k ∈ Icc 1 N, (hyperbolaProductCoefficient N k : ℝ) * w k) =
      ∑ n ∈ Icc 1 N, (ArithmeticFunction.moebius n : ℝ) *
        ∑ m ∈ Icc 1 (N / n).sqrt, w (n * m) := by
  classical
  let f : ℕ → ℕ → ℝ := fun n m =>
    if (n * m) * (n * m) ≤ N * n then (ArithmeticFunction.moebius n : ℝ) * w (n * m)
    else 0
  have he : (∑ k ∈ Icc 1 N, (hyperbolaProductCoefficient N k : ℝ) * w k) =
      ∑ k ∈ Icc 1 N, ∑ d ∈ k.divisors, f d (k / d) := by
    apply Finset.sum_congr rfl
    intro k _
    simp only [hyperbolaProductCoefficient, Int.cast_sum, Int.cast_ite,
      Int.cast_zero, Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro d hd
    dsimp [f]
    rw [Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1]
    split_ifs <;> simp
  rw [he, sum_divisors_eq_sum_factor_pairs N f]
  apply Finset.sum_congr rfl
  intro n hn
  have hn0 : 0 < n := (mem_Icc.mp hn).1
  have hc : ∀ m : ℕ, (n * m) * (n * m) ≤ N * n ↔ m ≤ (N / n).sqrt := by
    intro m
    rw [Nat.le_sqrt, Nat.le_div_iff_mul_le hn0]
    have he : (n * m) * (n * m) = (m * m * n) * n := by ring
    rw [he, Nat.mul_le_mul_right_iff hn0]
  have hs : ((Icc 1 (N / n)).filter (fun m => m ≤ (N / n).sqrt)) =
      Icc 1 (N / n).sqrt := by
    ext m
    simp only [mem_filter, mem_Icc]
    have hh := Nat.sqrt_le_self (N / n)
    omega
  rw [Finset.mul_sum]
  calc
    _ = ∑ m ∈ Icc 1 (N / n), if m ≤ (N / n).sqrt then
        (ArithmeticFunction.moebius n : ℝ) * w (n * m) else 0 := by
      apply Finset.sum_congr rfl
      intro m _
      simp only [f, hc]
    _ = _ := by rw [← Finset.sum_filter, hs]

end BuildingBlocks.HyperbolaProduct
