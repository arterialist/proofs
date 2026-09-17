import BuildingBlocks.FactorialHOneFinite
import Mathlib.Tactic

/-!
# Finite factorial-ground comparison under prime-weight reductions

For an arbitrary arithmetic weight, the finite factorial ground is a
linear functional whose coefficient at `n ≤ N` is nonpositive. Reducing
any arrival weight therefore increases the ground. This proves the
finite exact comparison used by the sparse prime-weight test, without
assuming a prime number theorem or omitting prime powers.
-/

namespace BuildingBlocks.FactorialGroundDownweightFinite

open Finset

/-- The factorial-ground expression for arbitrary finite arrival weights. -/
noncomputable def groundAt (weight : ℕ → ℝ) (N : ℕ) : ℝ :=
  Real.log N +
    ∑ n ∈ Icc 1 N, weight n * ((N : ℝ)⁻¹ - (n : ℝ)⁻¹)

/-- The definition is the usual logarithm-minus-weighted-prefix plus
Chebyshev-prefix form, including the endpoint `n = N`. -/
theorem groundAt_eq_prefix (weight : ℕ → ℝ) (N : ℕ) :
    groundAt weight N =
      Real.log N - (∑ n ∈ Icc 1 N, weight n / (n : ℝ)) +
        (∑ n ∈ Icc 1 N, weight n) / (N : ℝ) := by
  simp [groundAt, mul_sub, Finset.sum_sub_distrib, Finset.sum_mul,
    div_eq_mul_inv]
  ring

/-- Exact finite comparison: each downweighted arrival contributes
its deficit times the nonnegative remaining reciprocal-clock gap. -/
theorem groundAt_sub (original reduced : ℕ → ℝ) (N : ℕ) :
    groundAt reduced N - groundAt original N =
      ∑ n ∈ Icc 1 N,
        (original n - reduced n) * ((n : ℝ)⁻¹ - (N : ℝ)⁻¹) := by
  unfold groundAt
  calc
    (Real.log N + ∑ n ∈ Icc 1 N,
        reduced n * ((N : ℝ)⁻¹ - (n : ℝ)⁻¹)) -
        (Real.log N + ∑ n ∈ Icc 1 N,
          original n * ((N : ℝ)⁻¹ - (n : ℝ)⁻¹)) =
      ∑ n ∈ Icc 1 N,
        (reduced n * ((N : ℝ)⁻¹ - (n : ℝ)⁻¹) -
          original n * ((N : ℝ)⁻¹ - (n : ℝ)⁻¹)) := by
            rw [Finset.sum_sub_distrib]
            ring
    _ = ∑ n ∈ Icc 1 N,
        (original n - reduced n) * ((n : ℝ)⁻¹ - (N : ℝ)⁻¹) := by
          apply Finset.sum_congr rfl
          intro n hn
          ring

/-- Any pointwise reduction of nonnegative or signed weights increases
the finite ground; no smallness condition is needed. -/
theorem groundAt_mono_of_downweight (original reduced : ℕ → ℝ) (N : ℕ)
    (hweight : ∀ n ∈ Icc 1 N, reduced n ≤ original n) :
    groundAt original N ≤ groundAt reduced N := by
  rw [← sub_nonneg, groundAt_sub]
  apply Finset.sum_nonneg
  intro n hn
  have hnpos : 0 < (n : ℝ) := by
    have hnn : 0 < n := by
      have hbound := (Finset.mem_Icc.mp hn).1
      omega
    exact_mod_cast hnn
  have hnN : (n : ℝ) ≤ (N : ℝ) := by
    exact_mod_cast (Finset.mem_Icc.mp hn).2
  have hgap : 0 ≤ (n : ℝ)⁻¹ - (N : ℝ)⁻¹ := by
    apply sub_nonneg.mpr
    simpa only [one_div] using one_div_le_one_div_of_le hnpos hnN
  exact mul_nonneg (sub_nonneg.mpr (hweight n hn)) hgap

/-- The abstract finite ground specializes exactly to the actual
von Mangoldt factorial ground already used in the H₁ bridge. -/
theorem groundAt_vonMangoldt (N : ℕ) :
    groundAt ArithmeticFunction.vonMangoldt N =
      FactorialHOneFinite.fFinite N := by
  simp [groundAt_eq_prefix, FactorialHOneFinite.fFinite,
    FactorialHOneFinite.logPrimeFinite,
    FactorialHOneFinite.psiFinite]

end BuildingBlocks.FactorialGroundDownweightFinite
