import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Data.Complex.Basic
import Mathlib.Tactic

namespace BuildingBlocks.FiniteTriangularGeometric
open Finset

noncomputable def triangular (q : ℂ) (n : ℕ) : ℂ :=
  ∑ k ∈ range n, (k + 1 : ℕ) * q ^ (n - 1 - k)

theorem triangular_succ (q : ℂ) (n : ℕ) :
    triangular q (n + 1) = q * triangular q n + (n + 1 : ℕ) := by
  unfold triangular
  rw [sum_range_succ, mul_sum]
  have he : (∑ k ∈ range n, (k + 1 : ℕ) * q ^ (n + 1 - 1 - k)) =
      ∑ k ∈ range n, q * ((k + 1 : ℕ) * q ^ (n - 1 - k)) := by
    apply sum_congr rfl
    intro k hk
    have hn : n + 1 - 1 - k = (n - 1 - k) + 1 := by
      have := mem_range.mp hk
      omega
    rw [hn, pow_succ]
    ring
  rw [he]
  simp

theorem triangular_polynomial (q : ℂ) (n : ℕ) :
    (1 - q)^2 * triangular q n = n - (n + 1 : ℕ) * q + q^(n+1) := by
  induction n with
  | zero => simp [triangular]
  | succ n ih =>
    rw [triangular_succ, pow_succ q (n + 1)]
    push_cast
    push_cast at ih
    linear_combination q * ih

theorem triangular_eq_sum (q : ℂ) (n : ℕ) :
    triangular q n = ∑ k ∈ range n, (n - k : ℕ) * q^k := by
  unfold triangular
  calc
    _ = ∑ k ∈ range n, (n - (n - 1 - k) : ℕ) * q^(n - 1 - k) := by
      apply sum_congr rfl
      intro k hk
      have hn : n - (n - 1 - k) = k + 1 := by
        have := mem_range.mp hk
        omega
      rw [hn]
    _ = _ := sum_range_reflect (fun k => (n - k : ℕ) * q^k) n

theorem positive_triangular_polynomial (q : ℂ) (n : ℕ) :
    (1 - q)^2 * ((∑ k ∈ range n, (n - k : ℕ) * q^k) - n) =
      n * q * (1 - q) - q + q^(n+1) := by
  rw [← triangular_eq_sum]
  have hp := triangular_polynomial q n
  push_cast at hp
  linear_combination hp

theorem positive_triangular_closed_form (q : ℂ) (hq : q ≠ 1) (n : ℕ) :
    (∑ k ∈ range n, (n - k : ℕ) * q^k) - n =
      n * q / (1 - q) - q * (1 - q^n) / (1 - q)^2 := by
  have hn : (1 : ℂ) - q ≠ 0 := sub_ne_zero.mpr hq.symm
  field_simp [hn]
  have hp := positive_triangular_polynomial q n
  rw [pow_succ] at hp
  linear_combination hp

noncomputable def modeResidual (q h : ℂ) (n : ℕ) : ℂ :=
  2 / n * ((∑ k ∈ range n, (n - k : ℕ) * q^k) - n) +
    2 / (n * h^2) * (q^(n+1) + q^(n-1) + 2*(h-1)*q^n - 2*q)

theorem mode_residual_closed_form (q h : ℂ) (hq0 : q ≠ 0) (hq1 : q ≠ 1)
    (hh : h ≠ 0) (n : ℕ) (hn : 0 < n) :
    modeResidual q h n = 2*q/(1-q) - 2*q/n * (1/(1-q)^2 + 2/h^2) +
      2*q^n/(n*h^2) * ((q+q⁻¹-2+h)^2/(q+q⁻¹-2)) := by
  have hn0 : (n : ℂ) ≠ 0 := by exact_mod_cast Nat.ne_of_gt hn
  have hp : q^(n-1) = q^n/q := by
    apply (eq_div_iff hq0).mpr
    rw [← pow_succ]
    congr 1
    omega
  have hd : q+q⁻¹-2 = (q-1)^2/q := by
    field_simp
    ring
  unfold modeResidual
  rw [positive_triangular_closed_form q hq1 n, hp, pow_succ, hd]
  field_simp [hn0, hh, hq0, sub_ne_zero.mpr hq1, sub_ne_zero.mpr hq1.symm]
  ring

#print axioms triangular_succ
#print axioms triangular_polynomial
#print axioms triangular_eq_sum
#print axioms positive_triangular_polynomial
#print axioms positive_triangular_closed_form
#print axioms mode_residual_closed_form
end BuildingBlocks.FiniteTriangularGeometric
