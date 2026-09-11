import Mathlib.NumberTheory.Divisors
import Mathlib.NumberTheory.Harmonic.Bounds
import Mathlib.Data.Real.Sqrt

/-!
Finite divisor-pair arithmetic for the cyclotomic boundary bounds.

The factor-pair bijection proof is reused from
BuildingBlocks/FloorRecurrence.lean, sum_divisors_eq_sum_factor_pairs.
The harmonic divisor proof is reused from
BuildingBlocks/MertensPrimeTransfer.lean, divisorCard_harmonic_bound.
The unweighted bound below combines that finite bijection with natural-division
comparison. This module imports only cached Mathlib dependencies.
-/

open Finset
open scoped BigOperators

namespace BuildingBlocks.CyclotomicBoundary

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


/-- The finite average divisor bound from the factor-pair bijection. -/
theorem divisorCard_sum_harmonic_bound (X : ℕ) :
    (∑ n ∈ Finset.Icc 1 X, (n.divisors.card : ℝ)) ≤
      (X : ℝ) * (harmonic X : ℝ) := by
  have he : (∑ n ∈ Finset.Icc 1 X, (n.divisors.card : ℝ)) =
      ∑ a ∈ Finset.Icc 1 X, ((X / a : ℕ) : ℝ) := by
    have h := sum_divisors_eq_sum_factor_pairs X (fun _ _ => (1 : ℝ))
    simpa using h
  rw [he]
  calc
    _ ≤ ∑ a ∈ Finset.Icc 1 X, (X : ℝ) / a :=
      Finset.sum_le_sum (fun _ _ => Nat.cast_div_le)
    _ = _ := by
      simp only [harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast,
        Finset.mul_sum, div_eq_mul_inv]

theorem divisorCard_harmonic_bound (K : ℕ) :
    (∑ n ∈ Finset.Icc 1 K, (n.divisors.card : ℝ) / n) ≤ (harmonic K : ℝ) ^ 2 := by
  have he : (∑ n ∈ Finset.Icc 1 K, (n.divisors.card : ℝ) / n) =
      ∑ n ∈ Finset.Icc 1 K, ∑ d ∈ n.divisors, 1 / ((d : ℝ) * (n / d : ℕ)) := by
    apply Finset.sum_congr rfl
    intro n hn
    have hi : (∑ d ∈ n.divisors, 1 / ((d : ℝ) * (n / d : ℕ))) =
        ∑ _d ∈ n.divisors, (1 : ℝ) / n := by
      apply Finset.sum_congr rfl
      intro d hd
      have hm : (d : ℝ) * (n / d : ℕ) = n := by
        exact_mod_cast Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1
      rw [hm]
    rw [hi]
    simp [div_eq_mul_inv]
  rw [he, sum_divisors_eq_sum_factor_pairs K (fun a b => (1 : ℝ) / ((a : ℝ) * b))]
  calc
    _ ≤ ∑ a ∈ Finset.Icc 1 K, ∑ b ∈ Finset.Icc 1 K, 1 / ((a : ℝ) * b) := by
      apply Finset.sum_le_sum
      intro a ha
      exact Finset.sum_le_sum_of_subset_of_nonneg
        (Finset.Icc_subset_Icc le_rfl (Nat.div_le_self K a)) (fun _ _ _ => by positivity)
    _ = _ := by
      simp only [harmonic_eq_sum_Icc, Rat.cast_sum, Rat.cast_inv, Rat.cast_natCast,
        pow_two, Finset.sum_mul_sum, one_div, mul_inv]

end BuildingBlocks.CyclotomicBoundary
