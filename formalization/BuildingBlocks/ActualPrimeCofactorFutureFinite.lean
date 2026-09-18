import BuildingBlocks.HyperbolaProduct
import Mathlib.NumberTheory.VonMangoldt
import Mathlib.Tactic

/-!
# Exact finite prime/cofactor transfer

The identities here use mathlib's actual von Mangoldt function. They retain
every prime power and every endpoint, for arbitrary complex test weights.
They are finite algebra, not an analytic estimate of the signed prime row.
-/

namespace BuildingBlocks.ActualPrimeCofactorFutureFinite

open Finset
open scoped BigOperators

noncomputable section

private theorem complex_log_eq_mangoldt_divisors (n : ℕ) :
    (Real.log (n : ℝ) : ℂ) =
      ∑ d ∈ n.divisors, (ArithmeticFunction.vonMangoldt d : ℂ) := by
  exact_mod_cast ArithmeticFunction.vonMangoldt_sum (n := n).symm

/-- The exact finite `Λ * 1 = log` identity against an arbitrary complex
weight. The right side includes every divisor/cofactor pair `d*k ≤ N`. -/
theorem weighted_log_eq_complete_future (N : ℕ) (g : ℕ → ℂ) :
    (∑ n ∈ Icc 1 N, (Real.log (n : ℝ) : ℂ) * g n) =
      ∑ d ∈ Icc 1 N, (ArithmeticFunction.vonMangoldt d : ℂ) *
        ∑ k ∈ Icc 1 (N / d), g (d * k) := by
  calc
    _ = ∑ n ∈ Icc 1 N, ∑ d ∈ n.divisors,
          (ArithmeticFunction.vonMangoldt d : ℂ) * g (d * (n / d)) := by
      apply Finset.sum_congr rfl
      intro n _
      rw [complex_log_eq_mangoldt_divisors, Finset.sum_mul]
      apply Finset.sum_congr rfl
      intro d hd
      rw [Nat.mul_div_cancel' (Nat.mem_divisors.mp hd).1]
    _ = ∑ d ∈ Icc 1 N, ∑ k ∈ Icc 1 (N / d),
          (ArithmeticFunction.vonMangoldt d : ℂ) * g (d * k) := by
      exact BuildingBlocks.HyperbolaProduct.sum_divisors_eq_sum_factor_pairs N
        (fun d k => (ArithmeticFunction.vonMangoldt d : ℂ) * g (d * k))
    _ = _ := by
      apply Finset.sum_congr rfl
      intro d _
      rw [Finset.mul_sum]

private theorem cofactor_sum_one_and_proper
    {N d : ℕ} (hdpos : 0 < d) (hdN : d ≤ N) (g : ℕ → ℂ) :
    (∑ k ∈ Icc 1 (N / d), g (d * k)) =
      g d + ∑ k ∈ Icc 2 (N / d), g (d * k) := by
  have hbound : 1 ≤ N / d := Nat.div_pos hdN hdpos
  have hrest : (Ioc 1 (N / d) : Finset ℕ) = Icc 2 (N / d) := by
    ext k
    simp only [mem_Ioc, mem_Icc]
    omega
  rw [Finset.Icc_eq_cons_Ioc hbound, Finset.sum_cons, hrest]
  simp

/-- Exact finite row on actual prime powers, with no density subtraction. -/
def primeRow (N : ℕ) (g : ℕ → ℂ) : ℂ :=
  ∑ n ∈ Icc 1 N, (ArithmeticFunction.vonMangoldt n : ℂ) * g n

/-- The logarithmic row determined by the complete divisor identity. -/
def logRow (N : ℕ) (g : ℕ → ℂ) : ℂ :=
  ∑ n ∈ Icc 1 N, (Real.log (n : ℝ) : ℂ) * g n

/-- Complete divisor future up to the literal hard cutoff `C`. -/
def lowFullFuture (N C : ℕ) (g : ℕ → ℂ) : ℂ :=
  ∑ d ∈ Icc 1 N,
    if d ≤ C then (ArithmeticFunction.vonMangoldt d : ℂ) *
      ∑ k ∈ Icc 1 (N / d), g (d * k) else 0

/-- The proper (`k ≥ 2`) future above the literal hard cutoff `C`. -/
def highProperFuture (N C : ℕ) (g : ℕ → ℂ) : ℂ :=
  ∑ d ∈ Icc 1 N,
    if C < d then (ArithmeticFunction.vonMangoldt d : ℂ) *
      ∑ k ∈ Icc 2 (N / d), g (d * k) else 0

/-- A finite, complex-weighted version of the sharp cofactor reduction.
The support condition is exactly what removes the `k = 1` contribution
from the low-divisor range. No asymptotic estimate is used. -/
theorem cofactor_cutoff_transfer (N C : ℕ) (g : ℕ → ℂ)
    (hvanish : ∀ d, d ≤ C → g d = 0) :
    primeRow N g = logRow N g - lowFullFuture N C g - highProperFuture N C g := by
  have hlog : logRow N g = primeRow N g +
      lowFullFuture N C g + highProperFuture N C g := by
    rw [logRow, weighted_log_eq_complete_future]
    simp only [primeRow, lowFullFuture, highProperFuture,
      ← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro d hd
    obtain ⟨hdpos, hdN⟩ := Finset.mem_Icc.mp hd
    by_cases hcut : d ≤ C
    · have hg : g d = 0 := hvanish d hcut
      simp [hcut, Nat.not_lt.mpr hcut, hg]
    · have hgt : C < d := Nat.lt_of_not_ge hcut
      rw [cofactor_sum_one_and_proper hdpos hdN]
      simp [hcut, hgt, mul_add]
  apply eq_sub_iff_add_eq.mpr
  apply eq_sub_iff_add_eq.mpr
  linear_combination -hlog

end

end BuildingBlocks.ActualPrimeCofactorFutureFinite
