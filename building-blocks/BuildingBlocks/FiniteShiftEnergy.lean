import Mathlib.Analysis.Complex.Basic
import Mathlib.Algebra.Order.BigOperators.Ring.Finset
import Mathlib.Algebra.Order.Ring.Abs
import Mathlib.Data.Int.Interval
import Lean.Elab.Tactic.Omega
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

open Finset
open scoped BigOperators ComplexConjugate

namespace BuildingBlocks

/-- A common finite interval containing every backward shift of [0,N). -/
def shiftEnvelope (N H : ℕ) : Finset ℤ := Finset.Ico (-(H : ℤ)) N

theorem shiftEnvelope_card (N H : ℕ) :
    (shiftEnvelope N H).card = N + H := by
  simp only [shiftEnvelope, Int.card_Ico]
  omega

theorem sum_shiftEnvelope_eq (z : ℤ → ℂ) (N H h : ℕ) (hh : h ≤ H)
    (hz : ∀ n, n ∉ Finset.Ico (0 : ℤ) N → z n = 0) :
    (∑ n ∈ shiftEnvelope N H, z (n + h)) = ∑ n ∈ Finset.Ico (0 : ℤ) N, z n := by
  let J : Finset ℤ := Finset.Ico (-(H : ℤ) + h) ((N : ℤ) + h)
  have hshift : (∑ n ∈ shiftEnvelope N H, z (n + h)) = ∑ n ∈ J, z n := by
    apply Finset.sum_bij (fun (n : ℤ) _ => n + (h : ℤ))
    · intro n hn
      simp only [shiftEnvelope, Finset.mem_Ico] at hn
      simp only [J, Finset.mem_Ico]
      omega
    · intro a _ b _ he
      omega
    · intro b hb
      refine ⟨b - h, ?_, by omega⟩
      simp only [J, Finset.mem_Ico] at hb
      simp only [shiftEnvelope, Finset.mem_Ico]
      omega
    · intro n _
      rfl
  rw [hshift]
  symm
  apply Finset.sum_subset
  · intro n hn
    simp only [Finset.mem_Ico] at hn
    simp only [J, Finset.mem_Ico]
    omega
  · intro n _ hn
    exact hz n hn

theorem sum_shiftEnvelope_shifts (z : ℤ → ℂ) (N H : ℕ)
    (hz : ∀ n, n ∉ Finset.Ico (0 : ℤ) N → z n = 0) :
    (∑ n ∈ shiftEnvelope N H, ∑ h ∈ Finset.range H, z (n + h)) =
      (H : ℂ) * ∑ n ∈ Finset.Ico (0 : ℤ) N, z n := by
  rw [Finset.sum_comm]
  have he : ∀ h ∈ Finset.range H,
      (∑ n ∈ shiftEnvelope N H, z (n + h)) =
        ∑ n ∈ Finset.Ico (0 : ℤ) N, z n := by
    intro h hh
    exact sum_shiftEnvelope_eq z N H h (Finset.mem_range.mp hh).le hz
  rw [Finset.sum_congr rfl he]
  simp

theorem complex_norm_sum_sq_le_card {ι : Type*} (s : Finset ι) (z : ι → ℂ) :
    ‖∑ i ∈ s, z i‖ ^ 2 ≤ (s.card : ℝ) * ∑ i ∈ s, ‖z i‖ ^ 2 := by
  have hn := norm_sum_le s z
  have hs : (∑ i ∈ s, ‖z i‖) ^ 2 ≤ (s.card : ℝ) * ∑ i ∈ s, ‖z i‖ ^ 2 := by
    simpa using Finset.sum_mul_sq_le_sq_mul_sq s (fun _ => (1 : ℝ)) (fun i => ‖z i‖)
  exact (pow_le_pow_left₀ (norm_nonneg _) hn 2).trans hs

theorem complex_norm_sum_sq_eq_pairs {ι : Type*} (s : Finset ι) (z : ι → ℂ) :
    ‖∑ i ∈ s, z i‖ ^ 2 =
      ∑ i ∈ s, ∑ j ∈ s, (z i * conj (z j)).re := by
  have h := congrArg Complex.re (Complex.mul_conj' (∑ i ∈ s, z i))
  simpa only [map_sum, Finset.sum_mul_sum, Complex.re_sum, ← Complex.ofReal_pow,
    Complex.ofReal_re] using h.symm

/-- Finite shift inequality with the complete signed correlation expression.
It applies to arbitrary complex sequences supported in [0,N). -/
theorem finite_shift_energy (z : ℤ → ℂ) (N H : ℕ)
    (hz : ∀ n, n ∉ Finset.Ico (0 : ℤ) N → z n = 0) :
    (H : ℝ) ^ 2 * ‖∑ n ∈ Finset.Ico (0 : ℤ) N, z n‖ ^ 2 ≤
      ((N : ℝ) + H) *
        ∑ h ∈ Finset.range H, ∑ j ∈ Finset.range H,
          ∑ n ∈ shiftEnvelope N H, (z (n + h) * conj (z (n + j))).re := by
  have hc := complex_norm_sum_sq_le_card (shiftEnvelope N H)
    (fun n => ∑ h ∈ Finset.range H, z (n + h))
  rw [sum_shiftEnvelope_shifts z N H hz, norm_mul, Complex.norm_natCast,
    mul_pow, shiftEnvelope_card, Nat.cast_add] at hc
  simp_rw [complex_norm_sum_sq_eq_pairs] at hc
  have he : (∑ n ∈ shiftEnvelope N H, ∑ h ∈ Finset.range H, ∑ j ∈ Finset.range H,
      (z (n + h) * conj (z (n + j))).re) =
      ∑ h ∈ Finset.range H, ∑ j ∈ Finset.range H,
        ∑ n ∈ shiftEnvelope N H, (z (n + h) * conj (z (n + j))).re := by
    rw [Finset.sum_comm]
    apply Finset.sum_congr rfl
    intro h _
    rw [Finset.sum_comm]
  rw [he] at hc
  simpa only [complex_norm_sum_sq_eq_pairs] using hc

/-- Cauchy in an outer variable followed by finite shifts. The outer-variable
sum remains inside each signed correlation; no correlation is replaced by
the sum of its pointwise absolute values. -/
theorem weighted_finite_shift_energy {ι : Type*} (s : Finset ι) (a : ι → ℂ)
    (z : ι → ℤ → ℂ) (N H : ℕ)
    (hz : ∀ p ∈ s, ∀ n, n ∉ Finset.Ico (0 : ℤ) N → z p n = 0) :
    (H : ℝ) ^ 2 * ‖∑ p ∈ s, a p * ∑ n ∈ Finset.Ico (0 : ℤ) N, z p n‖ ^ 2 ≤
      (∑ p ∈ s, ‖a p‖ ^ 2) * ((N : ℝ) + H) *
        ∑ h ∈ Finset.range H, ∑ j ∈ Finset.range H, ∑ p ∈ s,
          ∑ n ∈ shiftEnvelope N H, (z p (n + h) * conj (z p (n + j))).re := by
  let A : ℝ := ∑ p ∈ s, ‖a p‖ ^ 2
  let S : ι → ℂ := fun p => ∑ n ∈ Finset.Ico (0 : ℤ) N, z p n
  have hA : 0 ≤ A := Finset.sum_nonneg (fun p _ => sq_nonneg ‖a p‖)
  have hc : ‖∑ p ∈ s, a p * S p‖ ^ 2 ≤ A * ∑ p ∈ s, ‖S p‖ ^ 2 := by
    have hn : ‖∑ p ∈ s, a p * S p‖ ≤ ∑ p ∈ s, ‖a p‖ * ‖S p‖ := by
      simpa only [norm_mul] using norm_sum_le s (fun p => a p * S p)
    exact (pow_le_pow_left₀ (norm_nonneg _) hn 2).trans
      (Finset.sum_mul_sq_le_sq_mul_sq s (fun p => ‖a p‖) (fun p => ‖S p‖))
  have he := Finset.sum_le_sum (fun p hp => finite_shift_energy (z p) N H (hz p hp))
  rw [← Finset.mul_sum, ← Finset.mul_sum] at he
  have hd := mul_le_mul_of_nonneg_left he hA
  rw [← mul_assoc, mul_comm A ((H : ℝ) ^ 2), mul_assoc] at hd
  have hf := (mul_le_mul_of_nonneg_left hc (sq_nonneg (H : ℝ))).trans hd
  have hswap : (∑ p ∈ s, ∑ h ∈ Finset.range H, ∑ j ∈ Finset.range H,
      ∑ n ∈ shiftEnvelope N H, (z p (n + h) * conj (z p (n + j))).re) =
      ∑ h ∈ Finset.range H, ∑ j ∈ Finset.range H, ∑ p ∈ s,
        ∑ n ∈ shiftEnvelope N H, (z p (n + h) * conj (z p (n + j))).re := by
    rw [Finset.sum_comm]
    apply Finset.sum_congr rfl
    intro h _
    rw [Finset.sum_comm]
  simpa only [A, S, hswap, mul_assoc] using hf

end BuildingBlocks
